Return-Path: <linux-kernel+bounces-766408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5333B24637
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620E81784D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214382F3C0A;
	Wed, 13 Aug 2025 09:53:10 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C7A2F1FFE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078789; cv=none; b=cAJDJi+kjoYt0Ec8eY3m1XrCgxgsZ1WcOGCiXsdEPFJ51h0fVUTctvp1AsDT+B379i3HwJsfHVSCY/1lrRjzlIAarlssN8xuBprVlUcReb8t3wZyK9MXgYv4FKN/+hUpdobdFwM2Y/uJfXxKQcTHKwiAPGTWJnzgQ1m6qM2ge9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078789; c=relaxed/simple;
	bh=eij5R5KwVff9lIpyOsW5M0osrieWwiznhkloD0S5vUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9njas8+oUmhkht0vWman+rOsswDirVqruqN/f04LDH6PqRb2Y35hrDXhwJjbNRz5BQkwnutaiB8LEvblB5omyt5PXm98Pd+K5zKSjPHuykYLN7hFcTP1XepIQv4vi6OC5PoWrlBVQaZ/r16t2nP/Hr2Kf91RowDAqMbFMDlvdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c23W83FLKz13N9J;
	Wed, 13 Aug 2025 17:49:40 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id A987614027A;
	Wed, 13 Aug 2025 17:53:04 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 17:53:04 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 17:53:03 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 drm-dp 02/11] drm/hisilicon/hibmc: fix dp probabilistical detect errors after HPD irq
Date: Wed, 13 Aug 2025 17:42:29 +0800
Message-ID: <20250813094238.3722345-3-shiyongbang@huawei.com>
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

The debouncing when HPD pulled out still remains sometimes, 200ms still can
not ensure helper_detect() is correct. So add a flag to hold the sink
status, and changed detect_ctx() functions by using flag to check status.

Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v3 -> v4:
  - remove link training process in hibmc_dp_detect(), suggested by Dmitry Baryshkov.
  - remove if (dev->registered), suggested by Dmitry Baryshkov.
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  1 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
index 665f5b166dfb..68867475508c 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
@@ -50,6 +50,7 @@ struct hibmc_dp {
 	struct drm_dp_aux aux;
 	struct hibmc_dp_cbar_cfg cfg;
 	u32 irq_status;
+	int hpd_status;
 };
 
 int hibmc_dp_hw_init(struct hibmc_dp *dp);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index d06832e62e96..ded38530ecda 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -34,9 +34,12 @@ static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
 static int hibmc_dp_detect(struct drm_connector *connector,
 			   struct drm_modeset_acquire_ctx *ctx, bool force)
 {
-	mdelay(200);
+	struct hibmc_dp *dp = to_hibmc_dp(connector);
 
-	return drm_connector_helper_detect_from_ddc(connector, ctx, force);
+	if (dp->hpd_status)
+		return connector_status_connected;
+	else
+		return connector_status_disconnected;
 }
 
 static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
@@ -115,21 +118,23 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
 {
 	struct drm_device *dev = (struct drm_device *)arg;
 	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
+	struct hibmc_dp *dp = &priv->dp;
 	int idx;
 
 	if (!drm_dev_enter(dev, &idx))
 		return -ENODEV;
 
-	if (priv->dp.irq_status & DP_MASKED_SINK_HPD_PLUG_INT) {
+	if (((dp->irq_status & DP_MASKED_SINK_HPD_PLUG_INT) && !dp->hpd_status)) {
 		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
-		hibmc_dp_hpd_cfg(&priv->dp);
+		hibmc_dp_hpd_cfg(dp);
+		dp->hpd_status = 1;
 	} else {
 		drm_dbg_dp(&priv->dev, "HPD OUT isr occur!\n");
-		hibmc_dp_reset_link(&priv->dp);
+		hibmc_dp_reset_link(dp);
+		dp->hpd_status = 0;
 	}
 
-	if (dev->registered)
-		drm_connector_helper_hpd_irq_event(&priv->dp.connector);
+	drm_connector_helper_hpd_irq_event(&priv->dp.connector);
 
 	drm_dev_exit(idx);
 
-- 
2.33.0


