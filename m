Return-Path: <linux-kernel+bounces-769056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C145AB2699C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EF31C25EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B17B18DF62;
	Thu, 14 Aug 2025 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yomn762k"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874DE321445
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181615; cv=none; b=u6Jarp7O1+3pS34nz5V/wujsdPZeJKwVEkjef/628yoiK2m5U0kjXobWOKgsmKmzBtyO6eOGM/iSgwVwGUfhqliduU4Tk/lijOu6nQYA2NDcr6OzWtG8wqyEaL791aoNlxpidAJ+C7N6WaP74u8yKofLHju1/KtFgkM/ehSD0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181615; c=relaxed/simple;
	bh=6ICT6B96OQEFF8afYdd7lv2MynDiSVKNATVqe3vuqu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8Me7N1XsiRYFVMN2HZr6WTnFbIGHuO8+djfgH/a5dKRkM6ZQ0+Z0lLArKlEzNsBzUZ78UQbbmMNp7/KRO6yjAq9806bV4RG2Y9zhOI8i+08kVdys31DV2jxQx8Ab+271SQtCKUnL5Oygp5cvKzdYrfs2fk0h3GUm+jkvvdKV5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yomn762k; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6hUjWfjD4aH1U26/f1SxLNvGUN4fBgJOkcYQm5M4nAA=; b=Yomn762kFRVC5ypSw4Wpp1+PoF
	BvcZWviurShuiggA6CWVIdWLPvb/1khMUdBYHX/ZFx+MbevdC53HNih+tx0M1Lov++O5OHgDvCVSY
	fgAf1F53S+Fk6nIuuOA2ReXELd1y1ykapzSPA1JUJvcSHODFPXF/S8dhaYKlqVe+2gJ357aBiRAmy
	4txbWJso/KmK63CumLLG++uAu3KcnmfAwbvxfYLyxni075u3IPAHkASa6oAc/LZUXIUeBJwfWqku3
	Sb0nUNdoVdsj3JX4/uULkk2U6ftDalP6jhGm1He6aKHtnOKW7cs165ttQwlLaVs9IDeGY71Qs+LVN
	uxB7E45g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umYuh-0000000GRlD-1xhs;
	Thu, 14 Aug 2025 14:26:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 20576302DA9; Thu, 14 Aug 2025 16:26:42 +0200 (CEST)
Date: Thu, 14 Aug 2025 16:26:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	quic_zhonhan@quicinc.com
Subject: Re: [PATCH] sched/fair: Save cpu id locally to avoid repeated
 smp_processor_id() calls
Message-ID: <20250814142641.GX4067720@noisy.programming.kicks-ass.net>
References: <20250814140141.2655087-1-zhongqiu.han@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814140141.2655087-1-zhongqiu.han@oss.qualcomm.com>

On Thu, Aug 14, 2025 at 10:01:41PM +0800, Zhongqiu Han wrote:
> Avoid repeated smp_processor_id() by saving cpu id in a local variable.
> 
> - find_new_ilb(): func called with interrupts disabled.
> - sched_cfs_period_timer(): cpu id saved after raw_spin_lock_irqsave().
> 
> This improves clarity and reduces overhead without changing functionality.

No, this makes things actively worse. It:

 - violates coding style by declaring a variable in the middle of code
 - fetches the CPU number even if its never used (hopefully the compiler
   can optimize this for you)
 - moves error path logic into the normal code path

> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> ---
>  kernel/sched/fair.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e256793b9a08..60a9830fb8a4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6401,6 +6401,8 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  	int count = 0;
>  
>  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
> +	int cpu = smp_processor_id();
> +
>  	for (;;) {
>  		overrun = hrtimer_forward_now(timer, cfs_b->period);
>  		if (!overrun)
> @@ -6424,13 +6426,13 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  
>  				pr_warn_ratelimited(
>  	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us = %lld, cfs_quota_us = %lld)\n",
> -					smp_processor_id(),
> +					cpu,
>  					div_u64(new, NSEC_PER_USEC),
>  					div_u64(cfs_b->quota, NSEC_PER_USEC));
>  			} else {
>  				pr_warn_ratelimited(
>  	"cfs_period_timer[cpu%d]: period too short, but cannot scale up without losing precision (cfs_period_us = %lld, cfs_quota_us = %lld)\n",
> -					smp_processor_id(),
> +					cpu,
>  					div_u64(old, NSEC_PER_USEC),
>  					div_u64(cfs_b->quota, NSEC_PER_USEC));
>  			}
> @@ -12195,12 +12197,13 @@ static inline int find_new_ilb(void)
>  {
>  	const struct cpumask *hk_mask;
>  	int ilb_cpu;
> +	int this_cpu = smp_processor_id();

This again violates coding style.

>  	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
>  
>  	for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
>  
> -		if (ilb_cpu == smp_processor_id())
> +		if (ilb_cpu == this_cpu)
>  			continue;

And have you checked if the compiler did this lift for you? It can
generally lift loads out of loops.

>  
>  		if (idle_cpu(ilb_cpu))
> -- 
> 2.43.0
> 

