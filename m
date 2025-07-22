Return-Path: <linux-kernel+bounces-741134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7CFB0E078
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03847189ECE6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8C3267F4C;
	Tue, 22 Jul 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kkLWUgiM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bzfZ8NoE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA1267729;
	Tue, 22 Jul 2025 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198054; cv=none; b=l9bdxdTAKZgCpZYjgWSvr0RdRSSIof7n6CQ4QmSyYwUnjwUHSa0C3xEDTtFA0dMqF5PPCPK2t0V2mq9nx5gy39O3pBJeHPIvYqC+yYQlaPeuWjGT9H6CMH5KVfHSHObbN7cFnEPY96z8c5ZmROlvh+5xqd8sgoAs0SKck5Tqogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198054; c=relaxed/simple;
	bh=ajXHEG1ys9O2LMQbJKpp188afSNpNDo+IJgTNnqpNHk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ggOQfl9/ZgRY4L1TCzJb8XRu4RxwJPB00e3B4wshMiax+sz9Wcbe2ayoVLaGcJCND2miWoaiYBogrBNS2yd5UtdEX3IDit/osoujFNt8tWaNBbXi0An8FXSvd6Te45nvQ8bSM45WXbU87EcC9CO6sLWg2BrsWXDu8hIK4fJ4tOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kkLWUgiM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bzfZ8NoE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753198050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7m/XuAzAuznwNYeAO8xDbMoWfLWG/BV9jH86cwzm7kM=;
	b=kkLWUgiMBeBkuMrm+74J4ZxDj1nFTwnSBaSfHvdPmNOftscpA1c8uI+4rQFNcQkbgLCRW0
	n5Rt6j3tuvIkM798JI888IZRgJ6039UN9TB62oygfg9U+d9c3Vazs6iu7Sm8hCARwcC0mq
	R/qZGGoAStqRnaYxcRbXq+3oAob1reB/W3BoVhct+cAma/6N9I9KRw1j4hQjmbCTvzW4ng
	i2EFkzqF0m3kL93G1+yxnsNFvqXzGCt1C1nLskIVNuPYcR1hAdF5d6RR3QtvgE0feMsNcg
	Q2b2zWMfntC2LQrsw1enEGMn1xjog+QGsyoFHfmqwDlToj1gr8BQDcwtobwjNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753198050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7m/XuAzAuznwNYeAO8xDbMoWfLWG/BV9jH86cwzm7kM=;
	b=bzfZ8NoEaQr2P+9CRQbsWj/TA2vOvdMnlb7wwbXgbLsNfTgB9rjFc34IetmI+ISP6yU7KH
	UGzulKrg6K+tfrCw==
To: Ryan Chen <ryan_chen@aspeedtech.com>, ryan_chen
 <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kevin Chen <kevin_chen@aspeedtech.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v3 2/2] irqchip: aspeed: add debugfs support and AST2700
 INTC0/INTC1 routing/protection display
In-Reply-To: <20250722095156.1672873-3-ryan_chen@aspeedtech.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-3-ryan_chen@aspeedtech.com>
Date: Tue, 22 Jul 2025 17:27:29 +0200
Message-ID: <8734aotfdq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 22 2025 at 17:51, Ryan Chen wrote:

The subsystem prefix is made up. See:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-submission-notes

> AST2700 INTC0/INTC1 nodes ("aspeed,ast2700-intc0/1") not only
> include the interrupt controller child node ("aspeed,ast2700-intc-ic"),
> but also provide interrupt routing and register protection features.

> This patch adds debugfs entries for interrupt routing and protection

# git grep 'This patch' Documentation/process

> status for AST2700 INTC0/INTC1.
>
> - Register platform driver for "aspeed,ast2700-intc0" and
>  "aspeed,ast2700-intc1" compatible nodes.
> - Add show_routing/show_prot callbacks for both intc0 and intc1,
>  displaying current interrupt routing and protection register status.
> - Expose routing/protection information via debugfs for debugging
>  and validation.
> +
> +struct aspeed_intc {
> +	void __iomem *base;
> +	struct device *dev;
> +	struct dentry *dbg_root;
> +	int (*show_routing)(struct seq_file *s, void *unused);
> +	int (*show_prot)(struct seq_file *s, void *unused);
> +};

See the chapter about struct declarations and initializers in the
documentation I linked to above.

> +static int aspeed_intc1_show_prot(struct seq_file *s, void *unused)
> +{
> +	struct aspeed_intc *intc = s->private;
> +	u32 prot = readl(intc->base);
> +
> +	seq_printf(s, "INTC1: 0x%08x\n", prot);
> +
> +	static const char * const prot_bits[] = {
> +		"pprot_ca35: Protect INTC100~150,280~2D0,300~350 write by PSP only",
> +		"pprot_ssp: Protect INTC180~1D0 write by SSP only",
> +		"pprot_tsp: Protect INTC200~250 write by TSP only",
> +		"pprot_reg_prot: Protect INTC080~0D4 to be read only",
> +		"pprot_regrd: Protect INTC080~0D4 to be read protected",
> +		"pprot_regrd2: Protect INTC100~150,280~2D0,300~350 read by PSP only",
> +		"pprot_regrd3: Protect INTC180~1D0 read by SSP only",
> +		"pprot_regrd4: Protect INTC200~250 read by TSP only",
> +		"pprot_mcu0: Protect INTC010,014 write by MCU0 only",
> +		"pprot_regrd5: Protect INTC010,014 read by MCU0 only",
> +		"pprot_treg: Protect INTC040~054 to be read protected"
> +	};
> +
> +	for (int i = 0; i < 11; i++)
> +		seq_printf(s, "  [%2d] %s: %s\n", i, prot_bits[i],
> +			   (prot & BIT(i)) ? "Enable" : "Disable");
> +	return 0;
> +}

I really have to ask, what the value of this metric ton of string
constants and decoding is. This is a debug interface, which is intended
for developers and experts. As these are hardware bits, which are
immutable, it's completely sufficient to print out the raw values here
and let the engineer decode it, no?

> +static int aspeed_intc_probe(struct platform_device *pdev)
> +{
> +	struct aspeed_intc *intc;
> +	struct resource *res;
> +
> +	intc = devm_kzalloc(&pdev->dev, sizeof(*intc), GFP_KERNEL);
> +	if (!intc)
> +		return -ENOMEM;
> +	intc->dev = &pdev->dev;

intc->dev is not used anywhere.

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	intc->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(intc->base))
> +		return PTR_ERR(intc->base);
> +
> +	if (of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2700-intc0")) {
> +		intc->show_routing = aspeed_intc0_show_routing;
> +		intc->show_prot    = aspeed_intc0_show_prot;
> +	} else if (of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2700-intc1")) {
> +		intc->show_routing = aspeed_intc1_show_routing;
> +		intc->show_prot    = aspeed_intc1_show_prot;
> +	} else {
> +		intc->show_routing = NULL;
> +		intc->show_prot = NULL;

What's the point of creating the debugfs entry instead of bailing out?

> +	}
> +
> +	platform_set_drvdata(pdev, intc);
> +
> +	intc->dbg_root = debugfs_create_dir(dev_name(&pdev->dev), NULL);

Why storing this? It's just used for setting up the debugfs entry, no?

> +	if (intc->dbg_root) {
> +		debugfs_create_file("routing", 0400, intc->dbg_root, intc,
> +				    &aspeed_intc_routing_fops);
> +		debugfs_create_file("protection", 0400, intc->dbg_root, intc,
> +				    &aspeed_intc_prot_fops);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id aspeed_intc_of_match[] = {
> +	{ .compatible = "aspeed,ast2700-intc0", },
> +	{ .compatible = "aspeed,ast2700-intc1", },
> +	{},
> +};
> +
> +static struct platform_driver aspeed_intc_driver = {
> +	.probe  = aspeed_intc_probe,
> +	.driver = {
> +		.name = "ast2700-intc",
> +		.of_match_table = aspeed_intc_of_match,
> +	},
> +};
> +builtin_platform_driver(aspeed_intc_driver);

Why has this to be builtin and not a module? It has zero dependencies on
the existing code in this file, right?

Just stick it into a seperate source file and make it modular with a
seperate Kconfig switch. No point in carrying this code as built-in in
multi-platform builds.

This whole platform driver muck is just there to expose the routing and
protection registers in debugfs even if debugfs is disabled. Seriously?

It's completely disconnected from the interrupt delivery chain as far as
the kernel is concerned, i.e. it does not provide a interrupt
domain/chip. So that interface dumps just some register values with a
lot of effort and leaves it to the user to decode which actual linux
interrupt in the real intc-ic interrupt domains is affected, right?

I'm still failing to see the value of all of this. As the kernel does
not even modify these registers, you are basically implementing a dump
facility for decoding what the firmware put into those registers, right?

I don't have a strong opinion about it, but if it has a value, then all
of this can be done with way smaller code by just dumping the raw
register values all in one go. No need for two files and string
encoding. That's what user space is for.

Something like the completely uncompiled below, which I cobbled together
quickly for illustration. You get the idea.

Thanks,

        tglx
---

#define INTC_TYPE_C0	0
#define INTC_TYPE_C1	1

struct aspeed_intc {
	void __iomem	*base;
	unsigned int	type;
};

const struct aspeed_intc_data {
	char		*name;
	unsigned int	groups;
	unsigned int	prot_offs;
	unsigned int	rout_offs;
	unsigned int	rout_gap;
} aspeed_intc_data[2] = {
	{
		.name		= "INTC0",
		.groups		= 4,
		.prot_offs	= 0x40,
		.rout_offs	= 0x200,
		.rout_gap	= 0x100,
	},
	{
		.name		= "INTC1",
		.groups		= 6,
		.prot_offs	= 0x0,
		.rout_offs	= 0x80,
		.rout_gap	= 0x20,
	},
};

static int aspeed_intc_show(struct seq_file *m, void *unused)
{
	struct aspeed_intc *intc = m->private;
	const struct aspeed_intc_data *d = &aspeed_intc_data[intc->type];
	void __iomem *base = intc->base;

	seq_printf(m, "%s\n", d->name)
	seq_printf(m, "P: 0x%08x\n", readl(base + d->prot_offs));

	base += d->rout_offs;
	for (unsigned int i = 0; i < d->groups; i++, base += 4) {
		seq_printf(m, "R%d: 0x%08x 0x%08x 0x%08x\n", i, readl(base),
			   readl(base + d->rout_gap), readl(base + 2 * d->rout_gap));
	}
	return 0;
}
DEFINE_SHOW_ATTRIBUTE(aspeed_intc);

static int aspeed_intc_probe(struct platform_device *pdev)
{
	struct aspeed_intc *intc;
	struct resource *res;
	struct dentry *dir;

	intc = devm_kzalloc(&pdev->dev, sizeof(*intc), GFP_KERNEL);
	if (!intc)
		return -ENOMEM;

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	intc->base = devm_ioremap_resource(&pdev->dev, res);
	if (IS_ERR(intc->base))
		return PTR_ERR(intc->base);

	if (of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2700-intc0"))
		intc->type = INTC_TYPE_C0;
	else if (of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2700-intc1"))
		intc->type = INTC_TYPE_C1;
	else
		return -ENOTSUPP;

	platform_set_drvdata(pdev, intc);

	dir = debugfs_create_dir(dev_name(&pdev->dev), NULL);
	debugfs_create_file("intc_regs", 0400, dir, intc, &aspeed_intc_fops);
	return 0;
}

static const struct of_device_id aspeed_intc_of_match[] = {
	{ .compatible	= "aspeed,ast2700-intc0", },
	{ .compatible	= "aspeed,ast2700-intc1", },
	{ },
};
MODULE_DEVICE_TABLE(of, aspeed_intc_of_match);

static struct platform_driver aspeed_intc_driver = {
	.probe  = aspeed_intc_probe,
	.driver = {
		.name		= "ast2700-intc",
		.of_match_table	= aspeed_intc_of_match,
	},
};
module_platform_driver(aspeed_intc_driver);

