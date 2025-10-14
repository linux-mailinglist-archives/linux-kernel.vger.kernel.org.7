Return-Path: <linux-kernel+bounces-853000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD82BDA68B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D393188359E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BE43002C9;
	Tue, 14 Oct 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ne9vxHCE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F4B19CCEC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455950; cv=none; b=WjoyvH15Zwx10yH+fgwTerbeaj3Ylky2G714Wn39+jct5exjLKjRrv4PreE1/gTHmis0EemGzzVSq0AXl95OEcc52LNGHaS6+L9nXS4gRWcQYbLc1gs40rr5PZEg30OJW0SX799aGAKYXpAcq/llO8zR2KPX72JbVvK7KqLDzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455950; c=relaxed/simple;
	bh=09dD90bcaeqEr+k9KC7eqZqIf2sl9ltfNKmWsiiNMkc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDgKRlYHBjpnrIHGvLydUMMrUIrMUEjrkDJt5Pkbqi6couyN7Mc+iJt8xA1bzv386vpd8oo/kc5EUdVQqFNlCCdMx1qLB0buqsdg6NrTE8PXXxhfvROF//rrTEMgBayDP+Jy/aXDfTPpoPJoApPFG5Je/ZzDskY0K7TzBnO8UuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ne9vxHCE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760455944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YHrkf0abjhKrsVY0OHdQ6HsFVemPBcOZ5v5g3LT8Gcw=;
	b=Ne9vxHCE8CkIPg3SX8BTV0Vq6LjJxM9hUpCEoTdaDg7dJF4J8rWUTkI6oR/NN2dt4wGpf+
	3dqAbjgcdMJcdQYPPTr0v6js/jsuOGLf2V1eFwi6qY3Hch8AnC+kJlI0Z8bo997zldSvkJ
	ohYlMNHg4K5p6P4PEF0RE987BMEDhfY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-mwV8meSCMu6XSQLM9tTvZQ-1; Tue, 14 Oct 2025 11:32:23 -0400
X-MC-Unique: mwV8meSCMu6XSQLM9tTvZQ-1
X-Mimecast-MFC-AGG-ID: mwV8meSCMu6XSQLM9tTvZQ_1760455942
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-426ce339084so4084627f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760455942; x=1761060742;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHrkf0abjhKrsVY0OHdQ6HsFVemPBcOZ5v5g3LT8Gcw=;
        b=Q6ulOz8oLq5SikCZ6rvKNvAqNRdPAXegMPdTZrJAIEM2q54DHMjwCoheAS7XmjzRhi
         MyFebZywgPzX0mGZSFV0bWYXicX3wr67Ice+J/MPYNw/7c/4AGalPmINoCqnmfBb/gyS
         DXrKdmK2sY3spk0L+YKWlxcQhrHuOsVOzicqhH3CMK96QUMaucsIJC/EUfG3GMfrmpDH
         T33aNfpGyLdT9wwLAxQvu5S+1/rcWTbpsL5ZCdBvKzFoo+YT1Jkp6lAWMxfRRWgIMjaZ
         MIcF42/7+7PAWvqIJteOwK5YZ4iINo8i19qbcB762LifDLrGbP4xipiw151hZvCN+2oy
         A4Pw==
X-Gm-Message-State: AOJu0YyM3+w0X9RKUunyc+Y/1q3hhlyR9zeTALfjlVzvyu0NSiP5HiGB
	Skt6VmyjLRevRQqoyNMuDOyIa7kquOtdTNTwe4tlcCO/fGHqJD6PfWgzVQIGKwiNuVjGw/SUmOy
	v3wwQBHKlP8s8IaUl/nhWyeQr95GcrF3dFaF+qd8jzTV9XeaeWY3HTQ3hAvCy0dFcmA==
X-Gm-Gg: ASbGncv8SJ2iH0VjPZWaREh5nBnI3mcnx9rvzg4S8AlvbStx/k2zEzm17jHkaoQyB1Q
	3CPfTrci+zJokazfZ/ljJQUpC0SlyWoDx0VmgdpnRRLP1zFFS4UA7DbySTba0i4YYyU3ACu9MPq
	D1kjzE0UuvzSkKCHDu9kdAuSvK7OZNpbVRhTbaOQ5LoKmS/VdLtj6yoKdK5/GYTrt++T4CSPJdj
	YGJsVhR8Ockixu3LpS/2gv7Udho6vqUCd3UzzY36KKFbcomnODoBlRqKxfXgAioCqdvRXh4GnL4
	Un+MSWujs4Xia4fVpnqKZ3ZBv3APe31AVGnEgWhuPDLWIEPP1byH6du5Kl+SNDyO3KPb
X-Received: by 2002:a05:600c:46d2:b0:46e:3686:a2dd with SMTP id 5b1f17b1804b1-46fbbc93abfmr85111095e9.11.1760455942052;
        Tue, 14 Oct 2025 08:32:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1xOonl2VAHITnj0lflKvsJ2Dx2gUVTdT3A8KSOIVMJnb6ewUHOxXC0WjnDzSjtKmYPpMb6Q==
X-Received: by 2002:a05:600c:46d2:b0:46e:3686:a2dd with SMTP id 5b1f17b1804b1-46fbbc93abfmr85110845e9.11.1760455941606;
        Tue, 14 Oct 2025 08:32:21 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb483c7e0sm248225525e9.7.2025.10.14.08.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:32:21 -0700 (PDT)
Message-ID: <83a5971ef07226737421737f889795ec57b6fa6c.camel@redhat.com>
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Clark Williams <williams@redhat.com>
Date: Tue, 14 Oct 2025 17:32:19 +0200
In-Reply-To: <20251014102541.GS3245006@noisy.programming.kicks-ass.net>
References: <20251007122904.31611-1-gmonaco@redhat.com>
	 <20251014095407.GM4067720@noisy.programming.kicks-ass.net>
	 <a0ccf27f5e12a11d2e9dc951ceaf7f9d103f67f6.camel@redhat.com>
	 <20251014102541.GS3245006@noisy.programming.kicks-ass.net>
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

On Tue, 2025-10-14 at 12:25 +0200, Peter Zijlstra wrote:
>=20
> Lets be confused together :-)
>=20
> So dl_server is active, but machine is otherwise idle, this means
> dl_server_timer is pending, right?

It may not be, as far as I see from the trace, the timer expires at the las=
t
replenish before this "error" and is only restarted a while after, when the
boosted task is throttled by a tick.

>=20
> This timer is in one of two states:
>=20
> =C2=A0- waiting for replenish; which will trigger and switch to 0-laxity.
> =C2=A0- waiting for 0-laxity
>=20
> So that 0-laxity case is the interesting one; when the machine really is
> idle, no fair tasks will run and its runtime budget will not get
> depleted. Therefore, once we hit 0-laxity, it will do
> enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH).
>=20
> This enqueue should ensure dl_se->deadline is in the future, right?

Yes, this enqueue replenishes (as I can see in the trace), but that doesn't=
 re-
start the timer. The server gets to replenish_dl_entity with dl_defer_armed=
,
toggles that and doesn't start a timer (should it?).

> Anyway, we run this deadline entity (there ain't nothing else to do
> anyway), and it finds there aren't any fair tasks, it does
> dl_server_stop().

As far as I see, we do reschedule when enqueueing this server entity, but w=
e
don't stop the server (should we though?).
I'm going to gather some more traces to understand what's happening in ther=
e.

Here is a trace where you see the schedule just after that replenish before=
 the
error, but no server stop in there (we have tracepoints so you'd see it):

      <idle>-0    d.h3.  13.347981: (+3)     sched_dl_replenish:   comm=3Ds=
erver pid=3D-13 runtime=3D50000000 deadline=3D14270340997 yielded=3D0
      <idle>-0    .N.2.  13.348043: (+62)    sched_entry:          without =
preemption
      <idle>-0    ...2.  13.348048: (+5)     sched_exit:           without =
switch
      <idle>-0    .N.2.  14.942485: (+1594437) sched_entry:          withou=
t preemption
      <idle>-0    dN.2.  14.942498: (+13)    bprint:               pick_tas=
k_dl: Server picked ksoftirqd/13-126 (runtime 0)
      <idle>-0    d..3.  14.942519: (+21)    event_nomiss:         -13: rea=
dy x sched_switch_in -> running
      <idle>-0    d..2.  14.942521: (+2)     sched_switch:         swapper/=
13:0 [120] R =3D=3D> ksoftirqd/13:126 [120]
ksoftirqd/13-126  ...2.  14.942528: (+7)     sched_exit:           with swi=
tch
ksoftirqd/13-126  ...2.  14.942566: (+38)    sched_entry:          without =
preemption
ksoftirqd/13-126  d..3.  14.942588: (+22)    error_env_nomiss:     -13: eve=
nt dl_throttle not expected in the state running with env clk=3D593612020
ksoftirqd/13-126  d..3.  14.942592: (+4)     sched_dl_throttle:    comm=3Ds=
erver pid=3D-13 runtime=3D-92390 deadline=3D14270340997 yielded=3D0
ksoftirqd/13-126  d..3.  14.942601: (+9)     sched_dl_replenish:   comm=3Ds=
erver pid=3D-13 runtime=3D50000000 deadline=3D15864951976 yielded=3D0
ksoftirqd/13-126  d..2.  14.942623: (+22)    sched_switch:         ksoftirq=
d/13:126 [120] S =3D=3D> rcuc/13:124 [98]
     rcuc/13-124  ...2.  14.942628: (+5)     sched_exit:           with swi=
tch

> Then, if a fair takes wakes (nr_running: 0->1) and dl_server isn't
> active, we do dl_server_start(), which in turn does enqueue_dl_entity().
> Now this enqueue is supposed to check if the dl_entity can still run;
> does it still have time left in its current period, if not, its
> replenish timer time.
>=20
>=20
> So where exactly does the fair task start, and result in dl_se being
> on_rq such that dl_deadline is in the past? That sounds like an enqueue
> problem to me.
>=20
>=20


