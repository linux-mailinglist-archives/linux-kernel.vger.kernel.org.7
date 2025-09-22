Return-Path: <linux-kernel+bounces-827459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AD5B91D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E18E1900F10
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055F92D838E;
	Mon, 22 Sep 2025 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="QboX/JA3"
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75426B777;
	Mon, 22 Sep 2025 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552939; cv=pass; b=nk8n8Zx0Zh547IEbo+8PP9BCn/8Lb5hbejn1b6hYrgSxY2AvVHrZxF3+lOwNitbawVOwMO2/XfpNJQ1D3zvU/DcGnAm9tqH17EDNO9fuM9WOAijTN/MxcNBFt9TNXTH83oRgQg9JiNgIE3q7wUXQpixGll3hSN9cXqsQPA3YE6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552939; c=relaxed/simple;
	bh=9oDsGPNv/SAQ6fcn0oxyan9xEcehvHNYnAPzf4OFj1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q9AQ2PY6GtHtgXr9SCHuuThQzsnv7JuAw+2yBMQEm8HH7CljnaYnFF7upG9VPgoDEv2PCLzLtMGa8gkWS4qTFJQ1JSNFLiWVlh4cBhlhIxX9QaCU4huNZvj/EVuB7zX6/iX4Id5/1icUXz1uhqgJ5xLFY0sn74J7hBuy32dnyMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=QboX/JA3; arc=pass smtp.client-ip=136.143.188.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1758552910; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XKvxcm4abdNWcZtZyzkUtXCD3igf0CLyIMGzwyg7mY/wFW7Fi0fblGzDD5U77nu/Pdxf6pQseT2XiglQRDqCH6IRGn63JPct7dmWvSqdrPlZr8gLvhZ04f03gX35L3RH6JzY2X0Bm9d0ynLlTYIBaHLq2iwTFiZh0uLeqYi+JGw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758552910; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VYjqi7ZPOyzMEvVW7DcEvSzrVujGkkSlOHUUxycbCQY=; 
	b=CalENtVsiJiZkYi0HvVqFyXFntshZaSg9TWO8qE1HrtLqCzsmf64inJ9zQJ3J/KMjP3730U5D9lQz7nQIm8ijVRdyEemKom06zMUEVKFnQWih1ONYHfaD1mov0+t7xvuRKvS23ZLBOyl4f9qx0wsGTqou3CS1MKpVBvFfJf0b0w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758552910;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=VYjqi7ZPOyzMEvVW7DcEvSzrVujGkkSlOHUUxycbCQY=;
	b=QboX/JA3hbZ2Uc5PvW1nXRDZkcVmPkckO9GcCLNmLLB+OJF9NndW6KxZmr6y+VIj
	+h/ISmG2U6nKzjEzim2i9v9Dk9JGDOcSmb4LFbczKTYyq0epBIfTMBgK82YlIlZzLGe
	HWVPGpEYzieHrhEulSlvRFdbWUMoNv6fGMaGNF2s=
Received: by mx.zohomail.com with SMTPS id 1758552908801603.2694173474916;
	Mon, 22 Sep 2025 07:55:08 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 22 Sep 2025 22:51:50 +0800
Subject: [PATCH 4/5] reset: anlogic: add support for Anlogic DR1V90 resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-dr1v90-cru-v1-4-e393d758de4e@pigmoral.tech>
References: <20250922-dr1v90-cru-v1-0-e393d758de4e@pigmoral.tech>
In-Reply-To: <20250922-dr1v90-cru-v1-0-e393d758de4e@pigmoral.tech>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 "fushan.zeng" <fushan.zeng@anlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758552834; l=6149;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=9oDsGPNv/SAQ6fcn0oxyan9xEcehvHNYnAPzf4OFj1s=;
 b=W85sTOUqX951oStBEOpahvLiwEt+WR4EGC0QXkcyRr0aKWTXiOQ3mvTfyi//WI1PxsZZPf9OD
 ZRsyWGu8beDAzefHKptdv3aswXvx8VnszxabxfuiZiwI+5SY2/kjwPK
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Add reset controller support for the Anlogic DR1V90 SoC, which is an
auxiliary device associated with the Clock and Reset Unit (CRU). All
resets are active-low.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/reset/Kconfig        |   9 +++
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-dr1v90.c | 136 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 635eef469ab797ac8ef39d95a82d47071aeec630..bc7a1abb907806a1efaf568ee3dc3ca6081f667b 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -66,6 +66,15 @@ config RESET_BRCMSTB_RESCAL
 	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
 	  BCM7216 or the BCM2712.
 
+config RESET_DR1V90
+	tristate "Anlogic DR1V90 reset controller"
+	depends on ARCH_ANLOGIC || COMPILE_TEST
+	select AUXILIARY_BUS
+	default ARCH_ANLOGIC
+	help
+	  This enables the reset controller driver for Anlogic DR1V90 SoCs
+	  provided by the CRU unit.
+
 config RESET_EYEQ
 	bool "Mobileye EyeQ reset controller"
 	depends on MACH_EYEQ5 || MACH_EYEQ6H || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index a917d2522e8d12af0dd2b252e493fa4fc9eabecf..441307fd6ccd6fe0793fe819a60e66888efcb92c 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
 obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
+obj-$(CONFIG_RESET_DR1V90) += reset-dr1v90.o
 obj-$(CONFIG_RESET_EYEQ) += reset-eyeq.o
 obj-$(CONFIG_RESET_GPIO) += reset-gpio.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
diff --git a/drivers/reset/reset-dr1v90.c b/drivers/reset/reset-dr1v90.c
new file mode 100644
index 0000000000000000000000000000000000000000..914bbb9331969939f039bfb3caa6ef9d88a48b96
--- /dev/null
+++ b/drivers/reset/reset-dr1v90.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Shanghai Anlogic Infotech Co., Ltd.
+ * Copyright (c) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include "linux/device.h"
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/reset-controller.h>
+
+#include <dt-bindings/reset/anlogic,dr1v90-cru.h>
+
+struct dr1v90_reset_map {
+	u32 offset;
+	u32 bit;
+};
+
+struct dr1v90_reset_controller {
+	struct reset_controller_dev rcdev;
+	void __iomem *base;
+};
+
+static inline struct dr1v90_reset_controller *
+to_dr1v90_reset_controller(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct dr1v90_reset_controller, rcdev);
+}
+
+static const struct dr1v90_reset_map dr1v90_resets[] = {
+	[RESET_OCM]		= { 0x74, BIT(4)},
+	[RESET_QSPI]		= { 0x74, BIT(5)},
+	[RESET_SMC]		= { 0x74, BIT(6)},
+	[RESET_WDT]		= { 0x74, BIT(7)},
+	[RESET_DMAC_AXI]	= { 0x74, BIT(8)},
+	[RESET_DMAC_AHB]	= { 0x74, BIT(9)},
+	[RESET_NPU]		= { 0x74, BIT(12)},
+	[RESET_JPU]		= { 0x74, BIT(13)},
+	[RESET_DDRBUS]		= { 0x74, BIT(14)},
+	[RESET_NIC_HP0]		= { 0x78, BIT(0)},
+	[RESET_NIC_HP1]		= { 0x78, BIT(1)},
+	[RESET_NIC_GP0M]	= { 0x78, BIT(4)},
+	[RESET_NIC_GP1M]	= { 0x78, BIT(5)},
+	[RESET_GPIO]		= { 0x78, BIT(8)},
+	[RESET_IPC]		= { 0x78, BIT(12)},
+	[RESET_USB0]		= { 0x7C, BIT(0)},
+	[RESET_USB1]		= { 0x7C, BIT(1)},
+	[RESET_GBE0]		= { 0x7C, BIT(4)},
+	[RESET_GBE1]		= { 0x7C, BIT(5)},
+	[RESET_SDIO0]		= { 0x7C, BIT(8)},
+	[RESET_SDIO1]		= { 0x7C, BIT(9)},
+	[RESET_UART0]		= { 0x7C, BIT(12)},
+	[RESET_UART1]		= { 0x7C, BIT(13)},
+	[RESET_SPI0]		= { 0x7C, BIT(16)},
+	[RESET_SPI1]		= { 0x7C, BIT(17)},
+	[RESET_CAN0]		= { 0x7C, BIT(20)},
+	[RESET_CAN1]		= { 0x7C, BIT(21)},
+	[RESET_TTC0]		= { 0x7C, BIT(24)},
+	[RESET_TTC1]		= { 0x7C, BIT(25)},
+	[RESET_I2C0]		= { 0x7C, BIT(28)},
+	[RESET_I2C1]		= { 0x7C, BIT(29)}
+};
+
+static int dr1v90_reset_control_update(struct reset_controller_dev *rcdev,
+				       unsigned long id, bool assert)
+{
+	struct dr1v90_reset_controller *rstc = to_dr1v90_reset_controller(rcdev);
+	u32 offset = dr1v90_resets[id].offset;
+	u32 bit = dr1v90_resets[id].bit;
+	u32 reg;
+
+	reg = readl(rstc->base + offset);
+	if (assert)
+		reg &= ~bit;
+	else
+		reg |= bit;
+	writel(reg, rstc->base + offset);
+
+	return 0;
+}
+
+static int dr1v90_reset_control_assert(struct reset_controller_dev *rcdev,
+				       unsigned long id)
+{
+	return dr1v90_reset_control_update(rcdev, id, true);
+}
+
+static int dr1v90_reset_control_deassert(struct reset_controller_dev *rcdev,
+					 unsigned long id)
+{
+	return dr1v90_reset_control_update(rcdev, id, false);
+}
+
+static const struct reset_control_ops dr1v90_reset_control_ops = {
+	.assert = dr1v90_reset_control_assert,
+	.deassert = dr1v90_reset_control_deassert,
+};
+
+static int dr1v90_reset_probe(struct auxiliary_device *adev,
+			      const struct auxiliary_device_id *id)
+{
+	struct dr1v90_reset_controller *rstc;
+	struct device *dev = &adev->dev;
+
+	rstc = devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
+	if (!rstc)
+		return -ENOMEM;
+
+	rstc->base = of_iomap(dev->parent->of_node, 0);
+	rstc->rcdev.dev = dev;
+	rstc->rcdev.nr_resets = ARRAY_SIZE(dr1v90_resets);
+	rstc->rcdev.of_node = dev->parent->of_node;
+	rstc->rcdev.ops = &dr1v90_reset_control_ops;
+	rstc->rcdev.owner = THIS_MODULE;
+
+	return devm_reset_controller_register(dev, &rstc->rcdev);
+}
+
+static const struct auxiliary_device_id dr1v90_reset_ids[] = {
+	{
+		.name = "anlogic_dr1v90_cru.reset"
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(auxiliary, dr1v90_reset_ids);
+
+static struct auxiliary_driver dr1v90_reset_driver = {
+	.probe = dr1v90_reset_probe,
+	.id_table = dr1v90_reset_ids,
+};
+module_auxiliary_driver(dr1v90_reset_driver);
+
+MODULE_AUTHOR("Junhui Liu <junhui.liu@pigmoral.tech>");
+MODULE_DESCRIPTION("Anlogic DR1V90 reset controller driver");
+MODULE_LICENSE("GPL");

-- 
2.51.0


