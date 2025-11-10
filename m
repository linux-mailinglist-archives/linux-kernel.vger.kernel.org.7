Return-Path: <linux-kernel+bounces-892939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3ADC462C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3463B6FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77911307486;
	Mon, 10 Nov 2025 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIcu67Cc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTtM3arm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9F221542
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773287; cv=none; b=J17HfOSeRLeQ4JWm2lnHrssKdKPQBN2E/sPn9rI6pXAzIYnGpDGo04I5xfy7eUCCSCDfJV46PypZOdWPP3v8M0N4vJoaJV44MEqhLggWCtSu52sRZvwlzKm0GPf49wGm0DX+MWjdDDhtPL6NEeg1uWRAi3hm9RyToZU6YM+xiAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773287; c=relaxed/simple;
	bh=SURQ4NlwgOrSqd+Gpu6c4JbLevAYQ5ExBhpW4iYm6Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fukcfj7M4xnzdlY+iDwGeO2ebTMVnIS+OSOTgcXjZukVOMuV7LI4Wfi6lf1GLcWzD2hj2WSe3lWomQW8PW+9yOyRbbArBVyFRd0Fr/LS7fxGmUkRiHNE7qzSbQtksYoQBCq3bYe0jgHbzsLmFRCwU3/UxCOG8VKAXjx/SGBe4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIcu67Cc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTtM3arm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762773284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Py+740NixF0P+XPW3DD1TJP5gqzzgehIaFEcKIhOQ+E=;
	b=PIcu67Cc1Arr07mrCTU96HBbwLIqB/Ppela2Ky/O9IYkl2CpGTmnQu9Z6y1UoWbP3yLU88
	/X1QrAbsIfaX3lvzkL/RQAaU41uCKgi5jVLDqfCxUm7HV7hn097o/ifLBhjfuJji8WWR1Y
	6zK2Kq4jAusXPEhO9GqY2IhLxdDoPYU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-9FUdfhhYPYCT_V8hxYa3lw-1; Mon, 10 Nov 2025 06:14:43 -0500
X-MC-Unique: 9FUdfhhYPYCT_V8hxYa3lw-1
X-Mimecast-MFC-AGG-ID: 9FUdfhhYPYCT_V8hxYa3lw_1762773282
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477563e531cso35375755e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762773282; x=1763378082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Py+740NixF0P+XPW3DD1TJP5gqzzgehIaFEcKIhOQ+E=;
        b=fTtM3arm+qjtUFrXee6/1bu/0nA9g6jU6Lpmu80uonYQYrgOWGFxKpxb9ormtpRc1z
         jnB/YRT2+rn4Lih9NT9jdSc3VGOYMVNGFuK+JYekywcODAN7JKtr+8RYjx8L6ZWZyBRn
         XjWFQmcc4gN4SXb6jXOJ7kVur1h5M8+TOOvXvv23MoDvELpeT1BthYH+V69D/ltg0d6W
         /8EHGuODgl7mrzYt/w9dnZkfL3RmZSis08zwjE3lvZB8OYimtBihJ4lZiE6wAzKpSP+C
         Q0Pm9eU/ZKQRr3yAGeMtucMQSqcLHE5zB7p/0XATCE7UgzoStSZI9S2e/0Cx3xs0w1iY
         pz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762773282; x=1763378082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Py+740NixF0P+XPW3DD1TJP5gqzzgehIaFEcKIhOQ+E=;
        b=sJtIf8BG5infwT+bQdR9HyNz1T9VkfpZ8yKQKu2sKqlZxnRBekK1D/Er8wvuH4JI2Y
         EH+RF2RSpW9iU0oiHqm73ph7TRgdDbWf/wLJTazrLqnlf86q/BoWYwGoAMMSfjDjZLMh
         nlZdRIRiqxNtvI0sJgl1lEGQ55mjdm6tWqN6Q3xLTDpvgBK2EuOKMcbt9JdjDQle6+Ng
         AWK5hLnvfby9Zm0DzY8ferv5QTyiL62sWdN6YRMpFFCbUTOdeDBBhrLMqbeXxduig6tY
         cTwBw08BqWrspEHI3aZJD6bk695NvcGRusAtwCeCKvjg1rRz+uVq4nEdJLZxOo+2TeSC
         KClw==
X-Gm-Message-State: AOJu0Yyu7gQ5d03WVAVg8xgv91QmYjkVGMjdnZiQ2ZbAiTuuNckjPK26
	YU4yTVv82suZOVxsxpcZ647Qnaz3qc/cuSChbUe9JKdZzAuL3K9PXCGACYhGulnchGAh60pn54+
	a2zHnGNfpkiJ6qQArxcugLQ3+llTe8inNqmujLOXW4KyL54YeowNcMUxctBGG5Bw1Sg==
X-Gm-Gg: ASbGncuHhMjJMWUK0xmqIrWlcfuE/glfECioHCTH+8/2AV7jayhoD+CmKnfnG8S8j67
	6ijOE6cD+TxpWufpKnqUNcv6RzRAmaJxYOKU6oJZpTHO6VEbzj+CaM59UdYQrDGKArgoBrqFeX+
	iCiCIELqNTcDyDP0ntw90QtAfQAIh0QSQoPYDgszTzHykKwcsFTWPVC05TlIa+t667G1rj48veg
	wHsSB1d9J3HgpqsbMNdeXKOISAwTNop/XN2eYvxRWqmrJbjA714Le0130Lj2MdwhZ1ePwZTHO8Y
	nPjh6hljHTXCK52eznpQmW66P2vWfG8zDJ2svpP0M9au/LqCLvLde8igsLINuITD4ZxKSPhFUeO
	bH5okUsSm2TioNw50zS1gPE1vI3wv/A==
X-Received: by 2002:a05:600c:1c15:b0:477:7c44:c0c3 with SMTP id 5b1f17b1804b1-4777c44c1e2mr31983785e9.40.1762773282326;
        Mon, 10 Nov 2025 03:14:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESUF7SHyOHQJjTCBHVMsOvdyaK/R0Qf8OXSSIZ5Uc72xHVCtUTrkrYR8eznx3dlYJyEAkUJQ==
X-Received: by 2002:a05:600c:1c15:b0:477:7c44:c0c3 with SMTP id 5b1f17b1804b1-4777c44c1e2mr31983465e9.40.1762773281926;
        Mon, 10 Nov 2025 03:14:41 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bd08834sm200897155e9.15.2025.11.10.03.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:14:41 -0800 (PST)
Date: Mon, 10 Nov 2025 12:14:39 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCHv5] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
Message-ID: <aRHJHxfEI-tnotRe@jlelli-thinkpadt14gen4.remote.csb>
References: <20251110014706.8118-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110014706.8118-1-piliu@redhat.com>

Hi,

Looks like this has two issues.

On 10/11/25 09:47, Pingfan Liu wrote:

...

> +/*
> + * This function always returns a non-empty bitmap in @cpus. This is because
> + * if a root domain has reserved bandwidth for DL tasks, the DL bandwidth
> + * check will prevent CPU hotplug from deactivating all CPUs in that domain.
> + */
> +static void dl_get_task_effective_cpus(struct task_struct *p, struct cpumask *cpus)
> +{
> +	const struct cpumask *hk_msk;
> +
> +	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
> +	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> +		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
> +			/*
> +			 * CPUs isolated by isolcpu="domain" always belong to
> +			 * def_root_domain.
> +			 */
> +			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> +			return;
> +		}
> +	}
> +
> +	/*
> +	 * If a root domain holds a DL task, it must have active CPUs. So
> +	 * active CPUs can always be found by walking up the task's cpuset
> +	 * hierarchy up to the partition root.
> +	 */
> +	cpuset_cpus_allowed(p, cpus);

Grabs callbak_lock spin_lock (sleepable on RT) under pi_lock
raw_spin_lock.

> +}
> +
> +/* The caller should hold cpuset_mutex */
>  void dl_add_task_root_domain(struct task_struct *p)
>  {
>  	struct rq_flags rf;
>  	struct rq *rq;
>  	struct dl_bw *dl_b;
> +	unsigned int cpu;
> +	struct cpumask msk;

Potentially huge mask allocated on the stack.

>  	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>  	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
> @@ -2891,16 +2923,22 @@ void dl_add_task_root_domain(struct task_struct *p)
>  		return;
>  	}
>  
> -	rq = __task_rq_lock(p, &rf);
> -
> +	/*
> +	 * Get an active rq, whose rq->rd traces the correct root
> +	 * domain.
> +	 * And the caller should hold cpuset_mutex, which gurantees
> +	 * the cpu remaining in the cpuset until rq->rd is fetched.
> +	 */
> +	dl_get_task_effective_cpus(p, &msk);
> +	cpu = cpumask_first_and(cpu_active_mask, &msk);
> +	BUG_ON(cpu >= nr_cpu_ids);
> +	rq = cpu_rq(cpu);
>  	dl_b = &rq->rd->dl_bw;
> -	raw_spin_lock(&dl_b->lock);
>  
> +	raw_spin_lock(&dl_b->lock);
>  	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
> -
>  	raw_spin_unlock(&dl_b->lock);
> -
> -	task_rq_unlock(rq, p, &rf);
> +	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);

Thanks,
Juri


