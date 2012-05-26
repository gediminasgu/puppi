#!/bin/bash

DIR=`dirname $0`
java -jar $DIR/check_jmx.jar "$@"
