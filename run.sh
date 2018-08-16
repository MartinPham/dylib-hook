#!/bin/bash

gcc -framework UIKit -framework Foundation -o testDylib.dylib -dynamiclib testDylib.m
