Return-Path: <linux-kernel+bounces-841506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55164BB78C0
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EDC19E886A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60E82C08BB;
	Fri,  3 Oct 2025 16:27:49 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CD2C08B1
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508868; cv=none; b=WbP3TP5u9LNDFcFIqvBP9sGwXzHzKA6UW11uIFNaR8YbonOlTZPgO/TQFiaDTPWyIZ7NAysm3H81hPatFaHmNCZ1fvpcxM7hUj9bxNgVdmfIosvEaC7jhWL0ge7GU9QYOxdV40pR2S8/rBEKBNobepeskstbZOnpBXu/DsF8L3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508868; c=relaxed/simple;
	bh=LptIEecUswlbf9DR4ahmfHvYTHa+BrPuy4RbuH+ZHjI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uhi+17V9WQQg0JZ5qvcxMssLSaAOkKsrvJcmSx+mtjhJT+cenUcWCUint7mh5bENyWXWXYVPhsDcp5urkZd0Op4SeiUjfydxue6ANvkcLAX2o1PmuNesA9sWeoxsX7WoeCyvnLEOXD+b2imsi2dkYRZZWvo3zlV6701RvERqG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id CA56EC0830;
	Fri,  3 Oct 2025 16:27:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id C39FD20032;
	Fri,  3 Oct 2025 16:27:40 +0000 (UTC)
Date: Fri, 3 Oct 2025 12:29:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Elijah Wright <git@elijahs.space>, Fushuai
 Wang <wangfushuai@baidu.com>, Liao Yuanhong <liaoyuanhong@vivo.com>, Marco
 Crivellari <marco.crivellari@suse.com>, Michal =?UTF-8?B?S291dG7DvQ==?=
 <mkoutny@suse.com>, Qianfeng Rong <rongqianfeng@vivo.com>, Sasha Levin
 <sashal@kernel.org>, Vladimir Riabchun <ferr.lambarginio@gmail.com>
Subject: [GIT PULL] tracing: Updates for v6.18
Message-ID: <20251003122923.0cf11def@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: C39FD20032
X-Stat-Signature: 1ueokcrdt4i1wsentr1r74feaux1m59z
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18uo1tslUfPG9Lk/rIGCvpfqUYb3f8cyUY=
X-HE-Tag: 1759508860-527404
X-HE-Meta: U2FsdGVkX1+9iH/cci7ikpbZuSjVHZz0UJ6DpD583g+G9soyMDJSWnUSOZZhkdiLM9pcZZJwlv6wTQfGGrSP5uybjcacfdja39ik1Gu6a7OpTyKrElaNJBAtMa1wPyzvAKmoyeU6NMaF6UOpHiEfolNwIHpRj+97bgs83WY1iP900uDi0FJ6HAXGwMBs3SngIbpJir+aRCW5CRTWGv1U7p1R+9NWIOFOUP6XTps6OAbnOe0TVPt2DYNeEyYgHSijAxb2RLA3xEXexmhzjjD2h6Z5NLsaQ1nhN82S2Bc4spY0KDOJpeG4R3F7XwyPzuDg/wV01erNmaKabY/9X9KmO2+AJqI8iccM


Linus,

No new features. Just clean ups and one fix.

tracing updates for v6.18:

- Use READ_ONCE() and WRITE_ONCE() instead of RCU for syscall tracepoints

  Individual system call trace events are pseudo events attached to the
  raw_syscall trace events that just trace the entry and exit of all system
  calls. When any of these individual system call trace events get enabled,
  an element in an array indexed by the system call number is assigned to
  the trace file that defines how to trace it. When the trace event
  triggers, it reads this array and if the array has an element, it uses th=
at
  trace file to know what to write it (the trace file defines the output
  format of the corresponding system call).

  The issue is that it uses rcu_dereference_ptr() and marks the elements of
  the array as using RCU. This is incorrect. There is no RCU synchronization
  here. The event file that is pointed to has a completely different way to
  make sure it's freed properly. The reading of the array during the system
  call trace event is only to know if there is a value or not. If not, it
  does nothing (it means this system call isn't being traced). If it does,
  it uses the information to store the system call data.

  The RCU usage here can simply be replaced by READ_ONCE() and WRITE_ONCE()
  macros.

- Have the system call trace events use "0x" for hex values

  Some system call trace events display hex values but do not have "0x" in
  front of it. Seeing "count: 44" can be assumed that it is 44 decimal when
  in actuality it is 44 hex (68 decimal). Display "0x44" instead.

- Use vmalloc_array() in tracing_map_sort_entries()

  The function tracing_map_sort_entries() used array_size() and vmalloc()
  when it could have simply used vmalloc_array().

- Use for_each_online_cpu() in trace_osnoise.c()

  Instead of open coding for_each_cpu(cpu, cpu_online_mask), use
  for_each_online_cpu().

- Move the buffer field in struct trace_seq to the end

  The buffer field in struct trace_seq is architecture dependent in size,
  and caused padding for the fields after it. By moving the buffer to the
  end of the structure, it compacts the trace_seq structure better.

- Remove redundant zeroing of cmdline_idx field in saved_cmdlines_buffer()

  The structure that contains cmdline_idx is zeroed by memset(), no need to
  explicitly zero any of its fields after that.

- Use system_percpu_wq instead of system_wq in user_event_mm_remove()

  As system_wq is being deprecated, use the new wq.

- Add cond_resched() is ftrace_module_enable()

  Some modules have a lot of functions (thousands of them), and the enabling
  of those functions can take some time. On non preemtable kernels, it was
  triggering a watchdog timeout. Add a cond_resched() to prevent that.

- Add a BUILD_BUG_ON() to make sure PID_MAX_DEFAULT is always a power of 2

  There's code that depends on PID_MAX_DEFAULT being a power of 2 or it will
  break. If in the future that changes, make sure the build fails to ensure
  that the code is fixed that depends on this.

- Grab mutex_lock() before ever exiting s_start()

  The s_start() function is a seq_file start routine. As s_stop() is always
  called even if s_start() fails, and s_stop() expects the event_mutex to be
  held as it will always release it. That mutex must always be taken in
  s_start() even if that function fails.


Please pull the latest trace-v6.18 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.18

Tag SHA1: 82a729dbe4755a6982a70e980fd7beca91c19e98
Head SHA1: 61e19cd2e5c5235326a13a68df1a2f8ec4eeed7b


Elijah Wright (1):
      tracing: Move buffer in trace_seq to end of struct

Fushuai Wang (1):
      tracing/osnoise: Use for_each_online_cpu() instead of for_each_cpu()

Liao Yuanhong (1):
      tracing: Remove redundant 0 value initialization

Marco Crivellari (1):
      tracing: replace use of system_wq with system_percpu_wq

Michal Koutn=C3=BD (1):
      tracing: Ensure optimized hashing works

Qianfeng Rong (1):
      tracing: Use vmalloc_array() to improve code

Sasha Levin (1):
      tracing: Fix lock imbalance in s_start() memory allocation failure pa=
th

Steven Rostedt (2):
      tracing: Replace syscall RCU pointer assignment with READ/WRITE_ONCE()
      tracing: Have syscall trace events show "0x" for values greater than =
10

Vladimir Riabchun (1):
      ftrace: Fix softlockup in ftrace_module_enable

----
 include/linux/trace_seq.h         |  2 +-
 kernel/trace/ftrace.c             |  2 ++
 kernel/trace/trace.h              |  4 ++--
 kernel/trace/trace_events.c       |  3 +--
 kernel/trace/trace_events_user.c  |  2 +-
 kernel/trace/trace_osnoise.c      |  4 ++--
 kernel/trace/trace_sched_switch.c |  3 ++-
 kernel/trace/trace_syscalls.c     | 26 +++++++++++++++-----------
 kernel/trace/tracing_map.c        |  2 +-
 9 files changed, 27 insertions(+), 21 deletions(-)
---------------------------
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index a93ed5ac3226..557780fe1c77 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -21,10 +21,10 @@
 	(sizeof(struct seq_buf) + sizeof(size_t) + sizeof(int)))
=20
 struct trace_seq {
-	char			buffer[TRACE_SEQ_BUFFER_SIZE];
 	struct seq_buf		seq;
 	size_t			readpos;
 	int			full;
+	char                    buffer[TRACE_SEQ_BUFFER_SIZE];
 };
=20
 static inline void
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a69067367c29..42bd2ba68a82 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7535,6 +7535,8 @@ void ftrace_module_enable(struct module *mod)
 		if (!within_module(rec->ip, mod))
 			break;
=20
+		cond_resched();
+
 		/* Weak functions should still be ignored */
 		if (!test_for_valid_rec(rec)) {
 			/* Clear all other flags. Should not be enabled anyway */
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5f4bed5842f9..85eabb454bee 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -380,8 +380,8 @@ struct trace_array {
 #ifdef CONFIG_FTRACE_SYSCALLS
 	int			sys_refcount_enter;
 	int			sys_refcount_exit;
-	struct trace_event_file __rcu *enter_syscall_files[NR_syscalls];
-	struct trace_event_file __rcu *exit_syscall_files[NR_syscalls];
+	struct trace_event_file	*enter_syscall_files[NR_syscalls];
+	struct trace_event_file	*exit_syscall_files[NR_syscalls];
 #endif
 	int			stop_count;
 	int			clock_id;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9f3e9537417d..e00da4182deb 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1629,11 +1629,10 @@ static void *s_start(struct seq_file *m, loff_t *po=
s)
 	loff_t l;
=20
 	iter =3D kzalloc(sizeof(*iter), GFP_KERNEL);
+	mutex_lock(&event_mutex);
 	if (!iter)
 		return NULL;
=20
-	mutex_lock(&event_mutex);
-
 	iter->type =3D SET_EVENT_FILE;
 	iter->file =3D list_entry(&tr->events, struct trace_event_file, list);
=20
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_u=
ser.c
index af42aaa3d172..3169182229ad 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -835,7 +835,7 @@ void user_event_mm_remove(struct task_struct *t)
 	 * so we use a work queue after call_rcu() to run within.
 	 */
 	INIT_RCU_WORK(&mm->put_rwork, delayed_user_event_mm_put);
-	queue_rcu_work(system_wq, &mm->put_rwork);
+	queue_rcu_work(system_percpu_wq, &mm->put_rwork);
 }
=20
 void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index fd259da0aa64..4cb464894faf 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -271,7 +271,7 @@ static inline void tlat_var_reset(void)
 	 * So far, all the values are initialized as 0, so
 	 * zeroing the structure is perfect.
 	 */
-	for_each_cpu(cpu, cpu_online_mask) {
+	for_each_online_cpu(cpu) {
 		tlat_var =3D per_cpu_ptr(&per_cpu_timerlat_var, cpu);
 		if (tlat_var->kthread)
 			hrtimer_cancel(&tlat_var->timer);
@@ -295,7 +295,7 @@ static inline void osn_var_reset(void)
 	 * So far, all the values are initialized as 0, so
 	 * zeroing the structure is perfect.
 	 */
-	for_each_cpu(cpu, cpu_online_mask) {
+	for_each_online_cpu(cpu) {
 		osn_var =3D per_cpu_ptr(&per_cpu_osnoise_var, cpu);
 		memset(osn_var, 0, sizeof(*osn_var));
 	}
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_s=
witch.c
index cb49f7279dc8..c46d584ded3b 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -224,7 +224,6 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_=
buffer(unsigned int val)
 	/* Place map_cmdline_to_pid array right after saved_cmdlines */
 	s->map_cmdline_to_pid =3D (unsigned *)&s->saved_cmdlines[val * TASK_COMM_=
LEN];
=20
-	s->cmdline_idx =3D 0;
 	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,
 	       sizeof(s->map_pid_to_cmdline));
 	memset(s->map_cmdline_to_pid, NO_CMDLINE_MAP,
@@ -248,6 +247,8 @@ int trace_save_cmdline(struct task_struct *tsk)
 	if (!tsk->pid)
 		return 1;
=20
+	BUILD_BUG_ON(!is_power_of_2(PID_MAX_DEFAULT));
+
 	tpid =3D tsk->pid & (PID_MAX_DEFAULT - 1);
=20
 	/*
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 46aab0ab9350..0f932b22f9ec 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -153,14 +153,20 @@ print_syscall_enter(struct trace_iterator *iter, int =
flags,
 		if (trace_seq_has_overflowed(s))
 			goto end;
=20
+		if (i)
+			trace_seq_puts(s, ", ");
+
 		/* parameter types */
 		if (tr && tr->trace_flags & TRACE_ITER_VERBOSE)
 			trace_seq_printf(s, "%s ", entry->types[i]);
=20
 		/* parameter values */
-		trace_seq_printf(s, "%s: %lx%s", entry->args[i],
-				 trace->args[i],
-				 i =3D=3D entry->nb_args - 1 ? "" : ", ");
+		if (trace->args[i] < 10)
+			trace_seq_printf(s, "%s: %lu", entry->args[i],
+					 trace->args[i]);
+		else
+			trace_seq_printf(s, "%s: 0x%lx", entry->args[i],
+					 trace->args[i]);
 	}
=20
 	trace_seq_putc(s, ')');
@@ -310,8 +316,7 @@ static void ftrace_syscall_enter(void *data, struct pt_=
regs *regs, long id)
 	if (syscall_nr < 0 || syscall_nr >=3D NR_syscalls)
 		return;
=20
-	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE) */
-	trace_file =3D rcu_dereference_sched(tr->enter_syscall_files[syscall_nr]);
+	trace_file =3D READ_ONCE(tr->enter_syscall_files[syscall_nr]);
 	if (!trace_file)
 		return;
=20
@@ -356,8 +361,7 @@ static void ftrace_syscall_exit(void *data, struct pt_r=
egs *regs, long ret)
 	if (syscall_nr < 0 || syscall_nr >=3D NR_syscalls)
 		return;
=20
-	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE()) */
-	trace_file =3D rcu_dereference_sched(tr->exit_syscall_files[syscall_nr]);
+	trace_file =3D READ_ONCE(tr->exit_syscall_files[syscall_nr]);
 	if (!trace_file)
 		return;
=20
@@ -393,7 +397,7 @@ static int reg_event_syscall_enter(struct trace_event_f=
ile *file,
 	if (!tr->sys_refcount_enter)
 		ret =3D register_trace_sys_enter(ftrace_syscall_enter, tr);
 	if (!ret) {
-		rcu_assign_pointer(tr->enter_syscall_files[num], file);
+		WRITE_ONCE(tr->enter_syscall_files[num], file);
 		tr->sys_refcount_enter++;
 	}
 	mutex_unlock(&syscall_trace_lock);
@@ -411,7 +415,7 @@ static void unreg_event_syscall_enter(struct trace_even=
t_file *file,
 		return;
 	mutex_lock(&syscall_trace_lock);
 	tr->sys_refcount_enter--;
-	RCU_INIT_POINTER(tr->enter_syscall_files[num], NULL);
+	WRITE_ONCE(tr->enter_syscall_files[num], NULL);
 	if (!tr->sys_refcount_enter)
 		unregister_trace_sys_enter(ftrace_syscall_enter, tr);
 	mutex_unlock(&syscall_trace_lock);
@@ -431,7 +435,7 @@ static int reg_event_syscall_exit(struct trace_event_fi=
le *file,
 	if (!tr->sys_refcount_exit)
 		ret =3D register_trace_sys_exit(ftrace_syscall_exit, tr);
 	if (!ret) {
-		rcu_assign_pointer(tr->exit_syscall_files[num], file);
+		WRITE_ONCE(tr->exit_syscall_files[num], file);
 		tr->sys_refcount_exit++;
 	}
 	mutex_unlock(&syscall_trace_lock);
@@ -449,7 +453,7 @@ static void unreg_event_syscall_exit(struct trace_event=
_file *file,
 		return;
 	mutex_lock(&syscall_trace_lock);
 	tr->sys_refcount_exit--;
-	RCU_INIT_POINTER(tr->exit_syscall_files[num], NULL);
+	WRITE_ONCE(tr->exit_syscall_files[num], NULL);
 	if (!tr->sys_refcount_exit)
 		unregister_trace_sys_exit(ftrace_syscall_exit, tr);
 	mutex_unlock(&syscall_trace_lock);
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 1921ade45be3..7f8da4dab69d 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -1076,7 +1076,7 @@ int tracing_map_sort_entries(struct tracing_map *map,
 	struct tracing_map_sort_entry *sort_entry, **entries;
 	int i, n_entries, ret;
=20
-	entries =3D vmalloc(array_size(sizeof(sort_entry), map->max_elts));
+	entries =3D vmalloc_array(map->max_elts, sizeof(sort_entry));
 	if (!entries)
 		return -ENOMEM;
=20

