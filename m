Return-Path: <linux-kernel+bounces-893339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB13C471C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACA03B98E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638493126D3;
	Mon, 10 Nov 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WBUWdqii"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1A34D3B3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783907; cv=none; b=g6nt6OURLLHsVj7wsqQs5HJ67fftjjoGtPQLuACMz3fGqes6Qx/0ctXIZdttd1HUKetmTaw0qwS27BhM769ny9UiAV7xFcqNuUDMV9rgalYc6TZcMs2U80vsZIKtyIqxOZgBpCaee/zBdNkyK9wHFsnRqJ6tKU3fVqvNcu6cy8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783907; c=relaxed/simple;
	bh=Buq1MT0S7MubjcfDlzuiL8qsg8OhP5WDNgUJe5GnQE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeDv08Wvf4mErUTsfuN4HUcyRWrvACuEBs3xRPLOGTVTKPnTg7gcLQsu190MGP4qUriQpiLjNLRe0B6U5f8LDJRfXVfC6yrPsj13Djr2ooN7n57SUhDauxG0JqbD7Py61lTSoH5JXnQRC+C6JieMb3ol79e3ztUKtLpgjBQsf2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WBUWdqii; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GaeHzArTdI+oTKMXGP82IYfI26aTSt0HVq6Zx2NSCs4=; b=WBUWdqii/uf7SdtW/vcZd945LC
	ktYg/ZQWxo4gr3co3/3PCH5kIVTax039NCa6NXd+XOPVcNppZjDakXUGVIm63tScDkTUmFYuz0I0M
	oST0IozeUoFuroPoC17T44c5hcIp4+dTMg31+6mrNDdGTKFjY84ozHs8U17SNvmqm2qcLfQA8qexN
	5g8kCH2eI18vUM08o6JL73Z8aQR6t2vc1ZkdBk4XEqoIHPyoG1zOq6ghDE2r4gUA51G6BMfEoenpM
	uy0BHO/LIIoaMLnjbulVHd5GRszC8dNp64FF5Taenuuo4e4M90VUsa3U+DE4xoaZENGnTB+JVjBPq
	qYgZiYsg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIRkk-0000000AqY7-0Ocu;
	Mon, 10 Nov 2025 13:16:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6DE3D30029E; Mon, 10 Nov 2025 15:11:41 +0100 (CET)
Date: Mon, 10 Nov 2025 15:11:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: juri.lelli@redhat.com, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, nico@fluxnic.net
Subject: Re: [PATCH 2/2] sched/deadline: Use cpumask_weight_and in dl_bw_cpus
Message-ID: <20251110141141.GZ3245006@noisy.programming.kicks-ass.net>
References: <20251014100342.978936-1-sshegde@linux.ibm.com>
 <20251014100342.978936-3-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014100342.978936-3-sshegde@linux.ibm.com>

On Tue, Oct 14, 2025 at 03:33:42PM +0530, Shrikanth Hegde wrote:
> - cpumask_subset(a,b) -> cpumask_weight(a) should be same as 
> cpumask_weight_and(a,b)
> 
> - for_each_cpu_and(a,b) to count cpus could be replaced by
> cpumask_weight_and(a,b)
> 
> No Functional Change. It could save a few cycles since cpumask_weight_and 
> would be more efficient. Plus one less stack variable. 
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/deadline.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 8b7c4ee41fd8..a18f64b2e47c 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -125,20 +125,11 @@ static inline struct dl_bw *dl_bw_of(int i)
>  static inline int dl_bw_cpus(int i)
>  {
>  	struct root_domain *rd = cpu_rq(i)->rd;
> -	int cpus;
>  
>  	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
>  			 "sched RCU must be held");
>  
> -	if (cpumask_subset(rd->span, cpu_active_mask))
> -		return cpumask_weight(rd->span);
> -
> -	cpus = 0;
> -
> -	for_each_cpu_and(i, rd->span, cpu_active_mask)
> -		cpus++;
> -
> -	return cpus;
> +	return cpumask_weight_and(rd->span, cpu_active_mask);
>  }

Right, let me stick that on top of the change I have in queue/sched/core

