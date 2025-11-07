Return-Path: <linux-kernel+bounces-890036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FB3C3F1DC
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD4018829DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EEE27A900;
	Fri,  7 Nov 2025 09:19:28 +0000 (UTC)
Received: from mail-m49219.qiye.163.com (mail-m49219.qiye.163.com [45.254.49.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB92AD04
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507167; cv=none; b=DOsQ7SIM0JfzGPaGWpfEBM9MVfIyy1MgJf7PP+Wq6UkmWnds4rxSrjHAtlExtX2+nUGBPfKjnmYooRcldI0yzTtQly3wlbE4Xc8Fd236x5MMTolLKv4MCxhOSaUgKy6XlxM0uVykm0JsQaKvT4CKb5eqvmv+5E73ka0GWGqabGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507167; c=relaxed/simple;
	bh=/RmS55EMHk9CoPzX2y/JRQSYZBorkiKegha7LSqfbxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgY6oehK/Q/6PAUzfAZYCrZk7CCIHMHmoYi3wz1hRixTNEwYnEZP2pdVgGC+vsim7Wda025DqKwnsS1gcQM32UTDTiNkZuNXuka/mJv4UahD1r3ca/f8reWwDAjpQ9/eWYDxb8CORnjTVWHxNehtqYm6Lzzypw3q9HMsUVeVT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; arc=none smtp.client-ip=45.254.49.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Received: from localhost.localdomain (unknown [122.224.147.158])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28c500970;
	Fri, 7 Nov 2025 16:43:35 +0800 (GMT+08:00)
From: Shouping Wang <allen.wang@hj-micro.com>
To: will@kernel.org,
	robin.murphy@arm.com
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	allen.wang@hj-micro.com,
	andy.xu@hj-micro.com,
	peter.du@hj-micro.com
Subject: [PATCH 2/2] perf: arm-ni: add topology debug info for the clock domain
Date: Fri,  7 Nov 2025 16:43:19 +0800
Message-ID: <20251107084320.555979-3-allen.wang@hj-micro.com>
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
X-HM-Tid: 0a9a5d7c3fe709d9kunm533ae5d212b2e0c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSUhKVk1MGUkZGk9DSh9MQ1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUpPTFVKTkNZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++

When capturing PMU info with perf, it is necessary to know the nodeid of 
the interface. Here, we add topology debug info for the clock domain to 
display the nodeid of the interfaces.

$ cat /sys/kernel/debug/arm-ni/map_1f3c06
as shown below:
| HSNI #5 || PMNI #6 || PMU  #14 |

Signed-off-by: Shouping Wang <allen.wang@hj-micro.com>
---
 drivers/perf/arm-ni.c | 63 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index 32eabdbe877a..e0f0e18d0120 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -13,6 +13,7 @@
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/debugfs.h>
 
 /* Common registers */
 #define NI_NODE_TYPE		0x000
@@ -110,6 +111,7 @@ struct arm_ni_cd {
 	struct arm_ni_unit *units;
 	struct perf_event *evcnt[NI_NUM_COUNTERS];
 	struct perf_event *ccnt;
+	struct dentry *debug;
 };
 
 struct arm_ni {
@@ -476,6 +478,59 @@ static irqreturn_t arm_ni_handle_irq(int irq, void *dev_id)
 	}
 }
 
+static struct dentry *arm_ni_cd_debugfs;
+
+#ifdef CONFIG_DEBUG_FS
+static const char *arm_ni_node_type(enum ni_node_type type)
+{
+	switch (type) {
+	case NI_ASNI:
+		return "| ASNI ";
+	case NI_AMNI:
+		return "| AMNI ";
+	case NI_PMU:
+		return "| PMU  ";
+	case NI_HSNI:
+		return "| HSNI ";
+	case NI_HMNI:
+		return "| HMNI ";
+	case NI_PMNI:
+		return "| PMNI ";
+	default:
+		return "| ???? ";
+	}
+}
+
+static int arm_ni_cd_map_show(struct seq_file *s, void *data)
+{
+	struct arm_ni_cd *cd = s->private;
+
+	cd_for_each_unit(cd, unit) {
+		seq_printf(s, "%s#%-2d |", arm_ni_node_type(unit->type), unit->id);
+	}
+	seq_puts(s, "\n");
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(arm_ni_cd_map);
+
+static void arm_ni_cd_debugfs_init(struct arm_ni_cd *cd, u64 res_start)
+{
+	const char *name = "map";
+
+	if (res_start > 0)
+		name = devm_kasprintf(cd_to_ni(cd)->dev, GFP_KERNEL, "map_%llx",
+				res_start >> NI_PMU_PA_SHIFT);
+	if (!name)
+		return;
+
+	cd->debug = debugfs_create_file(name, 0444, arm_ni_cd_debugfs, cd, &arm_ni_cd_map_fops);
+}
+#else
+static void arm_ni_cd_debugfs_init(struct arm_ni_cd *cd, u64 res_start) {}
+#endif
+
 static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_start)
 {
 	struct arm_ni_cd *cd = ni->cds + node->id;
@@ -563,6 +618,7 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
 	name = devm_kasprintf(ni->dev, GFP_KERNEL, "arm_ni_%llx", res_start >> NI_PMU_PA_SHIFT);
 	if (!name)
 		return -ENOMEM;
+	arm_ni_cd_debugfs_init(cd, res_start);
 
 	return perf_pmu_register(&cd->pmu, name, -1);
 }
@@ -575,6 +631,7 @@ static void arm_ni_remove(struct platform_device *pdev)
 		writel_relaxed(0, cd->pmu_base + NI_PMCR);
 		writel_relaxed(U32_MAX, cd->pmu_base + NI_PMINTENCLR);
 		perf_pmu_unregister(&cd->pmu);
+		debugfs_remove(cd->debug);
 	}
 	cpuhp_state_remove_instance_nocalls(arm_ni_hp_state, &ni->cpuhp_node);
 }
@@ -787,9 +844,12 @@ static int __init arm_ni_init(void)
 
 	arm_ni_hp_state = ret;
 
+	arm_ni_cd_debugfs = debugfs_create_dir("arm-ni", NULL);
 	ret = platform_driver_register(&arm_ni_driver);
-	if (ret)
+	if (ret) {
 		cpuhp_remove_multi_state(arm_ni_hp_state);
+		debugfs_remove(arm_ni_cd_debugfs);
+	}
 	return ret;
 }
 
@@ -797,6 +857,7 @@ static void __exit arm_ni_exit(void)
 {
 	platform_driver_unregister(&arm_ni_driver);
 	cpuhp_remove_multi_state(arm_ni_hp_state);
+	debugfs_remove(arm_ni_cd_debugfs);
 }
 
 module_init(arm_ni_init);
-- 
2.43.0


