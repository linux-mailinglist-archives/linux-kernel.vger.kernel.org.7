Return-Path: <linux-kernel+bounces-779603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4731EB2F62C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6FB167797
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B872F3112D9;
	Thu, 21 Aug 2025 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="qGnBf+tN"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A830BF76;
	Thu, 21 Aug 2025 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774759; cv=none; b=pY4scNjfIMfrUh1r3BxmMVVWUtO7leN1b2VC/HPwpDmsYBFkaFMecthEN6UisIxdeBGHN7DvivLWKCaxwhcZa9ZtT/UHlWzcqnv//m9CMIkethfGipN8/eZOtCc1caIQ0wPr+m90r2h40xKG+1mn7x9XKVnAvparuCNCY66eQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774759; c=relaxed/simple;
	bh=bjgTsmo8TSNBn7Y5uS9FKtRGZx77AcdvayM0qxFlC40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tj9yZe3qyhSNB9YqiGidT49q4oQf7ZH6v0S5mNJpT+c3Vj8+f31+LBxgks1NmcFA1BJiZGXErHiCQS6x4EgpPkJBIfkIArG5X/jP2WIB5adDlEyEp89eUcZCGckeJCWoK3Fv7l6S3xxJy0vU+TH6yLo7iGP5Bq8tUhfcJOZw/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=qGnBf+tN; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LBAeUL014697;
	Thu, 21 Aug 2025 13:12:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	y/Q15h+PegKv09QXnm29cQhg3ChHERI7hmCMG+BmM3Y=; b=qGnBf+tNTg9SIGSP
	IXO/K2JWXw7Z+rBulcAvw4jjJTHBPlzKuFfrJnaXiQg3UnDVK5zsm/uOrUflE/hg
	JUxCOAKcFyAR1MibDsjrJCtP4rdDPalQg3K/7/AU6hUpkZysPFBS2c6kJQqj4DTa
	fEXQ0IpQr3/3sVAduhW9XMXXpeSqyMcMYmFRHmOWuydMMY+HiYdFPHJaDfnT0XBh
	XXwzJmnCO6C+Yd0Q+bf4xDYYQFuxXythq6rrDmjntbyr9pa+ahYsQQj5K7B1k3vr
	y7XaOiRzlSv9o/NcWGbt5FvYzuD9p4joAfvKt7ZrjwrgvxLX8TT6Y0KplawaQf3b
	ysODHQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n754ehjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 13:12:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 153DC40050;
	Thu, 21 Aug 2025 13:10:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6518B74E7B5;
	Thu, 21 Aug 2025 13:09:57 +0200 (CEST)
Received: from localhost (10.252.7.99) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 13:09:57 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Thu, 21 Aug 2025 13:08:57 +0200
Subject: [PATCH v4 07/13] drm/stm: ltdc: support new hardware version for
 STM32MP25 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250821-drm-misc-next-v4-7-7060500f8fd3@foss.st.com>
References: <20250821-drm-misc-next-v4-0-7060500f8fd3@foss.st.com>
In-Reply-To: <20250821-drm-misc-next-v4-0-7060500f8fd3@foss.st.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01

From: Yannick Fertre <yannick.fertre@foss.st.com>

STM32MP25 SoC features a new version of the LTDC IP.  Add its compatible
to the list of device to probe and implement its quirks.

This hardware supports a pad frequency of 150MHz and a peripheral bus
clock.

Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 drivers/gpu/drm/stm/drv.c  | 12 +++++++++++-
 drivers/gpu/drm/stm/ltdc.c | 38 +++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/stm/ltdc.h |  5 +++++
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 8ebcaf953782d806a738d5a41ff1f428b0ccff78..ab00d1a6140cc32e71e10abc82f7956328b518e3 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -236,8 +236,18 @@ static void stm_drm_platform_shutdown(struct platform_device *pdev)
 	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
 }
 
+static struct ltdc_plat_data stm_drm_plat_data = {
+	.pad_max_freq_hz = 90000000,
+};
+
+static struct ltdc_plat_data stm_drm_plat_data_mp25 = {
+	.pad_max_freq_hz = 150000000,
+};
+
 static const struct of_device_id drv_dt_ids[] = {
-	{ .compatible = "st,stm32-ltdc"},
+	{ .compatible = "st,stm32-ltdc", .data = &stm_drm_plat_data, },
+	{ .compatible = "st,stm32mp251-ltdc", .data = &stm_drm_plat_data_mp25, },
+	{ .compatible = "st,stm32mp255-ltdc", .data = &stm_drm_plat_data_mp25, },
 	{ /* end node */ },
 };
 MODULE_DEVICE_TABLE(of, drv_dt_ids);
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index ba315c66a04d72758b9d3cfcd842432877f66d3a..17548dd3484a0a3e1015c58c752b80f8892a0ff7 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/media-bus-format.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
@@ -51,6 +52,7 @@
 #define HWVER_10300 0x010300
 #define HWVER_20101 0x020101
 #define HWVER_40100 0x040100
+#define HWVER_40101 0x040101
 
 /*
  * The address of some registers depends on the HW version: such registers have
@@ -1779,6 +1781,7 @@ static int ltdc_get_caps(struct drm_device *ddev)
 {
 	struct ltdc_device *ldev = ddev->dev_private;
 	u32 bus_width_log2, lcr, gc2r;
+	const struct ltdc_plat_data *pdata = of_device_get_match_data(ddev->dev);
 
 	/*
 	 * at least 1 layer must be managed & the number of layers
@@ -1794,6 +1797,8 @@ static int ltdc_get_caps(struct drm_device *ddev)
 	ldev->caps.bus_width = 8 << bus_width_log2;
 	regmap_read(ldev->regmap, LTDC_IDR, &ldev->caps.hw_version);
 
+	ldev->caps.pad_max_freq_hz = pdata->pad_max_freq_hz;
+
 	switch (ldev->caps.hw_version) {
 	case HWVER_10200:
 	case HWVER_10300:
@@ -1811,7 +1816,6 @@ static int ltdc_get_caps(struct drm_device *ddev)
 		 * does not work on 2nd layer.
 		 */
 		ldev->caps.non_alpha_only_l1 = true;
-		ldev->caps.pad_max_freq_hz = 90000000;
 		if (ldev->caps.hw_version == HWVER_10200)
 			ldev->caps.pad_max_freq_hz = 65000000;
 		ldev->caps.nb_irq = 2;
@@ -1842,6 +1846,7 @@ static int ltdc_get_caps(struct drm_device *ddev)
 		ldev->caps.fifo_threshold = false;
 		break;
 	case HWVER_40100:
+	case HWVER_40101:
 		ldev->caps.layer_ofs = LAY_OFS_1;
 		ldev->caps.layer_regs = ltdc_layer_regs_a2;
 		ldev->caps.pix_fmt_hw = ltdc_pix_fmt_a2;
@@ -1849,7 +1854,6 @@ static int ltdc_get_caps(struct drm_device *ddev)
 		ldev->caps.pix_fmt_nb = ARRAY_SIZE(ltdc_drm_fmt_a2);
 		ldev->caps.pix_fmt_flex = true;
 		ldev->caps.non_alpha_only_l1 = false;
-		ldev->caps.pad_max_freq_hz = 90000000;
 		ldev->caps.nb_irq = 2;
 		ldev->caps.ycbcr_input = true;
 		ldev->caps.ycbcr_output = true;
@@ -1872,6 +1876,8 @@ void ltdc_suspend(struct drm_device *ddev)
 
 	DRM_DEBUG_DRIVER("\n");
 	clk_disable_unprepare(ldev->pixel_clk);
+	if (ldev->bus_clk)
+		clk_disable_unprepare(ldev->bus_clk);
 }
 
 int ltdc_resume(struct drm_device *ddev)
@@ -1887,7 +1893,13 @@ int ltdc_resume(struct drm_device *ddev)
 		return ret;
 	}
 
-	return 0;
+	if (ldev->bus_clk) {
+		ret = clk_prepare_enable(ldev->bus_clk);
+		if (ret)
+			drm_err(ddev, "failed to enable bus clock (%d)\n", ret);
+	}
+
+	return ret;
 }
 
 int ltdc_load(struct drm_device *ddev)
@@ -1922,6 +1934,20 @@ int ltdc_load(struct drm_device *ddev)
 		return -ENODEV;
 	}
 
+	if (of_device_is_compatible(np, "st,stm32mp251-ltdc") ||
+	    of_device_is_compatible(np, "st,stm32mp255-ltdc")) {
+		ldev->bus_clk = devm_clk_get(dev, "bus");
+		if (IS_ERR(ldev->bus_clk))
+			return dev_err_probe(dev, PTR_ERR(ldev->bus_clk),
+					     "Unable to get bus clock\n");
+
+		ret = clk_prepare_enable(ldev->bus_clk);
+		if (ret) {
+			drm_err(ddev, "Unable to prepare bus clock\n");
+			return ret;
+		}
+	}
+
 	/* Get endpoints if any */
 	for (i = 0; i < nb_endpoints; i++) {
 		ret = drm_of_find_panel_or_bridge(np, 0, i, &panel, &bridge);
@@ -2034,6 +2060,9 @@ int ltdc_load(struct drm_device *ddev)
 
 	clk_disable_unprepare(ldev->pixel_clk);
 
+	if (ldev->bus_clk)
+		clk_disable_unprepare(ldev->bus_clk);
+
 	pinctrl_pm_select_sleep_state(ddev->dev);
 
 	pm_runtime_enable(ddev->dev);
@@ -2042,6 +2071,9 @@ int ltdc_load(struct drm_device *ddev)
 err:
 	clk_disable_unprepare(ldev->pixel_clk);
 
+	if (ldev->bus_clk)
+		clk_disable_unprepare(ldev->bus_clk);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
index 9d488043ffdbc652deeede71c9d57d45fb89d3c6..ddfa8ae61a7ba5dc446fae647562d0ec8e6953e1 100644
--- a/drivers/gpu/drm/stm/ltdc.h
+++ b/drivers/gpu/drm/stm/ltdc.h
@@ -40,10 +40,15 @@ struct fps_info {
 	ktime_t last_timestamp;
 };
 
+struct ltdc_plat_data {
+	int pad_max_freq_hz;	/* max frequency supported by pad */
+};
+
 struct ltdc_device {
 	void __iomem *regs;
 	struct regmap *regmap;
 	struct clk *pixel_clk;	/* lcd pixel clock */
+	struct clk *bus_clk;	/* bus clock */
 	struct mutex err_lock;	/* protecting error_status */
 	struct ltdc_caps caps;
 	u32 irq_status;

-- 
2.25.1


