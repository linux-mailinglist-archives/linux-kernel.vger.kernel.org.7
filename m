Return-Path: <linux-kernel+bounces-836344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0BCBA9650
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E1A189C90C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214C33054F1;
	Mon, 29 Sep 2025 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f5qt/mzh"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A782AD24
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759153522; cv=none; b=mtaguqLN737A10lDoO9GevKlurQcCzsUo+YeqGc16tHD//Nf9CJkIBJ9ZfiCfU7o2tlWOrBTadXYlnvpepz8bqGVQxlNZV54E++j2jB2ZsJtwN+9fyR2NqeJ91IA58qoMabd9AQk3uEzUPsXzaEtxIus9GDYQGdHWT/KggiQ4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759153522; c=relaxed/simple;
	bh=Hg1gCErI21oFk6D0poBOQ+krDb+IwW4PRHgU07/PSJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/S8CvUr4Hjfwz6Fo2nHpCjoiPMLI/GzMQHb+U07e5TtsGU18aAryX1NpQb2RtkeJknsRG1YbAUN0O7rvsiXi6Mu5zEWnNECnZUObcHmy+h0yxm2X1wpQwy9NAK6p6/jvpPREey0Bi5+V1MaCvRVToYY1rOzxwatEX1vQ5OARRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f5qt/mzh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bWEgyYuZw9gYNOUPJqq+g3u20qMd4YshQ7tTqVtgSWY=; b=f5qt/mzhBzFHiWVMK1AaYkGBu8
	znxKy4GS97sTcDy04OAwifO6LJr/mzwuSjSv5nt2MWPCjL/B516dt4KuwcoLXYZwxFugPdYjUY+XH
	/kvrLb6/Jx91TLug7g1q3E0YjDXCQ+O/GAUlozYk61K5E0uoWrpfU1mqMkYYopYSYq8LdJ33AVHFv
	RzUSRAn6xF0c3tm0aOdQw2qW05KSGU9bPbpGEkUIHhxopkP3Fw7nrYbRj3LhXe44rypx3BMq/rSKK
	u/YHUfrqvUfDsMOVMCsJiPO2OpF39PuWucJBkS4Qd8hdLtohspNtas4RMOxgI0MOVgwUpXDPAw9/U
	moqjNz5A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3EBM-0000000C97z-2U0d;
	Mon, 29 Sep 2025 13:44:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5928A300359; Mon, 29 Sep 2025 15:44:47 +0200 (CEST)
Date: Mon, 29 Sep 2025 15:44:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Libo Chen <libo.chen@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Vern Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 05/28] sched: Add hysteresis to switch a task's
 preferred LLC
Message-ID: <20250929134447.GM3419281@noisy.programming.kicks-ass.net>
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
 <e51f8a6e172606d520c91c94c0c14b045639217e.1754712565.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e51f8a6e172606d520c91c94c0c14b045639217e.1754712565.git.tim.c.chen@linux.intel.com>

On Sat, Aug 09, 2025 at 01:02:18PM +0800, Chen Yu wrote:
> From: Tim Chen <tim.c.chen@linux.intel.com>
> 
> Switching a process's preferred LLC generates lots of task
> migrations across LLCs. To avoid frequent switches
> of home LLC, implement the following policy:
> 
> 1. Require a 2x occ change threshold to switch preferred LLC
> 2. Don't discard preferred LLC for a task
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a7be5c5ecba3..9e3c6f0eb934 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1175,6 +1175,14 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
>  #define EPOCH_PERIOD	(HZ/100)	/* 10 ms */
>  #define EPOCH_OLD	5		/* 50 ms */
>  
> +static int llc_id(int cpu)
> +{
> +	if (cpu < 0)
> +		return -1;
> +
> +	return per_cpu(sd_llc_id, cpu);
> +}
> +
>  void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *_pcpu_sched)
>  {
>  	unsigned long epoch;
> @@ -1307,6 +1315,7 @@ static void __no_profile task_cache_work(struct callback_head *work)
>  	struct task_struct *p = current;
>  	struct mm_struct *mm = p->mm;
>  	unsigned long m_a_occ = 0;
> +	unsigned long last_m_a_occ = 0;
>  	int cpu, m_a_cpu = -1;
>  	cpumask_var_t cpus;
>  
> @@ -1345,11 +1354,13 @@ static void __no_profile task_cache_work(struct callback_head *work)
>  					     per_cpu(sd_llc_id, i), occ, m_occ, m_cpu, nr);
>  			}
>  
> -			a_occ /= nr;
> +			// a_occ /= nr;

This seems broken.

>  			if (a_occ > m_a_occ) {
>  				m_a_occ = a_occ;
>  				m_a_cpu = m_cpu;
>  			}
> +			if (llc_id(cpu) == llc_id(mm->mm_sched_cpu))
> +				last_m_a_occ = a_occ;

Not 'last', 'curr' perhaps?

>  
>  			trace_printk("(%d) a_occ: %ld m_a_occ: %ld\n",
>  				     per_cpu(sd_llc_id, cpu), a_occ, m_a_occ);
> @@ -1363,13 +1374,10 @@ static void __no_profile task_cache_work(struct callback_head *work)
>  		}
>  	}
>  
> -	/*
> -	 * If the max average cache occupancy is 'small' we don't care.
> -	 */
> -	if (m_a_occ < (NICE_0_LOAD >> EPOCH_OLD))
> -		m_a_cpu = -1;
> -
> -	mm->mm_sched_cpu = m_a_cpu;
> +	if (m_a_occ > (2 * last_m_a_occ)) {
> +		/* avoid the bouncing of mm_sched_cpu */
> +		mm->mm_sched_cpu = m_a_cpu;
> +	}


The whole double thing doesn't seem right either. That means that
anything over .5 will never be able to change, even when confronted with
say a .8.

Also, while this is a threshold, this is not in fact hysteresis.


