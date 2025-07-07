Return-Path: <linux-kernel+bounces-720162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05692AFB7E0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5187A16CB02
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8722820FAAB;
	Mon,  7 Jul 2025 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRMGMHCO"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098420E6E2
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903361; cv=none; b=RIsWBXJPmJy3v4X8I1yCW60qzLOsg9PAgD7BzXUddzbDfCW9SHIFdT2/d0jcJJXOtANeITjxetRGU4zJh6DpZndVQmv7fIA7eMZVfrHmzg+iRBKmM4weKwrwl7XAxbpbeGw3YXB4rhEno/9L7kgoypIaDErlqniP7tJB6W8dHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903361; c=relaxed/simple;
	bh=uIz9YiagejmxAneifSVCZPWs1ki6QlxUEvfVKy2bKCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9frqGdWmJEagGWT+Vr41bsmvbJrWgAjsjAXWTYEkzheagdhVE6qjs13RbbdSqvTJdyltsCyxkI1XRkekFPoQXXBtxhfW1IF4Mlj2LX6XnzvJ7pbIbSuJfMKF4p2KkOGU7pdZWIfaEKuKflSCEUNZpeLbr80m4eInl78gLLM9/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BRMGMHCO; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso695233266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751903357; x=1752508157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NojYtulilTnBbnGOrUvW3XJmfQpL6dHc8t5CSUBwyq8=;
        b=BRMGMHCOA71+ew0/8qHkVMJoTxnpUInKdC9opBeoYZwOmk2jfLGN8Y0Wes4qLDm1xH
         VaemLaH/1ub8WR4dSc94HSsRYmDUtGIeLV4m1hAr9jty+FRCa0trf1k+HnZbBhmjNWG3
         zN/FDwj87rYH51gIawRZKZrt8YezO4z/sChC31rj7eLJiG8d/iNoFCK9N/A6CJsVKdiU
         A2nJmaZT5kMGAUQZGO0HHOcGPhKrDoL5C/rJO3xZtoYHTiVUyjncgem0xgERLARbCJYk
         jqtuuJWDHKr/uSkg4Q4JlgtVbaIJGZRotBTzu8Z/R3wQvn1LTcDgBD2znFagVsM30kba
         hO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903357; x=1752508157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NojYtulilTnBbnGOrUvW3XJmfQpL6dHc8t5CSUBwyq8=;
        b=Iqs8wU7VxYFC12EuVyxqq4CWPj0n5EepoOmdu+Xj2cs6+BmOAkOE3FRE9OKXyRDhP/
         Mxxv2kfeb5xgD0RQF8Q3hfHZoTm2oRySJ6ZV2rqHCmJv4ByM8N3cNuckE/atc4beQDo9
         zgfl5WjuDVKr7sS6Ev2jqty+RkRv1d/Jkzl1zTbLZT4Mx5gl4zQnolv6/8qvg5/hRjFD
         /wBlKdx6vNrm7sRNJbm5vjGyBiYYQwKw/S29Bd8dzDEYFiYsQOSOvHKlpVGgQ8J+ElcD
         6DXOWddxT2YyV/GNHnPL0O/Il6BA7elTxVWxdWWMzPBJwTe02eiH57eFnXI4u0IJ+HH+
         b4Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXb3iu3G3dJkL2Ozf6ZOzGzo4UTHm44ihKnEMCmEawv2yPFEEkUobh0X8xZ0ssgFYNXIDF3mVcbDcQ6jnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+QZIKMHy8ndI2FvwoYZAeuk+DaBXGYjbQUfHzQEK8di1GcOT
	ieD8tc2DzjzENwQafaUgEGQFYzSH5YuB+kFOtsD1mesz8lzO+TIoQQnt5h9Kk+VzWbiUYC1LMpd
	dAnQ42TP4wfFWRn/6O2lvllwGZ2TjxzhddUntrn0xbg==
X-Gm-Gg: ASbGncsPA/EGfyvo/4foGz8UVvHGISMLVB5p5Fa/vHgFTZSUa/cRJvTybI0IDPWfGSh
	OrD0vVjND/3O+3ojfLiq6Ub778uKMktutSMVAu9yc0VqNDw1Hd/Q1T84/hbjPfTdu14xv7bTH6m
	8DRtjIiTvwQjOBWeA/Zs6H/X7MVdPGDX7sGcUl99zEIl1hErVFN6cIaovCjaVE9zbh3qmJfBxw
X-Google-Smtp-Source: AGHT+IFY2w0gDOPOsRDRHdpJKztp8dQ11Pf9lm5KMAMFNZbwPa6oCKy5kvz+ppJck9Qp/d6N8pAofHoQxz+astnRDQg=
X-Received: by 2002:a17:907:7f22:b0:ae0:d4b1:b5f0 with SMTP id
 a640c23a62f3a-ae3fe6feef3mr1343396266b.35.1751903356601; Mon, 07 Jul 2025
 08:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704143612.998419-1-vincent.guittot@linaro.org> <20250707141441.GG1613200@noisy.programming.kicks-ass.net>
In-Reply-To: <20250707141441.GG1613200@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 7 Jul 2025 17:49:05 +0200
X-Gm-Features: Ac12FXzL6DBFI1cRarBbIyuTdLOpugoycS275GUW0tY869NHQfQpyiWhB4zi4aI
Message-ID: <CAKfTPtDD0J0NBipE7AsXxUHCSeKb3VR44o1tDc0nGkcDeR70Ew@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] sched/fair: Manage lag and run to parity with
 different slices
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	dhaval@gianis.ca, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 16:14, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 04, 2025 at 04:36:06PM +0200, Vincent Guittot wrote:
> > This follows the attempt to better track maximum lag of tasks in presence
> > of different slices duration:
> > [1]  https://lore.kernel.org/all/20250418151225.3006867-1-vincent.guittot@linaro.org/
> >
> > Since v1, tracking of the max slice has been removed from the patchset
> > because we now ensure that the lag of an entity remains in the range of:
> >
> >   [-(slice + tick) : (slice + tick)] with run_to_parity
> > and
> >   [max(-slice, -(0.7+tick) : max(slice , (0.7+tick)] without run to parity
> >
> > As a result, there is no need the max slice of enqueued entities anymore.
> >
> > Patch 1 is a simple cleanup to ease following changes.
> >
> > Patch 2 fixes the lag for NO_RUN_TO_PARITY. It has been put 1st because of
> > its simplicity. The running task has a minimum protection of 0.7ms before
> > eevdf looks for another task.
>
> The usage of min() on vruntimes is broken; it doesn't work right in the
> face of wrapping; use min_vruntime().

Good point. Don't know why I didn't use it

>
> Also, perhaps it is time to better document this vlag abuse.

will add something

>
> > Patch 3 ensures that the protection is canceled only if the waking task
> > will be selected by pick_task_fair. This case has been mentionned by Peter
> > will reviewing v1.
> >
> > Patch 4 modifes the duration of the protection to take into account the
> > shortest slice of enqueued tasks instead of the slice of the running task.
> >
> > Patch 5 fixes the case of tasks not being eligible at wakeup or after
> > migrating  but with a shorter slice. We need to update the duration of the
> > protection to not exceed the lag.
>
> This has issues with non-determinism; specifically,
> update_protected_slice() will use the current ->vruntime, and as such
> can unduly push forward the protection window.

se->vprot = min_vruntime(se->vprot, (se->vruntime +
calc_delta_fair(quantum, se)));

the min_vruntime (previously min) with current vprot (previously vlag)
should prevent pushing forward the protection. We can only reduce
further the vlag but never increase it

>
> > Patch 6 fixes the case of tasks still being eligible after the protected
> > period but others must run to no exceed lag limit. This has been
> > highlighted in a test with delayed entities being dequeued with a positive
> > lag larger than their slice but it can happen for delayed dequeue entity
> > too.
>
> At this point resched_next_quantum() becomes !protec_slice() and can be
> removed.

yes, it was the last remaining fix and forgot to  simplify

>
> How about something like so? I've probably wrecked the whole
> !RUN_TO_PARITY thing -- so that needs to be put back in.
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -579,7 +579,15 @@ struct sched_entity {
>         u64                             sum_exec_runtime;
>         u64                             prev_sum_exec_runtime;
>         u64                             vruntime;
> -       s64                             vlag;
> +       union {
> +               /*
> +                * When !@on_rq this field is vlag.
> +                * When cfs_rq->curr == se (which implies @on_rq)
> +                * this field is vprot. See protect_slice().
> +                */
> +               s64                     vlag;
> +               u64                     vprot;
> +       };
>         u64                             slice;
>
>         u64                             nr_migrations;
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -882,45 +882,36 @@ struct sched_entity *__pick_first_entity
>  }
>
>  /*
> - * HACK, Set the vruntime up to which an entity can run before picking another
> - * one, in vlag, which isn't used until dequeue.
> - * In case of run to parity, we use the shortest slice of the enqueued entities
> - * to define the longest runtime.
> - * When run to parity is disabled, we give a minimum quantum to the running
> - * entity to ensure progress.
> + * Take a snapshot of the vruntime at the point the task gets scheduled.
>   */
>  static inline void set_protect_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> -       u64 quantum;
> -
> -       if (sched_feat(RUN_TO_PARITY))
> -               quantum = cfs_rq_min_slice(cfs_rq);
> -       else
> -               quantum = normalized_sysctl_sched_base_slice;
> -       quantum = min(quantum, se->slice);
> -
> -       if (quantum != se->slice)
> -               se->vlag = min(se->deadline, se->vruntime + calc_delta_fair(quantum, se));
> -       else
> -               se->vlag = se->deadline;
> +       se->vprot = se->vruntime;
>  }
>
> -static inline void update_protect_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
> +/*
> + * Should we still run @se? It is allowed to run until either se->deadline or
> + * until se->vprot + min_vslice, whichever comes first.
> + */
> +static inline bool protect_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> -       u64 quantum = cfs_rq_min_slice(cfs_rq);
> +       u64 min_vslice, deadline = se->deadline;
> +       u64 min_slice = cfs_rq_min_slice(cfs_rq);
>
> -       se->vlag = min(se->vlag, (s64)(se->vruntime + calc_delta_fair(quantum, se)));
> -}
> +       if (min_slice != se->slice) {
> +               min_vslice = calc_delta_fair(min_slice, se);
> +               deadline = min_vruntime(se->deadline, se->vprot + min_vslice);

I didn't go into that direction because protect_slice() is call far
more often than set_protect_slice() or update_protect_slice()

> +       }
>
> -static inline bool protect_slice(struct sched_entity *se)
> -{
> -       return ((s64)(se->vlag - se->vruntime) > 0);
> +       WARN_ON_ONCE(!se->on_rq);
> +
> +       return ((s64)(deadline - se->vruntime) > 0);
>  }
>
> -static inline void cancel_protect_slice(struct sched_entity *se)
> +static inline void cancel_protect_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> -       if (protect_slice(se))
> -               se->vlag = se->vruntime;
> +       if (protect_slice(cfs_rq, se))
> +               se->vprot = se->vruntime - calc_delta_fair(NSEC_PER_SEC, se);
>  }
>
>  /*
> @@ -959,7 +950,7 @@ static struct sched_entity *__pick_eevdf
>         if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
>                 curr = NULL;
>
> -       if (curr && protect && protect_slice(curr))
> +       if (curr && protect && protect_slice(cfs_rq, curr))
>                 return curr;
>
>         /* Pick the leftmost entity if it's eligible */
> @@ -1183,14 +1174,6 @@ static inline void update_curr_task(stru
>         cgroup_account_cputime(p, delta_exec);
>  }
>
> -static inline bool resched_next_quantum(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> -{
> -       if (protect_slice(curr))
> -               return false;
> -
> -       return true;
> -}
> -
>  /*
>   * Used by other classes to account runtime.
>   */
> @@ -1251,7 +1234,7 @@ static void update_curr(struct cfs_rq *c
>         if (cfs_rq->nr_queued == 1)
>                 return;
>
> -       if (resched || resched_next_quantum(cfs_rq, curr)) {
> +       if (resched || !protect_slice(cfs_rq, curr)) {
>                 resched_curr_lazy(rq);
>                 clear_buddies(cfs_rq, curr);
>         }
> @@ -8729,7 +8712,7 @@ static void check_preempt_wakeup_fair(st
>          * If @p has a shorter slice than current and @p is eligible, override
>          * current's slice protection in order to allow preemption.
>          */
> -        do_preempt_short = sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice);
> +       do_preempt_short = sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice);
>
>         /*
>          * If @p has become the most eligible task, force preemption.
> @@ -8737,14 +8720,11 @@ static void check_preempt_wakeup_fair(st
>         if (__pick_eevdf(cfs_rq, !do_preempt_short) == pse)
>                 goto preempt;
>
> -       if (sched_feat(RUN_TO_PARITY) && do_preempt_short)
> -               update_protect_slice(cfs_rq, se);
> -
>         return;
>
>  preempt:
>         if (do_preempt_short)
> -               cancel_protect_slice(se);
> +               cancel_protect_slice(cfs_rq, se);
>
>         resched_curr_lazy(rq);
>  }

