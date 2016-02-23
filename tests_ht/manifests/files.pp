class tests_ht::files{
  file {'test_dir':
    path      => "/opt/tests",
    ensure    => directory
  }
	file{'system_dir':
		path			=> "/opt/tests/system", 
		ensure		=> directory, 
		require		=> File['test_dir'],
	}
	file{'falcon_dir':
		path			=> "/opt/tests/falcon", 
		ensure		=> directory, 
		require		=> File['test_dir'],
	}
	file{'falcon_script':
		path			=> "/opt/tests/falcon/falcon_test.sh",
		source		=> "puppet:///modules/tests_ht/falcon/falcon_test.sh", 
		require		=> File['falcon_dir'],
	}
	file {'hive_dir':
		path			=> "/opt/tests/hive",
		ensure		=> directory, 
		require		=> File['test_dir'],
	}
	file{'hive_script':	
		path			=> "/opt/tests/hive/hive_test.sh",
		source		=> "puppet:///modules/tests_ht/hive/hive_test.sh",
		require		=> File['hive_dir'],
	}
	file{'sqoop_dir':
		path			=> "/opt/tests/sqoop",
		ensure		=> directory, 
		require		=> File['test_dir'], 
	}
	file{'sqoop_script':
		path			=> '/opt/tests/sqoop/sqoop_test.sh',
		source		=> 'puppet:///modules/tests_ht/sqoop/sqoop_test.sh', 
		require		=> File['sqoop_dir'],
	}
	file {'api_dir':
    path      => "/opt/tests/api",
    ensure    => directory,
    require   => File['test_dir'],
  }	
	file {'systems_script':
		path			=> '/opt/tests/system/system_tests.sh', 
		source		=> 'puppet:///modules/tests_ht/system/system_tests.sh', 
		require		=> File['system_dir'],
	}
	file{'all_scripts':
		path			=> '/opt/tests/all_tests.sh', 
		source		=> 'puppet:///modules/tests_ht/all_tests.sh', 
		mode			=> "655",
		require		=> File['test_dir'],
	}
	file {'api_script':
		path			=> "/opt/tests/api_tests.sh",
		source		=> "puppet:///modules/tests_ht/api/api_test.sh",
		require		=> File['api_dir'],
	}
	file {'hbase_dir':
    path      => "/opt/tests/hbase",
    ensure    => directory,
    require   => File['test_dir'],
  }
	file{'hbase_script':
		path			=> "/opt/tests/hbase/hbase_test.sh",
		source		=> "puppet:///modules/tests_ht/hbase/hbase_test.sh",
		require		=> File['hbase_dir'],
	}
  file{'hbase_commands':
    path      => "/opt/tests/hbase/hbase_commands",
    source    => "puppet:///modules/tests_ht/hbase/hbase_commands",
    require   => File['hbase_dir'],
  }
}
