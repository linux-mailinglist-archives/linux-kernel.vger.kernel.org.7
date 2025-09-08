Return-Path: <linux-kernel+bounces-805802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8224B48DA0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77BF61734A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0772FE058;
	Mon,  8 Sep 2025 12:34:30 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C02B2E7BA7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334870; cv=none; b=HGLrSoc03mzDvNo5axIwoG9enWh/hgdY+TOPGhMC/rhUv6h+t52NwaD2F3EsWbP2JpfFizqgSfMAQ1iORU/YHTG/M4ak+PBZFxwnquSaCl4wvMP8t2KNX6qsBTh0l7jD8Yr00FvNP3EUbRpU/lo0Uhfv2lr85IWcTpEUPhs6/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334870; c=relaxed/simple;
	bh=XIIzZzslMJ2iD0U7qq+AYISp6T9//dbYYl2DW9E/cAI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cz8LR83g/fmUGfzLTzWz5m+M/LGdYvBPaIGAhRaFNAZpgB4np4hxO5KPpco+KcgLsOrbREo1xJor4ypienLMLjo2AKuvZ81//gC0denE7HWjUobxAUdeOdSCOwD5xJdigDrTCfSq8c4PPX8uTR2+8XihNKKHapQO5iiNqB16Xv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cL5w85KQbztTjG;
	Mon,  8 Sep 2025 20:33:28 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3BF3A1402CC;
	Mon,  8 Sep 2025 20:34:24 +0800 (CST)
Received: from kwepemq500007.china.huawei.com (7.202.195.21) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Sep 2025 20:34:24 +0800
Received: from huawei.com (10.67.174.117) by kwepemq500007.china.huawei.com
 (7.202.195.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 8 Sep
 2025 20:34:23 +0800
From: Lin Yujun <linyujun809@h-partners.com>
To: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>, <linyujun809@h-partners.com>,
	<santosh@fossix.org>
CC: <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ndtest: Fix incorrect handling for return value of device_create_with_groups.
Date: Mon, 8 Sep 2025 20:23:31 +0800
Message-ID: <20250908122331.1315530-1-linyujun809@h-partners.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500007.china.huawei.com (7.202.195.21)

The return value of device_create_with_groups will not
be an null pointer, use IS_ERR() to fix incorrect handling
return value of device_create_with_groups.

Fixes: 9399ab61ad82 ("ndtest: Add dimms to the two buses")
Signed-off-by: Lin Yujun <linyujun809@h-partners.com>
---
 tools/testing/nvdimm/test/ndtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 68a064ce598c..7d722f2f7d62 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -745,11 +745,11 @@ static int ndtest_dimm_register(struct ndtest_priv *priv,
 
 	dimm->dev = device_create_with_groups(&ndtest_dimm_class,
 					     &priv->pdev.dev,
 					     0, dimm, dimm_attribute_groups,
 					     "test_dimm%d", id);
-	if (!dimm->dev) {
+	if (IS_ERR(dimm->dev)) {
 		pr_err("Could not create dimm device attributes\n");
 		return -ENOMEM;
 	}
 
 	return 0;
-- 
2.34.1


