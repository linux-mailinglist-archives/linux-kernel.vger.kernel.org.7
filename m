Return-Path: <linux-kernel+bounces-846074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43358BC6F82
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 02:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9133E08F0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 00:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584B44C6D;
	Thu,  9 Oct 2025 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8Ofa572"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762A538D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 00:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759968462; cv=none; b=r0qngNobYTOrYiuGwJQzljns+oMcvu+Qr/0sFyyy5ZBlUn3igDRERXpF6iUHBS+cXuXfuG+uYGg8XeZgbKNEEfrM7moZmQf7YROEAxonW+BgiA/ZfROrhsgvcC1jhHUPmYGPq3j8pqcCAdkqyQpoha3yUKYRyIPaGXTFpzW/xXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759968462; c=relaxed/simple;
	bh=svMcZlDO9Sp2OwaMfE6dWnt1qEktF7lLK5mriH0mW8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAap+Eg32ilJz+m+6vMF8UZwZxo0FdDz4Y6dc6k27BXkGdme0aATScQx+RdOKaKQxjZZNzduJqGvi3zyTqCLXDBBPEtc96aaUhpvGoZfAuVktq2+h2Pl9s9dA0yZCpgoyQXh5bLozNmUwRrN/eA/WvjFteQ2pO8bGFmJpsCAPGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8Ofa572; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78ead12so59490166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 17:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759968459; x=1760573259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbaxYmF7Qwblc4BprYgLUbkoGyzlzLYAJQhWp8QYcwI=;
        b=R8Ofa572hVlYKsgDwEFnpa30/aGc/p4E/ez8bDNLealfi7LR4xvAJbG2duQ0Ogs3+i
         7EjiGB7QqF3h66yeTm1CV6hzPjwurRqXxpSUsFIUHO/zT1fYTNOrMQqxSGjKZ61JRQrn
         13cQsC+XABbTM0XP6CFXat01v5UjVGuD2uICKU+2+it6m7STX9Vb/oUwGzzxhmy48i0g
         SofhRfNk86iuozOwLQpj/PcM0YdXkXnCOfQEBADVZVg8dxv05/utnRZoHdM4TUHvWM6A
         h3THu8y1lBND8eV8ODEhqXIuOKLBqZpAOSJDE/iMsUhfcj4cWQE2pAROD1vm8MzekIhc
         2kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759968459; x=1760573259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbaxYmF7Qwblc4BprYgLUbkoGyzlzLYAJQhWp8QYcwI=;
        b=hcnOVPeJe9RdGha4QkbS1alIG2ShljF1ioQlTt5jBiviywthP7P9hjOK8cMtxwxJuG
         Z5TdgS+zA63+PFANugwOeLz+5Cx7HAbBHFyexVkozntwc0m0XRXOQFtaDbunsW/08g6n
         rfVqanW+Yht84x0pqwD09wUnsRQPsYTD8mald1bXhbyIG9NmhzmM2XQl1bPbcwaOirQ8
         KimJtFSX9geK29mLaNh0yax3XCA4yoRPTf0ipcDeJT8SCtg6zJedcWJzJ8886cegs2WU
         gTD5hQEsLcq6gGmVY0P11wGZLrj1/qOorHup6dgPL/OICpNtXGDF9n4cHAKsLmJaSrOQ
         tR8w==
X-Gm-Message-State: AOJu0YyOQzdJt9e6EyRosZFr57qGjMkXz5VykOfm82L+gSxRQGw9g/ep
	VIwcRR+M7aLpWa97v/+7zoCtV+ec8l1dZyn34OJf+FYgrpFWRhWcWCDiwTV/gBwnYgBY8adWToo
	QHuuZloukAsk+EpDbZH2cLP3rIbqfTeNj544E8jNnLXGi3veexsm1IHY=
X-Gm-Gg: ASbGncuuPOiOAQqqi6qc1TYrgFyjHIQm+MPdRUeSaAZY6/h6N8cR85VS8cGI+HQsMwJ
	JuFki+NEkt8TU32OIzFpo5KLuDa//pt7CbMO9gfH7FlVTqikOy7XqUL2bnfHelNJREcnXgkDuQx
	hZHRClF6luWj7krg7q9E41swxyYKDX8YeuArWYFpHhHmxjdAN39lqiqs2OgAP2XGm74zkGPSdpe
	dXvc532Jbsq3Le9psNDthDc/7Vxoa1h2GYGSFquVxviprYqqPS/41ndr55LJ+p02ZMaeDi9HHGO
	iXM=
X-Google-Smtp-Source: AGHT+IHtBWOV5lK8o7tDNCQ3Un3Zyzot68GEuPzZ2padV5g+RRXw8ysL2Bp6ZIH37PZ8WgwFRKrI8D5j9HlcwQJDB2M=
X-Received: by 2002:a17:907:868b:b0:b3e:babd:f257 with SMTP id
 a640c23a62f3a-b50aa49207amr681520366b.10.1759968458385; Wed, 08 Oct 2025
 17:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926032931.27663-1-jstultz@google.com> <20250926032931.27663-3-jstultz@google.com>
 <20251008112603.GU3419281@noisy.programming.kicks-ass.net>
In-Reply-To: <20251008112603.GU3419281@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Wed, 8 Oct 2025 17:07:26 -0700
X-Gm-Features: AS18NWB6BepBJP_C1ns9ZZVuTEc3qPJzpn87HL1BggfJ_Pgt9GYxibxPj7GTYXI
Message-ID: <CANDhNCpSNyOkcuUZvpZK5FQhL8oxQEax2wUStdRAV_ns2z7n_A@mail.gmail.com>
Subject: Re: [PATCH v22 2/6] sched/locking: Add blocked_on_state to provide
 necessary tri-state for proxy return-migration
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 4:26=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
> On Fri, Sep 26, 2025 at 03:29:10AM +0000, John Stultz wrote:
> > As we add functionality to proxy execution, we may migrate a
> > donor task to a runqueue where it can't run due to cpu affinity.
> > Thus, we must be careful to ensure we return-migrate the task
> > back to a cpu in its cpumask when it becomes unblocked.
> >
> > Thus we need more then just a binary concept of the task being
> > blocked on a mutex or not.
> >
> > So add a blocked_on_state value to the task, that allows the
> > task to move through BO_RUNNING -> BO_BLOCKED -> BO_WAKING
> > and back to BO_RUNNING. This provides a guard state in
> > BO_WAKING so we can know the task is no longer blocked
> > but we don't want to run it until we have potentially
> > done return migration, back to a usable cpu.
> >
> > Signed-off-by: John Stultz <jstultz@google.com>
> > ---
> >  include/linux/sched.h     | 92 +++++++++++++++++++++++++++++++++------
> >  init/init_task.c          |  3 ++
> >  kernel/fork.c             |  3 ++
> >  kernel/locking/mutex.c    | 15 ++++---
> >  kernel/locking/ww_mutex.h | 20 ++++-----
> >  kernel/sched/core.c       | 45 +++++++++++++++++--
> >  kernel/sched/sched.h      |  6 ++-
> >  7 files changed, 146 insertions(+), 38 deletions(-)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index cb4e81d9d9b67..8245940783c77 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -813,6 +813,12 @@ struct kmap_ctrl {
> >  #endif
> >  };
> >
> > +enum blocked_on_state {
> > +     BO_RUNNABLE,
> > +     BO_BLOCKED,
> > +     BO_WAKING,
> > +};
>
> I am still struggling with all this.

My apologies. I really appreciate you taking the time to look it over!

>   RUNNABLE is !p->blocked_on
>   BLOCKED is !!p->blocked_on
>   WAKING is !!p->blocked_on but you need magical beans
>
> I'm not sure I follow the argument above, and there is a distinct lack
> of comments with this enum explaining the states (although there are
> some comments scattered across the patch itself).

That's fair. I'll try to improve the comments there.

So the blocked_on_state values don't quite match to blocked_on as you
listed above, but it did evolve out of the fact that just having the
blocked_on pointer didn't give us enough state and had lots of subtle
bugs, so having more state helped stabilize this. I do agree it has
some duplicative aspects with the task->__state, so I'd love to
flatten it down, but so far I've not found a good way.

So p->blocked_on can be separated off, as is totally managed by the
__mutex_lock_common() path. It's set to the mutex we're trying to
take, and cleared when we get it.

Where as the p->blocked_on_state tells us:
BO_RUNNABLE: If the task was picked from the runqueue it can be run on that=
 cpu.
BO_BLOCKED: The task can be picked, but cannot be executed, it can
only be a donor task. It may migrate to the runqueue of cpus that it
is not allowed to run on.
BO_WAKING: An intermediate "gate" state. This task was BO_BLOCKED, and
we'd like it to be BO_RUNNABLE, but we have to address that it might
be on a runqueue it can't run on. So this prevents tasks from being
run until they have been evaluated for return migration.  Ideally ttwu
will handle the return migration, but there are cases where we will do
it manually in find_proxy_task() if we come across a task in the chain
with this state.

So, just to clarify your summary, the a task can be
p->blocked_on_state=3DBO_RUNNABLE and p->blocked_on can be set, since we
need to run the task in order for it to complete __mutex_lock_common()
to clear its own blocked_on pointer.  BO_BLOCKED does imply
!!p->blocked_on and BO_WAKING implies !!p->blocked_on but also that we
need to evaluate return migration before we run it.

> Last time we talked about this:
>
>   https://lkml.kernel.org/r/20241216165419.GE35539@noisy.programming.kick=
s-ass.net
>
> I was equally confused; and suggested not having the WAKING state by
> simply dequeueing the offending task and letting ttwu() sort it out --
> since we know a wakeup will be coming our way.

So yeah, and I really appreciated that suggestion. I used that dequeue
and wake approach in the "manual" return-migration path
(proxy_force_return()), and it did simplify things, but I haven't been
able to apply it everywhere.

> I'm thinking that suggesting didn't work out somehow, but I'm still not
> sure I understand why.

So the main issue is about where we end up setting the task to
BO_WAKING (via set_blocked_on_waking()). This is done in
__mutex_unlock_slowpath(), __ww_mutex_die(), and __ww_mutex_wound().
And in those cases, we are already holding the mutex->wait_lock, and
sometimes a task's blocked_lock, without the rq lock.  So we can't
just grab the rq lock out of order, and we probably shouldn't drop and
try to reacquire the blocked_lock and wait_lock there.

Though, one approach that I just thought of would be to have a special
wake_up_q call, which would handle dequeuing the blocked_on tasks on
the wake_q before doing the wakeup?  I can give that a try.

Though I'm not sure if that will still enable us to drop the
blocked_on_state tri-state. Since I worry we may be able to get
spurious wakeups on blocked_on tasks outside the mutex_unlock_slowpath
or ww_mutex_die/wound paths. Then we risk running a proxy-migrated
task on a cpu outside its affinity set. As without proxy-migration,
spurious wakeups are ok as the task will just loop back into schedule,
but with proxy migration, we have to be sure we return migrate first.

> There is this comment:
>
>
> +               /*
> +                * If a ww_mutex hits the die/wound case, it marks the ta=
sk as
> +                * BO_WAKING and calls try_to_wake_up(), so that the mute=
x
> +                * cycle can be broken and we avoid a deadlock.
> +                *
> +                * However, if at that moment, we are here on the cpu whi=
ch the
> +                * die/wounded task is enqueued, we might loop on the cyc=
le as
> +                * BO_WAKING still causes task_is_blocked() to return tru=
e
> +                * (since we want return migration to occur before we run=
 the
> +                * task).
> +                *
> +                * Unfortunately since we hold the rq lock, it will block
> +                * try_to_wake_up from completing and doing the return
> +                * migration.
> +                *
> +                * So when we hit a !BO_BLOCKED task briefly schedule idl=
e
> +                * so we release the rq and let the wakeup complete.
> +                */
> +               if (p->blocked_on_state !=3D BO_BLOCKED)
> +                       return proxy_resched_idle(rq);
>
>
> Which I presume tries to clarify things, but that only had me scratching
> my head again. Why would you need task_is_blocked() to affect return
> migration?

So task_is_blocked() returns true when p->blocked_on is set and
p->blocked_on_state !=3D BO_RUNNABLE.  So BO_WAKING tasks are still
prevented from being selected to run, until they have had a chance to
be return-migrated (because as a donor they may be on a runqueue where
they can't actually run on).

The problem this comment tries to describe is that due to ww_mutexes,
there may be a loop in the blocked_on chain. So the cpu running
find_proxy_task() might spin following this loop. The ww_mutex logic
will fix the loop via ww_mutex_die/wound, which sets BO_WAKING, and
wakes the task up to release the lock.   However, the try_to_wake_up()
can get stuck waiting for the rqlock that the cpu looping in
find_proxy_task() is holding. So for the case where it's not
BO_BLOCKED, we resched_idle for a moment to drop the lock and let
try_to_wake_up() complete.

Though I worry I've just repeated the comment here, so let me know if
this wasn't helpful in clarifying things.

thanks
-john

