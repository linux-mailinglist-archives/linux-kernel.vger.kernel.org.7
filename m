Return-Path: <linux-kernel+bounces-796533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B74B4021F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B583A93D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110C62DAFA5;
	Tue,  2 Sep 2025 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0MpqbOb0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AKhUPcae"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB802D9EF5;
	Tue,  2 Sep 2025 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818449; cv=none; b=BjauCARCVn9WoM2N8YLViab2j7a//fwkYTOG3Vdv1n78ztKNqr2vnq9AI3N3mB1tel28hh2+AihCOhWEGNSZ52lA6TIA05bDBaGslRDHtW/HQIUYARxc9+qwRpYji9svpPE0fJJoeA8PYkitqEYz7mZrcXPHMzeOt8yMmaKNkV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818449; c=relaxed/simple;
	bh=Bnr83H+4c3bTpZALd1MpNvFAul+hyMgBztlopn63ooE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CmmEgELMTgRUYHh4hnnS2YQqtVmrlpXbLQ7+AXpJ4PJIsdzUBFYi2szZJVf00qkhvRQVm2gNV2DujYEuf/3P41rQO8plVTmTnuLu7huf297UWYHaAf7PFLw+UqObZJ/L6OhLfD++QWi/M9DfVTX4RKO67jzMWvQOY0WwiuB97Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0MpqbOb0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AKhUPcae; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756818444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+IOP6KQgl7sg4RNv1HB15N9tnpQImYkfB9yocklRZDY=;
	b=0MpqbOb0MmctHgGLQpEoK7RvCrWqhe11k7zTcy8rW2Qfo7mEGcPn5YRQkw8nA/4UE4khMk
	qVglqTWaaErQgvpR6lBTxWvoGi008hP0GLsPHU7H/pp+UX2aUaLx1+7feoS6miXFyPEg9Z
	iqBXxrZmrXN+K4gbv0NKs1+w3YlIfGOPH2Uk/IWlXPSXd83ArVwnQB3A+coNOQYY0xi91a
	EQqlpauvguqFqYMV0d3U09qWOkil3jRoUezBM+Ji7uhtq2xn8/ZdOw0STltaDV+3yXvIiL
	w+eONQLePF81UOj2KAyLncrk+TWHd7+J8U4A22FRez4iuwC+eMkgWjBEaJfnHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756818444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+IOP6KQgl7sg4RNv1HB15N9tnpQImYkfB9yocklRZDY=;
	b=AKhUPcaeUUqBybjPoJeHUXRY72ygfIw8wlfOfdrh1iP5zgu2ytXtU3whmTaefPi79pOvkS
	oV/Hg036JfwXYfDg==
To: Ryan Chen <ryan_chen@aspeedtech.com>, ryan_chen
 <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SCU
 interrupt controllers
In-Reply-To: <20250831021438.976893-5-ryan_chen@aspeedtech.com>
References: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
 <20250831021438.976893-5-ryan_chen@aspeedtech.com>
Date: Tue, 02 Sep 2025 15:07:21 +0200
Message-ID: <87y0qx0zqu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Aug 31 2025 at 10:14, Ryan Chen wrote:

> The AST2700 continues the multi-instance SCU interrupt controller model
> introduced in the AST2600, with four independent interrupt domains
> (scu-ic0 to 3).
>
> Unlike earlier generations that combine interrupt enable and status bits
> into a single register, the AST2700 separates these into distinct IER and
> ISR registers. Support for this layout is implemented by using register
> offsets and separate chained IRQ handlers.
>
> The variant table is extended to cover AST2700 IC instances, enabling
> shared initialization logic while preserving support for previous SoCs.
>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/irqchip/irq-aspeed-scu-ic.c | 123 +++++++++++++++++++++-------
>  1 file changed, 95 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
> index cbfc35919281..ffdd9b4e44c1 100644
> --- a/drivers/irqchip/irq-aspeed-scu-ic.c
> +++ b/drivers/irqchip/irq-aspeed-scu-ic.c
> @@ -17,12 +17,16 @@
>  
>  #define ASPEED_SCU_IC_STATUS		GENMASK(28, 16)
>  #define ASPEED_SCU_IC_STATUS_SHIFT	16
> +#define AST2700_SCU_IC_STATUS		GENMASK(15, 0)
>  
>  struct aspeed_scu_ic_variant {
>  	const char		*compatible;
>  	unsigned long	irq_enable;
>  	unsigned long	irq_shift;
>  	unsigned int	num_irqs;
> +	bool			split_ier_isr;

How does that end up aligned?

> +	unsigned long	ier;
> +	unsigned long	isr;
>  };
>  
>  #define SCU_VARIANT(_compat, _shift, _enable, _num) { \
> @@ -30,13 +34,20 @@ struct aspeed_scu_ic_variant {
>  	.irq_shift		=	_shift,		\
>  	.irq_enable		=	_enable,	\
>  	.num_irqs		=	_num,		\
> +	.split_ier_isr	=	_split,		\

Ditto.

> +	.ier			=	_ier,		\
> +	.isr			=	_isr,		\

But what's worse is that '_split, _ier and _isr' come out of thin air as
SCU_VARIANT does not have corresponding arguments. So how is that
supposed to work?

>  }
>  
>  struct aspeed_scu_ic {
> @@ -45,9 +56,12 @@ struct aspeed_scu_ic {
>  	unsigned int		num_irqs;
>  	void __iomem		*base;
>  	struct irq_domain	*irq_domain;
> +	bool				split_ier_isr;

Sigh...

> +	unsigned long		ier;
> +	unsigned long		isr;
>  };
>  
> -static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
> +static void aspeed_scu_ic_irq_handler_combined(struct irq_desc *desc)
>  {
>  	struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> @@ -84,33 +98,69 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> +static void aspeed_scu_ic_irq_handler_split(struct irq_desc *desc)
> +{

...

>  static void aspeed_scu_ic_irq_mask(struct irq_data *data)
>  {
>  	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
> -	unsigned int mask = BIT(data->hwirq + scu_ic->irq_shift) |
> -		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
>  
> -	/*
> -	 * Status bits are cleared by writing 1. In order to prevent the mask
> -	 * operation from clearing the status bits, they should be under the
> -	 * mask and written with 0.
> -	 */
> -	writel(readl(scu_ic->base) & ~mask, scu_ic->base);
> +	if (scu_ic->split_ier_isr) {
> +		writel(readl(scu_ic->base) & ~BIT(data->hwirq + scu_ic->irq_shift),
> +		       scu_ic->base + scu_ic->ier);
> +	} else {
> +		unsigned int mask = BIT(data->hwirq + scu_ic->irq_shift) |
> +			(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
> +
> +		/*
> +		 * Status bits are cleared by writing 1. In order to prevent the mask
> +		 * operation from clearing the status bits, they should be under the
> +		 * mask and written with 0.
> +		 */
> +		writel(readl(scu_ic->base) & ~mask, scu_ic->base);
> +	}

So you have two different handlers. Why can't you provide two different
mask/unmask/ functions along with a seperate irq chip instead of
cluttering the code with conditionals. Thes two variants share no code
at all.

> -	irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler,
> -					 scu_ic);
> +	if (scu_ic->split_ier_isr)
> +		irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler_split,
> +						 scu_ic);
> +	else
> +		irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler_combined,
> +						 scu_ic);
>

Please get rid of the line break. You have 100 characters....

Thanks,

        tglx

