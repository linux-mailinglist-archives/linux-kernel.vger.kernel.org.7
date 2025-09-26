Return-Path: <linux-kernel+bounces-833488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B00DBA224A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AB317837F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A826D1632DD;
	Fri, 26 Sep 2025 01:26:20 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9AB34BA4D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758849980; cv=none; b=twl7WlFLbmD6W3JYlMiJG9vBPpzKLG4/xQFTx41IW5t1Xq3oXHUYzgc/W7PL5/2PJY38zAEafxE/meq9RVB7eAGYdatNDJbwAlMtxvrKnPdpgg6Jsk9Gd+uHMx6Th5t8F4GDfNzhSBeJ+U2dBOFF/wVlHmRu65euwEwwq15OfSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758849980; c=relaxed/simple;
	bh=9xtlaHqSJpnawlTh/8lp8pB89eiG8//+OrDD9UykXq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwCR4Y1ghHK0TEYmeedjYR6xQjoa3OWj5HkrWJI8Amsh7vbxn63t4pQ83Lj/mczTvgKltB6ybkHbs4enAY/b6KVS8UoSZIDxTTeWUfkq6W4PIt2vlcli7WvRA4YfQYlmaXrnJaCLnrnFnxIcJSoVIPclXvKraN40T+594rh3Vo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cXt8d19WrzQl7q;
	Fri, 26 Sep 2025 09:21:37 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id E639D180B5C;
	Fri, 26 Sep 2025 09:26:15 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Sep 2025 09:26:15 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Sep 2025 09:26:15 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 drm-dp 3/4] drm/hisilicon/hibmc: fix no showing problem with loading hibmc manually
Date: Fri, 26 Sep 2025 09:14:59 +0800
Message-ID: <20250926011500.2545817-4-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250926011500.2545817-1-shiyongbang@huawei.com>
References: <20250926011500.2545817-1-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq100007.china.huawei.com (7.202.195.175)

From: Baihan Li <libaihan@huawei.com>

When using command rmmod and insmod, there is no showing in second time
insmoding. Because DP controller won't send HPD signals, if connection
doesn't change or controller isn't reset. So add reset before unreset
in hibmc_dp_hw_init().

And also need to move the HDCP cfg after DP controller de-resets, so
that HDCP configuration takes effect.

Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
ChangeLog:
v4 -> v5:
  - combined 9 and 11 patch together, suggested by Dmitry Baryshkov.
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
index 23df0d5228ca..2954e3066923 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
@@ -177,13 +177,16 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
 	dp_dev->link.cap.lanes = 0x2;
 	dp_dev->link.cap.link_rate = DP_LINK_BW_8_1;
 
-	/* hdcp data */
-	writel(HIBMC_DP_HDCP, dp_dev->base + HIBMC_DP_HDCP_CFG);
 	/* int init */
 	writel(0, dp_dev->base + HIBMC_DP_INTR_ENABLE);
 	writel(HIBMC_DP_INT_RST, dp_dev->base + HIBMC_DP_INTR_ORIGINAL_STATUS);
 	/* rst */
+	writel(0, dp_dev->base + HIBMC_DP_DPTX_RST_CTRL);
+	usleep_range(30, 50);
+	/* de-rst */
 	writel(HIBMC_DP_DPTX_RST, dp_dev->base + HIBMC_DP_DPTX_RST_CTRL);
+	/* hdcp data */
+	writel(HIBMC_DP_HDCP, dp_dev->base + HIBMC_DP_HDCP_CFG);
 	/* clock enable */
 	writel(HIBMC_DP_CLK_EN, dp_dev->base + HIBMC_DP_DPTX_CLK_CTRL);
 
-- 
2.33.0


