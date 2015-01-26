#!/bin/bash

xml_parser() {
	if [ $OSTYPE == msys ]; then
		echo "xml"
	else
		echo "xmlstarlet"
	fi
}

##
# $1: node selecting XPath expression ("ns" alias is predifined for Maven's POM namespace)
# $2: path to XML file
##
node_text() {
	# can not use an empty string as the default output, using this secret constant in place
	NOT_FOUND_NODE="not found bastaaa"
	cmd=`xml_parser`
	value=$($cmd sel -N ns="http://maven.apache.org/POM/4.0.0" -t --if "($1)" -c "$1/text()" -n --else -o "$NOT_FOUND_NODE" "$2")
	if [ "$value" = "$NOT_FOUND_NODE" ]; then
		echo ""
	else
		echo "$value"
	fi
}

jirac_get_maven_project_version() {
	
	local projectPom=$1
	local directVersion=$(jirac_get_maven_direct_project_version "$projectPom")
	if [ -z "$directVersion" ]; then
		# if no direct version found, try to look for parent pom version
		echo $(jirac_get_maven_parent_project_version "$projectPom")
	else
		echo "$directVersion"
	fi
}

jirac_get_maven_direct_project_version() {
	cmd=`xml_parser`
	echo $(node_text "/ns:project/ns:version" "$1")
}

jirac_get_maven_parent_project_version() {
	cmd=`xml_parser`
	echo $(node_text "/ns:project/ns:parent/ns:version" "$1")
}

jirac_is_maven_project_version_from_parent() {

	local projectPom=$1
	local directVersion=$(jirac_get_maven_direct_project_version "$projectPom")
	local parentVersion=$(jirac_get_maven_parent_project_version "$projectPom")
	if [[ -z "$directVersion" && -n "$parentVersion" ]]; then
		return 0
	else
		return 1
	fi
}

##
# project name is the value of name tag if present and non empty, otherwise the value of the artifactId tag
##
jirac_get_maven_project_name() {
	cmd=`xml_parser`
	name=$(node_text "/ns:project/ns:name" "$1")
	if [ -z "$name" ]; then
		echo $(node_text "/ns:project/ns:artifactId" "$1")
	else
		echo "$name"
	fi
}

jirac_get_scm_url() {
	cmd=`xml_parser`
	echo $(node_text "/ns:project/ns:scm/ns:url" "$1")
}
