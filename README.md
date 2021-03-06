# Clubhouse

This sandbox app is built with Rails and features a mix of CableReady, StimulusReflex, MRUJS and Turbo (Drive) and does just enough to test that all the above are working correctly.

- CRUD actions on forum `Posts` use vanilla MRUJS and Cableready (via the CableCar plugin)
- `Comment` posting uses MRUJS and CableReady
- The search/filtering on forum `Posts` uses simple StimulusReflex
- The chat uses a weird mix of Cableready and StimulusReflex for `Messages`
- Navigation is handled by Turbo

The app is Dockerised and designed to be deployed to multiple regions with Fly.io, and used as a testing ground for multi-region database topologies and any issues around development of MRAs (Multi-Region Applications).

Regional Redis instances are provided by https://github.com/mra-clubhouse/fly-redis/tree/custom-redis (forked from `fly-apps/redis`).

----------------------------------

#### Related Docs
- Fly.io: https://fly.io/docs/
- Stimulus Reflex: https://docs.stimulusreflex.com/
- CableReady: https://cableready.stimulusreflex.com/
- MRUJS: https://mrujs.com/how-tos

#### Image Credits
- Treehouse: https://www.freepik.com/free-vector/tree-houses-green-foliage-illustration_6822653.htm
- Cloud: https://www.freepik.com/free-vector/cartoon-clouds-collection_15591096.htm
