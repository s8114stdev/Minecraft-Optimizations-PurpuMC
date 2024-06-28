# PurpurMC Optimizations Guide and Configurations

![PurpurMC Logo](https://github.com/s8114stdev/Minecraft-Optimizations-PurpuMC/assets/173851843/d4a01f13-8c11-4514-9fe9-e4b6fcd15627)

> Get my latest free optimizations and guides on my [dashboard](https://dashboard.s8114st.xyz). This tool is designed specifically for Minecraft developers to help with various optimizations and guidance.

## Preparations

### 1. Server Software

I **strongly** recommend using the optimized PaperMC fork called PurpurMC. It is more optimized than the default PaperMC and focuses on performance and customization. For this guide, please use the latest PurpurMC. Download it from [PurpurMC's website](https://purpurmc.org/).

### 2. Chunk Pregeneration

Pregenerating your chunks on your server improves performance by preloading chunks. 

**Recommended Plugins:** [Chunky](https://www.spigotmc.org/resources/chunky.81534/) and [Fast Chunk Pregenerator](https://www.spigotmc.org/resources/fast-chunk-pregenerator.74429/).

It is recommended to pregenerate chunks before server release. Additionally, set a world border using `/worldborder set <diameter>`.

### 3. Useless Plugins

Avoid installing every plugin available on SpigotMC or PaperMC Hangar. Only use plugins that you will actually need. Be aware of potential heap memory leaks from some plugins. A guide on how to prevent and detect these leaks is available on my [dashboard](https://dashboard.s8114st.xyz).

### 4. Cracked Plugins

Cracked plugins often contain malicious code such as botnets, backdoors, and cryptomining scripts, which can exploit your server’s network resources. Moreover, using cracked plugins violates most host terms of service. It's best to avoid cracked plugins altogether.

### 5. Server Hardware and Hosting Service

I highly recommend getting a server from [Hetzner](https://hetzner.com). It is affordable and reliable, with many Minecraft hosting services using Hetzner. You can easily get started with the help of our guide or through our free installation support via 24/7 Discord ticket support.

## Optimizations

### 1. Pterodactyl/Pelican Recommended Startup Flags

To optimize your PurpurMC server, use the following startup flags when running it on a Pterodactyl/Pelican container:

```
java -Xms128M -Xmx{{SERVER_MEMORY}}M -XX:MaxRAMPercentage=90.0 -XX:+UseContainerSupport -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 –add-modules=jdk.incubator.vector -Dusing.aikars.flags=https://mcflags.emc.gs -Dterminal.jline=false -Dterminal.ansi=true -Daikars.new.flags=true -jar {{SERVER_JARFILE}}
```

## 2. Server Configuration: server.properties

```
sync-chunk-writes=false
view-distance=6
entity-broadcast-range-percentage=90
simulation-distance=6
```


