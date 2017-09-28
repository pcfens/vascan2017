include ::apt

apt::source { 'docker':
  ensure       => present,
  architecture => 'amd64',
  location     => 'https://download.docker.com/linux/ubuntu',
  repos        => 'stable',
  key          => {
    id     => '9DC858229FC7DD38854AE2D88D81803C0EBFCD88',
    source => 'https://download.docker.com/linux/ubuntu/gpg',
  },
  include      => {
    src => false,
    deb => true,
  },
}

package { 'docker-ce':
  ensure  => present,
  require => [
    Class['apt::update'],
    Apt::Source['docker'],
  ],
}


service { 'docker':
  ensure  => running,
  enable  => true,
  require => Package['docker-ce'],
}

$swarm_join_token = hiera('swarm_join_token', false)
$swarm_join_node = hiera('swarm_join_node', false)

if $swarm_join_node and $swarm_join_token {
  exec { 'join-docker':
    command => "/usr/bin/docker swarm join --token ${swarm_join_token} ${swarm_join_node}",
    unless  => '/usr/bin/docker info | /bin/grep -c "Swarm: active"',
    require => Service['docker'],
  }
} else {
  exec { 'init-swarm':
    command => '/usr/bin/docker swarm init',
    unless  => '/usr/bin/docker info | /bin/grep -c "Swarm: active"',
    require => Service['docker'],
  }
}
