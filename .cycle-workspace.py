#!/usr/bin/env python

# Source:
# https://gist.github.com/97-109-107/b70356670ae8309ffb4f
#
# Requires i3 (pip i3-py)

import i3

outputs = i3.get_outputs()
workspaces = i3.get_workspaces()

# figure out what is on, and what is currently on your screen.
workspace = list(filter(lambda s: s['focused']==True, workspaces))
output = list(filter(lambda s: s['active']==True, outputs))

# figure out the other workspace name
other_workspace = list(filter(lambda s: s['name']!=workspace[0]['output'], output))

# send current to the no-active one
i3.command('move', 'workspace to output '+other_workspace[0]['name'])
