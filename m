Return-Path: <linux-kernel+bounces-851392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 232F3BD658A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B86194E5837
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954FD2E8B6C;
	Mon, 13 Oct 2025 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yfrxpf0V"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B51C2D77EA
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390469; cv=none; b=bpep5cYxWy9unkbiGMK06k7zAxlIHDQsrdaOkjddkvhOLOpeDT9lswZVHbrIOmAykfNVMJaUwH8vmjOaMboitHbCYc+mb+PSIpaUt2+pggXVWsTrFcqbUM1AuYQQ1PnzXghIPuYQdIjbA8xTRIVU3M73q4YSHxHNho4Pxlk3nW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390469; c=relaxed/simple;
	bh=4Sw6lri4TPgiwaVMH+4ZK3bSnV8mcsWF6T3JlzeAU3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhvNhODaK1c0YUh2CP6tRAR/WRaEoxS/qdRC92OYWd7fzxpcLiCWjmdMEH/UK/lknm4tZab3l6/Rit7jnEkUxD8tOA/1AsxBuHxSreexhWmdWNEdCi1lfCVWBsaQXIObHv4X6OxjhKbCNOyYbsRngLBZBGPdUX+Hic0qd2nllsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yfrxpf0V; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-782e93932ffso4182080b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760390465; x=1760995265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZRakwlsDIcfaa9Yjkhwp/x8BBQtu50zlU1+cKPLGbQ=;
        b=Yfrxpf0Vgn5WQ0KlXfRWlTQ9zHRsRax8IgXJBtBZwM/+5HFN5aQgWsiBu75MWNW/za
         hsGeYe9qZLHDO6j7DUDRsW09yonXUklhxXKT8rFJFo9JTDwxykmIJJ5j58B1bd/VQWSx
         WisLHAtsnbKVNPQWDOyMzbcukMWTLozrBJ4W6d/rVO5m7+74786KB1hNk7UTs7LRXMhQ
         cAZPB2ydx/3nxvWm/8x1Be81Am7ijsGW1PSbuTwKZfnLnsY/sVUe3T/9n2ysk4BOY39f
         4elmdS2XBUaHtjk5JZJ6MQo1a5EGE5hpyvzx5yCtEZGR/hcGlJL2w3ZZGRfgzq4cGDqn
         d6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760390465; x=1760995265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZRakwlsDIcfaa9Yjkhwp/x8BBQtu50zlU1+cKPLGbQ=;
        b=S/jJ//xsuHsOWvQzdh94WwuxkpbOn3cMAJtabKgnehZYLwcpAkPSceCC6vbDRab1lF
         dNCzZLW4a7kQ13oqsaOlYjleYHoEJR7C+xP3RvkWyyR98hCFNtbqLH6RfMQIaPRY0L61
         5cpo77+D6tTUpdFcGtZhixOmy+dTrHAOuZMes3fSOsWg0iJnNxPwLNQy9RwR1V+JQv0I
         HwX4qHRrGZBPDzOiONMrYfGh1+NE9Q5qnc1oXEe+tVf6VksNWpf3b71GuiQF9k2Kedzn
         d4n9wUnBHrtKDe1Q55qw3pyw4QaIpz2dGCNruWu4V+6sCROsxJ6UyDfeBNtdjMrzi4U1
         eMtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUESv7cUgRZeZkWcDSrlIjC4WwRH+EXdIWExsvhgMcivi7qoMh7xoEwgswtlDAcvvCTY6hdmgZQP8FgpOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKeDND2D8WarIhqQ0vYjWdp6+VqRCYBAxldQ4Ymt2GwH1+0jsF
	WKvKu9DformPn6VlMdEkLm/441NSSyd7NRTZx4yifq2V5XSQt/gC5Oyg
X-Gm-Gg: ASbGncu+Ycd0gV6iVMAc7w3zScrExLwWXqth6gaNnabcZHko2a7kkMzSklqUHUFwCQx
	MCS+oR8UNFKwrgmArYnllOQYI3GRDEVsgGJoAQJiUwjJ3jpcci1PD69AUqegSILTUmACeK3yo5o
	S9dUYrT4EO3GO/G8kNw+B516SnPbxFtSjNaxweRyA+VtU557Z8i8lz8GrlpBBeaEFQe9235PMna
	KaJEWRNUN2uLu74VGSvrg9la556uwfF51XyTx7c0PsNFm+jiz7Z3HKwqFaSQz8LRDnU+Ay7rv0Q
	TKH1ptYTSrHz0vo7QhH58oOw+eawah5XDXgBUJtZpmAUDih+hCEGe0MyFGU0Dfe8LB02pgeyn0s
	pnNvUu/zMSKpRp4AePWa0I4vK2Y8psOUXsCSqHkMlg/9Z8zjVbLMPZBIcJYMEZnhvlEeD/2lyV1
	MkTSCxHPKs2fvBkXDXZscKs/F3BGWF
X-Google-Smtp-Source: AGHT+IFiTEUx4WX6SEaX5gClVFJ7Xjbo9xWDhK4U59yZRFiLTXuzAsnVWEiBinffB9NWYVY0KwkOEA==
X-Received: by 2002:a05:6a00:189a:b0:77f:2dc4:4c16 with SMTP id d2e1a72fcca58-79387440592mr24625398b3a.21.1760390465214;
        Mon, 13 Oct 2025 14:21:05 -0700 (PDT)
Received: from [0.0.0.0] (ec2-54-193-105-225.us-west-1.compute.amazonaws.com. [54.193.105.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8135sm12402497b3a.68.2025.10.13.14.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 14:21:04 -0700 (PDT)
Message-ID: <65122c79-7497-4b40-8112-a8ccaeeb16ab@gmail.com>
Date: Mon, 13 Oct 2025 14:24:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] irqchip/plic: add support for UltraRISC DP1000
 PLIC
To: Samuel Holland <samuel.holland@sifive.com>,
 Lucas Zampieri <lzampier@redhat.com>
Cc: Charles Mirabile <cmirabil@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang <dramforever@live.com>,
 linux-riscv@lists.infradead.org, Zhang Xincheng
 <zhangxincheng@ultrarisc.com>, linux-kernel@vger.kernel.org
References: <20251013111539.2206477-1-lzampier@redhat.com>
 <20251013111539.2206477-4-lzampier@redhat.com>
 <1ecbd61e-6b3f-42e8-86cd-e1c589a45262@sifive.com>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <1ecbd61e-6b3f-42e8-86cd-e1c589a45262@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 12:00, Samuel Holland wrote:
> Hi Lucas,
> 
> On 2025-10-13 6:15 AM, Lucas Zampieri wrote:
>> From: Charles Mirabile <cmirabil@redhat.com>
>>
>> Add a new compatible for the plic found in UltraRISC DP1000 with a quirk to
>> work around a known hardware bug with IRQ claiming.
>>
>> When claiming an interrupt on the DP1000 PLIC all other interrupts must be
>> disabled before the claim register is accessed to prevent incorrect
>> handling of the interrupt.
>>
>> When the PLIC_QUIRK_CLAIM_REGISTER is present, during plic_handle_irq
>> the enable state of all interrupts is saved and then all interrupts
>> except for the first pending one are disabled before reading the claim
>> register. The interrupts are then restored before further processing of
>> the claimed interrupt continues.
> 
> Since the workaround requires scanning the pending bits for each interrupt
> anyway, it would be simpler and more efficient to ignore the claim register
> entirely. Call generic_handle_domain_irq() for each interrupt that is (enabled
> AND pending), then clear the pending bit. Then you would not need to save and
> restore the enable registers.
> 

Is that safe and race-free? Can we guarantee that the enable bits for
different contexts (harts) are disjoint at any given time? I'm a little
bit worried about the scenario where 2+ harts having the same irq enabled
and competing for the same irq claim. Without using the HW claim register,
we may get spurious interrupt, and then wrongly claimed the spurious
interrupt causing the next real one to be delayed indefinitely.

>> The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
>> SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
>> This has no impact on other platforms.
>>
>> Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
>> Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
>> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
>> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
>> ---
>>   drivers/irqchip/irq-sifive-plic.c | 83 ++++++++++++++++++++++++++++++-
>>   1 file changed, 82 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>> index 9c4af7d58846..a7b51a925e96 100644
>> --- a/drivers/irqchip/irq-sifive-plic.c
>> +++ b/drivers/irqchip/irq-sifive-plic.c
>> @@ -49,6 +49,8 @@
>>   #define CONTEXT_ENABLE_BASE		0x2000
>>   #define     CONTEXT_ENABLE_SIZE		0x80
>>
>> +#define PENDING_BASE                    0x1000
>> +
>>   /*
>>    * Each hart context has a set of control registers associated with it.  Right
>>    * now there's only two: a source priority threshold over which the hart will
>> @@ -63,6 +65,7 @@
>>   #define	PLIC_ENABLE_THRESHOLD		0
>>
>>   #define PLIC_QUIRK_EDGE_INTERRUPT	0
>> +#define PLIC_QUIRK_CLAIM_REGISTER	1
>>
>>   struct plic_priv {
>>   	struct fwnode_handle *fwnode;
>> @@ -367,6 +370,82 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
>>   	.free		= irq_domain_free_irqs_top,
>>   };
>>
>> +static bool dp1000_isolate_pending_irq(int nr_irq_groups, u32 ie[],
>> +				       void __iomem *pending,
>> +				       void __iomem *enable)
>> +{
>> +	u32 pending_irqs = 0;
>> +	int i, j;
>> +
>> +	/* Look for first pending interrupt */
>> +	for (i = 0; i < nr_irq_groups; i++) {
>> +		pending_irqs = ie[i] & readl(pending + i * sizeof(u32));
>> +		if (pending_irqs)
>> +			break;
>> +	}
>> +
>> +	if (!pending_irqs)
>> +		return false;
>> +
>> +	/* Disable all interrupts but the first pending one */
>> +	for (j = 0; j < nr_irq_groups; j++) {
>> +		u32 new_mask = 0;
>> +
>> +		if (j == i)
>> +			/* Extract mask with lowest set bit */
>> +			new_mask = (pending_irqs & -pending_irqs);
>> +
>> +		writel(new_mask, enable + j * sizeof(u32));
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static irq_hw_number_t dp1000_get_hwirq(struct plic_handler *handler,
>> +					void __iomem *claim)
>> +{
>> +	void __iomem *enable = handler->enable_base;
>> +	void __iomem *pending = handler->priv->regs + PENDING_BASE;
>> +	int nr_irqs = handler->priv->nr_irqs;
>> +	int nr_irq_groups = DIV_ROUND_UP(nr_irqs, 32);
>> +	int i;
>> +	u32 ie[32] = { 0 };
>> +	irq_hw_number_t hwirq = 0;
>> +
>> +	raw_spin_lock(&handler->enable_lock);
>> +
>> +	/* Save current interrupt enable state */
>> +	for (i = 0; i < nr_irq_groups; i++)
>> +		ie[i] = readl(enable + i * sizeof(u32));
>> +
>> +	if (!dp1000_isolate_pending_irq(nr_irq_groups, ie, pending, enable))
>> +		goto out;
>> +
>> +	hwirq = readl(claim);
>> +
>> +	/* Restore previous state */
>> +	for (i = 0; i < nr_irq_groups; i++)
>> +		writel(ie[i], enable + i * sizeof(u32));
>> +out:
>> +	raw_spin_unlock(&handler->enable_lock);
>> +	return hwirq;
>> +}
>> +
>> +static irq_hw_number_t plic_get_hwirq(struct plic_handler *handler,
>> +				      void __iomem *claim)
>> +{
>> +	/*
>> +	 * Due to a hardware bug in the implementation of the claim register
>> +	 * in the UltraRISC DP1000 platform, other interrupts must be disabled
>> +	 * before reading the claim register and restored afterwards.
>> +	 */
>> +
>> +	if (test_bit(PLIC_QUIRK_CLAIM_REGISTER, &handler->priv->plic_quirks))
>> +		return dp1000_get_hwirq(handler, claim);
>> +
>> +	return readl(claim);
>> +}
>> +
>>   /*
>>    * Handling an interrupt is a two-step process: first you claim the interrupt
>>    * by reading the claim register, then you complete the interrupt by writing
>> @@ -384,7 +463,7 @@ static void plic_handle_irq(struct irq_desc *desc)
>>
>>   	chained_irq_enter(chip, desc);
>>
>> -	while ((hwirq = readl(claim))) {
>> +	while ((hwirq = plic_get_hwirq(handler, claim))) {
> 
> This is the hot path for interrupt handling. Instead of checking for the quirk
> on every interrupt, please create a new function that you conditionally pass to
> irq_set_chained_handler(), so the quirk check only happens once at boot.
> 
> Regards,
> Samuel
> 
>>   		int err = generic_handle_domain_irq(handler->priv->irqdomain,
>>   						    hwirq);
>>   		if (unlikely(err)) {
>> @@ -432,6 +511,8 @@ static const struct of_device_id plic_match[] = {
>>   	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>>   	{ .compatible = "thead,c900-plic",
>>   	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>> +	{ .compatible = "ultrarisc,cp100-plic",
>> +	  .data = (const void *)BIT(PLIC_QUIRK_CLAIM_REGISTER) },
>>   	{}
>>   };
>>
>> --
>> 2.51.0
>>
> 

Bo

