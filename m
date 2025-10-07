Return-Path: <linux-kernel+bounces-844481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9E3BC2089
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80AEF19A2E5C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905DF2C9D;
	Tue,  7 Oct 2025 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="BFjjRyeb"
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC21553AA
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853115; cv=none; b=csbgEkgcVtKfRNEUu07H4r/2lB2MuqpbkzKkQUPUMuASsFtt+QefM1Z/C1HHT9m3RUHIuhUuEKKxtNCvt3kEsi5hAMlahmsOg21iXOOa02UxYqmTBTLl9fKhOYfC/7hsY5zy6SxJFX+YP/xC7dyWNldnLWMtPkljML5nqTUp6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853115; c=relaxed/simple;
	bh=DUEZ3N5Mux8Dv1oSjnxsiiySGYL11OfHPqWOdU1KrHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ymbhd3c31yMi8mLytcvF/JOJWfnMnod0F8GKTqud2Mi7ffKJy0McI1poYx+LkdmzBGUkKxSou8IikEyFXByZY0z6XMb23ccEoyVMzRMYYku/armR1FN0020KfvmXN3iEc06g/wK4WiKp7cva98bWQTTQ9ctMEmU4goq+CsS2YaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=BFjjRyeb; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-633c1b740c5so7398149d50.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1759853110; x=1760457910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oim9J7oUUmK3bNFuatfCuSTgsVMvHsUNI9x/rK5JZOg=;
        b=BFjjRyebR3xnZOaORTDaBKflTvM1tKr2wVMoH4YQYyS0AUqEDVipJUr0iHAStUwD0E
         9EU85Tij1kcLaX/emCFeRLb9RVqJmDPvdP/dbSPQLb0TxAxOcYOTVLj0wcCuEbCA9enm
         9TDB2aZncZWb5zSZ+6ekFxhBctLXytSBtGBYptrRdXQpAmB2xVOQOKahv2/pxWe4quI2
         +angbD/ndGkQQz+Kn/oqjBoyPUG3nCb16aVN+vEab59Wa9nBWVPmSP+tyQYZEYxfAlmV
         9xs6GQdJ6C5o7SI3U/WU/M9HTvu++xD4aQFF1aduKL69CRoA2sYc8oovU73HIvU++Ynh
         ZASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853110; x=1760457910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oim9J7oUUmK3bNFuatfCuSTgsVMvHsUNI9x/rK5JZOg=;
        b=jclviHlNRrLIWzd68SKlAoU3k4Zq68QA2EdwNjGaRmtUkG3xlm9UTj6rQfI9iO7ao2
         Rmu7+ht7VSba3pINGF4F5XFIY/6c9cZV+eyemwhPKgukD9TjNEEsxwsmVu6ZO8ESW/dU
         EDdxRq0sE2e0INM0RLaUWIqKIbcf2krcdWplmvJSlyaoM6S0qIusc8hZ7hSNKoeIYCv7
         MlgLqo+6Oc/NYhVreNyUnvbFKPPzVB7lepIh5T8bV2x2A1vKRVxE/l0WxYvfLl6a94PA
         ffKb13bFzJ9j53rsxG7H6CN3/R50/J6QhNaXL5JKWGHlYozsYICZDkcbIqNvZGhAENoQ
         gG4w==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZWDhdcF4a5d4XaKeH4VHo32N8jHZUNx6sxtfxQHS4pla+LEsqC2ytnG5SogN2JJY69sVqhA66GTkGno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwI0/Lih988E3APt/hfXe8AlUQYNOPa+kJ8s7yQxnn0K5PGApX
	sy5fnOso+kWYrUs4Gkb9qdHt/9DYXoXmeMslOWV3ivGwpPolTRf6n8GlV9bS8nBoMJkST3Mvehn
	uoSrQ1+ueFVorDhQNWxNLN/h6kqnmFnRApfclJ9nRhw==
X-Gm-Gg: ASbGncvveWdtFlg8f5yE1IKj/bFwUIQ0PTVf74JP/7/yXnF3fgoytifu8fUGkApPo4m
	VIoQ2mogb5HIxfn6v2A4bOtnR8ZrZDCvvrqin8zufUUL13ULcGQiMT6pOtrgsO0oRn0XHq4qNvi
	aSlMhLq/jDl/M42nA1KQ8C6wOZHaWutCTxeANWxvdGZY7EQL40qh6jeNRU3C+SRRQ=
X-Google-Smtp-Source: AGHT+IE+eDUa+80DrutEtRKJ/RpGPOfOJrSB0Eawgudncno0Fuzdzo7rIFG8Lqw1G1h8q3HyrIJ03aWJ33jC6k8uSSs=
X-Received: by 2002:a05:690e:2519:10b0:633:a7cf:bb4a with SMTP id
 956f58d0204a3-63ccb8a370dmr170573d50.23.1759853107994; Tue, 07 Oct 2025
 09:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007015147.2496026-1-tj@kernel.org> <20251007015147.2496026-4-tj@kernel.org>
In-Reply-To: <20251007015147.2496026-4-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Tue, 7 Oct 2025 12:04:56 -0400
X-Gm-Features: AS18NWCXkvGwLXfK2SfnGPYGcWgu28HQaN6iLQBJ0s2QVPEC4mYAffM-jY5ynYE
Message-ID: <CABFh=a4CQ0dJOKKDZPVEMPbFRtmY7z=0Bn00HY7JEke35GQy0g@mail.gmail.com>
Subject: Re: [PATCH 3/4] sched_ext: Wrap kfunc args in struct to prepare for aux__prog
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 9:51=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> scx_bpf_dsq_insert_vtime() and scx_bpf_select_cpu_and() currently have 5
> parameters. An upcoming change will add aux__prog parameter which will ex=
ceed
> BPF's 5 argument limit.
>
> Prepare by adding new kfuncs __scx_bpf_dsq_insert_vtime() and
> __scx_bpf_select_cpu_and() that take args structs. The existing kfuncs ar=
e
> kept as compatibility wrappers. BPF programs use inline wrappers that det=
ect
> kernel API version via bpf_core_type_exists() and use the new struct-base=
d
> kfuncs when available, falling back to compat kfuncs otherwise. This allo=
ws
> BPF programs to work with both old and new kernels.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c                       | 82 ++++++++++++++++++------
>  kernel/sched/ext_idle.c                  | 43 +++++++++++--
>  tools/sched_ext/include/scx/common.bpf.h |  6 +-
>  tools/sched_ext/include/scx/compat.bpf.h | 72 +++++++++++++++++++++
>  4 files changed, 173 insertions(+), 30 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 6d76efaaa9b2..a34e731229de 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5345,54 +5345,94 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_s=
truct *p, u64 dsq_id, u64 slice
>         scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
>  }
>
> +static void scx_dsq_insert_vtime(struct scx_sched *sch, struct task_stru=
ct *p,
> +                                u64 dsq_id, u64 slice, u64 vtime, u64 en=
q_flags)
> +{
> +       if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> +               return;
> +
> +       if (slice)
> +               p->scx.slice =3D slice;
> +       else
> +               p->scx.slice =3D p->scx.slice ?: 1;
> +

Though the ?:1 logic is already in the code: I assume the rationale is
that we want the slice to be immediately exhausted so that the BPF
scheduler refills it with the right value, which makes sense.

> +       p->scx.dsq_vtime =3D vtime;
> +
> +       scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRI=
Q);
> +}
> +
> +struct scx_bpf_dsq_insert_vtime_args {
> +       /* @p can't be packed together as KF_RCU is not transitive */
> +       u64                     dsq_id;
> +       u64                     slice;
> +       u64                     vtime;
> +       u64                     enq_flags;
> +};
> +
>  /**
> - * scx_bpf_dsq_insert_vtime - Insert a task into the vtime priority queu=
e of a DSQ
> + * __scx_bpf_dsq_insert_vtime - Arg-wrapped vtime DSQ insertion
>   * @p: task_struct to insert
> - * @dsq_id: DSQ to insert into
> - * @slice: duration @p can run for in nsecs, 0 to keep the current value
> - * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
> - * @enq_flags: SCX_ENQ_*
> + * @args: struct containing the rest of the arguments
> + *       @args->dsq_id: DSQ to insert into
> + *       @args->slice: duration @p can run for in nsecs, 0 to keep the c=
urrent value
> + *       @args->vtime: @p's ordering inside the vtime-sorted queue of th=
e target DSQ
> + *       @args->enq_flags: SCX_ENQ_*
>   *
> - * Insert @p into the vtime priority queue of the DSQ identified by @dsq=
_id.
> - * Tasks queued into the priority queue are ordered by @vtime. All other=
 aspects
> - * are identical to scx_bpf_dsq_insert().
> + * Wrapper kfunc that takes arguments via struct to work around BPF's 5 =
argument
> + * limit. BPF programs should use scx_bpf_dsq_insert_vtime() which is pr=
ovided
> + * as an inline wrapper in common.bpf.h.
>   *
> - * @vtime ordering is according to time_before64() which considers wrapp=
ing. A
> - * numerically larger vtime may indicate an earlier position in the orde=
ring and
> - * vice-versa.
> + * Insert @p into the vtime priority queue of the DSQ identified by
> + * @args->dsq_id. Tasks queued into the priority queue are ordered by
> + * @args->vtime. All other aspects are identical to scx_bpf_dsq_insert()=
.
> + *
> + * @args->vtime ordering is according to time_before64() which considers
> + * wrapping. A numerically larger vtime may indicate an earlier position=
 in the
> + * ordering and vice-versa.
>   *
>   * A DSQ can only be used as a FIFO or priority queue at any given time =
and this
>   * function must not be called on a DSQ which already has one or more FI=
FO tasks
>   * queued and vice-versa. Also, the built-in DSQs (SCX_DSQ_LOCAL and
>   * SCX_DSQ_GLOBAL) cannot be used as priority queues.
>   */
> -__bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq=
_id,
> -                                         u64 slice, u64 vtime, u64 enq_f=
lags)
> +__bpf_kfunc void
> +__scx_bpf_dsq_insert_vtime(struct task_struct *p,
> +                          struct scx_bpf_dsq_insert_vtime_args *args)
>  {
>         struct scx_sched *sch;
>
>         guard(rcu)();
> +
>         sch =3D rcu_dereference(scx_root);
>         if (unlikely(!sch))
>                 return;
>
> -       if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> -               return;
> +       scx_dsq_insert_vtime(sch, p, args->dsq_id, args->slice, args->vti=
me,
> +                            args->enq_flags);
> +}
>
> -       if (slice)
> -               p->scx.slice =3D slice;
> -       else
> -               p->scx.slice =3D p->scx.slice ?: 1;
> +/*
> + * COMPAT: Will be removed in v6.23.
> + */
> +__bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq=
_id,
> +                                         u64 slice, u64 vtime, u64 enq_f=
lags)
> +{
> +       struct scx_sched *sch;
>
> -       p->scx.dsq_vtime =3D vtime;
> +       guard(rcu)();
>
> -       scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRI=
Q);
> +       sch =3D rcu_dereference(scx_root);
> +       if (unlikely(!sch))
> +               return;
> +
> +       scx_dsq_insert_vtime(sch, p, dsq_id, slice, vtime, enq_flags);
>  }
>
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
> +BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
>
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index d2434c954848..3d9d404d5cd2 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -995,26 +995,56 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_=
struct *p, s32 prev_cpu,
>         return prev_cpu;
>  }
>
> +struct scx_bpf_select_cpu_and_args {
> +       /* @p and @cpus_allowed can't be packed together as KF_RCU is not=
 transitive */
> +       s32                     prev_cpu;
> +       u64                     wake_flags;
> +       u64                     flags;
> +};
> +
>  /**
> - * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p,
> - *                         prioritizing those in @cpus_allowed
> + * __scx_bpf_select_cpu_and - Arg-wrapped CPU selection with cpumask
>   * @p: task_struct to select a CPU for
> - * @prev_cpu: CPU @p was on previously
> - * @wake_flags: %SCX_WAKE_* flags
>   * @cpus_allowed: cpumask of allowed CPUs
> - * @flags: %SCX_PICK_IDLE* flags
> + * @args: struct containing the rest of the arguments
> + *       @args->prev_cpu: CPU @p was on previously
> + *       @args->wake_flags: %SCX_WAKE_* flags
> + *       @args->flags: %SCX_PICK_IDLE* flags
> + *
> + * Wrapper kfunc that takes arguments via struct to work around BPF's 5 =
argument
> + * limit. BPF programs should use scx_bpf_select_cpu_and() which is prov=
ided
> + * as an inline wrapper in common.bpf.h.
>   *
>   * Can be called from ops.select_cpu(), ops.enqueue(), or from an unlock=
ed
>   * context such as a BPF test_run() call, as long as built-in CPU select=
ion
>   * is enabled: ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDL=
E
>   * is set.
>   *
> - * @p, @prev_cpu and @wake_flags match ops.select_cpu().
> + * @p, @args->prev_cpu and @args->wake_flags match ops.select_cpu().
>   *
>   * Returns the selected idle CPU, which will be automatically awakened u=
pon
>   * returning from ops.select_cpu() and can be used for direct dispatch, =
or
>   * a negative value if no idle CPU is available.
>   */
> +__bpf_kfunc s32
> +__scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cp=
us_allowed,
> +                        struct scx_bpf_select_cpu_and_args *args)
> +{
> +       struct scx_sched *sch;
> +
> +       guard(rcu)();
> +
> +       sch =3D rcu_dereference(scx_root);
> +       if (unlikely(!sch))
> +               return -ENODEV;
> +
> +       return select_cpu_from_kfunc(sch, p, args->prev_cpu, args->wake_f=
lags,
> +                                    cpus_allowed, args->flags);
> +}
> +
> +/*
> + * COMPAT: Will be removed in v6.22.
> + */
>  __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_c=
pu, u64 wake_flags,
>                                        const struct cpumask *cpus_allowed=
, u64 flags)
>  {
> @@ -1383,6 +1413,7 @@ BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_R=
CU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
> +BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_idle)
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/i=
nclude/scx/common.bpf.h
> index 505231b7b7ae..b1c2a0dde76e 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -60,10 +60,10 @@ static inline void ___vmlinux_h_sanity_check___(void)
>
>  s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
>  s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake=
_flags, bool *is_idle) __ksym;
> -s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake=
_flags,
> -                          const struct cpumask *cpus_allowed, u64 flags)=
 __ksym __weak;
> +s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask=
 *cpus_allowed,
> +                            struct scx_bpf_select_cpu_and_args *args) __=
ksym __weak;
>  void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u6=
4 enq_flags) __ksym __weak;
> -void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 sli=
ce, u64 vtime, u64 enq_flags) __ksym __weak;
> +void __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_ds=
q_insert_vtime_args *args) __ksym __weak;
>  u32 scx_bpf_dispatch_nr_slots(void) __ksym;
>  void scx_bpf_dispatch_cancel(void) __ksym;
>  bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/i=
nclude/scx/compat.bpf.h
> index d979f16a3ae2..e172de696f99 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -143,6 +143,78 @@ static inline struct task_struct *__COMPAT_scx_bpf_c=
pu_curr(int cpu)
>         return rq ? rq->curr : NULL;
>  }
>
> +/*
> + * v6.19: To work around BPF maximum parameter limit, the following kfun=
cs are
> + * replaced with variants that pack scalar arguments in a struct. Wrappe=
rs are
> + * provided to maintain source compatibility.
> + *
> + * The kernel will carry the compat variants until v6.23 to maintain bin=
ary
> + * compatibility. After v6.23 release, remove the compat handling and mo=
ve the
> + * wrappers to common.bpf.h.
> + */
> +s32 scx_bpf_select_cpu_and___compat(struct task_struct *p, s32 prev_cpu,=
 u64 wake_flags,
> +                                   const struct cpumask *cpus_allowed, u=
64 flags) __ksym __weak;
> +void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p, u64 dsq_id=
, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
> +
> +/**
> + * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p
> + * @p: task_struct to select a CPU for
> + * @prev_cpu: CPU @p was on previously
> + * @wake_flags: %SCX_WAKE_* flags
> + * @cpus_allowed: cpumask of allowed CPUs
> + * @flags: %SCX_PICK_IDLE* flags
> + *
> + * Inline wrapper that packs scalar arguments into a struct and calls
> + * __scx_bpf_select_cpu_and(). See __scx_bpf_select_cpu_and() for detail=
s.
> + */
> +static inline s32
> +scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_fla=
gs,
> +                      const struct cpumask *cpus_allowed, u64 flags)
> +{
> +       if (bpf_core_type_exists(struct scx_bpf_select_cpu_and_args)) {
> +               struct scx_bpf_select_cpu_and_args args =3D {
> +                       .prev_cpu =3D prev_cpu,
> +                       .wake_flags =3D wake_flags,
> +                       .flags =3D flags,
> +               };
> +
> +               return __scx_bpf_select_cpu_and(p, cpus_allowed, &args);
> +       } else {
> +               return scx_bpf_select_cpu_and___compat(p, prev_cpu, wake_=
flags,
> +                                                      cpus_allowed, flag=
s);
> +       }
> +}
> +
> +/**
> + * scx_bpf_dsq_insert_vtime - Insert a task into the vtime priority queu=
e of a DSQ
> + * @p: task_struct to insert
> + * @dsq_id: DSQ to insert into
> + * @slice: duration @p can run for in nsecs, 0 to keep the current value
> + * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
> + * @enq_flags: SCX_ENQ_*
> + *
> + * Inline wrapper that packs scalar arguments into a struct and calls
> + * __scx_bpf_dsq_insert_vtime(). See __scx_bpf_dsq_insert_vtime() for de=
tails.
> + */
> +static inline void
> +scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u=
64 vtime,
> +                        u64 enq_flags)
> +{
> +       if (bpf_core_type_exists(struct scx_bpf_dsq_insert_vtime_args)) {
> +               struct scx_bpf_dsq_insert_vtime_args args =3D {
> +                       .dsq_id =3D dsq_id,
> +                       .slice =3D slice,
> +                       .vtime =3D vtime,
> +                       .enq_flags =3D enq_flags,
> +               };
> +
> +               __scx_bpf_dsq_insert_vtime(p, &args);
> +       } else {
> +               scx_bpf_dsq_insert_vtime___compat(p, dsq_id, slice, vtime=
,
> +                                                 enq_flags);
> +       }
> +}
> +
>  /*
>   * Define sched_ext_ops. This may be expanded to define multiple variant=
s for
>   * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
> --
> 2.51.0
>
>

