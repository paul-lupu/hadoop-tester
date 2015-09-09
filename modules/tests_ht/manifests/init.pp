class tests_ht(
$catalog,
$apis,
){
	file {'/root/api_tests':
		content	=> template('tests_ht/api_tests.erb'),
		ensure	=> present, 
	}
}
