Return-Path: <linux-kernel+bounces-828984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701DCB95FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B487B6158
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C9324B26;
	Tue, 23 Sep 2025 13:15:30 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8F5322547
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633329; cv=none; b=BEjpkuYJqqxSvjabpUoGihn2Fs48RXDPAJeLbdk6ZjEXRRm4K/DfyadmJOEUq+oQEbqGEhaJdhV9YhzvTZYmIdlbzfvxzsRqOq35IZqkgyz3REIPIZvidkCHWuZgDMHyb3CBI+gg+9NteqEnDWxQXgoPQg46oqDTMVFX9IdxC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633329; c=relaxed/simple;
	bh=xRhdM5zKpyZ5UTUPbRdCtsNXz4gxw9FaTuhMM0zp1U4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DapEoP/8i3dSSaf5UmuI/3CbPWsPRQiSyTgWN/PaRUy1GrfIMHoPSkzo8ZZQTIiJzKiE7DOO1HFDMppbB+dxfLQCYPP3HxmCtx84U7ahkjS6EnCVs22yb1/fuLxeuG3q8PWbw8oUyTWzqrboa1V1O5df1Sqe45MgCT62Kr/TpeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cWL2F1G4NzddPt;
	Tue, 23 Sep 2025 21:10:45 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 91146180B6B;
	Tue, 23 Sep 2025 21:15:23 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Sep 2025 21:15:23 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Sep 2025 21:15:22 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 drm-dp 1/4] drm/hisilicon/hibmc: fix dp probabilistical detect errors after HPD irq
Date: Tue, 23 Sep 2025 21:04:08 +0800
Message-ID: <20250923130411.2522339-2-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250923130411.2522339-1-shiyongbang@huawei.com>
References: <20250923130411.2522339-1-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq100007.china.huawei.com (7.202.195.175)

From: Baihan Li <libaihan@huawei.com>

The issue is that drm_connector_helper_detect_from_ddc() returns wrong
status when plugging or unplugging the monitor. Use HPD pin status in
DP's detect_ctx() for real physcal monitor in/out, and implementation
a complete DP detection including read DPCD, check if it's a branch
device and its sink count for different situations.

Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v6 -> v7:
  - add the check about branch devices, suggested by Dmitry Baryshkov.
v5 -> v6:
  - use HPD status in DP detect_ctx(), suggested by Dmitry Baryshkov.
v4 -> v5:
  - fix the commit message and DP detect_ctx(), suggested by Dmitry Baryshkov.
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  3 ++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 12 +++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  6 ++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  3 ++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 34 +++++++++++++++++--
 5 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
index 4add05c7f161..7954a883435c 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
@@ -40,6 +40,9 @@ struct hibmc_dp_dev {
 	struct mutex lock; /* protects concurrent RW in hibmc_dp_reg_write_field() */
 	struct hibmc_dp_link link;
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
+	struct drm_dp_desc desc;
+	bool is_branch;
+	int hpd_status;
 	void __iomem *serdes_base;
 };
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
index 8f0daec7d174..bd3d73075629 100644
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
+			   FIELD_GET(HIBMC_DP_HPD_CUR_STATE, status) != dp->dp_dev->hpd_status,
+			   1000, 100000); /* DP spec says 100ms */
+
+	dp->dp_dev->hpd_status = FIELD_GET(HIBMC_DP_HPD_CUR_STATE, status);
+}
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
index 665f5b166dfb..1e2214aece6a 100644
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
@@ -60,5 +65,6 @@ void hibmc_dp_reset_link(struct hibmc_dp *dp);
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
index d06832e62e96..6792cd0b64b2 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -12,6 +12,7 @@
 
 #include "hibmc_drm_drv.h"
 #include "dp/dp_hw.h"
+#include "dp/dp_comm.h"
 
 #define DP_MASKED_SINK_HPD_PLUG_INT	BIT(2)
 
@@ -34,9 +35,36 @@ static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
 static int hibmc_dp_detect(struct drm_connector *connector,
 			   struct drm_modeset_acquire_ctx *ctx, bool force)
 {
-	mdelay(200);
+	struct hibmc_dp *dp = to_hibmc_dp(connector);
+	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
+	int ret;
+
+	if (dp->irq_status) {
+		if (dp_dev->hpd_status != HIBMC_HPD_IN)
+			return connector_status_disconnected;
+	}
+
+	ret = drm_dp_read_dpcd_caps(dp_dev->aux, dp_dev->dpcd);
+	if (ret)
+		return connector_status_disconnected;
+
+	dp_dev->is_branch = drm_dp_is_branch(dp_dev->dpcd);
 
-	return drm_connector_helper_detect_from_ddc(connector, ctx, force);
+	ret = drm_dp_read_desc(dp_dev->aux, &dp_dev->desc, dp_dev->is_branch);
+	if (ret)
+		return connector_status_disconnected;
+
+	if (!dp_dev->is_branch)
+		return connector_status_connected;
+
+	if (drm_dp_read_sink_count_cap(connector, dp_dev->dpcd, &dp_dev->desc) &&
+	    dp_dev->dpcd[DP_DOWNSTREAM_PORT_0] & DP_DS_PORT_HPD) {
+		ret = drm_dp_read_sink_count(dp_dev->aux);
+		if (ret > 0)
+			return connector_status_connected;
+	}
+
+	return connector_status_disconnected;
 }
 
 static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
@@ -128,6 +156,8 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
 		hibmc_dp_reset_link(&priv->dp);
 	}
 
+	hibmc_dp_update_hpd_status(&priv->dp);
+
 	if (dev->registered)
 		drm_connector_helper_hpd_irq_event(&priv->dp.connector);
 
-- 
2.33.0


