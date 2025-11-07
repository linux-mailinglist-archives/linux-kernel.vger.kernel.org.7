Return-Path: <linux-kernel+bounces-890443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 462E6C4011E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09893B2B3B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C88290D81;
	Fri,  7 Nov 2025 13:19:46 +0000 (UTC)
Received: from mail-m19731116.qiye.163.com (mail-m19731116.qiye.163.com [220.197.31.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B38B27AC31
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521586; cv=none; b=AedL9GckReyrpfM1Nb7QeYLZFS+aZparUwgAPtHcwD/YjtNRczHVZ6O4Flr+CgkAXMlLe1GHdJR+hSKcm54uqVqI69J+3KLHQjnkQafeZ49frqY7hNyYD2HO73n31hiG7NzvACCqPVt2njF/NYXrXJyRo1v4EPK+r6Su4+0Q3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521586; c=relaxed/simple;
	bh=GFrhyFs7hYtqLxbw2uhN+QJfUrdtqrVfhsgCP3ZvLN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdYezqXUL/8bZ53DnW7y/sP2hWRHCwR++CuHzt9qJ2Ich4l9uA6Y384plnOs1AXq0noZPgSqUs1bGnDI7oA36VCERyf3roVZbTsjt50Ed1qypFY1jW4A3QYYIL0kej1Tz+Ip5Op0Ivcdy53Wh6U+UNPLRpVtjSqo2rSS5MWTvKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; arc=none smtp.client-ip=220.197.31.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Received: from localhost.localdomain (unknown [122.224.147.158])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28c500960;
	Fri, 7 Nov 2025 16:43:33 +0800 (GMT+08:00)
From: Shouping Wang <allen.wang@hj-micro.com>
To: will@kernel.org,
	robin.murphy@arm.com
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	allen.wang@hj-micro.com,
	andy.xu@hj-micro.com,
	peter.du@hj-micro.com
Subject: [PATCH 1/2] perf/arm-ni: rename PMU device name
Date: Fri,  7 Nov 2025 16:43:18 +0800
Message-ID: <20251107084320.555979-2-allen.wang@hj-micro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107084320.555979-1-allen.wang@hj-micro.com>
References: <20251107084320.555979-1-allen.wang@hj-micro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a5d7c37ed09d9kunm533ae5d212b2dd2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHx8dVkIeHxpOQhpPTEJLSFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUpPTFVKTkNZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++

The PMU device names are arm_ni_1_*,arm_ni_2_*, etc. 
The device names change based on the order of registration 
for multiple NI instances. By naming the PMU device using 
its address, the device name can be made independent of 
the registration order.

Signed-off-by: Shouping Wang <allen.wang@hj-micro.com>
---
 drivers/perf/arm-ni.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index 1615a0564031..32eabdbe877a 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -53,6 +53,7 @@
 
 #define NI_NUM_COUNTERS		8
 #define NI_CCNT_IDX		31
+#define NI_PMU_PA_SHIFT		12
 
 /* Event attributes */
 #define NI_CONFIG_TYPE		GENMASK_ULL(15, 0)
@@ -115,7 +116,6 @@ struct arm_ni {
 	struct device *dev;
 	void __iomem *base;
 	enum ni_part part;
-	int id;
 	int cpu;
 	int num_cds;
 	struct hlist_node cpuhp_node;
@@ -560,7 +560,7 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
 		.read = arm_ni_event_read,
 	};
 
-	name = devm_kasprintf(ni->dev, GFP_KERNEL, "arm_ni_%d_cd_%d", ni->id, cd->id);
+	name = devm_kasprintf(ni->dev, GFP_KERNEL, "arm_ni_%llx", res_start >> NI_PMU_PA_SHIFT);
 	if (!name)
 		return -ENOMEM;
 
@@ -623,7 +623,6 @@ static int arm_ni_probe(struct platform_device *pdev)
 	struct arm_ni *ni;
 	struct resource *res;
 	void __iomem *base;
-	static atomic_t id;
 	int ret, num_cds;
 	u32 reg, part;
 
@@ -674,7 +673,6 @@ static int arm_ni_probe(struct platform_device *pdev)
 	ni->base = base;
 	ni->num_cds = num_cds;
 	ni->part = part;
-	ni->id = atomic_fetch_inc(&id);
 	ni->cpu = cpumask_local_spread(0, dev_to_node(ni->dev));
 	platform_set_drvdata(pdev, ni);
 
-- 
2.43.0


