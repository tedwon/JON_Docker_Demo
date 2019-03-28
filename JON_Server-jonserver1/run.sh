#!/bin/bash

# docker stop jon
# docker run --rm --name jon -h jon -it -d -p 7080:7080 psteiner/jon:3.3.11
#docker start jon
# docker exec -it jon bash 

docker run --rm --name jonserver1 -h jonserver1 -p 7081:7080 psteiner/jon-ha-jonserver1:3.3.11
