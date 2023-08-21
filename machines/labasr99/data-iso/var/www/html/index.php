<?php
// mirrorlist

// Host router
switch ($_SERVER['SERVER_NAME']) {
case "mirrorlist.centos.org":
	$release = htmlspecialchars($_GET['release']);
	$arch = htmlspecialchars($_GET['arch']);
	$repo = htmlspecialchars($_GET['repo']);
	$infra = htmlspecialchars($_GET['infra']);

	echo "http://mirror.centos.org/centos/{$release}/{$repo}/{$arch}/os/";
	break;
}
?>
