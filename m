Return-Path: <linux-kernel+bounces-857004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56015BE5A17
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA22547A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4582E229C;
	Thu, 16 Oct 2025 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A3gYDrJm"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE199199385
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652092; cv=none; b=Z5KP/xFsJ0FeXYMYJEE731vYCA0/f1YR+t2/81ROqigfb9xci3vn+/YOO7ZAvvF8KMnru4NFvey565mdIXCgVdpNxfk8O0LohtoyZsh57tSvXXoUngQHPecJGYs9DqxTy7UxOZO3/B3GsUEHENhZ7cFeV57YfzW5uyIoQzhVJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652092; c=relaxed/simple;
	bh=tdPjClI262Zm5tYMT3cr/OeRgdo7FymAe1OpdlIo1tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guwbv2fNIt0j0F/v4gP7UUTtuSbkFsN1bSOp6tkbtXyWdK0ApVaJLVUyt3VOA75AUm0mGZyRI4cW0yy/CCS9oN/BUMsyS/Te/CYyNoc54Pua0QJwfvDyeB3AYKVzoZ0MyDASspKhzV5YIgNzifpQCtctCVODdNaHmS1ftzGy2MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=A3gYDrJm; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-91fbba9a8f5so101782839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760652090; x=1761256890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMl38ifpHYx95j3NO3+X1dV6A44ciq5yhWKFujz48Ms=;
        b=A3gYDrJmpGuoMvTvekyXRcVcG5cC3vIdNjbWS9JrGad769t/h0qEvI0NTdujQwTMXL
         v50m8AICnpnlZvMJdCU6ktzKJDihmme33brRyBbp1UWzb/aKXWWXKR+NLeXna249IJh+
         UJim+jSnZ1EaYcuw1ARHPngqjEtmg63BUS6/NljKskJEPy24U/fk3pUQjW4uieyOdz9w
         5WlC8ufIH1YpSFnqCSpyP1KxDYa49Mf2zOzD+rho8nB1RkwTbyKYsxU2T+SGWpRnfjfP
         eeDiXi21Kcq8NxWcV7gRqBJzHLwk5l0xdQ54mv+U9QM085fqpYb8cX0HF57CtpUSDuZa
         VvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760652090; x=1761256890;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMl38ifpHYx95j3NO3+X1dV6A44ciq5yhWKFujz48Ms=;
        b=mD0sRGLjD8h9AG7V0BbkCnPsR52mQZjGkj/rVyG1Wuw2/V5cAUOAhLWO2fCj/wzozG
         OGjULakFvhsFANHcgagznaV3JYcHg8/gCXT9XFnza6EaKirysxqSjV5c/yq2V68TA1Y7
         japJY3V5s6dyw/4XUTD6oUeY4PnT4VL7O+cCd84hBRkLuFEuu1q6g/pD2VrHZMcq6u78
         MOET9eoIajB2H7BOyQL7Ovk5H95L01kh/PD4iKMwYjeGaltxDPVrd2IKzNtItFAOROr6
         Yk/iV0xHZegkQqw6/c3SdtCByBQgkhcWkGi9EQE6VVsCBxa/OmbTabpqrRKQMbUU7uBF
         fmkA==
X-Forwarded-Encrypted: i=1; AJvYcCV8S0pkpz4q5lW+S+4GgbgsTROWuyooqPPgH35LCnG4SFBbUustMnYy3AlMgB7TMkAx19k0Kt2lS1PT8/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw71i+o65UM9E/AXQf5SDjCvEcxT/uJUROKopwP8QW2G1q/XYLx
	+Ggxg75nbsCO+7xkx1MVGJo9+mO4tztVIYE7qz3q73JZhXPG16WpOPdyq7Q93wOOm0w=
X-Gm-Gg: ASbGnctyvxZALrIXxm2gboDbeBj3ph+Pmod0d9kgBdszPopbjz/RmYYzGCqTWve/Njd
	3ELPdBBupvHDW8eLWfJz6U979065zAqq1CWvz6WqULcMj601ypr30fxiS6GHhHvjzyqAetB0hLc
	3J55u57XNLGsjxqLztvjbH8dJyZxZuaUeeaAsFfhdoc/OGEslH7qVStRVTuydJXDYUJI61Ll2vR
	B+Ty9WrkNmC6CzIr7gVNFRim3/Estem62eNG6mBzZKxmY0JQnmidXfnl8jW6u9bAIKMDrXnO54g
	yC0lm8n2A1NPzLq7MFC1zJrPE0KAE37Sl7dQK47x24Ad6Y1Ypo2YL0Tt01+1yCoJdIYE8o+ZkFw
	HVnzSh2/A9Ae3w0ZOB06ST7PYLBxBD4lxnXHMSh+S0QOPHhUPuwXZ3ZoL10Fdm/L07h5rk9bQsO
	9J5uHGEo2AcdrQJJACdkAB1/vtycc=
X-Google-Smtp-Source: AGHT+IEpHdQzMerjWdBXorJoGsR/H2Zsez6Tl7azsD2lDQq/RwaDAfjdaA+AF4wBT4wi6aeIVjSUPQ==
X-Received: by 2002:a05:6e02:2291:b0:42f:9187:f6e0 with SMTP id e9e14a558f8ab-430c5270233mr29240445ab.13.1760652089394;
        Thu, 16 Oct 2025 15:01:29 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.207])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430b512c03esm16138215ab.25.2025.10.16.15.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 15:01:28 -0700 (PDT)
Message-ID: <95a777a7-4998-4451-b271-8450a5b674bb@sifive.com>
Date: Thu, 16 Oct 2025 17:01:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] irqchip/plic: add support for UltraRISC DP1000
 PLIC
To: Bo Gan <ganboing@gmail.com>, Lucas Zampieri <lzampier@redhat.com>
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
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <831744c6-ba89-4029-a035-9a70c3f57465@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bo,

On 2025-10-16 4:28 PM, Bo Gan wrote:
> Hi Lucas, Charles,
> 
> I just realized your last reply and sorry about the messy formatting.
> Please disregard the previous one from me and use this one.
> 
> On 10/16/25 01:42, Lucas Zampieri wrote:
>> From: Charles Mirabile <cmirabil@redhat.com>
>>
>> Add a new compatible for the plic found in UltraRISC DP1000 with a quirk to
>> work around a known hardware bug with IRQ claiming in the UR-CP100 cores.
>>
>> When claiming an interrupt on UR-CP100 cores, all other interrupts must be
>> disabled before the claim register is accessed to prevent incorrect
>> handling of the interrupt. This is a hardware bug in the CP100 core
>> implementation, not specific to the DP1000 SoC.
>>
>> When the PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM flag is present, a specialized
>> handler (plic_handle_irq_cp100) saves the enable state of all interrupts,
>> disables all interrupts except for the first pending one before reading the
>> claim register, and then restores the interrupts before further processing of
>> the claimed interrupt continues.
>>
>> The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
>> SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
>> This has no impact on other platforms.
>>
>> Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
>> Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
>> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
>> Acked-by: Samuel Holland <samuel.holland@sifive.com>
>> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
>> ---
>>   drivers/irqchip/irq-sifive-plic.c | 94 ++++++++++++++++++++++++++++++-
>>   1 file changed, 93 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-
>> plic.c
>> index bf69a4802b71..0428e9f3423d 100644
>> --- a/drivers/irqchip/irq-sifive-plic.c
>> +++ b/drivers/irqchip/irq-sifive-plic.c
>> @@ -49,6 +49,8 @@
>>   #define CONTEXT_ENABLE_BASE        0x2000
>>   #define     CONTEXT_ENABLE_SIZE        0x80
>>   +#define PENDING_BASE                    0x1000
>> +
>>   /*
>>    * Each hart context has a set of control registers associated with it.  Right
>>    * now there's only two: a source priority threshold over which the hart will
>> @@ -63,6 +65,7 @@
>>   #define    PLIC_ENABLE_THRESHOLD        0
>>     #define PLIC_QUIRK_EDGE_INTERRUPT    0
>> +#define PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM    1
>>     struct plic_priv {
>>       struct fwnode_handle *fwnode;
>> @@ -394,6 +397,89 @@ static void plic_handle_irq(struct irq_desc *desc)
>>       chained_irq_exit(chip, desc);
>>   }
>>   +static bool cp100_isolate_pending_irq(int nr_irq_groups, u32 ie[],
>> +                       void __iomem *pending,
>> +                       void __iomem *enable)
>> +{
>> +    u32 pending_irqs = 0;
>> +    int i, j;
>> +
>> +    /* Look for first pending interrupt */
>> +    for (i = 0; i < nr_irq_groups; i++) {
>> +        pending_irqs = ie[i] & readl_relaxed(pending + i * sizeof(u32));
>> +        if (pending_irqs)
>> +            break;
> 
> No need to start from group 0. Only readl on the group with ie[i] != 0
> 
>> +    }
>> +
>> +    if (!pending_irqs)
>> +        return false;
>> +
>> +    /* Disable all interrupts but the first pending one */
>> +    for (j = 0; j < nr_irq_groups; j++) {
>> +        u32 new_mask = 0;
>> +
>> +        if (j == i) {
>> +            /* Extract mask with lowest set bit */
>> +            new_mask = (pending_irqs & -pending_irqs);
>> +        }
>> +
>> +        writel_relaxed(new_mask, enable + j * sizeof(u32));
> 
> 
> There's no need to write the register if the value isn't changing. You can
> check new_mask with the value in ie[].
> 
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler,
>> +                    void __iomem *claim)
>> +{
>> +    int nr_irq_groups = DIV_ROUND_UP(handler->priv->nr_irqs, 32);
>> +    void __iomem *pending = handler->priv->regs + PENDING_BASE;
>> +    void __iomem *enable = handler->enable_base;
>> +    irq_hw_number_t hwirq = 0;
>> +    int i;
>> +
>> +    guard(raw_spinlock)(&handler->enable_lock);
>> +
>> +    /* Save current interrupt enable state */
>> +    for (i = 0; i < nr_irq_groups; i++)
>> +        handler->enable_save[i] = readl_relaxed(enable + i * sizeof(u32));
> 
> 
> I see that you start to use handler->enable_save to track HW in the last reply.
> I'm about to suggest that. Please send out a new patch, so people can properly
> review it. There's change to common code path.
> 
>> +
>> +    if (!cp100_isolate_pending_irq(nr_irq_groups, handler->enable_save,
>> pending, enable))
>> +        return 0;
>> +
>> +    hwirq = readl(claim);
> 
> Possibly missing a io barrier. readl isn't going to enforce the ordering of
> readl/writel_relaxed above and itself. There could be other barriers missing.
> Please check.

There is no missing barrier. Linux requires the hardware to enforce this
ordering. See the comment in asm/mmio.h:

/*
 * Relaxed I/O memory access primitives. These follow the Device memory
 * ordering rules but do not guarantee any ordering relative to Normal memory
 * accesses.  These are defined to order the indicated access (either a read or
 * write) with all other I/O memory accesses to the same peripheral. Since the
 * platform specification defines that all I/O regions are strongly ordered on
 * channel 0, no explicit fences are required to enforce this ordering.
 */

where "strongly ordered" is defined by the privileged ISA: "accesses to an I/O
region with strong ordering are generally observed by other harts and bus
mastering devices in program order."

Barriers are only needed if there are ordering requirements between I/O accesses
to multiple MMIO regions, or between I/O and normal memory (e.g. locks and DMA).

Regards,
Samuel

>> +
>> +    /* Restore previous state */
>> +    for (i = 0; i < nr_irq_groups; i++)
>> +        writel_relaxed(handler->enable_save[i], enable + i * sizeof(u32));
>> +
>> +    return hwirq;
>> +}
>> +
>> +static void plic_handle_irq_cp100(struct irq_desc *desc)
>> +{
>> +    struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
>> +    struct irq_chip *chip = irq_desc_get_chip(desc);
>> +    void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
>> +    irq_hw_number_t hwirq;
>> +
>> +    WARN_ON_ONCE(!handler->present);
>> +
>> +    chained_irq_enter(chip, desc);
>> +
>> +    while ((hwirq = cp100_get_hwirq(handler, claim))) {
>> +        int err = generic_handle_domain_irq(handler->priv->irqdomain, hwirq);
>> +
>> +        if (unlikely(err)) {
>> +            pr_warn_ratelimited("%pfwP: can't find mapping for hwirq %lu\n",
>> +                        handler->priv->fwnode, hwirq);
>> +        }
>> +    }
>> +
>> +    chained_irq_exit(chip, desc);
>> +}
>> +
>>   static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
>>   {
>>       /* priority must be > threshold to trigger an interrupt */
>> @@ -430,6 +516,8 @@ static const struct of_device_id plic_match[] = {
>>         .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>>       { .compatible = "thead,c900-plic",
>>         .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>> +    { .compatible = "ultrarisc,cp100-plic",
>> +      .data = (const void *)BIT(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM) },
>>       {}
>>   };
>>   @@ -664,12 +752,16 @@ static int plic_probe(struct fwnode_handle *fwnode)
>>           }
>>             if (global_setup) {
>> +            void (*handler_fn)(struct irq_desc *) = plic_handle_irq;
>> +
>> +            if (test_bit(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM, &handler-
>> >priv->plic_quirks))
>> +                handler_fn = plic_handle_irq_cp100;
>> +
>>               /* Find parent domain and register chained handler */
>>               domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
>> DOMAIN_BUS_ANY);
>>               if (domain)
>>                   plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
>>               if (plic_parent_irq)
>> -                irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
>> +                irq_set_chained_handler(plic_parent_irq, handler_fn);
>>                 cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
>>                         "irqchip/sifive/plic:starting",
> 
> My rationale of the above comments is to achieve minimal overhead with this
> "read pending[] -> disable IE[] -> claim -> enable IE[]" approach. In general,
> the fewer interrupts enabled on a hart, the lower the overhead. If there's only
> 1 interrupt enabled for a give hart, then there's zero reading/writing of IE[],
> and you can further optimize away the reading of pending register.
> 
> I'd imagine that if the user truly want to avoid the overhead of this quirk,
> they can chose to spread out the irq groups onto different harts to alleviate
> the slow down, or better isolate a single irq to a given hart, and we should
> make it possible.
> 
> Feel free to point out any of my misunderstandings.
> 
> Bo


