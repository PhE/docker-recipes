DockerFile devionic
==========================

DockerFile for my Ionic+Python dev env

Shortcuts
--------------

* _couchdb_ : start the couchdb server
* http://CONTAINER_IP::5984/_utils : Futon Couchdb admin interface
* http://CONTAINER_IP::xxxx : Ionic serve
* http://CONTAINER_IP::8888 : IPython notebook
* http://CONTAINER_IP::7999 : Web2py


Couchdb data
----------------------

A dummy database is present.
To update dummy data :

.. code:: Bash

  couchdb-dump http://localhost:5984/dummy2 > data_dummy.mime


The couchdb-load conterpart is in the Dockerfile.
