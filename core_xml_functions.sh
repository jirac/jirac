#!/bin/bash

xml_parser() {
	if [[ $OSTYPE == msys ]]; then
		echo "xml"
	else
		echo "xmlstarlet"
	fi
}

jirac_get_maven_version() {
	cmd=`xml_parser`
	echo $($cmd sel -N ns="http://maven.apache.org/POM/4.0.0" -t -m "/ns:project/ns:version/text()" -c . -n "$1")
}

jirac_get_maven_project_artifact_id() {
	cmd=`xml_parser`
	echo $($cmd sel -N ns="http://maven.apache.org/POM/4.0.0" -t -m "/ns:project/ns:artifactId/text()" -c . -n "$1")
}

jirac_get_scm_url() {
	cmd=`xml_parser`
	echo $($cmd sel -N ns="http://maven.apache.org/POM/4.0.0" -t -m "/ns:project/ns:scm/ns:url/text()" -c . -n "$1")
}

jirac_get_connection_url() {
	cmd=`xml_parser`
	echo $($cmd sel -N ns="http://maven.apache.org/POM/4.0.0" -t -m "/ns:project/ns:scm/ns:connection/text()" -c . -n "$1" | cut -d':' -f3- | sed  's/\.git//')
}
