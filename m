Return-Path: <linux-kernel+bounces-585004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE9CA78EA9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 14:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30FE3AA089
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 12:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB92323A9A3;
	Wed,  2 Apr 2025 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M7F54b6X"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66672238D2D;
	Wed,  2 Apr 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743597166; cv=none; b=Ju3dAtDIbYaLD0LtYfzyyH04M8v80jZUOCGQ68vTQBx4maplJfXgMhcYQ17Fzrge8xSaeytbNa9awb+iMiq86pCLz0JhGnE+DADEQEfSuVHt/+sWXWGQfmT+swjjqFYt1VAM+xsYi5eBsi8wC4zbvkE0yWlUpPfcY71Qx7/B/gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743597166; c=relaxed/simple;
	bh=RY1wOESZWxNAL6kdiDv+BIzI3pjPPM9sK0ZV9d7NMYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uscBzd/av9a9WMo+tWjjx8UBDVICTLRIvy/PQcX9zFhW8JeZlmhCD+P/3VsNrDwkNsoK6WMGvHnT3VJIs7/lpzlS7H+vdLfDhbSlldqxbMfTSLnBtsAQd00jw07zsjSvVLvxBW49u54NKE0yivGX/ZOeAu4eTWVfsUqI09szt60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M7F54b6X; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=CBuVD
	5mLxW1qWVh3yysFaNPsNmOWSZ6Qe90zC/Vn6b4=; b=M7F54b6XJU+kRYft5LtkL
	Z6VagWP+2LCz3EVq3DxVZzZKAdHopIr1/Y079LCLE2IzRkka9P7h7LxY0BAjQrtB
	HOISEyKLKPyUe2qVBgZs7NKURvHtA5f+BWNtW1qLkWaZpBUqvk/LChH7EVjrDkE8
	FN9cRUgvV71k5ayvX5R75E=
Received: from ProDesk.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDnd405Lu1nJwOJBA--.36321S6;
	Wed, 02 Apr 2025 20:32:01 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	hjc@rock-chips.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	dmitry.baryshkov@oss.qualcomm.com,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v3 4/7] drm/rockchip: inno-hdmi: Fix video timing HSYNC/VSYNC polarity setting for rk3036
Date: Wed,  2 Apr 2025 20:31:38 +0800
Message-ID: <20250402123150.238234-5-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250402123150.238234-1-andyshrk@163.com>
References: <20250402123150.238234-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDnd405Lu1nJwOJBA--.36321S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr17Gry3Ar18CFW5Xw4xZwb_yoWrJF4xpa
	yUCFyUJF43Xa13Jw4xAa97Cr1aga97ta12yry7W3Wa9w12gr9YyF1kZF43uF1rAF93Was7
	trWkGa4UG3W7Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07js2-5UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqB0jXmftKV94EgAAse

From: Andy Yan <andy.yan@rock-chips.com>

The HSYNC/VSYNC polarity of rk3036 HDMI are controlled by GRF.
Without the polarity configuration in GRF, it can be observed
from the HDMI protocol analyzer that the H/V front/back timing
output by RK3036 HDMI are currently not in line with the specifications.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

(no changes since v2)

Changes in v2:
- First included in this series

 drivers/gpu/drm/rockchip/inno_hdmi.c | 36 +++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index e891d42dd08a4..db4b4038e51d5 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -10,10 +10,12 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/hdmi.h>
+#include <linux/mfd/syscon.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -29,8 +31,19 @@
 
 #include "inno_hdmi.h"
 
+#define HIWORD_UPDATE(val, mask)	((val) | (mask) << 16)
+
 #define INNO_HDMI_MIN_TMDS_CLOCK  25000000U
 
+#define RK3036_GRF_SOC_CON2	0x148
+#define RK3036_HDMI_PHSYNC	BIT(4)
+#define RK3036_HDMI_PVSYNC	BIT(5)
+
+enum inno_hdmi_dev_type {
+	RK3036_HDMI,
+	RK3128_HDMI,
+};
+
 struct inno_hdmi_phy_config {
 	unsigned long pixelclock;
 	u8 pre_emphasis;
@@ -38,6 +51,7 @@ struct inno_hdmi_phy_config {
 };
 
 struct inno_hdmi_variant {
+	enum inno_hdmi_dev_type dev_type;
 	struct inno_hdmi_phy_config *phy_configs;
 	struct inno_hdmi_phy_config *default_phy_config;
 };
@@ -58,6 +72,7 @@ struct inno_hdmi {
 	struct clk *pclk;
 	struct clk *refclk;
 	void __iomem *regs;
+	struct regmap *grf;
 
 	struct drm_connector	connector;
 	struct rockchip_encoder	encoder;
@@ -374,7 +389,15 @@ static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
 static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 					 struct drm_display_mode *mode)
 {
-	int value;
+	int value, psync;
+
+	if (hdmi->variant->dev_type == RK3036_HDMI) {
+		psync = mode->flags & DRM_MODE_FLAG_PHSYNC ? RK3036_HDMI_PHSYNC : 0;
+		value = HIWORD_UPDATE(psync, RK3036_HDMI_PHSYNC);
+		psync = mode->flags & DRM_MODE_FLAG_PVSYNC ? RK3036_HDMI_PVSYNC : 0;
+		value |= HIWORD_UPDATE(psync, RK3036_HDMI_PVSYNC);
+		regmap_write(hdmi->grf, RK3036_GRF_SOC_CON2, value);
+	}
 
 	/* Set detail external video timing polarity and interlace mode */
 	value = v_EXTERANL_VIDEO(1);
@@ -904,6 +927,15 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 		goto err_disable_pclk;
 	}
 
+	if (hdmi->variant->dev_type == RK3036_HDMI) {
+		hdmi->grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,grf");
+		if (IS_ERR(hdmi->grf)) {
+			ret = dev_err_probe(dev, PTR_ERR(hdmi->grf),
+					    "Unable to get rockchip,grf\n");
+			goto err_disable_clk;
+		}
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
@@ -988,11 +1020,13 @@ static void inno_hdmi_remove(struct platform_device *pdev)
 }
 
 static const struct inno_hdmi_variant rk3036_inno_hdmi_variant = {
+	.dev_type = RK3036_HDMI,
 	.phy_configs = rk3036_hdmi_phy_configs,
 	.default_phy_config = &rk3036_hdmi_phy_configs[1],
 };
 
 static const struct inno_hdmi_variant rk3128_inno_hdmi_variant = {
+	.dev_type = RK3128_HDMI,
 	.phy_configs = rk3128_hdmi_phy_configs,
 	.default_phy_config = &rk3128_hdmi_phy_configs[1],
 };
-- 
2.43.0


