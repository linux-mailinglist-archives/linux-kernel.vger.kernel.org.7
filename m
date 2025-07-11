Return-Path: <linux-kernel+bounces-726716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAFDB0105B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C0E5C3CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493CDC2E0;
	Fri, 11 Jul 2025 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8wN4cuP"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A5CBA2D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752194633; cv=none; b=UzXyUddHwdKPv6htLxRrAEus/bmcrOQU2uynI/tYVu8OvPEL75N5xFRQvD+HczPOz0ZcPqUZ/U1ovuIgSBbqkKGMYf+I7eudWWMiY4ba/Ixbjz696wWcHuPihyicE9K/LeNyTOCESziKeSA/eVBLNICusmd0h4buyuzEiEn+CpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752194633; c=relaxed/simple;
	bh=oW9kU6nDbGpijB7+R84uDXbm/Jg1CH40oB8z+tw9YfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iw+W6h4M9y7oxJHXNH7wuWYQ7rZO0Ci6d91wSXTWz9AIKZDl39Xcv05mOiALddwof1mJegJuz7h6VCOf6gm9b66E19Gt9k2LORh/bGEzIF6wSw6zBDtWUUA95H+2NctDimROKzeK4Lwtn/wqhfytU8VLsybAwXzeBauyvLBzN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8wN4cuP; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so3074817e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752194630; x=1752799430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23tH3kwK2zNscloHV19jl2g2diFMNT71zfU8iSYG6vU=;
        b=R8wN4cuPXZHTxqY+Fwypd/QwqaSsT6rHdSo3ZwJ3aPU6pgaE3pq9pErgwLN2LO6oki
         PfeujBIAbbe7BvguDX3AD7t2HPwLnVSQHXR/3EJvM1pVKlibFqAjYbV54wf0e8mNhY29
         ZQpEtAtuRoOTN28K3rXhIdaFqA5qgPRqcW54pk1Phn+UFsFPJz/PHmRC5Zv96aHA5tlt
         dFsr7ufg5Kq5rx51yd1zcjRMTQubzfFvqZcD5LdmtzbL+A0emDwrdf9tFfZ9+178fzCi
         5d+4DdC7cmGQW0BBMvSH5cI8nLl1raKiz5Rs+wxiOO1k2UaXcAEfs1T92KaYLrXGX4EM
         g5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752194630; x=1752799430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23tH3kwK2zNscloHV19jl2g2diFMNT71zfU8iSYG6vU=;
        b=J89AXaN5DGlL/oJWoFftMQHlhI9MNZgpPHU+qyD96uefT529Fx2zg73IRXVHybud6d
         lE7XmZkC+zYL8ybgrSd9NjYmRQuSGx0h2DM8LHFvhdgpwwwoWmDeVBHm8tcXG3wR1PCK
         LjcwD2jZfhLA26PWRdd2rVmVM38k+FVQ970MG36eLIbNEk+po3Jv39K1iVTSHlLP09vm
         7yQu9p4VWoUjh3DZhjUM7mRtJo+tzQ55UUdZHQqwSUkj7DR9VPPxJR3ktDUfhIFrGL8i
         d8CRkWHl1tH2RgNHCzK7k6/B80BzGnnyJNUlH3Hro5XrZCdSkeTCD92TcZ6C0Id58EPP
         J7bQ==
X-Gm-Message-State: AOJu0YxQH8qVAUGZUMnfk+w2GfNVd/OIc3aWufpGQnWUOiF6T1Mb+95w
	jVN5PQGicnqSUgLxy7Q59J34RJ0UL4x8AIj75iHwukJ0jFIPdRSrYzN0pyVHTUf6xr34pUpjRXi
	fJYrkl6n4KH5pXkVch0+V4acu0C9tKCt2hg/8V4c=
X-Gm-Gg: ASbGnct5hRaPCpr+d2mjqfxwn8MGOPWBmz/n0S2+7b4XuKntILaQxE3GDHb5neLFLIn
	2ziQpAa9UQOw7O1RqqcyfXV9Ep2/m8XyGuPunsOmAh8IgENrALs0Ojwk4TohLCdTbs2Z7/hChSR
	5slpKhV7TLsp+EQF4gYK1A32mqSEAOdgU5Bcykqs2VNJh7PxikDd2A2LEon2rOH9h/laEi0h6cx
	voEvgiGTiIzj8qXZnXqj4vl1DSSVr1+p+UB8dffdRQ9dUM=
X-Google-Smtp-Source: AGHT+IGU9Ey8P0KeI+8cEqXOwz6jralfEtszA60a6H3id2VcfyEPxqsNUCIHIPRE/2KpIvtjCoPiEJWqWriCO2RsRjc=
X-Received: by 2002:a05:6512:12cd:b0:553:cc61:170d with SMTP id
 2adb3069b0e04-55a039d5886mr377534e87.21.1752194629450; Thu, 10 Jul 2025
 17:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707204409.1028494-1-jstultz@google.com> <20250707204409.1028494-7-jstultz@google.com>
 <20250710100206.GI1613376@noisy.programming.kicks-ass.net>
In-Reply-To: <20250710100206.GI1613376@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Thu, 10 Jul 2025 17:43:36 -0700
X-Gm-Features: Ac12FXxPEEjWiGjFGMFjErIKrz4ZKAwzThrg6OhTyISwJW6qt3raTRYfntNX9ZA
Message-ID: <CANDhNCoMvY0s0AyePNouWqxdRpXCYJE=28E_b8RdmJ_2px_OBA@mail.gmail.com>
Subject: Re: [RESEND][PATCH v18 6/8] sched: Add an initial sketch of the
 find_proxy_task() function
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
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

On Thu, Jul 10, 2025 at 3:02=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> On Mon, Jul 07, 2025 at 08:43:53PM +0000, John Stultz wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 853157b27f384..dc82d9b8bee2c 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6614,7 +6614,8 @@ pick_next_task(struct rq *rq, struct task_struct =
*prev, struct rq_flags *rf)
> >   * Otherwise marks the task's __state as RUNNING
> >   */
> >  static bool try_to_block_task(struct rq *rq, struct task_struct *p,
> > -                           unsigned long *task_state_p)
> > +                           unsigned long *task_state_p,
> > +                           bool deactivate_cond)
> >  {
> >       unsigned long task_state =3D *task_state_p;
> >       int flags =3D DEQUEUE_NOCLOCK;
> > @@ -6625,6 +6626,9 @@ static bool try_to_block_task(struct rq *rq, stru=
ct task_struct *p,
> >               return false;
> >       }
> >
> > +     if (!deactivate_cond)
> > +             return false;
> > +
> >       p->sched_contributes_to_load =3D
> >               (task_state & TASK_UNINTERRUPTIBLE) &&
> >               !(task_state & TASK_NOLOAD) &&
>
> I'm struggling with this; @deactivate_cond doesn't seem to adequately
> cover what it actually does.
>

So initially, there was just this extra logic to exit early if the
prev task was blocked_on so we don't deactivate it (keeping it on the
rq). However, in cases (later in the series) where we later decide to
bail on proxying and just deactivate the task even if we are
blocked_on, I wanted to re-use this for that fallback case, so passing
the !blocked_on state as an argument (which could be forced to true
when we bail) made sense to me. Thus a "deactivation condition".

> So far what it seems to do is when true, don't block. It still does the
> signal thing -- but I can't tell if that is actually required or not.

So, preserving the signal check seemed important, as if we do get a
signal we probably want to make sure we don't deactivate and that the
task so it can be selected to run.
I'm curious as to your thinking that makes you skeptical that it is require=
d?

That said, I appreciate you raising the question, as looking at and
thinking about it some more, I do see that we should be clearing the
blocked_on state when we do set ourselves as runnable in that case,
otherwise if we are blocked_on we might get stuck waiting for a wakeup
(likely from the lock release).

I'll fix that up here.

> Would 'should_block' be a better name? And maybe stick a little
> something in the comment above try_to_block_task() or near the:
>
>         if (!should_block)
>                 return false;
>
> lines about why the signal bits are important to have done.

Sure, I'm happy to use that if should_block is more clear. I'll try to
add some better comments as well.

>
> > @@ -6648,6 +6652,89 @@ static bool try_to_block_task(struct rq *rq, str=
uct task_struct *p,
> >       return true;
> >  }
> >
> > +#ifdef CONFIG_SCHED_PROXY_EXEC
> > +static inline struct task_struct *proxy_resched_idle(struct rq *rq)
> > +{
> > +     put_prev_set_next_task(rq, rq->donor, rq->idle);
> > +     rq_set_donor(rq, rq->idle);
> > +     set_tsk_need_resched(rq->idle);
> > +     return rq->idle;
> > +}
>
> Nothing cares about the return value.

Well, nothing in this patch, but the last patch in this series I sent
here uses it.  But if you think it makes the series easier to grok and
I can drop it here and add the return in that later patch.

Thanks so much again for the review and feedback! I really appreciate it!
-john

