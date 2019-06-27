#!/bin/bash 
cd /root/PyOne
/usr/local/bin/gunicorn -w4 -b 0.0.0.0:34567 run:app
