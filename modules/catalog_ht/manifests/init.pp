class catalog_ht($components){
	
	file {'/root/catalog':
		content	=> template('catalog_ht/catalog.erb'),
		ensure	=> present, 
	}

}
