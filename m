Return-Path: <linux-kernel+bounces-845068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68A4BC36C2
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 08:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5685C1883C1B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 06:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7282EB878;
	Wed,  8 Oct 2025 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvshig18"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFC62EAD0A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 06:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759903224; cv=none; b=j69LeKNrR+WhWovuxuTnsczQe3s4gRjaE24af3FFAtsXFz5OvRQ7M1hXAeDCXoQw38jpk490jMMv84PI5AFMXYLScG+rS4Ww92/GIW6eXMSBqjocKWsTBcpC1iuO8Ra75rBnZPfY61CDC3QSjxCIrjCSf/8NkqVJN9iJBb3CfME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759903224; c=relaxed/simple;
	bh=1LsFgPYzpayfPJ/FsKvMjpCnXRfU9VdGJpb+XK443rc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JwlI0XK3gAkR+y6Cxzu7GrNtapW1rySuz9s2HFkgmMdDAOVENCOtPU0R/0p++/+xiwtge0vMO+JxNkvsl28wlw1f2ro0goL7zkUEwHvuMdkWpghiFg2stEuzycCBWMVP+lBLyX3lzGp52memF0FMQGviNZBTdT/+MfdGOtfba7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvshig18; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2681642efd9so70316995ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 23:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759903222; x=1760508022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka8Q7nlHWOoI2RkFnFPZVDeuOoF3NtDVxhEhxWMkISg=;
        b=cvshig18HdBGmWJTR1yO/hnq7ZW58Z7yFQ6V3mMVsm+O/p54f1e1oecuTCIt65RPjC
         nUV2xD/VA3CBpgZtayxGqQkwfWEHZR8Oz+0AVBhItuRePlQQbQgE0okBeHH1GMiLq9+K
         IpsV0YV1aTxTmlNLE4Sh5QrIdhYNv1W3ejVGOW/Yhub2bea17htr1TyCRpIPSX/QqrNw
         hg4SY11E9pEKYirzrY4gETXknesvGUQ7LNaK06CUQvddYIDAl2ssh7Nd+FdA1SV8Cbzx
         rj3FrdPNM23JNrTJy3cTdJLVCdn629dxK0WUB31tNBsW/xmZTOEC5OMthsJxX7XHVAu5
         lurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759903222; x=1760508022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka8Q7nlHWOoI2RkFnFPZVDeuOoF3NtDVxhEhxWMkISg=;
        b=Pz1qpzXoziw5xZt3msyKAg1EH+n+IB4eUdqnoQXIJJnlHvL7c8oSCciHz6L0kNoq6I
         xQfPQ5k+W6ds11coNkVNgRAtSAjNdhIVc4yWnciRPlJBjsCT5dSpzgzfJiVrKVlOQCjV
         EU8cI0RGPSgUlg/HtCj1MgIcRxhV0kr1FzHYCCNi/ltCF+pAY0PsPbtzNlyMmiSOEKFj
         ai6QX7qTkRztsKKG95dLzqpH9ux3YhNrIgaFKspvgw/rGfYuqVddf4P3bA5G5dPF35bQ
         lMnUPg3rQniLi+SjejhcaL3gv7uyoORobxsjCpZMBZ4TyeA0ys1d7eN+g+7YDvZD8eeq
         mmgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/yS8eMAae83mq7WHdn9fi6s0XE5eE7/iOvXdvKqmyXdBtBrjaVhbCGTEceoNR3nlccPzZNNYW53jhFgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQj30yoX0ajSgbt2c24q/ZlnJW4grlLy9xSgM8wpOLRSHy/Ht+
	DeX/QYUhy7Cnqzwp69EqmMi7wY2odBitL+HqYVN7Hh8Ru7jIoGCY0cFuI0zEtrdYWy4GGy1KWLV
	5or0LDA==
X-Google-Smtp-Source: AGHT+IHEgK0iSfGPTqrfxzDEFvxdlz9aMrrAMDN66bGMiYvI5hGjGDvEExy9qsuc4PeR2LLXj7IghdV+NhY=
X-Received: from plot12.prod.google.com ([2002:a17:902:8c8c:b0:27d:6f45:42ec])
 (user=royluo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a6b:b0:25c:abb3:9bae
 with SMTP id d9443c01a7336-29027385222mr27269835ad.48.1759903222057; Tue, 07
 Oct 2025 23:00:22 -0700 (PDT)
Date: Wed,  8 Oct 2025 06:00:00 +0000
In-Reply-To: <20251008060000.3136021-1-royluo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251008060000.3136021-1-royluo@google.com>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008060000.3136021-5-royluo@google.com>
Subject: [PATCH v2 4/4] phy: Add Google Tensor SoC USB PHY driver
From: Roy Luo <royluo@google.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	"=?UTF-8?q?Andr=C3=A9=20Draszik?=" <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Joy Chakraborty <joychakr@google.com>, Naveen Kumar <mnkumar@google.com>, Roy Luo <royluo@google.com>, 
	Badhri Jagan Sridharan <badhri@google.com>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Support the USB PHY found on Google Tensor G5. This particular USB PHY
supports both high-speed and super-speed operations, and is integrated
with the SNPS DWC3 controller that's also on the SoC.
This initial patch specifically adds functionality for high-speed.

Co-developed-by: Joy Chakraborty <joychakr@google.com>
Signed-off-by: Joy Chakraborty <joychakr@google.com>
Co-developed-by: Naveen Kumar <mnkumar@google.com>
Signed-off-by: Naveen Kumar <mnkumar@google.com>
Signed-off-by: Roy Luo <royluo@google.com>
---
 drivers/phy/Kconfig          |  14 ++
 drivers/phy/Makefile         |   1 +
 drivers/phy/phy-google-usb.c | 286 +++++++++++++++++++++++++++++++++++
 3 files changed, 301 insertions(+)
 create mode 100644 drivers/phy/phy-google-usb.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 58c911e1b2d2..0966ab0297df 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -101,6 +101,20 @@ config PHY_NXP_PTN3222
 	  schemes. It supports all three USB 2.0 data rates: Low Speed, Full
 	  Speed and High Speed.
 
+config PHY_GOOGLE_USB
+	tristate "Google Tensor SoC USB PHY driver"
+	depends on HAS_IOMEM
+	depends on OF
+	depends on TYPEC
+	depends on USB_DWC3_GOOGLE
+	select GENERIC_PHY
+	default USB_DWC3_GOOGLE
+	help
+	  Enable support for the USB PHY on Google Tensor SoCs, starting with
+	  the G5 generation. This driver provides the PHY interfaces to
+	  interact with the SNPS eUSB2 and USB 3.2/DisplayPort Combo PHY, both
+	  of which are integrated with the DWC3 USB controller.
+
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index c670a8dac468..1d7a1331bd19 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PHY_SNPS_EUSB2)		+= phy-snps-eusb2.o
 obj-$(CONFIG_USB_LGM_PHY)		+= phy-lgm-usb.o
 obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
 obj-$(CONFIG_PHY_NXP_PTN3222)		+= phy-nxp-ptn3222.o
+obj-$(CONFIG_PHY_GOOGLE_USB)		+= phy-google-usb.o
 obj-y					+= allwinner/	\
 					   amlogic/	\
 					   broadcom/	\
diff --git a/drivers/phy/phy-google-usb.c b/drivers/phy/phy-google-usb.c
new file mode 100644
index 000000000000..4027d38dc34b
--- /dev/null
+++ b/drivers/phy/phy-google-usb.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * phy-google-usb.c - Google USB PHY driver
+ *
+ * Copyright (C) 2025, Google LLC
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <linux/cleanup.h>
+#include <linux/usb/typec_mux.h>
+
+#define USBCS_USB2PHY_CFG19_OFFSET 0x0
+#define USBCS_USB2PHY_CFG19_PHY_CFG_PLL_FB_DIV GENMASK(19, 8)
+
+#define USBCS_USB2PHY_CFG21_OFFSET 0x8
+#define USBCS_USB2PHY_CFG21_PHY_ENABLE BIT(12)
+#define USBCS_USB2PHY_CFG21_REF_FREQ_SEL GENMASK(15, 13)
+#define USBCS_USB2PHY_CFG21_PHY_TX_DIG_BYPASS_SEL BIT(19)
+
+#define USBCS_PHY_CFG1_OFFSET 0x28
+#define USBCS_PHY_CFG1_SYS_VBUSVALID BIT(17)
+
+#define USBCS_TOP_CTRL_CFG1_OFFSET 0x0
+#define USBCS_TOP_CTRL_CFG1_USB2ONLY_MODE BIT(5)
+
+enum google_usb_phy_id {
+	GOOGLE_USB2_PHY,
+	GOOGLE_USB_PHY_NUM,
+};
+
+struct google_usb_phy_instance {
+	int index;
+	struct phy *phy;
+	struct clk *clk;
+	struct reset_control *rst;
+};
+
+struct google_usb_phy {
+	struct device *dev;
+	void __iomem *usb2_cfg_base;
+	void __iomem *dp_top_base;
+	void __iomem *usb_top_cfg_base;
+	struct google_usb_phy_instance insts[GOOGLE_USB_PHY_NUM];
+	/* serialize phy access */
+	struct mutex phy_mutex;
+	struct typec_switch_dev *sw;
+	enum typec_orientation orientation;
+};
+
+static inline struct google_usb_phy *to_google_usb_phy(struct google_usb_phy_instance *inst)
+{
+	return container_of(inst, struct google_usb_phy, insts[inst->index]);
+}
+
+static void set_vbus_valid(struct google_usb_phy *gphy)
+{
+	u32 reg;
+
+	if (gphy->orientation == TYPEC_ORIENTATION_NONE) {
+		reg = readl(gphy->dp_top_base + USBCS_PHY_CFG1_OFFSET);
+		reg &= ~USBCS_PHY_CFG1_SYS_VBUSVALID;
+		writel(reg, gphy->dp_top_base + USBCS_PHY_CFG1_OFFSET);
+	} else {
+		reg = readl(gphy->dp_top_base + USBCS_PHY_CFG1_OFFSET);
+		reg |= USBCS_PHY_CFG1_SYS_VBUSVALID;
+		writel(reg, gphy->dp_top_base + USBCS_PHY_CFG1_OFFSET);
+	}
+}
+
+static int google_usb_set_orientation(struct typec_switch_dev *sw,
+				      enum typec_orientation orientation)
+{
+	struct google_usb_phy *gphy = typec_switch_get_drvdata(sw);
+
+	dev_dbg(gphy->dev, "set orientation %d\n", orientation);
+
+	gphy->orientation = orientation;
+
+	if (pm_runtime_suspended(gphy->dev))
+		return 0;
+
+	guard(mutex)(&gphy->phy_mutex);
+
+	set_vbus_valid(gphy);
+
+	return 0;
+}
+
+static int google_usb2_phy_init(struct phy *_phy)
+{
+	struct google_usb_phy_instance *inst = phy_get_drvdata(_phy);
+	struct google_usb_phy *gphy = to_google_usb_phy(inst);
+	u32 reg;
+	int ret = 0;
+
+	dev_dbg(gphy->dev, "initializing usb2 phy\n");
+
+	guard(mutex)(&gphy->phy_mutex);
+
+	 /*
+	  * TODO: usb2only mode should be removed once usb3 is supported
+	  */
+	reg = readl(gphy->usb_top_cfg_base + USBCS_TOP_CTRL_CFG1_OFFSET);
+	reg |= USBCS_TOP_CTRL_CFG1_USB2ONLY_MODE;
+	writel(reg, gphy->usb_top_cfg_base + USBCS_TOP_CTRL_CFG1_OFFSET);
+
+	reg = readl(gphy->usb2_cfg_base + USBCS_USB2PHY_CFG21_OFFSET);
+	reg &= ~USBCS_USB2PHY_CFG21_PHY_TX_DIG_BYPASS_SEL;
+	reg &= ~USBCS_USB2PHY_CFG21_REF_FREQ_SEL;
+	reg |= FIELD_PREP(USBCS_USB2PHY_CFG21_REF_FREQ_SEL, 0);
+	writel(reg, gphy->usb2_cfg_base + USBCS_USB2PHY_CFG21_OFFSET);
+
+	reg = readl(gphy->usb2_cfg_base + USBCS_USB2PHY_CFG19_OFFSET);
+	reg &= ~USBCS_USB2PHY_CFG19_PHY_CFG_PLL_FB_DIV;
+	reg |= FIELD_PREP(USBCS_USB2PHY_CFG19_PHY_CFG_PLL_FB_DIV, 368);
+	writel(reg, gphy->usb2_cfg_base + USBCS_USB2PHY_CFG19_OFFSET);
+
+	set_vbus_valid(gphy);
+
+	ret = clk_prepare_enable(inst->clk);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(inst->rst);
+	if (ret) {
+		clk_disable_unprepare(inst->clk);
+		return ret;
+	}
+
+	reg = readl(gphy->usb2_cfg_base + USBCS_USB2PHY_CFG21_OFFSET);
+	reg |= USBCS_USB2PHY_CFG21_PHY_ENABLE;
+	writel(reg, gphy->usb2_cfg_base + USBCS_USB2PHY_CFG21_OFFSET);
+
+	return ret;
+}
+
+static int google_usb2_phy_exit(struct phy *_phy)
+{
+	struct google_usb_phy_instance *inst = phy_get_drvdata(_phy);
+	struct google_usb_phy *gphy = to_google_usb_phy(inst);
+	u32 reg;
+
+	dev_dbg(gphy->dev, "exiting usb2 phy\n");
+
+	guard(mutex)(&gphy->phy_mutex);
+
+	reg = readl(gphy->usb2_cfg_base + USBCS_USB2PHY_CFG21_OFFSET);
+	reg &= ~USBCS_USB2PHY_CFG21_PHY_ENABLE;
+	writel(reg, gphy->usb2_cfg_base + USBCS_USB2PHY_CFG21_OFFSET);
+
+	reset_control_assert(inst->rst);
+	clk_disable_unprepare(inst->clk);
+
+	return 0;
+}
+
+static const struct phy_ops google_usb2_phy_ops = {
+	.init		= google_usb2_phy_init,
+	.exit		= google_usb2_phy_exit,
+};
+
+static struct phy *google_usb_phy_xlate(struct device *dev,
+					const struct of_phandle_args *args)
+{
+	struct google_usb_phy *gphy = dev_get_drvdata(dev);
+
+	if (args->args[0] >= GOOGLE_USB_PHY_NUM) {
+		dev_err(dev, "invalid PHY index requested from DT\n");
+		return ERR_PTR(-ENODEV);
+	}
+	return gphy->insts[args->args[0]].phy;
+}
+
+static int google_usb_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct google_usb_phy *gphy;
+	struct phy *phy;
+	struct google_usb_phy_instance *inst;
+	struct phy_provider *phy_provider;
+	struct typec_switch_desc sw_desc = { };
+	int ret;
+
+	gphy = devm_kzalloc(dev, sizeof(*gphy), GFP_KERNEL);
+	if (!gphy)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, gphy);
+	gphy->dev = dev;
+
+	ret = devm_mutex_init(dev, &gphy->phy_mutex);
+	if (ret)
+		return ret;
+
+	gphy->usb2_cfg_base = devm_platform_ioremap_resource_byname(pdev,
+								    "usb2_cfg_csr");
+	if (IS_ERR(gphy->usb2_cfg_base))
+		return dev_err_probe(dev, PTR_ERR(gphy->usb2_cfg_base),
+				    "invalid usb2 cfg csr\n");
+
+	gphy->dp_top_base = devm_platform_ioremap_resource_byname(pdev,
+								  "dp_top_csr");
+	if (IS_ERR(gphy->dp_top_base))
+		return dev_err_probe(dev, PTR_ERR(gphy->dp_top_base),
+				    "invalid dp top csr\n");
+
+	gphy->usb_top_cfg_base = devm_platform_ioremap_resource_byname(pdev,
+								       "usb_top_cfg_csr");
+	if (IS_ERR(gphy->usb_top_cfg_base))
+		return dev_err_probe(dev, PTR_ERR(gphy->usb_top_cfg_base),
+				    "invalid usb top cfg csr\n");
+
+	inst = &gphy->insts[GOOGLE_USB2_PHY];
+	inst->index = GOOGLE_USB2_PHY;
+	phy = devm_phy_create(dev, NULL, &google_usb2_phy_ops);
+	if (IS_ERR(phy))
+		return dev_err_probe(dev, PTR_ERR(phy),
+				     "failed to create usb2 phy instance\n");
+	inst->phy = phy;
+	phy_set_drvdata(phy, inst);
+	inst->clk = devm_clk_get(dev, "usb2_phy_clk");
+	if (IS_ERR(inst->clk))
+		return dev_err_probe(dev, PTR_ERR(inst->clk),
+				     "failed to get usb2 phy clk\n");
+	inst->rst = devm_reset_control_get_exclusive(dev, "usb2_phy_reset");
+	if (IS_ERR(inst->rst))
+		return dev_err_probe(dev, PTR_ERR(inst->rst),
+				     "failed to get usb2 phy reset\n");
+
+	phy_provider = devm_of_phy_provider_register(dev, google_usb_phy_xlate);
+	if (IS_ERR(phy_provider))
+		return dev_err_probe(dev, PTR_ERR(phy_provider),
+				     "failed to register phy provider\n");
+
+	pm_runtime_enable(dev);
+
+	sw_desc.fwnode = dev_fwnode(dev);
+	sw_desc.drvdata = gphy;
+	sw_desc.name = fwnode_get_name(dev_fwnode(dev));
+	sw_desc.set = google_usb_set_orientation;
+
+	gphy->sw = typec_switch_register(dev, &sw_desc);
+	if (IS_ERR(gphy->sw))
+		return dev_err_probe(dev, PTR_ERR(gphy->sw),
+				     "failed to register typec switch\n");
+
+	return 0;
+}
+
+static void google_usb_phy_remove(struct platform_device *pdev)
+{
+	struct google_usb_phy *gphy = dev_get_drvdata(&pdev->dev);
+
+	typec_switch_unregister(gphy->sw);
+	pm_runtime_disable(&pdev->dev);
+}
+
+static const struct of_device_id google_usb_phy_of_match[] = {
+	{
+		.compatible = "google,gs5-usb-phy",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, google_usb_phy_of_match);
+
+static struct platform_driver google_usb_phy = {
+	.probe	= google_usb_phy_probe,
+	.remove = google_usb_phy_remove,
+	.driver = {
+		.name		= "google-usb-phy",
+		.of_match_table	= google_usb_phy_of_match,
+	}
+};
+
+module_platform_driver(google_usb_phy);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Google USB phy driver");
-- 
2.51.0.710.ga91ca5db03-goog


