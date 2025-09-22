Return-Path: <linux-kernel+bounces-826572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893DEB8ED5C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71187A7149
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203F02EC0A9;
	Mon, 22 Sep 2025 03:01:00 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF3212B94
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758510059; cv=none; b=OPiAWrhP6Zo6UaQLBMbJoPtypPvThnc27XcdJgbUs+gKSQ7i9vlXcLflrqaGWzX7bSp64mFzKBxDw1xC6HxG3bYLahVqWxwSpdpqp2z7oj1AFwBy0r7vie96Y7exLIablyE0LHaWaWU1aP0PuSKdZzsh/Q1yBwVpNsGpU++1ilg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758510059; c=relaxed/simple;
	bh=Hq/c4MWOQ4XCKGNnAIDudRymhkmEwWdWRXBGXeDUAT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNfp0ci4/QrTwappFtX4dtnzQKnl+JNgVM0C+ynp2BtMf7dtPUbm5+9iE6GnXcBXJFsOg1FETpevCkn8MRwm2TgFm204mdm3JGuHl5oiywEfFv5bdC0BiSEGOak3LNS/wQ5LGlc+n/2ogktay/jeh2R0nzGjM6sEHeD+sHhBetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cVSSz3vzxz2RW7W;
	Mon, 22 Sep 2025 10:57:23 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 88FB81A016C;
	Mon, 22 Sep 2025 11:00:54 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 11:00:54 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 11:00:53 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 drm-dp 1/4] drm/hisilicon/hibmc: fix dp probabilistical detect errors after HPD irq
Date: Mon, 22 Sep 2025 10:49:40 +0800
Message-ID: <20250922024943.311947-2-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250922024943.311947-1-shiyongbang@huawei.com>
References: <20250922024943.311947-1-shiyongbang@huawei.com>
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

The issue is that drm_connector_helper_detect_from_ddc() returns wrong
status when plugging or unplugging the monitor. Use HPD pin status in
DP's detect_ctx() for real physcal monitor in/out, and keep using
detect_frome_ddc() if it's the first time to call detect because of
insmoding driver.

Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v5 -> v6:
  - use HPD status in DP detect_ctx(), suggested by Dmitry Baryshkov.
v4 -> v5:
  - fix the commit message and DP detect_ctx(), suggested by Dmitry Baryshkov.
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c     | 12 ++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h     |  7 +++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h    |  3 +++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c | 13 +++++++++++--
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
index 8f0daec7d174..4d8d3e4d4f84 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2024 Hisilicon Limited.
 
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/delay.h>
 #include "dp_config.h"
 #include "dp_comm.h"
@@ -305,3 +306,14 @@ void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg)
 	hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, BIT(0), cfg->enable);
 	writel(HIBMC_DP_SYNC_EN_MASK, dp_dev->base + HIBMC_DP_TIMING_SYNC_CTRL);
 }
+
+void hibmc_dp_update_hpd_status(struct hibmc_dp *dp)
+{
+	int status;
+
+	readl_poll_timeout(dp->dp_dev->base + HIBMC_DP_HPD_STATUS, status,
+			   FIELD_GET(HIBMC_DP_HPD_CUR_STATE, status) != dp->hpd_status,
+			   1000, 100000); /* DP spec says 100ms */
+
+	dp->hpd_status = FIELD_GET(HIBMC_DP_HPD_CUR_STATE, status);
+}
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
index 665f5b166dfb..8348ad9e34a8 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
@@ -14,6 +14,11 @@
 
 struct hibmc_dp_dev;
 
+enum hibmc_hpd_status {
+	HIBMC_HPD_OUT,
+	HIBMC_HPD_IN,
+};
+
 enum hibmc_dp_cbar_pattern {
 	CBAR_COLOR_BAR,
 	CBAR_WHITE,
@@ -50,6 +55,7 @@ struct hibmc_dp {
 	struct drm_dp_aux aux;
 	struct hibmc_dp_cbar_cfg cfg;
 	u32 irq_status;
+	int hpd_status;
 };
 
 int hibmc_dp_hw_init(struct hibmc_dp *dp);
@@ -60,5 +66,6 @@ void hibmc_dp_reset_link(struct hibmc_dp *dp);
 void hibmc_dp_hpd_cfg(struct hibmc_dp *dp);
 void hibmc_dp_enable_int(struct hibmc_dp *dp);
 void hibmc_dp_disable_int(struct hibmc_dp *dp);
+void hibmc_dp_update_hpd_status(struct hibmc_dp *dp);
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
index 394b1e933c3a..64306abcd986 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
@@ -24,6 +24,9 @@
 #define HIBMC_DP_CFG_AUX_READY_DATA_BYTE	GENMASK(16, 12)
 #define HIBMC_DP_CFG_AUX			GENMASK(24, 17)
 
+#define HIBMC_DP_HPD_STATUS			0x98
+#define HIBMC_DP_HPD_CUR_STATE		GENMASK(7, 4)
+
 #define HIBMC_DP_PHYIF_CTRL0			0xa0
 #define HIBMC_DP_CFG_SCRAMBLE_EN		BIT(0)
 #define HIBMC_DP_CFG_PAT_SEL			GENMASK(7, 4)
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index d06832e62e96..48c9c97eef0e 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -34,9 +34,16 @@ static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
 static int hibmc_dp_detect(struct drm_connector *connector,
 			   struct drm_modeset_acquire_ctx *ctx, bool force)
 {
-	mdelay(200);
+	struct hibmc_dp *dp = to_hibmc_dp(connector);
+
+	/* if no HPD just probe DDC */
+	if (!dp->irq_status)
+		return drm_connector_helper_detect_from_ddc(connector, ctx, force);
 
-	return drm_connector_helper_detect_from_ddc(connector, ctx, force);
+	if (dp->hpd_status == HIBMC_HPD_IN)
+		return connector_status_connected;
+
+	return connector_status_disconnected;
 }
 
 static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
@@ -128,6 +135,8 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
 		hibmc_dp_reset_link(&priv->dp);
 	}
 
+	hibmc_dp_update_hpd_status(&priv->dp);
+
 	if (dev->registered)
 		drm_connector_helper_hpd_irq_event(&priv->dp.connector);
 
-- 
2.33.0


