Return-Path: <linux-kernel+bounces-857785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F92BE7EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B4994EC1C0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC98730F556;
	Fri, 17 Oct 2025 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yB/Xy940"
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CAA2DE700
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695483; cv=none; b=AR7qXhBlVXhEv/+7YemlHBXmaceAeTggBrHqoapvrbgd+9NFryqYEK6UfWe5mYMrKZTu9i+xkqrE4bE7Kf4YuK1Ys2IoMhNUdbQGk+n4omWH9V/yPk6S11y0Pqvjcclbo59rsSmEmy2QUKDp9HQ4Fp7RiqXDVYen17Pzlyy3s9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695483; c=relaxed/simple;
	bh=AJZ/yuLn3/WX+LUO9ZMkW9/t76HI0vihFBH0uuAwQgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZqaxJkrogqXCR1HEw4wQF3mCUPIT9TQhGv3qE80K8sd+6iS15uMTfODzFvJeclDvtU52833+RFslPGrwiEyK6rbQLIAbkYibhzJwzlNgg+cVNj4g7UUkdjWPrJR7fH9QA0oDqlbMeVU4eDnPhDYaOjI85C4qS3w5SaG/rqOMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yB/Xy940; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JHCcEfOcTvm0pjaG9Antp+DfqBF3Ft++N8nVTv2Pff4=;
	b=yB/Xy940E+x7czBJACDvZzjurCyZO6TCBlOBSGPux4QZbd9Ru9ZzCQH4ezLjZjtK4cC1epQqC
	PUL6aU0sfCsaS5pSha6HfHWgzeT3VObdueZNoDQH4su6hfxmCOJp4h/oiDirgWW0aMw0hqAL4GK
	H56hKrGpU6trjj296sFvPSA=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cp0lZ2q5WznTWX;
	Fri, 17 Oct 2025 18:03:54 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DB741402C4;
	Fri, 17 Oct 2025 18:04:38 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 18:04:38 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 18:04:37 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 drm-dp 3/4] drm/hisilicon/hibmc: fix no showing problem with loading hibmc manually
Date: Fri, 17 Oct 2025 17:59:06 +0800
Message-ID: <20251017095907.2060834-4-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251017095907.2060834-1-shiyongbang@huawei.com>
References: <20251017095907.2060834-1-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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
index 8ca925a1ee51..d76256bfbb20 100644
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


