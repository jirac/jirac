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
	project_version=$($cmd sel -N ns="http://maven.apache.org/POM/4.0.0" -t -m "/ns:project/ns:version/text()" -c . -n "$1")
}

jirac_get_maven_project_name() {
	cmd=`xml_parser`
	project=$($cmd sel -N ns="http://maven.apache.org/POM/4.0.0" -t -m "/ns:project/ns:name/text()" -c . -n "$1")
}

jirac_get_repository_url() {
	cmd=`xml_parser`
	repository_base_url= $($cmd sel -N ns="http://maven.apache.org/POM/4.0.0" -t -m "/ns:project/ns:scm/ns:url/text()" -c . -n "$1")
    if [ -z "$repository_base_url" ];then
	    repository_base_url=$($cmd sel -N ns="http://maven.apache.org/POM/4.0.0" -t -m "/ns:project/ns:scm/ns:connection/text()" -c . -n "$1" | cut -d':' -f3- | sed  's/\.git//')
    fi
}
