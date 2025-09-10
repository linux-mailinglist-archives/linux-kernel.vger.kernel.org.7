Return-Path: <linux-kernel+bounces-810326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FE9B518C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 576327AFB79
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3844A3277B4;
	Wed, 10 Sep 2025 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="i5HM2qCN"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D3322DD2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513013; cv=none; b=PbqTx20XDq2AnJ1+/qjiE0DRNi0C3K0/xxgBGCtPiUzF9jJ5Hqiz2xlLmCmRvUam7ILTWY2sQ0esZv9pfMbfNb122YN7qsGSnjFv4/acu6cm/FispClpAnUq0D0Oj3dpozVbOYHt/jUeKaKzQyoHjuOBpWadNg6+fL3VNbBUBhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513013; c=relaxed/simple;
	bh=8c/w6U15zCvX/wrzXc/QykctPWD6qOZa3pqSO0c1jqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkKUoq5fXc7Igx7aMKZeGHMD94kuNwNWVKBRKjd12z+lHfcPkYxiUZeOOx8hn2LHGb+bK9vSG2oUBqJPYxk+gkACQZe+cIEnQxrfS5zobJa+WrOQL1mV6vStX5n9JBpoJunMUmHFiTwb2QrWVDNPD8lbFc1WgboPgj9jd+lDlgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=i5HM2qCN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so5144795e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757513009; x=1758117809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFS5WGwWPXNbCDtOnCJOrPVvak3s//W4F+FQv/tO0/g=;
        b=i5HM2qCNLX4ba9NDgYaPIFwROQ9hsL5wfUI7Xrnut7K7m621B6hbHSMTac2x11j+tX
         0Z0fn6EOcofUeQBHJ2Pli1gdMgr6+f0yF0e8FMo8simKo1SmzKL6TsSXP16QHdNkrwVz
         +71tTfvEb/70ZxnXgTMkG2a6NUpqtsxHHk+VGPQKuC/F1QdLSU9sg41aUSLHnX7JIWGk
         vrUF+zO7sd0Hg4olmLPwrwdeZrPP491fUZJGsyxmbNH6T2MdwwkQxIt5eK3kQpzal96O
         oTdP2N9r1ZDRLtt84WSJbwhNPOzZV82AQOX1yOQYeqWjOKueI/zLZAMQd/mcfNivinOp
         HBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513009; x=1758117809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFS5WGwWPXNbCDtOnCJOrPVvak3s//W4F+FQv/tO0/g=;
        b=Fdk2k66dbdue8y3n2tOIBEYAbNCUO5JQrgSKSResj1XcSzt7j3Uf8erQHpoStlzcmT
         hDXAhgm+wbcq5ewhts4jJN8Qb2bdyS3PvouMP+Yj2Ee0O30+b/KyH8GdwFRrLNPI4OkH
         cuDCPJpblQWZn883BZUds20JL/0weFHYqm7bLEU1fb6YoZVIpI12z8MwLYR2TMFL9x9u
         +XbhTvSpg3Chclmtd24o6kIoOd4Xeb1SAqFk7+7x6bPfRy5uT2kt3iI+2SMMmMZsAOX2
         sKou9EAsnVlLN9e3jY/74nYzof5bCJEQ/zhuLkxWnPmFf6tWZipo9GJhyPMlvl3a0vcD
         gw/w==
X-Forwarded-Encrypted: i=1; AJvYcCXSlH3ZrYyRFfCLNpPd10xuOBuUgRttVunFBSLiWGfQRn+djsou80sEpO6E7roJyi47Xk1kWaHD5MyftQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFBXxjTeSMdYyCZpRJwm7qU4L0xUm8L6G04E1qjz5I333RFLYV
	6wqpR7UJGSkPp6P1er2SO5cPW/Ftpf0952aUICrP5CwQNrd1XWRQctvWPFkUz7G2FiA=
X-Gm-Gg: ASbGncsYaG/F7MXCh0iVBBtDLZ++iv1pUE5//B1edTPQYAbGYXg+24DIRvTXosI9htA
	NVNvMArRoc+E/SCzM6+2st71PfO+9DuixdBuIaJzZxp3le8R7/pLiR+9+Rsi4OaP8RJ6JAWAMoS
	HQCEfbLLbEmXz83D27ay5rsl2CqWXDmbirC+QILRUHlSaOi49UrnSMPRVAROIDk0CnAJ6BJtrXb
	Jt9H6MFmI5E4F+L19TLL6RLDGWXJazdl6gBWem1i4EusRV5ZuuCIQ4QAFtxh5wWiVLDieCxu6yL
	Em7dUHW0lSXiFxDistnmMz763LGXsqTZ/fyVTK5EkLy0mHUOnOd9XJyYUkukWoF4wL5WiARa0XF
	4q+JzLOPTczly4lAFBzpZ8TY9k4Xj/3RiYP7C2vb0LJ1mldP8Zq7z
X-Google-Smtp-Source: AGHT+IE5s2eqxL5ESY4m6HYY5SZYPbPnzuqSSy5OTggf0gfyDfz/El0P6CZkq4NVLmBBSQnvtzsrrg==
X-Received: by 2002:a05:600c:1389:b0:45c:b580:f795 with SMTP id 5b1f17b1804b1-45dddedf80fmr129952235e9.34.1757513009050;
        Wed, 10 Sep 2025 07:03:29 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df804bce3sm29523875e9.0.2025.09.10.07.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:03:28 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v6 4/7] reset: rzg2l-usbphy-ctrl: Add support for USB PWRRDY
Date: Wed, 10 Sep 2025 17:03:02 +0300
Message-ID: <20250910140305.541961-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910140305.541961-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250910140305.541961-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On the Renesas RZ/G3S SoC, the USB PHY block has an input signal called
PWRRDY. This signal is managed by the system controller and must be
de-asserted after powering on the area where USB PHY resides and asserted
before powering it off.

On power-on the USB PWRRDY signal need to be de-asserted before enabling
clock and switching the module to normal state (through MSTOP support). The
power-on configuration sequence must be:

1/ PWRRDY=0
2/ CLK_ON=1
3/ MSTOP=0

On power-off the configuration sequence should be:

1/ MSTOP=1
2/ CLK_ON=0
3/ PWRRDY=1

The CLK_ON and MSTOP functionalities are controlled by clock drivers.

After long discussions with the internal HW team, it has been confirmed
that the HW connection b/w USB PHY block, the USB channels, the system
controller, clock, MSTOP, PWRRDY signal is as follows:

                               ┌──────────────────────────────┐
                               │                              │◄── CPG_CLKON_USB.CLK0_ON
                               │     USB CH0                  │
┌──────────────────────────┐   │┌───────────────────────────┐ │◄── CPG_CLKON_USB.CLK2_ON
│                 ┌────────┐   ││host controller registers  │ │
│                 │        │   ││function controller registers│
│                 │ PHY0   │◄──┤└───────────────────────────┘ │
│     USB PHY     │        │   └────────────▲─────────────────┘
│                 └────────┘                │
│                          │    CPG_BUS_PERI_COM_MSTOP.MSTOP{6, 5}_ON
│┌──────────────┐ ┌────────┐
││USHPHY control│ │        │
││  registers   │ │ PHY1   │   ┌──────────────────────────────┐
│└──────────────┘ │        │◄──┤     USB CH1                  │
│                 └────────┘   │┌───────────────────────────┐ │◄── CPG_CLKON_USB.CLK1_ON
└─▲───────▲─────────▲──────┘   ││ host controller registers │ │
  │       │         │          │└───────────────────────────┘ │
  │       │         │          └────────────▲─────────────────┘
  │       │         │                       │
  │       │         │           CPG_BUS_PERI_COM_MSTOP.MSTOP7_ON
  │PWRRDY │         │
  │       │   CPG_CLK_ON_USB.CLK3_ON
  │       │
  │  CPG_BUS_PERI_COM_MSTOP.MSTOP4_ON
  │
┌────┐
│SYSC│
└────┘

where:
- CPG_CLKON_USB.CLK.CLKX_ON is the register bit controlling the clock X
  of different USB blocks, X in {0, 1, 2, 3}
- CPG_BUS_PERI_COM_MSTOP.MSTOPX_ON is the register bit controlling the
  MSTOP of different USB blocks, X in {4, 5, 6, 7}
- USB PHY is the USB PHY block exposing 2 ports, port0 and port1, used
  by the USB CH0, USB CH1
- SYSC is the system controller block controlling the PWRRDY signal
- USB CHx are individual USB block with host and function capabilities
  (USB CH0 have both host and function capabilities, USB CH1 has only
  host capabilities)

The USBPHY control registers are controlled though the
reset-rzg2l-usbphy-ctrl driver. The USB PHY ports are controlled by
phy_rcar_gen3_usb2 (drivers/phy/renesas/phy-rcar-gen3-usb2.c file). The
USB PHY ports request resets from the reset-rzg2l-usbphy-ctrl driver.

The connection b/w the system controller and the USB PHY CTRL driver is
implemented through the renesas,sysc-pwrrdy device tree property
proposed in this patch. This property specifies the register offset and the
bitmask required to control the PWRRDY signal.

Since the USB PHY CTRL driver needs to be probed before any other
USB-specific driver on RZ/G3S, control of PWRRDY is passed exclusively
to it. This guarantees the correct configuration sequence between clocks,
MSTOP bits, and the PWRRDY bit. At the same time, changes are kept minimal
by avoiding modifications to the USB PHY driver to also handle the PWRRDY
itself.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- used syscon_regmap_lookup_by_phandle_args() to simplify the code
- collected tags

Changes in v5:
- none

Changes in v4:
- updated patch description
- updated rzg2l_usbphy_ctrl_pwrrdy_init() to map directly the
  "renesas,sysc-pwrrdy" as the SYSC signal abstraction was dropped
  in this version, along with rz_sysc_get_signal_map()
- dropped priv member of rzg2l_usbphy_ctrl_pwrrdy_init() as it is
  not needed in this version
- shift left !power_on with pwrrdy->mask as this is how the
  regmap_update_bits() needs the last member to be
- selected MFD_SYSCON

Changes in v3:
- none; this patch is new

 drivers/reset/Kconfig                   |  1 +
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 61 +++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 78b7078478d4..329730cbcfb9 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -237,6 +237,7 @@ config RESET_RASPBERRYPI
 config RESET_RZG2L_USBPHY_CTRL
 	tristate "Renesas RZ/G2L USBPHY control driver"
 	depends on ARCH_RZG2L || COMPILE_TEST
+	select MFD_SYSCON
 	help
 	  Support for USBPHY Control found on RZ/G2L family. It mainly
 	  controls reset and power down of the USB/PHY.
diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index 8a7f167e405e..c58bf19993c1 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -13,6 +13,7 @@
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>
+#include <linux/mfd/syscon.h>
 
 #define RESET			0x000
 #define VBENCTL			0x03c
@@ -41,6 +42,18 @@ struct rzg2l_usbphy_ctrl_priv {
 
 #define rcdev_to_priv(x)	container_of(x, struct rzg2l_usbphy_ctrl_priv, rcdev)
 
+/**
+ * struct rzg2l_usbphy_ctrl_pwrrdy - SYSC PWRRDY signal descriptor
+ * @regmap: SYSC regmap
+ * @offset: offset into the SYSC address space for accessing PWRRDY
+ * @mask: mask into the register at offset for accessing PWRRDY
+ */
+struct rzg2l_usbphy_ctrl_pwrrdy {
+	struct regmap *regmap;
+	u32 offset;
+	u32 mask;
+};
+
 static int rzg2l_usbphy_ctrl_assert(struct reset_controller_dev *rcdev,
 				    unsigned long id)
 {
@@ -91,6 +104,8 @@ static int rzg2l_usbphy_ctrl_status(struct reset_controller_dev *rcdev,
 	return !!(readl(priv->base + RESET) & port_mask);
 }
 
+#define RZG2L_USBPHY_CTRL_PWRRDY	1
+
 static const struct of_device_id rzg2l_usbphy_ctrl_match_table[] = {
 	{ .compatible = "renesas,rzg2l-usbphy-ctrl" },
 	{ /* Sentinel */ }
@@ -110,6 +125,48 @@ static const struct regmap_config rzg2l_usb_regconf = {
 	.max_register = 1,
 };
 
+static void rzg2l_usbphy_ctrl_set_pwrrdy(struct rzg2l_usbphy_ctrl_pwrrdy *pwrrdy,
+					 bool power_on)
+{
+	regmap_update_bits(pwrrdy->regmap, pwrrdy->offset, pwrrdy->mask,
+			   !power_on << pwrrdy->mask);
+}
+
+static void rzg2l_usbphy_ctrl_pwrrdy_off(void *data)
+{
+	rzg2l_usbphy_ctrl_set_pwrrdy(data, false);
+}
+
+static int rzg2l_usbphy_ctrl_pwrrdy_init(struct device *dev)
+{
+	struct rzg2l_usbphy_ctrl_pwrrdy *pwrrdy;
+	struct regmap *regmap;
+	const int *data;
+	u32 args[2];
+
+	data = device_get_match_data(dev);
+	if (data != (int *)RZG2L_USBPHY_CTRL_PWRRDY)
+		return 0;
+
+	regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+						      "renesas,sysc-pwrrdy",
+						      ARRAY_SIZE(args), args);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	pwrrdy = devm_kzalloc(dev, sizeof(*pwrrdy), GFP_KERNEL);
+	if (!pwrrdy)
+		return -ENOMEM;
+
+	pwrrdy->regmap = regmap;
+	pwrrdy->offset = args[0];
+	pwrrdy->mask = args[1];
+
+	rzg2l_usbphy_ctrl_set_pwrrdy(pwrrdy, true);
+
+	return devm_add_action_or_reset(dev, rzg2l_usbphy_ctrl_pwrrdy_off, pwrrdy);
+}
+
 static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -132,6 +189,10 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	error = rzg2l_usbphy_ctrl_pwrrdy_init(dev);
+	if (error)
+		return error;
+
 	priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(priv->rstc))
 		return dev_err_probe(dev, PTR_ERR(priv->rstc),
-- 
2.43.0


