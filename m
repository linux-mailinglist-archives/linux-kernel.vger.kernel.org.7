Return-Path: <linux-kernel+bounces-749586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D793B15048
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A5318A496B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31F8298CCF;
	Tue, 29 Jul 2025 15:38:37 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBADA298991
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803517; cv=none; b=rIVA8ohmjbHxLn2jHQc3NCHaFupKJ2+e2f0RuEDXsxsht2i7sQFzmDIyAQG2QoewaridkStVT5Cwv59qyKwE/RTqhxEwdrmE9B87VfrBJ7JVhcXfNZsHobOfTRntBZ1eoKVGp7qYh1clCEkuOOyV7U7a55FBjbzT5mfVy0IZ6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803517; c=relaxed/simple;
	bh=pN99BjN2i/SYImCHhpOtr9qgBYd6xWMB1l6p8kiujMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=St7V8pS+ZFprQc1Le0VoTEuhn2dbtHFD8SxPksYqFFsdOVW62UHli9JDuKgex7zzL/8QDd8Vmz/9Va6n40Kk6/xoMq+f8bwZkvh2nB4cRwOj3bpIUnmRCWzPdQh+DHI3rMbkVeB8NC2GsN4SsRg1nyyWIj/IkV6I2s+FcdDGCq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4brzxJ3x85ztScm;
	Tue, 29 Jul 2025 23:37:24 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C181140278;
	Tue, 29 Jul 2025 23:38:27 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Jul 2025 23:38:27 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Jul 2025 23:38:26 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
	<wangyushan12@huawei.com>
Subject: [PATCH 6/8] drivers/perf: hisi: Refactor the event configuration of L3C PMU
Date: Tue, 29 Jul 2025 23:38:21 +0800
Message-ID: <20250729153823.2026154-7-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250729153823.2026154-1-wangyushan12@huawei.com>
References: <20250729153823.2026154-1-wangyushan12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100008.china.huawei.com (7.202.194.111)

From: Yicong Yang <yangyicong@hisilicon.com>

The event register is configured using hisi_pmu::base directly since
only one address space is supported for L3C PMU. We need to extend if
events configuration locates in different address space. In order to
make preparation for such hardware, extract the event register
configuration to separate function using hw_perf_event::event_base as
each event's base address.  Implement a private
hisi_uncore_ops::get_event_idx() callback for initialize the event_base
besides get the hardware index.

No functional changes intended.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 128 ++++++++++++-------
 1 file changed, 83 insertions(+), 45 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index 39444f11cbad..6ac0ea74cda3 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -60,51 +60,86 @@ HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_cfg, config1, 15, 11);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_skt, config1, 16, 16);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_core, config2, 15, 0);
 
-static void hisi_l3c_pmu_config_req_tracetag(struct perf_event *event)
+static int hisi_l3c_pmu_get_event_idx(struct perf_event *event)
 {
 	struct hisi_pmu *l3c_pmu = to_hisi_pmu(event->pmu);
+	unsigned long *used_mask = l3c_pmu->pmu_events.used_mask;
+	u32 num_counters = l3c_pmu->num_counters;
+	int idx;
+
+	idx = find_first_zero_bit(used_mask, num_counters);
+	if (idx == num_counters)
+		return -EAGAIN;
+
+	set_bit(idx, used_mask);
+	event->hw.event_base = (unsigned long)l3c_pmu->base;
+	return idx;
+}
+
+static u32 hisi_l3c_pmu_event_readl(struct hw_perf_event *hwc, u32 reg)
+{
+	return readl((void __iomem *)hwc->event_base + reg);
+}
+
+static void hisi_l3c_pmu_event_writel(struct hw_perf_event *hwc, u32 reg, u32 val)
+{
+	writel(val, (void __iomem *)hwc->event_base + reg);
+}
+
+static u64 hisi_l3c_pmu_event_readq(struct hw_perf_event *hwc, u32 reg)
+{
+	return readq((void __iomem *)hwc->event_base + reg);
+}
+
+static void hisi_l3c_pmu_event_writeq(struct hw_perf_event *hwc, u32 reg, u64 val)
+{
+	writeq(val, (void __iomem *)hwc->event_base + reg);
+}
+
+static void hisi_l3c_pmu_config_req_tracetag(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
 	u32 tt_req = hisi_get_tt_req(event);
 
 	if (tt_req) {
 		u32 val;
 
 		/* Set request-type for tracetag */
-		val = readl(l3c_pmu->base + L3C_TRACETAG_CTRL);
+		val = hisi_l3c_pmu_event_readl(hwc, L3C_TRACETAG_CTRL);
 		val |= tt_req << L3C_TRACETAG_REQ_SHIFT;
 		val |= L3C_TRACETAG_REQ_EN;
-		writel(val, l3c_pmu->base + L3C_TRACETAG_CTRL);
+		hisi_l3c_pmu_event_writel(hwc, L3C_TRACETAG_CTRL, val);
 
 		/* Enable request-tracetag statistics */
-		val = readl(l3c_pmu->base + L3C_PERF_CTRL);
+		val = hisi_l3c_pmu_event_readl(hwc, L3C_PERF_CTRL);
 		val |= L3C_TRACETAG_EN;
-		writel(val, l3c_pmu->base + L3C_PERF_CTRL);
+		hisi_l3c_pmu_event_writel(hwc, L3C_PERF_CTRL, val);
 	}
 }
 
 static void hisi_l3c_pmu_clear_req_tracetag(struct perf_event *event)
 {
-	struct hisi_pmu *l3c_pmu = to_hisi_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
 	u32 tt_req = hisi_get_tt_req(event);
 
 	if (tt_req) {
 		u32 val;
 
 		/* Clear request-type */
-		val = readl(l3c_pmu->base + L3C_TRACETAG_CTRL);
+		val = hisi_l3c_pmu_event_readl(hwc, L3C_TRACETAG_CTRL);
 		val &= ~(tt_req << L3C_TRACETAG_REQ_SHIFT);
 		val &= ~L3C_TRACETAG_REQ_EN;
-		writel(val, l3c_pmu->base + L3C_TRACETAG_CTRL);
+		hisi_l3c_pmu_event_writel(hwc, L3C_TRACETAG_CTRL, val);
 
 		/* Disable request-tracetag statistics */
-		val = readl(l3c_pmu->base + L3C_PERF_CTRL);
+		val = hisi_l3c_pmu_event_readl(hwc, L3C_PERF_CTRL);
 		val &= ~L3C_TRACETAG_EN;
-		writel(val, l3c_pmu->base + L3C_PERF_CTRL);
+		hisi_l3c_pmu_event_writel(hwc, L3C_PERF_CTRL, val);
 	}
 }
 
 static void hisi_l3c_pmu_write_ds(struct perf_event *event, u32 ds_cfg)
 {
-	struct hisi_pmu *l3c_pmu = to_hisi_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	u32 reg, reg_idx, shift, val;
 	int idx = hwc->idx;
@@ -120,15 +155,15 @@ static void hisi_l3c_pmu_write_ds(struct perf_event *event, u32 ds_cfg)
 	reg_idx = idx % 4;
 	shift = 8 * reg_idx;
 
-	val = readl(l3c_pmu->base + reg);
+	val = hisi_l3c_pmu_event_readl(hwc, reg);
 	val &= ~(L3C_DATSRC_MASK << shift);
 	val |= ds_cfg << shift;
-	writel(val, l3c_pmu->base + reg);
+	hisi_l3c_pmu_event_writel(hwc, reg, val);
 }
 
 static void hisi_l3c_pmu_config_ds(struct perf_event *event)
 {
-	struct hisi_pmu *l3c_pmu = to_hisi_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
 	u32 ds_cfg = hisi_get_datasrc_cfg(event);
 	u32 ds_skt = hisi_get_datasrc_skt(event);
 
@@ -138,15 +173,15 @@ static void hisi_l3c_pmu_config_ds(struct perf_event *event)
 	if (ds_skt) {
 		u32 val;
 
-		val = readl(l3c_pmu->base + L3C_DATSRC_CTRL);
+		val = hisi_l3c_pmu_event_readl(hwc, L3C_DATSRC_CTRL);
 		val |= L3C_DATSRC_SKT_EN;
-		writel(val, l3c_pmu->base + L3C_DATSRC_CTRL);
+		hisi_l3c_pmu_event_writel(hwc, L3C_DATSRC_CTRL, val);
 	}
 }
 
 static void hisi_l3c_pmu_clear_ds(struct perf_event *event)
 {
-	struct hisi_pmu *l3c_pmu = to_hisi_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
 	u32 ds_cfg = hisi_get_datasrc_cfg(event);
 	u32 ds_skt = hisi_get_datasrc_skt(event);
 
@@ -156,51 +191,51 @@ static void hisi_l3c_pmu_clear_ds(struct perf_event *event)
 	if (ds_skt) {
 		u32 val;
 
-		val = readl(l3c_pmu->base + L3C_DATSRC_CTRL);
+		val = hisi_l3c_pmu_event_readl(hwc, L3C_DATSRC_CTRL);
 		val &= ~L3C_DATSRC_SKT_EN;
-		writel(val, l3c_pmu->base + L3C_DATSRC_CTRL);
+		hisi_l3c_pmu_event_writel(hwc, L3C_DATSRC_CTRL, val);
 	}
 }
 
 static void hisi_l3c_pmu_config_core_tracetag(struct perf_event *event)
 {
-	struct hisi_pmu *l3c_pmu = to_hisi_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
 	u32 core = hisi_get_tt_core(event);
 
 	if (core) {
 		u32 val;
 
 		/* Config and enable core information */
-		writel(core, l3c_pmu->base + L3C_CORE_CTRL);
-		val = readl(l3c_pmu->base + L3C_PERF_CTRL);
+		hisi_l3c_pmu_event_writel(hwc, L3C_CORE_CTRL, core);
+		val = hisi_l3c_pmu_event_readl(hwc, L3C_PERF_CTRL);
 		val |= L3C_CORE_EN;
-		writel(val, l3c_pmu->base + L3C_PERF_CTRL);
+		hisi_l3c_pmu_event_writel(hwc, L3C_PERF_CTRL, val);
 
 		/* Enable core-tracetag statistics */
-		val = readl(l3c_pmu->base + L3C_TRACETAG_CTRL);
+		val = hisi_l3c_pmu_event_readl(hwc, L3C_TRACETAG_CTRL);
 		val |= L3C_TRACETAG_CORE_EN;
-		writel(val, l3c_pmu->base + L3C_TRACETAG_CTRL);
+		hisi_l3c_pmu_event_writel(hwc, L3C_TRACETAG_CTRL, val);
 	}
 }
 
 static void hisi_l3c_pmu_clear_core_tracetag(struct perf_event *event)
 {
-	struct hisi_pmu *l3c_pmu = to_hisi_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
 	u32 core = hisi_get_tt_core(event);
 
 	if (core) {
 		u32 val;
 
 		/* Clear core information */
-		writel(L3C_COER_NONE, l3c_pmu->base + L3C_CORE_CTRL);
-		val = readl(l3c_pmu->base + L3C_PERF_CTRL);
+		hisi_l3c_pmu_event_writel(hwc, L3C_CORE_CTRL, L3C_COER_NONE);
+		val = hisi_l3c_pmu_event_readl(hwc, L3C_PERF_CTRL);
 		val &= ~L3C_CORE_EN;
-		writel(val, l3c_pmu->base + L3C_PERF_CTRL);
+		hisi_l3c_pmu_event_writel(hwc, L3C_PERF_CTRL, val);
 
 		/* Disable core-tracetag statistics */
-		val = readl(l3c_pmu->base + L3C_TRACETAG_CTRL);
+		val = hisi_l3c_pmu_event_readl(hwc, L3C_TRACETAG_CTRL);
 		val &= ~L3C_TRACETAG_CORE_EN;
-		writel(val, l3c_pmu->base + L3C_TRACETAG_CTRL);
+		hisi_l3c_pmu_event_writel(hwc, L3C_TRACETAG_CTRL, val);
 	}
 }
 
@@ -239,18 +274,19 @@ static u32 hisi_l3c_pmu_get_counter_offset(int cntr_idx)
 static u64 hisi_l3c_pmu_read_counter(struct hisi_pmu *l3c_pmu,
 				     struct hw_perf_event *hwc)
 {
-	return readq(l3c_pmu->base + hisi_l3c_pmu_get_counter_offset(hwc->idx));
+	return hisi_l3c_pmu_event_readq(hwc, hisi_l3c_pmu_get_counter_offset(hwc->idx));
 }
 
 static void hisi_l3c_pmu_write_counter(struct hisi_pmu *l3c_pmu,
 				       struct hw_perf_event *hwc, u64 val)
 {
-	writeq(val, l3c_pmu->base + hisi_l3c_pmu_get_counter_offset(hwc->idx));
+	hisi_l3c_pmu_event_writeq(hwc, hisi_l3c_pmu_get_counter_offset(hwc->idx), val);
 }
 
 static void hisi_l3c_pmu_write_evtype(struct hisi_pmu *l3c_pmu, int idx,
 				      u32 type)
 {
+	struct hw_perf_event *hwc = &l3c_pmu->pmu_events.hw_events[idx]->hw;
 	u32 reg, reg_idx, shift, val;
 
 	/*
@@ -265,10 +301,10 @@ static void hisi_l3c_pmu_write_evtype(struct hisi_pmu *l3c_pmu, int idx,
 	shift = 8 * reg_idx;
 
 	/* Write event code to L3C_EVENT_TYPEx Register */
-	val = readl(l3c_pmu->base + reg);
+	val = hisi_l3c_pmu_event_readl(hwc, reg);
 	val &= ~(L3C_EVTYPE_NONE << shift);
 	val |= (type << shift);
-	writel(val, l3c_pmu->base + reg);
+	hisi_l3c_pmu_event_writel(hwc, reg, val);
 }
 
 static void hisi_l3c_pmu_start_counters(struct hisi_pmu *l3c_pmu)
@@ -303,9 +339,9 @@ static void hisi_l3c_pmu_enable_counter(struct hisi_pmu *l3c_pmu,
 	u32 val;
 
 	/* Enable counter index in L3C_EVENT_CTRL register */
-	val = readl(l3c_pmu->base + L3C_EVENT_CTRL);
+	val = hisi_l3c_pmu_event_readl(hwc, L3C_EVENT_CTRL);
 	val |= (1 << hwc->idx);
-	writel(val, l3c_pmu->base + L3C_EVENT_CTRL);
+	hisi_l3c_pmu_event_writel(hwc, L3C_EVENT_CTRL, val);
 }
 
 static void hisi_l3c_pmu_disable_counter(struct hisi_pmu *l3c_pmu,
@@ -314,9 +350,9 @@ static void hisi_l3c_pmu_disable_counter(struct hisi_pmu *l3c_pmu,
 	u32 val;
 
 	/* Clear counter index in L3C_EVENT_CTRL register */
-	val = readl(l3c_pmu->base + L3C_EVENT_CTRL);
+	val = hisi_l3c_pmu_event_readl(hwc, L3C_EVENT_CTRL);
 	val &= ~(1 << hwc->idx);
-	writel(val, l3c_pmu->base + L3C_EVENT_CTRL);
+	hisi_l3c_pmu_event_writel(hwc, L3C_EVENT_CTRL, val);
 }
 
 static void hisi_l3c_pmu_enable_counter_int(struct hisi_pmu *l3c_pmu,
@@ -324,10 +360,10 @@ static void hisi_l3c_pmu_enable_counter_int(struct hisi_pmu *l3c_pmu,
 {
 	u32 val;
 
-	val = readl(l3c_pmu->base + L3C_INT_MASK);
+	val = hisi_l3c_pmu_event_readl(hwc, L3C_INT_MASK);
 	/* Write 0 to enable interrupt */
 	val &= ~(1 << hwc->idx);
-	writel(val, l3c_pmu->base + L3C_INT_MASK);
+	hisi_l3c_pmu_event_writel(hwc, L3C_INT_MASK, val);
 }
 
 static void hisi_l3c_pmu_disable_counter_int(struct hisi_pmu *l3c_pmu,
@@ -335,10 +371,10 @@ static void hisi_l3c_pmu_disable_counter_int(struct hisi_pmu *l3c_pmu,
 {
 	u32 val;
 
-	val = readl(l3c_pmu->base + L3C_INT_MASK);
+	val = hisi_l3c_pmu_event_readl(hwc, L3C_INT_MASK);
 	/* Write 1 to mask interrupt */
 	val |= (1 << hwc->idx);
-	writel(val, l3c_pmu->base + L3C_INT_MASK);
+	hisi_l3c_pmu_event_writel(hwc, L3C_INT_MASK, val);
 }
 
 static u32 hisi_l3c_pmu_get_int_status(struct hisi_pmu *l3c_pmu)
@@ -348,7 +384,9 @@ static u32 hisi_l3c_pmu_get_int_status(struct hisi_pmu *l3c_pmu)
 
 static void hisi_l3c_pmu_clear_int_status(struct hisi_pmu *l3c_pmu, int idx)
 {
-	writel(1 << idx, l3c_pmu->base + L3C_INT_CLEAR);
+	struct hw_perf_event *hwc = &l3c_pmu->pmu_events.hw_events[idx]->hw;
+
+	hisi_l3c_pmu_event_writel(hwc, L3C_INT_CLEAR, 1 << idx);
 }
 
 static int hisi_l3c_pmu_init_data(struct platform_device *pdev,
@@ -474,7 +512,7 @@ static const struct hisi_pmu_dev_info hisi_l3c_pmu_v2 = {
 
 static const struct hisi_uncore_ops hisi_uncore_l3c_ops = {
 	.write_evtype		= hisi_l3c_pmu_write_evtype,
-	.get_event_idx		= hisi_uncore_pmu_get_event_idx,
+	.get_event_idx		= hisi_l3c_pmu_get_event_idx,
 	.start_counters		= hisi_l3c_pmu_start_counters,
 	.stop_counters		= hisi_l3c_pmu_stop_counters,
 	.enable_counter		= hisi_l3c_pmu_enable_counter,
-- 
2.33.0


