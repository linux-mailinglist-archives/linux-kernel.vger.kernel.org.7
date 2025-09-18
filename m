Return-Path: <linux-kernel+bounces-823712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3145BB874B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1E57AD2EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31BE2FD7DD;
	Thu, 18 Sep 2025 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1d6IhkdO"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE41EDA26
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236248; cv=none; b=oIeEU51V0Fl2i47vNhw9+POgsiiGSCxHGPyI6wQKwePzp8McLZkAX5Pc5mrJVFylWkbsWX78WF88Y67lJOFs/jkNBFOQ0hfEGBiOWjfvvjzFUppIhoVyDuzA5+0sdrpC0Y3KfzmfB7w1VOJOPbNMkYwKofcNBLwTqAFvdiCtKJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236248; c=relaxed/simple;
	bh=5XO8tJoHhQ/XEy5UTCNEXw1OWHe/nodS5CDFr1qw5oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYzn+RlGxsUfvzCDU4y9EIA88MblEIhg1Nd75kJwjNbT8hzw0shJ+ucRrempjTJzSeyXZueSofaSM2Q40nz9TdoJCUfhkLY7NpDn90IEIDfhShSPMZMuzp35nGkfGiZOeHH1LxGKrC4cDJx++TcsvKHw83S17WRtjfTuaibeMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1d6IhkdO; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-362e291924aso7590501fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758236244; x=1758841044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfcqQ5jVwvJlqSIzlZhXG/+CXPU8TkcDxoMptOUGr5s=;
        b=1d6IhkdOurkH5Hmb+6aeW5MXFnq4YkPr87JVlgvSiqEKkByUDSv67+b/vRylNYi0Rd
         W/Trxx1nKiOxYRYVwYpWDbOwRSjZ7NmQ/vauZ2fa/SLr7fjWSBGJi7QtnFEkPPg3Gymb
         B1/V5C0cEb97yjwewMuOXffoEC8qtLCJrVmUtcxp2C80ZeEjZ/lWQfKYZKFM4iIqLXMF
         Qiet3ZOqhwcuEzJWn6OyDjN5g912At4T0Njp0QIg3MXwSIqoj/ZuotovQNjCnYUik1ia
         tZLm4RxyPrd04Xb/YqwIx4IS1yxupg3v/c60s5DRh16yCuF+onrpm9p4Jpje38rk3tXP
         xjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758236244; x=1758841044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfcqQ5jVwvJlqSIzlZhXG/+CXPU8TkcDxoMptOUGr5s=;
        b=womUqeT7Y7Cmid+N+9B7awzRtf9VMdVhDNPfzUWHq4ss6N1D4d6b/blP6KSoS13VtZ
         akiT+r73jePyTlXuaqBuJapZ1UhDsYDh7Oh8aZFrZjz3WAvkc/hqNKzW0argj4tBKlXg
         nXuxYCONaNyCQURAYARXRnFVEljKXZ52iVUI8QGi1F86MCCcpEmN8BvB/eqPUqZ7dRMI
         mQttGQ2bSbJt2I99CV6BtbEOqya3DXvZY+gvoS3tdnmttEq4Vb9Ghh7bWMVTK+ZeXu4q
         NcXq05t3rD5NWvPmq5lc0lkySVa/32MiFALnrxpK07Skeu9jRRfkL46ImH1pKgKQgxkh
         bwbg==
X-Gm-Message-State: AOJu0YwHO4UWHhEuOYu0ZHUv1NdN//s2H10joA8Y3wQLQgUZTWFUJXl7
	nKoV4CJ2FFfYfAuTtAw2nzKxcnkBDePZa/w0Qc48erhXLCj40jhlkKuMA7qUv9aidGpH15SqUsa
	6ftz8eITwiYGvblif9nE5OU2QcgQNMT0tR4Enfb8=
X-Gm-Gg: ASbGncs/A9GV4Ejf1n166xECHhUrw4knJ6xB+KNcp2pgcNlPsCV0mD691dSMjah3/x1
	ttIU7X3K8wnF8tMxwBT8CE2g2zwkJFxwt48dmtFVIQMYo0Vf8DMIzRlo32I0i772v6UcONFu/ks
	lPd43AHmwtdS09IUEDpft7BOQa1RbvPjVX8pul6U7td/eHR9l94rFj0SLXTqZzpWtf0B/MgohiL
	BjJxXkM8/4TdUm7sI02L1gpV8OAM033Uu2v6fUArpAriaggK+sxBtTMAUagEA==
X-Google-Smtp-Source: AGHT+IFbrT7vLaWYdOrxkx6WdYgNvYu9yycE1k2quAq8t1A0efHmMPED05ZwoVBpKpUPo1sXwmckwTiHyrKnDMmCZUg=
X-Received: by 2002:a05:651c:715:b0:336:bfe4:b11c with SMTP id
 38308e7fff4ca-3641ca1ea91mr2182241fa.44.1758236243923; Thu, 18 Sep 2025
 15:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904002201.971268-1-jstultz@google.com> <20250904002201.971268-3-jstultz@google.com>
 <337322ea-6efe-4814-a813-e55d4c80fda7@amd.com>
In-Reply-To: <337322ea-6efe-4814-a813-e55d4c80fda7@amd.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 18 Sep 2025 15:57:10 -0700
X-Gm-Features: AS18NWCyHnqwkpESiqLurRSDMwgCyef-OUZy4obTQe1ojtl6ipCYjq16_lzoDi4
Message-ID: <CANDhNCpmQLF_03t3PMEtjBU_tpL10FJ_iL=x3zMG+Bs0PEFESw@mail.gmail.com>
Subject: Re: [RESEND][PATCH v21 2/6] sched/locking: Add blocked_on_state to
 provide necessary tri-state for proxy return-migration
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

On Mon, Sep 15, 2025 at 1:06=E2=80=AFAM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
>
> Hello John,
>
> On 9/4/2025 5:51 AM, John Stultz wrote:
> >  static inline void __clear_task_blocked_on(struct task_struct *p, stru=
ct mutex *m)
> >  {
> > +     /* The task should only be clearing itself */
> > +     WARN_ON_ONCE(p !=3D current);
> >       /* Currently we serialize blocked_on under the task::blocked_lock=
 */
> >       lockdep_assert_held_once(&p->blocked_lock);
> > -     /*
> > -      * There may be cases where we re-clear already cleared
> > -      * blocked_on relationships, but make sure we are not
> > -      * clearing the relationship with a different lock.
> > -      */
> > -     WARN_ON_ONCE(m && p->blocked_on && p->blocked_on !=3D m);
> > +     /* Make sure we are clearing the relationship with the right lock=
 */
> > +     WARN_ON_ONCE(m && p->blocked_on !=3D m);
> >       p->blocked_on =3D NULL;
> > +     p->blocked_on_state =3D BO_RUNNABLE;
> >  }
> >
>
> Maybe it is just me, but I got confused a couple of time only to
> realize __clear_task_blocked_on() clears the "blocked_on" and sets
> "blocked_on_state" to BO_RUNNABLE.
>
> Can we decouple the two and only set "p->blocked_on" in
> *_task_blocked_on_* and "p->blocked_on_state" in
> *{set,clear,force}_blocked_on* functions so it becomes easier to
> follow in the mutex path as:
>
>     __set_task_blocked_on(p, mutex); // blocked on mutex
>     __force_blocked_on_blocked(p); // blocked from running on CPU
>
>    ...
>
>     __clear_task_blocked_on(p, mutex); // p is no longer blocked on a mut=
ex
>     __set_blocked_on_runnable(p); // p is now runnable

Hrm. So I guess I was thinking of
set_task_blocked_on()/clear_task_blocked_on() as the main enter/exit
states, with set_blocked_on_waking(), set_blocked_on_runnable() as
transition states within.

But, the various force_blocked_on_<state>() cases do add more
complexity, so maybe handling it completely separately would be more
intuitive? I dunno.


> >  static inline void clear_task_blocked_on(struct task_struct *p, struct=
 mutex *m)
>
> Of the three {set,clear}_task_blcoked_on() usage:
>
>     $ grep -r "\(set\|clear\)_task_blocked_on" include/
>     kernel/locking/mutex.c: __set_task_blocked_on(current, lock);
>     kernel/locking/mutex.c: __clear_task_blocked_on(current, lock);
>     kernel/locking/mutex.c: clear_task_blocked_on(current, lock);
>
> two can be converted directly and perhaps clear_task_blocked_on() can be
> renamed as clear_task_blocked_on_set_runnable()?
>
> This is just me rambling on so feel free to ignore. I probably have to
> train my mind enough to see __clear_task_blocked_on() not only clears
> "blocked_on" but also sets task to runnable :)

Yeah, the case where we don't already hold the lock and want to do
both gets more complex in that case.

Hrm. Maybe just the way the functions are organized in the header make
it seem like we're managing two separate bits of state, where really
they are ordered.
I'll try to re-arrange that introducing the
set_task_blocked_on/clear_task_blocked_on first, then the transition
set_blocked_on_<state>() helpers after?
Maybe that and  some comments will make that clearer?

> > @@ -6749,6 +6776,15 @@ find_proxy_task(struct rq *rq, struct task_struc=
t *donor, struct rq_flags *rf)
> >
> >       WARN_ON_ONCE(owner && !owner->on_rq);
> >       return owner;
> > +
> > +     /*
> > +      * NOTE: This logic is down here, because we need to call
> > +      * the functions with the mutex wait_lock and task
> > +      * blocked_lock released, so we have to get out of the
> > +      * guard() scope.
> > +      */
>
> I didn't know that was possible! Neat. Since cleanup.h has a note
> reading:
>
>     ... the expectation is that usage of "goto" and cleanup helpers is
>     never mixed in the same function.
>
> are there any concerns w.r.t. compiler versions etc. or am I just being
> paranoid?

Hrrrrmmmm.  I hadn't seen that detail. :/   I guess I was just lucky
it worked with my toolchain.

Oof. That may require reworking all this logic back to explicit
lock/unlock calls, away from the guard() usage.

Let me think on if there's a better way.

Thanks so much again for pointing this out!
-john

