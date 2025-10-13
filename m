Return-Path: <linux-kernel+bounces-850269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D476BBD25F4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57AB8349FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC2F2FF679;
	Mon, 13 Oct 2025 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZJbeI3k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B62FE06C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348927; cv=none; b=XsUl9MjAqILNcmnuELCkDtSbpa6w6JUQFJUVjI6wo1mr8DtSBQDDTHF5yNrW19QTat1cMclzD3cRhEWb+XLwoJswxdbSvn+bSj6MljQon+29+B3h+YPxRx/FL1IBeg15vJa3W2O7+wsMKG49VmpyfsHZ/yIpy/zaQ+DlpZgQOhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348927; c=relaxed/simple;
	bh=o1ZBRe04qCznx5vGi8J/gWWXoRKEi3IAlB8Qhb0gwzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njyLhnGe4wxbKtuvomGVbNGcmCPV6BvrRBgf0e+hucm7wYA4z9zzdWE5d4Yl0KOkT5e6PVGvGUFe0xssaKxYGZIO0EC9PygS4Lu8ahuDLSiao+140tbRPCz+E4gbxzMqe/zpYlkCDwxlJL3TLHloOVnHpS5BGa7ifLEl4Z+Riwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZJbeI3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE631C4AF09;
	Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760348927;
	bh=o1ZBRe04qCznx5vGi8J/gWWXoRKEi3IAlB8Qhb0gwzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZJbeI3kQvnUFiLYKuqJNScfLu0/hijdXQHQmw/3WxI+mHdi8+uJGGbwvMueSBORD
	 DUjV0+F4FJ7uXIsS/DFq1K69ZFjdAsf7pnnP3PaodbTq7nOesTXZDcla+RwVltHAlH
	 hCN6y7IXohtjJXgB3JW0e7QQh5eXIRxL7TLRpgqzVHh7p3xvszERln2suU1z3wURPc
	 iWwKt45DVtarX8pgMB3oV/oBeG+n8hacdUpIygGVJf5metQqnui8vnnCOuwu/RQ5Pd
	 g0j6EbOn8ePwgTT/j/vbPgggmSHA0m0BLrQeOQbyq5LBxp5ew6wAY8XHqlNOi/eNwa
	 BUmBZcyJYqn+g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8FAa-0000000036l-22RX;
	Mon, 13 Oct 2025 11:48:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 11/11] irqchip: Pass platform device to platform drivers
Date: Mon, 13 Oct 2025 11:46:11 +0200
Message-ID: <20251013094611.11745-12-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251013094611.11745-1-johan@kernel.org>
References: <20251013094611.11745-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IRQCHIP_PLATFORM_DRIVER macros can be used to convert OF irqchip
drivers to platform drivers but currently reuse the OF init callback
prototype that only takes OF nodes as arguments. This forces drivers to
do reverse lookups of their struct devices during probe if they need
them for things like dev_printk() and device managed resources.

Half of the drivers doing reverse lookups also currently fail to release
the additional reference taken during the lookup, while other drivers
have had the reference leak plugged in various ways (e.g. using
non-intuitive cleanup constructs which still confuse static checkers).

Switch to using a probe callback that takes a platform device as its
first argument to simplify drivers and plug the remaining (mostly
benign) reference leaks.

Fixes: 32c6c054661a ("irqchip: Add Broadcom BCM2712 MSI-X interrupt controller")
Fixes: 70afdab904d2 ("irqchip: Add IMX MU MSI controller driver")
Fixes: a6199bb514d8 ("irqchip: Add Qualcomm MPM controller driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/irqchip/irq-bcm2712-mip.c          | 10 ++-----
 drivers/irqchip/irq-bcm7038-l1.c           |  5 ++--
 drivers/irqchip/irq-bcm7120-l2.c           | 20 ++++---------
 drivers/irqchip/irq-brcmstb-l2.c           | 21 ++++++-------
 drivers/irqchip/irq-imx-mu-msi.c           | 25 +++++++---------
 drivers/irqchip/irq-mchp-eic.c             |  5 ++--
 drivers/irqchip/irq-meson-gpio.c           |  5 ++--
 drivers/irqchip/irq-qcom-mpm.c             |  6 ++--
 drivers/irqchip/irq-renesas-rzg2l.c        | 35 +++++++---------------
 drivers/irqchip/irq-renesas-rzv2h.c        | 32 ++++++--------------
 drivers/irqchip/irq-starfive-jh8100-intc.c |  5 ++--
 drivers/irqchip/irqchip.c                  |  6 ++--
 drivers/irqchip/qcom-pdc.c                 |  5 ++--
 include/linux/irqchip.h                    |  8 ++++-
 14 files changed, 78 insertions(+), 110 deletions(-)

diff --git a/drivers/irqchip/irq-bcm2712-mip.c b/drivers/irqchip/irq-bcm2712-mip.c
index 8466646e5a2d..4761974ad650 100644
--- a/drivers/irqchip/irq-bcm2712-mip.c
+++ b/drivers/irqchip/irq-bcm2712-mip.c
@@ -232,16 +232,12 @@ static int mip_parse_dt(struct mip_priv *mip, struct device_node *np)
 	return ret;
 }
 
-static int mip_of_msi_init(struct device_node *node, struct device_node *parent)
+static int mip_msi_probe(struct platform_device *pdev, struct device_node *parent)
 {
-	struct platform_device *pdev;
+	struct device_node *node = pdev->dev.of_node;
 	struct mip_priv *mip;
 	int ret;
 
-	pdev = of_find_device_by_node(node);
-	if (!pdev)
-		return -EPROBE_DEFER;
-
 	mip = kzalloc(sizeof(*mip), GFP_KERNEL);
 	if (!mip)
 		return -ENOMEM;
@@ -284,7 +280,7 @@ static int mip_of_msi_init(struct device_node *node, struct device_node *parent)
 }
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(mip_msi)
-IRQCHIP_MATCH("brcm,bcm2712-mip", mip_of_msi_init)
+IRQCHIP_MATCH("brcm,bcm2712-mip", mip_msi_probe)
 IRQCHIP_PLATFORM_DRIVER_END(mip_msi)
 MODULE_DESCRIPTION("Broadcom BCM2712 MSI-X interrupt controller");
 MODULE_AUTHOR("Phil Elwell <phil@raspberrypi.com>");
diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index e28be83872cb..f9f725499dc3 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -395,8 +395,9 @@ static const struct irq_domain_ops bcm7038_l1_domain_ops = {
 	.map			= bcm7038_l1_map,
 };
 
-static int bcm7038_l1_of_init(struct device_node *dn, struct device_node *parent)
+static int bcm7038_l1_probe(struct platform_device *pdev, struct device_node *parent)
 {
+	struct device_node *dn = pdev->dev.of_node;
 	struct bcm7038_l1_chip *intc;
 	int idx, ret;
 
@@ -454,7 +455,7 @@ static int bcm7038_l1_of_init(struct device_node *dn, struct device_node *parent
 }
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(bcm7038_l1)
-IRQCHIP_MATCH("brcm,bcm7038-l1-intc", bcm7038_l1_of_init)
+IRQCHIP_MATCH("brcm,bcm7038-l1-intc", bcm7038_l1_probe)
 IRQCHIP_PLATFORM_DRIVER_END(bcm7038_l1)
 MODULE_DESCRIPTION("Broadcom STB 7038-style L1/L2 interrupt controller");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 63ff68d33787..5e87999de811 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -206,15 +206,15 @@ static int bcm7120_l2_intc_iomap_3380(struct device_node *dn, struct bcm7120_l2_
 	return 0;
 }
 
-static int bcm7120_l2_intc_probe(struct device_node *dn,
+static int bcm7120_l2_intc_probe(struct platform_device *pdev,
 				 struct device_node *parent,
 				 int (*iomap_regs_fn)(struct device_node *,
 					struct bcm7120_l2_intc_data *),
 				 const char *intc_name)
 {
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	struct device_node *dn = pdev->dev.of_node;
 	struct bcm7120_l2_intc_data *data;
-	struct platform_device *pdev;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 	int ret = 0;
@@ -225,14 +225,7 @@ static int bcm7120_l2_intc_probe(struct device_node *dn,
 	if (!data)
 		return -ENOMEM;
 
-	pdev = of_find_device_by_node(dn);
-	if (!pdev) {
-		ret = -ENODEV;
-		goto out_free_data;
-	}
-
 	data->num_parent_irqs = platform_irq_count(pdev);
-	put_device(&pdev->dev);
 	if (data->num_parent_irqs <= 0) {
 		pr_err("invalid number of parent interrupts\n");
 		ret = -ENOMEM;
@@ -332,20 +325,19 @@ static int bcm7120_l2_intc_probe(struct device_node *dn,
 		if (data->map_base[idx])
 			iounmap(data->map_base[idx]);
 	}
-out_free_data:
 	kfree(data);
 	return ret;
 }
 
-static int bcm7120_l2_intc_probe_7120(struct device_node *dn, struct device_node *parent)
+static int bcm7120_l2_intc_probe_7120(struct platform_device *pdev, struct device_node *parent)
 {
-	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_7120,
+	return bcm7120_l2_intc_probe(pdev, parent, bcm7120_l2_intc_iomap_7120,
 				     "BCM7120 L2");
 }
 
-static int bcm7120_l2_intc_probe_3380(struct device_node *dn, struct device_node *parent)
+static int bcm7120_l2_intc_probe_3380(struct platform_device *pdev, struct device_node *parent)
 {
-	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_3380,
+	return bcm7120_l2_intc_probe(pdev, parent, bcm7120_l2_intc_iomap_3380,
 				     "BCM3380 L2");
 }
 
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 53e67c6c01f7..bb7078d6524f 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -138,11 +138,12 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	irq_reg_writel(gc, ~b->saved_mask, ct->regs.enable);
 }
 
-static int brcmstb_l2_intc_of_init(struct device_node *np, struct device_node *parent,
-				   const struct brcmstb_intc_init_params *init_params)
+static int brcmstb_l2_intc_probe(struct platform_device *pdev, struct device_node *parent,
+				 const struct brcmstb_intc_init_params *init_params)
 {
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	unsigned int set = 0;
+	struct device_node *np = pdev->dev.of_node;
 	struct brcmstb_l2_intc_data *data;
 	struct irq_chip_type *ct;
 	int ret;
@@ -255,21 +256,21 @@ static int brcmstb_l2_intc_of_init(struct device_node *np, struct device_node *p
 	return ret;
 }
 
-static int brcmstb_l2_edge_intc_of_init(struct device_node *np, struct device_node *parent)
+static int brcmstb_l2_edge_intc_probe(struct platform_device *pdev, struct device_node *parent)
 {
-	return brcmstb_l2_intc_of_init(np, parent, &l2_edge_intc_init);
+	return brcmstb_l2_intc_probe(pdev, parent, &l2_edge_intc_init);
 }
 
-static int brcmstb_l2_lvl_intc_of_init(struct device_node *np, struct device_node *parent)
+static int brcmstb_l2_lvl_intc_probe(struct platform_device *pdev, struct device_node *parent)
 {
-	return brcmstb_l2_intc_of_init(np, parent, &l2_lvl_intc_init);
+	return brcmstb_l2_intc_probe(pdev, parent, &l2_lvl_intc_init);
 }
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(brcmstb_l2)
-IRQCHIP_MATCH("brcm,l2-intc", brcmstb_l2_edge_intc_of_init)
-IRQCHIP_MATCH("brcm,hif-spi-l2-intc", brcmstb_l2_edge_intc_of_init)
-IRQCHIP_MATCH("brcm,upg-aux-aon-l2-intc", brcmstb_l2_edge_intc_of_init)
-IRQCHIP_MATCH("brcm,bcm7271-l2-intc", brcmstb_l2_lvl_intc_of_init)
+IRQCHIP_MATCH("brcm,l2-intc", brcmstb_l2_edge_intc_probe)
+IRQCHIP_MATCH("brcm,hif-spi-l2-intc", brcmstb_l2_edge_intc_probe)
+IRQCHIP_MATCH("brcm,upg-aux-aon-l2-intc", brcmstb_l2_edge_intc_probe)
+IRQCHIP_MATCH("brcm,bcm7271-l2-intc", brcmstb_l2_lvl_intc_probe)
 IRQCHIP_PLATFORM_DRIVER_END(brcmstb_l2)
 MODULE_DESCRIPTION("Broadcom STB generic L2 interrupt controller");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
index d247f77e5477..c598f2f52fc6 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -296,11 +296,9 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
 		  },
 };
 
-static int imx_mu_of_init(struct device_node *dn,
-			  struct device_node *parent,
-			  const struct imx_mu_dcfg *cfg)
+static int imx_mu_probe(struct platform_device *pdev, struct device_node *parent,
+			const struct imx_mu_dcfg *cfg)
 {
-	struct platform_device *pdev = of_find_device_by_node(dn);
 	struct device_link *pd_link_a;
 	struct device_link *pd_link_b;
 	struct imx_mu_msi *msi_data;
@@ -416,28 +414,27 @@ static const struct dev_pm_ops imx_mu_pm_ops = {
 			   imx_mu_runtime_resume, NULL)
 };
 
-static int imx_mu_imx7ulp_of_init(struct device_node *dn, struct device_node *parent)
+static int imx_mu_imx7ulp_probe(struct platform_device *pdev, struct device_node *parent)
 {
-	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx7ulp);
+	return imx_mu_probe(pdev, parent, &imx_mu_cfg_imx7ulp);
 }
 
-static int imx_mu_imx6sx_of_init(struct device_node *dn, struct device_node *parent)
+static int imx_mu_imx6sx_probe(struct platform_device *pdev, struct device_node *parent)
 {
-	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx6sx);
+	return imx_mu_probe(pdev, parent, &imx_mu_cfg_imx6sx);
 }
 
-static int imx_mu_imx8ulp_of_init(struct device_node *dn, struct device_node *parent)
+static int imx_mu_imx8ulp_probe(struct platform_device *pdev, struct device_node *parent)
 {
-	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx8ulp);
+	return imx_mu_probe(pdev, parent, &imx_mu_cfg_imx8ulp);
 }
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(imx_mu_msi)
-IRQCHIP_MATCH("fsl,imx7ulp-mu-msi", imx_mu_imx7ulp_of_init)
-IRQCHIP_MATCH("fsl,imx6sx-mu-msi", imx_mu_imx6sx_of_init)
-IRQCHIP_MATCH("fsl,imx8ulp-mu-msi", imx_mu_imx8ulp_of_init)
+IRQCHIP_MATCH("fsl,imx7ulp-mu-msi", imx_mu_imx7ulp_probe)
+IRQCHIP_MATCH("fsl,imx6sx-mu-msi", imx_mu_imx6sx_probe)
+IRQCHIP_MATCH("fsl,imx8ulp-mu-msi", imx_mu_imx8ulp_probe)
 IRQCHIP_PLATFORM_DRIVER_END(imx_mu_msi, .pm = &imx_mu_pm_ops)
 
-
 MODULE_AUTHOR("Frank Li <Frank.Li@nxp.com>");
 MODULE_DESCRIPTION("Freescale MU MSI controller driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/irqchip/irq-mchp-eic.c b/drivers/irqchip/irq-mchp-eic.c
index 516a3a0e359c..b513a899c085 100644
--- a/drivers/irqchip/irq-mchp-eic.c
+++ b/drivers/irqchip/irq-mchp-eic.c
@@ -199,8 +199,9 @@ static const struct irq_domain_ops mchp_eic_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
-static int mchp_eic_init(struct device_node *node, struct device_node *parent)
+static int mchp_eic_probe(struct platform_device *pdev, struct device_node *parent)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct irq_domain *parent_domain = NULL;
 	int ret, i;
 
@@ -273,7 +274,7 @@ static int mchp_eic_init(struct device_node *node, struct device_node *parent)
 }
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(mchp_eic)
-IRQCHIP_MATCH("microchip,sama7g5-eic", mchp_eic_init)
+IRQCHIP_MATCH("microchip,sama7g5-eic", mchp_eic_probe)
 IRQCHIP_PLATFORM_DRIVER_END(mchp_eic)
 
 MODULE_DESCRIPTION("Microchip External Interrupt Controller");
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 8e84724e8d28..6c5e2ff0d1cf 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -572,8 +572,9 @@ static int meson_gpio_irq_parse_dt(struct device_node *node, struct meson_gpio_i
 	return 0;
 }
 
-static int meson_gpio_irq_of_init(struct device_node *node, struct device_node *parent)
+static int meson_gpio_irq_probe(struct platform_device *pdev, struct device_node *parent)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct irq_domain *domain, *parent_domain;
 	struct meson_gpio_irq_controller *ctl;
 	int ret;
@@ -630,7 +631,7 @@ static int meson_gpio_irq_of_init(struct device_node *node, struct device_node *
 }
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(meson_gpio_intc)
-IRQCHIP_MATCH("amlogic,meson-gpio-intc", meson_gpio_irq_of_init)
+IRQCHIP_MATCH("amlogic,meson-gpio-intc", meson_gpio_irq_probe)
 IRQCHIP_PLATFORM_DRIVER_END(meson_gpio_intc)
 
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index 8d569f7c5a7a..83f31ea657b7 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -320,9 +320,9 @@ static bool gic_hwirq_is_mapped(struct mpm_gic_map *maps, int cnt, u32 hwirq)
 	return false;
 }
 
-static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
+static int qcom_mpm_probe(struct platform_device *pdev, struct device_node *parent)
 {
-	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct irq_domain *parent_domain;
 	struct generic_pm_domain *genpd;
@@ -478,7 +478,7 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 }
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(qcom_mpm)
-IRQCHIP_MATCH("qcom,mpm", qcom_mpm_init)
+IRQCHIP_MATCH("qcom,mpm", qcom_mpm_probe)
 IRQCHIP_PLATFORM_DRIVER_END(qcom_mpm)
 MODULE_DESCRIPTION("Qualcomm Technologies, Inc. MSM Power Manager");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 12b6eb150301..1bf19deb02c4 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -528,18 +527,15 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_irqc_priv *priv,
 	return 0;
 }
 
-static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *parent,
-				  const struct irq_chip *irq_chip)
+static int rzg2l_irqc_common_probe(struct platform_device *pdev, struct device_node *parent,
+				   const struct irq_chip *irq_chip)
 {
-	struct platform_device *pdev = of_find_device_by_node(node);
-	struct device *dev __free(put_device) = pdev ? &pdev->dev : NULL;
 	struct irq_domain *irq_domain, *parent_domain;
+	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	struct reset_control *resetn;
 	int ret;
 
-	if (!pdev)
-		return -ENODEV;
-
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain)
 		return dev_err_probe(dev, -ENODEV, "cannot find parent domain\n");
@@ -583,33 +579,22 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 
 	register_syscore_ops(&rzg2l_irqc_syscore_ops);
 
-	/*
-	 * Prevent the cleanup function from invoking put_device by assigning
-	 * NULL to dev.
-	 *
-	 * make coccicheck will complain about missing put_device calls, but
-	 * those are false positives, as dev will be automatically "put" via
-	 * __free_put_device on the failing path.
-	 * On the successful path we don't actually want to "put" dev.
-	 */
-	dev = NULL;
-
 	return 0;
 }
 
-static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
+static int rzg2l_irqc_probe(struct platform_device *pdev, struct device_node *parent)
 {
-	return rzg2l_irqc_common_init(node, parent, &rzg2l_irqc_chip);
+	return rzg2l_irqc_common_probe(pdev, parent, &rzg2l_irqc_chip);
 }
 
-static int rzfive_irqc_init(struct device_node *node, struct device_node *parent)
+static int rzfive_irqc_probe(struct platform_device *pdev, struct device_node *parent)
 {
-	return rzg2l_irqc_common_init(node, parent, &rzfive_irqc_chip);
+	return rzg2l_irqc_common_probe(pdev, parent, &rzfive_irqc_chip);
 }
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
-IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
-IRQCHIP_MATCH("renesas,r9a07g043f-irqc", rzfive_irqc_init)
+IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_probe)
+IRQCHIP_MATCH("renesas,r9a07g043f-irqc", rzfive_irqc_probe)
 IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
 MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 9018d9c3911e..899a423b5da8 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -490,29 +490,15 @@ static int rzv2h_icu_parse_interrupts(struct rzv2h_icu_priv *priv, struct device
 	return 0;
 }
 
-static void rzv2h_icu_put_device(void *data)
-{
-	put_device(data);
-}
-
-static int rzv2h_icu_init_common(struct device_node *node, struct device_node *parent,
-				 const struct rzv2h_hw_info *hw_info)
+static int rzv2h_icu_probe_common(struct platform_device *pdev, struct device_node *parent,
+				  const struct rzv2h_hw_info *hw_info)
 {
 	struct irq_domain *irq_domain, *parent_domain;
+	struct device_node *node = pdev->dev.of_node;
 	struct rzv2h_icu_priv *rzv2h_icu_data;
-	struct platform_device *pdev;
 	struct reset_control *resetn;
 	int ret;
 
-	pdev = of_find_device_by_node(node);
-	if (!pdev)
-		return -ENODEV;
-
-	ret = devm_add_action_or_reset(&pdev->dev, rzv2h_icu_put_device,
-				       &pdev->dev);
-	if (ret < 0)
-		return ret;
-
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
 		dev_err(&pdev->dev, "cannot find parent domain\n");
@@ -618,19 +604,19 @@ static const struct rzv2h_hw_info rzv2h_hw_params = {
 	.field_width	= 8,
 };
 
-static int rzg3e_icu_init(struct device_node *node, struct device_node *parent)
+static int rzg3e_icu_probe(struct platform_device *pdev, struct device_node *parent)
 {
-	return rzv2h_icu_init_common(node, parent, &rzg3e_hw_params);
+	return rzv2h_icu_probe_common(pdev, parent, &rzg3e_hw_params);
 }
 
-static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
+static int rzv2h_icu_probe(struct platform_device *pdev, struct device_node *parent)
 {
-	return rzv2h_icu_init_common(node, parent, &rzv2h_hw_params);
+	return rzv2h_icu_probe_common(pdev, parent, &rzv2h_hw_params);
 }
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzv2h_icu)
-IRQCHIP_MATCH("renesas,r9a09g047-icu", rzg3e_icu_init)
-IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_init)
+IRQCHIP_MATCH("renesas,r9a09g047-icu", rzg3e_icu_probe)
+IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_probe)
 IRQCHIP_PLATFORM_DRIVER_END(rzv2h_icu)
 MODULE_AUTHOR("Fabrizio Castro <fabrizio.castro.jz@renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/V2H(P) ICU Driver");
diff --git a/drivers/irqchip/irq-starfive-jh8100-intc.c b/drivers/irqchip/irq-starfive-jh8100-intc.c
index 117f2c651ebd..705361b4ebe0 100644
--- a/drivers/irqchip/irq-starfive-jh8100-intc.c
+++ b/drivers/irqchip/irq-starfive-jh8100-intc.c
@@ -114,8 +114,9 @@ static void starfive_intc_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int starfive_intc_init(struct device_node *intc, struct device_node *parent)
+static int starfive_intc_probe(struct platform_device *pdev, struct device_node *parent)
 {
+	struct device_node *intc = pdev->dev.of_node;
 	struct starfive_irq_chip *irqc;
 	struct reset_control *rst;
 	struct clk *clk;
@@ -198,7 +199,7 @@ static int starfive_intc_init(struct device_node *intc, struct device_node *pare
 }
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(starfive_intc)
-IRQCHIP_MATCH("starfive,jh8100-intc", starfive_intc_init)
+IRQCHIP_MATCH("starfive,jh8100-intc", starfive_intc_probe)
 IRQCHIP_PLATFORM_DRIVER_END(starfive_intc)
 
 MODULE_DESCRIPTION("StarFive JH8100 External Interrupt Controller");
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 652d20d2b07f..689c8e448901 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -36,9 +36,9 @@ int platform_irqchip_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *par_np __free(device_node) = of_irq_find_parent(np);
-	of_irq_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
+	platform_irq_probe_t irq_probe = of_device_get_match_data(&pdev->dev);
 
-	if (!irq_init_cb)
+	if (!irq_probe)
 		return -EINVAL;
 
 	if (par_np == np)
@@ -55,6 +55,6 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY))
 		return -EPROBE_DEFER;
 
-	return irq_init_cb(np, par_np);
+	return irq_probe(pdev, par_np);
 }
 EXPORT_SYMBOL_GPL(platform_irqchip_probe);
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index b0cdcdb7c505..d94beb786a67 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -469,10 +469,11 @@ static const struct of_device_id pdc_aux_gpio_matches[] = {
 	{ }
 };
 
-static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
+static int qcom_pdc_probe(struct platform_device *pdev, struct device_node *parent)
 {
 	unsigned int flags = IRQ_DOMAIN_FLAG_QCOM_PDC_WAKEUP;
 	struct irq_domain *parent_domain, *pdc_domain;
+	struct device_node *node = pdev->dev.of_node;
 	resource_size_t res_size;
 	struct resource res;
 	int ret;
@@ -558,7 +559,7 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 }
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(qcom_pdc)
-IRQCHIP_MATCH("qcom,pdc", qcom_pdc_init)
+IRQCHIP_MATCH("qcom,pdc", qcom_pdc_probe)
 IRQCHIP_PLATFORM_DRIVER_END(qcom_pdc)
 MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index d5e6024cb2a8..bc4ddacd6ddc 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -17,12 +17,18 @@
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 
+typedef int (*platform_irq_probe_t)(struct platform_device *, struct device_node *);
+
 /* Undefined on purpose */
 extern of_irq_init_cb_t typecheck_irq_init_cb;
+extern platform_irq_probe_t typecheck_irq_probe;
 
 #define typecheck_irq_init_cb(fn)					\
 	(__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
 
+#define typecheck_irq_probe(fn)						\
+	(__typecheck(typecheck_irq_probe, &fn) ? fn : fn)
+
 /*
  * This macro must be used by the different irqchip drivers to declare
  * the association between their DT compatible string and their
@@ -42,7 +48,7 @@ extern int platform_irqchip_probe(struct platform_device *pdev);
 static const struct of_device_id drv_name##_irqchip_match_table[] = {
 
 #define IRQCHIP_MATCH(compat, fn) { .compatible = compat,		\
-				    .data = typecheck_irq_init_cb(fn), },
+				    .data = typecheck_irq_probe(fn), },
 
 
 #define IRQCHIP_PLATFORM_DRIVER_END(drv_name, ...)			\
-- 
2.49.1


