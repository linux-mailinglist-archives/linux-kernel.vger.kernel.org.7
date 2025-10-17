Return-Path: <linux-kernel+bounces-857787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5DEBE7F02
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0978D4280EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6833126A4;
	Fri, 17 Oct 2025 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rHoFyxMW"
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12E82DEA99
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695484; cv=none; b=d1UQiegJU9CTTBoFNvzbs7zLzzh6crL2J1oz0BnQKchASV6IN2j7EfegznE2Rr+A2ru9tXKaOx5a5mbEK5v6I6jk7f0Uhk/XbDad4enzMY+Ub+H1L60ISYTbGI/agZp9pOOZYKeIDqX0qT19BCCxAwmSwzF9EwjNI5mfFx+Rtnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695484; c=relaxed/simple;
	bh=6pRexirXbr77ULdonotRnBXl0C21BHWhmtVqgYzrY+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyyqCG8irnY8rlGT7H4zkUYMvhl4oABBDA6jpEDxwBfDl7PufyDjs4IyDDGxk97iU/Bxh/w5DaWO/eVTtRciTDyFGBhBstvX+7HgTfDB8cPcz7o6wcIVZd442AhSpjgdCjE751+MLVg1dqlnOw1g9S/r2/gYEvAgY4BVz/6+C2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rHoFyxMW; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=reWly1NxFE7gmc97Niaqd2O2TqvCPMr5L+wBby/HDAA=;
	b=rHoFyxMWohkulhoUoNt1zA5r14SjhLhUOhYTcf0fFjFNXkQLCzcKY+2nKSxaFkblRsGLARQiy
	Qp29OWj8B6sVXvY5ezl+FXsifpyfy8j8oJGzH4GaiIvCaXrc9CuQJ4KWrMWaOhtwgTJ1X3f6so/
	FqG7wu9bztPpU9UBvust9/k=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4cp0m115y8z1prMP;
	Fri, 17 Oct 2025 18:04:17 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 105DE1402ED;
	Fri, 17 Oct 2025 18:04:39 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 18:04:37 +0800
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
Subject: [PATCH v9 drm-dp 2/4] drm/hisilicon/hibmc: add dp mode valid check
Date: Fri, 17 Oct 2025 17:59:05 +0800
Message-ID: <20251017095907.2060834-3-shiyongbang@huawei.com>
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

If DP is connected, check the DP BW in mode_valid_ctx() to ensure
that DP's link rate supports high-resolution data transmission.

Fixes: 0ab6ea261c1f ("drm/hisilicon/hibmc: add dp module in hibmc")
Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
ChangeLog:
v4 -> v5:
  - fix bugfix commit ID, suggested by Dmitry Baryshkov.
---
 .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  2 ++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 10 ++++++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  2 ++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 19 +++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
index 08f9e1caf7fc..efb30a758475 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
@@ -17,5 +17,7 @@
 #define HIBMC_DP_LINK_RATE_CAL		27
 #define HIBMC_DP_SYNC_DELAY(lanes)	((lanes) == 0x2 ? 86 : 46)
 #define HIBMC_DP_INT_ENABLE		0xc
+/* HIBMC_DP_LINK_RATE_CAL * 10000 * 80% = 216000 */
+#define DP_MODE_VALI_CAL		216000
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
index 8e91ded0dd37..8ca925a1ee51 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
@@ -264,6 +264,16 @@ void hibmc_dp_reset_link(struct hibmc_dp *dp)
 	dp->dp_dev->link.status.channel_equalized = false;
 }
 
+u8 hibmc_dp_get_link_rate(struct hibmc_dp *dp)
+{
+	return dp->dp_dev->link.cap.link_rate;
+}
+
+u8 hibmc_dp_get_lanes(struct hibmc_dp *dp)
+{
+	return dp->dp_dev->link.cap.lanes;
+}
+
 static const struct hibmc_dp_color_raw g_rgb_raw[] = {
 	{CBAR_COLOR_BAR, 0x000, 0x000, 0x000},
 	{CBAR_WHITE,     0xfff, 0xfff, 0xfff},
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
index 59c1eae153c5..31316fe1ea8d 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
@@ -66,5 +66,7 @@ void hibmc_dp_hpd_cfg(struct hibmc_dp *dp);
 void hibmc_dp_enable_int(struct hibmc_dp *dp);
 void hibmc_dp_disable_int(struct hibmc_dp *dp);
 bool hibmc_dp_check_hpd_status(struct hibmc_dp *dp, int exp_status);
+u8 hibmc_dp_get_link_rate(struct hibmc_dp *dp);
+u8 hibmc_dp_get_lanes(struct hibmc_dp *dp);
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index 5cdbd0882de8..a4f3aef84851 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -13,6 +13,7 @@
 #include "hibmc_drm_drv.h"
 #include "dp/dp_hw.h"
 #include "dp/dp_comm.h"
+#include "dp/dp_config.h"
 
 #define DP_MASKED_SINK_HPD_PLUG_INT	BIT(2)
 
@@ -81,9 +82,27 @@ static int hibmc_dp_detect(struct drm_connector *connector,
 	return connector_status_disconnected;
 }
 
+static int hibmc_dp_mode_valid(struct drm_connector *connector,
+			       const struct drm_display_mode *mode,
+			       struct drm_modeset_acquire_ctx *ctx,
+			       enum drm_mode_status *status)
+{
+	struct hibmc_dp *dp = to_hibmc_dp(connector);
+	u64 cur_val, max_val;
+
+	/* check DP link BW */
+	cur_val = (u64)mode->clock * HIBMC_DP_BPP;
+	max_val = (u64)hibmc_dp_get_link_rate(dp) * DP_MODE_VALI_CAL * hibmc_dp_get_lanes(dp);
+
+	*status = cur_val > max_val ? MODE_CLOCK_HIGH : MODE_OK;
+
+	return 0;
+}
+
 static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
 	.get_modes = hibmc_dp_connector_get_modes,
 	.detect_ctx = hibmc_dp_detect,
+	.mode_valid_ctx = hibmc_dp_mode_valid,
 };
 
 static int hibmc_dp_late_register(struct drm_connector *connector)
-- 
2.33.0


