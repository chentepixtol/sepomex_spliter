# README

Sepomex Splitter [![Build Status](https://secure.travis-ci.org/chentepixtol/sepomex_spliter.png?branch=master)](http://travis-ci.org/chentepixtol/sepomex_spliter)

You can run workers as follows 

Filter postal codes of Ciudad de México

`bin/rails worker:state["Ciudad de México"]`

Filter postal codes of Guerrero

`bin/rails worker:state["Guerrero"]`

or any another state

Also you can negate the worker with `not_in_state`

Filter all postal code except of Ciudad de México

`bin/rails worker:not_in_state["Ciudad de México"]`

