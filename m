Return-Path: <linux-kernel+bounces-667956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB98AC8BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 12:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D231C03AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 10:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C06122DA0A;
	Fri, 30 May 2025 10:03:48 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C487F22B8D0
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748599428; cv=none; b=LfHhzhuSuVpkDD+BDjibOqWPPY6XP0y7yk0djSxWrmVf6gPOZ0SAvcOpIlA5PUz9T54S2FYVQ1Im3D8jpKO+a1kg9wGd61VtO0SEDXEgQ41JZ9cTSuRq1KJ2tFIL+Ie5nGexqqahCIHICLBsp3AjR4SivW0sc7wGCVnvxYbh3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748599428; c=relaxed/simple;
	bh=wZ3ir5p1+a+IHOaGqQdqBBbDJXEiSVgRLAr6Z2xxecs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMcB842CpgLkj/7USWGS/ZNv5tDzmgFNf07aIJ/e6uwfF3LkCtpDq8/++cj5m9ljR3iWZwXco050784Kyj3srzKKVnUMw7DeG0RDKZMvmWFaUS2uCbcXarAQC9y2dqXDAf4ZhnqzVUrO9lSF2ap6+xWs4e7qmL33mVozNjHV38k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4b7zHX1ZfWzCtWk;
	Fri, 30 May 2025 17:59:52 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 59293180B27;
	Fri, 30 May 2025 18:03:38 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 May 2025 18:03:38 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 May 2025 18:03:37 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <libaihan@huawei.com>, <shenjian15@huawei.com>,
	<shaojijie@huawei.com>, <jani.nikula@linux.intel.com>,
	<dmitry.baryshkov@oss.qualcomm.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH drm-dp 06/10] drm/hisilicon/hibmc: add dp mode valid check
Date: Fri, 30 May 2025 17:54:28 +0800
Message-ID: <20250530095432.1206966-7-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250530095432.1206966-1-shiyongbang@huawei.com>
References: <20250530095432.1206966-1-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq100007.china.huawei.com (7.202.195.175)

From: Baihan Li <libaihan@huawei.com>

If DP is connected, add mode check and BW check in mode_valid_ctx() to
ensure DP's cfg is usable.

Fixes: f9698f802e50 ("drm/hisilicon/hibmc: Restructuring the header dp_reg.h")
Signed-off-by: Baihan Li <libaihan@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 10 ++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  7 +++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 59 +++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
index ee0b543afd7f..4f93d60b932b 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
@@ -259,6 +259,16 @@ void hibmc_dp_reset_link(struct hibmc_dp *dp)
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
index 68867475508c..ebc7256ad006 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
@@ -12,6 +12,10 @@
 #include <drm/drm_print.h>
 #include <drm/display/drm_dp_helper.h>
 
+/* 27 * 10000000 * 80% = 216000000 */
+#define DP_MODE_VALI_CAL	216000000
+#define BPP_24				24
+
 struct hibmc_dp_dev;
 
 enum hibmc_dp_cbar_pattern {
@@ -51,6 +55,7 @@ struct hibmc_dp {
 	struct hibmc_dp_cbar_cfg cfg;
 	u32 irq_status;
 	int hpd_status;
+	bool is_connected;
 };
 
 int hibmc_dp_hw_init(struct hibmc_dp *dp);
@@ -61,5 +66,7 @@ void hibmc_dp_reset_link(struct hibmc_dp *dp);
 void hibmc_dp_hpd_cfg(struct hibmc_dp *dp);
 void hibmc_dp_enable_int(struct hibmc_dp *dp);
 void hibmc_dp_disable_int(struct hibmc_dp *dp);
+u8 hibmc_dp_get_link_rate(struct hibmc_dp *dp);
+u8 hibmc_dp_get_lanes(struct hibmc_dp *dp);
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index 191fb434baa7..e4b13f21ccb3 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -16,8 +16,31 @@
 #define HIBMC_DP_MASKED_SINK_HPD_PLUG_INT	BIT(2)
 #define HIBMC_DP_MASKED_SINK_HPD_UNPLUG_INT	BIT(3)
 
+struct hibmc_dp_disp_clk {
+	u16 hdisplay;
+	u16 vdisplay;
+	u32 clock;
+};
+
+static const struct hibmc_dp_disp_clk hibmc_dp_clk_table[] = {
+	{640, 480, 25175}, /* 25175 khz */
+	{800, 600, 40000}, /* 40000 khz */
+	{1024, 768, 65000}, /* 65000 khz */
+	{1152, 864, 80000}, /* 80000 khz */
+	{1280, 768, 79500}, /* 79500 khz */
+	{1280, 720, 74250}, /* 74250 khz */
+	{1280, 960, 108000}, /* 108000 khz */
+	{1280, 1024, 108000}, /* 108000 khz */
+	{1440, 900, 106500}, /* 106500 khz */
+	{1600, 900, 108000}, /* 108000 khz */
+	{1600, 1200, 162000}, /* 162000 khz */
+	{1920, 1080, 148500}, /* 148500 khz */
+	{1920, 1200, 193250}, /* 193250 khz */
+};
+
 static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
 {
+	struct hibmc_dp *dp = to_hibmc_dp(connector);
 	const struct drm_edid *drm_edid;
 	int count;
 
@@ -27,6 +50,8 @@ static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
 
 	count = drm_edid_connector_add_modes(connector);
 
+	dp->is_connected = !!count;
+
 	drm_edid_free(drm_edid);
 
 	return count;
@@ -43,9 +68,43 @@ static int hibmc_dp_detect(struct drm_connector *connector,
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
+	if (!dp->is_connected) {
+		*status = MODE_OK;
+		return 0;
+	}
+
+	/* check DP link BW */
+	cur_val = (u64)mode->htotal * mode->vtotal * drm_mode_vrefresh(mode) * BPP_24;
+	max_val = (u64)hibmc_dp_get_link_rate(dp) * DP_MODE_VALI_CAL * hibmc_dp_get_lanes(dp);
+	if (cur_val > max_val)
+		*status = MODE_CLOCK_HIGH;
+	else
+		*status = MODE_OK;
+
+	/* check the clock */
+	for (size_t i = 0; i < ARRAY_SIZE(hibmc_dp_clk_table); i++) {
+		if (hibmc_dp_clk_table[i].hdisplay == mode->hdisplay &&
+		    hibmc_dp_clk_table[i].vdisplay == mode->vdisplay) {
+			if (hibmc_dp_clk_table[i].clock != mode->clock)
+				*status = MODE_CLOCK_RANGE;
+		}
+	}
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


