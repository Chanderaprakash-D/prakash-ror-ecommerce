#!/bin/bash
set -e

mkdir -p /app/log
touch /app/log/production.log
touch /app/log/puma.log
touch /app/log/error.log

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
  -s

echo "CloudWatch Agent started"

bundle exec rails server -b 0.0.0.0 -p 3000 \
  > >(tee -a /app/log/puma.log) \
  2> >(tee -a /app/log/error.log >&2)