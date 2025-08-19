Return-Path: <linux-kernel+bounces-776244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A795B2CA85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61FA3BF82F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCEF3043BE;
	Tue, 19 Aug 2025 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="l0Y4F3fj"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF4130147C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624235; cv=none; b=ZvNLbbE7btPAzNBZEmGb4c6DYBXuUuf106RovkKG+5ZVlTX/sXAp3FegE3vQ+7zhv1sbN0PX35l0Xm9BycsZJGNNd/dYTQR2T9VDtmuYk2AvLaWE8E1aDyLYiXdajTvF5uW70OCTOhxHMBbvqvRyVua4lob17E48MhYicVFDu88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624235; c=relaxed/simple;
	bh=2SF9hFfi2KnWzL/wGsdOdSKE8sZ/GkpDxdN74uj+SLI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=FVrzdDCOQhRbWIbliEB9kMAL85clPIyte4rEhmi7vVerkSR8IpKnnKUUbrVGiX3sGZkuMaKNMzXsxdzZVUPIa/LXMGVvApKE2kip4IX4BGQX5jriPmGGiFe5E/cwbztqz6JWwTffmOm8iH2NK66mFNLY4sNj8ekUi2NkV+bosR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=l0Y4F3fj; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1755623920;
	bh=XdPDxZTMOyYizbKK9PfXmbIuKEs0kPtkOmxgKo2ltRs=;
	h=From:To:Cc:Subject:Date;
	b=l0Y4F3fjo25bn+FZ9J6CeMkUu1vkdFmlm1y00GQJEAr2lCp2hVg5Ik4xmeSgJLF9W
	 Rb78SCf8ZFLhIiuLqhgrQzdfxltQTiOoSLKH7W/0Ow0D1jHPpYtq28LFSzfAZg0xwg
	 km+cQs/fdSJwqcDm+9SYceyWe9ZKm3Jl1bPNioas=
Received: from zm.. ([2408:8340:a29:3fc0:20c:29ff:fe69:94c7])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 4A712A54; Wed, 20 Aug 2025 01:18:39 +0800
X-QQ-mid: xmsmtpt1755623919tma0yvmhr
Message-ID: <tencent_22B2504A61A3281D6A2590CB43ABCCEC790A@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XCDGMX72hfSgKMY+LOyhXcEUYdH6drhZUGVj++6F538lsY3hKQX
	 9ulpSxSm3oYupHleG9Mnh9bkCVZrhsICsn0wimLjsNzEvMptVYoE9SBYXevmbmRqKRkyvinbARTQ
	 aNsvkAsC7Q83tGhADQ/EaRXrHMhBPoxo5LCb8teOuYn1Ztre1PaDUpzITDj4vu7lRAYYiqxWszQJ
	 BFfFXvHbM4vb3uv8H7R8yx1N4/fP8XVWZZP9yreV4Ps7NXkVC/SlHRV912JKzxccuJOxvx76OPGW
	 +gHIc9qOsiaY84/VwI7N8ZwmLh8oYFTLVngGYgPmFWhJt3FHwW60gzkbtxFCiWW9v6xXY1P1cR4J
	 Qv5brmLv3bR8S+O0sKgn/9MYTM6G5QBWZYTnIstCnznJV/KVTVQfrOHKoKzHnJqkZRWVS5GF2Bpc
	 TrAywkq5CeDJVhxZjn3qw6HRjcnS+4nsF3VJS9zJ96iXCJ19NIp8JM8KsNQ5rJjp17BUJLibWCKx
	 GpOHM1DMDcP18KP8uIMT/vJiihNA/5vjoFDh8l4FBWLbDu+UR9xf/786UQErjHj/RCpPiMJEmG1r
	 gkkX+Y1RN56g4K9Lx10loncrjpKErYdTsS7XccbQZ58CPyUAX6GJwDIRVCzFJt06zzwsVhoOmWgN
	 bPHmtwp50abmWSEoevbsqsiqGxyfF1/IuNEIu3dBzUAGSvTMGAzPSdLq7mHXv3bNMlt3IR491z7U
	 PYbyqQ6yA9ovPy/qzNB8aImxG8ddDZa9uf0Q8Rm252tXV7UitgEdTZ56mWT12lumCJgxxlcX81D7
	 a/CICvDNk9sIPeOFJSiSuEVETnS0A1PaYolvtEMMFuQCCwArtARyq7WbF73x/VQjPhSVXNX8UK1S
	 sMGFM7ld0e0r5YTZY1zdSe+dg9Fy+GXf8W6Ypgs3+NMK44KLYihcyGyGvU7M7MVY3qCwO3NEU3sp
	 4j94w+TmfrO8DK32s1kd0TCPuO6DspWuh27uYf6KzioymG1P5Ib9P/u6Quc06ozA/KOexbTDQvj0
	 VmXv6P5dUlEiWA5nmNn0OhQYyU4WOwL1cMawiWdZKW28nEql7c01an80gEE5CTZZ/Mh3ViZELOgz
	 p696TNPT4MJCXu/5ceZyeqzBbuMw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: zhoumin <teczm@foxmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	zhoumin <teczm@foxmail.com>
Subject: [RFC PATCH] kobject: fix uevent helper execution order issues
Date: Wed, 20 Aug 2025 01:18:28 +0800
X-OQ-MSGID: <20250819171837.1786454-1-teczm@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

The current use of the UMH_NO_WAIT parameter does not guarantee the
sequential execution of CONFIG_STATIC_USERMODEHELPER_PATH.

For example, when fdisk completes and issues a BLKRRPART ioctl command,
kernel first sending remove events followed by an add events. However, 
process CONFIG_STATIC_USERMODEHELPER_PATH may execute
out-of-order—potentially handling the add before the remove. This can
result in the new partition being unexpectedly unmounted instead of mounted
as intended.

Admittedly, the current approach does not fully ensure that all
CONFIG_STATIC_USERMODEHELPER_PATH helpers execute in strict sequential
order. I have not yet identified a more robust solution and welcome
feedback on this issue. That said, if a mechanism can be established to
enforce reliable ordering of these user-mode helpers, higher-level
synchronization primitives—such as file locks—could then be used to
coordinate the overall execution sequence in userspace.

Test Log:

CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"

~ # cat /sbin/hotplug
#!/bin/sh
echo hotplug $DEVPATH $ACTION $DEVTYPE $MAJOR $MINOR $SUBSYSTEM > /dev/console
~ #

~ # fdisk /dev/sda

The number of cylinders for this disk is set to 8354.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p
Disk /dev/sda: 64 GB, 68719476736 bytes, 134217728 sectors
8354 cylinders, 255 heads, 63 sectors/track
Units: sectors of 1 * 512 = 512 bytes

Device  Boot StartCHS    EndCHS        StartLBA     EndLBA    Sectors  Size Id Type
/dev/sda1    0,1,1       12,191,50           63     204862     204800  100M 83 Linux
/dev/sda2    12,191,51   25,127,37       204863     409662     204800  100M 83 Linux
/dev/sda3    25,127,38   127,123,59      409663    2048062    1638400  800M 83 Linux
/dev/sda4    127,123,60  178,122,7      2048063    2867262     819200  400M  5 Extended
/dev/sda5    127,124,60  178,122,7      2048126    2867262     819137  399M 83 Linux

Command (m for help): wq
The partition table has been altered.
Calling ioctl() to re-read partition table
[  282.069158]  sda: sda1 sda2 sda3 sda4 < sda5 >
hotplug /devices/platform/4010000000.pcie/pci0000:00/0000:00:01.0/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda2 remove partition 8 2 block
~ # hotplug /devices/platform/4010000000.pcie/pci0000:00/0000:00:01.0/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda1 remove partition 8 1 block
hotplug /devices/platform/4010000000.pcie/pci0000:00/0000:00:01.0/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda3 remove partition 8 3 block
hotplug /devices/platform/4010000000.pcie/pci0000:00/0000:00:01.0/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda5 add partition 8 5 block
hotplug /devices/platform/4010000000.pcie/pci0000:00/0000:00:01.0/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda5 remove partition 8 5 block
hotplug /devices/platform/4010000000.pcie/pci0000:00/0000:00:01.0/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda3 add partition 8 3 block
hotplug /devices/platform/4010000000.pcie/pci0000:00/0000:00:01.0/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda4 remove partition 8 4 block
hotplug /devices/platform/4010000000.pcie/pci0000:00/0000:00:01.0/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda2 add partition 8 2 block
hotplug /devices/platform/4010000000.pcie/pci0000:00/0000:00:01.0/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda1 add partition 8 1 block
hotplug /devices/platform/4010000000.pcie/pci0000:00/0000:00:01.0/ata1/host0/target0:0:0/0:0:0:0/block/sda change disk 8 0 block
hotplug /devices/platform/4010000000.pcie/pci0000:00/0000:00:01.0/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda4 add partition 8 4 block




Signed-off-by: zhoumin <teczm@foxmail.com>
---
 lib/kobject_uevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index b7f2fa08d9c8..fd7b9d4c46c0 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -629,7 +629,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 						 env->envp, GFP_KERNEL,
 						 NULL, cleanup_uevent_env, env);
 		if (info) {
-			retval = call_usermodehelper_exec(info, UMH_NO_WAIT);
+			retval = call_usermodehelper_exec(info, UMH_WAIT_EXEC);
 			env = NULL;	/* freed by cleanup_uevent_env */
 		}
 	}
-- 
2.43.0


