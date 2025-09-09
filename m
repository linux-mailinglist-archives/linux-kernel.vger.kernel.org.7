Return-Path: <linux-kernel+bounces-808963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 735EFB506E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD441C2281E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F443054F0;
	Tue,  9 Sep 2025 20:21:22 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D581FE44A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449281; cv=none; b=fN2Mwtec82yNgN/4GzqoX83XK9Z7ATjvDSnEJ4OZwJdtPh2xxppfHqh2mbPMGKNFDmdr11dtj+FHsF++pVXEjJJMl4o7ye120/56KvTPDqku/0BCr/YWb+U+kIapb9bI7bUz4vXDJJ9c6+L4a74l/u0V6Eq3guXGSvHpQXMYOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449281; c=relaxed/simple;
	bh=B/M5UH9SJiJn4aSOr67qjYJPA0fzRmeVBYk5T4w9MBM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AGzL3c7KfYBk+3eFDSh52lnJg3SAeYdZFm8IdGUn3zscFcswBpE77twhOZ0feviLXw2K1kKsnad0bczHH2SQxvEMbZeQoXb0ECjnww0BctihlX1fGpa1EbjHr/H0FL+DuUO+zq1NAfegjT2c4Ts3Ll2bUr2CNFn6D8nj08E0aLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id A0BCF1404C1;
	Tue,  9 Sep 2025 20:21:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 8163332;
	Tue,  9 Sep 2025 20:21:07 +0000 (UTC)
Date: Tue, 9 Sep 2025 16:21:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Guenter Roeck <linux@roeck-us.net>, Luo Gengkun
 <luogengkun@huaweicloud.com>, Pu Lehui <pulehui@huawei.com>, Qianfeng Rong
 <rongqianfeng@vivo.com>, Vladimir Riabchun <ferr.lambarginio@gmail.com>,
 Wang Liang <wangliang74@huawei.com>
Subject: [GIT PULL] tracing: Fixes for v6.17
Message-ID: <20250909162155.76756fe3@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8163332
X-Stat-Signature: 6ed81iphj3p4sq5zoh6x3x7pzog3zi4q
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/pFCtkiMlScp8QdSgap9eUBYoUUURp+/0=
X-HE-Tag: 1757449267-593935
X-HE-Meta: U2FsdGVkX192R7Z9nLYbjkTGYEO686FibHXC8V57T75Trc9sl5SL55tDVj8IXX2/Wrg/bRi/E4qFeTE0UrLK7y5YtB2cMqF2t76CotEOBVZ5R9t4JJ5O1CDoHGUVxV8DJ5bU+cQ4mb7jMeiu8hlKI6oPlFEGaQC4ktR0gO5gfZcZbS/Mm22VGY6qRnnZgWpR7Wr22IWVffSz2De+zayKfdBJP5hg4X/5oV/hStvPPQgkvLhKsie8yuPGbQvC8m2p5kxGkNlGr0aUQd0iUx66hB64Ce07x2d6lVXIc/KBiVL2WeAMsYRNHRh8szYUAGQtZ3tlyIuyeQUC7BSkDNh7rIPmQrFtnqWWMTAnOAsavA2oE7uXZ0HZWoqkYxowRImindyu4MWkzD9EfLLMOKgJdJRLGCsLZa54ch/h/BTHWtxYldJP2p4R0Edsr0laUma9zqNKHs4RO7S/DrLk8gWfBx89mjIPy58Va2Fd9C3Wazp40BYwTZyZCQ==

Guenter Roeck <linux@roeck-us.net>, Luo Gengkun <luogengkun@huaweicloud.com>, Pu Lehui <pulehui@huawei.com>, Qianfeng Rong <rongqianfeng@vivo.com>, Vladimir Riabchun <ferr.lambarginio@gmail.com>, Wang Liang <wangliang74@huawei.com>

Linus,

Tracing fixes for v6.17:

- Remove redundant __GFP_NOWARN flag is kmalloc

  As now __GFP_NOWARN is part of __GFP_NOWAIT, it can be removed from kmalloc
  as it is redundant.

- Use copy_from_user_nofault() instead of _inatomic() for trace markers

  The trace_marker files are written to to allow user space to quickly write
  into the tracing ring buffer. Back in 2016, the get_user_pages_fast() and
  the kmap() logic was replaced by a __copy_from_user_inatomic(). But the
  _inatomic() is somewhat a misnomer, as if the data being read faults, it can
  cause a schedule. This is not something you want to do in an atomic context.
  Since the time this was added, copy_from_user_nofault() was added which is
  what is actually needed here. Replace the inatomic() with the nofault().

- Fix the assembly markup in the ftrace direct sample code

  The ftrace direct sample code (which is also used for selftests), had the
  size directive between the "leave" and the "ret" instead of after the ret.
  This caused objtool to think the code was unreachable.

- Only call unregister_pm_notifier() on outer most fgraph registration

  There was an error path in register_ftrace_graph() that did not call
  unregister_pm_notifier() on error, so it was added in the error path.
  The problem with that fix, is that register_pm_notifier() is only called by
  the initial user of fgraph. If that succeeds, but another fgraph
  registration were to fail, then unregister_pm_notifier() would be called
  incorrectly.

- Fix a crash in osnoise when zero size cpumask is passed in

  If a zero size CPU mask is passed in, the kmalloc() would return
  ZERO_SIZE_PTR which is not checked, and the code would continue thinking it
  had real memory and crash. If zero is passed in as the size of the write,
  simply return 0.

- Fix possible warning in trace_pid_write()

  If while processing a series of numbers passed to the "set_event_pid" file,
  and one of the updates fails to allocate (triggered by a fault injection),
  it can cause a warning to trigger. Check the return value of the call to
  trace_pid_list_set() and break out early with an error code if it fails.


Please pull the latest trace-v6.17-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.17-rc4

Tag SHA1: ff84e946ad59a3b7f3254d667aa7f47bf21246a0
Head SHA1: cd4453c5e983cf1fd5757e9acb915adb1e4602b6


Guenter Roeck (1):
      trace/fgraph: Fix error handling

Luo Gengkun (1):
      tracing: Fix tracing_marker may trigger page fault during preempt_disable

Pu Lehui (1):
      tracing: Silence warning when chunk allocation fails in trace_pid_write

Qianfeng Rong (1):
      trace: Remove redundant __GFP_NOWARN

Vladimir Riabchun (1):
      ftrace/samples: Fix function size computation

Wang Liang (1):
      tracing/osnoise: Fix null-ptr-deref in bitmap_parselist()

----
 kernel/trace/fgraph.c                 |  3 ++-
 kernel/trace/trace.c                  | 10 +++++++---
 kernel/trace/trace_events_user.c      |  2 +-
 kernel/trace/trace_osnoise.c          |  3 +++
 samples/ftrace/ftrace-direct-modify.c |  2 +-
 5 files changed, 14 insertions(+), 6 deletions(-)
---------------------------
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 2a42c1036ea8..1e3b32b1e82c 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1397,7 +1397,8 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_active--;
 		gops->saved_func = NULL;
 		fgraph_lru_release_index(i);
-		unregister_pm_notifier(&ftrace_suspend_notifier);
+		if (!ftrace_graph_active)
+			unregister_pm_notifier(&ftrace_suspend_notifier);
 	}
 	return ret;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1b7db732c0b1..b3c94fbaf002 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -834,7 +834,10 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		/* copy the current bits to the new max */
 		ret = trace_pid_list_first(filtered_pids, &pid);
 		while (!ret) {
-			trace_pid_list_set(pid_list, pid);
+			ret = trace_pid_list_set(pid_list, pid);
+			if (ret < 0)
+				goto out;
+
 			ret = trace_pid_list_next(filtered_pids, pid + 1, &pid);
 			nr_pids++;
 		}
@@ -871,6 +874,7 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		trace_parser_clear(&parser);
 		ret = 0;
 	}
+ out:
 	trace_parser_put(&parser);
 
 	if (ret < 0) {
@@ -7209,7 +7213,7 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 	entry = ring_buffer_event_data(event);
 	entry->ip = ip;
 
-	len = __copy_from_user_inatomic(&entry->buf, ubuf, cnt);
+	len = copy_from_user_nofault(&entry->buf, ubuf, cnt);
 	if (len) {
 		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
 		cnt = FAULTED_SIZE;
@@ -7306,7 +7310,7 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 
 	entry = ring_buffer_event_data(event);
 
-	len = __copy_from_user_inatomic(&entry->id, ubuf, cnt);
+	len = copy_from_user_nofault(&entry->id, ubuf, cnt);
 	if (len) {
 		entry->id = -1;
 		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index af42aaa3d172..2ab283fd3032 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -496,7 +496,7 @@ static bool user_event_enabler_queue_fault(struct user_event_mm *mm,
 {
 	struct user_event_enabler_fault *fault;
 
-	fault = kmem_cache_zalloc(fault_cache, GFP_NOWAIT | __GFP_NOWARN);
+	fault = kmem_cache_zalloc(fault_cache, GFP_NOWAIT);
 
 	if (!fault)
 		return false;
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index fd259da0aa64..337bc0eb5d71 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2322,6 +2322,9 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	int running, err;
 	char *buf __free(kfree) = NULL;
 
+	if (count < 1)
+		return 0;
+
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index cfea7a38befb..da3a9f2091f5 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -75,8 +75,8 @@ asm (
 	CALL_DEPTH_ACCOUNT
 "	call my_direct_func1\n"
 "	leave\n"
-"	.size		my_tramp1, .-my_tramp1\n"
 	ASM_RET
+"	.size		my_tramp1, .-my_tramp1\n"
 
 "	.type		my_tramp2, @function\n"
 "	.globl		my_tramp2\n"

