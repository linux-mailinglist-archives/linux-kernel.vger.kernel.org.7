Return-Path: <linux-kernel+bounces-803971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640B0B4681C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DF95C6148
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754271C5489;
	Sat,  6 Sep 2025 01:49:00 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E7186E40;
	Sat,  6 Sep 2025 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757123339; cv=none; b=mFYJFNXvIwZagxVumGppEz9DwYIuM/m8Y05u6pYx08SFwk7pk17C7dNFcD3PWC+XtkH880Uj0TX68pI0lnYkYXiTabwg1mgo+lOmMQk9kJPiGz82h2FKSgyNxB1MVS5yXlu5xlEvW0rop59b2iZHjfHGEooLUG50S/ZyhYlQ8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757123339; c=relaxed/simple;
	bh=ZeZewhLsyLKNrLXp27L523l5O6hHKBkFOtMhLVkcFfE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHSfxWMmqjJAZDA3a2wTRiYIxXcm+/x8dNAcmdoNOiGsqFDXVIUn0PExgRdwpi4OS5QJ9kX66TOlMCSyw+kvInHURQgykjYz/umDXlinML6KsjSSfMol8M/bVd7vSoBW6cXfUmvl1uLtK8baMZgM8rzoVa886tbt4Uny0KVQShE=
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
Subject: [PATCH v3 1/4] irqchip/aspeed-scu-ic: Refactor driver to support variant-based initialization
Date: Sat, 6 Sep 2025 09:48:43 +0800
Message-ID: <20250906014846.861368-2-ryan_chen@aspeedtech.com>
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

The original SCU IC driver handled each AST2600 instance with separate
initialization functions and hardcoded register definitions. This patch
consolidates the implementation by introducing a variant-based structure,
selected via compatible string.

The driver now uses a unified init path and MMIO access via of_iomap().
This simplifies the code and prepares for upcoming SoCs like AST2700,
which require split register handling.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/irqchip/irq-aspeed-scu-ic.c | 143 ++++++++++++----------------
 1 file changed, 59 insertions(+), 84 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index 1c7045467c48..24d3d3fa5c4b 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -7,52 +7,52 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
-#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/regmap.h>
 
-#define ASPEED_SCU_IC_REG		0x018
-#define ASPEED_SCU_IC_SHIFT		0
-#define ASPEED_SCU_IC_ENABLE		GENMASK(15, ASPEED_SCU_IC_SHIFT)
-#define ASPEED_SCU_IC_NUM_IRQS		7
 #define ASPEED_SCU_IC_STATUS		GENMASK(28, 16)
 #define ASPEED_SCU_IC_STATUS_SHIFT	16
 
-#define ASPEED_AST2600_SCU_IC0_REG	0x560
-#define ASPEED_AST2600_SCU_IC0_SHIFT	0
-#define ASPEED_AST2600_SCU_IC0_ENABLE	\
-	GENMASK(5, ASPEED_AST2600_SCU_IC0_SHIFT)
-#define ASPEED_AST2600_SCU_IC0_NUM_IRQS	6
+struct aspeed_scu_ic_variant {
+	const char		*compatible;
+	unsigned long	irq_enable;
+	unsigned long	irq_shift;
+	unsigned int	num_irqs;
+};
+
+#define SCU_VARIANT(_compat, _shift, _enable, _num) { \
+	.compatible		=	_compat,	\
+	.irq_shift		=	_shift,		\
+	.irq_enable		=	_enable,	\
+	.num_irqs		=	_num,		\
+}
 
-#define ASPEED_AST2600_SCU_IC1_REG	0x570
-#define ASPEED_AST2600_SCU_IC1_SHIFT	4
-#define ASPEED_AST2600_SCU_IC1_ENABLE	\
-	GENMASK(5, ASPEED_AST2600_SCU_IC1_SHIFT)
-#define ASPEED_AST2600_SCU_IC1_NUM_IRQS	2
+static const struct aspeed_scu_ic_variant scu_ic_variants[]	__initconst = {
+	SCU_VARIANT("aspeed,ast2400-scu-ic",	0,	GENMASK(15, 0),	7),
+	SCU_VARIANT("aspeed,ast2500-scu-ic",	0,	GENMASK(15, 0), 7),
+	SCU_VARIANT("aspeed,ast2600-scu-ic0",	0,	GENMASK(5, 0),	6),
+	SCU_VARIANT("aspeed,ast2600-scu-ic1",	4,	GENMASK(5, 4),	2),
+};
 
 struct aspeed_scu_ic {
-	unsigned long irq_enable;
-	unsigned long irq_shift;
-	unsigned int num_irqs;
-	unsigned int reg;
-	struct regmap *scu;
-	struct irq_domain *irq_domain;
+	unsigned long		irq_enable;
+	unsigned long		irq_shift;
+	unsigned int		num_irqs;
+	void __iomem		*base;
+	struct irq_domain	*irq_domain;
 };
 
 static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 {
-	unsigned int sts;
-	unsigned long bit;
-	unsigned long enabled;
-	unsigned long max;
-	unsigned long status;
 	struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned int mask = scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
+	unsigned long bit, enabled, max, status;
+	unsigned int sts, mask;
 
 	chained_irq_enter(chip, desc);
 
@@ -66,7 +66,7 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 	 * shifting the status down to get the mapping and then back up to
 	 * clear the bit.
 	 */
-	regmap_read(scu_ic->scu, scu_ic->reg, &sts);
+	sts = readl(scu_ic->base);
 	enabled = sts & scu_ic->irq_enable;
 	status = (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
 
@@ -76,9 +76,9 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 	for_each_set_bit_from(bit, &status, max) {
 		generic_handle_domain_irq(scu_ic->irq_domain,
 					  bit - scu_ic->irq_shift);
-
-		regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
-				  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
+		writel((readl(scu_ic->base) & ~mask) |
+		       BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT),
+		       scu_ic->base);
 	}
 
 	chained_irq_exit(chip, desc);
@@ -95,7 +95,7 @@ static void aspeed_scu_ic_irq_mask(struct irq_data *data)
 	 * operation from clearing the status bits, they should be under the
 	 * mask and written with 0.
 	 */
-	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, 0);
+	writel(readl(scu_ic->base) & ~mask, scu_ic->base);
 }
 
 static void aspeed_scu_ic_irq_unmask(struct irq_data *data)
@@ -110,7 +110,7 @@ static void aspeed_scu_ic_irq_unmask(struct irq_data *data)
 	 * operation from clearing the status bits, they should be under the
 	 * mask and written with 0.
 	 */
-	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, bit);
+	writel((readl(scu_ic->base) & ~mask) | bit, scu_ic->base);
 }
 
 static int aspeed_scu_ic_irq_set_affinity(struct irq_data *data,
@@ -146,18 +146,13 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 	int irq;
 	int rc = 0;
 
-	if (!node->parent) {
-		rc = -ENODEV;
+	scu_ic->base = of_iomap(node, 0);
+	if (IS_ERR(scu_ic->base)) {
+		rc = PTR_ERR(scu_ic->base);
 		goto err;
 	}
-
-	scu_ic->scu = syscon_node_to_regmap(node->parent);
-	if (IS_ERR(scu_ic->scu)) {
-		rc = PTR_ERR(scu_ic->scu);
-		goto err;
-	}
-	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_STATUS, ASPEED_SCU_IC_STATUS);
-	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_ENABLE, 0);
+	writel(ASPEED_SCU_IC_STATUS, scu_ic->base);
+	writel(0, scu_ic->base);
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (!irq) {
@@ -166,8 +161,7 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 	}
 
 	scu_ic->irq_domain = irq_domain_create_linear(of_fwnode_handle(node), scu_ic->num_irqs,
-						   &aspeed_scu_ic_domain_ops,
-						   scu_ic);
+						      &aspeed_scu_ic_domain_ops, scu_ic);
 	if (!scu_ic->irq_domain) {
 		rc = -ENOMEM;
 		goto err;
@@ -184,57 +178,38 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 	return rc;
 }
 
-static int __init aspeed_scu_ic_of_init(struct device_node *node,
-					struct device_node *parent)
+static const struct aspeed_scu_ic_variant *
+aspeed_scu_ic_find_variant(struct device_node *np)
 {
-	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
-
-	if (!scu_ic)
-		return -ENOMEM;
-
-	scu_ic->irq_enable = ASPEED_SCU_IC_ENABLE;
-	scu_ic->irq_shift = ASPEED_SCU_IC_SHIFT;
-	scu_ic->num_irqs = ASPEED_SCU_IC_NUM_IRQS;
-	scu_ic->reg = ASPEED_SCU_IC_REG;
+	for (int i = 0; i < ARRAY_SIZE(scu_ic_variants); i++) {
+		if (of_device_is_compatible(np, scu_ic_variants[i].compatible))
+			return &scu_ic_variants[i];
+	}
 
-	return aspeed_scu_ic_of_init_common(scu_ic, node);
+	return NULL;
 }
 
-static int __init aspeed_ast2600_scu_ic0_of_init(struct device_node *node,
-						 struct device_node *parent)
+static int __init aspeed_scu_ic_of_init(struct device_node *node, struct device_node *parent)
 {
-	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
-
-	if (!scu_ic)
-		return -ENOMEM;
+	const struct aspeed_scu_ic_variant *variant;
+	struct aspeed_scu_ic *scu_ic;
 
-	scu_ic->irq_enable = ASPEED_AST2600_SCU_IC0_ENABLE;
-	scu_ic->irq_shift = ASPEED_AST2600_SCU_IC0_SHIFT;
-	scu_ic->num_irqs = ASPEED_AST2600_SCU_IC0_NUM_IRQS;
-	scu_ic->reg = ASPEED_AST2600_SCU_IC0_REG;
-
-	return aspeed_scu_ic_of_init_common(scu_ic, node);
-}
-
-static int __init aspeed_ast2600_scu_ic1_of_init(struct device_node *node,
-						 struct device_node *parent)
-{
-	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
+	variant = aspeed_scu_ic_find_variant(node);
+	if (!variant)
+		return -ENODEV;
 
+	scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
 	if (!scu_ic)
 		return -ENOMEM;
 
-	scu_ic->irq_enable = ASPEED_AST2600_SCU_IC1_ENABLE;
-	scu_ic->irq_shift = ASPEED_AST2600_SCU_IC1_SHIFT;
-	scu_ic->num_irqs = ASPEED_AST2600_SCU_IC1_NUM_IRQS;
-	scu_ic->reg = ASPEED_AST2600_SCU_IC1_REG;
+	scu_ic->irq_enable	= variant->irq_enable;
+	scu_ic->irq_shift	= variant->irq_shift;
+	scu_ic->num_irqs	= variant->num_irqs;
 
 	return aspeed_scu_ic_of_init_common(scu_ic, node);
 }
 
 IRQCHIP_DECLARE(ast2400_scu_ic, "aspeed,ast2400-scu-ic", aspeed_scu_ic_of_init);
 IRQCHIP_DECLARE(ast2500_scu_ic, "aspeed,ast2500-scu-ic", aspeed_scu_ic_of_init);
-IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0",
-		aspeed_ast2600_scu_ic0_of_init);
-IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1",
-		aspeed_ast2600_scu_ic1_of_init);
+IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0", aspeed_scu_ic_of_init);
+IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1", aspeed_scu_ic_of_init);
-- 
2.34.1


