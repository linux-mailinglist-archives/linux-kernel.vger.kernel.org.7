Return-Path: <linux-kernel+bounces-840418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11987BB4600
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B4C19C3829
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748E4220F2D;
	Thu,  2 Oct 2025 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buUsuc28"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188F74D8CE
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419324; cv=none; b=jXv1gXyK0uEYYB1DTviYtGG22BGYtEoqfRT89Jl5jQ3XRWWwRMbC0Yff0Yz5K6lhUrswSeODvjRKQmNqk5Y3D/1GkK3gefdsBPWNfGGgU8rZHPZ3+OWWKILM1czwS9EWgm3lZ/IJN6/sot6p9fkJNrEEfuVNGnJeRusNN2xiej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419324; c=relaxed/simple;
	bh=+3jL1+xUcK0SoNtKm4nYz4ToCDNc/EbaCjmDuxxVpgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7ucJNa8zX4oaxvxpq/ogoUKBWLqA+FNbA3WM9XbzNt1JvftzsfPczAwiryRBQkVDb+jS8Dm94iTfFT+bqsOLktx39TM/SsJewOVyvuJwBmaAaeRh45HKAbL/kEaikKZccgUfdwU2VKp7p/wvvbRDhDeyZhGErJQne/zHIgC+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=buUsuc28; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759419321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71yhr/e/+ZR0GLF/YCRkr0XQX/2f8HTKs9EYu7pd65o=;
	b=buUsuc28RZYwzf6n3QLFm7VFJQEArnO7TjdKEkunjYEIf3LQLahMCe2MOxppKg7CNZqh/Z
	BI3xt6gB+AAXhnCx7vMGClCoeygfnWa1+3a+z+aTh+hpkI6av0YXKAJ6No0hHvPxZKW74e
	3i/PLSLk7SviygJogdhjvG1Qk5NW2sQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-d1oDNqW6N5esCpvy3F3XyQ-1; Thu, 02 Oct 2025 11:35:20 -0400
X-MC-Unique: d1oDNqW6N5esCpvy3F3XyQ-1
X-Mimecast-MFC-AGG-ID: d1oDNqW6N5esCpvy3F3XyQ_1759419319
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8635d475527so305279785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759419319; x=1760024119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71yhr/e/+ZR0GLF/YCRkr0XQX/2f8HTKs9EYu7pd65o=;
        b=TPJE6soWYhtx31sbzjTO8QDALRZLf8JrGEUhsJLmxQcWBx1cz4v+HssQbTSCgB8qG8
         2tzxOffXCAy0PAtIhzgnoiblcbZyArx23C90LnwKPD+tRV+0Wu4CwsTKnZJwTd7UObOH
         7FVCntcFb9mgRvMa9u/ifLxbsLfUxIdL6z2iK+neetB05UqpGviKHrG4kCve9yGZlcx/
         YfiCtFiL4UI0Enuc4csaD1uQh3SVgPPZ445XoZbHdMBm6mGfTOnlEqIpAmrVCG3LwweD
         ZYwyiN+mDHeK3Sw4XOxudOFc+pXHK/y84Fm5CT0woKNE9LOObu03Viblaohs0P39goMf
         dnRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc4AoX6K795EiAxuZa3laIc1x5SH7bPlGP+FvLPOH4C6amSn/o8pJZju1BrxncBL+o0z4opmRGphUSJDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThQemlgVtY7fWlaXvYDMiByjPO9AHP3nVK6kZitJ6x/mVlZTJ
	W1llc4536PusocPFMECXcR/jVKJR/5TtsUR9NzYXav0N/1NCFUkAbnCpMwgLTzrPCCSVVas9GPW
	LIm1w0yIVPxtwMeWDfGf5rZfLCuXaUC4Q1jOrp0rce8U4r16ZIjeZKXJuKmY+FwoWGg==
X-Gm-Gg: ASbGncvnfX+DuZpZoJz3Rmj4Gr3Vzxnw7hHCWdqRN452n1ab0blU2N/XV1VCl0RboQM
	EKyWxTrKfvC7sfS1XfFZQT0+zfuzsqptnvkOpqBCIqrmRR59tBbjyagLSdmx5Q9yCLDqRnNIDQk
	f0IVxmJqik924Z9+X1SXu3AFZbBn2hSe1xpTJAg89XhY2MyiWOS1yoZ+S+yuwLnb/7ee3L/tyZA
	ZbBgZXYoT0D49LAU4C8EXA1JDQtmk++WFOv1ErCqVsTDandJYTmmW+VOYwu9fp1CCZjF8yDtkBU
	O9gosLFy6UMQlHfQzplIeiRFeaT1qgvKyzSjCgtV3h3IFrxvogcCe6gOJii7hlWRIn6ITRfqFqB
	CywLrrICthwF7DeasRCuB+g3J
X-Received: by 2002:a05:620a:2806:b0:814:54ee:f322 with SMTP id af79cd13be357-8737415ea91mr1072359985a.18.1759419319323;
        Thu, 02 Oct 2025 08:35:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8j/tytlKFFVYyHcTo2LZaPnt+q1mCmEmzQMWH36vAXFUMzLckmD7sscIUh7XA6OYBuvVeuw==
X-Received: by 2002:a05:620a:2806:b0:814:54ee:f322 with SMTP id af79cd13be357-8737415ea91mr1072353185a.18.1759419318699;
        Thu, 02 Oct 2025 08:35:18 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-6-60.as13285.net. [80.47.6.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87773789aadsm222049985a.29.2025.10.02.08.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:35:17 -0700 (PDT)
Date: Thu, 2 Oct 2025 16:35:13 +0100
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
Subject: Re: [RFC PATCH v3 05/24] sched/rt: Disable RT_GROUP_SCHED
Message-ID: <aN6bsSW1zSjuDV3q@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <20250929092221.10947-6-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-6-yurand2000@gmail.com>

Hello,

On 29/09/25 11:22, Yuri Andriaccio wrote:
> Disable the old RT_GROUP_SCHED scheduler. Note that this does not completely
> remove all the RT_GROUP_SCHED functionality, just unhooks it and removes most of
> the relevant functions. Some of the RT_GROUP_SCHED functions are kept because
> they will be adapted for the HCBS scheduling.
> 
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> ---
>  kernel/sched/core.c     |   6 -
>  kernel/sched/deadline.c |  34 --
>  kernel/sched/debug.c    |   6 -
>  kernel/sched/rt.c       | 848 ++--------------------------------------
>  kernel/sched/sched.h    |  11 +-
>  kernel/sched/syscalls.c |  13 -
>  6 files changed, 26 insertions(+), 892 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ccba6fc3c3f..5791aa1f8c8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8721,11 +8721,6 @@ void __init sched_init(void)
>  
>  	init_defrootdomain();
>  
> -#ifdef CONFIG_RT_GROUP_SCHED
> -	init_rt_bandwidth(&root_task_group.rt_bandwidth,
> -			global_rt_period(), global_rt_runtime());
> -#endif /* CONFIG_RT_GROUP_SCHED */
> -
>  #ifdef CONFIG_CGROUP_SCHED
>  	task_group_cache = KMEM_CACHE(task_group, 0);
>  
> @@ -8777,7 +8772,6 @@ void __init sched_init(void)
>  		 * starts working after scheduler_running, which is not the case
>  		 * yet.
>  		 */
> -		rq->rt.rt_runtime = global_rt_runtime();
>  		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
>  #endif
>  		rq->sd = NULL;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 6ff00f71041..277fbaff8b5 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1508,40 +1508,6 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>  		if (!is_leftmost(dl_se, &rq->dl))
>  			resched_curr(rq);
>  	}
> -
> -	/*
> -	 * The fair server (sole dl_server) does not account for real-time
> -	 * workload because it is running fair work.
> -	 */
> -	if (dl_se == &rq->fair_server)
> -		return;
> -
> -#ifdef CONFIG_RT_GROUP_SCHED
> -	/*
> -	 * Because -- for now -- we share the rt bandwidth, we need to
> -	 * account our runtime there too, otherwise actual rt tasks
> -	 * would be able to exceed the shared quota.
> -	 *
> -	 * Account to the root rt group for now.
> -	 *
> -	 * The solution we're working towards is having the RT groups scheduled
> -	 * using deadline servers -- however there's a few nasties to figure
> -	 * out before that can happen.
> -	 */
> -	if (rt_bandwidth_enabled()) {
> -		struct rt_rq *rt_rq = &rq->rt;
> -
> -		raw_spin_lock(&rt_rq->rt_runtime_lock);
> -		/*
> -		 * We'll let actual RT tasks worry about the overflow here, we
> -		 * have our own CBS to keep us inline; only account when RT
> -		 * bandwidth is relevant.
> -		 */
> -		if (sched_rt_bandwidth_account(rt_rq))
> -			rt_rq->rt_time += delta_exec;
> -		raw_spin_unlock(&rt_rq->rt_runtime_lock);
> -	}
> -#endif /* CONFIG_RT_GROUP_SCHED */
>  }
>  
>  /*
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 02e16b70a79..efcf8d82f85 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -890,12 +890,6 @@ void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
>  
>  	PU(rt_nr_running);
>  
> -#ifdef CONFIG_RT_GROUP_SCHED
> -	P(rt_throttled);
> -	PN(rt_time);
> -	PN(rt_runtime);
> -#endif
> -
>  #undef PN
>  #undef PU
>  #undef P
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index a599f63bf7f..c625ea45ca7 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1,3 +1,4 @@
> +#pragma GCC diagnostic ignored "-Wunused-function"

Uh oh, guess this goes away with later patches? It's anyway not very
nice unfortunately and it also breaks the SPDX licence first
requirement.

>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Real-Time Scheduling Class (mapped to the SCHED_FIFO and SCHED_RR

So, this leaves only a skeleton of the current RT_GROUP implementation.
I believe cgroup ABI will still be there, but it won't have an effect.
Since this is part of an atomic all-or-nothing set of changes, maybe
it's OK? Guess people can get confused if for some reason they end up
using a kernel with patches only up to this one. :-)

Best,
Juri


