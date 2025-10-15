Return-Path: <linux-kernel+bounces-854657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ED9BDF01D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7C819A04E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B7D25D533;
	Wed, 15 Oct 2025 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMdJq8O/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBDF34BA37
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538289; cv=none; b=Tidh7cn0JHe5iOiU5iW5F2rJcR3qu9IQco1mWmZDxhhRoQ6bCgPU+TdRuoSoD10uOswYE5U2+NCTN4xbMB90RMklKLhOP1yuMiGfZlsmmV0ikayGo206PjW48SzJdodo/nmnU3OQ3yrmVlepzD6RuWb4De4LnmCz/ixXdvzaeR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538289; c=relaxed/simple;
	bh=VI2G9//n5zjqGobSm8EFWcsEhUNu8SH7IDsCohF9+NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zn5j/rqwf/0RGSYG6V3tF7Xm7lIHR8iWv47bAmQepezWJ/cUWwoZsBtBdxeYEHLv7q6MeC4vYHcPFyQXSSRkM7fCetWDUrXVQ5ITGFj5Le7LktIi6717A1UbirtyEqhA4+AMoFAA8Nvw3biGXJLKs/vm5BCVm7WFOBQ78eiSC1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PMdJq8O/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760538286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ozqBrz5YYEDDU6fO6jRUaNchANEFpx1Jpq93/LUQQDI=;
	b=PMdJq8O/u+SJ7J/lpZCzvPtH6MP3h2hwzHxOyqV6zSYDK4cR5Hvi4h5NsBE61XtRvOFHlz
	qJ4YXq+wY+u7xh2vXIvusrLIGNE3ikiHm290Y/LXzS45LpGiljzvTpJTVYLVSDXMyaOdh6
	0sks8j1QnB77d0RqZoJowlwX5NNQ23M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-tsRwH4xEMuOEQ2iahbNNhQ-1; Wed, 15 Oct 2025 10:24:44 -0400
X-MC-Unique: tsRwH4xEMuOEQ2iahbNNhQ-1
X-Mimecast-MFC-AGG-ID: tsRwH4xEMuOEQ2iahbNNhQ_1760538284
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e473e577eso47850025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760538284; x=1761143084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozqBrz5YYEDDU6fO6jRUaNchANEFpx1Jpq93/LUQQDI=;
        b=Tonr7BpZ/Gvq/ezJuvi7G51abaYJcCZZXRp03AxovZ+scnXIQWoySzUzdK+0NKuGoM
         UU8nC9G3EOWUHCISruAbHf2d/An9VIwpayeYXQEQVn5uEJqqYgKOCK1702m2Ch1F3zlU
         vEXjqCLyyJDRVegLZZCIe1jrHV/2xkXoodQ1D0d2p0sn6GEz5lnuD1rmZSoqOtfTONac
         h51YqCuCAE7NrN4ddSp0ey+74JQkTS/Hh697BAlOxOYxZxJKbp3/cSBjFhZObNcjq87W
         8PBnQsMK0A+ayMIkZpCFpfV0A5ImOmiQiKbbK9IGmEl17/166/SAgllcGgmQr7jMAswe
         Htjw==
X-Forwarded-Encrypted: i=1; AJvYcCXkUehl3I1XAC+bB/1J8Z+f9anVlsrFhfOhS1jJmJi9QZGnPMcaUZB45TCwZoaGLy7ZD16gTxaAV8535no=@vger.kernel.org
X-Gm-Message-State: AOJu0YzunzNCWnHOrut8ef+sBNTvxqOlc2pKdJljr/e9kYgVbZ7QFag5
	Dsx105UVV1XjWlWJCdRL/H1THEyckDSW6GOi11JmVRMy8MFkglDu7zLF4IK7VM9LpkFA6Cygo8a
	stj5ftLD2VASscrn7KvhhxTJWZX4SDyRUPQs0LWqsIeeLy4tgovHMYPSMi1h16GVHRw==
X-Gm-Gg: ASbGncudphi2YqnokMf0GT2MtHZBBvpVMnSlB9XBPPBlI+ckHg5aInenyC/256CnxCm
	X4mtg47F/rRQQMspqXhnFAkgiXNvmBSRy3Wk4Iv1ePzvGiDaxflSumhjyn3mY06UbZYWimbsb4p
	2hQ1bOQIiZ+NZDN/5EVSz40eEhhZoJINK10hgVbKmYCJKEEa656JJdUE9oXJn3smwSrgF2lVMWy
	r6r/dbusRijMepXQdJZlKXJrkXjOkbMZaqqL7QWbWa8CwPmiTIv9jHLQH8mBucd1/D78fixTXQr
	4OV6yc/eJ95sAweKmHIt5n9n1w7QyubQbzkZaE1vV8e3r9TubAORXesbLxSSrD1PMEL3Zric
X-Received: by 2002:a05:600c:8206:b0:46c:d476:52f3 with SMTP id 5b1f17b1804b1-46fa9b021abmr184345485e9.26.1760538283597;
        Wed, 15 Oct 2025 07:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDJ45EHX8YylXfpODu03LRtssP9L7wolkb1tEwbfi1uR2ydFiaSx2QHRK4HaWhdPOlvjbivw==
X-Received: by 2002:a05:600c:8206:b0:46c:d476:52f3 with SMTP id 5b1f17b1804b1-46fa9b021abmr184345335e9.26.1760538283154;
        Wed, 15 Oct 2025 07:24:43 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101a576f7sm30335805e9.0.2025.10.15.07.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:24:42 -0700 (PDT)
Date: Wed, 15 Oct 2025 16:24:40 +0200
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
Subject: Re: [RFC PATCH v3 18/24] sched/deadline: Allow deeper hierarchies of
 RT cgroups
Message-ID: <aO-uqIZRS3qqsuN6@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <20250929092221.10947-19-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-19-yurand2000@gmail.com>

Hello,

On 29/09/25 11:22, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Allow creation of cgroup hierachies with depth greater than two.
> Add check to prevent attaching tasks to a child cgroup of an active cgroup (i.e.
> with a running FIFO/RR task).
> Add check to prevent attaching tasks to cgroups which have children with
> non-zero runtime.
> Update rt-cgroups allocated bandwidth accounting for nested cgroup hierachies.
> 
> Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> ---
>  kernel/sched/core.c     |  6 -----
>  kernel/sched/deadline.c | 51 +++++++++++++++++++++++++++++++++++++----
>  kernel/sched/rt.c       | 16 ++++++++++---
>  kernel/sched/sched.h    |  3 ++-
>  4 files changed, 62 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6f516cdc7bb..d1d7215c4a2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9281,12 +9281,6 @@ cpu_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  		return &root_task_group.css;
>  	}
>  
> -	/* Do not allow cpu_cgroup hierachies with depth greater than 2. */
> -#ifdef CONFIG_RT_GROUP_SCHED
> -	if (parent != &root_task_group)
> -		return ERR_PTR(-EINVAL);
> -#endif
> -
>  	tg = sched_create_group(parent);
>  	if (IS_ERR(tg))
>  		return ERR_PTR(-ENOMEM);
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 5d93b3ca030..abe11985c41 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -388,11 +388,42 @@ int dl_check_tg(unsigned long total)
>  	return 1;
>  }
>  
> -void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period)
> +bool is_active_sched_group(struct task_group *tg)

I wonder if the function name could be misleading, as this checks runtime
and not if there are tasks in the group.

>  {
> +	struct task_group *child;
> +	bool is_active = 1;
> +
> +	// if there are no children, this is a leaf group, thus it is active
> +	list_for_each_entry_rcu(child, &tg->children, siblings) {
> +		if (child->dl_bandwidth.dl_runtime > 0) {
> +			is_active = 0;
> +		}
> +	}
> +	return is_active;
> +}
> +
> +static inline bool sched_group_has_active_siblings(struct task_group *tg)
> +{
> +	struct task_group *child;
> +	bool has_active_siblings = 0;
> +
> +	// if there are no children, this is a leaf group, thus it is active

Copy-pasta from above? :) Also not the correct comment style.

> +	list_for_each_entry_rcu(child, &tg->parent->children, siblings) {
> +		if (child != tg && child->dl_bandwidth.dl_runtime > 0) {
> +			has_active_siblings = 1;
> +		}
> +	}
> +	return has_active_siblings;
> +}
> +
> +void dl_init_tg(struct task_group *tg, int cpu, u64 rt_runtime, u64 rt_period)
> +{
> +	struct sched_dl_entity *dl_se = tg->dl_se[cpu];
>  	struct rq *rq = container_of(dl_se->dl_rq, struct rq, dl);
> -	int is_active;
> -	u64 new_bw;
> +	int is_active, is_active_group;
> +	u64 old_runtime, new_bw;
> +
> +	is_active_group = is_active_sched_group(tg);
>  
>  	raw_spin_rq_lock_irq(rq);
>  	is_active = dl_se->my_q->rt.rt_nr_running > 0;
> @@ -400,8 +431,10 @@ void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period)
>  	update_rq_clock(rq);
>  	dl_server_stop(dl_se);
>  
> +	old_runtime = dl_se->dl_runtime;
>  	new_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
> -	dl_rq_change_utilization(rq, dl_se, new_bw);
> +	if (is_active_group)
> +		dl_rq_change_utilization(rq, dl_se, new_bw);
>  
>  	dl_se->dl_runtime  = rt_runtime;
>  	dl_se->dl_deadline = rt_period;
> @@ -413,6 +446,16 @@ void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period)
>  	dl_se->dl_bw = new_bw;
>  	dl_se->dl_density = new_bw;
>  
> +	// add/remove the parent's bw

Comment style is not correct. Also the comment itself is not very much
informative. What about something like (IIUC)

 /*
  * Handle parent bandwidth accounting when child runtime changes:
  * - Disabling the last active child: parent becomes a leaf group,
  *   so add the parent's bandwidth back to active accounting
  * - Enabling the first child: parent becomes a non-leaf group,
  *   so remove the parent's bandwidth from active accounting
  * Only leaf groups (those without active children) should have
  * non-zero bandwidth.
  */

> +	if (tg->parent && tg->parent != &root_task_group)
> +	{
> +		if (rt_runtime == 0 && old_runtime != 0 && !sched_group_has_active_siblings(tg)) {
> +			__add_rq_bw(tg->parent->dl_se[cpu]->dl_bw, dl_se->dl_rq);
> +		} else if (rt_runtime != 0 && old_runtime == 0 && !sched_group_has_active_siblings(tg)) {
> +			__sub_rq_bw(tg->parent->dl_se[cpu]->dl_bw, dl_se->dl_rq);
> +		}
> +	}
> +

Thanks,
Juri


