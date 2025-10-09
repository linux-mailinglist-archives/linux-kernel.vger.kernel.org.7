Return-Path: <linux-kernel+bounces-846569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCD6BC85FD
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8048350ADB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C32B2D7817;
	Thu,  9 Oct 2025 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGvmaJiH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699FF34BA49
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760003490; cv=none; b=DFn5gOIUdx5vlPMhXI6gBQecMOCyG/5oK2JhzEvvXn7ek4zsB/Wr6LGy/pwtsiEbMtotVcam2mzJYlGRP5WL4H8yPYR2aXTaybMMAEI098Gi3jCRGHv/ng4CRP2YD5EdwSRgZV6kl/jx2fpgqhCXtuElUNqCr1P916aOflNkSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760003490; c=relaxed/simple;
	bh=ybGc7cmkrEfAcvvKj25CdSXPkxdko9E7mfTwQE9NTOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftcQ9BiskmaaGmYjqPtATrjUUt8qoJCvRvlwHJhQycqrvg4hYMx5UV7kzNG1TFTvJdJHORaRsoxxS42ZdGEMq4IRSDSfj9VrzUwpDI2yX9UKolmn+B0DBD18HiTLCYepFk0Al937RoxqF03c93DYxpZLE4rc5iGnh8Lw8bAXvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGvmaJiH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760003487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvOnl5hsJoPzKb+GRzdNXASYsrHQyA7x/6tqf51SUQU=;
	b=EGvmaJiH6LfxSSfu1/DG6wWy9Vq8Yoy3i5EqJ3lX7liwhWosAn0XMFr96x+fumLKEo07UW
	gRK2nnD9xdSSGH8Y2BjCXFJ8t8VtjKKfLfn0n0Ld1qQYRlPfeS+wwQqHU210XLfzzSDqs9
	vgjbG3Ixn4GDLZpdFm4msjn9+ctJOxs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-cHtu5YgjPUe7m63wdtZiJA-1; Thu, 09 Oct 2025 05:51:26 -0400
X-MC-Unique: cHtu5YgjPUe7m63wdtZiJA-1
X-Mimecast-MFC-AGG-ID: cHtu5YgjPUe7m63wdtZiJA_1760003485
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f4fbdf144dso501753f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760003485; x=1760608285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvOnl5hsJoPzKb+GRzdNXASYsrHQyA7x/6tqf51SUQU=;
        b=r1OszLAyOzceg92GsqcZT7VVAA8CMFwPcqGdKvspec9Qxs1IeEIMMFuAI34MLnZBj/
         +0krLWIlNA3y77J5QvB4n/yxQc6UzviiPVlJJ3kjkxKbW7IfK6gEKSBLoHs3O6NwiSKZ
         VOxjv1qRBgNTx8Go2e/QBc6IEIo7+KpFEY9Hm29UUBLdX490561+AIxLi9uj0Bhc6XWh
         QJ53rJTjMtYpFF3ySGMw67HJ4L4bcWfo9okQ+beV9bv9kTYVdtgzpa8jQVFMFa9ejhwO
         T8BeMrc6QaIdnVBcdOiH8ccCDssXNwFjZE1jcMMGqZQ8DWGfup5ZNivGeRu2kdUJosC6
         aBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXimUA6Ly0sAHovALQnjCcPgxDDUhnmvZOhU6yZPzoGPsq1kRc/FblmuvUNu2TGEHqruTYV+KLKZfaOL10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiOAkdQ/wWsLqZXV3BKZEqoV2Y7sWAISwchMhYGRfwGPOqbiVb
	T2wWQy2PRPr9OdTnIOh2ei50b7ZraiMOOIDB8mJRDTu6S+GHVsHkvO4FYQE6dRZ7Tm9191sTQlz
	aXGwRYErwiq3MbnxKh5/5PXbcJUBBvwad9NYhvkpmpzQfmCGHh4dSAS/LzxgKp0J0WA==
X-Gm-Gg: ASbGncvijjtPEsztUFjxyAkVJ4ogsKoOAHzN+xk/uz29i11mjAahabH4Si7X+JDcRvf
	8o4VZvTlbIDm9oEsl3jlM9U9Fbna13jQkaVEEZmj7xy9Vaep1FiIxoGI1eFdZAthOKqfN24BoXE
	rKy4nuulPkmRrSElxa33Lyx+XxCAaSOEbRSl2MTG98su/KMwvf+AYEjxCEXsPRh3CJFkBbUDqNf
	VFJ5J69xTE7RXAlXijQSZ/XmdoWIPhhgIFPr1EzJn0R47fPdK76oYOrGD0nuJFOcxgFS3DzEd5J
	q6eHETSToEWpXwcnKAxSJfMtx5VWJ6FAAGpZsXIVjBm+lU3/A4UdOpLMd1Rx2mRtz5nMjI33s6I
	HRg==
X-Received: by 2002:a05:6000:4212:b0:406:87ba:99a3 with SMTP id ffacd0b85a97d-4266e8d8a8bmr3858491f8f.30.1760003484741;
        Thu, 09 Oct 2025 02:51:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEifdBk3XaRrgs3RsEwp8VgEGQ2iYk3qsYH96fbo3yKA++bXlWge6IbA6VNnqn92ji4FoRPXA==
X-Received: by 2002:a05:6000:4212:b0:406:87ba:99a3 with SMTP id ffacd0b85a97d-4266e8d8a8bmr3858456f8f.30.1760003484205;
        Thu, 09 Oct 2025 02:51:24 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8acc4csm33496504f8f.16.2025.10.09.02.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:51:23 -0700 (PDT)
Date: Thu, 9 Oct 2025 11:51:21 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v3 13/24] sched/rt: Update rt-cgroup schedulability
 checks
Message-ID: <aOeFmZIBIj6HDiIZ@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <20250929092221.10947-14-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-14-yurand2000@gmail.com>

Hello,

On 29/09/25 11:22, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Update schedulability checks and setup of runtime/period for rt-cgroups.

So, it looks like changelogs are all too minimal and dry. Having a more
comprehensive (but concise) description of what the patch does, why it
does it and how, will help reviewing and is essential in the future to
trace back design decisions and issues. Please consider this for current
and previous/subsequent patches.

> Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
> Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
> Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> ---
>  kernel/sched/core.c     |  6 ++++
>  kernel/sched/deadline.c | 46 +++++++++++++++++++++++----
>  kernel/sched/rt.c       | 70 +++++++++++++++++++++++------------------
>  kernel/sched/sched.h    |  1 +
>  4 files changed, 87 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2cfbe3b7b17..1217f714dd2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9281,6 +9281,12 @@ cpu_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  		return &root_task_group.css;
>  	}
>  
> +	/* Do not allow cpu_cgroup hierachies with depth greater than 2. */

I believe this limit gets removed with later patches, but since we have
it here, we should state why we have the limit in place.

> +#ifdef CONFIG_RT_GROUP_SCHED
> +	if (parent != &root_task_group)
> +		return ERR_PTR(-EINVAL);
> +#endif
> +
>  	tg = sched_create_group(parent);
>  	if (IS_ERR(tg))
>  		return ERR_PTR(-ENOMEM);
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 1293b9a252b..5d93b3ca030 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -347,7 +347,47 @@ void cancel_inactive_timer(struct sched_dl_entity *dl_se)
>  	cancel_dl_timer(dl_se, &dl_se->inactive_timer);
>  }
>  
> +/*
> + * Used for dl_bw check and update, used under sched_rt_handler()::mutex and
> + * sched_domains_mutex.
> + */
> +u64 dl_cookie;
> +
>  #ifdef CONFIG_RT_GROUP_SCHED
> +int dl_check_tg(unsigned long total)
> +{
> +	unsigned long flags;
> +	int which_cpu;
> +	int cpus;
> +	struct dl_bw *dl_b;
> +	u64 gen = ++dl_cookie;
> +
> +	for_each_possible_cpu(which_cpu) {
> +		rcu_read_lock_sched();
> +
> +		if (!dl_bw_visited(which_cpu, gen)) {
> +			cpus = dl_bw_cpus(which_cpu);
> +			dl_b = dl_bw_of(which_cpu);
> +
> +			raw_spin_lock_irqsave(&dl_b->lock, flags);
> +
> +			if (dl_b->bw != -1 &&
> +			    dl_b->bw * cpus < dl_b->total_bw + total * cpus) {

Does this need to use cap_scale()?

> +				raw_spin_unlock_irqrestore(&dl_b->lock, flags);
> +				rcu_read_unlock_sched();
> +
> +				return 0;
> +			}
> +
> +			raw_spin_unlock_irqrestore(&dl_b->lock, flags);
> +		}
> +
> +		rcu_read_unlock_sched();
> +	}
> +
> +	return 1;
> +}
> +

...

> @@ -2034,8 +2029,8 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
>  	unsigned long total, sum = 0;
>  	u64 period, runtime;
>  
> -	period = ktime_to_ns(tg->rt_bandwidth.rt_period);
> -	runtime = tg->rt_bandwidth.rt_runtime;
> +	period  = tg->dl_bandwidth.dl_period;
> +	runtime = tg->dl_bandwidth.dl_runtime;

Just as an example, this is the kind of important change (rt_bandwidth
-> dl_bandwidth) that usually deserves to be explicitly mentioned in the
changelog.

...

> @@ -2097,6 +2096,20 @@ static int __rt_schedulable(struct task_group *tg, u64 period, u64 runtime)
>  		.rt_runtime = runtime,
>  	};
>  
> +	/*
> +	* Since we truncate DL_SCALE bits, make sure we're at least
> +	* that big.
> +	*/
> +	if (runtime != 0 && runtime < (1ULL << DL_SCALE))
> +		return -EINVAL;
> +
> +	/*
        ^
Nit, fix alignment.

> +	* Since we use the MSB for wrap-around and sign issues, make
> +	* sure it's not set (mind that period can be equal to zero).
> +	*/
> +	if (period & (1ULL << 63))
> +		return -EINVAL;
> +

Thanks,
Juri


