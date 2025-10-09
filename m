Return-Path: <linux-kernel+bounces-847085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB46BC9D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2B51A60788
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D457214813;
	Thu,  9 Oct 2025 15:40:10 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47792144CF
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024409; cv=none; b=KnXcJQh3hPekbZTVTTteW+zPHEaXsFu9aCQPq0agVSNtn7GawlTYUf++kH+hj/t0264/GbIkrDtAjBY+dXvc2z4K2F4CjFw1MvfeCjujU7QxTOD01T047ePgkY+txkcB/t/s0k1pzf+PWzlPH69G049mnvSYyHJqYuNGwdbQVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024409; c=relaxed/simple;
	bh=6P2/cn79FAUI6FbbXpn+78dQjWtzdMcMHI6SwK+depo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=W9HInFaYsJ/OTnSZwIxFK6bR5KJKZAAlCQwtEpy5TE8ZpQwFTtvo1i0acZTPG1uYg0b4xdE62bQ9ITfcDXiutac4BwH3MjPFr7DgyaNBpJqeP0JOk2o2mFivIeM/JmybdUg3RY+7VyVRcMrR+x01iDga5zfo+P4Xiv99sTwsQgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 64A1A46679;
	Thu,  9 Oct 2025 15:40:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 94E0A20029;
	Thu,  9 Oct 2025 15:40:01 +0000 (UTC)
Date: Thu, 9 Oct 2025 11:40:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>, Thorsten Blum
 <thorsten.blum@linux.dev>
Subject: [GIT PULL] tracing: Clean up and fixes for v6.18
Message-ID: <20251009114001.30ae38bb@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4yjmjddeih4359m8sqpgwa795t5b5mnp
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 94E0A20029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+KVirvRQu64n1ijQOmuYbHpJ3IBTDH58o=
X-HE-Tag: 1760024401-343085
X-HE-Meta: U2FsdGVkX19HzI79jYCQgHq0Y8Hx8Gyu1OtI5+nrTJ2OTxQ4bIuhmWJNP8NZkLIXdLZ6DLc0zksRB4fw09UV0wNSzlUUhs6THJu49k7UiXdJYVdwZ0AjrHjTcjgEwzpwVLYds2b1GxkbaD6EdgUkA6ZXG1vo9Ls1b6OH4Ndo6KOah0rfXW5uBzk/aQuXAH91WVhIrSXxoHYYUEIsMf8b5pXM3Y+j5Uk3+gnc1oIAblIYPNUYhNvmEebhiXEO9EXo+k2fVOXnY14Dmmzm03/+lnNHhTasQuRPWIiTdaN4fSppXPtivqB9gEbTgVu4F5EGrixJrhnY63aO1dzAnotQ5kqzsxtInA6y


Linus,

tracing clean up and fixes for v6.18:

- Have osnoise tracer use memdup_user_nul()

  The function osnoise_cpus_write() open codes a kmalloc() and then
  a copy_from_user() and then adds a nul byte at the end which is the
  same as simply using memdup_user_nul().

- Fix wakeup and irq tracers when failing to acquire calltime

  When the wakeup and irq tracers use the function graph tracer for
  tracing function times, it saves a timestamp into the fgraph shadow
  stack. It is possible that this could fail to be stored. If that
  happens, it exits the routine early. These functions also disable
  nesting of the operations by incremeting the data "disable" counter.
  But if the calltime exits out early, it never increments the counter
  back to what it needs to be.

  Since there's only a couple of lines of code that does work after
  acquiring the calltime, instead of exiting out early, reverse the
  if statement to be true if calltime is acquired, and place the code
  that is to be done within that if block. The clean up will always
  be done after that.

- Fix ring_buffer_map() return value on failure of __rb_map_vma()

  If __rb_map_vma() fails in ring_buffer_map(), it does not return
  an error. This means the caller will be working against a bad vma
  mapping. Have ring_buffer_map() return an error when __rb_map_vma()
  fails.

- Fix regression of writing to the trace_marker file

  A bug fix was made to change __copy_from_user_inatomic() to
  copy_from_user_nofault() in the trace_marker write function.
  The trace_marker file is used by applications to write into
  it (usually with a file descriptor opened at the start of the
  program) to record into the tracing system. It's usually used
  in critical sections so the write to trace_marker is highly
  optimized.

  The reason for copying in an atomic section is that the write
  reserves space on the ring buffer and then writes directly into
  it. After it writes, it commits the event. The time between
  reserve and commit must have preemption disabled.

  The trace marker write does not have any locking nor can it
  allocate due to the nature of it being a critical path.

  Unfortunately, converting __copy_from_user_inatomic() to
  copy_from_user_nofault() caused a regression in Android.
  Now all the writes from its applications trigger the fault that
  is rejected by the _nofault() version that wasn't rejected by
  the _inatomic() version. Instead of getting data, it now just
  gets a trace buffer filled with:

    tracing_mark_write: <faulted>

  To fix this, on opening of the trace_marker file, allocate
  per CPU buffers that can be used by the write call. Then
  when entering the write call, do the following:

    preempt_disable();
    cpu = smp_processor_id();
    buffer = per_cpu_ptr(cpu_buffers, cpu);
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

  This works similarly to seqcount. As it must enabled preemption
  to do a copy_from_user() into a per CPU buffer, if it gets
  preempted, the buffer could be corrupted by another task.
  To handle this, read the number of context switches of the current
  CPU, disable migration, enable preemption, copy the data from
  user space, then immediately disable preemption again.
  If the number of context switches is the same, the buffer
  is still valid. Otherwise it must be assumed that the buffer may
  have been corrupted and it needs to try again.

  Now the trace_marker write can get the user data even if it has
  to fault it in, and still not grab any locks of its own.


Please pull the latest trace-v6.18-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.18-2

Tag SHA1: 887825d0040120933f92eaa638e76678ff570bc7
Head SHA1: 64cf7d058a005c5c31eb8a0b741f35dc12915d18


Ankit Khushwaha (1):
      ring buffer: Propagate __rb_map_vma return value to caller

Steven Rostedt (3):
      tracing: Fix wakeup tracers on failure of acquiring calltime
      tracing: Fix irqoff tracers on failure of acquiring calltime
      tracing: Have trace_marker use per-cpu data to read user space

Thorsten Blum (1):
      tracing/osnoise: Replace kmalloc + copy_from_user with memdup_user_nul

----
 kernel/trace/ring_buffer.c        |   2 +-
 kernel/trace/trace.c              | 268 +++++++++++++++++++++++++++++++-------
 kernel/trace/trace_irqsoff.c      |  23 ++--
 kernel/trace/trace_osnoise.c      |  11 +-
 kernel/trace/trace_sched_wakeup.c |  16 +--
 5 files changed, 241 insertions(+), 79 deletions(-)
---------------------------
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 43460949ad3f..1244d2c5c384 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7273,7 +7273,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		atomic_dec(&cpu_buffer->resize_disabled);
 	}
 
-	return 0;
+	return err;
 }
 
 int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
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
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 5496758b6c76..4c45c49b06c8 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -184,7 +184,7 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
 	unsigned long flags;
 	unsigned int trace_ctx;
 	u64 *calltime;
-	int ret;
+	int ret = 0;
 
 	if (ftrace_graph_ignore_func(gops, trace))
 		return 0;
@@ -202,13 +202,11 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
 		return 0;
 
 	calltime = fgraph_reserve_data(gops->idx, sizeof(*calltime));
-	if (!calltime)
-		return 0;
-
-	*calltime = trace_clock_local();
-
-	trace_ctx = tracing_gen_ctx_flags(flags);
-	ret = __trace_graph_entry(tr, trace, trace_ctx);
+	if (calltime) {
+		*calltime = trace_clock_local();
+		trace_ctx = tracing_gen_ctx_flags(flags);
+		ret = __trace_graph_entry(tr, trace, trace_ctx);
+	}
 	local_dec(&data->disabled);
 
 	return ret;
@@ -233,11 +231,10 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
 
 	rettime = trace_clock_local();
 	calltime = fgraph_retrieve_data(gops->idx, &size);
-	if (!calltime)
-		return;
-
-	trace_ctx = tracing_gen_ctx_flags(flags);
-	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
+	if (calltime) {
+		trace_ctx = tracing_gen_ctx_flags(flags);
+		__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
+	}
 	local_dec(&data->disabled);
 }
 
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index dc734867f0fc..26d0c99125f5 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -24,6 +24,7 @@
 #include <linux/sched/clock.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/sched.h>
+#include <linux/string.h>
 #include "trace.h"
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -2325,13 +2326,9 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	if (count < 1)
 		return 0;
 
-	buf = kmalloc(count + 1, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (copy_from_user(buf, ubuf, count))
-		return -EFAULT;
-	buf[count] = '\0';
+	buf = memdup_user_nul(ubuf, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	if (!zalloc_cpumask_var(&osnoise_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index bf1cb80742ae..e3f2e4f56faa 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -138,12 +138,10 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
 		return 0;
 
 	calltime = fgraph_reserve_data(gops->idx, sizeof(*calltime));
-	if (!calltime)
-		return 0;
-
-	*calltime = trace_clock_local();
-
-	ret = __trace_graph_entry(tr, trace, trace_ctx);
+	if (calltime) {
+		*calltime = trace_clock_local();
+		ret = __trace_graph_entry(tr, trace, trace_ctx);
+	}
 	local_dec(&data->disabled);
 	preempt_enable_notrace();
 
@@ -169,12 +167,10 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace,
 	rettime = trace_clock_local();
 
 	calltime = fgraph_retrieve_data(gops->idx, &size);
-	if (!calltime)
-		return;
+	if (calltime)
+		__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
 
-	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
 	local_dec(&data->disabled);
-
 	preempt_enable_notrace();
 	return;
 }

