# Raises Nginx connection and file-descriptor limits for heavy traffic.
exec { 'fix--for-nginx':
  command => 'sed -i "s/worker_connections 768;/worker_connections 4096;/" /etc/nginx/nginx.conf && sed -i "/worker_processes/a worker_rlimit_nofile 4096;" /etc/nginx/nginx.conf && service nginx restart',
  unless  => 'grep -q "worker_connections 4096;" /etc/nginx/nginx.conf && grep -q "worker_rlimit_nofile 4096;" /etc/nginx/nginx.conf',
  path    => ['/usr/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
}
