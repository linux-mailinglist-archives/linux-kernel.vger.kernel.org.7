Return-Path: <linux-kernel+bounces-867136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C3DC01AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CB23B2134
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AC1319848;
	Thu, 23 Oct 2025 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="uRIJyI3T"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CB530BB80
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228267; cv=none; b=iUcw+x9Sv2cBpBSnYaJaaq3jpHLMDr7TyjYAl7j0ChuZK+u3di3UkkjBMJdDLUfL52yAUItTu9RxZ1oZX+SmZlD86/rjs9MIFtJQCJiADeD1R5aYpGQmfgMP6F5XC6tjc2RAkH2F+DgP2XTJGwYvp2gaF4vN5X2DImbzU23Nlrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228267; c=relaxed/simple;
	bh=5GiTTJ/V4N6ZMDGl9YJyFnN1W24wDkPrKk2JEhAebdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3tyYejm3thWBoEBs+mYM1pZkpF0Ro+2MqTOlbs5523zN0p+8aTxDFRCwNVgonfJ610ndPsYamWOm3E0Rq3Otv3cT1JI21QnCcErOIhwl9epsWLW/YVATszS8+Ns8l+nAH1xPVohylZW9FUD7ZOFTGeyWhmRZhYa0gKRW5eFCnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=uRIJyI3T; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63e1a326253so943840d50.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1761228264; x=1761833064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8J8W/4L7ibTLS0Bia7yvTTNJ+W7TrnhRbawnUFjqqNQ=;
        b=uRIJyI3TAWsr8TYWYhdezUzZwTe6AtCZnQoVEfhE1TYpr2Tq9awrZ6gABbT+HQnCS/
         Lp0vVqddi5pyRr4Z3bhlWr2wKJaztf9C5VnePqbyNcaroLMM2VZJ/lhWdVFf3OFcPUUS
         AZhZSOa3slDuQTbDSj3b1YTVf1Rx9PlyqiUFZiMSnu6TWuU4Ogc+9vCdWahpLwgMBD+9
         J41I7aV0MxSK6rRZ6awh762v4T6a1M4wXJ/9K/INHLtV8Qc9pcMQXayjA6IMCf30nOVA
         /jLHxSiF0koJJTulsxz7OaCZ1v9VeSdzXqTyKuMuRKvJ5Lp4YRu0tCqkcIOdvVjfhSx0
         OynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228264; x=1761833064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8J8W/4L7ibTLS0Bia7yvTTNJ+W7TrnhRbawnUFjqqNQ=;
        b=KnDSyi1CNYbu43F4PzGb7PLegHHyTYxSiTCSaOhXpvaXNVAA9kmrDoPesMTZwgLgWZ
         2V/gJEWp3STYNJMYVe3RjIBxeeMocplE57OqTdqbMtHOYYFpvQ8jSDnYD0ItDqGwVvPV
         P+4AObiX/YwML9tpNZBFpWdUAWaMKWQX/Pf9G86XBlaMgu3Vtvwj22456fnqn6Wx3WtY
         O8JbNHhs4Y56lkFXQdIGs1wLl9tnC6pQbbl4uiuFKqfg6BK1Wg8YTPTMAavR30muWVyA
         aZWxCS4APwDa2i3qMW79rERIrSSdWCJQAOKKwg/usRo275ExHO/gyPdFYeTiDg8H3hW6
         tTIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq1h6Y4OHqU5jq7VaONYQsXzGHyZPWYuhhjgNf0hgAypA1l642EcUMkJyZNNuzrqWikiGrd1WNRPaN5vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+S/jk8QdGzNpYPbw+fBqHvicGhfdU2Op7p7UaqhQA4bk3QJC2
	Bko4krnNY1KC5QE3lN993tVZGpDFiOoE2h2puLu56hbO48ZlMYQ+8Qx0JI6C3NoZ0XbMxXdotHD
	manZtoosF3bIe4uwVTYEP9L8DKhTqyQtiNVefia9GwtkTeSMdFwJmoU0=
X-Gm-Gg: ASbGncvQMXglcxsqd/ltO0N8oeC255A4qkIWkq2VbuD0JbMqctD3wfOiasts98L4rTd
	iJVtt/IX7OpSYk0wtZP4AnLUZ21RJUcewMSLop2DT6wvfNMN7RpbOGztjrGrBKDI+iTeTe0tsW4
	tuNlgOdSbB3ftgPb683wFLdvaiQhnkTVtp+cLxEcYcsFRnTXbl8s/eKF5T6SZ3x/30au8D+p3Vh
	EOTQofPbeCnLoMzhZW47s26+PupTtMJs8QP+OkchOxlCUF4SWBituoVzjnhc7Y=
X-Google-Smtp-Source: AGHT+IGjkj4Vq+RYZ1BNhqghj1MG0T/9n6DAldT6/wV4FPLBWGPt1qZo28oeUBDysRpcui7hFmQ1+8o6Ij5ujeyDl6k=
X-Received: by 2002:a05:690e:1699:b0:63e:27e6:87a2 with SMTP id
 956f58d0204a3-63e27e68918mr13009967d50.46.1761228249887; Thu, 23 Oct 2025
 07:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023080130.76761-1-arighi@nvidia.com>
In-Reply-To: <20251023080130.76761-1-arighi@nvidia.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Thu, 23 Oct 2025 10:03:58 -0400
X-Gm-Features: AWmQ_bkyx9eKFwXSoUOomaXE-OysM83cIrNTnVb2dOkFLwm_-z0p1_rPmf4bW7c
Message-ID: <CABFh=a7EZQanSX+=of5A41Kwy83YDmu-AoGJ5hCns8YNkJ2FxA@mail.gmail.com>
Subject: Re: [PATCH v3 sched_ext/for-6.19] sched_ext/tools: Add compat layer
 for kfuncs using struct *_args
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:01=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
>
> Commit c0d630ba347c7 ("sched_ext: Wrap kfunc args in struct to prepare
> for aux__prog") introduced new kfuncs that take their scalar arguments
> packed into dedicated *_args structs.
>
> However, these new kfuncs need to coexist with the previous scalar
> variants, which causes build failures in sched_ext schedulers when
> building against older kernels.
>
> To address this, mirror the struct definitions adding a __COMPAT prefix,
> ensuring schedulers can still build also on old kernels that don't have
> the BTF definitions for these structs.
>
> Moreover, add a __COMPAT_bpf_ksym_exists() helper, which extends
> bpf_ksym_exists() to handle static inline kfunc wrappers and fall back
> to the *___compat() variants, where available.
>
> Fixes: c0d630ba347c7 ("sched_ext: Wrap kfunc args in struct to prepare fo=
r aux__prog")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

Tested the patch on a 6.17 and a 6.19 system, binaries run on both
when compiled on either.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> Changes v2 -> v3:
>  - Drop the ___v2() suffix from the new kfuncs (Tejun)
>  - Add __COMPAT_bpf_ksym_exists() to handle kfunc detection with static
>    inline wrappers
>  - Link to v2: https://lore.kernel.org/all/20251022153610.20111-1-arighi@=
nvidia.com/
>
> ChangeLog v1 -> v2:
>  - Introduce __COMPAT_* struct to fix build error with v6.19 (thanks Emil=
)
>
>  tools/sched_ext/include/scx/common.bpf.h |  3 --
>  tools/sched_ext/include/scx/compat.bpf.h | 36 +++++++++++++++++++++++-
>  2 files changed, 35 insertions(+), 4 deletions(-)
>
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
> index a023b71991a6a..d534cacb94066 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -15,6 +15,13 @@
>         __ret;                                                           =
       \
>  })
>
> +/*
> + * Extended version of bpf_ksym_exists() that handles static inline kfun=
c
> + * wrappers, falling back to the *___compat versions.
> + */
> +#define __COMPAT_bpf_ksym_exists(sym) \
> +       (__builtin_constant_p(!!sym) ? bpf_ksym_exists(sym##___compat) : =
!!sym)
> +
>  /*
>   * v6.15: 950ad93df2fc ("bpf: add kfunc for populating cpumask bits")
>   *
> @@ -161,6 +168,27 @@ static inline struct task_struct *__COMPAT_scx_bpf_c=
pu_curr(int cpu)
>         return rq ? rq->curr : NULL;
>  }
>
> +/*
> + * v6.19: Mirror the following _args structs, to prevent build errors in
> + * kernels that don't have these structs defined yet.
> + *
> + * The kernel will carry these __COMPAT_* structs until v6.23 (see below=
).
> + */
> +#define scx_bpf_select_cpu_and_args __COMPAT_scx_bpf_select_cpu_and_args
> +struct __COMPAT_scx_bpf_select_cpu_and_args {
> +       s32 prev_cpu;
> +       u64 wake_flags;
> +       u64 flags;
> +};
> +
> +#define scx_bpf_dsq_insert_vtime_args __COMPAT_scx_bpf_dsq_insert_vtime_=
args
> +struct __COMPAT_scx_bpf_dsq_insert_vtime_args {
> +       u64 dsq_id;
> +       u64 slice;
> +       u64 vtime;
> +       u64 enq_flags;
> +};
> +
>  /*
>   * v6.19: To work around BPF maximum parameter limit, the following kfun=
cs are
>   * replaced with variants that pack scalar arguments in a struct. Wrappe=
rs are
> @@ -170,9 +198,15 @@ static inline struct task_struct *__COMPAT_scx_bpf_c=
pu_curr(int cpu)
>   * compatibility. After v6.23 release, remove the compat handling and mo=
ve the
>   * wrappers to common.bpf.h.
>   */
> +s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask=
 *cpus_allowed,
> +                            struct scx_bpf_select_cpu_and_args *args) __=
ksym __weak;
>  s32 scx_bpf_select_cpu_and___compat(struct task_struct *p, s32 prev_cpu,=
 u64 wake_flags,
>                                     const struct cpumask *cpus_allowed, u=
64 flags) __ksym __weak;
> -void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p, u64 dsq_id=
, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
> +
> +bool __scx_bpf_dsq_insert_vtime(struct task_struct *p,
> +                               struct scx_bpf_dsq_insert_vtime_args *arg=
s) __ksym __weak;
> +void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p,
> +                               u64 dsq_id, u64 slice, u64 vtime, u64 enq=
_flags) __ksym __weak;
>
>  /**
>   * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p
> --
> 2.51.1
>

