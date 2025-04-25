Return-Path: <linux-kernel+bounces-619868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DFBA9C2ED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 11:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C77D7B10C8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 09:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6468924888F;
	Fri, 25 Apr 2025 09:00:48 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4D02475CD
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571648; cv=none; b=DzUCtDuEjIb16rRTdqEsOMoSyyDKHrPih2iM7/mDbJz4nrhIiN6AA13LGKJ1XbEmfTtE+W6lexUX0PY8W7zTlPYWAU2EwNAhUCkyVU3mhu/nZKdyDjPmDbEkqZxIbhaYukAObiywYaAyLcbqzgPVm8n8D663L9l+jtJp7yjXSMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571648; c=relaxed/simple;
	bh=YJ5hacusdQyGhXv53oxsZxWFAuPyPsvP8kKGHnbYb7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAWvlBZb0I94rDnoOm10MLmC2keurqMaOp+qi5zwFwnCLHV66eEnEa4VzPU7AOLJ54VcaF1QhPpa/YYNhK8orb3eysLx39pxAxRJecP8O2Cc9h2sGfkT+8NTXGpe4yYJMWNDdEyJL8AvBAIkAzp0WDUE1p+2t7Z4+Y7YH8eJCRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZkRc80qrRz1d0kp;
	Fri, 25 Apr 2025 16:59:36 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 81F3D180B51;
	Fri, 25 Apr 2025 17:00:37 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 25 Apr 2025 17:00:36 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <hejunhao3@huawei.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [RESEND PATCH v3 5/8] drivers/perf: hisi: Relax the event number check of v2 PMUs
Date: Fri, 25 Apr 2025 17:00:26 +0800
Message-ID: <20250425090029.50786-6-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20250425090029.50786-1-yangyicong@huawei.com>
References: <20250425090029.50786-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Junhao He <hejunhao3@huawei.com>

The supported event number range of each Uncore PMUs is provided by
each driver in hisi_pmu::check_event and out of range events
will be rejected. A later version with expanded event number range
needs to register the PMU with updated hisi_pmu::check_event
even if it's the only update, which means the expanded events
cannot be used unless the driver's updated. However the unsupported
events won't be counted by the hardware so we can relax the event
number check to allow the use the expanded events.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 2 +-
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 6 +++---
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   | 2 +-
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 26eaa6d20c00..21c494881ca0 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -53,7 +53,7 @@
 #define DDRC_V1_PERF_CTRL_EN	0x2
 #define DDRC_V2_PERF_CTRL_EN	0x1
 #define DDRC_V1_NR_EVENTS	0x7
-#define DDRC_V2_NR_EVENTS	0x90
+#define DDRC_V2_NR_EVENTS	0xFF
 
 #define DDRC_EVENT_CNTn(base, n)	((base) + (n) * 8)
 #define DDRC_EVENT_TYPEn(base, n)	((base) + (n) * 4)
diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index ca609db86046..97cfaa586a87 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -47,9 +47,9 @@
 #define HHA_SRCID_CMD		GENMASK(16, 6)
 #define HHA_SRCID_MSK		GENMASK(30, 20)
 #define HHA_DATSRC_SKT_EN	BIT(23)
-#define HHA_EVTYPE_NONE		0xff
+#define HHA_EVTYPE_MASK		GENMASK(7, 0)
 #define HHA_V1_NR_EVENT		0x65
-#define HHA_V2_NR_EVENT		0xCE
+#define HHA_V2_NR_EVENT		0xFF
 
 HISI_PMU_EVENT_ATTR_EXTRACTOR(srcid_cmd, config1, 10, 0);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(srcid_msk, config1, 21, 11);
@@ -197,7 +197,7 @@ static void hisi_hha_pmu_write_evtype(struct hisi_pmu *hha_pmu, int idx,
 
 	/* Write event code to HHA_EVENT_TYPEx register */
 	val = readl(hha_pmu->base + reg);
-	val &= ~(HHA_EVTYPE_NONE << shift);
+	val &= ~(HHA_EVTYPE_MASK << shift);
 	val |= (type << shift);
 	writel(val, hha_pmu->base + reg);
 }
diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
index a0142684e379..80108c63cb60 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
@@ -440,7 +440,7 @@ static int hisi_pa_pmu_dev_probe(struct platform_device *pdev,
 	pa_pmu->pmu_events.attr_groups = pa_pmu->dev_info->attr_groups;
 	pa_pmu->num_counters = PA_NR_COUNTERS;
 	pa_pmu->ops = &hisi_uncore_pa_ops;
-	pa_pmu->check_event = 0xB0;
+	pa_pmu->check_event = PA_EVTYPE_MASK;
 	pa_pmu->counter_bits = 64;
 	pa_pmu->dev = &pdev->dev;
 	pa_pmu->on_cpu = -1;
diff --git a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
index 852114cfe3bf..cd32d606df05 100644
--- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
@@ -58,7 +58,7 @@
 #define SLLC_V3_SRCID_CMD_SHIFT		1
 #define SLLC_V3_SRCID_MSK_SHIFT		10
 
-#define SLLC_NR_EVENTS			0x80
+#define SLLC_NR_EVENTS			0xff
 #define SLLC_EVENT_CNTn(cnt0, n)	((cnt0) + (n) * 8)
 
 HISI_PMU_EVENT_ATTR_EXTRACTOR(tgtid_min, config1, 10, 0);
-- 
2.24.0


