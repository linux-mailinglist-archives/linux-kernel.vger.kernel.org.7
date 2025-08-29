Return-Path: <linux-kernel+bounces-791555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4049BB3B86F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D29517E23F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0811D30E83B;
	Fri, 29 Aug 2025 10:14:41 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856EC30C34F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462480; cv=none; b=CCUZskABfQ3zVZTjyFO7zEE1NbbaoEL72VSky9IPZ5Fwb7a52MOTScfSp9Oaso4OEjt8qgmajMZsDVMPGpfcmOp3lsbOcQPr+g6yOvVhbknYV/zIn+FpCfrKzBlzMLP08KxcU7te4u2DyvluZDr+/YgWait3OyFoKwz7StEwK0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462480; c=relaxed/simple;
	bh=6hf8ewZYsQpWBs/YOtbNWTDxboDlULGi//C1chnrhfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ce5mEg1TGyJdI4ZBL3+xD96M0pC7eR+MPGZfoLuIohxrutsgpso869sW+fADwMv3aULoRCj2feBp1rov2cOkFNqI968W78hKm7dCxNi/WwqVWkIOK07mkkzhpLRunXBtyRuySXCxLllNvm9DsmGQsvMCGeqxrcm6z0hqxWyo6vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cCvDx2ngDz2VRTx;
	Fri, 29 Aug 2025 18:11:29 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1404F1402CC;
	Fri, 29 Aug 2025 18:14:30 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 18:14:29 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 18:14:29 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <robin.murphy@arm.com>, <yangyicong@huawei.com>,
	<Jonathan.Cameron@huawei.com>, <liuyonglong@huawei.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<wangyushan12@huawei.com>, <hejunhao3@h-partners.com>, <linuxarm@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH v3 2/9] drivers/perf: hisi: Export hisi_uncore_pmu_isr()
Date: Fri, 29 Aug 2025 18:14:20 +0800
Message-ID: <20250829101427.2557899-3-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250829101427.2557899-1-wangyushan12@huawei.com>
References: <20250829101427.2557899-1-wangyushan12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100008.china.huawei.com (7.202.194.111)

From: Yicong Yang <yangyicong@hisilicon.com>

Currently Uncore PMU framework assume one PMU device only have one
interrupt and will help register the interrupt handler. It cannot
support a PMU with multiple interrupt resources.  An uncore PMU may
have multiple interrupts that can share the same handler.  Export
hisi_uncore_pmu_isr() to allow drivers register the irq handler by
their own routine.

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 3 ++-
 drivers/perf/hisilicon/hisi_uncore_pmu.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 6594d64b03a9..de71dcf11653 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -149,7 +149,7 @@ static void hisi_uncore_pmu_clear_event_idx(struct hisi_pmu *hisi_pmu, int idx)
 	clear_bit(idx, hisi_pmu->pmu_events.used_mask);
 }
 
-static irqreturn_t hisi_uncore_pmu_isr(int irq, void *data)
+irqreturn_t hisi_uncore_pmu_isr(int irq, void *data)
 {
 	struct hisi_pmu *hisi_pmu = data;
 	struct perf_event *event;
@@ -178,6 +178,7 @@ static irqreturn_t hisi_uncore_pmu_isr(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_NS_GPL(hisi_uncore_pmu_isr, "HISI_PMU");
 
 int hisi_uncore_pmu_init_irq(struct hisi_pmu *hisi_pmu,
 			     struct platform_device *pdev)
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index e69660f72be6..8649be6f716a 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -165,6 +165,7 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node);
 ssize_t hisi_uncore_pmu_identifier_attr_show(struct device *dev,
 					     struct device_attribute *attr,
 					     char *page);
+irqreturn_t hisi_uncore_pmu_isr(int irq, void *data);
 int hisi_uncore_pmu_init_irq(struct hisi_pmu *hisi_pmu,
 			     struct platform_device *pdev);
 void hisi_uncore_pmu_init_topology(struct hisi_pmu *hisi_pmu, struct device *dev);
-- 
2.33.0


