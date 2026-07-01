#!/bin/bash

mkdir -p /app/log
touch /app/log/production.log /app/log/puma.log /app/log/error.log

echo "Starting CloudWatch Agent..."

if [ -f /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json ]; then
  /opt/aws/amazon-cloudwatch-agent/bin/config-translator \
    --input /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
    --output /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.toml \
    --mode ec2 \
    --os linux || echo "CloudWatch config translation failed"

  /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent \
    -config /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.toml \
    -pidfile /tmp/amazon-cloudwatch-agent.pid \
    > /tmp/cloudwatch-agent.log 2>&1 &

  echo "CloudWatch Agent started in background"
else
  echo "CloudWatch Agent config not found"
fi

echo "Starting Rails/Puma server..."

exec bundle exec rails server -b 0.0.0.0 -p 3000 \
  > >(tee -a /app/log/puma.log) \
  2> >(tee -a /app/log/error.log >&2)