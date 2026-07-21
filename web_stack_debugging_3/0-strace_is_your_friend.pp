# Fixes the WordPress typo that causes the Apache 500 error.
exec { 'fix-wordpress':
  command => '/bin/sed -i s/phpp/php/g /var/www/html/wp-settings.php',
  path    => ['/usr/local/bin', '/usr/bin', '/bin'],
}
