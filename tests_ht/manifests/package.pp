class tests_ht::package{
	package{'npm':
		ensure	=> present
	}
  file {'test_dir':
    path      => "/vagrant/tests",
    ensure    => directory
  }
	exec{'install jasmine':
		provider		=> 'shell', 
		command			=> 'npm install -g jasmine-node',
		require			=> [File['test_dir'],Package['npm']]
	}
	exec{'install frisby':
		provider		=> 'shell', 
		command			=> 'cd /vagrant/tests && sudo npm install --save-dev frisby',
		require			=> [File['test_dir'],Package['npm']]
	}
  exec{'install-form-data':
    provider    => 'shell',
    command     => 'cd /vagrant/tests && npm install form-data',
    require     => [File['test_dir'],Package['npm']]
  }
}
