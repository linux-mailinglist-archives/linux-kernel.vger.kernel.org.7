Return-Path: <linux-kernel+bounces-887379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2363C380E9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D77189C68B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97B92DF146;
	Wed,  5 Nov 2025 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xX+YSX82"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078802D0C89
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378655; cv=none; b=oMXDf3xlpSvbhu3xTEX5s6yVfO8iiCAWMumbT8chlKoLsMdUN+WxBAfhf3VqEL0XZWZoqcZdwBYMrqVUHON+55pN7g8p/QfTkWJ6TSwiC+5sUrkHjiYlRTghpcPwg0pANxm1akdAHBQLsMkOgxDtWv2Ari2Qm6NunvATyZdLb7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378655; c=relaxed/simple;
	bh=NuUA2px/wbeP6So5PQ23B7NoicGzD/i3r59syB+kGrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k6QPaM5omHA4c5F1T2kWVJRMVSyjkPgNNlPcFfbV7fCXnZvuEcDR/v76KzgIrUX97Ha27LI8P6KgIYNvoKKJ1YrLsnCFuywel7g9NYm/X3ve1CETnl5Uoen/vaBWl4pnRG259tgiAtRMhSguNG06R4RJxeDJg/I6XsSBDZVIXWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xX+YSX82; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a9e8a15502so361366b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 13:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762378652; x=1762983452; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vTBriQnjwevYGZCnFJ2UtmHQKrs50ix2n217XhNSCMQ=;
        b=xX+YSX82cRPG0mXvmZqsNuep/8YErSLjX7IL/JltgRE2EGN0+FN8hdTHEBmHcpZwlA
         FhkiX5jotLCXgH8QZZiB3jz2MW1arOJht1vgpEpHCk5lAypbeCSNYkeSmtBL7PptKtw+
         2L12366AghlHlwOxsT3d5Q70/SyiisGyFXseQ7Eh+B3ZU4D+UL6eQ03zq0C0LL9YgZl4
         F1aIGg2n+8C4vvPED43Zdof891oKIA2N49qGXAfYAjYhxJzbUBTs5X5wbK5M1Y6qeeUb
         1DxIVUYhlLWeCzzOh8Ij1qdv1rAu0FaoyAqlzSid4EWePEZ8QHo36nn7CyY7ZUggYtfm
         JT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762378652; x=1762983452;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTBriQnjwevYGZCnFJ2UtmHQKrs50ix2n217XhNSCMQ=;
        b=nNSyYzhTKsVKiMFMCvdTkr8JouLHpClDyJcKsPtMap0GQevmxPWt5lbyJn/KERvuha
         0wo4ppnR2Mbk3fHbBY8dfv+xJSfBOp36Z8rxUQRd6R/TKkZQzcOn1EHtP+n0yGFvKXj2
         /yF3YEGOpP81/keTb70o5/ga2LCkraoDh6vqexPtmWY4sdpvvHTORarrbxCerKwdoSFK
         Beh/oI8pQWxrAzy0o/1vCds0gjLw4t/7+tTB05BmECm9x8CsNB0jsHf1uXsc/FCX32fd
         wfvTHUvYttsiHIDq3BWCEpHnyLc5u5aeEuaz7YptFClL9LhhwVNDtySh0rAI+ubabNHL
         ez+g==
X-Forwarded-Encrypted: i=1; AJvYcCXYtr2DPhslTxnafwwzTt8b+iwTImYWn8MEf55WcgGUGuJp8/AubnvGQF0JYAAeAUMKsIAo1iw8LQ8sBHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDtjMOHGaEWzCwyvv5DlpiAqBPYuMfx9B8FZEKN9kXIPSBom94
	RtuIsWjfhcoaVuirxOaxz95Hw6mxN1vVW6t+fQLa+iPkKaLPOZDwql2hKYZuOtzwmg==
X-Gm-Gg: ASbGnctP47ExHhaEZ7nxIlMSlCqiBW7Y6xO7nowcx+DFR0IuQdezuRKAmtz3HBdaeUt
	1oDDMY7bjfYZZbu4faGfcCk3zeJ9FZsDV4ouW/a41Jz630cko4tgBK4tSSSkxrviYRj34AtXOn4
	FNmZyJiF7mZSgygWmzJ8PC774S/xTyl+Ck1VQC8svHOBYUOfyTZtk2rXE2WkRayGXRk44uuBRGx
	Axd7aWMDF2dT9Tppfw+Xl2OmtDyp87bO6TKQazVvk++X6p+LrtFphoa2wYklXCqjylmU5N7Cc7X
	/81Mq0ueg/6f3Bkj5N2FH8DgJGFhZ3oTMxIeBURg7xSmPvPNcS1h+AcMLJ1TJk+0xp7zQJoUkWO
	O8SPLr4iry7RbcwWSYkatVUq8kF5jdfbfmu0zA/VDMK30FnqZ0ePGR6wty2eaMKbklJyu3z2K99
	y/QwXZdv9ClkTWGjYMVCwCSxeUVee/m/J83sSJRf0Tomdcu0+OCYLALZ5ghg==
X-Google-Smtp-Source: AGHT+IFbyaZT8P3RxgRle3I+CZdtyqL5gYuiG3jcmVTs5TLc3E68of6agWIvG/K59aPFoYtQxsieWg==
X-Received: by 2002:a05:6a00:1411:b0:781:157b:3d2e with SMTP id d2e1a72fcca58-7ae1ee9a48cmr5143911b3a.21.1762378651930;
        Wed, 05 Nov 2025 13:37:31 -0800 (PST)
Received: from bsegall-glaptop.localhost ([2a00:79e0:2efc:9:ae9a:3bcb:975c:9b90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7fd52afesm403687b3a.18.2025.11.05.13.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:37:31 -0800 (PST)
From: Benjamin Segall <bsegall@google.com>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,  Peter Zijlstra
 <peterz@infradead.org>,  Hao Jia <jiahao.kernel@gmail.com>,  Valentin
 Schneider <vschneid@redhat.com>,  Chengming Zhou
 <chengming.zhou@linux.dev>,  Josh Don <joshdon@google.com>,  Ingo Molnar
 <mingo@redhat.com>,  Vincent Guittot <vincent.guittot@linaro.org>,  Xi
 Wang <xii@google.com>,  linux-kernel@vger.kernel.org,  Juri Lelli
 <juri.lelli@redhat.com>,  Dietmar Eggemann <dietmar.eggemann@arm.com>,
  Steven Rostedt <rostedt@goodmis.org>,  Mel Gorman <mgorman@suse.de>,
  Chuyi Zhou <zhouchuyi@bytedance.com>,  Jan Kiszka
 <jan.kiszka@siemens.com>,  Florian Bezdeka <florian.bezdeka@siemens.com>,
  Songtang Liu <liusongtang@bytedance.com>,  Chen Yu <yu.c.chen@intel.com>,
  Matteo Martelli <matteo.martelli@codethink.co.uk>,  Michal =?utf-8?Q?Kou?=
 =?utf-8?Q?tn=C3=BD?=
 <mkoutny@suse.com>,  Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3] sched/fair: Prevent cfs_rq from being unthrottled
 with zero runtime_remaining
In-Reply-To: <20251030032755.560-1-ziqianlu@bytedance.com> (Aaron Lu's message
	of "Thu, 30 Oct 2025 11:27:55 +0800")
References: <20251030032755.560-1-ziqianlu@bytedance.com>
Date: Wed, 05 Nov 2025 13:37:28 -0800
Message-ID: <xm26346sjh47.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Lu <ziqianlu@bytedance.com> writes:

> When a cfs_rq is to be throttled, its limbo list should be empty and
> that's why there is a warn in tg_throttle_down() for non empty
> cfs_rq->throttled_limbo_list.
>
> When running a test with the following hierarchy:
>
>           root
>         /      \
>         A*     ...
>      /  |  \   ...
>         B
>        /  \
>       C*
>
> where both A and C have quota settings, that warn on non empty limbo list
> is triggered for a cfs_rq of C, let's call it cfs_rq_c(and ignore the cpu
> part of the cfs_rq for the sake of simpler representation).
>
> Debug showed it happened like this:
> Task group C is created and quota is set, so in tg_set_cfs_bandwidth(),
> cfs_rq_c is initialized with runtime_enabled set, runtime_remaining
> equals to 0 and *unthrottled*. Before any tasks are enqueued to cfs_rq_c,
> *multiple* throttled tasks can migrate to cfs_rq_c (e.g., due to task
> group changes). When enqueue_task_fair(cfs_rq_c, throttled_task) is
> called and cfs_rq_c is in a throttled hierarchy (e.g., A is throttled),
> these throttled tasks are directly placed into cfs_rq_c's limbo list by
> enqueue_throttled_task().
>
> Later, when A is unthrottled, tg_unthrottle_up(cfs_rq_c) enqueues these
> tasks. The first enqueue triggers check_enqueue_throttle(), and with zero
> runtime_remaining, cfs_rq_c can be throttled in throttle_cfs_rq() if it
> can't get more runtime and enters tg_throttle_down(), where the warning
> is hit due to remaining tasks in the limbo list.
>
> I think it's a chaos to trigger throttle on unthrottle path, the status
> of a being unthrottled cfs_rq can be in a mixed state in the end, so fix
> this by granting 1ns to cfs_rq in tg_set_cfs_bandwidth(). This ensures
> cfs_rq_c has a positive runtime_remaining when initialized as unthrottled
> and cannot enter tg_unthrottle_up() with zero runtime_remaining.
>
> Also, update outdated comments in tg_throttle_down() since
> unthrottle_cfs_rq() is no longer called with zero runtime_remaining.
> While at it, remove a redundant assignment to se in tg_throttle_down().
>
> Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
> Suggested-by: Benjamin Segall <bsegall@google.com>
> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> ---
> v3: grant cfs_rq 1ns runtime on quota set as suggested by Ben, thanks!
>
>  kernel/sched/core.c |  2 +-
>  kernel/sched/fair.c | 15 ++++++---------
>  2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f1ebf67b48e21..f754a60de8484 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9606,7 +9606,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
>  
>  		guard(rq_lock_irq)(rq);
>  		cfs_rq->runtime_enabled = runtime_enabled;
> -		cfs_rq->runtime_remaining = 0;
> +		cfs_rq->runtime_remaining = 1;
>  
>  		if (cfs_rq->throttled)
>  			unthrottle_cfs_rq(cfs_rq);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 25970dbbb2795..5b752324270b0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6024,20 +6024,17 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
>  
>  	/*
> -	 * It's possible we are called with !runtime_remaining due to things
> -	 * like user changed quota setting(see tg_set_cfs_bandwidth()) or async
> -	 * unthrottled us with a positive runtime_remaining but other still
> -	 * running entities consumed those runtime before we reached here.
> +	 * It's possible we are called with runtime_remaining < 0 due to things
> +	 * like async unthrottled us with a positive runtime_remaining but other
> +	 * still running entities consumed those runtime before we reached here.
>  	 *
> -	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
> -	 * because any enqueue in tg_unthrottle_up() will immediately trigger a
> -	 * throttle, which is not supposed to happen on unthrottle path.
> +	 * We can't unthrottle this cfs_rq without any runtime remaining because
> +	 * any enqueue in tg_unthrottle_up() will immediately trigger a throttle,
> +	 * which is not supposed to happen on unthrottle path.
>  	 */
>  	if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0)
>  		return;
>  
> -	se = cfs_rq->tg->se[cpu_of(rq)];
> -
>  	cfs_rq->throttled = 0;
>  
>  	update_rq_clock(rq);

Reviewed-By: Benjamin Segall <bsegall@google.com>

