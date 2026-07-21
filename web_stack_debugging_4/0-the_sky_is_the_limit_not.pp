# Raises Nginx capacity and removes restrictive request limits.
exec { 'increase-nginx-worker-capacity':
  command => 'sed -ri "s/worker_connections[[:space:]]+[0-9]+;/worker_connections 4096;/" /etc/nginx/nginx.conf',
  path    => ['/usr/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
  notify  => Exec['restart-nginx'],
}

exec { 'remove-nginx-request-limits':
  command => 'sed -i "/^[[:space:]]*limit_req[[:space:]]/d; /^[[:space:]]*limit_conn[[:space:]]/d" /etc/nginx/sites-enabled/default',
  path    => ['/usr/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
  notify  => Exec['restart-nginx'],
}

exec { 'restart-nginx':
  command     => 'service nginx restart',
  path        => ['/usr/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
  refreshonly => true,
}
