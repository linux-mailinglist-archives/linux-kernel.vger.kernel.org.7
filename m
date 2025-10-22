Return-Path: <linux-kernel+bounces-865570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29C3BFD855
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544093B6AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8060D35B13D;
	Wed, 22 Oct 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uq1OVB0N"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C335B123
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152076; cv=none; b=ru3UDrxAus9Zl2m20X0Qxh5QhR8Or3JU9YKWAfvwq/vdcmWII36UCXnybS4/p4wCbIeeaShYxh1stNWNH0Z9nDr0Jcov9N7FSuUFpKDT0ClsdmCZyTSGsg3wmy9VUluUphIhjb0M9BGsMHg4mPIuFX7MgPy6WZxrVEBghX350kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152076; c=relaxed/simple;
	bh=AUYzAbLdyJHeYVfJdOZybgTvaRtFfMWE4gViY0FngSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqQ2uqE4oJtyy7YWiUZ1dehwjB6LBjw8/cWV0yYBsi7ek3uRdKdb3Y/VkiC8rCJgVxZah4OtqEPu4wTWnDQ9LYUoPUJrn4E1ncwkmDZGT2PWSQavQNhoU4rpU2UJfpEJePXcoCL9dMnKAs4JokPT8GqoKd76W9Kf0wZ00VOhQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uq1OVB0N; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso12713770a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761152073; x=1761756873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wf3QlU/cjxjriFxv9DrIX/nceHDFzc/cOYnNx1kv6p0=;
        b=Uq1OVB0NOwABoiG8MMcnhKpD0yBgpRrwgg0b+uuhj5i7kjFO3zCkR5DE4ef/fLEZuE
         bYIM/lfNDZ9xKXC8EfQB0bIALaSvqRCKL+Gd/Qn06+eBiSAz632W+HyMoQ0GIfRxdBo7
         8FlEP9PPpZAwncrp/dG1fHu40NeDGBFvunilhPMiFVQ3CJgCaJD1ZS2uuD3GW3J6jcf7
         0DYxHD84o3qD1Jg5WeY2Mls53o87aeriJ+TGhZdQ3OrV39D5/2fvcd+I06aoKMVgytGL
         n2B4d4l6gre/kG1+eBIhSAUNbZMCG2L8L3UHeTxbmGtXDZls6SaRTqoeM4YeokPlaKFM
         8cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761152073; x=1761756873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wf3QlU/cjxjriFxv9DrIX/nceHDFzc/cOYnNx1kv6p0=;
        b=cAbOIorff/744oE5Fn+n3YjIizx2i3vjTPglW4/G5pFs0E/P7rhOp7n/uFwjqvwKg5
         IuO12J7hNONhB9+56AkckGvRqMbulc96zPUwl82vsiLQADO36xflKGUZC12bnDSj+m2E
         Kj7ZqriLgQi46G65nuKqJMzSdmb2MkaUIB9X/3uEZuf3muuZQtWEVFpX2N0cCanCPjpX
         y+CbWVJaNArpSjIaon/bTZpPl3Ck43/VVDUAsc73eTFQKkUiNG7FI9T75LYVrnB0U5+w
         7ajEBQ2tEI4hFe4lSdPb7fdid0xT1JjQGNnqOYevZ+2uCDajnBFJrt2Bj3miX4Y42yG1
         bQsw==
X-Forwarded-Encrypted: i=1; AJvYcCVa0A+YOiju0kFq4TSXK68jvbxGZbgiFDptKKWnEyljhc0lxdqAnCiKzAeWuV8LsPNsor8FOTbOvbEA8Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyezx+XS87q0bhGaku9/vjSKGEkSyX3133Mai0q066VljDUHFVd
	tSruPxXYdVED5GTVcFQtZfdHrZao9qYMGYwWwnPt0/1cMr7sEff5nlV4s6PFlY+WP0X1l4yP3WW
	9AfT8dwxTMP+IV1+TKtX8JJOMjmgWo/OgUiQi75Udxw==
X-Gm-Gg: ASbGncsa/YB3mPaky4SHbB7+MqgatSloH4kx7s8dGi41iAlAdp/MqjlBo3Dzj41gYTa
	jqVwF2yDHYLG0o/JI7PLV5Ge3ZpHg2EeirRFjG+okC3D8okuFwpirixQEPnZ6FbDDHXRWyb7Iw0
	VSoTOvSCNlZMJ9oDyqW0TfF3N3DsnoVwoH/dxqfWTHRf3aps8HsXV7S/kaBR6yPj5apHtCPmPt4
	sOxs3bH6+2NdaOLPXoDp2s3I2Tu/7bnh7Hlri/JxPxgimkvSk3yE8OWm3u7PzCb4eFze25noPTi
	Qqp5Umdn3scCcQsSCf705Bwt
X-Google-Smtp-Source: AGHT+IFHXMjRw6e+gK077Fhej9HymCtjhFeg5jz/6fU7N7fVbBLjFtgHT6WMsOZ49fusMvzUX8EIvlVu5hyjkDRv1GI=
X-Received: by 2002:a05:6402:2788:b0:639:dbe7:37b4 with SMTP id
 4fb4d7f45d1cf-63c1f64ebf5mr20151170a12.1.1761152073053; Wed, 22 Oct 2025
 09:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com>
In-Reply-To: <20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 22 Oct 2025 18:54:21 +0200
X-Gm-Features: AS18NWCOyFUr-MMbOscjzvpVHi-z5Un2iJrFW2AJ72SLAjJFH4yGe8bhEL8PllQ
Message-ID: <CAKfTPtAVzgq5HxVc6q9VnD8i9wFtAWH0tnLHD81TBAudj2yFmA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup
To: shubhang@os.amperecomputing.com
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Shubhang Kaushik <sh@gentwo.org>, 
	Shijie Huang <Shijie.Huang@amperecomputing.com>, Frank Wang <zwang@amperecomputing.com>, 
	Christopher Lameter <cl@gentwo.org>, Adam Li <adam.li@amperecomputing.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 Oct 2025 at 01:01, Shubhang Kaushik via B4 Relay
<devnull+shubhang.os.amperecomputing.com@kernel.org> wrote:
>
> From: Shubhang Kaushik <shubhang@os.amperecomputing.com>
>
> Modify the wakeup path in `select_task_rq_fair()` to prioritize cache
> locality for waking tasks. The previous fast path always attempted to
> find an idle sibling, even if the task's prev CPU was not truly busy.
>
> The original problem was that under some circumstances, this could lead
> to unnecessary task migrations away from a cache-hot core, even when
> the task's prev CPU was a suitable candidate. The scheduler's internal
> mechanism `cpu_overutilized()` provide an evaluation of CPU load.
>
> To address this, the wakeup heuristic is updated to check the status of
> the task's `prev_cpu` first:
> - If the `prev_cpu` is  not overutilized (as determined by
>   `cpu_overutilized()`, via PELT), the task is woken up on
>   its previous CPU. This leverages cache locality and avoids
>   a potentially unnecessary migration.
> - If the `prev_cpu` is considered busy or overutilized, the scheduler
>   falls back to the existing behavior of searching for an idle sibling.
>
> Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
> ---
> This patch optimizes the scheduler's wakeup path to prioritize cache
> locality by keeping a task on its previous CPU if it is not overutilized,
> falling back to a sibling search only when necessary.
> ---
>  kernel/sched/fair.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bc0b7ce8a65d6bbe616953f530f7a02bb619537c..bb0d28d7d9872642cb5a4076caeb3ac9d8fe7bcd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8618,7 +8618,16 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>                 new_cpu = sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
>         } else if (wake_flags & WF_TTWU) { /* XXX always ? */
>                 /* Fast path */
> -               new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> +
> +               /*
> +                * Avoid wakeup on an overutilized CPU.
> +                * If the previous CPU is not overloaded, retain the same for cache locality.
> +                * Otherwise, search for an idle sibling.
> +                */
> +               if (!cpu_overutilized(prev_cpu))

cpu_overutilized() returns false if (!sched_energy_enabled())

so  new_cpu is always prev_cpu for non EAS aware system which is
probably not what you want

> +                       new_cpu = prev_cpu;
> +               else
> +                       new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
>         }
>         rcu_read_unlock();
>
>
> ---
> base-commit: 9b332cece987ee1790b2ed4c989e28162fa47860
> change-id: 20251017-b4-sched-cfs-refactor-propagate-2c4a820998a4
>
> Best regards,
> --
> Shubhang Kaushik <shubhang@os.amperecomputing.com>
>
>

