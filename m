Return-Path: <linux-kernel+bounces-890816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61958C41074
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF644189FB02
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3248F3346AE;
	Fri,  7 Nov 2025 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYbR19Hz"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AEC333758
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536264; cv=none; b=cQAQpzyzUUdS5n4SsGpK3DxzNHAuVrpbQ+wyDK2rNTOhU5COoK6KRH5E0dNZTTQMRbAleZ5bEb+n13/YShtOHp5ylucfJkrkuCA+EJ0kdsl2Y5Zn8VHnuJUcmBjZ6sab5RR2leKcAtoJPwDUlyebu3L8U/j47Gd7m/v9EhdkylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536264; c=relaxed/simple;
	bh=AlQPvxeTWsW6Hz0xZBVZ7BIgT45M5nsaeb4ujq7+qBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/NHjN/jtsrmWF0FeyvrIw8S+2GIH+gN3J0f7JULKGsXyl5CNYieKvxNA6QZq1oHhGjtBhhDvh1FHLs7OSJWG0hMDQYrud+WfpWd3XvAk7S5zOgu5nTHvZbvKdEq1bXmCzlFzeBFUbQxwHlJGEbnEkqZMyijuFnkfZwYVR7Wkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gYbR19Hz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640e9a53ff6so1962575a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762536261; x=1763141061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnS25iCFOS3ovWTIrIeDxR8HEFggFuUwFd6B+OJUBA8=;
        b=gYbR19HzxZT4xkJURiTy7lh+2zrcFVhfU9JYH2jTN/dXlfVNsjvtdj9wWCGV4sos1x
         pdFOn8VdLGwuAKNbf1dp/lNa7E4SoIbEziX2rqinGKiAoXc3W8a/Gs028w9EhUbsWkd2
         GiYH7GC2oxrmHNnM6aOcAHrEXamy+GfKoaBvWQF6BPXkgiJSJUmS3gyvddLp/P7IZmB+
         QyuvFeGNIabbnsYuhgUfHeSFQXGZJxhN+4ICc2bOxee3IvLvIgb4QIYzV70RtQt7fqQu
         QYEaMT5/Mi8xqrOPsnMPmNuVjD+VFdJOA1BoTSAFNQXcpFCajwLA6NYgA4eoH37IVPvY
         WMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762536261; x=1763141061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QnS25iCFOS3ovWTIrIeDxR8HEFggFuUwFd6B+OJUBA8=;
        b=rbokgVPY/bgg538I6/7PAY6UBXCMuQfoJ6NPoVd/XtOAtOvJtBbVk8eIpvY4UQiG60
         ibiMxq7szdN9uGcFNrihcWdg44D/NZy/Dfd7atB7EE3s9n+XSaqI7qVtTB7gataD9eWt
         xJpjBevBNvr1mMnkQNKbCr4lQvawOpcolhpYS3LjVCXc9gMGLlIerz0d0L5UwHnAzvrV
         cLKhWGLsm417AQ6ptQWc88I6oklh1t3h3Put/6In7eTeR4/zJpkhOTusFcjMCefwqLtt
         wNDoPoBe26Ep/TMhHUrju0NbrRaa451HVYBZDKzhw82YByll8bQ/h9xWzgJw2og1Te5u
         9QRg==
X-Gm-Message-State: AOJu0YyTReHxd3GUD97ljhBfS/mDpSVZgW17Ro2s1UQ7DJSWQby+QM+a
	BZWTU+OsBRI4IZ1t7MZE2+4KbzivhBOsPN8ZPblOj2wbknTzBqhVH1EmIneg0cz7bCzBRylaElD
	6ix1XLQ2X6Nri75URuktIgTj2wpPlhgMUPJwGj/c=
X-Gm-Gg: ASbGncvubB15ddokp8ZQMGC8nqVgFItZPgUVF11toOF5XOJZ6SNji77L3egoY83SaUO
	sX2qbzBo+yX3Z1e05udi375GyO/sm2wDg6LbvXz5LIi/3FnjDWraTxEU5iIp6/37G3VhRL6aY5e
	Xy/4Xp8Wkuf4h/wcMNfGVQPzGcDnxzgY3E2IU0NVLkp9ZWn5XqeXRmfCOEUkd2kAmZVtPgeyeoI
	eWwYI+LezX/Ua/iviWCzvDMlx0wSFXaB72al8q/fxX3xy4Jo5QqUDekfeBQ0uY71c5Qun7Kp9J5
	TQVQ7JQ33tdE5LI5vA==
X-Google-Smtp-Source: AGHT+IER8m14wbp3nvaGgeGxNvCD+sCkJgkPy3QG3Ozx5JlNqGV7U1EWQOMfVzq1oGsghRpa8Iq9nPMDZHVP/KzwMGE=
X-Received: by 2002:a17:907:3e9f:b0:b6d:505e:3da1 with SMTP id
 a640c23a62f3a-b72e036bbf6mr5469766b.7.1762536260496; Fri, 07 Nov 2025
 09:24:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030001857.681432-1-jstultz@google.com> <20251030001857.681432-7-jstultz@google.com>
 <aQ4OAn0bugNVv1bA@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <aQ4OAn0bugNVv1bA@jlelli-thinkpadt14gen4.remote.csb>
From: John Stultz <jstultz@google.com>
Date: Fri, 7 Nov 2025 09:24:08 -0800
X-Gm-Features: AWmQ_bm-ajffiy_WQk5Td8yQhfxzNvWkA-qZVPXvdH_5r7KCMzGXP-nG2Fsmk4U
Message-ID: <CANDhNCpL+3dwSDV_yDfcpW66i2jGwjDF42RW+kKg7XmXLESwzw@mail.gmail.com>
Subject: Re: [PATCH v23 6/9] sched: Handle blocked-waiter migration (and
 return migration)
To: Juri Lelli <juri.lelli@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
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

On Fri, Nov 7, 2025 at 7:19=E2=80=AFAM Juri Lelli <juri.lelli@redhat.com> w=
rote:
> On 30/10/25 00:18, John Stultz wrote:
> > +#ifdef CONFIG_SCHED_PROXY_EXEC
> > +static inline void proxy_set_task_cpu(struct task_struct *p, int cpu)
> > +{
> > +     unsigned int wake_cpu;
> > +
> > +     /*
> > +      * Since we are enqueuing a blocked task on a cpu it may
> > +      * not be able to run on, preserve wake_cpu when we
> > +      * __set_task_cpu so we can return the task to where it
> > +      * was previously runnable.
> > +      */
> > +     wake_cpu =3D p->wake_cpu;
> > +     __set_task_cpu(p, cpu);
> > +     p->wake_cpu =3D wake_cpu;
> > +}
> > +#endif /* CONFIG_SCHED_PROXY_EXEC */
> > +
>
> ...
>
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
> > +     proxy_set_task_cpu(p, target_cpu);
>
> We use proxy_set_task_cpu() here. BTW, can you comment/expand on why an
> ad-hoc set_task_cpu() is needed for proxy?

Since with proxy, we keep blocked waiters on the runqueue,
proxy-migrations may move those lock waiters to cpu runqueues where
they can't run. Ideally when the mutex is released, we want the waiter
to wake up on the same cpu it would have woken on if it has been
blocked.  So for proxy-migrations, we want to preserve the wake_cpu
value when we change the task_cpu.

For instance, if we were proxy-migrated as a donor to a cpu outside of
our affinity set, we don't want the wake_cpu hint to suggest that we
should be woken on a cpu we can't run on.

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
> > +     cpu =3D select_task_rq(p, p->wake_cpu, &wake_flag);
> > +     set_task_cpu(p, cpu);
>
> But, then use the 'standard' set_task_cpu() for the return migration. Is
> that intended?

Yep. On return migration, we want the task to be returned to the
runqueue it would have woken on (which wake_cpu provides a hint, but
select_task_rq can always choose somewhere else more appropriate).
Once the cpu has been selected, it's then fine if the wake_cpu is then
set to cpu the task now being assigned to.

thanks
-john

