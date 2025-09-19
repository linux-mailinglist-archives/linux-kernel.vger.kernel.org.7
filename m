Return-Path: <linux-kernel+bounces-825087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E0FB8AEDE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058171CC3DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356EB23ABA0;
	Fri, 19 Sep 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XmYxP3r3"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C3D481B1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306878; cv=none; b=Bvok6zxAcZo8eqWTz4KklXUQMJgn9zXQxzID1astBM/NqJ1v6OsBbEe5SA1J1DHoI7OHHhQBC66z7yvPV12uFOlE9a7LIfPDMHT0t8rXVLGIb4Zh98DkwET8/892LlXqRd52sRulKIQNX9940Rylo8YTflfw2peA5KMlgWy0Yxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306878; c=relaxed/simple;
	bh=Pxid4t2OMPqnn6RV7XV7PYBXTDtuyDOqFvKAgMWsbcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEah/QZNv4LcIGKIW0FNNXmFmhWhjaMELsbkgX2CYou3s4SWeC6d+M/3u5YUZoqUWtJ4O7crl9CZuB6onyu4KRl/3s/jb9rYhOBqOKZ2vrVhyGKh6wBYIWxGhFPBNc1znYTuVcLzp3fjkcLstzkUXNyZY/AXb9629FLvurT70V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XmYxP3r3; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-36639c30bb7so4368031fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758306875; x=1758911675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9St9wD2nhEOrolId7yBDyX03sSS+U2uH4PH1tEXkjyI=;
        b=XmYxP3r3yEkAes3hYuwcTeI4p7okUbrAkZYnNqnQd3cu7hOUEi2mJ8H23VSI1tSPVM
         QGuFt6P30mlcTQDa8rYAkDQBXkSBuh+NcFfaxVFgRRQRFqZz0ngY5naXFj5HXXkvgCB/
         xIWI9xEFEClp7OjHnAx7VxmKgR4sLdpR3hKRPaDTmLez5nJyCUPJ0vLIIfXZ1GUX9Gtx
         KrPhZFqbgWiEVrzZB4DzTnkwIREXqYFRQEO8rj6Gj02QMYH9O0qNZDhtbZDC5mU7PK/5
         9YxE6qi0wp7MMgtDLil0KZ1ir/3mRnFWQLFNvilWtbNL6q+6EgdIp5syrQoNCx5/qvm0
         7o2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306875; x=1758911675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9St9wD2nhEOrolId7yBDyX03sSS+U2uH4PH1tEXkjyI=;
        b=QtTBq6JLOEMFcvuGaOHlR+2GhsLVsc+QVYXIAcgezK6r1u4LsoeE5+WX41nqOJODgm
         CABno2rMkB0PztwkMztXHAnvUCcRNp5ci8ED+jac9/20vEPrHmA4damNQ+EEBMUQDvtU
         yVXg3idyNOkpXwxSqFCfcbS64nkFuoFxxxrhuTcQ/e2zgUE+prvPhJIqTE6Ig7/WYDnB
         LQMU3+Ug3lMs/L/od9WB1K0r7eydfVcSXM6NtO4AxfRXXFHrRAkGS1ai5c5D5X/WiQja
         4CynQoY/QPpEMcBDyB9+H7vXd3lRdhSlo0O2wOD4RkVSwGrtWLsg+kvQTi1ykveOJIDq
         AMzQ==
X-Gm-Message-State: AOJu0YybjW7PgPXaYegZz6i0VGG7vCYL7GC2fa0D4nIeM+waHXcyHfEa
	Ntz3jewCBiJtBhCynCH/6Vh541N4XWU7iQ8dsSbuIIuIqMby3YktYii5XfFLTbMa6MhTIr8lR3B
	7FWntNgQzURbjHGjV3k6j28roGhbo5SkkOtBEe7k=
X-Gm-Gg: ASbGncsUoV51kehsEZHskowpk98AfLgYSUa1gPxomItteYd9DSW/1sWBnyoxSazxdgz
	HiujChys/5ULwYkHSAXat/ekY+5s9pOot2wE8LG4qD7/Pv098oSD19rnKRxs0BIBLwn5wwPq7dV
	sHtJoP9XASx1fy312MLkhvxS5Tbcn1ltwZxn5ZUmJJVukR7Q4k6UGY7J1z+84dUUYj/1v4Kfqt1
	WyeiL1qAsW4gEtJBGwsGFK5z+c5fav5SZMz
X-Google-Smtp-Source: AGHT+IFcUmAwnl8lmC051G2kI6PuOY8yJha7bzXW+B4qDFQlnoncyHh7mPVAlRF8JsSXSO7cpd0SVB8n3lbpGE+kBXM=
X-Received: by 2002:a2e:be8a:0:b0:336:dde8:2ce6 with SMTP id
 38308e7fff4ca-364189f4fe9mr12047141fa.34.1758306874654; Fri, 19 Sep 2025
 11:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904002201.971268-1-jstultz@google.com> <20250904002201.971268-4-jstultz@google.com>
 <dfc571c7-6bd0-409d-ab94-33e8032270fa@amd.com>
In-Reply-To: <dfc571c7-6bd0-409d-ab94-33e8032270fa@amd.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 19 Sep 2025 11:34:21 -0700
X-Gm-Features: AS18NWBz50Iods8EwE2DUuodipweaZcTXjZ2ce98HmtyekpJfnTBSqkaisK0Wvk
Message-ID: <CANDhNCoQZaW3g7wyMnjE9gdC64tSYAnyTyP9zRoSAAJmM31+HQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v21 3/6] sched: Add logic to zap balance callbacks
 if we pick again
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>, 
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 1:32=E2=80=AFAM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
> On 9/4/2025 5:51 AM, John Stultz wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index e0007660161fa..01bf5ef8d9fcc 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5001,6 +5001,40 @@ static inline void finish_task(struct task_struc=
t *prev)
> >       smp_store_release(&prev->on_cpu, 0);
> >  }
> >
> > +#if defined(CONFIG_SCHED_PROXY_EXEC)
>
> nit. This can be an "#ifdef CONFIG_SCHED_PROXY_EXEC" now.

Ah. Yes, this is leftover from it previously checking for PROXY_EXEC
&& CONFIG_SMP.  I'll be sure to clean that up.

> > +#else
> > +static inline void zap_balance_callbacks(struct rq *rq)
> > +{
> > +}
>
> nit.
>
> This can perhaps be reduced to a single line in light of Thomas' recent
> work to condense the stubs elsewhere:
> https://lore.kernel.org/lkml/20250908212925.389031537@linutronix.de/

Ah, if folks are ok with that, I'd prefer it as well!  Thanks for the
suggestion! I'll try to work that throughout the series.

> > +#endif
> > +
> >  static void do_balance_callbacks(struct rq *rq, struct balance_callbac=
k *head)
> >  {
> >       void (*func)(struct rq *rq);
> > @@ -6941,8 +6975,11 @@ static void __sched notrace __schedule(int sched=
_mode)
> >       rq_set_donor(rq, next);
> >       if (unlikely(task_is_blocked(next))) {
> >               next =3D find_proxy_task(rq, next, &rf);
> > -             if (!next)
> > +             if (!next) {
> > +                     /* zap the balance_callbacks before picking again=
 */
> > +                     zap_balance_callbacks(rq);
> >                       goto pick_again;
> > +             }
> >               if (next =3D=3D rq->idle)
> >                       goto keep_resched;
>
> Should we zap the callbacks if we are planning to go through schedule()
> again via rq->idle since it essentially voids the last pick too?

Hrm. So I don't think it's strictly necessary, because we will run the
set callback as part of finish_task_switch() when we switch briefly to
idle. So we don't end up with stale callbacks in the next
pick_next_task().

But I guess zapping them could help just avoid running it spuriously.
I'll give that a shot and see how it affects things.

Thanks again for all the suggestions!
-john

