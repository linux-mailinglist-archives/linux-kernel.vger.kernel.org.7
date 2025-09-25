Return-Path: <linux-kernel+bounces-831685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DF0B9D507
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D930A3A5530
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994F722D7A5;
	Thu, 25 Sep 2025 03:31:32 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE1DDC3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758771092; cv=none; b=TMIgV2VwlE3ukw3TZ/qGiIZ3b8PQLH2T/Sf89FyUDW7MgEysMuuQjrBMmDj0GcTy8QQKvcbYUypOQxQUYJZbh/l4tzA4tPtvCsuKt4uJ5uZwhaE6P3+Sh0j5Uwye1pJjCwVl69aVyj2DOgR1b81fc9V/WRpMBPKDv/Fp0rH0F70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758771092; c=relaxed/simple;
	bh=YuTZyOhqv3hmDasYV87jd4zQgfOBYy8UDC3vvWKuhRs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PkCAR0cfclL3w3nWxPLODlCzzdXPgb23uep+xS95Q2a9zcxkRgzqq3f/R/nUHky7++688DboCTeQx5P29HuWvPONH4vI1v5u0J+pXr6iy/l/bV00PvammAtxiozS0zEPGjJLglYNuT6jvYSmm01Xo5VCd+uqsTZhnG0OTHWC8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cXJzW3Xjzz2Cgq3;
	Thu, 25 Sep 2025 11:26:47 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E7401A016C;
	Thu, 25 Sep 2025 11:31:26 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Sep 2025 11:31:24 +0800
Received: from DESKTOP-VM4LOUJ.huawei.com (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Sep 2025 11:31:24 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>, <wangyushan12@huawei.com>,
	<hejunhao3@h-partners.com>, <yangyccccc@gmail.com>
Subject: [PATCH] drivers/perf: hisi: Add tt_core_deprecated for compatibility
Date: Thu, 25 Sep 2025 11:31:23 +0800
Message-ID: <20250925033123.5836-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200018.china.huawei.com (7.202.195.108)

From: Yicong Yang <yangyicong@hisilicon.com>

Previously tt_core is defined as config1:0-7 which may not cover all
the CPUs sharing L3C on platforms with more than 8 CPUs in a L3C. In
order to support such platforms extend tt_core to 16 bits, since no
spare space in config1, tt_core was moved to config2:0-15.

Though linux expects the users to retrieve the control encoding from
sysfs first for each option, it's possible if user doesn't follow
this and hardcoded tt_core in config1. So add an option
tt_core_deprecated for config1:0-7 for backward compatibility.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Fail the event init if user use tt_core and tt_core_deprecated simultaneuously,
based on the dicussion:
Link: https://lore.kernel.org/linux-arm-kernel/aNPTwxnlXGbazFLR@willie-the-truck/

 Documentation/admin-guide/perf/hisi-pmu.rst  |  4 +++
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 33 +++++++++++++++++---
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
index c4c2cbbf88cb..0017f8ddeb75 100644
--- a/Documentation/admin-guide/perf/hisi-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pmu.rst
@@ -66,6 +66,10 @@ specified as a bitmap::
 
 This will only count the operations from core/thread 0 and 1 in this cluster.
 
+User should not use tt_core_deprecated to specify the core/thread filtering.
+This option is provided for backward compatiblility and only support 8bit
+which may not cover all the core/thread sharing L3C.
+
 2. Tracetag allow the user to chose to count only read, write or atomic
 operations via the tt_req parameeter in perf. The default value counts all
 operations. tt_req is 3bits, 3'b100 represents read operations, 3'b101
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index bbd81a43047d..f963e4f9e552 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -57,6 +57,11 @@
 #define L3C_V2_NR_EVENTS	0xFF
 
 HISI_PMU_EVENT_ATTR_EXTRACTOR(ext, config, 17, 16);
+/*
+ * Remain the config1:0-7 for backward compatibility if some existing users
+ * hardcode the config1:0-7 directly without parsing the sysfs attribute.
+ */
+HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_core_deprecated, config1, 7, 0);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_req, config1, 10, 8);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_cfg, config1, 15, 11);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_skt, config1, 16, 16);
@@ -95,6 +100,21 @@ static bool support_ext(struct hisi_l3c_pmu *pmu)
 	return l3c_pmu_ext->support_ext;
 }
 
+/*
+ * tt_core was extended to cover all the CPUs sharing the L3 and was moved from
+ * config1:0-7 to config2:0-*. Try it first and fallback to tt_core_deprecated
+ * if user's still using the deprecated one.
+ */
+static u32 hisi_l3c_pmu_get_tt_core(struct perf_event *event)
+{
+	u32 core = hisi_get_tt_core(event);
+
+	if (core)
+		return core;
+
+	return hisi_get_tt_core_deprecated(event);
+}
+
 static int hisi_l3c_pmu_get_event_idx(struct perf_event *event)
 {
 	struct hisi_pmu *l3c_pmu = to_hisi_pmu(event->pmu);
@@ -259,7 +279,7 @@ static void hisi_l3c_pmu_clear_ds(struct perf_event *event)
 static void hisi_l3c_pmu_config_core_tracetag(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	u32 core = hisi_get_tt_core(event);
+	u32 core = hisi_l3c_pmu_get_tt_core(event);
 
 	if (core) {
 		u32 val;
@@ -280,7 +300,7 @@ static void hisi_l3c_pmu_config_core_tracetag(struct perf_event *event)
 static void hisi_l3c_pmu_clear_core_tracetag(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	u32 core = hisi_get_tt_core(event);
+	u32 core = hisi_l3c_pmu_get_tt_core(event);
 
 	if (core) {
 		u32 val;
@@ -300,7 +320,7 @@ static void hisi_l3c_pmu_clear_core_tracetag(struct perf_event *event)
 
 static bool hisi_l3c_pmu_have_filter(struct perf_event *event)
 {
-	return hisi_get_tt_req(event) || hisi_get_tt_core(event) ||
+	return hisi_get_tt_req(event) || hisi_l3c_pmu_get_tt_core(event) ||
 	       hisi_get_datasrc_cfg(event) || hisi_get_datasrc_skt(event);
 }
 
@@ -331,6 +351,9 @@ static int hisi_l3c_pmu_check_filter(struct perf_event *event)
 	if (ext < 0 || ext > hisi_l3c_pmu->ext_num)
 		return -EINVAL;
 
+	if (hisi_get_tt_core(event) && hisi_get_tt_core_deprecated(event))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -602,10 +625,11 @@ static const struct attribute_group hisi_l3c_pmu_v1_format_group = {
 
 static struct attribute *hisi_l3c_pmu_v2_format_attr[] = {
 	HISI_PMU_FORMAT_ATTR(event, "config:0-7"),
-	HISI_PMU_FORMAT_ATTR(tt_core, "config2:0-15"),
+	HISI_PMU_FORMAT_ATTR(tt_core_deprecated, "config1:0-7"),
 	HISI_PMU_FORMAT_ATTR(tt_req, "config1:8-10"),
 	HISI_PMU_FORMAT_ATTR(datasrc_cfg, "config1:11-15"),
 	HISI_PMU_FORMAT_ATTR(datasrc_skt, "config1:16"),
+	HISI_PMU_FORMAT_ATTR(tt_core, "config2:0-15"),
 	NULL
 };
 
@@ -617,6 +641,7 @@ static const struct attribute_group hisi_l3c_pmu_v2_format_group = {
 static struct attribute *hisi_l3c_pmu_v3_format_attr[] = {
 	HISI_PMU_FORMAT_ATTR(event, "config:0-7"),
 	HISI_PMU_FORMAT_ATTR(ext, "config:16-17"),
+	HISI_PMU_FORMAT_ATTR(tt_core_deprecated, "config1:0-7"),
 	HISI_PMU_FORMAT_ATTR(tt_req, "config1:8-10"),
 	HISI_PMU_FORMAT_ATTR(tt_core, "config2:0-15"),
 	NULL
-- 
2.24.0


