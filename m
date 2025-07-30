Return-Path: <linux-kernel+bounces-750846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838DBB161C0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A07B5A2F37
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76692C3258;
	Wed, 30 Jul 2025 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vegHoSTF"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8119FA93
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883190; cv=none; b=Fv0rlPqJ/vQ+dfdRb9PixHNsuI0T3e5mxubvu5220ZzxNmO6e6F+0Peu+X1UnWxcK4jC1O8x0yHWdFpp58W+j7qZZ3c4k7pwg8eKI76yGuSH8QfvmLE3xmBcuCVBkWTa7GleD6p8Ejnh+ImqOhM3Yw18B0ignH6y7CIE+xDxqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883190; c=relaxed/simple;
	bh=x6QvuodMmjrvFEYf5ncf21szzag7VJQ9bmBkMJMOBoc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qq3Lppz4dmW/PKJyFjKDTUEU7tVFynshQHfhDnnYkELTFC/ULqOFtTCrSIkU/B6cxKlnbHN15LaxaQD8Ko+NtcxWXXFfJX5vLZOqBiVRVeMA2ilRh3tCm7sgHwsinAWXz2L6f/ExjH+gowBhtAAuF/3ILX8efZ6gzP7OUipce8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vegHoSTF; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c40f5578-7c07-4328-9885-500957a7dcab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753883185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr0jVB62KfXSRqm36gHw4zWnqZ3/blzsTegMlKlCjxU=;
	b=vegHoSTFwpMA+EUtATjp4DMjaEDZPkCYhysAiuUhK3avRrAl7yrwQzlDWCp0VJfdFEqq5h
	GkP1R3JkkgH0ng8eB0G7EFxSRjcibOBQy1bZEZCJ78tK7ed/Adq9wMDZf2RjeaYSfw8Pr8
	gWmBTwrPK5orxtb2gphSHktFLN5D1IQ=
Date: Wed, 30 Jul 2025 21:46:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Subject: Re: [RFC PATCH] hung_task: Dump blocker task if it is not hung
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
 Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang
 <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>,
 Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250730175150.af61caf3be97ef4cfbcc4da3@kernel.org>
 <175386922226.617855.4016966678697742834.stgit@devnote2>
Content-Language: en-US
In-Reply-To: <175386922226.617855.4016966678697742834.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/30 17:53, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Dump the lock blocker task if it is not hung because if the blocker
> task is also hung, it should be dumped by the detector. This will
> de-duplicate the same stackdumps if the blocker task is also blocked
> by another task (and hung).

Makes sense to me ;)

> 
> Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   kernel/hung_task.c |   86 ++++++++++++++++++++++++++++++----------------------
>   1 file changed, 49 insertions(+), 37 deletions(-)
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index d2432df2b905..52d72beb2233 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -94,9 +94,49 @@ static struct notifier_block panic_block = {
>   	.notifier_call = hung_task_panic,
>   };
>   
> +static bool task_is_hung(struct task_struct *t, unsigned long timeout)
> +{
> +	unsigned long switch_count = t->nvcsw + t->nivcsw;
> +	unsigned int state;
> +
> +	/*
> +	 * skip the TASK_KILLABLE tasks -- these can be killed
> +	 * skip the TASK_IDLE tasks -- those are genuinely idle
> +	 */
> +	state = READ_ONCE(t->__state);
> +	if (!(state & TASK_UNINTERRUPTIBLE) ||
> +		(state & TASK_WAKEKILL) ||
> +		(state & TASK_NOLOAD))
> +		return false;
> +
> +	/*
> +	 * Ensure the task is not frozen.
> +	 * Also, skip vfork and any other user process that freezer should skip.
> +	 */
> +	if (unlikely(READ_ONCE(t->__state) & TASK_FROZEN))
> +		return false;


Nit: the two separate checks on t->__state could be combined into
a single read and one conditional check ;)

Something like:

	state = READ_ONCE(t->__state);

	if (!(state & TASK_UNINTERRUPTIBLE) ||
		(state & (TASK_WAKEKILL | TASK_NOLOAD | TASK_FROZEN)))
			return false;


Otherwise, looks good to me:
Acked-by: Lance Yang <lance.yang@linux.dev>

Thanks,
Lance

> +
> +	/*
> +	 * When a freshly created task is scheduled once, changes its state to
> +	 * TASK_UNINTERRUPTIBLE without having ever been switched out once, it
> +	 * musn't be checked.
> +	 */
> +	if (unlikely(!switch_count))
> +		return false;
> +
> +	if (switch_count != t->last_switch_count) {
> +		t->last_switch_count = switch_count;
> +		t->last_switch_time = jiffies;
> +		return false;
> +	}
> +	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
> +		return false;
> +
> +	return true;
> +}
>   
>   #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> -static void debug_show_blocker(struct task_struct *task)
> +static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
>   {
>   	struct task_struct *g, *t;
>   	unsigned long owner, blocker, blocker_type;
> @@ -153,41 +193,21 @@ static void debug_show_blocker(struct task_struct *task)
>   			       task->comm, task->pid, t->comm, t->pid);
>   			break;
>   		}
> -		sched_show_task(t);
> +		/* Avoid duplicated task dump, skip if the task is also hung. */
> +		if (!task_is_hung(t, timeout))
> +			sched_show_task(t);
>   		return;
>   	}
>   }
>   #else
> -static inline void debug_show_blocker(struct task_struct *task)
> +static inline void debug_show_blocker(struct task_struct *task, unsigned long timeout)
>   {
>   }
>   #endif
>   
>   static void check_hung_task(struct task_struct *t, unsigned long timeout)
>   {
> -	unsigned long switch_count = t->nvcsw + t->nivcsw;
> -
> -	/*
> -	 * Ensure the task is not frozen.
> -	 * Also, skip vfork and any other user process that freezer should skip.
> -	 */
> -	if (unlikely(READ_ONCE(t->__state) & TASK_FROZEN))
> -		return;
> -
> -	/*
> -	 * When a freshly created task is scheduled once, changes its state to
> -	 * TASK_UNINTERRUPTIBLE without having ever been switched out once, it
> -	 * musn't be checked.
> -	 */
> -	if (unlikely(!switch_count))
> -		return;
> -
> -	if (switch_count != t->last_switch_count) {
> -		t->last_switch_count = switch_count;
> -		t->last_switch_time = jiffies;
> -		return;
> -	}
> -	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
> +	if (!task_is_hung(t, timeout))
>   		return;
>   
>   	/*
> @@ -222,7 +242,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>   		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
>   			" disables this message.\n");
>   		sched_show_task(t);
> -		debug_show_blocker(t);
> +		debug_show_blocker(t, timeout);
>   		hung_task_show_lock = true;
>   
>   		if (sysctl_hung_task_all_cpu_backtrace)
> @@ -278,7 +298,6 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>   	hung_task_show_lock = false;
>   	rcu_read_lock();
>   	for_each_process_thread(g, t) {
> -		unsigned int state;
>   
>   		if (!max_count--)
>   			goto unlock;
> @@ -287,15 +306,8 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>   				goto unlock;
>   			last_break = jiffies;
>   		}
> -		/*
> -		 * skip the TASK_KILLABLE tasks -- these can be killed
> -		 * skip the TASK_IDLE tasks -- those are genuinely idle
> -		 */
> -		state = READ_ONCE(t->__state);
> -		if ((state & TASK_UNINTERRUPTIBLE) &&
> -		    !(state & TASK_WAKEKILL) &&
> -		    !(state & TASK_NOLOAD))
> -			check_hung_task(t, timeout);
> +
> +		check_hung_task(t, timeout);
>   	}
>    unlock:
>   	rcu_read_unlock();
>

