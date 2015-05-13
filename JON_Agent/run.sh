#!/bin/bash
docker run -p 49160:8080 -p 49170:9990 --link jon:jon -d psteiner/jonagent
