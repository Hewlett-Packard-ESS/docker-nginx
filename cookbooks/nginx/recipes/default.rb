dirs=%w(/storage/nginx /storage/nginx/conf.d /storage/nginx/html /var/log/nginx /var/run/nginx /storage/nginx)

dirs.each do |dir|
  directory "#{dir}" do
    owner 'hpess'
    group 'hpess'
    action :create
    recursive true
  end
end

template '/storage/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  variables ({ :confvars => {} })
  owner 'hpess'
  group 'hpess'
  action :create_if_missing
end

if ENV['nginx_simple_http'] === 'true' 
  template '/storage/nginx/conf.d/simple.conf' do
    source 'site.conf.erb'
    variables ({ :confvars => {} })
    owner 'hpess'
    group 'hpess'
    action :create_if_missing
  end
end
