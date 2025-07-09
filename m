Return-Path: <linux-kernel+bounces-723313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8F3AFE5C0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3807A8A5E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E48E28C869;
	Wed,  9 Jul 2025 10:25:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6138C280330
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056715; cv=none; b=NoSWT2kJp1+XExcVOckeA7tBzwrHFvhqgvpnbMsQxago95LMsccl6Vr5vYIYMucK3ikvw4wf85WLXfiwMVCQzqYQLkbEcmsicPlYq0WEKm3myKcnrVGJlq8nfQP5bU3f/fLSN4hcfchu5f0E0j4yPkctPLP6rNL1dyAcB7DIZgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056715; c=relaxed/simple;
	bh=zR36+rbG75cJTNxJgZTENMx2+CpqVjIKBNNj2azZsUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TP+EWH4GNLKdaXjoFUsY7adu8dBmqYBkPmO4ifBIu+bAdAiMLH1ebILUVvl0XARQwhOeEfwTtzKfvqa4E9EpT2uDXYHYbPK/7lABt8TDdoyojARHOvVwIJr+R5wyKyNpKN9RbJ0nxRNxgY0Xk+k3i1lRS/zkXVNcn/4C92gKrCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C601153B;
	Wed,  9 Jul 2025 03:25:01 -0700 (PDT)
Received: from [10.1.29.30] (e127648.arm.com [10.1.29.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBD7F3F694;
	Wed,  9 Jul 2025 03:25:10 -0700 (PDT)
Message-ID: <d8a805d0-74ba-44dd-b5f7-8d2373c9538f@arm.com>
Date: Wed, 9 Jul 2025 11:25:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] sched/uclamp: Initialize uclamp_rq alongside rq setup
 in sched_init()
To: Zihuan Zhang <zhangzihuan@kylinos.cn>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, patrick.bellasi@arm.com,
 qyousef@layalina.io, xuewen.yan@unisoc.com
Cc: linux-kernel@vger.kernel.org
References: <20250627074535.14064-1-zhangzihuan@kylinos.cn>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250627074535.14064-1-zhangzihuan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 08:45, Zihuan Zhang wrote:
> uclamp_rq is currently initialized for all possible CPUs in a separate
> loop within init_uclamp(). This creates a dependency on the ordering of
> sched_init() and init_uclamp(), and duplicates the per-CPU iteration.
> 
> This patch simplifies the logic by moving uclamp_rq initialization into
> sched_init(), immediately after each cpu_rq is initialized. This ensures
> uclamprq setup is tightly coupled with rq setup and removes the need for
> a redundant loop.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  kernel/sched/core.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8988d38d46a3..a160ec8645b2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1998,7 +1998,7 @@ static void uclamp_post_fork(struct task_struct *p)
>  	uclamp_update_util_min_rt_default(p);
>  }
>  
> -static void __init init_uclamp_rq(struct rq *rq)
> +static void init_uclamp_rq(struct rq *rq)
>  {
>  	enum uclamp_id clamp_id;
>  	struct uclamp_rq *uc_rq = rq->uclamp;
> @@ -2016,10 +2016,6 @@ static void __init init_uclamp(void)
>  {
>  	struct uclamp_se uc_max = {};
>  	enum uclamp_id clamp_id;
> -	int cpu;
> -
> -	for_each_possible_cpu(cpu)
> -		init_uclamp_rq(cpu_rq(cpu));
>  
>  	for_each_clamp_id(clamp_id) {
>  		uclamp_se_set(&init_task.uclamp_req[clamp_id],
> @@ -2043,6 +2039,7 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
>  static inline void uclamp_fork(struct task_struct *p) { }
>  static inline void uclamp_post_fork(struct task_struct *p) { }
>  static inline void init_uclamp(void) { }
> +static inline void init_uclamp_rq(struct rq *rq) {}
>  #endif /* CONFIG_UCLAMP_TASK */
>  
>  bool sched_task_on_rq(struct task_struct *p)
> @@ -8586,6 +8583,7 @@ void __init sched_init(void)
>  		init_cfs_rq(&rq->cfs);
>  		init_rt_rq(&rq->rt);
>  		init_dl_rq(&rq->dl);
> +		init_uclamp_rq(rq);
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  		INIT_LIST_HEAD(&rq->leaf_cfs_rq_list);
>  		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;


I don't necessarily prefer one over the other, both look fine to me FWIW.

