Return-Path: <linux-kernel+bounces-726194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72211B0093B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFA7565B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEEA2F005D;
	Thu, 10 Jul 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbvLjpfQ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659462F0C50
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166309; cv=none; b=tvsHxGh37OaoOBMNveC36gqGFTr9PCX/9oeTXNDinQuVA/h6Q9a9IPXRSJOV2Rx5O0VyFtretiHB1gm5mX5sY6WyGsGT2DDfFhraAm069frP2A1Q+pBbsANqJ5UJNMTzLWHQk3CzGcCA3s01lYWsWSXdVnYZin1bZkfXVZw1lqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166309; c=relaxed/simple;
	bh=Poy+8cnHGuPVR17PPWLi7uFNCQJVr2Mhw7UcdTU8/OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkqAwawokQOTnt9mAs080vapODf2NHT15PoC9ehR4Ij5mDNJfAk/6VoR5O1efh0k/OPPqAAel3LM6KuZesnmvPd/oOWvFfMREAbLWC/kV6nHO10MEJfplZ+VSJclJMR66q9psfDwf5wKwVIoHPDotWRKRlc85p35QXTR2WWzB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tbvLjpfQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-acb5ec407b1so213729866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752166306; x=1752771106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rg7W3ayUlyQb5JFJl5mEXAZmxkN3IEghiswwsXYU9CQ=;
        b=tbvLjpfQpSUNj4DhY7xxdjAu6taS9CUS6+TJb83I0F+cfcAZwrrNrjMSz9FsxVRA0i
         Z4UfJDIgqMk0rPRTHxppGFSjjhYjP5uZ8oyoLhXfG271feNc93KYfkPCfiJs91msbdYd
         5ShLwPbYWCruQPNru7Au2MLgyc6WnLDTH37KkjF7g5Coi75vtxUfIXWB46W+2MUqTiWd
         zgscJiqfXYBDUDfYjiqu0MpPmHw58AsQZ/B5kD+3aDlRmTTSEke69R3iLF040JHwWM0d
         WgdyygrYLGHdRMPLcqB2act17bawAHzh6ph8pv2iZA+mJK1yboD0khUohHBI8DS+dLYV
         D/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752166306; x=1752771106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rg7W3ayUlyQb5JFJl5mEXAZmxkN3IEghiswwsXYU9CQ=;
        b=Hg+LMKzwBaIqwZlaCxGf8VZCYyV6s8v9ojhRFamNx1kIA2X8vJsuX8H01rIJK4oOhD
         KrURLhiD2w6eyonqMKonEacqgNP8+BWl34FZB64172W3acQyUfoRmye/IhgHpKx13GHZ
         zLX6XrKRbpMAjkSFTKNp4VuDejchiL3X5q2UMxB03d6bnYECzPnFMSNNBPNLNXxUQjg8
         ib9VCi4VF1d+7f9L17dcccCZuQY5imAUHvZGOXv0cJLVPR+/riW9/a/pIirQxFS6Pd/x
         B6x7K91WZvQclJoJOaf1aDLaDA0JIo0EPaD9Bb6sGqNQAqkjf5lvFZBsuN7NAeJP/Cjz
         fdPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeeeFgP9Ii/9u/DNcYqpmQfMkYE9M6oW0twMsDRvTfEsntUxmyYVA2EhEkIDG/7Sz+gevNU7iwKdw0MH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypoYs8wwUkElO0voVa1Z+LxjX46ydnx9juyS0KLxwsTmJiCy3I
	HapWCTAf2fV0XJC3knFF4g3cHfGsJnV0ibtiZDkAivxkLGlFxTfxUsdiggvdkYtQvMQeMbJbsqV
	2sJNj9o5hg4LFUtDu5XRcRre0l6qIp3ygiChxQ/oowA==
X-Gm-Gg: ASbGncuuwSdDjBWaHUtin+MvO5As9zCD/m/LsN52Rcxd9RXI1kT5MDD059SKGuMfeOv
	WHYiyJvOlcr5ZBF5AKv8Ht4k+ZlZ3KHfkbNsCT7qQUolYbwfGMIDGWNDZhVr1211nMBb9S+Hxqq
	w13JcPdD3RgyvKRno0wO6jBJTwmEBE9uKRSKSWiyYn53qXy6dK8zPwIyre28ZE4hPX5MFDon9I
X-Google-Smtp-Source: AGHT+IFfJtIHNBZ6smaTawvTed2QjaILq3BHfb1Vrxj6H6JFA8ISi2ODSS+iye9EggrB5gEB2g9NJinGyg5ngkFHIlI=
X-Received: by 2002:a17:906:f5a8:b0:ae0:c943:785c with SMTP id
 a640c23a62f3a-ae6e1250017mr482030066b.35.1752166305605; Thu, 10 Jul 2025
 09:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702114924.091581796@infradead.org> <20250702121158.817814031@infradead.org>
In-Reply-To: <20250702121158.817814031@infradead.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 10 Jul 2025 18:51:34 +0200
X-Gm-Features: Ac12FXxh3eeLKXMdnGOZfEfWIcxdu9DyzkOE_5vDXCXi1bt6P0QUv6R91-UNl70
Message-ID: <CAKfTPtCKJi_H1MYhfiaAkeNnAyP8p6pTaJurQ5ZM7Q-mUi3wZA@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] sched: Add ttwu_queue controls
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	clm@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Jul 2025 at 14:12, Peter Zijlstra <peterz@infradead.org> wrote:
>
> There are two (soon three) callers of ttwu_queue_wakelist(),
> distinguish them with their own WF_ and add some knobs on.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20250520101727.874587738@infradead.org
> ---
>  kernel/sched/core.c     |   22 ++++++++++++----------
>  kernel/sched/features.h |    2 ++
>  kernel/sched/sched.h    |    2 ++
>  3 files changed, 16 insertions(+), 10 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3888,7 +3888,7 @@ bool cpus_share_resources(int this_cpu,
>         return per_cpu(sd_share_id, this_cpu) == per_cpu(sd_share_id, that_cpu);
>  }
>
> -static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
> +static inline bool ttwu_queue_cond(struct task_struct *p, int cpu, bool def)
>  {
>         /* See SCX_OPS_ALLOW_QUEUED_WAKEUP. */
>         if (!scx_allow_ttwu_queue(p))
> @@ -3929,18 +3929,19 @@ static inline bool ttwu_queue_cond(struc
>         if (!cpu_rq(cpu)->nr_running)
>                 return true;
>
> -       return false;
> +       return def;
>  }
>
>  static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
>  {
> -       if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(p, cpu)) {
> -               sched_clock_cpu(cpu); /* Sync clocks across CPUs */
> -               __ttwu_queue_wakelist(p, cpu, wake_flags);
> -               return true;
> -       }
> +       bool def = sched_feat(TTWU_QUEUE_DEFAULT);

I'm always confused by this sched feature name because
sched_feat(TTWU_QUEUE_DEFAULT) must be false in order to have the
current (default ?) behaviour
Or you mean queue by default in the wakelist which is disable to keep
current behavior

> +
> +       if (!ttwu_queue_cond(p, cpu, def))
> +               return false;
>
> -       return false;
> +       sched_clock_cpu(cpu); /* Sync clocks across CPUs */
> +       __ttwu_queue_wakelist(p, cpu, wake_flags);
> +       return true;
>  }
>
>  static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
> @@ -3948,7 +3949,7 @@ static void ttwu_queue(struct task_struc
>         struct rq *rq = cpu_rq(cpu);
>         struct rq_flags rf;
>
> -       if (ttwu_queue_wakelist(p, cpu, wake_flags))
> +       if (sched_feat(TTWU_QUEUE) && ttwu_queue_wakelist(p, cpu, wake_flags))
>                 return;
>
>         rq_lock(rq, &rf);
> @@ -4251,7 +4252,8 @@ int try_to_wake_up(struct task_struct *p
>                  * scheduling.
>                  */
>                 if (smp_load_acquire(&p->on_cpu) &&
> -                   ttwu_queue_wakelist(p, task_cpu(p), wake_flags))
> +                   sched_feat(TTWU_QUEUE_ON_CPU) &&
> +                   ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
>                         break;
>
>                 cpu = select_task_rq(p, p->wake_cpu, &wake_flags);
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -81,6 +81,8 @@ SCHED_FEAT(TTWU_QUEUE, false)
>   */
>  SCHED_FEAT(TTWU_QUEUE, true)
>  #endif
> +SCHED_FEAT(TTWU_QUEUE_ON_CPU, true)
> +SCHED_FEAT(TTWU_QUEUE_DEFAULT, false)
>
>  /*
>   * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2279,6 +2279,8 @@ static inline int task_on_rq_migrating(s
>  #define WF_CURRENT_CPU         0x40 /* Prefer to move the wakee to the current CPU. */
>  #define WF_RQ_SELECTED         0x80 /* ->select_task_rq() was called */
>
> +#define WF_ON_CPU              0x0100
> +
>  static_assert(WF_EXEC == SD_BALANCE_EXEC);
>  static_assert(WF_FORK == SD_BALANCE_FORK);
>  static_assert(WF_TTWU == SD_BALANCE_WAKE);
>
>

