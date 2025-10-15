Return-Path: <linux-kernel+bounces-855099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8CCBE0396
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051171A2213B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC62F2F1FD1;
	Wed, 15 Oct 2025 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UOuBuEb3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UYfg96jV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F3325494;
	Wed, 15 Oct 2025 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553652; cv=none; b=A9OiasmJOFSNoLxv4WU8rLxweB0PPXrgiDlw+jzI0lwPGL55AIHu52+uM26e/mogFWi48VVXggbDpJRJiZbaXX9EXEAi2kIkPNXntNDD5KjaI/RxagOKg/vd7Hk4GEawIKbHy822I5sF+eBMxQn9GljJDks78d2beWr8uGkY50Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553652; c=relaxed/simple;
	bh=VLIxBEms27Yz3y0Bt+/VwITTq6tiyEIu79XTi07+0bg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cIWqqGOEsjVPSZsdpbxemUQIs3kY3UlvML1qeevg8x9Julo9ZK9lKSv7s5Pmbu1tfJdysvkinBoRC2rPhjtGhyE+xMAkxpiBZyiWmVXCA7kM8D9IKER+t6Daz7SvmIJvZcaNSdYeE0RxNvkV+uFhkj7Js3439/r25pnzcuiW+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UOuBuEb3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UYfg96jV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760553648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+uP+eUWmeV1AcOzpTFqHijqsFbONeijvS4FICr7ALx0=;
	b=UOuBuEb3B/deBdCKfzYKnZIv2IFCw47QVB1rB9Y5sQHMYA+c3VxT+e2bSU32O3lP319r+E
	t1Rit1EJ/f6KLl67lVV4PNtcL6K1nQflR65zafd5wymcBVREUIPxgUU7KW3A7mqtJRx31y
	3rg15l7/ICCsPuplfWLOBp6GXUeyCah+0B6FlzBJLr90J6H6tiOBh0x1k2Q0W+vQ6ih6+d
	QM8i/pcTOrSwkI18KlKjQXkKKCnFq/HxIAXijjZXELxg21GkNQnI+KoC5Mkhl1IvG2gacs
	c+gMgZYIM6Akpa9ZVhyVRBv5SpN3xt0TKERYMGsKDNR1BzixXp2mibw+FhajJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760553648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+uP+eUWmeV1AcOzpTFqHijqsFbONeijvS4FICr7ALx0=;
	b=UYfg96jVV87s4/TO5Vuc6hNOWjzMJp5IqRYwlMW4j71Ncv1gUmSo08Rx6c6uwktqSx9/6i
	D/+JC7X2WVknTiCg==
To: Lucas Zampieri <lzampier@redhat.com>, linux-kernel@vger.kernel.org
Cc: Charles Mirabile <cmirabil@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Samuel
 Holland <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Vivian
 Wang <dramforever@live.com>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, Zhang Xincheng
 <zhangxincheng@ultrarisc.com>, Lucas Zampieri <lzampier@redhat.com>
Subject: Re: [PATCH v4 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
In-Reply-To: <20251015143108.441291-4-lzampier@redhat.com>
References: <20251015143108.441291-1-lzampier@redhat.com>
 <20251015143108.441291-4-lzampier@redhat.com>
Date: Wed, 15 Oct 2025 20:40:47 +0200
Message-ID: <87y0pc100g.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 15 2025 at 15:31, Lucas Zampieri wrote:
> +static bool cp100_isolate_pending_irq(int nr_irq_groups, u32 ie[],
> +				       void __iomem *pending,
> +				       void __iomem *enable)
> +{
> +	u32 pending_irqs = 0;
> +	int i, j;
> +
> +	/* Look for first pending interrupt */
> +	for (i = 0; i < nr_irq_groups; i++) {
> +		pending_irqs = ie[i] & readl_relaxed(pending + i * sizeof(u32));
> +		if (pending_irqs)
> +			break;
> +	}
> +
> +	if (!pending_irqs)
> +		return false;
> +
> +	/* Disable all interrupts but the first pending one */
> +	for (j = 0; j < nr_irq_groups; j++) {
> +		u32 new_mask = 0;
> +
> +		if (j == i)
> +			/* Extract mask with lowest set bit */
> +			new_mask = (pending_irqs & -pending_irqs);

Please add brackets around the conditional as it's not a true single
line.

> +static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler,
> +					void __iomem *claim)
> +{
> +	void __iomem *enable = handler->enable_base;
> +	void __iomem *pending = handler->priv->regs + PENDING_BASE;
> +	int nr_irqs = handler->priv->nr_irqs;
> +	int nr_irq_groups = DIV_ROUND_UP(nr_irqs, 32);
> +	int i;
> +	irq_hw_number_t hwirq = 0;

Please use reverse fir tree ordering:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

> +
> +	raw_spin_lock(&handler->enable_lock);

Please use

       guard(raw_spinlock)(&handler->....);

which gets rid of the goto and you can just return instead.

> +	/* Save current interrupt enable state */
> +	for (i = 0; i < nr_irq_groups; i++)
> +		handler->enable_save[i] = readl_relaxed(enable + i * sizeof(u32));
> +
> +	if (!cp100_isolate_pending_irq(nr_irq_groups, handler->enable_save, pending, enable))
> +		goto out;
> +
> +	hwirq = readl(claim);
> +
> +	/* Restore previous state */
> +	for (i = 0; i < nr_irq_groups; i++)
> +		writel_relaxed(handler->enable_save[i], enable + i * sizeof(u32));
> +out:
> +	raw_spin_unlock(&handler->enable_lock);
> +	return hwirq;
> +}
> +
> +static void plic_handle_irq_cp100(struct irq_desc *desc)
> +{
> +	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
> +	irq_hw_number_t hwirq;
> +
> +	WARN_ON_ONCE(!handler->present);
> +
> +	chained_irq_enter(chip, desc);
> +
> +	while ((hwirq = cp100_get_hwirq(handler, claim))) {
> +		int err = generic_handle_domain_irq(handler->priv->irqdomain,
> +						    hwirq);

Let it stick out, you have 100 characters

> +		if (unlikely(err)) {
> +			pr_warn_ratelimited("%pfwP: can't find mapping for hwirq %lu\n",
> +					    handler->priv->fwnode, hwirq);
> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
>  static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
>  {
>  	/* priority must be > threshold to trigger an interrupt */
> @@ -430,6 +516,8 @@ static const struct of_device_id plic_match[] = {
>  	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>  	{ .compatible = "thead,c900-plic",
>  	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> +	{ .compatible = "ultrarisc,cp100-plic",
> +	  .data = (const void *)BIT(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM) },
>  	{}
>  };
>  
> @@ -664,12 +752,16 @@ static int plic_probe(struct fwnode_handle *fwnode)
>  		}
>  
>  		if (global_setup) {
> +			void (*handler_fn)(struct irq_desc *) = plic_handle_irq;

Lacks a newline between variable declaration and code.

> +			if (test_bit(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM, &handler->priv->plic_quirks))
> +				handler_fn = plic_handle_irq_cp100;
> +
>  			/* Find parent domain and register chained handler */
>  			domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
>  			if (domain)
>  				plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
>  			if (plic_parent_irq)
> -				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
> +				irq_set_chained_handler(plic_parent_irq, handler_fn);
>  
>  			cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
>  					  "irqchip/sifive/plic:starting",

Thanks,

        tglx

