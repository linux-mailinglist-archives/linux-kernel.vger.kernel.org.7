Return-Path: <linux-kernel+bounces-728544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9D9B029C7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 09:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189AA7BB38B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 07:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B602223DD6;
	Sat, 12 Jul 2025 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eVxQtLSm"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577802236E8
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752306568; cv=none; b=rZyvmDHcKXG/4rwErZo6ZOyje71bIKLWWAsXkFtlVOaYFNIWd7y/KUE/WzTCLgD+wwq8xR/rUVll6coD2iTYm9YdQCNRWQH2PVUYs/06NlUhpKEKQJpTWiqL43mGlrGAqJOAGCKq2pNo0eBEqGEsTNk3fUujPC/h+2/RRuzeOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752306568; c=relaxed/simple;
	bh=eSPbPl/69klHcDOS25MEdm83ebP3RhJ3ozcxcilcCXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kOppA/kv6/8cb1M8mOwxa1zhWuUXolrMAnL17O2UtXqNiSE+FHNXC97Z8yQ7EC3XPB771Cy+I/AhTk1ejdK76nTxQk+1INn+ckxPuJIel5TG1/Sc8ihPNlhG/YRmlpOdKIOMvWbMq4zuPmwfPkTDEMVK/tJTQKok90xiuCVGQ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eVxQtLSm; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752306564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhNJuAOp3LcN8J2bSaPZvLu7s1MyXK3kYFTKEjOni6Q=;
	b=eVxQtLSmxRnOaipcjlY+WP5SLBCoTHLCoMiZABMH04veJax0YH4fBFnGTPHG76NTweuWGh
	lYif4rdTvgX1Su3AElUUCr715L3vmoLLOWfFn+ibeObyudL99r5sRj2modq6dwe88yLuXk
	C+1yKo/N+6w10Ie30/As/uS3xbcce2c=
From: Ze Huang <huang.ze@linux.dev>
Date: Sat, 12 Jul 2025 15:49:01 +0800
Subject: [PATCH v6 2/2] usb: dwc3: add generic driver to support flattened
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250712-dwc3_generic-v6-2-cc87737cc936@linux.dev>
References: <20250712-dwc3_generic-v6-0-cc87737cc936@linux.dev>
In-Reply-To: <20250712-dwc3_generic-v6-0-cc87737cc936@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Ze Huang <huang.ze@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752306549; l=6806;
 i=huang.ze@linux.dev; s=20250705; h=from:subject:message-id;
 bh=eSPbPl/69klHcDOS25MEdm83ebP3RhJ3ozcxcilcCXI=;
 b=d00GwjHF1jDdvki/ZH8XeoHf3HAmPel7gJ4ZuQkD6rpasLgsiojHfGlOE1X9gBfI9+eLuNbLJ
 IHeOey9UXKjCwStT+llDceBePtnEKsBieZjlmjXlVGYwocDW2Op/BpN
X-Developer-Key: i=huang.ze@linux.dev; a=ed25519;
 pk=Kzc4PMu5PTo8eZZQ5xmTNL9jeXcQ9Wml0cs+vlQpBkg=
X-Migadu-Flow: FLOW_OUT

To support flattened dwc3 dt model and drop the glue layer, introduce the
`dwc3-generic` driver. This enables direct binding of the DWC3 core driver
and offers an alternative to the existing glue driver `dwc3-of-simple`.

Signed-off-by: Ze Huang <huang.ze@linux.dev>
---
 drivers/usb/dwc3/Kconfig             |  11 +++
 drivers/usb/dwc3/Makefile            |   1 +
 drivers/usb/dwc3/dwc3-generic-plat.c | 182 +++++++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)

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
index 0000000000000000000000000000000000000000..766f4cf17b6909793956f44660d3b3febad50a23
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-generic-plat.c
@@ -0,0 +1,182 @@
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
+static void dwc3_generic_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
+static void dwc3_generic_clk_bulk_disable_unprepare(void *data)
+{
+	struct dwc3_generic *dwc3 = data;
+
+	clk_bulk_disable_unprepare(dwc3->num_clocks, dwc3->clks);
+}
+
+static int dwc3_generic_probe(struct platform_device *pdev)
+{
+	struct dwc3_probe_data probe_data = {};
+	struct device *dev = &pdev->dev;
+	struct dwc3_generic *dwc3;
+	struct resource *res;
+	int ret;
+
+	dwc3 = devm_kzalloc(dev, sizeof(*dwc3), GFP_KERNEL);
+	if (!dwc3)
+		return -ENOMEM;
+
+	dwc3->dev = dev;
+
+	platform_set_drvdata(pdev, dwc3);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "missing memory resource\n");
+		return -ENODEV;
+	}
+
+	dwc3->resets = devm_reset_control_array_get_optional_exclusive(dev);
+	if (IS_ERR(dwc3->resets))
+		return dev_err_probe(dev, PTR_ERR(dwc3->resets), "failed to get resets\n");
+
+	ret = reset_control_assert(dwc3->resets);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to assert resets\n");
+
+	ret = devm_add_action_or_reset(dev, dwc3_generic_reset_control_assert, dwc3->resets);
+	if (ret)
+		return ret;
+
+	usleep_range(10, 1000);
+
+	ret = reset_control_deassert(dwc3->resets);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to deassert resets\n");
+
+	ret = devm_clk_bulk_get_all(dwc3->dev, &dwc3->clks);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get clocks\n");
+
+	dwc3->num_clocks = ret;
+
+	ret = clk_bulk_prepare_enable(dwc3->num_clocks, dwc3->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable clocks\n");
+
+	ret = devm_add_action_or_reset(dev, dwc3_generic_clk_bulk_disable_unprepare, dwc3);
+	if (ret)
+		return ret;
+
+	dwc3->dwc.dev = dev;
+	probe_data.dwc = &dwc3->dwc;
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
+	struct dwc3_generic *dwc3 = platform_get_drvdata(pdev);
+
+	dwc3_core_remove(&dwc3->dwc);
+}
+
+static int dwc3_generic_suspend(struct device *dev)
+{
+	struct dwc3_generic *dwc3 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = dwc3_pm_suspend(&dwc3->dwc);
+	if (ret)
+		return ret;
+
+	clk_bulk_disable_unprepare(dwc3->num_clocks, dwc3->clks);
+
+	return 0;
+}
+
+static int dwc3_generic_resume(struct device *dev)
+{
+	struct dwc3_generic *dwc3 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(dwc3->num_clocks, dwc3->clks);
+	if (ret)
+		return ret;
+
+	ret = dwc3_pm_resume(&dwc3->dwc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int dwc3_generic_runtime_suspend(struct device *dev)
+{
+	struct dwc3_generic *dwc3 = dev_get_drvdata(dev);
+
+	return dwc3_runtime_suspend(&dwc3->dwc);
+}
+
+static int dwc3_generic_runtime_resume(struct device *dev)
+{
+	struct dwc3_generic *dwc3 = dev_get_drvdata(dev);
+
+	return dwc3_runtime_resume(&dwc3->dwc);
+}
+
+static int dwc3_generic_runtime_idle(struct device *dev)
+{
+	struct dwc3_generic *dwc3 = dev_get_drvdata(dev);
+
+	return dwc3_runtime_idle(&dwc3->dwc);
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
2.50.1


