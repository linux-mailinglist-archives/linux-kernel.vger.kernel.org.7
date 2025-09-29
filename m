Return-Path: <linux-kernel+bounces-836171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BF7BA8ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B007D1C0A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFCF2FDC20;
	Mon, 29 Sep 2025 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ecACH7LU"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773191A9FBD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143332; cv=none; b=Q5u/FnC4k1OCyXR1nAt3yVOUUhW2mTNB4ueHqU67b/sczwRYm36sGHEGy9hbaOcOQY2V59zRvluvVrx9JqeNkMt7pyjsMfvQNjnT3abD8M5ONe0cpx1dfuDl2+LjYDYjRJpDiiMrVWgQz4m09bJise45P8/LG+OidUXM8dkphb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143332; c=relaxed/simple;
	bh=tRfsRG6budAyjYdnHC9+uQug2bEU9uN9nr5cSZHImsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMKUkyCLF/MQC/LWdy58PHOkZlYfTpd/CLK41n1VvqR1Hyq70SC+bxbcwppaGGW6tAiL5J+5iK2+glkiN5xc3aF2k+KnpiH4rwVyQZVuWWDHNbcheggTXRTkFhp35bxqBzljVIXfvcz8fi2avWKU9EBRvcjUDMf3+ES5MfVGFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ecACH7LU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so5862205b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759143330; x=1759748130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LDS/8WTSEZe1tpRKRR9P4kuLHIgK2d9cQIylV8PcECs=;
        b=ecACH7LU+85h5651dJZ1tJaMTVwIXF0mUujuS5vCDgK9Oij7+yRDiD7Wpci3H9uzvT
         9hyCqrf8TI1qv82AqSx/AJX1a7BemhnmIcBTeAk7jJ4Neh7MDUmulzShnWabNhXhOdOW
         TjWniO6uLTGrvGI8coTzzemjXqzzIj+zJXPaFtOp7JDaXvcjQmXHlpwngsSLWCorFZVj
         UfOuTIzDrE3EKGP93LAYJVfDWha28S6vhfC2CQQcDed2v1kevXURWbwybf8u1uFbLF6Y
         je8SX0n67WlqoiTwbMmf7VwJGo90L1dbM36vWZCO6RL7iydBS11dN0KOrpN3RStUqSZY
         wq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759143330; x=1759748130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDS/8WTSEZe1tpRKRR9P4kuLHIgK2d9cQIylV8PcECs=;
        b=gP44lm34EZ5zIXQXtI4lkp+bgY7Coki7ecmDzzkFU7Ibw2ckZ59rrhhJzYcgWPvMMY
         s58ZJEmRi/5bcb7UMdfHLnqxNOlX8hc72f8nN+87Abetx748ytzurPxG6CeuNtJ7Rx31
         2/VWXHMmvKGMvXSD1KzfMPBjQY6IsZLFy/4OyijmO5SRG9HrBpujvSAsvzKdXHGtf+t/
         AO5IgMbEAYTbDP95PB7I6fVDhnaFpugzhSwmcWCuaHQCEj/iF4R2l/NAesXk0kb5i5TG
         vBi4RxkkjVtut2Fcmlcwo2UJCdSY0apHp4v0130UN9CdQI0RPsyW1cgQ1nXB8EquLAec
         bt4A==
X-Forwarded-Encrypted: i=1; AJvYcCUmR8H5GVCRmDmH2UV5c5FuKT/WHlCizePewGdKNeOcQXNPcHXi4alckC+lImqnuvpGs6rPjiUfLGwR63U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKW4RZlsIQpewaXWyE9W28M9Y3BFlsCMM5x9DJ2XoUWK3o4sNA
	GOcqyaWQXFNjb3TX1Jh/cQHWcS/mN5SJ73xLCejYbKkXVH23R2OgkV+sLTJltn1IAg==
X-Gm-Gg: ASbGnctXDq5tbkcBsaLSrJW44k3ep/0z3AXw6WFHOw2p57w6ZWmcHu35Xn76tuN7K8x
	hjWMftHyoPL3fDIgcFB1T9UUf+zqI2960vC1MJWhm9iGXizujZMOi92S6rTB/kE3uPD3sGFTp4n
	ilab/p+7T3hrEcIjyO2+/SzR1pJCI6nD40nO0T3PUqGwKDz0g0FwEvJZdyVrTyRaar6v6PkXtai
	k43P4kJbcjYRVNAVH/RCYp1BQ4Lk5m95NaBdK40D1tZR090OLDGmfRec4XT+SpYsjm+P1jU2273
	kkkLeKxoHS9EUjxGCkvKPiEa44dC2Bj2n659sCY0HTbRHEGeq5XGGWgo6DcRbPWlr+ZamL5AlfQ
	RPsCt3mI1OKwqzCMVwSLSlbybtu9M3WkXTvcdxqHMkum6MVta9g==
X-Google-Smtp-Source: AGHT+IFwLaf+NJLOM6nEAB2jL/P7Cyq7DSL1VSFE5MGx+ytQueTWO7pr3lg9C8Os2VFFNjUQLs3T7Q==
X-Received: by 2002:a05:6a00:1a8f:b0:781:269a:8f9d with SMTP id d2e1a72fcca58-781269a901emr6823300b3a.16.1759143329561;
        Mon, 29 Sep 2025 03:55:29 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c2b29sm11029770b3a.36.2025.09.29.03.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 03:55:29 -0700 (PDT)
Date: Mon, 29 Sep 2025 18:55:18 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
Message-ID: <20250929105518.GB426@bytedance>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
 <7c93d622-49fe-4e99-8142-aed69d48aa8a@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c93d622-49fe-4e99-8142-aed69d48aa8a@amd.com>

Hi Prateek,

Thanks for taking a look and the suggestion.

On Mon, Sep 29, 2025 at 03:04:03PM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 9/29/2025 1:16 PM, Aaron Lu wrote:
> > When a cfs_rq is to be throttled, its limbo list should be empty and
> > that's why there is a warn in tg_throttle_down() for non empty
> > cfs_rq->throttled_limbo_list.
> > 
> > When running a test with the following hierarchy:
> > 
> >           root
> >         /      \
> >         A*     ...
> >      /  |  \   ...
> >         B
> >        /  \
> >       C*
> > 
> > where both A and C have quota settings, that warn on non empty limbo list
> > is triggered for a cfs_rq of C, let's call it cfs_rq_c(and ignore the cpu
> > part of the cfs_rq for the sake of simpler representation).
> > 
> > Debugging showed it happened like this:
> > Task group C is created and quota is set, so in tg_set_cfs_bandwidth(),
> > cfs_rq_c is initialized with runtime_enabled set, runtime_remaining
> > equals to 0 and *unthrottled*. Before any tasks are enqueued to cfs_rq_c,
> > *multiple* throttled tasks can migrate to cfs_rq_c (e.g., due to task
> > group changes). When enqueue_task_fair(cfs_rq_c, throttled_task) is
> > called and cfs_rq_c is in a throttled hierarchy (e.g., A is throttled),
> > these throttled tasks are placed into cfs_rq_c's limbo list by
> > enqueue_throttled_task().
> > 
> > Later, when A is unthrottled, tg_unthrottle_up(cfs_rq_c) enqueues these
> > tasks. The first enqueue triggers check_enqueue_throttle(), and with zero
> > runtime_remaining, cfs_rq_c can be throttled in throttle_cfs_rq() if it
> > can't get more runtime and enters tg_throttle_down(), where the warning
> > is hit due to remaining tasks in the limbo list.
> > 
> > Fix this by calling throttle_cfs_rq() in tg_set_cfs_bandwidth()
> > immediately after enabling bandwidth and setting runtime_remaining = 0.
> > This ensures cfs_rq_c is throttled upfront and cannot enter the enqueue
> > path in an unthrottled state with no runtime.
> > 
> > Also, update outdated comments in tg_throttle_down() since
> > unthrottle_cfs_rq() is no longer called with zero runtime_remaining.
> > 
> > While at it, remove a redundant assignment to se in tg_throttle_down().
> > 
> > Fixes: e1fad12dcb66("sched/fair: Switch to task based throttle model")
> > Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> > ---
> >  kernel/sched/core.c  |  9 ++++++++-
> >  kernel/sched/fair.c  | 16 +++++++---------
> >  kernel/sched/sched.h |  1 +
> >  3 files changed, 16 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 7f1e5cb94c536..421166d431fa7 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -9608,7 +9608,14 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
> >  		cfs_rq->runtime_enabled = runtime_enabled;
> >  		cfs_rq->runtime_remaining = 0;
> >  
> > -		if (cfs_rq->throttled)
> > +		/*
> > +		 * Throttle cfs_rq now or it can be unthrottled with zero
> > +		 * runtime_remaining and gets throttled on its unthrottle path.
> > +		 */
> > +		if (cfs_rq->runtime_enabled && !cfs_rq->throttled)
> > +			throttle_cfs_rq(cfs_rq);
> 
> So one downside of this is throttle_cfs_rq() here can assign bandwidth
> to an empty cfs_rq and a genuine enqueue later on another CPU might not
> find bandwidth thus delaying its execution.

Agree that assign doesn't make sense here.

> 
> Can we instead do a check_enqueue_throttle() in enqueue_throttled_task()
> if we find cfs_rq->throttled_limbo_list to be empty?
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 18a30ae35441..fd2d4dad9c27 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5872,6 +5872,8 @@ static bool enqueue_throttled_task(struct task_struct *p)
>  	 */
>  	if (throttled_hierarchy(cfs_rq) &&
>  	    !task_current_donor(rq_of(cfs_rq), p)) {
> +		if (list_empty(&cfs_rq->throttled_limbo_list))
> +			check_enqueue_throttle(cfs_rq);
>  		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
>  		return true;
>  	}
> ---
> 

Works for me, will follow your suggestion if no other comments, thanks!

