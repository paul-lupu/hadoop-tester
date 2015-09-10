class tests_ht::api(
$catalog,
$apis,
){
	file {'/opt/tests/api_spec.js':
		content	=> template('tests_ht/api_test.erb'),
		ensure	=> present, 
	}
	exec {'node-jasmine':
		provider		=> 'shell', 
		command			=> 'jasmine-node --forceexit --verbose /opt/tests/api_spec.js',
		require			=> File['/opt/tests/api_spec.js'],
	}
}
