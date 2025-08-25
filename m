Return-Path: <linux-kernel+bounces-784328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC32B33A02
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1751C3BC0F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9995A2BE02A;
	Mon, 25 Aug 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QTvmPbr5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F1D28C866
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756112233; cv=none; b=DFyNiyb9sBP4kGR7kI/S2frc3+rRR5AyoIFCRZ5Z3oOA5z9Bzdla1RGeeCuhge+XNKWfTmYxw9yZ/Vk8KHxapLIde4VwYgH1QJVWScB4+ljLaL7wkFFM3VyHBF5iQEiQPM0S83cjH40xBuV3dtI+EaX9Cu9XYjDBvbEyL79coQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756112233; c=relaxed/simple;
	bh=jzmAGuSUKWkNrxhAkqhlRCnweMgPbjMdhH1sCU3MatM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WH+5InL99hJfhY7OWEwS4zh8ilMc6Vcj0w8OXbvVQ045C7c5YU4R1uF1mWVh5Sspphz1dxAdAK+T7spQR5u5JN939ccQYgsmeeUMyCO6rNuARnFdIrC6TOlKg9Bnji5K4VxMrhexpcCkbgHZ+VxxSqzrbJ9+P00K0qs89bwL/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QTvmPbr5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756112229;
	bh=jzmAGuSUKWkNrxhAkqhlRCnweMgPbjMdhH1sCU3MatM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QTvmPbr5xeIJO4CEBlCj9ENxEV55Z2gXlLjeBj57tS75C22sNGirnqijcSmn9bSec
	 wAPS4gz85z1afeIcsRih6RJh8iThstHLrMQJdfJZu3AgLFlD1OjbJ08+A4JP0ONRXs
	 LA53tLXfooY+V3u8ZJyEfvmaWVAmamBVR3w9qFwjYcchhNq4wy9thS6Bn5dBASPLq5
	 iUu2M8Zgrvb196J8DLYGqV2tkCmU0r7WaZjR/8+vp4ySyl/LTKuW/tQ+fMkmrWJMrc
	 GhGQ1U9Nsl3QiIgi+LzGPeasnCM3gLca5E2ARLB7zbigeH8Krg3pmar4lvrXsfytjJ
	 9OizHzhCr5PbQ==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 4C78B17E0489;
	Mon, 25 Aug 2025 10:57:09 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 25 Aug 2025 11:56:41 +0300
Subject: [PATCH v3 1/6] drm/bridge: dw-hdmi-qp: Add CEC support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-rk3588-hdmi-cec-v3-1-95324fb22592@collabora.com>
References: <20250825-rk3588-hdmi-cec-v3-0-95324fb22592@collabora.com>
In-Reply-To: <20250825-rk3588-hdmi-cec-v3-0-95324fb22592@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Algea Cao <algea.cao@rock-chips.com>, 
 Derek Foreman <derek.foreman@collabora.com>
X-Mailer: b4 0.14.2

Add support for the CEC interface of the Synopsys DesignWare HDMI QP TX
controller.

This is based on the downstream implementation, but rewritten on top of
the CEC helpers added recently to the DRM HDMI connector framework.

Also note struct dw_hdmi_qp_plat_data has been extended to include the
CEC IRQ number to be provided by the platform driver.

Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/Kconfig      |   8 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 221 +++++++++++++++++++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h |  14 ++
 include/drm/bridge/dw_hdmi_qp.h              |   1 +
 4 files changed, 244 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/Kconfig b/drivers/gpu/drm/bridge/synopsys/Kconfig
index f3ab2f985f8ca9dc1eeac3bda6b4a31d355cd51c..99878f051067e65fa3b97d8132be8cfa15980966 100644
--- a/drivers/gpu/drm/bridge/synopsys/Kconfig
+++ b/drivers/gpu/drm/bridge/synopsys/Kconfig
@@ -54,6 +54,14 @@ config DRM_DW_HDMI_QP
 	select DRM_KMS_HELPER
 	select REGMAP_MMIO
 
+config DRM_DW_HDMI_QP_CEC
+	bool "Synopsis Designware QP CEC interface"
+	depends on DRM_DW_HDMI_QP
+	select DRM_DISPLAY_HDMI_CEC_HELPER
+	help
+	  Support the CEC interface which is part of the Synopsys
+	  Designware HDMI QP block.
+
 config DRM_DW_MIPI_DSI
 	tristate
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 39332c57f2c54296f39e27612544f4fbf923863f..96455b3bb7b6a3f6ad488d10bc9ba90a1b56e4c8 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2021-2022 Rockchip Electronics Co., Ltd.
  * Copyright (c) 2024 Collabora Ltd.
+ * Copyright (c) 2025 Amazon.com, Inc. or its affiliates.
  *
  * Author: Algea Cao <algea.cao@rock-chips.com>
  * Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
@@ -18,6 +19,7 @@
 
 #include <drm/bridge/dw_hdmi_qp.h>
 #include <drm/display/drm_hdmi_helper.h>
+#include <drm/display/drm_hdmi_cec_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -26,6 +28,8 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_modes.h>
 
+#include <media/cec.h>
+
 #include <sound/hdmi-codec.h>
 
 #include "dw-hdmi-qp.h"
@@ -131,12 +135,28 @@ struct dw_hdmi_qp_i2c {
 	bool			is_segment;
 };
 
+#ifdef CONFIG_DRM_DW_HDMI_QP_CEC
+struct dw_hdmi_qp_cec {
+	struct drm_connector *connector;
+	int irq;
+	u32 addresses;
+	struct cec_msg rx_msg;
+	u8 tx_status;
+	bool tx_done;
+	bool rx_done;
+};
+#endif
+
 struct dw_hdmi_qp {
 	struct drm_bridge bridge;
 
 	struct device *dev;
 	struct dw_hdmi_qp_i2c *i2c;
 
+#ifdef CONFIG_DRM_DW_HDMI_QP_CEC
+	struct dw_hdmi_qp_cec *cec;
+#endif
+
 	struct {
 		const struct dw_hdmi_qp_phy_ops *ops;
 		void *data;
@@ -965,6 +985,191 @@ static int dw_hdmi_qp_bridge_write_infoframe(struct drm_bridge *bridge,
 	}
 }
 
+#ifdef CONFIG_DRM_DW_HDMI_QP_CEC
+static irqreturn_t dw_hdmi_qp_cec_hardirq(int irq, void *dev_id)
+{
+	struct dw_hdmi_qp *hdmi = dev_id;
+	struct dw_hdmi_qp_cec *cec = hdmi->cec;
+	irqreturn_t ret = IRQ_HANDLED;
+	u32 stat;
+
+	stat = dw_hdmi_qp_read(hdmi, CEC_INT_STATUS);
+	if (stat == 0)
+		return IRQ_NONE;
+
+	dw_hdmi_qp_write(hdmi, stat, CEC_INT_CLEAR);
+
+	if (stat & CEC_STAT_LINE_ERR) {
+		cec->tx_status = CEC_TX_STATUS_ERROR;
+		cec->tx_done = true;
+		ret = IRQ_WAKE_THREAD;
+	} else if (stat & CEC_STAT_DONE) {
+		cec->tx_status = CEC_TX_STATUS_OK;
+		cec->tx_done = true;
+		ret = IRQ_WAKE_THREAD;
+	} else if (stat & CEC_STAT_NACK) {
+		cec->tx_status = CEC_TX_STATUS_NACK;
+		cec->tx_done = true;
+		ret = IRQ_WAKE_THREAD;
+	}
+
+	if (stat & CEC_STAT_EOM) {
+		unsigned int len, i, val;
+
+		val = dw_hdmi_qp_read(hdmi, CEC_RX_COUNT_STATUS);
+		len = (val & 0xf) + 1;
+
+		if (len > sizeof(cec->rx_msg.msg))
+			len = sizeof(cec->rx_msg.msg);
+
+		for (i = 0; i < 4; i++) {
+			val = dw_hdmi_qp_read(hdmi, CEC_RX_DATA3_0 + i * 4);
+			cec->rx_msg.msg[i * 4] = val & 0xff;
+			cec->rx_msg.msg[i * 4 + 1] = (val >> 8) & 0xff;
+			cec->rx_msg.msg[i * 4 + 2] = (val >> 16) & 0xff;
+			cec->rx_msg.msg[i * 4 + 3] = (val >> 24) & 0xff;
+		}
+
+		dw_hdmi_qp_write(hdmi, 1, CEC_LOCK_CONTROL);
+
+		cec->rx_msg.len = len;
+		cec->rx_done = true;
+
+		ret = IRQ_WAKE_THREAD;
+	}
+
+	return ret;
+}
+
+static irqreturn_t dw_hdmi_qp_cec_thread(int irq, void *dev_id)
+{
+	struct dw_hdmi_qp *hdmi = dev_id;
+	struct dw_hdmi_qp_cec *cec = hdmi->cec;
+
+	if (cec->tx_done) {
+		cec->tx_done = false;
+		drm_connector_hdmi_cec_transmit_attempt_done(cec->connector,
+							     cec->tx_status);
+	}
+
+	if (cec->rx_done) {
+		cec->rx_done = false;
+		drm_connector_hdmi_cec_received_msg(cec->connector, &cec->rx_msg);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int dw_hdmi_qp_cec_init(struct drm_bridge *bridge,
+			       struct drm_connector *connector)
+{
+	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
+	struct dw_hdmi_qp_cec *cec = hdmi->cec;
+	int ret;
+
+	if (cec->irq < 0) {
+		dev_err(hdmi->dev, "Invalid cec irq: %d\n", cec->irq);
+		return -EINVAL;
+	}
+
+	cec->connector = connector;
+
+	dw_hdmi_qp_write(hdmi, 0, CEC_TX_COUNT);
+	dw_hdmi_qp_write(hdmi, ~0, CEC_INT_CLEAR);
+	dw_hdmi_qp_write(hdmi, 0, CEC_INT_MASK_N);
+
+	ret = devm_request_threaded_irq(hdmi->dev, cec->irq,
+					dw_hdmi_qp_cec_hardirq,
+					dw_hdmi_qp_cec_thread, IRQF_SHARED,
+					dev_name(hdmi->dev), hdmi);
+	if (ret < 0) {
+		dev_err(hdmi->dev, "Request cec irq thread failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dw_hdmi_qp_cec_log_addr(struct drm_bridge *bridge, u8 logical_addr)
+{
+	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
+	struct dw_hdmi_qp_cec *cec = hdmi->cec;
+
+	if (logical_addr == CEC_LOG_ADDR_INVALID)
+		cec->addresses = 0;
+	else
+		cec->addresses |= BIT(logical_addr) | CEC_ADDR_BROADCAST;
+
+	dw_hdmi_qp_write(hdmi, cec->addresses, CEC_ADDR);
+
+	return 0;
+}
+
+static int dw_hdmi_qp_cec_enable(struct drm_bridge *bridge, bool enable)
+{
+	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
+	unsigned int irqs;
+	u32 swdisable;
+
+	if (!enable) {
+		dw_hdmi_qp_write(hdmi, 0, CEC_INT_MASK_N);
+		dw_hdmi_qp_write(hdmi, ~0, CEC_INT_CLEAR);
+
+		swdisable = dw_hdmi_qp_read(hdmi, GLOBAL_SWDISABLE);
+		swdisable = swdisable | CEC_SWDISABLE;
+		dw_hdmi_qp_write(hdmi, swdisable, GLOBAL_SWDISABLE);
+	} else {
+		swdisable = dw_hdmi_qp_read(hdmi, GLOBAL_SWDISABLE);
+		swdisable = swdisable & ~CEC_SWDISABLE;
+		dw_hdmi_qp_write(hdmi, swdisable, GLOBAL_SWDISABLE);
+
+		dw_hdmi_qp_write(hdmi, ~0, CEC_INT_CLEAR);
+		dw_hdmi_qp_write(hdmi, 1, CEC_LOCK_CONTROL);
+
+		dw_hdmi_qp_cec_log_addr(bridge, CEC_LOG_ADDR_INVALID);
+
+		irqs = CEC_STAT_LINE_ERR | CEC_STAT_NACK | CEC_STAT_EOM |
+		       CEC_STAT_DONE;
+		dw_hdmi_qp_write(hdmi, ~0, CEC_INT_CLEAR);
+		dw_hdmi_qp_write(hdmi, irqs, CEC_INT_MASK_N);
+	}
+
+	return 0;
+}
+
+static int dw_hdmi_qp_cec_transmit(struct drm_bridge *bridge, u8 attempts,
+				   u32 signal_free_time, struct cec_msg *msg)
+{
+	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
+	unsigned int i;
+	u32 val;
+
+	for (i = 0; i < msg->len; i++) {
+		if (!(i % 4))
+			val = msg->msg[i];
+		if ((i % 4) == 1)
+			val |= msg->msg[i] << 8;
+		if ((i % 4) == 2)
+			val |= msg->msg[i] << 16;
+		if ((i % 4) == 3)
+			val |= msg->msg[i] << 24;
+
+		if (i == (msg->len - 1) || (i % 4) == 3)
+			dw_hdmi_qp_write(hdmi, val, CEC_TX_DATA3_0 + (i / 4) * 4);
+	}
+
+	dw_hdmi_qp_write(hdmi, msg->len - 1, CEC_TX_COUNT);
+	dw_hdmi_qp_write(hdmi, CEC_CTRL_START, CEC_TX_CONTROL);
+
+	return 0;
+}
+#else
+#define dw_hdmi_qp_cec_init NULL
+#define dw_hdmi_qp_cec_enable NULL
+#define dw_hdmi_qp_cec_log_addr NULL
+#define dw_hdmi_qp_cec_transmit NULL
+#endif /* CONFIG_DRM_DW_HDMI_QP_CEC */
+
 static const struct drm_bridge_funcs dw_hdmi_qp_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
@@ -979,6 +1184,10 @@ static const struct drm_bridge_funcs dw_hdmi_qp_bridge_funcs = {
 	.hdmi_audio_startup = dw_hdmi_qp_audio_enable,
 	.hdmi_audio_shutdown = dw_hdmi_qp_audio_disable,
 	.hdmi_audio_prepare = dw_hdmi_qp_audio_prepare,
+	.hdmi_cec_init = dw_hdmi_qp_cec_init,
+	.hdmi_cec_enable = dw_hdmi_qp_cec_enable,
+	.hdmi_cec_log_addr = dw_hdmi_qp_cec_log_addr,
+	.hdmi_cec_transmit = dw_hdmi_qp_cec_transmit,
 };
 
 static irqreturn_t dw_hdmi_qp_main_hardirq(int irq, void *dev_id)
@@ -1093,6 +1302,18 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
 	hdmi->bridge.hdmi_audio_dev = dev;
 	hdmi->bridge.hdmi_audio_dai_port = 1;
 
+#ifdef CONFIG_DRM_DW_HDMI_QP_CEC
+	hdmi->bridge.ops |= DRM_BRIDGE_OP_HDMI_CEC_ADAPTER;
+	hdmi->bridge.hdmi_cec_dev = dev;
+	hdmi->bridge.hdmi_cec_adapter_name = dev_name(dev);
+
+	hdmi->cec = devm_kzalloc(hdmi->dev, sizeof(*hdmi->cec), GFP_KERNEL);
+	if (!hdmi->cec)
+		return ERR_PTR(-ENOMEM);
+
+	hdmi->cec->irq = plat_data->cec_irq;
+#endif
+
 	ret = devm_drm_bridge_add(dev, &hdmi->bridge);
 	if (ret)
 		return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h
index 72987e6c468928f2b998099697a6f32726411557..91a15f82e32acc32eef58f11ec5ca958337ebb9a 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h
@@ -488,9 +488,23 @@
 #define AUDPKT_VBIT_OVR0				0xf24
 /* CEC Registers */
 #define CEC_TX_CONTROL					0x1000
+#define CEC_CTRL_CLEAR					BIT(0)
+#define CEC_CTRL_START					BIT(0)
 #define CEC_STATUS					0x1004
+#define CEC_STAT_DONE					BIT(0)
+#define CEC_STAT_NACK					BIT(1)
+#define CEC_STAT_ARBLOST				BIT(2)
+#define CEC_STAT_LINE_ERR				BIT(3)
+#define CEC_STAT_RETRANS_FAIL				BIT(4)
+#define CEC_STAT_DISCARD				BIT(5)
+#define CEC_STAT_TX_BUSY				BIT(8)
+#define CEC_STAT_RX_BUSY				BIT(9)
+#define CEC_STAT_DRIVE_ERR				BIT(10)
+#define CEC_STAT_EOM					BIT(11)
+#define CEC_STAT_NOTIFY_ERR				BIT(12)
 #define CEC_CONFIG					0x1008
 #define CEC_ADDR					0x100c
+#define CEC_ADDR_BROADCAST				BIT(15)
 #define CEC_TX_COUNT					0x1020
 #define CEC_TX_DATA3_0					0x1024
 #define CEC_TX_DATA7_4					0x1028
diff --git a/include/drm/bridge/dw_hdmi_qp.h b/include/drm/bridge/dw_hdmi_qp.h
index e9be6d507ad9cdc55f5c7d6d3ef37eba41f1ce74..b4a9b739734ec7b67013b683fe6017551aa19172 100644
--- a/include/drm/bridge/dw_hdmi_qp.h
+++ b/include/drm/bridge/dw_hdmi_qp.h
@@ -23,6 +23,7 @@ struct dw_hdmi_qp_plat_data {
 	const struct dw_hdmi_qp_phy_ops *phy_ops;
 	void *phy_data;
 	int main_irq;
+	int cec_irq;
 };
 
 struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,

-- 
2.50.1


