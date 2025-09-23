Return-Path: <linux-kernel+bounces-828906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B8FB95CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266E51896F76
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACB2322DD4;
	Tue, 23 Sep 2025 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vxc/FUcS"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E93321F5A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629711; cv=none; b=JHLI5cfh/OQWLjek2H/jNQ6BujG9RovvKv/JQQCL6JkiJsLP28TGGB7m9+U/0tsj56vIjH2PxzRGsaB0pO2kolcbqrcAIMr0ldviN0h+Oi3AeAg/jVZwNjifEzlvc9cqQIMydY9vW3YKSwSI+w7W9jYJeL4C9Y+J3Fnrv/zSt5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629711; c=relaxed/simple;
	bh=VL15PO7hhNmjtKsemAXSnpq80smtAz+Fi2s2bevouwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UU0lDbQa400D1BcB4z+x/r/U85Z0aV6ZwD9XgcpXByMRgbeoLPRlDhB7mjKhI3UuBRS5ZMQiYNwuqsYTSTuhZ9BtzTq3k6wB4H+huUgvRjLVn6EE9P4CkRsz5wK4BM759uBhRPiLKR3wv+ijvwyv52fIwsNpbn7p+vvGtt70Vrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vxc/FUcS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b55197907d1so2869071a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758629708; x=1759234508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRGWz2OWIbh5vSUeQ4aINSMVrvTB34hL/QPr6iZ6Mqc=;
        b=vxc/FUcSYMWV6S+KvKjAQTVDUWfYRSi91IBIonnoKfIJYpMNhu1N3nkf2kWIwjQ/Yn
         HpYlcPTnpQti5JScyyOR2np9AnD3bkvpPJYR2guXBKFzTL4r8oHwXNpwZEDcTpYpSFc4
         MuuHAG9fc+XZyl2jxM6ERZqPM/d2sMsljgpubV9UJMrs6bN4TzTM3PtJPtulVOxCfz+H
         RkjxuM4mFDzSbM2CnTBueTDVrSg8HRNT6imyTvClPmGIcwmucQdPs4rg2KaX3Q+SFVZI
         2yVoFGii5MeEG6fKjNrerbvz6lt8LACC5nje/b1PpFinfqu6J0l+jRq3Qka67T6ZWy3o
         Ou3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758629708; x=1759234508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRGWz2OWIbh5vSUeQ4aINSMVrvTB34hL/QPr6iZ6Mqc=;
        b=in22W4TsREqLS13KraHDciOiExDW5/Dff8kS+hDXKeZbW1ekctM/GAV0bNxuAQjgZv
         4r2XSi+aUa9YRSXMJEO9vhY37QFdzdO0s8PMG7GwWt4nswVZ4YCyypt98peK1nIMoN4w
         L0JG54WqRiTTfjXCDUtveiJm9L3slGbO88c2mcrLxkJwRSI6gsxa1a+TWTesQTptjSrp
         XzGWJT6zZLlOwd627IbgRqKlZC3NO8NqzuazL0fUntoEV5FWaVtMkb78Y+Zy80Omvq2+
         eHC8i1x6oXZWRi8t1PjbgoBGsABZabHKlKE8XasEO9UOx+wPIlbwgNxNEHdlDUehLd8C
         PKoA==
X-Forwarded-Encrypted: i=1; AJvYcCUmywxfUPuyVnYeT7OecVjV57M81fPsA4h9T3U/41KozoYtlssh+AmDJi681JtNPo+Knt59VVJuvcZkUlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyccoWnMJmZB6nqaWI0ItMGFEcOYw2JqvSUvS3Du55oVE20JRo+
	7nKlRIdBSGUERonp4DrMSrXyYE7tinFL3f0PfE836C2nP5hJJ0yPzW351IhwsDehgudK9wVdiEw
	A9uej7n0Q0NwSZi7YP9Acczl7kcL3RJNsQHR3W4TsLA==
X-Gm-Gg: ASbGnctCywTVydwwC1b4bhl/TWzALus1Fx6qpv9l5ZFMrfQu4Pfm0Jk+KBLvL7mipbG
	WuFsQ0qaFAYd3mB89AksmsDl87SIAIib62tWzMFldnZpz9munk9FIqV0pqJQt0RZNE4fJFfY4qb
	D4KSEa68+IVyx9UgqJrN7hU/NwmJjzolUC/vI4adSQB0DwYayozySW9GLT+JyhPoMas8M8AKinY
	4mhrsGFiu6pmbQVYhfybA0GExgQ+XAXYWzIvq9+q4gdu+U=
X-Google-Smtp-Source: AGHT+IHYzfBi+3aUZbGMwqJyPh8cZb/BuH8tA/o+EK8ylfiKyqgZgiCLoLGLWTMGR0G35lS98onAQQd5ZM371jkHTG8=
X-Received: by 2002:a17:90b:5109:b0:32b:8b8d:c2c6 with SMTP id
 98e67ed59e1d1-332a950f797mr3033068a91.14.1758629707596; Tue, 23 Sep 2025
 05:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910084316.356169-1-hupu.gm@gmail.com> <CAKfTPtCyL=ofg4yLtfG7zsoBMDnP48KCeUELT_Hddd3gnWeYEw@mail.gmail.com>
 <CADHxFxTkexicChcg3To4=AsX8c+s2RNWZ5NfA9UBLMfYRZtmKg@mail.gmail.com> <CADHxFxQ2cg1pVOxx6VU7Z0D-Bo7EsJ6Vo2-qrgT+gF64mkhPGA@mail.gmail.com>
In-Reply-To: <CADHxFxQ2cg1pVOxx6VU7Z0D-Bo7EsJ6Vo2-qrgT+gF64mkhPGA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 23 Sep 2025 14:14:51 +0200
X-Gm-Features: AS18NWA1P9Uql9lfTOVKKeYIiIUDaPs-fFN68bCSsPdADsr0ClndH5I09R8cgcw
Message-ID: <CAKfTPtDCaTP_mX+5RKc9Xcw0m6ZxzyUk1FNPNjO1OOQ+zp_DkQ@mail.gmail.com>
Subject: Re: [RESEND][RFC] sched: Introduce removed.load_sum for precise load propagation
To: hupu <hupu.gm@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi hupu,

I have been busy with other stuff so far and haven't been able to look
at your reply but It's on my todo list.

Vincent

On Tue, 23 Sept 2025 at 13:17, hupu <hupu.gm@gmail.com> wrote:
>
> Hi Vincent Guittot and fellow maintainers,
>
> As I mentioned in my previous email, I think there may be a
> misunderstanding on your part regarding the modification in this
> patch.
>
> This change does *NOT* directly add `se->avg.load_sum` to
> `cfs_rq->avg.load_sum`. In the end, it will also *NOT* result in
> tracking both `load_avg` and `load_sum` simultaneously. My current
> preference is to retain `load_sum` and eventually deprecate
> `load_avg`, but only after we=E2=80=99ve confirmed through discussion tha=
t
> this approach is reasonable.
>
> The intent of this proposal lies in two key aspects, which I believe
> can improve the accuracy of `cfs_rq` load statistics:
> 1. Avoid using `runnable_avg` to approximate `load_sum`, as such
> approximations inherently introduce errors. Instead, recording the
> `load_sum` of the task at the time of dequeue is more reasonable.
> 2. Avoid the additional error introduced by right-shift operations.
>
> Could you please review the feasibility of this proposal again when
> you have time?
> Your feedback would be greatly appreciated.
>
> Thanks and best regards,
> hupu
>
> On Fri, Sep 12, 2025 at 2:44=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
> >
> > Hi Vincent Guittot
> > Thank you very much for your reply.
> >
> > On Thu, Sep 11, 2025 at 4:01=E2=80=AFPM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Wed, 10 Sept 2025 at 10:43, hupu <hupu.gm@gmail.com> wrote:
> > > >
> > > > Currently, load_sum to be propagated is estimated from
> > > > (removed_runnable * divider) >> SCHED_CAPACITY_SHIFT, which relies =
on
> > > > runnable_avg as an approximation. This approach can introduce preci=
sion
> > > > loss due to the shift operation, and the error may become more visi=
ble
> > > > when small tasks frequently enter and leave the queue.
> > >
> > > Do you have a level of error ? Do you have a typical use case ?
> > >
> >
> > In fact, I derived the error here from the underlying mathematical
> > relationship. The error mainly comes from two sources:
> > a) The approximation of load_sum using runnable_avg;
> > b) The truncation introduced by the right shift (SCHED_CAPACITY_SHIFT).
> >
> > Below is the detailed derivation and explanation.
> >
> > removed_runnable records the sum of se->avg.runnable_avg for tasks
> > that have migrated to another CPU. It represents the decayed
> > cumulative contribution of a task=E2=80=99s runtime, with the unit bein=
g
> > microseconds (=CE=BCs). Right-shifting by SCHED_CAPACITY_SHIFT (10 bits=
) is
> > equivalent to truncating the low part below 1024 =CE=BCs. In other word=
s,
> > if a task has accumulated less than 1024 =CE=BCs of runtime before
> > dequeueing, its load contribution will be completely discarded by the
> > shift operation. Even if the accumulated runtime exceeds 1024 =CE=BCs, =
the
> > shift may still introduce up to nearly 1024 =CE=BCs of truncation error
> > (about 1 ms).
> >
> > For example, suppose a task has accumulated 4095 =CE=BCs (4.095 ms) of
> > runtime on CPU0, then goes to sleep and is migrated to CPU1 upon
> > wakeup. Ideally, CPU0 should remove that task=E2=80=99s contribution fu=
lly.
> > However, after the shift, the result is 4095 >> 10 =3D 3 ms, which mean=
s
> > CPU0 will still retain about 1023 =CE=BCs (~=3D 1.023 ms) of the task=
=E2=80=99s
> > contribution.
> >
> > Experimental results also confirm this. By adding debug output before
> > add_tg_cfs_propagate and comparing the actual removed_load_sum (the
> > true value to be removed) with the approximate value obtained through
> > the shift, we observed that the latter is smaller in most cases. This
> > discrepancy is exactly due to the approximation and truncation
> > introduced by the shift.
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > old mode 100644
> > new mode 100755
> > index b173a059315c..92396da04520
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4561,7 +4561,8 @@ static void migrate_se_pelt_lag(struct
> > sched_entity *se) {}
> >  static inline int
> >  update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> >  {
> > -       unsigned long removed_load =3D 0, removed_util =3D 0, removed_r=
unnable =3D 0;
> > +       unsigned long removed_load_sum =3D 0, removed_load =3D 0;
> > +       unsigned long removed_util =3D 0, removed_runnable =3D 0;
> >         struct sched_avg *sa =3D &cfs_rq->avg;
> >         int decayed =3D 0;
> >
> > @@ -4572,6 +4573,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cf=
s_rq)
> >                 raw_spin_lock(&cfs_rq->removed.lock);
> >                 swap(cfs_rq->removed.util_avg, removed_util);
> >                 swap(cfs_rq->removed.load_avg, removed_load);
> > +               swap(cfs_rq->removed.load_sum, removed_load_sum);
> >                 swap(cfs_rq->removed.runnable_avg, removed_runnable);
> >                 cfs_rq->removed.nr =3D 0;
> >                 raw_spin_unlock(&cfs_rq->removed.lock);
> > @@ -4609,8 +4611,10 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *c=
fs_rq)
> >                  * removed_runnable is the unweighted version of
> > removed_load so we
> >                  * can use it to estimate removed_load_sum.
> >                  */
> > -               add_tg_cfs_propagate(cfs_rq,
> > -                       -(long)(removed_runnable * divider) >>
> > SCHED_CAPACITY_SHIFT);
> > +               trace_printk("DEBUG BYHP: removed_load_sum=3D%lu,
> > raw_removed_runnable_sum=3D%lu\n",
> > +                               (long)removed_load_sum,
> > +                               (long)((removed_runnable * divider) >>
> > SCHED_CAPACITY_SHIFT));
> > +               add_tg_cfs_propagate(cfs_rq, -(long)removed_load_sum);
> >
> >                 decayed =3D 1;
> >         }
> > @@ -4792,6 +4796,7 @@ static void remove_entity_load_avg(struct
> > sched_entity *se)
> >         ++cfs_rq->removed.nr;
> >         cfs_rq->removed.util_avg        +=3D se->avg.util_avg;
> >         cfs_rq->removed.load_avg        +=3D se->avg.load_avg;
> > +       cfs_rq->removed.load_sum        +=3D se->avg.load_sum;
> >         cfs_rq->removed.runnable_avg    +=3D se->avg.runnable_avg;
> >         raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
> >  }
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index be9745d104f7..659935a5c694 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -682,6 +682,7 @@ struct cfs_rq {
> >         struct {
> >                 raw_spinlock_t  lock ____cacheline_aligned;
> >                 int             nr;
> > +               unsigned long   load_sum;
> >                 unsigned long   load_avg;
> >                 unsigned long   util_avg;
> >                 unsigned long   runnable_avg;
> >
> > The logs are as follows: raw_removed_runnable_sum is often smaller
> > than removed_load_sum. This difference is exactly caused by the
> > approximate calculation and the truncation introduced by bit shifting.
> >
> >    stress-ng-cpu-183     (-------) [001] dnh1.   144.338335:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D35463,
> > raw_removed_runnable_sum=3D35429
> >    stress-ng-cpu-184     (-------) [007] dNs1.   144.346203:
> > sched_balance_update_blocked_averages: DEBUG BYHP:
> > removed_load_sum=3D20607, raw_removed_runnable_sum=3D20496
> >    stress-ng-cpu-185     (-------) [001] d.h1.   144.568803:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
> > raw_removed_runnable_sum=3D0
> >    stress-ng-cpu-183     (-------) [000] d.h1.   145.526897:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D11103,
> > raw_removed_runnable_sum=3D11072
> >    stress-ng-cpu-183     (-------) [000] d.h1.   145.563980:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
> > raw_removed_runnable_sum=3D0
> >    stress-ng-cpu-185     (-------) [002] d..2.   145.593563:
> > sched_balance_update_blocked_averages: DEBUG BYHP: removed_load_sum=3D0=
,
> > raw_removed_runnable_sum=3D0
> >    stress-ng-cpu-181     (-------) [005] d.s1.   145.653525:
> > sched_balance_update_blocked_averages: DEBUG BYHP:
> > removed_load_sum=3D2537, raw_removed_runnable_sum=3D2508
> >    stress-ng-cpu-183     (-------) [003] d.s1.   145.657599:
> > sched_balance_update_blocked_averages: DEBUG BYHP:
> > removed_load_sum=3D28510, raw_removed_runnable_sum=3D28473
> >    stress-ng-cpu-180     (-------) [007] d.h1.   146.049167:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D9548,
> > raw_removed_runnable_sum=3D9526
> >    stress-ng-cpu-184     (-------) [005] d.h1.   146.057200:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D5974,
> > raw_removed_runnable_sum=3D5963
> >    stress-ng-cpu-182     (-------) [000] d.s1.   146.062025:
> > sched_balance_update_blocked_averages: DEBUG BYHP:
> > removed_load_sum=3D55, raw_removed_runnable_sum=3D45
> >       kcompactd0-65      (-------) [001] d..2.   146.095334:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
> > raw_removed_runnable_sum=3D0
> >       kcompactd0-65      (-------) [001] d..2.   146.095433:
> > sched_balance_update_blocked_averages: DEBUG BYHP:
> > removed_load_sum=3D17493, raw_removed_runnable_sum=3D17461
> >    stress-ng-cpu-186     (-------) [006] d.h1.   146.118910:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D11404,
> > raw_removed_runnable_sum=3D11389
> >    stress-ng-cpu-186     (-------) [000] d.h1.   147.112614:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
> > raw_removed_runnable_sum=3D0
> >              cat-234     (-------) [005] d.s2.   147.161900:
> > sched_balance_update_blocked_averages: DEBUG BYHP:
> > removed_load_sum=3D36778, raw_removed_runnable_sum=3D36768
> >    stress-ng-cpu-181     (-------) [004] d.h1.   147.406979:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D3029,
> > raw_removed_runnable_sum=3D3014
> >    stress-ng-cpu-185     (-------) [003] d.s1.   147.474502:
> > sched_balance_update_blocked_averages: DEBUG BYHP:
> > removed_load_sum=3D1242, raw_removed_runnable_sum=3D1205
> >    stress-ng-cpu-186     (-------) [000] d.h1.   147.533368:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D11,
> > raw_removed_runnable_sum=3D0
> >    stress-ng-cpu-181     (-------) [001] d.s1.   148.341639:
> > sched_balance_update_blocked_averages: DEBUG BYHP:
> > removed_load_sum=3D15837, raw_removed_runnable_sum=3D15804
> >      migration/7-51      (-------) [007] d..2.   148.384219:
> > sched_balance_update_blocked_averages: DEBUG BYHP: removed_load_sum=3D0=
,
> > raw_removed_runnable_sum=3D0
> >           <idle>-0       (-------) [004] d.s2.   148.431501:
> > sched_balance_update_blocked_averages: DEBUG BYHP:
> > removed_load_sum=3D4292, raw_removed_runnable_sum=3D1924
> >              cat-234     (-------) [007] d.h1.   148.434474:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D10380,
> > raw_removed_runnable_sum=3D9945
> >    stress-ng-cpu-184     (-------) [001] d.h1.   148.853949:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D15896,
> > raw_removed_runnable_sum=3D15869
> >    stress-ng-cpu-185     (-------) [007] d.s1.   148.862267:
> > sched_balance_update_blocked_averages: DEBUG BYHP:
> > removed_load_sum=3D31, raw_removed_runnable_sum=3D0
> >    stress-ng-cpu-183     (-------) [006] d.h1.   149.157805:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D20553,
> > raw_removed_runnable_sum=3D20527
> >    stress-ng-cpu-179     (-------) [007] d.h1.   149.330189:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D9204,
> > raw_removed_runnable_sum=3D9177
> >    stress-ng-cpu-185     (-------) [002] d.h1.   149.434768:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D11198,
> > raw_removed_runnable_sum=3D11176
> >           <idle>-0       (-------) [006] dNs2.   149.456004:
> > sched_balance_update_blocked_averages: DEBUG BYHP:
> > removed_load_sum=3D2826, raw_removed_runnable_sum=3D465
> >    stress-ng-cpu-184     (-------) [005] d.s1.   149.483636:
> > sched_balance_update_blocked_averages: DEBUG BYHP:
> > removed_load_sum=3D11607, raw_removed_runnable_sum=3D11595
> >    stress-ng-cpu-186     (-------) [001] d.h1.   149.668063:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
> > raw_removed_runnable_sum=3D0
> >           <idle>-0       (-------) [001] d.h2.   149.672477:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
> > raw_removed_runnable_sum=3D0
> >    stress-ng-cpu-183     (-------) [007] d.s1.   149.684045:
> > sched_balance_update_blocked_averages: DEBUG BYHP:
> > removed_load_sum=3D5657, raw_removed_runnable_sum=3D5458
> >      ksoftirqd/1-22      (-------) [001] d.s1.   149.700089:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
> > raw_removed_runnable_sum=3D0
> >    stress-ng-cpu-183     (-------) [004] d.h1.   149.807666:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D10481,
> > raw_removed_runnable_sum=3D10474
> >    stress-ng-cpu-184     (-------) [000] d.h1.   149.817148:
> > update_load_avg: DEBUG BYHP: removed_load_sum=3D3,
> > raw_removed_runnable_sum=3D0
> >           <idle>-0       (-------) [001] d.s2.   149.866309:
> > sched_balance_update_blocked_averages: DEBUG BYHP:
> > removed_load_sum=3D4010, raw_removed_runnable_sum=3D3999
> >    stress-ng-cpu-184     (-------) [000] d.s1.   149.914423:
> > sched_balance_update_blocked_averages: DEBUG BYHP:
> > removed_load_sum=3D1920, raw_removed_runnable_sum=3D1876
> >
> >
> >
> >
> > > >
> > > > This patch introduces removed.load_sum to directly accumulate
> > > > se->avg.load_sum when tasks dequeue, and uses it during load
> > > > propagation. By doing so:
> > > >
> > > >   a) Avoid relying on runnable_avg-based approximation and obtain
> > > >      higher precision in load_sum propagation;
> > > >   b) Eliminate precision loss from the shift operation, especially
> > > >      with frequent short-lived tasks;
> > > >   c) Reduce one multiplication and shift in the hotpath, which
> > > >      theoretically lowers overhead (though the impact is minor).
> > >
> > > This doesn't work because rq's load_sum tracks current weight whereas
> > > se's load_sum doesn't include the weight which is only applied on se'=
s
> > > load_avg. So you can't directly add/sub se's load_sum and rq's
> > > load_sum. Only load_avg of both se and rq use the same unit.
> > >
> >
> > I understand and agree with your point: cfs_rq->avg.load_sum includes
> > the weight while se->avg.load_sum does not, so the two are indeed in
> > different units and cannot be directly added or subtracted.
> >
> > However, in this patch we DO NOT directly add or subtract
> > se->avg.load_sum to/from cfs_rq->avg.load_sum. Instead, the load_sum
> > of dequeued tasks is accumulated into cfs_rq->prop_runnable_sum.
> > Later, in update_tg_cfs_load, this prop_runnable_sum is used to
> > recompute the load_sum and load_avg of both gse and cfs_rq.
> >
> > In other words, the update here is performed via recomputation rather
> > than direct arithmetic, so the =E2=80=9Cunit mismatch=E2=80=9D issue yo=
u mentioned
> > does not occur.
> >
> > update_tg_cfs_load
> >   |-- long delta_avg, runnable_sum =3D gcfs_rq->prop_runnable_sum;
> >   |
> >   |   runnable_sum +=3D gse->avg.load_sum;
> >   |
> >   |   load_sum =3D se_weight(gse) * runnable_sum;
> >   |   load_avg =3D div_u64(load_sum, divider);
> >   |
> >   |   delta_avg =3D load_avg - gse->avg.load_avg;
> >   |   delta_sum =3D load_sum - (s64)se_weight(gse) * gse->avg.load_sum;
> >   |
> >   |-- /* Recalculate the load_sum and load_avg of gse. */
> >   |   gse->avg.load_sum =3D runnable_sum;
> >   |   gse->avg.load_avg =3D load_avg;
> >   |
> >   |-- /* Recalculate the load_sum and load_avg of cfs_rq. */
> >   |   add_positive(&cfs_rq->avg.load_avg, delta_avg);
> >   |   add_positive(&cfs_rq->avg.load_sum, delta_sum);
> >
> >
> >
> >
> > >
> > > Then, why is it a problem only for load and not util or runnable ?
> > >
> >
> > I broke this question into three parts and derived the related
> > formulas step by step.
> >
> >
> > Q1: Why doesn=E2=80=99t util_avg have the same problem?
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > A1: Because the formulas of util_avg / util_sum are exactly the same
> > for both se and cfs_rq. Neither involves weight, and the units are
> > consistent, so direct addition and subtraction are valid.
> >
> > The formulas for a sched_entity (tse) are:
> >
> >              util_sum
> > util_avg =3D ------------
> >               divider
> >
> >
> >     decay(history) + contrib(running) * 1024
> >   =3D ----------------------------------------
> >                   divider
> >
> >
> >     (decay(history) + contrib(running)) * 1024
> >  ~=3D ------------------------------------------
> >                   divider
> >
> >
> >     decay(history) + contrib(running)
> >   =3D --------------------------------- * 1024
> >                   divider
> >
> >
> > Where:
> > util_sum =3D decay(history) + contrib(running) * 1024
> > util_avg < 1024
> > decay(history): represents geometric decay of the historical contributi=
on (time)
> > contrib(running): contribution added when the task is in running state
> >
> >
> > For cfs_rq, the formulas of util_avg / util_sum are:
> >
> >              util_sum
> > util_avg =3D ------------
> >               divider
> >
> >
> >     decay(history) + contrib(running) * 1024
> >   =3D ----------------------------------------
> >                   divider
> >
> >
> >     (decay(history) + contrib(running)) * 1024
> >  ~=3D ------------------------------------------
> >                       divider
> >
> >
> >     decay(history) + contrib(running)
> >   =3D --------------------------------- * 1024
> >                  divider
> >
> >
> > Where:
> > util_sum =3D decay(history) + contrib(running) * 1024
> > util_avg < 1024
> > decay(history): represents geometric decay of the historical contributi=
on (time)
> > contrib(running): contribution added when the task is in running state
> >
> >
> > Therefore, se and cfs_rq share the same units for util_avg / util_sum,
> > which makes direct addition and subtraction valid. This is also why
> > update_tg_cfs_util performs direct subtraction when updating:
> >
> > update_tg_cfs_util
> >   |-- /* Calculate the delta between gse and gcfs_rq directly by subtra=
ction. */
> >   |   long delta_avg =3D gcfs_rq->avg.util_avg - se->avg.util_avg;
> >   |
> >   |-- /* Set new sched_entity's utilization */
> >   |   se->avg.util_avg =3D gcfs_rq->avg.util_avg;
> >   |   new_sum =3D se->avg.util_avg * divider;
> >   |   delta_sum =3D (long)new_sum - (long)se->avg.util_sum;
> >   |   se->avg.util_sum =3D new_sum;
> >   |
> >   |-- /* Update parent cfs_rq utilization */
> >   |   add_positive(&cfs_rq->avg.util_avg, delta_avg);
> >   |   add_positive(&cfs_rq->avg.util_sum, delta_sum);
> >
> >
> > Q2: Why doesn=E2=80=99t runnable_avg have the same problem?
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > A2: Similarly, the runnable_avg / runnable_sum of se and cfs_rq also
> > do not include weight.
> >
> > The calculation formulas for tse's runnable_avg and runnable_sum are as=
 follows:
> >
> >                  runnable_sum
> > runnable_avg =3D ----------------
> >                    divider
> >
> >
> >     decay(history) + contrib(running + runnable) * 1024
> >   =3D ---------------------------------------------------
> >                         divider
> >
> >
> >     (decay(history) + contrib(running + runnable)) * 1024
> >  ~=3D -----------------------------------------------------
> >                          divider
> >
> >
> >     decay(history) + contrib(running + runnable)
> >   =3D -------------------------------------------- * 1024
> >                       divider
> >
> >
> > Where:
> > runnable_sum =3D decay(history) + contrib(running + runnable) * 1024
> > runnable_avg < 1024
> > decay(history): represents geometric decay of the historical contributi=
on (time)
> > contrib(running + runnable): contribution added when the task is in
> > running and runnable states
> >
> >
> > The calculation formulas for cfs_rq's runnable_avg and runnable_sum
> > are as follows:
> >
> >                  runnable_sum
> > runnable_avg =3D ----------------
> >                    divider
> >
> >
> >     decay(history) + contrib(running + runnable) * cfs_rq->h_nr_running=
 * 1024
> >   =3D -----------------------------------------------------------------=
---------
> >                                      divider
> >
> >
> >   (decay(history) + contrib(running + runnable)) * cfs_rq->h_nr_running=
 * 1024
> >  ~=3D -----------------------------------------------------------------=
---------
> >                                    divider
> >
> >
> >     decay(history) + contrib(running + runnable)
> >   =3D -------------------------------------------- * cfs_rq->h_nr_runni=
ng * 1024
> >                       divider
> >
> >
> > Where:
> > runnable_sum =3D decay(history) + contrib(running + runnable) *
> > cfs_rq->h_nr_running * 1024
> > runnable_avg < cfs_rq->h_nr_running * 1024
> > decay(history): represents geometric decay of the historical contributi=
on (time)
> > contrib(running + runnable): contribution added when the task is in
> > running and runnable states
> >
> >
> > The runnable statistic of cfs_rq is represented by h_nr_running, which
> > indicates the number of tasks and can be regarded as the accumulated
> > runnable of all se. Therefore, in update_tg_cfs_runnable, the update
> > can also be done directly using subtraction.
> >
> > update_tg_cfs_runnable
> >   |-- /* Calculate the delta directly by subtraction. */
> >   |   long delta_avg =3D gcfs_rq->avg.runnable_avg - gse->avg.runnable_=
avg;
> >   |
> >   |-- /* Set new sched_entity's runnable */
> >   |   gse->avg.runnable_avg =3D gcfs_rq->avg.runnable_avg;
> >   |   new_sum =3D gse->avg.runnable_avg * divider;
> >   |   delta_sum =3D (long)new_sum - (long)gse->avg.runnable_sum;
> >   |   gse->avg.runnable_sum =3D new_sum;
> >   |
> >   |-- /* Update parent cfs_rq runnable */
> >   |   add_positive(&cfs_rq->avg.runnable_avg, delta_avg);
> >   |   add_positive(&cfs_rq->avg.runnable_sum, delta_sum);
> >
> >
> > Q3: Why does load_avg have this problem?
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > A3: The key difference is that cfs_rq=E2=80=99s load_avg and load_sum i=
nclude
> > weight information, while a task=E2=80=99s load_sum does not. Moreover,=
 we
> > cannot reconstruct load_sum from a task=E2=80=99s load_avg.
> >
> > For a task (tse), the formulas are:
> >
> >              load_sum
> > load_avg =3D ------------ * se_weight(se)
> >               divider
> >
> >
> >    decay(history) + contrib(running + runnable)
> >  =3D -------------------------------------------- * se_weight(se)
> >                      divider
> >
> >
> > Where:
> > load_sum =3D decay(history) + contrib(running + runnable)
> > load_avg < se_weight(se)
> > decay(history): represents geometric decay of the historical contributi=
on (time)
> > contrib(running + runnable): contribution added when the task is in
> > running and runnable states
> >
> >
> > For a cfs_rq, the formulas are:
> >
> >              load_sum
> > load_avg =3D ------------
> >               divider
> >
> >
> >     decay(history) + contrib(running + runnable) * cfs_rq->load.weight
> >   =3D -----------------------------------------------------------------=
-
> >                                   divider
> >
> >
> >     (decay(history) + contrib(running + runnable)) * cfs_rq->load.weigh=
t
> >  ~=3D -----------------------------------------------------------------=
---
> >                                  divider
> >
> >
> >     decay(history) + contrib(running + runnable)
> >   =3D -------------------------------------------- * cfs_rq->load.weigh=
t
> >                       divider
> >
> >
> > Where:
> > load_sum =3D decay(history) + contrib(running + runnable) * cfs_rq->loa=
d.weight
> > load_avg < cfs_rq->load.weight
> > decay(history): represents geometric decay of the historical contributi=
on (time)
> > contrib(running + runnable): contribution added when the task is in
> > running and runnable states
> >
> >
> > From these formulas, we can see that tse=E2=80=99s load_sum does not in=
clude
> > weight, while cfs_rq=E2=80=99s does. Their units differ, so they cannot=
 be
> > directly added or subtracted. In addition, weight is a "historical
> > variable" that changes over time, which means load_sum cannot be
> > derived from se=E2=80=99s load_avg.
> >
> > To propagate load_sum changes from a child cfs_rq, the upstream
> > implementation uses runnable_avg to APPROXIMATE load_sum. The
> > derivation is as follows.
> >
> > For tse:
> >
> >                  runnable_sum
> > runnable_avg =3D ----------------
> >                    divider
> >
> >     decay(history) + contrib(running + runnable) * 1024
> >   =3D ---------------------------------------------------
> >                      divider
> >
> >      decay(history) + contrib(running + runnable)
> >  ~=3D --------------------------------------------- * 1024
> >                      divider
> >
> >
> > Thus:
> >
> > decay(history) + contrib(running + runnable)
> >
> >
> >      runnable_avg * divider
> >  ~=3D -----------------------
> >              1024
> >
> >
> >  ~=3D (runnable_avg * divider) >> SCHED_CAPACITY_SHIFT        (1)
> >
> >
> > Equation (1) represents the contribution when a task is in running or
> > runnable state. The kernel refers to this as the "unweighted version
> > of removed_load", which is essentially time with exponential decay
> > applied.
> >
> > It is worth noting that equation (1) happens to be equal to tse=E2=80=
=99s
> > load_sum. Therefore, for tse we have:
> >
> > load_sum ~=3D (runnable_avg * divider) >> SCHED_CAPACITY_SHIFT     (2)
> >
> > However, equation (2) itself is only an approximation, and the
> > right-shift operation introduces further truncation error.
> >
> > My idea is that since the task=E2=80=99s load_sum already exists when i=
t
> > dequeues, it is more reasonable to record this value directly. By
> > doing so, we can avoid both the approximation and the shift-induced
> > error. This is the motivation behind introducing removed.load_sum in
> > my patch.
> >
> >
> >
> >
> > > Also we don't want to track both load_sum and load_avg, only one is
> > > enough and by the above it is load_avg
> > >
> >
> > My view is consistent with yours, but I personally lean towards
> > keeping load_sum and deprecating load_avg, since load_avg does not
> > seem to be accurate.
> >
> > That said, this is only my personal perspective and may not be
> > comprehensive. I would like to further discuss the feasibility of this
> > approach with you.
> >
> > Thanks.
> > hupu

