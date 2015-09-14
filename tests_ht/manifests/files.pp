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
 file {'api_dir':
    path      => "/opt/tests/api",
    ensure    => directory,
    require   => File['test_dir'],
  }
 file {'hbase_dir':
    path      => "/opt/tests/hbase",
    ensure    => directory,
    require   => File['test_dir'],
  }
}
