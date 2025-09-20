Return-Path: <linux-kernel+bounces-825458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1537DB8BD83
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 04:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1B25666B0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5EB1F4C96;
	Sat, 20 Sep 2025 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjvlRjvr"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3AD1A9F84
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758335915; cv=none; b=hgrSIsNrPmgQmk6+49oibeepBHshlzcfoQBcmbJetkFhsPSiPa8KtRa11OoqJJyHNzllpu+LBVpjgjt4EUmFNRcqlRL95UpoU5r96H0fFpwC8sQl3oEI6wDIF1LPZv6NluxTb/rDvKKSZtNmuBmKRByVmuXemN/zfeFWE9PjjJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758335915; c=relaxed/simple;
	bh=2XmR7vn25TBpMbjrM39voGEyF+zmY/uDMJUnx5Zsp1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXLB8r4o7ByiW89HirYFsHrrAMgpvsOibTQopJWhqm94zdh+x1S6b2rmwmDyBh5bOQjFuUY/bQVbgq5e4UWfD6cbOgMwCnWI6iswYjSEzqtwx1rjUkAFHgEr4otFfUE9jlIE7A9VA1kaHVmFVyBhVhIOkccfOE0omGemtZG0Zvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wjvlRjvr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57992ba129eso2158771e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758335912; x=1758940712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I16QWu7vmn07Xgp2BoTE382or22Ps9XzkOSN2Arkwdw=;
        b=wjvlRjvrxcM6qYB3awFbYD9oLVlU+0tCHW33KIPaw91kamg1+w+n3bhWNmGD9CyP30
         3EBxMDQvtXfd5fVIVB0wTQFZaUfsdrvncfIA9VP0sqiJrSCRAECPMTUbsLeayisINnOM
         riIf/BRFevtcn+2VTOIcrEiXAylufP1tunDi3FZ/4TpZkGABDrMxpOpQOW9/k/HDuKBw
         i28PKMd7yB1FsxbWdzKZEP1AiYeZQZQnTfNarwTEyDDVUxW3MfAYok/mBLEj5WNoCIzd
         jF/Dp5raoRaP3Zz/R3hWwHIvlWjoyRpFVQWS7ybRVYgwKiLE9s0Xg/9t+5QEJpq4f9OS
         2kTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758335912; x=1758940712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I16QWu7vmn07Xgp2BoTE382or22Ps9XzkOSN2Arkwdw=;
        b=B5aittVebPH8YVca3/B3DHECFhSuo95XkEf89QRJRqVGC8t+Gu+mTNAPdOPtwnMbeg
         2Jcv5enmU9KbENzQHSmo1UOgf5MLY/nnt5AxV9+aR9rekCNgerFctX/vC5OxdzTuJoWt
         +uOl6PRc/lUhOkquarsE2pSDVxNcXACetblqZuh0HDILeuyMlfLVGps6UOnA11kQwE+l
         VQNyvedY0meOdyIRUDqUJpVxw71qaVQYaeSYfJbou3Kg08R9vDf8ZrVdkQhWMNi0FePX
         Se3WjLiPimzxWV+d/rPW5VyuQUSG8nGrdCS3+2JQ7QxieM+OBN4wqclaZLroaAgS3bYV
         JBCA==
X-Gm-Message-State: AOJu0YyoIQ5FdHOiEeohkzw2he+mltlAgOzX3N5rwkaPD/x648I+nyLx
	3Wh/FvXa8/eyP1ucQ31bXAXYstNvyUGcpkE7TmkAXW9VSvvmHQSnjwd69vSIQx9uuBBEHqk4eA6
	wgv08652/Acfyrs0ijpzxm9fKQUP7HZmVcX0eB2E=
X-Gm-Gg: ASbGncufur+795xtXSUxPSUJX8VsbdaheZvo51Q1ArOrSZx4MvvMwOAn/6gxFYDvFry
	jE3Ey+yDFSEW7mqV5520plZ/IU9Okk/PfTdIprinRKB7YEVxkShxLNykhP+r2MhBhcjwrbfNR6Y
	Lk+d6T6zPvx36AqQRKGfqiwPcw9XSQwXY+jwpOZaFE3U02QEXDoCVKEIQrPlltDbYG4GZLR37Ew
	imUUU7S0xJzr8YuLhi9e+ihBrH4HhRYxyHPHJYW6fLAkq8=
X-Google-Smtp-Source: AGHT+IHt/qtMkbvpBk2mbntfOMS9jGQAs+1JdlX+vhtmEYyC61xxGbVJWGCbIIcPI+yNXpUhBWkPFcdFs4CihjPR3DM=
X-Received: by 2002:a05:6512:2447:b0:579:fb2b:d280 with SMTP id
 2adb3069b0e04-579fb2bd2e8mr1576046e87.42.1758335911685; Fri, 19 Sep 2025
 19:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904002201.971268-1-jstultz@google.com> <20250904002201.971268-5-jstultz@google.com>
 <befadd44-9549-4400-ab28-b8aef55cd73d@amd.com>
In-Reply-To: <befadd44-9549-4400-ab28-b8aef55cd73d@amd.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 19 Sep 2025 19:38:20 -0700
X-Gm-Features: AS18NWCWXvNOUnRYwOBrqyyURcrEOOXugpodTfiYl7MyxK3j312wfe9boijHX2k
Message-ID: <CANDhNCphG8LzYEM321fXpg4xCXL8kqfKbtttV-HN+e1tZCGahQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v21 4/6] sched: Handle blocked-waiter migration
 (and return migration)
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

On Mon, Sep 15, 2025 at 3:07=E2=80=AFAM 'K Prateek Nayak' via kernel-team
<kernel-team@android.com> wrote:
> On 9/4/2025 5:51 AM, John Stultz wrote:
> > +     /* XXX - Added to address problems with changed dl_server semanti=
cs - double check */
> > +     __put_prev_set_next_dl_server(rq, rq->donor, rq->curr);
>
> Given we are tagging the rq->dl_server to the donor's context, should we
> do:
>
>     __put_prev_set_next_dl_server(rq, rq->donor, rq->idle);
>
> ... since we are setting rq->idle as next task and the donor?
>
> On a side note, this can perhaps be simplified as:
>
>     put_prev_set_next_task(rq, rq->donor, rq->idle);
>     rq_set_donor(rq, rq->idle);
>
> put_prev_set_next_task() will take are of the dl_server handoff too.

Nice! That is simpler. I think I can also simplify those two lines to
proxy_resched_idle() as well.
And looking, the big comment above that section needs an update as
well as its out of date.

> > +     put_prev_task(rq, rq->donor);
> > +     rq_set_donor(rq, rq->idle);
> > +     set_next_task(rq, rq->idle);
> > +
> > +     WARN_ON(p =3D=3D rq->curr);
> > +
> > +     deactivate_task(rq, p, 0);
> > +     proxy_set_task_cpu(p, target_cpu);
> > +
> > +     zap_balance_callbacks(rq);
>
> Is this zap necessary? Given we return NULL from find_proxy_task() for
> migrate case, __schedule() would zap the callback soon. I don't see
> any WARN_ON() for the balance callbacks in the unpin + repin path so
> this might not be necessary or am I mistaken?

So unfortunately the issue is that when we're letting go of the
runqueue other CPUs can jump in via sched_balance_domains()  ->
sched_balance_rq() -> rq_lock_irqsave() -> rq_pin_lock() which will
trip the
WARN_ON_ONCE(rq->balance_callback && rq->balance_callback !=3D
&balance_push_callback); case if we leave callbacks.

So we need to zap the callbacks before we drop the rq lock.  I'll add
a comment to make that clear.

And yeah, that means we do call zap_balance_callbacks() again after we
re-take the lock and return null.

I guess we could remove the zap_balance_callbacks() call in
__schedule() and instead call it in every case where find_proxy_task()
returns NULL? Or we call it twice in the migration paths, as it should
just have one entry the second time.


> > +static void proxy_force_return(struct rq *rq, struct rq_flags *rf,
> > +                            struct task_struct *p)
> > +{
> > +     lockdep_assert_rq_held(rq);
> > +
> > +     put_prev_task(rq, rq->donor);
> > +     rq_set_donor(rq, rq->idle);
> > +     set_next_task(rq, rq->idle);
>
> Similar set of comments as above.

Ack.

> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index b173a059315c2..cc531eb939831 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8781,7 +8781,8 @@ pick_next_task_fair(struct rq *rq, struct task_st=
ruct *prev, struct rq_flags *rf
> >       se =3D &p->se;
> >
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> > -     if (prev->sched_class !=3D &fair_sched_class)
> > +     if (prev->sched_class !=3D &fair_sched_class ||
> > +         rq->curr !=3D rq->donor)
>
> Why is this special handling required?

Hrmm.. that's a good question, as I haven't thought about that in
awhile, and I'm unfortunately forgetful. My instinct is that its a
concern that by checking the prev sched class is fair, is assuming the
prev task was selected by the fair scheduler's pick_next_task last
time around. But since we may have picked a blocked RT task as donor,
if we are proxying, we can't assume prev was previously chosen by
pick_next_task_fair(). So we skip the optimization just to be careful.

But this may be overly cautious and looking it over I don't
immediately see it as necessary. So I'll drop it and do some thorough
testing without it. If I do find an issue I'll re-add it with a much
better comment so I don't forget again.  I do really appreciate you
checking me here!

thanks
-john

