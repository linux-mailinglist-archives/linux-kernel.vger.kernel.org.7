Return-Path: <linux-kernel+bounces-895392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9D6C4DA4F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5599188A795
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9EF3587A4;
	Tue, 11 Nov 2025 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="D3yIxMCd"
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F32EBB87
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863720; cv=none; b=naiJfvF9VUidYzIPi7wSGV4OXmo8jMLorcMV51aDLNb1Ug9D5hCLRIWuh7AeRoPXbaMlZfJUVS6s+D8BOEoBmFCymdyCAXN6W6o6oNoUC9eo8klADyk4PkIVFWWSTVtxO60eLMihGVvKvjtwNxS1GSYVS3WUAtoaY/w19AsNkA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863720; c=relaxed/simple;
	bh=2i9eMVeAgs4FxudCLXGednNHljF1BWT6z0VDS5RVdUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqdKsUWth7C+ATZ+6lM1MlBuw1akUNHKAjttlYK4lQwx75zCGbZ9GMqYUpDoRfDnvrOYiAkj7GQ4mN6Ypno72A+0uBCQNQ8eNWoCyU8O8+6Ur4Qm1Q/FlaVVPKTTCkmYCC29DGBi4a4Zagh4PmY7zdN6L+QKL0+3sLiiK7nEca0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=D3yIxMCd; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JYS6cUYbaBrYBqtuCBw04MHvPS3IithG0eILiPsNDuE=;
	b=D3yIxMCddptLlUBQdnNB3tKYWITzCH5GN1PsjoPQafWeO0bEDwgm7eIQQcA8Voh0hhYxxs2EA
	uMe8Cg/nwZuMsYI1RTpL2djHxJdO+IfZQNXoTdZYA3EEtwZAB5kXBDI8Er+CADpOi8Hd/Wpk30K
	Gs5qeHh+i59TzQfVyzTjO9Q=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d5QbB4N9Nzcb16;
	Tue, 11 Nov 2025 20:20:06 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7AE75180B5A;
	Tue, 11 Nov 2025 20:21:54 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 20:21:54 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 20:21:52 +0800
From: Junhao He <hejunhao3@h-partners.com>
To: <suzuki.poulose@arm.com>, <james.clark@linaro.org>,
	<anshuman.khandual@arm.com>, <yeoreum.yun@arm.com>, <mike.leach@linaro.org>,
	<leo.yan@arm.com>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <hejunhao3@h-partners.com>
Subject: [PATCH v4 3/3] coresight: tmc: Decouple the perf buffer allocation from sysfs mode
Date: Tue, 11 Nov 2025 20:21:49 +0800
Message-ID: <20251111122149.1981162-4-hejunhao3@h-partners.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251111122149.1981162-1-hejunhao3@h-partners.com>
References: <20251111122149.1981162-1-hejunhao3@h-partners.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn500004.china.huawei.com (7.202.194.145)

From: Yicong Yang <yangyicong@hisilicon.com>

Currently the perf buffer allocation follows the below logic:
- if the required AUX buffer size if larger, allocate the buffer with
  the required size
- otherwise allocate the size reference to the sysfs buffer size

This is not useful as we only collect to one AUX data, so just try to
allocate the buffer match the AUX buffer size.

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/linux-arm-kernel/df8967cd-2157-46a2-97d9-a1aea883cf63@arm.com/
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Junhao He <hejunhao3@h-partners.com>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 30 ++++++-------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index fe1d5e8a0d2b..c2ba004a25fe 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1327,9 +1327,7 @@ EXPORT_SYMBOL_GPL(tmc_etr_get_buffer);
 
 /*
  * alloc_etr_buf: Allocate ETR buffer for use by perf.
- * The size of the hardware buffer is dependent on the size configured
- * via sysfs and the perf ring buffer size. We prefer to allocate the
- * largest possible size, scaling down the size by half until it
+ * Allocate the largest possible size, scaling down the size by half until it
  * reaches a minimum limit (1M), beyond which we give up.
  */
 static struct etr_buf *
@@ -1338,36 +1336,26 @@ alloc_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
 {
 	int node;
 	struct etr_buf *etr_buf;
-	unsigned long size;
+	ssize_t size;
 
 	node = (event->cpu == -1) ? NUMA_NO_NODE : cpu_to_node(event->cpu);
-	/*
-	 * Try to match the perf ring buffer size if it is larger
-	 * than the size requested via sysfs.
-	 */
-	if ((nr_pages << PAGE_SHIFT) > drvdata->size) {
-		etr_buf = tmc_alloc_etr_buf(drvdata, ((ssize_t)nr_pages << PAGE_SHIFT),
-					    0, node, NULL);
-		if (!IS_ERR(etr_buf))
-			goto done;
-	}
+
+	/* Use the minimum limit if the required size is smaller */
+	size = nr_pages << PAGE_SHIFT;
+	size = max_t(ssize_t, size, TMC_ETR_PERF_MIN_BUF_SIZE);
 
 	/*
-	 * Else switch to configured size for this ETR
-	 * and scale down until we hit the minimum limit.
+	 * Try to allocate the required size for this ETR, if failed scale
+	 * down until we hit the minimum limit.
 	 */
-	size = drvdata->size;
 	do {
 		etr_buf = tmc_alloc_etr_buf(drvdata, size, 0, node, NULL);
 		if (!IS_ERR(etr_buf))
-			goto done;
+			return etr_buf;
 		size /= 2;
 	} while (size >= TMC_ETR_PERF_MIN_BUF_SIZE);
 
 	return ERR_PTR(-ENOMEM);
-
-done:
-	return etr_buf;
 }
 
 static struct etr_buf *
-- 
2.33.0


