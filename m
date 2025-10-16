Return-Path: <linux-kernel+bounces-857051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 63387BE5C60
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BAE7A355BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CD325291B;
	Thu, 16 Oct 2025 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7ntGdLG"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26C61CEAD6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760656592; cv=none; b=N+6IMa0Hh29woyplm9KybJJ1pC032NU/2ntXWBjuYQZsJUbwygORkr6zIR0X2fFw0tJ3tiVAEEt9YLCrJjcd0g+AMPnZM8pSyA3C0dVt7X01aHsSjbIOw84V5Ww7oiYQ3pwXV1D9+JZiP6+Pqlxj4Wx1e14aHyU4pJ98up6m+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760656592; c=relaxed/simple;
	bh=upjbPB6DTd2eAPDo7wFnSOj/2yeDbk2CtEo/BlT0wDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McGft5L+tl0skOalM3qyE4uzV6njWLRdQcM4+tWeBzg9fp1OZdjQRx7OF9i/nCkmi7KF1346uvH0o3jiTobHrNJwBGyQ7Yt//fSvj7qYGXQdR1jl7mEmxcme5VxNPy9S+A2G23loqnUphTWyBx7TUdKddTTYkGye4jOBIpseKbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7ntGdLG; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b554bb615dcso935834a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760656590; x=1761261390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/a+qqdPVmjqV2OGXo1EbYLdYhsnJczk1bqRHKiDFhY4=;
        b=F7ntGdLGW7ZSQaQszoKm3ZuQa/QNZzE3ERB8y1L0shHdCvlJHHn+6A7ayBWGl7uxva
         aRQ3JZNrSwWMSuLWmAhHmxl+jDWtIdazc38pVIENW+io8OzTmsejiZJjx3AeectDevvw
         38KUSdMwq8R1idurRqawttpmpRNmJacWm1KPpEBTBNUBEV3dVi5Ro4vxremcHOQWkMQM
         XoPDWdHEz3uBC5z9Dk0+fwbxEFldgu7pD+NelWbGbbrtcY/iWugIJrWeIbP3QI/DXW7M
         +AktLMey4EDYRNVpBHMA+El59jcQKJneZ5/V6fRGgDsSqFiDkL5iwcvgdTdjAsfoo+Mq
         G0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760656590; x=1761261390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/a+qqdPVmjqV2OGXo1EbYLdYhsnJczk1bqRHKiDFhY4=;
        b=ak8Ox/ZdTqvPYg3qF2mby8se5XxT/b1jPh7Ee0Lw7SW4qLncwGG/TEl6zpPQftI0+7
         wqgDPplZCOiDg6TXlFqeorenS16VGYG+z0iN9Pxvb1Ibl0IN3NvRwL2kHlVpe8a4tJjx
         N4tHyacBD1icEdop0giaIv8Odx8eYNBdZCbg9ithr0fCkjEiSZsWSys1Lwj/X/NgsTMt
         /fBSms+lfVuPm2/Re57v0qQMOYvi6e+yIl19NwxaO3kXAeOH2ScZiMRdGtlymGnFxpi6
         hfIZc/1/wl3EgDZJXaTbOtwN9YS1p3CcvKR3isbFATJeygf44P9/HqXr5wcf9/MB68ib
         jZHA==
X-Forwarded-Encrypted: i=1; AJvYcCVmD5WxsEIIk+p4FbE7ZgAXARG7tJ4ycfBPBpN3K6M6RboJUAYR71DRxoKNq2SpFO/op13966i9YgAh8xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywho9fRveEnOe/oXxXr0256oRACR7X4VP/Mt+3J0NPRBvNQvWZ8
	UxDDANzbynWeX/uy6/ExCcI48RBhhBVs8uP4Y8/FRzUsiBVJbVA56oYe
X-Gm-Gg: ASbGnctQNA9gjOmfNk9Lo/LTzGCQ4LMW8PVHTqfJcoKB2Zm6FPWikLlYA3OU8exWjht
	mQn1bSl/uWocTLo6N/I62Zn6ORVRuv4NO0NOlqGBaXhctxx4/aYQdcDkpuytTxhJqR9H8+WW052
	zHFQ8NECOVUPJyRAwsS0+m6PqhbcShmpcHhv44VWfV9MLbsVPs/0RghirZa6SrjVWwxI22fGsS6
	dxUq8xTzbTEiDMwCCM0vSA2F7s0/yYwfoChhfnLOcGkGNb/jEZ5N2/Tx0dSer3ebgkza5g0Kl/+
	d9N7Alei9aVg2DdA4T/CvAD9U1CkFRoQdY3IV9Kie/1B4BCmg9MdubIHVNz28vpOExqD8MrpOFx
	xbUOikvqRrX8JgBq5Rd7ExnAIweXuOMA8Yy1GQB7FxvDFDuHGuUFoKZa9WyVo+zLwnPF8d+6SqX
	AXcSA6ZWoMd8ogWjsivIgs7SjpHxUDXUUyyLw=
X-Google-Smtp-Source: AGHT+IGvciSnN+zR7+38ggCqYBNxU45unPBKyeAyCkOvXXXe6c3Mc9N3D3t2Q8bN895H8fJj9a/MAg==
X-Received: by 2002:a17:903:1a4c:b0:267:ba92:4d19 with SMTP id d9443c01a7336-290c99a8ed3mr21441465ad.0.1760656589902;
        Thu, 16 Oct 2025 16:16:29 -0700 (PDT)
Received: from [172.16.0.242] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab1ca0sm42189905ad.96.2025.10.16.16.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 16:16:29 -0700 (PDT)
Message-ID: <62e709f0-5841-40d6-97cd-91da3ba556e8@gmail.com>
Date: Thu, 16 Oct 2025 16:19:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] irqchip/plic: add support for UltraRISC DP1000
 PLIC
To: Samuel Holland <samuel.holland@sifive.com>, Bo Gan <ganboing@gmail.com>,
 Lucas Zampieri <lzampier@redhat.com>
Cc: Charles Mirabile <cmirabil@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang <dramforever@live.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 Zhang Xincheng <zhangxincheng@ultrarisc.com>, linux-kernel@vger.kernel.org
References: <20251016084301.27670-1-lzampier@redhat.com>
 <20251016084301.27670-4-lzampier@redhat.com>
 <831744c6-ba89-4029-a035-9a70c3f57465@gmail.com>
 <95a777a7-4998-4451-b271-8450a5b674bb@sifive.com>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <95a777a7-4998-4451-b271-8450a5b674bb@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Samuel,

On 10/16/25 15:01, Samuel Holland wrote:
> Hi Bo,
> 
> On 2025-10-16 4:28 PM, Bo Gan wrote:
>> Hi Lucas, Charles,
>>
>> I just realized your last reply and sorry about the messy formatting.
>> Please disregard the previous one from me and use this one.
>>
>> On 10/16/25 01:42, Lucas Zampieri wrote:
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
>>> When the PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM flag is present, a specialized
>>> handler (plic_handle_irq_cp100) saves the enable state of all interrupts,
>>> disables all interrupts except for the first pending one before reading the
>>> claim register, and then restores the interrupts before further processing of
>>> the claimed interrupt continues.
>>>
>>> The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
>>> SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
>>> This has no impact on other platforms.
>>>
>>> Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
>>> Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
>>> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
>>> Acked-by: Samuel Holland <samuel.holland@sifive.com>
>>> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
>>> ---
>>>    drivers/irqchip/irq-sifive-plic.c | 94 ++++++++++++++++++++++++++++++-
>>>    1 file changed, 93 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-
>>> plic.c
>>> index bf69a4802b71..0428e9f3423d 100644
>>> --- a/drivers/irqchip/irq-sifive-plic.c
>>> +++ b/drivers/irqchip/irq-sifive-plic.c
>>> @@ -49,6 +49,8 @@
>>>    #define CONTEXT_ENABLE_BASE        0x2000
>>>    #define     CONTEXT_ENABLE_SIZE        0x80
>>>    +#define PENDING_BASE                    0x1000
>>> +
>>>    /*
>>>     * Each hart context has a set of control registers associated with it.  Right
>>>     * now there's only two: a source priority threshold over which the hart will
>>> @@ -63,6 +65,7 @@
>>>    #define    PLIC_ENABLE_THRESHOLD        0
>>>      #define PLIC_QUIRK_EDGE_INTERRUPT    0
>>> +#define PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM    1
>>>      struct plic_priv {
>>>        struct fwnode_handle *fwnode;
>>> @@ -394,6 +397,89 @@ static void plic_handle_irq(struct irq_desc *desc)
>>>        chained_irq_exit(chip, desc);
>>>    }
>>>    +static bool cp100_isolate_pending_irq(int nr_irq_groups, u32 ie[],
>>> +                       void __iomem *pending,
>>> +                       void __iomem *enable)
>>> +{
>>> +    u32 pending_irqs = 0;
>>> +    int i, j;
>>> +
>>> +    /* Look for first pending interrupt */
>>> +    for (i = 0; i < nr_irq_groups; i++) {
>>> +        pending_irqs = ie[i] & readl_relaxed(pending + i * sizeof(u32));
>>> +        if (pending_irqs)
>>> +            break;
>>
>> No need to start from group 0. Only readl on the group with ie[i] != 0
>>
>>> +    }
>>> +
>>> +    if (!pending_irqs)
>>> +        return false;
>>> +
>>> +    /* Disable all interrupts but the first pending one */
>>> +    for (j = 0; j < nr_irq_groups; j++) {
>>> +        u32 new_mask = 0;
>>> +
>>> +        if (j == i) {
>>> +            /* Extract mask with lowest set bit */
>>> +            new_mask = (pending_irqs & -pending_irqs);
>>> +        }
>>> +
>>> +        writel_relaxed(new_mask, enable + j * sizeof(u32));
>>
>>
>> There's no need to write the register if the value isn't changing. You can
>> check new_mask with the value in ie[].
>>
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler,
>>> +                    void __iomem *claim)
>>> +{
>>> +    int nr_irq_groups = DIV_ROUND_UP(handler->priv->nr_irqs, 32);
>>> +    void __iomem *pending = handler->priv->regs + PENDING_BASE;
>>> +    void __iomem *enable = handler->enable_base;
>>> +    irq_hw_number_t hwirq = 0;
>>> +    int i;
>>> +
>>> +    guard(raw_spinlock)(&handler->enable_lock);
>>> +
>>> +    /* Save current interrupt enable state */
>>> +    for (i = 0; i < nr_irq_groups; i++)
>>> +        handler->enable_save[i] = readl_relaxed(enable + i * sizeof(u32));
>>
>>
>> I see that you start to use handler->enable_save to track HW in the last reply.
>> I'm about to suggest that. Please send out a new patch, so people can properly
>> review it. There's change to common code path.
>>
>>> +
>>> +    if (!cp100_isolate_pending_irq(nr_irq_groups, handler->enable_save,
>>> pending, enable))
>>> +        return 0;
>>> +
>>> +    hwirq = readl(claim);
>>
>> Possibly missing a io barrier. readl isn't going to enforce the ordering of
>> readl/writel_relaxed above and itself. There could be other barriers missing.
>> Please check.
> 
> There is no missing barrier. Linux requires the hardware to enforce this
> ordering. See the comment in asm/mmio.h:
> 
> /*
>   * Relaxed I/O memory access primitives. These follow the Device memory
>   * ordering rules but do not guarantee any ordering relative to Normal memory
>   * accesses.  These are defined to order the indicated access (either a read or
>   * write) with all other I/O memory accesses to the same peripheral. Since the
>   * platform specification defines that all I/O regions are strongly ordered on
>   * channel 0, no explicit fences are required to enforce this ordering.
>   */
> 
> where "strongly ordered" is defined by the privileged ISA: "accesses to an I/O
> region with strong ordering are generally observed by other harts and bus
> mastering devices in program order."
> 
> Barriers are only needed if there are ordering requirements between I/O accesses
> to multiple MMIO regions, or between I/O and normal memory (e.g. locks and DMA).
> 
> Regards,
> Samuel
> 

Thanks for the clarification. I thought the I/O ordering requirement is more
fine grained in that it only preserves per-register order. Given that it's per
I/O region, my concern was not valid.

>>> +
>>> +    /* Restore previous state */
>>> +    for (i = 0; i < nr_irq_groups; i++)
>>> +        writel_relaxed(handler->enable_save[i], enable + i * sizeof(u32));
>>> +
>>> +    return hwirq;
>>> +}
>>> +
>>> +static void plic_handle_irq_cp100(struct irq_desc *desc)
>>> +{
>>> +    struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
>>> +    struct irq_chip *chip = irq_desc_get_chip(desc);
>>> +    void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
>>> +    irq_hw_number_t hwirq;
>>> +
>>> +    WARN_ON_ONCE(!handler->present);
>>> +
>>> +    chained_irq_enter(chip, desc);
>>> +
>>> +    while ((hwirq = cp100_get_hwirq(handler, claim))) {
>>> +        int err = generic_handle_domain_irq(handler->priv->irqdomain, hwirq);
>>> +
>>> +        if (unlikely(err)) {
>>> +            pr_warn_ratelimited("%pfwP: can't find mapping for hwirq %lu\n",
>>> +                        handler->priv->fwnode, hwirq);
>>> +        }
>>> +    }
>>> +
>>> +    chained_irq_exit(chip, desc);
>>> +}
>>> +
>>>    static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
>>>    {
>>>        /* priority must be > threshold to trigger an interrupt */
>>> @@ -430,6 +516,8 @@ static const struct of_device_id plic_match[] = {
>>>          .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>>>        { .compatible = "thead,c900-plic",
>>>          .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>>> +    { .compatible = "ultrarisc,cp100-plic",
>>> +      .data = (const void *)BIT(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM) },
>>>        {}
>>>    };
>>>    @@ -664,12 +752,16 @@ static int plic_probe(struct fwnode_handle *fwnode)
>>>            }
>>>              if (global_setup) {
>>> +            void (*handler_fn)(struct irq_desc *) = plic_handle_irq;
>>> +
>>> +            if (test_bit(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM, &handler-
>>>> priv->plic_quirks))
>>> +                handler_fn = plic_handle_irq_cp100;
>>> +
>>>                /* Find parent domain and register chained handler */
>>>                domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
>>> DOMAIN_BUS_ANY);
>>>                if (domain)
>>>                    plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
>>>                if (plic_parent_irq)
>>> -                irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
>>> +                irq_set_chained_handler(plic_parent_irq, handler_fn);
>>>                  cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
>>>                          "irqchip/sifive/plic:starting",
>>
>> My rationale of the above comments is to achieve minimal overhead with this
>> "read pending[] -> disable IE[] -> claim -> enable IE[]" approach. In general,
>> the fewer interrupts enabled on a hart, the lower the overhead. If there's only
>> 1 interrupt enabled for a give hart, then there's zero reading/writing of IE[],
>> and you can further optimize away the reading of pending register.
>>
>> I'd imagine that if the user truly want to avoid the overhead of this quirk,
>> they can chose to spread out the irq groups onto different harts to alleviate
>> the slow down, or better isolate a single irq to a given hart, and we should
>> make it possible.
>>
>> Feel free to point out any of my misunderstandings.
>>
>> Bo
> 

Bo

