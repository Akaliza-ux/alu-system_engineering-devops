# Raises the Nginx connection limit to handle concurrent requests.
exec { 'increase-nginx-connections':
  command => 'sed -ri "s/worker_connections[[:space:]]+[0-9]+;/worker_connections 4096;/" /etc/nginx/nginx.conf',
  path    => ['/usr/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
  notify  => Exec['restart-nginx'],
}

exec { 'restart-nginx':
  command     => 'service nginx restart',
  path        => ['/usr/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
  refreshonly => true,
}
