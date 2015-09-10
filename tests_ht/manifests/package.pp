class tests_ht::package{
	package{'npm':
		ensure	=> present
	}
  file {'test_dir':
    path      => "/opt/tests",
    ensure    => directory
  }
	exec{'install jasmine':
		provider		=> 'shell', 
		command			=> 'cd /opt/tests && npm install jasmine-node',
		require			=> [File['test_dir'],Package['npm']]
	}
	exec{'install frisby':
		provider		=> 'shell', 
		command			=> 'cd /opt/tests && sudo npm install --save-dev frisby',
		require			=> [File['test_dir'],Package['npm']]
	}
  exec{'form-data':
    provider    => 'shell',
    command     => 'cd /opt/tests && npm install form-data',
    require     => [File['test_dir'],Package['npm']]
  }

}
