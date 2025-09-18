Return-Path: <linux-kernel+bounces-759914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B27EB1E46A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0BB18C19BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3AA2673A9;
	Fri,  8 Aug 2025 08:30:43 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED2122759C;
	Fri,  8 Aug 2025 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.97.181.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754641843; cv=fail; b=UaR9epy82NjU/rls0mHEef2bfKywPx90lob2HwZCA5jBoWm6rEpz4UGOnMV8S+Hjqey1DdVY1d5V4QlGG8AceepWJ9Tgk6/qID+Pemc/4XFgtfXokQxqGrC6qI+P65JojK6loG/wvyHO/QCQcRfwkFDw162mu6iuCZpn/aBu1zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754641843; c=relaxed/simple;
	bh=5WLJ58+p3nOB839ip0FHS9sWkiDYPdLautEoOOvAg5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version:MIME-Version; b=fcU9NiVRIa756Itt5MG+aIKxf7h0SvvqMfr1bhw1b7htkGCtH5vShERvjpcLGRf750xVlX3DpCBS4dg61BRSYWes6//MH20kRdbwQFvTJHKLVRH3u+1sOG7dv2QsLSk7duWmD9H22D5jQeeAtk9bTkr/vR8Wz28yQrMTZxGLeeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=fail smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD3jWGotZVoVHf9BA--.32022S2;
	Fri, 08 Aug 2025 16:30:32 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwBH0gmNtZVoag0NAA--.18908S7;
	Fri, 08 Aug 2025 16:30:13 +0800 (CST)
From: wangyuquan <wangyuquan1236@phytium.com.cn>
To: tangtao1634@phytium.com.cn,
	linux-cxl@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linuxarm@huawei.com,
	tongtiangen@huawei.com,
	Yicong Yang <yangyicong@huawei.com>,
	Niyas Sait <niyas.sait@huawei.com>,
	ajayjoshi@micron.com,
	Vandana Salve <vsalve@micron.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Gregory Price <gourry@gourry.net>,
	Huang Ying <ying.huang@intel.com>
Subject: [RFC PATCH 1/4] cxl: Register devices for CXL Hotness Monitoring Units (CHMU)
Date: Fri,  8 Aug 2025 16:29:53 +0800
Message-Id: <20241121101845.1815660-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
References: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Submitter: Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Patchwork-Id: 13881829
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6701D279D; Thu, 21 Nov 2024 10:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116; t=1732184365; cv=none; b=hvQ9NxvHX7i5aCKj6VwUrxFzi50fdYOVq2KAvaCzAth9dRUbtP7K1mxQCHhCECsd3fIFjWIKTaClR2TWWsYfbVJzQemPVGv4iQCq00gfIlk3uo8avftjGlnuwc2lgb8RKWXkPM2yyVKzNCfyv3+1/BNVnZljn3eqJw8Lrtx5EGs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116; t=1732184365; c=relaxed/simple; bh=TQhKGdns8i2TCFG83ZPwfMERNwy4IVlHhhxiOHTkbV8=; h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References: MIME-Version:Content-Type; b=jwRFoTanNYtTYUnjFw9Kv2e6n5eEVtISKCZY0ZNyrHymCj6bzLAmV/+KMPxSfBPRq15oIvz62UnxxZC7aML/rSg4TIv4E1qc+t+cLtqe4VGjNzUqo4mG2vOwp7yg/Z6okU/XCc5ey0+WDT1t803/EgzhSPDUt32Jvk6c01h4DBQ=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Received: from mail.maildlp.com (unknown [172.18.186.231]) by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvDdX6kKWz6K6Vd; Thu, 21 Nov 2024 18:15:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71]) by mail.maildlp.com (Postfix) with ESMTPS id 25ABD140AB8; Thu, 21 Nov 2024 18:19:19 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov 2024 11:19:18 +0100
X-Mailer: git-send-email 2.43.0
Precedence: bulk
MIME-Version: 1.0
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To frapeml500008.china.huawei.com (7.182.85.71)
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBH0gmNtZVoag0NAA--.18908S7
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWiU-30C6wAAsH
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3XrWDAr1ktFWrur1UWrW7Jwb_yoWxWw1rpF
	4xCay5Jr48GF97urW3Jay5ZF15W3ZY9a47CF92q34avFnrAFyDAF4UXayUAa45C3ykK3y7
	GF15KFy8Ka45ur7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Basic registration using similar approach to how the CPMUs
are registered.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/Makefile |  1 +
 drivers/cxl/core/hmu.c    | 64 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c   | 14 +++++++++
 drivers/cxl/cxl.h         |  4 +++
 drivers/cxl/cxlpci.h      |  1 +
 drivers/cxl/hmu.h         | 23 ++++++++++++++
 drivers/cxl/pci.c         | 26 +++++++++++++++-
 7 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 9259bcc6773c..d060abb773ae 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -12,6 +12,7 @@ cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
+cxl_core-y += hmu.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
diff --git a/drivers/cxl/core/hmu.c b/drivers/cxl/core/hmu.c
new file mode 100644
index 000000000000..3ee938bb6c05
--- /dev/null
+++ b/drivers/cxl/core/hmu.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Huawei. All rights reserved. */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <cxlmem.h>
+#include <hmu.h>
+#include <cxl.h>
+#include "core.h"
+
+static void cxl_hmu_release(struct device *dev)
+{
+	struct cxl_hmu *hmu = to_cxl_hmu(dev);
+
+	kfree(hmu);
+}
+
+const struct device_type cxl_hmu_type = {
+	.name = "cxl_hmu",
+	.release = cxl_hmu_release,
+};
+
+static void remove_dev(void *dev)
+{
+	device_unregister(dev);
+}
+
+int devm_cxl_hmu_add(struct device *parent, struct cxl_hmu_regs *regs,
+		     int assoc_id, int index)
+{
+	struct cxl_hmu *hmu;
+	struct device *dev;
+	int rc;
+
+	hmu = kzalloc(sizeof(*hmu), GFP_KERNEL);
+	if (!hmu)
+		return -ENOMEM;
+
+	hmu->assoc_id = assoc_id;
+	hmu->index = index;
+	hmu->base = regs->hmu;
+	dev = &hmu->dev;
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->parent = parent;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_hmu_type;
+	rc = dev_set_name(dev, "hmu_mem%d.%d", assoc_id, index);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	return devm_add_action_or_reset(parent, remove_dev, dev);
+
+err:
+	put_device(&hmu->dev);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_hmu_add, CXL);
+
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e1082e749c69..c12afaa6ef98 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -401,6 +401,20 @@ int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_map_pmu_regs, CXL);
 
+int cxl_map_hmu_regs(struct cxl_register_map *map, struct cxl_hmu_regs *regs)
+{
+	struct device *dev = map->host;
+	resource_size_t phys_addr;
+
+	phys_addr = map->resource;
+	regs->hmu = devm_cxl_iomap_block(dev, phys_addr, map->max_size);
+	if (!regs->hmu)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_map_hmu_regs, CXL);
+
 static int cxl_map_regblock(struct cxl_register_map *map)
 {
 	struct device *host = map->host;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5406e3ab3d4a..8172bc1f7a8d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -227,6 +227,9 @@ struct cxl_regs {
 	struct_group_tagged(cxl_pmu_regs, pmu_regs,
 		void __iomem *pmu;
 	);
+	struct_group_tagged(cxl_hmu_regs, hmu_regs,
+		void __iomem *hmu;
+	);
 
 	/*
 	 * RCH downstream port specific RAS register
@@ -292,6 +295,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 			   unsigned long map_mask);
 int cxl_map_device_regs(const struct cxl_register_map *map,
 			struct cxl_device_regs *regs);
+int cxl_map_hmu_regs(struct cxl_register_map *map, struct cxl_hmu_regs *regs);
 int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
 
 enum cxl_regloc_type;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 4da07727ab9c..71f5e9620137 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -67,6 +67,7 @@ enum cxl_regloc_type {
 	CXL_REGLOC_RBI_VIRT,
 	CXL_REGLOC_RBI_MEMDEV,
 	CXL_REGLOC_RBI_PMU,
+	CXL_REGLOC_RBI_HMU,
 	CXL_REGLOC_RBI_TYPES
 };
 
diff --git a/drivers/cxl/hmu.h b/drivers/cxl/hmu.h
new file mode 100644
index 000000000000..c4798ed9764b
--- /dev/null
+++ b/drivers/cxl/hmu.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright(c) 2024 Huawei
+ * CXL Specification rev 3.2 Setion 8.2.8 (CHMU Register Interface)
+ */
+#ifndef CXL_HMU_H
+#define CXL_HMU_H
+#include <linux/device.h>
+
+#define CXL_HMU_REGMAP_SIZE 0xe00 /* Table 8-32 CXL 3.0 specification */
+struct cxl_hmu {
+	struct device dev;
+	void __iomem *base;
+	int assoc_id;
+	int index;
+};
+
+#define to_cxl_hmu(dev) container_of(dev, struct cxl_hmu, dev)
+struct cxl_hmu_regs;
+int devm_cxl_hmu_add(struct device *parent, struct cxl_hmu_regs *regs,
+		     int assoc_id, int idx);
+
+#endif
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 188412d45e0d..e89ea9d3f007 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -15,6 +15,7 @@
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "cxl.h"
+#include "hmu.h"
 #include "pmu.h"
 
 /**
@@ -814,7 +815,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct cxl_dev_state *cxlds;
 	struct cxl_register_map map;
 	struct cxl_memdev *cxlmd;
-	int i, rc, pmu_count;
+	int i, rc, hmu_count, pmu_count;
 	bool irq_avail;
 
 	/*
@@ -938,6 +939,29 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		}
 	}
 
+	hmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_HMU);
+	for (i = 0; i < hmu_count; i++) {
+		struct cxl_hmu_regs hmu_regs;
+
+		rc = cxl_find_regblock_instance(pdev, CXL_REGLOC_RBI_HMU, &map, i);
+		if (rc) {
+			dev_dbg(&pdev->dev, "Could not find HMU regblock\n");
+			break;
+		}
+
+		rc = cxl_map_hmu_regs(&map, &hmu_regs);
+		if (rc) {
+			dev_dbg(&pdev->dev, "Could not map HMU regs\n");
+			break;
+		}
+
+		rc = devm_cxl_hmu_add(cxlds->dev, &hmu_regs, cxlmd->id, i);
+		if (rc) {
+			dev_dbg(&pdev->dev, "Could not add HMU instance\n");
+			break;
+		}
+	}
+
 	rc = cxl_event_config(host_bridge, mds, irq_avail);
 	if (rc)
 		return rc;


