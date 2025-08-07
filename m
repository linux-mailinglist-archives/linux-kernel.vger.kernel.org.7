Return-Path: <linux-kernel+bounces-759073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D988B1D819
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C6B18C5C9A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F7625392D;
	Thu,  7 Aug 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NZsPU/Pb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TepyGY1Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF2824728B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570393; cv=none; b=ayw/xG0eyEeOrPwJIt6th9UgXM+x7+X4oYajs5zrjJTe3cSYjmdW7hSPL0ok8EYRIOHavVplz/dwCD1E8E5M9Vb9IWJ+1boO/PZsY6KogWdUSa+BVkAGKQ39wWYB7fZ80smWo2i7dw2PLF190rcuVXDkrrlqAzcDIqrSfzOjGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570393; c=relaxed/simple;
	bh=IhNfL21psMTR3yWMWB9MAI03PjqKlLcbpYNauM4CdRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IK/oezuJDmYt5DpY6H5gLmgBnZXmcPkip4EW5NZ225o71XWqVH+GAOU2QgW6lLCcm9YFml2ATm8Y6C1KnCS4zGLVVJX4VhAYf1x1feN8EQYvTGKd+AS0hpH4brKBc0raGVfkU8lg94ieDia0Zw2VMFw06lnZ4fwMqKmybLEl1d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NZsPU/Pb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TepyGY1Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754570389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H04ZIKmE6o/aPmfvgSEleptBdX7dH7MfiferMt7opCk=;
	b=NZsPU/PbjAmXPLlxHSsskQxfOtibTbwPmlJokCaaAPMOjTFYCn+2cJlZ7fYnA1fMTc3lCu
	n0XXake88wIY4bmJhFeTs0YjdBcQ2e1SBLlLp+95Tr12Txh/kpTFNMDGszDdWwvEhafK78
	ZcCuuuiFX1sgn6lXLpC5USt9Phjr7hNi7HMsESOCvOOxk/jR3ozzijPU0QNVTwVYo/tkkB
	OxJ/Qp5WQlfJVuUlNAsSzu+fW/3EEKc7zKILYspOpYNjL8W6YICh7NGQIKNMlMq3z93hXR
	4/zVbF0HGELzmQaUL4uX6YDNIbiU7ryyi+Ly15+B0OlEGmL+uG4np0BLfmnsnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754570389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H04ZIKmE6o/aPmfvgSEleptBdX7dH7MfiferMt7opCk=;
	b=TepyGY1Q/w6JTWISuc7uBnfYRybQDBGRbEiIniDXkeS7XOTOy9r4ek7IMPif/ZYZVvKDqQ
	9W16cb2F6VkPC9Ag==
To: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner
 <tglx@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, Samuel
 Holland <samuel.holland@sifive.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li
 <looong.bin@gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Respect mask state when setting
 affinity
In-Reply-To: <20250807111806.741706-1-inochiama@gmail.com>
References: <20250807111806.741706-1-inochiama@gmail.com>
Date: Thu, 07 Aug 2025 14:39:42 +0200
Message-ID: <87fre3mhkh.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Inochi Amaoto <inochiama@gmail.com> writes:

> The plic_set_affinity always call plic_irq_enable(), which clears up
> the priority setting even the irq is only masked. This make the irq
> unmasked unexpectly.
>
> Replace the plic_irq_enable/disable() with plic_irq_toggle() to
> avoid changing priority setting.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index bf69a4802b71..5bf5050996da 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -148,6 +148,7 @@ static void plic_irq_enable(struct irq_data *d)
>  
>  static void plic_irq_disable(struct irq_data *d)
>  {
> +	plic_irq_mask(d);
>  	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
>  }

This part is not required for the problem you are addressing, right?

I do not oppose the change, I'm just curious if I miss something here.

>  
> @@ -179,12 +180,14 @@ static int plic_set_affinity(struct irq_data *d,
>  	if (cpu >= nr_cpu_ids)
>  		return -EINVAL;
>  
> -	plic_irq_disable(d);
> +	/* Invalidate the original routing entry */
> +	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
>  
>  	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>  
> +	/* Setting the new routing entry if irq is enabled */
>  	if (!irqd_irq_disabled(d))
> -		plic_irq_enable(d);
> +		plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
>  
>  	return IRQ_SET_MASK_OK_DONE;
>  }

This part makes sense:

Reviewed-by: Nam Cao <namcao@linutronix.de>
Tested-by: Nam Cao <namcao@linutronix.de> # VisionFive 2

