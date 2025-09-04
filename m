Return-Path: <linux-kernel+bounces-801411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D61B444BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7CE1895593
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419B031AF1C;
	Thu,  4 Sep 2025 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LM51+XH5"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2CA31A56A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008199; cv=none; b=GcUTvaG6H6fwTJoVkfrPTw28201PgctNpAM2JcyIASHTfTS0TGDwVZD209rP57oQZ/FTWR6xc4kEltVrgPNBXUevVZfN3X7CoFff2Y4njz/dhFcQKeDfJZ8LsG4pWZfxAZkyLjHI5NXuM0utPO00DLtaDOl3UBy8oWNOo08VykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008199; c=relaxed/simple;
	bh=P75rCZPVw96u/xm3axOzWQ8A/0dUeO3HwLrPeDSqxzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=u/HyRGq4Di+CCuubfP6l26RkVEJYrlGqv3EiH/Ua2BcTcf5y9GkoCHJDGuBwc8QtXY71rDdVIpPtC5ZSyAdpPx8YYcRzpHhasclcWejxBqCFOjvOzYZr70lctUpVRScL+NtebFH6AhoHySdhh3KTWoPUkzMelpWt5R00Hh8ZrhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LM51+XH5; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250904174955euoutp0154a271ddce85286ba2756e05c30b56de~iJaUJgeVv2505425054euoutp01z
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:49:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250904174955euoutp0154a271ddce85286ba2756e05c30b56de~iJaUJgeVv2505425054euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757008195;
	bh=xDLKHxEV4hBOubU1hA0pF3KKCXpZ9u6NZsKj3VxloXA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=LM51+XH5yTExcGU88pRP1td8ngDXTxUnoaAgoRNqnWz/70AD7Ccf55vCTccn3Y1e1
	 skSBgRtje2OwcDcspXfx8EsJZppo7vJ3/+u1tFeWyH17BrFvQenRtdMJZdKVqqmnWh
	 TlsVqtdLkH5CDFGLBHQqW2Gd8LOWK5bee0Juq7IE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250904174953eucas1p17f0b6acef323d0a44b84b8ab177041cb~iJaS00zsD2322323223eucas1p1H;
	Thu,  4 Sep 2025 17:49:53 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250904174952eusmtip2cc300941d5463e8178ab6192d3bf54a1~iJaRhhG0z0094500945eusmtip2X;
	Thu,  4 Sep 2025 17:49:52 +0000 (GMT)
Message-ID: <28a9be50-2432-49b5-b10c-bf8b4f9ebd8b@samsung.com>
Date: Thu, 4 Sep 2025 19:49:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] clocksource/drivers/exynos_mct: only use IRQF_PERCPU
 flag on ARM64 SoCs
To: Peter Griffin <peter.griffin@linaro.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Krzysztof
	Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Ingo
	Molnar <mingo@kernel.org>, Will McVicker <willmcvicker@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, John Stultz
	<jstultz@google.com>, kernel-team@android.com, youngmin.nam@samsung.com,
	hoony.yu@samsung.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250904-exynos-mct-arm32-cpuhp-regression-v1-1-5d9e4dd356ab@linaro.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250904174953eucas1p17f0b6acef323d0a44b84b8ab177041cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250904153242eucas1p12841f999bf68861f7386b0c9f3f4f60f
X-EPHeader: CA
X-CMS-RootMailID: 20250904153242eucas1p12841f999bf68861f7386b0c9f3f4f60f
References: <CGME20250904153242eucas1p12841f999bf68861f7386b0c9f3f4f60f@eucas1p1.samsung.com>
	<20250904-exynos-mct-arm32-cpuhp-regression-v1-1-5d9e4dd356ab@linaro.org>

On 04.09.2025 17:32, Peter Griffin wrote:
> This patch addresses a regression reported in [1] whereby CPU hotplug now
> fails on little CPUs (for reasons that aren't fully understood) for Arm
> 32bit platforms such as Exynos 5422 used in OdroidXU3/XU4 boards.
>
> Note: This patch makes an assumption that the exynos_mct driver is only
> used on Arm 32/64 bit SoCs.
>
> Fixes: f3cec54ee3bf ("clocksource/drivers/exynos_mct: Set local timer interrupts as percpu")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/lkml/8c861182-7e90-4bbf-ac04-173d59f5af69@samsung.com/
> Link: https://lore.kernel.org/lkml/8c861182-7e90-4bbf-ac04-173d59f5af69@samsung.com/ [1]
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
> Hi Marek & Krzysztof,
>      
> Can you test this patch on your Exynos5422 based boards and see if it
> resolves the issue Marek reported of CPU hot plug failing on the little
> cores of Exynos 5422 based boards?
>
> Unfortunately I only have gs101 based Exynos hardware (which is Arm 64 bit
> SoC) to test on. I can confirm CPU hotplug is functional on the little
> cluster CPUs with IRQF_PERCPU flag on Pixel6/gs101 though.

This is a duplicate of 
https://lore.kernel.org/all/20250827102645.1964659-1-m.szyprowski@samsung.com/

and yes, it fixes the reported issue.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Thanks,
>
> Peter
> ---
> ---
>   drivers/clocksource/exynos_mct.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 62febeb4e1decec7f5db104db395884824563915..91d79b73a96a7e8a354d803c2b497bcde92af8d8 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -532,6 +532,16 @@ static int __init exynos4_timer_resources(struct device_node *np)
>   	return 0;
>   }
>   
> +/*
> + * For reasons that aren't fully understood IRQF_PERCPU breaks CPU hotplug on
> + * little cores of ARM 32 bit SoCs like Exynos5422 used in OdroidXU3/4 boards.
> + */
> +#if defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
> +#define MCT_IRQ_FLAGS (IRQF_TIMER | IRQF_NOBALANCING | IRQF_PERCPU)
> +#elif defined(CONFIG_ARM)
> +#define MCT_IRQ_FLAGS (IRQF_TIMER | IRQF_NOBALANCING)
> +#endif
> +
>   /**
>    * exynos4_timer_interrupts - initialize MCT interrupts
>    * @np: device node for MCT
> @@ -602,8 +612,7 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
>   			irq_set_status_flags(mct_irq, IRQ_NOAUTOEN);
>   			if (request_irq(mct_irq,
>   					exynos4_mct_tick_isr,
> -					IRQF_TIMER | IRQF_NOBALANCING |
> -					IRQF_PERCPU,
> +					MCT_IRQ_FLAGS,
>   					pcpu_mevt->name, pcpu_mevt)) {
>   				pr_err("exynos-mct: cannot register IRQ (cpu%d)\n",
>   									cpu);
>
> ---
> base-commit: 4ac65880ebca1b68495bd8704263b26c050ac010
> change-id: 20250904-exynos-mct-arm32-cpuhp-regression-14f321e4a591
>
> Best regards,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


