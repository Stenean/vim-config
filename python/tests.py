# -*- coding: utf-8 -*-
import unittest

from mock import Mock, patch

import import_search
from import_search import (
    _filtered_py_walk,
    _search_file,
    find_import,
    find_import_path,
    find_missing_import,
)


class TestFindImport(unittest.TestCase):
    @patch.object(import_search, '_search_file', Mock(return_value=[]))
    def test_find_in_path_with_init(self):
        expected = 'unittest'
        results = find_import('unittest')

        self.assertIn(expected, results)


if __name__ == '__main__':
    unittest.main()
