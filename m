Return-Path: <linux-kernel+bounces-756175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65726B1B0D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7066E1722BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A60259CBA;
	Tue,  5 Aug 2025 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nAe7aA/X"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567B12E36E7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385464; cv=none; b=XH0wxUMpDIdhI+OLGNjRUfIu9FyDr4zn2EAi8QcPhV24VhwnlBIrUCuSvUF50QCVJZiAxP8CFkhPVgkPMO1gbtRN1d1/NFFvwp2p7mSgwl4UTfNcCjp0Mx9Ls6PxZbO5SV+AuzzxHramMUx7Z1oCJpmbVP7GA1piKB1iW4cePrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385464; c=relaxed/simple;
	bh=UYCWmIghk7XLTV9hOFoeu8oU/E+r50TUj1Z3quT4/Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaG25aGXkmahMNFH9qPcDUeIxDH9XtcP/Cfjxem51nY1TBayWdhYzsZFLr7likJUAQTPDHzRBNcpiygHuHu2TuLl84j9uj+svMdkvvPLQpiX9yoTuOB7LVCXvt+Mf2l3Bmann+n29dVTr7ZgC5Do53/zc87Upcedib3jtPktH38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nAe7aA/X; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af91a6b7a06so943393766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 02:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754385461; x=1754990261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KFhTWHBXCWBFnoD6BdM+WmXK3hWwJH6qZ9YaEhbj8VY=;
        b=nAe7aA/XINLdnQborWVcToc/Ny4Y9cfWLXCgNh88SYcAux7pIGD/c4qhEuoryWikUC
         iKvXJRL6I/prrcAs2+eYWZySRRRsWnUAQkoI0sf89kyM5PdmH9UOuZYKCT5rO+mLRnKM
         CsO+9/PiKtMtF4kmlUa4vNnRLzFxz1qaUUqSkL9YSZIYjVGOpDzhEJjMk7JH84UQ2Suc
         suEJl4jvWmU/EKqVP0eH9uXKmfzNCdkgkJexaCcVZVH2ebVBX7RD/EL4R4CUXQCiYt2Y
         OaPvk4P3iZLoL13tl39fbSsr7/U3Pr9aXqbp1qJhtHwAJE3nz6Ls33EYTiTtbAns7s3Q
         tVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754385461; x=1754990261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFhTWHBXCWBFnoD6BdM+WmXK3hWwJH6qZ9YaEhbj8VY=;
        b=bkAf1M7ggEf5P6KOj0pQVWmhNyt5vepZbgJeTLhOCrj226uT+vDcfai+8J/Hbyk2fL
         VDJYhI7RlcmzAWd7lpzlKR5HsTQ8wrYY4MBp3rrN2QjMawsRp+n9Ie2ahrCFqLnFe2jx
         wEnsrB2jFyT1TupOaWqp85y9mePdqgIqfaWobEDIa7RkJdW57VokvcOj0bJGpXvPbwmu
         Mv/ZiMExyjEdQOyFEkz6IYePCg78hZbm8Ws82mGqfleE8wpa333aGKyBi7RlUYnWcIEY
         StRavWjsZtOouUM47kH6hcRdB0NdMo/FVGwwsnU7HokhDD5PiqxSsPdDNx9rRdjsoAdk
         Xn9A==
X-Forwarded-Encrypted: i=1; AJvYcCUm98Y0TaMXQ6JFP3Xm2E5nCVXVjsH0od85EU+jvRZNi8MMrQ65ECFzWlsP0xSUykmQvFeROhKR10hIKr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdfVm5KSTfZNNOPvxUVyQwDkYz8ZMh/Vn5Byuk9CcZhZOFiyti
	0DzkXxd4kgeg/yfcHwq1V9xyhVPXADDImLgriB5Akfh5JcLb5VPnYq6Z9IDkx9cR0iKH2oQH3Ln
	rP5Tfgk0WGm0prAA31+9XACxRySLC+1WYVGIuiT08Sw==
X-Gm-Gg: ASbGncudGTSjhbjp5qssvqjwrUC0DziNfnWMpj9NIbZOzRBp7O9+OUH/A8FHP+rA8l/
	ARBXG3WDzN2CXgkPC9Q67XV5cItzfPMOhQBTrcxalDBWricHZ3w9yn9NUx49qF1S2tp6OPZg5Ou
	q+sO5F33YpfEAC0mJTN0kohSOcdZnxBwoliCCpVmw8Ug9G2a2R37wm5lcpiew65Z5s3f5JMQ6x2
	5tbxJylvHkvo5m7nGN0c30IoY5tzURWw9Aj6Bki3eVFxKI=
X-Google-Smtp-Source: AGHT+IGZtqBo3cjZ4Qn6Ax912agmq6WXrhLbffKrfagZR07vgNXNSmjcHWHg+6F+e9RvSGUR/MUv5LSEv/16tagpIn4=
X-Received: by 2002:a17:906:168c:b0:af9:71c2:9c3 with SMTP id
 a640c23a62f3a-af971c20d56mr454940566b.35.1754385460460; Tue, 05 Aug 2025
 02:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804130326.57523-1-xupengbo@oppo.com> <20250805090517.GA687566@bytedance>
In-Reply-To: <20250805090517.GA687566@bytedance>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 5 Aug 2025 11:17:29 +0200
X-Gm-Features: Ac12FXwwDGP6jUtv9TKzkrY2qe9H_E-7mgbFHFM2LDljOhY6Iqna4V3HEt0LR_8
Message-ID: <CAKfTPtDexWX5N0jaMRqVQEnURSaPhVa6XQr_TexpU2SGU-e=9A@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix unfairness caused by stalled
 tg_load_avg_contrib when the last task migrates out.
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: xupengbo <xupengbo@oppo.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 11:08, Aaron Lu <ziqianlu@bytedance.com> wrote:
>
> On Mon, Aug 04, 2025 at 09:03:26PM +0800, xupengbo wrote:
> > We added a function named update_tg_load_avg_immediately() that mimics
> > update_tg_load_avg(). In this function we remove the update interval
> > restriction from update_tg_load_avg() in order to update tg->load
> > immediately when the function is called. This function is only called in
> > update_load_avg(). In update_load_avg(), we should call
> > update_tg_load_avg_immediately() if flag & DO_DETACH == true and the task
> > is the last task in cfs_rq, otherwise we call update_tg_load_avg(). The
> > reason is as follows.
> >
> > 1. Due to the 1ms update period limitation in update_tg_load_avg(), there
> > is a possibility that the reduced load_avg is not updated to tg->load_avg
> > when a task migrates out.
> > 2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
> > calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
> > function cfs_rq_is_decayed() does not check whether
> > cfs->tg_load_avg_contrib is null. Consequently, in some cases,
> > __update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
> > updated to tg->load_avg.
> >
> > When these two events occur within the 1ms window (defined by
> > NSEC_PER_MSEC in update_tg_load_avg()) and no other tasks can migrate to
> > the CPU due to the cpumask constraints, the corresponding portion of
> > load_avg will never be subtracted from tg->load_avg. This results in an
> > inflated tg->load_avg and reduced scheduling entity (se) weight for the
> > task group. If the migrating task had a large weight, the task group's
> > share may deviate significantly from its expected value. This issue is
> > easily reproducible in task migration scenarios.
> >
>
> Agree this is a problem.
>
> > Initially, I discovered this bug on Android 16 (running kernel v6.12), and
> > was subsequently able to reproduce it on an 8-core Ubuntu 24.04 VM with
> > kernel versions v6.14 and v6.16-rc7. I believe it exists in any kernel
> > version that defines both CONFIG_FAIR_GROUP_SCHED and CONFIG_SMP.
> > I wrote a short C program which just does 3 things:
> >   1. call sched_setaffinity() to bound itself to cpu 1.
> >   2. call sched_setaffinity() to bound itself to cpu 2.
> >   3. endless loop.
> >
> > Here is the source code.
> > ```
> > \#define _GNU_SOURCE
> > \#include <sched.h>
> > \#include <unistd.h>
> > int main() {
> >   cpu_set_t cpuset;
> >   CPU_ZERO(&cpuset);
> >   CPU_SET(1, &cpuset);
> >   pid_t pid = gettid();
> >
> >   if (sched_setaffinity(pid, sizeof(cpu_set_t), &cpuset) == -1) {
> >     return 1;
> >   }
> >
> >   CPU_ZERO(&cpuset);
> >   CPU_SET(2, &cpuset);
> >
> >   if (sched_setaffinity(pid, sizeof(cpu_set_t), &cpuset) == -1) {
> >     return 1;
> >   }
> >   while (1)
> >     ;
> >   return 0;
> > }
> > ```
> >
> > Then I made a test script to add tasks into groups.
> > (Forgive me for just copying and pasting those lines but not using
> > a for-loop)
> >
> > ```
> > \#!/usr/bin/bash
> >
> > shares=100
> > pkill 'bug_test'
> > sleep 2
> > rmdir /sys/fs/cgroup/cpu/bug_test_{1..4}
> > mkdir /sys/fs/cgroup/cpu/bug_test_{1..4}
> >
> > echo $shares >/sys/fs/cgroup/cpu/bug_test_1/cpu.shares
> > echo $shares >/sys/fs/cgroup/cpu/bug_test_2/cpu.shares
> > echo $shares >/sys/fs/cgroup/cpu/bug_test_3/cpu.shares
> > echo $shares >/sys/fs/cgroup/cpu/bug_test_4/cpu.shares
> >
> > nohup ./bug_test &
> > proc1=$!
> > echo "$proc1" >/sys/fs/cgroup/cpu/bug_test_1/cgroup.procs
> > nohup ./bug_test &
> > proc2=$!
> > echo "$proc2" >/sys/fs/cgroup/cpu/bug_test_2/cgroup.procs
> > nohup ./bug_test &
> > proc3=$!
> > echo "$proc3" >/sys/fs/cgroup/cpu/bug_test_3/cgroup.procs
> > nohup ./bug_test &
> > proc4=$!
> > echo "$proc4" >/sys/fs/cgroup/cpu/bug_test_4/cgroup.procs
> >
> > ```
> >
> > After several repetitions of the script, we can find that some
> > processes have a smaller share of the cpu, while others have twice
> > that. This state is stable until the end of the process.
>
> I can reproduce it using your test code.
>
> > When a task is migrated from cfs_rq, dequeue_load_avg() will subtract its
> > avg.load_sum and avg.load_avg. Sometimes its load_sum is reduced to null
> > sometimes not. If load_sum is reduced to null, then this cfs_rq will be
> > removed from the leaf_cfs_rq_list soon. So __update_blocked_fair() can not
> > update it anymore.
> >
> > Link: https://lore.kernel.org/cgroups/20210518125202.78658-2-odin@uged.al/
> > In this patch, Odin proposed adding a check in cfs_rq_is_decayed() to
> > determine whether cfs_rq->tg_load_avg_contrib is null. However, it appears
> > that this patch was not merged. In fact, if there were a check in
> > cfs_rq_is_decayed() similar to the one in update_tg_load_avg() regarding
> > the size of the _delta_ value (see update_tg_load_avg()), this issue
> > could also be effectively resolved. This solution would block (2.),
> > because if delta is too large, cfs_rq_is_decayed() returns false, and the
> > cfs_rq remains in leaf_cfs_rq_list, ultimately causing
> > __update_blocked_fair() to update it outside the 1ms limit. The only
> > consideration is whether to add a check for cfs_rq->tg_load_avg_contrib in
> > cfs_rq_is_decayed(), which may increase coupling.
> >
>
> Performance wise, doing an immediate update to tg->load_avg on detach
> path should be OK because last time when I did those tests, the migration
> path that leads to updates to tg->load_avg is mostly from task wakeup path.
> I also did some quick tests using hackbench and netperf on an Intel EMR
> and didn't notice anything problematic regarding performance with your
> change here.
>
> With this said, I think adding cfs_rq->tg_load_avg_contrib check in
> cfs_rq_is_decayed() makes more sense to me, because if a cfs_rq still has

Adding a check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed()
makes more sense for me too because it doesn't bypass the ratelimit

> contrib to its tg but its load_avg is 0, it should stay in that list and
> have its contrib synced with its load_avg to zero when that 1ms window
> has passed by __update_blocked_fair() path.
>
> > Signed-off-by: xupengbo <xupengbo@oppo.com>
>
> Maybe add a fix tag for commit 1528c661c24b("sched/fair: Ratelimit
> update to tg->load_avg")?
>
> Thanks,
> Aaron
>
> > ---
> >  kernel/sched/fair.c | 50 ++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 49 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index b173a059315c..97feba367be9 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4065,6 +4065,45 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> >       return true;
> >  }
> >
> > +/* only called in update_load_avg() */
> > +static inline void update_tg_load_avg_immediately(struct cfs_rq *cfs_rq)
> > +{
> > +     long delta;
> > +     u64 now;
> > +
> > +     /*
> > +      * No need to update load_avg for root_task_group as it is not used.
> > +      */
> > +     if (cfs_rq->tg == &root_task_group)
> > +             return;
> > +
> > +     /* rq has been offline and doesn't contribute to the share anymore: */
> > +     if (!cpu_active(cpu_of(rq_of(cfs_rq))))
> > +             return;
> > +
> > +     /*
> > +      * Under normal circumstances, for migration heavy workloads, access
> > +      * to tg->load_avg can be unbound. Limit the update rate to at most
> > +      * once per ms.
> > +      * However when the last task is migrating from this cpu, we must
> > +      * update tg->load_avg immediately. Otherwise, if this cfs_rq becomes
> > +      * idle forever due to cpumask and is removed from leaf_cfs_rq_list,
> > +      * the huge mismatch between cfs_rq->avg.load_avg(which may be zero)
> > +      * and cfs_rq->tg_load_avg_contrib(stalled load_avg of last task)
> > +      * can never be corrected, which will lead to a significant value
> > +      * error in se.weight for this group.
> > +      * We retain this value filter below because it is not the main cause
> > +      * of this bug, so we are being conservative.
> > +      */
> > +     now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
> > +     delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> > +     if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> > +             atomic_long_add(delta, &cfs_rq->tg->load_avg);
> > +             cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
> > +             cfs_rq->last_update_tg_load_avg = now;
> > +     }
> > +}
> > +
> >  /**
> >   * update_tg_load_avg - update the tg's load avg
> >   * @cfs_rq: the cfs_rq whose avg changed
> > @@ -4449,6 +4488,8 @@ static inline bool skip_blocked_update(struct sched_entity *se)
> >
> >  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
> >
> > +static inline void update_tg_load_avg_immediately(struct cfs_rq *cfs_rq) {}
> > +
> >  static inline void clear_tg_offline_cfs_rqs(struct rq *rq) {}
> >
> >  static inline int propagate_entity_load_avg(struct sched_entity *se)
> > @@ -4747,9 +4788,16 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >               /*
> >                * DO_DETACH means we're here from dequeue_entity()
> >                * and we are migrating task out of the CPU.
> > +              *
> > +              * At this point, we have not subtracted nr_queued.
> > +              * If cfs_rq->nr_queued ==1, the last cfs task is being
> > +              * migrated from this cfs_rq.
> >                */
> >               detach_entity_load_avg(cfs_rq, se);
> > -             update_tg_load_avg(cfs_rq);
> > +             if (cfs_rq->nr_queued == 1)
> > +                     update_tg_load_avg_immediately(cfs_rq);
> > +             else
> > +                     update_tg_load_avg(cfs_rq);
> >       } else if (decayed) {
> >               cfs_rq_util_change(cfs_rq, 0);
> >
> > --
> > 2.43.0
> >

