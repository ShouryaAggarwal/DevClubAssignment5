#!/bin/bash
find $1 -maxdepth 1 -type f -name "*$2" | wc -l