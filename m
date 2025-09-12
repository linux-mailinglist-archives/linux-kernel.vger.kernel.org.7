Return-Path: <linux-kernel+bounces-814523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2EFB55523
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5901CC7BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DFD329F13;
	Fri, 12 Sep 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O/k3tQ4+"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1DB324B25
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696058; cv=none; b=WUetARAnnDYZoTHXz/+4uthkAqCyaW2KTb3hNL2UZ9eaxs2Zy85sChT930qsUpWlDqkCs2/R3ZFiQEAblxPNFpAgFC5HK/1JDiQ5SjITQzT9TCQL6sCo8bxUc9qP0BLGUEA0p228KtJ2IaZqL/m4+hIO2IlWP0CzD86F67MHpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696058; c=relaxed/simple;
	bh=FfgkdU6etZrYAfvJBDW3eVcqdsFZWMjbz1Dd8LUWRgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IDd6i28rMxD7RlFswMmYzL969eFhD4GfV/5j5xPF/yFY6Y8OA1ktG9JCMAwnnzkCPos/kEsquX3iRe9fVF2FF+OLqloyazWGE2EyrMj8fSy96rXkgfcd6jWb2OL0F7ThKBqVqBARzfEK+nn2o6lzYMxvy8/S3tzPFhYclhv9BYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O/k3tQ4+; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757696054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZNri8xN5U7Vx0F01Sp7vJZsX4j0K/IC1lKGnDrBvpw=;
	b=O/k3tQ4+g/0+rpbSpw7sbARdvoMR1xVwthpuB9MxRtifJRLY61qimQXiWWpoxP8WWyvEZf
	zODN95PTl4WqF5lWFdYrs8fKPp/2YMK2yuC6mzmzoqN2SOQHCwT+UykUzfYHLSF4qUjTEF
	m2AgvKDFbRyRsAbvbWbcOeBOk69wsbQ=
From: Ze Huang <huang.ze@linux.dev>
Date: Sat, 13 Sep 2025 00:53:48 +0800
Subject: [PATCH v8 2/2] usb: dwc3: add generic driver to support flattened
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-dwc3_generic-v8-2-b50f81f05f95@linux.dev>
References: <20250913-dwc3_generic-v8-0-b50f81f05f95@linux.dev>
In-Reply-To: <20250913-dwc3_generic-v8-0-b50f81f05f95@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Ze Huang <huang.ze@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757696039; l=6552;
 i=huang.ze@linux.dev; s=20250705; h=from:subject:message-id;
 bh=FfgkdU6etZrYAfvJBDW3eVcqdsFZWMjbz1Dd8LUWRgw=;
 b=gH7DEKhPnuHMv4E13jQV6dT1Uy5BuV//pCHGR5nlTXxk3OMFYtgL4ZmcEhzK4VR+dp5gosxZt
 QAg2fT6J5Z1B1k24+gPbQHA4mirhrdw1jLpVk8XVaxsOQi0kJx6bIHY
X-Developer-Key: i=huang.ze@linux.dev; a=ed25519;
 pk=Kzc4PMu5PTo8eZZQ5xmTNL9jeXcQ9Wml0cs+vlQpBkg=
X-Migadu-Flow: FLOW_OUT

To support flattened dwc3 dt model and drop the glue layer, introduce the
`dwc3-generic` driver. This enables direct binding of the DWC3 core driver
and offers an alternative to the existing glue driver `dwc3-of-simple`.

Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Ze Huang <huang.ze@linux.dev>
---
 drivers/usb/dwc3/Kconfig             |  11 +++
 drivers/usb/dwc3/Makefile            |   1 +
 drivers/usb/dwc3/dwc3-generic-plat.c | 166 +++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 310d182e10b50b253d7e5a51674806e6ec442a2a..4925d15084f816d3ff92059b476ebcc799b56b51 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -189,4 +189,15 @@ config USB_DWC3_RTK
 	  or dual-role mode.
 	  Say 'Y' or 'M' if you have such device.
 
+config USB_DWC3_GENERIC_PLAT
+	tristate "DWC3 Generic Platform Driver"
+	depends on OF && COMMON_CLK
+	default USB_DWC3
+	help
+	  Support USB3 functionality in simple SoC integrations.
+	  Currently supports SpacemiT DWC USB3. Platforms using
+	  dwc3-of-simple can easily switch to dwc3-generic by flattening
+	  the dwc3 child node in the device tree.
+	  Say 'Y' or 'M' here if your platform integrates DWC3 in a similar way.
+
 endif
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 830e6c9e5fe073c1f662ce34b6a4a2da34c407a2..96469e48ff9d189cc8d0b65e65424eae2158bcfe 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_USB_DWC3_IMX8MP)		+= dwc3-imx8mp.o
 obj-$(CONFIG_USB_DWC3_XILINX)		+= dwc3-xilinx.o
 obj-$(CONFIG_USB_DWC3_OCTEON)		+= dwc3-octeon.o
 obj-$(CONFIG_USB_DWC3_RTK)		+= dwc3-rtk.o
+obj-$(CONFIG_USB_DWC3_GENERIC_PLAT)	+= dwc3-generic-plat.o
diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
new file mode 100644
index 0000000000000000000000000000000000000000..d96b20570002dc619ea813f4d6a8013636a0f346
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-generic-plat.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * dwc3-generic-plat.c - DesignWare USB3 generic platform driver
+ *
+ * Copyright (C) 2025 Ze Huang <huang.ze@linux.dev>
+ *
+ * Inspired by dwc3-qcom.c and dwc3-of-simple.c
+ */
+
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include "glue.h"
+
+struct dwc3_generic {
+	struct device		*dev;
+	struct dwc3		dwc;
+	struct clk_bulk_data	*clks;
+	int			num_clocks;
+	struct reset_control	*resets;
+};
+
+#define to_dwc3_generic(d) container_of((d), struct dwc3_generic, dwc)
+
+static void dwc3_generic_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
+static int dwc3_generic_probe(struct platform_device *pdev)
+{
+	struct dwc3_probe_data probe_data = {};
+	struct device *dev = &pdev->dev;
+	struct dwc3_generic *dwc3g;
+	struct resource *res;
+	int ret;
+
+	dwc3g = devm_kzalloc(dev, sizeof(*dwc3g), GFP_KERNEL);
+	if (!dwc3g)
+		return -ENOMEM;
+
+	dwc3g->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "missing memory resource\n");
+		return -ENODEV;
+	}
+
+	dwc3g->resets = devm_reset_control_array_get_optional_exclusive(dev);
+	if (IS_ERR(dwc3g->resets))
+		return dev_err_probe(dev, PTR_ERR(dwc3g->resets), "failed to get resets\n");
+
+	ret = reset_control_assert(dwc3g->resets);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to assert resets\n");
+
+	/* Not strict timing, just for safety */
+	udelay(2);
+
+	ret = reset_control_deassert(dwc3g->resets);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to deassert resets\n");
+
+	ret = devm_add_action_or_reset(dev, dwc3_generic_reset_control_assert, dwc3g->resets);
+	if (ret)
+		return ret;
+
+	ret = devm_clk_bulk_get_all_enabled(dwc3g->dev, &dwc3g->clks);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get clocks\n");
+
+	dwc3g->num_clocks = ret;
+	dwc3g->dwc.dev = dev;
+	probe_data.dwc = &dwc3g->dwc;
+	probe_data.res = res;
+	probe_data.ignore_clocks_and_resets = true;
+	ret = dwc3_core_probe(&probe_data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register DWC3 Core\n");
+
+	return 0;
+}
+
+static void dwc3_generic_remove(struct platform_device *pdev)
+{
+	struct dwc3 *dwc = platform_get_drvdata(pdev);
+	struct dwc3_generic *dwc3g = to_dwc3_generic(dwc);
+
+	dwc3_core_remove(dwc);
+
+	clk_bulk_disable_unprepare(dwc3g->num_clocks, dwc3g->clks);
+}
+
+static int dwc3_generic_suspend(struct device *dev)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+	struct dwc3_generic *dwc3g = to_dwc3_generic(dwc);
+	int ret;
+
+	ret = dwc3_pm_suspend(dwc);
+	if (ret)
+		return ret;
+
+	clk_bulk_disable_unprepare(dwc3g->num_clocks, dwc3g->clks);
+
+	return 0;
+}
+
+static int dwc3_generic_resume(struct device *dev)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+	struct dwc3_generic *dwc3g = to_dwc3_generic(dwc);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(dwc3g->num_clocks, dwc3g->clks);
+	if (ret)
+		return ret;
+
+	ret = dwc3_pm_resume(dwc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int dwc3_generic_runtime_suspend(struct device *dev)
+{
+	return dwc3_runtime_suspend(dev_get_drvdata(dev));
+}
+
+static int dwc3_generic_runtime_resume(struct device *dev)
+{
+	return dwc3_runtime_resume(dev_get_drvdata(dev));
+}
+
+static int dwc3_generic_runtime_idle(struct device *dev)
+{
+	return dwc3_runtime_idle(dev_get_drvdata(dev));
+}
+
+static const struct dev_pm_ops dwc3_generic_dev_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(dwc3_generic_suspend, dwc3_generic_resume)
+	RUNTIME_PM_OPS(dwc3_generic_runtime_suspend, dwc3_generic_runtime_resume,
+		       dwc3_generic_runtime_idle)
+};
+
+static const struct of_device_id dwc3_generic_of_match[] = {
+	{ .compatible = "spacemit,k1-dwc3", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, dwc3_generic_of_match);
+
+static struct platform_driver dwc3_generic_driver = {
+	.probe		= dwc3_generic_probe,
+	.remove		= dwc3_generic_remove,
+	.driver		= {
+		.name	= "dwc3-generic-plat",
+		.of_match_table = dwc3_generic_of_match,
+		.pm	= pm_ptr(&dwc3_generic_dev_pm_ops),
+	},
+};
+module_platform_driver(dwc3_generic_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DesignWare USB3 generic platform driver");

-- 
2.34.1


