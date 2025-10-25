Return-Path: <linux-kernel+bounces-870157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27853C0A108
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 01:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC5E3A4A3D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AA72DF701;
	Sat, 25 Oct 2025 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="MkU+FUIu"
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0B513DBA0
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761434521; cv=none; b=E4uT/4DEt77Ex96jmLtixnMhbJQ83NzYbiAH8ZlRvap8m0aSb19tK8Nk6cAYF1srHSqVjDddjq9eKQMuyqYtGUOm7sfQRrsFv2SSRN30iBBeRJvTOzOIkINqgUAbevVQFQP/mD+L5/EkQbcTtdAoP3l2XUWs/5pwo+74OE1S9Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761434521; c=relaxed/simple;
	bh=9fjXyu9uOlx9Boil8JIPaRzS9MzDT1EcBqLi9OTnrcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDOD0rZRY2vCFUWRiwbkaRnYEpPLX2UMi4LLXKWnn9VeiKszyLyESie2hhBX5pLUQwlnTnI8ruRCp0Ici9sXSAejF5+h4UU2tyO2OUy3n9xys5cSfAGqoDJTSKIgGRKnlmDwy5nDp5yvosy4LTNWu7oGfRAHM98H6YmOVWInubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=MkU+FUIu; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63e1b52b452so3593727d50.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1761434518; x=1762039318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RT1AYIMXw3zvx720aG+zN8z/yfufifvlumEKQUokldE=;
        b=MkU+FUIux5NQxnPEvKabbm3bToh38KKAvp8gCqJOBhAaz/wD4lg/90n9BgTQzfSBPG
         MqiYoA6T/V9lT59eF24ghMt+y341G5FfNjtIE9yJUTUZeqsmBhQT/miGHSbkZyGTxsuh
         Qqr+V1ebp+fZ7ZVYmXNoTeM0VKvdGhT6rYPg2sCsyUfFG42iG5oRXzQoop3FexKdiyGT
         YD8zY1ai1YySUO8crEyR3lj8u1zI4uZsF9ccR21W3fNwZgPLmIbnzS8Z9xKMGs8AIkwg
         ef3G4OXQsWhS1Pecadx6nHDcfwggAmTpQJOA/bGVPr/tqqLelRWMruAzg8p1iMUijJw4
         upeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761434518; x=1762039318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RT1AYIMXw3zvx720aG+zN8z/yfufifvlumEKQUokldE=;
        b=s7HzCgqibQ+XITuWh5YmCPQdXKvlM46B6dq6sazONaVEkbMk68sgOX2SVnt51RQjPj
         cRd8ugpH1RGGGzldWALM8wik5jpI50haubPAaRU/S8ClvdF3+qmX+ihnpCkhCnxTiiyi
         eNJsaeCupA5RvetRoVYj0+VV1tPrSczafl0Pz1cDkDf9syiB8t96ZFncT/q+VQ2BDlpV
         Mq+k66BogJGy9NgOYV7qYHsDVWZNmaflzM2z/e1u3UNrTLc2mXcqx9Pu8G/faSQ2zsz1
         VUtLCMIMVm9UiWXUHQ/oVW+qQR4HVMONG6csVHeyeKs65dnqoboxcYHNFClNl7BHnvC4
         W6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGOoL6m5Aef0Uv1BCWpwj1U0WNWWkrlbs4HcOoA78f1kAKveyN2aaWdZhJZbnmLvd8jjtz9jJJiYvEw94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNUizpBqSHyVeAU3hov++hH2ssh4vEBM51slLMLooBSzmfTuIX
	WjlAxJUGCIOnJTAtU8CuH7SDWTGi3Q3irr75oUbwq9bFjhF78i5Yoo92zAslHL5Vac2wJzfgRaL
	+fqjv8GXGwoZPsOfa3SgZHG5KnNeIER6rq+Aw9QDbyQ==
X-Gm-Gg: ASbGncsBziArT+qLzc6dybxBmyNnJPw8KORP4l/zlF/oA2maRGw4+etwOR6Nu6AybCb
	TBYzyM4boRNNTpyp/W260b0Aflk4Ti5yafHV46843OJb5Z2b4izynyfB1nFfHyrzggV6xfw8qZG
	VslNSHV23s7S9A0Q1vt5bQ6P+ffoc3bDIq84XpOnxegWTGkubUw6qZg5XPo3wJaJc77WewMCl3t
	Zu5ZBQhBuc0ha+aTKlYvIb0MpmlOh4TnNmy3yFj/DGC/2RNNmREaOgSpnVaHcYEbV7fPUvtxqVt
	fBpC0bSO
X-Google-Smtp-Source: AGHT+IFhxKlUF6Fiz73JRYYxd+P6t/tDTPK+t/aprswamomVEkvgq99WI5vKHuKlz2pksoYuOQQBQlHtRAzo2Wn+KGA=
X-Received: by 2002:a53:d251:0:b0:63c:f5a7:401 with SMTP id
 956f58d0204a3-63e16215840mr19598689d50.69.1761434517904; Sat, 25 Oct 2025
 16:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025001849.1915635-1-tj@kernel.org> <20251025001849.1915635-4-tj@kernel.org>
In-Reply-To: <20251025001849.1915635-4-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Sat, 25 Oct 2025 19:21:47 -0400
X-Gm-Features: AWmQ_bm0dZg6N8y7k5-rvrwBCXnlYT-eZGKzVti1vfVt0BGoS5wHoDqt5TvI8jg
Message-ID: <CABFh=a4-5+SfNGTcjBP1_5bsN5HqdzoWE4F9P1K1yrNQt=k2yw@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Wen-Fang Liu <liuwenfang@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:18=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> The ops.cpu_acquire/release() callbacks are broken - they miss events und=
er
> multiple conditions and can't be fixed without adding global sched core h=
ooks
> that sched maintainers don't want. They also aren't necessary as BPF sche=
dulers
> can use generic BPF mechanisms like tracepoints to achieve the same goals=
.
>
> The main use case for cpu_release() was calling scx_bpf_reenqueue_local()=
 when
> a CPU gets preempted by a higher priority scheduling class. However, the =
old
> scx_bpf_reenqueue_local() could only be called from cpu_release() context=
.
>
> Add a new version of scx_bpf_reenqueue_local() that can be called from an=
y
> context by deferring the actual re-enqueue operation. This eliminates the=
 need
> for cpu_acquire/release() ops entirely. Schedulers can now use standard B=
PF
> mechanisms like the sched_switch tracepoint to detect and handle CPU pree=
mption.
>
> Update scx_qmap to demonstrate the new approach using sched_switch instea=
d of
> cpu_release, with compat support for older kernels. Mark cpu_acquire/rele=
ase()
> as deprecated. The old scx_bpf_reenqueue_local() variant will be removed =
in
> v6.23.
>
> Reported-by: Wen-Fang Liu <liuwenfang@honor.com>
> Link: https://lore.kernel.org/all/8d64c74118c6440f81bcf5a4ac6b9f00@honor.=
com/
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/sched/ext.c                       | 31 ++++++++++++++++++++
>  kernel/sched/sched.h                     |  1 +
>  tools/sched_ext/include/scx/common.bpf.h |  1 -
>  tools/sched_ext/include/scx/compat.bpf.h | 23 +++++++++++++++
>  tools/sched_ext/scx_qmap.bpf.c           | 38 +++++++++++++++++-------
>  5 files changed, 83 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 222222222222..333333333333 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -147,6 +147,7 @@ static struct kset *scx_kset;
>  #include <trace/events/sched_ext.h>
>
>  static void process_ddsp_deferred_locals(struct rq *rq);
> +static u32 reenq_local(struct rq *rq);
>  static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
>  static void scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
>                       s64 exit_code, const char *fmt, va_list args);
> @@ -755,6 +756,11 @@ static int ops_sanitize_err(struct scx_sched *sch, s=
32 ret, s32 ops_err)
>  static void run_deferred(struct rq *rq)
>  {
>         process_ddsp_deferred_locals(rq);
> +
> +       if (local_read(&rq->scx.reenq_local_deferred)) {
> +               local_set(&rq->scx.reenq_local_deferred, 0);
> +               reenq_local(rq);
> +       }
>  }
>
>  static void deferred_bal_cb_workfn(struct rq *rq)
> @@ -4569,6 +4575,9 @@ static int validate_ops(struct scx_sched *sch)
>         if (ops->flags & SCX_OPS_HAS_CGROUP_WEIGHT)
>                 pr_warn("SCX_OPS_HAS_CGROUP_WEIGHT is deprecated and a no=
op\n");
>
> +       if (ops->cpu_acquire || ops->cpu_release)
> +               pr_warn("ops->cpu_acquire/release() are deprecated, use s=
ched_switch TP instead\n");
> +
>         return 0;
>  }
>
> @@ -5931,6 +5940,9 @@ __bpf_kfunc_start_defs();
>   * Iterate over all of the tasks currently enqueued on the local DSQ of =
the
>   * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the n=
umber of
>   * processed tasks. Can only be called from ops.cpu_release().
> + *
> + * COMPAT: Will be removed in v6.23 along with the ___v2 suffix on the v=
oid
> + * returning variant that can be called from anywhere.
>   */
>  __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
>  {
> @@ -6490,6 +6502,24 @@ __bpf_kfunc void scx_bpf_dump_bstr(char *data__str=
, u32 data__sz)
>  }
>
>  /**
> + * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
> + *
> + * Iterate over all of the tasks currently enqueued on the local DSQ of =
the
> + * caller's CPU, and re-enqueue them in the BPF scheduler. Can be called=
 from
> + * anywhere.
> + */
> +__bpf_kfunc void scx_bpf_reenqueue_local___v2(void)
> +{
> +       struct rq *rq;
> +
> +       guard(preempt)();
> +
> +       rq =3D this_rq();
> +       local_set(&rq->scx.reenq_local_deferred, 1);
> +       schedule_deferred(rq);
> +}
> +
> +/**
>   * scx_bpf_cpuperf_cap - Query the maximum relative capacity of a CPU
>   * @cpu: CPU of interest
>   *
> @@ -6902,6 +6932,7 @@ BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITE=
R_DESTRUCTOR)
>  BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, scx_bpf_reenqueue_local___v2)
>  BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
>  BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
>  BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 444444444444..555555555555 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -804,6 +804,7 @@ struct scx_rq {
>         cpumask_var_t           cpus_to_preempt;
>         cpumask_var_t           cpus_to_wait;
>         unsigned long           kick_sync;
> +       local_t                 reenq_local_deferred;
>         struct balance_callback deferred_bal_cb;
>         struct irq_work         deferred_irq_work;
>         struct irq_work         kick_cpus_irq_work;
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/i=
nclude/scx/common.bpf.h
> index 666666666666..777777777777 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -70,7 +70,6 @@ void scx_bpf_dsq_move_set_slice(struct bpf_iter_scx_dsq=
 *it__iter, u64 slice) _
>  void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 v=
time) __ksym __weak;
>  bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter, struct task_str=
uct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
>  bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter, struct ta=
sk_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
> -u32 scx_bpf_reenqueue_local(void) __ksym;
>  void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
>  s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
>  void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/i=
nclude/scx/compat.bpf.h
> index 888888888888..999999999999 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -279,6 +279,29 @@ static inline void scx_bpf_task_set_dsq_weight(struc=
t task_struct *p, u32 weigh
>  }
>
>  /*
> + * v6.19: The new void variant can be called from anywhere while the old=
er v1
> + * variant can only be called from ops.cpu_release(). The double ___ pre=
fixes on
> + * the v2 variant need to be removed once libbpf is updated to ignore __=
_ prefix
> + * on kernel side. Drop the wrapper and move the decl to common.bpf.h af=
ter
> + * v6.22.
> + */
> +u32 scx_bpf_reenqueue_local___v1(void) __ksym __weak;
> +void scx_bpf_reenqueue_local___v2___compat(void) __ksym __weak;
> +
> +static inline bool __COMPAT_scx_bpf_reenqueue_local_from_anywhere(void)
> +{
> +       return bpf_ksym_exists(scx_bpf_reenqueue_local___v2___compat);
> +}
> +
> +static inline void scx_bpf_reenqueue_local(void)
> +{
> +       if (__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
> +               scx_bpf_reenqueue_local___v2___compat();
> +       else
> +               scx_bpf_reenqueue_local___v1();
> +}
> +
> +/*
>   * Define sched_ext_ops. This may be expanded to define multiple variant=
s for
>   * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
>   */
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index aaaaaaaaaaaa..bbbbbbbbbbbb 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -202,6 +202,9 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct =
*p, u64 enq_flags)
>         void *ring;
>         s32 cpu;
>
> +       if (enq_flags & SCX_ENQ_REENQ)
> +               __sync_fetch_and_add(&nr_reenqueued, 1);
> +
>         if (p->flags & PF_KTHREAD) {
>                 if (stall_kernel_nth && !(++kernel_cnt % stall_kernel_nth=
))
>                         return;
> @@ -529,20 +532,35 @@ bool BPF_STRUCT_OPS(qmap_core_sched_before, struct =
task_struct *a,
>         return task_qdist(a) > task_qdist(b);
>  }
>
> -void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_ar=
gs *args)
> +SEC("tp_btf/sched_switch")
> +int BPF_PROG(qmap_sched_switch, bool preempt, struct task_struct *prev,
> +            struct task_struct *next, unsigned long prev_state)
>  {
> -       u32 cnt;
> +       if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
> +               return 0;
>
>         /*
> -        * Called when @cpu is taken by a higher priority scheduling clas=
s. This
> -        * makes @cpu no longer available for executing sched_ext tasks. =
As we
> -        * don't want the tasks in @cpu's local dsq to sit there until @c=
pu
> -        * becomes available again, re-enqueue them into the global dsq. =
See
> -        * %SCX_ENQ_REENQ handling in qmap_enqueue().
> +        * If @cpu is taken by a higher priority scheduling class, it is =
no
> +        * longer available for executing sched_ext tasks. As we don't wa=
nt the
> +        * tasks in @cpu's local dsq to sit there until @cpu becomes avai=
lable
> +        * again, re-enqueue them into the global dsq. See %SCX_ENQ_REENQ
> +        * handling in qmap_enqueue().
>          */
> -       cnt =3D scx_bpf_reenqueue_local();
> -       if (cnt)
> -               __sync_fetch_and_add(&nr_reenqueued, cnt);
> +       switch (next->policy) {
> +       case 1: /* SCHED_FIFO */
> +       case 2: /* SCHED_RR */
> +       case 6: /* SCHED_DEADLINE */
> +               scx_bpf_reenqueue_local();
> +       }
> +
> +       return 0;
> +}
> +
> +void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_ar=
gs *args)
> +{
> +       /* see qmap_sched_switch() to learn how to do this on newer kerne=
ls */
> +       if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
> +               scx_bpf_reenqueue_local();
>  }
>
>  s32 BPF_STRUCT_OPS(qmap_init_task, struct task_struct *p,
> --
> 2.47.1
>

