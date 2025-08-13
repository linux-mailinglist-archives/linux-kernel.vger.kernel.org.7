Return-Path: <linux-kernel+bounces-766412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C177B24659
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08AF1BC4943
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDA32F659A;
	Wed, 13 Aug 2025 09:53:14 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AF72F068C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078793; cv=none; b=G/9Tbgczl69nECJnU7VFMO+mwlYv7hWIsoOgCW/akKOQz7S83Xrl0TZhgaGxwE0QBYFo+q3RYGo5YDhliw6Y3iCF12HnxzydNPF05OzYbHBMmJqmBt/5heH+nr0qz02YXwfJkKxC8wfB0lN1m/3DXiWZlWIfKV8YGhGHVxKhugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078793; c=relaxed/simple;
	bh=KB0Kx78GvPfpFrfllLcIEIMhOu3aZp+3a99+geIE7Bg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXyUWGe6HiOvLbLmkDq7QTMp4ylfyGW2IT1IGYtbNdE1QiiQ7TgWdUC8m3MI1Brl3hnbGh0P/a7H7yuo+amlwPx6y4+wGNlfJzqoZMdaBf5W3vTcnYOkrFnXSwCyR9oyHxKItMY1k6b5da3N9m/nUDRaAgig5MgjCfa4qy53HqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c23V96Ttvz2Cg7J;
	Wed, 13 Aug 2025 17:48:49 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 8256C180044;
	Wed, 13 Aug 2025 17:53:09 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 17:53:09 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 17:53:08 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 drm-dp 07/11] drm/hisilicon/hibmc: fix dp and vga cannot show together
Date: Wed, 13 Aug 2025 17:42:34 +0800
Message-ID: <20250813094238.3722345-8-shiyongbang@huawei.com>
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

If VGA and DP connected together, there will be only one can get crtc.
Add encoder possible_clones to support two connectors enable.

Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index ac552c339671..289304500ab0 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -115,6 +115,8 @@ static const struct drm_mode_config_funcs hibmc_mode_funcs = {
 static int hibmc_kms_init(struct hibmc_drm_private *priv)
 {
 	struct drm_device *dev = &priv->dev;
+	struct drm_encoder *encoder;
+	u32 clone_mask = 0;
 	int ret;
 
 	ret = drmm_mode_config_init(dev);
@@ -154,6 +156,12 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
 		return ret;
 	}
 
+	drm_for_each_encoder(encoder, dev)
+		clone_mask |= drm_encoder_mask(encoder);
+
+	drm_for_each_encoder(encoder, dev)
+		encoder->possible_clones = clone_mask;
+
 	return 0;
 }
 
-- 
2.33.0


