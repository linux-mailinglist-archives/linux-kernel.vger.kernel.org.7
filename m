Return-Path: <linux-kernel+bounces-853064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D93BDA918
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF5454630D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B623016EA;
	Tue, 14 Oct 2025 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="m6IGRwZA"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B04221FCB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458153; cv=none; b=Zp10LACD6toYXo5aYHQVzHzuOqVTvTqnOo0WlJCHkAnkltFBkY/P1TL4ChcpVdSz2t7m8IhYCs++DgXIdDWxNFrUBRqE00ZugxXSa+UWqlH3LwW6HY5v82AslW3NaC5IsopODX2yfvzck/UUDdKzn2CGcwRcd6jM73Nhb8Ibvq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458153; c=relaxed/simple;
	bh=vI/HA29EzGIBPGI5M+Onivig7KOJp/tMhJYSeUKOUEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8725+8LkrToViU+7TmGOgOVuHNMLv9Uq1WPKyB2BUgVuBuhlhiikcdxeHhEIiJGyySfXLW9yprSQZV9dmNtR2+dQ9hnuu2FxcXI8/YH8qkZU9BBLeAHy0x055ite1yV1c0d3kCHe5b+h0zkNJ/DbGgsOQxvPH0P9jBWU7YH55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=m6IGRwZA; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-42f67e91ae7so57586625ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760458151; x=1761062951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/56Sp040rDsPp3z3aaVtrpaepoT3obZVyIP0xy0kutY=;
        b=m6IGRwZAik2N332EZtp776Iy0w+uCc0kIYfc9iBJ8kl2vAH4Fq+ngMRW7rJ3pRKJST
         dd/avbtDnrwJGGJdc3o/a7UdENFJiip+QkISYwIILWmNMH1707kGvsPK4UfUi7qyimsx
         YmFmShzweSzRwrhdKVMqjThy3OZQhktm4MTMgSmv2sEuA7rDuxx40ILg5YXmbGLC/LlI
         9uaZ3B2RLbp7giWWXLT8TM8ftnST2XMWEWR7uJrH0B63bW/PJbupg/eHrbmnuQAX/JpK
         nh+KcJd35u7JMNRJwIGGG+hJd+e43PLDUXgeaEzmpqt1Jtek6UQ/WuWYaa96mTp2IFIp
         SuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760458151; x=1761062951;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/56Sp040rDsPp3z3aaVtrpaepoT3obZVyIP0xy0kutY=;
        b=b9Sm8OIxF3lHYQJsFlhFQTBh04fQCNQ1FOVf9CXi0yExdTB76CjCzQBcsaaLo04pd8
         +7jhSo1WvHN5NR5yLs7jOFE6ddj1/tXkvSYHTYysPMykw8tIlLmeBmCkTsK47RGy/Pkw
         4tVhq1LTP7rPa6vUUA3HTMG6JJD4L4V8gUUm/OCnPQoMwCvph/pMHF+AS6RMsovEwAgt
         pUgKX0duXoacPfVQVDJk2ZITZjLgQEOBERAZFyCfS//qFBv6PSvfF4ZHQdMTVB0uQ7vA
         t7Szx5yeftB0fTr+C48eQxrn/JwAWMaya9U92JZ6XtC8i48rCVtBU3OiSquW/darBcQG
         VkoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOaQDYZiMumIKX3VWqB5o+s9qOmutfK/t5HZqKp+OGH2cEcsvWqtXh+KIzeu3h8lIebRZ7l3bxAL5LISo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPobifo0fsgg3xyd90tdIHAaynVJtKMpK95JEMGE+KoaLapQrc
	KbPdbi/8aoGItr9oFwq2uqmgNpXFkK6yZbgtK3Q4CJXv+BPHafmV+0D1UhNUPJJSNoY=
X-Gm-Gg: ASbGncu8/qk3y/Y4658WHMF/EOSZxOpGQ2yCeaDY008hp6NSYNnjQEzfkqeMaLWeRzQ
	ziKFij8Wh+MjM5xX1b/vxJc3xwBkcfaAmPXvFywka2vEcLi4eZ/PF29vPDSDL/6b6FEZXvfx8PY
	P9y/IZgqSpfzfovTAeyk3Xh1lb1ECp6D6lfMSXCPQLVp98rNPc38hR6ONG6ODDgJnafHW25DNs3
	7egoCWt8zraT85Kz8I1g4SBjE4kTxMoN6UH18R6OCQ0DAuxXS8DMXjAePntSlMqEIN9Aa6ZSMWT
	GQgsLFzF99pQZL+0fPn8n2LUYCF1T9kEktD1OS77otJHQVfrvTDO3ZMGVMQ6ZUsTxqirOihR1p2
	6W7faWyrb/NmucUF1+hpkncDW5f5zqXmgpTNag5CiTDXtu3sejMrFaQAmLV3u5+yb+e9a
X-Google-Smtp-Source: AGHT+IF2rM5N57cc9e87vSQgs53jlX3hESnb8bjcQJckI0u09+/PvPrRQAWm3vnphVNgXUCUPAT9Lw==
X-Received: by 2002:a05:6e02:1688:b0:42f:953c:6d59 with SMTP id e9e14a558f8ab-42f953c6db7mr210550045ab.24.1760458150581;
        Tue, 14 Oct 2025 09:09:10 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.208])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430a4b94dbdsm6044085ab.13.2025.10.14.09.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 09:09:10 -0700 (PDT)
Message-ID: <b58b2705-a1b4-4d71-8b76-e2bba4df6987@sifive.com>
Date: Tue, 14 Oct 2025 11:09:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] irqchip/plic: add support for UltraRISC DP1000
 PLIC
To: Lucas Zampieri <lzampier@redhat.com>
Cc: Charles Mirabile <cmirabil@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang <dramforever@live.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 Zhang Xincheng <zhangxincheng@ultrarisc.com>, linux-kernel@vger.kernel.org
References: <20251014154100.168236-1-lzampier@redhat.com>
 <20251014154100.168236-4-lzampier@redhat.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20251014154100.168236-4-lzampier@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-14 10:40 AM, Lucas Zampieri wrote:
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
> When the PLIC_QUIRK_CLAIM_REGISTER is present, a specialized handler

You may want to name this something a bit more specific. Every PLIC has a claim
register, so it seems a bit weird saying that this is a quirk :)

Anyway, the code looks good, so:

Acked-by: Samuel Holland <samuel.holland@sifive.com>

> (plic_handle_irq_cp100) saves the enable state of all interrupts, disables
> all interrupts except for the first pending one before reading the claim
> register, and then restores the interrupts before further processing of
> the claimed interrupt continues.
> 
> The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
> SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
> This has no impact on other platforms.
> 
> Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
> Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 94 ++++++++++++++++++++++++++++++-
>  1 file changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index bf69a4802b71..1d528904b353 100644
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
> @@ -394,6 +397,89 @@ static void plic_handle_irq(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
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
> +
> +		writel_relaxed(new_mask, enable + j * sizeof(u32));
> +	}
> +
> +	return true;
> +}
> +
> +static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler,
> +					void __iomem *claim)
> +{
> +	void __iomem *enable = handler->enable_base;
> +	void __iomem *pending = handler->priv->regs + PENDING_BASE;
> +	int nr_irqs = handler->priv->nr_irqs;
> +	int nr_irq_groups = DIV_ROUND_UP(nr_irqs, 32);
> +	int i;
> +	irq_hw_number_t hwirq = 0;
> +
> +	raw_spin_lock(&handler->enable_lock);
> +
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
> +	  .data = (const void *)BIT(PLIC_QUIRK_CLAIM_REGISTER) },
>  	{}
>  };
>  
> @@ -664,12 +752,16 @@ static int plic_probe(struct fwnode_handle *fwnode)
>  		}
>  
>  		if (global_setup) {
> +			void (*handler_fn)(struct irq_desc *) = plic_handle_irq;
> +			if (test_bit(PLIC_QUIRK_CLAIM_REGISTER, &handler->priv->plic_quirks))
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


