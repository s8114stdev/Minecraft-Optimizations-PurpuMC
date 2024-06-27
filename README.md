# PurpurMC Optimizations Guide and Configurations

To optimize your PurpurMC server, it is recommended to run it on a Pterodactyl container with the following startup flags:

```
java -Xms128M -Xmx{{SERVER_MEMORY}}M -XX:MaxRAMPercentage=90.0 -XX:+UseContainerSupport -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 –add-modules=jdk.incubator.vector -Dusing.aikars.flags=https://mcflags.emc.gs -Dterminal.jline=false -Dterminal.ansi=true -Daikars.new.flags=true -jar {{SERVER_JARFILE}}
```

