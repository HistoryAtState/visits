<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" queryBinding="xslt3">
    <title>Visits Rules</title>
    
    <p>This schematron file contains rules for visits.</p>
    
    <let name="visit-ids" value="collection('../data?select=*.xml')//id"/>
    <let name="next-id" value="max(($visit-ids ! (. cast as xs:integer))) + 1"/>
    
    <pattern>
        <rule context="visit">
            <assert test="start-date le end-date">Start/end date problem: Start date should precede end date, but <value-of select="start-date"/> is given as the start date and <value-of select="end-date"/> is given as the end date</assert>
        </rule>
    </pattern>
    
    <pattern>
        <rule context="visit[preceding-sibling::visit]">
            <assert test="start-date ge preceding-sibling::visit[1]/start-date">Visit ordering problem: Visits should be given in chronological order, but visit <value-of select="id"/> starts before visit <value-of select="preceding-sibling::visit[1]/id"/>
            </assert>
        </rule>
    </pattern>
    
    <pattern>
        <rule context="id">
            <let name="this-id" value="./string()"/>
            <let name="count-used" value="count($visit-ids[. = $this-id])"/>
            <assert test="$count-used eq 1" sqf:fix="update-id">Visit ID problem: <value-of select="$count-used"/> other visit(s) also use the same ID, <value-of select="$this-id"/>.</assert>
            <sqf:fix id="update-id">
                <sqf:description>
                    <sqf:title>Fix ID (use next available ID, <value-of select="$next-id"/>)</sqf:title>
                </sqf:description>
                <sqf:replace match="text()" select="$next-id"/>
            </sqf:fix>
        </rule>
    </pattern>
    
</schema>