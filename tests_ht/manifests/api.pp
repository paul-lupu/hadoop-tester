class tests_ht::api(
$catalog,
$apis,
){
	file {'/vagrant/tests/api_spec.js':
		content	=> template('tests_ht/api_test.erb'),
		ensure	=> present, 
	}
	exec {'node-jasmine':
		provider		=> 'shell', 
		command			=> 'cd /vagrant/tests/ && jasmine-node  --junitreport --forceexit --verbose api_spec.js',
		returns			=> [1,0],
		require			=> File['/vagrant/tests/api_spec.js'],
	}
}
