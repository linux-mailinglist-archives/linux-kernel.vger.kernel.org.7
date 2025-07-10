Return-Path: <linux-kernel+bounces-726234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1646B009DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61CD644811
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC29F2F0C4E;
	Thu, 10 Jul 2025 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dd/t06aT"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C29F22423A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168364; cv=none; b=IoCLfKC1Xt5fpWz5O83ty0B9IPjwlb1sA3ZwEoXNrdmvkXTpKHINRlq6PqYsknkaAyl+wGzIb/+HlqsUOEGpHx6NdW6O1LmI62l3uIFkN0BeFShn8OjL70os7x6BA7XL/tHfL1VLAdEPyGT0iRiQi3aC0RSF8GQsiz6H1JpXsAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168364; c=relaxed/simple;
	bh=tzDXk6u+RlViWI30RVTu4uk6ty3gLvfXd5xOxEJPV8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D00F15ar/y1KZhrpEw8VGbnAz35KzwB5/Z55ksMK/vJsb1fYVek+s/tyq9wc5VD9akC0QUXQc1g8YlDlnmWKoPZJDnS0fJj6Qh+YBNooTrd8ZN1WVaaHM0hX3C8W72P3mMLDQU62zOG6y/hyfJL7Webs64r9sjQZd97UegEVedk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dd/t06aT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5561d41fc96so1417471e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752168361; x=1752773161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4oifSR1VKcg7ZmfxEDKXOIn2uGV/Zoj6PakeK/6RzM=;
        b=dd/t06aTBptEhXOKJFcV/8IPmDeaNfVxQC9wZc1CaI0/71wn036WV3pahYYAJCuy+b
         U0gNz8Ahrupzhc6ix/1tHUoMFtAr7klauXPTZ5shuM/TFiE33VE8OkiRj0weldRel7tE
         UKqQZuIeAJt6CYS0u5UW9k6H2ayJotnlFfpJh9upvPGsesvyhM4mYWCxW8+h8BNrz6iu
         YE7UBWyTHeJZC/fjDr1LsB86cygad0sVxR6WgvfvYr8xRwXPCofMNP6T3sw6KqIWpSd0
         1fs0oCGU+CiWe8PqLe0e/VUXDxRfJ4LbLLA8pPySV0rly5cy8EHYI0uvQoEoHooJjAQF
         JwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752168361; x=1752773161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4oifSR1VKcg7ZmfxEDKXOIn2uGV/Zoj6PakeK/6RzM=;
        b=P/cJR4CypISjDOn2bcy0AqqwIWgOwZHfSqqybfh/WGxaQ2vcW6kajffnCDuXmCTicY
         4IW35QqzZxx+SkhfwabewHrrk9LbsdinUSdThr6CncEKwdf49CsZ2OKETZaV4tQgterQ
         2kFvKgW3UDOTB9IyyzdFGT1cTQG4OESqezhmD697/P2qs0cX1BPUKF84u+H6cR/o0f2D
         9g9Edb5Ur4tqRIwgas3XBl9SEO2r6oCvWXp43mqQwJ7MKK4638owLvaFXeihXrxjUzoX
         50Ki0BKHWFcaQrXq05ey7dl/0+gKiQ1wTSHcshigfaYVAs822hTIOeTA7o5nONc2ob6c
         AvcA==
X-Gm-Message-State: AOJu0Yx+S5xBglOcjawIaIUO0wiTfSW+eJea6VrYQMs44Pg9x7MHwmbx
	S0XRdnKVgT1EdW/LrLN+UkWXI1ImexyQ+4VAIE7Hb9MsT0MI8iWOqo6KprOh5Xoi8li3sLbQoD8
	8lSKMKfDBg/Qbff0rGwhRtJ7oeVMgfyhE0/ZhlgNEka0EPO7NKQLU
X-Gm-Gg: ASbGnctq8+M/TwEjNDtzOs+3CrC/sFraISAxfW3wFoIfdr3XVBnhKANLcfqJ+XCcOuK
	YnKEGfcT3nKd/r9btSuBUEVd/kg4znXJbKCiPeBPRhtPluMCE4He1GJD2sgF38RHbDELEURVvp0
	pnDoY5X5ccgZbVg2sPz3bmNpGOnk0FDUC6jQ4n5MxLN8rGywNyDYY3v1ASA35zfiRDAYF2A0J9
X-Google-Smtp-Source: AGHT+IELbwRSkORSRjnIsWojdPOjPoAhkOJqUrUf1vx6VqeIsoCXhNMaxozhrNJsu5Wujge906h8x43tXxSH5F6/fHk=
X-Received: by 2002:a05:6512:224a:b0:553:3028:75bd with SMTP id
 2adb3069b0e04-55935b36fa3mr1450818e87.49.1752168359664; Thu, 10 Jul 2025
 10:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707204409.1028494-1-jstultz@google.com> <20250707204409.1028494-6-jstultz@google.com>
 <20250710094506.GH1613376@noisy.programming.kicks-ass.net>
In-Reply-To: <20250710094506.GH1613376@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Thu, 10 Jul 2025 10:25:46 -0700
X-Gm-Features: Ac12FXyI9kJAqV7ZW8Pa09kPhZ7Dykrzx9C9LzmRJFkRw2miVH18w1DdVrtWh5Y
Message-ID: <CANDhNCo0u4bdvMxCpoDaZtFFJw5s2KJU=FOeho116p_8LujAfA@mail.gmail.com>
Subject: Re: [RESEND][PATCH v18 5/8] sched: Fix runtime accounting w/ split
 exec & sched contexts
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

On Thu, Jul 10, 2025 at 2:45=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> On Mon, Jul 07, 2025 at 08:43:52PM +0000, John Stultz wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index edcc7d59ecc3b..c34e0891193a7 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1143,30 +1143,40 @@ static void update_tg_load_avg(struct cfs_rq *c=
fs_rq)
> >  }
> >  #endif /* CONFIG_SMP */
> >
> > +static s64 update_se(struct rq *rq, struct sched_entity *se)
> >  {
> >       u64 now =3D rq_clock_task(rq);
> >       s64 delta_exec;
> >
> > +     delta_exec =3D now - se->exec_start;
> >       if (unlikely(delta_exec <=3D 0))
> >               return delta_exec;
> >
> > +     se->exec_start =3D now;
> > +     if (entity_is_task(se)) {
> > +             struct task_struct *donor =3D task_of(se);
> > +             struct task_struct *running =3D rq->curr;
> > +             /*
> > +              * If se is a task, we account the time against the runni=
ng
> > +              * task, as w/ proxy-exec they may not be the same.
> > +              */
> > +             running->se.exec_start =3D now;
> > +             running->se.sum_exec_runtime +=3D delta_exec;
> >
> > +             trace_sched_stat_runtime(running, delta_exec);
> > +             account_group_exec_runtime(running, delta_exec);
> >
> > +             /* cgroup time is always accounted against the donor */
> > +             cgroup_account_cputime(donor, delta_exec);
> > +     } else {
> > +             /* If not task, account the time against donor se  */
> > +             se->sum_exec_runtime +=3D delta_exec;
> >       }
>
> Bah.. this is all terrible :-) But yeah, I suppose this wil do.

Yeah, :/ I'm happy to rework it further if you have ideas.

> > @@ -1213,7 +1223,7 @@ s64 update_curr_common(struct rq *rq)
> >  {
> >       struct task_struct *donor =3D rq->donor;
> >
> > +     return update_se(rq, &donor->se);
> >  }
>
> At this point this might as well read:
>
>         return update_se(rq, &rq->donor->se);

Good point. Done.

Thanks so much for the review! I'll get the next iteration ready to go out =
soon.
-john

