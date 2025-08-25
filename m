Return-Path: <linux-kernel+bounces-784200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAF5B337FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C864175E54
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F16296BD8;
	Mon, 25 Aug 2025 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rUWh3VxZ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE362566E9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756107757; cv=none; b=NxJLvPnygoUd8h8Gx/IiRMC0ZYumQG3HAcUCuT+Z/7+jzR5O7nB+MOQgO8HWlTOEzpvykvZcEFUfVRPBtWWoQVIVOJwD91xSJ5zAPr51xtCj+2DQjuD/I9Ns4NTeLDkVk7OcGr2oDX2561UsF3bF1WEMc2bqnbOIqIXsmKG6oAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756107757; c=relaxed/simple;
	bh=+piRMyk996oarQcrywspO+vsQru2/x0PtBUGXUFMQLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqRUNiVDB+q7lJTtQGxtiKQsFB7dzSM+dxNpfZjT//vu6W068gwOFJyPMI//hr/qKBjPl/IfFUiPSFFn+f0OHAXLEpE9haXi0uAQtj3gZIwhwk4wuTvbJlX7TaQ2oQlNSYCdqCg39t72oifL+6bRWEgqAQrjzuc3oj93RqnZ+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rUWh3VxZ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so4832894a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 00:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756107754; x=1756712554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G2EmfZstt/z8tWivV5ddyDVrQKEzNnXfSR1j/m6PBPk=;
        b=rUWh3VxZEpud+buWPv9NpBxJ6uMVXOYdTpIo7s8QkDXKtX978WEVPnRiaKAFcCNti5
         J3JuXWGjh2BVznsxIMB1sCYv7kSf2kEnjYzSz+qlFAjVyQE6GergNhJgUsbuCsz0kCSQ
         2ujXtp8+V29qa1QQ9dXe/4q7Fd6ycx02v1kT5kKuToPPQx21GgvTbR+iR2byXpSmB+qG
         Dsai4fc3YnmeOS1szhQwwNiD2yRo94pueALLu/IPBDZkTyqMezZwTSLtYM/1okqRXJc3
         P+xYPcK1D1WIFi65H3ySSyiGEwjhw8dmixsHKVnsykxP6NB3H8joMEGjPO+KKyMJc2md
         Ygag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756107754; x=1756712554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2EmfZstt/z8tWivV5ddyDVrQKEzNnXfSR1j/m6PBPk=;
        b=EtS5fkHftlx0caz87S2mjpZlblFLY1K5OiDc4uTcoxjGEv/bAPno8qvQbNyf4vlvY1
         uLd9ZABZje0WSI91AoaorwnmGe40/VlHacNUyX9HpL2NstQrn15X+If2KqvVDejiqc6w
         hA9XK2fi/smDICwPWjarXLZkCN2r8m/7x7nyR914UFc/4tm7OU9NouFDfxTiXVmZOHJ9
         uXZEvpoOZGvWsuG5jBhqwjbjs8Uequ1QN09G/XkIW7kzNyguTFGqDtKDlLIIjUgptTCh
         sEvKKowaEN+HUzKBz4ujKl/uyyQqK9Dg/JyktraJQNCYm/ft5ZNH6C/6iOpXu0/W463F
         PQdg==
X-Forwarded-Encrypted: i=1; AJvYcCUOQT8G974ghayi+XZpgV5Q3DrKIMnurZPceCtAzJ/5VZlb5pXTm6o1JmTrBq8Iv1cclAYtyXEWbsfYtU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf7MTap0guZsY0uzDCxQ9GF/z135bJIBnmhPuBcb0juzkilrJZ
	gPxcXwDx9yK2M2z07QnFwPQWwuXop9ceyuPLAH08iJS7+mVD5C82VNR1U/A1Y2fSLuBfTWLTJi/
	Rt/ipknsjdfoeFPl0b1xMd7IMV7AWjRLL+oVLm8weGQ==
X-Gm-Gg: ASbGncv22o14N+5c5v9grnjv+lAs3bciJlhjPKsNgybfs0Nc7Hs7oRVZ4O0fFvwlQdo
	pZ9JpJDRi7KT6j1zOLK+FNkTtAM9/XCFZ9GqLwXN8JCvNjj7nFkHs7JCt8DPZyWcfN1IBM3oy+n
	QVfL7V3NpFNszk3vohYyXLuSLa9wpGB7UjN0L8tD8goxXIZIDihfjW12i4oW1UE9J46HflNnl+U
	C3dYTUbKG7l/P2nQCtwQhakTAr23ebQ/y3wtOJXq9swJ7E=
X-Google-Smtp-Source: AGHT+IEH0WVgPD6c/Mjdpyb/eF5VATXLdRsxaboB8Iu4b3QUipIjqYn7VvvJjf0qKIiH04WPs5t3rHqKmP6xZm9hqWU=
X-Received: by 2002:a05:6402:3492:b0:61c:6ecf:79dc with SMTP id
 4fb4d7f45d1cf-61c6ecf9073mr1539700a12.26.1756107754092; Mon, 25 Aug 2025
 00:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818124702.163271-1-chengming.zhou@linux.dev>
In-Reply-To: <20250818124702.163271-1-chengming.zhou@linux.dev>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 25 Aug 2025 09:42:21 +0200
X-Gm-Features: Ac12FXyrO1tWMo0QYCpxOf8f4paPwsN9S1LtfKAhQLQsYNpdpzSNyduMsFfQx9A
Message-ID: <CAKfTPtAU4UG+wVSQcqucpkRVZBiNwLkG=eEOkv7DJ4+6wNjghg@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: Remove sched_idle_cpu() usages in select_task_rq_fair()
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 14:47, Chengming Zhou <chengming.zhou@linux.dev> wrote:
>
> These sched_idle_cpu() considerations in select_task_rq_fair() is based
> on an assumption that the wakee task can pick a cpu running sched_idle
> task and preempt it to run, faster than picking an idle cpu to preempt
> the idle task.
>
> This assumption is correct, but it also brings some problems:
>
> 1. work conservation: Often sched_idle tasks are also picking the cpu
> which is already running sched_idle task, instead of utilizing a real
> idle cpu, so work conservation is somewhat broken.

But this will be fixed by next idle load balancing, won't it ?

Keep in mind that sched_idle task has a particular meaning to not
preempt other task and use a very low share

>
> 2. sched_idle group: This sched_idle_cpu() is just not correct with
> sched_idle group running. Look a simple example below.
>
>                 root
>         /               \
>         kubepods        system
>         /       \
> burstable       besteffort
>                 (cpu.idle == 1)
>
> When a sched_idle cpu is just running tasks from besteffort group,
> sched_idle_cpu() will return true in this case, but this cpu pick
> is bad for wakee task from system group. Because the system group
> has lower weight than kubepods, work conservation is somewhat
> broken too.

sched_idle task in non sched_idle group has always been a problem
because people wants those task to be preempted immediately but they
also give it more weight than just what sched_idle provide with the
weight of their parent group

>
> In a nutshell, sched_idle_cpu() should consider the wakee task group's
> relationship with sched_idle tasks running on the cpu.
>
> Obviously, it's hard to do so. This patch chooses the simple approach
> to remove all sched_idle_cpu() considerations in select_task_rq_fair()
> to bring back work conservation in these cases.

No, CPU with only sched_idle tasks should be considered as idle CPUs
from a scheduling PoV. You need to find another way to fix it.  Why
don't you use batch task but sched_idle if those sched_idle tasks are
finally more important than just using remaining cycles on CPUs ?

>
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
> ---
>  kernel/sched/fair.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..d9de63cdc314 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7355,9 +7355,6 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>                 if (!sched_core_cookie_match(rq, p))
>                         continue;
>
> -               if (sched_idle_cpu(i))
> -                       return i;
> -
>                 if (available_idle_cpu(i)) {
>                         struct cpuidle_state *idle = idle_get_state(rq);
>                         if (idle && idle->exit_latency < min_exit_latency) {
> @@ -7446,7 +7443,7 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
>
>  static inline int __select_idle_cpu(int cpu, struct task_struct *p)
>  {
> -       if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
> +       if (available_idle_cpu(cpu) &&
>             sched_cpu_cookie_match(cpu_rq(cpu), p))
>                 return cpu;
>
> @@ -7519,13 +7516,9 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>         for_each_cpu(cpu, cpu_smt_mask(core)) {
>                 if (!available_idle_cpu(cpu)) {
>                         idle = false;
> -                       if (*idle_cpu == -1) {
> -                               if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
> -                                       *idle_cpu = cpu;
> -                                       break;
> -                               }
> +                       if (*idle_cpu == -1)
>                                 continue;
> -                       }
> +
>                         break;
>                 }
>                 if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
> @@ -7555,7 +7548,7 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
>                  */
>                 if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
>                         continue;
> -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> +               if (available_idle_cpu(cpu))
>                         return cpu;
>         }
>
> @@ -7677,7 +7670,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>         for_each_cpu_wrap(cpu, cpus, target) {
>                 unsigned long cpu_cap = capacity_of(cpu);
>
> -               if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
> +               if (!available_idle_cpu(cpu))
>                         continue;
>
>                 fits = util_fits_cpu(task_util, util_min, util_max, cpu);
> @@ -7748,7 +7741,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>          */
>         lockdep_assert_irqs_disabled();
>
> -       if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> +       if (available_idle_cpu(target) &&
>             asym_fits_cpu(task_util, util_min, util_max, target))
>                 return target;
>
> @@ -7756,7 +7749,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>          * If the previous CPU is cache affine and idle, don't be stupid:
>          */
>         if (prev != target && cpus_share_cache(prev, target) &&
> -           (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> +           available_idle_cpu(prev) &&
>             asym_fits_cpu(task_util, util_min, util_max, prev)) {
>
>                 if (!static_branch_unlikely(&sched_cluster_active) ||
> @@ -7788,7 +7781,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         if (recent_used_cpu != prev &&
>             recent_used_cpu != target &&
>             cpus_share_cache(recent_used_cpu, target) &&
> -           (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
> +           available_idle_cpu(recent_used_cpu) &&
>             cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
>             asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
>
> --
> 2.20.1
>

