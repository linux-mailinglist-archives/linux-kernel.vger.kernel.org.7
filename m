Return-Path: <linux-kernel+bounces-756166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1017B1B0BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A087A18EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F6D259CB2;
	Tue,  5 Aug 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i7AH72LS"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BBA1514DC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384940; cv=none; b=m7jUlcPuOAyZCPkpTcbSbJAqTTNydumCMx4fkc16IoYhy40ge2+ZYfbKHLO73zVXeFkMhhBm8HxhyPAQ8v4aN7fo6oa/q7HPy2d8obWlcobV1Evqo0dH0nStxVTPYhCSpirL5MkqvWUABZRV9Jo+ARtGZ0jk+3CUZ4iEGWoshsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384940; c=relaxed/simple;
	bh=ZMgNQDgkQJmkePkHnKt56kuXyoYutC/VIuVZUP6kL3g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y37D6n9YWbk0hA6IkIkVSQqt2GdDuRMTycXLyWN+lOHcdKT30F+5PfkdgZHWxQLQKqy+SXn0eX+pitEx/mOtg+ayZU5S6NDQWX7xdghumwXjM/7xhqjlbmEkj7nvjAnSqAYeTXebQs3udxLjGag+ESLUShFI48J+128e1oa5ZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=i7AH72LS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23636167afeso35908945ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 02:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754384938; x=1754989738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nmvTu8J17MsrjPnltOR23SziTXhWiFiiubrIRb4OpbM=;
        b=i7AH72LSXk4ifXvyHTs0fn42ztAxAVtPKMBiFzuAD1KL2bC3AfjlKde6t7fH0sWM4u
         XwEILIc2SQvqbRPX/aYtiJvFNIMHfxnaXG5bguII5OO57c4mQ6jErE+wNv4lbEOLdgql
         ZJR7p+/h6MlCRsLxPe8sh2S0gWlG5AtkNzwz7mflxS8h+lwHNLM6SuAimiuAWa+QHV3b
         7YczfpT6xysMo6YUECjeomplCkYSSJpv/qHbkVj7PJOo8Z68RAXWniqjiNcMXBPv//gc
         HnvGI2TemSQ1zgbyttTaGfHRIzQbcnYgks3gaK24uneUVSaI982svfp5nwfo3ZAWv4iv
         vW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754384938; x=1754989738;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmvTu8J17MsrjPnltOR23SziTXhWiFiiubrIRb4OpbM=;
        b=U97QTIlylJUnMUHLImJwdNsC6cO5iQteR2Ofj9Ote8LmB584Gz7lBvAKFyVvIxGqUq
         ENYaP6zHc+idbJIFih2UXdyd5WoO6K23J7YpR8CUg2VVrMRd9SKmgLv7mFW0ZS/ViUNC
         9fvVQleybBxcBEGAaZMTCSzRQV/CL8FJuBSvEM7b9sbK3dwKoGPVkFFaY/s2xYWkY4iP
         y0+VZAm2zURuGh6LQMpYdfqkFqD0vCaS7EzHNOTyfi1zFObZNeVRJ67EJvB9SubU+KtK
         PjZFHRYjWwDbNZYNRGBsgI5ZYpZb34UlrzwLNpaPyJb94ln47c6zUdHSaKNhU/baLq45
         y8ng==
X-Forwarded-Encrypted: i=1; AJvYcCUDVWfMwCPOAwVyG4/l7IbsFORjjOpjvSdSIfU6BJO+/4B9xPxF3mMoVtoKp51jLgIognn0YqPrysIWK7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbY6FHE9is1o7JlNofn+eO+CmfUIPuBsdcwewtMUDgsUiqhqK/
	6NhedI3Zi9dQIYkV54wCvY4tz8pww5eSARERyw78HBfgdKW5FutW17l7PTXk40fCbg==
X-Gm-Gg: ASbGnctzQznBXfcFUu3M2fK8oZX2CEDhltlqkbedr+FsYvhdJI/6p1qFQ4RvN0dgNzZ
	AzYrbI2trTxEnYtOD2qRMy2OCRhC0f1cqiPFodctudo4skWSQc2CFG8lMj+MYDwqrEBYyJRF9Na
	aeSFJxcuXxM3dr6liCoC0a1vncckb3PfbXFok+VvU5NkgchtkuwGAMJTNc+keN/0FrNtAA6TzHs
	1yRx0SRrJ0rKkZq2IH+JRIPa4467T8YCEYK0ZjKh3eya9cl5N2vlqQFuR8HgasuJAM7/uoJxP2w
	hOlSFHYWetU7EKdXFVYs4jQNdX1Rdku/7PZHp0Af0N84pYwcTFReTvR5DSTXXiBUPqBAtPiGn+F
	eVkKjLy4KIHcFR86SAVKDuhguqKoeGhJMRnppNMnIjD8=
X-Google-Smtp-Source: AGHT+IHQX75mHJ/fN4WXC11ph9Iaz/hrjihHVF2dCEZcrYnMXfV2Rzh4GbdrvU9udExH+61jRko3kA==
X-Received: by 2002:a17:902:e889:b0:23d:fa76:5c3b with SMTP id d9443c01a7336-24246f721fbmr196540125ad.22.1754384938296;
        Tue, 05 Aug 2025 02:08:58 -0700 (PDT)
Received: from bytedance ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef7557sm126977585ad.19.2025.08.05.02.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:08:57 -0700 (PDT)
Date: Tue, 5 Aug 2025 17:08:40 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: xupengbo <xupengbo@oppo.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix unfairness caused by stalled
 tg_load_avg_contrib when the last task migrates out.
Message-ID: <20250805090517.GA687566@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804130326.57523-1-xupengbo@oppo.com>

On Mon, Aug 04, 2025 at 09:03:26PM +0800, xupengbo wrote:
> We added a function named update_tg_load_avg_immediately() that mimics
> update_tg_load_avg(). In this function we remove the update interval
> restriction from update_tg_load_avg() in order to update tg->load
> immediately when the function is called. This function is only called in
> update_load_avg(). In update_load_avg(), we should call
> update_tg_load_avg_immediately() if flag & DO_DETACH == true and the task
> is the last task in cfs_rq, otherwise we call update_tg_load_avg(). The
> reason is as follows.
> 
> 1. Due to the 1ms update period limitation in update_tg_load_avg(), there
> is a possibility that the reduced load_avg is not updated to tg->load_avg
> when a task migrates out.
> 2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
> calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
> function cfs_rq_is_decayed() does not check whether
> cfs->tg_load_avg_contrib is null. Consequently, in some cases,
> __update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
> updated to tg->load_avg.
> 
> When these two events occur within the 1ms window (defined by
> NSEC_PER_MSEC in update_tg_load_avg()) and no other tasks can migrate to
> the CPU due to the cpumask constraints, the corresponding portion of
> load_avg will never be subtracted from tg->load_avg. This results in an
> inflated tg->load_avg and reduced scheduling entity (se) weight for the
> task group. If the migrating task had a large weight, the task group's
> share may deviate significantly from its expected value. This issue is
> easily reproducible in task migration scenarios.
>

Agree this is a problem.

> Initially, I discovered this bug on Android 16 (running kernel v6.12), and
> was subsequently able to reproduce it on an 8-core Ubuntu 24.04 VM with
> kernel versions v6.14 and v6.16-rc7. I believe it exists in any kernel
> version that defines both CONFIG_FAIR_GROUP_SCHED and CONFIG_SMP.
> I wrote a short C program which just does 3 things:
>   1. call sched_setaffinity() to bound itself to cpu 1.
>   2. call sched_setaffinity() to bound itself to cpu 2.
>   3. endless loop.
> 
> Here is the source code.
> ```
> \#define _GNU_SOURCE
> \#include <sched.h>
> \#include <unistd.h>
> int main() {
>   cpu_set_t cpuset;
>   CPU_ZERO(&cpuset);
>   CPU_SET(1, &cpuset);
>   pid_t pid = gettid();
> 
>   if (sched_setaffinity(pid, sizeof(cpu_set_t), &cpuset) == -1) {
>     return 1;
>   }
> 
>   CPU_ZERO(&cpuset);
>   CPU_SET(2, &cpuset);
> 
>   if (sched_setaffinity(pid, sizeof(cpu_set_t), &cpuset) == -1) {
>     return 1;
>   }
>   while (1)
>     ;
>   return 0;
> }
> ```
> 
> Then I made a test script to add tasks into groups.
> (Forgive me for just copying and pasting those lines but not using
> a for-loop)
> 
> ```
> \#!/usr/bin/bash
> 
> shares=100
> pkill 'bug_test'
> sleep 2
> rmdir /sys/fs/cgroup/cpu/bug_test_{1..4}
> mkdir /sys/fs/cgroup/cpu/bug_test_{1..4}
> 
> echo $shares >/sys/fs/cgroup/cpu/bug_test_1/cpu.shares
> echo $shares >/sys/fs/cgroup/cpu/bug_test_2/cpu.shares
> echo $shares >/sys/fs/cgroup/cpu/bug_test_3/cpu.shares
> echo $shares >/sys/fs/cgroup/cpu/bug_test_4/cpu.shares
> 
> nohup ./bug_test &
> proc1=$!
> echo "$proc1" >/sys/fs/cgroup/cpu/bug_test_1/cgroup.procs
> nohup ./bug_test &
> proc2=$!
> echo "$proc2" >/sys/fs/cgroup/cpu/bug_test_2/cgroup.procs
> nohup ./bug_test &
> proc3=$!
> echo "$proc3" >/sys/fs/cgroup/cpu/bug_test_3/cgroup.procs
> nohup ./bug_test &
> proc4=$!
> echo "$proc4" >/sys/fs/cgroup/cpu/bug_test_4/cgroup.procs
> 
> ```
>
> After several repetitions of the script, we can find that some
> processes have a smaller share of the cpu, while others have twice
> that. This state is stable until the end of the process.
 
I can reproduce it using your test code.
 
> When a task is migrated from cfs_rq, dequeue_load_avg() will subtract its
> avg.load_sum and avg.load_avg. Sometimes its load_sum is reduced to null
> sometimes not. If load_sum is reduced to null, then this cfs_rq will be
> removed from the leaf_cfs_rq_list soon. So __update_blocked_fair() can not
> update it anymore.
> 
> Link: https://lore.kernel.org/cgroups/20210518125202.78658-2-odin@uged.al/
> In this patch, Odin proposed adding a check in cfs_rq_is_decayed() to
> determine whether cfs_rq->tg_load_avg_contrib is null. However, it appears
> that this patch was not merged. In fact, if there were a check in
> cfs_rq_is_decayed() similar to the one in update_tg_load_avg() regarding
> the size of the _delta_ value (see update_tg_load_avg()), this issue
> could also be effectively resolved. This solution would block (2.),
> because if delta is too large, cfs_rq_is_decayed() returns false, and the
> cfs_rq remains in leaf_cfs_rq_list, ultimately causing
> __update_blocked_fair() to update it outside the 1ms limit. The only
> consideration is whether to add a check for cfs_rq->tg_load_avg_contrib in
> cfs_rq_is_decayed(), which may increase coupling.
>

Performance wise, doing an immediate update to tg->load_avg on detach
path should be OK because last time when I did those tests, the migration
path that leads to updates to tg->load_avg is mostly from task wakeup path.
I also did some quick tests using hackbench and netperf on an Intel EMR
and didn't notice anything problematic regarding performance with your
change here.

With this said, I think adding cfs_rq->tg_load_avg_contrib check in
cfs_rq_is_decayed() makes more sense to me, because if a cfs_rq still has
contrib to its tg but its load_avg is 0, it should stay in that list and
have its contrib synced with its load_avg to zero when that 1ms window
has passed by __update_blocked_fair() path.

> Signed-off-by: xupengbo <xupengbo@oppo.com>

Maybe add a fix tag for commit 1528c661c24b("sched/fair: Ratelimit
update to tg->load_avg")?

Thanks,
Aaron

> ---
>  kernel/sched/fair.c | 50 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..97feba367be9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4065,6 +4065,45 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  	return true;
>  }
>  
> +/* only called in update_load_avg() */
> +static inline void update_tg_load_avg_immediately(struct cfs_rq *cfs_rq)
> +{
> +	long delta;
> +	u64 now;
> +
> +	/*
> +	 * No need to update load_avg for root_task_group as it is not used.
> +	 */
> +	if (cfs_rq->tg == &root_task_group)
> +		return;
> +
> +	/* rq has been offline and doesn't contribute to the share anymore: */
> +	if (!cpu_active(cpu_of(rq_of(cfs_rq))))
> +		return;
> +
> +	/*
> +	 * Under normal circumstances, for migration heavy workloads, access
> +	 * to tg->load_avg can be unbound. Limit the update rate to at most
> +	 * once per ms.
> +	 * However when the last task is migrating from this cpu, we must
> +	 * update tg->load_avg immediately. Otherwise, if this cfs_rq becomes
> +	 * idle forever due to cpumask and is removed from leaf_cfs_rq_list,
> +	 * the huge mismatch between cfs_rq->avg.load_avg(which may be zero)
> +	 * and cfs_rq->tg_load_avg_contrib(stalled load_avg of last task)
> +	 * can never be corrected, which will lead to a significant value
> +	 * error in se.weight for this group.
> +	 * We retain this value filter below because it is not the main cause
> +	 * of this bug, so we are being conservative.
> +	 */
> +	now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
> +	delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> +	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> +		atomic_long_add(delta, &cfs_rq->tg->load_avg);
> +		cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
> +		cfs_rq->last_update_tg_load_avg = now;
> +	}
> +}
> +
>  /**
>   * update_tg_load_avg - update the tg's load avg
>   * @cfs_rq: the cfs_rq whose avg changed
> @@ -4449,6 +4488,8 @@ static inline bool skip_blocked_update(struct sched_entity *se)
>  
>  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
>  
> +static inline void update_tg_load_avg_immediately(struct cfs_rq *cfs_rq) {}
> +
>  static inline void clear_tg_offline_cfs_rqs(struct rq *rq) {}
>  
>  static inline int propagate_entity_load_avg(struct sched_entity *se)
> @@ -4747,9 +4788,16 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  		/*
>  		 * DO_DETACH means we're here from dequeue_entity()
>  		 * and we are migrating task out of the CPU.
> +		 *
> +		 * At this point, we have not subtracted nr_queued.
> +		 * If cfs_rq->nr_queued ==1, the last cfs task is being
> +		 * migrated from this cfs_rq.
>  		 */
>  		detach_entity_load_avg(cfs_rq, se);
> -		update_tg_load_avg(cfs_rq);
> +		if (cfs_rq->nr_queued == 1)
> +			update_tg_load_avg_immediately(cfs_rq);
> +		else
> +			update_tg_load_avg(cfs_rq);
>  	} else if (decayed) {
>  		cfs_rq_util_change(cfs_rq, 0);
>  
> -- 
> 2.43.0
> 

