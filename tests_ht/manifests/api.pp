class tests_ht::api(
$catalog,
$apis,
){
	file {'/opt/tests/api/api_spec.js':
		content	=> template('tests_ht/api_test.erb'),
		ensure	=> present, 
	}
}
