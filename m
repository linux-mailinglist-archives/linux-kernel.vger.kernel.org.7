Return-Path: <linux-kernel+bounces-845771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC80BC6100
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0993F403A25
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1E92BE7AF;
	Wed,  8 Oct 2025 16:43:23 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9541228FFF6;
	Wed,  8 Oct 2025 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941803; cv=none; b=UAwPNKZlxFToCREeaRtmHwukwXs8lBIb4puElREVVFBZmqnxW6fTXiUVe4zu1VjY43yu9ZKFxNmSpYeMuHQZ2T2+YsT6P1QHrLiKRwMzd2KaEpVQbLxGk65MN/d4xxQnL6lwR9GUyBHTkS+Mr+boSJN0UVUlkuplInq/JB4DEpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941803; c=relaxed/simple;
	bh=gLmh2aSaxjnnQePYcPxSGkjcH8tlac8SA/LAD127HeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hL664qpYDbA9E+P5GPho16l9UbKuk+I0MBY53XhSxf/tOlezePGhROQUQkyLUKqOT628qb1YHM3IMus7MR+35t3lvTeUJv/N/be41kiDaM2UfqeyVJ1EU2D4dCyUUGHioFqtDwX5In5dTS3d/VuXFFdXl8oOd4rur4/jzwR4Jnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id BC41588002;
	Wed,  8 Oct 2025 16:43:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id BB8EF31;
	Wed,  8 Oct 2025 16:43:16 +0000 (UTC)
Date: Wed, 8 Oct 2025 12:45:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Runping Lai <runpinglai@google.com>, Luo
 Gengkun <luogengkun@huaweicloud.com>, Wattson CI
 <wattson-external@google.com>, kernel-team@android.com, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: [PATCH] tracing: Have trace_marker use per-cpu data to read user
 space
Message-ID: <20251008124510.6dba541a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ee8g3ofs4rg9zxd1ntii3cjo3m31wfa4
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: BB8EF31
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19xSVCS8cXzRf2SzX4rRKaRLZ/2/lhwQ5Q=
X-HE-Tag: 1759941796-431918
X-HE-Meta: U2FsdGVkX18OW2V6hH0U+K6uMVN5urPuPJU0gSChmRaf8lOpJSSZoOgWQRGl1VyCBO8yTlBoclrMgRA3HHh8qlqdvHAf88txIkKA0dGSYxy05FsVh/MWYKZxV7VNONdR//VMpmGIthk66Fb8kfJzogkVZITi9+ZCJbaNpSAzD/r1+nhPsa/NmizAhEQ5o+VJimd3pXyaobuITx+EZx94yUtOQQuFu1CXeU9Zvv/9L/W8v0aJsob9cLGiNc92qxBHz+/5bfDTOc2WPIwoOpxVme8ofG/Nvbnc0iPTdUcabcIjB0bqQvriOGI1RjUL9PLdGokpZ63U9eyqCHph/z2SIQyzoKxRg50m49Ajw8Y3qgnuvB3tZweDqLicmQS0+CLJ3swSX+E2RUuXF5KOjALxAGIgoaWkPkDzu2n7+hcfHd5nm5AFNbztN4HzCTAoFpucMttKNzhmEHE=

From: Steven Rostedt <rostedt@goodmis.org>

It was reported that using __copy_from_user_inatomic() can actually
schedule. Which is bad when preemption is disabled. Even though there's
logic to check in_atomic() is set, but this is a nop when the kernel is
configured with PREEMPT_NONE. This is due to page faulting and the code
could schedule with preemption disabled.

Link: https://lore.kernel.org/all/20250819105152.2766363-1-luogengkun@huaweicloud.com/

The solution was to change the __copy_from_user_inatomic() to
copy_from_user_nofault(). But then it was reported that this caused a
regression in Android. There's several applications writing into
trace_marker() in Android, but now instead of showing the expected data,
it is showing:

  tracing_mark_write: <faulted>

After reverting the conversion to copy_from_user_nofault(), Android was
able to get the data again.

Writes to the trace_marker is a way to efficiently and quickly enter data
into the Linux tracing buffer. It takes no locks and was designed to be as
non-intrusive as possible. This means it cannot allocate memory, and must
use pre-allocated data.

A method that is actively being worked on to have faultable system call
tracepoints read user space data is to allocate per CPU buffers, and use
them in the callback. The method uses a technique similar to seqcount.
That is something like this:

	preempt_disable();
	cpu = smp_processor_id();
	buffer = this_cpu_ptr(&pre_allocated_cpu_buffers, cpu);
	do {
		cnt = nr_context_switches_cpu(cpu);
		migrate_disable();
		preempt_enable();
		ret = copy_from_user(buffer, ptr, size);
		preempt_disable();
		migrate_enable();
	} while (!ret && cnt != nr_context_switches_cpu(cpu));

	if (!ret)
		ring_buffer_write(buffer);
	preempt_enable();

It's a little more involved than that, but the above is the basic logic.
The idea is to acquire the current CPU buffer, disable migration, and then
enable preemption. At this moment, it can safely use copy_from_user().
After reading the data from user space, it disables preemption again. It
then checks to see if there was any new scheduling on this CPU. If there
was, it must assume that the buffer was corrupted by another task. If
there wasn't, then the buffer is still valid as only tasks in preemptable
context can write to this buffer and only those that are running on the
CPU.

By using this method, where trace_marker open allocates the per CPU
buffers, trace_marker writes can access user space and even fault it in,
without having to allocate or take any locks of its own.

Cc: stable@vger.kernel.org
Fixes: 3d62ab32df065 ("tracing: Fix tracing_marker may trigger page fault during preempt_disable")
Reported-by: Runping Lai <runpinglai@google.com>
Tested-by: Runping Lai <runpinglai@google.com>
Closes: https://lore.kernel.org/linux-trace-kernel/20251007003417.3470979-2-runpinglai@google.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 268 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 220 insertions(+), 48 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b3c94fbaf002..0fd582651293 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4791,12 +4791,6 @@ int tracing_single_release_file_tr(struct inode *inode, struct file *filp)
 	return single_release(inode, filp);
 }
 
-static int tracing_mark_open(struct inode *inode, struct file *filp)
-{
-	stream_open(inode, filp);
-	return tracing_open_generic_tr(inode, filp);
-}
-
 static int tracing_release(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
@@ -7163,7 +7157,7 @@ tracing_free_buffer_release(struct inode *inode, struct file *filp)
 
 #define TRACE_MARKER_MAX_SIZE		4096
 
-static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user *ubuf,
+static ssize_t write_marker_to_buffer(struct trace_array *tr, const char *buf,
 				      size_t cnt, unsigned long ip)
 {
 	struct ring_buffer_event *event;
@@ -7173,20 +7167,11 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 	int meta_size;
 	ssize_t written;
 	size_t size;
-	int len;
-
-/* Used in tracing_mark_raw_write() as well */
-#define FAULTED_STR "<faulted>"
-#define FAULTED_SIZE (sizeof(FAULTED_STR) - 1) /* '\0' is already accounted for */
 
 	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
  again:
 	size = cnt + meta_size;
 
-	/* If less than "<faulted>", then make sure we can still add that */
-	if (cnt < FAULTED_SIZE)
-		size += FAULTED_SIZE - cnt;
-
 	buffer = tr->array_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
 					    tracing_gen_ctx());
@@ -7196,9 +7181,6 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 		 * make it smaller and try again.
 		 */
 		if (size > ring_buffer_max_event_size(buffer)) {
-			/* cnt < FAULTED size should never be bigger than max */
-			if (WARN_ON_ONCE(cnt < FAULTED_SIZE))
-				return -EBADF;
 			cnt = ring_buffer_max_event_size(buffer) - meta_size;
 			/* The above should only happen once */
 			if (WARN_ON_ONCE(cnt + meta_size == size))
@@ -7212,14 +7194,8 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 
 	entry = ring_buffer_event_data(event);
 	entry->ip = ip;
-
-	len = copy_from_user_nofault(&entry->buf, ubuf, cnt);
-	if (len) {
-		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
-		cnt = FAULTED_SIZE;
-		written = -EFAULT;
-	} else
-		written = cnt;
+	memcpy(&entry->buf, buf, cnt);
+	written = cnt;
 
 	if (tr->trace_marker_file && !list_empty(&tr->trace_marker_file->triggers)) {
 		/* do not add \n before testing triggers, but add \0 */
@@ -7243,6 +7219,169 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 	return written;
 }
 
+struct trace_user_buf {
+	char		*buf;
+};
+
+struct trace_user_buf_info {
+	struct trace_user_buf __percpu	*tbuf;
+	int				ref;
+};
+
+
+static DEFINE_MUTEX(trace_user_buffer_mutex);
+static struct trace_user_buf_info *trace_user_buffer;
+
+static void trace_user_fault_buffer_free(struct trace_user_buf_info *tinfo)
+{
+	char *buf;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		buf = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
+		kfree(buf);
+	}
+	free_percpu(tinfo->tbuf);
+	kfree(tinfo);
+}
+
+static int trace_user_fault_buffer_enable(void)
+{
+	struct trace_user_buf_info *tinfo;
+	char *buf;
+	int cpu;
+
+	guard(mutex)(&trace_user_buffer_mutex);
+
+	if (trace_user_buffer) {
+		trace_user_buffer->ref++;
+		return 0;
+	}
+
+	tinfo = kmalloc(sizeof(*tinfo), GFP_KERNEL);
+	if (!tinfo)
+		return -ENOMEM;
+
+	tinfo->tbuf = alloc_percpu(struct trace_user_buf);
+	if (!tinfo->tbuf) {
+		kfree(tinfo);
+		return -ENOMEM;
+	}
+
+	tinfo->ref = 1;
+
+	/* Clear each buffer in case of error */
+	for_each_possible_cpu(cpu) {
+		per_cpu_ptr(tinfo->tbuf, cpu)->buf = NULL;
+	}
+
+	for_each_possible_cpu(cpu) {
+		buf = kmalloc_node(TRACE_MARKER_MAX_SIZE, GFP_KERNEL,
+				   cpu_to_node(cpu));
+		if (!buf) {
+			trace_user_fault_buffer_free(tinfo);
+			return -ENOMEM;
+		}
+		per_cpu_ptr(tinfo->tbuf, cpu)->buf = buf;
+	}
+
+	trace_user_buffer = tinfo;
+
+	return 0;
+}
+
+static void trace_user_fault_buffer_disable(void)
+{
+	struct trace_user_buf_info *tinfo;
+
+	guard(mutex)(&trace_user_buffer_mutex);
+
+	tinfo = trace_user_buffer;
+
+	if (WARN_ON_ONCE(!tinfo))
+		return;
+
+	if (--tinfo->ref)
+		return;
+
+	trace_user_fault_buffer_free(tinfo);
+	trace_user_buffer = NULL;
+}
+
+/* Must be called with preemption disabled */
+static char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
+				   const char __user *ptr, size_t size,
+				   size_t *read_size)
+{
+	int cpu = smp_processor_id();
+	char *buffer = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
+	unsigned int cnt;
+	int trys = 0;
+	int ret;
+
+	if (size > TRACE_MARKER_MAX_SIZE)
+		size = TRACE_MARKER_MAX_SIZE;
+	*read_size = 0;
+
+	/*
+	 * This acts similar to a seqcount. The per CPU context switches are
+	 * recorded, migration is disabled and preemption is enabled. The
+	 * read of the user space memory is copied into the per CPU buffer.
+	 * Preemption is disabled again, and if the per CPU context switches count
+	 * is still the same, it means the buffer has not been corrupted.
+	 * If the count is different, it is assumed the buffer is corrupted
+	 * and reading must be tried again.
+	 */
+
+	do {
+		/*
+		 * If for some reason, copy_from_user() always causes a context
+		 * switch, this would then cause an infinite loop.
+		 * If this task is preempted by another user space task, it
+		 * will cause this task to try again. But just in case something
+		 * changes where the copying from user space causes another task
+		 * to run, prevent this from going into an infinite loop.
+		 * 100 tries should be plenty.
+		 */
+		if (WARN_ONCE(trys++ > 100, "Error: Too many tries to read user space"))
+			return NULL;
+
+		/* Read the current CPU context switch counter */
+		cnt = nr_context_switches_cpu(cpu);
+
+		/*
+		 * Preemption is going to be enabled, but this task must
+		 * remain on this CPU.
+		 */
+		migrate_disable();
+
+		/*
+		 * Now preemption is being enabed and another task can come in
+		 * and use the same buffer and corrupt our data.
+		 */
+		preempt_enable_notrace();
+
+		ret = __copy_from_user(buffer, ptr, size);
+
+		preempt_disable_notrace();
+		migrate_enable();
+
+		/* if it faulted, no need to test if the buffer was corrupted */
+		if (ret)
+			return NULL;
+
+		/*
+		 * Preemption is disabled again, now check the per CPU context
+		 * switch counter. If it doesn't match, then another user space
+		 * process may have schedule in and corrupted our buffer. In that
+		 * case the copying must be retried.
+		 */
+	} while (nr_context_switches_cpu(cpu) != cnt);
+
+	*read_size = size;
+	return buffer;
+}
+
 static ssize_t
 tracing_mark_write(struct file *filp, const char __user *ubuf,
 					size_t cnt, loff_t *fpos)
@@ -7250,6 +7389,8 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	struct trace_array *tr = filp->private_data;
 	ssize_t written = -ENODEV;
 	unsigned long ip;
+	size_t size;
+	char *buf;
 
 	if (tracing_disabled)
 		return -EINVAL;
@@ -7263,6 +7404,16 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (cnt > TRACE_MARKER_MAX_SIZE)
 		cnt = TRACE_MARKER_MAX_SIZE;
 
+	/* Must have preemption disabled while having access to the buffer */
+	guard(preempt_notrace)();
+
+	buf = trace_user_fault_read(trace_user_buffer, ubuf, cnt, &size);
+	if (!buf)
+		return -EFAULT;
+
+	if (cnt > size)
+		cnt = size;
+
 	/* The selftests expect this function to be the IP address */
 	ip = _THIS_IP_;
 
@@ -7270,32 +7421,27 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (tr == &global_trace) {
 		guard(rcu)();
 		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
-			written = write_marker_to_buffer(tr, ubuf, cnt, ip);
+			written = write_marker_to_buffer(tr, buf, cnt, ip);
 			if (written < 0)
 				break;
 		}
 	} else {
-		written = write_marker_to_buffer(tr, ubuf, cnt, ip);
+		written = write_marker_to_buffer(tr, buf, cnt, ip);
 	}
 
 	return written;
 }
 
 static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
-					  const char __user *ubuf, size_t cnt)
+					  const char *buf, size_t cnt)
 {
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
 	struct raw_data_entry *entry;
 	ssize_t written;
-	int size;
-	int len;
-
-#define FAULT_SIZE_ID (FAULTED_SIZE + sizeof(int))
+	size_t size;
 
 	size = sizeof(*entry) + cnt;
-	if (cnt < FAULT_SIZE_ID)
-		size += FAULT_SIZE_ID - cnt;
 
 	buffer = tr->array_buffer.buffer;
 
@@ -7309,14 +7455,8 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 		return -EBADF;
 
 	entry = ring_buffer_event_data(event);
-
-	len = copy_from_user_nofault(&entry->id, ubuf, cnt);
-	if (len) {
-		entry->id = -1;
-		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
-		written = -EFAULT;
-	} else
-		written = cnt;
+	memcpy(&entry->id, buf, cnt);
+	written = cnt;
 
 	__buffer_unlock_commit(buffer, event);
 
@@ -7329,8 +7469,8 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 {
 	struct trace_array *tr = filp->private_data;
 	ssize_t written = -ENODEV;
-
-#define FAULT_SIZE_ID (FAULTED_SIZE + sizeof(int))
+	size_t size;
+	char *buf;
 
 	if (tracing_disabled)
 		return -EINVAL;
@@ -7342,6 +7482,17 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	if (cnt < sizeof(unsigned int))
 		return -EINVAL;
 
+	/* Must have preemption disabled while having access to the buffer */
+	guard(preempt_notrace)();
+
+	buf = trace_user_fault_read(trace_user_buffer, ubuf, cnt, &size);
+	if (!buf)
+		return -EFAULT;
+
+	/* raw write is all or nothing */
+	if (cnt > size)
+		return -EINVAL;
+
 	/* The global trace_marker_raw can go to multiple instances */
 	if (tr == &global_trace) {
 		guard(rcu)();
@@ -7357,6 +7508,27 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	return written;
 }
 
+static int tracing_mark_open(struct inode *inode, struct file *filp)
+{
+	int ret;
+
+	ret = trace_user_fault_buffer_enable();
+	if (ret < 0)
+		return ret;
+
+	stream_open(inode, filp);
+	ret = tracing_open_generic_tr(inode, filp);
+	if (ret < 0)
+		trace_user_fault_buffer_disable();
+	return ret;
+}
+
+static int tracing_mark_release(struct inode *inode, struct file *file)
+{
+	trace_user_fault_buffer_disable();
+	return tracing_release_generic_tr(inode, file);
+}
+
 static int tracing_clock_show(struct seq_file *m, void *v)
 {
 	struct trace_array *tr = m->private;
@@ -7764,13 +7936,13 @@ static const struct file_operations tracing_free_buffer_fops = {
 static const struct file_operations tracing_mark_fops = {
 	.open		= tracing_mark_open,
 	.write		= tracing_mark_write,
-	.release	= tracing_release_generic_tr,
+	.release	= tracing_mark_release,
 };
 
 static const struct file_operations tracing_mark_raw_fops = {
 	.open		= tracing_mark_open,
 	.write		= tracing_mark_raw_write,
-	.release	= tracing_release_generic_tr,
+	.release	= tracing_mark_release,
 };
 
 static const struct file_operations trace_clock_fops = {
-- 
2.51.0


