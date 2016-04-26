<?php defined('BASEPATH') OR exit('No direct script access allowed'); ?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title><?=$T['app.base.title']?></title>

    <script type="text/javascript">
        var LocaleDictionary = <?=$localeDictionary?>;
        function t(key) {
            return LocaleDictionary[key] || key;
        }

        var localUrl = "<?=$baseUrlRedirect?>";
    </script>

    <script type="text/javascript" src="/extjs/ext-all-debug.js"></script>
    <link rel="stylesheet" href="/extjs/resources/css/ext-all-debug.css" />

    <script type="text/javascript" src="/UI/app.js"></script>
    <link rel="stylesheet" type="text/css" href="<?=$baseUrl?>resources/css/main-page.css" />
    <link rel="stylesheet" type="text/css" href="<?=$baseUrl?>resources/css/navigation.css" />
</head>
<body>

</body>
</html>