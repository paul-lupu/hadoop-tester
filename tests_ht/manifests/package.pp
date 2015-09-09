class tests_ht::package{
	package{'npm':
		ensure	=> present
	}
	exec{'install frisby':
		provider		=> 'shell', 
		command			=> 'npm install -g jasmine-node',
		require			=> Package['npm']
	}
}
