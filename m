Return-Path: <linux-kernel+bounces-851228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DEBBD5D30
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4509318A78F8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8606D2D7DDD;
	Mon, 13 Oct 2025 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R7TKAs0N"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FD221ABD0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382035; cv=none; b=O70rpU9n56uVDmsLOI6LY5AR+GgIvsDC0GcoxZNqHdKgUULtOVYdhQm8PaARsS2ieNPNgGWHsZZAuq2a99DFN4EMaoN3J2K87VKgAu06PzHjVgbZ7IIDFdR6DHtZiqNcgMsHK+tw8VemChXwyQWP0O7XjizKnwqMQ5tGjALGPSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382035; c=relaxed/simple;
	bh=kCmAPXEcssW/9ZJQG1jwo+B3gkKYyt6MGkZHZWW+yJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBF8YVsC41Zh9V88oIUCCLWk0CdynGqrPGLxg1X830Lu4P+8LGsgvsKZ3beYJp/w85pQc48xiC8jH+pF6FkmweqHrCM89xOnFAzWtlGeVD6v6z5BQXDt+kXVUTHKRHZ5k/hF6fcYiQIFKHav1hTMwU5mINU3TKsWqQ8d5zW5/ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=R7TKAs0N; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-90a0b3ddebeso185073839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760382031; x=1760986831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ssDH5wMDHRQ7E8ITNqhxYfPq50TMwnF4aaotfvSu9x8=;
        b=R7TKAs0NCb3T3pDfpXnIcTVw6axgODJgJ1DA0on9hs7w/c8cAMvl6zD8QDJjVBkQ56
         eP5qXC3asvBW3O7JXnT49UM4TDPnGC2NOufXVsi2fVxLYiIA+ZgVqgsLTMPt8NmuiATs
         cx+on0M0FsltoONQDfJOcSB0pY4bfRQHzK0OAAY/VE4RRzEet35nRPKoRVe1Ku2901eE
         ra6QRhhCVxqTF0v1gY7H1SmCp1OXZvZohtObHVWfmP8S4FtOKcwu6ukCDKOB06UeTQiB
         svKnMCNyA7O3VqewOa8yiB23CTMU/co6uZwYqOgQIH87XFVEBw1jHxndzUAWjO9zmcYX
         zIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760382031; x=1760986831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssDH5wMDHRQ7E8ITNqhxYfPq50TMwnF4aaotfvSu9x8=;
        b=cPzRsIczJqX1MrPqE/g4Qir/G8BQKOy+ouJyi5nhbgtC49zTA28c983M7CgSToseQ/
         rIufd4O+nRZzsUpKdUdCwomOwH8zfXL4vdBkuztfsvPqIXtqB8WYeBITa8US8f+/1tP/
         mPwnnRJFV5s41FsFRbSlFRcXI3FS17Mf714V6eRR7LSUBHjJQo2qiUZRHPy9cM4s49+F
         adbU5C2MtlrdOV3LLZgg18szXSyYvDXx1HCcvmIuKCEYmi9w9dLp/Tvly/a4iHcz5VoX
         a8HtuS7c/xVJIp80kPGC3BmhhGFEDCh1I4ChiTI4l7gcMnVGFldOgyxZeRg0Z80ZKmxU
         bDkg==
X-Forwarded-Encrypted: i=1; AJvYcCUWd8EESs3g3YIlvYFhYFCtaot1gsVOhMhYD/PCxa+ArffB5TntOo/Uf+MO/ldKHz+4Duy9N7GXiEJK4t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdeYRRjv1HMWIkeW8B38WBKqZWa+zo90OeLFBc4nQrZX8DM4o5
	zialLFO14aLrG3FiWcIzpMLrhvxQF6Sv6hRhX9RVskJ2fyEf3SiCjD6KROI014SKS2M=
X-Gm-Gg: ASbGncvd+7bhbxVADO+NyptHbjPCn4JiVmG2HXzU8SKQp9LCfnaFspJPPSQikmNX6WB
	ypz8z5WnoejyaJWHI28bUcRLeVVsTQ1Vod/4kUuOvOG6PaAfK5iFz5/MexvQFjtKIj96wdEuEAs
	KXX3ssTdOj04JbLs1DnxA5eTIfTswemt4rkLLhu7SudcP8e4t3kXQEeSNtRjeMZFD5+1y4vLahY
	y9OutpBAkapX5XYKAlGDBTVizPNgGFWhTMuLJN96SDaBMnZhE8in1mBMm6OU49ss7gsi81tUFD5
	HNTgTuW9OGI4eiC/kik+EKOdvG1AsSZ8fcLrt/Op2q9d+yeeA5jBIXh8A4ssuJnNr7x/AMvlXTA
	3urWlNuc+0DlZtvNRu79K+AgT/wleu92VVMD0IZmVRCz2doWoFyivTUiPvA==
X-Google-Smtp-Source: AGHT+IG4W8VtMga1eZ2FO+QwDF4LZFqBPLZzjzJvdbI9DAmiIc+D/vD2QvPa3hISTH2l19wPpplo3Q==
X-Received: by 2002:a05:6e02:3c85:b0:42f:9ba7:e47e with SMTP id e9e14a558f8ab-42f9ba7e72dmr156254155ab.14.1760382031018;
        Mon, 13 Oct 2025 12:00:31 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.207])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f90278522sm54190115ab.13.2025.10.13.12.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 12:00:30 -0700 (PDT)
Message-ID: <1ecbd61e-6b3f-42e8-86cd-e1c589a45262@sifive.com>
Date: Mon, 13 Oct 2025 14:00:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] irqchip/plic: add support for UltraRISC DP1000
 PLIC
To: Lucas Zampieri <lzampier@redhat.com>
Cc: Charles Mirabile <cmirabil@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang <dramforever@live.com>,
 linux-riscv@lists.infradead.org, Zhang Xincheng
 <zhangxincheng@ultrarisc.com>, linux-kernel@vger.kernel.org
References: <20251013111539.2206477-1-lzampier@redhat.com>
 <20251013111539.2206477-4-lzampier@redhat.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20251013111539.2206477-4-lzampier@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lucas,

On 2025-10-13 6:15 AM, Lucas Zampieri wrote:
> From: Charles Mirabile <cmirabil@redhat.com>
> 
> Add a new compatible for the plic found in UltraRISC DP1000 with a quirk to
> work around a known hardware bug with IRQ claiming.
> 
> When claiming an interrupt on the DP1000 PLIC all other interrupts must be
> disabled before the claim register is accessed to prevent incorrect
> handling of the interrupt.
> 
> When the PLIC_QUIRK_CLAIM_REGISTER is present, during plic_handle_irq
> the enable state of all interrupts is saved and then all interrupts
> except for the first pending one are disabled before reading the claim
> register. The interrupts are then restored before further processing of
> the claimed interrupt continues.

Since the workaround requires scanning the pending bits for each interrupt
anyway, it would be simpler and more efficient to ignore the claim register
entirely. Call generic_handle_domain_irq() for each interrupt that is (enabled
AND pending), then clear the pending bit. Then you would not need to save and
restore the enable registers.

> The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
> SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
> This has no impact on other platforms.
> 
> Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
> Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 83 ++++++++++++++++++++++++++++++-
>  1 file changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 9c4af7d58846..a7b51a925e96 100644
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
> @@ -367,6 +370,82 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
>  	.free		= irq_domain_free_irqs_top,
>  };
> 
> +static bool dp1000_isolate_pending_irq(int nr_irq_groups, u32 ie[],
> +				       void __iomem *pending,
> +				       void __iomem *enable)
> +{
> +	u32 pending_irqs = 0;
> +	int i, j;
> +
> +	/* Look for first pending interrupt */
> +	for (i = 0; i < nr_irq_groups; i++) {
> +		pending_irqs = ie[i] & readl(pending + i * sizeof(u32));
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
> +		writel(new_mask, enable + j * sizeof(u32));
> +	}
> +
> +	return true;
> +}
> +
> +static irq_hw_number_t dp1000_get_hwirq(struct plic_handler *handler,
> +					void __iomem *claim)
> +{
> +	void __iomem *enable = handler->enable_base;
> +	void __iomem *pending = handler->priv->regs + PENDING_BASE;
> +	int nr_irqs = handler->priv->nr_irqs;
> +	int nr_irq_groups = DIV_ROUND_UP(nr_irqs, 32);
> +	int i;
> +	u32 ie[32] = { 0 };
> +	irq_hw_number_t hwirq = 0;
> +
> +	raw_spin_lock(&handler->enable_lock);
> +
> +	/* Save current interrupt enable state */
> +	for (i = 0; i < nr_irq_groups; i++)
> +		ie[i] = readl(enable + i * sizeof(u32));
> +
> +	if (!dp1000_isolate_pending_irq(nr_irq_groups, ie, pending, enable))
> +		goto out;
> +
> +	hwirq = readl(claim);
> +
> +	/* Restore previous state */
> +	for (i = 0; i < nr_irq_groups; i++)
> +		writel(ie[i], enable + i * sizeof(u32));
> +out:
> +	raw_spin_unlock(&handler->enable_lock);
> +	return hwirq;
> +}
> +
> +static irq_hw_number_t plic_get_hwirq(struct plic_handler *handler,
> +				      void __iomem *claim)
> +{
> +	/*
> +	 * Due to a hardware bug in the implementation of the claim register
> +	 * in the UltraRISC DP1000 platform, other interrupts must be disabled
> +	 * before reading the claim register and restored afterwards.
> +	 */
> +
> +	if (test_bit(PLIC_QUIRK_CLAIM_REGISTER, &handler->priv->plic_quirks))
> +		return dp1000_get_hwirq(handler, claim);
> +
> +	return readl(claim);
> +}
> +
>  /*
>   * Handling an interrupt is a two-step process: first you claim the interrupt
>   * by reading the claim register, then you complete the interrupt by writing
> @@ -384,7 +463,7 @@ static void plic_handle_irq(struct irq_desc *desc)
> 
>  	chained_irq_enter(chip, desc);
> 
> -	while ((hwirq = readl(claim))) {
> +	while ((hwirq = plic_get_hwirq(handler, claim))) {

This is the hot path for interrupt handling. Instead of checking for the quirk
on every interrupt, please create a new function that you conditionally pass to
irq_set_chained_handler(), so the quirk check only happens once at boot.

Regards,
Samuel

>  		int err = generic_handle_domain_irq(handler->priv->irqdomain,
>  						    hwirq);
>  		if (unlikely(err)) {
> @@ -432,6 +511,8 @@ static const struct of_device_id plic_match[] = {
>  	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>  	{ .compatible = "thead,c900-plic",
>  	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> +	{ .compatible = "ultrarisc,cp100-plic",
> +	  .data = (const void *)BIT(PLIC_QUIRK_CLAIM_REGISTER) },
>  	{}
>  };
> 
> --
> 2.51.0
> 


