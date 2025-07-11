Return-Path: <linux-kernel+bounces-728133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B107B023ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F45B47E56
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBE92F5475;
	Fri, 11 Jul 2025 18:37:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA322F5466
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259072; cv=none; b=OeU4QVDl6zXzFccQxWBzwGUeJaEysa3v/reLlIXNFt9OoPnY1vZM5VWXkYQEPUUUV/7LzESmKdQEWlwUHdf2SPz9fk6rf0FMo5VQdKXQXKRGP59OHBznRDvdTgqM9ecB6tSn3KoVBG3NsTfqOlSNpo7FLvjomzCZwp4Mnm0a8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259072; c=relaxed/simple;
	bh=BLdFERIskXXwtASjTDYJQcmyxahO7w3ejsvgTwN2m1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UYkbQzVzhG/wSa8nwdEEnMZrHajBm6u0GMGVpI7cH3wZoXJYAbRSdPNyiczWcDvd5IngtVkwZ7jyQJ0Az+5l0xLtSNmpYTjoZgpCv3U7THkBUq/YD5XF7RviYEsMX4ztGuxpq0d0yvnxeDbbISVsmFC/mZXZ2urrDYs4vyl00CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CEFD16F8;
	Fri, 11 Jul 2025 11:37:39 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE0033F694;
	Fri, 11 Jul 2025 11:37:46 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Ben Horgan <ben.horgan@arm.com>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Zeng Heng <zengheng4@huawei.com>,
	Lecopzer Chen <lecopzerc@nvidia.com>,
	Carl Worth <carl@os.amperecomputing.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	James Morse <james.morse@arm.com>
Subject: [RFC PATCH 14/36] arm_mpam: Add support for memory controller MSC on DT platforms
Date: Fri, 11 Jul 2025 18:36:26 +0000
Message-Id: <20250711183648.30766-15-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250711183648.30766-1-james.morse@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shanker Donthineni <sdonthineni@nvidia.com>

The device-tree binding has two examples for MSC associated with
memory controllers. Add the support to discover the component_id
from the device-tree and create 'memory' RIS.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
[ morse: split out of a bigger patch, added affinity piece ]
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c | 67 +++++++++++++++-------
 1 file changed, 47 insertions(+), 20 deletions(-)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index 5b886ba54ba8..f5abd5f0d41a 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -60,41 +60,63 @@ static int mpam_dt_parse_resource(struct mpam_msc *msc, struct device_node *np,
 				  u32 ris_idx)
 {
 	int err = 0;
-	u32 level = 0;
-	unsigned long cache_id;
-	struct device_node *cache;
+	u32 class_id = 0, component_id = 0;
+	struct device_node *cache = NULL, *memory = NULL;
+	enum mpam_class_types type = MPAM_CLASS_UNKNOWN;
 
 	do {
+		/* What kind of MSC is this? */
 		if (of_device_is_compatible(np, "arm,mpam-cache")) {
 			cache = of_parse_phandle(np, "arm,mpam-device", 0);
 			if (!cache) {
 				pr_err("Failed to read phandle\n");
 				break;
 			}
+			type = MPAM_CLASS_CACHE;
 		} else if (of_device_is_compatible(np->parent, "cache")) {
 			cache = of_node_get(np->parent);
+			type = MPAM_CLASS_CACHE;
+		} else if (of_device_is_compatible(np, "arm,mpam-memory")) {
+			memory = of_parse_phandle(np, "arm,mpam-device", 0);
+			if (!memory) {
+				pr_err("Failed to read phandle\n");
+				break;
+			}
+			type = MPAM_CLASS_MEMORY;
+		} else if (of_device_is_compatible(np, "arm,mpam-memory-controller-msc")) {
+			memory = of_node_get(np->parent);
+			type = MPAM_CLASS_MEMORY;
 		} else {
-			/* For now, only caches are supported */
-			cache = NULL;
+			/*
+			 * For now, only caches and memory controllers are
+			 * supported.
+			 */
 			break;
 		}
 
-		err = of_property_read_u32(cache, "cache-level", &level);
-		if (err) {
-			pr_err("Failed to read cache-level\n");
-			break;
-		}
-
-		cache_id = cache_of_calculate_id(cache);
-		if (cache_id == ~0UL) {
-			err = -ENOENT;
-			break;
+		/* Determine the class and component ids, based on type. */
+		if (type == MPAM_CLASS_CACHE) {
+			err = of_property_read_u32(cache, "cache-level", &class_id);
+			if (err) {
+				pr_err("Failed to read cache-level\n");
+				break;
+			}
+			component_id = cache_of_calculate_id(cache);
+			if (component_id == ~0UL) {
+				err = -ENOENT;
+				break;
+			}
+		} else if (type == MPAM_CLASS_MEMORY) {
+			err = of_node_to_nid(np);
+			component_id = (err == NUMA_NO_NODE) ? 0 : err;
+			class_id = 255;
 		}
 
-		err = mpam_ris_create(msc, ris_idx, MPAM_CLASS_CACHE, level,
-				      cache_id);
+		err = mpam_ris_create(msc, ris_idx, type, class_id,
+				      component_id);
 	} while (0);
 	of_node_put(cache);
+	of_node_put(memory);
 
 	return err;
 }
@@ -157,9 +179,14 @@ static int update_msc_accessibility(struct mpam_msc *msc)
 		cpumask_copy(&msc->accessibility, cpu_possible_mask);
 		err = 0;
 	} else {
-		err = -EINVAL;
-		pr_err("Cannot determine accessibility of MSC: %s\n",
-		       dev_name(&msc->pdev->dev));
+		if (of_device_is_compatible(parent, "memory")) {
+			cpumask_copy(&msc->accessibility, cpu_possible_mask);
+			err = 0;
+		} else {
+			err = -EINVAL;
+			pr_err("Cannot determine accessibility of MSC: %s\n",
+			       dev_name(&msc->pdev->dev));
+		}
 	}
 	of_node_put(parent);
 
-- 
2.39.5


