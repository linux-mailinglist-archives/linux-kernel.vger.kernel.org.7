Return-Path: <linux-kernel+bounces-793227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4CFB3D0BF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 04:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3129B1A81DA5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 02:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED7321765B;
	Sun, 31 Aug 2025 02:14:59 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABABF21255B;
	Sun, 31 Aug 2025 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756606498; cv=none; b=duxKLSAwO4vTvv6uFfTEmBLwxAHP8WyRbrhMqrd9VYnITuPxAAfRsueHHvvysrqatvxzcRpe1QfTKtGE+K27SWtLPkt55/FGU37gXQs4YlMBTuV+trzDonUl1G8HHn1BB3b5BomVyGUaFRCgZYjnXybGkh0k+BW6YYObs5cNeOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756606498; c=relaxed/simple;
	bh=DuzOd379NE4e2AVcKOhoMibnDRPoyuNJ8AlG3C0MnF4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRJEKWDd7BaRIWEjd9wbZ795r3waX24pGXgPRRr59Hqa03BhBZQceSE5sYCuvmElHClCW2SeXtxO/mGXJXDU8JaggJgCarqHVISiXrLnY3tn7tgQq4/BeW8rMI3H0vh1GfB4inZmUDPd66+AGB7h3xdbugeWq3Al+pwuo46faXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 31 Aug
 2025 10:14:39 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 31 Aug 2025 10:14:39 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SCU interrupt controllers
Date: Sun, 31 Aug 2025 10:14:38 +0800
Message-ID: <20250831021438.976893-5-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
References: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
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
 drivers/irqchip/irq-aspeed-scu-ic.c | 123 +++++++++++++++++++++-------
 1 file changed, 95 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index cbfc35919281..ffdd9b4e44c1 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -17,12 +17,16 @@
 
 #define ASPEED_SCU_IC_STATUS		GENMASK(28, 16)
 #define ASPEED_SCU_IC_STATUS_SHIFT	16
+#define AST2700_SCU_IC_STATUS		GENMASK(15, 0)
 
 struct aspeed_scu_ic_variant {
 	const char		*compatible;
 	unsigned long	irq_enable;
 	unsigned long	irq_shift;
 	unsigned int	num_irqs;
+	bool			split_ier_isr;
+	unsigned long	ier;
+	unsigned long	isr;
 };
 
 #define SCU_VARIANT(_compat, _shift, _enable, _num) { \
@@ -30,13 +34,20 @@ struct aspeed_scu_ic_variant {
 	.irq_shift		=	_shift,		\
 	.irq_enable		=	_enable,	\
 	.num_irqs		=	_num,		\
+	.split_ier_isr	=	_split,		\
+	.ier			=	_ier,		\
+	.isr			=	_isr,		\
 }
 
 static const struct aspeed_scu_ic_variant scu_ic_variants[]	__initconst = {
-	SCU_VARIANT("aspeed,ast2400-scu-ic",	0,	GENMASK(15, 0),	7),
-	SCU_VARIANT("aspeed,ast2500-scu-ic",	0,	GENMASK(15, 0), 7),
-	SCU_VARIANT("aspeed,ast2600-scu-ic0",	0,	GENMASK(5, 0),	6),
-	SCU_VARIANT("aspeed,ast2600-scu-ic1",	4,	GENMASK(5, 4),	2),
+	SCU_VARIANT("aspeed,ast2400-scu-ic",	0, GENMASK(15, 0),	7,	false,	0,	0),
+	SCU_VARIANT("aspeed,ast2500-scu-ic",	0, GENMASK(15, 0),	7,	false,	0,	0),
+	SCU_VARIANT("aspeed,ast2600-scu-ic0",	0, GENMASK(5, 0),	6,	false,	0,	0),
+	SCU_VARIANT("aspeed,ast2600-scu-ic1",	4, GENMASK(5, 4),	2,	false,	0,	0),
+	SCU_VARIANT("aspeed,ast2700-scu-ic0",	0, GENMASK(3, 0),	4,	true,	0x00, 0x04),
+	SCU_VARIANT("aspeed,ast2700-scu-ic1",	0, GENMASK(3, 0),	4,	true,	0x00, 0x04),
+	SCU_VARIANT("aspeed,ast2700-scu-ic2",	0, GENMASK(3, 0),	4,	true,	0x04, 0x00),
+	SCU_VARIANT("aspeed,ast2700-scu-ic3",	0, GENMASK(1, 0),	2,	true,	0x04, 0x00),
 };
 
 struct aspeed_scu_ic {
@@ -45,9 +56,12 @@ struct aspeed_scu_ic {
 	unsigned int		num_irqs;
 	void __iomem		*base;
 	struct irq_domain	*irq_domain;
+	bool				split_ier_isr;
+	unsigned long		ier;
+	unsigned long		isr;
 };
 
-static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
+static void aspeed_scu_ic_irq_handler_combined(struct irq_desc *desc)
 {
 	struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -84,33 +98,69 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
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
 static void aspeed_scu_ic_irq_mask(struct irq_data *data)
 {
 	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
-	unsigned int mask = BIT(data->hwirq + scu_ic->irq_shift) |
-		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
 
-	/*
-	 * Status bits are cleared by writing 1. In order to prevent the mask
-	 * operation from clearing the status bits, they should be under the
-	 * mask and written with 0.
-	 */
-	writel(readl(scu_ic->base) & ~mask, scu_ic->base);
+	if (scu_ic->split_ier_isr) {
+		writel(readl(scu_ic->base) & ~BIT(data->hwirq + scu_ic->irq_shift),
+		       scu_ic->base + scu_ic->ier);
+	} else {
+		unsigned int mask = BIT(data->hwirq + scu_ic->irq_shift) |
+			(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
+
+		/*
+		 * Status bits are cleared by writing 1. In order to prevent the mask
+		 * operation from clearing the status bits, they should be under the
+		 * mask and written with 0.
+		 */
+		writel(readl(scu_ic->base) & ~mask, scu_ic->base);
+	}
 }
 
 static void aspeed_scu_ic_irq_unmask(struct irq_data *data)
 {
 	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
 	unsigned int bit = BIT(data->hwirq + scu_ic->irq_shift);
-	unsigned int mask = bit |
-		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
 
-	/*
-	 * Status bits are cleared by writing 1. In order to prevent the unmask
-	 * operation from clearing the status bits, they should be under the
-	 * mask and written with 0.
-	 */
-	writel((readl(scu_ic->base) & ~mask) | bit, scu_ic->base);
+	if (scu_ic->split_ier_isr) {
+		writel(readl(scu_ic->base) | bit, scu_ic->base + scu_ic->ier);
+	} else {
+		unsigned int mask = bit | (scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
+
+		/*
+		 * Status bits are cleared by writing 1. In order to prevent the unmask
+		 * operation from clearing the status bits, they should be under the
+		 * mask and written with 0.
+		 */
+		writel((readl(scu_ic->base) & ~mask) | bit, scu_ic->base);
+	}
 }
 
 static int aspeed_scu_ic_irq_set_affinity(struct irq_data *data,
@@ -151,8 +201,14 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
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
@@ -168,8 +224,12 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 		goto err;
 	}
 
-	irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler,
-					 scu_ic);
+	if (scu_ic->split_ier_isr)
+		irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler_split,
+						 scu_ic);
+	else
+		irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler_combined,
+						 scu_ic);
 
 	return 0;
 
@@ -202,9 +262,12 @@ static int __init aspeed_scu_ic_of_init(struct device_node *node, struct device_
 	if (!scu_ic)
 		return -ENOMEM;
 
-	scu_ic->irq_enable    = variant->irq_enable;
-	scu_ic->irq_shift     = variant->irq_shift;
-	scu_ic->num_irqs      = variant->num_irqs;
+	scu_ic->irq_enable	= variant->irq_enable;
+	scu_ic->irq_shift	= variant->irq_shift;
+	scu_ic->num_irqs	= variant->num_irqs;
+	scu_ic->split_ier_isr	= variant->split_ier_isr;
+	scu_ic->ier		= variant->ier;
+	scu_ic->isr		= variant->isr;
 
 	return aspeed_scu_ic_of_init_common(scu_ic, node);
 }
@@ -213,3 +276,7 @@ IRQCHIP_DECLARE(ast2400_scu_ic, "aspeed,ast2400-scu-ic", aspeed_scu_ic_of_init);
 IRQCHIP_DECLARE(ast2500_scu_ic, "aspeed,ast2500-scu-ic", aspeed_scu_ic_of_init);
 IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0", aspeed_scu_ic_of_init);
 IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1",     aspeed_scu_ic_of_init);
+IRQCHIP_DECLARE(ast2700_scu_ic0, "aspeed,ast2700-scu-ic0", aspeed_scu_ic_of_init);
+IRQCHIP_DECLARE(ast2700_scu_ic1, "aspeed,ast2700-scu-ic1", aspeed_scu_ic_of_init);
+IRQCHIP_DECLARE(ast2700_scu_ic2, "aspeed,ast2700-scu-ic2", aspeed_scu_ic_of_init);
+IRQCHIP_DECLARE(ast2700_scu_ic3, "aspeed,ast2700-scu-ic3", aspeed_scu_ic_of_init);
-- 
2.34.1


