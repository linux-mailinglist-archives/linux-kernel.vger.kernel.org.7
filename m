Return-Path: <linux-kernel+bounces-734995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A39EFB0893D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57A43B7D65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F55E28A71E;
	Thu, 17 Jul 2025 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM8GCicA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8C828A410
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744320; cv=none; b=RQuN5FVnM9KjyHqWRo83D7fi5FkhWdeEBsiM2zMZPW2b8sk7EUYUBeb6c6kHNY1yFKAsKpT5+uoIiBly4sPDCzMKxn6b99nsLB2g2U64CgPZw8OuTXO/amQKnZEWDBeAIReRcq65O2/jD6SfGve6BR5Wp6v+rhGueVGi4sGxZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744320; c=relaxed/simple;
	bh=21OlRn5Tc3SuYE+8FTQNy15rkxkozWxGI6bsYMCzUxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SU27VFriDxRtghYVj9WjU02vfUwrz7DdMToOK2o0mQrPis9tB0opYJneIvP6ft8ubht4sV8J+c5Lm28VgoY5KrZfNxAv/ZYfuxgM8FcfO2ir4njvUY/+JWflce3z+x/ywFg+nUtzREn8f1vCQmj/dyxbH0UIx/2uD0/7nWs7AY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM8GCicA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7617CC4CEEB;
	Thu, 17 Jul 2025 09:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752744320;
	bh=21OlRn5Tc3SuYE+8FTQNy15rkxkozWxGI6bsYMCzUxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EM8GCicAlRYjBB8i/419ADE8vJ8mSfHU3Shjzg3mH1sYrOtHTfRa2jMuk0UFpEqYx
	 sCvduz/fUv7+1QNun6UnNQ9Rr6AYjQ2xTlN70IrLBv+pVUlIBhi/R2cp6g6T46M7Nf
	 7V2MeT95zjm0z4MH0kGvLVA6hdTdRA7SGDThcCgzjUcn24E9TnCmEyxjfeP/dbdi8P
	 Ka6/m2Sk3eNDsz49cHmSojmrG19f74O0uhI673imWmirrjsS42QFj7r2GjegdzFOIE
	 ixLmDgbH4w3SUy7e8vkCjHezJH2zl3Ra2N/GsMdowYkxpN9BXsp+otMUoHu3amxWD3
	 ZYbZQpzB3jigg==
Date: Thu, 17 Jul 2025 11:25:15 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] irqchip/gic-v5: Fix error handling in
 gicv5_its_irq_domain_alloc()
Message-ID: <aHjBe9k2Igl2iopq@lpieralisi>
References: <cover.1752693640.git.dan.carpenter@linaro.org>
 <4787a3c4-9713-4b99-9b8a-7ba227e91d02@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4787a3c4-9713-4b99-9b8a-7ba227e91d02@sabinyo.mountain>

On Wed, Jul 16, 2025 at 02:38:22PM -0500, Dan Carpenter wrote:
> There are two issues to fix in this code:
> 1) If gicv5_alloc_lpi() fails the original code was checking the wrong
> variable.  Fix the mixup between "ret" and "lpi".
> 2) If irq_domain_alloc_irqs_parent() fails, then clean up all the loop
> iterations instead of just the current iteration.
> 
> Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/irqchip/irq-gic-v5-its.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
> index 55360ae9f1f6..8cc8563e27d5 100644
> --- a/drivers/irqchip/irq-gic-v5-its.c
> +++ b/drivers/irqchip/irq-gic-v5-its.c
> @@ -949,15 +949,18 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *domain, unsigned int vi
>  	device_id = its_dev->device_id;
>  
>  	for (i = 0; i < nr_irqs; i++) {
> -		lpi = gicv5_alloc_lpi();
> +		ret = gicv5_alloc_lpi();
>  		if (ret < 0) {
>  			pr_debug("Failed to find free LPI!\n");
>  			goto out_eventid;

This should be:

goto out_free_lpi;

otherwise we miss cleaning up for [0, i - 1] on LPI alloc failure.

I can fix it up - not sure it is worth splitting it into two patches,
just let me know please how you want me to handle it.

Thanks,
Lorenzo

>  		}
> +		lpi = ret;
>  
>  		ret = irq_domain_alloc_irqs_parent(domain, virq + i, 1, &lpi);
> -		if (ret)
> +		if (ret) {
> +			gicv5_free_lpi(lpi);
>  			goto out_free_lpi;
> +		}
>  
>  		/*
>  		 * Store eventid and deviceid into the hwirq for later use.
> @@ -979,7 +982,12 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *domain, unsigned int vi
>  	return 0;
>  
>  out_free_lpi:
> -	gicv5_free_lpi(lpi);
> +	while (--i >= 0) {
> +		irqd = irq_domain_get_irq_data(domain, virq + i);
> +		gicv5_free_lpi(irqd->parent_data->hwirq);
> +		irq_domain_reset_irq_data(irqd);
> +		irq_domain_free_irqs_parent(domain, virq + i, 1);
> +	}
>  out_eventid:
>  	gicv5_its_free_eventid(its_dev, event_id_base, nr_irqs);
>  	return ret;
> -- 
> 2.47.2
> 

