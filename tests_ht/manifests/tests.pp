class tests_ht::tests(
$components,
$catalog=$tests_ht::api::catalog,
){
	file {'/opt/tests/service_tests.sh':
		content	=> template('tests_ht/tests.erb'),
		ensure	=> present, 
	}

	exec{'mod777':
		provider	=> 'shell',
		command		=> 'chmod -R 777 /opt/tests/*',
		require		=> File['/opt/tests/service_tests.sh'],
	}
	  exec{'cleanup':
    provider      => "shell",
    command       => "/usr/bin/sandbox-reset", 
    require       => [File['/opt/tests/service_tests.sh']],
  }

}
