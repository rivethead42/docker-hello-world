FROM node:boron

EXPOSE 3000

RUN  apt-get -yq update
RUN apt-get install -qqy wget git ssh vim

RUN wget https://apt.puppetlabs.com/puppetlabs-release-pc1-precise.deb
RUN dpkg -i puppetlabs-release-pc1-precise.deb
RUN apt-get -qqy update

RUN apt-get install -qqy puppet

RUN mkdir -p /etc/puppet/hieradata

RUN gem install r10k

# Configure manifests and modules
COPY puppet/site.pp /etc/puppet/manifests/

# Add Puppetfile
COPY puppet/Puppetfile /etc/puppet/

# Configure hiera
COPY puppet/hiera/hiera.yaml /etc/puppet/

COPY puppet/hiera/common.json /etc/puppet/hieradata/

# Run r10k
RUN PUPPETFILE=/etc/puppet/Puppetfile PUPPETFILE_DIR=/etc/puppet/modules/ r10k puppetfile install --verbose debug2 --color

# Run Puppet apply
RUN puppet apply --modulepath=/etc/puppet/modules/ --hiera_config /etc/puppet/hiera.yaml

WORKDIR /var/node/helloworld

RUN npm install
RUN chown -R nodejs:nodejs /var/node/helloworld

ENV NODE_ENV production

CMD ["/var/node/helloworld/bin/www"]
