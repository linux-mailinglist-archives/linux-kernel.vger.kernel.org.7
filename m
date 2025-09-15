Return-Path: <linux-kernel+bounces-816470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACD1B57429
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 459497A4834
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446E72EFDA4;
	Mon, 15 Sep 2025 09:11:22 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF35028468E;
	Mon, 15 Sep 2025 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927481; cv=none; b=TrWB8xdEKhUHl+muPSgYXSITMYZCziLB6HK90UoQN58FboTOu+HRb/a9ZeN51sA5Zc37Tn9U5mKuZmx4Z5c2ue5fVVEuGCSzHb5EXdldNJ7OozwDqh13U7/b/E6WEU+YRa0QkmF4X0YRkBQsQr4QFIp0ahKUfkfYCU96VHUBqEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927481; c=relaxed/simple;
	bh=yFi8cRadx195sIEL/v50y4jcj2/wqodeTLR3JoFsz8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbs5vfNs7IJUUa0qMLDMOcIkG7Hsdos93JfR+SWbo0YbPr9AHq7h4NOMiYAW09tZx8Kg6+rA4KaUFcAEVk/Z/YLNYVx6nPqR6eIav/jOOADpbOppn743HvOM6HZeivRii2Nqpek3u1iFxW0gkX4a7t0mSFozjVkj4PMLeD+pr58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006493LT.eswin.cn (unknown [10.127.112.153])
	by app1 (Coremail) with SMTP id TAJkCgBXexEe2MdohlfRAA--.46204S4;
	Mon, 15 Sep 2025 17:10:55 +0800 (CST)
From: caohang@eswincomputing.com
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Thinh.Nguyen@synopsys.com,
	p.zabel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Hang Cao <caohang@eswincomputing.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v3 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
Date: Mon, 15 Sep 2025 17:10:51 +0800
Message-ID: <20250915091051.2148-1-caohang@eswincomputing.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20250915085329.2058-1-caohang@eswincomputing.com>
References: <20250915085329.2058-1-caohang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgBXexEe2MdohlfRAA--.46204S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKw17JFyUuw4xJF18Wr1xZrb_yoWfXw4UpF
	4UJFW5Krs3Gr92gan3AF1vvF4ftw40gFy7JrZ2g3Zxuw18tasrJF18GFyYq3Z8urn8Wry5
	JF4UJ3yFkF4xK3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ec7CjxVAajcxG14v26r1j6r4UMcIj6I8E87Iv67AKxV
	WUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS
	5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7
	AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjfU54SrUUUUU
X-CM-SenderInfo: xfdrxt1qj6v25zlqu0xpsx3x1qjou0bp/

From: Hang Cao <caohang@eswincomputing.com>

Add the EIC7700 usb driver, which is responsible for
identifying,configuring and connecting usb devices.

Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Signed-off-by: Hang Cao <caohang@eswincomputing.com>
---
 drivers/usb/dwc3/Kconfig        |  11 ++
 drivers/usb/dwc3/Makefile       |   1 +
 drivers/usb/dwc3/dwc3-eic7700.c | 261 ++++++++++++++++++++++++++++++++
 3 files changed, 273 insertions(+)
 create mode 100644 drivers/usb/dwc3/dwc3-eic7700.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 310d182e10b5..2ae1817987d2 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -189,4 +189,15 @@ config USB_DWC3_RTK
 	  or dual-role mode.
 	  Say 'Y' or 'M' if you have such device.
 
+config USB_DWC3_EIC7700
+	tristate "Eswin Platforms"
+	depends on ARCH_ESWIN || COMPILE_TEST
+	default USB_DWC3
+	depends on OF
+	help
+	  The usb controller on eic7700 SoC.
+	  support of USB2/3 functionality
+	  in Eswin platforms.
+	  say 'Y' or 'M' if you have one such device.
+
 endif
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 830e6c9e5fe0..05f582103f8b 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_USB_DWC3_IMX8MP)		+= dwc3-imx8mp.o
 obj-$(CONFIG_USB_DWC3_XILINX)		+= dwc3-xilinx.o
 obj-$(CONFIG_USB_DWC3_OCTEON)		+= dwc3-octeon.o
 obj-$(CONFIG_USB_DWC3_RTK)		+= dwc3-rtk.o
+obj-$(CONFIG_USB_DWC3_EIC7700)		+= dwc3-eic7700.o
diff --git a/drivers/usb/dwc3/dwc3-eic7700.c b/drivers/usb/dwc3/dwc3-eic7700.c
new file mode 100644
index 000000000000..7d3d051fd0bb
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-eic7700.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ESWIN Specific Glue layer
+ *
+ * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd.
+ *
+ * Authors: Wei Yang <yangwei1@eswincomputing.com>
+ *          Senchuan Zhang <zhangsenchuan@eswincomputing.com>
+ *          Hang Cao <caohang@eswincomputing.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/usb.h>
+
+#include "glue.h"
+
+#define HSP_USB_VBUS_FSEL		0x2a
+#define HSP_USB_MPLL_DEFAULT		0x0
+
+#define HSP_USB_BUS_FILTER_EN		BIT(0)
+#define HSP_USB_BUS_CLKEN_GM		BIT(9)
+#define HSP_USB_BUS_CLKEN_GS		BIT(16)
+#define HSP_USB_BUS_SW_RST		BIT(24)
+#define HSP_USB_BUS_CLK_EN		BIT(28)
+
+#define HSP_USB_AXI_LP_XM_CSYSREQ	BIT(0)
+#define HSP_USB_AXI_LP_XS_CSYSREQ	BIT(16)
+
+struct dwc3_eswin {
+	struct device *dev;
+	struct dwc3 dwc;
+	struct clk_bulk_data *clks;
+	int num_clks;
+	struct reset_control *vaux_rst;
+};
+
+#define to_dwc3_eswin(d) container_of((d), struct dwc3_eswin, dwc)
+
+static int dwc_usb_clk_init(struct device *dev)
+{
+	struct regmap *regmap;
+	u32 hsp_usb_vbus_freq;
+	u32 hsp_usb_axi_lp;
+	u32 hsp_usb_bus;
+	u32 hsp_usb_mpll;
+	u32 args[4];
+
+	regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+						      "eswin,hsp-sp-csr",
+						      ARRAY_SIZE(args), args);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "No hsp-sp-csr phandle specified\n");
+		return PTR_ERR(regmap);
+	}
+
+	hsp_usb_bus       = args[0];
+	hsp_usb_axi_lp    = args[1];
+	hsp_usb_vbus_freq = args[2];
+	hsp_usb_mpll      = args[3];
+
+	/*
+	 * usb clock init,ref clock is 24M below need to be set to satisfy usb
+	 * phy requirement(125M)
+	 */
+	regmap_write(regmap, hsp_usb_vbus_freq, HSP_USB_VBUS_FSEL);
+	regmap_write(regmap, hsp_usb_mpll, HSP_USB_MPLL_DEFAULT);
+
+	/* reset usb core and usb phy */
+	regmap_write(regmap, hsp_usb_bus, HSP_USB_BUS_FILTER_EN |
+		     HSP_USB_BUS_CLKEN_GM | HSP_USB_BUS_CLKEN_GS |
+		     HSP_USB_BUS_SW_RST | HSP_USB_BUS_CLK_EN);
+	regmap_write(regmap, hsp_usb_axi_lp, HSP_USB_AXI_LP_XM_CSYSREQ |
+		     HSP_USB_AXI_LP_XS_CSYSREQ);
+
+	return 0;
+}
+
+static int dwc3_eswin_probe(struct platform_device *pdev)
+{
+	struct dwc3_probe_data probe_data = {};
+	struct device *dev = &pdev->dev;
+	struct dwc3_eswin *eswin;
+	struct resource *res;
+	int ret;
+
+	eswin = devm_kzalloc(dev, sizeof(*eswin), GFP_KERNEL);
+	if (!eswin)
+		return -ENOMEM;
+
+	eswin->dev = dev;
+	eswin->num_clks = devm_clk_bulk_get_all_enabled(dev, &eswin->clks);
+	if (eswin->num_clks < 0)
+		return dev_err_probe(dev, eswin->num_clks,
+			"Failed to get usb clocks\n");
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return dev_err_probe(dev, -ENODEV,
+			"Missing memory resource\n");
+
+	eswin->vaux_rst = devm_reset_control_get(dev, "vaux");
+	if (IS_ERR(eswin->vaux_rst))
+		return dev_err_probe(dev, PTR_ERR(eswin->vaux_rst),
+		"Failed to get vaux reset\n");
+
+	ret = reset_control_deassert(eswin->vaux_rst);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			"Failed to deassert reset\n");
+
+	ret = dwc_usb_clk_init(dev);
+	if (ret) {
+		dev_err(dev, "Failed to clk init: %d\n", ret);
+		goto reset_assert;
+	}
+
+	eswin->dwc.dev = dev;
+	probe_data.dwc = &eswin->dwc;
+	probe_data.res = res;
+	probe_data.ignore_clocks_and_resets = true;
+	ret = dwc3_core_probe(&probe_data);
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to register DWC3 Core\n");
+		goto reset_assert;
+	}
+
+	return 0;
+
+reset_assert:
+	reset_control_assert(eswin->vaux_rst);
+
+	return ret;
+}
+
+static void dwc3_eswin_remove(struct platform_device *pdev)
+{
+	struct dwc3 *dwc = platform_get_drvdata(pdev);
+	struct dwc3_eswin *eswin = to_dwc3_eswin(dwc);
+
+	dwc3_core_remove(&eswin->dwc);
+
+	reset_control_assert(eswin->vaux_rst);
+}
+
+static void dwc3_eswin_complete(struct device *dev)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+
+	dwc3_pm_complete(dwc);
+}
+
+static int dwc3_eswin_prepare(struct device *dev)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+
+	return dwc3_pm_prepare(dwc);
+}
+
+static int dwc3_eswin_pm_suspend(struct device *dev)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+	struct dwc3_eswin *eswin = to_dwc3_eswin(dwc);
+	int ret;
+
+	ret = dwc3_pm_suspend(&eswin->dwc);
+	if (ret)
+		return ret;
+
+	clk_bulk_disable_unprepare(eswin->num_clks, eswin->clks);
+
+	return 0;
+}
+
+static int dwc3_eswin_pm_resume(struct device *dev)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+	struct dwc3_eswin *eswin = to_dwc3_eswin(dwc);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(eswin->num_clks, eswin->clks);
+	if (ret) {
+		dev_err(dev, "Failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	return dwc3_pm_resume(&eswin->dwc);
+}
+
+static int dwc3_eswin_runtime_suspend(struct device *dev)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+	struct dwc3_eswin *eswin = to_dwc3_eswin(dwc);
+	int ret;
+
+	ret = dwc3_runtime_suspend(&eswin->dwc);
+	if (ret)
+		return ret;
+
+	clk_bulk_disable_unprepare(eswin->num_clks, eswin->clks);
+	return 0;
+}
+
+static int dwc3_eswin_runtime_resume(struct device *dev)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+	struct dwc3_eswin *eswin = to_dwc3_eswin(dwc);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(eswin->num_clks, eswin->clks);
+	if (ret) {
+		dev_err(dev, "Failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	return dwc3_runtime_resume(&eswin->dwc);
+}
+
+static int dwc3_eswin_runtime_idle(struct device *dev)
+{
+	return dwc3_runtime_idle(dev_get_drvdata(dev));
+}
+
+static const struct dev_pm_ops dwc3_eswin_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dwc3_eswin_pm_suspend, dwc3_eswin_pm_resume)
+	SET_RUNTIME_PM_OPS(dwc3_eswin_runtime_suspend,
+			   dwc3_eswin_runtime_resume, dwc3_eswin_runtime_idle)
+	.complete = pm_sleep_ptr(dwc3_eswin_complete),
+	.prepare = pm_sleep_ptr(dwc3_eswin_prepare),
+};
+
+static const struct of_device_id eswin_dwc3_match[] = {
+	{ .compatible = "eswin,eic7700-dwc3" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, eswin_dwc3_match);
+
+static struct platform_driver dwc3_eswin_driver = {
+	.probe = dwc3_eswin_probe,
+	.remove = dwc3_eswin_remove,
+	.driver = {
+		.name = "eic7700-dwc3",
+		.pm	= pm_ptr(&dwc3_eswin_dev_pm_ops),
+		.of_match_table = eswin_dwc3_match,
+	},
+};
+
+module_platform_driver(dwc3_eswin_driver);
+
+MODULE_AUTHOR("Wei Yang <yangwei1@eswincomputing.com");
+MODULE_AUTHOR("Senchuan Zhang <zhangsenchuan@eswincomputing.com");
+MODULE_AUTHOR("Hang Cao <caohang@eswincomputing.com");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DesignWare USB3 ESWIN Glue Layer");
-- 
2.34.1


