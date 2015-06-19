FROM frvi/dashing

ENV CONSUL_TEMPLATE_HOME /etc/consul-template
ENV PATH $PATH:$CONSUL_TEMPLATE_HOME/bin
ENV DASHING_AUTH_TOKEN MY_AUTH_TOKEN
ENV CONSUL_SERVER_URL consul:8500
ENV URL_PATTERN http://SERVICE_NAME.HOST_IP.xip.io/SERVICE_NAME/
ENV CONSUL_SERVICE_TAG web

RUN apt-get update && \
    apt-get install -y curl && \
    mkdir $CONSUL_TEMPLATE_HOME && \
	curl -L https://github.com/hashicorp/consul-template/releases/download/v0.9.0/consul-template_0.9.0_linux_amd64.tar.gz | \
	tar xvz -C $CONSUL_TEMPLATE_HOME && \
	cd $CONSUL_TEMPLATE_HOME && \
	mv consul-template_0.9.0_linux_amd64 bin && \
	mkdir $CONSUL_TEMPLATE_HOME/consul-template.d/ && \
	ln -s $CONSUL_TEMPLATE_HOME/consul-template.d/ /ctmpl_dir && \
	ln -s /dashing/assets/api_jobs /api_jobs && \
	ln -s /dashing/assets/images /images

COPY consul $CONSUL_TEMPLATE_HOME/consul-template.d
COPY dashing /dashing
COPY start.sh /start.sh

VOLUME ["/images", "/ctmpl_dir", "/api_jobs"]

CMD /start.sh

