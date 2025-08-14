Return-Path: <linux-kernel+bounces-768999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DC0B26899
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A46C74E2DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360071EB1A4;
	Thu, 14 Aug 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGzytPXq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4E1E0E14
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180121; cv=none; b=qsT4ZqGcXwmQauQSG8wYBsYIsj92prMy5Habw549Is6FF+Q4fk4FA0gMf1Uxgad8rsXFXh4Qnuz9ieQCcYYL6jKjCH/Q7T2gLTprUP2kCcBdgwsQo2uDw2nQxcfw5ukOnA+4GK2LA/xZ+sXOGqFnHIl1wLxiBJpTxkpYsQxQJPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180121; c=relaxed/simple;
	bh=ZpqJkdRqmgMpLBrGPUoz1aoYYxR6Dcu+5W9DucJYJzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzU8wSO0X4WyUtHsgkNxXqY/8Mx5LNFjQ4x5Fha3r85MXrb072AWzEqf0PDbsNYrurjEW/zIkn24kA97ntv561p9FdwVfNAwcrMSoD9KC0npSiAWTJ9PE56PC5S9vcqiPxsMFHWeoCDt0nsdZOZe8yRZJdxdgIx6SSJNrubW9kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGzytPXq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755180118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/EryTRMH+rxkrqTuruXtg2o9IutiuwuTWQJ7ZDObv8=;
	b=gGzytPXqrvPNyirhekGl+Y0z/QwDKmYmoHawi+cCok9rIhFPmRJmUIZv89SfxmcerA3JMb
	eoJMGoFDusYbxDwD1CuHJzCXoG0PNUtJlUR/VsKh1V5VuSuSVYm3AJ4gI6JFSbTKEwkRRN
	ykBC1uK/ZXnJFmaS6t0pxKG6vr2ltSw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-RTdhcZHxPOino9gArpu1pQ-1; Thu, 14 Aug 2025 10:01:55 -0400
X-MC-Unique: RTdhcZHxPOino9gArpu1pQ-1
X-Mimecast-MFC-AGG-ID: RTdhcZHxPOino9gArpu1pQ_1755180115
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8704d540cso104795785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180114; x=1755784914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/EryTRMH+rxkrqTuruXtg2o9IutiuwuTWQJ7ZDObv8=;
        b=LdN6EjerOnSOrczXj2E1ZJHbP4R69eBqZf7AXsQzKzGc98Wyd6YeHNX/TLh44br4+G
         fwyDqCejaLkJMcahmRWoAl2BIv5GEWcxAO36Qn+8WOKtqvbw8fhcUwRTzG+DjK7wzVP7
         5hRzgk95nZfeESeYlr4oNoMPQBbEoBXxK4A6tNIyJmjQ4trT8L+fofvipkwdB6CQbDWn
         Y+sPMftP1K4VJeHItnI9IQPYF2LfRE3oF23f3gg00yxKYaBNYmB0T/Sp3DOyPlx80zVv
         eI4EwnasX2ojYnrbYTnIHapzLFkLKYLidIgqXLtuXMg+rDYMPngQGK7GWbc8BYkOV6fC
         cVag==
X-Forwarded-Encrypted: i=1; AJvYcCWmEwR/hNITWLaej23cieUnRbgre8pGuA5/fh+mjq3Zpsiuy5A3QcGL1M1E9ZSUGe+hN5PFxJXOI00ovD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXdjnqZ9GXDgvneW967B+YG3BqDn/TwVI7epAaG8aRxhiWTeXj
	SChiDU1qkN0M0k7yB3PK3yJjfYkzV+AhFB8EMzvXJMtND02H0d+5p2KVKnZ2r+b5fMtpFm4/9HG
	HiM639gMD3SVZdELkg6VYRii7gfJDk3BmYnFPRxFjSoIXNl8KlhsrVFs1kr5MwOOJ7YqDbXQNMp
	kg
X-Gm-Gg: ASbGncs0cwg6bKATRp0xcDHRASH+XK5suu3B2ThuQ7Z+O7kZqdc6YeJVawEzn/oTUtS
	XxwpSRgc+hi2RLJGeNEJxev9HmSMiEw95CbDSjHC5u9uie6ra+07pvL/AZn+5At5aLQxw9WUjQr
	TSUVC1jjBJKZVTG1RjVSmoRzZ0MLk4pTtP+ZE/hcOQtrSEPmE48Mt3YwozRrCODLUUPjW+7ioXU
	N26vlc7nQYgWgKQEfyXMulihjbd0fmsaQ5NjEJ+3N7hEK0dlTzqHBSJBS52ekcWzj1gQj8ywV3M
	TdS6hPu0hBY2Ek9SToDOcqXNzYek8jsRAzsfytZfVc6jDNR1ewpXGuyioMXVhE7f7kDjcg==
X-Received: by 2002:a05:620a:7184:b0:7e8:2038:7cdc with SMTP id af79cd13be357-7e87043977bmr365632685a.38.1755180113956;
        Thu, 14 Aug 2025 07:01:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHereF1KbK3/3c8JFcDQw95om+m5/ETSh5q8qoQAFiyEGNi6yPmT+vduGnwdOgCxujgsEV75w==
X-Received: by 2002:a05:620a:7184:b0:7e8:2038:7cdc with SMTP id af79cd13be357-7e87043977bmr365582885a.38.1755180108649;
        Thu, 14 Aug 2025 07:01:48 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.57.62.225])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e816a9a3cdsm1417099185a.23.2025.08.14.07.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:01:47 -0700 (PDT)
Date: Thu, 14 Aug 2025 16:01:41 +0200
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
Subject: Re: [RFC PATCH v2 13/25] sched/rt: Add HCBS related checks and
 operations for rt tasks
Message-ID: <aJ3sRfefZCxZd2t0@jlelli-thinkpadt14gen4.remote.csb>
References: <20250731105543.40832-1-yurand2000@gmail.com>
 <20250731105543.40832-14-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731105543.40832-14-yurand2000@gmail.com>

Hi!

On 31/07/25 12:55, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Add checks wheter a task belongs to the root cgroup or a rt-cgroup, since HCBS
> reuses the rt classes' scheduler, and operate accordingly where needed.
> 
> Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
> Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
> Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> ---
>  kernel/sched/core.c     |   3 +
>  kernel/sched/deadline.c |  16 ++++-
>  kernel/sched/rt.c       | 147 +++++++++++++++++++++++++++++++++++++---
>  kernel/sched/sched.h    |   6 +-
>  kernel/sched/syscalls.c |  13 ++++
>  5 files changed, 171 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3a69cb906c3..6173684a02b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2196,6 +2196,9 @@ void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
>  {
>  	struct task_struct *donor = rq->donor;
>  
> +	if (is_dl_group(rt_rq_of_se(&p->rt)) && task_has_rt_policy(p))
> +		resched_curr(rq);

Why this unconditional resched for tasks in groups?

...

> @@ -715,6 +744,14 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>  	check_schedstat_required();
>  	update_stats_wait_start_rt(rt_rq_of_se(rt_se), rt_se);
>  
> +	/* Task arriving in an idle group of tasks. */
> +	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) &&
> +	    is_dl_group(rt_rq) && rt_rq->rt_nr_running == 0) {
> +		struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
> +
> +		dl_server_start(dl_se);
> +	}
> +
>  	enqueue_rt_entity(rt_se, flags);

Is it OK to start the server before the first task is enqueued in an
idle group?

...

> @@ -891,6 +936,34 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
>  {
>  	struct task_struct *donor = rq->donor;
>  
> +	if (!rt_group_sched_enabled())
> +		goto no_group_sched;
> +

I think the below deserves a comment detailing the rules of preemption
(inside/outside groups, etc.).

> +	if (is_dl_group(rt_rq_of_se(&p->rt)) &&
> +	    is_dl_group(rt_rq_of_se(&rq->curr->rt))) {
> +		struct sched_dl_entity *dl_se, *curr_dl_se;
> +
> +		dl_se = dl_group_of(rt_rq_of_se(&p->rt));
> +		curr_dl_se = dl_group_of(rt_rq_of_se(&rq->curr->rt));
> +
> +		if (dl_entity_preempt(dl_se, curr_dl_se)) {
> +			resched_curr(rq);
> +			return;
> +		} else if (!dl_entity_preempt(curr_dl_se, dl_se)) {

Isn't this condition implied by the above?

...

> +#ifdef CONFIG_RT_GROUP_SCHED
> +static int group_push_rt_task(struct rt_rq *rt_rq)
> +{
> +	struct rq *rq = rq_of_rt_rq(rt_rq);
> +
> +	if (is_dl_group(rt_rq))
> +		return 0;
> +
> +	return push_rt_task(rq, false);
> +}
> +
> +static void group_push_rt_tasks(struct rt_rq *rt_rq)
> +{
> +	while (group_push_rt_task(rt_rq))
> +		;
> +}
> +#else
> +static void group_push_rt_tasks(struct rt_rq *rt_rq)
> +{
> +	push_rt_tasks(rq_of_rt_rq(rt_rq));
> +}
> +#endif
> +

Hummm, maybe too much for a single patch? I am a little lost at this
point. :))

Thanks,
Juri


