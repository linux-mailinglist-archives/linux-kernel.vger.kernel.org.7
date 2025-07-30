Return-Path: <linux-kernel+bounces-750306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17234B159CC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E544560947
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20B6290BC8;
	Wed, 30 Jul 2025 07:42:17 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4181E7C27;
	Wed, 30 Jul 2025 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861337; cv=none; b=FwWeyOF/QROMmzbI8qqtsB0JxlvDVeFRHFlfcAaShEXudl4IDizNv6cnRu6IXXGwLtwuU1IhO1boV05uUKAdknPtKB72dMHOlt89qDxF/U4AUGj8UEVhDwLQ47IxiJx3m3dcHal4sJrVYzi2ZRQ7d4ZMXmC6/mfIfSWKiJpv3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861337; c=relaxed/simple;
	bh=Jy5buhfNQWEdoYecamEiCJwtPxunZbYDYXWlN6ah0AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pO/4D1NV5uV6TloEUqPSzHC1+vlYCnhMOlEETE2QB6V5ianSFkhJXRiV1QB9eR2VsvCuIq5/gqR/QOUqXNcqn+IEZL7SAvqWvp8IgSXkLTkhqjj+/ZDpWqw3yoWjEXxM5+zO+A420FMtangNtOJUXKKYMu7CR383QrwxGL7PKso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004758DT.eswin.cn (unknown [10.12.96.83])
	by app2 (Coremail) with SMTP id TQJkCgBn+ZLGzIlo8OC4AA--.27051S2;
	Wed, 30 Jul 2025 15:41:59 +0800 (CST)
From: zhangsenchuan@eswincomputing.com
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Thinh.Nguyen@synopsys.com,
	p.zabel@pengutronix.de
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	yangwei1@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v2 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
Date: Wed, 30 Jul 2025 15:41:55 +0800
Message-ID: <20250730074156.1600-1-zhangsenchuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250730073953.1623-1-zhangsenchuan@eswincomputing.com>
References: <20250730073953.1623-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBn+ZLGzIlo8OC4AA--.27051S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW8Jw47Xw1rWryrWw4fGrg_yoW3JFy3pF
	4UJFy5KrZ3Gr4xXw4fAF1v9F4rJw40gFy8JrWIg3Zruw18tas7XF1kKFyYgFn8AFn8JFy5
	JF4DKayFkF4Y9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHCJQUUUUU=
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/

From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>

Add the eic7700 usb driver, which is responsible for
identifying,configuring and connecting usb devices.

Co-developed-by: Wei Yang <yangwei1@eswincomputing.com>
Signed-off-by: Wei Yang <yangwei1@eswincomputing.com>
Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
---
 drivers/usb/dwc3/Kconfig        |  11 ++
 drivers/usb/dwc3/Makefile       |   1 +
 drivers/usb/dwc3/dwc3-eic7700.c | 207 ++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)
 create mode 100644 drivers/usb/dwc3/dwc3-eic7700.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 310d182e10b5..19657cfb5d08 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -189,4 +189,15 @@ config USB_DWC3_RTK
 	  or dual-role mode.
 	  Say 'Y' or 'M' if you have such device.
 
+config USB_DWC3_EIC7700
+	tristate "Eswin Platforms"
+	depends on OF
+	depends on USB=y || USB=USB_DWC3
+	default USB_DWC3
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
index 000000000000..337f6c1cbe66
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-eic7700.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Eswin Specific Glue layer
+ *
+ * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd.
+ *
+ * Authors: Wei Yang <yangwei1@eswincomputing.com>
+ *          Senchuan Zhang <zhangsenchuan@eswincomputing.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/reset.h>
+#include <linux/usb.h>
+#include <linux/pm.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#define HSP_USB_VBUS_FSEL 0x2a
+#define HSP_USB_MPLL_DEFAULT 0x0
+
+#define HSP_USB_BUS_FILTER_EN (0x1 << 0)
+#define HSP_USB_BUS_CLKEN_GM (0x1 << 9)
+#define HSP_USB_BUS_CLKEN_GS (0x1 << 16)
+#define HSP_USB_BUS_SW_RST (0x1 << 24)
+#define HSP_USB_BUS_CLK_EN (0x1 << 28)
+
+#define HSP_USB_AXI_LP_XM_CSYSREQ (0x1 << 0)
+#define HSP_USB_AXI_LP_XS_CSYSREQ (0x1 << 16)
+
+struct dwc3_eswin {
+	int num_clks;
+	struct device *dev;
+	struct clk_bulk_data *clks;
+	struct reset_control *vaux_rst;
+};
+
+static int dwc_usb_clk_init(struct device *dev)
+{
+	struct regmap *regmap;
+	u32 hsp_usb_bus;
+	u32 hsp_usb_axi_lp;
+	u32 hsp_usb_vbus_freq;
+	u32 hsp_usb_mpll;
+	u32 args[4];
+
+	regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+						      "eswin,hsp-sp-csr", 4,
+						      args);
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
+	 * usb clock init
+	 * ref clock is 24M, below need to be set to satisfy
+	 * usb phy requirement(125M)
+	 */
+	regmap_write(regmap, hsp_usb_vbus_freq, HSP_USB_VBUS_FSEL);
+	regmap_write(regmap, hsp_usb_mpll, HSP_USB_MPLL_DEFAULT);
+	/*
+	 * reset usb core and usb phy
+	 */
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
+	struct dwc3_eswin *eswin;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	eswin = devm_kzalloc(dev, sizeof(*eswin), GFP_KERNEL);
+	if (!eswin)
+		return -ENOMEM;
+
+	eswin->dev = dev;
+	platform_set_drvdata(pdev, eswin);
+
+	eswin->num_clks = devm_clk_bulk_get_all_enabled(dev, &eswin->clks);
+	if (eswin->num_clks < 0)
+		return dev_err_probe(dev, eswin->num_clks,
+				     "Failed to get usb clocks\n");
+
+	eswin->vaux_rst = devm_reset_control_get(dev, "vaux");
+	if (IS_ERR(eswin->vaux_rst))
+		return dev_err_probe(dev, PTR_ERR(eswin->vaux_rst),
+				     "Failed to get vaux reset\n");
+
+	ret = reset_control_deassert(eswin->vaux_rst);
+	if (ret)
+		return dev_err_probe(eswin->dev, ret,
+				     "Failed to deassert reset\n");
+
+	ret = dwc_usb_clk_init(dev);
+	if (ret) {
+		dev_err(eswin->dev, "Failed to clk init: %d\n", ret);
+		goto reset_assert;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "get_sync failed with err %d\n", ret);
+		goto disable_pm;
+	}
+
+	/* Allocate and initialize the core */
+	ret = of_platform_populate(np, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "failed to create dwc3 core: %d\n", ret);
+		goto put_pm;
+	}
+
+	return ret;
+
+put_pm:
+	pm_runtime_put_sync(dev);
+disable_pm:
+	pm_runtime_disable(dev);
+reset_assert:
+	reset_control_assert(eswin->vaux_rst);
+
+	return ret;
+}
+
+static void dwc3_eswin_remove(struct platform_device *pdev)
+{
+	struct dwc3_eswin *eswin = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	of_platform_depopulate(dev);
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	reset_control_assert(eswin->vaux_rst);
+}
+
+static int __maybe_unused dwc3_eswin_runtime_suspend(struct device *dev)
+{
+	struct dwc3_eswin *eswin = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(eswin->num_clks, eswin->clks);
+
+	return 0;
+}
+
+static int __maybe_unused dwc3_eswin_runtime_resume(struct device *dev)
+{
+	struct dwc3_eswin *eswin = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(eswin->num_clks, eswin->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static const struct dev_pm_ops dwc3_eswin_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(dwc3_eswin_runtime_suspend,
+			   dwc3_eswin_runtime_resume, NULL)
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
+		.pm	= &dwc3_eswin_dev_pm_ops,
+		.of_match_table = eswin_dwc3_match,
+	},
+};
+
+module_platform_driver(dwc3_eswin_driver);
+
+MODULE_AUTHOR("Wei Yang <yangwei1@eswincomputing.com");
+MODULE_AUTHOR("Senchuan Zhang <zhangsenchuan@eswincomputing.com");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DesignWare USB3 ESWIN Glue Layer");
-- 
2.25.1


