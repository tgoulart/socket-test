#!/bin/bash

clang -o objcclient objcclient.m TPTCPSocket.m -fobjc-arc -framework Foundation
clang -o objcserver objcserver.m TPTCPSocket.m -fobjc-arc -framework Foundation
