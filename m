Return-Path: <linux-kernel+bounces-880646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 333E3C2642D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFDA3B476B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641DB2FD1B1;
	Fri, 31 Oct 2025 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4wjm+hsB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="POIpP0mT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711423D7F8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929652; cv=none; b=dl++RGRJJ0mHwLQqdzQSFQo5yG44XzNYpd2OLsd2IwqRtJVCk+iac5foij2hFF0ioe+V3UMWCSne/Vw0taDb+p12oI4KU7sI+FJoDJvlcp1b8njRbt3qcb9tgvMYBJTWaK6v5JQ6HcNkUTX4u8wHW91CGbTaqICpr04oT4drXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929652; c=relaxed/simple;
	bh=mqGWgO7cyC3iggWMgWRC+CNmWFkC2rMhj3EhiBsn0NA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TSGR240J+MzVlv3FdW/Erybd48mOaU590h6OPLIFHE/uW03duyg0WrXtA4r3IPTaG60lCZjfpsIM93PfNDTRw4uSzAYWjqPqdk71hhJXCujlV25KXQJSKzZDfqBx+Pq2n+GGDKazCP9jO1Ew3WefcvuaBlKDxsVG3W+De5h1qfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4wjm+hsB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=POIpP0mT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761929648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e6n+rSOP7O7Kh+RAMVznelXmjArh9FxQrsNWnMALPbU=;
	b=4wjm+hsBvVWIAG3xTKA96NxL+eBfsDGoHKcBtzUNz2WYWjr/mdoYRiz+SwQW9QTzYciKV6
	jblwA38qtBPI2InsG9TS9G9bFhUO4+JkfKekFybdnvGwNxX9NruQPCvz27fqwJNeC9/7i5
	v38ka5Ncv81A5ISZ36WvvtQ+c+L4NBCIlEI0cOwLnqY3+iXdyG/2oUzXm4MUOPzh7GDcM+
	uTcJJO3rrziP41VW0IaKvpVgJmS6RJbm+4sXaMQdtkK3PGHe2ZIeszRT/19zzFPuBdbK3K
	E1UvAPfi0d7SEmvb/i8P5mElgUqwr6IABl2oX/kP7cMkVc89EGuWdNto9YWHPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761929648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e6n+rSOP7O7Kh+RAMVznelXmjArh9FxQrsNWnMALPbU=;
	b=POIpP0mTC5pmIbsND22UCFYxCyi0YOJ6daoH8mdD0xYEVxo/vH9nZCkrnpcaKJH4ghq20U
	QzVQVmg4SzlIGMDg==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, Jens Axboe
 <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim
 Chen <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>, Shrikanth
 Hegde <sshegde@linux.ibm.com>
Subject: Re: [patch V3 17/20] sched/mmcid: Provide CID ownership mode fixup
 functions
In-Reply-To: <c2e4fed9-b207-4d28-93f5-b09f0fe78e35@efficios.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124516.343419392@linutronix.de>
 <c2e4fed9-b207-4d28-93f5-b09f0fe78e35@efficios.com>
Date: Fri, 31 Oct 2025 17:54:07 +0100
Message-ID: <87wm4brp00.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 30 2025 at 11:51, Mathieu Desnoyers wrote:
> On 2025-10-29 09:09, Thomas Gleixner wrote:
>> At the point of switching to per CPU mode the new user is not yet visible
>> in the system, so the task which initiated the fork() runs the fixup
>> function: mm_cid_fixup_tasks_to_cpu() walks the thread list and either
>> transfers each tasks owned CID to the CPU the task runs on or drops it into
>> the CID pool if a task is not on a CPU at that point in time. Tasks which
>> schedule in before the task walk reaches them do the handover in
>> mm_cid_schedin(). When mm_cid_fixup_tasks_to_cpus() completes it's
>> guaranteed that no task related to that MM owns a CID anymore.
>> 
>> Switching back to task mode happens when the user count goes below the
>> threshold which was recorded on the per CPU mode switch:
>> 
>> 	pcpu_thrs = min(opt_cids - (opt_cids / 4), nr_cpu_ids / 2);
>> 
>
> AFAIU this provides an hysteresis so we don't switch back and
> forth between modes if a single thread is forked/exits repeatedly,
> right ?

Yes. We could do that with a timer too, but the hysteresis worked fine
so far.

>> This transition from CPU to per task ownership happens in two phases:
>> 
>>   1) mm:mm_cid.transit contains MM_CID_TRANSIT. This is OR'ed on the task
>>      CID and denotes that the CID is only temporarily owned by the
>>      task. When it schedules out the task drops the CID back into the
>>      pool if this bit is set.
>
> OK, so the mm_drop_cid() on sched out only happens due to a transition
> from per-cpu back to per-task. This answers my question in the previous
> patch.

:)

>> + * Switching back to task mode happens when the user count goes below the
>> + * threshold which was recorded on the per CPU mode switch:
>> + *
>> + *	pcpu_thrs = min(opt_cids - (opt_cids / 4), num_possible_cpus() / 2);
>
> I notice that mm_update_cpus_allowed() calls __mm_update_max_cids() 
> before updating the pcpu_thrs threshold.
>
> sched_mm_cid_{add,remove}_user() only invoke mm_update_max_cids(mm)
> without updating pcpu_thrs first.
>
> Are those done on purpose ?

Yes. Update of pcpu_thrs is only possible when a resulting transition
can be handled in the context. max_cids update is always possible.

That's why mm_update_cpus_allowed() only updates max_cids and then
schedules work to defer a potential transition to the worker thread
context.

sched_mm_cid_{add,remove}_user() does:

    mm_update_max_cids()
      __mm_update_max_cids()    <- Updates max_cids

      update threshold and potentially switch ownership mode

As this holds the mutex it prevents new tasks coming in or other tasks
exiting until it managed the transition.

mm_cid_work_fn() does the same thing unless a
sched_mm_cid_{add,remove}_user() did not already handle it.

Thanks,

        tglx

      

