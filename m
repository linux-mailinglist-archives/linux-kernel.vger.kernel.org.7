Return-Path: <linux-kernel+bounces-895089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4A5C4CFB6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439254A2F64
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BEF2FD7A7;
	Tue, 11 Nov 2025 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGONj7sY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2hCiBSX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EDB2FB62E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855140; cv=none; b=rUgI+TCYmx8ecuBaa/teBqmnN9jMLuT2frIuO/MpHbTuJLsUjRl71lALqwQxD2c988rhYadViFymGFPeMcq6ZM+kmNvqA9SADGDhrYOOQOI++3xVlPR4RqjgaIvWDmqVUx2FNhijjdSjOU6T0C8XVJMfwOLoaCszSS0LCU8NALM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855140; c=relaxed/simple;
	bh=svLm/wpH1nJRoCs/TpqOou+xfBK8zTgJzZukj7mNZqs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ic3BLtXNyX6CLwyijihtfCuKYSiAYEo+nv6QtsinUnRCqzHiz7EID4Nltzv0hZq38Q1VUD6sVgPK7g1sV7h9aPNdbhcV4jksYVQ3xY7fPGklKu8lTB6OUVvuGFwK8xOJ19IL+klJb5VoUgQsjXU2nITgR88b757cobpyXdY64NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGONj7sY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2hCiBSX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762855137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1Uu3z2VCY2s8lnICfif8IdcZ3H70TzLzE4ghLUFwew4=;
	b=XGONj7sYEVrP/Ig3OCOYeTV5KBMJHUvYbZd9RhROuL4Xyu9Mu9dn9GVH60M9NkrNxXf6TN
	4A2XPWHC4Cf//TS52i6JyBEuf6fW9FtN1q1ZtFutE+NLkNUPtsQk7u82ZPRNrCOOnmZUfW
	gRi8JgnhmAQnRU14jmRSF6BuVnL0tY4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-OQEvrYQcO8OitGdRanzcxA-1; Tue, 11 Nov 2025 04:58:55 -0500
X-MC-Unique: OQEvrYQcO8OitGdRanzcxA-1
X-Mimecast-MFC-AGG-ID: OQEvrYQcO8OitGdRanzcxA_1762855134
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b3086a055so1951007f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762855134; x=1763459934; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Uu3z2VCY2s8lnICfif8IdcZ3H70TzLzE4ghLUFwew4=;
        b=P2hCiBSXTjRJPkdpCh94Tzz8ihL+VbAc6sLpn7XiLI7r0NTOysXoHO87f6b+4AzfDs
         P6/rqVqxX2j/S+kZQuMEgPEP7oG/K3lR0/XpQeAz8ecUU9aYSIt8yv1FF+3hLLAo3BAV
         kA3crxMntYtY74ksSP0L0N2xo9GrAGlsdmnISCYzvx44uK3bRTjDheb/wIQYxugGSKZS
         RyCLneZTk4HihzXaPbYpTTtqZdF1ft2jt6jPt5tDkxjSf9h1BHl4U/PwS2NmhflQ9HAh
         P3zRx7wf2emjFYON3fZm7y5KNHw7LyJ5KHr3g1FsOTblEi5oW3d5xhwZkoRfE4fyxX5o
         JTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762855134; x=1763459934;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Uu3z2VCY2s8lnICfif8IdcZ3H70TzLzE4ghLUFwew4=;
        b=hkxoIwqdyzpo0MnS/Ag0nR0uBPW2gOC/U3A/8zTQ/EM7LRUTOQe2bByPDSN1VhQD3M
         8btpKCJakFqgZzTie42Y+VlDjHJA/JqLrgR9Ag3DN0GJGSr4CseQeBWqzmKANKkB+zXR
         B0F/31XWX2sdp+SsNfExPsofJ0wrS7D3MkLPKXjhB39BKZRZDkI9mPRBLh8CGVRYHFGs
         EBB9aoeWUQ6jcfblZ1CndG1bNBTjzaV5OyCOMNDDI2jVhlEAev1UZ8gGNdxBqCVHKRan
         s6F3Rp1Os0L/cdu5N4aTRHpfJt47CvR/nm0ju1LyVzqOcZKLvpzOOHRko+2nvwaxlcwC
         wzyg==
X-Forwarded-Encrypted: i=1; AJvYcCWH2gSExHiAXp4wjmmiSWBP4kiCyqzBsguGNnWLUVkG5W754CQXiR8bJawIZ4J3VCmFVPQY2Sj12CSSn2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIBP6CnNdDyZwrbCO6/kX0wph5vRhRaz90Zg6XTV8WWEW2S/IH
	eCmZrpFYBwE2oxFFsnb3J0nnMn5wAoSSL95nl1eQUEH8QgIL5i9XsnISVAwhC8ZnbAPm+/KEfpA
	1RbxML8yPpl+fpn8UqKEAR1DRdB88oAQm1SuOh5JWo1j0rbNlU0gr2js/rWqsdM+1YcSXpyil5l
	AB
X-Gm-Gg: ASbGncsdX6qeY9VC/dS8H0riFOseuvddQksT+1MUjiM8E2IFfci4dFLy5WWEAPxH4gB
	KHsLIh8wHLUEU5I/kMLctwAHaTJb3BYqN68HtFtGmMeNKUeOctyn7cMpphZXBy6mCdCuB2dKqQ2
	e04Fz2pbwSPqbiFUruPoIV/tofFDYXXwgfBD7ppDEfSw5bq6oh7jKeqgb5evfu+YsAhMdhxYNa0
	m0LOdykOuD0fspT4ro5/+9drihecS5JK0zsiELb+9zIHoAMi1nwB3SvWJ2g2Ry1GLC4Ft8sWtaM
	UBXpRWZdn74Cay3C47RbMEe5Mg9YsDzIgFrcYyp4tkL/yBD2Y6Kh5UtwpMnMDhVBPGoW5sv0I0L
	0uSOcx0qeFnMDR3ZCKxP1wo7b
X-Received: by 2002:a05:6000:2002:b0:427:813:6a52 with SMTP id ffacd0b85a97d-42b2dc7f5ccmr9960390f8f.41.1762855134246;
        Tue, 11 Nov 2025 01:58:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7XiVNSZ+c1RX6np2dB7Q789yU4ZKc53kY91D3SS5t0hNK6VZ1hZA6/ZRo5h0lUMRWBbsEug==
X-Received: by 2002:a05:6000:2002:b0:427:813:6a52 with SMTP id ffacd0b85a97d-42b2dc7f5ccmr9960359f8f.41.1762855133747;
        Tue, 11 Nov 2025 01:58:53 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b330f6899sm15570180f8f.21.2025.11.11.01.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:58:53 -0800 (PST)
Message-ID: <b8454329ce061f0c113b25b9400e2b0771fa9e27.camel@redhat.com>
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, Ingo
 Molnar <mingo@redhat.com>, Clark Williams <williams@redhat.com>,
 arighi@nvidia.com
Date: Tue, 11 Nov 2025 10:58:51 +0100
In-Reply-To: <20251101000057.GA2184199@noisy.programming.kicks-ass.net>
References: <20251014193300.GA1206438@noisy.programming.kicks-ass.net>
	 <aO8zwouX6qIaf-U-@jlelli-thinkpadt14gen4.remote.csb>
	 <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
	 <8dc29e28a4d87954378ef1d989e0374526b44723.camel@redhat.com>
	 <20251030184205.GB2989771@noisy.programming.kicks-ass.net>
	 <20251031130543.GV4068168@noisy.programming.kicks-ass.net>
	 <1f2ad071e59db2ed8bc0b382ae202b7474d07afc.camel@redhat.com>
	 <20251031152005.GT3245006@noisy.programming.kicks-ass.net>
	 <2daa2e6217eeaa239616303626c0d73d808ae947.camel@redhat.com>
	 <20251031154455.GU3245006@noisy.programming.kicks-ass.net>
	 <20251101000057.GA2184199@noisy.programming.kicks-ass.net>
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

On Sat, 2025-11-01 at 01:00 +0100, Peter Zijlstra wrote:
> On Fri, Oct 31, 2025 at 04:44:55PM +0100, Peter Zijlstra wrote:
>=20
> > Anyway, back to noodling on how to make it stop on idle :-)
>=20
> This seems to behave (at least, it did before the cleanup).=20
>=20
> It has the fancy comment, ascii-art and everything. Hopefully we'll all
> get less confused when looking at this in the future.
>=20

I tested the 3 patches from your tree and I confirm the server behaves as
expected in my test case:

* it properly stops and restarts
* it doesn't boost after deadline or consumed runtime

I'm going to write a model like the one you drew to catch if there are issu=
es
with boosting when not necessary.
From the traces I see the server stays in the state running until the end o=
f my
test (30s) although the CPU should be busy only for the first 5s.

I see things like this, where the server starts as running, bootsts and sto=
ps
(while scheduling out, not in the timer):

     <idle>-0   11.412790:  sched_dl_server_start: comm=3Dserver pid=3D-9 r=
untime=3D34227068 deadline=3D12209337602 yielded=3D0
     <idle>-0   11.412795:  sched_wakeup:         ksoftirqd/9:94 [120] CPU:=
009
     <idle>-0   11.412802:  bprint:               pick_task_dl: Picked task=
 94 (running 1)
     <idle>-0   11.412809:  event_throttle:       -9: armed x sched_switch_=
in -> running (final)
     <idle>-0   11.412809:  sched_switch:         swapper/9:0 [120] R =3D=
=3D> ksoftirqd/9:94 [120]
ksoftirqd/9-94  11.412833:  event_throttle:       -9: running x sched_switc=
h_out -> preempted
ksoftirqd/9-94  11.412834:  sched_dl_server_stop: comm=3Dserver pid=3D-9 ru=
ntime=3D34190225 deadline=3D12209337602 yielded=3D0
ksoftirqd/9-94  11.412840:  sched_switch:         ksoftirqd/9:94 [120] S =
=3D=3D> irq/50-virtio1:213 [49]

Is there a reason why dl_server_stop() doesn't reset the running flag? In t=
his
case if the CPU is only running fair tasks in bursts (like ksoftirqd), it w=
ill
continue boosting them and stopping the server when they go to sleep, wont'=
 it?

Thanks,
Gabriele

> ---
> =C2=A0include/linux/sched.h=C2=A0=C2=A0 |=C2=A0=C2=A0 15 +--
> =C2=A0kernel/sched/deadline.c |=C2=A0 233
> +++++++++++++++++++++++++++++++++++++++++++++++-
> =C2=A02 files changed, 240 insertions(+), 8 deletions(-)
>=20
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -685,20 +685,22 @@ struct sched_dl_entity {
> =C2=A0	 *
> =C2=A0	 * @dl_server tells if this is a server entity.
> =C2=A0	 *
> -	 * @dl_defer tells if this is a deferred or regular server. For
> -	 * now only defer server exists.
> -	 *
> -	 * @dl_defer_armed tells if the deferrable server is waiting
> -	 * for the replenishment timer to activate it.
> -	 *
> =C2=A0	 * @dl_server_active tells if the dlserver is active(started).
> =C2=A0	 * dlserver is started on first cfs enqueue on an idle runqueue
> =C2=A0	 * and is stopped when a dequeue results in 0 cfs tasks on the
> =C2=A0	 * runqueue. In other words, dlserver is active only when cpu's
> =C2=A0	 * runqueue has atleast one cfs task.
> =C2=A0	 *
> +	 * @dl_defer tells if this is a deferred or regular server. For
> +	 * now only defer server exists.
> +	 *
> +	 * @dl_defer_armed tells if the deferrable server is waiting
> +	 * for the replenishment timer to activate it.
> +	 *
> =C2=A0	 * @dl_defer_running tells if the deferrable server is actually
> =C2=A0	 * running, skipping the defer phase.
> +	 *
> +	 * @dl_defer_idle tracks idle state
> =C2=A0	 */
> =C2=A0	unsigned int			dl_throttled=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 1;
> =C2=A0	unsigned int			dl_yielded=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 : 1;
> @@ -709,6 +711,7 @@ struct sched_dl_entity {
> =C2=A0	unsigned int			dl_defer	=C2=A0 : 1;
> =C2=A0	unsigned int			dl_defer_armed	=C2=A0 : 1;
> =C2=A0	unsigned int			dl_defer_running=C2=A0 : 1;
> +	unsigned int			dl_defer_idle=C2=A0=C2=A0=C2=A0=C2=A0 : 1;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Bandwidth enforcement timer. Each -deadline task has its
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1173,6 +1173,11 @@ static enum hrtimer_restart dl_server_ti
> =C2=A0		 */
> =C2=A0		rq->curr->sched_class->update_curr(rq);
> =C2=A0
> +		if (dl_se->dl_defer_idle) {
> +			dl_server_stop(dl_se);
> +			return HRTIMER_NORESTART;
> +		}
> +
> =C2=A0		if (dl_se->dl_defer_armed) {
> =C2=A0			/*
> =C2=A0			 * First check if the server could consume runtime in
> background.
> @@ -1420,10 +1425,11 @@ s64 dl_scaled_delta_exec(struct rq *rq,
> =C2=A0}
> =C2=A0
> =C2=A0static inline void
> -update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_=
se,
> -			int flags);
> +update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_=
se,
> int flags);
> +
> =C2=A0static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity=
 *dl_se,
> s64 delta_exec)
> =C2=A0{
> +	bool idle =3D rq->curr =3D=3D rq->idle;
> =C2=A0	s64 scaled_delta_exec;
> =C2=A0
> =C2=A0	if (unlikely(delta_exec <=3D 0)) {
> @@ -1444,6 +1450,9 @@ static void update_curr_dl_se(struct rq
> =C2=A0
> =C2=A0	dl_se->runtime -=3D scaled_delta_exec;
> =C2=A0
> +	if (dl_se->dl_defer_idle && !idle)
> +		dl_se->dl_defer_idle =3D 0;
> +
> =C2=A0	/*
> =C2=A0	 * The fair server can consume its runtime while throttled (not
> queued/
> =C2=A0	 * running as regular CFS).
> @@ -1454,6 +1463,29 @@ static void update_curr_dl_se(struct rq
> =C2=A0	 */
> =C2=A0	if (dl_se->dl_defer && dl_se->dl_throttled &&
> dl_runtime_exceeded(dl_se)) {
> =C2=A0		/*
> +		 * Non-servers would never get time accounted while
> throttled.
> +		 */
> +		WARN_ON_ONCE(!dl_server(dl_se));
> +
> +		/*
> +		 * While the server is marked idle, do not push out the
> +		 * activation further, instead wait for the period timer
> +		 * to lapse and stop the server.
> +		 */
> +		if (dl_se->dl_defer_idle && idle) {
> +			/*
> +			 * The timer is at the zero-laxity point, this means
> +			 * dl_server_stop() / dl_server_start() can happen
> +			 * while now < deadline. This means
> update_dl_entity()
> +			 * will not replenish. Additionally start_dl_timer()
> +			 * will be set for 'deadline - runtime'. Negative
> +			 * runtime will not do.
> +			 */
> +			dl_se->runtime =3D 0;
> +			return;
> +		}
> +
> +		/*
> =C2=A0		 * If the server was previously activated - the starving
> condition
> =C2=A0		 * took place, it this point it went away because the fair
> scheduler
> =C2=A0		 * was able to get runtime in background. So return to the
> initial
> @@ -1465,6 +1497,9 @@ static void update_curr_dl_se(struct rq
> =C2=A0
> =C2=A0		replenish_dl_new_period(dl_se, dl_se->rq);
> =C2=A0
> +		if (idle)
> +			dl_se->dl_defer_idle =3D 1;
> +
> =C2=A0		/*
> =C2=A0		 * Not being able to start the timer seems problematic. If it
> could not
> =C2=A0		 * be started for whatever reason, we need to "unthrottle"
> the DL server
> @@ -1560,6 +1595,199 @@ void dl_server_update(struct sched_dl_en
> =C2=A0		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
> =C2=A0}
> =C2=A0
> +/*
> + * dl_server && dl_defer:
> + *
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 6
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +--------------------+
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> + *=C2=A0=C2=A0=C2=A0=C2=A0 +-------------+=C2=A0 4=C2=A0=C2=A0 +--------=
---+=C2=A0 5=C2=A0=C2=A0=C2=A0=C2=A0 +------------------+
> + * +-> |=C2=A0=C2=A0 A:init=C2=A0=C2=A0=C2=A0 | <--- | D:running | -----=
> | E:replenish-wait |
> + * |=C2=A0=C2=A0 +-------------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +--------=
---+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +------------------+
> + * |=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0 ^=C2=A0=C2=A0=C2=A0 ^=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |
> + * |=C2=A0=C2=A0=C2=A0=C2=A0 | 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +--=
--------+=C2=A0=C2=A0=C2=A0 | 3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> + * |=C2=A0=C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> + * |=C2=A0=C2=A0 +--------------------------------+=C2=A0=C2=A0 2=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |
> + * |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ----+=C2=A0=C2=
=A0=C2=A0 |
> + * | 8 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 B:zero_laxity-wait=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |
> + * |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | <---+=C2=A0=C2=
=A0=C2=A0 |
> + * |=C2=A0=C2=A0 +--------------------------------+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> + * |=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^=C2=A0=C2=A0=C2=A0=C2=A0 ^=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |
> + * |=C2=A0=C2=A0=C2=A0=C2=A0 | 7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2=C2=A0=C2=A0 +--------------------+
> + * |=C2=A0=C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> + * |=C2=A0=C2=A0 +-------------+=C2=A0 |
> + * +-- | C:idle-wait | -+
> + *=C2=A0=C2=A0=C2=A0=C2=A0 +-------------+
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^ 7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +---------+
> + *
> + *
> + * [A] - init
> + *=C2=A0=C2=A0 dl_server_active =3D 0
> + *=C2=A0=C2=A0 dl_throttled =3D 0
> + *=C2=A0=C2=A0 dl_defer_armed =3D 0
> + *=C2=A0=C2=A0 dl_defer_running =3D 0/1
> + *=C2=A0=C2=A0 dl_defer_idle =3D 0
> + *
> + * [B] - zero_laxity-wait
> + *=C2=A0=C2=A0 dl_server_active =3D 1
> + *=C2=A0=C2=A0 dl_throttled =3D 1
> + *=C2=A0=C2=A0 dl_defer_armed =3D 1
> + *=C2=A0=C2=A0 dl_defer_running =3D 0
> + *=C2=A0=C2=A0 dl_defer_idle =3D 0
> + *
> + * [C] - idle-wait
> + *=C2=A0=C2=A0 dl_server_active =3D 1
> + *=C2=A0=C2=A0 dl_throttled =3D 1
> + *=C2=A0=C2=A0 dl_defer_armed =3D 1
> + *=C2=A0=C2=A0 dl_defer_running =3D 0
> + *=C2=A0=C2=A0 dl_defer_idle =3D 1
> + *
> + * [D] - running
> + *=C2=A0=C2=A0 dl_server_active =3D 1
> + *=C2=A0=C2=A0 dl_throttled =3D 0
> + *=C2=A0=C2=A0 dl_defer_armed =3D 0
> + *=C2=A0=C2=A0 dl_defer_running =3D 1
> + *=C2=A0=C2=A0 dl_defer_idle =3D 0
> + *
> + * [E] - replenish-wait
> + *=C2=A0=C2=A0 dl_server_active =3D 1
> + *=C2=A0=C2=A0 dl_throttled =3D 1
> + *=C2=A0=C2=A0 dl_defer_armed =3D 0
> + *=C2=A0=C2=A0 dl_defer_running =3D 1
> + *=C2=A0=C2=A0 dl_defer_idle =3D 0
> + *
> + *
> + * [1] A->B, A->D
> + * dl_server_start()
> + *=C2=A0=C2=A0 dl_server_active =3D 1;
> + *=C2=A0=C2=A0 enqueue_dl_entity()
> + *=C2=A0=C2=A0=C2=A0=C2=A0 update_dl_entity(WAKEUP)
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dl_defer_running)
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_armed =3D 1;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_throttled =3D 1;
> + *=C2=A0=C2=A0=C2=A0=C2=A0 if (dl_throttled && start_dl_timer())
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // start server into waiting for =
zero-laxity
> + *=C2=A0=C2=A0=C2=A0=C2=A0 __enqueue_dl_entity();
> + *=C2=A0=C2=A0=C2=A0=C2=A0 // start running
> + *
> + * // deplete server runtime from client-class
> + * [2] B->B, C->B, E->B
> + * dl_server_update()
> + *=C2=A0=C2=A0 update_curr_dl_se()
> + *=C2=A0=C2=A0=C2=A0=C2=A0 if (dl_defer_idle)
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_idle =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0 if (dl_defer && dl_throttled && dl_runtime_ex=
ceeded())
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_running =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hrtimer_try_to_cancel();=C2=A0=C2=
=A0 // stop timer
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replenish_dl_new_period()
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // fwd period
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_throttled =3D 1;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_armed =3D 1;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_dl_timer();=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 // restart timer
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // back into waiting for zero-lax=
ity
> + *
> + * // timer actually fires means we have runtime
> + * [3] B->D
> + * dl_server_timer()
> + *=C2=A0=C2=A0 if (dl_defer_armed)
> + *=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_running =3D 1;
> + *=C2=A0=C2=A0 enqueue_dl_entity(REPLENISH)
> + *=C2=A0=C2=A0=C2=A0=C2=A0 replenish_dl_entity()
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // fwd period
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dl_throttled)
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_throttled =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dl_defer_armed)
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_armed =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0 __enqueue_dl_entity();
> + *=C2=A0=C2=A0=C2=A0=C2=A0 // goto [4]
> + *
> + * // schedule server
> + * [4] D->A
> + * pick_task_dl()
> + *=C2=A0=C2=A0 p =3D server_pick_task();
> + *=C2=A0=C2=A0 if (!p)
> + *=C2=A0=C2=A0=C2=A0=C2=A0 dl_server_stop()
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dequeue_dl_entity();
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hrtimer_try_to_cancel();
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_armed =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_throttled =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_server_active =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // goto [1]
> + *=C2=A0=C2=A0 return p;
> + *
> + * // server running
> + * [5] D->E
> + * update_curr_dl_se()
> + *=C2=A0=C2=A0 if (dl_runtime_exceeded())
> + *=C2=A0=C2=A0=C2=A0=C2=A0 dl_throttled =3D 1;
> + *=C2=A0=C2=A0=C2=A0=C2=A0 dequeue_dl_entity();
> + *=C2=A0=C2=A0=C2=A0=C2=A0 start_dl_timer();
> + *=C2=A0=C2=A0=C2=A0=C2=A0 // replenish-timer
> + *
> + * // server exchausted
> + * [6] E->D
> + * dl_server_timer()
> + *=C2=A0=C2=A0 enqueue_dl_entity(REPLENISH)
> + *=C2=A0=C2=A0=C2=A0=C2=A0 replenish_dl_entity()
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fwd-period
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dl_throttled)
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_throttled =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0 __enqueue_dl_entity();
> + *=C2=A0=C2=A0=C2=A0=C2=A0 // goto [4]
> + *
> + * // deplete server runtime from idle
> + * [7] B->C, C->C
> + * dl_server_update_idle()
> + *=C2=A0=C2=A0 update_curr_dl_se()
> + *=C2=A0=C2=A0=C2=A0=C2=A0 if (dl_defer && dl_throttled && dl_runtime_ex=
ceeded())
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dl_defer_idle)
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_running =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hrtimer_try_to_cancel();
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replenish_dl_new_period()
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // fwd period
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_throttled =3D 1;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_armed =3D 1;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_idle =3D 1;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_dl_timer();=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 // restart timer
> + *
> + * // stop idle server
> + * [8] C->A
> + * dl_server_timer()
> + *=C2=A0=C2=A0 if (dl_defer_idle)
> + *=C2=A0=C2=A0=C2=A0=C2=A0 dl_server_stop();
> + *
> + *
> + * digraph dl_server {
> + *=C2=A0=C2=A0 "A:init" -> "B:zero_laxity-wait"=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [label=3D"1:dl_server_star=
t"]
> + *=C2=A0=C2=A0 "A:init" -> "D:running"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 [label=3D"1:dl_server_start"]
> + *=C2=A0=C2=A0 "B:zero_laxity-wait" -> "B:zero_laxity-wait"
> [label=3D"2:dl_server_update"]
> + *=C2=A0=C2=A0 "B:zero_laxity-wait" -> "C:idle-wait"=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
> [label=3D"7:dl_server_update_idle"]
> + *=C2=A0=C2=A0 "B:zero_laxity-wait" -> "D:running"=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [label=3D"3:dl_server_timer"]
> + *=C2=A0=C2=A0 "C:idle-wait" -> "C:idle-wait"=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> [label=3D"7:dl_server_update_idle"]
> + *=C2=A0=C2=A0 "C:idle-wait" -> "B:zero_laxity-wait"=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
> [label=3D"2:dl_server_update"]
> + *=C2=A0=C2=A0 "C:idle-wait" -> "A:init"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 [label=3D"8:dl_server_timer"]
> + *=C2=A0=C2=A0 "D:running" -> "A:init"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 [label=3D"4:pick_task_dl"]
> + *=C2=A0=C2=A0 "D:running" -> "E:replenish-wait"=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> [label=3D"5:update_curr_dl_se"]
> + *=C2=A0=C2=A0 "E:replenish-wait" -> "B:zero_laxity-wait"=C2=A0=C2=A0
> [label=3D"2:dl_server_update"]
> + *=C2=A0=C2=A0 "E:replenish-wait" -> "D:running"=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [label=3D"6:dl_server_timer"]
> + * }
> + *
> + *
> + * Notes:
> + *
> + *=C2=A0 - When there are fair tasks running the most likely loop is [2]=
->[2].
> + *=C2=A0=C2=A0=C2=A0 the dl_server never actually runs, the timer never =
fires.
> + *
> + *=C2=A0 - When there is actual fair starvation; the timer fires and sta=
rts the
> + *=C2=A0=C2=A0=C2=A0 dl_server. This will then throttle and replenish li=
ke a normal DL
> + *=C2=A0=C2=A0=C2=A0 task. Notably it will not 'defer' again.
> + *
> + *=C2=A0 - When idle it will push the activation forward once, and then =
wait
> + *=C2=A0=C2=A0=C2=A0 for the timer to hit or a non-idle update to restar=
t things.
> + */
> =C2=A0void dl_server_start(struct sched_dl_entity *dl_se)
> =C2=A0{
> =C2=A0	struct rq *rq =3D dl_se->rq;
> @@ -1590,6 +1818,7 @@ void dl_server_stop(struct sched_dl_enti
> =C2=A0	hrtimer_try_to_cancel(&dl_se->dl_timer);
> =C2=A0	dl_se->dl_defer_armed =3D 0;
> =C2=A0	dl_se->dl_throttled =3D 0;
> +	dl_se->dl_defer_idle =3D 0;
> =C2=A0	dl_se->dl_server_active =3D 0;
> =C2=A0}
> =C2=A0


