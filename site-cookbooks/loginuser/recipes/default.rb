#
# Cookbook Name:: loginuser
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# loginusers/recipes/default.rb
data_ids=data_bag('users')

data_ids.each do |id|
 u = data_bag_item('users', id)
 user u['username'] do
  home u['home']
  shell u['shell']
  uid u['uid']
  gid u['group']
  password u['passwd']
  supports :manage_home => true, :non_unique => false
  action   [:create]
 end

 directory "/home/#{id}/.ssh" do
  owner u['username']
  mode 0700
  action :create
 end
 
 file "/home/#{id}/.ssh/authorized_keys" do
  owner u['username']
  mode 0600
  content u['key']
  action :create
 end
end
