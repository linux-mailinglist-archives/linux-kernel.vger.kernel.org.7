Return-Path: <linux-kernel+bounces-791548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD21B3B868
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF3F560C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1738530AD02;
	Fri, 29 Aug 2025 10:14:36 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E63081D4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462475; cv=none; b=WEOwjVFNUaLpSxoHZtNHGE1YkJ+H6qL78dw+SneRjViO94Fbz0IBga7Jc2/9tC1CUDKBV/iaj1nHsnXNfLR80yhKluyQrV3TJtx+pBgNEvE22V0Bu2IgN0yn1nvL0TXWVx3dhIYOcp4Vz4PoklTc6ESpmycMrZjEivBoSgQiJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462475; c=relaxed/simple;
	bh=N2NvpHg88S62Uc5fbVIvESI1ayJo/wLkVMflp508xBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhRlK8tOSPSpY1GpeqUoR4i+/OS+Rt+JIACW85Nr5eX1V1G0bSsADZCjPwIaGrwB1pBuxF5/Mg4AoDXMeT/JC9NdyOyMFB7TiB2eePMPA1zYUnrc/e+fzWDktGHTsjFRuhkeVI97vFPUcd4mBxrX20uxUw+0aX5Q6A0KX+geOkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cCvJG5Fdsz14MCg;
	Fri, 29 Aug 2025 18:14:22 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E111180B54;
	Fri, 29 Aug 2025 18:14:30 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 18:14:30 +0800
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
Subject: [PATCH v3 3/9] drivers/perf: hisi: Simplify the probe process of each L3C PMU version
Date: Fri, 29 Aug 2025 18:14:21 +0800
Message-ID: <20250829101427.2557899-4-wangyushan12@huawei.com>
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

Version 1 and 2 of L3C PMU also use different HID. Make use of
struct acpi_device_id::driver_data for version specific information
rather than judge the version register. This will help to
simplify the probe process and also a bit easier for extension.

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 43 ++++++++++++--------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index 412fc3a97963..db683dd7375c 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -345,13 +345,6 @@ static void hisi_l3c_pmu_clear_int_status(struct hisi_pmu *l3c_pmu, int idx)
 	writel(1 << idx, l3c_pmu->base + L3C_INT_CLEAR);
 }
 
-static const struct acpi_device_id hisi_l3c_pmu_acpi_match[] = {
-	{ "HISI0213", },
-	{ "HISI0214", },
-	{}
-};
-MODULE_DEVICE_TABLE(acpi, hisi_l3c_pmu_acpi_match);
-
 static int hisi_l3c_pmu_init_data(struct platform_device *pdev,
 				  struct hisi_pmu *l3c_pmu)
 {
@@ -371,6 +364,10 @@ static int hisi_l3c_pmu_init_data(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	l3c_pmu->dev_info = device_get_match_data(&pdev->dev);
+	if (!l3c_pmu->dev_info)
+		return -ENODEV;
+
 	l3c_pmu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(l3c_pmu->base)) {
 		dev_err(&pdev->dev, "ioremap failed for l3c_pmu resource\n");
@@ -457,6 +454,18 @@ static const struct attribute_group *hisi_l3c_pmu_v2_attr_groups[] = {
 	NULL
 };
 
+static const struct hisi_pmu_dev_info hisi_l3c_pmu_v1 = {
+	.attr_groups = hisi_l3c_pmu_v1_attr_groups,
+	.counter_bits = 48,
+	.check_event = L3C_V1_NR_EVENTS,
+};
+
+static const struct hisi_pmu_dev_info hisi_l3c_pmu_v2 = {
+	.attr_groups = hisi_l3c_pmu_v2_attr_groups,
+	.counter_bits = 64,
+	.check_event = L3C_V2_NR_EVENTS,
+};
+
 static const struct hisi_uncore_ops hisi_uncore_l3c_ops = {
 	.write_evtype		= hisi_l3c_pmu_write_evtype,
 	.get_event_idx		= hisi_uncore_pmu_get_event_idx,
@@ -487,16 +496,9 @@ static int hisi_l3c_pmu_dev_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	if (l3c_pmu->identifier >= HISI_PMU_V2) {
-		l3c_pmu->counter_bits = 64;
-		l3c_pmu->check_event = L3C_V2_NR_EVENTS;
-		l3c_pmu->pmu_events.attr_groups = hisi_l3c_pmu_v2_attr_groups;
-	} else {
-		l3c_pmu->counter_bits = 48;
-		l3c_pmu->check_event = L3C_V1_NR_EVENTS;
-		l3c_pmu->pmu_events.attr_groups = hisi_l3c_pmu_v1_attr_groups;
-	}
-
+	l3c_pmu->pmu_events.attr_groups = l3c_pmu->dev_info->attr_groups;
+	l3c_pmu->counter_bits = l3c_pmu->dev_info->counter_bits;
+	l3c_pmu->check_event = l3c_pmu->dev_info->check_event;
 	l3c_pmu->num_counters = L3C_NR_COUNTERS;
 	l3c_pmu->ops = &hisi_uncore_l3c_ops;
 	l3c_pmu->dev = &pdev->dev;
@@ -554,6 +556,13 @@ static void hisi_l3c_pmu_remove(struct platform_device *pdev)
 					    &l3c_pmu->node);
 }
 
+static const struct acpi_device_id hisi_l3c_pmu_acpi_match[] = {
+	{ "HISI0213", (kernel_ulong_t)&hisi_l3c_pmu_v1 },
+	{ "HISI0214", (kernel_ulong_t)&hisi_l3c_pmu_v2 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, hisi_l3c_pmu_acpi_match);
+
 static struct platform_driver hisi_l3c_pmu_driver = {
 	.driver = {
 		.name = "hisi_l3c_pmu",
-- 
2.33.0


