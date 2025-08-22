Return-Path: <linux-kernel+bounces-781215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E6EB30F58
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAB63BEBE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786162E5B04;
	Fri, 22 Aug 2025 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RDWaAsFN"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BFF2E54CC;
	Fri, 22 Aug 2025 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844865; cv=none; b=Jd7WMgT8FGM22eTmIZO5pvnzvhGCoe2Q6i19BAvIriXOehSJ947wuUnrmlcy8pNT+Mj9S3nt3xnH8zPHy+obAbfCPGn9LlgdA3s+qazpA1NgT0G0gKeywD9QC7lA2tjZwMJG3MmyqVWoYLT6kII5/3+IYYZmS+i4I0uXhfE0tLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844865; c=relaxed/simple;
	bh=3BZnGpfGS80rjkt03ILe7U1ImBSuSfEvMCCNC6ZTq40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmJnoAwy2SesW7G4sQZdESOP+fAEEsgxALAOS8Mh1IFoC+o1srEPxBfW/SJ+4ZME0tnK6vO02+ki0+xrt5ww2wGIAaBxaq3iYqSgbXiuGv5EJGB9WSX0CY1HFHGeqLO45K8lLbZr5lLq5Fm2h6RcpfXeQWzURPVTSiTENRe8T8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RDWaAsFN; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Fu
	2I9I0K62mO9f2lY4d01rL8jispecH5XRwzqIEZ658=; b=RDWaAsFNfL5tLve9J7
	23n6lUtUjWvE76duPN5kWnO/bLST8/qwd/AFUGzLEOLkBQZuQGEMk6TX1FywectU
	4f5IGgWSltBAzJhW8+4kKaE91wglQPSRXXTLzOmLSssr1siTr30r7eP+24HeeBW4
	5MsV3hm5dSslwHCmC2obvFrxo=
Received: from ProDesk.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAn9_zCEKhoYtibAA--.23257S5;
	Fri, 22 Aug 2025 14:40:19 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: dmitry.baryshkov@oss.qualcomm.com,
	heiko@sntech.de
Cc: hjc@rock-chips.com,
	mripard@kernel.org,
	naoki@radxa.com,
	stephen@radxa.com,
	cristian.ciocaltea@collabora.com,
	neil.armstrong@linaro.org,
	Laurent.pinchart@ideasonboard.com,
	yubing.zhang@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v7 03/10] drm/rockchip: Add RK3588 DPTX output support
Date: Fri, 22 Aug 2025 14:39:47 +0800
Message-ID: <20250822063959.692098-4-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822063959.692098-1-andyshrk@163.com>
References: <20250822063959.692098-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAn9_zCEKhoYtibAA--.23257S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3XrWxJF18Kw4ftr18Kw17Jrb_yoWfCFyrpa
	1DAFWYyrW8Gr4Yq3s7AF4kCFs0yanFyayxXrZ7C3Wa9a4IkryDG3sxWr1DAr9xJFW7uF13
	CwsrJ3yUZF47ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jPtxhUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gqxXmioDHlwywAAs5

From: Andy Yan <andy.yan@rock-chips.com>

Add driver extension for Synopsys DesignWare DPTX IP used
on Rockchip RK3588 SoC.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Acked-by: Dmitry Baryshkov <lumag@kernel.org>
Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

---

(no changes since v4)

Changes in v4:
- Drop unused function
- Add platform_set_drvdata

Changes in v2:
- no include uapi path
- switch to drmm_encoder_init

 drivers/gpu/drm/rockchip/Kconfig            |   9 ++
 drivers/gpu/drm/rockchip/Makefile           |   1 +
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c   | 150 ++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   1 +
 5 files changed, 162 insertions(+)
 create mode 100644 drivers/gpu/drm/rockchip/dw_dp-rockchip.c

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index ab525668939a7..616c0bc1ccee0 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -10,6 +10,7 @@ config DRM_ROCKCHIP
 	select VIDEOMODE_HELPERS
 	select DRM_ANALOGIX_DP if ROCKCHIP_ANALOGIX_DP
 	select DRM_DISPLAY_DP_AUX_BUS if ROCKCHIP_ANALOGIX_DP
+	select DRM_DW_DP if ROCKCHIP_DW_DP
 	select DRM_DW_HDMI if ROCKCHIP_DW_HDMI
 	select DRM_DW_HDMI_QP if ROCKCHIP_DW_HDMI_QP
 	select DRM_DW_MIPI_DSI if ROCKCHIP_DW_MIPI_DSI
@@ -60,6 +61,14 @@ config ROCKCHIP_CDN_DP
 	  RK3399 based SoC, you should select this
 	  option.
 
+config ROCKCHIP_DW_DP
+	bool "Rockchip specific extensions for Synopsys DW DP"
+	help
+	  This selects support for Rockchip SoC specific extensions
+	  to enable Synopsys DesignWare Cores based DisplayPort transmit
+	  controller support on Rockchip SoC, If you want to enable DP on
+	  rk3588 based SoC, you should select this option.
+
 config ROCKCHIP_DW_HDMI
 	bool "Rockchip specific extensions for Synopsys DW HDMI"
 	help
diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index 2b867cebbc121..097f062399c7a 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -14,6 +14,7 @@ rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI_QP) += dw_hdmi_qp-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI2) += dw-mipi-dsi2-rockchip.o
+rockchipdrm-$(CONFIG_ROCKCHIP_DW_DP) += dw_dp-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
 rockchipdrm-$(CONFIG_ROCKCHIP_LVDS) += rockchip_lvds.o
 rockchipdrm-$(CONFIG_ROCKCHIP_RGB) += rockchip_rgb.o
diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
new file mode 100644
index 0000000000000..25ab4e46301e8
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Rockchip Electronics Co., Ltd.
+ *
+ * Author: Zhang Yubing <yubing.zhang@rock-chips.com>
+ * Author: Andy Yan <andy.yan@rock-chips.com>
+ */
+
+#include <linux/component.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <drm/bridge/dw_dp.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
+#include <drm/drm_of.h>
+#include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
+
+#include <linux/media-bus-format.h>
+#include <linux/videodev2.h>
+
+#include "rockchip_drm_drv.h"
+#include "rockchip_drm_vop.h"
+
+struct rockchip_dw_dp {
+	struct dw_dp *base;
+	struct device *dev;
+	struct rockchip_encoder encoder;
+};
+
+static int dw_dp_encoder_atomic_check(struct drm_encoder *encoder,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state)
+{
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+	struct drm_atomic_state *state = conn_state->state;
+	struct drm_display_info *di = &conn_state->connector->display_info;
+	struct drm_bridge *bridge  = drm_bridge_chain_get_first_bridge(encoder);
+	struct drm_bridge_state *bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
+	u32 bus_format = bridge_state->input_bus_cfg.format;
+
+	switch (bus_format) {
+	case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
+	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
+		s->output_mode = ROCKCHIP_OUT_MODE_YUV420;
+		break;
+	case MEDIA_BUS_FMT_YUYV10_1X20:
+	case MEDIA_BUS_FMT_YUYV8_1X16:
+		s->output_mode = ROCKCHIP_OUT_MODE_S888_DUMMY;
+		break;
+	case MEDIA_BUS_FMT_RGB101010_1X30:
+	case MEDIA_BUS_FMT_RGB888_1X24:
+	case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
+	case MEDIA_BUS_FMT_YUV10_1X30:
+	case MEDIA_BUS_FMT_YUV8_1X24:
+	default:
+		s->output_mode = ROCKCHIP_OUT_MODE_AAAA;
+		break;
+	}
+
+	s->output_type = DRM_MODE_CONNECTOR_DisplayPort;
+	s->bus_format = bus_format;
+	s->bus_flags = di->bus_flags;
+	s->color_space = V4L2_COLORSPACE_DEFAULT;
+
+	return 0;
+}
+
+static const struct drm_encoder_helper_funcs dw_dp_encoder_helper_funcs = {
+	.atomic_check		= dw_dp_encoder_atomic_check,
+};
+
+static int dw_dp_rockchip_bind(struct device *dev, struct device *master, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_dp_plat_data plat_data;
+	struct drm_device *drm_dev = data;
+	struct rockchip_dw_dp *dp;
+	struct drm_encoder *encoder;
+	struct drm_connector *connector;
+	int ret;
+
+	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
+	if (!dp)
+		return -ENOMEM;
+
+	dp->dev = dev;
+	platform_set_drvdata(pdev, dp);
+
+	plat_data.max_link_rate = 810000;
+	encoder = &dp->encoder.encoder;
+	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev, dev->of_node);
+	rockchip_drm_encoder_set_crtc_endpoint_id(&dp->encoder, dev->of_node, 0, 0);
+
+	ret = drmm_encoder_init(drm_dev, encoder, NULL, DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret)
+		return ret;
+	drm_encoder_helper_add(encoder, &dw_dp_encoder_helper_funcs);
+
+	dp->base = dw_dp_bind(dev, encoder, &plat_data);
+	if (IS_ERR(dp->base)) {
+		ret = PTR_ERR(dp->base);
+		return ret;
+	}
+
+	connector = drm_bridge_connector_init(drm_dev, encoder);
+	if (IS_ERR(connector)) {
+		ret = PTR_ERR(connector);
+		return dev_err_probe(dev, ret, "Failed to init bridge connector");
+	}
+
+	drm_connector_attach_encoder(connector, encoder);
+
+	return 0;
+}
+
+static const struct component_ops dw_dp_rockchip_component_ops = {
+	.bind = dw_dp_rockchip_bind,
+};
+
+static int dw_dp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	return component_add(dev, &dw_dp_rockchip_component_ops);
+}
+
+static void dw_dp_remove(struct platform_device *pdev)
+{
+	struct rockchip_dw_dp *dp = platform_get_drvdata(pdev);
+
+	component_del(dp->dev, &dw_dp_rockchip_component_ops);
+}
+
+static const struct of_device_id dw_dp_of_match[] = {
+	{ .compatible = "rockchip,rk3588-dp", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, dw_dp_of_match);
+
+struct platform_driver dw_dp_driver = {
+	.probe	= dw_dp_probe,
+	.remove = dw_dp_remove,
+	.driver = {
+		.name = "dw-dp",
+		.of_match_table = dw_dp_of_match,
+	},
+};
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index ed88788e04dd2..687bb7b252e8e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -531,6 +531,7 @@ static int __init rockchip_drm_init(void)
 	ADD_ROCKCHIP_SUB_DRIVER(rockchip_dp_driver,
 				CONFIG_ROCKCHIP_ANALOGIX_DP);
 	ADD_ROCKCHIP_SUB_DRIVER(cdn_dp_driver, CONFIG_ROCKCHIP_CDN_DP);
+	ADD_ROCKCHIP_SUB_DRIVER(dw_dp_driver, CONFIG_ROCKCHIP_DW_DP);
 	ADD_ROCKCHIP_SUB_DRIVER(dw_hdmi_rockchip_pltfm_driver,
 				CONFIG_ROCKCHIP_DW_HDMI);
 	ADD_ROCKCHIP_SUB_DRIVER(dw_hdmi_qp_rockchip_pltfm_driver,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index c183e82a42a51..2e86ad00979c4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -87,6 +87,7 @@ int rockchip_drm_encoder_set_crtc_endpoint_id(struct rockchip_encoder *rencoder,
 					      struct device_node *np, int port, int reg);
 int rockchip_drm_endpoint_is_subdriver(struct device_node *ep);
 extern struct platform_driver cdn_dp_driver;
+extern struct platform_driver dw_dp_driver;
 extern struct platform_driver dw_hdmi_rockchip_pltfm_driver;
 extern struct platform_driver dw_hdmi_qp_rockchip_pltfm_driver;
 extern struct platform_driver dw_mipi_dsi_rockchip_driver;
-- 
2.43.0


