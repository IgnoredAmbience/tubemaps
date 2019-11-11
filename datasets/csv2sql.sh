#!/bin/sh

cat << EOF > london.sql
-- SQL dump for [[London Underground geographic maps]]. ([{{fullurl:{{PAGENAME}}|action=raw}} Download])
-- <pre><nowiki>
--
-- Table structure for table links
--
CREATE TABLE links (
  station1 smallint NOT NULL default '0',
  station2 smallint NOT NULL default '0',
  line smallint NOT NULL default '0',
  UNIQUE (line,station1,station2) 
) ;

--
-- Dumping data for table links
--
EOF

sed -e '1d; s/^/INSERT INTO links VALUES (/; s/$/);/' london.connections.csv >> london.sql

cat << EOF >> london.sql

--
-- Table structure for table routes
--
CREATE TABLE routes (
  line smallint NOT NULL default '0' PRIMARY KEY,
  name varchar(64) NOT NULL default '',
  colour varchar(6) NOT NULL default '',
  stripe varchar(6) default NULL,
  UNIQUE (line)
);

--
-- Dumping data for table routes
--
EOF

sed -e "1d; s/^/INSERT INTO routes VALUES (/; s/\"/'/g; s/$/);/" london.lines.csv >> london.sql

cat << EOF >> london.sql

--
-- Table structure for table stations
--
CREATE TABLE stations (
  id smallint NOT NULL default '0' UNIQUE,
  latitude float NOT NULL default '0',
  longitude float NOT NULL default '0',
  name varchar(64) NOT NULL default '',
  display_name varchar(64) default NULL,
  zone float default NULL,
  total_lines smallint NOT NULL default '0',
  rail smallint NOT NULL default '0',
  PRIMARY KEY (id)
);

--
-- Dumping data for table stations
--
EOF

sed -e "1d; s/^/INSERT INTO stations VALUES (/; s/'/\\\\'/g; s/\"/'/g; s/$/);/" london.stations.csv >> london.sql

cat << EOF >> london.sql

-- </nowiki></pre>

-- [[Category:London Underground maps]]
EOF
