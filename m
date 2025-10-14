Return-Path: <linux-kernel+bounces-852366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED59ABD8C60
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2D084E8D88
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFA728E5F3;
	Tue, 14 Oct 2025 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MukWh70z"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DFB248F6A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437886; cv=none; b=pLKBEJnqeZ6hKyeeUQPCqV7vwIyMZI96JG7HPGOagFrFPoreyPpW+kzh6XkX1kzYFlZQ8W8zr5IYAEyWQr1g8Qe6SepvpD3WN3OVdQpHLTHzQrxvbCi5ulMNwzbG56UXzaT5QxSsAnBzg/ud7pjllRmdrJpQ/btZmSw/VnVcJXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437886; c=relaxed/simple;
	bh=rho+4uaK3D/tNXHLH4M6jcEtowZ1pH/uHwB97tNshWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDm7PSm59elNc7XRQqUSSW3mzO7x6ahKcypYzzLC/OIPCqp13QSjGpRr0a8urLgg90yiF4CAY72E1ErIthaPzGPzXirtiXoaWRGzYUAevvXvydd4kels3MYDy70fIibbXr4Zo/Al+3AfsQCXJXtUtsUsV9XVkKlPxGHreLXp6sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MukWh70z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=h4otq5V0qtq2WKfA0DSQt9nt4sGdrV62Xt/uNv/VQ1k=; b=MukWh70zl8e9YhegNhl5o3K8CO
	OL4NBR4wF9Frfz4ag/g836F5BpUpqEeytqKfBoNy1YwTygvfi4/vCndDZS5JL5ceVqgF8iBIgMlYk
	EdZE21L4RdtxtSdTqFdsuTsjY9RunonkkRgJo1TbTPH21Hufd4qk8oLl7B/rWLbsdlpKiqESyogZj
	XQRDJmcy2Xp+MwN+h7YZdqxcebV9t3+xSQEOVX3fbJJSnU9uUmvau6buPOcmFgj93awkO49U/rDD3
	nBEtshLcnwBR9Kmr+J8zC2Ktxn1mq1gPKMCHsCtyZZXd14NjK1pR9lcl+P5W4/bpmdY7o04DCO0eI
	SSs0IeSg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8cJI-00000008pb3-3gu4;
	Tue, 14 Oct 2025 10:31:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F3929300212; Tue, 14 Oct 2025 12:31:16 +0200 (CEST)
Date: Tue, 14 Oct 2025 12:31:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kriish Sharma <kriish.sharma2006@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] sched: remove unused cpumask variable in mm_cid_get()
Message-ID: <20251014103116.GT3245006@noisy.programming.kicks-ass.net>
References: <20251009194818.1587650-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251009194818.1587650-1-kriish.sharma2006@gmail.com>

On Thu, Oct 09, 2025 at 07:48:18PM +0000, Kriish Sharma wrote:
> The variable 'cpumask' in mm_cid_get() was assigned but never used,
> causing the following build error with -Werror:
> 
> kernel/sched/sched.h: In function ‘mm_cid_get’:
> kernel/sched/sched.h:3743:25: error: variable ‘cpumask’ set but not used [-Werror=unused-but-set-variable]
>  3743 |         struct cpumask *cpumask;
>       |                         ^~~~~~~
> 
> Removing the unused variable allows the kernel to compile without errors.

How come I don't see build errors myself?

Anyway, Thomas is in the process or rewriting all this, I'm not inclined
to bother with this unless the build robots actually complain.

Also, you're missing a Fixes tag or something, some commit must've
caused this.

> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  kernel/sched/sched.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1f5d07067f60..361f9101cef9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3740,11 +3740,9 @@ static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
>  			     struct mm_struct *mm)
>  {
>  	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
> -	struct cpumask *cpumask;
>  	int cid;
>  
>  	lockdep_assert_rq_held(rq);
> -	cpumask = mm_cidmask(mm);
>  	cid = __this_cpu_read(pcpu_cid->cid);
>  	if (mm_cid_is_valid(cid)) {
>  		mm_cid_snapshot_time(rq, mm);
> -- 
> 2.34.1
> 

