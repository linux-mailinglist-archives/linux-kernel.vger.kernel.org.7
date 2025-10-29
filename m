Return-Path: <linux-kernel+bounces-876670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDB6C1BFF3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28191188419B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F753358C8;
	Wed, 29 Oct 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vL3wKFOI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B522F25E0;
	Wed, 29 Oct 2025 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754298; cv=none; b=A1NRlftlOsWZWSJlGW3a8fXwTu2b4rlkMb15XqeVVu3x3XXenAdCVT2GWA37g8FTbUPpLsuhR4Rgr5esLpRkvPM3hY1do9lZUJeViM7piYMVfs6CIRamd2MM89EuNYkSbReY98/8CXz3cgAT1ma6hWQ65Mx1pJHfmqBmerEU5X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754298; c=relaxed/simple;
	bh=SBPUsQQts6myI7KNC8yymj9GqGzDulDYvcTpau9/ALk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUwY9wnm8x1Mc228oaElWjMc8KYN4KZU6wMcR5qKfN2MTv2Ym0CTnkdse+kvp2frojq+knfB9FIheFDuUp4pIxReRcZmNz4zTuGzPGjbm7wj592+0pBP64jPBreahiKJ/ePcwXW7ByJ6UlYGxuCECFo/R09GtXqgwD3Jgq0AgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vL3wKFOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50589C4CEF7;
	Wed, 29 Oct 2025 16:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761754298;
	bh=SBPUsQQts6myI7KNC8yymj9GqGzDulDYvcTpau9/ALk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vL3wKFOIoq91uTTR96HuBCNCR0G7LITKAB33GwdtWlZeoGAyn+DRgPe0glvKcknJq
	 M9dMTaEPAloeCsn6TK7lZM9RlOw7cUNUGcpknMdVf+CSTmLtZTHZjnDHZ5+KZWA8Jv
	 e0VsXgB/8ulVgFyGI+viPeK1eZw66zUZaL4ZsnL34lkm/2q7H83ZUE0gXJCfSAUbZU
	 QTJ2p9BZGr+TaXt1s0YcydKPPTW0I8OtPD0HnRh6m66XQCO1B20aARMNxTKscYWj/9
	 hKRJN5h/fHLcopvATVbruTVkBSHhP8STh4N2SZh3s+wSpQ6gDjyLDLxscXROACoR8V
	 d3FiA4wXgiqzQ==
From: Conor Dooley <conor@kernel.org>
To: claudiu.beznea@tuxon.dev
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/7] reset: mpfs: add non-auxiliary bus probing
Date: Wed, 29 Oct 2025 16:11:17 +0000
Message-ID: <20251029-macarena-neglector-318431fec367@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
References: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6690; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=WjSYxPHoiecG3YZVCMCzeZtGrY72vr6u1gmlrYkaGJE=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlMNusucCmdWFN9dEqkWdThu5L3a33SHX3fBXR6vp3+K bros658RykLgxgXg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACby6TcjQ/sq8czfXZ9/R5SZ +MfoHvu39vKcGU3K8g/llG8w7PoZtJCR4ccnFW6d3HN9xX3FZs84N9Z/8HoSZTn1yqxZV4psHsS t4wIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

While the auxiliary bus was a nice bandaid, and meant that re-writing
the representation of the clock regions in devicetree was not required,
it has run its course. The "mss_top_sysreg" region that contains the
clock and reset regions, also contains pinctrl and an interrupt
controller, so the time has come rewrite the devicetree and probe the
reset controller from an mfd devicetree node, rather than implement
those drivers using the auxiliary bus. Wanting to avoid propagating this
naive/incorrect description of the hardware to the new pic64gx SoC is a
major motivating factor here.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v6:
- depend on MFD_SYSCON
- return regmap_update_bits() result directly instead of an additional
  return 0

v4:
- Only use driver specific lock for non-regmap writes

v2:
- Implement the request to use regmap_update_bits(). I found that I then
  hated the read/write helpers since they were just bloat, so I ripped
  them out. I replaced the regular spin_lock_irqsave() stuff with a
  guard(spinlock_irqsave), since that's a simpler way of handling the two
  different paths through such a trivial pair of functions.
---
 drivers/reset/Kconfig      |  1 +
 drivers/reset/reset-mpfs.c | 79 ++++++++++++++++++++++++++++++--------
 2 files changed, 63 insertions(+), 17 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 78b7078478d4..0ec4b7cd08d6 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -200,6 +200,7 @@ config RESET_PISTACHIO
 config RESET_POLARFIRE_SOC
 	bool "Microchip PolarFire SoC (MPFS) Reset Driver"
 	depends on MCHP_CLK_MPFS
+	depends on MFD_SYSCON
 	select AUXILIARY_BUS
 	default MCHP_CLK_MPFS
 	help
diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
index f6fa10e03ea8..25de7df55301 100644
--- a/drivers/reset/reset-mpfs.c
+++ b/drivers/reset/reset-mpfs.c
@@ -7,13 +7,16 @@
  *
  */
 #include <linux/auxiliary_bus.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
+#include <linux/regmap.h>
 #include <linux/reset-controller.h>
+#include <linux/slab.h>
 #include <dt-bindings/clock/microchip,mpfs-clock.h>
 #include <soc/microchip/mpfs.h>
 
@@ -27,11 +30,14 @@
 #define MPFS_SLEEP_MIN_US	100
 #define MPFS_SLEEP_MAX_US	200
 
+#define REG_SUBBLK_RESET_CR	0x88u
+
 /* block concurrent access to the soft reset register */
 static DEFINE_SPINLOCK(mpfs_reset_lock);
 
 struct mpfs_reset {
 	void __iomem *base;
+	struct regmap *regmap;
 	struct reset_controller_dev rcdev;
 };
 
@@ -46,41 +52,46 @@ static inline struct mpfs_reset *to_mpfs_reset(struct reset_controller_dev *rcde
 static int mpfs_assert(struct reset_controller_dev *rcdev, unsigned long id)
 {
 	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
-	unsigned long flags;
 	u32 reg;
 
-	spin_lock_irqsave(&mpfs_reset_lock, flags);
+	if (rst->regmap)
+		return regmap_update_bits(rst->regmap, REG_SUBBLK_RESET_CR, BIT(id), BIT(id));
+
+	guard(spinlock_irqsave)(&mpfs_reset_lock);
 
 	reg = readl(rst->base);
 	reg |= BIT(id);
 	writel(reg, rst->base);
 
-	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
-
 	return 0;
 }
 
 static int mpfs_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 {
 	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
-	unsigned long flags;
 	u32 reg;
 
-	spin_lock_irqsave(&mpfs_reset_lock, flags);
+	if (rst->regmap)
+		return regmap_update_bits(rst->regmap, REG_SUBBLK_RESET_CR, BIT(id), 0);
+
+	guard(spinlock_irqsave)(&mpfs_reset_lock);
 
 	reg = readl(rst->base);
 	reg &= ~BIT(id);
 	writel(reg, rst->base);
 
-	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
-
 	return 0;
 }
 
 static int mpfs_status(struct reset_controller_dev *rcdev, unsigned long id)
 {
 	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
-	u32 reg = readl(rst->base);
+	u32 reg;
+
+	if (rst->regmap)
+		regmap_read(rst->regmap, REG_SUBBLK_RESET_CR, &reg);
+	else
+		reg = readl(rst->base);
 
 	/*
 	 * It is safe to return here as MPFS_NUM_RESETS makes sure the sign bit
@@ -130,11 +141,45 @@ static int mpfs_reset_xlate(struct reset_controller_dev *rcdev,
 	return index - MPFS_PERIPH_OFFSET;
 }
 
-static int mpfs_reset_probe(struct auxiliary_device *adev,
-			    const struct auxiliary_device_id *id)
+static int mpfs_reset_mfd_probe(struct platform_device *pdev)
 {
-	struct device *dev = &adev->dev;
 	struct reset_controller_dev *rcdev;
+	struct device *dev = &pdev->dev;
+	struct mpfs_reset *rst;
+
+	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
+	if (!rst)
+		return -ENOMEM;
+
+	rcdev = &rst->rcdev;
+	rcdev->dev = dev;
+	rcdev->ops = &mpfs_reset_ops;
+
+	rcdev->of_node = pdev->dev.parent->of_node;
+	rcdev->of_reset_n_cells = 1;
+	rcdev->of_xlate = mpfs_reset_xlate;
+	rcdev->nr_resets = MPFS_NUM_RESETS;
+
+	rst->regmap = device_node_to_regmap(pdev->dev.parent->of_node);
+	if (IS_ERR(rst->regmap))
+		dev_err_probe(dev, PTR_ERR(rst->regmap), "Failed to find syscon regmap\n");
+
+	return devm_reset_controller_register(dev, rcdev);
+}
+
+static struct platform_driver mpfs_reset_mfd_driver = {
+	.probe		= mpfs_reset_mfd_probe,
+	.driver = {
+		.name = "mpfs-reset",
+	},
+};
+module_platform_driver(mpfs_reset_mfd_driver);
+
+static int mpfs_reset_adev_probe(struct auxiliary_device *adev,
+				 const struct auxiliary_device_id *id)
+{
+	struct reset_controller_dev *rcdev;
+	struct device *dev = &adev->dev;
 	struct mpfs_reset *rst;
 
 	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
@@ -145,8 +190,8 @@ static int mpfs_reset_probe(struct auxiliary_device *adev,
 
 	rcdev = &rst->rcdev;
 	rcdev->dev = dev;
-	rcdev->dev->parent = dev->parent;
 	rcdev->ops = &mpfs_reset_ops;
+
 	rcdev->of_node = dev->parent->of_node;
 	rcdev->of_reset_n_cells = 1;
 	rcdev->of_xlate = mpfs_reset_xlate;
@@ -176,12 +221,12 @@ static const struct auxiliary_device_id mpfs_reset_ids[] = {
 };
 MODULE_DEVICE_TABLE(auxiliary, mpfs_reset_ids);
 
-static struct auxiliary_driver mpfs_reset_driver = {
-	.probe		= mpfs_reset_probe,
+static struct auxiliary_driver mpfs_reset_aux_driver = {
+	.probe		= mpfs_reset_adev_probe,
 	.id_table	= mpfs_reset_ids,
 };
 
-module_auxiliary_driver(mpfs_reset_driver);
+module_auxiliary_driver(mpfs_reset_aux_driver);
 
 MODULE_DESCRIPTION("Microchip PolarFire SoC Reset Driver");
 MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
-- 
2.51.0


