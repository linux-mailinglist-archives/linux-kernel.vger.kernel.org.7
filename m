Return-Path: <linux-kernel+bounces-796508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DE8B401BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B262F1892EFF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919882DC35B;
	Tue,  2 Sep 2025 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jl3Ir6pn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cSY2/Zxw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2952DC341;
	Tue,  2 Sep 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817779; cv=none; b=Ri4zvouNwaA0bH7HLjXpgyD+qu3o03F0BNs7G8AojqWtV4GacGSUeZkHvzOOspVqZReyTkItwxKXauOWfNaI0M/8Nb/TPGg441/fcQ66hCFAAJ4270jfM6FvvcieeLbD+aBBMyo3PnIfyOvSxn4+7/8Vjc40J2g11vhKfn8uUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817779; c=relaxed/simple;
	bh=Z6vo3zFV1WLx2GO09f0w8l1Sx+D0tzXBaDo5dcw0fhY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BefTZ2sk+KLEUL1Fg/hHyNIf5hQglG/oNUN2iayVepncTWXAYcXos0mMHV3r36sxWFZVSN+hzAGp9hbnn2/lgoryGFMr8ZUnpSGrOg/J6UyAYTwFUYzly0OpdpRz5+sBAmv/Hu+gcNWyoBB7wyriQO8QBLXHToKRQARmWzsf3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jl3Ir6pn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cSY2/Zxw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756817773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqaO+SeV+juuMOmuDP+CCM9/ezm8a+cuzkEOZBsIzaY=;
	b=Jl3Ir6pnSxJZNrlzEafpDbybEzAsScYMj2qFx4iAZKmr8ZcHniinwHLqQDkswxZdZVwrkH
	5TJRXTmcz57EvPHj07PBTrvCJaCEGuftAp+3rgQ14QaoTSXSxu2pyf09OnP9PC7+LX4MbZ
	pQwN9gposebgqqLa4aLFRNqXgYFOdRtp+CKIn30FTYyvvsgQq6NUwVdqkgqYE+m4/8Rmu1
	iihZDcz5qzDmpdQgKJMCMh9pVlcg9XvBKwujlRU3ep7YCsASiKAChlRfP3sWpCnFoGkof0
	ZtDCtMl5DH4mL9cvIsD3CD7GndYOqN9OBv0vEvmDqSizBOTr4ViVXZ3rzoqu4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756817773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqaO+SeV+juuMOmuDP+CCM9/ezm8a+cuzkEOZBsIzaY=;
	b=cSY2/ZxwSkTcM3n6h5dg0DWREVEm4aceh5FyNagu4bT+lojglO0U9ENF3AeFej8rv30yCv
	HhNHiyDBYRxVUcBg==
To: Ryan Chen <ryan_chen@aspeedtech.com>, ryan_chen
 <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] irqchip/aspeed-scu-ic: Refactor driver to
 support variant-based initialization
In-Reply-To: <20250831021438.976893-2-ryan_chen@aspeedtech.com>
References: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
 <20250831021438.976893-2-ryan_chen@aspeedtech.com>
Date: Tue, 02 Sep 2025 14:56:12 +0200
Message-ID: <871pop2etv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Aug 31 2025 at 10:14, Ryan Chen wrote:
>  	scu_ic->irq_domain = irq_domain_create_linear(of_fwnode_handle(node), scu_ic->num_irqs,
> -						   &aspeed_scu_ic_domain_ops,
> -						   scu_ic);
> +						      &aspeed_scu_ic_domain_ops,
> +						      scu_ic);

Please move scu_ic to the previous line.

> +aspeed_scu_ic_find_variant(struct device_node *np)
>  {
> -	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
> -
> -	if (!scu_ic)
> -		return -ENOMEM;
> +	for (int i = 0; i < ARRAY_SIZE(scu_ic_variants); i++)
> +		if (of_device_is_compatible(np, scu_ic_variants[i].compatible))
> +			return &scu_ic_variants[i];

the for loop wants curly brackets.

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracket-rules

> +	scu_ic->irq_enable    = variant->irq_enable;
> +	scu_ic->irq_shift     = variant->irq_shift;
> +	scu_ic->num_irqs      = variant->num_irqs;

Please use a TAB not spaces when you want to align things.

> +IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0", aspeed_scu_ic_of_init);
> +IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1",     aspeed_scu_ic_of_init);

Stray TAB in the last line.

Thanks,

        tglx

