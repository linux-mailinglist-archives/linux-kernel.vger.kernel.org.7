Return-Path: <linux-kernel+bounces-812332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F17B53671
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87571B626B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553AB345722;
	Thu, 11 Sep 2025 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VcElagIG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1A343D79
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602542; cv=none; b=apGjwVaJ2ih/2U4Arkqt5nIfvooR1oP7lcqr7TCL9qC6KqaeBwAD/WdIgZct6bwYk81N6QmJ8ItyJX0cEA/v+FXwn1anWIckhd9ZvvMLPRwGgL0xt+SkGaLgxMWl/zS5Sg2L7quZ00H6XqRQW21EETh7r/9+OFWUz5Q9s2VY6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602542; c=relaxed/simple;
	bh=78IrfQSQc/vYvBmr4Hd7SBAiD/BRnh9v/jyb8cpkSRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lmpluvdLJhQEUFb3fesi16Z15i55TVpYe7pCwiJVz1gyiT3bNoskkOvBJet8ulPcnmZKYKKmUP7DPjytMQdFg0ff5sJk6Uz0AMZyT8lIwz4jlFeVovTKbJ8pDAgt/uNarTyxD9y66rFETMjnDfNELa8ZR9RnzJQvmS0DqnDerSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VcElagIG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BACJPI002423
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NDfSQabXzokHSIW13jl0jd
	4obAw0ZOVDLamUkVRB0cU=; b=VcElagIGAHVnSU1Ekm7IARNiz5+0WrwWNzQI0P
	f2m8IlKh4JU5ZP9np7c18lsrRw/7fI64BCui9lbgvwvOTFw4vZfIjXbH1dAO2Smy
	Ca18cz3aYX9dSq+6lEYQx+B+4tV4fuUm3H4kej9Kl2Ed1SuMUPyELRlucSHs/cHF
	Dll2WjMHh57lOc/SRXTzflzclcasE6UJewXRpCzTqaJrjvZrYnYHX0xibcuDxlM4
	PypAaFIkDg4EOKl70lZ6lxKnWQ5qjjBaBKNn27CPsZ03JgA1DAPBLrONc9qdsqja
	RJ2IbjOXO3QI1TVktuBtz3Wsr06HkSfRzqv2skQJhE0Ydsow==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8r753-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:55:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77283b2b5f7so1456894b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757602537; x=1758207337;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDfSQabXzokHSIW13jl0jd4obAw0ZOVDLamUkVRB0cU=;
        b=HacKZA1TXVFofHG0iB0VOPYJ+JxAY5AGUCAY22MM6gBr67SWf5djyoLbRyfoXJ0kta
         BOJISqjfJ+GzkcoqSW5PK4zzK5c/K4RQdqayOAtaa5+2SsDMMKFC0ZDvpCrIZtTdGA5W
         vscoOk/t7h09KRm9SRo9RyhluHbHXyZu2Z8ZhqVU61AQvHSKSbots1whLYEk6YZhEN9+
         Iqj1QLEDmGK7T8zWeQvtsz0Hxx0ubR0G6zQ9/GL9sEWZQqd41AFNdKiHEHQON94SEuFb
         fQjsGlktUWaVcguSAZjwryIAGc3YtBk53xDurOAlJtEXd+HETJsyi6Wd1BzQoT35O4CY
         UknQ==
X-Gm-Message-State: AOJu0Yx/rtlt+gZ7OnI6MZWhw0s79/hyP1dEWwB1PjJEQttHG10k4Tec
	HXWMFJ6e0OZqF4qDKaL6nHykn7kK2aTS3LPzNRAKoSZrdRd0EGqEWmmCzC7mdjlymY49kRaCPfz
	DWDy7ZHUsx3vbwexFTdfiQmA1eETts1eOKEQ3ZEZQGKATrS8/tLajxLOj23i053P17g==
X-Gm-Gg: ASbGncsK6VuOjLtJwVVlfREkrarqWtGeztL7t/JXN5hEVOylvG6LYVhOTU776PDSJXz
	+pOl1ZHo1SFK+ZI5HjwbXTh1icD4VCa1rBbSPqqWwEDMFW/ZbpctUsCn3czIafZtyu1coKA4DVn
	TfSikJGri709oXSF8MRtkX0gaDLoj/ejZS2a9cTJV9EQ/Xi8M6mXKWJ7d7QPhKBIU45U0/31jtj
	krvGZMsbgsqPOAoznTG28CusMVohkZwHmnPjPipvmjtdJvH2l5oM4QsSmvnhrY8wlmJsryp2yEs
	atCcfVnt1MHVzTx34Sg6rnad/Z13W9cWW9hhsvM15pZRVy6/m94+K3TDZm/9KvT1mQ==
X-Received: by 2002:a05:6a20:431d:b0:243:78a:82b0 with SMTP id adf61e73a8af0-25347571753mr29349701637.56.1757602536734;
        Thu, 11 Sep 2025 07:55:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDXaEgoMJ/P72C88e/lPunSgbJvGLitgP+i6ER1bxNffIZ0+r2UZUYuFGf0K4MlnxSeqz55g==
X-Received: by 2002:a05:6a20:431d:b0:243:78a:82b0 with SMTP id adf61e73a8af0-25347571753mr29349661637.56.1757602536070;
        Thu, 11 Sep 2025 07:55:36 -0700 (PDT)
Received: from hu-nlaad-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c47260sm2404640b3a.94.2025.09.11.07.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 07:55:35 -0700 (PDT)
From: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 20:25:27 +0530
Subject: [PATCH] drm/bridge: add support for lontium lt9211c bridge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-lt9211c-bridge-support-v1-1-c221202cbcd5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAN7iwmgC/12Ny2rDMBBFf8VoXYUZ+aHIhNL/KFmMpFEriGNHY
 4dCyL9XSbrqZuDcy5x7U8Ils6ixuanC1yx5PlfAt0aFbzp/sc6xsjJgenCI+rQ6gxi0LznWVrZ
 lmcuqnQGXbAh2cFbV56Vwyj9P8efxxYUvW/Wvr1BNLEJP/9gc/vSgKcb/E1fUqLtkWttBYgT8m
 EV2l41OYZ6mXT3vj0VPwvqR5HVsUg/eDc5TouTNHoHAptYO7d62PYQuQLSGDKrj/f4L90Fh/gQ
 BAAA=
X-Change-ID: 20250911-lt9211c-bridge-support-9209f7cc7697
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        venkata.valluru@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
        Yi Zhang <zhanyi@qti.qualcomm.com>,
        Nilesh Laad <nilesh.laad@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757602531; l=31390;
 i=nilesh.laad@oss.qualcomm.com; s=20250718; h=from:subject:message-id;
 bh=4xE0U1XTqvTM34boFbCtAHKvZeKGvifMpb3upBO7lE8=;
 b=3K0x+eG1/nBZxTmg7PXykzkH5zStwKgRw1qnlJRf3sB3zzkUtO5XzN7+e6ugfs5bBGseHq5Qu
 rKwRI4kfcAeBgE+E6TrhNoyvbbHmM1gyWLXMIqQND7JBUO9wPgnLEH/
X-Developer-Key: i=nilesh.laad@oss.qualcomm.com; a=ed25519;
 pk=MjLHvGipC16awutyYh0FnLpT1nPxL/Cs1dCevHMrrD4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX9KffmUCAmhyY
 9bcerKeAIbuDih0b0rMEMZDQwxHD/IxtH2cvZROrft3BVioYO3BuNvzHFwuCMlsIGmjj0mKGwBa
 Eo69dJ9H1LF1sO91wjFDPG4LRArG0l0Ak6PFkqXuhcW1nfP8Y9CKZf2q82pg3XUlEsRkbDJdrGR
 ZevMJpJAv2rrm8rQ0vL32tDYiOjsnEg8o888B5Bf6lfgDis6nEdaLG743vVKR+l+XTBtf0YoXjM
 vafeo1YKPYu6VPugTUJnZkG3Pvp5qcik1QdvCQVgGW486lvAlFIrULn6L7E4ZMJwmtnmIew3uNt
 2xP1B+MnkHQpDqA5thaqHGwrgSQfSkB8EgoFVj9GsqCsH2HGMmwgp/uwwhJtk7Ss/zv1Tgss82y
 3b8vLHe6
X-Proofpoint-ORIG-GUID: 6GivZu8um486iPpT3Ey7n52KwYUJL6lO
X-Proofpoint-GUID: 6GivZu8um486iPpT3Ey7n52KwYUJL6lO
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c2e2ea cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=8QlUORy2qNFl4_zbHzYA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

From: Yi Zhang <zhanyi@qti.qualcomm.com>

LT9211c is a Single/Dual-Link DSI/LVDS or Single DPI input to
Single-link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
Add support for DSI to LVDS bridge configuration.

Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/Kconfig           |   13 +
 drivers/gpu/drm/bridge/Makefile          |    1 +
 drivers/gpu/drm/bridge/lontium-lt9211c.c | 1105 ++++++++++++++++++++++++++++++
 3 files changed, 1119 insertions(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index a250afd8d662..d07f426b1096 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -154,6 +154,19 @@ config DRM_LONTIUM_LT9211
 	  chip.
 	  Please say Y if you have such hardware.
 
+config DRM_LONTIUM_LT9211C
+	tristate "Lontium LT9211C DSI/LVDS/DPI bridge"
+	depends on OF
+	select DRM_PANEL_BRIDGE
+	select DRM_KMS_HELPER
+	select DRM_MIPI_DSI
+	select REGMAP_I2C
+	help
+	  Driver for Lontium LT9211C Single/Dual-Link DSI/LVDS or Single DPI
+	  input to Single-link/Dual-Link DSI/LVDS or Single DPI output bridge
+	  chip.
+	  Please say Y if you have such hardware.
+
 config DRM_LONTIUM_LT9611
 	tristate "Lontium LT9611 DSI/HDMI bridge"
 	select SND_SOC_HDMI_CODEC if SND_SOC
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index c7dc03182e59..b74d54f1a395 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_DRM_ITE_IT6263) += ite-it6263.o
 obj-$(CONFIG_DRM_ITE_IT6505) += ite-it6505.o
 obj-$(CONFIG_DRM_LONTIUM_LT8912B) += lontium-lt8912b.o
 obj-$(CONFIG_DRM_LONTIUM_LT9211) += lontium-lt9211.o
+obj-$(CONFIG_DRM_LONTIUM_LT9211C) += lontium-lt9211c.o
 obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
 obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) += lontium-lt9611uxc.o
 obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
diff --git a/drivers/gpu/drm/bridge/lontium-lt9211c.c b/drivers/gpu/drm/bridge/lontium-lt9211c.c
new file mode 100644
index 000000000000..8702fdbdf382
--- /dev/null
+++ b/drivers/gpu/drm/bridge/lontium-lt9211c.c
@@ -0,0 +1,1105 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/media-bus-format.h>
+#include <linux/module.h>
+#include <linux/of_graph.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/workqueue.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
+
+#define REG_PAGE_CONTROL			0xff
+#define REG_CHIPID0				0x8100
+#define REG_CHIPID0_VALUE			0x21
+#define REG_CHIPID1				0x8101
+#define REG_CHIPID1_VALUE			0x03
+#define REG_CHIPID2				0x8102
+#define REG_CHIPID2_VALUE			0xe1
+
+#define REG_DSI_LANE				0xd000
+/* DSI lane count - 0 means 4 lanes ; 1, 2, 3 means 1, 2, 3 lanes. */
+#define REG_DSI_LANE_COUNT(n)			((n) & 3)
+
+struct lt9211c {
+	struct drm_bridge		bridge;
+	struct device			*dev;
+	struct regmap			*regmap;
+	struct mipi_dsi_device		*dsi;
+	struct drm_bridge		*panel_bridge;
+	struct gpio_desc		*reset_gpio;
+	struct regulator		*vccio;
+	bool				lvds_dual_link;
+	bool				lvds_dual_link_even_odd_swap;
+	struct workqueue_struct *wq;
+	struct delayed_work lt9211c_dw;
+	struct drm_display_mode mode;
+	bool bpp24;
+	bool jeida;
+	bool de;
+};
+
+static const struct regmap_range lt9211c_rw_ranges[] = {
+	regmap_reg_range(0xff, 0xff),
+	regmap_reg_range(0x8100, 0x8182),
+	regmap_reg_range(0x8200, 0x82aa),
+	regmap_reg_range(0x8500, 0x85ff),
+	regmap_reg_range(0x8600, 0x86a0),
+	regmap_reg_range(0x8700, 0x8746),
+	regmap_reg_range(0xd000, 0xd0a7),
+	regmap_reg_range(0xd400, 0xd42c),
+	regmap_reg_range(0xd800, 0xd838),
+	regmap_reg_range(0xd9c0, 0xd9d5),
+};
+
+static const struct regmap_access_table lt9211c_rw_table = {
+	.yes_ranges = lt9211c_rw_ranges,
+	.n_yes_ranges = ARRAY_SIZE(lt9211c_rw_ranges),
+};
+
+static const struct regmap_range_cfg lt9211c_range = {
+	.name = "lt9211c",
+	.range_min = 0x0000,
+	.range_max = 0xda00,
+	.selector_reg = REG_PAGE_CONTROL,
+	.selector_mask = 0xff,
+	.selector_shift = 0,
+	.window_start = 0,
+	.window_len = 0x100,
+};
+
+static const struct regmap_config lt9211c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.rd_table = &lt9211c_rw_table,
+	.wr_table = &lt9211c_rw_table,
+	.volatile_table	= &lt9211c_rw_table,
+	.ranges = &lt9211c_range,
+	.num_ranges = 1,
+	.cache_type = REGCACHE_RBTREE,
+	.max_register = 0xda00,
+};
+
+static struct lt9211c *bridge_to_lt9211c(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct lt9211c, bridge);
+}
+
+static int lt9211c_attach(struct drm_bridge *bridge,
+			struct drm_encoder *encoder,
+			enum drm_bridge_attach_flags flags)
+{
+	struct lt9211c *ctx = bridge_to_lt9211c(bridge);
+
+	return drm_bridge_attach(encoder, ctx->panel_bridge,
+				&ctx->bridge, flags);
+}
+
+static int lt9211c_read_chipid(struct lt9211c *ctx)
+{
+	u8 chipid[3];
+	int ret;
+
+	/* Read Chip ID registers and verify the chip can communicate. */
+	ret = regmap_bulk_read(ctx->regmap, REG_CHIPID0, chipid, 3);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to read Chip ID: %d\n", ret);
+		return ret;
+	}
+
+	/* Test for known Chip ID. */
+	if (chipid[0] != REG_CHIPID0_VALUE || chipid[1] != REG_CHIPID1_VALUE ||
+	    chipid[2] != REG_CHIPID2_VALUE) {
+		dev_err(ctx->dev, "Unknown Chip ID: 0x%02x 0x%02x 0x%02x\n",
+			chipid[0], chipid[1], chipid[2]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int lt9211c_configure_rx(struct lt9211c *ctx)
+{
+	unsigned int pval;
+
+	const struct reg_sequence lt9211c_rx_phy_seq[] = {
+		{ REG_DSI_LANE, REG_DSI_LANE_COUNT(ctx->dsi->lanes) },
+		{ 0x8201, 0x11 },
+		{ 0x8218, 0x48 },
+		{ 0x8201, 0x91 },
+		{ 0x8202, 0x00 },
+		{ 0x8203, 0xee },
+		{ 0x8209, 0x21 },
+		{ 0x8204, 0x44 },
+		{ 0x8205, 0xc4 },
+		{ 0x8206, 0x44 },
+		{ 0x8213, 0x0c },
+
+		{ 0xd001, 0x00 },
+		{ 0xd002, 0x0e },
+		{ 0xd005, 0x00 },
+		{ 0xd00a, 0x59 },
+		{ 0xd00b, 0x20 },
+	};
+
+	const struct reg_sequence lt9211c_rx_phy_reset_seq[] = {
+		{ 0x8109, 0xde },
+		{ 0x8109, 0xdf },
+	};
+
+	const struct reg_sequence lt9211c_rx_clk_sel_seq[] = {
+		{ 0x85e9, 0x88 },
+		{ 0x8180, 0x51 },
+		{ 0x8181, 0x10 },
+		{ 0x8632, 0x03 },
+	};
+
+	const struct reg_sequence lt9211c_rx_input_sel_seq[] = {
+		{ 0xd004, 0x00 },
+		{ 0xd021, 0x46 },
+	};
+
+	const struct reg_sequence lt9211c_rx_dig_seq[] = {
+		{ 0x853f, 0x08 },
+		{ 0x8540, 0x04 },
+		{ 0x8541, 0x03 },
+		{ 0x8542, 0x02 },
+		{ 0x8543, 0x01 },
+		{ 0x8545, 0x04 },
+		{ 0x8546, 0x03 },
+		{ 0x8547, 0x02 },
+		{ 0x8548, 0x01 },
+		{ 0x8544, 0x00 },
+		{ 0x8549, 0x00 },
+	};
+
+	int ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_phy_seq,
+				     ARRAY_SIZE(lt9211c_rx_phy_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_phy_reset_seq,
+				     ARRAY_SIZE(lt9211c_rx_phy_reset_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_clk_sel_seq,
+				     ARRAY_SIZE(lt9211c_rx_clk_sel_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_read(ctx->regmap, 0x8180, &pval);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x8180, (pval & 0xfc | 0x03));
+	if (ret)
+		return ret;
+
+	ret = regmap_read(ctx->regmap, 0x8680, &pval);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x863f, (pval & 0xf8));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x863f, 0x05);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(ctx->regmap, 0x8530, &pval);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x8530, (pval & 0xf8 | 0x11));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_input_sel_seq,
+				     ARRAY_SIZE(lt9211c_rx_input_sel_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_dig_seq,
+				     ARRAY_SIZE(lt9211c_rx_dig_seq));
+	if (ret)
+		return ret;
+
+	/* Give the chip time to lock onto RX stream. */
+	msleep(100);
+
+	return 0;
+}
+
+static int lt9211c_autodetect_rx(struct lt9211c *ctx,
+				const struct drm_display_mode *mode)
+{
+	u16 width, height;
+	u8 buf[5];
+	u8 format;
+	u8 bc[3];
+	u8 sot[8];
+	int ret;
+
+	/* Read the SOT from the chip. */
+	ret = regmap_bulk_read(ctx->regmap, 0xd088, sot, sizeof(sot));
+	if (ret)
+		return ret;
+
+	dev_dbg(ctx->dev, "Sot Num = 0x%02x, 0x%02x, 0x%02x, 0x%02x\n",
+		sot[0], sot[2], sot[4], sot[6]);
+
+	dev_dbg(ctx->dev, "Sot Data = 0x%02x, 0x%02x, 0x%02x, 0x%02x\n",
+		sot[1], sot[3], sot[5], sot[7]);
+
+	/* HS Settle Set */
+	if ((sot[0] > 0x10) && (sot[0] < 0x50))
+		regmap_write(ctx->regmap, 0xd002, sot[0] - 5);
+	else
+		regmap_write(ctx->regmap, 0xd002, 0x08);
+
+	/* Width/Height/Format Auto-detection */
+	ret = regmap_bulk_read(ctx->regmap, 0xd082, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	width = (buf[0] << 8) | buf[1];
+	height = (buf[3] << 8) | buf[4];
+	format = buf[2] & 0xf;
+
+	if (format == 0x3) {		/* YUV422 16bit */
+		width /= 2;
+	} else if (format == 0xa) {	/* RGB888 24bit */
+		width /= 3;
+	} else {
+		dev_err(ctx->dev, "Unsupported DSI format 0x%01x\n",
+			format);
+		return -EINVAL;
+	}
+
+	if (width != mode->hdisplay) {
+		dev_err(ctx->dev,
+			"RX: Detected DSI width (%d) does not match mode hdisplay (%d)\n",
+			width, mode->hdisplay);
+		return -EINVAL;
+	}
+
+	if (height != mode->vdisplay) {
+		dev_err(ctx->dev,
+			"RX: Detected DSI height (%d) does not match mode vdisplay (%d)\n",
+			height, mode->vdisplay);
+		return -EINVAL;
+	}
+
+	dev_dbg(ctx->dev, "RX: %dx%d format=0x%01x\n",
+		width, height, format);
+
+	return 0;
+}
+
+static int lt9211c_configure_timing(struct lt9211c *ctx,
+				   const struct drm_display_mode *mode)
+{
+	const struct reg_sequence lt9211c_timing[] = {
+		{ 0xd00d, (mode->vtotal >> 8) & 0xff },
+		{ 0xd00e, mode->vtotal & 0xff },
+		{ 0xd00f, (mode->vdisplay >> 8) & 0xff },
+		{ 0xd010, mode->vdisplay & 0xff },
+		{ 0xd011, (mode->htotal >> 8) & 0xff },
+		{ 0xd012, mode->htotal & 0xff },
+		{ 0xd013, (mode->hdisplay >> 8) & 0xff },
+		{ 0xd014, mode->hdisplay & 0xff },
+		{ 0xd015, (mode->vsync_end - mode->vsync_start) & 0xff },
+		{ 0xd04c, ((mode->hsync_end - mode->hsync_start) >> 8) & 0xff },
+		{ 0xd016, (mode->hsync_end - mode->hsync_start) & 0xff },
+		{ 0xd017, ((mode->vsync_start - mode->vdisplay) >> 8) & 0xff },
+		{ 0xd018, (mode->vsync_start - mode->vdisplay) & 0xff },
+		{ 0xd019, ((mode->hsync_start - mode->hdisplay) >> 8) & 0xff },
+		{ 0xd01a, (mode->hsync_start - mode->hdisplay) & 0xff },
+	};
+
+	return regmap_multi_reg_write(ctx->regmap, lt9211c_timing,
+				      ARRAY_SIZE(lt9211c_timing));
+}
+
+static int lt9211c_configure_plls(struct lt9211c *ctx,
+				 const struct drm_display_mode *mode)
+{
+	const struct reg_sequence lt9211c_dessc_pll_reset[] = {
+		{ 0x8103, 0xfe, 2000 },
+		{ 0x8103, 0xff, 0 },
+	};
+
+	const struct reg_sequence lt9211c_pcr_cali_seq[] = {
+		{ 0xd00a, 0x5f },
+		{ 0xd01e, 0x51 },
+		{ 0xd023, 0x80 },
+		{ 0xd024, 0x70 },
+		{ 0xd025, 0x80 },
+		{ 0xd02a, 0x10 },
+		{ 0xd021, 0x4f },
+		{ 0xd022, 0xf0 },
+		{ 0xd038, 0x04 },
+		{ 0xd039, 0x08 },
+		{ 0xd03a, 0x10 },
+		{ 0xd03b, 0x20 },
+		{ 0xd03f, 0x04 },
+		{ 0xd040, 0x08 },
+		{ 0xd041, 0x10 },
+		{ 0xd042, 0x20 },
+		{ 0xd02b, 0xA0 },
+	};
+
+	const struct reg_sequence lt9211c_pcr_reset_seq[] = {
+		{ 0xd009, 0xdb },
+		{ 0xd009, 0xdf },
+		{ 0xd008, 0x80 },
+		{ 0xd008, 0x00 },
+	};
+
+	unsigned int pval;
+	int ret;
+	u8 div;
+	u32 pcr_m;
+	u32 pcr_k;
+	u32 pcr_up;
+	u32 pcr_down;
+
+	/* DeSSC PLL reference clock is 25 MHz XTal. */
+	ret = regmap_write(ctx->regmap, 0x8226, 0x20);
+	if (ret)
+		return ret;
+
+	/* Prediv = 0 */
+	ret = regmap_write(ctx->regmap, 0x8227, 0x40);
+	if (ret)
+		return ret;
+
+	if (mode->clock < 22000) {
+		ret = regmap_write(ctx->regmap, 0x822f, 0x07);
+		ret |= regmap_write(ctx->regmap, 0x822c, 0x01);
+		div = 16;
+	} else if (mode->clock < 44000) {
+		ret = regmap_write(ctx->regmap, 0x822f, 0x07);
+		div = 16;
+	} else if (mode->clock < 88000) {
+		ret = regmap_write(ctx->regmap, 0x822f, 0x06);
+		div = 8;
+	} else if (mode->clock < 176000) {
+		ret = regmap_write(ctx->regmap, 0x822f, 0x05);
+		div = 4;
+	} else {
+		ret = regmap_write(ctx->regmap, 0x822f, 0x04);
+		div = 2;
+	}
+
+	if (ret)
+		return ret;
+
+	pcr_m = (mode->clock * div) / 25;
+	pcr_k = pcr_m % 1000;
+	pcr_m /= 1000;
+
+	pcr_up = pcr_m + 1;
+	pcr_down = pcr_m - 1;
+
+	pcr_k <<= 14;
+
+	ret = regmap_write(ctx->regmap, 0xd008, 0x00);
+	if (ret < 0)
+		return ret;
+
+	/* 0xd026: pcr_m */
+	ret = regmap_write(ctx->regmap, 0xd026, (0x80 | (u8)pcr_m) & 0x7f);
+	if (ret < 0)
+		return ret;
+
+	/* 0xd027 0xd028 0xd029: pcr_k */
+	ret = regmap_write(ctx->regmap, 0xd027, (pcr_k >> 16) & 0xff);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0xd028, (pcr_k >> 8) & 0xff);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0xd029, pcr_k & 0xff);
+	if (ret < 0)
+		return ret;
+
+	/* 0xd02d: pcr_m overflow limit setting */
+	ret = regmap_write(ctx->regmap, 0xd02d, pcr_up);
+	if (ret < 0)
+		return ret;
+
+	/* 0xd031: pcr_m underflow limit setting */
+	ret = regmap_write(ctx->regmap, 0xd031, pcr_down);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_dessc_pll_reset,
+				     ARRAY_SIZE(lt9211c_dessc_pll_reset));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_pcr_cali_seq,
+				     ARRAY_SIZE(lt9211c_pcr_cali_seq));
+	if (ret)
+		return ret;
+
+	if (mode->clock < 44000) {
+		ret = regmap_write(ctx->regmap, 0xd00c, 0x60);
+		ret |= regmap_write(ctx->regmap, 0xd01b, 0x00);
+		ret |= regmap_write(ctx->regmap, 0xd01c, 0x60);
+	} else {
+		ret = regmap_write(ctx->regmap, 0xd00c, 0x40);
+		ret |= regmap_write(ctx->regmap, 0xd01b, 0x00);
+		ret |= regmap_write(ctx->regmap, 0xd01c, 0x40);
+	}
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_pcr_reset_seq,
+				     ARRAY_SIZE(lt9211c_pcr_reset_seq));
+	if (ret)
+		return ret;
+
+
+	/* PCR stability test takes seconds. */
+	ret = regmap_read_poll_timeout(ctx->regmap, 0xd087, pval, ((pval & 0x18) == 0x18),
+				       20000, 3000000);
+	if (ret)
+		dev_err(ctx->dev, "PCR unstable, ret=%i\n", ret);
+
+	ret = regmap_write(ctx->regmap, 0x8180, 0x51);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x863f, 0x00);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x863f, 0x01);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(ctx->regmap, 0x8640, pval, ((pval & 0x01) == 0x01),
+				       50000, 250000);
+	if (ret)
+		dev_err(ctx->dev, "Video check not stable, ret=%i\n", ret);
+
+	return ret;
+}
+
+static int lt9211c_configure_tx(struct lt9211c *ctx,
+				 const struct drm_display_mode *mode)
+{
+	const struct reg_sequence lt9211c_tx_phy_off_seq[] = {
+		{ 0x8236, 0x00 },
+		{ 0x8237, 0x00 },
+		{ 0x8108, 0x6f },
+		{ 0x8103, 0xbf },
+	};
+
+	const struct reg_sequence lt9211c_tx_phy_seq[] = {
+		{ 0x8236, 0x03 },
+		{ 0x8237, 0x44 },
+		{ 0x8238, 0x14 },
+		{ 0x8239, 0x31 },
+		{ 0x823a, 0xc8 },
+		{ 0x823b, 0x00 },
+		{ 0x823c, 0x0f },
+		{ 0x8246, 0x40 },
+		{ 0x8247, 0x40 },
+		{ 0x8248, 0x40 },
+		{ 0x8249, 0x40 },
+		{ 0x824a, 0x40 },
+		{ 0x824b, 0x40 },
+		{ 0x824c, 0x40 },
+		{ 0x824d, 0x40 },
+		{ 0x824e, 0x40 },
+		{ 0x824f, 0x40 },
+		{ 0x8250, 0x40 },
+		{ 0x8251, 0x40 },
+	};
+
+	const struct reg_sequence lt9211c_tx_mltx_reset[] = {
+		{ 0x8103, 0xbf },
+		{ 0x8103, 0xff },
+	};
+
+	const struct reg_sequence lt9211c_tx_dig_seq[] = {
+		{ 0x854a, 0x01 },
+		{ 0x854b, 0x00 },
+		{ 0x854c, 0x10 },
+		{ 0x854d, 0x20 },
+		{ 0x854e, 0x50 },
+		{ 0x854f, 0x30 },
+		{ 0x8550, 0x46 },
+		{ 0x8551, 0x10 },
+		{ 0x8552, 0x20 },
+		{ 0x8553, 0x50 },
+		{ 0x8554, 0x30 },
+		{ 0x8555, 0x00 },
+		{ 0x8556, 0x20 },
+
+		{ 0x8568, 0x00 },
+		{ 0x856e, 0x10 | (ctx->de ? BIT(6) : 0)},
+		{ 0x856f, 0x81 | (ctx->jeida ? BIT(6) : 0) |
+			  (ctx->lvds_dual_link ? BIT(4) : 0) |
+			  (ctx->bpp24 ? BIT(2) : 0)},
+	};
+
+	const struct reg_sequence lt9211c_tx_ssc_seq[] = {
+		{ 0x8234, 0x00 },
+		{ 0x856e, 0x10 },
+		{ 0x8181, 0x15 },
+		{ 0x871e, 0x00 },
+		{ 0x8717, 0x02 },
+		{ 0x8718, 0x04 },
+		{ 0x8719, 0xd4 },
+		{ 0x871A, 0x00 },
+		{ 0x871B, 0x12 },
+		{ 0x871C, 0x00 },
+		{ 0x871D, 0x24 },
+		{ 0x871F, 0x1c },
+		{ 0x8720, 0x00 },
+		{ 0x8721, 0x00 },
+		{ 0x871e, 0x02 },
+	};
+
+	const struct reg_sequence lt9211c_tx_pll_reset_seq[] = {
+		{ 0x810c, 0xfe, 2000 },
+		{ 0x810c, 0xff, 0 },
+	};
+
+	const struct reg_sequence lt9211c_tx_sw_reset_seq[] = {
+		{ 0x8108, 0x6f, 2000 },
+		{ 0x8108, 0x7f, 0 },
+	};
+
+	unsigned int pval;
+	int ret;
+	u32 phy_clk;
+	u8 pixclk_div;
+	u8 pre_div;
+	u8 div_set;
+	u8 sericlk_div;
+	u8 val;
+
+	dev_info(ctx->dev, "dual_link=%d,even_odd_swap=%d,bpp24=%d,jeida=%d,de=%d\n",
+		  ctx->lvds_dual_link,
+		  ctx->lvds_dual_link_even_odd_swap,
+		  ctx->bpp24,
+		  ctx->jeida,
+		  ctx->de);
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_phy_off_seq,
+				     ARRAY_SIZE(lt9211c_tx_phy_off_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_read(ctx->regmap, 0x8530, &pval);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x8530, (pval & 0x3f | 0x40));
+	if (ret)
+		return ret;
+
+	/* [7]0:txpll normal work; txpll ref clk sel pix clk */
+	ret = regmap_write(ctx->regmap, 0x8230, 0x00);
+	if (ret)
+		return ret;
+
+	if (ctx->lvds_dual_link)
+		phy_clk = (u32)(mode->clock * 7 / 2);
+	else
+		phy_clk = (u32)(mode->clock * 7);
+
+	/* 0x8231: prediv sel */
+	if (mode->clock < 20000) {
+		val = 0x28;
+		pre_div = 1;
+	} else if (mode->clock < 40000) {
+		val = 0x28;
+		pre_div = 1;
+	} else if (mode->clock < 80000) {
+		val = 0x29;
+		pre_div = 2;
+	} else if (mode->clock < 160000) {
+		val = 0x2a;
+		pre_div = 4;
+	} else if (mode->clock < 320000) {
+		val = 0x2b;
+		pre_div = 8;
+	} else {
+		val = 0x2f;
+		pre_div = 16;
+	}
+	ret = regmap_write(ctx->regmap, 0x8231, val);
+	if (ret < 0)
+		return ret;
+
+	/* 0x8232: serickdiv sel */
+	if (phy_clk < 80000) {
+		val = 0x32;
+		sericlk_div = 16;
+	} else if (phy_clk < 160000) {
+		val = 0x22;
+		sericlk_div = 8;
+	} else if (phy_clk < 320000) {
+		val = 0x12;
+		sericlk_div = 4;
+	} else if (phy_clk < 640000) {
+		val = 0x02;
+		sericlk_div = 2;
+	} else {
+		val = 0x42;
+		sericlk_div = 1;
+	}
+	ret = regmap_write(ctx->regmap, 0x8232, val);
+	if (ret < 0)
+		return ret;
+
+	/* 0x8233: pix_mux sel & pix_div sel
+	 * To avoid floating point operations, The pixclk_div is enlarged by 10 times
+	 */
+	if (mode->clock > 150000) {
+		val = 0x04;
+		pixclk_div = 35;
+	} else {
+		pixclk_div = (u8)((phy_clk * sericlk_div * 10) / (mode->clock * 7));
+		if (pixclk_div <= 10)
+			val = 0x00;
+		else if (pixclk_div <= 20)
+			val = 0x01;
+		else if (pixclk_div <= 40)
+			val = 0x02;
+		else
+			val = 0x03;
+	}
+	ret = regmap_write(ctx->regmap, 0x8233, val);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x8234, 0x01);
+	if (ret < 0)
+		return ret;
+
+	/* 0x8235: div set */
+	div_set = (u8)(phy_clk * sericlk_div / mode->clock / pre_div);
+	ret = regmap_write(ctx->regmap, 0x8235, div_set);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_ssc_seq,
+				     ARRAY_SIZE(lt9211c_tx_ssc_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_pll_reset_seq,
+				     ARRAY_SIZE(lt9211c_tx_pll_reset_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(ctx->regmap, 0x8739, pval, pval & 0x04,
+				       10000, 1000000);
+	if (ret) {
+		dev_err(ctx->dev, "TX PLL unstable, ret=%i\n", ret);
+		return ret;
+	}
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_phy_seq,
+				     ARRAY_SIZE(lt9211c_tx_phy_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_mltx_reset,
+				     ARRAY_SIZE(lt9211c_tx_mltx_reset));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_dig_seq,
+				     ARRAY_SIZE(lt9211c_tx_dig_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_sw_reset_seq,
+				     ARRAY_SIZE(lt9211c_tx_sw_reset_seq));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void lt9211c_delayed_work_func(struct work_struct *work)
+{
+	struct delayed_work *dw = to_delayed_work(work);
+	struct lt9211c *ctx = container_of(dw, struct lt9211c, lt9211c_dw);
+	int ret;
+	const struct drm_display_mode *mode = &ctx->mode;
+
+	ret = lt9211c_configure_rx(ctx);
+	if (ret)
+		return;
+
+	ret = lt9211c_autodetect_rx(ctx, mode);
+	if (ret)
+		return;
+
+	ret = lt9211c_configure_timing(ctx, mode);
+	if (ret)
+		return;
+
+	ret = lt9211c_configure_plls(ctx, mode);
+	if (ret)
+		return;
+
+	ret = lt9211c_configure_tx(ctx, mode);
+	if (ret)
+		return;
+}
+
+static void lt9211c_atomic_enable(struct drm_bridge *bridge,
+				struct drm_atomic_state *state)
+{
+	struct lt9211c *ctx = bridge_to_lt9211c(bridge);
+	const struct drm_bridge_state *bridge_state;
+	const struct drm_crtc_state *crtc_state;
+	struct drm_connector *connector;
+	struct drm_crtc *crtc;
+	u32 bus_flags;
+	int ret;
+
+	ret = regulator_enable(ctx->vccio);
+	if (ret) {
+		dev_err(ctx->dev, "Failed to enable vccio: %d\n", ret);
+		return;
+	}
+
+	/* Deassert reset */
+	gpiod_set_value(ctx->reset_gpio, 1);
+	usleep_range(20000, 21000);	/* Very long post-reset delay. */
+
+	/* Get the LVDS format from the bridge state. */
+	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
+	bus_flags = bridge_state->output_bus_cfg.flags;
+	ctx->de = !!(bus_flags & DRM_BUS_FLAG_DE_HIGH);
+
+	switch (bridge_state->output_bus_cfg.format) {
+	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
+		ctx->bpp24 = false;
+		ctx->jeida = true;
+		break;
+	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
+		ctx->bpp24 = true;
+		ctx->jeida = true;
+		break;
+	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
+		ctx->bpp24 = true;
+		ctx->jeida = false;
+		break;
+	default:
+		/*
+		 * Some bridges still don't set the correct
+		 * LVDS bus format, use SPWG24 default
+		 * format until those are fixed.
+		 */
+		ctx->bpp24 = true;
+		ctx->jeida = false;
+		dev_warn(ctx->dev,
+			 "Unsupported LVDS bus format 0x%04x\n",
+			 bridge_state->output_bus_cfg.format);
+		break;
+	}
+
+	/*
+	 * Retrieve the CRTC adjusted mode. This requires a little dance to go
+	 * from the bridge to the encoder, to the connector and to the CRTC.
+	 */
+	connector = drm_atomic_get_new_connector_for_encoder(state,
+							     bridge->encoder);
+	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	drm_mode_copy(&ctx->mode, &crtc_state->adjusted_mode);
+
+	dev_dbg(ctx->dev, "width=%d,height=%d,clock=%d\n",
+			ctx->mode.hdisplay,
+			ctx->mode.vdisplay,
+			ctx->mode.clock);
+
+	ret = lt9211c_read_chipid(ctx);
+	if (ret)
+		return;
+
+	/* Lt9211c must enable after mipi clock enable */
+	queue_delayed_work(ctx->wq, &ctx->lt9211c_dw,
+		msecs_to_jiffies(100));
+
+	dev_dbg(ctx->dev, "LT9211 enabled.\n");
+}
+
+static void lt9211c_atomic_disable(struct drm_bridge *bridge,
+				struct drm_atomic_state *state)
+{
+	struct lt9211c *ctx = bridge_to_lt9211c(bridge);
+	int ret;
+
+	/*
+	 * Put the chip in reset, pull nRST line low,
+	 * and assure lengthy 10ms reset low timing.
+	 */
+	gpiod_set_value(ctx->reset_gpio, 0);
+	usleep_range(10000, 11000);	/* Very long reset duration. */
+
+	ret = regulator_disable(ctx->vccio);
+	if (ret)
+		dev_err(ctx->dev, "Failed to disable vccio: %d\n", ret);
+
+	regcache_mark_dirty(ctx->regmap);
+}
+
+static enum drm_mode_status
+lt9211c_mode_valid(struct drm_bridge *bridge,
+		  const struct drm_display_info *info,
+		  const struct drm_display_mode *mode)
+{
+	/* LVDS output clock range 25..176 MHz */
+	if (mode->clock < 25000)
+		return MODE_CLOCK_LOW;
+	if (mode->clock > 176000)
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
+#define MAX_INPUT_SEL_FORMATS	1
+
+static u32 *
+lt9211c_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
+				 struct drm_bridge_state *bridge_state,
+				 struct drm_crtc_state *crtc_state,
+				 struct drm_connector_state *conn_state,
+				 u32 output_fmt,
+				 unsigned int *num_input_fmts)
+{
+	u32 *input_fmts;
+
+	*num_input_fmts = 0;
+
+	input_fmts = kcalloc(MAX_INPUT_SEL_FORMATS, sizeof(*input_fmts),
+			     GFP_KERNEL);
+	if (!input_fmts)
+		return NULL;
+
+	/* This is the DSI-end bus format */
+	input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
+	*num_input_fmts = 1;
+
+	return input_fmts;
+}
+
+static const struct drm_bridge_funcs lt9211c_funcs = {
+	.attach			= lt9211c_attach,
+	.mode_valid		= lt9211c_mode_valid,
+	.atomic_enable		= lt9211c_atomic_enable,
+	.atomic_disable		= lt9211c_atomic_disable,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
+	.atomic_get_input_bus_fmts = lt9211c_atomic_get_input_bus_fmts,
+	.atomic_reset		= drm_atomic_helper_bridge_reset,
+};
+
+static int lt9211c_parse_dt(struct lt9211c *ctx)
+{
+	struct device_node *port2, *port3;
+	struct drm_bridge *panel_bridge;
+	struct device *dev = ctx->dev;
+	struct drm_panel *panel;
+	int dual_link;
+	int ret;
+
+	ctx->vccio = devm_regulator_get(dev, "vccio");
+	if (IS_ERR(ctx->vccio))
+		return dev_err_probe(dev, PTR_ERR(ctx->vccio),
+				     "Failed to get supply 'vccio'\n");
+
+	ctx->lvds_dual_link = false;
+	ctx->lvds_dual_link_even_odd_swap = false;
+
+	port2 = of_graph_get_port_by_id(dev->of_node, 2);
+	port3 = of_graph_get_port_by_id(dev->of_node, 3);
+	dual_link = drm_of_lvds_get_dual_link_pixel_order(port2, port3);
+	of_node_put(port2);
+	of_node_put(port3);
+
+	if (dual_link == DRM_LVDS_DUAL_LINK_ODD_EVEN_PIXELS) {
+		ctx->lvds_dual_link = true;
+		/* Odd pixels to LVDS Channel A, even pixels to B */
+		ctx->lvds_dual_link_even_odd_swap = false;
+	} else if (dual_link == DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS) {
+		ctx->lvds_dual_link = true;
+		/* Even pixels to LVDS Channel A, odd pixels to B */
+		ctx->lvds_dual_link_even_odd_swap = true;
+	}
+
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 2, 0, &panel, &panel_bridge);
+	if (ret < 0)
+		return ret;
+	if (panel) {
+		panel_bridge = devm_drm_panel_bridge_add(dev, panel);
+		if (IS_ERR(panel_bridge))
+			return PTR_ERR(panel_bridge);
+	}
+
+	ctx->panel_bridge = panel_bridge;
+
+	return 0;
+}
+
+static int lt9211c_host_attach(struct lt9211c *ctx)
+{
+	const struct mipi_dsi_device_info info = {
+		.type = "lt9211c",
+		.channel = 0,
+		.node = NULL,
+	};
+	struct device *dev = ctx->dev;
+	struct device_node *host_node;
+	struct device_node *endpoint;
+	struct mipi_dsi_device *dsi;
+	struct mipi_dsi_host *host;
+	int dsi_lanes;
+	int ret;
+
+	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
+	dsi_lanes = drm_of_get_data_lanes_count(endpoint, 1, 4);
+	host_node = of_graph_get_remote_port_parent(endpoint);
+	host = of_find_mipi_dsi_host_by_node(host_node);
+	of_node_put(host_node);
+	of_node_put(endpoint);
+
+	if (!host)
+		return -EPROBE_DEFER;
+
+	if (dsi_lanes < 0)
+		return dsi_lanes;
+
+	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
+	if (IS_ERR(dsi))
+		return dev_err_probe(dev, PTR_ERR(dsi),
+				     "failed to create dsi device\n");
+
+	ctx->dsi = dsi;
+
+	dsi->lanes = dsi_lanes;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
+
+	ret = devm_mipi_dsi_attach(dev, dsi);
+	if (ret < 0) {
+		dev_err(dev, "failed to attach dsi to host: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lt9211c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct lt9211c *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->dev = dev;
+
+	/*
+	 * Put the chip in reset, pull nRST line low,
+	 * and assure lengthy 10ms reset low timing.
+	 */
+	ctx->reset_gpio = devm_gpiod_get_optional(ctx->dev, "reset",
+						  GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio))
+		return PTR_ERR(ctx->reset_gpio);
+
+	usleep_range(10000, 11000);	/* Very long reset duration. */
+
+	ret = lt9211c_parse_dt(ctx);
+	if (ret)
+		return ret;
+
+	ctx->regmap = devm_regmap_init_i2c(client, &lt9211c_regmap_config);
+	if (IS_ERR(ctx->regmap))
+		return PTR_ERR(ctx->regmap);
+
+	dev_set_drvdata(dev, ctx);
+	i2c_set_clientdata(client, ctx);
+
+	ctx->bridge.funcs = &lt9211c_funcs;
+	ctx->bridge.of_node = dev->of_node;
+	drm_bridge_add(&ctx->bridge);
+
+	ret = lt9211c_host_attach(ctx);
+	if (ret)
+		drm_bridge_remove(&ctx->bridge);
+
+	ctx->wq = create_workqueue("lt9211c_work");
+	INIT_DELAYED_WORK(&ctx->lt9211c_dw, lt9211c_delayed_work_func);
+
+	return ret;
+}
+
+static void lt9211c_remove(struct i2c_client *client)
+{
+	struct lt9211c *ctx = i2c_get_clientdata(client);
+
+	cancel_delayed_work(&ctx->lt9211c_dw);
+	destroy_workqueue(ctx->wq);
+
+	drm_bridge_remove(&ctx->bridge);
+}
+
+static struct i2c_device_id lt9211c_id[] = {
+	{ "lontium,lt9211c" },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, lt9211c_id);
+
+static const struct of_device_id lt9211c_match_table[] = {
+	{ .compatible = "lontium,lt9211c" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, lt9211c_match_table);
+
+static struct i2c_driver lt9211c_driver = {
+	.probe = lt9211c_probe,
+	.remove = lt9211c_remove,
+	.id_table = lt9211c_id,
+	.driver = {
+		.name = "lt9211c",
+		.of_match_table = lt9211c_match_table,
+	},
+};
+module_i2c_driver(lt9211c_driver);
+
+MODULE_DESCRIPTION("Lontium LT9211C DSI/LVDS/DPI bridge driver");
+MODULE_LICENSE("GPL");

---
base-commit: f50b969bafafb2810a07f376387350c4c0d72a21
change-id: 20250911-lt9211c-bridge-support-9209f7cc7697
prerequisite-message-id: <20250910-add-lt9211c-bridge-v1-1-4f23740fe101@oss.qualcomm.com>
prerequisite-patch-id: 79524a1aaba6b39f49603db725539cf11176820b

Best regards,
--  
Nilesh Laad <nilesh.laad@oss.qualcomm.com>


