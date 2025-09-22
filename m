Return-Path: <linux-kernel+bounces-826721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01247B8F2F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF70C1898059
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D679E274FDF;
	Mon, 22 Sep 2025 06:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo4aXObR"
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736434BA39
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523409; cv=none; b=s9F6dYCVJRwFdvsN0dh+K4x2qbsNOK1N68GN/x6eL4aT4bM5g2lX6hZgs50qVPSpabJnfNOGJht/87FHLRoJb+pxzNFzhTzpceDxASF7D1bfVCA58bQVPqivnGJ3EqlG9sCF7JrZuEPwlkNMKP0y9lQj9+eKOT18h1tzf6j9HVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523409; c=relaxed/simple;
	bh=bVyfxwD012fYWklfeh/U4fEg00b4rmGz9NI2gNLfD9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGlByHYZUC5rHkQJeKiDERiHJ1ZNN+LlS4A8/jWqkYwSgX8BD+ILq0Xryrhw7vkKnPsNVA5q0CLGlsAyAen3xbide4fCknbDCbUcwBe3H7zUcyMjXhICkljKMQ0abY7vWXlT1cqEc6Se3qfHFgCugzv7qGW6SlMb5//X7V5CG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo4aXObR; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-3635bd94dadso29957891fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758523405; x=1759128205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4j8Lj4RbWFDIK1ssp7+3G4Z7pvxO3HJ6ik1GmfQvWaA=;
        b=Oo4aXObR3q8mAB2hNuaLe0Umk14nHezugrO4qPW6nHecCWyex5jFMNUjBb0Ymsnvei
         fIZxoyXiSHbaafzOY0geThFYSJcGl45ItvtkE/VOfdRL9r3xWBi4XONcZA9BrUVfqZwf
         YpO8V2xyrlO+8Ai9wtOr5DOBgZkMTq0+PoCWDdfIvxL4Jd5zxa3MbU1ovIpmBzi4es6a
         HlE0KPQKWksyQaGTn03ibsXWMDBLJfERmxHHtQHUHy7/2F+INxv8qfdvtF79QjrSM1bQ
         EOycWnqIINWBSKXjfCntWoq97WJ4kdiE4SmADHH+b1NjHr0PgmeOTrZYnB3TBO+5rnBX
         mqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758523405; x=1759128205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4j8Lj4RbWFDIK1ssp7+3G4Z7pvxO3HJ6ik1GmfQvWaA=;
        b=KhZdDbXxAN7b407H3w5kVgIEtZFhFbPDSWdnFT+zPb+FIPlkZSO8OuDKaPg1WjPwzW
         t5QVfCOWIjqmpMfb9js1fBtXr9S+zjs+GZOKCOT43+Okwc8aAL/2zE6dlyn49ipNYLyP
         NbFDr8nfrFlTKhDwteE66F7Rvbc83ahRF9IWco31W5m+0wugnPU1NmqyT7fogDGIJo0u
         akT4otCAV+BWvf9NM6AEh4CrunSWHKEQ2EDuVL56E7xn1yuhY3eeW88Kh86hUectk87y
         VgF6JMQEZFINLj4AHI4KIkGV/UKpW/RqFFmQoSihjnJpkrUmnK0x3XZL1qlgxGn16E+D
         yRNQ==
X-Gm-Message-State: AOJu0YxvCIr9wfztdmkO7fQjw0q3LMW/Q8QPW0dGG/Rr9ZMpLrViqDyw
	HM8EZvW0GTmbsnbG17ZuUtUSeVlqkrjWF4kyG3GmJ57Nwv/iXeWWz6iZVdj8BPAo4g9hvZ9BVzj
	xaGEVCaQMkuMiLf1RPSXCAR0krbrAJooauQa92hqw0Q==
X-Gm-Gg: ASbGnct2oo4uLexGAp6/4Ag4ODBeRq8zlL/Wswmgp9agM+MIYZ9B33PlFggmHGs8HoN
	WMvejQkp+vOSgT3p3KUBLg0NVn9fVAml/vVbFJ7K7tp+4fHEkAaoeS8juzPMzIJXCL3kxxL+1X6
	e620vtG6uTlqCIQhf2dTjEGKZP4Y+nhnpbUu03sF4NBlQN6/sdSGMQtsdmfgkPNW+oiGcYjnxQ3
	/we0fMi
X-Google-Smtp-Source: AGHT+IFztuQnp+k8xIgPykqXc+Ztu/ikPm8GBW5oj5hUJ6NQ5f/gsl9a/mSo0b92/wHGBOPFZxq56fHnn65eFrSsJ8w=
X-Received: by 2002:a05:651c:545:b0:36b:4cc1:15ff with SMTP id
 38308e7fff4ca-36b4cc116b5mr11494321fa.5.1758523404336; Sun, 21 Sep 2025
 23:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910084316.356169-1-hupu.gm@gmail.com> <CAKfTPtCyL=ofg4yLtfG7zsoBMDnP48KCeUELT_Hddd3gnWeYEw@mail.gmail.com>
 <CADHxFxTkexicChcg3To4=AsX8c+s2RNWZ5NfA9UBLMfYRZtmKg@mail.gmail.com>
In-Reply-To: <CADHxFxTkexicChcg3To4=AsX8c+s2RNWZ5NfA9UBLMfYRZtmKg@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 22 Sep 2025 14:43:11 +0800
X-Gm-Features: AS18NWCakLQGi2VJu63meM5hyStkMnipzjicjO37bLgCo2277QKyHrbpLOTRtZY
Message-ID: <CADHxFxSxnCbxukRW0Q8tovM-CMYmMjdxnLW2DUL-tKWMkAEBQg@mail.gmail.com>
Subject: Re: [RESEND][RFC] sched: Introduce removed.load_sum for precise load propagation
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, vschneid@redhat.com, mgorman@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

RESEND AGAIN

On Fri, Sep 12, 2025 at 2:44=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
>
> Hi Vincent Guittot
> Thank you very much for your reply.
>
> On Thu, Sep 11, 2025 at 4:01=E2=80=AFPM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Wed, 10 Sept 2025 at 10:43, hupu <hupu.gm@gmail.com> wrote:
> > >
> > > Currently, load_sum to be propagated is estimated from
> > > (removed_runnable * divider) >> SCHED_CAPACITY_SHIFT, which relies on
> > > runnable_avg as an approximation. This approach can introduce precisi=
on
> > > loss due to the shift operation, and the error may become more visibl=
e
> > > when small tasks frequently enter and leave the queue.
> >
> > Do you have a level of error ? Do you have a typical use case ?
> >
>
> In fact, I derived the error here from the underlying mathematical
> relationship. The error mainly comes from two sources:
> a) The approximation of load_sum using runnable_avg;
> b) The truncation introduced by the right shift (SCHED_CAPACITY_SHIFT).
>
> Below is the detailed derivation and explanation.
>
> removed_runnable records the sum of se->avg.runnable_avg for tasks
> that have migrated to another CPU. It represents the decayed
> cumulative contribution of a task=E2=80=99s runtime, with the unit being
> microseconds (=CE=BCs). Right-shifting by SCHED_CAPACITY_SHIFT (10 bits) =
is
> equivalent to truncating the low part below 1024 =CE=BCs. In other words,
> if a task has accumulated less than 1024 =CE=BCs of runtime before
> dequeueing, its load contribution will be completely discarded by the
> shift operation. Even if the accumulated runtime exceeds 1024 =CE=BCs, th=
e
> shift may still introduce up to nearly 1024 =CE=BCs of truncation error
> (about 1 ms).
>
> For example, suppose a task has accumulated 4095 =CE=BCs (4.095 ms) of
> runtime on CPU0, then goes to sleep and is migrated to CPU1 upon
> wakeup. Ideally, CPU0 should remove that task=E2=80=99s contribution full=
y.
> However, after the shift, the result is 4095 >> 10 =3D 3 ms, which means
> CPU0 will still retain about 1023 =CE=BCs (~=3D 1.023 ms) of the task=E2=
=80=99s
> contribution.
>
> Experimental results also confirm this. By adding debug output before
> add_tg_cfs_propagate and comparing the actual removed_load_sum (the
> true value to be removed) with the approximate value obtained through
> the shift, we observed that the latter is smaller in most cases. This
> discrepancy is exactly due to the approximation and truncation
> introduced by the shift.
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> old mode 100644
> new mode 100755
> index b173a059315c..92396da04520
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4561,7 +4561,8 @@ static void migrate_se_pelt_lag(struct
> sched_entity *se) {}
>  static inline int
>  update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  {
> -       unsigned long removed_load =3D 0, removed_util =3D 0, removed_run=
nable =3D 0;
> +       unsigned long removed_load_sum =3D 0, removed_load =3D 0;
> +       unsigned long removed_util =3D 0, removed_runnable =3D 0;
>         struct sched_avg *sa =3D &cfs_rq->avg;
>         int decayed =3D 0;
>
> @@ -4572,6 +4573,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_=
rq)
>                 raw_spin_lock(&cfs_rq->removed.lock);
>                 swap(cfs_rq->removed.util_avg, removed_util);
>                 swap(cfs_rq->removed.load_avg, removed_load);
> +               swap(cfs_rq->removed.load_sum, removed_load_sum);
>                 swap(cfs_rq->removed.runnable_avg, removed_runnable);
>                 cfs_rq->removed.nr =3D 0;
>                 raw_spin_unlock(&cfs_rq->removed.lock);
> @@ -4609,8 +4611,10 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs=
_rq)
>                  * removed_runnable is the unweighted version of
> removed_load so we
>                  * can use it to estimate removed_load_sum.
>                  */
> -               add_tg_cfs_propagate(cfs_rq,
> -                       -(long)(removed_runnable * divider) >>
> SCHED_CAPACITY_SHIFT);
> +               trace_printk("DEBUG BYHP: removed_load_sum=3D%lu,
> raw_removed_runnable_sum=3D%lu\n",
> +                               (long)removed_load_sum,
> +                               (long)((removed_runnable * divider) >>
> SCHED_CAPACITY_SHIFT));
> +               add_tg_cfs_propagate(cfs_rq, -(long)removed_load_sum);
>
>                 decayed =3D 1;
>         }
> @@ -4792,6 +4796,7 @@ static void remove_entity_load_avg(struct
> sched_entity *se)
>         ++cfs_rq->removed.nr;
>         cfs_rq->removed.util_avg        +=3D se->avg.util_avg;
>         cfs_rq->removed.load_avg        +=3D se->avg.load_avg;
> +       cfs_rq->removed.load_sum        +=3D se->avg.load_sum;
>         cfs_rq->removed.runnable_avg    +=3D se->avg.runnable_avg;
>         raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index be9745d104f7..659935a5c694 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -682,6 +682,7 @@ struct cfs_rq {
>         struct {
>                 raw_spinlock_t  lock ____cacheline_aligned;
>                 int             nr;
> +               unsigned long   load_sum;
>                 unsigned long   load_avg;
>                 unsigned long   util_avg;
>                 unsigned long   runnable_avg;
>
> The logs are as follows: raw_removed_runnable_sum is often smaller
> than removed_load_sum. This difference is exactly caused by the
> approximate calculation and the truncation introduced by bit shifting.
>
>    stress-ng-cpu-183     (-------) [001] dnh1.   144.338335:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D35463,
> raw_removed_runnable_sum=3D35429
>    stress-ng-cpu-184     (-------) [007] dNs1.   144.346203:
> sched_balance_update_blocked_averages: DEBUG BYHP:
> removed_load_sum=3D20607, raw_removed_runnable_sum=3D20496
>    stress-ng-cpu-185     (-------) [001] d.h1.   144.568803:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
> raw_removed_runnable_sum=3D0
>    stress-ng-cpu-183     (-------) [000] d.h1.   145.526897:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D11103,
> raw_removed_runnable_sum=3D11072
>    stress-ng-cpu-183     (-------) [000] d.h1.   145.563980:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
> raw_removed_runnable_sum=3D0
>    stress-ng-cpu-185     (-------) [002] d..2.   145.593563:
> sched_balance_update_blocked_averages: DEBUG BYHP: removed_load_sum=3D0,
> raw_removed_runnable_sum=3D0
>    stress-ng-cpu-181     (-------) [005] d.s1.   145.653525:
> sched_balance_update_blocked_averages: DEBUG BYHP:
> removed_load_sum=3D2537, raw_removed_runnable_sum=3D2508
>    stress-ng-cpu-183     (-------) [003] d.s1.   145.657599:
> sched_balance_update_blocked_averages: DEBUG BYHP:
> removed_load_sum=3D28510, raw_removed_runnable_sum=3D28473
>    stress-ng-cpu-180     (-------) [007] d.h1.   146.049167:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D9548,
> raw_removed_runnable_sum=3D9526
>    stress-ng-cpu-184     (-------) [005] d.h1.   146.057200:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D5974,
> raw_removed_runnable_sum=3D5963
>    stress-ng-cpu-182     (-------) [000] d.s1.   146.062025:
> sched_balance_update_blocked_averages: DEBUG BYHP:
> removed_load_sum=3D55, raw_removed_runnable_sum=3D45
>       kcompactd0-65      (-------) [001] d..2.   146.095334:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
> raw_removed_runnable_sum=3D0
>       kcompactd0-65      (-------) [001] d..2.   146.095433:
> sched_balance_update_blocked_averages: DEBUG BYHP:
> removed_load_sum=3D17493, raw_removed_runnable_sum=3D17461
>    stress-ng-cpu-186     (-------) [006] d.h1.   146.118910:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D11404,
> raw_removed_runnable_sum=3D11389
>    stress-ng-cpu-186     (-------) [000] d.h1.   147.112614:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
> raw_removed_runnable_sum=3D0
>              cat-234     (-------) [005] d.s2.   147.161900:
> sched_balance_update_blocked_averages: DEBUG BYHP:
> removed_load_sum=3D36778, raw_removed_runnable_sum=3D36768
>    stress-ng-cpu-181     (-------) [004] d.h1.   147.406979:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D3029,
> raw_removed_runnable_sum=3D3014
>    stress-ng-cpu-185     (-------) [003] d.s1.   147.474502:
> sched_balance_update_blocked_averages: DEBUG BYHP:
> removed_load_sum=3D1242, raw_removed_runnable_sum=3D1205
>    stress-ng-cpu-186     (-------) [000] d.h1.   147.533368:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D11,
> raw_removed_runnable_sum=3D0
>    stress-ng-cpu-181     (-------) [001] d.s1.   148.341639:
> sched_balance_update_blocked_averages: DEBUG BYHP:
> removed_load_sum=3D15837, raw_removed_runnable_sum=3D15804
>      migration/7-51      (-------) [007] d..2.   148.384219:
> sched_balance_update_blocked_averages: DEBUG BYHP: removed_load_sum=3D0,
> raw_removed_runnable_sum=3D0
>           <idle>-0       (-------) [004] d.s2.   148.431501:
> sched_balance_update_blocked_averages: DEBUG BYHP:
> removed_load_sum=3D4292, raw_removed_runnable_sum=3D1924
>              cat-234     (-------) [007] d.h1.   148.434474:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D10380,
> raw_removed_runnable_sum=3D9945
>    stress-ng-cpu-184     (-------) [001] d.h1.   148.853949:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D15896,
> raw_removed_runnable_sum=3D15869
>    stress-ng-cpu-185     (-------) [007] d.s1.   148.862267:
> sched_balance_update_blocked_averages: DEBUG BYHP:
> removed_load_sum=3D31, raw_removed_runnable_sum=3D0
>    stress-ng-cpu-183     (-------) [006] d.h1.   149.157805:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D20553,
> raw_removed_runnable_sum=3D20527
>    stress-ng-cpu-179     (-------) [007] d.h1.   149.330189:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D9204,
> raw_removed_runnable_sum=3D9177
>    stress-ng-cpu-185     (-------) [002] d.h1.   149.434768:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D11198,
> raw_removed_runnable_sum=3D11176
>           <idle>-0       (-------) [006] dNs2.   149.456004:
> sched_balance_update_blocked_averages: DEBUG BYHP:
> removed_load_sum=3D2826, raw_removed_runnable_sum=3D465
>    stress-ng-cpu-184     (-------) [005] d.s1.   149.483636:
> sched_balance_update_blocked_averages: DEBUG BYHP:
> removed_load_sum=3D11607, raw_removed_runnable_sum=3D11595
>    stress-ng-cpu-186     (-------) [001] d.h1.   149.668063:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
> raw_removed_runnable_sum=3D0
>           <idle>-0       (-------) [001] d.h2.   149.672477:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
> raw_removed_runnable_sum=3D0
>    stress-ng-cpu-183     (-------) [007] d.s1.   149.684045:
> sched_balance_update_blocked_averages: DEBUG BYHP:
> removed_load_sum=3D5657, raw_removed_runnable_sum=3D5458
>      ksoftirqd/1-22      (-------) [001] d.s1.   149.700089:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
> raw_removed_runnable_sum=3D0
>    stress-ng-cpu-183     (-------) [004] d.h1.   149.807666:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D10481,
> raw_removed_runnable_sum=3D10474
>    stress-ng-cpu-184     (-------) [000] d.h1.   149.817148:
> update_load_avg: DEBUG BYHP: removed_load_sum=3D3,
> raw_removed_runnable_sum=3D0
>           <idle>-0       (-------) [001] d.s2.   149.866309:
> sched_balance_update_blocked_averages: DEBUG BYHP:
> removed_load_sum=3D4010, raw_removed_runnable_sum=3D3999
>    stress-ng-cpu-184     (-------) [000] d.s1.   149.914423:
> sched_balance_update_blocked_averages: DEBUG BYHP:
> removed_load_sum=3D1920, raw_removed_runnable_sum=3D1876
>
>
>
>
> > >
> > > This patch introduces removed.load_sum to directly accumulate
> > > se->avg.load_sum when tasks dequeue, and uses it during load
> > > propagation. By doing so:
> > >
> > >   a) Avoid relying on runnable_avg-based approximation and obtain
> > >      higher precision in load_sum propagation;
> > >   b) Eliminate precision loss from the shift operation, especially
> > >      with frequent short-lived tasks;
> > >   c) Reduce one multiplication and shift in the hotpath, which
> > >      theoretically lowers overhead (though the impact is minor).
> >
> > This doesn't work because rq's load_sum tracks current weight whereas
> > se's load_sum doesn't include the weight which is only applied on se's
> > load_avg. So you can't directly add/sub se's load_sum and rq's
> > load_sum. Only load_avg of both se and rq use the same unit.
> >
>
> I understand and agree with your point: cfs_rq->avg.load_sum includes
> the weight while se->avg.load_sum does not, so the two are indeed in
> different units and cannot be directly added or subtracted.
>
> However, in this patch we DO NOT directly add or subtract
> se->avg.load_sum to/from cfs_rq->avg.load_sum. Instead, the load_sum
> of dequeued tasks is accumulated into cfs_rq->prop_runnable_sum.
> Later, in update_tg_cfs_load, this prop_runnable_sum is used to
> recompute the load_sum and load_avg of both gse and cfs_rq.
>
> In other words, the update here is performed via recomputation rather
> than direct arithmetic, so the =E2=80=9Cunit mismatch=E2=80=9D issue you =
mentioned
> does not occur.
>
> update_tg_cfs_load
>   |-- long delta_avg, runnable_sum =3D gcfs_rq->prop_runnable_sum;
>   |
>   |   runnable_sum +=3D gse->avg.load_sum;
>   |
>   |   load_sum =3D se_weight(gse) * runnable_sum;
>   |   load_avg =3D div_u64(load_sum, divider);
>   |
>   |   delta_avg =3D load_avg - gse->avg.load_avg;
>   |   delta_sum =3D load_sum - (s64)se_weight(gse) * gse->avg.load_sum;
>   |
>   |-- /* Recalculate the load_sum and load_avg of gse. */
>   |   gse->avg.load_sum =3D runnable_sum;
>   |   gse->avg.load_avg =3D load_avg;
>   |
>   |-- /* Recalculate the load_sum and load_avg of cfs_rq. */
>   |   add_positive(&cfs_rq->avg.load_avg, delta_avg);
>   |   add_positive(&cfs_rq->avg.load_sum, delta_sum);
>
>
>
>
> >
> > Then, why is it a problem only for load and not util or runnable ?
> >
>
> I broke this question into three parts and derived the related
> formulas step by step.
>
>
> Q1: Why doesn=E2=80=99t util_avg have the same problem?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> A1: Because the formulas of util_avg / util_sum are exactly the same
> for both se and cfs_rq. Neither involves weight, and the units are
> consistent, so direct addition and subtraction are valid.
>
> The formulas for a sched_entity (tse) are:
>
>              util_sum
> util_avg =3D ------------
>               divider
>
>
>     decay(history) + contrib(running) * 1024
>   =3D ----------------------------------------
>                   divider
>
>
>     (decay(history) + contrib(running)) * 1024
>  ~=3D ------------------------------------------
>                   divider
>
>
>     decay(history) + contrib(running)
>   =3D --------------------------------- * 1024
>                   divider
>
>
> Where:
> util_sum =3D decay(history) + contrib(running) * 1024
> util_avg < 1024
> decay(history): represents geometric decay of the historical contribution=
 (time)
> contrib(running): contribution added when the task is in running state
>
>
> For cfs_rq, the formulas of util_avg / util_sum are:
>
>              util_sum
> util_avg =3D ------------
>               divider
>
>
>     decay(history) + contrib(running) * 1024
>   =3D ----------------------------------------
>                   divider
>
>
>     (decay(history) + contrib(running)) * 1024
>  ~=3D ------------------------------------------
>                       divider
>
>
>     decay(history) + contrib(running)
>   =3D --------------------------------- * 1024
>                  divider
>
>
> Where:
> util_sum =3D decay(history) + contrib(running) * 1024
> util_avg < 1024
> decay(history): represents geometric decay of the historical contribution=
 (time)
> contrib(running): contribution added when the task is in running state
>
>
> Therefore, se and cfs_rq share the same units for util_avg / util_sum,
> which makes direct addition and subtraction valid. This is also why
> update_tg_cfs_util performs direct subtraction when updating:
>
> update_tg_cfs_util
>   |-- /* Calculate the delta between gse and gcfs_rq directly by subtract=
ion. */
>   |   long delta_avg =3D gcfs_rq->avg.util_avg - se->avg.util_avg;
>   |
>   |-- /* Set new sched_entity's utilization */
>   |   se->avg.util_avg =3D gcfs_rq->avg.util_avg;
>   |   new_sum =3D se->avg.util_avg * divider;
>   |   delta_sum =3D (long)new_sum - (long)se->avg.util_sum;
>   |   se->avg.util_sum =3D new_sum;
>   |
>   |-- /* Update parent cfs_rq utilization */
>   |   add_positive(&cfs_rq->avg.util_avg, delta_avg);
>   |   add_positive(&cfs_rq->avg.util_sum, delta_sum);
>
>
> Q2: Why doesn=E2=80=99t runnable_avg have the same problem?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> A2: Similarly, the runnable_avg / runnable_sum of se and cfs_rq also
> do not include weight.
>
> The calculation formulas for tse's runnable_avg and runnable_sum are as f=
ollows:
>
>                  runnable_sum
> runnable_avg =3D ----------------
>                    divider
>
>
>     decay(history) + contrib(running + runnable) * 1024
>   =3D ---------------------------------------------------
>                         divider
>
>
>     (decay(history) + contrib(running + runnable)) * 1024
>  ~=3D -----------------------------------------------------
>                          divider
>
>
>     decay(history) + contrib(running + runnable)
>   =3D -------------------------------------------- * 1024
>                       divider
>
>
> Where:
> runnable_sum =3D decay(history) + contrib(running + runnable) * 1024
> runnable_avg < 1024
> decay(history): represents geometric decay of the historical contribution=
 (time)
> contrib(running + runnable): contribution added when the task is in
> running and runnable states
>
>
> The calculation formulas for cfs_rq's runnable_avg and runnable_sum
> are as follows:
>
>                  runnable_sum
> runnable_avg =3D ----------------
>                    divider
>
>
>     decay(history) + contrib(running + runnable) * cfs_rq->h_nr_running *=
 1024
>   =3D -------------------------------------------------------------------=
-------
>                                      divider
>
>
>   (decay(history) + contrib(running + runnable)) * cfs_rq->h_nr_running *=
 1024
>  ~=3D -------------------------------------------------------------------=
-------
>                                    divider
>
>
>     decay(history) + contrib(running + runnable)
>   =3D -------------------------------------------- * cfs_rq->h_nr_running=
 * 1024
>                       divider
>
>
> Where:
> runnable_sum =3D decay(history) + contrib(running + runnable) *
> cfs_rq->h_nr_running * 1024
> runnable_avg < cfs_rq->h_nr_running * 1024
> decay(history): represents geometric decay of the historical contribution=
 (time)
> contrib(running + runnable): contribution added when the task is in
> running and runnable states
>
>
> The runnable statistic of cfs_rq is represented by h_nr_running, which
> indicates the number of tasks and can be regarded as the accumulated
> runnable of all se. Therefore, in update_tg_cfs_runnable, the update
> can also be done directly using subtraction.
>
> update_tg_cfs_runnable
>   |-- /* Calculate the delta directly by subtraction. */
>   |   long delta_avg =3D gcfs_rq->avg.runnable_avg - gse->avg.runnable_av=
g;
>   |
>   |-- /* Set new sched_entity's runnable */
>   |   gse->avg.runnable_avg =3D gcfs_rq->avg.runnable_avg;
>   |   new_sum =3D gse->avg.runnable_avg * divider;
>   |   delta_sum =3D (long)new_sum - (long)gse->avg.runnable_sum;
>   |   gse->avg.runnable_sum =3D new_sum;
>   |
>   |-- /* Update parent cfs_rq runnable */
>   |   add_positive(&cfs_rq->avg.runnable_avg, delta_avg);
>   |   add_positive(&cfs_rq->avg.runnable_sum, delta_sum);
>
>
> Q3: Why does load_avg have this problem?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> A3: The key difference is that cfs_rq=E2=80=99s load_avg and load_sum inc=
lude
> weight information, while a task=E2=80=99s load_sum does not. Moreover, w=
e
> cannot reconstruct load_sum from a task=E2=80=99s load_avg.
>
> For a task (tse), the formulas are:
>
>              load_sum
> load_avg =3D ------------ * se_weight(se)
>               divider
>
>
>    decay(history) + contrib(running + runnable)
>  =3D -------------------------------------------- * se_weight(se)
>                      divider
>
>
> Where:
> load_sum =3D decay(history) + contrib(running + runnable)
> load_avg < se_weight(se)
> decay(history): represents geometric decay of the historical contribution=
 (time)
> contrib(running + runnable): contribution added when the task is in
> running and runnable states
>
>
> For a cfs_rq, the formulas are:
>
>              load_sum
> load_avg =3D ------------
>               divider
>
>
>     decay(history) + contrib(running + runnable) * cfs_rq->load.weight
>   =3D ------------------------------------------------------------------
>                                   divider
>
>
>     (decay(history) + contrib(running + runnable)) * cfs_rq->load.weight
>  ~=3D -------------------------------------------------------------------=
-
>                                  divider
>
>
>     decay(history) + contrib(running + runnable)
>   =3D -------------------------------------------- * cfs_rq->load.weight
>                       divider
>
>
> Where:
> load_sum =3D decay(history) + contrib(running + runnable) * cfs_rq->load.=
weight
> load_avg < cfs_rq->load.weight
> decay(history): represents geometric decay of the historical contribution=
 (time)
> contrib(running + runnable): contribution added when the task is in
> running and runnable states
>
>
> From these formulas, we can see that tse=E2=80=99s load_sum does not incl=
ude
> weight, while cfs_rq=E2=80=99s does. Their units differ, so they cannot b=
e
> directly added or subtracted. In addition, weight is a "historical
> variable" that changes over time, which means load_sum cannot be
> derived from se=E2=80=99s load_avg.
>
> To propagate load_sum changes from a child cfs_rq, the upstream
> implementation uses runnable_avg to APPROXIMATE load_sum. The
> derivation is as follows.
>
> For tse:
>
>                  runnable_sum
> runnable_avg =3D ----------------
>                    divider
>
>     decay(history) + contrib(running + runnable) * 1024
>   =3D ---------------------------------------------------
>                      divider
>
>      decay(history) + contrib(running + runnable)
>  ~=3D --------------------------------------------- * 1024
>                      divider
>
>
> Thus:
>
> decay(history) + contrib(running + runnable)
>
>
>      runnable_avg * divider
>  ~=3D -----------------------
>              1024
>
>
>  ~=3D (runnable_avg * divider) >> SCHED_CAPACITY_SHIFT        (1)
>
>
> Equation (1) represents the contribution when a task is in running or
> runnable state. The kernel refers to this as the "unweighted version
> of removed_load", which is essentially time with exponential decay
> applied.
>
> It is worth noting that equation (1) happens to be equal to tse=E2=80=99s
> load_sum. Therefore, for tse we have:
>
> load_sum ~=3D (runnable_avg * divider) >> SCHED_CAPACITY_SHIFT     (2)
>
> However, equation (2) itself is only an approximation, and the
> right-shift operation introduces further truncation error.
>
> My idea is that since the task=E2=80=99s load_sum already exists when it
> dequeues, it is more reasonable to record this value directly. By
> doing so, we can avoid both the approximation and the shift-induced
> error. This is the motivation behind introducing removed.load_sum in
> my patch.
>
>
>
>
> > Also we don't want to track both load_sum and load_avg, only one is
> > enough and by the above it is load_avg
> >
>
> My view is consistent with yours, but I personally lean towards
> keeping load_sum and deprecating load_avg, since load_avg does not
> seem to be accurate.
>
> That said, this is only my personal perspective and may not be
> comprehensive. I would like to further discuss the feasibility of this
> approach with you.
>
> Thanks.
> hupu

