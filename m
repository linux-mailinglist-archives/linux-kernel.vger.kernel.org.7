Return-Path: <linux-kernel+bounces-749585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E90B15046
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AF218A4656
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226072989BA;
	Tue, 29 Jul 2025 15:38:37 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA50298990
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803516; cv=none; b=Zz4n9LiAqqCe1xq6agRo1egdz5WcKUj5AbX5DrY7abMhSZBpW59x0BTpTXx3S22pyTPpuGttAPL35XCw3scI8AAQ2y10AcIgMGdTy3yFnhYUp/CzlcSoKH6fjjXMefk0e4OlMyjxCnKtflqzknoaWX5UABbiQ6TP0f3B4hh2hHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803516; c=relaxed/simple;
	bh=35gOphLUnY+QgbjDNDrxI4suISxXiDI6dzAEOVeM/eQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnKyFlxUP/9h9VzvrDabHjuCxNtQir2a5sowq2y5K0PXmwLIF1OVU4plGxhQRG3f1ehPLcLXPZaNWiyRaKHOn4HU9T8m+J5FD4w0upgKQLs9DODF4GyurvhsCd6f8cd3Zt2AhllPfPuELDurKL991wOYQ4d9NxTYDpOw3vk3Pwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4brzsB3zkhzSjYy;
	Tue, 29 Jul 2025 23:33:50 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 734B1180487;
	Tue, 29 Jul 2025 23:38:25 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Jul 2025 23:38:25 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Jul 2025 23:38:24 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
	<wangyushan12@huawei.com>
Subject: [PATCH 1/8] drivers/perf: hisi: Relax the event ID check in the framework
Date: Tue, 29 Jul 2025 23:38:16 +0800
Message-ID: <20250729153823.2026154-2-wangyushan12@huawei.com>
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

Event ID is only using the attr::config bit [7, 0] but we check the
event range using the whole 64bit field. It blocks the usage of the
resident field of attr::config. Relax the check by only using the
bit [7, 0].

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index ef058b1dd509..3050899ddf17 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -234,7 +234,7 @@ int hisi_uncore_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	hisi_pmu = to_hisi_pmu(event->pmu);
-	if (event->attr.config > hisi_pmu->check_event)
+	if ((event->attr.config & HISI_EVENTID_MASK) > hisi_pmu->check_event)
 		return -EINVAL;
 
 	if (hisi_pmu->on_cpu == -1)
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index f4fed2544877..50a97e79076a 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -43,7 +43,8 @@
 		return FIELD_GET(GENMASK_ULL(hi, lo), event->attr.config);  \
 	}
 
-#define HISI_GET_EVENTID(ev) (ev->hw.config_base & 0xff)
+#define HISI_EVENTID_MASK	0xff
+#define HISI_GET_EVENTID(ev) ((ev)->hw.config_base & HISI_EVENTID_MASK)
 
 #define HISI_PMU_EVTYPE_BITS		8
 #define HISI_PMU_EVTYPE_SHIFT(idx)	((idx) % 4 * HISI_PMU_EVTYPE_BITS)
-- 
2.33.0


