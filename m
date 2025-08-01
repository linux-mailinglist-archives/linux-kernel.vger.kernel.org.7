Return-Path: <linux-kernel+bounces-753255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B158B180A5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59293A50C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4B720E314;
	Fri,  1 Aug 2025 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3qJk5gJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51C037160
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046308; cv=none; b=qMJw5WZEMNXgeHHWiV1UzKxOQ/My64B+7HA5aR86cALP4yxElaevIrXqTFkIym4YnoQJJHmuL3I8wv/WsDb1ZaCNiWGF1/SBoeRXVUzZ0YHOmx1Jy3kcp7VaUr0OBeX/dlznFqO9/pOWvINnNaw2nPZFKd9yyXQFYPh5dcqV2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046308; c=relaxed/simple;
	bh=E/iKu9km0IN+j1369J8l/nFlMCX5Cqw42VFl85vT6U0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ALO1Lv54FZ1tTX0fsuyJHHkc5OunXsJlqxN0uZ2jt09M6PnYuhX8frODD8hOA13Zh+cbnSJnJuNZpu+jaVjbUw9WU74zoQNAWnQmF+9wBtE0WQMpRxOmbD5EYTT6DKKPb4BcP1u7LKFVKGGIcjEtwCxUgnas6QxV+hmG5ZEEQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3qJk5gJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754046296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QqHGIpMb5fC5epWMvjdUC6ZxFzKr8k7TYbLjA53/+Ak=;
	b=H3qJk5gJE7s8fTPbVJqqDsredzn0Z0sopjRuuDXQ9Iu54K9mBashLbD7COO9UGQUPJim5M
	I2AdCe2mOygaWbzh4WNhfo6uyolBAlZdChn6+CDc4ypsiGTxx8Vwckcd3FGWL9evsO9Zu1
	1/tCCStBbLhDd/LjCjcBEcX/Bj4Z17s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-IICXVF9xNXuP6851Y0reww-1; Fri, 01 Aug 2025 07:04:53 -0400
X-MC-Unique: IICXVF9xNXuP6851Y0reww-1
X-Mimecast-MFC-AGG-ID: IICXVF9xNXuP6851Y0reww_1754046292
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so20785935e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754046292; x=1754651092;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QqHGIpMb5fC5epWMvjdUC6ZxFzKr8k7TYbLjA53/+Ak=;
        b=jKV9MaQoN0CYWNTwvVC/8cpXtNf3vnLNvgiDqTMOesNoIvG5Uip1IIBWM+Oy3THMis
         Ma37bEcA3LHIJQGnyYYMrIsWWjluJ5Y8ISpZrchziD92CYP9Vj0tRX4eTXJkJT5fI24B
         1pv1YqH+Ad2tUFSPmQSD775KVtSclneYHzZim8gnAhLQSeuADe0ZCvnWtBMkF59laG5J
         8jgpjJdqaSBhOniX+QsoOOb8/Dg9psI6pWkfuBV5sasJ2El2Q0tMJ8Y1+z624eGBpT6q
         cEgwgVGgLq9p0hFgq2futE8ucU+aUwM8mSBGVWgkVem5b5/bHA2XrYUl8EO96S50Yozx
         uJog==
X-Forwarded-Encrypted: i=1; AJvYcCUXxPWJZ1742ldYO5JNACuSVqwHzNquwAS2uWGJXtmuqsaIupeAbMIb90EORJrOaHFmG5tt+t7obn8PmQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08MDSW1k2/xlyNSmqiIdzWTBTqfgv4N2TsTn6pDGakIuoWiet
	juDpIVFsi4/uIjP2l5xGrvtvxfTpUKkot2oouPXnXdURehXAIZ9WP+qdUyXKmakSAhaSA9tqQ1S
	rBehH5W+c0dHxMKCpNIYocAGm22hegWtZIH77pTM3Ues8Tf4Mf1tu0N73yHtu5C+FRA==
X-Gm-Gg: ASbGnctWU0W48/t5fkiMMFrGgfZTe98Q2M3JBx/knkd1mdbIYgjMLWRS6rXMRGu4MyI
	bIsPARqA6Dj8invJZdYiY12QGRfwoRcjq06fwI9GDNvCcxc76SZMDqDNHaIkeejDIc3tetiv2n6
	njzLq8vPsxqTSkRxorDjg5sZvSieMQVknbRnXt381i2OyUUV0Ig4SWqz+wnDfNCXMO56kC0uIFf
	ZYCGiy02alFjC2IB1izBc0XMKHbS/BMf8rLbWWZny8kU2E+0KDrHXZBAh6e2gp8SZsZONc/ttEs
	8LmjXF8zgsOjxMJrcoCYnah7SSs6EGyXakyzJ6bY/OWHnFA5DgtLcX+4a+atbHUkMA==
X-Received: by 2002:a05:600c:c04b:10b0:458:a7b1:7a29 with SMTP id 5b1f17b1804b1-458a7b17ac9mr34558795e9.31.1754046291926;
        Fri, 01 Aug 2025 04:04:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtdNIn0GB/r6mfjGgFhVHFpnL7eFDWc99k0NC7yD3+xblg7u6QpCPIaCj/0gW+QRwYRV7Yng==
X-Received: by 2002:a05:600c:c04b:10b0:458:a7b1:7a29 with SMTP id 5b1f17b1804b1-458a7b17ac9mr34558205e9.31.1754046291371;
        Fri, 01 Aug 2025 04:04:51 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c51e2sm5382507f8f.32.2025.08.01.04.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 04:04:50 -0700 (PDT)
Message-ID: <c403aacc94dc09aa9ad4441be6095d00b2091f68.camel@redhat.com>
Subject: Re: [PATCH 4/5] sched: Add rt task enqueue/dequeue trace points
From: Gabriele Monaco <gmonaco@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,  Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall	 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider	 <vschneid@redhat.com>
Date: Fri, 01 Aug 2025 13:04:48 +0200
In-Reply-To: <97c8a989-08b1-4233-8f5a-cb8b582b6c02@amd.com>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <8f83869a5040bd7cd3096bd12090c1ab110ae5c4.1753879295.git.namcao@linutronix.de>
	 <767a9d59081220594d21856f329fb35988ef7925.camel@redhat.com>
	 <20250730151818.7RemAREO@linutronix.de>
	 <5065c29035be39dee954f2b233a40ae15dcc5035.camel@redhat.com>
	 <20250731073520.ktIOaGts@linutronix.de>
	 <179674c6-f82a-4718-ace2-67b5e672fdee@amd.com>
	 <20250801072946.nTiUlMwS@linutronix.de>
	 <97c8a989-08b1-4233-8f5a-cb8b582b6c02@amd.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-01 at 15:26 +0530, K Prateek Nayak wrote:
> There are a few more cases with delayed dequeue:
>=20
> 1. A delayed task can be reenqueued before it is completely dequeued
> and
> =C2=A0=C2=A0 will lead to a enqueue -> enqueue transition if we don't tra=
ce the
> =C2=A0=C2=A0 first dequeue.
>=20
> 2. There are cases in set_user_nice() and __sched_setscheduler()
> where
> =C2=A0=C2=A0 a delayed task is dequeued in delayed state and be put back =
in the
> =C2=A0=C2=A0 cfs_rq in delayed state - an attempt to handle 1. can trip t=
his.
>=20
> Best I could think of is the below diff on top of your suggestion
> where
> a "delayed -> reenqueue" is skipped but the case 2. is captures in
> case
> one needs to inspect some properties from set_user_nice() /
> __sched_setscheduler():
>=20
> (only build tested on top of the diff you had pasted)
>=20

Hello Prateek,

thanks for the comments, this looks much more convoluted than I would
have expected.
As Nam pointed out, currently RV is not going to rely on those events
for fair tasks (existing monitors are fine with tracepoints like
wakeup/set_state/switch).

For the time being it might be better just add the tracepoints in the
RT enqueue/dequeue (the only needed for this series) and not complicate
things.

At most we may want to keep tracepoint names general, allowing the
tracing call to be added later to other locations (or moved to a
general one) without changing too much, besides existing users.
And perhaps a comment saying the tracepoints are currently only
supported on RT would do.

Anyway, that's your call Nam, I'm fine with your initial proposal as
well, unless some scheduler guys complain.

Thanks,
Gabriele

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9598984bee8d..1fc5a97bba6b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2071,7 +2071,8 @@ unsigned long get_wchan(struct task_struct *p)
> =C2=A0
> =C2=A0void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
> =C2=A0{
> -	trace_enqueue_task_tp(rq->cpu, p);
> +	if (!p->se.sched_delayed || !move_entity(flags))
> +		trace_enqueue_task_tp(rq->cpu, p);
> =C2=A0
> =C2=A0	if (!(flags & ENQUEUE_NOCLOCK))
> =C2=A0		update_rq_clock(rq);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..1e2a636d6804 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5444,7 +5444,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct
> sched_entity *se, int flags)
> =C2=A0	 * put back on, and if we advance min_vruntime, we'll be
> placed back
> =C2=A0	 * further than we started -- i.e. we'll be penalized.
> =C2=A0	 */
> -	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) !=3D DEQUEUE_SAVE)
> +	if (move_entity(flags))
> =C2=A0		update_min_vruntime(cfs_rq);
> =C2=A0
> =C2=A0	if (flags & DEQUEUE_DELAYED)
> @@ -7054,6 +7054,7 @@ static int dequeue_entities(struct rq *rq,
> struct sched_entity *se, int flags)
> =C2=A0
> =C2=A0		/* Fix-up what dequeue_task_fair() skipped */
> =C2=A0		hrtick_update(rq);
> +		trace_dequeue_task_tp(rq->cpu, p);
> =C2=A0
> =C2=A0		/*
> =C2=A0		 * Fix-up what block_task() skipped.
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 7936d4333731..33897d35744a 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1196,19 +1196,6 @@ void dec_rt_tasks(struct sched_rt_entity
> *rt_se, struct rt_rq *rt_rq)
> =C2=A0	dec_rt_group(rt_se, rt_rq);
> =C2=A0}
> =C2=A0
> -/*
> - * Change rt_se->run_list location unless SAVE && !MOVE
> - *
> - * assumes ENQUEUE/DEQUEUE flags match
> - */
> -static inline bool move_entity(unsigned int flags)
> -{
> -	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) =3D=3D DEQUEUE_SAVE)
> -		return false;
> -
> -	return true;
> -}
> -
> =C2=A0static void __delist_rt_entity(struct sched_rt_entity *rt_se, struc=
t
> rt_prio_array *array)
> =C2=A0{
> =C2=A0	list_del_init(&rt_se->run_list);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d3f33d10c58c..37730cd834ba 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2361,6 +2361,20 @@ extern const
> u32		sched_prio_to_wmult[40];
> =C2=A0
> =C2=A0#define RETRY_TASK		((void *)-1UL)
> =C2=A0
> +/*
> + * Checks for a SAVE/RESTORE without MOVE. Returns false if
> + * SAVE and !MOVE.
> + *
> + * Assumes ENQUEUE/DEQUEUE flags match.
> + */
> +static inline bool move_entity(unsigned int flags)
> +{
> +	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) =3D=3D DEQUEUE_SAVE)
> +		return false;
> +
> +	return true;
> +}
> +
> =C2=A0struct affinity_context {
> =C2=A0	const struct cpumask	*new_mask;
> =C2=A0	struct cpumask		*user_mask;
> ---
>=20
> Thoughts?


