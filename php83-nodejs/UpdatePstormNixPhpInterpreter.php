<?php

use Ramsey\Uuid\Uuid;

require 'vendor/autoload.php';

function createInterpreterIfNotExists(SimpleXMLElement $root): string
{
    $existingInterpreter = $root->xpath('//interpreter[@home="$PROJECT_DIR$/.bin/php"]')[0] ?? null;
    if ($existingInterpreter !== null) {
        $interpreterId = (string) $existingInterpreter->attributes()->id;
        printf("Found existing interpreter with id: %s\n", $interpreterId);

        return $interpreterId;
    }

    // Find or create <component name="PhpInterpreters">
    $phpInterpreters = $root->xpath("//component[@name='PhpInterpreters']")[0] ?? null;
    if ($phpInterpreters === null) {
        $phpInterpreters = $root->addChild('component');
        $phpInterpreters->addAttribute('name', 'PhpInterpreters');
    }

    // Find or create //component[@name='PhpInterpreters']/interpreters
    $interpreters = $phpInterpreters->interpreters
        ?? $phpInterpreters->addChild('interpreters');

    $interpreter = $interpreters->addChild('interpreter');
    $interpreter->addAttribute('id', $interpreterId = (string) Uuid::uuid4());
    $interpreter->addAttribute('name', 'nix flake');
    $interpreter->addAttribute('home', '$PROJECT_DIR$/.bin/php');
    $interpreter->addAttribute('auto', 'false');
    $interpreter->addAttribute('debugger_id', 'php.debugger.XDebug');
    printf("Nix flake interpreter added with id: %s.\n", $interpreterId);

    return $interpreterId;
}

// formatter
// +  <component name="PhpExternalFormatter">
// +    <option name="externalFormatter" value="LARAVEL_PINT" />
// +  </component>
function setExternalFormatterToPint(SimpleXMLElement $root): void
{
    $formatter = $root->xpath('//component[@name="PhpExternalFormatter"]')[0] ?? null;
    if ($formatter !== null) {

        $selectedFormatter = (string) $formatter->option->attributes()->value;
        printf("Found formatter: %s\n", $selectedFormatter);

        return;
    }

    $formatter = $root->addChild('component');
    $formatter->addAttribute('name', 'PhpExternalFormatter');
    $fmtOption = $formatter->addChild('option');
    $fmtOption->addAttribute('name', 'externalFormatter');
    $fmtOption->addAttribute('value', 'LARAVEL_PINT');
}

function getPhpXml(string $path): SimpleXMLElement
{
    if (file_exists($path)) {
        return simplexml_load_file($path);
    }

    printf("Interpreter settings not found at: %s, creating new one.\n", str($path)->after(__DIR__)->ltrim('/'));

    return simplexml_load_string('<?xml version="1.0" encoding="UTF-8"?><project version="4"></project>');
}

$phpXmlPath = __DIR__.'/.idea/php.xml';
$phpXml = getphpxml($phpXmlPath);
createInterpreterIfNotExists($phpXml);

if (file_exists(__DIR__.'/pint.json')
    && file_exists(__DIR__.'/vendor/bin/pint')) {
    setExternalFormatterToPint($phpXml);
}
$phpXml->asXML($phpXmlPath);
