#!/usr/bin/env python
from __future__ import print_function

# from multiprocessing import dummy as multithreading
import multiprocessing as multithreading
import os
import Queue
import ScrolledText
import select
import socket
import sys
import ttk

import Tkinter


class MainGui(Tkinter.Tk):
    INITIAL_WIDTH = 640
    INITIAL_HEIGHT = 480
    INITIAL_ADDR = '127.0.0.1'
    INITIAL_PORT = 35942
    MAX_SCROLLBACK_CHARS = 10240

    def __init__(self):
        Tkinter.Tk.__init__(self)
        self.window_init()

        self.f1 = ttk.Frame(self)
        self.f1.pack(fill=Tkinter.BOTH, expand=True)

        self.mainmenu = Tkinter.Menu(self)
        self.config(menu=self.mainmenu)

        self.text = ScrolledText.ScrolledText(self.f1, state='disabled')
        # self.text.bind('<1>', lambda e: self.text.focus_set())
        self.text.configure(font='TkFixedFont', borderwidth=0)
        self.text.pack(fill=Tkinter.BOTH, expand=True)

        self.s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.s.setblocking(0)

        self.m = multithreading.Manager()
        self.run = self.m.Event()
        self.run.set()

        self.queue = self.m.Queue()

        self.fetcher = multithreading.Process(
            target=self.socketer_multiprocess
        )

        self.addr = self.INITIAL_ADDR
        self.port = self.INITIAL_PORT
        self.max_lines = self.MAX_SCROLLBACK_CHARS

    def window_init(self):
        self.option_add('*tearOff', 'FALSE')
        self.title('UDP log viewer')
        self.configure(width=self.INITIAL_WIDTH, height=self.INITIAL_HEIGHT)
        self.protocol("WM_DELETE_WINDOW", self.stop)
        self.createcommand('exit', self.stop)
        self.lift()
        self.attributes("-topmost", 1)
        self.attributes("-topmost", 0)

    def insert_text(self, text):
        self.text.configure(state=Tkinter.NORMAL)
        self.text.insert(Tkinter.END, text)
        self.text.configure(state=Tkinter.DISABLED)
        if self.text.vbar.get()[1] == 1:
            self.text.yview(Tkinter.END)
        self.text.update()

    def delete_text(self, lines):
        self.text.configure(state=Tkinter.NORMAL)
        self.text.delete(1.0, float(lines))
        self.text.configure(state=Tkinter.DISABLED)
        if self.text.vbar.get()[1] == 1:
            self.text.yview(Tkinter.END)
        self.text.update()

    def populate_log(self):
        try:
            msg = self.queue.get(False)
            self.insert_text(msg)
            lines = float(self.text.index(Tkinter.END))
            if lines > self.max_lines:
                self.delete_text(float(lines - self.max_lines))
            self.queue.task_done()
        except Queue.Empty:
            pass
        self.populate_log.__func__.after_id = self.after(100, self.populate_log)
    populate_log.after_id = None

    def start(self):
        self.s.bind((self.addr, self.port))
        self.fetcher.start()
        self.populate_log()
        if sys.platform == 'darwin':
            launcher = "/usr/bin/osascript -e '%s'"
            os.system(
                launcher % 'tell app "Finder" to set frontmost of process "Python" to true'
            )
        self.mainloop()

    def stop(self):
        self.run.clear()
        self.fetcher.join()
        if self.populate_log.after_id:
            self.after_cancel(self.populate_log.after_id)
        self.destroy()
        sys.exit()

    def socketer_multiprocess(self):
        while self.run.is_set():
            result = select.select([self.s], [], [])
            msg = result[0][0].recv(1024 * 9)
            self.queue.put(msg)


if __name__ == '__main__':
    gui = MainGui()
    gui.start()
