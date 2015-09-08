class catalogHT($components){
	
	file {'/root/catalog':
		content	=> template('catalog/catalog.erb'),
		ensure	=> present, 
	}

}
