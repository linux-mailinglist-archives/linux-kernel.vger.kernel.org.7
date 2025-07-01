Return-Path: <linux-kernel+bounces-710682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1380AEEFAF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 09:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862381BC53A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 07:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F1C25A2D2;
	Tue,  1 Jul 2025 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVntZeoe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A71EA6F;
	Tue,  1 Jul 2025 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751354552; cv=none; b=QvvoQ4yQ8kGubWnedw/S7uG7elzJJ1nKnAJ+Q6KhjZH1in//JnntuzmACFUj171NZMVrxZji3W7SSCEHGnliq0cPMpWfXsGpF+pA2HbZpuWog6QACm39GSS/tSEDAZFYEUaK3hpxxZoj1I/3+BsjaK4BCWv66BfhMN0wiwLny/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751354552; c=relaxed/simple;
	bh=vcaLgndn3WFLw6Dz/O3hK84SLm+T5JxcdduJdHR1mXk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p4+FylI2/U2auzk/OPhF3HnetMjp6HjC/0d1gUBCvygttgUAj925vMGXBn4XfrigT+UNzNEzfXlYeSiVL+NP1mpoCsHdw/HrXeVHFKQ+CHQFuRK/Ik8josn4PKVilEANZpWVoCDqdIEM2NCvvbu+TYBFVwwRcIUhmJiLRG40gdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVntZeoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFE6C4CEEB;
	Tue,  1 Jul 2025 07:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751354552;
	bh=vcaLgndn3WFLw6Dz/O3hK84SLm+T5JxcdduJdHR1mXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WVntZeoeCLuK1vtl2zGm/AzpMEfj/ayor910A9tHVJLdaUOq9IH7g+wfSVOeBJLxM
	 o4KcnbKnoR0EUiQULOylJW0qqxw4e4+52E0NU+n/Ng2YSCAfj0g8VUMxm8QLRwqmxC
	 13ocE15muOQf/YQap5phQe5HqWL5fNtv4gdH2gz+eu2PYxwpi8WO5cjhuLr15/j2HX
	 FnXUrgPFHDvTRBhu0+4VLrIrj5sYunvd2bbr4Kfw69J8L5KmnoLq2vmZpjjJgNwXGI
	 e9HSE+/Vqa3jkjJraqTaUjguEEOD9fyUmdVq78Wq6VjuzUAnl6z0hHThH3JcWfcdgN
	 ZUTY/5k5O29mA==
Date: Tue, 1 Jul 2025 16:22:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] ring-buffer: Remove ring_buffer_read_prepare_sync()
Message-Id: <20250701162230.76d399aea87b93ba589d8272@kernel.org>
In-Reply-To: <20250630180440.3eabb514@batman.local.home>
References: <20250630180440.3eabb514@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 18:04:40 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When the ring buffer was first introduced, reading the non-consuming
> "trace" file required disabling the writing of the ring buffer. To make
> sure the writing was fully disabled before iterating the buffer with a
> non-consuming read, it would set the disable flag of the buffer and then
> call an RCU synchronization to make sure all the buffers were
> synchronized.
> 
> The function ring_buffer_read_start() originally  would initialize the
> iterator and call an RCU synchronization, but this was for each individual
> per CPU buffer where this would get called many times on a machine with
> many CPUs before the trace file could be read. The commit 72c9ddfd4c5bf
> ("ring-buffer: Make non-consuming read less expensive with lots of cpus.")
> separated ring_buffer_read_start into ring_buffer_read_prepare(),
> ring_buffer_read_sync() and then ring_buffer_read_start() to allow each of
> the per CPU buffers to be prepared, call the read_buffer_read_sync() once,
> and then the ring_buffer_read_start() for each of the CPUs which made
> things much faster.
> 
> The commit 1039221cc278 ("ring-buffer: Do not disable recording when there
> is an iterator") removed the requirement of disabling the recording of the
> ring buffer in order to iterate it, but it did not remove the
> synchronization that was happening that was required to wait for all the
> buffers to have no more writers. It's now OK for the buffers to have
> writers and no synchronization is needed.
> 
> Remove the synchronization and put back the interface for the ring buffer
> iterator back before commit 72c9ddfd4c5bf was applied.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Reported-by: David Howells <dhowells@redhat.com>
> Fixes: 1039221cc278 ("ring-buffer: Do not disable recording when there is an iterator")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/ring_buffer.h |  4 +--
>  kernel/trace/ring_buffer.c  | 63 ++++++-------------------------------
>  kernel/trace/trace.c        | 14 +++------
>  kernel/trace/trace_kdb.c    |  8 ++---
>  4 files changed, 18 insertions(+), 71 deletions(-)
> 
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index cd7f0ae26615..bc90c3c7b5fd 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -152,9 +152,7 @@ ring_buffer_consume(struct trace_buffer *buffer, int cpu, u64 *ts,
>  		    unsigned long *lost_events);
>  
>  struct ring_buffer_iter *
> -ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags);
> -void ring_buffer_read_prepare_sync(void);
> -void ring_buffer_read_start(struct ring_buffer_iter *iter);
> +ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags);
>  void ring_buffer_read_finish(struct ring_buffer_iter *iter);
>  
>  struct ring_buffer_event *
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 00fc38d70e86..24bb5287c415 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5846,24 +5846,20 @@ ring_buffer_consume(struct trace_buffer *buffer, int cpu, u64 *ts,
>  EXPORT_SYMBOL_GPL(ring_buffer_consume);
>  
>  /**
> - * ring_buffer_read_prepare - Prepare for a non consuming read of the buffer
> + * ring_buffer_read_start - start a non consuming read of the buffer
>   * @buffer: The ring buffer to read from
>   * @cpu: The cpu buffer to iterate over
>   * @flags: gfp flags to use for memory allocation
>   *
> - * This performs the initial preparations necessary to iterate
> - * through the buffer.  Memory is allocated, buffer resizing
> - * is disabled, and the iterator pointer is returned to the caller.
> - *
> - * After a sequence of ring_buffer_read_prepare calls, the user is
> - * expected to make at least one call to ring_buffer_read_prepare_sync.
> - * Afterwards, ring_buffer_read_start is invoked to get things going
> - * for real.
> + * This creates an iterator to allow non-consuming iteration through
> + * the buffer. If the buffer is disabled for writing, it will produce
> + * the same information each time, but if the buffer is still writing
> + * then the first hit of a write will cause the iteration to stop.
>   *
> - * This overall must be paired with ring_buffer_read_finish.
> + * Must be paired with ring_buffer_read_finish.
>   */
>  struct ring_buffer_iter *
> -ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
> +ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
>  {
>  	struct ring_buffer_per_cpu *cpu_buffer;
>  	struct ring_buffer_iter *iter;
> @@ -5889,51 +5885,12 @@ ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
>  
>  	atomic_inc(&cpu_buffer->resize_disabled);
>  
> -	return iter;
> -}
> -EXPORT_SYMBOL_GPL(ring_buffer_read_prepare);
> -
> -/**
> - * ring_buffer_read_prepare_sync - Synchronize a set of prepare calls
> - *
> - * All previously invoked ring_buffer_read_prepare calls to prepare
> - * iterators will be synchronized.  Afterwards, read_buffer_read_start
> - * calls on those iterators are allowed.
> - */
> -void
> -ring_buffer_read_prepare_sync(void)
> -{
> -	synchronize_rcu();
> -}
> -EXPORT_SYMBOL_GPL(ring_buffer_read_prepare_sync);
> -
> -/**
> - * ring_buffer_read_start - start a non consuming read of the buffer
> - * @iter: The iterator returned by ring_buffer_read_prepare
> - *
> - * This finalizes the startup of an iteration through the buffer.
> - * The iterator comes from a call to ring_buffer_read_prepare and
> - * an intervening ring_buffer_read_prepare_sync must have been
> - * performed.
> - *
> - * Must be paired with ring_buffer_read_finish.
> - */
> -void
> -ring_buffer_read_start(struct ring_buffer_iter *iter)
> -{
> -	struct ring_buffer_per_cpu *cpu_buffer;
> -	unsigned long flags;
> -
> -	if (!iter)
> -		return;
> -
> -	cpu_buffer = iter->cpu_buffer;
> -
> -	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
>  	arch_spin_lock(&cpu_buffer->lock);
>  	rb_iter_reset(iter);
>  	arch_spin_unlock(&cpu_buffer->lock);
> -	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> +
> +	return iter;
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_read_start);
>  
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 95ae7c4e5835..7996f26c3f46 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4735,21 +4735,15 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
>  	if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
>  		for_each_tracing_cpu(cpu) {
>  			iter->buffer_iter[cpu] =
> -				ring_buffer_read_prepare(iter->array_buffer->buffer,
> -							 cpu, GFP_KERNEL);
> -		}
> -		ring_buffer_read_prepare_sync();
> -		for_each_tracing_cpu(cpu) {
> -			ring_buffer_read_start(iter->buffer_iter[cpu]);
> +				ring_buffer_read_start(iter->array_buffer->buffer,
> +						       cpu, GFP_KERNEL);
>  			tracing_iter_reset(iter, cpu);
>  		}
>  	} else {
>  		cpu = iter->cpu_file;
>  		iter->buffer_iter[cpu] =
> -			ring_buffer_read_prepare(iter->array_buffer->buffer,
> -						 cpu, GFP_KERNEL);
> -		ring_buffer_read_prepare_sync();
> -		ring_buffer_read_start(iter->buffer_iter[cpu]);
> +			ring_buffer_read_start(iter->array_buffer->buffer,
> +					       cpu, GFP_KERNEL);
>  		tracing_iter_reset(iter, cpu);
>  	}
>  
> diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> index d7b135de958a..896ff78b8349 100644
> --- a/kernel/trace/trace_kdb.c
> +++ b/kernel/trace/trace_kdb.c
> @@ -43,17 +43,15 @@ static void ftrace_dump_buf(int skip_entries, long cpu_file)
>  	if (cpu_file == RING_BUFFER_ALL_CPUS) {
>  		for_each_tracing_cpu(cpu) {
>  			iter.buffer_iter[cpu] =
> -			ring_buffer_read_prepare(iter.array_buffer->buffer,
> -						 cpu, GFP_ATOMIC);
> -			ring_buffer_read_start(iter.buffer_iter[cpu]);
> +			ring_buffer_read_start(iter.array_buffer->buffer,
> +					       cpu, GFP_ATOMIC);
>  			tracing_iter_reset(&iter, cpu);
>  		}
>  	} else {
>  		iter.cpu_file = cpu_file;
>  		iter.buffer_iter[cpu_file] =
> -			ring_buffer_read_prepare(iter.array_buffer->buffer,
> +			ring_buffer_read_start(iter.array_buffer->buffer,
>  						 cpu_file, GFP_ATOMIC);
> -		ring_buffer_read_start(iter.buffer_iter[cpu_file]);
>  		tracing_iter_reset(&iter, cpu_file);
>  	}
>  
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

