Return-Path: <linux-kernel+bounces-810192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1CCB51717
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C139D1C8248F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306FE31CA58;
	Wed, 10 Sep 2025 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pKGyG2Ug"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5A31A55A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507786; cv=none; b=GIYZhJiqyNRTWp3xyS20o8Ed7soOVFl1XwC/sw1tMnjZh+Y3zlzMSN6uRckxnulCrxE7uYExSAhIXngJ+WEW9wNgXl8QmWBHUQ8t+37PMHGCb1PXHCjP60TlgROMZzFXw4SuYQ7QlqFVdQSa/20nrqwh+n4Ws9KF5GJnslJoZcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507786; c=relaxed/simple;
	bh=NoLJl6scBRVZRqT+wkrDL4OnVlDy7ZVPjr3jqhZ0scU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tk/+622t7FbLR+k6o9XIeKNunagl8Ck22X27beesPqENvM/bcvMnVV1x8StYx0dx0EL9HhiVGwjBpMxKd8EEfYZ5kq0Gus8QcCGMmxE/Gr7i1lwrNY51qGJBGfPAhaG0K6pxWn0EJo5lMO9dfqRzYI5KtVMJMPwPZhTnGKeayb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pKGyG2Ug; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f13922e4-07f8-4720-bc62-c309efc48967@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757507782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMbn74c4BsmSunzhyeWTqZeRg+QZ0xdrTfapzSQZIdc=;
	b=pKGyG2UgJGq6vlE51DaUbmgoLHh1ll/nGTbJA1qgCW4qQan/OtSU6roMde+nS8Jc377reK
	1BxJ5mDsM+7OpOkfg4SSXUbpumBRc4ouR7XQksXkVzF7MuPDHvR56je7pqgRk+Vyajyt7L
	ZWlGKqAdrHNpRSDjjAJTzIoHS5H2eDM=
Date: Wed, 10 Sep 2025 20:36:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] sched/fair: Propagate load for throttled cfs_rq
To: Aaron Lu <ziqianlu@bytedance.com>,
 Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Don <joshdon@google.com>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
 Chuyi Zhou <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Songtang Liu <liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>,
 Matteo Martelli <matteo.martelli@codethink.co.uk>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
 <20250910095044.278-2-ziqianlu@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20250910095044.278-2-ziqianlu@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/9/10 17:50, Aaron Lu wrote:
> Before task based throttle model, propagating load will stop at a
> throttled cfs_rq and that propagate will happen on unthrottle time by
> update_load_avg().
> 
> Now that there is no update_load_avg() on unthrottle for throttled
> cfs_rq and all load tracking is done by task related operations, let the
> propagate happen immediately.
> 
> While at it, add a comment to explain why cfs_rqs that are not affected
> by throttle have to be added to leaf cfs_rq list in
> propagate_entity_cfs_rq() per my understanding of commit 0258bdfaff5b
> ("sched/fair: Fix unfairness caused by missing load decay").
> 
> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>

LGTM!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>   kernel/sched/fair.c | 26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index df8dc389af8e1..f993de30e1466 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5729,6 +5729,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
>   	return cfs_bandwidth_used() && cfs_rq->throttled;
>   }
>   
> +static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
> +{
> +	return cfs_bandwidth_used() && cfs_rq->pelt_clock_throttled;
> +}
> +
>   /* check whether cfs_rq, or any parent, is throttled */
>   static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
>   {
> @@ -6721,6 +6726,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
>   	return 0;
>   }
>   
> +static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
> +{
> +	return false;
> +}
> +
>   static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
>   {
>   	return 0;
> @@ -13151,10 +13161,13 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>   {
>   	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>   
> -	if (cfs_rq_throttled(cfs_rq))
> -		return;
> -
> -	if (!throttled_hierarchy(cfs_rq))
> +	/*
> +	 * If a task gets attached to this cfs_rq and before being queued,
> +	 * it gets migrated to another CPU due to reasons like affinity
> +	 * change, make sure this cfs_rq stays on leaf cfs_rq list to have
> +	 * that removed load decayed or it can cause faireness problem.
> +	 */
> +	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
>   		list_add_leaf_cfs_rq(cfs_rq);
>   
>   	/* Start to propagate at parent */
> @@ -13165,10 +13178,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>   
>   		update_load_avg(cfs_rq, se, UPDATE_TG);
>   
> -		if (cfs_rq_throttled(cfs_rq))
> -			break;
> -
> -		if (!throttled_hierarchy(cfs_rq))
> +		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
>   			list_add_leaf_cfs_rq(cfs_rq);
>   	}
>   }

