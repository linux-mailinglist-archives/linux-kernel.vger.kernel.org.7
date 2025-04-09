Return-Path: <linux-kernel+bounces-596997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11DEA833B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 23:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EE18A4A64
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 21:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB2E21B9E0;
	Wed,  9 Apr 2025 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Npw/B+DN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34721A452;
	Wed,  9 Apr 2025 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235554; cv=none; b=rncruFiMY2QXnq6cP2+5DNaEpW2LuROMMbgMbP+GifozDsAQwTk+FuYsiTS3u+vvLz+WgjDO1r14CHSAlcNUhoEJuII/qV6HAtn9tCvkZD/8a4tD+T734jp9K+Y81aLbO8glFXlWoqgCt49CR8iC4ZcytJ6pWJKsy5/F7NOTIOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235554; c=relaxed/simple;
	bh=tMapkNaQp8ltazzf638sydyhIw8s6HEffDjTUKejwr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pkTrz0ZINPH2DQNfgyEanw+OIovraD3NZNAyXffRMegMSHOEr/TtZLAvI2SiZEGOqNbj0Z00ex/GnQUVG4NKM3mBnmak/gOSSOb0ctZ2xv1jKACRdj93wMxGcyVOc4ZVboRqT01wwIA9qTANJEg9usbvHYmRRI3C/5DrtX8y+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Npw/B+DN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3BD7C4CEEB;
	Wed,  9 Apr 2025 21:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744235554;
	bh=tMapkNaQp8ltazzf638sydyhIw8s6HEffDjTUKejwr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Npw/B+DNkAP58uVwMRMsDnDCWFwsIURmrBB11VYEvtDcFT3Kx2cXGeUI14S5tApa8
	 jMzWdUVFKAWH5Gf9YlibzMnUbFfRdEfyCETHJUIUs8RyBOtScIEKtlGsZnOUIHWxaA
	 /vumrnN+aO0aY35FAf9Guvc/sRqxH0HmG1gidrKOSmNdYUR3wagJKqrrNbi0aqgR2c
	 FRILcDx0pUnVeonNCtceVQ168tbrq8bvq7E2LVaYnbRqbwg1Z8diguJnNf+t7Q+XKh
	 oM9kl1ItjFK09BI6u3IyFhogLNpMzwWRbb7C2f8tPKuBVF2tLmjPy2DYb7a9odhIHW
	 0TkPfrA6elyQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A99C369A6;
	Wed,  9 Apr 2025 21:52:33 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Wed, 09 Apr 2025 23:52:13 +0200
Subject: [PATCH v4 2/3] spmi: add a spmi driver for Apple SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-spmi-v4-2-eb81ecfd1f64@gmail.com>
References: <20250409-spmi-v4-0-eb81ecfd1f64@gmail.com>
In-Reply-To: <20250409-spmi-v4-0-eb81ecfd1f64@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Neal Gompa <neal@gompa.dev>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, 
 Jean-Francois Bortolotti <jeff@borto.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744235551; l=7005;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=y7ztBnWxx1KkNiqatI7+yAmSN/osNp2F29pacyZI0ng=;
 b=sQaOqIQSxrFUAVClscndXBEx8y0BQf4BomXth1k5aR3dau75uqmBjMy02UklTIoJwJel+U/5e
 yS3Sz62KVyQBejv0Y6yGqlRtQbAuD+fx1ez0s8AB4glkMV8/TUDMdcv
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Jean-Francois Bortolotti <jeff@borto.fr>

The connected PMU contains several useful nvmem cells such as RTC offset,
boot failure counters, reboot/shutdown selector, and a few others.
In addition M3+ machines have their USB-PD controller connected via SPMI.

Signed-off-by: Jean-Francois Bortolotti <jeff@borto.fr>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Co-developed-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 MAINTAINERS                          |   1 +
 drivers/spmi/Kconfig                 |   8 ++
 drivers/spmi/Makefile                |   1 +
 drivers/spmi/spmi-apple-controller.c | 168 +++++++++++++++++++++++++++++++++++
 4 files changed, 178 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f348736ea0bbdb83fe541c872103ce4835de40b..2bf1c547bd0ab366b343260a93f04d4a9df7e078 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2302,6 +2302,7 @@ F:	drivers/pinctrl/pinctrl-apple-gpio.c
 F:	drivers/pwm/pwm-apple.c
 F:	drivers/soc/apple/*
 F:	drivers/spi/spi-apple.c
+F:	drivers/spmi/spmi-apple-controller.c
 F:	drivers/video/backlight/apple_dwi_bl.c
 F:	drivers/watchdog/apple_wdt.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
index 73780204631463631cabcbad5bf83e8dbbee94ce..9005fa91d9f4e541403ccc7bf84e0592402ac41e 100644
--- a/drivers/spmi/Kconfig
+++ b/drivers/spmi/Kconfig
@@ -11,6 +11,14 @@ menuconfig SPMI
 
 if SPMI
 
+config SPMI_APPLE
+	tristate "Apple SoC SPMI Controller platform driver"
+	depends on ARCH_APPLE || COMPILE_TEST
+	help
+	  If you say yes to this option, support will be included for the
+	  SPMI controller present on many Apple SoCs, including the
+	  t8103 (M1) and t600x (M1 Pro/Max).
+
 config SPMI_HISI3670
 	tristate "Hisilicon 3670 SPMI Controller"
 	select IRQ_DOMAIN_HIERARCHY
diff --git a/drivers/spmi/Makefile b/drivers/spmi/Makefile
index 7f152167bb05b2c24a0f9669f60278152898eebb..38ac635645ba65aa46cb5e8a50072ed9771e229b 100644
--- a/drivers/spmi/Makefile
+++ b/drivers/spmi/Makefile
@@ -4,6 +4,7 @@
 #
 obj-$(CONFIG_SPMI)	+= spmi.o spmi-devres.o
 
+obj-$(CONFIG_SPMI_APPLE)	+= spmi-apple-controller.o
 obj-$(CONFIG_SPMI_HISI3670)	+= hisi-spmi-controller.o
 obj-$(CONFIG_SPMI_MSM_PMIC_ARB)	+= spmi-pmic-arb.o
 obj-$(CONFIG_SPMI_MTK_PMIF)	+= spmi-mtk-pmif.o
diff --git a/drivers/spmi/spmi-apple-controller.c b/drivers/spmi/spmi-apple-controller.c
new file mode 100644
index 0000000000000000000000000000000000000000..697b3e8bb023566f17911fc222666d84f5e14c91
--- /dev/null
+++ b/drivers/spmi/spmi-apple-controller.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Apple SoC SPMI device driver
+ *
+ * Copyright The Asahi Linux Contributors
+ *
+ * Inspired by:
+ *		OpenBSD support Copyright (c) 2021 Mark Kettenis <kettenis@openbsd.org>
+ *		Correllium support Copyright (C) 2021 Corellium LLC
+ *		hisi-spmi-controller.c
+ *		spmi-pmic-arb.c Copyright (c) 2021, The Linux Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/spmi.h>
+
+/* SPMI Controller Registers */
+#define SPMI_STATUS_REG 0
+#define SPMI_CMD_REG 0x4
+#define SPMI_RSP_REG 0x8
+
+#define SPMI_RX_FIFO_EMPTY BIT(24)
+
+#define REG_POLL_INTERVAL_US 10000
+#define REG_POLL_TIMEOUT_US (REG_POLL_INTERVAL_US * 5)
+
+struct apple_spmi {
+	void __iomem *regs;
+};
+
+#define poll_reg(spmi, reg, val, cond) \
+	readl_poll_timeout((spmi)->regs + (reg), (val), (cond), \
+			   REG_POLL_INTERVAL_US, REG_POLL_TIMEOUT_US)
+
+static inline u32 apple_spmi_pack_cmd(u8 opc, u8 sid, u16 saddr, size_t len)
+{
+	return opc | sid << 8 | saddr << 16 | (len - 1) | (1 << 15);
+}
+
+/* Wait for Rx FIFO to have something */
+static int apple_spmi_wait_rx_not_empty(struct spmi_controller *ctrl)
+{
+	struct apple_spmi *spmi = spmi_controller_get_drvdata(ctrl);
+	int ret;
+	u32 status;
+
+	ret = poll_reg(spmi, SPMI_STATUS_REG, status, !(status & SPMI_RX_FIFO_EMPTY));
+	if (ret) {
+		dev_err(&ctrl->dev,
+			"failed to wait for RX FIFO not empty\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
+			 u16 saddr, u8 *buf, size_t len)
+{
+	struct apple_spmi *spmi = spmi_controller_get_drvdata(ctrl);
+	u32 spmi_cmd = apple_spmi_pack_cmd(opc, sid, saddr, len);
+	u32 rsp;
+	size_t len_read = 0;
+	u8 i;
+	int ret;
+
+	writel(spmi_cmd, spmi->regs + SPMI_CMD_REG);
+
+	ret = apple_spmi_wait_rx_not_empty(ctrl);
+	if (ret)
+		return ret;
+
+	/* Discard SPMI reply status */
+	readl(spmi->regs + SPMI_RSP_REG);
+
+	/* Read SPMI data reply */
+	while (len_read < len) {
+		rsp = readl(spmi->regs + SPMI_RSP_REG);
+		i = 0;
+		while ((len_read < len) && (i < 4)) {
+			buf[len_read++] = ((0xff << (8 * i)) & rsp) >> (8 * i);
+			i += 1;
+		}
+	}
+
+	return 0;
+}
+
+static int spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
+			  u16 saddr, const u8 *buf, size_t len)
+{
+	struct apple_spmi *spmi = spmi_controller_get_drvdata(ctrl);
+	u32 spmi_cmd = apple_spmi_pack_cmd(opc, sid, saddr, len);
+	size_t i = 0, j;
+	int ret;
+
+	writel(spmi_cmd, spmi->regs + SPMI_CMD_REG);
+
+	while (i < len) {
+		j = 0;
+		spmi_cmd = 0;
+		while ((j < 4) & (i < len))
+			spmi_cmd |= buf[i++] << (j++ * 8);
+
+		writel(spmi_cmd, spmi->regs + SPMI_CMD_REG);
+	}
+
+	ret = apple_spmi_wait_rx_not_empty(ctrl);
+	if (ret)
+		return ret;
+
+	/* Discard */
+	readl(spmi->regs + SPMI_RSP_REG);
+
+	return 0;
+}
+
+static int apple_spmi_probe(struct platform_device *pdev)
+{
+	struct apple_spmi *spmi;
+	struct spmi_controller *ctrl;
+	int ret;
+
+	ctrl = devm_spmi_controller_alloc(&pdev->dev, sizeof(*spmi));
+	if (IS_ERR(ctrl))
+		return -ENOMEM;
+
+	spmi = spmi_controller_get_drvdata(ctrl);
+
+	spmi->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(spmi->regs))
+		return PTR_ERR(spmi->regs);
+
+	ctrl->dev.of_node = pdev->dev.of_node;
+
+	ctrl->read_cmd = spmi_read_cmd;
+	ctrl->write_cmd = spmi_write_cmd;
+
+	ret = devm_spmi_controller_add(&pdev->dev, ctrl);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "spmi_controller_add failed\n");
+
+	return 0;
+}
+
+static const struct of_device_id apple_spmi_match_table[] = {
+	{ .compatible = "apple,spmi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, apple_spmi_match_table);
+
+static struct platform_driver apple_spmi_driver = {
+	.probe		= apple_spmi_probe,
+	.driver		= {
+		.name	= "apple-spmi",
+		.of_match_table = apple_spmi_match_table,
+	},
+};
+module_platform_driver(apple_spmi_driver);
+
+MODULE_AUTHOR("Jean-Francois Bortolotti <jeff@borto.fr>");
+MODULE_DESCRIPTION("Apple SoC SPMI driver");
+MODULE_LICENSE("GPL");

-- 
2.49.0



