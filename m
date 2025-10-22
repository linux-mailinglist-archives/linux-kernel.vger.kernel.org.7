Return-Path: <linux-kernel+bounces-864687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7812EBFB570
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 585664E3AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48248313E37;
	Wed, 22 Oct 2025 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTMfO1NE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1AC211472
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127919; cv=none; b=bp28IDL4ViEOJejpKqqfQwLVn0u1ALToowV83XrMYqQmUnOK17ZcuM//sjA8GHyVdr5VvsozMRgAvJxhOI+wkbUZp1oGTaB90CIsfduo29Jixf6VMCpFQe2kQjQ0xTcEhL8YDeG9WYZmDnxeJM2hAM6r297B/FM1xPjfhMroWHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127919; c=relaxed/simple;
	bh=Jp54SD40MnW9bmRRS+/8kk8pEpAqKmGvZ7BVXumanJw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qg0R9EBDjODI5OM5+4vTQ8I+VkO8WSGQt6F6R9HVeDic/TC9SzHKgz1EYJJ8DXaYWu5FXPWnIRXhJwKrCUqIDLR3wKGaWKYFF8GjQ3xhU8NvBfA/EoDVfz4bFiC9Mv6ZuKxmIrfgsnTGyuskFWn68g+aKxq7h3udGYUAluGEd2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTMfO1NE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761127916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DEnCGpp8rQBAIpEA5A+Df2mRU9lJu3EoG19Lc6Eeokk=;
	b=bTMfO1NEhQdYHPbE5asfxedE+rJkr5Aida82X5RI3IeaQwIWCPFpCauvSm7Wit4ibPsJia
	8DppO0RDJnjMEEemoLy3kpd1xFBC2DCdjK+TpZjD6a6pdOpkt9LuuNGpJERYHy3Lf7hu6y
	GHjOidq7lk2Eiq4UlnSalJ0EWt/FsLY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-J0UDxy_oNCCDRIWOUc5bgw-1; Wed, 22 Oct 2025 06:11:55 -0400
X-MC-Unique: J0UDxy_oNCCDRIWOUc5bgw-1
X-Mimecast-MFC-AGG-ID: J0UDxy_oNCCDRIWOUc5bgw_1761127914
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471005f28d2so25453535e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127914; x=1761732714;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEnCGpp8rQBAIpEA5A+Df2mRU9lJu3EoG19Lc6Eeokk=;
        b=fHPBJQOqu8JCIk5ki0sTBhSPWFFQwutINdb9usqkDnbrh/dnNlUS2i9hQ5G8BvF77r
         QusKDXRBqXk/oTf1l/fihjsvz92Bym/zFugSwgXdkoGQ7PcN089VtW5aHsfNShMBVqmM
         D+cOhmWMxmuiWkKEeckGOp0vOiHPTiL1JzWbNDHz0lEG+kpD7xCSK1Sr05PjtUfzO17N
         J8kcdIycme4FWRM1SFv2r0uEg2U/SWFCkRJ1Zh7DWzU8rIOFPJQS37NkgRBsmkmy1JLx
         YtrjTr6lTrkSKdvKDg/0qUxoe3aENVEWlscFUAYsX9lEYGY1f+M41mBbAdNVRYwsU7cM
         UP8g==
X-Gm-Message-State: AOJu0YwacOpnBn0eZmxb//AiRRVNz4k+85I2teb+0+mDJY71XhDUw0f6
	eUFhEMAHQ7BoHKcnVZuLp/PYPcDGYftYEl8vJWGRZhqHT877OCnzZf9CfDpPGwZVjghtJhbsV+z
	T6CwV0yrS1vfApYgnEJCpm3YJ+oIZqI9AowKLCFxCtW1K4vSJBgWFxbYB5l5gk6Z8ng==
X-Gm-Gg: ASbGnctpR92ZFonAcvmM71FU+rXFZAfXj/I6sjCseIXNQf399C/vAbrFCP6chnvNrw/
	2Tq2Y50/R3xXv2peFG5H0rqGOMUNgB/WQkDUMR4dqe8Aw4DnMi3oNuMrHRWKTOcrHBImVNKoMdG
	zzYYc1KXltB5JKC+waJJJMZB3TA76WSgJ6a5s2dcOuuZ8ld8UUz3rHVj6EzSQGmMPuD00HUBfSn
	9aEjluNiTxVCCMk0n18yCwRvM2yfArEFZTabaZySK7ZgRtzh6vs1yzE0BVXX4NYW/oUZCrcqUoq
	Un0VA90RCQxEdSowVMG/XF23nrpBKfrX8zN/mz9yip9Yb062U1Jpsqe2tBzyyXNi2knK1nErq8H
	XSOS5d7HGxDoDJYz9kwVvFRui
X-Received: by 2002:a05:600c:154b:b0:46f:b42e:edcd with SMTP id 5b1f17b1804b1-47117925d59mr116913155e9.38.1761127913793;
        Wed, 22 Oct 2025 03:11:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO37dZ10Ev0JPSz6Qvc1I3TtLLzhpj6OYfPYJMSAd4oYpHiJGzieec+qEhC7FiLAk1zrQoQw==
X-Received: by 2002:a05:600c:154b:b0:46f:b42e:edcd with SMTP id 5b1f17b1804b1-47117925d59mr116912935e9.38.1761127913307;
        Wed, 22 Oct 2025 03:11:53 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f685sm38038795e9.2.2025.10.22.03.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:11:52 -0700 (PDT)
Message-ID: <8dc29e28a4d87954378ef1d989e0374526b44723.camel@redhat.com>
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Clark
 Williams <williams@redhat.com>, arighi@nvidia.com
Date: Wed, 22 Oct 2025 12:11:51 +0200
In-Reply-To: <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
References: <20251007122904.31611-1-gmonaco@redhat.com>
	 <20251014095407.GM4067720@noisy.programming.kicks-ass.net>
	 <a0ccf27f5e12a11d2e9dc951ceaf7f9d103f67f6.camel@redhat.com>
	 <20251014102541.GS3245006@noisy.programming.kicks-ass.net>
	 <83a5971ef07226737421737f889795ec57b6fa6c.camel@redhat.com>
	 <aO5zxvoCPNfWwfoK@jlelli-thinkpadt14gen4.remote.csb>
	 <20251014193300.GA1206438@noisy.programming.kicks-ass.net>
	 <aO8zwouX6qIaf-U-@jlelli-thinkpadt14gen4.remote.csb>
	 <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 16:11 +0200, Peter Zijlstra wrote:
> On Wed, Oct 15, 2025 at 07:40:18AM +0200, Juri Lelli wrote:
> > On 14/10/25 21:33, Peter Zijlstra wrote:
> > > On Tue, Oct 14, 2025 at 06:01:10PM +0200, Juri Lelli wrote:
> > >=20
> > > > Shouldn't idle time be accounted (subtracted from runtime) as well,
> > > > though?
> > >=20
> > > Argh, indeed. Then I suppose we should look at bringing some of that
> > > 'idle-for-whole-period' logic to try and actually stop the timer at s=
ome
> > > point if nothing happens.
> >=20
> > That was my initial thought. If we get to that replenish after a whole
> > idle period elapsed, stop the timer (resetting state), so that we can g=
o
> > back at defer mode with the next enqueue from fair.
>=20
> Finally staring at this again; and I'm, as expected, confused again.
>=20
> So put_prev_task_idle() calls dl_server_update_idle_time(). But this is
> only called when we context switch away from idle. The dl_server_timer()
> interrupt won't see this, because the interrupt doesn't schedule.
>=20
> Worse, dl_server_update_idle() only updates p->se.exec_start when it
> actually did the update. This means that if !dl_defer, it won't advance
> the time, and then when dl_defer it will still see the old timestamp and
> include the !dl_defer time.
>=20
> Also, the enqueue_task_fair() callsite of dl_server_update_idle_time()
> is dodgy as heck, the !nr_running check seems to want to ensures p =3D=3D
> rq->idle, but I'm not sure it actually does.
>=20
> So how about something like this for starters?
>=20

Thanks Peter for sharing this patch, I run it through my test and the model
seems to pass (i.e. no more boosting after deadline). What I found curious
however, is that throughout the test, servers went only through replenish
events.
The system under test is mostly idle (6 periodic dl tasks on a 16 CPUs virt=
me-ng
VM), so I expect not to see any task boosted by the servers, but in 5 minut=
es I
didn't even observe any start/stop for the server.

I'm not sure why this is happening, but looking at traces it seems replenis=
h
occurs more often and perhaps doesn't let the server stop:

<idle>-0     [009] d.h3.    14.312395: (+950124) event_nomiss:         -9: =
idle x dl_replenish_idle -> idle
<idle>-0     [009] d.h3.    14.312401: (+6)     sched_dl_replenish:   comm=
=3Dserver pid=3D-9 runtime=3D50000000 deadline=3D15253307235 yielded=3D0
<idle>-0     [009] d.h3.    15.262771: (+950370) event_nomiss:         -9: =
idle x dl_replenish_idle -> idle
<idle>-0     [009] d.h3.    15.262781: (+10)    sched_dl_replenish:   comm=
=3Dserver pid=3D-9 runtime=3D50000000 deadline=3D16203668554 yielded=3D0
<idle>-0     [009] d.h3.    16.213117: (+950336) event_nomiss:         -9: =
idle x dl_replenish_idle -> idle
<idle>-0     [009] d.h3.    16.213123: (+6)     sched_dl_replenish:   comm=
=3Dserver pid=3D-9 runtime=3D50000000 deadline=3D17154029879 yielded=3D0

Is this expected?

Thanks,
Gabriele

> ---
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 7b7671060bf9..963b85dbc477 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1166,8 +1166,12 @@ static enum hrtimer_restart dl_server_timer(struct
> hrtimer *timer, struct sched_
> =C2=A0		sched_clock_tick();
> =C2=A0		update_rq_clock(rq);
> =C2=A0
> -		if (!dl_se->dl_runtime)
> -			return HRTIMER_NORESTART;
> +		/*
> +		 * Make sure current has propagated its pending runtime into
> +		 * any relevant server through calling dl_server_update() and
> +		 * friends.
> +		 */
> +		rq->curr->sched_class->update_curr(rq);
> =C2=A0
> =C2=A0		if (dl_se->dl_defer_armed) {
> =C2=A0			/*
> @@ -1543,35 +1547,16 @@ static void update_curr_dl_se(struct rq *rq, stru=
ct
> sched_dl_entity *dl_se, s64
> =C2=A0 * as time available for the fair server, avoiding a penalty for th=
e
> =C2=A0 * rt scheduler that did not consumed that time.
> =C2=A0 */
> -void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
> +void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec=
)
> =C2=A0{
> -	s64 delta_exec;
> -
> -	if (!rq->fair_server.dl_defer)
> -		return;
> -
> -	/* no need to discount more */
> -	if (rq->fair_server.runtime < 0)
> -		return;
> -
> -	delta_exec =3D rq_clock_task(rq) - p->se.exec_start;
> -	if (delta_exec < 0)
> -		return;
> -
> -	rq->fair_server.runtime -=3D delta_exec;
> -
> -	if (rq->fair_server.runtime < 0) {
> -		rq->fair_server.dl_defer_running =3D 0;
> -		rq->fair_server.runtime =3D 0;
> -	}
> -
> -	p->se.exec_start =3D rq_clock_task(rq);
> +	if (dl_se->dl_server_active && dl_se->dl_runtime && dl_se->dl_defer)
> +		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
> =C2=A0}
> =C2=A0
> =C2=A0void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec=
)
> =C2=A0{
> =C2=A0	/* 0 runtime =3D fair server disabled */
> -	if (dl_se->dl_runtime)
> +	if (dl_se->dl_server_active && dl_se->dl_runtime)
> =C2=A0		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
> =C2=A0}
> =C2=A0
> @@ -1582,6 +1567,11 @@ void dl_server_start(struct sched_dl_entity *dl_se=
)
> =C2=A0	if (!dl_server(dl_se) || dl_se->dl_server_active)
> =C2=A0		return;
> =C2=A0
> +	/*
> +	 * Update the current task to 'now'.
> +	 */
> +	rq->curr->sched_class->update_curr(rq);
> +
> =C2=A0	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
> =C2=A0		return;
> =C2=A0
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cee1793e8277..c94c996360e6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1239,8 +1239,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
> =C2=A0		 *=C2=A0=C2=A0=C2=A0 against fair_server such that it can account=
 for this
> time
> =C2=A0		 *=C2=A0=C2=A0=C2=A0 and possibly avoid running this period.
> =C2=A0		 */
> -		if (dl_server_active(&rq->fair_server))
> -			dl_server_update(&rq->fair_server, delta_exec);
> +		dl_server_update(&rq->fair_server, delta_exec);
> =C2=A0	}
> =C2=A0
> =C2=A0	account_cfs_rq_runtime(cfs_rq, delta_exec);
> @@ -6996,12 +6995,8 @@ enqueue_task_fair(struct rq *rq, struct task_struc=
t *p,
> int flags)
> =C2=A0			h_nr_idle =3D 1;
> =C2=A0	}
> =C2=A0
> -	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
> -		/* Account for idle runtime */
> -		if (!rq->nr_running)
> -			dl_server_update_idle_time(rq, rq->curr);
> +	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
> =C2=A0		dl_server_start(&rq->fair_server);
> -	}
> =C2=A0
> =C2=A0	/* At this point se is NULL and we are at root level*/
> =C2=A0	add_nr_running(rq, 1);
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index c39b089d4f09..89cfc26ada46 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -452,9 +452,11 @@ static void wakeup_preempt_idle(struct rq *rq, struc=
t
> task_struct *p, int flags)
> =C2=A0	resched_curr(rq);
> =C2=A0}
> =C2=A0
> +static void update_curr_idle(struct rq *rq);
> +
> =C2=A0static void put_prev_task_idle(struct rq *rq, struct task_struct *p=
rev,
> struct task_struct *next)
> =C2=A0{
> -	dl_server_update_idle_time(rq, prev);
> +	update_curr_idle(rq);
> =C2=A0	scx_update_idle(rq, false, true);
> =C2=A0}
> =C2=A0
> @@ -511,6 +513,17 @@ prio_changed_idle(struct rq *rq, struct task_struct =
*p,
> int oldprio)
> =C2=A0
> =C2=A0static void update_curr_idle(struct rq *rq)
> =C2=A0{
> +	struct sched_entity *se =3D &rq->idle->se;
> +	u64 now =3D rq_clock_task(rq);
> +	s64 delta_exec;
> +
> +	delta_exec =3D now - se->exec_start;
> +	if (unlikely(delta_exec <=3D 0))
> +		return;
> +
> +	se->exec_start =3D now;
> +
> +	dl_server_update_idle(&rq->fair_server, delta_exec);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1f5d07067f60..3bb1e59c5944 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -405,6 +405,7 @@ extern s64 dl_scaled_delta_exec(struct rq *rq, struct
> sched_dl_entity *dl_se, s6
> =C2=A0 * naturally thottled to once per period, avoiding high context swi=
tch
> =C2=A0 * workloads from spamming the hrtimer program/cancel paths.
> =C2=A0 */
> +extern void dl_server_update_idle(struct sched_dl_entity *dl_se, s64
> delta_exec);
> =C2=A0extern void dl_server_update(struct sched_dl_entity *dl_se, s64 del=
ta_exec);
> =C2=A0extern void dl_server_start(struct sched_dl_entity *dl_se);
> =C2=A0extern void dl_server_stop(struct sched_dl_entity *dl_se);
> @@ -412,8 +413,6 @@ extern void dl_server_init(struct sched_dl_entity *dl=
_se,
> struct rq *rq,
> =C2=A0		=C2=A0=C2=A0=C2=A0 dl_server_pick_f pick_task);
> =C2=A0extern void sched_init_dl_servers(void);
> =C2=A0
> -extern void dl_server_update_idle_time(struct rq *rq,
> -		=C2=A0=C2=A0=C2=A0 struct task_struct *p);
> =C2=A0extern void fair_server_init(struct rq *rq);
> =C2=A0extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, =
struct rq
> *rq);
> =C2=A0extern int dl_server_apply_params(struct sched_dl_entity *dl_se,


