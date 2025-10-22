Return-Path: <linux-kernel+bounces-865252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3931BFC9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22BE1348AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E060832ABEF;
	Wed, 22 Oct 2025 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="ANvY0yRo"
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B54280318
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144258; cv=none; b=RlHjaKkFwGqGoJp7rqrH+1miZb7zlLBnyWuwK9S/3uHBTKCJIBhwseGq63SBIBpk7Tav4kvXoyB23r3UDVuIfa677mWobNADIAP32/+88cRJNMYCyhXDv6hw3to4+E9Pao350vhDgMq/mARg7SLrC6HmTfARl1EZOBKidVIUa+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144258; c=relaxed/simple;
	bh=4UeKeau2dGFdCtx0vU3GDBXTLPHXAFYddNA0OPUhE0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCiZIArmNFjr8OXS/6AlS4MIpNtP6A3rd8W1rnsnXK9WJ0ybNlOtPFlQi/x1E699Gk3/iAqmLaxg6VgdiaaOttae+FYqsxYEH9kMlBPf8j1so7O1C2GgANS1RKb4ae8qwOOnbtNW07N8MA8VvW8khYQYTobaX6qu/VE2QEngLwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=ANvY0yRo; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63e11347fd9so6833313d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1761144254; x=1761749054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NfxdVhl1bI6pLYJbH2edx0kudsqUWH4Ma1EH2Ns170=;
        b=ANvY0yRoO8T5GzeLawL8Rl6o+yDWDiSrVz/1OrhcNFBf8I9CeLdff99QK5rPFluqWQ
         Bn+V0E7cHDFWCpc3+futhgjZJBb60i3x/uizy49eBrm1KHTfp9RhMByg7uyHwTtBZVHW
         /JcK2lybsvzOOrvKuYXlCFXJ6LCFjN0vt2H8FV11K8pwrNXWWBY7o9ipn7uHZa3uMuxu
         xC6zrSdi6tfEdRbBmoKj5Wb9W74IS/mmerYZo6UslIG6VXdECtCCcFk1cnDh21ifJRTs
         wXqmECBksRONLwaEZwHf0ah2nyLCioSN2HCqrTPVqZxkMGPjmcW7CAWSyyIBv3PEGh36
         q5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761144254; x=1761749054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NfxdVhl1bI6pLYJbH2edx0kudsqUWH4Ma1EH2Ns170=;
        b=V6MkoKS9RTeN/9QE7y4fyd2zYUBzOStdE5pvxl5U24HzHwlK3RguSLszGKd/TBcN7j
         tA5fljBfTLZI5oGKQHIsTPbTOOrHfQNMRm2J+Ykfg52/M12uqEr698ZvDdj4GJCNsLLg
         YwjzXc36tjVXkWpuSm4cIn1iKa1Ee9QEGYQouQ0PxiGQCKtXBHP8RkLlPfuAAez9zkjS
         +XY+bKmVbLj62Wtnr93glvuAb3yJHmHFUhxt7Cqbw3E6ea24BdY/INJ+/wcBVqjO4UPm
         6CD2ghSp1ENejGbH0t6AEl9cnNiLVR/xRSA1Hh3KUVRJeZR3oDzmQmzj82SbCrx/zhj4
         oDBg==
X-Forwarded-Encrypted: i=1; AJvYcCWdf9LeMaK3vie7WNt+Oepv8Tf3+RPeaCanYlejikyVKPrWnaqX0pSDlbWRLHpibFtw1XWM7Av4VTHSxho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1bzNAuAkwGCTnt6qjkfz9WgTv9P0HhgyCrW9+eWCZ9Alvi6F
	l+CEegV2H97gsZyEuQXoAUUh6W3gF8qSNynxpdVpgNBrvERcK5djHrNe7Cyi2MPKCyeqWD6ALWt
	7B9VlLwo5CMIVInemB4KMa7qpLYJLp9TeIXRXB2IfStG6tLVAF5JB5oE=
X-Gm-Gg: ASbGncsh+B/G66o9L51Rjp0323axF4s85+VJQFca5bU7LA7HGwskM/UTQ3XuRWKZxXL
	YKOvcb4P157g1pYatQGpcNrWEc9UVwwMXhgYQfuuA0TNtTkW6n4Dr0T56BYQz9WczibVHP6pdaF
	i0OdJ/AqDGhMTT1JDA8v8hlSVhXtGPok7u2wCT3QFyysuLwp3US54C0Kbue4BcRi8xOJ33hjOer
	V8BP37hXBwNaBUjKAJj/j5zAdSiVXQZYKMGxiwIxjxO0jtKpW7uxnyxCISDQbE=
X-Google-Smtp-Source: AGHT+IG39XZqBGqjXgZTNdRqOLsmNT6O6AZbr/QddiWP1oWwJ6u9G/otU0SUsA5xaXsLXZxxcaOvNX7dt3A7Qfrt52s=
X-Received: by 2002:a05:690e:408b:b0:63e:2341:b7e with SMTP id
 956f58d0204a3-63e23410e78mr12363118d50.19.1761144253552; Wed, 22 Oct 2025
 07:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022093826.113508-1-arighi@nvidia.com>
In-Reply-To: <20251022093826.113508-1-arighi@nvidia.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 22 Oct 2025 10:44:02 -0400
X-Gm-Features: AWmQ_bmPiV5TjhbBUhbRsR-uADmf8JlOAAYxc4ZPmhGa2IVFWjc-sO3GhA9q4DA
Message-ID: <CABFh=a4Vn+FCe9DTLt_p7RzNBSJFU-he+OhNqTK_Z3C5NbP7KA@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Use ___v2 suffix for new
 kfuncs and fix scx build errors
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

On Wed, Oct 22, 2025 at 5:38=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
>
> Following commit 2dbbdeda77a61 ("sched_ext: Fix scx_bpf_dsq_insert()
> backward binary compatibility"), consistently use the ___v2 suffix also
> to the new scx_bpf_dsq_insert_vtime() and scx_bpf_select_cpu_and()
> kfuncs.
>
> Introduce __COMPAT_scx_bpf_select_cpu_and() and
> __COMPAT_scx_bpf_dsq_insert_vtime(), to ensure schedulers can transition
> smoothly to the updated interfaces, and temporarily mirror the
> definitions of struct scx_bpf_select_cpu_and_args and struct
> scx_bpf_dsq_insert_vtime_args to prevent build failures on kernels where
> these structs are not yet defined.
>
> Both the compatibility helpers and mirrored structs will be removed in
> v6.23.
>
> With these changes in place, all schedulers in the scx repository build
> and run correctly with the updated headers.
>
> Fixes: c0d630ba347c7 ("sched_ext: Wrap kfunc args in struct to prepare fo=
r aux__prog")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c                       | 10 ++--
>  kernel/sched/ext_idle.c                  | 10 ++--
>  tools/sched_ext/include/scx/common.bpf.h |  3 --
>  tools/sched_ext/include/scx/compat.bpf.h | 63 +++++++++++++++++-------
>  4 files changed, 56 insertions(+), 30 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index cb41365032ebc..8816d89426a6f 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5490,7 +5490,7 @@ struct scx_bpf_dsq_insert_vtime_args {
>  };
>
>  /**
> - * __scx_bpf_dsq_insert_vtime - Arg-wrapped vtime DSQ insertion
> + * scx_bpf_dsq_insert_vtime___v2 - Arg-wrapped vtime DSQ insertion
>   * @p: task_struct to insert
>   * @args: struct containing the rest of the arguments
>   *       @args->dsq_id: DSQ to insert into
> @@ -5520,8 +5520,8 @@ struct scx_bpf_dsq_insert_vtime_args {
>   * to check the return value.
>   */
>  __bpf_kfunc bool
> -__scx_bpf_dsq_insert_vtime(struct task_struct *p,
> -                          struct scx_bpf_dsq_insert_vtime_args *args)
> +scx_bpf_dsq_insert_vtime___v2(struct task_struct *p,
> +                             struct scx_bpf_dsq_insert_vtime_args *args)
>  {
>         struct scx_sched *sch;
>
> @@ -5536,7 +5536,7 @@ __scx_bpf_dsq_insert_vtime(struct task_struct *p,
>  }
>
>  /*
> - * COMPAT: Will be removed in v6.23.
> + * COMPAT: Will be removed in v6.23 along with the ___v2 suffix.
>   */
>  __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq=
_id,
>                                           u64 slice, u64 vtime, u64 enq_f=
lags)
> @@ -5557,7 +5557,7 @@ __bpf_kfunc_end_defs();
>  BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert___v2, KF_RCU)
> -BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime___v2, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
>
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 3d9d404d5cd20..d4b6b5a300345 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -1003,7 +1003,7 @@ struct scx_bpf_select_cpu_and_args {
>  };
>
>  /**
> - * __scx_bpf_select_cpu_and - Arg-wrapped CPU selection with cpumask
> + * scx_bpf_select_cpu_and___v2 - Arg-wrapped CPU selection with cpumask
>   * @p: task_struct to select a CPU for
>   * @cpus_allowed: cpumask of allowed CPUs
>   * @args: struct containing the rest of the arguments
> @@ -1027,8 +1027,8 @@ struct scx_bpf_select_cpu_and_args {
>   * a negative value if no idle CPU is available.
>   */
>  __bpf_kfunc s32
> -__scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cp=
us_allowed,
> -                        struct scx_bpf_select_cpu_and_args *args)
> +scx_bpf_select_cpu_and___v2(struct task_struct *p, const struct cpumask =
*cpus_allowed,
> +                           struct scx_bpf_select_cpu_and_args *args)
>  {
>         struct scx_sched *sch;
>
> @@ -1043,7 +1043,7 @@ __scx_bpf_select_cpu_and(struct task_struct *p, con=
st struct cpumask *cpus_allow
>  }
>
>  /*
> - * COMPAT: Will be removed in v6.22.
> + * COMPAT: Will be removed in v6.22 along with the ___v2 suffix.
>   */
>  __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_c=
pu, u64 wake_flags,
>                                        const struct cpumask *cpus_allowed=
, u64 flags)
> @@ -1413,7 +1413,7 @@ BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_R=
CU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
> -BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_select_cpu_and___v2, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_idle)
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/i=
nclude/scx/common.bpf.h
> index e65b1eb668ea5..64e5411d04c04 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -60,9 +60,6 @@ static inline void ___vmlinux_h_sanity_check___(void)
>
>  s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
>  s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake=
_flags, bool *is_idle) __ksym;
> -s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask=
 *cpus_allowed,
> -                            struct scx_bpf_select_cpu_and_args *args) __=
ksym __weak;
> -bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_ds=
q_insert_vtime_args *args) __ksym __weak;
>  u32 scx_bpf_dispatch_nr_slots(void) __ksym;
>  void scx_bpf_dispatch_cancel(void) __ksym;
>  bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/i=
nclude/scx/compat.bpf.h
> index a023b71991a6a..963ff3263c20b 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -161,6 +161,25 @@ static inline struct task_struct *__COMPAT_scx_bpf_c=
pu_curr(int cpu)
>         return rq ? rq->curr : NULL;
>  }
>
> +/*
> + * v6.19: Mirror the following _args structs, to prevent build errors in
> + * kernels that don't have these structs defined yet.
> + *
> + * The kernel will carry these mirrored structs until v6.23 (see below).
> + */
> +struct scx_bpf_select_cpu_and_args {
> +       s32                     prev_cpu;
> +       u64                     wake_flags;
> +       u64                     flags;
> +};
> +
> +struct scx_bpf_dsq_insert_vtime_args {
> +       u64                     dsq_id;
> +       u64                     slice;
> +       u64                     vtime;
> +       u64                     enq_flags;
> +};
> +

This redefinition seems to cause compilation problems when compiling
the selftests on 6.19 w/ the patch (errors below). Turning the definitions
into declarations gets the tests to compile.

Maybe we can gate the definitions behind some ifdef? This issue aside,
compiling the tests on a 6.17 system and running them on a 6.19 system
still works, so everything else is in order.

# cd /linux/tools/sched_ext
# make -j9

In file included from scx_simple.bpf.c:23:
In file included from /linux/tools/sched_ext/include/scx/common.bpf.h:765:
/linux/tools/sched_ext/include/scx/compat.bpf.h:170:8: error: redefinition =
of
      'scx_bpf_select_cpu_and_args'
  170 | struct scx_bpf_select_cpu_and_args {
      |        ^
/linux/tools/sched_ext/build/include/vmlinux.h:83614:8: note: previous
definition
      is here
 83614 | struct scx_bpf_select_cpu_and_args {
       |        ^
In file included from scx_simple.bpf.c:23:
In file included from /linux/tools/sched_ext/include/scx/common.bpf.h:765:
/linux/tools/sched_ext/include/scx/compat.bpf.h:176:8: error: redefinition =
of
      'scx_bpf_dsq_insert_vtime_args'
  176 | struct scx_bpf_dsq_insert_vtime_args {
      |        ^
/linux/tools/sched_ext/build/include/vmlinux.h:83607:8: note: previous
definition
      is here
 83607 | struct scx_bpf_dsq_insert_vtime_args {
       |        ^
2 errors generated.
make: *** [Makefile:176:
/linux/tools/sched_ext/build/obj/sched_ext/scx_simple.bpf.o] Error 1
make: *** Waiting for unfinished jobs....
In file included from scx_qmap.bpf.c:25:
In file included from /linux/tools/sched_ext/include/scx/common.bpf.h:765:
/linux/tools/sched_ext/include/scx/compat.bpf.h:170:8: error: redefinition =
of
      'scx_bpf_select_cpu_and_args'
  170 | struct scx_bpf_select_cpu_and_args {
      |        ^
/linux/tools/sched_ext/build/include/vmlinux.h:83614:8: note: previous
definition
      is here
 83614 | struct scx_bpf_select_cpu_and_args {
       |        ^
In file included from scx_qmap.bpf.c:25:
In file included from /linux/tools/sched_ext/include/scx/common.bpf.h:765:
/linux/tools/sched_ext/include/scx/compat.bpf.h:176:8: error: redefinition =
of
      'scx_bpf_dsq_insert_vtime_args'
  176 | struct scx_bpf_dsq_insert_vtime_args {
      |        ^
/linux/tools/sched_ext/build/include/vmlinux.h:83607:8: note: previous
definition
      is here
 83607 | struct scx_bpf_dsq_insert_vtime_args {
       |        ^
2 errors generated.
make: *** [Makefile:176:
/linux/tools/sched_ext/build/obj/sched_ext/scx_qmap.bpf.o] Error 1



>  /*
>   * v6.19: To work around BPF maximum parameter limit, the following kfun=
cs are
>   * replaced with variants that pack scalar arguments in a struct. Wrappe=
rs are
> @@ -170,12 +189,20 @@ static inline struct task_struct *__COMPAT_scx_bpf_=
cpu_curr(int cpu)
>   * compatibility. After v6.23 release, remove the compat handling and mo=
ve the
>   * wrappers to common.bpf.h.
>   */
> -s32 scx_bpf_select_cpu_and___compat(struct task_struct *p, s32 prev_cpu,=
 u64 wake_flags,
> -                                   const struct cpumask *cpus_allowed, u=
64 flags) __ksym __weak;
> -void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p, u64 dsq_id=
, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
> +s32 scx_bpf_select_cpu_and___v2(struct task_struct *p, const struct cpum=
ask *cpus_allowed,
> +                            struct scx_bpf_select_cpu_and_args *args) __=
ksym __weak;
> +
> +s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake=
_flags,
> +                          const struct cpumask *cpus_allowed, u64 flags)=
 __ksym __weak;
> +
> +bool scx_bpf_dsq_insert_vtime___v2(struct task_struct *p,
> +                                  struct scx_bpf_dsq_insert_vtime_args *=
args) __ksym __weak;
> +
> +void scx_bpf_dsq_insert_vtime(struct task_struct *p,
> +                             u64 dsq_id, u64 slice, u64 vtime, u64 enq_f=
lags) __ksym __weak;
>
>  /**
> - * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p
> + * __COMPAT_scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p
>   * @p: task_struct to select a CPU for
>   * @prev_cpu: CPU @p was on previously
>   * @wake_flags: %SCX_WAKE_* flags
> @@ -183,11 +210,12 @@ void scx_bpf_dsq_insert_vtime___compat(struct task_=
struct *p, u64 dsq_id, u64 sl
>   * @flags: %SCX_PICK_IDLE* flags
>   *
>   * Inline wrapper that packs scalar arguments into a struct and calls
> - * __scx_bpf_select_cpu_and(). See __scx_bpf_select_cpu_and() for detail=
s.
> + * scx_bpf_select_cpu_and___v2(). See scx_bpf_select_cpu_and___v2() for
> + * details.
>   */
>  static inline s32
> -scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_fla=
gs,
> -                      const struct cpumask *cpus_allowed, u64 flags)
> +__COMPAT_scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64=
 wake_flags,
> +                               const struct cpumask *cpus_allowed, u64 f=
lags)
>  {
>         if (bpf_core_type_exists(struct scx_bpf_select_cpu_and_args)) {
>                 struct scx_bpf_select_cpu_and_args args =3D {
> @@ -196,15 +224,16 @@ scx_bpf_select_cpu_and(struct task_struct *p, s32 p=
rev_cpu, u64 wake_flags,
>                         .flags =3D flags,
>                 };
>
> -               return __scx_bpf_select_cpu_and(p, cpus_allowed, &args);
> +               return scx_bpf_select_cpu_and___v2(p, cpus_allowed, &args=
);
>         } else {
> -               return scx_bpf_select_cpu_and___compat(p, prev_cpu, wake_=
flags,
> -                                                      cpus_allowed, flag=
s);
> +               return scx_bpf_select_cpu_and(p, prev_cpu, wake_flags,
> +                                             cpus_allowed, flags);
>         }
>  }
>
>  /**
> - * scx_bpf_dsq_insert_vtime - Insert a task into the vtime priority queu=
e of a DSQ
> + * __COMPAT_scx_bpf_dsq_insert_vtime - Insert a task into the vtime
> + *                                    priority queue of a DSQ
>   * @p: task_struct to insert
>   * @dsq_id: DSQ to insert into
>   * @slice: duration @p can run for in nsecs, 0 to keep the current value
> @@ -212,11 +241,12 @@ scx_bpf_select_cpu_and(struct task_struct *p, s32 p=
rev_cpu, u64 wake_flags,
>   * @enq_flags: SCX_ENQ_*
>   *
>   * Inline wrapper that packs scalar arguments into a struct and calls
> - * __scx_bpf_dsq_insert_vtime(). See __scx_bpf_dsq_insert_vtime() for de=
tails.
> + * scx_bpf_dsq_insert_vtime___v2(). See scx_bpf_dsq_insert_vtime___v2() =
for
> + * details.
>   */
>  static inline bool
> -scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u=
64 vtime,
> -                        u64 enq_flags)
> +__COMPAT_scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64=
 slice, u64 vtime,
> +                                 u64 enq_flags)
>  {
>         if (bpf_core_type_exists(struct scx_bpf_dsq_insert_vtime_args)) {
>                 struct scx_bpf_dsq_insert_vtime_args args =3D {
> @@ -226,10 +256,9 @@ scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 =
dsq_id, u64 slice, u64 vtime
>                         .enq_flags =3D enq_flags,
>                 };
>
> -               return __scx_bpf_dsq_insert_vtime(p, &args);
> +               return scx_bpf_dsq_insert_vtime___v2(p, &args);
>         } else {
> -               scx_bpf_dsq_insert_vtime___compat(p, dsq_id, slice, vtime=
,
> -                                                 enq_flags);
> +               scx_bpf_dsq_insert_vtime(p, dsq_id, slice, vtime, enq_fla=
gs);
>                 return true;
>         }
>  }
> --
> 2.51.1
>

Thanks,
Emil

