class tests_ht{
	include package
	include api
  Class['files'] ->
	Class['package']->
	Class['api'] ->
	Class['tests']
}
