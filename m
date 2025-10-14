Return-Path: <linux-kernel+bounces-853124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8CDBDAAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD02B19A5210
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BAA3043C7;
	Tue, 14 Oct 2025 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="X+q/I94P"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE98E303C94
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460354; cv=none; b=AuX0GKyee2Hx90+GeUMCEENcUsCl6+xuslVwJs0s+zSh8tihwgCmPpjbVJ1c1REPjRPBP6E5iO4FCb40z1Z6oGTbvg6wKvcuBeHWYWYOAmBEG7SLirs/meyYX8HHGkqJtd6BnIDT/BMOHCkvFGDaglehkfir292oiPgz/p8TTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460354; c=relaxed/simple;
	bh=a5KLLkQhZ6b6E2j8llYD9a+xUbKHciW/VaWYlyPtDQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVbLshL03r8F4NM/CeG+TKXhVpk+FLet6D6kICWGKKMXH1BMbrojCXao1g6PXq+NIpzQaaMNwrjEWObZlr3bjT9NV/OZau33S/M/V4j/GP7S2+xn6ebmQIYJefKd/q95PnMtvxBlKU0Qe7rvU96QxDV4Dxdia1WX+hv8hA1I70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=X+q/I94P; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42f8b7cd7e5so22262955ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760460352; x=1761065152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3x8DtjbkWRFFFDpgqN2nIQDJb7THzH/v/Cgr1oRo74=;
        b=X+q/I94P0lemUIm4of2cnmLLBG6bzj/Ak73fz6i2XLRJXWix+LxnmwTYJIB8YO3TIA
         iSXDfeQkGuzdQFkBobRC4IebG0uoZLhy0Mad96gHwflXkfwjEHGQH7GY2IBLAkDk3BVU
         NXUugQeimvkTr/SHjjL25dR0osuKjlRlnI/5hbWBohogfzrqWCe8QP1ucOHQqCszxgf5
         czzuNzIKj5n9w0qrOEVVlUGcbk20hSD6SFM8OMkALSdv41BVEeMbk+EsBMAyn+EOJhgZ
         qllyW/hM5y0Vwkyerxg3QJoCVWArN4qrRwngWpS8QINoELcqeZKXyt63k7+2scnoj9Br
         PklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760460352; x=1761065152;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3x8DtjbkWRFFFDpgqN2nIQDJb7THzH/v/Cgr1oRo74=;
        b=GalN7EFbF0OoGlX4w+/tnuaJEk3HOgAXxXfGfnhzlS95N+Dq9mYiGA18ftllitNS0+
         ANTsARldcVvrZxt546QSsa90cVV03nglnPOMWndx4UfXObZ9ccuikYCIJZpvApi37pAN
         ACe9644rgo28oII4uuzVVN97glpPw+oVkyk8de9ZZ7gXSCzajkoEBrJdPmEODK6CEdpR
         Kmq/j9ChE9hQzN4jWhYkqN58JnqbA2dKCnJeCUX+R2dAfvDfPwH9I7EpNc8DooNPAv6A
         476rY4mpq4eL/LKuCzD75dYf/r7tVOSlhmhYlGlh2NCCmBhOw+BEJelvoRARaoPbnncE
         V4YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO4S1F1AAyeiUS9GUU2XXiUW6132KO9vD45M2b2p/IW7NHkab8Tj1QuRbSs6sYMi6aaT9jycn3rkJUjNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/NaNBk1+g6UOtlEl+zl+tzJqY4AhSFfY09mYHkwtC4wppx3mL
	P8Hl8w0sAjQqUZlb4coAXhDdBtX9C/4cXRgG1IM39z1LBmmg7GIqJDoPORVdC57MGkI=
X-Gm-Gg: ASbGnctxDMPmSY4KHX2u5zINGRZCmXCFWg4lLQBbuUVaavHLGvcP7UmzegU+5gsqVDA
	ajn1zVDtWpOsVD9lMZMeW967bz2h43YYhZVXyg13xRppo4/A5bGwS7uBN//AcSgQxmQXrUFeGgt
	6rB6o5CmMVbi/rb980WvsiPEHBBsc0FRqJ1j1Q7OkCpNwOYHaoH0yez31iuusG9pdXP7RP0WZpT
	EisRGGpHmHSm+bapuNdto4qx9kiAKoLvRZD7F7WKAqIl+clS5E7SfN/g5DkDZ4VK0ZtFYB0QgPf
	Ozo8Mi42wgrjlMR3ahcY7GyBWabvqhH1SFaTHnyf+R1fiuCM8aaHiOGzw+/wWbngqBEQGfxq5O/
	97AvKJOa7VCCBTNWv4i17mtd4dgslemOByKxkjRC+yIuVfWC1/x7wy02DXg==
X-Google-Smtp-Source: AGHT+IGBgLqyCovBEgClBM4VxYytju8tGxQfK+EmVV5Z5Zrw6KzipXrwTBu4B6RhdhOF65igc2cboQ==
X-Received: by 2002:a05:6e02:1529:b0:42d:8bc6:d163 with SMTP id e9e14a558f8ab-42f8736a9eamr256964205ab.9.1760460351654;
        Tue, 14 Oct 2025 09:45:51 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.208])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c49553esm4893248173.15.2025.10.14.09.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 09:45:51 -0700 (PDT)
Message-ID: <b50745b9-6b45-4364-aff8-3c10c7cadf3c@sifive.com>
Date: Tue, 14 Oct 2025 11:45:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] irqchip/plic: add support for UltraRISC DP1000
 PLIC
To: Charles Mirabile <cmirabil@redhat.com>
Cc: Lucas Zampieri <lzampier@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang <dramforever@live.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 Zhang Xincheng <zhangxincheng@ultrarisc.com>, linux-kernel@vger.kernel.org
References: <20251014154100.168236-1-lzampier@redhat.com>
 <20251014154100.168236-4-lzampier@redhat.com>
 <b58b2705-a1b4-4d71-8b76-e2bba4df6987@sifive.com>
 <CABe3_aECh-d9=O7yJjKuCffBMQ4c2XBYOoqAZa8vqR-PSfWnbA@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CABe3_aECh-d9=O7yJjKuCffBMQ4c2XBYOoqAZa8vqR-PSfWnbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Charles,

On 2025-10-14 11:28 AM, Charles Mirabile wrote:
> On Tue, Oct 14, 2025 at 12:09 PM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>
>> On 2025-10-14 10:40 AM, Lucas Zampieri wrote:
>>> From: Charles Mirabile <cmirabil@redhat.com>
>>>
>>> Add a new compatible for the plic found in UltraRISC DP1000 with a quirk to
>>> work around a known hardware bug with IRQ claiming in the UR-CP100 cores.
>>>
>>> When claiming an interrupt on UR-CP100 cores, all other interrupts must be
>>> disabled before the claim register is accessed to prevent incorrect
>>> handling of the interrupt. This is a hardware bug in the CP100 core
>>> implementation, not specific to the DP1000 SoC.
>>>
>>> When the PLIC_QUIRK_CLAIM_REGISTER is present, a specialized handler
>>
>> You may want to name this something a bit more specific. Every PLIC has a claim
>> register, so it seems a bit weird saying that this is a quirk :)
> 
> Something like `PLIC_QUIRK_CLAIM_REGISTER_ERRATA`? Or
> `PLIC_QUIRK_CP100_CLAIM_REGISTER`? Or
> `PLIC_QUIRK_MULTIPLE_PENDING_CLAIM`? I guess the trouble is that they
> get pretty long pretty quick. Hard to summarize the issue concisely.

If I had to suggest something, I'd say PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM,
but it's really up to you. The function name indicates it is specific to CP100,
so the flag probably should too. I don't think being long is a problem if it
helps the reader guess the value/effect of the flag at a glance.

Regards,
Samuel

>>
>> Anyway, the code looks good, so:
>>
>> Acked-by: Samuel Holland <samuel.holland@sifive.com>
> 
> Thanks!
> 
>>
>>> (plic_handle_irq_cp100) saves the enable state of all interrupts, disables
>>> all interrupts except for the first pending one before reading the claim
>>> register, and then restores the interrupts before further processing of
>>> the claimed interrupt continues.
>>>
>>> The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
>>> SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
>>> This has no impact on other platforms.
>>>
>>> Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
>>> Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
>>> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
>>> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
>>> ---
>>>  drivers/irqchip/irq-sifive-plic.c | 94 ++++++++++++++++++++++++++++++-
>>>  1 file changed, 93 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>>> index bf69a4802b71..1d528904b353 100644
>>> --- a/drivers/irqchip/irq-sifive-plic.c
>>> +++ b/drivers/irqchip/irq-sifive-plic.c
>>> @@ -49,6 +49,8 @@
>>>  #define CONTEXT_ENABLE_BASE          0x2000
>>>  #define     CONTEXT_ENABLE_SIZE              0x80
>>>
>>> +#define PENDING_BASE                    0x1000
>>> +
>>>  /*
>>>   * Each hart context has a set of control registers associated with it.  Right
>>>   * now there's only two: a source priority threshold over which the hart will
>>> @@ -63,6 +65,7 @@
>>>  #define      PLIC_ENABLE_THRESHOLD           0
>>>
>>>  #define PLIC_QUIRK_EDGE_INTERRUPT    0
>>> +#define PLIC_QUIRK_CLAIM_REGISTER    1
>>>
>>>  struct plic_priv {
>>>       struct fwnode_handle *fwnode;
>>> @@ -394,6 +397,89 @@ static void plic_handle_irq(struct irq_desc *desc)
>>>       chained_irq_exit(chip, desc);
>>>  }
>>>
>>> +static bool cp100_isolate_pending_irq(int nr_irq_groups, u32 ie[],
>>> +                                    void __iomem *pending,
>>> +                                    void __iomem *enable)
>>> +{
>>> +     u32 pending_irqs = 0;
>>> +     int i, j;
>>> +
>>> +     /* Look for first pending interrupt */
>>> +     for (i = 0; i < nr_irq_groups; i++) {
>>> +             pending_irqs = ie[i] & readl_relaxed(pending + i * sizeof(u32));
>>> +             if (pending_irqs)
>>> +                     break;
>>> +     }
>>> +
>>> +     if (!pending_irqs)
>>> +             return false;
>>> +
>>> +     /* Disable all interrupts but the first pending one */
>>> +     for (j = 0; j < nr_irq_groups; j++) {
>>> +             u32 new_mask = 0;
>>> +
>>> +             if (j == i)
>>> +                     /* Extract mask with lowest set bit */
>>> +                     new_mask = (pending_irqs & -pending_irqs);
>>> +
>>> +             writel_relaxed(new_mask, enable + j * sizeof(u32));
>>> +     }
>>> +
>>> +     return true;
>>> +}
>>> +
>>> +static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler,
>>> +                                     void __iomem *claim)
>>> +{
>>> +     void __iomem *enable = handler->enable_base;
>>> +     void __iomem *pending = handler->priv->regs + PENDING_BASE;
>>> +     int nr_irqs = handler->priv->nr_irqs;
>>> +     int nr_irq_groups = DIV_ROUND_UP(nr_irqs, 32);
>>> +     int i;
>>> +     irq_hw_number_t hwirq = 0;
>>> +
>>> +     raw_spin_lock(&handler->enable_lock);
>>> +
>>> +     /* Save current interrupt enable state */
>>> +     for (i = 0; i < nr_irq_groups; i++)
>>> +             handler->enable_save[i] = readl_relaxed(enable + i * sizeof(u32));
>>> +
>>> +     if (!cp100_isolate_pending_irq(nr_irq_groups, handler->enable_save, pending, enable))
>>> +             goto out;
>>> +
>>> +     hwirq = readl(claim);
>>> +
>>> +     /* Restore previous state */
>>> +     for (i = 0; i < nr_irq_groups; i++)
>>> +             writel_relaxed(handler->enable_save[i], enable + i * sizeof(u32));
>>> +out:
>>> +     raw_spin_unlock(&handler->enable_lock);
>>> +     return hwirq;
>>> +}
>>> +
>>> +static void plic_handle_irq_cp100(struct irq_desc *desc)
>>> +{
>>> +     struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
>>> +     struct irq_chip *chip = irq_desc_get_chip(desc);
>>> +     void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
>>> +     irq_hw_number_t hwirq;
>>> +
>>> +     WARN_ON_ONCE(!handler->present);
>>> +
>>> +     chained_irq_enter(chip, desc);
>>> +
>>> +     while ((hwirq = cp100_get_hwirq(handler, claim))) {
>>> +             int err = generic_handle_domain_irq(handler->priv->irqdomain,
>>> +                                                 hwirq);
>>> +             if (unlikely(err)) {
>>> +                     pr_warn_ratelimited("%pfwP: can't find mapping for hwirq %lu\n",
>>> +                                         handler->priv->fwnode, hwirq);
>>> +             }
>>> +     }
>>> +
>>> +     chained_irq_exit(chip, desc);
>>> +}
>>> +
>>>  static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
>>>  {
>>>       /* priority must be > threshold to trigger an interrupt */
>>> @@ -430,6 +516,8 @@ static const struct of_device_id plic_match[] = {
>>>         .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>>>       { .compatible = "thead,c900-plic",
>>>         .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>>> +     { .compatible = "ultrarisc,cp100-plic",
>>> +       .data = (const void *)BIT(PLIC_QUIRK_CLAIM_REGISTER) },
>>>       {}
>>>  };
>>>
>>> @@ -664,12 +752,16 @@ static int plic_probe(struct fwnode_handle *fwnode)
>>>               }
>>>
>>>               if (global_setup) {
>>> +                     void (*handler_fn)(struct irq_desc *) = plic_handle_irq;
>>> +                     if (test_bit(PLIC_QUIRK_CLAIM_REGISTER, &handler->priv->plic_quirks))
>>> +                             handler_fn = plic_handle_irq_cp100;
>>> +
>>>                       /* Find parent domain and register chained handler */
>>>                       domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
>>>                       if (domain)
>>>                               plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
>>>                       if (plic_parent_irq)
>>> -                             irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
>>> +                             irq_set_chained_handler(plic_parent_irq, handler_fn);
>>>
>>>                       cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
>>>                                         "irqchip/sifive/plic:starting",
>>
> 


