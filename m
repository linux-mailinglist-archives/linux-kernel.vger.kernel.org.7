Return-Path: <linux-kernel+bounces-791554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FB5B3B86C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7F41615FA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8793B30C60E;
	Fri, 29 Aug 2025 10:14:40 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876143081D8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462480; cv=none; b=CiHH1Rh1wKvrU2DxQ+yfIHUQalF7wAjGW8u+cJ9rX0a9I0E1vgH99OTukur0RJACI65V41RSyuasrHNnVfV7UO5YetlGgE6QsKrCqp0gwpTE79EYZ+cUFTbnCzj2fcWlWgPMTNNYbYCQIOtKpVXdR6vnCtZmL2iqtUdkrZ8DoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462480; c=relaxed/simple;
	bh=f+EzVav9odVJK5ghcnMa2DxMFZQoSx7apLszAQdf3Ho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPRwqxhc9NdMrLDnj9My5fdemOYCE6xKkACo10UvkIJBBVa2Yjmb+SnexEyVGNYWfvJAItvqOxk3XWRRjP0okrjrjNgYHm/NI/Y+5kyER06MHiTLHIDVLGZJhL9DK397w9NWem4fTvw9SN5i4qNstvuK4bKT3bCTe+P/2bGimf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cCvDy2Z3vz2VRQf;
	Fri, 29 Aug 2025 18:11:30 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CC451402CC;
	Fri, 29 Aug 2025 18:14:31 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 18:14:30 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 18:14:30 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <robin.murphy@arm.com>, <yangyicong@huawei.com>,
	<Jonathan.Cameron@huawei.com>, <liuyonglong@huawei.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<wangyushan12@huawei.com>, <hejunhao3@h-partners.com>, <linuxarm@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH v3 4/9] drivers/perf: hisi: Extract the event filter check of L3C PMU
Date: Fri, 29 Aug 2025 18:14:22 +0800
Message-ID: <20250829101427.2557899-5-wangyushan12@huawei.com>
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

L3C PMU has 4 filter options which are sharing perf_event_attr::config1.
Driver will check config1 to see whether a certain event has a filter
setting. It'll be incorrect if we make use of other bits in config1
for non-filter options. So check whether each filter options are set
directly in a separate function instead.

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index db683dd7375c..a372dd2c07b5 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -204,9 +204,15 @@ static void hisi_l3c_pmu_clear_core_tracetag(struct perf_event *event)
 	}
 }
 
+static bool hisi_l3c_pmu_have_filter(struct perf_event *event)
+{
+	return hisi_get_tt_req(event) || hisi_get_tt_core(event) ||
+	       hisi_get_datasrc_cfg(event) || hisi_get_datasrc_skt(event);
+}
+
 static void hisi_l3c_pmu_enable_filter(struct perf_event *event)
 {
-	if (event->attr.config1 != 0x0) {
+	if (hisi_l3c_pmu_have_filter(event)) {
 		hisi_l3c_pmu_config_req_tracetag(event);
 		hisi_l3c_pmu_config_core_tracetag(event);
 		hisi_l3c_pmu_config_ds(event);
@@ -215,7 +221,7 @@ static void hisi_l3c_pmu_enable_filter(struct perf_event *event)
 
 static void hisi_l3c_pmu_disable_filter(struct perf_event *event)
 {
-	if (event->attr.config1 != 0x0) {
+	if (hisi_l3c_pmu_have_filter(event)) {
 		hisi_l3c_pmu_clear_ds(event);
 		hisi_l3c_pmu_clear_core_tracetag(event);
 		hisi_l3c_pmu_clear_req_tracetag(event);
-- 
2.33.0


