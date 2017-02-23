#!/usr/bin/python2
from __future__ import print_function
from subprocess import *
import tempfile
import sys
import re

positiveAnswers = ['y', 'yes']
negativeAnswers = ['n', 'no']
allowedAnswers  = positiveAnswers + negativeAnswers

def request_user_input(prompt, crtnPrompt, alwdAnswers=['y','yes','n','no'], caseSntv=False):
    while True:
        print(prompt + ' ', end='')
        answer = sys.stdin.readline()
        answer = answer.strip()
	if not caseSntv:
            answer = answer.lower()

        if answer in alwdAnswers:
            break
        else:
            print(crtnPrompt)

    return answer


def grep_call_output(output, pattern):
    lines = str(output).splitlines()
    matches = []
    for line in lines:
        match = re.search(pattern, line)
        if match != None:
            matches.append(match.group(0))

    return matches


def get_available_interfaces():
    iwconfig_output = check_output('iwconfig', stderr=STDOUT)
    return grep_call_output(iwconfig_output, r'^\w+(?=\s+\w(?!o wireless))')


def get_available_access_points(iface):
    iwlist_output = check_output(['iwlist', iface, 'scan'])
    return grep_call_output(iwlist_output, r'(?<=ESSID:")\w+')
        

def write_config_file(file, iface, ap, psk):
    file.write('iface {} inet dhcp\n'.format(iface))
    file.write('\twpa-ssid {}\n'.format(ap))
    file.write('\twpa-psk {}\n'.format(psk))
    file.flush()

isConfigRequired = request_user_input(
    'Configure wireless network (y/n)?',
    'Please answer \'yes\' or \'no\'.',
    allowedAnswers)


if isConfigRequired in positiveAnswers:
    availableInterfaces = get_available_interfaces()
    print('Available wireless interfaces:')
    for iface in availableInterfaces:
        print('  ' + iface)
    
    iface = request_user_input(
        'Please type one of the interfaces listed above to configure:',
	'There is no such interface.',
        availableInterfaces,
        caseSntv=True)

    call(['ifconfig', iface, 'up'])
    
    availableAccessPoints = get_available_access_points(iface)
    print('Available access points:')
    for ap in availableAccessPoints:
        print('  ' + ap)

    ap = request_user_input(
        'Please type one of the access points listed above to connect:',
        'There is no such access point.',
        availableAccessPoints,
        caseSntv=True)

    print('Please input wpa-psk for selected access point:', end=' ')
    psk = sys.stdin.readline()

    print('Trying to connect to {} via {} wireless interface...'.format(ap, iface))

    with tempfile.NamedTemporaryFile('w+') as ifaceConfigFile:
        write_config_file(ifaceConfigFile, iface, ap, psk)
        ifaceConfigFileName = ifaceConfigFile.name
        call(['ifup', iface, '-i', ifaceConfigFileName])
