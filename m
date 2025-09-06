Return-Path: <linux-kernel+bounces-804331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB59B47285
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46423583F37
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4CC2FE05B;
	Sat,  6 Sep 2025 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6ASt8z7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067BD28642A;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173420; cv=none; b=mnzkPfMmCYeO7Fdy1rm63Bse7+6iI1GoBIb83FbgAC+VaY6xU6K9z0o0UQScIzsUFgLkWtORDKHAhimzPodi6wpk2sB9Gn824fzddBbfP4ephTjWuFGjrTLqsVKQLDh07l/kxQZaTEDJ7CbstQtAkjK9PL+e/D6Q28fC1T1bHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173420; c=relaxed/simple;
	bh=WGR1Ei6umo7JOvKNb22kiN6fvXUGcDGeVS4t2p3ndto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=br4RJTOLth4k+0zGmMnYJbJns6DdorDUwGK33qCVs6UUmOP7dAsLYj8KQWMde0v0t3QuX9IsUQFscuClUwE7Y8ew9g43AvuL33XhT2QVYc1KrQ1XYYO7xQ9+RRNuAIorN50B+2rqCe2csCzQYYx+g7X5tXAdUSLGzV9ss/W7LUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6ASt8z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66766C113D0;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173419;
	bh=WGR1Ei6umo7JOvKNb22kiN6fvXUGcDGeVS4t2p3ndto=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L6ASt8z7PGCih2VDOfQ89ftQIJn9cAxh0LGv890SGMMTiTwAOsAp8cLG9Nxndq/6R
	 W+UHlXBF3ggAJYAOfwo7nmpxsqT1V3Sh6NG0BzvKCw2p9iL1tmK941kFMoJzbGpCLf
	 4VmodiK7bHpY00Nd4alnLHoGErxiO+C5T2vjV3y1Jqs0vP6uLhBWxIicIatTONjR/Q
	 7Fl6LRnjnAOHbbWCPqZOtOwA1CsrpDZqba3DVpuSs/2pS/PpdiAhgi2NC6QPVooIpW
	 X+RIRaq4SrVl7zKUsV8i1XJ/glTVC2zNolIowr3umOMsicqEsm318TwL1mhot4YGcV
	 eIx4VNn/pL+oA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C66ACAC581;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sat, 06 Sep 2025 15:43:17 +0000
Subject: [PATCH v2 04/22] usb: dwc3: Add Apple Silicon DWC3 glue layer
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-atcphy-6-17-v2-4-52c348623ef6@kernel.org>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
In-Reply-To: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17012; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=WGR1Ei6umo7JOvKNb22kiN6fvXUGcDGeVS4t2p3ndto=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8aesLmr7nTtmVbpJ5D2SbXhqITUWYdy30BH7YaIib57f
 IOUgxd3lLIwiHEwyIopsmzfb2/65OEbwaWbLr2HmcPKBDKEgYtTACZyM42R4cIetV3HjotfuvyD
 m3dlkIwC25rIzT6PGr9uVl/35z/jKieG/1GlRyq1LS3/NXNMVjlT+rn1y+Nbv9vMWeKUjTdt9Ps
 bzwMA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

As mad as it sounds, the dwc3 controller present on the Apple M1 must be
reset and reinitialized whenever a device is unplugged from the root
port or when the PHY mode is changed.

This is required for at least the following reasons:

  - The USB2 D+/D- lines are connected through a stateful eUSB2 repeater
    which in turn is controlled by a variant of the TI TPS6598x USB PD
    chip. When the USB PD controller detects a hotplug event it resets
    the eUSB2 repeater. Afterwards, no new device is recognized before
    the DWC3 core and PHY are reset as well because the eUSB2 repeater
    and the PHY/dwc3 block disagree about the current state.

  - It's possible to completely break the dwc3 controller by switching
    it to device mode and unplugging the cable at just the wrong time.
    If this happens dwc3 behaves as if no device is connected.
    CORESOFTRESET will also never clear after it has been set. The only
    workaround is to trigger a hard reset of the entire dwc3 core with
    its external reset line.

  - Whenever the PHY mode is changed (to e.g. transition to DisplayPort
    alternate mode or USB4) dwc3 has to be shutdown and reinitialized.
    Otherwise the Type-C port will not be usable until the entire SoC
    has been reset.

Additionally, these controllers have a Apple-specific MMIO region after
the common dwc3 region where some controls have to be updated. PHY
bringup and shutdown also requires SUSPHY to be enabled for the ports
to work correctly.

In the future, this driver will also gain support for USB3-via-USB4
tunneling which will require additional tweaks.

Add a glue driver that takes of all of these constraints.

Signed-off-by: Sven Peter <sven@kernel.org>
---
 MAINTAINERS                   |   1 +
 drivers/usb/dwc3/Kconfig      |  11 ++
 drivers/usb/dwc3/Makefile     |   1 +
 drivers/usb/dwc3/dwc3-apple.c | 425 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 438 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e085cb0762f765958d67be61ae0d3d773503431..e147e1b919d5737a34e684ec587872ce591c641a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2424,6 +2424,7 @@ F:	drivers/pwm/pwm-apple.c
 F:	drivers/soc/apple/*
 F:	drivers/spi/spi-apple.c
 F:	drivers/spmi/spmi-apple-controller.c
+F:	drivers/usb/dwc3/dwc3-apple.c
 F:	drivers/video/backlight/apple_dwi_bl.c
 F:	drivers/watchdog/apple_wdt.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 310d182e10b50b253d7e5a51674806e6ec442a2a..8161cd8f5d0d82826262518a1aefa3096aae83a8 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -189,4 +189,15 @@ config USB_DWC3_RTK
 	  or dual-role mode.
 	  Say 'Y' or 'M' if you have such device.
 
+config USB_DWC3_APPLE
+	tristate "Apple Silicon DWC3 Platform Driver"
+	depends on OF && ARCH_APPLE
+	default USB_DWC3
+	select USB_ROLE_SWITCH
+	help
+	  Support Apple Silicon SoCs with DesignWare Core USB3 IP.
+	  The DesignWare Core USB3 IP has to be used in dual-role
+	  mode on these machines.
+	  Say 'Y' or 'M' if you have such device.
+
 endif
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 830e6c9e5fe073c1f662ce34b6a4a2da34c407a2..10b5e68cfd68d5ca9aa5a27b04f349f9bf58e65c 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -43,6 +43,7 @@ endif
 ##
 
 obj-$(CONFIG_USB_DWC3_AM62)		+= dwc3-am62.o
+obj-$(CONFIG_USB_DWC3_APPLE)		+= dwc3-apple.o
 obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
 obj-$(CONFIG_USB_DWC3_EXYNOS)		+= dwc3-exynos.o
 obj-$(CONFIG_USB_DWC3_PCI)		+= dwc3-pci.o
diff --git a/drivers/usb/dwc3/dwc3-apple.c b/drivers/usb/dwc3/dwc3-apple.c
new file mode 100644
index 0000000000000000000000000000000000000000..27674f0c284104cbbe75f51cd55593a964c8c9d6
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-apple.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Apple Silicon DWC3 Glue driver
+ * Copyright (C) The Asahi Linux Contributors
+ *
+ * Based on:
+ *  - dwc3-qcom.c Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *  - dwc3-of-simple.c Copyright (c) 2015 Texas Instruments Incorporated - https://www.ti.com
+ */
+
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include "glue.h"
+
+enum dwc3_apple_mode {
+	DWC3_APPLE_OFF,
+	DWC3_APPLE_HOST,
+	DWC3_APPLE_DEVICE,
+};
+
+/**
+ * struct dwc3_apple - Apple-specific DWC3 USB controller
+ * @dwc: Core DWC3 structure
+ * @dev: Pointer to the device structure
+ * @mmio_resource: Resource to be passed to dwc3_core_probe
+ * @apple_regs: Apple-specific DWC3 registers
+ * @resets: Reset control
+ * @role_sw: USB role switch
+ * @lock: Mutex for synchronizing access
+ * @core_probe_done: True if dwc3_core_probe was already called after the first plug
+ * @mode: Current mode of the controller (off/host/device)
+ */
+struct dwc3_apple {
+	struct dwc3 dwc;
+
+	struct device *dev;
+	struct resource *mmio_resource;
+	void __iomem *apple_regs;
+
+	struct reset_control *resets;
+	struct usb_role_switch *role_sw;
+
+	struct mutex lock;
+
+	bool core_probe_done;
+	enum dwc3_apple_mode mode;
+};
+
+#define to_dwc3_apple(d) container_of((d), struct dwc3_apple, dwc)
+
+/*
+ * Apple Silicon dwc3 vendor-specific registers
+ *
+ * These registers were identified by tracing XNU's memory access patterns
+ * and correlating them with debug output over serial to determine their names.
+ * We don't exactly know what these do but without these USB3 devices sometimes
+ * don't work.
+ */
+#define APPLE_DWC3_REGS_START 0xcd00
+#define APPLE_DWC3_REGS_END 0xcdff
+
+#define APPLE_DWC3_CIO_LFPS_OFFSET 0xcd38
+#define APPLE_DWC3_CIO_LFPS_OFFSET_VALUE 0xf800f80
+
+#define APPLE_DWC3_CIO_BW_NGT_OFFSET 0xcd3c
+#define APPLE_DWC3_CIO_BW_NGT_OFFSET_VALUE 0xfc00fc0
+
+#define APPLE_DWC3_CIO_LINK_TIMER 0xcd40
+#define APPLE_DWC3_CIO_PENDING_HP_TIMER GENMASK(23, 16)
+#define APPLE_DWC3_CIO_PENDING_HP_TIMER_VALUE 0x14
+#define APPLE_DWC3_CIO_PM_LC_TIMER GENMASK(15, 8)
+#define APPLE_DWC3_CIO_PM_LC_TIMER_VALUE 0xa
+#define APPLE_DWC3_CIO_PM_ENTRY_TIMER GENMASK(7, 0)
+#define APPLE_DWC3_CIO_PM_ENTRY_TIMER_VALUE 0x10
+
+static inline void dwc3_apple_writel(struct dwc3_apple *appledwc, u32 offset, u32 value)
+{
+	writel(value, appledwc->apple_regs + offset - APPLE_DWC3_REGS_START);
+}
+
+static inline u32 dwc3_apple_readl(struct dwc3_apple *appledwc, u32 offset)
+{
+	return readl(appledwc->apple_regs + offset - APPLE_DWC3_REGS_START);
+}
+
+static inline void dwc3_apple_mask(struct dwc3_apple *appledwc, u32 offset, u32 mask, u32 value)
+{
+	u32 reg;
+
+	reg = dwc3_apple_readl(appledwc, offset);
+	reg &= ~mask;
+	reg |= value;
+	dwc3_apple_writel(appledwc, offset, reg);
+}
+
+static void dwc3_apple_setup_cio(struct dwc3_apple *appledwc)
+{
+	dwc3_apple_writel(appledwc, APPLE_DWC3_CIO_LFPS_OFFSET, APPLE_DWC3_CIO_LFPS_OFFSET_VALUE);
+	dwc3_apple_writel(appledwc, APPLE_DWC3_CIO_BW_NGT_OFFSET,
+			  APPLE_DWC3_CIO_BW_NGT_OFFSET_VALUE);
+	dwc3_apple_mask(appledwc, APPLE_DWC3_CIO_LINK_TIMER, APPLE_DWC3_CIO_PENDING_HP_TIMER,
+			APPLE_DWC3_CIO_PENDING_HP_TIMER_VALUE);
+	dwc3_apple_mask(appledwc, APPLE_DWC3_CIO_LINK_TIMER, APPLE_DWC3_CIO_PM_LC_TIMER,
+			APPLE_DWC3_CIO_PM_LC_TIMER_VALUE);
+	dwc3_apple_mask(appledwc, APPLE_DWC3_CIO_LINK_TIMER, APPLE_DWC3_CIO_PM_ENTRY_TIMER,
+			APPLE_DWC3_CIO_PM_ENTRY_TIMER_VALUE);
+}
+
+static void dwc3_apple_set_ptrcap(struct dwc3_apple *appledwc, u32 mode)
+{
+	guard(spinlock_irqsave)(&appledwc->dwc.lock);
+	dwc3_set_prtcap(&appledwc->dwc, mode, false);
+}
+
+static int dwc3_apple_core_probe(struct dwc3_apple *appledwc)
+{
+	struct dwc3_probe_data probe_data = {};
+	int ret;
+
+	lockdep_assert_held(&appledwc->lock);
+	WARN_ON_ONCE(appledwc->core_probe_done);
+
+	appledwc->dwc.dev = appledwc->dev;
+	probe_data.dwc = &appledwc->dwc;
+	probe_data.res = appledwc->mmio_resource;
+	probe_data.ignore_clocks_and_resets = true;
+	probe_data.skip_core_init_mode = true;
+
+	ret = dwc3_core_probe(&probe_data);
+	if (ret)
+		return ret;
+
+	appledwc->core_probe_done = true;
+	return 0;
+}
+
+static int dwc3_apple_core_init(struct dwc3_apple *appledwc)
+{
+	int ret;
+
+	lockdep_assert_held(&appledwc->lock);
+
+	if (appledwc->core_probe_done) {
+		ret = dwc3_core_init(&appledwc->dwc);
+		if (ret)
+			dev_err(appledwc->dev, "Failed to initialize DWC3 Core, err=%d\n", ret);
+	} else {
+		ret = dwc3_apple_core_probe(appledwc);
+		if (ret)
+			dev_err(appledwc->dev, "Failed to probe DWC3 Core, err=%d\n", ret);
+	}
+
+	return ret;
+}
+
+static void dwc3_apple_phy_set_mode(struct dwc3_apple *appledwc, enum phy_mode mode)
+{
+	lockdep_assert_held(&appledwc->lock);
+
+	/*
+	 * This platform requires SUSPHY to be enabled here already in order to properly
+	 * configure the PHY
+	 */
+	dwc3_enable_susphy(&appledwc->dwc, true);
+	phy_set_mode(appledwc->dwc.usb2_generic_phy[0], mode);
+	phy_set_mode(appledwc->dwc.usb3_generic_phy[0], mode);
+}
+
+static int dwc3_apple_init(struct dwc3_apple *appledwc, enum dwc3_apple_mode mode)
+{
+	int ret, ret_reset;
+
+	lockdep_assert_held(&appledwc->lock);
+
+	ret = reset_control_deassert(appledwc->resets);
+	if (ret) {
+		dev_err(appledwc->dev, "Failed to deassert resets, err=%d\n", ret);
+		return ret;
+	}
+
+	ret = dwc3_apple_core_init(appledwc);
+	if (ret)
+		goto reset_assert;
+
+	/*
+	 * Now that the core is initialized and already went through dwc3_core_soft_reset we can
+	 * configure some unknown Apple-specific settings.
+	 */
+	dwc3_apple_setup_cio(appledwc);
+
+	switch (mode) {
+	case DWC3_APPLE_HOST:
+		appledwc->dwc.dr_mode = USB_DR_MODE_HOST;
+		dwc3_apple_set_ptrcap(appledwc, DWC3_GCTL_PRTCAP_HOST);
+		dwc3_apple_phy_set_mode(appledwc, PHY_MODE_USB_HOST);
+		ret = dwc3_host_init(&appledwc->dwc);
+		if (ret) {
+			dev_err(appledwc->dev, "Failed to initialize host, ret=%d\n", ret);
+			goto core_exit;
+		}
+
+		break;
+	case DWC3_APPLE_DEVICE:
+		appledwc->dwc.dr_mode = USB_DR_MODE_PERIPHERAL;
+		dwc3_apple_set_ptrcap(appledwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_apple_phy_set_mode(appledwc, PHY_MODE_USB_DEVICE);
+		ret = dwc3_gadget_init(&appledwc->dwc);
+		if (ret) {
+			dev_err(appledwc->dev, "Failed to initialize gadget, ret=%d\n", ret);
+			goto core_exit;
+		}
+		break;
+	default:
+		/* Unreachable unless there's a bug in this driver */
+		WARN_ON_ONCE(1);
+		ret = -EINVAL;
+		goto core_exit;
+	}
+
+	appledwc->mode = mode;
+	return 0;
+
+core_exit:
+	dwc3_core_exit(&appledwc->dwc);
+reset_assert:
+	ret_reset = reset_control_assert(appledwc->resets);
+	if (ret_reset)
+		dev_warn(appledwc->dev, "Failed to assert resets, err=%d\n", ret_reset);
+
+	return ret;
+}
+
+static int dwc3_apple_exit(struct dwc3_apple *appledwc)
+{
+	int ret = 0;
+
+	lockdep_assert_held(&appledwc->lock);
+
+	switch (appledwc->mode) {
+	case DWC3_APPLE_OFF:
+		/* Nothing to do if we're already off */
+		return 0;
+	case DWC3_APPLE_DEVICE:
+		dwc3_gadget_exit(&appledwc->dwc);
+		break;
+	case DWC3_APPLE_HOST:
+		dwc3_host_exit(&appledwc->dwc);
+		break;
+	}
+
+	/* This platform requires SUSPHY to be enabled in order to properly power down the PHY */
+	dwc3_enable_susphy(&appledwc->dwc, true);
+	dwc3_core_exit(&appledwc->dwc);
+	appledwc->mode = DWC3_APPLE_OFF;
+
+	ret = reset_control_assert(appledwc->resets);
+	if (ret) {
+		dev_err(appledwc->dev, "Failed to assert resets, err=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dwc3_usb_role_switch_set(struct usb_role_switch *sw, enum usb_role role)
+{
+	struct dwc3_apple *appledwc = usb_role_switch_get_drvdata(sw);
+	int ret;
+
+	guard(mutex)(&appledwc->lock);
+
+	/*
+	 * The USB2 D+/D- lines are connected through a stateful eUSB2 repeater which in turn is
+	 * controlled by a variant of the TI TPS6598x USB PD chip. When the USB PD controller
+	 * detects a hotplug event it resets the eUSB2 repeater. Afterwards, no new device is
+	 * recognized before the DWC3 core and PHY are reset as well because the eUSB2 repeater
+	 * and the PHY/dwc3 block disagree about the current state.
+	 * Additionally, the PHY is also incapable of switching between arbitrary modes when dwc3
+	 * is kept online. It's also possible to get dwc3 into a state where no new device is
+	 * recognized and even a soft reset is not enough to recover when unplugging a cable at the
+	 * wrong time while in gadget mode. Only a hard reset triggered via the external reset line
+	 * is able to recover from this state.
+	 * We thus tear all of dwc3 down here and re-initialize it every time we get a plug change
+	 * (or even mode change) event.
+	 */
+	ret = dwc3_apple_exit(appledwc);
+	if (ret)
+		return ret;
+
+	switch (role) {
+	case USB_ROLE_NONE:
+		/* Nothing to do if no cable is connected */
+		return 0;
+	case USB_ROLE_HOST:
+		return dwc3_apple_init(appledwc, DWC3_APPLE_HOST);
+	case USB_ROLE_DEVICE:
+		return dwc3_apple_init(appledwc, DWC3_APPLE_DEVICE);
+	default:
+		dev_err(appledwc->dev, "Invalid target role: %d\n", role);
+		return -EINVAL;
+	}
+}
+
+static enum usb_role dwc3_usb_role_switch_get(struct usb_role_switch *sw)
+{
+	struct dwc3_apple *appledwc = usb_role_switch_get_drvdata(sw);
+
+	guard(mutex)(&appledwc->lock);
+
+	switch (appledwc->mode) {
+	case DWC3_APPLE_HOST:
+		return USB_ROLE_HOST;
+	case DWC3_APPLE_DEVICE:
+		return USB_ROLE_DEVICE;
+	case DWC3_APPLE_OFF:
+		return USB_ROLE_NONE;
+	default:
+		/* Unreachable unless there's a bug in this driver */
+		WARN_ON_ONCE(1);
+		return USB_ROLE_NONE;
+	}
+}
+
+static int dwc3_apple_setup_role_switch(struct dwc3_apple *appledwc)
+{
+	struct usb_role_switch_desc dwc3_role_switch = { NULL };
+
+	dwc3_role_switch.fwnode = dev_fwnode(appledwc->dev);
+	dwc3_role_switch.set = dwc3_usb_role_switch_set;
+	dwc3_role_switch.get = dwc3_usb_role_switch_get;
+	dwc3_role_switch.driver_data = appledwc;
+	appledwc->role_sw = usb_role_switch_register(appledwc->dev, &dwc3_role_switch);
+	if (IS_ERR(appledwc->role_sw))
+		return PTR_ERR(appledwc->role_sw);
+
+	return 0;
+}
+
+static int dwc3_apple_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dwc3_apple *appledwc;
+	int ret;
+
+	appledwc = devm_kzalloc(&pdev->dev, sizeof(*appledwc), GFP_KERNEL);
+	if (!appledwc)
+		return -ENOMEM;
+
+	appledwc->dev = &pdev->dev;
+	mutex_init(&appledwc->lock);
+
+	appledwc->resets = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR(appledwc->resets))
+		return dev_err_probe(&pdev->dev, PTR_ERR(appledwc->resets),
+				     "Failed to get resets\n");
+
+	ret = reset_control_assert(appledwc->resets);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to assert resets, err=%d\n", ret);
+		return ret;
+	}
+
+	appledwc->mmio_resource = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dwc3-core");
+	if (!appledwc->mmio_resource) {
+		dev_err(dev, "Failed to get DWC3 MMIO\n");
+		return -EINVAL;
+	}
+
+	appledwc->apple_regs = devm_platform_ioremap_resource_byname(pdev, "dwc3-apple");
+	if (IS_ERR(appledwc->apple_regs))
+		return dev_err_probe(dev, PTR_ERR(appledwc->apple_regs),
+				     "Failed to map Apple-specific MMIO\n");
+
+	/*
+	 * Note that we only bring up dwc3 once the first device is attached because we need to know
+	 * the role (e.g. host), mode (e.g. USB3) and lane orientation to bring up the PHY which is
+	 * tightly coupled to dwc3.
+	 */
+	appledwc->mode = DWC3_APPLE_OFF;
+	appledwc->core_probe_done = false;
+	ret = dwc3_apple_setup_role_switch(appledwc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to setup role switch\n");
+
+	return 0;
+}
+
+static void dwc3_apple_remove(struct platform_device *pdev)
+{
+	struct dwc3 *dwc = platform_get_drvdata(pdev);
+	struct dwc3_apple *appledwc = to_dwc3_apple(dwc);
+
+	guard(mutex)(&appledwc->lock);
+
+	usb_role_switch_unregister(appledwc->role_sw);
+
+	dwc3_apple_exit(appledwc);
+	if (appledwc->core_probe_done)
+		dwc3_core_remove(&appledwc->dwc);
+}
+
+static const struct of_device_id dwc3_apple_of_match[] = {
+	{ .compatible = "apple,t8103-dwc3" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, dwc3_apple_of_match);
+
+static struct platform_driver dwc3_apple_driver = {
+	.probe		= dwc3_apple_probe,
+	.remove		= dwc3_apple_remove,
+	.driver		= {
+		.name	= "dwc3-apple",
+		.of_match_table	= dwc3_apple_of_match,
+	},
+};
+
+module_platform_driver(dwc3_apple_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sven Peter <sven@kernel.org>");
+MODULE_DESCRIPTION("DesignWare DWC3 Apple Silicon Glue Driver");

-- 
2.34.1



