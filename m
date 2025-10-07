Return-Path: <linux-kernel+bounces-843752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7453BC0276
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 06:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91AAC1896CC2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 04:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881FC218ACA;
	Tue,  7 Oct 2025 04:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="p0tTIUU0"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA5734BA3A
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 04:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759811299; cv=none; b=YH39nFisrGPKVq0bNg/zvzcMFTNzdUf8pCz1MC1ozttJ+ZdBsaUwPNYbBFZXfWIEVWRY0VZZXgMiZFLJcBLYJvoN8Rq3r3iiN+LoV3Wf5aRSH4UGcxF/+Wd5XnvdYwHwjREV31UNdRw/zjkLUzDuSBh72xCBbqFlavMjFy6DS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759811299; c=relaxed/simple;
	bh=9yVzn3ZpIshopjvvzCxG+1nC99jPfO2oOkje86bLalw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVu8QzXpganPqpguWwKByFgenA7BT/0xFiAZxd6SaWGzZi39pVw4dqDkP51BUIiVV/7G8hiONeMpWZkOrdeqE2s2yenaL6FCJvgiuM733qwv3AQ5rRTGGMclInbQJkyv09PJoNQFSUZtSw2qqmFPHeMr8V10f2A4cvMhyXoIhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=p0tTIUU0; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d60501806so64040597b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 21:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1759811295; x=1760416095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24nmEMKW5sAHhorNG5XT+pmsvvkx9tjAqyzOdDrY5Ik=;
        b=p0tTIUU0AFSKc4ya/ZPFmrP+MJgyFXdsJ2Rxs+4sUqR9p61yUKUAMgVjrBpWh1dOQq
         MX/mtNQsCtkEwv+4N+H8yU3v0YtMjkIj73gGNHClhNKUOwdQTq3Oer9uDo+jMYRHvWcV
         ryYs2TivyL0C86W+6QFreDJmMndA+oAGhcoQexiWuolLpjrrGpOL1n97Qd6EECHPce18
         mv0FJmqkUvEObTNde0R2pjrnb2ZlVFvYHl+6uR5xDj2deWdlRMaQoNdjTd1NUo7+jJZ6
         29KI6E9QCgcVTS5Bupy8lj+/Z3fIBfbolErHrx/+hjFKc4BRg09i+hGNzuy5NMsfH0ow
         JxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759811295; x=1760416095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24nmEMKW5sAHhorNG5XT+pmsvvkx9tjAqyzOdDrY5Ik=;
        b=qBfObsypEI6002/z/FfV6GnpN4JeuRs68m9UprGAyp3EDWDIyd5N+Kp5OC8P6LB0mn
         pugX2giRyQ4uk+rG67uNzBdqO5kIfjtTAL3AQ0rk48LNghgpcW5OFXNCdCN7vdOZ6QIy
         3iwc/75U1haMeTOkPlqXJ5kn7F2crrTktV2BPZo4+Pmnt9NKMVheRq1pnvfnpEL3GhTP
         bPJ/zI12sSaXvs/UBP4sMTTGl+he8lsCJ+p8xqeVOVJjzetPQG8pKz0X+bgCqimjH0z4
         cA+CZhXCDPua7vPO7gFZvjCbYB1Gq4mBbluHKBtfZ8aFvzoOhg04HZGnsYhPdvFMSYSj
         dICQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtscUMsBPobm1Pob3/y1EVtSzj1fqs6Ji8UhxaQeMBYA/7j1h5xEXW1iB9oKRnEJ0+cq5YZyi3Qbv+WQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcSS+PNOHIt/HyAxCK5SKuMYd0YRB4i3AhjcJEbW+AlEr7TJk6
	yL5LMnGFn/LDZs0vmVWcqBZE93D5G1VoJJourClkv2i2i/EXxb4Np7mw4PuEmD6mjOah3avUz0E
	KF3+s1K4OPioXEsZnRx2q3dgsiuUFKRN5jVAxGucR9g==
X-Gm-Gg: ASbGncujQBUm7Vg5TQbU6wFOIW2zlV5VL6el5rBLC2TvUS+lZb2q0tzjsLJ3KAKQwtL
	xF6V8WWBAXhbt1KPC6IFEwCri8m2hp6LQ5mHYJnT8+nXY2Ege7BF3hEKm995sM34/dtSpBvvLLE
	GhyPuHqonfIpsCYvl2uuH5eYVLUwvKOM2Yl/zMDIalGaieUo6lbApniPQuindciEHzJjhlql7bj
	ubq9DAIUkslzHQ5RjSjIsIuYej+nmPfQw==
X-Google-Smtp-Source: AGHT+IGhzTiWkfdI87vr+ql7n+ls2Q2mwQkq/hCmiGc/TFbmSh7pEvaPN+t3bx0U4a3klTVgRIv9BVvw0gk8VfEm9CA=
X-Received: by 2002:a53:b6ca:0:b0:62c:70de:7c9a with SMTP id
 956f58d0204a3-63b9a060c6bmr11169835d50.11.1759811294975; Mon, 06 Oct 2025
 21:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007015147.2496026-1-tj@kernel.org> <20251007015147.2496026-5-tj@kernel.org>
In-Reply-To: <20251007015147.2496026-5-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Tue, 7 Oct 2025 00:28:04 -0400
X-Gm-Features: AS18NWCFvNvrwtrBiaqOBKljQaSigyxHunXr9Ns6gQbxc73Qy4enNSRBK5aC_IM
Message-ID: <CABFh=a5wpYf-ZRTKqUhGQLynMXt4ABowfuqNS11cU6Yw-Pa5Jg@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched_ext: Make scx_bpf_dsq_insert*() return bool
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 9:51=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> In preparation for hierarchical schedulers, change scx_bpf_dsq_insert() a=
nd
> scx_bpf_dsq_insert_vtime() to return bool instead of void. With
> sub-schedulers, there will be no reliable way to guarantee a task is stil=
l
> owned by the sub-scheduler at insertion time (e.g., the task may have bee=
n
> migrated to another scheduler). The bool return value will enable
> sub-schedulers to detect and gracefully handle insertion failures.
>
> For the root scheduler, insertion failures will continue to trigger sched=
uler
> abort via scx_error(), so existing code doesn't need to check the return
> value. Backward compatibility is maintained through compat wrappers.
>
> Also update scx_bpf_dsq_move() documentation to clarify that it can retur=
n
> false for sub-schedulers when @dsq_id points to a disallowed local DSQ.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c                       | 45 ++++++++++++++++++------
>  tools/sched_ext/include/scx/common.bpf.h |  3 +-
>  tools/sched_ext/include/scx/compat.bpf.h | 23 ++++++++++--
>  3 files changed, 56 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index a34e731229de..399e53c8939c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5323,8 +5323,12 @@ __bpf_kfunc_start_defs();
>   * exhaustion. If zero, the current residual slice is maintained. If
>   * %SCX_SLICE_INF, @p never expires and the BPF scheduler must kick the =
CPU with
>   * scx_bpf_kick_cpu() to trigger scheduling.
> + *
> + * Returns %true on successful insertion, %false on failure. On the root
> + * scheduler, %false return triggers scheduler abort and the caller does=
n't need
> + * to check the return value.
>   */
> -__bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u=
64 slice,
> +__bpf_kfunc bool scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u=
64 slice,
>                                     u64 enq_flags)
>  {
>         struct scx_sched *sch;
> @@ -5332,10 +5336,10 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_s=
truct *p, u64 dsq_id, u64 slice
>         guard(rcu)();
>         sch =3D rcu_dereference(scx_root);
>         if (unlikely(!sch))
> -               return;
> +               return false;
>
>         if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> -               return;
> +               return false;
>
>         if (slice)
>                 p->scx.slice =3D slice;
> @@ -5343,13 +5347,24 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_s=
truct *p, u64 dsq_id, u64 slice
>                 p->scx.slice =3D p->scx.slice ?: 1;
>
>         scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
> +
> +       return true;
> +}
> +
> +/*
> + * COMPAT: Will be removed in v6.23.
> + */
> +__bpf_kfunc void scx_bpf_dsq_insert___compat(struct task_struct *p, u64 =
dsq_id,
> +                                            u64 slice, u64 enq_flags)
> +{
> +       scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags);
>  }
>
> -static void scx_dsq_insert_vtime(struct scx_sched *sch, struct task_stru=
ct *p,
> +static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_stru=
ct *p,
>                                  u64 dsq_id, u64 slice, u64 vtime, u64 en=
q_flags)
>  {
>         if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> -               return;
> +               return false;
>
>         if (slice)
>                 p->scx.slice =3D slice;
> @@ -5359,6 +5374,8 @@ static void scx_dsq_insert_vtime(struct scx_sched *=
sch, struct task_struct *p,
>         p->scx.dsq_vtime =3D vtime;
>
>         scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRI=
Q);
> +
> +       return true;
>  }
>
>  struct scx_bpf_dsq_insert_vtime_args {
> @@ -5394,8 +5411,12 @@ struct scx_bpf_dsq_insert_vtime_args {
>   * function must not be called on a DSQ which already has one or more FI=
FO tasks
>   * queued and vice-versa. Also, the built-in DSQs (SCX_DSQ_LOCAL and
>   * SCX_DSQ_GLOBAL) cannot be used as priority queues.
> + *
> + * Returns %true on successful insertion, %false on failure. On the root
> + * scheduler, %false return triggers scheduler abort and the caller does=
n't need
> + * to check the return value.
>   */
> -__bpf_kfunc void
> +__bpf_kfunc bool
>  __scx_bpf_dsq_insert_vtime(struct task_struct *p,
>                            struct scx_bpf_dsq_insert_vtime_args *args)
>  {
> @@ -5405,10 +5426,10 @@ __scx_bpf_dsq_insert_vtime(struct task_struct *p,
>
>         sch =3D rcu_dereference(scx_root);
>         if (unlikely(!sch))
> -               return;
> +               return false;
>
> -       scx_dsq_insert_vtime(sch, p, args->dsq_id, args->slice, args->vti=
me,
> -                            args->enq_flags);
> +       return scx_dsq_insert_vtime(sch, p, args->dsq_id, args->slice,
> +                                   args->vtime, args->enq_flags);
>  }
>
>  /*
> @@ -5432,6 +5453,7 @@ __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert___compat, KF_RCU)
>  BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
> @@ -5686,8 +5708,9 @@ __bpf_kfunc void scx_bpf_dsq_move_set_vtime(struct =
bpf_iter_scx_dsq *it__iter,
>   * Can be called from ops.dispatch() or any BPF context which doesn't ho=
ld a rq
>   * lock (e.g. BPF timers or SYSCALL programs).
>   *
> - * Returns %true if @p has been consumed, %false if @p had already been =
consumed
> - * or dequeued.
> + * Returns %true if @p has been consumed, %false if @p had already been
> + * consumed, dequeued, or, for sub-scheds, @dsq_id points to a disallowe=
d local
> + * DSQ.
>   */
>  __bpf_kfunc bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
>                                   struct task_struct *p, u64 dsq_id,
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/i=
nclude/scx/common.bpf.h
> index b1c2a0dde76e..522c90d0ced2 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -62,8 +62,7 @@ s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
>  s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake=
_flags, bool *is_idle) __ksym;
>  s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask=
 *cpus_allowed,
>                              struct scx_bpf_select_cpu_and_args *args) __=
ksym __weak;
> -void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u6=
4 enq_flags) __ksym __weak;
> -void __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_ds=
q_insert_vtime_args *args) __ksym __weak;
> +bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_ds=
q_insert_vtime_args *args) __ksym __weak;
>  u32 scx_bpf_dispatch_nr_slots(void) __ksym;
>  void scx_bpf_dispatch_cancel(void) __ksym;
>  bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/i=
nclude/scx/compat.bpf.h
> index e172de696f99..33c26928f4e9 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -196,7 +196,7 @@ scx_bpf_select_cpu_and(struct task_struct *p, s32 pre=
v_cpu, u64 wake_flags,
>   * Inline wrapper that packs scalar arguments into a struct and calls
>   * __scx_bpf_dsq_insert_vtime(). See __scx_bpf_dsq_insert_vtime() for de=
tails.
>   */
> -static inline void
> +static inline bool
>  scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u=
64 vtime,
>                          u64 enq_flags)
>  {
> @@ -208,10 +208,29 @@ scx_bpf_dsq_insert_vtime(struct task_struct *p, u64=
 dsq_id, u64 slice, u64 vtime
>                         .enq_flags =3D enq_flags,
>                 };
>
> -               __scx_bpf_dsq_insert_vtime(p, &args);
> +               return __scx_bpf_dsq_insert_vtime(p, &args);
>         } else {
>                 scx_bpf_dsq_insert_vtime___compat(p, dsq_id, slice, vtime=
,
>                                                   enq_flags);
> +               return true;
> +       }
> +}
> +
> +/*
> + * v6.19: scx_bpf_dsq_insert() now returns bool instead of void. Move
> + * scx_bpf_dsq_insert() decl to common.bpf.h and drop compat helper afte=
r v6.22.
> + */
> +bool scx_bpf_dsq_insert___new(struct task_struct *p, u64 dsq_id, u64 sli=
ce, u64 enq_flags) __ksym __weak;
> +void scx_bpf_dsq_insert___compat(struct task_struct *p, u64 dsq_id, u64 =
slice, u64 enq_flags) __ksym __weak;
> +
> +static inline bool
> +scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq=
_flags)
> +{
> +       if (bpf_ksym_exists(scx_bpf_dsq_insert___new)) {
> +               return scx_bpf_dsq_insert___new(p, dsq_id, slice, enq_fla=
gs);
> +       } else {
> +               scx_bpf_dsq_insert___compat(p, dsq_id, slice, enq_flags);
> +               return true;
>         }
>  }
>


> --
> 2.51.0
>
>

