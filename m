Return-Path: <linux-kernel+bounces-768304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB3B25F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E741CC0596
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1282D46A7;
	Thu, 14 Aug 2025 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1q4JDMF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520728BAB5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161469; cv=none; b=LlNWJuzURHQn687E0d9OkBxvdQ5Ix/Buez46SmCbKSHjHqenU1jreLtjAktqTDrS+Do9JQG7qdF4CUMpKRI2Ze67SzPfhPQ5bisQpwjqITqzEFgJkHIkVX3fbpORO9yMkP81POm2thG/w7AJLMExSgt6LrhY8oVXWQw0/kOsC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161469; c=relaxed/simple;
	bh=L+PtKm0h3KtbxqAiiSy7xschhJg5iVsY0IHISawEWHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kpq39FaSbzEd9FMAfh7TgBcJSphi4VsY3gxNFhoa2MvNzD24lvxWZqT96587Xmn1LpTYVv/V+fzeRy363B1wGGsbSVoMOrHBycvwCU7oYS6uM3KeJyQAyE4sbnu4+yRrEtxAXdhvNwclkF77Sz86uikJizKRHgh9DNOM0O1SOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1q4JDMF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755161466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ADZ4ilyP6zUmKYXerZFBdhor4DBAxartQ/o+X5YnbaY=;
	b=h1q4JDMFD01R03n/s4/ukcaJD1QCcEvJt/YhPdvO79Hors2jkVVE6y/d+SdAuTAoo65psZ
	zmpY7xq471SHvl9wpuwwfWwQeVaNTZEqjRTqq/5zP+RoK3lVRKSqgu3QPcZEK/GTqpLv1m
	2HQgKJ9TIL+2BdhaMlkTcGS99ve4p1U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-jFK-4wDdOk-j1v7AbZ2T6g-1; Thu, 14 Aug 2025 04:51:05 -0400
X-MC-Unique: jFK-4wDdOk-j1v7AbZ2T6g-1
X-Mimecast-MFC-AGG-ID: jFK-4wDdOk-j1v7AbZ2T6g_1755161464
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e870627e34so282343785a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755161464; x=1755766264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADZ4ilyP6zUmKYXerZFBdhor4DBAxartQ/o+X5YnbaY=;
        b=HSbuPO1h3JfB5dXPo6XMYY5RbE5H0mKtIbSx+9+kLBFwyKdPi6I6edjkGXYbrrj05P
         T85n8yNQp4C2xtuzbtcQT4ZnCPRHOxYfk86Xitq+l1CZEZC3QMTBBii4HLc8glge1jOA
         9FeVv8Fvsdqt6wRgwKvw4MgC6jgf134odsorcMNfeEc/gNNwC2PZq9bFw0B7pMWHL9Vs
         ZDPBHP3tR6+sophdhOBe4Or9gGpEyTXm2Wc1bWtbrGLoY70JLpeHNsKJp+MZJHTu3XSl
         Kyb1/FcN4wOg7W4lI6Rd7BhowbFsuBfz9ASDl6szq2ehrLube8dnwXhYSQw03s/Yn8Ed
         CaFw==
X-Forwarded-Encrypted: i=1; AJvYcCXoVij61xLWR4Qa1sZuDanfVyCi7cnAGqksp+0D0hMLO7OFpUgtwDluNwJ8OsoCIs+1/DWXkvS53c/WXfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2HcvGgPMprPQsZpB4ADw0vGGr4OBPXnMv41v+PlmaJuGfSeUE
	05TP19xPVR/JvmpJLFxnoKuBYfHrfwQaqPUqR4L0ORqUl7dQs/4W10J5qjI0Gu0jGUXiNHMKsL4
	RX/YWYywl3PYVHrB6LMEVqdVIXlboITden64SAPzEhtS7yfF6OyZ/rRhMx5JsnnNRYw==
X-Gm-Gg: ASbGncvBK8Zt7xsxkAyR1vto/Un+SBKvqk/0Y04XI1CQW6fPSZ9uKorZAS8RwRhtbQ+
	vVWy+mjXhG/EOCBWg5/kkk+PUsliUsB4XEHh3/xGI5LKfo4Cg32NebD5Zpj6N8nbwfRz90iVpEb
	t5Z8KHcUSAcM7iKYy6a0jb5udA+LWks2AQQqn2l6kfK0HJDllkzi/sBeMj3pJLItqGBOnX0H+ou
	7VMi8QkCMIyrVB/34eBJC+Bf+aFJd2uwRGeMF3maEZniIjH2sy36PWdQmgDOrqQ1PFYQ9oOu+jz
	CN2qSg676gNP2KALUZF0sbn6cnF45v5FXRwbfIGnPeP6uy2JgkXeinWeAUZNxSBhxIAy
X-Received: by 2002:a05:6214:3286:b0:70b:9ffd:b9b0 with SMTP id 6a1803df08f44-70b9ffdbfd5mr1986816d6.47.1755161464581;
        Thu, 14 Aug 2025 01:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnY17EI5pvOHSHDx35F+a399e8oECHj8KLWqEfsZZqKC9/CrEToOzSQIavBzUT24zYDjp6Cw==
X-Received: by 2002:a05:6214:3286:b0:70b:9ffd:b9b0 with SMTP id 6a1803df08f44-70b9ffdbfd5mr1986716d6.47.1755161464173;
        Thu, 14 Aug 2025 01:51:04 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.57.34.72])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5b0877fsm10408946d6.39.2025.08.14.01.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:51:03 -0700 (PDT)
Date: Thu, 14 Aug 2025 10:50:56 +0200
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
Subject: Re: [RFC PATCH v2 05/25] sched/rt: Move some functions from rt.c to
 sched.h
Message-ID: <aJ2jcIaHsKKFdUIL@jlelli-thinkpadt14gen4.remote.csb>
References: <20250731105543.40832-1-yurand2000@gmail.com>
 <20250731105543.40832-6-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731105543.40832-6-yurand2000@gmail.com>

Hi!

On 31/07/25 12:55, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Make the following functions be non-static and move them in sched.h, so that
> they can be used also in other source files:
> - rt_task_of()
> - rq_of_rt_rq()
> - rt_rq_of_se()
> - rq_of_rt_se()
> 
> There are no functional changes. This is needed by future patches.
> 
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> ---
>  kernel/sched/rt.c    | 52 --------------------------------------------
>  kernel/sched/sched.h | 51 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 52 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 945e3d705cc..3ea92b08a0e 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -168,34 +168,6 @@ static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
>  
>  #define rt_entity_is_task(rt_se) (!(rt_se)->my_q)
>  
> -static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
> -{
> -	WARN_ON_ONCE(!rt_entity_is_task(rt_se));
> -
> -	return container_of(rt_se, struct task_struct, rt);
> -}
> -
> -static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
> -{
> -	/* Cannot fold with non-CONFIG_RT_GROUP_SCHED version, layout */
> -	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
> -	return rt_rq->rq;
> -}
> -
> -static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
> -{
> -	WARN_ON(!rt_group_sched_enabled() && rt_se->rt_rq->tg != &root_task_group);
> -	return rt_se->rt_rq;
> -}
> -
> -static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
> -{
> -	struct rt_rq *rt_rq = rt_se->rt_rq;
> -
> -	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
> -	return rt_rq->rq;
> -}

Looks like we are losing WARN_ON checks with the change? Why is that?

...

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index a8073d0824d..a1e6d2852ca 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3042,6 +3042,57 @@ extern void set_rq_offline(struct rq *rq);
>  
>  extern bool sched_smp_initialized;
>  
> +#ifdef CONFIG_RT_GROUP_SCHED
> +static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
> +{
> +#ifdef CONFIG_SCHED_DEBUG
> +	WARN_ON_ONCE(rt_se->my_q);
> +#endif

And gaining this one above. :)

Thanks,
Juri


