Return-Path: <linux-kernel+bounces-887837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E7AC39316
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFEE3B6FE4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046452D5410;
	Thu,  6 Nov 2025 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJQLLdiT"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAFE221F34
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 05:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762408468; cv=none; b=QAOSQbd4AzLHay9Y+E8ae5Vy6R7MWe03FswAg5MHhAI1ldV+Bec3YW/k2twLPtcKh/OcGCyp9ENf9Pcs0Ifzx6rN245yQrfT+7AIBIfACgZz6hWM6LFIdFdsIA8vkgYvsF5yRe8z3mcBF5bs/gG8g7AsSme2P5GlvYIg7PkXDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762408468; c=relaxed/simple;
	bh=7sp0HJ+6dF2elX0OMaXBAvr0GEMizwSfVAyJ0EVvYLY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KovJ7TrTMcDp2FW4iiBZIudzmrE9GdxnxJx8Sb+V5jR+LGuwWVy4OVClzG1QC3wfS70BvDlgTUeH0Znn8mf3WcrWNlMim5YREfMBWdsZXjaB6BHQU36BTGkV4N7HelZYlCni7E36/brxjSp1Q7w1oVbHcL0DYdl//37mxyj1MJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJQLLdiT; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-340e525487eso475377a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 21:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762408465; x=1763013265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/uL/Sm5RZVxIUEP8aNHC40zOAXzudZ+giaQVujeAgo=;
        b=AJQLLdiTeeUpa4nFn13b3y5wzFcnniBYLI3Onedu33WbakFGvw3GNhw6Nx65a7lUni
         1I5SlMXG00VJ6x5X+l0fcK1YibYqcVTrF5qtX5j306ynU7tSV59b/UupC8mx1CTMziwF
         809kppQqTls8sArjdSG+obHWKSOPJRG52dJogVHO1H7AXYc2ysBY2/S0BzSzOhGKuEcJ
         t6u6STimplsbb1gDncyi0XoPVnaAP3K9mHBRihcInXv/UAE1EDd+umMC5/WZIHmceFV1
         GJ8siN11ju9lz4G+kv0U9+bD/3DDzN6cC4NOixo/2ZB8y8Oo06wfSO4/zbhx9iO9QOKO
         3ccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762408465; x=1763013265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/uL/Sm5RZVxIUEP8aNHC40zOAXzudZ+giaQVujeAgo=;
        b=hM6wzOpllsfHXr0ldF7d1D7JPar9n9JcH2AlBZd2CNtr06Q+slsRDxDz3qyaPIeVXt
         A4DsT1sODlxrtAHoFXUf2SVLN8dG5C/Eq21U3Pu7+mIoQuaCF6vmlcf+S3y35MJq1K1x
         VJRa4SvF3OlrjDmDewBLyFUqi32Csnl1iGcwAUqHoIS5GWtqlo1OGii3/ZbgyBm88Yso
         IQV4mYXyK2HhPKlaL0AldnuqKLRBbqXIpqllgeuzpvIRQ7dScJw3XXWKy/1yPytM/xCJ
         7wQ7HXo767lOfY/hAXClYdeLrSo6hRdkoxCrcTWYZBhvHu9OI76C19SIcwHmp5FCgMBT
         GZ9w==
X-Forwarded-Encrypted: i=1; AJvYcCW5UO2+uCCPonMh8okA3fkfehGkXoK+jitw0o1kfsIWgXCbu0oFVPmuFau/7gb/Efv9ZF5KT1K7VaItK7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YypKdWwxawk0gqTpmahkxgtz5TDmPrG8I/6JHK+C/mWCMLRERzY
	r/4xCnIma1UdbuxE19OpxHRlnC0EL+P5QeADVfCd9aQZXwy1t/XHT8XpexGM2g==
X-Gm-Gg: ASbGnctSddPIaFVbQUjmCuBYud11KhfCdjXS3g7yw4xq9+T55Ha/Z6xSdt4OeSX8xht
	XCbI1MeBEcp+DV0/ydC9mQ3MlSA53UKGlCAiFXct7fYBqSqkMIi30+ok7/ZvROfkuvhbaRiiYPX
	gPgS7aCi7fmAEimwzZ3Wag+7nWaEWvs1zv186rQIl6ym9sJleYO3S77MClMLfwtEssCgra/27tr
	foOT3JNioOHqjiwqD9SkC/Cn4/4IRRaDr9JGEEiV7fZZnYD3U8zbuXNXBs+rTTA6BWw/Dt9okB5
	EiGHtGoHpCkXa+cI2gMc5G5CsRnXCp08KiIZ2csthi6AYMaI5yPMGAIQmgODELnruO9JzTB5FUH
	z+S0Mr6u4MMjWpJWWKnW8hBXxvboku3TVGT/W4LACAGSvz+1SUt6MkYYFZ/bm5EhPfniAAxGz9q
	01vO6MYuBGygCS79+XqDf11feMfSYHFSmjgQ==
X-Google-Smtp-Source: AGHT+IG8HBHkWqeuKHYqad0SV9Y1SnR0afd0c8QhV6juVrv7g2kvEWv3+uz9+Uh1cH79VQ73r/cJMA==
X-Received: by 2002:a17:902:f544:b0:250:643e:c947 with SMTP id d9443c01a7336-2962ad8857dmr85099795ad.28.1762408464813;
        Wed, 05 Nov 2025 21:54:24 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7c5ccsm14283365ad.57.2025.11.05.21.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 21:54:24 -0800 (PST)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id F1A138015C;
	Thu,  6 Nov 2025 13:57:20 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: richard@nod.at,
	chengzhihao1@huawei.com,
	miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 0/1] mtd: ubi: skip programming unused bits in ubi headers
Date: Thu,  6 Nov 2025 13:49:39 +0800
Message-Id: <20251106054940.2728641-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

This patch verification was performed on a Xilinx Zynq-PicoZed board with
mtd-utils version 2.3.0. Tests were conducted using both the nandsim
simulated NAND and a real NAND flash device.

Before modifying ubi/io.c, running the tests in mtd-utils/tests/ubi-tests
exhibited the following issue.

While running the mtd-utils/tests/ubi-tests/runubitests.sh test suite,
the execution reaches rsvol.c where, after ubi_mkvol is called, it
subsequently calls ubi_get_vol_info. At this point, there is a certain
probability of encountering an "error -2, no such file or directory".

To address this, I modified the ubi_mkvol function within mtd-utils by
adding a polling mechanism that waits for the /dev/ubi0_x device node
to be created before proceeding.

However, after adding this polling, the test encountered a similar "no
such file" error in io_paral.c. Further investigation pointed to a
potential issue with mdev. According to mdev documentation, kernel hotplug
events are not serialized and increment the SEQNUM environmental variable
on each invocation. This can cause hotplug and hot-unplug events to be
reordered, which sometimes results in device nodes not being created
as expected.

To solve this, I introduced an mdev.seq to serialize these events,
effectively resolving the problem.

With both modifications, the polling in ubi_mkvol and the mdev.seq
handling - runubitests.sh completes successfully.

Beyond these fixes, to validate the patch’s behavior with and without
subpage support, I also added a new module parameter subpage to nandsim.
This allows dynamically toggling subpage support. Setting the parameter
to 0 enforces the chip flag NAND_NO_SUBPAGE_WRITE, effectively disabling
subpage writes.

The experimental procedure and logs are detailed below, covering tests
on both real Macronix NAND flash and the nandsim simulated flash, each
tested with and without subpage support enabled.

- Without subpage support on Macronix NAND flash
nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xda
nand: Macronix MX30LF2G18AC
nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64

zynq> ./mnt/mtd-utils/flash_unlock -u /dev/mtd0
zynq> flash_eraseall /dev/mtd0
Erasing 128 Kibyte @ 10000000 - 100% complete.

zynq> ./mnt/mtd-utils/ubiformat /dev/mtd0
ubiformat: mtd0 (nand), size 268435456 bytes (256.0 MiB), 2048 eraseblocks of 131072 bytes (128.0 KiB), min. I/O size 2048 bytes
libscan: scanning eraseblock 2047 -- 100 % complete
ubiformat: 2048 eraseblocks are supposedly empty
ubiformat: formatting eraseblock 2047 -- 100 % complete

zynq> ./mnt/mtd-utils/ubiattach -m 0
ubi0: attaching mtd0
ubi0: scanning is finished
ubi0: attached mtd0 (name "43a00000.Unified_Extensible_Flash_Controller", size 256 MiB)
ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 bytes
ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
ubi0: VID header offset: 2048 (aligned 2048), data offset: 4096
ubi0: good PEBs: 2048, bad PEBs: 0, corrupted PEBs: 0
ubi0: user volume: 0, internal volumes: 1, max. volumes count: 128
ubi0: max/mean erase counter: 0/0, WL threshold: 4096, image sequence number: 2132442355
ubi0: available PEBs: 2004, total reserved PEBs: 44, PEBs reserved for bad PEB handling: 40
ubi0: background thread "ubi_bgt0d" started, PID 88
UBI device number 0, total 2048 LEBs (260046848 bytes, 248.0 MiB), available 2004 LEBs (254459904 bytes, 242.6 MiB), LEB size 126976 bytes (124.0 KiB)

zynq> ./mnt/mtd-utils/tests/ubi-tests/runubitests.sh /dev/ubi0
Running mkvol_basic /dev/ubi0
Running mkvol_bad /dev/ubi0
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    -2
        alignment 1
        bytes     254459904
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    128
        alignment 1
        bytes     254459904
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 0
        bytes     254459904
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment -1
        bytes     254459904
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 126977
        bytes     254459904
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 2049
        bytes     254459904
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     -1
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     0
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: not enough PEBs, only 2004 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_create_volume: not enough PEBs, only 2004 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     126976
        vol_type  7
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: volume 0 already exists
ubi0 error: ubi_create_volume: cannot create volume 0, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_open_volume: cannot open device 0, volume 128, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume -1, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 128, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19
Running mkvol_paral /dev/ubi0
Running rsvol /dev/ubi0
Running io_basic /dev/ubi0
Running io_read /dev/ubi0
Running io_update /dev/ubi0
Running io_paral /dev/ubi0
Running volrefcnt /dev/ubi0
SUCCESS

- With subpage support of Macronix NAND flash
nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xda
nand: Macronix MX30LF2G18AC
nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64

zynq> ./mnt/mtd-utils/flash_unlock -u /dev/mtd0
zynq> flash_eraseall /dev/mtd0
Erasing 128 Kibyte @ 10000000 - 100% complete.

zynq> ./mnt/mtd-utils/ubiformat /dev/mtd0
ubiformat: mtd0 (nand), size 268435456 bytes (256.0 MiB), 2048 eraseblocks of 131072 bytes (128.0 KiB), min. I/O size 2048 bytes
libscan: scanning eraseblock 2047 -- 100 % complete  
ubiformat: 2048 eraseblocks are supposedly empty
ubiformat: formatting eraseblock 2047 -- 100 % complete  
zynq> ./mnt/mtd-utils/ubiattach -m 0
ubi0: attaching mtd0
ubi0: scanning is finished
ubi0: attached mtd0 (name "43a00000.Unified_Extensible_Flash_Controller", size 256 MiB)
ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 129024 bytes
ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 512
ubi0: VID header offset: 512 (aligned 512), data offset: 2048
ubi0: good PEBs: 2048, bad PEBs: 0, corrupted PEBs: 0
ubi0: user volume: 0, internal volumes: 1, max. volumes count: 128
ubi0: max/mean erase counter: 0/0, WL threshold: 4096, image sequence number: 1464207753
ubi0: available PEBs: 2004, total reserved PEBs: 44, PEBs reserved for bad PEB handling: 40
ubi0: background thread "ubi_bgt0d" started, PID 88
UBI device number 0, total 2048 LEBs (264241152 bytes, 252.0 MiB), available 2004 LEBs (258564096 bytes, 246.5 MiB), LEB size 129024 bytes (126.0 KiB)

zynq> ./mnt/mtd-utils/tests/ubi-tests/runubitests.sh /dev/ubi0
Running mkvol_basic /dev/ubi0
Running mkvol_bad /dev/ubi0
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    -2
        alignment 1
        bytes     258564096
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    128
        alignment 1
        bytes     258564096
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 0
        bytes     258564096
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment -1
        bytes     258564096
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 129025
        bytes     258564096
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 2049
        bytes     258564096
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     -1
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     0
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: not enough PEBs, only 2004 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_create_volume: not enough PEBs, only 2004 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     129024
        vol_type  7
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: volume 0 already exists
ubi0 error: ubi_create_volume: cannot create volume 0, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_open_volume: cannot open device 0, volume 128, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume -1, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 128, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19
Running mkvol_paral /dev/ubi0
Running rsvol /dev/ubi0
Running io_basic /dev/ubi0
Running io_read /dev/ubi0
Running io_update /dev/ubi0
Running io_paral /dev/ubi0
Running volrefcnt /dev/ubi0
SUCCESS

- nandsim: Toshiba NAND 128MiB 1,8V 8-bit without subpage support
zynq> modprobe nandsim do_delays=1 subpage=0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
nand: device found, Manufacturer ID: 0x98, Chip ID: 0x39
nand: Toshiba NAND 128MiB 1,8V 8-bit
nand: 128 MiB, SLC, erase size: 16 KiB, page size: 512, OOB size: 16
flash size: 128 MiB
page size: 512 bytes
OOB area size: 16 bytes
sector size: 16 KiB
pages number: 262144
pages per sector: 32
bus width: 8
bits in sector size: 14
bits in page size: 9
bits in OOB size: 4
flash size with OOB: 135168 KiB
page address bytes: 4
sector address bytes: 3
options: 0x42
Scanning device for bad blocks
Creating 1 MTD partitions on "NAND 128MiB 1,8V 8-bit":
0x000000000000-0x000008000000 : "NAND simulator partition 0"

zynq> ./mnt/mtd-utils/ubiattach -m 0
ubi0: attaching mtd0
ubi0: scanning is finished
ubi0: empty MTD device detected
ubi0: attached mtd0 (name "NAND 128MiB 1,8V 8-bit", size 128 MiB)
ubi0: PEB size: 16384 bytes (16 KiB), LEB size: 15360 bytes
ubi0: min./max. I/O unit sizes: 512/512, sub-page size 512
ubi0: VID header offset: 512 (aligned 512), data offset: 1024
ubi0: good PEBs: 8192, bad PEBs: 0, corrupted PEBs: 0
ubi0: user volume: 0, internal volumes: 1, max. volumes count: 89
ubi0: max/mean erase counter: 0/0, WL threshold: 4096, image sequence number: 1430177206
ubi0: available PEBs: 8028, total reserved PEBs: 164, PEBs reserved for bad PEB handling: 160
ubi0: background thread "ubi_bgt0d" started, PID 93
UBI device number 0, total 8192 LEBs (125829120 bytes, 120.0 MiB), available 8028 LEBs (123310080 bytes, 117.5 MiB), LEB size 15360 bytes (15.0 KiB)

zynq> ./mnt/mtd-utils/tests/ubi-tests/runubitests.sh /dev/ubi0
Running mkvol_basic /dev/ubi0
Running mkvol_bad /dev/ubi0
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    -2
        alignment 1
        bytes     123310080
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    89
        alignment 1
        bytes     123310080
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 0
        bytes     123310080
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment -1
        bytes     123310080
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 15361
        bytes     123310080
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 513
        bytes     123310080
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     -1
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     0
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: not enough PEBs, only 8028 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_create_volume: not enough PEBs, only 8028 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     15360
        vol_type  7
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: volume 0 already exists
ubi0 error: ubi_create_volume: cannot create volume 0, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_open_volume: cannot open device 0, volume 89, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume -1, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 89, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19Running mkvol_paral /dev/ubi0
Running rsvol /dev/ubi0
Running io_basic /dev/ubi0
Running io_read /dev/ubi0
Running io_update /dev/ubi0
Running io_paral /dev/ubi0
Running volrefcnt /dev/ubi0
SUCCESS

- nandsim: Toshiba NAND 128MiB 1,8V 8-bit with subpage support
zynq> modprobe nandsim do_delays=1 subpage=1
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
nand: device found, Manufacturer ID: 0x98, Chip ID: 0x39
nand: Toshiba NAND 128MiB 1,8V 8-bit
nand: 128 MiB, SLC, erase size: 16 KiB, page size: 512, OOB size: 16
flash size: 128 MiB
page size: 512 bytes
OOB area size: 16 bytes
sector size: 16 KiB
pages number: 262144
pages per sector: 32
bus width: 8
bits in sector size: 14
bits in page size: 9
bits in OOB size: 4
flash size with OOB: 135168 KiB
page address bytes: 4
sector address bytes: 3
options: 0x42
Scanning device for bad blocks
Creating 1 MTD partitions on "NAND 128MiB 1,8V 8-bit":
0x000000000000-0x000008000000 : "NAND simulator partition 0"

zynq> ./mnt/mtd-utils/ubiattach -m 0
ubi0: attaching mtd0
ubi0: scanning is finished
ubi0: empty MTD device detected
ubi0: attached mtd0 (name "NAND 128MiB 1,8V 8-bit", size 128 MiB)
ubi0: PEB size: 16384 bytes (16 KiB), LEB size: 15872 bytes
ubi0: min./max. I/O unit sizes: 512/512, sub-page size 256
ubi0: VID header offset: 256 (aligned 256), data offset: 512
ubi0: good PEBs: 8192, bad PEBs: 0, corrupted PEBs: 0
ubi0: user volume: 0, internal volumes: 1, max. volumes count: 92
ubi0: max/mean erase counter: 0/0, WL threshold: 4096, image sequence number: 1169990024
ubi0: available PEBs: 8028, total reserved PEBs: 164, PEBs reserved for bad PEB handling: 160
ubi0: background thread "ubi_bgt0d" started, PID 94
UBI device number 0, total 8192 LEBs (130023424 bytes, 124.0 MiB), available 8028 LEBs (127420416 bytes, 121.5 MiB), LEB size 15872 bytes (15.5 KiB)

zynq> ./mnt/mtd-utils/tests/ubi-tests/runubitests.sh /dev/ubi0
Running mkvol_basic /dev/ubi0
Running mkvol_bad /dev/ubi0
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    -2
        alignment 1
        bytes     127420416
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    92
        alignment 1
        bytes     127420416
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 0
        bytes     127420416
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment -1
        bytes     127420416
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 15873
        bytes     127420416
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 513
        bytes     127420416
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     -1
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     0
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: not enough PEBs, only 8028 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_create_volume: not enough PEBs, only 8028 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     15872
        vol_type  7
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: volume 0 already exists
ubi0 error: ubi_create_volume: cannot create volume 0, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_open_volume: cannot open device 0, volume 92, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume -1, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 92, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19
Running mkvol_paral /dev/ubi0
Running rsvol /dev/ubi0
Running io_basic /dev/ubi0
Running io_read /dev/ubi0
Running io_update /dev/ubi0
Running io_paral /dev/ubi0
Running volrefcnt /dev/ubi0
SUCCESS

- nandsim: Micron NAND 256MiB 3,3V 8-bit without subpage support
zynq> modprobe nandsim do_delays=1 subpage=0 first_id_byte=0x2C second
_id_byte=0xDA third_id_byte=0x90 fourth_id_byte=0x95
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
nand: Micron NAND 256MiB 3,3V 8-bit
nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
flash size: 256 MiB
page size: 2048 bytes
OOB area size: 64 bytes
sector size: 128 KiB
pages number: 131072
pages per sector: 64
bus width: 8
bits in sector size: 17
bits in page size: 11
bits in OOB size: 6
flash size with OOB: 270336 KiB
page address bytes: 5
sector address bytes: 3
options: 0x8
Scanning device for bad blocks
Creating 1 MTD partitions on "NAND 256MiB 3,3V 8-bit":
0x000000000000-0x000010000000 : "NAND simulator partition 0"

zynq> ./mnt/mtd-utils/ubiattach -m 0
ubi0: attaching mtd0
ubi0: scanning is finished
ubi0: empty MTD device detected
ubi0: attached mtd0 (name "NAND 256MiB 3,3V 8-bit", size 256 MiB)
ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 bytes
ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
ubi0: VID header offset: 2048 (aligned 2048), data offset: 4096
ubi0: good PEBs: 2048, bad PEBs: 0, corrupted PEBs: 0
ubi0: user volume: 0, internal volumes: 1, max. volumes count: 128
ubi0: max/mean erase counter: 0/0, WL threshold: 4096, image sequence number: 61027497
ubi0: available PEBs: 2004, total reserved PEBs: 44, PEBs reserved for bad PEB handling: 40
ubi0: background thread "ubi_bgt0d" started, PID 95
UBI device number 0, total 2048 LEBs (260046848 bytes, 248.0 MiB), available 2004 LEBs (254459904 bytes, 242.6 MiB), LEB size 126976 bytes (124.0 KiB)

zynq> ./mnt/mtd-utils/tests/ubi-tests/runubitests.sh /dev/ubi0
Running mkvol_basic /dev/ubi0
Running mkvol_bad /dev/ubi0
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    -2
        alignment 1
        bytes     123310080
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    89
        alignment 1
        bytes     123310080
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 0
        bytes     123310080
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment -1
        bytes     123310080
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 15361
        bytes     123310080
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 513
        bytes     123310080
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     -1
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     0
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: not enough PEBs, only 8028 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_create_volume: not enough PEBs, only 8028 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     15360
        vol_type  7
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: volume 0 already exists
ubi0 error: ubi_create_volume: cannot create volume 0, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_open_volume: cannot open device 0, volume 89, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume -1, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 89, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19
Running mkvol_paral /dev/ubi0
Running rsvol /dev/ubi0
Running io_basic /dev/ubi0
Running io_read /dev/ubi0
Running io_update /dev/ubi0
Running io_paral /dev/ubi0
Running volrefcnt /dev/ubi0
SUCCESS

- nandsim: Micron NAND 256MiB 3,3V 8-bit with subpage support
zynq>  modprobe nandsim do_delays=1 subpage=1 first_id_byte=0x2C second
_id_byte=0xDA third_id_byte=0x90 fourth_id_byte=0x95
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
nand: Micron NAND 256MiB 3,3V 8-bit
nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
flash size: 256 MiB
page size: 2048 bytes
OOB area size: 64 bytes
sector size: 128 KiB
pages number: 131072
pages per sector: 64
bus width: 8
bits in sector size: 17
bits in page size: 11
bits in OOB size: 6
flash size with OOB: 270336 KiB
page address bytes: 5
sector address bytes: 3
options: 0x8
Scanning device for bad blocks
Creating 1 MTD partitions on "NAND 256MiB 3,3V 8-bit":
0x000000000000-0x000010000000 : "NAND simulator partition 0"

zynq> ./mnt/mtd-utils/ubiattach -m 0
ubi0: attaching mtd0
ubi0: scanning is finished
ubi0: empty MTD device detected
ubi0: attached mtd0 (name "NAND 128MiB 1,8V 8-bit", size 128 MiB)
ubi0: PEB size: 16384 bytes (16 KiB), LEB size: 15872 bytes
ubi0: min./max. I/O unit sizes: 512/512, sub-page size 256
ubi0: VID header offset: 256 (aligned 256), data offset: 512
ubi0: good PEBs: 8192, bad PEBs: 0, corrupted PEBs: 0
ubi0: user volume: 0, internal volumes: 1, max. volumes count: 92
ubi0: max/mean erase counter: 0/0, WL threshold: 4096, image sequence number: 1784788311
ubi0: available PEBs: 8028, total reserved PEBs: 164, PEBs reserved for bad PEB handling: 160
ubi0: background thread "ubi_bgt0d" started, PID 93
UBI device number 0, total 8192 LEBs (130023424 bytes, 124.0 MiB), available 8028 LEBs (127420416 bytes, 121.5 MiB), LEB size 15872 bytes (15.5 KiB)

zynq> ./mnt/mtd-utils/tests/ubi-tests/runubitests.sh /dev/ubi0
Running mkvol_basic /dev/ubi0
Running mkvol_bad /dev/ubi0
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    -2
        alignment 1
        bytes     127420416
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    92
        alignment 1
        bytes     127420416
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 0
        bytes     127420416
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment -1
        bytes     127420416
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 15873
        bytes     127420416
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 513
        bytes     127420416
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     -1
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     0
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: not enough PEBs, only 8028 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_create_volume: not enough PEBs, only 8028 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     15872
        vol_type  7
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: volume 0 already exists
ubi0 error: ubi_create_volume: cannot create volume 0, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_open_volume: cannot open device 0, volume 92, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume -1, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 92, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19
Running mkvol_paral /dev/ubi0
Running rsvol /dev/ubi0
Running io_basic /dev/ubi0
Running io_read /dev/ubi0
Running io_update /dev/ubi0
Running io_paral /dev/ubi0
Running volrefcnt /dev/ubi0
SUCCESS

- nandsim: Toshiba NAND 512MiB 3,3V 8-bit without subpage support
zynq> modprobe nandsim do_delays=1 subpage=0 first_id_byte=0x98 second
_id_byte=0xdc third_id_byte=0x91 fourth_id_byte=0x15
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
nand: device found, Manufacturer ID: 0x98, Chip ID: 0xdc
nand: Toshiba NAND 512MiB 3,3V 8-bit
nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
flash size: 512 MiB
page size: 2048 bytes
OOB area size: 64 bytes
sector size: 128 KiB
pages number: 262144
pages per sector: 64
bus width: 8
bits in sector size: 17
bits in page size: 11
bits in OOB size: 6
flash size with OOB: 540672 KiB
page address bytes: 5
sector address bytes: 3
options: 0x8
Scanning device for bad blocks
Creating 1 MTD partitions on "NAND 512MiB 3,3V 8-bit":
0x000000000000-0x000020000000 : "NAND simulator partition 0"

zynq> ./mnt/mtd-utils/ubiattach -m 0
ubi0: attaching mtd0
ubi0: scanning is finished
ubi0: empty MTD device detected
ubi0: attached mtd0 (name "NAND 512MiB 3,3V 8-bit", size 512 MiB)
ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 bytes
ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
ubi0: VID header offset: 2048 (aligned 2048), data offset: 4096
ubi0: good PEBs: 4096, bad PEBs: 0, corrupted PEBs: 0
ubi0: user volume: 0, internal volumes: 1, max. volumes count: 128
ubi0: max/mean erase counter: 0/0, WL threshold: 4096, image sequence number: 412901883
ubi0: available PEBs: 4012, total reserved PEBs: 84, PEBs reserved for bad PEB handling: 80
ubi0: background thread "ubi_bgt0d" started, PID 93
UBI device number 0, total 4096 LEBs (520093696 bytes, 496.0 MiB), available 4012 LEBs (509427712 bytes, 485.8 MiB), LEB size 126976 bytes (124.0 KiB)

zynq> ./mnt/mtd-utils/tests/ubi-tests/runubitests.sh /dev/ubi0
Running mkvol_basic /dev/ubi0
Running mkvol_bad /dev/ubi0
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    -2
        alignment 1
        bytes     509427712
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    128
        alignment 1
        bytes     509427712
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 0
        bytes     509427712
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment -1
        bytes     509427712
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 126977
        bytes     509427712
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 2049
        bytes     509427712
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     -1
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     0
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: not enough PEBs, only 4012 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_create_volume: not enough PEBs, only 4012 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     126976
        vol_type  7
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: volume 0 already exists
ubi0 error: ubi_create_volume: cannot create volume 0, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_open_volume: cannot open device 0, volume 128, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume -1, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 128, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19
Running mkvol_paral /dev/ubi0
Running rsvol /dev/ubi0
Running io_basic /dev/ubi0
Running io_read /dev/ubi0
Running io_update /dev/ubi0
Running io_paral /dev/ubi0
Running volrefcnt /dev/ubi0
SUCCESS

- nandsim: Toshiba NAND 512MiB 3,3V 8-bit with subpage support
zynq> modprobe nandsim do_delays=1 subpage=1 first_id_byte=0x98 second
_id_byte=0xdc third_id_byte=0x91 fourth_id_byte=0x15
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
nand: device found, Manufacturer ID: 0x98, Chip ID: 0xdc
nand: Toshiba NAND 512MiB 3,3V 8-bit
nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
flash size: 512 MiB
page size: 2048 bytes
OOB area size: 64 bytes
sector size: 128 KiB
pages number: 262144
pages per sector: 64
bus width: 8
bits in sector size: 17
bits in page size: 11
bits in OOB size: 6
flash size with OOB: 540672 KiB
page address bytes: 5
sector address bytes: 3
options: 0x8
Scanning device for bad blocks
Creating 1 MTD partitions on "NAND 512MiB 3,3V 8-bit":
0x000000000000-0x000020000000 : "NAND simulator partition 0"

zynq> ./mnt/mtd-utils/ubiattach -m 0
ubi0: attaching mtd0
ubi0: scanning is finished
ubi0: empty MTD device detected
ubi0: attached mtd0 (name "NAND 512MiB 3,3V 8-bit", size 512 MiB)
ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 129024 bytes
ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 512
ubi0: VID header offset: 512 (aligned 512), data offset: 2048
ubi0: good PEBs: 4096, bad PEBs: 0, corrupted PEBs: 0
ubi0: user volume: 0, internal volumes: 1, max. volumes count: 128
ubi0: max/mean erase counter: 0/0, WL threshold: 4096, image sequence number: 1235604384
ubi0: available PEBs: 4012, total reserved PEBs: 84, PEBs reserved for bad PEB handling: 80
ubi0: background thread "ubi_bgt0d" started, PID 96
UBI device number 0, total 4096 LEBs (528482304 bytes, 504.0 MiB), available 4012 LEBs (517644288 bytes, 493.6 MiB), LEB size 129024 bytes (126.0 KiB)

zynq> ./mnt/mtd-utils/tests/ubi-tests/runubitests.sh /dev/ubi0
Running mkvol_basic /dev/ubi0
Running mkvol_bad /dev/ubi0
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    -2
        alignment 1
        bytes     517644288
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    128
        alignment 1
        bytes     517644288
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 0
        bytes     517644288
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment -1
        bytes     517644288
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 129025
        bytes     517644288
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 2049
        bytes     517644288
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     -1
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     0
        vol_type  3
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: not enough PEBs, only 4012 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_create_volume: not enough PEBs, only 4012 available
ubi0 error: ubi_create_volume: cannot create volume 0, error -28
ubi0 error: ubi_cdev_ioctl: bad volume creation request
Volume creation request dump:
        vol_id    0
        alignment 1
        bytes     129024
        vol_type  7
        name_len  22
        1st 16 characters of name: mkvol_bad:test_m
ubi0 error: ubi_create_volume: volume 0 already exists
ubi0 error: ubi_create_volume: cannot create volume 0, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_create_volume: volume "mkvol_bad:test_mkvol()" exists (ID 0)
ubi0 error: ubi_create_volume: cannot create volume 1, error -17
ubi0 error: ubi_open_volume: cannot open device 0, volume 128, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume -1, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 128, error -22
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19
ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -19
Running mkvol_paral /dev/ubi0
Running rsvol /dev/ubi0
Running io_basic /dev/ubi0
Running io_read /dev/ubi0
Running io_update /dev/ubi0
Running io_paral /dev/ubi0
Running volrefcnt /dev/ubi0
SUCCESS

Cheng Ming Lin (1):
  mtd: ubi: skip programming unused bits in ubi headers

 drivers/mtd/ubi/io.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.25.1


