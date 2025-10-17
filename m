Return-Path: <linux-kernel+bounces-857784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6090BE7EF7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6266427EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0254630F818;
	Fri, 17 Oct 2025 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="H2QtvZgk"
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AAB2DC76F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695483; cv=none; b=ESLN6qzwYBZNWIs5j/KkoGrxGKFEUYMyALprot9Noest1mihY4nEuPEHOxLpdy7IM/4CsZDW+a58FYGSvEaT2V5Q8IeveG2jbZXiW5+is0ixQs3ZXO/mQk20qdYZuEKh2SGE6gchK9hVQ1lXj2WKnbD9TvL8+Z8FU23lIlQxtYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695483; c=relaxed/simple;
	bh=bSkITrS7bu5JBDrg2tN0BOLhYeyVjBErA3y6o2rETs4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjqMmQ3j3e29HRweFx3BKHYedKlQ0vTaM4/2C9r2vwbfx9ezAGZg44PNccLE/QYvSENS8X/rDRKdto5mvtgXOnxXaHt0Q6U+0zpb/Eu/WBf1p+DlxmXkCeqq6M+MSG3hYl7OhgBGL6qhV9UlMHYIHnN7Fjwpj8xRqXUtbfF6o3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=H2QtvZgk; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wbYx1fJE4cXl200/XRlqVOJFeS2jQP+Toe4EXLOWtfA=;
	b=H2QtvZgkPdX/L6013EFTL/3iX2JLg3SvX/kifgBIg2wkypzdzdDg0rMA3RZNRFirJyafTx0R8
	x8MfCHF9YWVW883zojWcVSmhkdSqE9BLknx5JbUPCxK4atjzBS/rueMkJB1RTuMdNItYcT6Nuqg
	6PTyeyrf15LG4AGWL3Xqf3Q=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cp0m00GlDzKm5G;
	Fri, 17 Oct 2025 18:04:16 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 755F21A0188;
	Fri, 17 Oct 2025 18:04:37 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 18:04:37 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 18:04:36 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 drm-dp 1/4] drm/hisilicon/hibmc: fix dp probabilistical detect errors after HPD irq
Date: Fri, 17 Oct 2025 17:59:04 +0800
Message-ID: <20251017095907.2060834-2-shiyongbang@huawei.com>
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

The issue is that drm_connector_helper_detect_from_ddc() returns wrong
status when plugging or unplugging the monitor. Use HPD pin status in
DP's detect_ctx() for real physcal monitor in/out, and implementation
a complete DP detection including read DPCD, check if it's a branch
device and its sink count for different situations.
Do a double check that adding HPD check and get DPCD at the beginning of
DP encoder enable stage.

Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v8 -> v9:
  - refactor the hibmc_dp_check_hpd_status(), and add some checks
    in dp_encoder_enable.
v7 -> v8:
  - fix build errors reported by kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202509241625.o4mNleVb-lkp@intel.com/
v6 -> v7:
  - add the check about branch devices, suggested by Dmitry Baryshkov.
v5 -> v6:
  - use HPD status in DP detect_ctx(), suggested by Dmitry Baryshkov.
v4 -> v5:
  - fix the commit message and DP detect_ctx(), suggested by Dmitry Baryshkov.
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  4 ++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 21 +++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  6 ++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  3 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 58 +++++++++++++++++--
 5 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
index 4add05c7f161..f9ee7ebfec55 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
@@ -40,6 +40,10 @@ struct hibmc_dp_dev {
 	struct mutex lock; /* protects concurrent RW in hibmc_dp_reg_write_field() */
 	struct hibmc_dp_link link;
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
+	u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
+	struct drm_dp_desc desc;
+	bool is_branch;
+	int hpd_status;
 	void __iomem *serdes_base;
 };
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
index 8f0daec7d174..8e91ded0dd37 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2024 Hisilicon Limited.
 
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/delay.h>
 #include "dp_config.h"
 #include "dp_comm.h"
@@ -305,3 +306,23 @@ void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg)
 	hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, BIT(0), cfg->enable);
 	writel(HIBMC_DP_SYNC_EN_MASK, dp_dev->base + HIBMC_DP_TIMING_SYNC_CTRL);
 }
+
+bool hibmc_dp_check_hpd_status(struct hibmc_dp *dp, int exp_status)
+{
+	u32 status;
+	int ret;
+
+	msleep(100);
+
+	ret = readl_poll_timeout(dp->dp_dev->base + HIBMC_DP_HPD_STATUS, status,
+				 FIELD_GET(HIBMC_DP_HPD_CUR_STATE, status) == exp_status,
+				 1000, 100000); /* DP spec says 100ms */
+	if (ret) {
+		drm_dbg_dp(dp->drm_dev, "wait hpd status timeout");
+		return false;
+	}
+
+	dp->dp_dev->hpd_status = exp_status;
+
+	return true;
+}
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
index 665f5b166dfb..59c1eae153c5 100644
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
+bool hibmc_dp_check_hpd_status(struct hibmc_dp *dp, int exp_status);
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
index 394b1e933c3a..64306abcd986 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
@@ -24,6 +24,9 @@
 #define HIBMC_DP_CFG_AUX_READY_DATA_BYTE	GENMASK(16, 12)
 #define HIBMC_DP_CFG_AUX			GENMASK(24, 17)
 
+#define HIBMC_DP_HPD_STATUS			0x98
+#define HIBMC_DP_HPD_CUR_STATE			GENMASK(7, 4)
+
 #define HIBMC_DP_PHYIF_CTRL0			0xa0
 #define HIBMC_DP_CFG_SCRAMBLE_EN		BIT(0)
 #define HIBMC_DP_CFG_PAT_SEL			GENMASK(7, 4)
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index d06832e62e96..5cdbd0882de8 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -12,6 +12,7 @@
 
 #include "hibmc_drm_drv.h"
 #include "dp/dp_hw.h"
+#include "dp/dp_comm.h"
 
 #define DP_MASKED_SINK_HPD_PLUG_INT	BIT(2)
 
@@ -31,12 +32,53 @@ static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
 	return count;
 }
 
+static bool hibmc_dp_get_dpcd(struct hibmc_dp_dev *dp_dev)
+{
+	int ret;
+
+	ret = drm_dp_read_dpcd_caps(dp_dev->aux, dp_dev->dpcd);
+	if (ret)
+		return false;
+
+	dp_dev->is_branch = drm_dp_is_branch(dp_dev->dpcd);
+
+	ret = drm_dp_read_desc(dp_dev->aux, &dp_dev->desc, dp_dev->is_branch);
+	if (ret)
+		return false;
+
+	ret = drm_dp_read_downstream_info(dp_dev->aux, dp_dev->dpcd, dp_dev->downstream_ports);
+	if (ret)
+		return false;
+
+	return true;
+}
+
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
+	if (!hibmc_dp_get_dpcd(dp_dev))
+		return connector_status_disconnected;
+
+	if (!dp_dev->is_branch)
+		return connector_status_connected;
 
-	return drm_connector_helper_detect_from_ddc(connector, ctx, force);
+	if (drm_dp_read_sink_count_cap(connector, dp_dev->dpcd, &dp_dev->desc) &&
+	    dp_dev->downstream_ports[0] & DP_DS_PORT_HPD) {
+		ret = drm_dp_read_sink_count(dp_dev->aux);
+		if (ret > 0)
+			return connector_status_connected;
+	}
+
+	return connector_status_disconnected;
 }
 
 static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
@@ -92,6 +134,12 @@ static void hibmc_dp_encoder_enable(struct drm_encoder *drm_encoder,
 	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
 	struct drm_display_mode *mode = &drm_encoder->crtc->state->mode;
 
+	if (!hibmc_dp_check_hpd_status(dp, HIBMC_HPD_IN))
+		return;
+
+	if (!hibmc_dp_get_dpcd(dp->dp_dev))
+		return;
+
 	if (hibmc_dp_prepare(dp, mode))
 		return;
 
@@ -115,7 +163,7 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
 {
 	struct drm_device *dev = (struct drm_device *)arg;
 	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
-	int idx;
+	int idx, exp_status;
 
 	if (!drm_dev_enter(dev, &idx))
 		return -ENODEV;
@@ -123,12 +171,14 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
 	if (priv->dp.irq_status & DP_MASKED_SINK_HPD_PLUG_INT) {
 		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
 		hibmc_dp_hpd_cfg(&priv->dp);
+		exp_status = HIBMC_HPD_IN;
 	} else {
 		drm_dbg_dp(&priv->dev, "HPD OUT isr occur!\n");
 		hibmc_dp_reset_link(&priv->dp);
+		exp_status = HIBMC_HPD_OUT;
 	}
 
-	if (dev->registered)
+	if (hibmc_dp_check_hpd_status(&priv->dp, exp_status))
 		drm_connector_helper_hpd_irq_event(&priv->dp.connector);
 
 	drm_dev_exit(idx);
-- 
2.33.0


