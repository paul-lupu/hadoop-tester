class tests_ht::tests(
$components,
$catalog=$tests_ht::api::catalog,
){
	file {'/opt/tests/service_tests.sh':
		content	=> template('tests_ht/tests.erb'),
		ensure	=> present, 
	}
}
