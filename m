Return-Path: <linux-kernel+bounces-761048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A47B1F3BD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADAD18C334F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A4027FB15;
	Sat,  9 Aug 2025 09:29:05 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181691C2324
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754731744; cv=none; b=DyvwlrdiUnhgyivw5/UNlk8vud/Z+Vc7uVqMuAqJf2SaDga3DIVRDxbIwPge7eR5F8GsfGe8hnwp7eulRaqgF8jg7RiEZmZfZX3gzoWZo+yZqQ/WYS/W5xQNsIfYph5cMXgZ2ZmGHpKB8UZKZ0h1BMb+h2fJN7gYdAH7T3CpjlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754731744; c=relaxed/simple;
	bh=mtKp7k78At0Nke+v7N6Xy/XEEeiX3STC+r/o0e/YvHE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YjLwdl29Oi0JuVa3uOOOHKolt4y+Y384N/BD+aQt1i9St0RfHCM6YF6ATrmuafwObdW8bUC0aW+uLpKb8PtX1QflB/1t4AvIksp5mG3zgfBXOH3LYEFeMLc/qtvw/+GiIP2bI8FaNF4EOs7K8rvO0+677FemYwDC7xBHo4zb4lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bzbCq1y0rztT4X;
	Sat,  9 Aug 2025 17:27:51 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 30098180B64;
	Sat,  9 Aug 2025 17:28:52 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 9 Aug
 2025 17:28:51 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <maz@kernel.org>, <lpieralisi@kernel.org>, <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH -next] irqchip/gic-v5: Improve the SPI alloc efficiency
Date: Sat, 9 Aug 2025 17:29:20 +0800
Message-ID: <20250809092920.3765609-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)

If the GICv5 system has a large number of PEs and IRS components,
traversing the linked list to find the irs_data corresponding
to a specific SPI interrupt will be very slow.

Since the maximum number of IRS nodes, the minimum and maximum SPI
interrupt numbers for each IRS is known during the initialization
of the IRS nodes, sort the IRS nodes by interrupt number at
the initial stage. This way, when allocating SPI interrupts, we can
directly perform a binary search on the irs_data
using the SPI interrupt number with O(log N) complexity.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/irqchip/irq-gic-v5-irs.c   | 83 +++++++++++++++++++++---------
 include/linux/irqchip/arm-gic-v5.h |  2 +
 2 files changed, 61 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
index f845415f9143..41ddfd3c85de 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -8,6 +8,7 @@
 #include <linux/log2.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/sort.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v5.h>
@@ -22,7 +23,7 @@
 #define IRS_FLAGS_NON_COHERENT		BIT(0)
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct gicv5_irs_chip_data *, per_cpu_irs_data);
-static LIST_HEAD(irs_nodes);
+static struct gicv5_irs_chip_data **irs_nodes;
 
 static u32 irs_readl_relaxed(struct gicv5_irs_chip_data *irs_data,
 			     const u32 reg_offset)
@@ -382,17 +383,18 @@ int gicv5_irs_cpu_to_iaffid(int cpuid, u16 *iaffid)
 
 struct gicv5_irs_chip_data *gicv5_irs_lookup_by_spi_id(u32 spi_id)
 {
-	struct gicv5_irs_chip_data *irs_data;
-	u32 min, max;
+	int l = 0, r = gicv5_global_data.irs_count - 1;
 
-	list_for_each_entry(irs_data, &irs_nodes, entry) {
-		if (!irs_data->spi_range)
-			continue;
+	while (l <= r) {
+		int m = (l + r) >> 1;
 
-		min = irs_data->spi_min;
-		max = irs_data->spi_min + irs_data->spi_range - 1;
-		if (spi_id >= min && spi_id <= max)
-			return irs_data;
+		if (irs_nodes[m]->spi_min <= spi_id &&
+		    spi_id <= irs_nodes[m]->spi_max)
+			return irs_nodes[m];
+		else if (spi_id < irs_nodes[m]->spi_min)
+			r = m - 1;
+		else
+			l = m + 1;
 	}
 
 	return NULL;
@@ -489,7 +491,7 @@ void gicv5_irs_syncr(void)
 	struct gicv5_irs_chip_data *irs_data;
 	u32 syncr;
 
-	irs_data = list_first_entry_or_null(&irs_nodes, struct gicv5_irs_chip_data, entry);
+	irs_data = irs_nodes[0];
 	if (WARN_ON_ONCE(!irs_data))
 		return;
 
@@ -673,7 +675,7 @@ static void irs_setup_pri_bits(u32 idr1)
 	}
 }
 
-static int __init gicv5_irs_init(struct device_node *node)
+static int __init gicv5_irs_init(struct device_node *node, unsigned int *num)
 {
 	struct gicv5_irs_chip_data *irs_data;
 	void __iomem *irs_base;
@@ -725,11 +727,11 @@ static int __init gicv5_irs_init(struct device_node *node)
 	irs_data->spi_range = FIELD_GET(GICV5_IRS_IDR6_SPI_IRS_RANGE, idr);
 
 	if (irs_data->spi_range) {
+		irs_data->spi_max = irs_data->spi_min + irs_data->spi_range - 1;
 		pr_info("%s detected SPI range [%u-%u]\n",
 						of_node_full_name(node),
 						irs_data->spi_min,
-						irs_data->spi_min +
-						irs_data->spi_range - 1);
+						irs_data->spi_max);
 	}
 
 	/*
@@ -737,8 +739,7 @@ static int __init gicv5_irs_init(struct device_node *node)
 	 * Global properties (iaffid_bits, global spi count) are guaranteed to
 	 * be consistent across IRSes by the architecture.
 	 */
-	if (list_empty(&irs_nodes)) {
-
+	if (*num == 0) {
 		idr = irs_readl_relaxed(irs_data, GICV5_IRS_IDR1);
 		irs_setup_pri_bits(idr);
 
@@ -752,7 +753,7 @@ static int __init gicv5_irs_init(struct device_node *node)
 		pr_debug("Detected %u SPIs globally\n", spi_count);
 	}
 
-	list_add_tail(&irs_data->entry, &irs_nodes);
+	irs_nodes[(*num)++] = irs_data;
 
 	return 0;
 
@@ -765,12 +766,14 @@ static int __init gicv5_irs_init(struct device_node *node)
 
 void __init gicv5_irs_remove(void)
 {
-	struct gicv5_irs_chip_data *irs_data, *tmp_data;
+	struct gicv5_irs_chip_data *irs_data;
+	int i;
 
 	gicv5_free_lpi_domain();
 	gicv5_deinit_lpis();
 
-	list_for_each_entry_safe(irs_data, tmp_data, &irs_nodes, entry) {
+	for (i = 0; i < gicv5_global_data.irs_count; i++) {
+		irs_data = irs_nodes[i];
 		iounmap(irs_data->irs_base);
 		list_del(&irs_data->entry);
 		kfree(irs_data);
@@ -782,8 +785,7 @@ int __init gicv5_irs_enable(void)
 	struct gicv5_irs_chip_data *irs_data;
 	int ret;
 
-	irs_data = list_first_entry_or_null(&irs_nodes,
-					    struct gicv5_irs_chip_data, entry);
+	irs_data = irs_nodes[0];
 	if (!irs_data)
 		return -ENODEV;
 
@@ -799,24 +801,57 @@ int __init gicv5_irs_enable(void)
 void __init gicv5_irs_its_probe(void)
 {
 	struct gicv5_irs_chip_data *irs_data;
+	int i;
 
-	list_for_each_entry(irs_data, &irs_nodes, entry)
+	for (i = 0; i < gicv5_global_data.irs_count; i++) {
+		irs_data = irs_nodes[i];
 		gicv5_its_of_probe(to_of_node(irs_data->fwnode));
+	}
+}
+
+static int spi_min_cmp(const void *a, const void *b)
+{
+	const struct gicv5_irs_chip_data *irs_data1 = a;
+	const struct gicv5_irs_chip_data *irs_data2 = b;
+
+	return irs_data1->spi_min - irs_data2->spi_min;
 }
 
 int __init gicv5_irs_of_probe(struct device_node *parent)
 {
+	unsigned int irs_count = 0, num = 0;
 	struct device_node *np;
 	int ret;
 
+	for_each_available_child_of_node(parent, np) {
+		if (of_device_is_compatible(np, "arm,gic-v5-irs"))
+			irs_count++;
+	}
+
+	if (irs_count == 0)
+		return -ENODEV;
+
+	irs_nodes = kcalloc(irs_count, sizeof(struct gicv5_irs_chip_data *),
+			    __GFP_ZERO);
+	if (!irs_nodes)
+		return -ENOMEM;
+
 	for_each_available_child_of_node(parent, np) {
 		if (!of_device_is_compatible(np, "arm,gic-v5-irs"))
 			continue;
 
-		ret = gicv5_irs_init(np);
+		ret = gicv5_irs_init(np, &num);
 		if (ret)
 			pr_err("Failed to init IRS %s\n", np->full_name);
 	}
 
-	return list_empty(&irs_nodes) ? -ENODEV : 0;
+	if (num == 0) {
+		kfree(irs_nodes);
+		return -ENODEV;
+	}
+
+	sort(irs_nodes, num, sizeof(struct gicv5_irs_chip_data *), spi_min_cmp, NULL);
+	gicv5_global_data.irs_count = num;
+
+	return 0;
 }
diff --git a/include/linux/irqchip/arm-gic-v5.h b/include/linux/irqchip/arm-gic-v5.h
index 68ddcdb1cec5..6661b583b8d8 100644
--- a/include/linux/irqchip/arm-gic-v5.h
+++ b/include/linux/irqchip/arm-gic-v5.h
@@ -278,6 +278,7 @@ struct gicv5_chip_data {
 	u8			cpuif_pri_bits;
 	u8			cpuif_id_bits;
 	u8			irs_pri_bits;
+	unsigned int		irs_count;
 	struct {
 		__le64 *l1ist_addr;
 		u32 l2_size;
@@ -294,6 +295,7 @@ struct gicv5_irs_chip_data {
 	void __iomem		*irs_base;
 	u32			flags;
 	u32			spi_min;
+	u32			spi_max;
 	u32			spi_range;
 	raw_spinlock_t		spi_config_lock;
 };
-- 
2.34.1


