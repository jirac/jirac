BEGIN {
	# Le markup JIRA pour les line breaks
	line_break = "\\\\"
}

{
	# On ecrit la ligne n-1 quand on traite la ligne n, donc on ne commence
	# qu'apres la premiere.
	if (NR > 1) {
		# Si la ligne courante contient du texte ou si la ligne
		# precedente etait deja un line break, on affiche telle quelle
		# la ligne precedente (pour eviter d'avoir un double line
		# break dans le 2e cas).
		if ($1 || prev == line_break) print prev
		else print prev, line_break
	}
	# On verifie que la ligne courante contient du texte et pas juste des
	# espaces.
	if ($1) prev = $0
	else prev = line_break
}

END {
	if (prev && prev != line_break) print prev
}
