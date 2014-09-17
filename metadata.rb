name             'loganov-logstash'
maintainer       'Loganov Industries'
maintainer_email 'devops@loganov.com'
license          'All rights reserved'
description      'Installs/Configures loganov-logstash'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'

recipe            'loganov-logstash::default', 'Install logstash'

depends           'loganov-java'
depends           'yum'