Return-Path: <linux-kernel+bounces-883993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E32C2F087
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 03:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394783BE7C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 02:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7114925DB1A;
	Tue,  4 Nov 2025 02:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5i2yyJe"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4D25CC6C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 02:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762224847; cv=none; b=bEUE+mSJPXxzSXN/s8lfxGyD9r9kY2begAQJcrU10o+au0zqi/8csm7ob9eV2ntfN9vSwA9C0uD+IjNEDTPXcpRbiMhc+SByvaf0W9T79YR04cS5oE77uCCFlzn0popPWty3g4MPdE8AdLFQOGfwfsndH8yTqH+nuPfYheCOzQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762224847; c=relaxed/simple;
	bh=cPCFrz/Fw9OP083+a0MyGWj5PKzpsUWKqUCBCoIa77s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEcwlgYxtZBA4J5BpwwwAAKYbVzPy+p3KVInel0oYZ5t0nvxqxbY+3D8FPe2OE8BiIShZcxY0K9kXwDrWezXQcwD0ue5F79Gl7Qri7haxTYcTOyGdkTSwi2pWxrF+nC4ptFEfeLgmzFJdPbvJDskBOq/NEZSEw3s9dz8/TaAcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5i2yyJe; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5dbcd54d2d8so2848575137.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 18:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762224844; x=1762829644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0RngrDDDw8RzD2VHPuAYa9LZsFIzmsIlszLylz4l9U=;
        b=g5i2yyJeJc9YftbnqD6KRtH2ZmVxPOUjgkRyFL0zHKBlCDQoRh2DpqYEEznb2kfPXj
         Wr6XsyCGUPYXQL6ODFAkMkboccx8RPCyqxm+JSYCNsnWYAL1kR6apkizqHpHwiEchWWm
         LaBXyXLcPcoVq8XuU6yRek30xjyPIIod0q3RGHUssMQNbfuZTLugl24MUXYWYUE773aB
         +ooDRrQtiAmD3f1WT8lylGlmPUxWgrU6CoHhWwbejQH4UMdHW231mNfomiEZ7K0ZIu64
         6BG4FvQz0WoCvMtxl5JDpqJhYnyWCRKF1C5rZvR7JMjfGCia4vOyNk0xIUoA+dG28xSJ
         LnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762224844; x=1762829644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0RngrDDDw8RzD2VHPuAYa9LZsFIzmsIlszLylz4l9U=;
        b=Qz7ETFjP1jdUHMkgJk38Wdyd9kOXTKJrsBsZkq/nl6jtS/R2b+p4mSoFvGP8t/iUL3
         9FGDZK7QaAEfJ5tKm15zbiIMUzrin0x9UXyKpI+EBsDuPu5Tm/OuV6fVHZsRMNkbELpY
         ewsJlpWViI4+wl9SAicYvMjG0Dj7cYxmFoucPoRQWjRCEUZq+KA1hMFDUvqylrB/EvJZ
         qcL7VffLvJvvxcSjZ8qmEEoZ0w25KcfHwalhxKkBKdeheA9R7wo8tCQEFnWFa3BhrNnX
         4XiqOKLb2VsKEeQ9uZ8WUgQwz9DjfwnQOYq7gYYNGycRqQqUN61zpCABJ3YjE9TqbhXp
         GxBw==
X-Forwarded-Encrypted: i=1; AJvYcCX7XgzhhDUDYd29G2LSWjpw0oQNpJe9jSARK1vDJmHoHo3xBiBxUOeO26QesmETFqPYZTEdyYLtMhlPqek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd5RTwNljBj3j8crQjK7DO6odt/v+mxfKA8aCaUZonshZihu7z
	Z0X0YbwVk8DASzKaP7HkvIf+wjLu955dH/dWMw/VT1bFRmgpB6xNJpNKrvspthS6Oh2Bb3f6ey1
	/FpLZQe5+W6PDV3fOXu9XaAIyyKrsNnW/P4JdHdy5
X-Gm-Gg: ASbGncu3g5+AC59xmizUzotSZmQmCBQIqHujl2uW/b3lE3OvtshhZ56N9M7evQkKpCF
	ei5Lrkcz4N859KifTyCJUGtH6Jvl6PZ5F5ga/DfuDW3GqP9bXghapWpxrDpsTBNu52hl+LosRdk
	jNu12F1dNiQRmhrUkAhHr/rldQsJMGfTtrzkXeecEwbVyXhDcky8ZGfLQozpwyNYNJkZX4FSoix
	RYko8xnaVEwBAYtVKz9aDHoBgVVvb8pKfTfiKJZfkIm4R8Lms+JN/0sib30EFbcysg5pZzO3BFQ
	euhzU3RaIxQ0wGfv3rnCvI12qdeCTZSnvMZqRj4=
X-Google-Smtp-Source: AGHT+IFTxUwjmRjsT7V+qShhAHfWnugTZk4CjY8/1xWlKt1r7DCbRLBVAiEaSX0xLpAIPtxClGaJGTIQRyAfsg42+6o=
X-Received: by 2002:a05:6102:6cb:b0:5db:e6fa:f7fe with SMTP id
 ada2fe7eead31-5dbe6fafa2bmr1591631137.24.1762224844374; Mon, 03 Nov 2025
 18:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029185458.3040228-1-blakejones@google.com>
In-Reply-To: <20251029185458.3040228-1-blakejones@google.com>
From: Blake Jones <blakejones@google.com>
Date: Mon, 3 Nov 2025 18:53:53 -0800
X-Gm-Features: AWmQ_bkO412305cL-GO95mMWXLBhtDiW9xrrHY1GWKgUzQV_TKsZP126vR4cnIY
Message-ID: <CAP_z_CjGGU5O3JTnEdAadFAxfzXG08SxunB8XyOagW-hXwLqLg@mail.gmail.com>
Subject: Re: [PATCH v4] sched: reorder some fields in struct rq
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	Josh Don <joshdon@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Do you have any more questions or thoughts about this patch, after our
discussion of v3 last week?

Blake

On Wed, Oct 29, 2025 at 11:55=E2=80=AFAM Blake Jones <blakejones@google.com=
> wrote:
> This colocates some hot fields in "struct rq" to be on the same cache lin=
e
> as others that are often accessed at the same time or in similar ways.
>
> Using data from a Google-internal fleet-scale profiler, I found three
> distinct groups of hot fields in struct rq:
>
> - (1) The runqueue lock: __lock.
>
> - (2) Those accessed from hot code in pick_next_task_fair():
>       nr_running, nr_numa_running, nr_preferred_running,
>       ttwu_pending, cpu_capacity, curr, idle.
>
> - (3) Those accessed from some other hot codepaths, e.g.
>       update_curr(), update_rq_clock(), and scheduler_tick():
>       clock_task, clock_pelt, clock, lost_idle_time,
>       clock_update_flags, clock_pelt_idle, clock_idle.
>
> The cycles spent on accessing these different groups of fields broke down
> roughly as follows:
>
> - 50% on group (1) (the runqueue lock, always read-write)
> - 39% on group (2) (load:store ratio around 38:1)
> -  8% on group (3) (load:store ratio around 5:1)
> -  3% on all the other fields
>
> Most of the fields in group (3) are already in a cache line grouping; thi=
s
> patch just adds "clock" and "clock_update_flags" to that group. The field=
s
> in group (2) are scattered across several cache lines; the main effect of
> this patch is to group them together, on a single line at the beginning o=
f
> the structure. A few other less performance-critical fields (nr_switches,
> numa_migrate_on, has_blocked_load, nohz_csd, last_blocked_load_update_tic=
k)
> were also reordered to reduce holes in the data structure.
>
> Since the runqueue lock is acquired from so many different contexts, and =
is
> basically always accessed using an atomic operation, putting it on either
> of the cache lines for groups (2) or (3) would slow down accesses to thos=
e
> fields dramatically, since those groups are read-mostly accesses.
>
> This patch does not change the size of "struct rq" on machines with 64-by=
te
> cache lines. The additional "____cacheline_aligned" to put the runqueue
> lock on the next cache line will add an additional 64 bytes of padding on
> machines with 128-byte cache lines; although this is unfortunate, it seem=
ed
> more likely to lead to stably good performance than e.g. by just putting
> the runqueue lock somewhere in the middle of the structure and hoping it
> wasn't on an otherwise busy cache line.
>
> The "__no_randomize_layout" was added to reflect the fact that performanc=
e
> of this data structure is unusually sensitive to placement of its members=
.
>
> Signed-off-by: Blake Jones <blakejones@google.com>
> Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  kernel/sched/sched.h | 77 +++++++++++++++++++++++++++-----------------
>  1 file changed, 47 insertions(+), 30 deletions(-)
>
> v3 -> v4 changes:
> - Updated comment, moved "nr_iowait" to the end of the structure, and add=
ed
>   "__no_randomize_layout" tag to the structure.
>   Link to v3: https://lore.kernel.org/lkml/20251028080348.2177469-1-blake=
jones@google.com/T/#u
>   (v3 includes details of previous perf testing)
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e7718f12bc55..e1c3fefb14b7 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1114,28 +1114,50 @@ DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
>   * acquire operations must be ordered by ascending &runqueue.
>   */
>  struct rq {
> -       /* runqueue lock: */
> -       raw_spinlock_t          __lock;
> -
> -       /* Per class runqueue modification mask; bits in class order. */
> -       unsigned int            queue_mask;
> +       /*
> +        * The following members are loaded together, without holding the
> +        * rq->lock, in an extremely hot loop in update_sg_lb_stats()
> +        * (called from pick_next_task()). To reduce cache pollution from
> +        * this operation, they are placed together on this dedicated cac=
he
> +        * line. Even though some of them are frequently modified, they a=
re
> +        * loaded much more frequently than they are stored.
> +        */
>         unsigned int            nr_running;
>  #ifdef CONFIG_NUMA_BALANCING
>         unsigned int            nr_numa_running;
>         unsigned int            nr_preferred_running;
> -       unsigned int            numa_migrate_on;
>  #endif
> +       unsigned int            ttwu_pending;
> +       unsigned long           cpu_capacity;
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +       struct task_struct __rcu        *donor;  /* Scheduling context */
> +       struct task_struct __rcu        *curr;   /* Execution context */
> +#else
> +       union {
> +               struct task_struct __rcu *donor; /* Scheduler context */
> +               struct task_struct __rcu *curr;  /* Execution context */
> +       };
> +#endif
> +       struct task_struct      *idle;
> +       /* padding left here deliberately */
> +
> +       /*
> +        * The next cacheline holds the (hot) runqueue lock, as well as
> +        * some other less performance-critical fields.
> +        */
> +       u64                     nr_switches     ____cacheline_aligned;
> +
> +       /* runqueue lock: */
> +       raw_spinlock_t          __lock;
> +
>  #ifdef CONFIG_NO_HZ_COMMON
> -       unsigned long           last_blocked_load_update_tick;
> -       unsigned int            has_blocked_load;
> -       call_single_data_t      nohz_csd;
>         unsigned int            nohz_tick_stopped;
>         atomic_t                nohz_flags;
> +       unsigned int            has_blocked_load;
> +       unsigned long           last_blocked_load_update_tick;
> +       call_single_data_t      nohz_csd;
>  #endif /* CONFIG_NO_HZ_COMMON */
>
> -       unsigned int            ttwu_pending;
> -       u64                     nr_switches;
> -
>  #ifdef CONFIG_UCLAMP_TASK
>         /* Utilization clamp values based on CPU's RUNNABLE tasks */
>         struct uclamp_rq        uclamp[UCLAMP_CNT] ____cacheline_aligned;
> @@ -1158,6 +1180,9 @@ struct rq {
>         struct list_head        *tmp_alone_branch;
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>
> +#ifdef CONFIG_NUMA_BALANCING
> +       unsigned int            numa_migrate_on;
> +#endif
>         /*
>          * This is part of a global counter where only the total sum
>          * over all CPUs matters. A task can increase this counter on
> @@ -1166,36 +1191,31 @@ struct rq {
>          */
>         unsigned long           nr_uninterruptible;
>
> -#ifdef CONFIG_SCHED_PROXY_EXEC
> -       struct task_struct __rcu        *donor;  /* Scheduling context */
> -       struct task_struct __rcu        *curr;   /* Execution context */
> -#else
> -       union {
> -               struct task_struct __rcu *donor; /* Scheduler context */
> -               struct task_struct __rcu *curr;  /* Execution context */
> -       };
> -#endif
>         struct sched_dl_entity  *dl_server;
> -       struct task_struct      *idle;
>         struct task_struct      *stop;
>         unsigned long           next_balance;
>         struct mm_struct        *prev_mm;
>
> -       unsigned int            clock_update_flags;
> -       u64                     clock;
> -       /* Ensure that all clocks are in the same cache line */
> +       /* Per class runqueue modification mask; bits in class order. */
> +       unsigned int            queue_mask;
> +
> +       /*
> +        * The following fields of clock data are frequently referenced
> +        * and updated together, and should go on their own cache line.
> +        */
>         u64                     clock_task ____cacheline_aligned;
>         u64                     clock_pelt;
> +       u64                     clock;
>         unsigned long           lost_idle_time;
> +       unsigned int            clock_update_flags;
>         u64                     clock_pelt_idle;
>         u64                     clock_idle;
> +
>  #ifndef CONFIG_64BIT
>         u64                     clock_pelt_idle_copy;
>         u64                     clock_idle_copy;
>  #endif
>
> -       atomic_t                nr_iowait;
> -
>         u64 last_seen_need_resched_ns;
>         int ticks_without_resched;
>
> @@ -1206,8 +1226,6 @@ struct rq {
>         struct root_domain              *rd;
>         struct sched_domain __rcu       *sd;
>
> -       unsigned long           cpu_capacity;
> -
>         struct balance_callback *balance_callback;
>
>         unsigned char           nohz_idle_balance;
> @@ -1317,7 +1335,9 @@ struct rq {
>         call_single_data_t      cfsb_csd;
>         struct list_head        cfsb_csd_list;
>  #endif
> -};
> +
> +       atomic_t                nr_iowait;
> +} __no_randomize_layout;
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>
> --
> 2.51.2.997.g839fc31de9-goog
>

