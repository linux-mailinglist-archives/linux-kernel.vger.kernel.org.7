Return-Path: <linux-kernel+bounces-809328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4AFB50C14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F6C4E4C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A190F22422D;
	Wed, 10 Sep 2025 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O2L9G0KB"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017753FFD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473423; cv=none; b=PAbL+VnelLDMmKqlD4dqMvZ/cPJSTDQGKrEF9lYyHFqZjft3RcqeBplxqHmX3P6i2xYOBCPSwVhTR1VdoXuDS3mv5HucMcLjn8RWNTYD9g/d7sMt+h9mN4Fnj9R8ckzRJXg3AFARS8WpIGIfw8samT4gQ57J+4tesaTD4Jw2WP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473423; c=relaxed/simple;
	bh=mQZUDUAAj4bgtMPgT6grvCGbXUQxNNJuTooeiEiGxhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOwaXls/KrNa5Q9g6pMIT2k6T68vN6LT1n3qpGkH41plwci6nfKVGgr3vm3uqb2xU8wroMENyn90FAQTrLlmS0UslPmF0n8Lspl9jMAJuNt5Ma15PVrV3paRAOs/rPuDqWnOWV40k/WdDC+GD6rL6x/kEUcnXW3kbbDAcjG1UjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O2L9G0KB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24c8ef94e5dso1697685ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 20:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757473421; x=1758078221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfG+7VDiv0fbEnsAlvw2+sAz8AhX948HOSiJno9sD+4=;
        b=O2L9G0KBAEc80gO/8KeOSpsv8Ses0nRpCYYT4cWkw5MBpZ0MgUjvDdqKr3r/F1mKhT
         2CeoWVMKDneBnEvkc5iKDbGrsg3/D/fJ7Uc3yo5qpQwcaV4O9zffTLvWQcOqTRiytPKr
         +Ckhal/qtX0BWeAFFhm7MzbhsNf/xiixLtmrUsObzbF4oZDDlJm321dvo9wJXRtnp0xm
         fhTn/oCm1L+9L9Ullsc/De7P5Cqs+SFtEKN25xuOZgqJCMY1vtpemBdxg/Bw0Wyjo1jm
         pc32i9KyzReumXNmI/Y+lB+6cP4obDdqa4CifhagjucoHAzZAFZxGU9mpD+vvqhZjB/y
         U/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757473421; x=1758078221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfG+7VDiv0fbEnsAlvw2+sAz8AhX948HOSiJno9sD+4=;
        b=kVZz80zWJ23wkedPeYvO0e8mZHqsXHPpixN0j1G+PHmrMjJgBhG4IpRiBNgmDEpZOh
         WztKAka4Uv7/P3lCjSY04WPkYYZUszPN5Oj8C/nG/wEjYPVeyRb2LM952k3ICrRSy4H4
         0UZqtLQLp/kPMsFyytsBNaM31iDIZSCKb2hhwbGwF5iItTNbmFx17nB8GPObV2RF3PoQ
         O6a/YeUQ6RKOeUsnT1drWVbnXPkjpm/q9gCAutuhp9Y4XhkFPdi4r7LMXg6++gOxmoKn
         QwIFP0/xqHauoRHfnfkmb26W7d5MR3J41J2ycRXvOkcd0W29CSoPcpHc02ZF6568Z87A
         gxGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrIidBz3iAriy/WPYAzCPBIbqKNU5fSbxitiyU8NtXPtxqIQlCzDFWEZXF+HKXJ4YuK9mF0S2PBhspqqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcArJi5iJEXB+1VkOK+/IboBtxFyMW4RVZofmNypjUoOJ2zRee
	89/gxENcjIFLRBvZXdXF0yQbuWjJNdoDt1HNyL0Tx4dtC764mhnOQD8LSJ3XpFB79g==
X-Gm-Gg: ASbGnctUR9Zlqbkz1oWOGdVVi36B4EoXKw3Xdzvw+0wySBoAE6mPB9h6onYUegV/7UE
	fMbYU7h+vLTF6Uuh5aR6FOngOtxLUru9nySB6XsE+iY+4RkbpaFtK4rM3iHYzUCkulyH5esxval
	KDmv3AVMMKj5FLngLT7j1aVaSTrOmrlp19+Hln9gdizUrje8aepgl4YKlfQgeujsHCgYE0j4+OD
	B58SmwakjxLpAbzl1vuuaYsd3YA6wltf0rlv0IBNxED5a6sUaju3FdSb9LsonQPNBTGxnxWOe32
	aANYKc66+s1RDrXSb5taW2hqj8iauLLdGdmJF4G6WVvFtMyzTWCn99ENH3PJGbu38+DkMZI66Sh
	zphv9SE6Kd0MEFbBeu0eKsSqstq32mnomB0LjxDyxonmNlCz6gA==
X-Google-Smtp-Source: AGHT+IHVdJv7d6UUHTMbqOJwfluCGE+JmcynOtlKA0+mTjt6VSH/L4TVmDDSdod+ZC9ZhYrakDh5aA==
X-Received: by 2002:a17:903:1904:b0:234:8a4a:ad89 with SMTP id d9443c01a7336-2517427bc75mr169402755ad.1.1757473420988;
        Tue, 09 Sep 2025 20:03:40 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a43a9e5sm11519415ad.95.2025.09.09.20.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 20:03:40 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:03:29 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Benjamin Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal Koutn?? <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250910030329.GB90@bytedance>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
 <14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
 <xm26o6rrtgav.fsf@google.com>
 <20250904081611.GE42@bytedance>
 <da9141b1-d717-493f-939f-85e23d46e7ba@amd.com>
 <20250904110504.GG42@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904110504.GG42@bytedance>

On Thu, Sep 04, 2025 at 07:05:04PM +0800, Aaron Lu wrote:
> On Thu, Sep 04, 2025 at 03:21:06PM +0530, K Prateek Nayak wrote:
> > Hello Aaron,
> > 
> > On 9/4/2025 1:46 PM, Aaron Lu wrote:
> > > @@ -8722,15 +8730,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> > >  	if (unlikely(se == pse))
> > >  		return;
> > >  
> > > -	/*
> > > -	 * This is possible from callers such as attach_tasks(), in which we
> > > -	 * unconditionally wakeup_preempt() after an enqueue (which may have
> > > -	 * lead to a throttle).  This both saves work and prevents false
> > > -	 * next-buddy nomination below.
> > > -	 */
> > > -	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
> > > -		return;
> > 
> > I think we should have a:
> > 
> > 	if (task_is_throttled(p))
> > 		return;
> > 
> > here. I can see at least one possibility via prio_changed_fair()
> 
> Ah right. I didn't realize wakeup_preempt() can be called for a throttled
> task, I think it is not expected. What about forbid that :)
> (not tested in anyway, just to show the idea and get feedback)
>

Turned out there are other places that also call wakeup_preempt() for a
throttled task, like sched_setaffinity() -> move_queued_task() ->
wakeup_preempt(), and it's not possible to change the logic there as
it's outside of fair, so I'll go with your suggestion to add a
task_is_throttled() check in check_preempt_wakeup_fair().

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cb93e74a850e8..f1383aede764f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13135,7 +13135,11 @@ static void task_fork_fair(struct task_struct *p)
>  static void
>  prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
>  {
> -	if (!task_on_rq_queued(p))
> +	/*
> +	 * p->on_rq can be set for throttled task but there is no need to
> +	 * check wakeup preempt for throttled task, so use p->se.on_rq instead.
> +	 */
> +	if (!p->se.on_rq)
>  		return;
>  
>  	if (rq->cfs.nr_queued == 1)
> 
> > where a throttled task might reach here. Rest looks good. I'll
> > still wait on Ben for the update_cfs_group() bits :)
> > 
> > > -
> > >  	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
> > >  		set_next_buddy(pse);
> > >  	}

