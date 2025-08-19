Return-Path: <linux-kernel+bounces-775286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB8B2BD79
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8526846C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FB831AF05;
	Tue, 19 Aug 2025 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W4CFR2gB"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6E3319877
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596081; cv=none; b=KCvWj+ZeSYeRk8QBS0kN9vogxOOyyBpBfp6Um2A2hlQ5v0iQ1rjCqaxMP+5mTb2yBZjy2bhbtdo/fnqBLB02SC5nA3QS6HVVHWzQka9CAWAS/UaLR8lGbDY09ngkadbflloxB/g6Fb2mMbS5x+C47UAqlA7MgvXxo9RqfKxuCiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596081; c=relaxed/simple;
	bh=MRa6JSBgBj1A/RxVOyvTy8jbk2eJr9qP6dtgPicCwxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+DhltSVROd3VeUk0ggd0oFjewLg+TaQeAt+kOcmj6HoTJrqRWRvsF+ux7u91q/Zefs2W0dFJos5m2UH5VZGt/9rq6a6SJVZIZpHLbZQv0Qr0G9v8TTFTYVoGgU51iO28hAG2+G3Jw7BUJpS0Vgg3V9IKXYlLVxxfg2rzDMZnqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=W4CFR2gB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2eb3726cso3159278b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755596078; x=1756200878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wuXmO+qailbAmNe0MvWa3qSP32ct2TGIE5QjgKNxW6w=;
        b=W4CFR2gBg6LbJ2x6BN7073R2/iZvhxlHQzdWSkp+/FhGbhvnHXOCKyKMMm9DwPRTSx
         8gA5Bp7s/8jaIS92KNGBoaB1UwGobMRL91J3grVPQOhPcNJ6AcLd/RrsjseqOmiaTplZ
         Q4X9bf0v2Vve5nVLcEcrDQEXdmeQN9TmDkgvukWNI1CWiB/qsvMgjMCuFlMbojqfrF1A
         z1q3PxklpNtMynRj4GPQ7Arefaiyi6x0TIi4FsO2XMoUL8KsiVekTuyx96c1yTPZf8hL
         VrpRDOhoK3f/sUnYUSVVkJdnpN+GNLyVh2TehgOgmOgxn7CnjCSmvGR3CpXTmpWVM3bm
         VrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596078; x=1756200878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuXmO+qailbAmNe0MvWa3qSP32ct2TGIE5QjgKNxW6w=;
        b=u+QqSCG3ayOTunkN4PIITPtMyaED7YE0C2Fr7IvX9SnPYLeSrrLHsBcmu7PdYGUVLy
         IsKgd7/4BdA+oeDypKkLXHxklIJlWS2HleXqVlSLzG/Kh7I03RtsRmAU5fN/QQy0qMsy
         Om+LRqaA3sZf08ipG3v/RyZLyfgrA8W8wFrB7OYLvvJ76q2hUsL5y5KCoCfddv19+WOG
         QCEi8OJWMGBsii4LMsx4dK5Epdn6fURKgDuviNohLiE1hxTMiRgsZGeuYRf9/JQUKERW
         c4H72OPqkqARVBGwH9GloaLsQcVouxzLLTIeEF782VM/9x4hTYn4pwZJheXDT1WXrblH
         lv3A==
X-Forwarded-Encrypted: i=1; AJvYcCW0drr6zfzVbtDuzl1O2ec18dUFveN3XW1rsBsr2f+Oq89Z5xJ1q/PmtEZcywI24JdpF9QGtqhMBHbbdMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjoBpGBr1jSiV0yEvzeMrAslcAjbKs4tbzQdMp6emK6UMudFuO
	WUv2jGvg6Q23SwcriAwOrVtAbo06Z4KXFUVXDLXDgzqrKwMRHh7s6bNygxDKGrQ2TA==
X-Gm-Gg: ASbGnctolcWdWg06b8I/YMfkU+adaDvNYbUmdabuOgL4iJC9N3YzzUp+1FxOV+45jmT
	ka0xyIHF65rKQ/3imO7zPKY5/1Oi9M9XtNQlPYgHRvRVhm4rMlfsjoWLfpiVk9UjIOBZMxGL+yG
	OjzaktOOr2LFB5J6Y5XNgyBG9Aiy6rDwcsceSVYvYmaSWHJMAcQac5K0pkktVL0+V0FtB7Rmd+g
	L7KM4AwMPxJwYuhFWjfyyZrXWQEfZxn6VXAtWb5j1PX8OL44cFzNbwJW/D5DArXNnrgmci6TF9m
	Z63jlS7fbqWYSqX4BLOWBCtjnG9+GTK1MCxfv20kcV0fhRmwve+zStwtfZ9EfyPQL312c2oCdXr
	Ht2VV6whg7CVKC8MBqNBsY16xIWXfzWxgvX+eWAySApND9xQ=
X-Google-Smtp-Source: AGHT+IH20v9bJqq2keWdQyqYPMQQ3oBnPqNvun4Q9mRf+kKmTvUdH5YoJf+TFz0zW4yZsVWwQilNFA==
X-Received: by 2002:a05:6a20:938c:b0:243:78a:8274 with SMTP id adf61e73a8af0-2430d4bc52bmr2844403637.58.1755596078182;
        Tue, 19 Aug 2025 02:34:38 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b474bc471f6sm3730343a12.50.2025.08.19.02.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:34:37 -0700 (PDT)
Date: Tue, 19 Aug 2025 17:34:27 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
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
	Songtang Liu <liusongtang@bytedance.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 4/5] sched/fair: Task based throttle time accounting
Message-ID: <20250819093427.GC38@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-5-ziqianlu@bytedance.com>
 <xhsmhbjociso8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhbjociso8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Mon, Aug 18, 2025 at 04:57:27PM +0200, Valentin Schneider wrote:
> On 15/07/25 15:16, Aaron Lu wrote:
> > @@ -5287,19 +5287,12 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >               check_enqueue_throttle(cfs_rq);
> >               list_add_leaf_cfs_rq(cfs_rq);
> >  #ifdef CONFIG_CFS_BANDWIDTH
> > -		if (throttled_hierarchy(cfs_rq)) {
> > +		if (cfs_rq->pelt_clock_throttled) {
> >                       struct rq *rq = rq_of(cfs_rq);
> >
> > -			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
> > -				cfs_rq->throttled_clock = rq_clock(rq);
> > -			if (!cfs_rq->throttled_clock_self)
> > -				cfs_rq->throttled_clock_self = rq_clock(rq);
> > -
> > -			if (cfs_rq->pelt_clock_throttled) {
> > -				cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
> > -					cfs_rq->throttled_clock_pelt;
> > -				cfs_rq->pelt_clock_throttled = 0;
> > -			}
> > +			cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
> > +				cfs_rq->throttled_clock_pelt;
> > +			cfs_rq->pelt_clock_throttled = 0;
> 
> This is the only hunk of the patch that affects the PELT stuff; should this
> have been included in patch 3 which does the rest of the PELT accounting changes?
> 

Yes, I think your suggestion makes sense, I'll move it to patch3 in next
version, thanks.

> > @@ -7073,6 +7073,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
> >               if (cfs_rq_is_idle(cfs_rq))
> >                       h_nr_idle = h_nr_queued;
> >
> > +		if (throttled_hierarchy(cfs_rq) && task_throttled)
> > +			record_throttle_clock(cfs_rq);
> > +
> 
> Apologies if this has been discussed before.
> 
> So the throttled time (as reported by cpu.stat.local) is now accounted as
> the time from which the first task in the hierarchy gets effectively
> throttled - IOW the first time a task in a throttled hierarchy reaches
> resume_user_mode_work() - as opposed to as soon as the hierarchy runs out
> of quota.

Right.

> 
> The gap between the two shouldn't be much, but that should at the very
> least be highlighted in the changelog.
>

Got it, does the below added words make this clear?

    With task based throttle model, the previous way to check cfs_rq's
    nr_queued to decide if throttled time should be accounted doesn't work
    as expected, e.g. when a cfs_rq which has a single task is throttled,
    that task could later block in kernel mode instead of being dequeued on
    limbo list and account this as throttled time is not accurate.

    Rework throttle time accounting for a cfs_rq as follows:
    - start accounting when the first task gets throttled in its hierarchy;
    - stop accounting on unthrottle.

    Note that there will be a time gap between when a cfs_rq is throttled
    and when a task in its hierarchy is actually throttled. This accounting
    mechanism only started accounting in the latter case.

