#!/bin/bash

VN_PATH="${HOME}/Vorgangsreminder"

cd ${VN_PATH}
/usr/bin/python ./vn_reminder.py 2&> /tmp/vn_server.log &
sleep 2
firefox localhost:8081
