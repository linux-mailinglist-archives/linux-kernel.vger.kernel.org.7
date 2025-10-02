Return-Path: <linux-kernel+bounces-840324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE57EBB41DD
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 16:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E83B17BE49
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 14:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B4C13B5AE;
	Thu,  2 Oct 2025 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/kCvx3e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED96E139E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413698; cv=none; b=DWo1BxxNI44e/WRbzJ06ZrY8m4wPH0yWhO1ZhTSRFDRhp7ZgCVaKo1ZTx211BhNjUY5qmFGUon5p6dfuwnc95890ue8qiIrvKJohSZi/6PmR6cFP6jKYvDp8URoY24WAu6lG8N08x/djyh6GlsC3fGIgdjERkot9MjTYEvR5Xu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413698; c=relaxed/simple;
	bh=qvGG5Sp/wls0uIdw2iHlnWQPg9UFRvDF57gXXnxB8bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHl9rj+8vdS/BX90mJOSOsuh8C1SUHiTLAp5NvsdCmx1VuEgubzlmYDVbNJal5F4UI5y31Lyc/1+TsKUvMWsZJYMbYxDGEp0v5rYDw8HL+VOY4XiXe7NTkutjK2y34GS78BfQAbGBL4aqTfT/sPbnUItm8USrZWZd2IAtgvhDz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/kCvx3e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759413696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BkWeVgZk8kUqiPYnzR3sGa1HOxeTHYc8DALzvEtqa9s=;
	b=I/kCvx3egx86UNT42J0d4MH2bt+R3AEUjF6VDOG6QCwwwnCu8PuyaxMZIydJXh2wbPPBhz
	CgNkYn9FgfmX0bv4gwyZsAZ8Xxx4RNYjkn0pmOo+EAWBVqBznuSXlwGaidETMK7BHGtkDW
	Gv7jSHCGIZPQopluHZVz11VoXyMwCPE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-PGIcKr1fPeG8r_vMOJbPoA-1; Thu, 02 Oct 2025 10:01:34 -0400
X-MC-Unique: PGIcKr1fPeG8r_vMOJbPoA-1
X-Mimecast-MFC-AGG-ID: PGIcKr1fPeG8r_vMOJbPoA_1759413694
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-74381f4c715so1684147a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 07:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759413694; x=1760018494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkWeVgZk8kUqiPYnzR3sGa1HOxeTHYc8DALzvEtqa9s=;
        b=bG5oo2H0STCmtV1mzcmTmmxf3MtsLYOjJ+VX4NK3zi0RBZLLyPBT+lDtrHDHe9SUev
         sVWqIsTKBFNFMkJOlRhfCrRPtS6/qeOtSYGwcfJVgyAEHNxF/WEmh4P6a8nBNtvhKLds
         om25IMI8DmgGR2Sd0dbCr3iZl24ZuF2J2lm8BUiJN0Tw9iV+g+i4Jb5UAWdAQxWljfa+
         pElXWAGPeVWgMszkZmnN3bIWm44DMadcRoBJpTyum8T4/7y7EAhBRSQzdw1sVo1BMNc+
         q7/juGlWyV0l+7dX+jG7h1AByjHVmahrMD8dB0/42lnB7VR6SH+uwM1YtVsdzRUaxg5x
         g9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+Oyq0caQPdpcmUHlt/Gxb3BC9Fiqvx/DjZvWuvjl1ACE55x55raLxSycPvG2XOLUTUQlPhmJkE6ntU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySDG61kEI8QZId3HA9TPpom5BZnJeRCs1shwhEzRZvWAlG1jgG
	1qidUUYYBIVeD3iNb/cp5rUGJNODqu4keRl0B7CedEiAREBAszkOMUvN96iXgT4ZXSqPYHEcsUh
	OzPkyClDLa9PJHzDUfyOC1JHq4BDQSr3vVj1e4DIrzg5BHj4BpvAuD84eaTvdvm2jMw==
X-Gm-Gg: ASbGncsG8rC+wPjb3jl/DV3R2OOEuYNUaui3NfzO7NohVB8qS4RdVbI7kRwatWnovjA
	txOvyCEqphs49/PgaM7oN4DgRJxpDdI7DGcEKPai31KlyZTXmi++Iw2HmB+Ky+izr9bN/q4OVtV
	2vWsH8+UmVh59R2cMBLZ7j6UE645R5vxAuhqERP4PsE9t8TkhiqP2Fh0Kq/b82/OnStiXfZLxsZ
	Uvig4TjL0nL7THhLBX0gqalq4Mhf6f3iSigMIJlNtpHjI9TJJ0N9mDGUUTM1O3RHu7d/utpo6f5
	GRXs2+0DmfTTobdBAOsnnslfBbGrX7RJnRKuQPbbkHfzCbt+47Uldj+lH/Kmog+yNHQVbVyKfRO
	8JOWZVlqK7uXC4qaecJW2EZ4b
X-Received: by 2002:a05:6830:6388:b0:799:bdea:3470 with SMTP id 46e09a7af769-7bddb3180e7mr6320228a34.18.1759413693819;
        Thu, 02 Oct 2025 07:01:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFifkv3G0JYpxDmZZsqPFwY4V7Lyatv9jR3a1EVRoOQC8n0sy+M4wfNVLE6WgPIWF6BKQZlig==
X-Received: by 2002:a05:6830:6388:b0:799:bdea:3470 with SMTP id 46e09a7af769-7bddb3180e7mr6320049a34.18.1759413692979;
        Thu, 02 Oct 2025 07:01:32 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-6-60.as13285.net. [80.47.6.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777892eadasm211882885a.39.2025.10.02.07.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 07:01:30 -0700 (PDT)
Date: Thu, 2 Oct 2025 15:01:25 +0100
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
Subject: Re: [RFC PATCH v3 03/24] sched/rt: Pass an rt_rq instead of an rq
 where needed
Message-ID: <aN6FtY-J3WXlGaNv@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <20250929092221.10947-4-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-4-yurand2000@gmail.com>

Hello,

On 29/09/25 11:22, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Make rt.c code access the runqueue through the rt_rq data structure rather than
> passing an rq pointer directly. This allows future patches to define rt_rq data
> structures which do not refer only to the global runqueue, but also to local
> cgroup runqueues (rt_rq is not always equal to &rq->rt).
> 
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> ---
>  kernel/sched/rt.c | 99 ++++++++++++++++++++++++++---------------------
>  1 file changed, 54 insertions(+), 45 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 7936d433373..a7d063d2303 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -370,9 +370,9 @@ static inline void rt_clear_overload(struct rq *rq)
>  	cpumask_clear_cpu(rq->cpu, rq->rd->rto_mask);
>  }
>  
> -static inline int has_pushable_tasks(struct rq *rq)
> +static inline int has_pushable_tasks(struct rt_rq *rt_rq)
>  {
> -	return !plist_head_empty(&rq->rt.pushable_tasks);
> +	return !plist_head_empty(&rt_rq->pushable_tasks);
>  }
>  
>  static DEFINE_PER_CPU(struct balance_callback, rt_push_head);
> @@ -381,50 +381,54 @@ static DEFINE_PER_CPU(struct balance_callback, rt_pull_head);
>  static void push_rt_tasks(struct rq *);
>  static void pull_rt_task(struct rq *);
>  
> -static inline void rt_queue_push_tasks(struct rq *rq)
> +static inline void rt_queue_push_tasks(struct rt_rq * rt_rq)

Nit, remove space                                     ^^^

>  {
> -	if (!has_pushable_tasks(rq))
> +	struct rq *rq = container_of(rt_rq, struct rq, rt);
> +
> +	if (!has_pushable_tasks(rt_rq))
>  		return;
>  
>  	queue_balance_callback(rq, &per_cpu(rt_push_head, rq->cpu), push_rt_tasks);
>  }
>  
> -static inline void rt_queue_pull_task(struct rq *rq)
> +static inline void rt_queue_pull_task(struct rt_rq * rt_rq)

Nit, remove space                                     ^^^

>  {
> +	struct rq *rq = container_of(rt_rq, struct rq, rt);

Still need to check with the full series (and it's OK up until here),
but I guess this needs special attention with tasks inside groups to
make sure we don't queue callbacks in rqs representing groups?

> +
>  	queue_balance_callback(rq, &per_cpu(rt_pull_head, rq->cpu), pull_rt_task);
>  }

Thanks,
Juri


