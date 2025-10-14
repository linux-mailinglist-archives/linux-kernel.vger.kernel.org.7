Return-Path: <linux-kernel+bounces-851713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B0EBD71E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0838A406FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998163054E3;
	Tue, 14 Oct 2025 02:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l7T4mUH7"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E324E4D4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760409808; cv=none; b=jvQfYjsobnnatxP3LSyxat/nNGBMSvCTOWI+Jq5CNrIHOSUImtTRO4Xfs/Wxb9iipeF6k+ICXK7butqmkDeFE0LZdIJr1XirHYarJU3n8CudX/z1cCcp/jbEQdBpa4C2gvQRt+rzRnHKxiWb24xvjFAqhKWMnQhrD4LnIaRJLrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760409808; c=relaxed/simple;
	bh=ip6YWN7Qo0CgUpDyrhVBNBHnXEoOS4KyxEnCNliffP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOinQ/hZqcViNjRBAk8dpiBNm5hRMODZ4NWV2s9O1TjowSwFks6JiMyqWZ0B5lm0pAZIVy5Uw87nfJHyKqg/N3mM3G0aR6mK52Drdwm/UI+f7nHqmW8EpgAyD360DcJQXsnxNhkIAzr268/nHZy9BFQLrgUdZJmsk1FHXv7dGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l7T4mUH7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so692653666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760409805; x=1761014605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iN7xUJ1bHWP0TUEbAdhfTAOsne8D5XNfdYjEqPKRfO8=;
        b=l7T4mUH7iROuNjVUXLi3PW34Ozrill1PoktwK2YEP6pHUbsk0inayGm0647GZjeiEo
         hXtFAKrSvjuH90NTssL+u05/ZlgoBd/K6mPuLpUB+tsmSQe3JBEV/XQl97D1wE5O0mWX
         mpGQbsR8WkpRqeFTssOJKD89Fe6VwKl/lu1u7qHqFvkAFZARMI/ZZrZD749vgMHsRjRn
         hAWxQy5Dy/KGCdu1ibP23WxXgJkd7DcDhoSWtpzPMxNQDgcGvAVFos83caHjPEnV7a4+
         zXimmLFdIIIAAPNgay40PzKTYPORdLvzYmvyW40+NZeYJvHcQmT1vRjcAcd6P7p0X7pi
         qdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760409805; x=1761014605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iN7xUJ1bHWP0TUEbAdhfTAOsne8D5XNfdYjEqPKRfO8=;
        b=aulFYRyOre4SmCI8sBdnJIsh9USagiPVQqyjITCglpZMB+5brfMyj13eAVXOaUHdMb
         BQUfbeW/3RC69kT9ATa3wuYQHpVddxbFri1m45Aib8uk0kqfkTqrEytqGrPZXh0T1hrz
         lgERWL7DBCSu7HT4Vvt2NtoyqF4sKIetCIwZKtwTYU6W2uxee8dqVbe0ZrUAI9c/Ohve
         bCqxW+PCxR68ldPOSmzTc+3ZdnnMwQjGAOeM/em547cdMI+wkUuVv/NqzuW88I2/zsdp
         J3mVom69DI71Z6bvEgvXe8dQ4Huawr3ke2DhLNrzZfhdtv47V3LpUG9gH6jS03XT859l
         G49A==
X-Gm-Message-State: AOJu0Yy5JSNSCkixuBm79nfS4AJAw92ONbFsiVqVDdLd785Nk96i9qs6
	ASPRwygC/LdZZGR9XZNAyc1ZW4E+G3h+7hBWBrI3J7l1i0IsJlkgUrdnPRje/EBivnoHnOpXl7Q
	dO80XS/TtnE/4h1Pz39xhETtoe+MPlgUFDWDlKijVNbJBRv4YQJjUmfQ=
X-Gm-Gg: ASbGncsJWMJjqdjKfcJrlTrwaMRZ4PEswR5ssU3jMJDdU+4I0BOjFir/9BijaF+nT/C
	yQGAZVh3IGpPJ4JrfkIE82WlmPDz+GYreA+t3SwVNqXuVJm+whqIMGCXm1XZjlHLKhBV4Mo/ov5
	dzGRVJekYTbV+kwjbl1mBZHk5SoH99GektsBE9q2SrD/wPqGxCy9XKMSaapOkJ0sVqO7qnCBmFx
	/gNETjASUOZf8O3z2D6CMniEfQw8LoP56RaTV+vintzIC4NSFD7MAwjh6Jo9T0SR/Nb4/Dq
X-Google-Smtp-Source: AGHT+IFP0mI+SPGlE20pZONAs3hrj14G6ynAopJU7b1E6RpzrHIzs7nelbS4U2r2Q+pXnpsY76KmufXhepz1wX0c4ic=
X-Received: by 2002:a17:907:72d4:b0:b3b:110c:d343 with SMTP id
 a640c23a62f3a-b50aa492035mr2297014566b.8.1760409804811; Mon, 13 Oct 2025
 19:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926032931.27663-1-jstultz@google.com> <20250926032931.27663-3-jstultz@google.com>
 <20251008112603.GU3419281@noisy.programming.kicks-ass.net>
 <CANDhNCpSNyOkcuUZvpZK5FQhL8oxQEax2wUStdRAV_ns2z7n_A@mail.gmail.com> <20251009114302.GI3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20251009114302.GI3245006@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Mon, 13 Oct 2025 19:43:12 -0700
X-Gm-Features: AS18NWBkjfBSNwa60noLe6gbBQG1h4VcgHZpn7-gKIO6Yix0c_3TUwj4WoemY3o
Message-ID: <CANDhNCp6TPcfzJLCU-o-xScfoeCqMzYjVhGyDa23YjAqiMnA0w@mail.gmail.com>
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

On Thu, Oct 9, 2025 at 4:43=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
> On Wed, Oct 08, 2025 at 05:07:26PM -0700, John Stultz wrote:
>
> > > I'm thinking that suggesting didn't work out somehow, but I'm still n=
ot
> > > sure I understand why.
> >
> > So the main issue is about where we end up setting the task to
> > BO_WAKING (via set_blocked_on_waking()). This is done in
> > __mutex_unlock_slowpath(), __ww_mutex_die(), and __ww_mutex_wound().
> > And in those cases, we are already holding the mutex->wait_lock, and
> > sometimes a task's blocked_lock, without the rq lock.  So we can't
> > just grab the rq lock out of order, and we probably shouldn't drop and
> > try to reacquire the blocked_lock and wait_lock there.
>
> Oh bugger. In my head the scheduler locks still nest inside wait_lock,
> but we've flipped that such that schedule() / find_proxy_task() can take
> it inside rq->lock.
>
> Yes that does complicate things.
>
> So suppose we have this ww_mutex cycle thing:
>
>                   ,-+-* Mutex-1 <-.
>         Task-A ---' |             | ,-- Task-B
>                     `-> Mutex-2 *-+-'
>
> Where Task-A holds Mutex-1 and tries to acquire Mutex-2, and
> where Task-B holds Mutex-2 and tries to acquire Mutex-1.
>
> Then the blocked_on->owner chain will go in circles.
>
>         Task-A  -> Mutex-2
>           ^          |
>           |          v
>         Mutex-1 <- Task-B
>
> We need two things:
>
>  - find_proxy_task() to stop iterating the circle;
>
>  - the woken task to 'unblock' and run, such that it can back-off and
>    re-try the transaction.
>
>
> Now, the current code does:
>
>         __clear_task_blocked_on();
>         wake_q_add();
>
> And surely clearing ->blocked_on is sufficient to break the cycle.
>
> Suppose it is Task-B that is made to back-off, then we have:
>
>   Task-A -> Mutex-2 -> Task-B (no further blocked_on)
>
> and it would attempt to run Task-B. Or worse, it could directly pick
> Task-B and run it, without ever getting into find_proxy_task().
>
> Now, here is a problem because Task-B might not be runnable on the CPU
> it is currently on; and because !task_is_blocked() we don't get into the
> proxy paths, so nobody is going to fix this up.
>
> Ideally we would have dequeued Task-B alongside of clearing
> ->blocked_on, but alas, lock inversion spoils things.

Right. Thus my adding of the blocked_on_state to try to gate the task
from running until we evaluate it for return migration.

> > Though, one approach that I just thought of would be to have a special
> > wake_up_q call, which would handle dequeuing the blocked_on tasks on
> > the wake_q before doing the wakeup?  I can give that a try.
>
> I think this is racy worse than you considered. CPU1 could be inside
> schedule() trying to pick Task-B while CPU2 does that wound/die thing.
> No spurious wakeup required.

Yeah. I took a bit of a try at it, but couldn't manage to rework
things without preserving the BO_WAKING guard.

Then trying to do the dequeue in the wake_up_q() really isn't that far
away from just doing it in ttwu() a little deeper in the call stack,
as we still have to take  task_rq_lock() to call block_task().

> Anyway, since the actual value of ->blocked_on doesn't matter in this
> case (we really want it to be NULL, but can't because we need someone to
> go back migrate the thing), why not simply use something like:
>
> #define PROXY_STOP ((struct mutex *)(-1L))
>
>         __set_task_blocked_on(task, PROXY_STOP);
>
> Then, have find_proxy_task() fix it up?

Ok, so this sounds like it sort of matches the BO_WAKING state I
currently have (replacing the BO_WAKING state with PROXY_STOP). Not
much of a logic change, but would indeed save a bit of space.
I'll take a stab at it.

> Random thoughts:
>
>  - we should probably have something like:
>
>         next =3D pick_next_task();
>         rq_set_donor(next)
>         if (unlikely(task_is_blocked()) {
>                 ...
>         }
> +       WARN_ON_ONCE(next->__state);
>
>    at all times the task we end up picking should be in RUNNABLE state.
>
>  - similarly, we should have ttwu() check ->blocked_on is NULL ||
>    PROXY_STOP, waking a task that still has a blocked_on relation can't
>    be right -- ooh, dang race conditions :/ perhaps DEBUG_MUTEX and
>    serialize on wait_lock.
>
>  - I'm confliced on having TTWU fix up PROXY_STOP; strictly not required
>    I think, but might improve performance -- if so, include numbers in
>    patch that adds it -- which should be a separate patch from the one
>    that adds PROXY_STOP.

Ok, I'll work to split that logic out. The nice thing in ttwu is we
already end up taking the rq lock in ttwu_runnable() when we do the
dequeue so yeah I expect it would help performance.

>  - since find_proxy_task() can do a lock-break, it should probably
>    re-try the pick if, at the end, a higher runqueue is modified than
>    the task we ended up with.

So, I think find_proxy_task() will always pick-again if it releases
the rqlock.  So I'm not sure I'm quite following this bit. Could you
clarify?

>    Also see this thread:
>
>       https://lkml.kernel.org/r/20251006105453.522934521@infradead.org
>
>    eg. something like:
>
>         rq->queue_mask =3D 0;
>         // code with rq-lock-break
>         if (rq_modified_above(rq, next->sched_class))
>                 return NULL;
>
>
> I'm still confused on BO_RUNNABLE -- you set that around
> optimistic-spin, probably because you want to retain the ->blocked_on
> relation, but also you have to run that thing to make progress. There
> are a few other sites that use it, but those are more confusing still.

Mostly I liked managing the blocked_on_state separately from the
blocked_on pointer as I found it simplified my thinking in the mutex
lock side, for cases where we wake up and then loop again. But let me
take a pass at reworking it a bit like you suggest to see how it goes.

> Please try and clarify this.

Will try to add more comments to explain.

> Anyway, if that is indeed it, you could do this by (ab)using the LSB of
> the ->blocked_on pointer I suppose (you could make PROXY_STOP -2).

One complication for using the LSB of the pointer, Suleiman was
thinking about stealing those for extending the blocked_on pointer for
use with other lock types (rw_sem in his case).
Currently he's got it in a structure with an enum:
  https://github.com/johnstultz-work/linux-dev/commit/e61b487d240782302199f=
6dc1d99851c3449b547

But we talked a little about potentially squishing that together, but
it sort of depends on how many primitive types we end up using
proxy-exec with.

As always, thanks again for all the feedback, I really appreciate it!
-john

