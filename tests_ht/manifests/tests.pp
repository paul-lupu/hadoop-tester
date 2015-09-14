class tests_ht::tests(
$components,
){
	file {'/opt/tests/tests.sh':
		content	=> template('tests_ht/tests.erb'),
		ensure	=> present, 
	}
}
