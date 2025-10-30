Return-Path: <linux-kernel+bounces-877634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2245CC1EA18
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9D084E301C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09A22FABEE;
	Thu, 30 Oct 2025 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzneZ6SW"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A565A2F8BD9
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807082; cv=none; b=r5mQ2iRrvJ2y1OlB57yYHPDH7yjTEeMu+7yAVe5dwT57KIR3XwPMXkjhXYCc4Wml8C9na98337udS7Sr6lH9j4F4pcuu+60rW6+/AarMEjhIhd0qe37TPRSWhIni4xONGEdWERCdVXHjYbbcOrULmFZy7KWX+/RntKpvYcu0Bio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807082; c=relaxed/simple;
	bh=bcL2dth29HYQzmscdxxlij5j1nYMii+Jtot3hqRxds8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hR4zJkMnj8ncH09a39e1w5s3P0UR3gggGxzlKYXGkLSqfmmSWkWTxsxGT/sV6VT2PQCGncgseYz5bssnszWVN4nC9MJMBBm5YhJTYMKZBa9PHzcSqHYsPgl9s8+NVqrAssSRzMc2+bKQJco5R3OJ+8uQlKYqoi/Rpz2jnlz7m4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzneZ6SW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-269af38418aso8784275ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 23:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761807080; x=1762411880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZToePNHFLxmKzEbf/oZ2g0E7DskOjO73ks8X4+yw26w=;
        b=GzneZ6SWECaU3NmUO9prBhppdOSQT7DMu+7B6zwhYNI2HNpPAT1KqMtqRuR5uEPb/M
         gLV3IiM0qvIG8uZDYFEKsmdixiyvMHLdaG5Kb48STdtNd9cXg5LYryj3q5kT/CNC2acl
         oMTbUWJAAjpl8KLQeDP1g5LtqB2bYSAJrrRobt8lp/idPQS6IgL9Tv3aajlvC7ma45xW
         OJ/nqHrG//mRGC+DE0uLxFwBu5Ytn+PIhgbA1MLmE3BBpJ50znps/3v45RPR4TqjywMS
         HTMNwe1aI2YIEc5/QbO8X/egfwVPwGLJkkPbg/89yns6X65Gt58qQDM5X34DZUjVDM+o
         rgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761807080; x=1762411880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZToePNHFLxmKzEbf/oZ2g0E7DskOjO73ks8X4+yw26w=;
        b=PBKJ8sevGtpVkA6IR5W271f5nJd6XVvA7VA0dW7eMRHZdcQEpUEKmw6q/wrd+eXI4/
         Z1L911MlV8OKXpingzPR24NPPUNR6D7+qQzYhU4pnjqlivbxouuIfZIEjoBTVX7I3tp9
         0k+PbSFpEv1M8Vewz7NG48Y6pmL3rurmInJQa32izGY+hqidfxTRQ4Db/FQ/4aeihIve
         UGDNNoJswpxEN84C80fq1E8o/cZE+oozNKCiGyYZ3MWmDSVPYwBoh8HoYqaYLAnmp7ng
         fBlOmi0FBNa5KZevLAcUjCgn7neDWUhAvdVxrOBOceaBx2bmfogHNQQJqn54/FmTteVK
         ORDw==
X-Gm-Message-State: AOJu0Ywh5G3hm2vi9u/ZQz7MtIlX6B8PnSBNqY0GUQ2Foo1s94xUotEz
	DnSh4sWPLWp44GMcpO+urRAbmF9G0teCKnkM/RKhCo0NH1hf5bY5Eo+r
X-Gm-Gg: ASbGncsPbFprRLGkhvDyirqwU71Pc+elXHtcrQlepQtbIeyVIgIu0jniaxTsaqsPp0P
	v5WV9K2JOzLwKEwhXx85Fad6Vq0fnaIpVZxkHF9XNWihXMexyDMA7P+TH1TEGd2lNXVza3aQvdP
	+tNCL+GQb/3fZkLUmYeSeHR14sKa/2dwyA6XH5C8p4pk0SRnsep1dpUyyFyx8dckdB64e4oLdmg
	OZS9bTIwEnE87X3AKv2n0RJdoN/eBFcRWhPBeitYwoSOotkyiYK2RhYM2n+8Qc4uYryQvUAOkOr
	b93beCXyf2Vl3rcYGhYnRHlp7PLsPMFdEzjhhJJM9xCChUmohvbMuo01rdSF6b49706MtaENHSs
	qkZaIXgQTWLKVu+LEUprwnIcZmx18skhuNnlgw4CjQBuZ+fC9+hMXzisw2+jqbyr9a95bROdOu7
	NABb3qYSRiDfhTtWhmS4LE
X-Google-Smtp-Source: AGHT+IGQsM1iOYiKbBw2XcqUPFg8VFzxJi6w78gMdaDNAlcHF8f6L73Lz+WyHXIe5pNU7k8w5LnAnQ==
X-Received: by 2002:a17:903:2301:b0:272:a900:c42b with SMTP id d9443c01a7336-294dee996f7mr70503315ad.31.1761807079789;
        Wed, 29 Oct 2025 23:51:19 -0700 (PDT)
Received: from [10.125.192.70] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340509a3001sm1342828a91.10.2025.10.29.23.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 23:51:19 -0700 (PDT)
Message-ID: <be55df62-83ac-0605-48e9-7346fb4cb113@gmail.com>
Date: Thu, 30 Oct 2025 14:51:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
To: Aaron Lu <ziqianlu@bytedance.com>, Ben Segall <bsegall@google.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Chengming Zhou <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
 Chuyi Zhou <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Songtang Liu <liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>,
 Matteo Martelli <matteo.martelli@codethink.co.uk>,
 =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20251030032755.560-1-ziqianlu@bytedance.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <20251030032755.560-1-ziqianlu@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/30 11:27, Aaron Lu wrote:
> When a cfs_rq is to be throttled, its limbo list should be empty and
> that's why there is a warn in tg_throttle_down() for non empty
> cfs_rq->throttled_limbo_list.
> 
> When running a test with the following hierarchy:
> 
>            root
>          /      \
>          A*     ...
>       /  |  \   ...
>          B
>         /  \
>        C*
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


It worked well in my test cases, and the non-empty throttled_limbo_list 
warning no longer appeared.

Tested-by: Hao Jia <jiahao1@lixiang.com>


> ---
> v3: grant cfs_rq 1ns runtime on quota set as suggested by Ben, thanks!
> 
>   kernel/sched/core.c |  2 +-
>   kernel/sched/fair.c | 15 ++++++---------
>   2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f1ebf67b48e21..f754a60de8484 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9606,7 +9606,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
>   
>   		guard(rq_lock_irq)(rq);
>   		cfs_rq->runtime_enabled = runtime_enabled;
> -		cfs_rq->runtime_remaining = 0;
> +		cfs_rq->runtime_remaining = 1;
>   
>   		if (cfs_rq->throttled)
>   			unthrottle_cfs_rq(cfs_rq);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 25970dbbb2795..5b752324270b0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6024,20 +6024,17 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>   	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
>   
>   	/*
> -	 * It's possible we are called with !runtime_remaining due to things
> -	 * like user changed quota setting(see tg_set_cfs_bandwidth()) or async
> -	 * unthrottled us with a positive runtime_remaining but other still
> -	 * running entities consumed those runtime before we reached here.
> +	 * It's possible we are called with runtime_remaining < 0 due to things
> +	 * like async unthrottled us with a positive runtime_remaining but other
> +	 * still running entities consumed those runtime before we reached here.
>   	 *
> -	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
> -	 * because any enqueue in tg_unthrottle_up() will immediately trigger a
> -	 * throttle, which is not supposed to happen on unthrottle path.
> +	 * We can't unthrottle this cfs_rq without any runtime remaining because
> +	 * any enqueue in tg_unthrottle_up() will immediately trigger a throttle,
> +	 * which is not supposed to happen on unthrottle path.
>   	 */
>   	if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0)
>   		return;
>   
> -	se = cfs_rq->tg->se[cpu_of(rq)];
> -
>   	cfs_rq->throttled = 0;
>   
>   	update_rq_clock(rq);

