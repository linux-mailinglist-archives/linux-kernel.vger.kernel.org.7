Return-Path: <linux-kernel+bounces-736352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0806B09BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA303A8F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C5621859A;
	Fri, 18 Jul 2025 07:01:29 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941C11B0F23
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752822088; cv=none; b=Z/eQu69qZCEQlQe8zXQEDMfWD5Dtx3e4VxIOLRNx0vsxGNZdPhZKtVIxylY1YVjTPN6Yacvwx95VSuIEVCX1kqAHXKTuaORKctuSjWzUaOwV2/Pc17a2xAahMlHXjrNffU+LEaNdnunyFTfHwkZPEloE2x327/r21LmNyo6HOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752822088; c=relaxed/simple;
	bh=qwll/ntks+9Me4/eyt/CyWJeg9RccKk/c00VwPhHFaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhnhLu8Mx/jEeRAKPqUwPXWpwaCvl8ghm97VJIBw3GmRqYqRAqqptMqV8shu6UpJHA0+6ZB/0spojSj1bCU1qC2G1h3SnMf5iAtLy96b7hVzqVhNG9VW1cIgoelqUC7FtjJkBMXol1LNUcnistgN0AbWuxGp3Ojlvx2kJs4HTGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bk0xj4GTzzvSCj;
	Fri, 18 Jul 2025 14:58:33 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id EEC981402ED;
	Fri, 18 Jul 2025 15:01:23 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 15:01:23 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 15:01:23 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<jani.nikula@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 drm-dp 03/11] drm/hisilicon/hibmc: fix irq_request()'s irq name variable is local
Date: Fri, 18 Jul 2025 14:51:17 +0800
Message-ID: <20250718065125.2892404-4-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250718065125.2892404-1-shiyongbang@huawei.com>
References: <20250718065125.2892404-1-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq100007.china.huawei.com (7.202.195.175)

From: Baihan Li <libaihan@huawei.com>

The local variable is passed in request_irq (), and there will be use
after free problem, which will make request_irq failed. Using the global
irq name instead of it to fix.

Fixes: b11bc1ae4658 ("drm/hisilicon/hibmc: Add MSI irq getting and requesting for HPD")
Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 768b97f9e74a..4cdcc34070ee 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -32,7 +32,7 @@
 
 DEFINE_DRM_GEM_FOPS(hibmc_fops);
 
-static const char *g_irqs_names_map[HIBMC_MAX_VECTORS] = { "vblank", "hpd" };
+static const char *g_irqs_names_map[HIBMC_MAX_VECTORS] = { "hibmc-vblank", "hibmc-hpd" };
 
 static irqreturn_t hibmc_interrupt(int irq, void *arg)
 {
@@ -277,7 +277,6 @@ static void hibmc_unload(struct drm_device *dev)
 static int hibmc_msi_init(struct drm_device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	char name[32] = {0};
 	int valid_irq_num;
 	int irq;
 	int ret;
@@ -292,9 +291,6 @@ static int hibmc_msi_init(struct drm_device *dev)
 	valid_irq_num = ret;
 
 	for (int i = 0; i < valid_irq_num; i++) {
-		snprintf(name, ARRAY_SIZE(name) - 1, "%s-%s-%s",
-			 dev->driver->name, pci_name(pdev), g_irqs_names_map[i]);
-
 		irq = pci_irq_vector(pdev, i);
 
 		if (i)
@@ -302,10 +298,10 @@ static int hibmc_msi_init(struct drm_device *dev)
 			ret = devm_request_threaded_irq(&pdev->dev, irq,
 							hibmc_dp_interrupt,
 							hibmc_dp_hpd_isr,
-							IRQF_SHARED, name, dev);
+							IRQF_SHARED, g_irqs_names_map[i], dev);
 		else
 			ret = devm_request_irq(&pdev->dev, irq, hibmc_interrupt,
-					       IRQF_SHARED, name, dev);
+					       IRQF_SHARED, g_irqs_names_map[i], dev);
 		if (ret) {
 			drm_err(dev, "install irq failed: %d\n", ret);
 			return ret;
-- 
2.33.0


