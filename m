Return-Path: <linux-kernel+bounces-585956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D18A7998A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 03:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D591704C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 01:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E895339D;
	Thu,  3 Apr 2025 01:06:13 +0000 (UTC)
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A728D530
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 01:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743642373; cv=none; b=l5W7Bd6BFadVs7ikMXQ8MBBs6XaOUMtAHOb8Q2QtuxZGXLesuGzVIrmDZ1vYf/o0UU490wzS8O3nB6yqC1e3ktwbwmJ/Hq9FUdcxweHhApEAVB9ADkVhPpcVLAcBiDYgCYh9ZeXDq34Hk5pfYIvDnUoMfaDCoyTBT6cViK83omM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743642373; c=relaxed/simple;
	bh=DPjNaJwGYIut3lVEtU1MEzbkoWxtgz7SV3Az7K0Q3eU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Xlc0s99We/DZIRg0QxWpucys5hfhqsrqj2KWyQPPIMIhe2Q/qeUHb5UC2KYoOm6gI13ndjwWy/qw0tA/0v1DrANN4xuJjnujcq9pLQOpoGwZHU6OXmkrpsljH59cjK2y9ns6y7uTibU/hh9PH8FJbYRK7xeRBjePX16uGRlAGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
	by 156.147.23.51 with ESMTP; 3 Apr 2025 09:36:07 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
	by 156.147.1.125 with ESMTP; 3 Apr 2025 09:36:07 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From: Chanho Min <chanho.min@lge.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sven <dm-devel@schwermer.no>,
	Neil Brown <neilb@suse.de>,
	hch@lst.de,
	dm-devel@lists.linux.dev,
	Gunho Lee <gunho.lee@lge.com>,
	Chanho Min <chanho.min@lge.com>
Subject: [PATCH] block: remove non-existent partition dev_t return from blk_lookup_devt
Date: Thu,  3 Apr 2025 09:35:32 +0900
Message-Id: <20250403003532.412-1-chanho.min@lge.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

We encountered frequent boot failures while setting up a dm-verity rootfs with
the following configuration, and found that this issue had been reported
previously:

  root=/dev/dm-0
  dm-mod.waitfor=/dev/mmcblk0p23

The error observed was:

  device-mapper: table: 254:0: verity: Data device lookup failed (-ENXIO)
  device-mapper: ioctl: error adding target to table

Bisecting the issue revealed that this was a latent problem exacerbated by
commit 238d991f054a ("dm: use fsleep() instead of msleep() for deterministic
sleep duration"), after which the failures became more frequent. Further
investigation pinpointed the root cause to a special case added in
blk_lookup_devt() by commit 41b8c853a495 ("block: fix booting from partitioned
md array")

This commit modified blk_lookup_devt() to return a dev_t for non-existent
partitions to support MD RAID booting when partitions are not yet available,
e.g., for root=/dev/md_d0p1. While this addressed the MD issue, it deviates
from the expected role of blk_lookup_devt(), which should return a dev_t only
for existing block devices. Adding MD-specific logic to a common block layer
function was a suboptimal approach, as it compromises the function's clarity
and causes side effects, such as the dm-init failures seen with dm-verity.

The MD RAID booting issue should ideally have been handled within the MD
driver or boot logic (e.g., via a dedicated md_lookup_devt() function) rather
than modifying a generic lookup function. This patch removes the non-existent
partition dev_t return logic, restoring blk_lookup_devt() to its intended
purpose. This resolves the dm-verity boot failures by ensuring accurate dev_t
returns.

If MD RAID booting still depends on this behavior in some setups, a regression
may occur. In that case, the MD subsystem should implement a proper solution
(e.g., specific lookup function) rather than relying on this workaround.
Testers are encouraged to verify MD RAID booting with partitioned root devices
(e.g., root=/dev/md_d0p1) to confirm.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 block/early-lookup.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/block/early-lookup.c b/block/early-lookup.c
index 3fb57f7d2b127..3764dfb429c54 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -134,17 +134,9 @@ static dev_t __init blk_lookup_devt(const char *name, int partno)
 		if (strcmp(dev_name(dev), name))
 			continue;
 
-		if (partno < disk->minors) {
-			/* We need to return the right devno, even
-			 * if the partition doesn't exist yet.
-			 */
-			devt = MKDEV(MAJOR(dev->devt),
-				     MINOR(dev->devt) + partno);
-		} else {
-			devt = part_devt(disk, partno);
-			if (devt)
-				break;
-		}
+		devt = part_devt(disk, partno);
+		if (devt)
+			break;
 	}
 	class_dev_iter_exit(&iter);
 	return devt;
-- 
2.17.1


