Return-Path: <linux-kernel+bounces-851468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAAABD691E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A375426705
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C0974420;
	Mon, 13 Oct 2025 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PFxjDBs+"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E35061FFE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760393091; cv=none; b=sp25B7g2kGIMsTo2KYYl7Y47nO++LUihmd7npGpowan41M87sUZ2QgV13WAqHM/Dg3kK0IW6trpiwkaIMqxde3/3Wz0kIyfuvtjs+6tQO65glAQnrLzPI5ZyXYydLNFBdc37Mzzqi+R66/qjaJ8kngC6UEvVWmmMdM+UVlCsIy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760393091; c=relaxed/simple;
	bh=3DLunuDOzx2wc4LTJmyHVov2ccLkAzxAF7V+I9j1/EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYPiutPuKPsyPhFbpEnHXZVJaej8KeNjx7uPrNBbbUyymBsI4mTh3umRaAJxcef6a7rCR/M9TwqADNcZHpJeAX/zcVrfbvWZUasyAy4HqcTuoVwZdIQj8t+inVIAS4lovJhT26w4W1oF9llmQa1bGjepivkDomC6iKnY/PN6RAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PFxjDBs+; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-9335a918867so477505039f.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760393087; x=1760997887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxWRgO6YEocf6mS8jeQDPGKocXFshKz211hZPwFIojA=;
        b=PFxjDBs+YawA/K5fYY7RjHUOOLi30AxYt8g3jEKE4Z40aq4zY3dvj3RkJtLwl0lgAF
         R/mT+usdAXowGtuwW/jVduvafF4m/OU7GPuKbS2R9/BpqTk7rKi9Ukg8uOrIhABKlf2i
         ObsKPUHJPdljNlkospxLn6OxuNvG+5ubsqGF+H+//Mel4TN5Ht//27hVkqv9qi3u+BIT
         hCKk5XE9iFl/2YO46kYGhTu+t3vabkHf7Ihxsaa4aEjeL7C57try4fPKwcC51UFt4vil
         c/V3Wusiu73FHABdfyqZYsKRCTN04Ul+HkZKiTrsavhs1rMB1z6VbBqQMxUCrfIEidNA
         +DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760393087; x=1760997887;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxWRgO6YEocf6mS8jeQDPGKocXFshKz211hZPwFIojA=;
        b=XKMgYNzH6SKcFFlJko3wjt/PlunFjHkzKHigyXp5INp8GazAhFKssVhcv+WmzkjNzd
         kLAbTkT5eptga7WHPb0cvQwmhVZ+Q4nqfQab8QGBKMAGaYlNeVv5u1QE+S1J4uLzUr4z
         Jqm46zAogh8tccmNyrlqcYX6NX5pSQInb67UGk/xNJg8lHNFyuo/3l4QSI6xIpy0ruSE
         AWot44IXXl14drSPbYRL+KI5cyvB+A/G/9ztlokUDpV6AszZS+l9bz4AhekwRsSxekZH
         LiQ1R5VnytQBPY8ANtOcaEpyhw5HSwbdplVzL3F+1uzBseqNhT27zvUPvdBLcMPrzRyw
         7gRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfgs4Etg+fZLnRTeY+XyX0Ix8q//1cEGazNU7RuBx1VdGSScBEjdltZ0ldeJ/UEoaVTK+v2QrUq6Z+gUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvnFzF+xYSkD1g1cU0dcLI068kCenPkay64PnVdK8rcod1/Q0f
	rl60aW5+gMuTfVVKvEg++Vh24prTcW42pv1VdHsgj93OwX6LTfey7fkqzLvoJVVh7po=
X-Gm-Gg: ASbGncsAIllXlM0k6eglMxfeYzBqd70iUlTcyZKdqU2T01IbED5glcbWVXV5NN+KhZ8
	cdFZF3d8X2l9KtX06bueAF+WzsPWrIrpstCNwXtoJL0iuhNHDBAiegtTeasZq0PvQehcjw8N0Il
	O/azM5ZVcqMwHG25sHPT4zl2ErKjfJXk/n1ExA10xq51QvCOCfAAPWUz+kEzdUAkgRk8RAswXkg
	CHclMOSXBgfOpYk6jxaRmfFPErLKct5ZWi5L7FgEKeAz3C37HTcwRTkoBnQyvi3RRmOXBPN8geJ
	c+7Aq4zBRLSTZjePYuPRNElSihvpqafBvuXESkLAbllimbXvkf6gyvzwk3pAIz3nfoNOYtG1vAs
	0d9hCPcUXYthUlznE5TCaZgcMM1Quq2/WCMkocK8rayw07LTKiQ6XqBPTZh8JlycPVumQ
X-Google-Smtp-Source: AGHT+IGN3mhSATc8aFHDp4wT3kbflEafLQXVUUqdCPIUPkRo1fRMYru2F06C7CxBpT0syEUELwo3Zw==
X-Received: by 2002:a05:6602:6b12:b0:906:c3ea:3fb7 with SMTP id ca18e2360f4ac-93bd192b70amr2341106139f.12.1760393087138;
        Mon, 13 Oct 2025 15:04:47 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.207])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e2594a558sm433456339f.7.2025.10.13.15.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 15:04:46 -0700 (PDT)
Message-ID: <6fe6a924-b156-4b2a-858e-163ccc7e49d1@sifive.com>
Date: Mon, 13 Oct 2025 17:04:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] irqchip/plic: add support for UltraRISC DP1000
 PLIC
To: Bo Gan <ganboing@gmail.com>
Cc: Charles Mirabile <cmirabil@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang <dramforever@live.com>,
 linux-riscv@lists.infradead.org, Zhang Xincheng
 <zhangxincheng@ultrarisc.com>, linux-kernel@vger.kernel.org,
 Lucas Zampieri <lzampier@redhat.com>
References: <20251013111539.2206477-1-lzampier@redhat.com>
 <20251013111539.2206477-4-lzampier@redhat.com>
 <1ecbd61e-6b3f-42e8-86cd-e1c589a45262@sifive.com>
 <65122c79-7497-4b40-8112-a8ccaeeb16ab@gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <65122c79-7497-4b40-8112-a8ccaeeb16ab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bo,

On 2025-10-13 4:24 PM, Bo Gan wrote:
> On 10/13/25 12:00, Samuel Holland wrote:
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
> 
> Is that safe and race-free? Can we guarantee that the enable bits for
> different contexts (harts) are disjoint at any given time? I'm a little
> bit worried about the scenario where 2+ harts having the same irq enabled
> and competing for the same irq claim. Without using the HW claim register,
> we may get spurious interrupt, and then wrongly claimed the spurious
> interrupt causing the next real one to be delayed indefinitely.

Yes, we can guarantee each interrupt is enabled on only one hart at a time.
plic_set_affinity() always chooses a single CPU and gets called from
irq_startup() before the first time the interrupt is enabled.

There are other races to consider (e.g. clearing one pending bit while the
hardware sets an adjacent one), but it looks like this strategy may not work on
the hardware anyway.

Regards,
Samuel

>>> The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
>>> SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
>>> This has no impact on other platforms.
>>>
>>> Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
>>> Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
>>> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
>>> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
>>> ---
>>>   drivers/irqchip/irq-sifive-plic.c | 83 ++++++++++++++++++++++++++++++-
>>>   1 file changed, 82 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-
>>> plic.c
>>> index 9c4af7d58846..a7b51a925e96 100644
>>> --- a/drivers/irqchip/irq-sifive-plic.c
>>> +++ b/drivers/irqchip/irq-sifive-plic.c
>>> @@ -49,6 +49,8 @@
>>>   #define CONTEXT_ENABLE_BASE        0x2000
>>>   #define     CONTEXT_ENABLE_SIZE        0x80
>>>
>>> +#define PENDING_BASE                    0x1000
>>> +
>>>   /*
>>>    * Each hart context has a set of control registers associated with it.  Right
>>>    * now there's only two: a source priority threshold over which the hart will
>>> @@ -63,6 +65,7 @@
>>>   #define    PLIC_ENABLE_THRESHOLD        0
>>>
>>>   #define PLIC_QUIRK_EDGE_INTERRUPT    0
>>> +#define PLIC_QUIRK_CLAIM_REGISTER    1
>>>
>>>   struct plic_priv {
>>>       struct fwnode_handle *fwnode;
>>> @@ -367,6 +370,82 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
>>>       .free        = irq_domain_free_irqs_top,
>>>   };
>>>
>>> +static bool dp1000_isolate_pending_irq(int nr_irq_groups, u32 ie[],
>>> +                       void __iomem *pending,
>>> +                       void __iomem *enable)
>>> +{
>>> +    u32 pending_irqs = 0;
>>> +    int i, j;
>>> +
>>> +    /* Look for first pending interrupt */
>>> +    for (i = 0; i < nr_irq_groups; i++) {
>>> +        pending_irqs = ie[i] & readl(pending + i * sizeof(u32));
>>> +        if (pending_irqs)
>>> +            break;
>>> +    }
>>> +
>>> +    if (!pending_irqs)
>>> +        return false;
>>> +
>>> +    /* Disable all interrupts but the first pending one */
>>> +    for (j = 0; j < nr_irq_groups; j++) {
>>> +        u32 new_mask = 0;
>>> +
>>> +        if (j == i)
>>> +            /* Extract mask with lowest set bit */
>>> +            new_mask = (pending_irqs & -pending_irqs);
>>> +
>>> +        writel(new_mask, enable + j * sizeof(u32));
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +static irq_hw_number_t dp1000_get_hwirq(struct plic_handler *handler,
>>> +                    void __iomem *claim)
>>> +{
>>> +    void __iomem *enable = handler->enable_base;
>>> +    void __iomem *pending = handler->priv->regs + PENDING_BASE;
>>> +    int nr_irqs = handler->priv->nr_irqs;
>>> +    int nr_irq_groups = DIV_ROUND_UP(nr_irqs, 32);
>>> +    int i;
>>> +    u32 ie[32] = { 0 };
>>> +    irq_hw_number_t hwirq = 0;
>>> +
>>> +    raw_spin_lock(&handler->enable_lock);
>>> +
>>> +    /* Save current interrupt enable state */
>>> +    for (i = 0; i < nr_irq_groups; i++)
>>> +        ie[i] = readl(enable + i * sizeof(u32));
>>> +
>>> +    if (!dp1000_isolate_pending_irq(nr_irq_groups, ie, pending, enable))
>>> +        goto out;
>>> +
>>> +    hwirq = readl(claim);
>>> +
>>> +    /* Restore previous state */
>>> +    for (i = 0; i < nr_irq_groups; i++)
>>> +        writel(ie[i], enable + i * sizeof(u32));
>>> +out:
>>> +    raw_spin_unlock(&handler->enable_lock);
>>> +    return hwirq;
>>> +}
>>> +
>>> +static irq_hw_number_t plic_get_hwirq(struct plic_handler *handler,
>>> +                      void __iomem *claim)
>>> +{
>>> +    /*
>>> +     * Due to a hardware bug in the implementation of the claim register
>>> +     * in the UltraRISC DP1000 platform, other interrupts must be disabled
>>> +     * before reading the claim register and restored afterwards.
>>> +     */
>>> +
>>> +    if (test_bit(PLIC_QUIRK_CLAIM_REGISTER, &handler->priv->plic_quirks))
>>> +        return dp1000_get_hwirq(handler, claim);
>>> +
>>> +    return readl(claim);
>>> +}
>>> +
>>>   /*
>>>    * Handling an interrupt is a two-step process: first you claim the interrupt
>>>    * by reading the claim register, then you complete the interrupt by writing
>>> @@ -384,7 +463,7 @@ static void plic_handle_irq(struct irq_desc *desc)
>>>
>>>       chained_irq_enter(chip, desc);
>>>
>>> -    while ((hwirq = readl(claim))) {
>>> +    while ((hwirq = plic_get_hwirq(handler, claim))) {
>>
>> This is the hot path for interrupt handling. Instead of checking for the quirk
>> on every interrupt, please create a new function that you conditionally pass to
>> irq_set_chained_handler(), so the quirk check only happens once at boot.
>>
>> Regards,
>> Samuel
>>
>>>           int err = generic_handle_domain_irq(handler->priv->irqdomain,
>>>                               hwirq);
>>>           if (unlikely(err)) {
>>> @@ -432,6 +511,8 @@ static const struct of_device_id plic_match[] = {
>>>         .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>>>       { .compatible = "thead,c900-plic",
>>>         .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>>> +    { .compatible = "ultrarisc,cp100-plic",
>>> +      .data = (const void *)BIT(PLIC_QUIRK_CLAIM_REGISTER) },
>>>       {}
>>>   };
>>>
>>> -- 
>>> 2.51.0
>>>
>>
> 
> Bo


