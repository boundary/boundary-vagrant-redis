# Explictly set to avoid warning message
Package {
  allow_virtual => false,
}

node /^ubuntu/ {
  file { 'bash_profile':
    path    => '/home/vagrant/.bash_profile',
    ensure  => file,
    require => Class['redis::install'],
    source  => '/vagrant/manifests/bash_profile'
  }

  exec { 'update-apt-packages':
    command => '/usr/bin/apt-get update -y',
    creates => '/vagrant/.locks/update-apt-packages',
  }

  class { 'redis::install':
    redis_version => $redis_version,
    require => Exec['update-apt-packages'],
  }

  redis::server {
    'redis':
      redis_name => 'boundary',
      running => true,
      enabled => true,
  }

  redis::server {
    'redis-auth':
      redis_name => 'boundary_auth',
      redis_port => 6380,
      running => true,
      enabled => true,
      requirepass => 'boundary123',
  }


  class { 'boundary':
    token => $boundary_api_token,
  }

}

# Separate the Cento 7.0 install until the boundary meter puppet package is fixed
node /^centos-7-0/ {
  file { 'bash_profile':
    path    => '/home/vagrant/.bash_profile',
    ensure  => file,
    require => Class['redis'],
    source  => '/vagrant/manifests/bash_profile'
  }

  exec { 'update-rpm-packages':
    command => '/usr/bin/yum update -y',
    creates => '/vagrant/.locks/update-rpm-packages',
    timeout => 1800
  }

  package {'epel-release':
    ensure => 'installed',
    require => Exec['update-rpm-packages']
  }

  class { 'redis::install':
    redis_version => $redis_version,
    require => Package['epel-release'],
  }

  redis::server {
    'redis':
      redis_name => 'boundary',
      running => true,
      enabled => true,
  }

  redis::server {
    'redis-auth':
      redis_name => 'boundary_auth',
      redis_port => 6380,
      running => true,
      enabled => true,
      requirepass => 'boundary123',
  }

}

node /^centos/ {

  file { 'bash_profile':
    path    => '/home/vagrant/.bash_profile',
    ensure  => file,
    require => Class['redis::install'],
    source  => '/vagrant/manifests/bash_profile'
  }

  exec { 'update-rpm-packages':
    command => '/usr/bin/yum update -y',
    creates => '/vagrant/.locks/update-rpm-packages',
    timeout => 1800
  }

  package {'epel-release':
    ensure => 'installed',
    require => Exec['update-rpm-packages']
  }

  class { 'redis::install':
    redis_version => $redis_version,
    require => Package['epel-release'],
  }

  redis::server {
    'redis':
      redis_name => 'boundary',
      running => true,
      enabled => true,
  }

  redis::server {
    'redis-auth':
      redis_name => 'boundary_auth',
      redis_port => 6380,
      running => true,
      enabled => true,
      requirepass => 'boundary123',
  }

  class { 'boundary':
    token => $boundary_api_token
  }

}
