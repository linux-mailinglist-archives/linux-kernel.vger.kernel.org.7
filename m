Return-Path: <linux-kernel+bounces-895737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7984C4EC94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42FF934CCC1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F22365A19;
	Tue, 11 Nov 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFtUu+J1"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7583054DF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875073; cv=none; b=RqPYh+t8fglq3jsJiEaLcjxBjH9rXO9QKfsQ/HcvOk/JGfcrEN5htoFqFlLjIGb5VhP+QzfW9WXWscjGXwya+1Jjm9h8XyjAn+C+9Q/Y9DKcOH5Pbw8vKSYEftsJ9u+Nkm4OWQcunpYImr6NewO7QtgNMp3mi17kyCqGHglvgAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875073; c=relaxed/simple;
	bh=QBAXJ78fohyt6k2DI/5d/7XOCgEhX0xfNpRwM+nrwR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh1kHzpDTNEqsNMlnuNJiLbd4uoXIa2UeQgNMUKq8XGXkZi50VfW9wQoIrm3v4UqiZtN7dcIXnD/Def1hpWfMIn461jLM6OaprguCtcPSYmjEagX2Us7waJ2wxpVogZeYyEc8rUHGXjlIhQV6pJIztwjfMdxwxsCcFEnuUBv4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFtUu+J1; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-880570bdef8so48606776d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762875070; x=1763479870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KSFVN0bHdAdRdoucgDhNJZXr+UXErbmutQRh+BOF22I=;
        b=fFtUu+J1B6t5x2oGwrWfEx7XNct4sPfaZtWL9x2jrAj6VaFEjT3sIcrHnfaU8gLGry
         TPx3E2xLJODUzz2wr6IM3e2bn2SZ4uH9Wv5mRhJEA+/eTpTkwhuDUF+5rTEhz+uQcF0h
         k5I/2CM3+fme7CtxQKuKoEWvGUSz4JNZ6qWc3v6mmPtb75EXoP/fkuJ/M1K/SO+Vx5ZL
         UTx4WLSsYX5FkGpbtzcTH6hKupJvQhPTmmn92jUNy7r6R8+SVgR/dwLiJrsuC9iwrQGD
         lRaDCDku7bj9bfLTfRxnHOJfXi4IiZb/eaa+2Izut6wXcKkTqmszn0PswwNA+82/iMXo
         +I2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762875070; x=1763479870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSFVN0bHdAdRdoucgDhNJZXr+UXErbmutQRh+BOF22I=;
        b=w35LNFLCiRezzl8emZPC6FI7eaNoBUWuF66IGUsv7zAj7Tpp2faiKBXsmvetNgeLo1
         ZnganIcrt/PZv09NYVZO0RwkXFI6q8w5j534DLZlGXLqTABJ/fnrZB32XBZN+mfTQkw5
         0YqoEDWUZu72klYRoHn0Ayyg9sS+Wq0UzQsm9mlJGlUsAqdgG4KHBHtfBQBeauyhmXqV
         6sZLylwwqnHnT4/1O/DJOc4RM+M6hGjA5RgZqkOPuU9f700q9QsNfMHOptggl152nXMX
         SirsZyy0dkjpSNgmZyTqawzonkYVLhNTJb2QAsMkDJpERpBXy7J3Xmhi8m6FiYo1H92Z
         nUKw==
X-Forwarded-Encrypted: i=1; AJvYcCXDO6QtZbbi/7Me3ebi/725nmUGej/1b7DC++nNCHzsNj8LMdD6m8K60e4SAMMOUC6SlqA1Fv+zhl2w9bM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygr9npjqrCK/b7CuxfEQIJvr5pExriapdzVwY+X5PCmrVolviS
	yCIcT0aOx/k8Vniylkp6f/2BEGPmoE2BQXVYqy+U3puJ6SoDPB3eNPKN1zDzJg==
X-Gm-Gg: ASbGncvprfoCK4wfNf6k62tV0nbB2fFxB3vWcz8KNtD5xNg0tK8uEuDaV8HCNUxsJ1Y
	vjaHAiR+XkQFBBpIFtZwmZjpgU0iv9T0Eww6S8iHPk33H3R3NkQnhhHVngD9vaSSjyCFB1ICJ5Q
	bBhARXd0+3SLmWR1kdQNuS1lqpvyNVTidSxdZeoQXxycel67Z7gDhrinMZ5HslIwYX2gVEvu9J8
	w7UPhxjK40gHhVGrUJJgqs8AIPPAfZAFYWTFGSw16AYcCVlZ9yv0qzth8pLCCPGRVw2DKCDPOJb
	XUk4h+KkCQlnxNSggL8wKVU4ArdCzMBBHO6StW6xhCh9ZEGqmz5HdpfbwZArnv4Okx8SybXd8Xs
	mE19diwRlcNEBEkLpbziSDm0G+vleCFyVuQbjK5yjmUUcmlEm19/FrL/DvAiIpbCZRBx/zYDNgv
	a/qto7lxmQ+w3eOQ==
X-Google-Smtp-Source: AGHT+IHC238rt8Ac7Kvuq6Q1invfKYeCwvKqRQul76p/dB7Feo7vavQWqduyRaZvfI5nNYth4NoU8w==
X-Received: by 2002:a05:6214:20ef:b0:87c:f97:7acf with SMTP id 6a1803df08f44-88238703304mr213297486d6.62.1762875069798;
        Tue, 11 Nov 2025 07:31:09 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::7:708f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b92c4csm74255436d6.57.2025.11.11.07.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:31:09 -0800 (PST)
Date: Tue, 11 Nov 2025 10:31:07 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] sched_ext: Use per-CPU DSQs instead of per-node
 global DSQs in bypass mode
Message-ID: <aRNWu_4F_wGRlM2Z@dschatzberg-fedora-PF3DHTBV>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-5-tj@kernel.org>

On Sun, Nov 09, 2025 at 08:31:03AM -1000, Tejun Heo wrote:
> When bypass mode is activated, tasks are routed through a fallback dispatch
> queue instead of the BPF scheduler. Originally, bypass mode used a single
> global DSQ, but this didn't scale well on NUMA machines and could lead to
> livelocks. In b7b3b2dbae73 ("sched_ext: Split the global DSQ per NUMA node"),
> this was changed to use per-node global DSQs, which resolved the
> cross-node-related livelocks.
> 
> However, Dan Schatzberg found that per-node global DSQ can also livelock in a
> different scenario: On a NUMA node with many CPUs and many threads pinned to
> different small subsets of CPUs, each CPU often has to scan through many tasks
> it cannot run to find the one task it can run. With a high number of CPUs,
> this scanning overhead can easily cause livelocks.
> 
> Change bypass mode to use dedicated per-CPU bypass DSQs. Each task is queued
> on the CPU that it's currently on. Because the default idle CPU selection
> policy and direct dispatch are both active during bypass, this works well in
> most cases including the above.
> 
> However, this does have a failure mode in highly over-saturated systems where
> tasks are concentrated on a single CPU. If the BPF scheduler places most tasks
> on one CPU and then triggers bypass mode, bypass mode will keep those tasks on
> that one CPU, which can lead to failures such as RCU stalls as the queue may be
> too long for that CPU to drain in a reasonable time. This will be addressed
> with a load balancer in a future patch. The bypass DSQ is kept separate from
> the local DSQ to allow the load balancer to move tasks between bypass DSQs.
> 
> Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/sched/ext.h |  1 +
>  kernel/sched/ext.c        | 16 +++++++++++++---
>  kernel/sched/sched.h      |  1 +
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 9f5b0f2be310..e1502faf6241 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -57,6 +57,7 @@ enum scx_dsq_id_flags {
>  	SCX_DSQ_INVALID		= SCX_DSQ_FLAG_BUILTIN | 0,
>  	SCX_DSQ_GLOBAL		= SCX_DSQ_FLAG_BUILTIN | 1,
>  	SCX_DSQ_LOCAL		= SCX_DSQ_FLAG_BUILTIN | 2,
> +	SCX_DSQ_BYPASS		= SCX_DSQ_FLAG_BUILTIN | 3,
>  	SCX_DSQ_LOCAL_ON	= SCX_DSQ_FLAG_BUILTIN | SCX_DSQ_FLAG_LOCAL_ON,
>  	SCX_DSQ_LOCAL_CPU_MASK	= 0xffffffffLLU,
>  };
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index a29bfadde89d..4b8b91494947 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1301,7 +1301,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  
>  	if (scx_rq_bypassing(rq)) {
>  		__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
> -		goto global;
> +		goto bypass;
>  	}
>  
>  	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
> @@ -1359,6 +1359,9 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  global:
>  	dsq = find_global_dsq(sch, p);
>  	goto enqueue;
> +bypass:
> +	dsq = &task_rq(p)->scx.bypass_dsq;
> +	goto enqueue;
>  
>  enqueue:
>  	/*
> @@ -2157,8 +2160,14 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
>  	if (consume_global_dsq(sch, rq))
>  		goto has_tasks;
>  
> -	if (unlikely(!SCX_HAS_OP(sch, dispatch)) ||
> -	    scx_rq_bypassing(rq) || !scx_rq_online(rq))
> +	if (scx_rq_bypassing(rq)) {
> +		if (consume_dispatch_q(sch, rq, &rq->scx.bypass_dsq))
> +			goto has_tasks;
> +		else
> +			goto no_tasks;
> +	}
> +
> +	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
>  		goto no_tasks;
>  
>  	dspc->rq = rq;
> @@ -5370,6 +5379,7 @@ void __init init_sched_ext_class(void)
>  		int  n = cpu_to_node(cpu);
>  
>  		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
> +		init_dsq(&rq->scx.bypass_dsq, SCX_DSQ_BYPASS);
>  		INIT_LIST_HEAD(&rq->scx.runnable_list);
>  		INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 27aae2a298f8..5991133a4849 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -808,6 +808,7 @@ struct scx_rq {
>  	struct balance_callback	deferred_bal_cb;
>  	struct irq_work		deferred_irq_work;
>  	struct irq_work		kick_cpus_irq_work;
> +	struct scx_dispatch_q	bypass_dsq;
>  };
>  #endif /* CONFIG_SCHED_CLASS_EXT */
>  
> -- 
> 2.51.1
> 

Reviewed-by: Dan Schatzberg <schatzberg.dan@gmail.com>

