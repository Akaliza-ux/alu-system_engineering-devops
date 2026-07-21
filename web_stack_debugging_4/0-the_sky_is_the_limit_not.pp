# Raises Nginx and PHP-FPM capacity for concurrent web requests.
exec { 'increase-nginx-worker-capacity':
  command => 'sed -ri "s/worker_connections[[:space:]]+[0-9]+;/worker_connections 4096;/" /etc/nginx/nginx.conf',
  path    => ['/usr/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
  notify  => Exec['restart-nginx'],
}

exec { 'increase-php-fpm-capacity':
  command => 'sed -ri "s/^pm.max_children = [0-9]+/pm.max_children = 100/" /etc/php5/fpm/pool.d/www.conf',
  onlyif  => 'test -f /etc/php5/fpm/pool.d/www.conf',
  path    => ['/usr/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
  notify  => Exec['restart-php-fpm'],
}

exec { 'restart-nginx':
  command     => 'service nginx restart',
  path        => ['/usr/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
  refreshonly => true,
}

exec { 'restart-php-fpm':
  command     => 'service php5-fpm restart',
  path        => ['/usr/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
  refreshonly => true,
}
