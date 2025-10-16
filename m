Return-Path: <linux-kernel+bounces-856946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B5EBE5837
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43CC21AA08D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD4F21CA00;
	Thu, 16 Oct 2025 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUFAmQ4b"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657442E228C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648751; cv=none; b=QIxKpYL93p19CRogBDwLOWMt/i1IvhMvPXB/6y9Wy2K+aZuigpOR5ip54yr/u0nFMQjbrb/ArTvIbsxdhYqkuzwxEQY5UZwJoOZcea50QWXFOWvsfEWsBFf++b9uHOy8HumaNuT+B5OwX2Fr4kkhkRePXQhck6W1M7PlHkLvYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648751; c=relaxed/simple;
	bh=0dR3gSPfSYELSWtkPMVt7iH1wbrrlnNX3HP+So0LDng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6Bcq439LEwDx30pvAX9INlok4/jqrvyzqiC4nkbN1a5+c/8hb3pdaElD+THKDd+dv6JYxgso4Y7x/WtPURIX8gp8lyUdWim7tMgnKrBcZs23ILsWHm4wIK7bqaXMLwBV9izWSHkIyOl71E/0nsX3nArNyDqFirybNRljNVeSNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUFAmQ4b; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-330b4739538so1092762a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648749; x=1761253549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L2EzoKc9cX6h7fNdOB+aUUlkvfgneGtOjZpo3gaTcMo=;
        b=BUFAmQ4baeyeEFeasA5F4ZJCXl12P9jAhpD6IsYgU15Dpczvozr6nBM65cw2Obowxl
         vHjL0WQ5Kd5pHBVrcaNF41capwFvfarARsGBHpVgIk1qpmPUCalqC2In3McJSjlnC3tZ
         jOQ3MXWxFRR6+JwLEg0/L8lbXLTAs4Ya0OOyxtlPcOHa14c8fM06TQcrK1S6xbeKjcI9
         fWdFxLqjoBaWbOaYuj3dtyVOJCpsbDmWw8IhQuCMJ5wKvA3gPS+y4nMOKriZRYRInSGt
         ZYxCGGf8wsMpQ/ByGDiVB/PLmtT1AYnTi8rW9rg0HBX3EOGJ7ekCeD4NJ0zLQ26zIQeu
         hVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648749; x=1761253549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2EzoKc9cX6h7fNdOB+aUUlkvfgneGtOjZpo3gaTcMo=;
        b=qY8PnW/BsmIoEZTII8HVKMb9xGDgq3LDaPL8/X0NdePJKmPjBhECz0o7PYyHBJAOQL
         3HFVEVqHNfj7/YcJB3honIQC13v6/Jm73fmvR9a2e9v3hICkWrcCcxuUAFAh4Ep+VMNh
         5tf6LOyJcbJNBftRrWSJJMIok8xB3p8zBJyscBiJnbAqhVDIzXCiCwsXdJpvG7TWZlBR
         j8xA3npAwj3oxFTWtDZqcuk75D6s/BgNSAhXCtCOP3m1SNSmaU+rmNXUzYO82bRYGbug
         dY0CelD2hh9eHoqlNZ5FzZ5dnQFPUP2uu1+QdKMQOs2e8y7+eEiMvh6x6R2ltixzZSZc
         VOEg==
X-Forwarded-Encrypted: i=1; AJvYcCW83JVXssv8t2rMfhFELKTy9K3pVmznDQqtwtAbF7eEkkO2P4CX2++JBRr//+6MRb1HYK5H5uU2KxpzUsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKMLkQKBiLWG7088ibt9OoE9CIJ4bAfZgOyZnrgvNXsuZcCLVp
	USvACFf8TXB47zmxR9hO7KhZ/z+Fizuz6lgFAMLVUS3qEFKh39q0IpNy6Lo+3B9B
X-Gm-Gg: ASbGncvHsVIORbkbnNaXxrqQdn9ccxeIceU3ANqRVVWoJZ+B+BEdaXo6ZLvKf+KfWEV
	GSu9VWuHIj8XPuMjhWvwUiyCq4+kr0sV9IpY6qR2DDoLKxzRGrwRuZfpUztlSvTHT9ZfqDbsMMd
	+L6+EcybXnQ4iozA65WypEx8rYTY06Ai2jr0Df1Fj63njD4t2v6yPmCmjVvgg9aiitkQCitt6yI
	55LE9Sky3x9PlRpP1SXkdW9f2+sSOSTg6tRREkiics9xqj+4BnPunn25Fe+bdniIGN6NO8SMbZp
	4x78YHZt+OcgMufaHnlQslHGtap0Gmk3ruABzkAl7egNQu2AeOLaaH6j14AhgRJBVn48p0P01ds
	+7y+lsCoT2o3Rx1vVuu12jWuvQXbgp0tJCSAWfA0QAFReFf0w1RYPuMTbJ+qvOE0LExs8BtAtPk
	oHfum8VKARGmWzs6nOn2cVVjCgvr+zHRAIZzA=
X-Google-Smtp-Source: AGHT+IEL6ii9KnkIQBAerVn0Vg+xnY1ZhmA6A7rv/13jR+aG1nOdbS7HiWtqv1Golb0GwzDp3Xs8nQ==
X-Received: by 2002:a17:90b:2887:b0:32e:5cba:ae26 with SMTP id 98e67ed59e1d1-33bcf8fa1aamr1327937a91.23.1760648748582;
        Thu, 16 Oct 2025 14:05:48 -0700 (PDT)
Received: from [172.16.0.242] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22b7a625sm3812966a12.24.2025.10.16.14.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 14:05:48 -0700 (PDT)
Message-ID: <565422eb-d5fc-4b84-9a8b-6f36df39b8e2@gmail.com>
Date: Thu, 16 Oct 2025 14:09:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] irqchip/plic: add support for UltraRISC DP1000
 PLIC
To: Lucas Zampieri <lzampier@redhat.com>, linux-kernel@vger.kernel.org
Cc: Charles Mirabile <cmirabil@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang <dramforever@live.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 Zhang Xincheng <zhangxincheng@ultrarisc.com>
References: <20251016084301.27670-1-lzampier@redhat.com>
 <20251016084301.27670-4-lzampier@redhat.com>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <20251016084301.27670-4-lzampier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lucas,

Please see my comments below.

On 10/16/25 01:42, Lucas Zampieri wrote:
> From: Charles Mirabile <cmirabil@redhat.com>
> 
> Add a new compatible for the plic found in UltraRISC DP1000 with a quirk to
> work around a known hardware bug with IRQ claiming in the UR-CP100 cores.
> 
> When claiming an interrupt on UR-CP100 cores, all other interrupts must be
> disabled before the claim register is accessed to prevent incorrect
> handling of the interrupt. This is a hardware bug in the CP100 core
> implementation, not specific to the DP1000 SoC.
> 
> When the PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM flag is present, a specialized
> handler (plic_handle_irq_cp100) saves the enable state of all interrupts,
> disables all interrupts except for the first pending one before reading the
> claim register, and then restores the interrupts before further processing of
> the claimed interrupt continues.
> 
> The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
> SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
> This has no impact on other platforms.
> 
> Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
> Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Acked-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> ---
>   drivers/irqchip/irq-sifive-plic.c | 94 ++++++++++++++++++++++++++++++-
>   1 file changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index bf69a4802b71..0428e9f3423d 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -49,6 +49,8 @@
>   #define CONTEXT_ENABLE_BASE		0x2000
>   #define     CONTEXT_ENABLE_SIZE		0x80
>   
> +#define PENDING_BASE                    0x1000
> +
>   /*
>    * Each hart context has a set of control registers associated with it.  Right
>    * now there's only two: a source priority threshold over which the hart will
> @@ -63,6 +65,7 @@
>   #define	PLIC_ENABLE_THRESHOLD		0
>   
>   #define PLIC_QUIRK_EDGE_INTERRUPT	0
> +#define PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM	1
>   
>   struct plic_priv {
>   	struct fwnode_handle *fwnode;
> @@ -394,6 +397,89 @@ static void plic_handle_irq(struct irq_desc *desc)
>   	chained_irq_exit(chip, desc);
>   }
>   
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

No need to start from group 0. Only readl on the group with ie[i] != 0

> +	}
> +
> +	if (!pending_irqs)
> +		return false;
> +
> +	/* Disable all interrupts but the first pending one */
> +	for (j = 0; j < nr_irq_groups; j++) {
> +		u32 new_mask = 0;
> +
> +		if (j == i) {
> +			/* Extract mask with lowest set bit */
> +			new_mask = (pending_irqs & -pending_irqs);
> +		}
> +
> +		writel_relaxed(new_mask, enable + j * sizeof(u32));

There's no need to write the register if the value isn't changing. You can
check new_mask with the value in ie[].

> +	}
> +
> +	return true;
> +}
> +
> +static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler,
> +					void __iomem *claim)
> +{
> +	int nr_irq_groups = DIV_ROUND_UP(handler->priv->nr_irqs, 32);
> +	void __iomem *pending = handler->priv->regs + PENDING_BASE;
> +	void __iomem *enable = handler->enable_base;
> +	irq_hw_number_t hwirq = 0;
> +	int i;
> +
> +	guard(raw_spinlock)(&handler->enable_lock);
> +
> +	/* Save current interrupt enable state */
> +	for (i = 0; i < nr_irq_groups; i++)
> +		handler->enable_save[i] = readl_relaxed(enable + i * sizeof(u32));

Here we need to read all the enabled bits from HW register. What about if we 
keep the handler->enable_save in sync with HW? I.e., enable_save tracks the
HW enable registers and we maintain it per each irq toggle. In this way, we
don't need to read them at all. We'll introduce more overhead with irq_toggle,
but they are not frequent. Thus, we can move this reading of ie[] away from
hot-path.

> +
> +	if (!cp100_isolate_pending_irq(nr_irq_groups, handler->enable_save, pending, enable))
> +		return 0;
> +
> +	hwirq = readl(claim);

Possibly missing a io barrier. readl isn't going to enforce the ordering of 
writel_relaxed above and itself. There could be other barriers missing. Please 
check.

> +
> +	/* Restore previous state */
> +	for (i = 0; i < nr_irq_groups; i++)
> +		writel_relaxed(handler->enable_save[i], enable + i * sizeof(u32));
> +
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
> +		int err = generic_handle_domain_irq(handler->priv->irqdomain, hwirq);
> +
> +		if (unlikely(err)) {
> +			pr_warn_ratelimited("%pfwP: can't find mapping for hwirq %lu\n",
> +					    handler->priv->fwnode, hwirq);
> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
>   static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
>   {
>   	/* priority must be > threshold to trigger an interrupt */
> @@ -430,6 +516,8 @@ static const struct of_device_id plic_match[] = {
>   	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>   	{ .compatible = "thead,c900-plic",
>   	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> +	{ .compatible = "ultrarisc,cp100-plic",
> +	  .data = (const void *)BIT(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM) },
>   	{}
>   };
>   
> @@ -664,12 +752,16 @@ static int plic_probe(struct fwnode_handle *fwnode)
>   		}
>   
>   		if (global_setup) {
> +			void (*handler_fn)(struct irq_desc *) = plic_handle_irq;
> +
> +			if (test_bit(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM, &handler->priv->plic_quirks))
> +				handler_fn = plic_handle_irq_cp100;
> +
>   			/* Find parent domain and register chained handler */
>   			domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
>   			if (domain)
>   				plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
>   			if (plic_parent_irq)
> -				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
> +				irq_set_chained_handler(plic_parent_irq, handler_fn);
>   
>   			cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
>   					  "irqchip/sifive/plic:starting",

My rationale of the above comments is to achieve minimal overhead with this 
"read pending[] -> disable IE[] -> claim -> enable IE[]" approach. In general, 
the fewer interrupts enabled on a hart, the lower the overhead. If there's only 
1 interrupt enabled for a give hart, then there's zero reading/writing of IE[], 
and you can further optimize away the reading of pending register. If you chose
to use enable_save to track HW as I've described above, we should document it
well, because enable_save is only used by suspend/resume without this quirk.

I'd imagine that if the user truly want to avoid the overhead of this quirk, 
they can chose to spread out the irq groups onto different harts to alleviate 
the slow down, or better isolate a single irq to a given hart, and we should
make it possible.

Feel free to point out any of my misunderstandings.

Bo

