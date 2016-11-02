class tests_ht::package{
	package{'npm':
		ensure	=> present
	}
	package{'jq':
		ensure	=> present
	}
	exec{'install jasmine':
		provider		=> 'shell', 
		command			=> 'npm cache clean jasmine-node && npm install -g jasmine-node',
		require			=> Package['npm']
	}
	exec{'install frisby':
		provider		=> 'shell', 
		command			=> 'cd /opt/tests/api && npm cache clean frisby && npm install --save-dev frisby',
		require			=> Package['npm']
	}
  exec{'install-form-data':
    provider    => 'shell',
    command     => 'cd /opt/tests/api && npm cache clean form-data && npm install form-data',
    require     => Package['npm']
  }
}
