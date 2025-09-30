Return-Path: <linux-kernel+bounces-837327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F4EBAC09D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715C017ACF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCBA2F39D6;
	Tue, 30 Sep 2025 08:27:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3748C2EC0A5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220827; cv=none; b=IsA9rsfs8zp+pXZcHu4TJY32zZ1sJpk2cGqKy2bmGgfHOsQTylPwQNSVg0pX/wtaEgzzxUh/0hzXJ5Q6bl+u4w0dezzFtDsLaCrQuvHsCNrW8hIAoM0yJcSc4P2mOB+SOGSBvU2Jc3r/Z+yBOuXpWJhCe/X9aWJS+8NTxjjhSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220827; c=relaxed/simple;
	bh=RkeHON5M+TQW4Bl1A0yGPY3mlWSErKUw5XXt9TQ/PDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHeFRyIS/riPPvt7CMsk/DiefdaeZrZDUJvNJr9MG53agZrpz/0p9jg0LqOBwWVdM2uhrYcOFmc64njMyST4q3UcMdWl/DzAjrpLFfVFLdOdBs92l6GJdfDlW/+KdJ/DXA/TUJz9ZxGQXOgW/NCfCzvMhlqA6MjztMyBMfFvLD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 383971424;
	Tue, 30 Sep 2025 01:26:56 -0700 (PDT)
Received: from [10.57.34.73] (unknown [10.57.34.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF5F43F66E;
	Tue, 30 Sep 2025 01:27:01 -0700 (PDT)
Message-ID: <ff4099fa-a6e4-4478-af81-a4c1baaf483b@arm.com>
Date: Tue, 30 Sep 2025 09:26:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched: Fix some spelling mistakes in the scheduler
 module
To: Jianyun Gao <jianyungao89@gmail.com>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20250929061213.1659258-1-jianyungao89@gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250929061213.1659258-1-jianyungao89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/25 07:12, Jianyun Gao wrote:
> From: "jianyun.gao" <jianyungao89@gmail.com>
> 
> The following are some spelling mistakes existing in the scheduler
> module. Just fix it!
> 
>   slection -> selection
>   achitectures -> architectures
>   excempt -> except
>   incorectly -> incorrectly
>   litle -> little
>   faireness -> fairness
>   condtion -> condition
> 
> Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
> ---
> V2:
> Delete the incorrect modifications for "borken" in V1.
> The previous version is here:
> 
> https://lore.kernel.org/lkml/20250926092832.1457477-1-jianyungao89@gmail.com/
> 
>  kernel/sched/core.c     | 2 +-
>  kernel/sched/cputime.c  | 2 +-
>  kernel/sched/fair.c     | 8 ++++----
>  kernel/sched/wait_bit.c | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7f1e5cb94c53..af5076e40567 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6858,7 +6858,7 @@ static void __sched notrace __schedule(int sched_mode)
>  		/*
>  		 * We pass task_is_blocked() as the should_block arg
>  		 * in order to keep mutex-blocked tasks on the runqueue
> -		 * for slection with proxy-exec (without proxy-exec
> +		 * for selection with proxy-exec (without proxy-exec
>  		 * task_is_blocked() will always be false).
>  		 */
>  		try_to_block_task(rq, prev, &prev_state,
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 7097de2c8cda..2429be5a5e40 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -585,7 +585,7 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>  	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
>  	/*
>  	 * Because mul_u64_u64_div_u64() can approximate on some
> -	 * achitectures; enforce the constraint that: a*b/(b+c) <= a.
> +	 * architectures; enforce the constraint that: a*b/(b+c) <= a.
>  	 */
>  	if (unlikely(stime > rtime))
>  		stime = rtime;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 18a30ae35441..20fe5899b247 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5381,7 +5381,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  		bool delay = sleep;
>  		/*
>  		 * DELAY_DEQUEUE relies on spurious wakeups, special task
> -		 * states must not suffer spurious wakeups, excempt them.
> +		 * states must not suffer spurious wakeups, except them.

This should be exempt, no?

