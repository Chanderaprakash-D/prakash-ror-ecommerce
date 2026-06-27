#!/bin/bash
set -e

mkdir -p /app/log
touch /app/log/production.log

TASK_META=$(curl -sf "${ECS_CONTAINER_METADATA_URI_V4}/task" || true)
if [ -n "$TASK_META" ]; then
  TASK_ID=$(echo "$TASK_META" | grep -o '"TaskARN":"[^"]*"' | cut -d'/' -f3 | tr -d '"')
else
  TASK_ID=$(hostname)
fi

sed -i "s/{instance_id}/$TASK_ID/g" /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

/opt/aws/amazon-cloudwatch-agent/bin/config-translator \
  --input /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
  --output /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.toml \
  --mode ec2 \
  --os linux

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent \
  -config /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.toml \
  -pidfile /var/run/amazon-cloudwatch-agent.pid &

echo "CloudWatch Agent started"

exec bundle exec rails server -b 0.0.0.0 -p 3000