Return-Path: <linux-kernel+bounces-791551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F147AB3B86D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F39847BCEBB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B1E30C602;
	Fri, 29 Aug 2025 10:14:38 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CF730BBBB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462478; cv=none; b=S9POTMRoyNKvEKccNp3Ev6DSAsxAP8rkaE2fMStQVZp+dh2oWRF9/3m5bAs6rg8Gse1heRUKvBuHXhLz656eO8iRkhxj6d3+dVNXGbJpqnyX+K+oG2kGIQ/JhIKpW31AaiAymgLKBbtnPeEeLJ7ATvwiRKQ2rhdPtEnxl1q+SGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462478; c=relaxed/simple;
	bh=Y6gZ+jiEuQdZO7xo7djSWcAR87HgM36vOHpw2uyA0/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWCsuUfIH0BnOT76uwyTnx5z5Ic+RSeTq0VyVi8BYlnTbkWKSvYn+D4W1Gt6un4cJ1Bnn3BrMi1+NRBRhE06ihfcNoHMUZ+XHAUroS2U2MSjKS3eUNdbAQg0fB331jF82sfHL209C74Uh9Z0YWAYaGNJiIjXoLiw0hckBZ1hg/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cCvF34jwvz1R98v;
	Fri, 29 Aug 2025 18:11:35 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id C953118005F;
	Fri, 29 Aug 2025 18:14:32 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 18:14:32 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 18:14:32 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <robin.murphy@arm.com>, <yangyicong@huawei.com>,
	<Jonathan.Cameron@huawei.com>, <liuyonglong@huawei.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<wangyushan12@huawei.com>, <hejunhao3@h-partners.com>, <linuxarm@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH v3 8/9] Documentation: hisi-pmu: Fix of minor format error
Date: Fri, 29 Aug 2025 18:14:26 +0800
Message-ID: <20250829101427.2557899-9-wangyushan12@huawei.com>
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

The inline path of sysfs should be placed in literal blocks to make
documentation look better.

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 Documentation/admin-guide/perf/hisi-pmu.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
index 48992a0b8e94..a307bce2f5c5 100644
--- a/Documentation/admin-guide/perf/hisi-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pmu.rst
@@ -18,9 +18,10 @@ HiSilicon SoC uncore PMU driver
 Each device PMU has separate registers for event counting, control and
 interrupt, and the PMU driver shall register perf PMU drivers like L3C,
 HHA and DDRC etc. The available events and configuration options shall
-be described in the sysfs, see:
+be described in the sysfs, see::
+
+/sys/bus/event_source/devices/hisi_sccl{X}_<l3c{Y}/hha{Y}/ddrc{Y}>
 
-/sys/bus/event_source/devices/hisi_sccl{X}_<l3c{Y}/hha{Y}/ddrc{Y}>.
 The "perf list" command shall list the available events from sysfs.
 
 Each L3C, HHA and DDRC is registered as a separate PMU with perf. The PMU
-- 
2.33.0


