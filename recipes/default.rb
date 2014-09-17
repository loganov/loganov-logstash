#
# Cookbook Name:: loganov-logstash
# Recipe:: default
#
# Copyright 2014, Loganov Industries
#
# All rights reserved - Do Not Redistribute
#

include_recipe "loganov-java"

cookbook_file 'GPG-KEY-elasticsearch' do
    path   '/etc/pki/rpm-gpg/GPG-KEY-elasticsearch'
    owner  'root'
    group  'root'
    mode   '0644'
    action :create
end

yum_repository 'logstash-1.4' do
    description 'logstash repository for 1.4.x packages'
    baseurl 'http://packages.elasticsearch.org/logstash/1.4/centos'
    gpgcheck true
    gpgkey 'file:///etc/pki/rpm-gpg/GPG-KEY-elasticsearch'
    sslverify false
    enabled true
    action :create
end

package 'logstash' do
  version node['logstash']['version']
  action :install
end

cookbook_file '01-collectd-input.conf' do
    path '/etc/logstash/conf.d/01-collectd-input.conf'
    owner  'root'
    group  'root'
    mode   '0644'
    action :create
end

template '/etc/logstash/conf.d/30-collectd-output.conf' do
  source '30-collectd-output.conf.erb'
  owner  'root'
  group  'root'
  mode   '0644'
end

service 'logstash' do
  service_name 'logstash'
  supports :restart => true, :reload => true
  action [:enable, :start]
end