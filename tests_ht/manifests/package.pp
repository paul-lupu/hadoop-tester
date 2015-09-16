class tests_ht::package{
	package{'npm':
		ensure	=> present
	}
	exec{'install jasmine':
		provider		=> 'shell', 
		command			=> 'npm install -g jasmine-node',
		require			=> Package['npm']
	}
	exec{'install frisby':
		provider		=> 'shell', 
		command			=> 'cd /opt/tests/api && npm install --save-dev frisby',
		require			=> Package['npm']
	}
  exec{'install-form-data':
    provider    => 'shell',
    command     => 'cd /opt/tests/api && npm install form-data',
    require     => Package['npm']
  }
}
