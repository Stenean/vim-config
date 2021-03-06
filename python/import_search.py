#!/usr/bin/env python
import re
import sys
import os


# add use case, where import name is defined in filename not, in .py file itself - top level modules
def find_import(name):
    matches = []

    for x in find_missing_import(name):
        import_path = find_import_path(x[0], x[1])
        if import_path not in matches:
            matches.append(import_path)

    return matches


def find_import_path(base_path, file_path):
    if 'site-packages' not in base_path and 'site-packages' in file_path:
        file_path = file_path.replace('site-packages/', '')

    if 'dist-packages' not in base_path and 'dist-packages' in file_path:
        file_path = file_path.replace('dist-packages/', '')

    for i in xrange(len(base_path)):
        if base_path[i] != file_path[i]:
            break

    return file_path[i+1:].replace('.py', '').replace('/', '.')[1:]


def find_missing_import(name, regexp=None):
    compiled = re.compile(r'(?P<def>def\s|class\s)?\s*' + name + r'\s*(?(def)\(|=(?!=))')
    found_defs = []
    found = []

    for base_path in sys.path:
        for filepath, filename in _filtered_py_walk(base_path):
            fullpath = os.path.join(filepath, filename)

            add_found = _additional_checks(filepath, filename, name)
            if add_found:
                found.append((base_path, add_found[0], add_found[1]))

            for line in _search_file(fullpath, compiled):
                found.append((base_path, fullpath, line))

    for item in found:
        if 'def ' in item[2] or 'class ' in item[2]:
            found_defs.append(item)

    if found_defs:
        return found_defs
    else:
        return found


def _additional_checks(filepath, filename, name):
    newpath, newname = os.path.split(filepath)

    if name == filename[:-3]:
        return filepath, 'class %s(' % name

    if '__init__' == filename[:-3] and name == newname:
        return '%s.py' % filepath, 'class %s(' % name


def _search_file(filepath, compiled):
    with open(filepath) as f:
        for line in f.readlines():
            if compiled.match(line):
                yield line


def _filtered_py_walk(base_path, excludes=None):
    if excludes is None:
        excludes = ['.git']

    for path, dirnames, filenames in os.walk(base_path):
        if any([x in path for x in excludes]):
            continue

        for filename in filenames:
            if filename[-3:] != '.py':
                continue

            yield path, filename
