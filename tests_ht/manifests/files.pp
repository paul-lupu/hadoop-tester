class tests_ht::files{
  file {'test_dir':
    path      => "/opt/tests",
    ensure    => directory
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
	file {'api_dir':
    path      => "/opt/tests/api",
    ensure    => directory,
    require   => File['test_dir'],
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
