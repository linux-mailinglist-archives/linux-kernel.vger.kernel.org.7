Return-Path: <linux-kernel+bounces-876835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1908EC1C83B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 275D84E28F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E139B350A2A;
	Wed, 29 Oct 2025 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpxwOiRQ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525223546EC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759453; cv=none; b=uxm36GgTBSacIBy3di9yHXZD6px2Zd2WAkYfkNObtuaqcC8tF7zVGZmDZppZO6a8rv0RqU+lx0ix1i5BnpTyMxaJ4RHiABrY/cDg/RnGlxNXu5pDbzA3fJt4x3aTQPKANgaJGmaBU1N+0xFPwEYo3ib7kIqFMD4FffEJ6U3cHSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759453; c=relaxed/simple;
	bh=Tb7byiQXXQF/j2nNskYh7eZZLfbEZwig7/jY1Ktr5oY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4t3Qt5ihx+6+brsrXqRwHMHf0XKI+iFaRtdRKuRFIglTo6QA+2Es/KR2jWbu+dN/1qD7t5JYQeOqihQM5DGxqLA4BGga6TC+DIPIS6Fbk35hx2kp+Uevfp2Oy7SS8r2ztc02JxCQoqUf8RmEhqbBXWs3s5cJUNtsAN2SgfgEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpxwOiRQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-474975af41dso699715e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761759449; x=1762364249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBOV5y14zLJY461SlCRrfLskZTeD8oaRyeqNtZ5L1HE=;
        b=JpxwOiRQsdSM3W6Hm8XbIOHLT1hFxz0psE2i8+Wbq6E+3OWavCWqE67mSe6PhLjgNx
         SKYs7N2IfOk22Jy5MV/9OlYoIEdeCDN1mk+lZSkw2c5Op75y2lnuYdswksKEc80c1T00
         ru1fLfH8ztLwGDYLmXfaThYErUY2446sc3pHdWZYTVSCjDNRSqtoEFQJl45UDYXImECR
         hJhQ8EQ6z9he3UFdD2U5kDfc0rwk+AP+VwVMrgn4294Vc4dOoKlntPk7BEWGw4sVMXpR
         B1tdswYh+puJJQkmm7RYmWtqtJ4WKeozOldDI+PyTOgrZ7S88yem3vZRD9r/aWgGFqcE
         HO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759449; x=1762364249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBOV5y14zLJY461SlCRrfLskZTeD8oaRyeqNtZ5L1HE=;
        b=mN/z29BsTg1Tb4CMf3+XJBqjLSWhbxJtABsnL+QLDQzYljNC5PSwsHS74BNQyfbKR/
         zj7jzl13Gvznz5iSNiKwBI0tm/ZLMnkyIwIkHsjAJd7d2VWgRf/gMqwHkf52wFy1FHOa
         mOR+GHCoFH527whAvN/KZTyTtekiy5/908MUVOw1FCF6Mcgrtx4+eP6jCjZxVRyDfHB+
         Qe6mY7HAQlPOJQXIYYYzaCWNIWtxlqZcWjhsIoQwV89Q4ECq/1t0JhltyoxSaFTQJcWT
         Z+LE2oY+9bU4aNxBxmSPMzfurnlx8mTkIfb9mlj2ndOtQaWY+77VE+sDdGbEYxTGM6e9
         93ow==
X-Forwarded-Encrypted: i=1; AJvYcCV9CJYEOnua0SblKbWEgWosqeEDU+rtUKxCxT8CcTAjm+YCbNZKwlFCp5O+3RLJG+y4kudGAEfZXtwSo0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwAKLkWMl5Nb9UQxwhqb1brOgjSYL+zVVpJL6jwoIk/SbuaFoO
	8JbKOTxlJXvMKHQzemaT2pUe5490IjyHrbqqqv3qzNT3wE8v+fRU1q0W
X-Gm-Gg: ASbGncuQOq1Mp2FZiRQW3aykEGDNTXVR5NkYZ8y+LGRWPVEqsphdNURk0MmP43f1CfO
	sJuf2m29AXrVAUEk6nmGbwo0NA5e8J4I0coK1ZCQxe0fTAQfyAlfvjgY5b9Uo35Ybv8orsbl+TA
	+3bLZQihDAuvYLo1hiEreLRPneRl86QovjfO18KFednGdRjRL1kJO+T+IvekkOdWKmTQyu5GkLb
	OnKK2oG9ZyAbxuUK+9DmhUgOf5EgFBpuLgZP8ii44Cs+W8qtYlBZbcitdUadvt7IuSE+6RfQrBg
	iqMIGiYlTFSqT1ZMFzD7v0i+FiHkfUW3PKyQum0d9R5NJ6OmUdvGv56ZpJy30XWWuVks762UuVr
	hs2ubKu9DtYuknv90aIEgR2QzbmilM7vPUAyxhOsGsBCTxV5AYJP8fNFLWsux1Eexcp/R61iW4l
	DVQXJN/9eVoNqO9FQkDOTI979c9ePBzQ==
X-Google-Smtp-Source: AGHT+IHIdt+Y6vepqTCorK7FZTNvF1I3+IkB9WCPc3/F3TOwHBHlx42aT3+kkqaVB8QlNGJipSyajA==
X-Received: by 2002:a05:600c:608e:b0:46e:432f:32ab with SMTP id 5b1f17b1804b1-4772684ed85mr1577445e9.33.1761759448397;
        Wed, 29 Oct 2025 10:37:28 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm27493844f8f.28.2025.10.29.10.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:37:27 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] phy: airoha: Add support for Airoha AN7581 USB PHY
Date: Wed, 29 Oct 2025 18:37:12 +0100
Message-ID: <20251029173713.7670-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029173713.7670-1-ansuelsmth@gmail.com>
References: <20251029173713.7670-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha AN7581 USB PHY driver. AN7581 supports up to 2
USB port with USB 2.0 mode always supported and USB 3.0 mode available
only if the Serdes port is correctly configured for USB 3.0.

The first USB port on the SoC can be both  used for USB 3.0 operation or
Ethernet.
The second USB port on the SoC can be both used for USB 3.0 operation or
PCIe.
Both port operation toggled by the SCU SSR register and configured by
the USB PHY driver.

If the USB 3.0 mode is not configured, the modes needs to be also
disabled in the xHCI node or the driver will report unsable clock and
fail probe.

For USB 2.0 Slew Rate calibration, airoha,usb2-monitor-clk-sel is
mandatory and is used to select the monitor clock for calibration.

Normally it's 1 for USB port 1 and 2 for USB port 2.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS                         |   1 +
 drivers/phy/airoha/Kconfig          |  10 +
 drivers/phy/airoha/Makefile         |   1 +
 drivers/phy/airoha/phy-airoha-usb.c | 615 ++++++++++++++++++++++++++++
 scripts/tracepoint-update           | Bin 0 -> 22952 bytes
 5 files changed, 627 insertions(+)
 create mode 100644 drivers/phy/airoha/phy-airoha-usb.c
 create mode 100755 scripts/tracepoint-update

diff --git a/MAINTAINERS b/MAINTAINERS
index 0857baa8d5bb..cbfc9b1f7dd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -768,6 +768,7 @@ M:	Christian Marangi <ansuelsmth@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
+F:	drivers/phy/airoha/phy-airoha-usb.c
 F:	include/dt-bindings/phy/airoha,an7581-usb-phy.h
 
 AIRSPY MEDIA DRIVER
diff --git a/drivers/phy/airoha/Kconfig b/drivers/phy/airoha/Kconfig
index 70b7eac4a2bf..0675d8f2f9d1 100644
--- a/drivers/phy/airoha/Kconfig
+++ b/drivers/phy/airoha/Kconfig
@@ -11,3 +11,13 @@ config PHY_AIROHA_PCIE
 	  Say Y here to add support for Airoha PCIe PHY driver.
 	  This driver create the basic PHY instance and provides initialize
 	  callback for PCIe GEN3 port.
+
+config PHY_AIROHA_USB
+	tristate "Airoha USB PHY Driver"
+	depends on ARCH_AIROHA || COMPILE_TEST
+	depends on OF
+	select GENERIC_PHY
+	help
+	  Say 'Y' here to add support for Airoha USB PHY driver.
+	  This driver create the basic PHY instance and provides initialize
+	  callback for USB port.
diff --git a/drivers/phy/airoha/Makefile b/drivers/phy/airoha/Makefile
index 3222f749546b..fd188d08c412 100644
--- a/drivers/phy/airoha/Makefile
+++ b/drivers/phy/airoha/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
+obj-$(CONFIG_PHY_AIROHA_USB)		+= phy-airoha-usb.o
diff --git a/drivers/phy/airoha/phy-airoha-usb.c b/drivers/phy/airoha/phy-airoha-usb.c
new file mode 100644
index 000000000000..50950e6de771
--- /dev/null
+++ b/drivers/phy/airoha/phy-airoha-usb.c
@@ -0,0 +1,615 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/soc/airoha,scu-ssr.h>
+#include <linux/bitfield.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/* SCU */
+#define AIROHA_SCU_SSR3				0x94
+#define   AIROHA_SCU_SSR3_SSUSB_HSGMII_SEL	BIT(29)
+#define   AIROHA_SCU_SSR3_SSUSB_HSGMII_SEL_HSGMII FIELD_PREP_CONST(AIROHA_SCU_SSR3_SSUSB_HSGMII_SEL, 0x1)
+#define   AIROHA_SCU_SSR3_SSUSB_HSGMII_SEL_USB	FIELD_PREP_CONST(AIROHA_SCU_SSR3_SSUSB_HSGMII_SEL, 0x1)
+#define AIROHA_SCU_SSTR				0x9c
+#define   AIROHA_SCU_SSTR_USB_PCIE_SEL		BIT(3)
+#define   AIROHA_SCU_SSTR_USB_PCIE_SEL_PCIE	FIELD_PREP_CONST(AIROHA_SCU_SSTR_USB_PCIE_SEL, 0x0)
+#define   AIROHA_SCU_SSTR_USB_PCIE_SEL_USB	FIELD_PREP_CONST(AIROHA_SCU_SSTR_USB_PCIE_SEL, 0x1)
+
+/* U2PHY */
+#define AIROHA_USB_PHY_FMCR0			0x100
+#define   AIROHA_USB_PHY_MONCLK_SEL		GENMASK(27, 26)
+#define   AIROHA_USB_PHY_MONCLK_SEL0		FIELD_PREP_CONST(AIROHA_USB_PHY_MONCLK_SEL, 0x0)
+#define   AIROHA_USB_PHY_MONCLK_SEL1		FIELD_PREP_CONST(AIROHA_USB_PHY_MONCLK_SEL, 0x1)
+#define   AIROHA_USB_PHY_MONCLK_SEL2		FIELD_PREP_CONST(AIROHA_USB_PHY_MONCLK_SEL, 0x2)
+#define   AIROHA_USB_PHY_MONCLK_SEL3		FIELD_PREP_CONST(AIROHA_USB_PHY_MONCLK_SEL, 0x3)
+#define   AIROHA_USB_PHY_FREQDET_EN		BIT(24)
+#define   AIROHA_USB_PHY_CYCLECNT		GENMASK(23, 0)
+#define AIROHA_USB_PHY_FMMONR0			0x10c
+#define   AIROHA_USB_PHY_USB_FM_OUT		GENMASK(31, 0)
+#define AIROHA_USB_PHY_FMMONR1			0x110
+#define   AIROHA_USB_PHY_FRCK_EN		BIT(8)
+
+#define AIROHA_USB_PHY_USBPHYACR4		0x310
+#define   AIROHA_USB_PHY_USB20_FS_CR		GENMASK(10, 8)
+#define   AIROHA_USB_PHY_USB20_FS_CR_MAX	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_FS_CR, 0x0)
+#define   AIROHA_USB_PHY_USB20_FS_CR_NORMAL	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_FS_CR, 0x2)
+#define   AIROHA_USB_PHY_USB20_FS_CR_SMALLER	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_FS_CR, 0x4)
+#define   AIROHA_USB_PHY_USB20_FS_CR_MIN	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_FS_CR, 0x6)
+#define   AIROHA_USB_PHY_USB20_FS_SR		GENMASK(2, 0)
+#define   AIROHA_USB_PHY_USB20_FS_SR_MAX	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_FS_SR, 0x0)
+#define   AIROHA_USB_PHY_USB20_FS_SR_NORMAL	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_FS_SR, 0x2)
+#define   AIROHA_USB_PHY_USB20_FS_SR_SMALLER	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_FS_SR, 0x4)
+#define   AIROHA_USB_PHY_USB20_FS_SR_MIN	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_FS_SR, 0x6)
+#define AIROHA_USB_PHY_USBPHYACR5		0x314
+#define   AIROHA_USB_PHY_USB20_HSTX_SRCAL_EN	BIT(15)
+#define   AIROHA_USB_PHY_USB20_HSTX_SRCTRL	GENMASK(14, 12)
+#define AIROHA_USB_PHY_USBPHYACR6		0x318
+#define   AIROHA_USB_PHY_USB20_BC11_SW_EN	BIT(23)
+#define   AIROHA_USB_PHY_USB20_DISCTH		GENMASK(7, 4)
+#define   AIROHA_USB_PHY_USB20_DISCTH_400	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0x0)
+#define   AIROHA_USB_PHY_USB20_DISCTH_420	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0x1)
+#define   AIROHA_USB_PHY_USB20_DISCTH_440	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0x2)
+#define   AIROHA_USB_PHY_USB20_DISCTH_460	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0x3)
+#define   AIROHA_USB_PHY_USB20_DISCTH_480	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0x4)
+#define   AIROHA_USB_PHY_USB20_DISCTH_500	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0x5)
+#define   AIROHA_USB_PHY_USB20_DISCTH_520	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0x6)
+#define   AIROHA_USB_PHY_USB20_DISCTH_540	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0x7)
+#define   AIROHA_USB_PHY_USB20_DISCTH_560	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0x8)
+#define   AIROHA_USB_PHY_USB20_DISCTH_580	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0x9)
+#define   AIROHA_USB_PHY_USB20_DISCTH_600	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0xa)
+#define   AIROHA_USB_PHY_USB20_DISCTH_620	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0xb)
+#define   AIROHA_USB_PHY_USB20_DISCTH_640	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0xc)
+#define   AIROHA_USB_PHY_USB20_DISCTH_660	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0xd)
+#define   AIROHA_USB_PHY_USB20_DISCTH_680	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0xe)
+#define   AIROHA_USB_PHY_USB20_DISCTH_700	FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_DISCTH, 0xf)
+#define   AIROHA_USB_PHY_USB20_SQTH		GENMASK(3, 0)
+#define   AIROHA_USB_PHY_USB20_SQTH_85		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0x0)
+#define   AIROHA_USB_PHY_USB20_SQTH_90		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0x1)
+#define   AIROHA_USB_PHY_USB20_SQTH_95		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0x2)
+#define   AIROHA_USB_PHY_USB20_SQTH_100		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0x3)
+#define   AIROHA_USB_PHY_USB20_SQTH_105		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0x4)
+#define   AIROHA_USB_PHY_USB20_SQTH_110		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0x5)
+#define   AIROHA_USB_PHY_USB20_SQTH_115		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0x6)
+#define   AIROHA_USB_PHY_USB20_SQTH_120		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0x7)
+#define   AIROHA_USB_PHY_USB20_SQTH_125		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0x8)
+#define   AIROHA_USB_PHY_USB20_SQTH_130		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0x9)
+#define   AIROHA_USB_PHY_USB20_SQTH_135		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0xa)
+#define   AIROHA_USB_PHY_USB20_SQTH_140		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0xb)
+#define   AIROHA_USB_PHY_USB20_SQTH_145		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0xc)
+#define   AIROHA_USB_PHY_USB20_SQTH_150		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0xd)
+#define   AIROHA_USB_PHY_USB20_SQTH_155		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0xe)
+#define   AIROHA_USB_PHY_USB20_SQTH_160		FIELD_PREP_CONST(AIROHA_USB_PHY_USB20_SQTH, 0xf)
+
+#define AIROHA_USB_PHY_U2PHYDTM1		0x36c
+#define   AIROHA_USB_PHY_FORCE_IDDIG		BIT(9)
+#define   AIROHA_USB_PHY_IDDIG			BIT(1)
+
+#define AIROHA_USB_PHY_GPIO_CTLD		0x80c
+#define   AIROHA_USB_PHY_C60802_GPIO_CTLD	GENMASK(31, 0)
+#define     AIROHA_USB_PHY_SSUSB_IP_SW_RST	BIT(31)
+#define     AIROHA_USB_PHY_MCU_BUS_CK_GATE_EN	BIT(30)
+#define     AIROHA_USB_PHY_FORCE_SSUSB_IP_SW_RST BIT(29)
+#define     AIROHA_USB_PHY_SSUSB_SW_RST		BIT(28)
+
+#define AIROHA_USB_PHY_U3_PHYA_REG0		0xb00
+#define   AIROHA_USB_PHY_SSUSB_BG_DIV		GENMASK(29, 28)
+#define   AIROHA_USB_PHY_SSUSB_BG_DIV_2		FIELD_PREP_CONST(AIROHA_USB_PHY_SSUSB_BG_DIV, 0x0)
+#define   AIROHA_USB_PHY_SSUSB_BG_DIV_4		FIELD_PREP_CONST(AIROHA_USB_PHY_SSUSB_BG_DIV, 0x1)
+#define   AIROHA_USB_PHY_SSUSB_BG_DIV_8		FIELD_PREP_CONST(AIROHA_USB_PHY_SSUSB_BG_DIV, 0x2)
+#define   AIROHA_USB_PHY_SSUSB_BG_DIV_16	FIELD_PREP_CONST(AIROHA_USB_PHY_SSUSB_BG_DIV, 0x3)
+#define AIROHA_USB_PHY_U3_PHYA_REG1		0xb04
+#define   AIROHA_USB_PHY_SSUSB_XTAL_TOP_RESERVE	GENMASK(25, 10)
+#define AIROHA_USB_PHY_U3_PHYA_REG6		0xb18
+#define   AIROHA_USB_PHY_SSUSB_CDR_RESERVE	GENMASK(31, 24)
+#define AIROHA_USB_PHY_U3_PHYA_REG8		0xb20
+#define   AIROHA_USB_PHY_SSUSB_CDR_RST_DLY	GENMASK(7, 6)
+#define   AIROHA_USB_PHY_SSUSB_CDR_RST_DLY_32	FIELD_PREP_CONST(AIROHA_USB_PHY_SSUSB_CDR_RST_DLY, 0x0)
+#define   AIROHA_USB_PHY_SSUSB_CDR_RST_DLY_64	FIELD_PREP_CONST(AIROHA_USB_PHY_SSUSB_CDR_RST_DLY, 0x1)
+#define   AIROHA_USB_PHY_SSUSB_CDR_RST_DLY_128	FIELD_PREP_CONST(AIROHA_USB_PHY_SSUSB_CDR_RST_DLY, 0x2)
+#define   AIROHA_USB_PHY_SSUSB_CDR_RST_DLY_216	FIELD_PREP_CONST(AIROHA_USB_PHY_SSUSB_CDR_RST_DLY, 0x3)
+
+#define AIROHA_USB_PHY_U3_PHYA_DA_REG19		0xc38
+#define   AIROHA_USB_PHY_SSUSB_PLL_SSC_DELTA1_U3 GENMASK(15, 0)
+
+#define AIROHA_USB_PHY_U2_FM_DET_CYCLE_CNT	1024
+#define AIROHA_USB_PHY_REF_CK			20
+#define AIROHA_USB_PHY_U2_SR_COEF		28
+#define AIROHA_USB_PHY_U2_SR_COEF_DIVISOR	1000
+
+#define AIROHA_USB_PHY_DEFAULT_SR_CALIBRATION	0x5
+#define AIROHA_USB_PHY_FREQDET_SLEEP		1000 /* 1ms */
+#define AIROHA_USB_PHY_FREQDET_TIMEOUT		(AIROHA_USB_PHY_FREQDET_SLEEP * 10)
+
+struct airoha_usb_phy_instance {
+	struct phy *phy;
+	u32 type;
+};
+
+enum airoha_usb_phy_instance_type {
+	AIROHA_PHY_USB2,
+	AIROHA_PHY_USB3,
+
+	AIROHA_PHY_USB_MAX,
+};
+
+struct airoha_usb_phy_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regmap *scu;
+
+	unsigned int monclk_sel;
+	unsigned int serdes_port;
+
+	struct airoha_usb_phy_instance *phys[AIROHA_PHY_USB_MAX];
+};
+
+static void airoha_usb_phy_u2_slew_rate_calibration(struct airoha_usb_phy_priv *priv)
+{
+	u32 fm_out;
+	u32 srctrl;
+
+	/* Enable HS TX SR calibration */
+	regmap_set_bits(priv->regmap, AIROHA_USB_PHY_USBPHYACR5,
+			AIROHA_USB_PHY_USB20_HSTX_SRCAL_EN);
+
+	usleep_range(1000, 1500);
+
+	/* Enable Free run clock */
+	regmap_set_bits(priv->regmap, AIROHA_USB_PHY_FMMONR1,
+			AIROHA_USB_PHY_FRCK_EN);
+
+	/* Select Monitor Clock */
+	regmap_update_bits(priv->regmap, AIROHA_USB_PHY_FMCR0,
+			   AIROHA_USB_PHY_MONCLK_SEL,
+			   FIELD_PREP(AIROHA_USB_PHY_MONCLK_SEL,
+				      priv->monclk_sel));
+
+	/* Set cyclecnt */
+	regmap_update_bits(priv->regmap, AIROHA_USB_PHY_FMCR0,
+			   AIROHA_USB_PHY_CYCLECNT,
+			   FIELD_PREP(AIROHA_USB_PHY_CYCLECNT,
+				      AIROHA_USB_PHY_U2_FM_DET_CYCLE_CNT));
+
+	/* Enable Frequency meter */
+	regmap_set_bits(priv->regmap, AIROHA_USB_PHY_FMCR0,
+			AIROHA_USB_PHY_FREQDET_EN);
+
+	/* Timeout can happen and we will apply workaround at the end */
+	regmap_read_poll_timeout(priv->regmap, AIROHA_USB_PHY_FMMONR0, fm_out,
+				 fm_out, AIROHA_USB_PHY_FREQDET_SLEEP,
+				 AIROHA_USB_PHY_FREQDET_TIMEOUT);
+
+	/* Disable Frequency meter */
+	regmap_clear_bits(priv->regmap, AIROHA_USB_PHY_FMCR0,
+			  AIROHA_USB_PHY_FREQDET_EN);
+
+	/* Disable Free run clock */
+	regmap_clear_bits(priv->regmap, AIROHA_USB_PHY_FMMONR1,
+			  AIROHA_USB_PHY_FRCK_EN);
+
+	/* Disable HS TX SR calibration */
+	regmap_clear_bits(priv->regmap, AIROHA_USB_PHY_USBPHYACR5,
+			  AIROHA_USB_PHY_USB20_HSTX_SRCAL_EN);
+
+	usleep_range(1000, 1500);
+
+	/* Frequency was not detected, use default SR calibration value */
+	if (!fm_out) {
+		srctrl = AIROHA_USB_PHY_DEFAULT_SR_CALIBRATION;
+		dev_err(priv->dev, "Frequency not detected, using default SR calibration.\n");
+	} else {
+		/* (1024 / FM_OUT) * REF_CK * U2_SR_COEF (round to the nearest digits) */
+		srctrl = AIROHA_USB_PHY_REF_CK * AIROHA_USB_PHY_U2_SR_COEF;
+		srctrl = (srctrl * AIROHA_USB_PHY_U2_FM_DET_CYCLE_CNT) / fm_out;
+		srctrl = DIV_ROUND_CLOSEST(srctrl, AIROHA_USB_PHY_U2_SR_COEF_DIVISOR);
+		dev_dbg(priv->dev, "SR calibration applied: %x\n", srctrl);
+	}
+
+	regmap_update_bits(priv->regmap, AIROHA_USB_PHY_USBPHYACR5,
+			   AIROHA_USB_PHY_USB20_HSTX_SRCTRL,
+			   FIELD_PREP(AIROHA_USB_PHY_USB20_HSTX_SRCTRL, srctrl));
+}
+
+static void airoha_usb_phy_u2_init(struct airoha_usb_phy_priv *priv)
+{
+	regmap_update_bits(priv->regmap, AIROHA_USB_PHY_USBPHYACR4,
+			   AIROHA_USB_PHY_USB20_FS_CR,
+			   AIROHA_USB_PHY_USB20_FS_CR_MIN);
+
+	regmap_update_bits(priv->regmap, AIROHA_USB_PHY_USBPHYACR4,
+			   AIROHA_USB_PHY_USB20_FS_SR,
+			   AIROHA_USB_PHY_USB20_FS_SR_NORMAL);
+
+	/* FIXME: evaluate if needed */
+	regmap_update_bits(priv->regmap, AIROHA_USB_PHY_USBPHYACR6,
+			   AIROHA_USB_PHY_USB20_SQTH,
+			   AIROHA_USB_PHY_USB20_SQTH_130);
+
+	regmap_update_bits(priv->regmap, AIROHA_USB_PHY_USBPHYACR6,
+			   AIROHA_USB_PHY_USB20_DISCTH,
+			   AIROHA_USB_PHY_USB20_DISCTH_600);
+
+	/* Enable the USB port and then disable after calibration */
+	regmap_clear_bits(priv->regmap, AIROHA_USB_PHY_USBPHYACR6,
+			  AIROHA_USB_PHY_USB20_BC11_SW_EN);
+
+	airoha_usb_phy_u2_slew_rate_calibration(priv);
+
+	regmap_set_bits(priv->regmap, AIROHA_USB_PHY_USBPHYACR6,
+			AIROHA_USB_PHY_USB20_BC11_SW_EN);
+
+	usleep_range(1000, 1500);
+}
+
+/*
+ * USB 3.0 mode can only work if USB serdes is correctly set.
+ * This is validated in xLate function.
+ */
+static void airoha_usb_phy_u3_init(struct airoha_usb_phy_priv *priv)
+{
+	regmap_update_bits(priv->regmap, AIROHA_USB_PHY_U3_PHYA_REG8,
+			   AIROHA_USB_PHY_SSUSB_CDR_RST_DLY,
+			   AIROHA_USB_PHY_SSUSB_CDR_RST_DLY_32);
+
+	regmap_update_bits(priv->regmap, AIROHA_USB_PHY_U3_PHYA_REG6,
+			   AIROHA_USB_PHY_SSUSB_CDR_RESERVE,
+			   FIELD_PREP(AIROHA_USB_PHY_SSUSB_CDR_RESERVE, 0xe));
+
+	regmap_update_bits(priv->regmap, AIROHA_USB_PHY_U3_PHYA_REG0,
+			   AIROHA_USB_PHY_SSUSB_BG_DIV,
+			   AIROHA_USB_PHY_SSUSB_BG_DIV_4);
+
+	regmap_set_bits(priv->regmap, AIROHA_USB_PHY_U3_PHYA_REG1,
+			FIELD_PREP(AIROHA_USB_PHY_SSUSB_XTAL_TOP_RESERVE, 0x600));
+
+	regmap_update_bits(priv->regmap, AIROHA_USB_PHY_U3_PHYA_DA_REG19,
+			   AIROHA_USB_PHY_SSUSB_PLL_SSC_DELTA1_U3,
+			   FIELD_PREP(AIROHA_USB_PHY_SSUSB_PLL_SSC_DELTA1_U3, 0x43));
+}
+
+static int airoha_usb_phy_init(struct phy *phy)
+{
+	struct airoha_usb_phy_instance *instance = phy_get_drvdata(phy);
+	struct airoha_usb_phy_priv *priv = dev_get_drvdata(phy->dev.parent);
+
+	switch (instance->type) {
+	case PHY_TYPE_USB2:
+		airoha_usb_phy_u2_init(priv);
+		break;
+	case PHY_TYPE_USB3:
+		if (phy_get_mode(phy) == PHY_MODE_PCIE)
+			return 0;
+
+		airoha_usb_phy_u3_init(priv);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int airoha_usb_phy_u2_power_on(struct airoha_usb_phy_priv *priv)
+{
+	regmap_clear_bits(priv->regmap, AIROHA_USB_PHY_USBPHYACR6,
+			  AIROHA_USB_PHY_USB20_BC11_SW_EN);
+
+	usleep_range(1000, 1500);
+
+	return 0;
+}
+
+static int airoha_usb_phy_u3_power_on(struct airoha_usb_phy_priv *priv)
+{
+	regmap_clear_bits(priv->regmap, AIROHA_USB_PHY_GPIO_CTLD,
+			  AIROHA_USB_PHY_SSUSB_IP_SW_RST |
+			  AIROHA_USB_PHY_MCU_BUS_CK_GATE_EN |
+			  AIROHA_USB_PHY_FORCE_SSUSB_IP_SW_RST |
+			  AIROHA_USB_PHY_SSUSB_SW_RST);
+
+	usleep_range(1000, 1500);
+
+	return 0;
+}
+
+static int airoha_usb_phy_power_on(struct phy *phy)
+{
+	struct airoha_usb_phy_instance *instance = phy_get_drvdata(phy);
+	struct airoha_usb_phy_priv *priv = dev_get_drvdata(phy->dev.parent);
+
+	switch (instance->type) {
+	case PHY_TYPE_USB2:
+		airoha_usb_phy_u2_power_on(priv);
+		break;
+	case PHY_TYPE_USB3:
+		if (phy_get_mode(phy) == PHY_MODE_PCIE)
+			return 0;
+
+		airoha_usb_phy_u3_power_on(priv);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int airoha_usb_phy_u2_power_off(struct airoha_usb_phy_priv *priv)
+{
+	regmap_set_bits(priv->regmap, AIROHA_USB_PHY_USBPHYACR6,
+			AIROHA_USB_PHY_USB20_BC11_SW_EN);
+
+	usleep_range(1000, 1500);
+
+	return 0;
+}
+
+static int airoha_usb_phy_u3_power_off(struct airoha_usb_phy_priv *priv)
+{
+	regmap_set_bits(priv->regmap, AIROHA_USB_PHY_GPIO_CTLD,
+			AIROHA_USB_PHY_SSUSB_IP_SW_RST |
+			AIROHA_USB_PHY_FORCE_SSUSB_IP_SW_RST);
+
+	usleep_range(1000, 1500);
+
+	return 0;
+}
+
+static int airoha_usb_phy_power_off(struct phy *phy)
+{
+	struct airoha_usb_phy_instance *instance = phy_get_drvdata(phy);
+	struct airoha_usb_phy_priv *priv = dev_get_drvdata(phy->dev.parent);
+
+	switch (instance->type) {
+	case PHY_TYPE_USB2:
+		airoha_usb_phy_u2_power_off(priv);
+		break;
+	case PHY_TYPE_USB3:
+		if (phy_get_mode(phy) == PHY_MODE_PCIE)
+			return 0;
+
+		airoha_usb_phy_u3_power_off(priv);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int airoha_usb_phy_u2_set_mode(struct airoha_usb_phy_priv *priv,
+				      enum phy_mode mode)
+{
+	u32 val;
+
+	/*
+	 * For Device and Host mode, enable force IDDIG.
+	 * For Device set IDDIG, for Host clear IDDIG.
+	 * For OTG disable force and clear IDDIG bit while at it.
+	 */
+	switch (mode) {
+	case PHY_MODE_USB_DEVICE:
+		val = AIROHA_USB_PHY_IDDIG;
+		break;
+	case PHY_MODE_USB_HOST:
+		val = AIROHA_USB_PHY_FORCE_IDDIG |
+		      AIROHA_USB_PHY_FORCE_IDDIG;
+		break;
+	case PHY_MODE_USB_OTG:
+		val = 0;
+		break;
+	default:
+		return 0;
+	}
+
+	regmap_update_bits(priv->regmap, AIROHA_USB_PHY_U2PHYDTM1,
+			   AIROHA_USB_PHY_FORCE_IDDIG |
+			   AIROHA_USB_PHY_IDDIG, val);
+
+	return 0;
+}
+
+static int airoha_usb_phy_u3_set_mode(struct airoha_usb_phy_priv *priv,
+				      enum phy_mode mode)
+{
+	u32 sel;
+
+	/* Only USB1 supports Ethernet mode */
+	if (mode == PHY_MODE_ETHERNET &&
+	    priv->serdes_port != AIROHA_SCU_SERDES_USB1)
+		return -EINVAL;
+
+	/* Only USB2 supports PCIe mode */
+	if (mode == PHY_MODE_PCIE &&
+	    priv->serdes_port != AIROHA_SCU_SERDES_USB2)
+		return -EINVAL;
+
+	if (priv->serdes_port == AIROHA_SCU_SERDES_USB1) {
+		if (mode == PHY_MODE_ETHERNET)
+			sel = AIROHA_SCU_SSR3_SSUSB_HSGMII_SEL_HSGMII;
+		else
+			sel = AIROHA_SCU_SSR3_SSUSB_HSGMII_SEL_USB;
+
+		regmap_update_bits(priv->scu, AIROHA_SCU_SSR3,
+				   AIROHA_SCU_SSR3_SSUSB_HSGMII_SEL, sel);
+	}
+
+	if (priv->serdes_port == AIROHA_SCU_SERDES_USB2) {
+		if (mode == PHY_MODE_PCIE)
+			sel = AIROHA_SCU_SSTR_USB_PCIE_SEL_PCIE;
+		else
+			sel = AIROHA_SCU_SSTR_USB_PCIE_SEL_USB;
+
+		regmap_update_bits(priv->scu, AIROHA_SCU_SSTR,
+				   AIROHA_SCU_SSTR_USB_PCIE_SEL, sel);
+	}
+
+	return 0;
+}
+
+static int airoha_usb_phy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct airoha_usb_phy_instance *instance = phy_get_drvdata(phy);
+	struct airoha_usb_phy_priv *priv = dev_get_drvdata(phy->dev.parent);
+
+	switch (instance->type) {
+	case PHY_TYPE_USB2:
+		return airoha_usb_phy_u2_set_mode(priv, mode);
+	case PHY_TYPE_USB3:
+		return airoha_usb_phy_u3_set_mode(priv, mode);
+	default:
+		return 0;
+	}
+}
+
+static struct phy *airoha_usb_phy_xlate(struct device *dev,
+					const struct of_phandle_args *args)
+{
+	struct airoha_usb_phy_priv *priv = dev_get_drvdata(dev);
+	struct airoha_usb_phy_instance *instance = NULL;
+	unsigned int index, phy_type;
+
+	if (args->args_count != 1) {
+		dev_err(dev, "invalid number of cells in 'phy' property\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	phy_type = args->args[0];
+	if (!(phy_type == PHY_TYPE_USB2 || phy_type == PHY_TYPE_USB3)) {
+		dev_err(dev, "unsupported device type: %d\n", phy_type);
+		return ERR_PTR(-EINVAL);
+	}
+
+	for (index = 0; index < AIROHA_PHY_USB_MAX; index++)
+		if (priv->phys[index] &&
+		    phy_type == priv->phys[index]->type) {
+			instance = priv->phys[index];
+			break;
+		}
+
+	if (!instance) {
+		dev_err(dev, "failed to find appropriate phy\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return instance->phy;
+}
+
+static const struct phy_ops airoha_phy = {
+	.init		= airoha_usb_phy_init,
+	.power_on	= airoha_usb_phy_power_on,
+	.power_off	= airoha_usb_phy_power_off,
+	.set_mode	= airoha_usb_phy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static const struct regmap_config airoha_usb_phy_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static int airoha_usb_phy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct airoha_usb_phy_priv *priv;
+	struct device *dev = &pdev->dev;
+	unsigned int index;
+	void *base;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	ret = of_property_read_u32(dev->of_node, "airoha,usb2-monitor-clk-sel",
+				   &priv->monclk_sel);
+	if (ret)
+		return dev_err_probe(dev, ret, "Monitor clock selection is mandatory for USB PHY calibration\n");
+
+	if (priv->monclk_sel > 3)
+		return dev_err_probe(dev, -EINVAL, "only 4 Monitor clock are selectable on the SoC\n");
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->regmap = devm_regmap_init_mmio(dev, base, &airoha_usb_phy_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	platform_set_drvdata(pdev, priv);
+
+	for (index = 0; index < AIROHA_PHY_USB_MAX; index++) {
+		enum airoha_usb_phy_instance_type phy_type;
+		struct airoha_usb_phy_instance *instance;
+
+		switch (index) {
+		case AIROHA_PHY_USB2:
+			phy_type = PHY_TYPE_USB2;
+			break;
+		case AIROHA_PHY_USB3:
+			phy_type = PHY_TYPE_USB3;
+			break;
+		}
+
+		if (phy_type == PHY_TYPE_USB3) {
+			ret = of_property_read_u32(dev->of_node, "airoha,usb3-serdes",
+						   &priv->serdes_port);
+			if (ret)
+				return dev_err_probe(dev, ret, "missing serdes line for USB 3.0\n");
+
+			priv->scu = syscon_regmap_lookup_by_phandle(dev->of_node,
+								    "airoha,scu");
+			if (IS_ERR(priv->scu))
+				return dev_err_probe(dev, PTR_ERR(priv->scu), "failed to get SCU syscon\n");
+		}
+
+		instance = devm_kzalloc(dev, sizeof(*instance), GFP_KERNEL);
+		if (!instance)
+			return -ENOMEM;
+
+		instance->type = phy_type;
+		priv->phys[index] = instance;
+
+		instance->phy = devm_phy_create(dev, NULL, &airoha_phy);
+		if (IS_ERR(instance->phy))
+			return dev_err_probe(dev, PTR_ERR(instance->phy), "failed to create phy\n");
+
+		phy_set_drvdata(instance->phy, instance);
+	}
+
+	phy_provider = devm_of_phy_provider_register(&pdev->dev, airoha_usb_phy_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id airoha_phy_id_table[] = {
+	{ .compatible = "airoha,an7581-usb-phy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, airoha_phy_id_table);
+
+static struct platform_driver airoha_usb_driver = {
+	.probe		= airoha_usb_phy_probe,
+	.driver		= {
+		.name	= "airoha-usb-phy",
+		.of_match_table = airoha_phy_id_table,
+	},
+};
+
+module_platform_driver(airoha_usb_driver);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Airoha USB PHY driver");
diff --git a/scripts/tracepoint-update b/scripts/tracepoint-update
new file mode 100755
index 0000000000000000000000000000000000000000..e3261675b1535f52e235c01d959a441fdd3d224e
GIT binary patch
literal 22952
zcmeHP4|J5(m46cwNEI?sNeyCUq)AN`#smTzkZ1x4d~t(B1xr`$FeDR_n#{!cBSEP~
zleo-@V`*zW*xFOtb+;T>TUy=9YHLRU!ES4#R-0}u#`<qYMC0Ga+U48dec!z^-+UxJ
z-95YK?Aeo-leyphy?gJw@4olF_r8DcrpD&gc`lcdG)-Noh)bSsA$6S5aVZ~w)TtU(
zgx|B3M@<KxuQ4mX&LYUQQt`B0TF5xTq<0VJJL#D$CsaHnN_vx}T_;;PLRGQFlU@NG
zGVi2wPPOEON`9uiN-JME=z^0hT&P`-VzY0BmA|h!mu}>Gw@78!uRMs6-o{!>e&gC)
zI>vzzD)A&U^xq<O9n|5ra_aT5ypxt$#Vesy1|_2OfA=!tPNX|6SP2!q%U_MQ(eZ!P
z&lc9JS!5Y@(pNYxLZ!S*p-1ujYZEtvx{S-4to;m*mryQV$HaresIRTLWP?I`Cdn5T
zS9yIFZ<n9V`6T}-?}qZxFCJL;=<+`{{r<ES2R<BWf9d?L&dp1!&+lqm*wq<~^)BqK
zS-Nm(wKo#-E+YGi^vRyCr|V`MsXW3;@c(q+sqSU(4#{amc{yngIPUs6_?k)Z7l3<m
zBrPTmGLfC~NpR|a6Ul#h5<D~s9-9QeWfFWGxCj5vv;e?F{+u-lzH$<r+F>F)H%x+8
zPlC^YArJDL=?(xB+1~_wzEc?d=kb4vI#YRCtV}uYRZk!s4uzG^7m4~?ukp2ZT;pr^
zcXp}va3G+%W5I5JkBUUYU4ftq2mD=Kp;pMY_k=rx(RPwnp&n%UeCV64WFs8)b^AMm
z&}oBZWVH7BeeIn=e^=-A0oB?SiUd@9Pb}K1+P8)~qX9DB+TEkBjfBEc)lJ2<!%S3>
zLF(H})tcs}m8*P<yo(oS553iy<LuGm?BOEs66I@Jzt#sY0$VyG(Li|p+ErblU|_v}
zb5{U<ZRrjL*<qh0I-wxKm4~y|h2K1!)$~h$7H=IFfSaySI{ymPH=rZq#{*xv6Q|>J
zbq{0FIh~)NQQ-&7&+hD;MI-1V%s;5*r>TR?$Ic-6JT(lSlFT2{e!EL8JjwHl;F}mf
z?7)W^A9mo11^}cH2fm5%Q3sx6JmtVWXIOT|95}k3PU8-IlZ;3_zlr~Q*-oJY_pp4i
z15a|jN*(wZ;~odz!v0q{@V$&zI`Crlr^bQTF<$4uTi8#-f$wJd76)F;@`aA`Q}~f}
zR{User?Fnrs1297h4NB1oR>mcWz2@#$B%IvPIHDN882uaqj^NqCYGN8fW|sW9X4F%
zUdrpS;bcovuMOAp7H9O?a4JL64jV3gh4OaVaGWriw9AI`5>4mrw&61~(n{^I;j?V`
zUK?Iy!}r;6w+&C)a2X3I`>+i^#U?*&!%wr}Q-@O#n2Nwu1pc=p@SgjuKN<aR78*kZ
zzr9E)V=x)bGlz}-1BLr_(dLqK0h{Fu@avver%1koa?*b=O|yNc=4m2GKa=HYqDnuW
z<!ORS|0v7T1d;x3mZym!{nac_6GHlyEKd_bI-KQc0!VMp@-*<LFU#^Y;HOt+d722*
zi?Tco{OS2wo(BB%sac)|`gC4~H_M;8P^otJyauJ~Z<c??!Jp;eKk49$9Q<?#e;il)
zcKaVX__rMVYYzU1gMZ$^Kjq+`aPW^h_#bEZ=J@NWeTYQ-?bM|p=>o)(uzQFZN1)ri
z?s)@<7j+MgPyOfWuc+Tpzkb8z=vf_Y#!!BF1@et}L)pfvq;aUBOfPo&O_%%jZ=x^6
zKQ@MLEHvUD7>Ol4pTZhu28<6T-2<iQNKZ7Bty4y#5%~>ep2Vu-Mxx<hF)=kbDr=#m
zx~e384eFo95TuNuXj$FE)C-NFn$(l%9wb$W&g~v}1f5X}H4kksD{M|IS&q6IL#UKV
zLKS976##Hei8E)ICDj(=ekf&@cyQblKjwZYS!<d~#Xe!gUo=Zr0(Jl3pwT*RxWLW@
zYmjNOR&17hyaL$|4G%sOb8GQw$d5mc(`;LOeOc*G$;rm5SJ3!Y5Ft}<UeSU`gs?Is
zqo`1!F>QNUadTot4g5-_|AV3vJIRQD>N*(jKjwn;dPq~|FS41JTAB6z2VBjrql3qy
zGa4>vD=Q7(Z4A}cBCl^dBI_P_hQc&xx(ANH7o)#+4zd785GS)_Ef`~{xva427`%jH
zK7i&#waYA7jw8fq`q5A7xVIkcKj>N;uRgH0_1L;Z)az<mcEsKPE!b*~|1tIIpG~tV
zeh}3j{o_FsrejYf{sosm$b8*s{m^*qwP~rd;d)d209q;bLt|*xEf*;DFs;fTrQyX$
z)c*Zkbd41dN)H0*KkDlL*ySF$k^6|t=s#GPeiqrfAL<(2YSm~BETKl<Ar767`l3pE
z(8t{K)Zj7qz*3kqT8}+U!-|oZbr;+tx8iT5&Vt*h^b8m<OX~5fV*%uY<r0R)K${Y?
zr#CHo-rfHSS%`O)RW`+c(;P>zcT(k3A5+DW)cfv-K=V*nS*bB}RavF(B1cPg{1TU&
zYZG0^3XP}VFyhY|gTITG8}Z*m-FW&~(@^x7O1%R!WaGE6anrAi_)!SOeg|hZ!kMaM
zbNn46QS#<o1Pm2bsrlr4|8`Wj8C|Fta+Q#C5B!{bM3YuP`Vw4~XlYW1Q0f@U(Bje`
z*R~!;YZkfIE<5hN<$T1fc?i{_5#ZfFQEZ|(1F5&C9>Bn0^yB2iRML!db6Inl$355$
zC#sV0!cgw7Cyk-?WgFX!^JeSuz&%(=f$u-iapl$ZSJhu#|Al(reqDG@p${K7&7*Pg
z2PGJ;qj%cQm*YR9;ofrpQTTMCg<e=lH^6uF?hBSd*gdd{I30wc+Btv_i$#b<Rnm&x
zYp|1^r)6gSsRsS93|i6;UqYu$JqU@aWcpl7=6RA?V3SFZ%uY*Yx~;7HA&9a*M7ET5
zJ*0H4(%*-l;?#g8_<>FEQV1S>E_Lrmn0GUSF3rDH$C~0#f5C|V!RUWwtYv*;RkG?y
zoG;fx-Yj|VZ<KmJD-V2*HeGNkk!9o25={NiLx`sSPne_bd3~sd+Rqg7Y06A2`2&&9
z9yj7+#$#_?WIQ%L&2T+oJbgSm8wUQ74HTNA);uQq<X>OyPm!%+=WRd(+(L&&{MG18
z^vGMmr0yCw%~TtFeWKv&;9XZkH&Z_8r?(=L{UP2MT51eklzs_%di`PaAF43R=c7K>
zdPJ{h`VV=`lH;&PYngb`?hoXbo8@mHPvj4I&GLV@^B0=sKezLX%<_lr{0g)DUOQiD
zmVd*}7n|i@weeVA^&gsPmIQ%K=ufFxzS${{$>YMw<UMBjBB%Upv!rM;`5Lo4&naJK
zmK<3+i9d+v<H*az2mbvi!<*&*M8}!=9(Bt{eKYy)AFs*pA9W+-)_M{AOgj(xLbE)a
zk>~cxH%l%7Her0Go8`-G@`sAd@^dph)?;*R^XJV%vm`HTt3BKQb^oFDF8NS$WXXi(
zp^GQBVvTXgEPnwKJDvLRaRcLWq6f8jaDx1y8ScaO{^ovYM*CyQ!c07jp&5pjXt36k
zLo@cn`2jlZ^!gI=kj?Ut&*9y_ieG5A4=zXFaAS5L3AS%BHhcYt&_CbBt>;YpqWzw+
z^Qf7f*YQI8d>=9=wvSnUC+TL&Gs|yv@Ym(=+}@{}CGBhvODd`Y`&*UlyD8s=`67`&
zn2(t3cf`N`il+F7dZ5NCGyYut`lk4wvDUo#&D{{TEjI_sb^)kLre1$v&zw6}eSiTr
z{#yJ{{9x)d9Ah@!F&7l`V`;e>Q>s?=DHXjOBUAojnp0ll$&sc9+?`211w&W~uK}sT
z%xe{Z3C&vIx(B}tca575kRL{TM5Z;g1ZLc5S!H9@llAe`zhc%?4`Y#`s?5}z?~zOU
zjs9`0z}^N(>%GeO+fDK5sZq+qLf{VfkN>uy?;|XBK7*OP@1wkE6+GO$NU62)(X5Aa
zX2Zh;aIFdBWBkR`OHfa5&_ib(2Jl)x)<#C6;ES3piD)wGK21sv5{cJ71)D~^;8&U~
z8P;Uh)0&h#19I~PH{p4)d+<6q+IPcrmwT{_Tu$6jY!27E|KXs!|3>g|H($GZ2sMSf
z?!h~0qE8fj8#5AwtKW0qSnxG3x{TotjsX82@OF3Ce&R>LzYgAgO2M8gOC&||*FYXw
z3$Q>TF`S_VJ#_5uIzaq5_&)GZyP4GvliCVPZIIQ5A@-!Dc2G)BV~ql}zhkvgQk!L|
zy#-Ok;|G-G?s@`J4LBr$_ZMpD5TJU7(iZd>pbHr~VnL4sx`3f)EoeWW8io#A&;dY8
z0GTE0@Y~)$UKg8<Xe~EOE@Iw2u!GuZsJ6Y*(K{PYMcY@tiv~9#LH#XJ`yFyVQE;y&
zOCHc<)-N<Ec@-pmvR-f0&VjL<j&xr!jJ^C0Bz^>A)_Dm-?_j=#KNVE{1Qt6Kzr(;k
z0*>fBMm)uL85St0${XifA|oUpfIPBpq_qpgsF5Fs3s8HU_!RhOEVcctHb!boEw$gU
z8a47<TVJ8l&$If<-K;iDYBMag7G$CI-k~gX6Zmv14oTpx^E7l2P(MR2TM)HzA44M+
zL~Z;fhJI;5)W+8{^tc648*c?<mV5=jXuWFp;AIrx#0_4vg!F+`xCfq~$S*?%$91Uo
zF7&mWq2|RR#J_b+4>d2m4e>uiN7iFQwVh7+!z8~L^65P5dS#7MB1sabki;lVrMAGR
zZ9SEK2t0<P?A$1Ke*jLUsR&F(U@8Jr5txd=R0O6XFcpER2uwv_Dgsjx_<s=rdY^IO
z!tPL8Ourl%4f|UIJt4g0iFZ5$t=Hgv$t)DXYm<2Yb4x_6#+#ynHcxk;I~3mL(Qk+P
zqn)APNy^h1^jOwB<&l$AFckIpJ$S(~*5wa-+M%^v<Euikt~L+l(wm>Qj94%nXbo)%
z;-%3x5AHSTEUnTMybkY@T3~crPavCff=+9fKN9hjw`o1AnPL(D7L=W>%)(etn?D-x
zNafjUuh&bDlhma0*LCZcutjdGKO96zmV4If5TZm+hd<&81-rI+V!>DhwaAvK1LCoV
z)QU0%EgKu{a4?iB$B{olGE;uG6wf*3k#jtq5iXzW?~E%d@Am|Pt)Vu!k62mlqH<%o
z-q*OXan<>a>wOKMza+;+*W76r(7X0{`l(XCH%)p}pE_cib)e&*8;O6>G#B9AjnYxm
z900%LRorF(?S0KOdx!@e0o?`qCg?uUeB3`g3|b000=fV+1zHC>4!Rz+@O9Jd04)XG
z4q5@a6Vw3R1G*9PC!oEczXsg_ngZPes&I#PALwk*5zqyoDbPC5anSXkg(=tvEd|{U
zS^>Hfv<CDZPy=)yXb0#pXfNn1pgTavL3e@9#5*nfK+8Z!Kv#f{gSLQ{rcJXAv;wpj
zv<CDxPy=)~=tj^7K|4SXgZ6^H0J;No40IQ0KHibp16m5Y4|D<OVbD6z5zzIZDbNnk
z!Z%E_5405Y4$unFJ)kw9KLOnc`fJc$&=lxl+zx8ymoIToStr-^mnm0ov1{(k8HGF1
z?u4I-|Gt+^^D`vTFaviDmHtiyH}%!w-yznJQ$@wAi%KtcpS-oOPhE7zvU3-g%_lk1
zzY71mUocIrNFWm7QT*=$K1Kj1lDUnJU%{;_##%sk<Nr4Fzjnk$tu8A5a^A|K(%Yx4
zEb=7sR~A*=R#0D5dF%B0qMH604Mn?M(>|SlQc(@C`l1TRKz3zO@yepY`jeqfiOP8&
z|9em`+%(gPd@4j;?g579v1q8G;!BDOwX6sDeKuLruLfq<C(K}du}Rofz;-)ydw|{T
zzy^Tra$viF-C@JX$NPZo1m^VdfJ2{TM_At}OWzgQ%O}}<I!7n4dnRzZ|0G)pjP#v$
z4d4{NoccTTDJC>7kiH&-!4pPf#|iZZM)jYGd`cvDA26!F9ZLec%~me?_-kN0fH{4n
zF^Kf-KGKIfc6};mHjOEe6CcTD1+W2N`dw-CkBiYi2&Zw2^qpnV_g~~c$xtG@^elzq
zX~+72QU8*6n@R2tVAQ|t^`vo+;%o26GzOAAd5@ZOhk;Ri>0K8}guMcc;%mpofsudq
za%W;}qxjhEd4N&<?B!O|Sm>~40HgTWV|x{_J_ptVY`YDkSPTH`1?G(5-K;O|Ky}&6
z`gZI9>kCFUM}S3P6EA(_oX=yduiFt>b@<Pxu@|yUJjUFfcX3f^Vp?O7=eGQYqKaE-
zjOm}grfArex8tOuN<j6tp{3zu8Yd0tJ~(2UXX98wvVZ!m1-IoVrrnM{M}Bu8KZ^N5
z;!R?3Md#s^)Zda3hGwBDR42;cg#R1QIR5k14eQhm^J!f)fBF2jz~=c2=7%CUjBSnu
zqcLzne>Y`qq0ei;UKa>QuwVnS$XmT=VWlOv7&-oMYX`p1X^qChq~PyvTUtH;OS-_R
zpQ#A^ABli`|0Lf#$@fk2J(GODB;PB^_et_Sl6-$8-y6yIMe;q7d_N@L3(5CE@;#7z
z|0Cb~$oD<+JrA9;l)hmRC1bTdp@Gd3e7<#{$2J_wcV2jnPbV3Z^*9AYzW1Urg_7id
zaNG<LpQHf-iH0gl<9vW+oldk4rX*wG+3cu{-=$V|&Nn{<v6?d0SpqT!b+Eq7Su!`A
z&UPxfAi?+Wf%v_H4avAC<)6j+B8SJ8x_&55LwJCyd4uiYH3!Mpnt0Z!`7<~lPmnb)
z<2sxFA0zUew$orG4em&FOk0?4V%o#BkLgaPyP57~nq)f6bd>2BQ+(v9Q!!JE`|E$@
zd$TpGRxS5bY|yiYr)r6Jk+*W;5^Hj(`YZ!~$trb+eDw}JPR>cxzAmhY<a==s=h8P%
z6Uom5o~PVO&PQ1{EMQ#DcR6pCF)rt=$Y0F3j0=Ka$#^jv5d0d(Jr4W^#w#884#w*o
z_}3Yi@k8u?hw)7;&qUqNc%Q@0BaH8K$Un*WUWfd1j3*uPFEKvqkRM}w%pp$=Nb#5P
zPW(R^4NSO<r-Gl(cqI>1GQND8aTzZ~{(Qz;SYF1*<&1A~;Ejy;FfMj3WxS7Zu7<jr
z@!byjPR92-@EGGs#>M}B#)lb~@#8Cuk1;Ogew*=P9>8T>e1P#v2Trd@Q9N51mvQjl
z7~jOW#AlfC9>!(deva`z#$~+yE#o^Gm+|xn<GUUB%Z%@3T>N>R@ub84QO1WE7k}tF
zlIk_;u>S$$V~k5XPQyGv@-jaQ?q*!(Rl(;nF7vj;{~X5ac!HF6T+F!4*MeWj_$G&Z
zli0_LRg})Qh`Iv!MB~*LS$;21V5o^s*8_K<QZ+3WFY%8vUg^NUHHrN_Y=2B9R<?gH
z;~tqf8K)0RD4w!DVpu&3ocyWaa?u<*y{PfiGwTbHpN@&2?Cf^fKNYx3eKNCN5&6md
zuhR0Tsa?xNGD|0l=S5n6j&jbc25{N|LH7R;D_3gyGcxNF!LJ3*O(>A2w@iY68@MM&
z(qb;g#g<2*({kKI<Ppfz{t9)BALfiFCb2&Pycl+h9d=$M`MhE^bG}%%=&O_1q3iRB
z>UA3YoCq(Q1YbG{PS@+?r?b8rCXuK6rJh{ZHMbS`DS301tS>}_uIW#qMN6fHfYs@1
zI5-vkZ7-jX`kEU#-vnNaI2T^Zf=n)9dD*W>--|@vZjI;4689k6@i^k2oJ9Uvw%@`*
z)%O`;hwdMcpFQj+PXj77iJgxo!RbCR+1bf<WPUkI<0txG1)SpP>_4@W$bSyF=R`B=
zS}l)Jiu;?4^EXUlhwe{1x~8`JJ(ADEs9&60$o;@4+;`;i)^N1S8^VJn|K?6#)W1aq
zy4n}^_`{Kaw^ao?+QLh#eUXk(d%I>9FS0Q@ClHKAXiE_i)wy;+OW;{au&p;MVB>Xu
zFxH*TBqm~&>Thcc>tmSB976-XL;_LCv2kRLTp@jOMUH`sQ=DaIk&8!2*N9f;7&zUe
z(KwFjUXF@v>$V-D3>%8aVKFTMICBi?NC(v(n&gr`4hOpY$Y9TjLsl+_`UZk+*y=?~
z>K$4r27*C87uy_A;YIXQLqB+S7+yp_HTc;IWGhk1+DZspWqTYFT@%jf47P`~6w1-Z
zEMvt($3PAtp%2k(u;EOPw>8w&rm_#e_^}?kQfsIiy(*A-W~rZN`slHjFA`|Asbn#9
z%}6wcuMJvNcKaA#wA+X6Yl49Y`fOXsx1}qz+27@Bi-y7xpFh^C3+f6)18v^Qi6v+o
zoKBxV9QJRcei7b=O?J@GzP4C*_co~5IMlu~nj`A-t-h>&ZKJR8k_I34tHE=)`n64~
zpoQI{e2oU@8V#2z-<sxiE9;wm>sGJ698c`l*RO1D^y&S4>SQM!y*rL`%brXww$b@Z
zTjx;3^?4e$HtosiX{!N>tkPBGeS>oIY0DkkK0}$zYQ6VQh9z5iv!EPAZyc0^peb}q
z(#Au)m5?Jpcb^|$TO{P`@CVz_9eqvf;0>O8`sn#AjX%_r6xxPP0R1%EVQX`Qo_$kM
z*3L*d*?QX}HUdMqdm0Sr-H~#nto@d9AkjhR+F}hJ*49WlLOvh%FOt@`Z@`q1T8urB
zbh}Nsj}aAO?dGJnSITNFMjx{8(Ui&2%}M=`_j1a~P+klyQU7MpXxO41a)ihE0q>Sz
z%-a*j=1}42Hs#Ggn`52WzpS%OdGT&RAl#$0ARd)>C~w=gAdFfx8n$xy{&WuGLmmwn
zq`*f#T~V?KU%fc=ZVB-Lo#EbSpcgEie2@<5{^<>L@acvjTV*(Qw0>pNLYk2*w|mfE
z@zQ{0-#RBPYjR8$$srim&ilJNQL0rAdW^!@)ZL8}K6hsP?{RdwMAvj!rt9R~KaZDD
zoSVHbD1a9ScKtrAA1Mhfv)IfpmMb}_9-IsRQvPK7HHs3++EWvl4{;Ap^yNOK&<YmD
zvOy=gPGVMFjsv>36n(jmDYTd~=sqWvE&6iVawRaTvgpfwQK51l6e2n~{ci<I_ZUTA
z?kftV`%;v|e~}Z~gFL!tDZJdb6uOC&k(~ZpC_ebc0kw(f%Y9U#avxR7ch*17`YYL>
z+?N$9_i;&|*0N6huK}Z&$bIC@dXLwA)IaUX*?(?Frd{8|dO~%k%>ZX-in+_F&-Xb!
zOhsNy2ru-z4*g2j6FMe}Ohr%VKRfh2d_5pEEf@R_eKGq(hrV3r36<voBJYgfL#!|D
zFV{^%mu5073(|gK?`IBuxqcQZ`(}!~v;1E=^gY#<q|ois@z{W~{NDh#k3VuBSg42f
zggDE8)uI0rzK<ZZM--Vl_1^<d_l|hj%iOn+{XL!j3NMuIhf))ZzC4FXt^kN6au%26
z1*iL_)c-|a_UAjy`a4CDsptt@3S~O?L|^WU$Ud=jzm1ZdpQ11Qmp0<CmoLw8jEl6I
z+Gml>ujmV<@zJiIxi3&>sYp3uK=gz^2g-zr|8o6ZTxUt7M3AY+!7t$QD;>D#mpgFs
zm6Dx0P7$47Q>Tfl;TwYUz^=i+_%HJZT_20@mWK7)bFoE}j{Yy@iYyH`6Y0zSza<U@
H2dn-Q>g^LV

literal 0
HcmV?d00001

-- 
2.51.0


