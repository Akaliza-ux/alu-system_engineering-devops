# Increases Nginx worker connections to handle concurrent requests.
exec { 'fix--for-nginx':
  command => 'sed -i "s/worker_connections 768/worker_connections 4096/g" /etc/nginx/nginx.conf && service nginx restart',
  path    => ['/usr/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
}
