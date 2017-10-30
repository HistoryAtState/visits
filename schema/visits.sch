<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3" xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <title>Visits Rules</title>
    
    <p>This schematron file contains rules for visits.</p>
    
    <pattern>
        <rule context="visit">
            <assert test="start-date le end-date">Start/end date problem: Start date should precede end date</assert>
        </rule>
    </pattern>
    
    <pattern>
        <rule context="visit[preceding-sibling::visit]">
            <assert test="start-date ge preceding-sibling::visit[1]/start-date">Visit ordering problem: Visits should be given in chronological order</assert>
        </rule>
    </pattern>
    
</schema>