Return-Path: <linux-kernel+bounces-826598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524FCB8EE32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D297A8859
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E42D9792;
	Mon, 22 Sep 2025 03:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KJuwx+JF"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3286320E6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758513200; cv=none; b=JpuQQigZ9rQ+ICEEBEYeVFt9XQoQ+ei4Ry302QrmrFOEX/qAxBAFnAJCNIxVA1fo06iqNS/N3c2fsiUz0OhkKKn6QhLxkMrX/a+r5ehDN9p9D/66KzLJB52X5Gj/486qfxvNPuEaMHY74u7FZrfiJ6IdIB2ZoGrPLgBPyAG736E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758513200; c=relaxed/simple;
	bh=354oogsbAq0aUBehh+I8r05obovSJbZF7h+il5hYikM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t72p2H09BwPKLGAKJvudg5jUdNXjR7dYHT+9qS0KBLpgbZj4khE5cumfc4Z8hfGThuNn/qF6Z8CK6oCbTZaQPMwR15vosc7I6yAE5/vf9Z+ILWiYMO/dpeyACoZHPg9RX4HIa6d9Wx8lT4yiUGet6FpWJZhjjx+9CMUZp8/+5Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KJuwx+JF; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758513188; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/biUeOKDwcfokhtOIl6NAmRLsJFUpLMG7ZpTgciiCOg=;
	b=KJuwx+JFKMoD2/NJ6dvkKLq7jQQTtHSJjusHe4uTdiidkpPgB3e8FUBTVRY/iKRQ776LInevtfxZfmxbD5LjFGFzbAY/HnhrKvyEu+xa7Wp7ijINaW8Mi+pKWjH3Mfs1u0dWKdukIhHGiifwU1CUj/il3ee587XdLNasUyjZ76c=
Received: from 30.74.144.144(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WoRFNvA_1758513187 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Sep 2025 11:53:07 +0800
Message-ID: <c85ffa6a-f885-47fc-b807-609f966e34c5@linux.alibaba.com>
Date: Mon, 22 Sep 2025 11:53:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/sprd: Enable register for timer
 counter from 32 bit to 64 bit
To: Cixi Geng <cixi.geng@linux.dev>, daniel.lezcano@linaro.org,
 tglx@linutronix.de
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, linux-kernel@vger.kernel.org
References: <20250911082507.7697-1-cixi.geng@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250911082507.7697-1-cixi.geng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/11 16:25, Cixi Geng wrote:
> From: Enlin Mu <enlin.mu@unisoc.com>
> 
> Using 32 bit for suspend compensation, the max compensation time is 36
> hours(working clock is 32k).In some IOT devices, the suspend time may
> be long, even exceeding 36 hours. Therefore, a 64 bit timer counter
> is needed for counting.
> 
> Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng@linux.dev>
> ---
>   drivers/clocksource/timer-sprd.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
> index 430cb99d8d79..742ee88b05d0 100644
> --- a/drivers/clocksource/timer-sprd.c
> +++ b/drivers/clocksource/timer-sprd.c
> @@ -30,6 +30,7 @@
>   #define TIMER_VALUE_SHDW_HI	0x1c
>   
>   #define TIMER_VALUE_LO_MASK	GENMASK(31, 0)
> +#define TIMER_VALUE_HI_MASK	GENMASK(31, 0)
>   
>   static void sprd_timer_enable(void __iomem *base, u32 flag)
>   {
> @@ -162,15 +163,23 @@ static struct timer_of suspend_to = {
>   
>   static u64 sprd_suspend_timer_read(struct clocksource *cs)
>   {
> -	return ~(u64)readl_relaxed(timer_of_base(&suspend_to) +
> -				   TIMER_VALUE_SHDW_LO) & cs->mask;
> +	u32 lo, hi;
> +
> +	lo = readl_relaxed(timer_of_base(&suspend_to) +
> +			TIMER_VALUE_SHDW_LO);
> +	hi = readl_relaxed(timer_of_base(&suspend_to) +
> +			TIMER_VALUE_SHDW_HI);

Can you align your code like the previous code?

> +	return ~(((u64)hi << 32) | lo);
>   }
>   
>   static int sprd_suspend_timer_enable(struct clocksource *cs)
>   {
> -	sprd_timer_update_counter(timer_of_base(&suspend_to),
> -				  TIMER_VALUE_LO_MASK);
> -	sprd_timer_enable(timer_of_base(&suspend_to), TIMER_CTL_PERIOD_MODE);
> +	writel_relaxed(TIMER_VALUE_LO_MASK,
> +			timer_of_base(&suspend_to) + TIMER_LOAD_LO);
> +	writel_relaxed(TIMER_VALUE_HI_MASK,
> +			timer_of_base(&suspend_to) + TIMER_LOAD_HI);
> +	sprd_timer_enable(timer_of_base(&suspend_to),
> +				TIMER_CTL_PERIOD_MODE|TIMER_CTL_64BIT_WIDTH);

Ditto. Otherwise LGTM.

>   
>   	return 0;
>   }
> @@ -186,7 +195,7 @@ static struct clocksource suspend_clocksource = {
>   	.read	= sprd_suspend_timer_read,
>   	.enable = sprd_suspend_timer_enable,
>   	.disable = sprd_suspend_timer_disable,
> -	.mask	= CLOCKSOURCE_MASK(32),
> +	.mask	= CLOCKSOURCE_MASK(64),
>   	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
>   };
>   


