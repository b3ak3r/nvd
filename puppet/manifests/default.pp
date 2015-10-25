class { 'postgresql::server':
  listen_addresses  => 'localhost'
}

postgresql::server::db { 'b3ak3r-nvd':
  user      => 'b3ak3r',
  password  => postgresql_password('b3ak3r', ';;b3ak3r;;'), # Should use encrypted hiera
}
