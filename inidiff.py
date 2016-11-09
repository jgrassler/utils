#!/usr/bin/python

# Normalizes two ini files into a Python dictionary and performs a
# section-by-section, option-by-option diff. Requires oslo.config.
#
# usage:
#   inidiff.py <file1> <file2>
#
# Author: Johannes Grassler <johannes@btw23.de>
# License: GNU GPL Version 3.0

from oslo_config import cfg

import sys

f1 = sys.argv[1]
f2 = sys.argv[2]

s1 = {}
s2 = {}

p1 = cfg.ConfigParser(f1, s1)
p2 = cfg.ConfigParser(f2, s2)

p1.parse()
p2.parse()

for section in s1.keys():
  try:
    sp2 = s2[section]
    print('[%s]' % section)
    for key in s1[section].keys():
      try:
        vp1 = s1[section][key]
        vp2 = s2[section][key]
        if (vp1 !=  vp2 ):
          print('-%s = %s' % (key, vp1))
          print('+%s = %s' % (key, vp2))
      except KeyError:
        print('-%s = %s' % (key, vp1))
  except KeyError:
    print('-[%s]' % section)
  print('')
