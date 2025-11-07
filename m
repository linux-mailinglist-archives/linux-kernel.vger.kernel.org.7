Return-Path: <linux-kernel+bounces-891139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A63D5C41ECF
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 00:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C682E4E8FA0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 23:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ECE30AD0B;
	Fri,  7 Nov 2025 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pr6BI/GF"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FC530AAA9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 23:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762557528; cv=none; b=Te+bVNTh20qe8l90myDWqXE/GuDcF1OTptxSZ4SeKg+ZNHA7pqLqaQa2MnkH0zSU37z21wmXmtJYJnbQRNeiXzOX2LmIddhxvb9uwPrArR0fmaFlpOTWjSZLdo9IeiP8DDluuaEva92aTK9F9AO2rsHSktXQxVmydRxvuz1zGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762557528; c=relaxed/simple;
	bh=98QPetegaAqnwxhrMwgTTx/hGmwTOaJosxM/zyb4Dw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+0dqAd5n15xb3nuzJijHsJ6WxSzifZaoKaMibZAXlZwvNbDSTk4pjyNxMadlvCiJ/Qfcm3MQshv4h3U43+yLpLsBfdb5LPQws+kn2LlOwBEXw34UwAM5kN2YGaVNvq/lZbhRoPB0uDQlhVBp19nWPo9Nf375mNTWk9afNJ1xnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pr6BI/GF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b72cbc24637so221458166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 15:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762557524; x=1763162324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7V119aqift6WVySRcUTDMClCXuDJ1R+JHALENnuo80A=;
        b=Pr6BI/GFWDzfUi+tA3OwIs3jOzuaw2LiUgrAETeaTRNUDs6kxga+Ja3pgYQFue8Nr6
         QD2H42nNdAg2Npu6gUbngay2c25/sReNks0jt0DTvDkV07U1nE8Z29vxje62dAAOCqpM
         IUnqCRUs+sq2JhwV105RMRWlLOygYAI0zdv+Xdw9+VLfRPChYY2YrO1jQ+sGxFFkXPsG
         g+bzRa9UaPLdPCMSeRhiGBsmLy9zAN0H11BD11yee+3a8r+BPOGkGB5ZIvs9SKhuxEO5
         DhIbPXsgtSG4KaFGJiQReZEDjh+CBiDJAOfJA3RnGpxKTNBVkmvEBN+uZkpkn/6T3gx0
         TvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762557524; x=1763162324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7V119aqift6WVySRcUTDMClCXuDJ1R+JHALENnuo80A=;
        b=kwURj6fcgrCOcQFE84Gl4xPh95QDWLDSBy5E1XWucSFRgP8JsZ2usZ1sZCEGGgr5GY
         3uLsYd1wAJHRs+CV2Um2WZ5AN46UyEJgbjTaaBKgFjLNuxp0aDksuyIuo0UY70BJtX+H
         Wo7vXTO53yvBJ/2oqtCh9deAxEz66WUyUXCsWFJmWoc/Q/04mKOp2Pop+hnfKWizz7hu
         1ipb16X+hTZoPjTOMl5abv8YTmsk/+iXWAzMvUTCkHXRZtYSGRlucQPUw0Fng6dqwy8E
         FdHSEJUA8LCFoZR0JhmI7C9UQ4VRGPsGpkdEaGxRPjAXoUJVuqIJALdnu+HLUuOTH5Gt
         JiTA==
X-Gm-Message-State: AOJu0YyrWzGeNMiAIz7jdGjMqXtvwrLYyrS7bMdUfhGpSbvC0IkXmCnC
	oKqlTi3KB1jV9k9HZWxkYx/v04xl8rntsdSidbY1JSURQMIGnfcMJMn2dgXHSa+22b+hv9oOlsS
	NujioEHCemFX0AFyxZBm5sVGmU/hBsB7XzpyJZxU=
X-Gm-Gg: ASbGncv3gL+mfViMC4cmWIV9H6nxPPWBbdGTQDUuqI0HJ80Kp7+dUIZ6fZCtViG9z67
	VUcW4OcwYJ+a+W0BnK10HN4pMdZKCQkJZVv8VwnBSlKxgfRouAocnk4TOkpIwnm7aRiAz8ruk+g
	ITwXV55vro4hLUt7jBLfjcQIvYj0k0fKeIxfy4ZDKRlJZ0TIJBSnXDMZO3SW0ZDO/J38yzkyk07
	wvSgQLE2YQkmrqyW701lAq7Ug22YG2IqhYwgnjoh6Q/VChUPgdaVY08s6Mg5H3t/EvF3t+WIVO1
	OZzzggcwzeuzSSg234hkcFcx8HI/
X-Google-Smtp-Source: AGHT+IEY9OjER3fEw+jaJBuYIf9du6d8okT6EAaQ5rQXON9zFAmAwW3M3dxO+NbxnjNiYz09TsxN4wsC3WJ0r05hfmA=
X-Received: by 2002:a17:906:eecb:b0:b70:6d3a:a08b with SMTP id
 a640c23a62f3a-b72e02d3b61mr101061266b.10.1762557524026; Fri, 07 Nov 2025
 15:18:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030001857.681432-1-jstultz@google.com> <20251030001857.681432-7-jstultz@google.com>
 <0c337bca-4ecf-4654-9256-df766573c7de@amd.com>
In-Reply-To: <0c337bca-4ecf-4654-9256-df766573c7de@amd.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 7 Nov 2025 15:18:32 -0800
X-Gm-Features: AWmQ_bkm8O4zYmttV-wP4c0zaLcHZV-SrU5sgtTNzs1nMBBexkfzbn7AIS2HixM
Message-ID: <CANDhNCpOdnmC+dB+uwt82XrxFuzx72d+5w1j21eFovSeFr8pDw@mail.gmail.com>
Subject: Re: [PATCH v23 6/9] sched: Handle blocked-waiter migration (and
 return migration)
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

On Thu, Oct 30, 2025 at 2:33=E2=80=AFAM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
> On 10/30/2025 5:48 AM, John Stultz wrote:
> > -static struct task_struct *proxy_deactivate(struct rq *rq, struct task=
_struct *donor)
> > +/*
> > + * If the blocked-on relationship crosses CPUs, migrate @p to the
> > + * owner's CPU.
> > + *
> > + * This is because we must respect the CPU affinity of execution
> > + * contexts (owner) but we can ignore affinity for scheduling
> > + * contexts (@p). So we have to move scheduling contexts towards
> > + * potential execution contexts.
> > + *
> > + * Note: The owner can disappear, but simply migrate to @target_cpu
> > + * and leave that CPU to sort things out.
> > + */
> > +static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
> > +                            struct task_struct *p, int target_cpu)
> >  {
> > -     if (!__proxy_deactivate(rq, donor)) {
> > -             /*
> > -              * XXX: For now, if deactivation failed, set donor
> > -              * as unblocked, as we aren't doing proxy-migrations
> > -              * yet (more logic will be needed then).
> > -              */
> > -             clear_task_blocked_on(donor, NULL);
> > +     struct rq *target_rq =3D cpu_rq(target_cpu);
> > +
> > +     lockdep_assert_rq_held(rq);
> > +
> > +     /*
> > +      * Since we're going to drop @rq, we have to put(@rq->donor) firs=
t,
> > +      * otherwise we have a reference that no longer belongs to us.
> > +      *
> > +      * Additionally, as we put_prev_task(prev) earlier, its possible =
that
> > +      * prev will migrate away as soon as we drop the rq lock, however=
 we
> > +      * still have it marked as rq->curr, as we've not yet switched ta=
sks.
> > +      *
> > +      * So call proxy_resched_idle() to let go of the references befor=
e
> > +      * we release the lock.
> > +      */
> > +     proxy_resched_idle(rq);
> > +
> > +     WARN_ON(p =3D=3D rq->curr);
> > +
> > +     deactivate_task(rq, p, 0);
>
> DEQUEUE_NOCLOCK since we arrive here with the clock updated from
> schedule().

Ah, good point.

> > +     proxy_set_task_cpu(p, target_cpu);
> > +
> > +     /*
> > +      * We have to zap callbacks before unlocking the rq
> > +      * as another CPU may jump in and call sched_balance_rq
> > +      * which can trip the warning in rq_pin_lock() if we
> > +      * leave callbacks set.
> > +      */
> > +     zap_balance_callbacks(rq);
> > +     rq_unpin_lock(rq, rf);
> > +     raw_spin_rq_unlock(rq);
> > +     raw_spin_rq_lock(target_rq);
> > +
> > +     activate_task(target_rq, p, 0);
> > +     wakeup_preempt(target_rq, p, 0);
> > +
> > +     raw_spin_rq_unlock(target_rq);
> > +     raw_spin_rq_lock(rq);
> > +     rq_repin_lock(rq, rf);
>
> We should perhaps update the clock once we've reacquired the rq_lock
> given we are going into schedule() again for another pick.

No objection to adding this, though I wonder why I'm not hitting the
usual warnings. I'll have to think through that a bit.


> > +static void proxy_force_return(struct rq *rq, struct rq_flags *rf,
> > +                            struct task_struct *p)
> > +{
> > +     struct rq *this_rq, *target_rq;
> > +     struct rq_flags this_rf;
> > +     int cpu, wake_flag =3D 0;
> > +
> > +     lockdep_assert_rq_held(rq);
> > +     WARN_ON(p =3D=3D rq->curr);
> > +
> > +     get_task_struct(p);
> > +
> > +     /*
> > +      * We have to zap callbacks before unlocking the rq
> > +      * as another CPU may jump in and call sched_balance_rq
> > +      * which can trip the warning in rq_pin_lock() if we
> > +      * leave callbacks set.
> > +      */
> > +     zap_balance_callbacks(rq);
> > +     rq_unpin_lock(rq, rf);
> > +     raw_spin_rq_unlock(rq);
> > +
> > +     /*
> > +      * We drop the rq lock, and re-grab task_rq_lock to get
> > +      * the pi_lock (needed for select_task_rq) as well.
> > +      */
> > +     this_rq =3D task_rq_lock(p, &this_rf);
> > +     update_rq_clock(this_rq);
>
> I think we can delay the clock update until proxy_resched_idle().

You're thinking just to avoid it if we trip into the error paths?  Sounds g=
ood.


> > +
> > +     /*
> > +      * Since we let go of the rq lock, the task may have been
> > +      * woken or migrated to another rq before we  got the
> > +      * task_rq_lock. So re-check we're on the same RQ. If
> > +      * not, the task has already been migrated and that CPU
> > +      * will handle any futher migrations.
> > +      */
> > +     if (this_rq !=3D rq)
> > +             goto err_out;
> > +
> > +     /* Similarly, if we've been dequeued, someone else will wake us *=
/
> > +     if (!task_on_rq_queued(p))
> > +             goto err_out;
> > +
> > +     /*
> > +      * Since we should only be calling here from __schedule()
> > +      * -> find_proxy_task(), no one else should have
> > +      * assigned current out from under us. But check and warn
> > +      * if we see this, then bail.
> > +      */
> > +     if (task_current(this_rq, p) || task_on_cpu(this_rq, p)) {
> > +             WARN_ONCE(1, "%s rq: %i current/on_cpu task %s %d  on_cpu=
: %i\n",
> > +                       __func__, cpu_of(this_rq),
> > +                       p->comm, p->pid, p->on_cpu);
> > +             goto err_out;
> >       }
> > -     return NULL;
> > +
> > +     proxy_resched_idle(this_rq);
> > +     deactivate_task(this_rq, p, 0);
>
> This should add DEQUEUE_NOCLOCK since we've already updated the rq clock
> before the call.

Ack.


> > +     cpu =3D select_task_rq(p, p->wake_cpu, &wake_flag);
> > +     set_task_cpu(p, cpu);
> > +     target_rq =3D cpu_rq(cpu);
> > +     clear_task_blocked_on(p, NULL);
> > +     task_rq_unlock(this_rq, p, &this_rf);
> > +
> > +     /* Drop this_rq and grab target_rq for activation */
> > +     raw_spin_rq_lock(target_rq);
> > +     activate_task(target_rq, p, 0);
> > +     wakeup_preempt(target_rq, p, 0);
> > +     put_task_struct(p);
> > +     raw_spin_rq_unlock(target_rq);
> > +
> > +     /* Finally, re-grab the origianl rq lock and return to pick-again=
 */
> > +     raw_spin_rq_lock(rq);
> > +     rq_repin_lock(rq, rf);
> > +     return;
> > +
> > +err_out:
> > +     put_task_struct(p);
> > +     task_rq_unlock(this_rq, p, &this_rf);
>
> I believe as long a we have the task_rq_lock(), the task cannot
> disappear under us but are there any concern on doing a
> put_task_struct() and then using the same task reference for
> task_rq_unlock()?

Yeah. Seems proper to do it the way you're suggesting.


> > +     raw_spin_rq_lock(rq);
> > +     rq_repin_lock(rq, rf);
>
> Probably a clock update once we reacquire the rq_lock since we
> go into schedule() again to retry pick?
>

Ack.


> > @@ -6689,26 +6834,41 @@ find_proxy_task(struct rq *rq, struct task_stru=
ct *donor, struct rq_flags *rf)
> >                       return NULL;
> >               }
> >
> > +             if (task_current(rq, p))
> > +                     curr_in_chain =3D true;
> > +
> >               owner =3D __mutex_owner(mutex);
> >               if (!owner) {
> >                       /*
> > -                      * If there is no owner, clear blocked_on
> > -                      * and return p so it can run and try to
> > -                      * acquire the lock
> > +                      * If there is no owner, either clear blocked_on
> > +                      * and return p (if it is current and safe to
> > +                      * just run on this rq), or return-migrate the ta=
sk.
> >                        */
> > -                     __clear_task_blocked_on(p, mutex);
> > -                     return p;
> > +                     if (task_current(rq, p)) {
> > +                             __clear_task_blocked_on(p, NULL);
> > +                             return p;
> > +                     }
> > +                     action =3D NEEDS_RETURN;
> > +                     break;
> >               }
> >
> >               if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) =
{
>
> Should we handle task_on_rq_migrating() in the similar way?
> Wait for the owner to finish migrating and look at the
> task_cpu(owner) once it is reliable?

Hrm. I'm not quite sure I understand your suggestion here. Could you
expand a bit here? Are you thinking we should deactivate the donor
when the owner is migrating? What would then return the donor to the
runqueue? Just rescheduling idle so that we drop the rq lock
momentarily should be sufficient to make sure the owner can finish
migration.

As always, I really appreciate your review and feedback!
Thanks so much!
-john

