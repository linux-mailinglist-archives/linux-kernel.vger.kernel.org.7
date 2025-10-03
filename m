Return-Path: <linux-kernel+bounces-841525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722CEBB794D
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D494485ABE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F44E2C2346;
	Fri,  3 Oct 2025 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhISpB8Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E5E2C15AA
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509592; cv=none; b=lYCsRhb7eWhdZc9WN/en4RXgvQMF84d2lq8Zwc/rK9MmuPzLTmTLK9UGmco+lHYp0nItSKNiYC5UNli0oJjo/v6B8JuiW/Jo8xu/DGRwJrZHA2yfukX+OWHl/4x16sHVOX7KxygCmFe+uIEU3Rq31+lGz1A0zUp0ZbXUBg0yQgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509592; c=relaxed/simple;
	bh=okLywSLQERdqHv/E6qCu3rCfq43ywGN4F5Z6aGMxIUo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cNpWABJt90I+oEuhgWfPI5XVWEStbL4KzQdJ+MMuniz9OoMgwYd/enaXWOv6Corp2AIT4H74suXFyCaYykzJSCcB5pp7G4J6HeIVyrEcFLo+SiMVeBHUEBu1nWO1Pqm1dBwgdyuxxiAdakraG2J67Q4+p5Lj8/4cGrHkE0rf0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhISpB8Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759509589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HgK31/HNQg7ggKjdcNkWt1dqEAffaf6+FWeT+7NWoVw=;
	b=fhISpB8ZiaEyKpyoJvCzw8Ia7SjlNxru0GWvO4RTLhdulhXSd9AuLWLtBgr3gqjanjETKg
	W4kN8jMfLasSzqY1x/s4LfFCTUhay7ixVdesVq/85igQdBxoreEeMlCjc3foEAHY1Ou5+i
	579Ept+9TALSi5M/2V/0RCqm0H+EpA8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-7tAZcm11MAusxJywsHLcIQ-1; Fri, 03 Oct 2025 12:39:48 -0400
X-MC-Unique: 7tAZcm11MAusxJywsHLcIQ-1
X-Mimecast-MFC-AGG-ID: 7tAZcm11MAusxJywsHLcIQ_1759509588
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-803339f345bso5510206d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759509588; x=1760114388;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgK31/HNQg7ggKjdcNkWt1dqEAffaf6+FWeT+7NWoVw=;
        b=iiMVf6/LDmFMQlmr80g+bGIdVJ8WToFLMRpn9D5xraE2gIWrQcGuuaRvuapQQJC5ke
         lan4eukjOC3lW/BAAPdyWtRvbNtUZI2qMcAhptYmbwBwLN+Dn7RRlkdhqLRPYIjvRH5d
         asAE9x3oUQF9emyOoQg+dn8lhYYD1yqq+EuCyTD6wI+dJQ+RCYm27Zt+YRrA5y2KKoBN
         QFl43thFYUJ6r9pLKr3+lkxonMqGAEiNltwVeCMpavf4c7Baw6IQtTlyB1RYDC9ExqHh
         PAWN1PinuntgM/5woxCOgmzgIZpmW1ntvqq22idDvqKKx/fxmu/ABYINsWW+b/ayyA7E
         mQIg==
X-Forwarded-Encrypted: i=1; AJvYcCU49Gsn+/ki+DyW9wgEjbawGGRViaWgi/pQGv7+eU/AYIGj7kEpRzEFNdgsHEdxVyPmEWJhanKgLlDiJ1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5kWr5wSqHP+8OUBNTD7unOadvyDnwSM0fiAWw8t29RU6dfVsC
	4CqI1uVqS/zez2jRWPmuRHM2X3bHO7SxuyCVDCe+gyLm66vejunrFs51V9WdONS6kbXTaOpHyih
	GCPwrQXGU2AZI4naAWbGv9iS0+4DcvrcG/NRYw8EqspnUAMq0mj1B/k+N/PsFymZw+A==
X-Gm-Gg: ASbGncvcWIwL+lGN0CwmEAxTJ+aJjx/gbt55NKUeJ4P96JP8T2qZvS6pNx8JSQE/VM7
	XX77/GWiRJe1uxnPJDSYddvFKLAdhwQLaUZrOdteNZ9gsHNHv4mDF2N+ixcKRvKt5Fxeoq4ZJoO
	iHIykUwnhB/p0BBL2Fy804e30TpcUT3YXRbdMnTY4pau3kjS6jutULmuUv3BMIZuDJrQ921RVvZ
	+aSaqyQvN0zI8wG5HP7FFEvZTJ9ZB3wUUmVrMF312gcu0rh5R4lHkKcbZHySInbPqBi+IeFpfl/
	uyKzt9GuI0fA4+dASU6eQt6fB6dnSSFMU1E+dEfU/L8Q6+qPBDN2S8MPDAFkfQcD+t3MST07xHO
	HAx7jLs1GvRF/58do
X-Received: by 2002:a0c:f102:0:b0:7f0:e84e:b2b2 with SMTP id 6a1803df08f44-879dc85646emr40558546d6.57.1759509587594;
        Fri, 03 Oct 2025 09:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHskRaz1K3XctwHslNih4jWzaCR5M1nfAkWoKa8GC1GjUkr85SEE2VYgSuQKIM6wJEO5jyCeA==
X-Received: by 2002:a0c:f102:0:b0:7f0:e84e:b2b2 with SMTP id 6a1803df08f44-879dc85646emr40558126d6.57.1759509587029;
        Fri, 03 Oct 2025 09:39:47 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bbb17bf3sm42638946d6.27.2025.10.03.09.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 09:39:46 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a29a1849-e7f7-4c96-85be-6d8041ea1e57@redhat.com>
Date: Fri, 3 Oct 2025 12:39:45 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: cgroup: Move task_can_attach() to cpuset.c
To: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Andrea Righi <righi.andrea@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>
References: <20251003121421.0cf4372d@gandalf.local.home>
Content-Language: en-US
In-Reply-To: <20251003121421.0cf4372d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 12:14 PM, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>
> At our monthly stable meeting, we were talking about documenting non
> static functions and randomly picked a function to look at. That was
> task_can_attach(). It was then noticed that it's only used by
> cgroup/cpuset.c and nothing else. It's a simple function that doesn't
> reference anything unique to sched/core.c, hence there's no reason that
> function should be there.
>
> Move it to cgroup/cpuset.c as that's the only place it is used. Also make
> it a static inline as it is so small.
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   include/linux/sched.h  |  1 -
>   kernel/cgroup/cpuset.c | 19 +++++++++++++++++++
>   kernel/sched/core.c    | 19 -------------------
>   3 files changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e4ce0a76831e..4ee4fa973eda 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1849,7 +1849,6 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
>   }
>   
>   extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
> -extern int task_can_attach(struct task_struct *p);
>   extern int dl_bw_alloc(int cpu, u64 dl_bw);
>   extern void dl_bw_free(int cpu, u64 dl_bw);
>   
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 27adb04df675..21fe872803e8 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3009,6 +3009,25 @@ static void reset_migrate_dl_data(struct cpuset *cs)
>   	cs->sum_migrate_dl_bw = 0;
>   }
>   
> +static inline int task_can_attach(struct task_struct *p)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * Kthreads which disallow setaffinity shouldn't be moved
> +	 * to a new cpuset; we don't want to change their CPU
> +	 * affinity and isolating such threads by their set of
> +	 * allowed nodes is unnecessary.  Thus, cpusets are not
> +	 * applicable for such threads.  This prevents checking for
> +	 * success of set_cpus_allowed_ptr() on all attached tasks
> +	 * before cpus_mask may be changed.
> +	 */
> +	if (p->flags & PF_NO_SETAFFINITY)
> +		ret = -EINVAL;
> +
> +	return ret;
> +}
> +
>   /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
>   static int cpuset_can_attach(struct cgroup_taskset *tset)
>   {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ccba6fc3c3fe..a195c4b25475 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8070,25 +8070,6 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
>   	return ret;
>   }
>   
> -int task_can_attach(struct task_struct *p)
> -{
> -	int ret = 0;
> -
> -	/*
> -	 * Kthreads which disallow setaffinity shouldn't be moved
> -	 * to a new cpuset; we don't want to change their CPU
> -	 * affinity and isolating such threads by their set of
> -	 * allowed nodes is unnecessary.  Thus, cpusets are not
> -	 * applicable for such threads.  This prevents checking for
> -	 * success of set_cpus_allowed_ptr() on all attached tasks
> -	 * before cpus_mask may be changed.
> -	 */
> -	if (p->flags & PF_NO_SETAFFINITY)
> -		ret = -EINVAL;
> -
> -	return ret;
> -}
> -
>   bool sched_smp_initialized __read_mostly;
>   
>   #ifdef CONFIG_NUMA_BALANCING
Acked-by: Waiman Long <longman@redhat.com>


