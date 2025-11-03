Return-Path: <linux-kernel+bounces-882532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0489FC2AACF
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7B314E40BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725392E5B1D;
	Mon,  3 Nov 2025 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTbzegrB"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3711EEB3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160668; cv=none; b=iIPE7TfyX1iaArnWmfJTXdZd8oQCLxELqFMokk8b/X9UXdHUKlIFfmBVlQtJSw6OgXedcr34GJ+EVGTkTrfLr3vrHfQBohAF7KHWcNXhVwvgFnJ0GwNj+c8f5MTjmEJwsZFYGvHlZn3STBZPtcBrFmPg7z/Gk7XxIsBU+V0PMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160668; c=relaxed/simple;
	bh=tV6UXJ0HM5G+H0oioa1cmnrMBNFf/EwaCWdEDzaPMN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHh5epZfE+/EUtg0xwfSytsoeqp5oHWEiovh2JBw6e3WrWSvQkj6m4dbnVGJ1gdRvd6jDAbj4R4Ii7Fs+laRBK6fKtcvlbWJHpSjEWWX3LLQHcWRLa1RHCkQ+mxGzT1cLfGrs5xeB7CXvtxxbyDYbWQyO35OzZi4nguzO7mOOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VTbzegrB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so1836944a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762160665; x=1762765465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cdy2iLH/iyHDOo0ysoqKpyMQzKMQbVYwfSzFM61M/6Y=;
        b=VTbzegrBTksnod0dIAPHwvi48fsb7gInAjHiIFbVdqdpSewi1vZf6NLSkLGLIcpjDJ
         gLe0zV2ijGBaSVoMSLcVOAnTchUjVNcqSdcMlqgODDy9Ih/4w/vUOwKSQG0M/ut4GzyP
         /NiVRKeC8vsu9Kg1BM8tOOsKpeqFREmv7f8KqALul5sVUGV7CBDwoLDfxLdvEPh2rRgk
         ANFdn3bKM3Ax4cgmZ2FPWCP494glRUoz4V71HAys4LwNFce5nQIIefxLMKUKjLVkLDmN
         BYvtxmmxyNIabHaszEBpZ4rnVCPYbXXcl+x0ir7Ok+UE+EeQteFGJABpuVkRa1Fs+d9c
         KeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762160665; x=1762765465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cdy2iLH/iyHDOo0ysoqKpyMQzKMQbVYwfSzFM61M/6Y=;
        b=a5d/TGAET68HGldIMXvQ4xQaTHHkn5LvZSb7xPbWGgMRvWoxSn5AM8DSU5CrZbRrak
         n6q5z3WFEF4RgOtc9shXpdlWWIGWm5H+kt9Z1jf5o0QOoa8trPO6QZIZsuazEKZ0uWfG
         407f9kLHsHnp7SnbIMBfLQl7CrX5KRod9z3/9NuazwVLTPU0xGwD3V9n3FrKRGQXcyJr
         KwZ6fSxGIllSI/RJH95KATQ3K941X16+6wS9gCL/jf+1qOUR/erEPBX22n9tz/uNoKbF
         j5RI7FQdGkIz32GsS3hgVqftOgaKf2qQMj4QKrFyP/kdnq8z5CtC4ZNiZ/gzcEAn8J15
         fwSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmyXbGi5JAf+2vLHhTN8F989VAfkCeK1L29Dxx9sfCTP0lsm0ZsWBzwzLeFZZpmlNRxFX2B/FrhribZ5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxhSTj+knfoW4d/jKHgvfQWDicD4QNnVuMgIWv0n97d/GmVn2Q
	xyH+/GcVPJmc32M2CjbxG90EU8ezJWgefq5+IFLtzxBzMoCY4UPndenvrh7sDPs4vnnrQRvNLBX
	IJMSFIIM9KIKJ86HVllWv8T2XMHHXHTY8kNYGnmTv0Q==
X-Gm-Gg: ASbGncscIZv4Phj2va7IKvoPlWvtfUQoI4hLJxO5PkUOeGVAiwroPb6YZY7s6kSMN00
	F3gc5QO4BREiLnzePSt9UwGbfjMV5qJbfEQ1DIYpy7LD7f9CIvhfUFhnfPxVd58rQUYDArCaSFy
	RuqeWFj4h186zpag51cD0rHw/jLuO77SLIIB5kLXN8OJJM33NmIDtILhCAupx36cmi6fsCWhppr
	Zj6XQs3d0jDBIC83dAqzC3QBemBF2yKxgee9s66gQbQOu2GSubcBrPv3zfWByWT6R4AbECqWll/
	6SKSLkyoB2vrjyfRPf9co5F1ojV0zg==
X-Google-Smtp-Source: AGHT+IHEQf853OX4AynR6BIRtmeSoyZHJJZatVIPpDXBqOH01xEff02e6PpXvVSz+YHlBVSJrxCQm20epV/nZ72RMYc=
X-Received: by 2002:a05:6402:26c2:b0:640:c640:98b9 with SMTP id
 4fb4d7f45d1cf-640c6409e87mr2036730a12.16.1762160664857; Mon, 03 Nov 2025
 01:04:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030-b4-follow-up-v2-1-19a23c83b837@os.amperecomputing.com>
In-Reply-To: <20251030-b4-follow-up-v2-1-19a23c83b837@os.amperecomputing.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 3 Nov 2025 10:04:12 +0100
X-Gm-Features: AWmQ_bkiIXcogtRYvKzgdB2mseLcCnz9yIAOZceydA5N6-9Deon6h4h_SUJKyqM
Message-ID: <CAKfTPtB25-M9sxm4vRQVaYvGkZjyoyZUh-NQ0+rZRuv3szSZ0A@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Prefer cache locality for EAS wakeup
To: shubhang@os.amperecomputing.com
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Shubhang Kaushik <sh@gentwo.org>, 
	Shijie Huang <Shijie.Huang@amperecomputing.com>, Frank Wang <zwang@amperecomputing.com>, 
	Christopher Lameter <cl@gentwo.org>, Adam Li <adam.li@amperecomputing.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Oct 2025 at 20:19, Shubhang Kaushik via B4 Relay
<devnull+shubhang.os.amperecomputing.com@kernel.org> wrote:
>
> From: Shubhang Kaushik <shubhang@os.amperecomputing.com>
>
> When Energy Aware Scheduling (EAS) is enabled, a task waking up on a
> sibling CPU might migrate away from its previous CPU even if that CPU
> is not overutilized. This sacrifices cache locality and introduces
> unnecessary migration overhead.
>
> This patch refines the wakeup heuristic in `select_idle_sibling()`. If
> EAS is active and the task's previous CPU (`prev`) is not overutilized,
> the scheduler will prioritize waking the task on `prev`, avoiding an
> unneeded migration and preserving cache-hotness.
>
> ---
> v2:
> - Addressed reviewer comments to handle this special condition
>   within the selection logic, prioritizing the
>   previous CPU if not overutilized for EAS.
> - Link to v1: https://lore.kernel.org/all/20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com/
>
> Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
> ---
>  kernel/sched/fair.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 25970dbbb27959bc130d288d5f80677f75f8db8b..ac94463627778f09522fb5420f67b903a694ad4d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7847,9 +7847,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>             asym_fits_cpu(task_util, util_min, util_max, target))
>                 return target;
>
> -       /*
> -        * If the previous CPU is cache affine and idle, don't be stupid:
> -        */
> +       /* Reschedule on an idle, cache-sharing sibling to preserve affinity: */
>         if (prev != target && cpus_share_cache(prev, target) &&
>             (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>             asym_fits_cpu(task_util, util_min, util_max, prev)) {
> @@ -7861,6 +7859,14 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>                 prev_aff = prev;
>         }
>
> +       /*
> +        * If the previous CPU is not overutilized, prefer it for cache locality.
> +        * This prevents migration away from a cache-hot CPU that can still
> +        * handle the task without causing an overload.
> +        */
> +       if (sched_energy_enabled() && !cpu_overutilized(prev))

From your previous answer on v1, I don't think that you use
heterogeneous system so eas will not be enabled in your case and even
when used find_energy_efficient_cpu() will be called before

select_idle_sibling looks for an idle cpu that shares the cache with
target, Isn't such migration inside the same LLC good in your case ?

Otherwise you might want to check in wake_affine() where we decide
between local cpu and previous cpu which one should be the target.
This can have an impact especially if there are not in the same LLC

> +               return prev;
> +
>         /*
>          * Allow a per-cpu kthread to stack with the wakee if the
>          * kworker thread and the tasks previous CPUs are the same.
>
> ---
> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
> change-id: 20251030-b4-follow-up-ff03b4533a2d
>
> Best regards,
> --
> Shubhang Kaushik <shubhang@os.amperecomputing.com>
>
>

