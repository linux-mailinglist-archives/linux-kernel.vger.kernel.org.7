Return-Path: <linux-kernel+bounces-868977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF44C06A28
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF6219A6A73
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F784321440;
	Fri, 24 Oct 2025 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WiuVgYJk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kji0obE1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20431321437
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314918; cv=none; b=gICtxEo9xP/PlY/8cNqSRkwofe1i8+JzKpHuG9uqUcwfYSMtFGz+xKKiJli7RUEWtZh60W7/nU8FJumJQwuXUE7pKXZDBdGx3wiaXUdu3WThWnM2vnERXBOBOhbrACTthuHcyZx5YAxCHuVl2E+yzgn+Y1gOHTmGAh/qGVrLG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314918; c=relaxed/simple;
	bh=DjZIMYziZJti4cIwCUk2zMo08dJyZ1fKo+YAtBDfE7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2lcxHjEWKHhFVxnMEgApryd5i8CmR8EPsnh7VYpWVzrU3Hd94HvbwB+JZXtRcsQpXDzOtTou9vqH34mII1o72XfGPoOOBQ+OxY1iwq5ga6CrXoJFv2k7zkCQH0fdHajfd8J4pZSh7lJ3SduYfclSIqmqQbsMQCkjjkfNcPtqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WiuVgYJk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kji0obE1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 16:08:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761314913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUhz7mvCtVK/4sfT1pxu2dbd/8sjuxWFFtbj6/RjElU=;
	b=WiuVgYJknrfIsBkliwPM36Re2J+A7d96kIRevAIVbLLVlBo+GDgsvDqg0IHrJboA5bOz4o
	unnfWzpwDgg5msrhinMtCSUAu4sk1I7IjzwfGdxvLPHbr+1g+yoFntWvqIuEqgPGqtRLhO
	equnabzU40qAcUYCsx3EX7lB60Zzmmu7Bj4BUG8cpck/gzaMFcCSfAf/lgMwOcMCDqJ0aV
	SY3OjSoqtxRF9a/WtUM3jzxJTK5Mk+PH08r/jp0La1Q/uUzkYZcKVxcSD/IPA0drsB/NKp
	MqENSPXlHxFB8YmV233Jh4g4ElJUdx86yw6FCteLeBM1f3C7gdj3o4JCjopBmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761314913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUhz7mvCtVK/4sfT1pxu2dbd/8sjuxWFFtbj6/RjElU=;
	b=Kji0obE1/YO2pp1Qe4rCQZx5NAxLWg0Ad6gJHoxlN31n0kf+f2D3ZjO9cGZWj4Cy2qlLMW
	yLXgzcgTvF0L5jBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Mel Gorman <mgorman@suse.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smp: Suppress false DEBUG_PREEMPT warning in
 smp_call_on_cpu()
Message-ID: <20251024140832.46JNLRvL@linutronix.de>
References: <20251024070714.4047816-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024070714.4047816-1-namcao@linutronix.de>

On 2025-10-24 09:07:14 [+0200], Nam Cao wrote:
> While booting UP (uniprocessor) kernel with CONFIG_DEBUG_PREEMPT=y, the
> following warning is observed:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> caller is debug_smp_processor_id+0x1c/0x28
> CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.0-rc2-00012-g002733e953a7 #111 PREEMPT_RT
> Hardware name: MangoPi MQ Pro (DT)
> Call Trace:
>     dump_backtrace
>     show_stack
>     dump_stack_lvl
>     dump_stack
>     check_preemption_disabled.isra.0
>     debug_smp_processor_id
>     check_unaligned_access
>     smp_call_on_cpu
>     check_unaligned_access_all_cpus
>     do_one_initcall
>     kernel_init_freeable
>     kernel_init
>     ret_from_fork_kernel
>     ret_from_fork_kernel_asm

Can be compressed to:

   Using smp_processor_id() in a smp_call_on_cpu() callback triggers a
   "using ... in preemptible" warning in UP builds.

> This is a false warning. The UP-variant of smp_call_on_cpu() simply calls
> the callback, and thus debug_smp_processor_id() thinks the context is
> unsafe for smp_processor_id(), which is obviously false because this is UP
> kernel.

"Only the UP implementation is affected by this"

> This appears after commit 06ddd17521bf ("sched/smp: Always define
> is_percpu_thread() and scheduler_ipi()"). Before this commit,
> is_percpu_thread() always returns true on UP kernel and thus
> debug_smp_processor_id() always sees a per-cpu thread and never warns. But
> now is_percpu_thread() returns false for this case.
> 
> Suppress this warning with a migrate_disable()+migrate_enable() pair.

Right. This is one of the possibilities. The other one would be to also
workqueue on UP and preserve the same semantic.
I don't mind this.

> Fixes: 06ddd17521bf ("sched/smp: Always define is_percpu_thread() and scheduler_ipi()")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> grep shows me that the followings also have the same false warning:
> 
>     arch/arm64/kernel/watchdog_hld.c
>     drivers/hwmon/dell-smm-hwmon.c
>     drivers/platform/x86/dell/dcdbas.c
>     kernel/watchdog.c
> ---
>  kernel/up.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/up.c b/kernel/up.c
> index df50828cc2f0..37c9f0d39b36 100644
> --- a/kernel/up.c
> +++ b/kernel/up.c
> @@ -64,7 +64,14 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
>  
>  	if (phys)
>  		hypervisor_pin_vcpu(0);
> +
> +	/* suppress warnings from debug_smp_processor_id() */

If you want to add a comment, what about something like

  /* Preserve not being migratable such as SMP variant does */ 

> +	migrate_disable();
> +
>  	ret = func(par);
> +
> +	migrate_enable();
> +
>  	if (phys)
>  		hypervisor_pin_vcpu(-1);
>  

Sebastian

