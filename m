Return-Path: <linux-kernel+bounces-870156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6908CC0A105
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 01:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D08AF4E4031
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586702DEA87;
	Sat, 25 Oct 2025 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="x/eJk5kn"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78672DE703
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761434358; cv=none; b=cNGiuEsq8YpVbvHmYGCngqiuYRJYWjiRqI2g5Tbr6fLJSKOF5ds5GMCe9Ym9FMDZ+y0nDA2EkRtaK2HiI9ENpHW6P16oozYePMcNT861gGZnvjT1FUiekBILiIja94htzdOvKKorPLO8aNnvh4UB9Nrz2XE6MLuJ6DeEBOkKxUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761434358; c=relaxed/simple;
	bh=URJlCVicZhm+oeTzrJXAhhMSWhyRebViHBBjjqxzfZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZzvySCNuEHYsMR75DzvdhK75ZVmLcLXxIns4/tV+J+6P/O5muxtMxlWMbRsHIKe3q7ik6Lin7iKSz0gNNJyCGpnCjUAyxs3B8VWHSTyAa+I0Pfa0c1OI59QmXq0i3yxhHBb/yTsdqpr+uE0h/nz6H9njjCtAJTmMOasPAJN21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=x/eJk5kn; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-73b4e3d0756so33736277b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1761434355; x=1762039155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z65Za7rXC8MqpESbbemIcqGNq0y/exeyJvrr1tkhhcQ=;
        b=x/eJk5knIjhAN7M/nH9VzIEhS6LzVpmFhNtQU0xtPPfjVq8ZuOOyFNioKnLJZvfXxt
         S+geyTff0l6bXhpSypmgcfXZIOgLXPXkd6DBb5Fwb1umPb3hetkmBgI7mKrw9MDJiDjR
         va9hd50vAotT5nps0qz5IPk2S02zITAft7z4NVpHkFI2nGSspetmPCyEcjoyxRWfWlZB
         /vHm8Jl8s9wrn3jcuia7UmrzOgDD/Ndev7WFFMOTHINZqGyTZVSWko06feAWjPsiW3PH
         pZoTNtliy1DAiJRn3IWKphAacyLOHCg80DdtBqpCY/jYpbhOJ5uNpeZA4eg3uFtLSdYu
         hXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761434355; x=1762039155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z65Za7rXC8MqpESbbemIcqGNq0y/exeyJvrr1tkhhcQ=;
        b=q94OlEO8oN7mp20rVvZCjMZc76I+D7rKt0FVnV6qR8TjH7E/kqFCguxxBjhrAiA/rN
         kVbCs8Wf16ScdUvDOdYcnC8e0LM9yN4XsEjl7qc8R67SgQ8+Zj2G5onYGHfrEBDeh8Kh
         ylOk4S/jXubvzp88/3aZYvlPPjlLhhyMrlkg1qMMShEF02EQvrd2ha3JfoqsYf+3dU/U
         bBn3C0WEsATZySw03l+zwvvgZYcSLMZcmS/t3OTWdxVYMQYPQ6vVI2l2xiFZklgxl6gk
         iXF0PBqfHMgE55MYWarjUfVkJ5afpSlilGkcklP0Q+292N78FBgSLjSE6C9Dj2x7q1qV
         uafg==
X-Forwarded-Encrypted: i=1; AJvYcCUmcZivAxK8s5dbeV1yI1jFtaSPTn0rjyzTsRb5s/ZJg2TKE1sap0HNj5BYdnQWUBrBd/9DWmOUMqT9MXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+lRErrL9uDRqQPqe4utoQMNRLtTDK3ymZ8Vcr+sHYD0Ys4BmK
	fo/74MvcdcoEHW9/roBHv50E4dcikmIHsFeF5zYFrPdcrcE6631CMbyUXJ1SUWvhGWFjRI5gUnl
	bn680dEE4pk5qhmev0MxIhYNmKWR56qexw5Q8MpBHqHBv0csTE6dV5eA=
X-Gm-Gg: ASbGncuozwchIouvRmo5h8nxR9gp3ejQrQkMqfHI6KvhcpkTB+z+amrDUDP9XfoUYu9
	/TcrBYjTNcfxiPVbRG84A14kjA+UeeL8XU66oFfldKArhOhmDit7NgemAPNQCDMaDV3W8Pm86ip
	qo0/G7Er73SBtXPaM3MkhJ6D/VfmNOYCf3bTo68CTF3G3vFdWediq9Ha2/V+nTVVT9sjcwxbkCg
	dCtUSt+2qzHc9p92J6RN1dEiqglMBxOdwyyKW/K9zwqpl/xUl8FxYjoTBx51L9UOMrbxnKYcA==
X-Google-Smtp-Source: AGHT+IHXZu5cLWt/PiTOREaGquHeok6rGtaRuaSbXTkjGC2A+8z0JnQnXbkKFDEK+CktDKRCiWYdomoYKxeCE4eJg7E=
X-Received: by 2002:a05:690e:124c:b0:63f:580c:8b60 with SMTP id
 956f58d0204a3-63f580c8ccdmr575228d50.67.1761434355559; Sat, 25 Oct 2025
 16:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025001849.1915635-1-tj@kernel.org> <20251025001849.1915635-3-tj@kernel.org>
In-Reply-To: <20251025001849.1915635-3-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Sat, 25 Oct 2025 19:19:05 -0400
X-Gm-Features: AWmQ_bkurP8V5hEnVqiEa2FzBR81gtLdBm2d_U5QRVaRHsjoZXcdo92K3TTXe_A
Message-ID: <CABFh=a4faAi0_GNQQrFQKfLFtKrOFDBEBoCFUC4dvHf2taCkFA@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched_ext: Factor out reenq_local() from scx_bpf_reenqueue_local()
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Wen-Fang Liu <liuwenfang@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:18=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Factor out the core re-enqueue logic from scx_bpf_reenqueue_local() into =
a
> new reenq_local() helper function. scx_bpf_reenqueue_local() now handles =
the
> BPF kfunc checks and calls reenq_local() to perform the actual work.
>
> This is a prep patch to allow reenq_local() to be called from other conte=
xts.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/sched/ext.c | 50 +++++++++++++++++++++++++++++-------------------=
--
>  1 file changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 111111111111..222222222222 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5881,32 +5881,12 @@ static const struct btf_kfunc_id_set scx_kfunc_se=
t_dispatch =3D {
>         .set                    =3D &scx_kfunc_ids_dispatch,
>  };
>
> -__bpf_kfunc_start_defs();
> -
> -/**
> - * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
> - *
> - * Iterate over all of the tasks currently enqueued on the local DSQ of =
the
> - * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the n=
umber of
> - * processed tasks. Can only be called from ops.cpu_release().
> - */
> -__bpf_kfunc u32 scx_bpf_reenqueue_local(void)
> +static u32 reenq_local(struct rq *rq)
>  {
> -       struct scx_sched *sch;
>         LIST_HEAD(tasks);
>         u32 nr_enqueued =3D 0;
> -       struct rq *rq;
>         struct task_struct *p, *n;
>
> -       guard(rcu)();
> -       sch =3D rcu_dereference(scx_root);
> -       if (unlikely(!sch))
> -               return 0;
> -
> -       if (!scx_kf_allowed(sch, SCX_KF_CPU_RELEASE))
> -               return 0;
> -
> -       rq =3D cpu_rq(smp_processor_id());
>         lockdep_assert_rq_held(rq);
>
>         /*
> @@ -5943,6 +5923,34 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
>         return nr_enqueued;
>  }
>
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
> + *
> + * Iterate over all of the tasks currently enqueued on the local DSQ of =
the
> + * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the n=
umber of
> + * processed tasks. Can only be called from ops.cpu_release().
> + */
> +__bpf_kfunc u32 scx_bpf_reenqueue_local(void)
> +{
> +       struct scx_sched *sch;
> +       struct rq *rq;
> +
> +       guard(rcu)();
> +       sch =3D rcu_dereference(scx_root);
> +       if (unlikely(!sch))
> +               return 0;
> +
> +       if (!scx_kf_allowed(sch, SCX_KF_CPU_RELEASE))
> +               return 0;
> +
> +       rq =3D cpu_rq(smp_processor_id());
> +       lockdep_assert_rq_held(rq);
> +
> +       return reenq_local(rq);
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(scx_kfunc_ids_cpu_release)
> --
> 2.47.1
>

