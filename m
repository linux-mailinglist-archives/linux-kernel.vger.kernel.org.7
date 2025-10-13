Return-Path: <linux-kernel+bounces-851461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 492A0BD68F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B73189F4E7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E8E30B53E;
	Mon, 13 Oct 2025 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RNZCApCC"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476130ACF0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392698; cv=none; b=imdTJVnlayqlgspTQgG0FRTvn5Yf2IK0cFOu5ekj2kl+Pet+rtV+i+Xu16bd+Kc/bRvgpbntYe/shxrRdOrXwmHWfkmNNccQgxNziTI4PDK3fRV6tCWv6sHpAnxH3ihM9JfVAaljqmoC5MAGkahyk3sQhot/suefi2QFhMrML8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392698; c=relaxed/simple;
	bh=yLjHbFg4kWtZtlzCG8yQqA+NVQ/mb4I1yjF88dIfHcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0GpmXFQDNzIE5NbDAreB221TEYsNQeIpgkIq1Oj62pYpWKlDdaUBiw7aLag95OMMqzJq5EG1Nhq8LVxxDKkDhuxNack+JTUdjx6e8cgLzTYoLYgZcWr3ii0jyJxi9WiHeraqPp7SnLNC/5+zcGA/JRsg0nN/iRV668qeazbHNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=RNZCApCC; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-93bd394fab0so117336539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760392696; x=1760997496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V4CgO2gjUB1ReYMvMrsG9awRFMRdFdaL7/IydQKP1Oc=;
        b=RNZCApCCNUgM20CNfDXMfHurN9Azj6UsaZqchCYxIdPwipXnj/HoryEnjBbp1a8sld
         iO0FE0Jxx8Hk4Ve4wUYuks/CSkYC0PudrJLwhSGGdaCMxkBQz44HlcJAfSHTrlmSis8A
         tVNQGw5i+vwaSJvJUrT+xz8d+QEWlSS4rd/jZ4jVXZvq7ZTPxdWy46DEJ3pRS/OSKXVa
         /nBDJ0KtLLH1tMU0Ycqwec0UcyzEGUNBO+Woainit9Xk61bIiAKXEHXsccL2T8RoFbSq
         LqaHduNQk0SKeGCpNADKAySGbQ48MVR1o8V9u2VD42FzPIrBWDlSuvCw4HplwxiWhKrx
         v3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392696; x=1760997496;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4CgO2gjUB1ReYMvMrsG9awRFMRdFdaL7/IydQKP1Oc=;
        b=gQT+LNkCkU7q6JhT2X/FRG2J2KJfcmlfHbO5LMpiJNJIfQiWngd+r2pYEdZlHjtlGN
         LoWi/9Y1DUVHCQq4kig5Lv263go6pGTowbp5d6NAy3x2aMzPpk5gGfCWydfJfukKZk/X
         TIvqR7k+7jwa/PHsNFD58dCHEeTnkENW4yK1P7wn/quBPDSDOxBw2e4TGWpju+I+00AO
         dhDjc9d1dKGX+dOsYti/hIrWsjrZaz80BrUEmiahZUF3p73FGquxiQY01o3gFALXVwZq
         ZwX5V2kotNdMa5wAYZNsqFJ5X0Qk3SaDKuIpkqBsT0qmUgJ2FOHX/zrOi69cpURew/Bi
         uHxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5gKI0fQ4NBxZx6q4a3lY6/hjaapytmqKSpsNutwzCkWr+5iGV0bhps3xa28bcWVZQjGgnAD2cNA1jGas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5h/nyGoviJd1X60HYv+CSJL/RYTlTG2nKDO5p+QE60fyjjz1i
	mkK1OTNaS8KbRGlAoF+eYfckT0yU7cxdhT/LPxgqNUzP/dPdVmAYbTRJFPJdGWyqyXQ=
X-Gm-Gg: ASbGnctUzNBSd6DncZ35ZBy0gllPldsQin4qHxiS/pPWsCC5iV7YFFvj8FIurfyMM80
	EE1Pi8fIzMNFWEuI4N7Yto6WjfjJCNybf1noTh2ZwpKvDqpCu66rQqZ0YmgdEOnCSphroQEfyvW
	vxznQkZXtrKmgXAG/4D9Z0dQk0mObltNQ2DjvfekX7zfrOFWVEWKtB9yxmRft6kHGcJYbwcSDVC
	A7VAxTwMVvQ1eusDS0+kY0EtiRwoTaHRoeBV4rwVUQN8VY8K6prNK6NlFXB8TDWg6CA20skS0Io
	Q8WuDFQSvcO924mqcPiMjYC1Fyb92iis7ItEXW/03motNx+gvN+OFah+7CD8AeEZg2nJtgsAJDx
	IUChs04AIIDY5R1CceSxPvXf3lV0Yq00hFWGhWxdiSW56FlRMniYUWky6PV/OMhn0uIp7
X-Google-Smtp-Source: AGHT+IEV6dAdcfXQoRvn/BXZwFufuwLnQ5+I48pbEZjHle5JG0qhVLr8+8yrpSJSElgFCsDommrYNA==
X-Received: by 2002:a05:6602:29d4:b0:93b:a3c3:1b09 with SMTP id ca18e2360f4ac-93bd17928e4mr2919782039f.6.1760392695538;
        Mon, 13 Oct 2025 14:58:15 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.207])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e25a39134sm424429139f.12.2025.10.13.14.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 14:58:15 -0700 (PDT)
Message-ID: <a7f42340-63ee-4d26-ae9a-840bbbf46b05@sifive.com>
Date: Mon, 13 Oct 2025 16:58:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] irqchip/plic: add support for UltraRISC DP1000
 PLIC
To: Charles Mirabile <cmirabil@redhat.com>
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, dramforever@live.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 lzampier@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 tglx@linutronix.de, zhangxincheng@ultrarisc.com
References: <1ecbd61e-6b3f-42e8-86cd-e1c589a45262@sifive.com>
 <20251013210318.3879203-1-cmirabil@redhat.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20251013210318.3879203-1-cmirabil@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Charles,

On 2025-10-13 4:03 PM, Charles Mirabile wrote:
> Hi Samuel - 
> 
> On Mon, Oct 13, 2025 at 02:00:29PM -0500, Samuel Holland wrote:
>> Hi Lucas,
>>
>> On 2025-10-13 6:15 AM, Lucas Zampieri wrote:
>>> From: Charles Mirabile <cmirabil@redhat.com>
>>>
>>> Add a new compatible for the plic found in UltraRISC DP1000 with a quirk to
>>> work around a known hardware bug with IRQ claiming.
>>>
>>> When claiming an interrupt on the DP1000 PLIC all other interrupts must be
>>> disabled before the claim register is accessed to prevent incorrect
>>> handling of the interrupt.
>>>
>>> When the PLIC_QUIRK_CLAIM_REGISTER is present, during plic_handle_irq
>>> the enable state of all interrupts is saved and then all interrupts
>>> except for the first pending one are disabled before reading the claim
>>> register. The interrupts are then restored before further processing of
>>> the claimed interrupt continues.
>>
>> Since the workaround requires scanning the pending bits for each interrupt
>> anyway, it would be simpler and more efficient to ignore the claim register
>> entirely. Call generic_handle_domain_irq() for each interrupt that is (enabled
>> AND pending), then clear the pending bit. Then you would not need to save and
>> restore the enable registers.
>>
>>> The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
>>> SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
>>> This has no impact on other platforms.
>>>
>>> Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
>>> Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
>>> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
>>> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
>>> ---
>>>  drivers/irqchip/irq-sifive-plic.c | 83 ++++++++++++++++++++++++++++++-
>>>  1 file changed, 82 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>>> index 9c4af7d58846..a7b51a925e96 100644
>>> --- a/drivers/irqchip/irq-sifive-plic.c
>>> +++ b/drivers/irqchip/irq-sifive-plic.c
>>> @@ -49,6 +49,8 @@
>>>  #define CONTEXT_ENABLE_BASE		0x2000
>>>  #define     CONTEXT_ENABLE_SIZE		0x80
>>>
>>> +#define PENDING_BASE                    0x1000
>>> +
>>>  /*
>>>   * Each hart context has a set of control registers associated with it.  Right
>>>   * now there's only two: a source priority threshold over which the hart will
>>> @@ -63,6 +65,7 @@
>>>  #define	PLIC_ENABLE_THRESHOLD		0
>>>
>>>  #define PLIC_QUIRK_EDGE_INTERRUPT	0
>>> +#define PLIC_QUIRK_CLAIM_REGISTER	1
>>>
>>>  struct plic_priv {
>>>  	struct fwnode_handle *fwnode;
>>> @@ -367,6 +370,82 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
>>>  	.free		= irq_domain_free_irqs_top,
>>>  };
>>>
>>> +static bool dp1000_isolate_pending_irq(int nr_irq_groups, u32 ie[],
>>> +				       void __iomem *pending,
>>> +				       void __iomem *enable)
>>> +{
>>> +	u32 pending_irqs = 0;
>>> +	int i, j;
>>> +
>>> +	/* Look for first pending interrupt */
>>> +	for (i = 0; i < nr_irq_groups; i++) {
>>> +		pending_irqs = ie[i] & readl(pending + i * sizeof(u32));
>>> +		if (pending_irqs)
>>> +			break;
>>> +	}
>>> +
>>> +	if (!pending_irqs)
>>> +		return false;
>>> +
>>> +	/* Disable all interrupts but the first pending one */
>>> +	for (j = 0; j < nr_irq_groups; j++) {
>>> +		u32 new_mask = 0;
>>> +
>>> +		if (j == i)
>>> +			/* Extract mask with lowest set bit */
>>> +			new_mask = (pending_irqs & -pending_irqs);
>>> +
>>> +		writel(new_mask, enable + j * sizeof(u32));
>>> +	}
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +static irq_hw_number_t dp1000_get_hwirq(struct plic_handler *handler,
>>> +					void __iomem *claim)
>>> +{
>>> +	void __iomem *enable = handler->enable_base;
>>> +	void __iomem *pending = handler->priv->regs + PENDING_BASE;
>>> +	int nr_irqs = handler->priv->nr_irqs;
>>> +	int nr_irq_groups = DIV_ROUND_UP(nr_irqs, 32);
>>> +	int i;
>>> +	u32 ie[32] = { 0 };

A couple of comments since we're keeping this algorithm:

There's already an appropriately-sized handler->enable_save array that can be
reused here.

>>> +	irq_hw_number_t hwirq = 0;
>>> +
>>> +	raw_spin_lock(&handler->enable_lock);
>>> +
>>> +	/* Save current interrupt enable state */
>>> +	for (i = 0; i < nr_irq_groups; i++)
>>> +		ie[i] = readl(enable + i * sizeof(u32));
>>> +
>>> +	if (!dp1000_isolate_pending_irq(nr_irq_groups, ie, pending, enable))
>>> +		goto out;
>>> +
>>> +	hwirq = readl(claim);
>>> +
>>> +	/* Restore previous state */
>>> +	for (i = 0; i < nr_irq_groups; i++)
>>> +		writel(ie[i], enable + i * sizeof(u32));

All of the I/O in these new functions, except the readl(claim), can use the
{readl,writel}_relaxed I/O accessors. They don't have any ordering requirement
with respect to main memory, just other I/O.

>>> +out:
>>> +	raw_spin_unlock(&handler->enable_lock);
>>> +	return hwirq;
>>> +}
>>> +
>>> +static irq_hw_number_t plic_get_hwirq(struct plic_handler *handler,
>>> +				      void __iomem *claim)
>>> +{
>>> +	/*
>>> +	 * Due to a hardware bug in the implementation of the claim register
>>> +	 * in the UltraRISC DP1000 platform, other interrupts must be disabled
>>> +	 * before reading the claim register and restored afterwards.
>>> +	 */
>>> +
>>> +	if (test_bit(PLIC_QUIRK_CLAIM_REGISTER, &handler->priv->plic_quirks))
>>> +		return dp1000_get_hwirq(handler, claim);
>>> +
>>> +	return readl(claim);
>>> +}
>>> +
>>>  /*
>>>   * Handling an interrupt is a two-step process: first you claim the interrupt
>>>   * by reading the claim register, then you complete the interrupt by writing
>>> @@ -384,7 +463,7 @@ static void plic_handle_irq(struct irq_desc *desc)
>>>
>>>  	chained_irq_enter(chip, desc);
>>>
>>> -	while ((hwirq = readl(claim))) {
>>> +	while ((hwirq = plic_get_hwirq(handler, claim))) {
>>
>> This is the hot path for interrupt handling. Instead of checking for the quirk
>> on every interrupt, please create a new function that you conditionally pass to
>> irq_set_chained_handler(), so the quirk check only happens once at boot.
>>
>> Regards,
>> Samuel
>>
>>>  		int err = generic_handle_domain_irq(handler->priv->irqdomain,
>>>  						    hwirq);
>>>  		if (unlikely(err)) {
>>> @@ -432,6 +511,8 @@ static const struct of_device_id plic_match[] = {
>>>  	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>>>  	{ .compatible = "thead,c900-plic",
>>>  	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>>> +	{ .compatible = "ultrarisc,cp100-plic",
>>> +	  .data = (const void *)BIT(PLIC_QUIRK_CLAIM_REGISTER) },
>>>  	{}
>>>  };
>>>
>>> --
>>> 2.51.0
>>>
>>
> 
> Is something like this closer to what you had in mind? I tried it on the
> dp1000 and it doesn't work. Obviously it is concievable that I messed up
> the logic here, but it also might be the case that reading the claim
> register is integral to the proper functioning of the pending bits.

It's also possible that the pending bits are read only. There are existing
implementations with both RO and RW pending bits. So the claim register might be
the only way to clear the pending bits for edge-triggered interrupts. (For level
interrupts, the pending bits should clear themselves, so it should be fine if
the write is ignored.) I don't see anything wrong with the code below, but we're
working with known-buggy hardware, so who knows.

> I can confirm that a more minimal change that just moves the quirk check
> out of the hot path is fine. Would that be acceptable even if it is not
> the most efficient? (in essense take the hunk with new functions from
> the original patch but revert the change to `plic_handle_irq` and then add
> the hunk that changes probe from this proposed patch and then create
> the `plic_handle_irq_dp1000` function as a copy of `plic_handle_irq` where
> `dp1000_get_hwirq` is in the loop instead of `readl(claim)`).

Yes, this is acceptable. Even if the workaround isn't the most efficient, it's
at least isolated to the affected hardware. So we'll get the hardware working
now, and the efficiency can always be revisited later.

Regards,
Samuel

> Best - Charlie
> 
> ---
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 9c4af7d58846..fcf520ed33fd 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -49,6 +49,8 @@
>  #define CONTEXT_ENABLE_BASE		0x2000
>  #define     CONTEXT_ENABLE_SIZE		0x80
>  
> +#define PENDING_BASE                    0x1000
> +
>  /*
>   * Each hart context has a set of control registers associated with it.  Right
>   * now there's only two: a source priority threshold over which the hart will
> @@ -63,6 +65,7 @@
>  #define	PLIC_ENABLE_THRESHOLD		0
>  
>  #define PLIC_QUIRK_EDGE_INTERRUPT	0
> +#define PLIC_QUIRK_CLAIM_REGISTER	1
>  
>  struct plic_priv {
>  	struct fwnode_handle *fwnode;
> @@ -367,6 +370,53 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
>  	.free		= irq_domain_free_irqs_top,
>  };
>  
> +static int dp1000_find_pending_irq(struct plic_handler *handler, void __iomem *pending)
> +{
> +	void __iomem *enable = handler->enable_base;
> +	int nr_irqs = handler->priv->nr_irqs;
> +	int nr_irq_groups = DIV_ROUND_UP(nr_irqs, 32);
> +	u32 pending_irqs = 0;
> +	int i;
> +
> +	raw_spin_lock(&handler->enable_lock);
> +	for (i = 0; i < nr_irq_groups; i++) {
> +		u32 enable_mask = readl(enable + i * sizeof(u32));
> +		u32 pending_mask = readl(pending + i * sizeof(u32));
> +		if ((pending_irqs = enable_mask & pending_mask))
> +			break;
> +	}
> +	raw_spin_unlock(&handler->enable_lock);
> +
> +	if (!pending_irqs)
> +		return 0;
> +
> +	return 32 * i + __ffs(pending_irqs);
> +}
> +
> +static void plic_handle_irq_dp1000(struct irq_desc *desc)
> +{
> +	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> +	void __iomem *pending = handler->priv->regs + PENDING_BASE;
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	irq_hw_number_t hwirq;
> +
> +	WARN_ON_ONCE(!handler->present);
> +
> +	chained_irq_enter(chip, desc);
> +
> +	while ((hwirq = dp1000_find_pending_irq(handler, pending))) {
> +		int err = generic_handle_domain_irq(handler->priv->irqdomain,
> +						    hwirq);
> +		__plic_toggle(pending, hwirq, 0);
> +		if (unlikely(err)) {
> +			pr_warn_ratelimited("%pfwP: can't find mapping for hwirq %lu\n",
> +					    handler->priv->fwnode, hwirq);
> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
>  /*
>   * Handling an interrupt is a two-step process: first you claim the interrupt
>   * by reading the claim register, then you complete the interrupt by writing
> @@ -432,6 +482,8 @@ static const struct of_device_id plic_match[] = {
>  	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>  	{ .compatible = "thead,c900-plic",
>  	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> +	{ .compatible = "ultrarisc,dp1000-plic",
> +	  .data = (const void *)BIT(PLIC_QUIRK_CLAIM_REGISTER) },
>  	{}
>  };
>  
> @@ -666,12 +718,16 @@ static int plic_probe(struct fwnode_handle *fwnode)
>  		}
>  
>  		if (global_setup) {
> +			void (*handler_fn)(struct irq_desc *) = plic_handle_irq;
> +			if (test_bit(PLIC_QUIRK_CLAIM_REGISTER, &handler->priv->plic_quirks))
> +				handler_fn = plic_handle_irq_dp1000;
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


