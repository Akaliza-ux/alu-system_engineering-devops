# Raise Nginx and PHP-FPM capacity for concurrent requests.

exec { 'increase-worker-connections':
  command => 'sed -ri "s/worker_connections\\s+[0-9]+;/worker_connections 4096;/" /etc/nginx/nginx.conf',
  unless  => 'grep -q "worker_connections 4096;" /etc/nginx/nginx.conf',
  path    => ['/bin','/usr/bin','/usr/sbin'],
  notify  => Exec['restart-nginx'],
}

exec { 'increase-pm-max-children':
  command => 'sed -ri "s/^pm.max_children\\s*=.*/pm.max_children = 100/" /etc/php5/fpm/pool.d/www.conf',
  onlyif  => 'test -f /etc/php5/fpm/pool.d/www.conf',
  unless  => 'grep -q "^pm.max_children = 100$" /etc/php5/fpm/pool.d/www.conf',
  path    => ['/bin','/usr/bin','/usr/sbin'],
  notify  => Exec['restart-php-fpm'],
}

exec { 'restart-nginx':
  command     => 'service nginx restart',
  refreshonly => true,
  path        => ['/bin','/usr/bin','/usr/sbin'],
}

exec { 'restart-php-fpm':
  command     => 'service php5-fpm restart',
  refreshonly => true,
  path        => ['/bin','/usr/bin','/usr/sbin'],
}
