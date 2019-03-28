#!/bin/bash

# docker stop jon
# docker run --rm --name jon -h jon -it -d -p 7080:7080 psteiner/jon:3.3.11
#docker start jon
# docker exec -it jon bash 

docker run --rm --link jonserver1:jonserver1 --name jonserver2 -h jonserver2 -p 7082:7080 psteiner/jon-ha-jonserver2:3.3.11
