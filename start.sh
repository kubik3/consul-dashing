#!/bin/bash

#Updating values

find ${CONSUL_TEMPLATE_HOME} -type f -exec sed -i 's|__CONSUL_TEMPLATE_HOME__|'$CONSUL_TEMPLATE_HOME'|g' {} +

find /dashing -type f -exec sed -i "s/YOUR_AUTH_TOKEN/${DASHING_AUTH_TOKEN}/g" {} +

find ${CONSUL_TEMPLATE_HOME} -type f -exec sed -i "s/__CONSUL_URL__/${CONSUL_SERVER_URL}/g" {} +

#Installing required gem
echo -e "\ngem 'httparty', '0.13.3'" >> /dashing/Gemfile

bundle install

#Running Dashing
echo "Starting Dashing"

/run.sh &

sleep 60

echo "Starting Consul-Template"

#Running Consul Template
consul-template -config "${CONSUL_TEMPLATE_HOME}/consul-template.d/config" -retry 10s && fg