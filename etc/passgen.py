#!/usr/bin/python

import random
import string
import sys

digits = string.digits
lower = string.ascii_lowercase
upper = string.ascii_uppercase
punctuation = string.punctuation
alphabet = digits + lower + upper + punctuation

defaultPassLen = 8
minimumPassLen = 8 # should not be less than 4
passLen = int(sys.argv[1]) if len(sys.argv) > 1 else defaultPassLen
passLen = max(passLen, minimumPassLen)

def genRandomString(length):
    return ''.join([random.choice(alphabet) for _ in range(length)])

def isValidPassword(string):
    def predicatedAny(string, predicate):
        return any(predicate(c) for c in string)

    isdigit = getattr(str, 'isdigit')
    islower = getattr(str, 'islower')
    isupper = getattr(str, 'isupper')
    ispunctuation = lambda(x): x in punctuation

    return predicatedAny(password, isdigit) and \
            predicatedAny(password, islower) and \
            predicatedAny(password, isupper) and \
            predicatedAny(password, ispunctuation)

password = ''

while not isValidPassword(password):
    password = genRandomString(passLen)

print(password)



