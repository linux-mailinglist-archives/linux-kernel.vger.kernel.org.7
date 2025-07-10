Return-Path: <linux-kernel+bounces-726186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA05B00928
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15141C208A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402012F005D;
	Thu, 10 Jul 2025 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSVwkVXy"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A962F004D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166085; cv=none; b=QLvLzsOqiDn5uyZgFzlJ9EUdobT11eu92AqEMERsCmib3tyBIL8yNzFA81ynvYHPQ6uQ7+DsfFvJ3BRaMBywFAOnjfR4ktkgRIyOssjDqpuDJ+FxLvEUscz4nf1UGSOfWX2SHFRxuqlkzFeu8S6FbTTIvVSXSoUH0Ge/uFqi4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166085; c=relaxed/simple;
	bh=9/WPru0K5gd56bfvKG6rCeKMJQOeQ/IbLTLatArSyko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojBcwtVqe/4+LaA4mTx70/RcXiUtTkRLacpmYxzae9uboeSOWF/KzGFNVshI4aFBnrq4gB0LKVPObnBCKrm5GmQ8TnCppEgCXwNaAhjBJ3D6uXO336Lx91019vNmoTcJcPfl0AfiYnngji/QGoVS04wjHg83DG1J6FWRoNYfttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xSVwkVXy; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so228991266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752166082; x=1752770882; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2vsrv/dCbGf7XZPYnv3R359okUiufCgNAHT6duccBmc=;
        b=xSVwkVXyOwHlP0SGl2XzXNIG6SuNHECyhV9y2/xAbNnrTuEAA90myzx41j+UwZ4qhR
         WEblTBugF5l5Wm+LEEmYwDMscEi1ByDpEM3x9SuhaYabdPHRGkpl8P0hwKAorZnAInA3
         BADYkAJwj7LvIL4CrgB1U/IdVQsi7HnRPOuyARqa2yepQM8JP727+5L9tRRgBk41crWC
         p+qDQQ1nGfnMOsUb+lBioZiM4lMETaaSssWmdV9OBbPMtNcYIc+XZjrEM7atNdP6fehq
         MEOMt0EcmT4+UAmWihdDxje3bnq0nRLSIPPGAlpuOBusSZxZjKIn1igpw5HokakfL3sA
         Vpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752166082; x=1752770882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vsrv/dCbGf7XZPYnv3R359okUiufCgNAHT6duccBmc=;
        b=G+ppMNHR0AhcVrbgC8KVnZ/rs9UCJHKGagijQbr3i9+XXDNsd4T79QrvIVxvCxhgcP
         By3PyG4r9XUzS5e/pX2XPBVoin0+tCxgEsz5ZcF+yRicxKyPgn9eKB3dP9/i0DI5sM3B
         ZPLklpDX4DKLvlrkwHetLHcseqAP6Kaz8m9o5jgaa7vrka9v7U43lLocfYqpZiDwbtot
         2bAyTjg/BphY7IKXx4zKEIbDGHnM6yxPY6AlVP9jL63Iz9bTqhOkEy8gtLTcDsWFAvRK
         5sI+yYqhIJZEsi7HgCTfAceLTpQECAQwPcP1qxWKpOa6Fe1Xky5Y5mIjenwmQUhqZTng
         1QcA==
X-Forwarded-Encrypted: i=1; AJvYcCVW2YQkNWNqtznY6qHr+Tgo0XFrpJVOaZ/IogSlgkcxDTfD/Mu4fRjM0PjA2XKNQKArKt56yA5bw+yp+i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSdZO3NTmuiYLD4j7MS7RAw33XSSohlm9nWpoZEioOFA1qQJ6h
	zcxvFAncwAVWyDWhmPmE7NS3Uht1XSyIrALQHq1AYxRjdPvCZyORoIKpxAUqtlsOemlBFiLRcF0
	aZj4OwDWsJZuHIH7/+MOy0pCOx/iNsAT/fNDhf/yMpg==
X-Gm-Gg: ASbGncu/+VPNkcMJyPUiVBoKcfb8KtcyF0g5BPqj1SmQP3pKp5v24RP9v35l/fWh7/B
	ZomzhRadPhgiVue2Ss367X5FW0TqrSpx4Ou1XlSpW6DB/hVr1THhINNOkqYXecBs6lk3VpvfwXg
	ym/8SD3qF52r474BRl130A9gJIyn5yrSZqorNJ40vxGXjWijqp/M86KpPfu+F7nbWdVDfprKAt
X-Google-Smtp-Source: AGHT+IGDd9xoTUdn4lUQspqnTXMPBXhJcK1zPMvsmx4gqbIn8l4+Aanw7+MQE8E5zjS1a3uTMjVFuzDnH27DP6k3zJc=
X-Received: by 2002:a17:906:f5a4:b0:ad4:f517:ca3 with SMTP id
 a640c23a62f3a-ae6e1119b01mr524784366b.20.1752166081860; Thu, 10 Jul 2025
 09:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702114924.091581796@infradead.org> <20250702121158.582321755@infradead.org>
In-Reply-To: <20250702121158.582321755@infradead.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 10 Jul 2025 18:47:49 +0200
X-Gm-Features: Ac12FXwCv-kZSiesJR0OtXj7VVGrS5FhD-uNsh0uZHjOMsJ87r7C0Wl-TZyHpUA
Message-ID: <CAKfTPtBjtHdFUNCfe4+iiRXf570_GSHPvRtuhzHndf0PD4fmJQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] sched: Optimize ttwu() / select_task_rq()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	clm@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Jul 2025 at 14:12, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Optimize ttwu() by pushing select_idle_siblings() up above waiting for
> on_cpu(). This allows making use of the cycles otherwise spend waiting
> to search for an idle CPU.
>
> One little detail is that since the task we're looking for an idle CPU
> for might still be on the CPU, that CPU won't report as running the
> idle task, and thus won't find his own CPU idle, even when it is.
>
> To compensate, remove the 'rq->curr == rq->idle' condition from
> idle_cpu() -- it doesn't really make sense anyway.
>
> Additionally, Chris found (concurrently) that perf-c2c reported that
> test as being a cache-miss monster.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20250520101727.620602459@infradead.org

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> ---
>  kernel/sched/core.c     |    5 +++--
>  kernel/sched/syscalls.c |    3 ---
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3593,7 +3593,7 @@ int select_task_rq(struct task_struct *p
>                 cpu = p->sched_class->select_task_rq(p, cpu, *wake_flags);
>                 *wake_flags |= WF_RQ_SELECTED;
>         } else {
> -               cpu = cpumask_any(p->cpus_ptr);
> +               cpu = task_cpu(p);
>         }
>
>         /*
> @@ -4309,6 +4309,8 @@ int try_to_wake_up(struct task_struct *p
>                     ttwu_queue_wakelist(p, task_cpu(p), wake_flags))
>                         break;
>
> +               cpu = select_task_rq(p, p->wake_cpu, &wake_flags);
> +
>                 /*
>                  * If the owning (remote) CPU is still in the middle of schedule() with
>                  * this task as prev, wait until it's done referencing the task.
> @@ -4320,7 +4322,6 @@ int try_to_wake_up(struct task_struct *p
>                  */
>                 smp_cond_load_acquire(&p->on_cpu, !VAL);
>
> -               cpu = select_task_rq(p, p->wake_cpu, &wake_flags);
>                 if (task_cpu(p) != cpu) {
>                         if (p->in_iowait) {
>                                 delayacct_blkio_end(p);
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -203,9 +203,6 @@ int idle_cpu(int cpu)
>  {
>         struct rq *rq = cpu_rq(cpu);
>
> -       if (rq->curr != rq->idle)
> -               return 0;
> -
>         if (rq->nr_running)
>                 return 0;
>
>
>

