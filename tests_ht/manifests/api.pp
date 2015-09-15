class tests_ht::api(
$catalog,
$apis,
){
	file {'/opt/tests/api/api_spec.js':
		content	=> template('tests_ht/api_test.erb'),
		ensure	=> present, 
	}
	user{'unit':
		name		=> 'unit',
		ensure	=> 'present', 
		shell 	=> '/bin/bash',
		password	=> '$6$Qj/Fx6lA$S0N.PnGLBQqAQnkSN8elDFOt0Ncqh4gcFHUgNNEmOiviN8dbWBQRVDVJWHwvLvBqZXaOm5.dmzhIB9frKZ5Up1',
		comment		=> 'Unit user for doing unit tests',
	}
	exec{'expire_unit':
		provider		=> 'shell',
		command			=> ' chage -E `date -d "1 day" +"%Y-%m-%d"` unit',
		require			=> User['unit'],
	}
}
