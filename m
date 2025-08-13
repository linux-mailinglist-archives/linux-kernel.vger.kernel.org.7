Return-Path: <linux-kernel+bounces-766406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CA5B24627
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A957B7B9BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50CE2F2915;
	Wed, 13 Aug 2025 09:53:09 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485302F1FDE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078789; cv=none; b=HfdGxrN1WMBb+Srgwl1BvKuwLssyWUKXfiKnPQBvAgds5hcyLOstHNslgSt/LtGRa0CXugNS1TzUA7OGw9J3VGPsyJ8uQ3JJhNpgElWfVZmKNA7QpU6oBK/8fZQ2uAAO/1n6hQethjHfzweZlzZdSKyEOwhv8w9/hnKqynodB0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078789; c=relaxed/simple;
	bh=qwll/ntks+9Me4/eyt/CyWJeg9RccKk/c00VwPhHFaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBfN3IqLp/M+7vYEnskFVYE6eR87d/lP3NSgpEC+yqC2F3fjsUkjIOOPzGV9TOZZRzI6IQCLshbIC5yKVJhAoosAdkdHH+7XJICu/FoOUWTgzFKZ3FfBLXffHpG337SX0Ad+W6SlTYBq+TfwM6i0wThZkCsHhxRygDmFVUzbnxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c23Wq1j5rz1R92X;
	Wed, 13 Aug 2025 17:50:15 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 32FE3180044;
	Wed, 13 Aug 2025 17:53:05 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 17:53:04 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 17:53:04 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 drm-dp 03/11] drm/hisilicon/hibmc: fix irq_request()'s irq name variable is local
Date: Wed, 13 Aug 2025 17:42:30 +0800
Message-ID: <20250813094238.3722345-4-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250813094238.3722345-1-shiyongbang@huawei.com>
References: <20250813094238.3722345-1-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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


