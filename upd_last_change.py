#!/usr/bin/env python3
# -*- coding: utf-8 -*-

u"最終変更履歴を更新する。"

import sys, re
from os import path
from datetime import datetime

def main():
    args = sys.argv
    parent, _ = path.splitext(args[0])
    plugin_name = path.basename(path.dirname(path.abspath(parent)))

    target = "plugin/" + plugin_name
    with open(target) as infile:
        text = infile.read()

    lines = []
    p = re.compile(r'^"\s*Last Change:.*$', re.IGNORECASE)
    for line in text.split("\n"):
        m = p.match(line)
        if m != None:
            now = datetime.now().strftime("%Y/%m/%d")
            line = '" Last Change: ' + now
            lines.append(line)
        else:
            lines.append(line)

    text = "\n".join(lines)
    with open(target, "w") as outfile:
        outfile.write(text)

if __name__ == '__main__':
    main()
