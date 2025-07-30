Return-Path: <linux-kernel+bounces-751368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E49B16898
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA1F622749
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB702253FE;
	Wed, 30 Jul 2025 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcmSAP+k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B41E1A05
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912256; cv=none; b=f2aj786qUBbMcxbW8NTVLX5OiBggSpLL0+67AKcMdVoY8IhJ22Do5y2OSTq6zmAp5K9xDdh6JxNNOwhL1CDxKn/zVzTo5Ig7hjLhVs68wrNr2iHBBg4yxE6f5WmAtONm3hjAgfBUKub6XtDeQ213C4xPCeaC65vhwCsTAjvJ0T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912256; c=relaxed/simple;
	bh=uxRJXSWej+1pl/HDqr/i9dIOy3MyQoKUeCAFVRS8AZ8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UHBopzujV0QICUe4OU1wTKdTlShRc9atg4dDFLOYf8WlE1pXllR9Z2zNCi7m30o0wWg8I9yV29IotgzIiLuxBOK5/rX7zyZdtGAuYkMehrFkGwy00MT6dM117XglCPnN25U/Y6wl96lMCit5O305OgU5PX3M4v54gEEgo+x0I3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcmSAP+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF25C4CEE3;
	Wed, 30 Jul 2025 21:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753912256;
	bh=uxRJXSWej+1pl/HDqr/i9dIOy3MyQoKUeCAFVRS8AZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dcmSAP+kkky5t6fIl43Eb991tE8j+ncx35TTySqegkqEqBP8Ia8pSaJvLxYFyS+v1
	 NZQfG1CUyqM9iEcQotJJhR/at2fcEDmGUHXDdtzkm16tyHPljaMm4qGAJ+V2fcRF7D
	 yRtf+dQ3d3FVPP9MWR3X5BD7mWQHCgvn5N6JNaPTPvj4dkaRzNN1FrMoWFt/czMB6a
	 4CXn8CL7KyQrVD7BIje1CFmfRXe/JzOow/fgtK/lkohwtUt5nMSCtHIkwmKEG8Jm17
	 vHiKFflF0s+OH7VM7AAOvGn2Ylgu0gKHfBfZyuvMcdQpoBf2tr8xqDX56f7YlBsDT+
	 a9cRWxG1GZIYg==
Date: Thu, 31 Jul 2025 06:50:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Joel
 Granados <joel.granados@kernel.org>, Anna Schumaker
 <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>, Kent
 Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa
 <tfiga@chromium.org>, linux-kernel@vger.kernel.org, Sergey Senozhatsky
 <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH] hung_task: Dump blocker task if it is not hung
Message-Id: <20250731065050.38905afadd094ddc0d7a8bcf@kernel.org>
In-Reply-To: <c40f5578-7c07-4328-9885-500957a7dcab@linux.dev>
References: <20250730175150.af61caf3be97ef4cfbcc4da3@kernel.org>
	<175386922226.617855.4016966678697742834.stgit@devnote2>
	<c40f5578-7c07-4328-9885-500957a7dcab@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 21:46:16 +0800
Lance Yang <lance.yang@linux.dev> wrote:

> 
> 
> On 2025/7/30 17:53, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Dump the lock blocker task if it is not hung because if the blocker
> > task is also hung, it should be dumped by the detector. This will
> > de-duplicate the same stackdumps if the blocker task is also blocked
> > by another task (and hung).
> 
> Makes sense to me ;)
> 
> > 
> > Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >   kernel/hung_task.c |   86 ++++++++++++++++++++++++++++++----------------------
> >   1 file changed, 49 insertions(+), 37 deletions(-)
> > 
> > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > index d2432df2b905..52d72beb2233 100644
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -94,9 +94,49 @@ static struct notifier_block panic_block = {
> >   	.notifier_call = hung_task_panic,
> >   };
> >   
> > +static bool task_is_hung(struct task_struct *t, unsigned long timeout)
> > +{
> > +	unsigned long switch_count = t->nvcsw + t->nivcsw;
> > +	unsigned int state;
> > +
> > +	/*
> > +	 * skip the TASK_KILLABLE tasks -- these can be killed
> > +	 * skip the TASK_IDLE tasks -- those are genuinely idle
> > +	 */
> > +	state = READ_ONCE(t->__state);
> > +	if (!(state & TASK_UNINTERRUPTIBLE) ||
> > +		(state & TASK_WAKEKILL) ||
> > +		(state & TASK_NOLOAD))
> > +		return false;
> > +
> > +	/*
> > +	 * Ensure the task is not frozen.
> > +	 * Also, skip vfork and any other user process that freezer should skip.
> > +	 */
> > +	if (unlikely(READ_ONCE(t->__state) & TASK_FROZEN))
> > +		return false;
> 
> 
> Nit: the two separate checks on t->__state could be combined into
> a single read and one conditional check ;)
> 
> Something like:
> 
> 	state = READ_ONCE(t->__state);
> 
> 	if (!(state & TASK_UNINTERRUPTIBLE) ||
> 		(state & (TASK_WAKEKILL | TASK_NOLOAD | TASK_FROZEN)))
> 			return false;

Ah, Indeed.

> 
> 
> Otherwise, looks good to me:
> Acked-by: Lance Yang <lance.yang@linux.dev>

Thanks, let me update it. (also on the next tree)

Thank you!

> 
> Thanks,
> Lance
> 
> > +
> > +	/*
> > +	 * When a freshly created task is scheduled once, changes its state to
> > +	 * TASK_UNINTERRUPTIBLE without having ever been switched out once, it
> > +	 * musn't be checked.
> > +	 */
> > +	if (unlikely(!switch_count))
> > +		return false;
> > +
> > +	if (switch_count != t->last_switch_count) {
> > +		t->last_switch_count = switch_count;
> > +		t->last_switch_time = jiffies;
> > +		return false;
> > +	}
> > +	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
> > +		return false;
> > +
> > +	return true;
> > +}
> >   
> >   #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > -static void debug_show_blocker(struct task_struct *task)
> > +static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
> >   {
> >   	struct task_struct *g, *t;
> >   	unsigned long owner, blocker, blocker_type;
> > @@ -153,41 +193,21 @@ static void debug_show_blocker(struct task_struct *task)
> >   			       task->comm, task->pid, t->comm, t->pid);
> >   			break;
> >   		}
> > -		sched_show_task(t);
> > +		/* Avoid duplicated task dump, skip if the task is also hung. */
> > +		if (!task_is_hung(t, timeout))
> > +			sched_show_task(t);
> >   		return;
> >   	}
> >   }
> >   #else
> > -static inline void debug_show_blocker(struct task_struct *task)
> > +static inline void debug_show_blocker(struct task_struct *task, unsigned long timeout)
> >   {
> >   }
> >   #endif
> >   
> >   static void check_hung_task(struct task_struct *t, unsigned long timeout)
> >   {
> > -	unsigned long switch_count = t->nvcsw + t->nivcsw;
> > -
> > -	/*
> > -	 * Ensure the task is not frozen.
> > -	 * Also, skip vfork and any other user process that freezer should skip.
> > -	 */
> > -	if (unlikely(READ_ONCE(t->__state) & TASK_FROZEN))
> > -		return;
> > -
> > -	/*
> > -	 * When a freshly created task is scheduled once, changes its state to
> > -	 * TASK_UNINTERRUPTIBLE without having ever been switched out once, it
> > -	 * musn't be checked.
> > -	 */
> > -	if (unlikely(!switch_count))
> > -		return;
> > -
> > -	if (switch_count != t->last_switch_count) {
> > -		t->last_switch_count = switch_count;
> > -		t->last_switch_time = jiffies;
> > -		return;
> > -	}
> > -	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
> > +	if (!task_is_hung(t, timeout))
> >   		return;
> >   
> >   	/*
> > @@ -222,7 +242,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
> >   		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
> >   			" disables this message.\n");
> >   		sched_show_task(t);
> > -		debug_show_blocker(t);
> > +		debug_show_blocker(t, timeout);
> >   		hung_task_show_lock = true;
> >   
> >   		if (sysctl_hung_task_all_cpu_backtrace)
> > @@ -278,7 +298,6 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
> >   	hung_task_show_lock = false;
> >   	rcu_read_lock();
> >   	for_each_process_thread(g, t) {
> > -		unsigned int state;
> >   
> >   		if (!max_count--)
> >   			goto unlock;
> > @@ -287,15 +306,8 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
> >   				goto unlock;
> >   			last_break = jiffies;
> >   		}
> > -		/*
> > -		 * skip the TASK_KILLABLE tasks -- these can be killed
> > -		 * skip the TASK_IDLE tasks -- those are genuinely idle
> > -		 */
> > -		state = READ_ONCE(t->__state);
> > -		if ((state & TASK_UNINTERRUPTIBLE) &&
> > -		    !(state & TASK_WAKEKILL) &&
> > -		    !(state & TASK_NOLOAD))
> > -			check_hung_task(t, timeout);
> > +
> > +		check_hung_task(t, timeout);
> >   	}
> >    unlock:
> >   	rcu_read_unlock();
> >
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

