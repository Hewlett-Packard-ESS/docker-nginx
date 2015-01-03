directory '/storage/nginx' do
  owner 'nginx'
  group 'nginx'
  action :create
  recursive true
end

# This is a fudge as chef doesn't seem to set permissions all
# the way up a recursive tree!
directory "/storage/nginx/conf.d" do
  owner 'nginx'
  group 'nginx'
  action :create
  recursive true
end

directory "/storage/nginx/html" do
  owner 'nginx'
  group 'nginx'
  action :create
  recursive true
end

template '/storage/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  variables ({ :confvars => {} })
  owner 'nginx'
  group 'nginx'
  action :create_if_missing
end

template '/storage/nginx/conf.d/simple.conf' do
  source 'site.conf.erb'
  variables ({ :confvars => {} })
  owner 'nginx'
  group 'nginx'
  action :create_if_missing
end
