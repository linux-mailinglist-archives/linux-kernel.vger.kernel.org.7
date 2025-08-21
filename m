Return-Path: <linux-kernel+bounces-779951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7896B2FB76
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969105A2667
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D45246797;
	Thu, 21 Aug 2025 13:50:58 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5EB2EC549
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784257; cv=none; b=YfRskZPSRIH2AZxvkAMa++cqWIGAoCwPzLgWtnMl0WvBWtNKGw9tx5h+EP6RDuV9um4qxZEBPf4hUCfAY4rJbWi1wmFiXdL4VR8aKK1ugwXTY22UldtJeK24qpb4MBEMTYBbPpXCZwTBdhakHZqxZX2iXKFZzB0yOu1YRgwb5sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784257; c=relaxed/simple;
	bh=QUCVYtIMVjY3ZVxvZ5i+HOYe1LGOqs+zz4lLRZ1tucA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8Y+OcWXl3eGo0NGQotFfQO1qh1kkGtAnrwXkzDTkTf7faPsbq+U6KZdeZrJUEZXapaLGoQwT9MJb6EBQFPphMYWaLBS3R1SiY53yX2vs4AQDPaWWH6jIwY8URtH3J2tgyWx8Egb30YtkojKbjMhIB3xmyzKJ3VxV6TRd53olJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c74Nk1sx1z2CgDq;
	Thu, 21 Aug 2025 21:46:30 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B2D41A016C;
	Thu, 21 Aug 2025 21:50:53 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 21:50:53 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 21:50:52 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <robin.murphy@arm.com>, <yangyicong@huawei.com>,
	<Jonathan.Cameron@huawei.com>, <liuyonglong@huawei.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<wangyushan12@huawei.com>, <hejunhao3@h-partners.com>
Subject: [PATCH v2 5/9] drivers/perf: hisi: Extend the field of tt_core
Date: Thu, 21 Aug 2025 21:50:45 +0800
Message-ID: <20250821135049.2010220-6-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250821135049.2010220-1-wangyushan12@huawei.com>
References: <20250821135049.2010220-1-wangyushan12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100008.china.huawei.com (7.202.194.111)

From: Yicong Yang <yangyicong@hisilicon.com>

Currently the tt_core's using config1's bit [7, 0] and can not be
extended. For some platforms there's more the 8 CPUs sharing the
L3 cache. So make tt_core use config2's bit [15, 0] and the remaining
bits in config2 is reserved for extension.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index a372dd2c07b5..39444f11cbad 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -55,10 +55,10 @@
 #define L3C_V1_NR_EVENTS	0x59
 #define L3C_V2_NR_EVENTS	0xFF
 
-HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_core, config1, 7, 0);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_req, config1, 10, 8);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_cfg, config1, 15, 11);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_skt, config1, 16, 16);
+HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_core, config2, 15, 0);
 
 static void hisi_l3c_pmu_config_req_tracetag(struct perf_event *event)
 {
@@ -397,7 +397,7 @@ static const struct attribute_group hisi_l3c_pmu_v1_format_group = {
 
 static struct attribute *hisi_l3c_pmu_v2_format_attr[] = {
 	HISI_PMU_FORMAT_ATTR(event, "config:0-7"),
-	HISI_PMU_FORMAT_ATTR(tt_core, "config1:0-7"),
+	HISI_PMU_FORMAT_ATTR(tt_core, "config2:0-15"),
 	HISI_PMU_FORMAT_ATTR(tt_req, "config1:8-10"),
 	HISI_PMU_FORMAT_ATTR(datasrc_cfg, "config1:11-15"),
 	HISI_PMU_FORMAT_ATTR(datasrc_skt, "config1:16"),
-- 
2.33.0


