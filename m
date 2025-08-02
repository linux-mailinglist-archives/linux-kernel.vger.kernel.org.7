Return-Path: <linux-kernel+bounces-754181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6946DB18F64
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 18:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37B454E0526
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525C8254874;
	Sat,  2 Aug 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPNGyY8T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583B02494F0
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754152086; cv=none; b=T2l2KVxeWszf4UrneM80is94Ypz9mHLmADO6FBPo6gR9e2aqeXRwqEtWVRuubZGcfpQ/5Eg4z00EE7M7r6QlTkIG9HtY5amCNKpijQpf6K4Dh6/ODYG6iJ7bQrmXtTTMDQkswYfQm1/7iv3pzI2uA5HbstHyqGEfML0ZQbN6YrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754152086; c=relaxed/simple;
	bh=vxiBDmyvlA2PS2tmmpe8jWPMSoj+TI8bgMKDT7CY6eQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=D78PmcNmcUYpLrT8VVf/AJ53YCDGtXfXd2hCkHBCvms0epOaAPGqDu1apgA43Rs3M+RNXpEdngi7/2N471aN6fcHcSH+wrfNPeeTOd9rXUq02jDGZXZhq3iV6aQuKP+brTpWa9dx0Ao+h9Ktu28HClBhwuSTNkhtZ0WpOLDZrC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPNGyY8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D11C4CEFA;
	Sat,  2 Aug 2025 16:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754152086;
	bh=vxiBDmyvlA2PS2tmmpe8jWPMSoj+TI8bgMKDT7CY6eQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=lPNGyY8TTwcY5a3A2eoqRriZ2chpw7WEDlyglEBX0W2FzqLGNQHmP4QaOdwEF9Pmb
	 m7nE1YFWjD5cBdTGWJGWWJXac5SweW2Qz4VxL31V967ty6h9f/ETmS/Q4GzP2RnI19
	 9CkH3rGbRG+ObDxTTUkmDNdeOlLpn2aM6a6f8K1e/CIr/sL52XYBT0yb55DZ2QINVD
	 J2lzOMBDsfndkjyu+Eq3rrQpuiZlqpJhQGSVIKwpzXjod6XGaAfpOKlo/6bLQjXWqx
	 L3Ho+I1oXwyxDVZ3lxwgsVF2N1N7UYweG8TdjJeENvaWsU2smX3Hvhm+5r7UrN1MpP
	 v+9k56xPBC2ng==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uiF5x-00000008SXa-29ux;
	Sat, 02 Aug 2025 12:28:29 -0400
Message-ID: <20250802162829.364996738@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 02 Aug 2025 12:27:37 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 3/6] tracing: Add guard() around locks and mutexes in trace.c
References: <20250802162734.529626660@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There's several locations in trace.c that can be simplified by using
guards around raw_spin_lock_irqsave, mutexes and preempt disabling.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/20250801203857.879085376@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 144 ++++++++++++++-----------------------------
 1 file changed, 46 insertions(+), 98 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 332487179e1d..4299e89ed04e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -432,15 +432,13 @@ static void ftrace_exports(struct ring_buffer_event *event, int flag)
 {
 	struct trace_export *export;
 
-	preempt_disable_notrace();
+	guard(preempt_notrace)();
 
 	export = rcu_dereference_raw_check(ftrace_exports_list);
 	while (export) {
 		trace_process_export(export, event, flag);
 		export = rcu_dereference_raw_check(export->next);
 	}
-
-	preempt_enable_notrace();
 }
 
 static inline void
@@ -497,27 +495,18 @@ int register_ftrace_export(struct trace_export *export)
 	if (WARN_ON_ONCE(!export->write))
 		return -1;
 
-	mutex_lock(&ftrace_export_lock);
+	guard(mutex)(&ftrace_export_lock);
 
 	add_ftrace_export(&ftrace_exports_list, export);
 
-	mutex_unlock(&ftrace_export_lock);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(register_ftrace_export);
 
 int unregister_ftrace_export(struct trace_export *export)
 {
-	int ret;
-
-	mutex_lock(&ftrace_export_lock);
-
-	ret = rm_ftrace_export(&ftrace_exports_list, export);
-
-	mutex_unlock(&ftrace_export_lock);
-
-	return ret;
+	guard(mutex)(&ftrace_export_lock);
+	return rm_ftrace_export(&ftrace_exports_list, export);
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 
@@ -640,9 +629,8 @@ void trace_array_put(struct trace_array *this_tr)
 	if (!this_tr)
 		return;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 	__trace_array_put(this_tr);
-	mutex_unlock(&trace_types_lock);
 }
 EXPORT_SYMBOL_GPL(trace_array_put);
 
@@ -1424,13 +1412,8 @@ static int tracing_arm_snapshot_locked(struct trace_array *tr)
 
 int tracing_arm_snapshot(struct trace_array *tr)
 {
-	int ret;
-
-	mutex_lock(&trace_types_lock);
-	ret = tracing_arm_snapshot_locked(tr);
-	mutex_unlock(&trace_types_lock);
-
-	return ret;
+	guard(mutex)(&trace_types_lock);
+	return tracing_arm_snapshot_locked(tr);
 }
 
 void tracing_disarm_snapshot(struct trace_array *tr)
@@ -2483,9 +2466,8 @@ void tracing_reset_all_online_cpus_unlocked(void)
 
 void tracing_reset_all_online_cpus(void)
 {
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 	tracing_reset_all_online_cpus_unlocked();
-	mutex_unlock(&trace_types_lock);
 }
 
 int is_tracing_stopped(void)
@@ -2496,18 +2478,17 @@ int is_tracing_stopped(void)
 static void tracing_start_tr(struct trace_array *tr)
 {
 	struct trace_buffer *buffer;
-	unsigned long flags;
 
 	if (tracing_disabled)
 		return;
 
-	raw_spin_lock_irqsave(&tr->start_lock, flags);
+	guard(raw_spinlock_irqsave)(&tr->start_lock);
 	if (--tr->stop_count) {
 		if (WARN_ON_ONCE(tr->stop_count < 0)) {
 			/* Someone screwed up their debugging */
 			tr->stop_count = 0;
 		}
-		goto out;
+		return;
 	}
 
 	/* Prevent the buffers from switching */
@@ -2524,9 +2505,6 @@ static void tracing_start_tr(struct trace_array *tr)
 #endif
 
 	arch_spin_unlock(&tr->max_lock);
-
- out:
-	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
 }
 
 /**
@@ -2544,11 +2522,10 @@ void tracing_start(void)
 static void tracing_stop_tr(struct trace_array *tr)
 {
 	struct trace_buffer *buffer;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&tr->start_lock, flags);
+	guard(raw_spinlock_irqsave)(&tr->start_lock);
 	if (tr->stop_count++)
-		goto out;
+		return;
 
 	/* Prevent the buffers from switching */
 	arch_spin_lock(&tr->max_lock);
@@ -2564,9 +2541,6 @@ static void tracing_stop_tr(struct trace_array *tr)
 #endif
 
 	arch_spin_unlock(&tr->max_lock);
-
- out:
-	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
 }
 
 /**
@@ -2679,12 +2653,12 @@ void trace_buffered_event_enable(void)
 
 		per_cpu(trace_buffered_event, cpu) = event;
 
-		preempt_disable();
-		if (cpu == smp_processor_id() &&
-		    __this_cpu_read(trace_buffered_event) !=
-		    per_cpu(trace_buffered_event, cpu))
-			WARN_ON_ONCE(1);
-		preempt_enable();
+		scoped_guard(preempt,) {
+			if (cpu == smp_processor_id() &&
+			    __this_cpu_read(trace_buffered_event) !=
+			    per_cpu(trace_buffered_event, cpu))
+				WARN_ON_ONCE(1);
+		}
 	}
 }
 
@@ -3029,7 +3003,7 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 		skip++;
 #endif
 
-	preempt_disable_notrace();
+	guard(preempt_notrace)();
 
 	stackidx = __this_cpu_inc_return(ftrace_stack_reserve) - 1;
 
@@ -3087,8 +3061,6 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 	/* Again, don't let gcc optimize things here */
 	barrier();
 	__this_cpu_dec(ftrace_stack_reserve);
-	preempt_enable_notrace();
-
 }
 
 static inline void ftrace_trace_stack(struct trace_array *tr,
@@ -3171,9 +3143,9 @@ ftrace_trace_userstack(struct trace_array *tr,
 	 * prevent recursion, since the user stack tracing may
 	 * trigger other kernel events.
 	 */
-	preempt_disable();
+	guard(preempt)();
 	if (__this_cpu_read(user_stack_count))
-		goto out;
+		return;
 
 	__this_cpu_inc(user_stack_count);
 
@@ -3191,8 +3163,6 @@ ftrace_trace_userstack(struct trace_array *tr,
 
  out_drop_count:
 	__this_cpu_dec(user_stack_count);
- out:
-	preempt_enable();
 }
 #else /* CONFIG_USER_STACKTRACE_SUPPORT */
 static void ftrace_trace_userstack(struct trace_array *tr,
@@ -3374,7 +3344,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	pause_graph_tracing();
 
 	trace_ctx = tracing_gen_ctx();
-	preempt_disable_notrace();
+	guard(preempt_notrace)();
 
 	tbuffer = get_trace_buf();
 	if (!tbuffer) {
@@ -3406,7 +3376,6 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	put_trace_buf();
 
 out_nobuffer:
-	preempt_enable_notrace();
 	unpause_graph_tracing();
 
 	return len;
@@ -3430,7 +3399,7 @@ int __trace_array_vprintk(struct trace_buffer *buffer,
 	pause_graph_tracing();
 
 	trace_ctx = tracing_gen_ctx();
-	preempt_disable_notrace();
+	guard(preempt_notrace)();
 
 
 	tbuffer = get_trace_buf();
@@ -3458,7 +3427,6 @@ int __trace_array_vprintk(struct trace_buffer *buffer,
 	put_trace_buf();
 
 out_nobuffer:
-	preempt_enable_notrace();
 	unpause_graph_tracing();
 
 	return len;
@@ -4788,20 +4756,16 @@ int tracing_open_file_tr(struct inode *inode, struct file *filp)
 	if (ret)
 		return ret;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
 	/* Fail if the file is marked for removal */
 	if (file->flags & EVENT_FILE_FL_FREED) {
 		trace_array_put(file->tr);
-		ret = -ENODEV;
+		return -ENODEV;
 	} else {
 		event_file_get(file);
 	}
 
-	mutex_unlock(&event_mutex);
-	if (ret)
-		return ret;
-
 	filp->private_data = inode->i_private;
 
 	return 0;
@@ -5945,9 +5909,9 @@ tracing_set_trace_read(struct file *filp, char __user *ubuf,
 	char buf[MAX_TRACER_SIZE+2];
 	int r;
 
-	mutex_lock(&trace_types_lock);
-	r = sprintf(buf, "%s\n", tr->current_trace->name);
-	mutex_unlock(&trace_types_lock);
+	scoped_guard(mutex, &trace_types_lock) {
+		r = sprintf(buf, "%s\n", tr->current_trace->name);
+	}
 
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
@@ -6249,15 +6213,13 @@ int tracing_update_buffers(struct trace_array *tr)
 {
 	int ret = 0;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	update_last_data(tr);
 
 	if (!tr->ring_buffer_expanded)
 		ret = __tracing_resize_ring_buffer(tr, trace_buf_size,
 						RING_BUFFER_ALL_CPUS);
-	mutex_unlock(&trace_types_lock);
-
 	return ret;
 }
 
@@ -6554,7 +6516,7 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 	if (ret)
 		return ret;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 	cpu = tracing_get_cpu(inode);
 	ret = open_pipe_on_cpu(tr, cpu);
 	if (ret)
@@ -6598,7 +6560,6 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 
 	tr->trace_ref++;
 
-	mutex_unlock(&trace_types_lock);
 	return ret;
 
 fail:
@@ -6607,7 +6568,6 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 	close_pipe_on_cpu(tr, cpu);
 fail_pipe_on_cpu:
 	__trace_array_put(tr);
-	mutex_unlock(&trace_types_lock);
 	return ret;
 }
 
@@ -6616,14 +6576,13 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
 	struct trace_iterator *iter = file->private_data;
 	struct trace_array *tr = inode->i_private;
 
-	mutex_lock(&trace_types_lock);
+	scoped_guard(mutex, &trace_types_lock) {
+		tr->trace_ref--;
 
-	tr->trace_ref--;
-
-	if (iter->trace->pipe_close)
-		iter->trace->pipe_close(iter);
-	close_pipe_on_cpu(tr, iter->cpu_file);
-	mutex_unlock(&trace_types_lock);
+		if (iter->trace->pipe_close)
+			iter->trace->pipe_close(iter);
+		close_pipe_on_cpu(tr, iter->cpu_file);
+	}
 
 	free_trace_iter_content(iter);
 	kfree(iter);
@@ -7426,7 +7385,7 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 	if (i == ARRAY_SIZE(trace_clocks))
 		return -EINVAL;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	tr->clock_id = i;
 
@@ -7450,8 +7409,6 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 		tscratch->clock_id = i;
 	}
 
-	mutex_unlock(&trace_types_lock);
-
 	return 0;
 }
 
@@ -7503,15 +7460,13 @@ static int tracing_time_stamp_mode_show(struct seq_file *m, void *v)
 {
 	struct trace_array *tr = m->private;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	if (ring_buffer_time_stamp_abs(tr->array_buffer.buffer))
 		seq_puts(m, "delta [absolute]\n");
 	else
 		seq_puts(m, "[delta] absolute\n");
 
-	mutex_unlock(&trace_types_lock);
-
 	return 0;
 }
 
@@ -8099,14 +8054,14 @@ static void clear_tracing_err_log(struct trace_array *tr)
 {
 	struct tracing_log_err *err, *next;
 
-	mutex_lock(&tracing_err_log_lock);
+	guard(mutex)(&tracing_err_log_lock);
+
 	list_for_each_entry_safe(err, next, &tr->err_log, list) {
 		list_del(&err->list);
 		free_tracing_log_err(err);
 	}
 
 	tr->n_err_log_entries = 0;
-	mutex_unlock(&tracing_err_log_lock);
 }
 
 static void *tracing_err_log_seq_start(struct seq_file *m, loff_t *pos)
@@ -8377,7 +8332,7 @@ static int tracing_buffers_release(struct inode *inode, struct file *file)
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	iter->tr->trace_ref--;
 
@@ -8388,8 +8343,6 @@ static int tracing_buffers_release(struct inode *inode, struct file *file)
 					   info->spare_cpu, info->spare);
 	kvfree(info);
 
-	mutex_unlock(&trace_types_lock);
-
 	return 0;
 }
 
@@ -8597,14 +8550,13 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 	 * An ioctl call with cmd 0 to the ring buffer file will wake up all
 	 * waiters
 	 */
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	/* Make sure the waiters see the new wait_index */
 	(void)atomic_fetch_inc_release(&iter->wait_index);
 
 	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);
 
-	mutex_unlock(&trace_types_lock);
 	return 0;
 }
 
@@ -9094,10 +9046,9 @@ trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		return -EINVAL;
 
 	if (!!(topt->flags->val & topt->opt->bit) != val) {
-		mutex_lock(&trace_types_lock);
+		guard(mutex)(&trace_types_lock);
 		ret = __set_tracer_option(topt->tr, topt->flags,
 					  topt->opt, !val);
-		mutex_unlock(&trace_types_lock);
 		if (ret)
 			return ret;
 	}
@@ -9406,7 +9357,7 @@ rb_simple_write(struct file *filp, const char __user *ubuf,
 		return ret;
 
 	if (buffer) {
-		mutex_lock(&trace_types_lock);
+		guard(mutex)(&trace_types_lock);
 		if (!!val == tracer_tracing_is_on(tr)) {
 			val = 0; /* do nothing */
 		} else if (val) {
@@ -9420,7 +9371,6 @@ rb_simple_write(struct file *filp, const char __user *ubuf,
 			/* Wake up any waiters */
 			ring_buffer_wake_waiters(buffer, RING_BUFFER_ALL_CPUS);
 		}
-		mutex_unlock(&trace_types_lock);
 	}
 
 	(*ppos)++;
@@ -9804,10 +9754,9 @@ static void __update_tracer_options(struct trace_array *tr)
 
 static void update_tracer_options(struct trace_array *tr)
 {
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 	tracer_options_updated = true;
 	__update_tracer_options(tr);
-	mutex_unlock(&trace_types_lock);
 }
 
 /* Must have trace_types_lock held */
@@ -9829,11 +9778,10 @@ struct trace_array *trace_array_find_get(const char *instance)
 {
 	struct trace_array *tr;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 	tr = trace_array_find(instance);
 	if (tr)
 		tr->ref++;
-	mutex_unlock(&trace_types_lock);
 
 	return tr;
 }
-- 
2.47.2



