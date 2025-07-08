Return-Path: <linux-kernel+bounces-721551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1CEAFCABA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB371AA648E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F6D21421A;
	Tue,  8 Jul 2025 12:45:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6312516A95B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978742; cv=none; b=R3tPcbgnrZAAK6aRIdWnf1YrakKY5BeMmgOFXkEokEpjK0+l/V7tdkEoK3ojti6DNRzYfvC91sO9M6HzpWvgeaXMj3eP/5eJn7VcvrDtDLgSa+ZM3EYgVhzhD1jFSZldcCbegCIFJpm5ac/yRF64EcjAvdvE2PRnfT0NtLR3zgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978742; c=relaxed/simple;
	bh=6Z7QluDO9s5nNYJ4KoY00YcWpvOHajXbZcJ4hdnKrz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YnAbbrBfiMk7TSCGSp86/i0GydQe8c7a5j4YBqgb1WoRns9PEf+EBonl+mWxg7W4vb6hMrTJEM7NGfyvojDcrtY7xNofECp/9+ukn9OmOncjh1GLMXsBtYTwz9KvSBE+4BRuQZw8XhMdzBSDmTDELW5TgXqyht7XU/wmb9pZfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62D2F153B;
	Tue,  8 Jul 2025 05:45:26 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD7D33F694;
	Tue,  8 Jul 2025 05:45:36 -0700 (PDT)
Message-ID: <ae9f49dc-b300-4827-9cb6-be40354f5d57@arm.com>
Date: Tue, 8 Jul 2025 14:44:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] sched: Add ttwu_queue support for delayed tasks
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, clm@meta.com
Cc: linux-kernel@vger.kernel.org
References: <20250702114924.091581796@infradead.org>
 <20250702121159.652969404@infradead.org>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20250702121159.652969404@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/07/2025 13:49, Peter Zijlstra wrote:

[...]

> @@ -3801,6 +3839,52 @@ static inline bool ttwu_do_migrate(struc
>  	return true;
>  }
>  
> +static int ttwu_delayed(struct rq *rq, struct task_struct *p, int wake_flags,
> +			struct rq_flags *rf)
> +{
> +	struct rq *p_rq = task_rq(p);
> +	int cpu;
> +
> +	/*
> +	 * Notably it is possible for on-rq entities to get migrated -- even
> +	 * sched_delayed ones. This should be rare though, so flip the locks
> +	 * rather than IPI chase after it.
> +	 */
> +	if (unlikely(rq != p_rq)) {
> +		rq_unlock(rq, rf);
> +		p_rq = __task_rq_lock(p, rf);
> +		update_rq_clock(p_rq);
> +	}
> +
> +	if (task_on_rq_queued(p))
> +		dequeue_task(p_rq, p, DEQUEUE_NOCLOCK | DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> +
> +	/*
> +	 * NOTE: unlike the regular try_to_wake_up() path, this runs both
> +	 * select_task_rq() and ttwu_do_migrate() while holding rq->lock
> +	 * rather than p->pi_lock.
> +	 */
> +	cpu = select_task_rq(p, p->wake_cpu, &wake_flags);

There are 'lockdep_assert_held(&p->pi_lock)'s in select_task_rq() and
select_task_rq_fair() which should trigger IMHO? Can they be changed the
same way like  __task_rq_lock()?

> +	if (ttwu_do_migrate(rq, p, cpu))
> +		wake_flags |= WF_MIGRATED;

[...]

>  /*
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2280,6 +2280,7 @@ static inline int task_on_rq_migrating(s
>  #define WF_RQ_SELECTED		0x80 /* ->select_task_rq() was called */
>  
>  #define WF_ON_CPU		0x0100

Looks like this is still not used. Not sure whether it can be removed or
you wanted to add a condition for this as well?

