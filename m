Return-Path: <linux-kernel+bounces-749584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 816A0B15045
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B901117FBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CC529899D;
	Tue, 29 Jul 2025 15:38:36 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED9A298987
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803516; cv=none; b=s9MNpGDOwQ0UoNpw6PqVrTDLQRAjbFEKpMCv0N+TuIYgEZrn9zOntSys6yBnFJjlZo88n5HaTwJDTIY/7SFlMntEg/a03eHmr0jkvYGf1+ipEiO+rbpIOD9Q7cKE83oLZxkAaHjf/1Qs8KaHYNN6Mo62FQ1r4IubvvaUWBUHT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803516; c=relaxed/simple;
	bh=QUCVYtIMVjY3ZVxvZ5i+HOYe1LGOqs+zz4lLRZ1tucA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+3TGJvENE5+gH/ZjYZJruEyFZ+K5FA0nZ2PHta1+2eQE1QZfY8koy8yVxK5KoeoESwxWM6cb3/7Tbin9YLZ+jqoqGq5ywbmu2IBN0AEVcWj6qNDDvXylcOl8OujPE9zba6IHoAKgh2WP5zIT8KQ0v2PdYBEAMZ22PQwxxnoSis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4brzsd70MgzdcB9;
	Tue, 29 Jul 2025 23:34:13 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 33A78180B52;
	Tue, 29 Jul 2025 23:38:27 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Jul 2025 23:38:26 +0800
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
Subject: [PATCH 5/8] drivers/perf: hisi: Extend the field of tt_core
Date: Tue, 29 Jul 2025 23:38:20 +0800
Message-ID: <20250729153823.2026154-6-wangyushan12@huawei.com>
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


