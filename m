Return-Path: <linux-kernel+bounces-803974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B85CEB46827
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872FD188BECC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB76C1A0BFD;
	Sat,  6 Sep 2025 01:49:06 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD31DE8BF;
	Sat,  6 Sep 2025 01:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757123346; cv=none; b=Oj7zu/7FvJQZl+RgITUVnKaW0+HgT9PrcqK8H0V0HmBCFBioEK1OKalrXsB/MvgPcg3mxxxO6ozmFxXwjV7aM7p6LsRTmBFyIlDIgBa1ylf/3mCnodx9Qh/LQ3HtrMTSwJuhGA0ECaYoTyU1vVwJWm68hqGmW3kdPeHrEQ9N7SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757123346; c=relaxed/simple;
	bh=Dv8RWtAGXVai4jLnn5kg93giQ+Fw7LvlkApU1McGVMs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipov6LjFEa4dVrvnjsB4Zlp9VLkhDGZecl1gswBKC64B5nVyKB3NGGK4cZuViHC5RVQ3cXOYZub9oOC7N1GCH9f8tnsChH44Liv1OkP93tzjhuZNw9Z6JvZSs2aeTbze9MFz4JXEOLx5bF7+GMZRB92I7/Umwwjh96lpbL4+VlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sat, 6 Sep
 2025 09:48:46 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sat, 6 Sep 2025 09:48:46 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SCU interrupt controllers
Date: Sat, 6 Sep 2025 09:48:46 +0800
Message-ID: <20250906014846.861368-5-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906014846.861368-1-ryan_chen@aspeedtech.com>
References: <20250906014846.861368-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The AST2700 continues the multi-instance SCU interrupt controller model
introduced in the AST2600, with four independent interrupt domains
(scu-ic0 to 3).

Unlike earlier generations that combine interrupt enable and status bits
into a single register, the AST2700 separates these into distinct IER and
ISR registers. Support for this layout is implemented by using register
offsets and separate chained IRQ handlers.

The variant table is extended to cover AST2700 IC instances, enabling
shared initialization logic while preserving support for previous SoCs.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/irqchip/irq-aspeed-scu-ic.c | 119 +++++++++++++++++++++++-----
 1 file changed, 101 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index 24d3d3fa5c4b..8c2df72353be 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Aspeed AST24XX, AST25XX, and AST26XX SCU Interrupt Controller
+ * Aspeed AST24XX, AST25XX, AST26XX, and AST27XX SCU Interrupt Controller
  * Copyright 2019 IBM Corporation
  *
  * Eddie James <eajames@linux.ibm.com>
@@ -17,26 +17,37 @@
 
 #define ASPEED_SCU_IC_STATUS		GENMASK(28, 16)
 #define ASPEED_SCU_IC_STATUS_SHIFT	16
+#define AST2700_SCU_IC_STATUS		GENMASK(15, 0)
 
 struct aspeed_scu_ic_variant {
 	const char		*compatible;
 	unsigned long	irq_enable;
 	unsigned long	irq_shift;
 	unsigned int	num_irqs;
+	bool		split_ier_isr;
+	unsigned long	ier;
+	unsigned long	isr;
 };
 
-#define SCU_VARIANT(_compat, _shift, _enable, _num) { \
+#define SCU_VARIANT(_compat, _shift, _enable, _num, _split, _ier, _isr) { \
 	.compatible		=	_compat,	\
 	.irq_shift		=	_shift,		\
 	.irq_enable		=	_enable,	\
 	.num_irqs		=	_num,		\
+	.split_ier_isr		=	_split,		\
+	.ier			=	_ier,		\
+	.isr			=	_isr,		\
 }
 
 static const struct aspeed_scu_ic_variant scu_ic_variants[]	__initconst = {
-	SCU_VARIANT("aspeed,ast2400-scu-ic",	0,	GENMASK(15, 0),	7),
-	SCU_VARIANT("aspeed,ast2500-scu-ic",	0,	GENMASK(15, 0), 7),
-	SCU_VARIANT("aspeed,ast2600-scu-ic0",	0,	GENMASK(5, 0),	6),
-	SCU_VARIANT("aspeed,ast2600-scu-ic1",	4,	GENMASK(5, 4),	2),
+	SCU_VARIANT("aspeed,ast2400-scu-ic",	0, GENMASK(15, 0),	7, false,	0,	0),
+	SCU_VARIANT("aspeed,ast2500-scu-ic",	0, GENMASK(15, 0),	7, false,	0,	0),
+	SCU_VARIANT("aspeed,ast2600-scu-ic0",	0, GENMASK(5, 0),	6, false,	0,	0),
+	SCU_VARIANT("aspeed,ast2600-scu-ic1",	4, GENMASK(5, 4),	2, false,	0,	0),
+	SCU_VARIANT("aspeed,ast2700-scu-ic0",	0, GENMASK(3, 0),	4, true,	0x00, 0x04),
+	SCU_VARIANT("aspeed,ast2700-scu-ic1",	0, GENMASK(3, 0),	4, true,	0x00, 0x04),
+	SCU_VARIANT("aspeed,ast2700-scu-ic2",	0, GENMASK(3, 0),	4, true,	0x04, 0x00),
+	SCU_VARIANT("aspeed,ast2700-scu-ic3",	0, GENMASK(1, 0),	2, true,	0x04, 0x00),
 };
 
 struct aspeed_scu_ic {
@@ -45,9 +56,12 @@ struct aspeed_scu_ic {
 	unsigned int		num_irqs;
 	void __iomem		*base;
 	struct irq_domain	*irq_domain;
+	bool			split_ier_isr;
+	unsigned long		ier;
+	unsigned long		isr;
 };
 
-static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
+static void aspeed_scu_ic_irq_handler_combined(struct irq_desc *desc)
 {
 	struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -84,7 +98,33 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void aspeed_scu_ic_irq_mask(struct irq_data *data)
+static void aspeed_scu_ic_irq_handler_split(struct irq_desc *desc)
+{
+	struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long bit, enabled, max, status;
+	unsigned int sts, mask;
+
+	chained_irq_enter(chip, desc);
+
+	mask = scu_ic->irq_enable;
+	sts = readl(scu_ic->base + scu_ic->isr);
+	enabled = sts & scu_ic->irq_enable;
+	sts = readl(scu_ic->base + scu_ic->isr);
+	status = sts & enabled;
+
+	bit = scu_ic->irq_shift;
+	max = scu_ic->num_irqs + bit;
+
+	for_each_set_bit_from(bit, &status, max) {
+		generic_handle_domain_irq(scu_ic->irq_domain, bit - scu_ic->irq_shift);
+		writel(BIT(bit), scu_ic->base + scu_ic->isr); // clear interrupt
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void aspeed_scu_ic_irq_mask_combined(struct irq_data *data)
 {
 	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
 	unsigned int mask = BIT(data->hwirq + scu_ic->irq_shift) |
@@ -98,7 +138,7 @@ static void aspeed_scu_ic_irq_mask(struct irq_data *data)
 	writel(readl(scu_ic->base) & ~mask, scu_ic->base);
 }
 
-static void aspeed_scu_ic_irq_unmask(struct irq_data *data)
+static void aspeed_scu_ic_irq_unmask_combined(struct irq_data *data)
 {
 	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
 	unsigned int bit = BIT(data->hwirq + scu_ic->irq_shift);
@@ -113,6 +153,22 @@ static void aspeed_scu_ic_irq_unmask(struct irq_data *data)
 	writel((readl(scu_ic->base) & ~mask) | bit, scu_ic->base);
 }
 
+static void aspeed_scu_ic_irq_mask_split(struct irq_data *data)
+{
+	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
+
+	writel(readl(scu_ic->base) & ~BIT(data->hwirq + scu_ic->irq_shift),
+	       scu_ic->base + scu_ic->ier);
+}
+
+static void aspeed_scu_ic_irq_unmask_split(struct irq_data *data)
+{
+	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
+	unsigned int bit = BIT(data->hwirq + scu_ic->irq_shift);
+
+	writel(readl(scu_ic->base) | bit, scu_ic->base + scu_ic->ier);
+}
+
 static int aspeed_scu_ic_irq_set_affinity(struct irq_data *data,
 					  const struct cpumask *dest,
 					  bool force)
@@ -120,17 +176,29 @@ static int aspeed_scu_ic_irq_set_affinity(struct irq_data *data,
 	return -EINVAL;
 }
 
-static struct irq_chip aspeed_scu_ic_chip = {
-	.name			= "aspeed-scu-ic",
-	.irq_mask		= aspeed_scu_ic_irq_mask,
-	.irq_unmask		= aspeed_scu_ic_irq_unmask,
-	.irq_set_affinity	= aspeed_scu_ic_irq_set_affinity,
+static struct irq_chip aspeed_scu_ic_chip_combined = {
+	.name                   = "aspeed-scu-ic",
+	.irq_mask               = aspeed_scu_ic_irq_mask_combined,
+	.irq_unmask             = aspeed_scu_ic_irq_unmask_combined,
+	.irq_set_affinity       = aspeed_scu_ic_irq_set_affinity,
+};
+
+static struct irq_chip aspeed_scu_ic_chip_split = {
+	.name                   = "ast2700-scu-ic",
+	.irq_mask               = aspeed_scu_ic_irq_mask_split,
+	.irq_unmask             = aspeed_scu_ic_irq_unmask_split,
+	.irq_set_affinity       = aspeed_scu_ic_irq_set_affinity,
 };
 
 static int aspeed_scu_ic_map(struct irq_domain *domain, unsigned int irq,
 			     irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &aspeed_scu_ic_chip, handle_level_irq);
+	struct aspeed_scu_ic *scu_ic = domain->host_data;
+
+	if (scu_ic->split_ier_isr)
+		irq_set_chip_and_handler(irq, &aspeed_scu_ic_chip_split, handle_level_irq);
+	else
+		irq_set_chip_and_handler(irq, &aspeed_scu_ic_chip_combined, handle_level_irq);
 	irq_set_chip_data(irq, domain->host_data);
 
 	return 0;
@@ -151,8 +219,14 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 		rc = PTR_ERR(scu_ic->base);
 		goto err;
 	}
-	writel(ASPEED_SCU_IC_STATUS, scu_ic->base);
-	writel(0, scu_ic->base);
+
+	if (scu_ic->split_ier_isr) {
+		writel(AST2700_SCU_IC_STATUS, scu_ic->base + scu_ic->isr);
+		writel(0, scu_ic->base + scu_ic->ier);
+	} else {
+		writel(ASPEED_SCU_IC_STATUS, scu_ic->base);
+		writel(0, scu_ic->base);
+	}
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (!irq) {
@@ -167,7 +241,9 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 		goto err;
 	}
 
-	irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler,
+	irq_set_chained_handler_and_data(irq, scu_ic->split_ier_isr ?
+					 aspeed_scu_ic_irq_handler_split :
+					 aspeed_scu_ic_irq_handler_combined,
 					 scu_ic);
 
 	return 0;
@@ -205,6 +281,9 @@ static int __init aspeed_scu_ic_of_init(struct device_node *node, struct device_
 	scu_ic->irq_enable	= variant->irq_enable;
 	scu_ic->irq_shift	= variant->irq_shift;
 	scu_ic->num_irqs	= variant->num_irqs;
+	scu_ic->split_ier_isr	= variant->split_ier_isr;
+	scu_ic->ier	= variant->ier;
+	scu_ic->isr	= variant->isr;
 
 	return aspeed_scu_ic_of_init_common(scu_ic, node);
 }
@@ -213,3 +292,7 @@ IRQCHIP_DECLARE(ast2400_scu_ic, "aspeed,ast2400-scu-ic", aspeed_scu_ic_of_init);
 IRQCHIP_DECLARE(ast2500_scu_ic, "aspeed,ast2500-scu-ic", aspeed_scu_ic_of_init);
 IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0", aspeed_scu_ic_of_init);
 IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1", aspeed_scu_ic_of_init);
+IRQCHIP_DECLARE(ast2700_scu_ic0, "aspeed,ast2700-scu-ic0", aspeed_scu_ic_of_init);
+IRQCHIP_DECLARE(ast2700_scu_ic1, "aspeed,ast2700-scu-ic1", aspeed_scu_ic_of_init);
+IRQCHIP_DECLARE(ast2700_scu_ic2, "aspeed,ast2700-scu-ic2", aspeed_scu_ic_of_init);
+IRQCHIP_DECLARE(ast2700_scu_ic3, "aspeed,ast2700-scu-ic3", aspeed_scu_ic_of_init);
-- 
2.34.1


