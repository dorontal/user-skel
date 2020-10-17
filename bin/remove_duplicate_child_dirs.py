#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
remove_duplicate_child_folders.py
"""

import os
import subprocess

ROOT_DIR = "/data/dtal/old_dtal"

if __name__ == "__main__":
    for root, dirs, files in os.walk (ROOT_DIR, topdown=False):
        # for file_name in files:
        #     print(os.path.join(root, file_name))
        parent = os.path.split(root)[1]
        for dir in dirs:
            if (dir == parent):
                to_dir = root + "/"
                print(to_dir)
                from_dir = to_dir + dir + "/"

                # rsync from duplicate child (from_dir) to parent (to_dir)
                # subprocess.call(["rsync", "-av", from_dir, to_dir])

                # remove the duplicate child
                # subprocess.call(["/bin/rm", "-fr", from_dir])
