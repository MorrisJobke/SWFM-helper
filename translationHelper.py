#!/usr/bin/env python
# -*- coding: utf-8 -*-

import subprocess
import sys
from pprint import pprint
import re

# directory to look for swfm
swfmDirectory = 'swfm/swfm/'
language = 'de'
dictionary = {}

a = subprocess.Popen(
	['grep', 'SWFM.I18N.get(', swfmDirectory, '-Rin'],
	stdout=subprocess.PIPE
)
lines = a.stdout.readlines()
for line in lines:
	path = re.compile('(.*:\d*):')
	translationPattern = ".*SWFM\.I18N\.get\((\'|\")(.*)(\'|\")\,\s*(\'|\")(.*)(\'|\")\)"
	translation = re.compile(translationPattern)
	p = path.match(line)
	if p:
		p = p.groups()
	else:
		print 'path error'
		continue
	t = translation.match(line)
	if t:
		t = t.groups()
	else:
		print re.sub(r'\s', '', line)
		continue
	if t[1] not in dictionary:
		dictionary[t[1]] = {}
		dictionary[t[1]][t[4]] = {'call': [p[0]], 'def' : ''}
	elif t[4] not in dictionary[t[1]]:
		dictionary[t[1]][t[4]] = {'call': [p[0]], 'def' : ''}
	else:
		dictionary[t[1]][t[4]]['call'].append(p[0])
		
a = subprocess.Popen(
	'find ' + swfmDirectory + ' -wholename "*/'+language+'.js"',
	shell=True,
	stdout=subprocess.PIPE
)

files = a.stdout.readlines()
curContext = ''
for file in files:
	f = open(file[:-1], 'r')
	for line in f:
		head = re.compile("(SmartWFM|SWFM)\.I18N\.add\(\'"+language[:2]+"\'\,\s*\'(.*)\'")
		translation = re.compile('\s*\'(.*)\'\s*:\s*\'(.*)\'')
		end = re.compile('\s*}\);');
		h = head.match(line)
		if h:
			curContext = h.groups()[1]
		elif curContext == '':
			print 'ERROR - missing header', file[:-1]
			print line[:-1]
			continue
		t = translation.match(line)
		if curContext == '':
			print 'ERROR - missing context'
			continue
		elif t:
			t = t.groups()
			if curContext not in dictionary:
				dictionary[curContext] = {}
				dictionary[curContext][t[0]] = {'call': [], 'def' : t[1]}
			elif t[0] not in dictionary[curContext]:
				dictionary[curContext][t[0]] = {'call': [], 'def' : t[1]}
			else:
				dictionary[curContext][t[0]]['def'] = t[1]	
		e = end.match(line)
		if e:
			curContext = ''
			continue
	f.close()
delete = []
#pprint(dictionary)
for i in dictionary:
	for j in dictionary[i]:
		if dictionary[i][j]['def'] != '':
			delete.append([i,j])
		
for i in delete:
	del dictionary[i[0]][i[1]]
count = 0
for i in dictionary:
	if len(dictionary[i]):
		print i
		for j in dictionary[i]:
			print '\t', j
			for k in dictionary[i][j]['call']:
				print '\t\t', k
			count += 1

print 'Anzahl:', count
#			print
#			pprint(dictionary[i][j]['call'])
#			print
#pprint(dictionary)
