#!/bin/bash

jirac_get_maven_version() {
	echo $(xmlstarlet sel -N ns="http://maven.apache.org/POM/4.0.0" -t -m "/ns:project/ns:version/text()" -c . -n $1)
}

jirac_get_maven_project_name() {
	echo $(xmlstarlet sel -N ns="http://maven.apache.org/POM/4.0.0" -t -m "/ns:project/ns:name/text()" -c . -n $1)
}

jirac_get_scm_url() {
	echo $(xmlstarlet sel -N ns="http://maven.apache.org/POM/4.0.0" -t -m "/ns:project/ns:scm/ns:connection/text()" -c . -n $1 | cut -d':' -f3- | sed -s 's/\.git//')
}
