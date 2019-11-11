#!/bin/sh

cat << EOF > london.wiki
Source data for [[London Underground geographic maps]].
__TOC__
== Stations ==

{| class="toccolours" border="1" cellpadding="3" style="margin: 1em 1em 1em 0; border-collapse: collapse; font-size: 95%;"
! id !! latitude !! longitude !! name !! display_name !! zone !! total_lines !! rail
EOF

sed -E -e '1d; i |-' -e 's/^/| /;' -e ':1' -e 's/^(([^",]|"[^"]*")*),/\1 || /; t1;' -e 's/"//g; s/</\&lt;/g; s/>/\&gt;/g' london.stations.csv >> london.wiki

cat << EOF >> london.wiki
|}

== Routes ==

{| class="toccolours" border="1" cellpadding="3" style="margin: 1em 1em 1em 0; border-collapse: collapse; font-size: 95%;"
! line !! name !! colour !! stripe
EOF

sed -e '1d; i |-' -e 's/^/| /; s/,/ || /g; s/"//g' london.lines.csv >> london.wiki

cat << EOF >> london.wiki
|}

== Line definitions ==

{| class="toccolours" border="1" cellpadding="3" style="margin: 1em 1em 1em 0; border-collapse: collapse; font-size: 95%;"
! station1 !! station2 !! line
EOF

sed -e '1d; i |-' -e 's/^/| /; s/,/ || /g' london.connections.csv >> london.wiki


cat << EOF >> london.wiki
|}

[[Category:London Underground maps]]
EOF
