Return-Path: <linux-kernel+bounces-756088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729FDB1AFDB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D0F3A3A25
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005E425A348;
	Tue,  5 Aug 2025 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ENkdKStn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kDsAWd4d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED40D23AB8F;
	Tue,  5 Aug 2025 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380263; cv=none; b=blJDIVrP66WDXKm4qTjyb22awStt3Bgfx+0FyEDER8YPUcrlfnu5Y6RVj0QuASSRvAyG+fapGCaGUwFRIyIzYDqZIa3WxUydj72Lzv2bAkd6eU3cB+Awt1ZzDDBxzLfqzs5DYr4VF0TzcaUBiun9B2jGhQnjeq78TzZLzo54GPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380263; c=relaxed/simple;
	bh=JV1JLj4pZFDTkT0IcqmLzcpjmLokdPTSEXz5/ZTakT4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BQtxYSD+8c+JQP5oQeXhc84UlfJ+JCC88DpvEjj3GFFCAvPwlnanfwuuXZjBEnF2ZHaNAtjqiiNaadjRI731idH/a+DIADmZR/gYxkJFXwGHQLtcNzy66J9BA7fBS12N31psv9kAQEz82w7+/WxxGyBRSh4ucWDWIfc9zjDexDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ENkdKStn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kDsAWd4d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754380253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+So4wv8Zly3BtM63OQvZFyoVi+SRY/LO7UXsrqv6fcM=;
	b=ENkdKStnJoAkA7rx4rCYyNvtfAObVJucm1RTLx0dCnp6fLEhYmmtees1scz01sZcNuGQ72
	LYetv4m5hNv8baU3Hoc+i4/m/gX775ghEjIpGKHkW02GP5mlcQw7Qq4dATqHCRJefyXSnC
	PfbtP8lYlQEexNFMGYPbRabIjdcm9C1SAbbRQe040we8pcNLcDqbgP+PoKaOLXO8QlCPsH
	PeLl7os0fgf1FbKd6FRrZyfo0OdKXKHCPx2zVjQDR4PvOPkB39R9GrRj3YXuQtTFCR7r4k
	80RVHm0udF+/eLGnmh0+49AKNmGEeu5PfqINf7a8XQe8MVejCN43T47tjXLQwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754380253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+So4wv8Zly3BtM63OQvZFyoVi+SRY/LO7UXsrqv6fcM=;
	b=kDsAWd4dy48cmoYwpT8I4eiUq6h6MDpAhKchcYikjsGh9zQmB8lOuDP9cO66j1qoC3gMqQ
	MnNkyv4iYe2pTqBA==
To: Ryan Chen <ryan_chen@aspeedtech.com>, ryan_chen
 <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 SCU
 interrupt controllers
In-Reply-To: <20250804053445.1482749-3-ryan_chen@aspeedtech.com>
References: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
 <20250804053445.1482749-3-ryan_chen@aspeedtech.com>
Date: Tue, 05 Aug 2025 09:50:52 +0200
Message-ID: <874iumgqar.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 04 2025 at 13:34, Ryan Chen wrote:
> +#define ASPEED_AST2700_SCU_IC0_EN_REG	0x1d0
> +#define ASPEED_AST2700_SCU_IC0_STS_REG	0x1d4
> +#define ASPEED_AST2700_SCU_IC0_SHIFT	0
> +#define ASPEED_AST2700_SCU_IC0_ENABLE	\
> +	GENMASK(3, ASPEED_AST2700_SCU_IC0_SHIFT)

Let it stick out, you have 100 characters

>  struct aspeed_scu_ic {
>  	unsigned long irq_enable;
>  	unsigned long irq_shift;
>  	unsigned int num_irqs;
>  	unsigned int reg;
> +	unsigned int en_reg;
> +	unsigned int sts_reg;
> +	bool split_ier_isr;

Please reformat this struct declaration according to:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

>  	struct regmap *scu;
>  	struct irq_domain *irq_domain;
>  };
> @@ -52,33 +83,51 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
>  	unsigned long status;
>  	struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> -	unsigned int mask = scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
> +	unsigned int mask;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

>  	chained_irq_enter(chip, desc);
>  
> -	/*
> -	 * The SCU IC has just one register to control its operation and read
> -	 * status. The interrupt enable bits occupy the lower 16 bits of the
> -	 * register, while the interrupt status bits occupy the upper 16 bits.
> -	 * The status bit for a given interrupt is always 16 bits shifted from
> -	 * the enable bit for the same interrupt.
> -	 * Therefore, perform the IRQ operations in the enable bit space by
> -	 * shifting the status down to get the mapping and then back up to
> -	 * clear the bit.
> -	 */
> -	regmap_read(scu_ic->scu, scu_ic->reg, &sts);
> -	enabled = sts & scu_ic->irq_enable;
> -	status = (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
> -
> -	bit = scu_ic->irq_shift;
> -	max = scu_ic->num_irqs + bit;
> -
> -	for_each_set_bit_from(bit, &status, max) {
> -		generic_handle_domain_irq(scu_ic->irq_domain,
> -					  bit - scu_ic->irq_shift);
> -
> -		regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
> -				  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
> +	if (scu_ic->split_ier_isr) {
> +		mask = scu_ic->irq_enable;
> +		regmap_read(scu_ic->scu, scu_ic->en_reg, &sts);
> +		enabled = sts & scu_ic->irq_enable;
> +		regmap_read(scu_ic->scu, scu_ic->sts_reg, &sts);
> +		status = sts & enabled;
> +
> +		bit = scu_ic->irq_shift;
> +		max = scu_ic->num_irqs + bit;
> +
> +		for_each_set_bit_from(bit, &status, max) {
> +			generic_handle_domain_irq(scu_ic->irq_domain, bit - scu_ic->irq_shift);
> +
> +			regmap_write_bits(scu_ic->scu, scu_ic->sts_reg, mask, BIT(bit));
> +		}
> +	} else {
> +		mask = scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
> +		/*
> +		 * The SCU IC has just one register to control its operation and read
> +		 * status. The interrupt enable bits occupy the lower 16 bits of the
> +		 * register, while the interrupt status bits occupy the upper 16 bits.
> +		 * The status bit for a given interrupt is always 16 bits shifted from
> +		 * the enable bit for the same interrupt.
> +		 * Therefore, perform the IRQ operations in the enable bit space by
> +		 * shifting the status down to get the mapping and then back up to
> +		 * clear the bit.
> +		 */
> +		regmap_read(scu_ic->scu, scu_ic->reg, &sts);
> +		enabled = sts & scu_ic->irq_enable;
> +		status = (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
> +
> +		bit = scu_ic->irq_shift;
> +		max = scu_ic->num_irqs + bit;
> +
> +		for_each_set_bit_from(bit, &status, max) {
> +			generic_handle_domain_irq(scu_ic->irq_domain,
> +						  bit - scu_ic->irq_shift);
> +
> +			regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
> +					  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
> +		}

This is horrible, really. Either rework the code so that both chips can
share it with minimal conditionals or provide seperate handlers. It's
not rocket science.
  
>  	chained_irq_exit(chip, desc);
> @@ -87,30 +136,42 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)

>  static void aspeed_scu_ic_irq_mask(struct irq_data *data)
>  static void aspeed_scu_ic_irq_unmask(struct irq_data *data)

>  {
>  	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
>  	unsigned int bit = BIT(data->hwirq + scu_ic->irq_shift);
> -	unsigned int mask = bit |
> -		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
> -
> -	/*
> -	 * Status bits are cleared by writing 1. In order to prevent the unmask
> -	 * operation from clearing the status bits, they should be under the
> -	 * mask and written with 0.
> -	 */
> -	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, bit);
> +	unsigned int mask;
> +
> +	if (scu_ic->split_ier_isr) {
> +		mask = bit;
> +		regmap_update_bits(scu_ic->scu, scu_ic->en_reg, mask, bit);
> +	} else {
> +		mask = bit | (scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
> +
> +		/*
> +		 * Status bits are cleared by writing 1. In order to prevent the unmask
> +		 * operation from clearing the status bits, they should be under the
> +		 * mask and written with 0.
> +		 */
> +		regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, bit);
> +	}

This also wants to be consolidated or seperated.

>  }
>  
> +static int __init aspeed_ast2700_scu_ic0_of_init(struct device_node *node,
> +						 struct device_node *parent)
> +{
> +	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
> +
> +	if (!scu_ic)
> +		return -ENOMEM;
> +
> +	scu_ic->irq_enable = ASPEED_AST2700_SCU_IC0_ENABLE;
> +	scu_ic->irq_shift = ASPEED_AST2700_SCU_IC0_SHIFT;
> +	scu_ic->num_irqs = ASPEED_AST2700_SCU_IC0_NUM_IRQS;
> +	scu_ic->split_ier_isr = true;
> +	scu_ic->en_reg = ASPEED_AST2700_SCU_IC0_EN_REG;
> +	scu_ic->sts_reg = ASPEED_AST2700_SCU_IC0_STS_REG;
> +
> +	return aspeed_scu_ic_of_init_common(scu_ic, node);
> +}
> +
> +static int __init aspeed_ast2700_scu_ic1_of_init(struct device_node *node,
> +						 struct device_node *parent)
> +{
> +	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
> +
> +	if (!scu_ic)
> +		return -ENOMEM;
> +
> +	scu_ic->irq_enable = ASPEED_AST2700_SCU_IC1_ENABLE;
> +	scu_ic->irq_shift = ASPEED_AST2700_SCU_IC1_SHIFT;
> +	scu_ic->num_irqs = ASPEED_AST2700_SCU_IC1_NUM_IRQS;
> +	scu_ic->split_ier_isr = true;
> +	scu_ic->en_reg = ASPEED_AST2700_SCU_IC1_EN_REG;
> +	scu_ic->sts_reg = ASPEED_AST2700_SCU_IC1_STS_REG;
> +
> +	return aspeed_scu_ic_of_init_common(scu_ic, node);
> +}
> +
> +static int __init aspeed_ast2700_scu_ic2_of_init(struct device_node *node,
> +						 struct device_node *parent)
> +{
> +	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
> +
> +	if (!scu_ic)
> +		return -ENOMEM;
> +
> +	scu_ic->irq_enable = ASPEED_AST2700_SCU_IC2_ENABLE;
> +	scu_ic->irq_shift = ASPEED_AST2700_SCU_IC2_SHIFT;
> +	scu_ic->num_irqs = ASPEED_AST2700_SCU_IC2_NUM_IRQS;
> +	scu_ic->split_ier_isr = true;
> +	scu_ic->en_reg = ASPEED_AST2700_SCU_IC2_EN_REG;
> +	scu_ic->sts_reg = ASPEED_AST2700_SCU_IC2_STS_REG;
> +
> +	return aspeed_scu_ic_of_init_common(scu_ic, node);
> +}
> +
> +static int __init aspeed_ast2700_scu_ic3_of_init(struct device_node *node,
> +						 struct device_node *parent)
> +{
> +	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
> +
> +	if (!scu_ic)
> +		return -ENOMEM;
> +
> +	scu_ic->irq_enable = ASPEED_AST2700_SCU_IC3_ENABLE;
> +	scu_ic->irq_shift = ASPEED_AST2700_SCU_IC3_SHIFT;
> +	scu_ic->num_irqs = ASPEED_AST2700_SCU_IC3_NUM_IRQS;
> +	scu_ic->split_ier_isr = true;
> +	scu_ic->en_reg = ASPEED_AST2700_SCU_IC3_EN_REG;
> +	scu_ic->sts_reg = ASPEED_AST2700_SCU_IC3_STS_REG;
> +
> +	return aspeed_scu_ic_of_init_common(scu_ic, node);
> +}

You seriously have no better idea than this copy & pasta orgy?

static struct scu_variant variants = {
	SCU("aspeed,ast2400-scu-ic", ......, whatever...),
        ...
	SCU("aspeed,ast2700-scu-ic0", 0x1D0, 0x1D4, 0, GENMASK(3, 0),
            4, whatever...),
        ...
	SCU("aspeed,ast2700-scu-ic3", 0x10C, 0x108, 0, GENMASK(1, 0),
            2, ......),
} __initdata;

static struct scu_variant *find_variant(struct device_node *node)
{
        for (int i = 0; i < ARRAY_SIZE(variant); i++) {
        	if (!strcmp(variant[i].name, node->name))
                	return &variant[i];
	}                               
        return NULL;
}

static int __init ast_scu_of_init(struct device_node *node, struct device_node *parent)
{
        struct variant *v = find_variant(node);

        if (!v)
          	...

        scu_ic = kzalloc(...);
        *scu_ic = v->scu;
        ...

You get the idea.

This rework needs to come first and then you can add your new 2700 muck
on top.

Thanks,

        tglx

