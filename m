Return-Path: <linux-kernel+bounces-752180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FABB17229
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3112C5866A7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280D42D1900;
	Thu, 31 Jul 2025 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmGZwBU/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA8F2C15AB
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968969; cv=none; b=K3clwLiC0KiUHG5HcYf4vFelCdeo0E8+/7EsJuG0dP5Um04Y0IFoTSo6ay2/YN1hNV+uwt6YZa2r2AOPpsjjN5Wc5RVFsRww/m6q1kkfzcxqsDnNd2hdpKSV17HMxrQDe+0YIy6VC7g7pMLLnYWzExilhy9YqnLV4W/C4J2BmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968969; c=relaxed/simple;
	bh=i1SCWt50Ygc6FMcOpQFAqFWiVjruzxtbkqgfnEMPSmg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CmEx4xz8qMFXTEKXI+CQ80PIYZ0/AqUu/jvskMnQYONCDBRyPESCuHf6fbr5IC0DRCmKpGmkpwBjrjT0JfgpCGfHGb8J6weXtdUMu+vm+sFMYk3tZYF9YW8o8knlG5sqdxAlFoAeH6LOiYHm8Gsr2U078Aif4ce3JMjHQsZlz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmGZwBU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE290C4AF09;
	Thu, 31 Jul 2025 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753968968;
	bh=i1SCWt50Ygc6FMcOpQFAqFWiVjruzxtbkqgfnEMPSmg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=mmGZwBU/GV//mOnm3eXCzsz3a0kVBJlx/XxfX9VrDQFhkxuAXAgISLJO66qrOVs0b
	 MYoZV3BzhXtjVmCFBEzCIabLmSjTA5dT0464KqOZXE6oSPRDRDnmf4/cSOwG7nwCbe
	 Bzua2UT+vNhCZgDvoNTMOCAigyESS0HLQ10aDYDqmdybWSZAbEvLKqPOEqP25yqqbW
	 mJrIrKZrXHqfhyu8mcCFPXY58IW5sIy8d7PrQcOZ2MHXbyBhflHovfqxqXfF2kZzSR
	 7xyK1ogn9kCSlRHCHMClS7H0JFFvBSi0vFoicwAnUTFItN0JJ+qnvhUeSGvczH/rn/
	 yPut6Y7/KHNrQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uhTSN-00000006kjl-1z2D;
	Thu, 31 Jul 2025 09:36:27 -0400
Message-ID: <20250731133627.322882387@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 31 Jul 2025 09:36:15 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: [for-next][PATCH 2/2] Documentation: tracing: Add documentation about eprobes
References: <20250731133613.889948523@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Eprobes was added back in 5.15, but was never documented. It became a
"secret" interface even though it has been a topic of several
presentations. For some reason, when eprobes was added, documenting it
never became a priority, until now.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Link: https://lore.kernel.org/20250730140945.528135548@kernel.org
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/eprobetrace.rst | 269 ++++++++++++++++++++++++++++
 Documentation/trace/index.rst       |   1 +
 2 files changed, 270 insertions(+)
 create mode 100644 Documentation/trace/eprobetrace.rst

diff --git a/Documentation/trace/eprobetrace.rst b/Documentation/trace/eprobetrace.rst
new file mode 100644
index 000000000000..89b5157cfab8
--- /dev/null
+++ b/Documentation/trace/eprobetrace.rst
@@ -0,0 +1,269 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Eprobe - Event-based Probe Tracing
+==================================
+
+:Author: Steven Rostedt <rostedt@goodmis.org>
+
+- Written for v6.17
+
+Overview
+========
+
+Eprobes are dynamic events that are placed on existing events to either
+dereference a field that is a pointer, or simply to limit what fields are
+recorded in the trace event.
+
+Eprobes depend on kprobe events so to enable this feature, build your kernel
+with CONFIG_EPROBE_EVENTS=y.
+
+Eprobes are created via the /sys/kernel/tracing/dynamic_events file.
+
+Synopsis of eprobe_events
+-------------------------
+::
+
+  e[:[EGRP/][EEVENT]] GRP.EVENT [FETCHARGS]	: Set a probe
+  -:[EGRP/][EEVENT]				: Clear a probe
+
+ EGRP		: Group name of the new event. If omitted, use "eprobes" for it.
+ EEVENT		: Event name. If omitted, the event name is generated and will
+		  be the same event name as the event it attached to.
+ GRP		: Group name of the event to attach to.
+ EVENT		: Event name of the event to attach to.
+
+ FETCHARGS	: Arguments. Each probe can have up to 128 args.
+  $FIELD	: Fetch the value of the event field called FIELD.
+  @ADDR		: Fetch memory at ADDR (ADDR should be in kernel)
+  @SYM[+|-offs]	: Fetch memory at SYM +|- offs (SYM should be a data symbol)
+  $comm		: Fetch current task comm.
+  +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
+  \IMM		: Store an immediate value to the argument.
+  NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
+  FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
+		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
+		  (x8/x16/x32/x64), VFS layer common type(%pd/%pD), "char",
+                  "string", "ustring", "symbol", "symstr" and "bitfield" are
+                  supported.
+
+Types
+-----
+The FETCHARGS above is very similar to the kprobe events as described in
+Documentation/trace/kprobetrace.rst.
+
+The difference between eprobes and kprobes FETCHARGS is that eprobes has a
+$FIELD command that returns the content of the event field of the event
+that is attached. Eprobes do not have access to registers, stacks and function
+arguments that kprobes has.
+
+If a field argument is a pointer, it may be dereferenced just like a memory
+address using the FETCHARGS syntax.
+
+
+Attaching to dynamic events
+---------------------------
+
+Eprobes may attach to dynamic events as well as to normal events. It may
+attach to a kprobe event, a synthetic event or a fprobe event. This is useful
+if the type of a field needs to be changed. See Example 2 below.
+
+Usage examples
+==============
+
+Example 1
+---------
+
+The basic usage of eprobes is to limit the data that is being recorded into
+the tracing buffer. For example, a common event to trace is the sched_switch
+trace event. That has a format of::
+
+	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
+	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
+	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
+	field:int common_pid;	offset:4;	size:4;	signed:1;
+
+	field:char prev_comm[16];	offset:8;	size:16;	signed:0;
+	field:pid_t prev_pid;	offset:24;	size:4;	signed:1;
+	field:int prev_prio;	offset:28;	size:4;	signed:1;
+	field:long prev_state;	offset:32;	size:8;	signed:1;
+	field:char next_comm[16];	offset:40;	size:16;	signed:0;
+	field:pid_t next_pid;	offset:56;	size:4;	signed:1;
+	field:int next_prio;	offset:60;	size:4;	signed:1;
+
+The first four fields are common to all events and can not be limited. But the
+rest of the event has 60 bytes of information. It records the names of the
+previous and next tasks being scheduled out and in, as well as their pids and
+priorities. It also records the state of the previous task. If only the pids
+of the tasks are of interest, why waste the ring buffer with all the other
+fields?
+
+An eprobe can limit what gets recorded. Note, it does not help in performance,
+as all the fields are recorded in a temporary buffer to process the eprobe.
+::
+
+ # echo 'e:sched/switch sched.sched_switch prev=$prev_pid:u32 next=$next_pid:u32' >> /sys/kernel/tracing/dynamic_events
+ # echo 1 > /sys/kernel/tracing/events/sched/switch/enable
+ # cat /sys/kernel/tracing/trace
+
+ # tracer: nop
+ #
+ # entries-in-buffer/entries-written: 2721/2721   #P:8
+ #
+ #                                _-----=> irqs-off/BH-disabled
+ #                               / _----=> need-resched
+ #                              | / _---=> hardirq/softirq
+ #                              || / _--=> preempt-depth
+ #                              ||| / _-=> migrate-disable
+ #                              |||| /     delay
+ #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+ #              | |         |   |||||     |         |
+     sshd-session-1082    [004] d..4.  5041.239906: switch: (sched.sched_switch) prev=1082 next=0
+             bash-1085    [001] d..4.  5041.240198: switch: (sched.sched_switch) prev=1085 next=141
+    kworker/u34:5-141     [001] d..4.  5041.240259: switch: (sched.sched_switch) prev=141 next=1085
+           <idle>-0       [004] d..4.  5041.240354: switch: (sched.sched_switch) prev=0 next=1082
+             bash-1085    [001] d..4.  5041.240385: switch: (sched.sched_switch) prev=1085 next=141
+    kworker/u34:5-141     [001] d..4.  5041.240410: switch: (sched.sched_switch) prev=141 next=1085
+             bash-1085    [001] d..4.  5041.240478: switch: (sched.sched_switch) prev=1085 next=0
+     sshd-session-1082    [004] d..4.  5041.240526: switch: (sched.sched_switch) prev=1082 next=0
+           <idle>-0       [001] d..4.  5041.247524: switch: (sched.sched_switch) prev=0 next=90
+           <idle>-0       [002] d..4.  5041.247545: switch: (sched.sched_switch) prev=0 next=16
+      kworker/1:1-90      [001] d..4.  5041.247580: switch: (sched.sched_switch) prev=90 next=0
+        rcu_sched-16      [002] d..4.  5041.247591: switch: (sched.sched_switch) prev=16 next=0
+           <idle>-0       [002] d..4.  5041.257536: switch: (sched.sched_switch) prev=0 next=16
+        rcu_sched-16      [002] d..4.  5041.257573: switch: (sched.sched_switch) prev=16 next=0
+
+Note, without adding the "u32" after the prev_pid and next_pid, the values
+would default showing in hexadecimal.
+
+Example 2
+---------
+
+If a specific system call is to be recorded but the syscalls events are not
+enabled, the raw_syscalls can still be used (syscalls are system call
+events are not normal events, but are created from the raw_syscalls events
+within the kernel). In order to trace the openat system call, one can create
+an event probe on top of the raw_syscalls event:
+::
+
+ # cd /sys/kernel/tracing
+ # cat events/raw_syscalls/sys_enter/format
+ name: sys_enter
+ ID: 395
+ format:
+	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
+	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
+	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
+	field:int common_pid;	offset:4;	size:4;	signed:1;
+
+	field:long id;	offset:8;	size:8;	signed:1;
+	field:unsigned long args[6];	offset:16;	size:48;	signed:0;
+
+ print fmt: "NR %ld (%lx, %lx, %lx, %lx, %lx, %lx)", REC->id, REC->args[0], REC->args[1], REC->args[2], REC->args[3], REC->args[4], REC->args[5]
+
+From the source code, the sys_openat() has:
+::
+
+ int sys_openat(int dirfd, const char *path, int flags, mode_t mode)
+ {
+	return my_syscall4(__NR_openat, dirfd, path, flags, mode);
+ }
+
+The path is the second parameter, and that is what is wanted.
+::
+
+ # echo 'e:openat raw_syscalls.sys_enter nr=$id filename=+8($args):ustring' >> dynamic_events
+
+This is being run on x86_64 where the word size is 8 bytes and the openat
+system call __NR_openat is set at 257.
+::
+
+ # echo 'nr == 257' > events/eprobes/openat/filter
+
+Now enable the event and look at the trace.
+::
+
+ # echo 1 > events/eprobes/openat/enable
+ # cat trace
+
+ # tracer: nop
+ #
+ # entries-in-buffer/entries-written: 4/4   #P:8
+ #
+ #                                _-----=> irqs-off/BH-disabled
+ #                               / _----=> need-resched
+ #                              | / _---=> hardirq/softirq
+ #                              || / _--=> preempt-depth
+ #                              ||| / _-=> migrate-disable
+ #                              |||| /     delay
+ #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+ #              | |         |   |||||     |         |
+              cat-1298    [003] ...2.  2060.875970: openat: (raw_syscalls.sys_enter) nr=0x101 filename=(fault)
+              cat-1298    [003] ...2.  2060.876197: openat: (raw_syscalls.sys_enter) nr=0x101 filename=(fault)
+              cat-1298    [003] ...2.  2060.879126: openat: (raw_syscalls.sys_enter) nr=0x101 filename=(fault)
+              cat-1298    [003] ...2.  2060.879639: openat: (raw_syscalls.sys_enter) nr=0x101 filename=(fault)
+
+The filename shows "(fault)". This is likely because the filename has not been
+pulled into memory yet and currently trace events cannot fault in memory that
+is not present. When an eprobe tries to read memory that has not been faulted
+in yet, it will show the "(fault)" text.
+
+To get around this, as the kernel will likely pull in this filename and make
+it present, attaching it to a synthetic event that can pass the address of the
+filename from the entry of the event to the end of the event, this can be used
+to show the filename when the system call returns.
+
+Remove the old eprobe::
+
+ # echo 1 > events/eprobes/openat/enable
+ # echo '-:openat' >> dynamic_events
+
+This time make an eprobe where the address of the filename is saved::
+
+ # echo 'e:openat_start raw_syscalls.sys_enter nr=$id filename=+8($args):x64' >> dynamic_events
+
+Create a synthetic event that passes the address of the filename to the
+end of the event::
+
+ # echo 's:filename u64 file' >> dynamic_events
+ # echo 'hist:keys=common_pid:f=filename if nr == 257' > events/eprobes/openat_start/trigger
+ # echo 'hist:keys=common_pid:file=$f:onmatch(eprobes.openat_start).trace(filename,$file) if id == 257' > events/raw_syscalls/sys_exit/trigger
+
+Now that the address of the filename has been passed to the end of the
+system call, create another eprobe to attach to the exit event to show the
+string::
+
+ # echo 'e:openat synthetic.filename filename=+0($file):ustring' >> dynamic_events
+ # echo 1 > events/eprobes/openat/enable
+ # cat trace
+
+ # tracer: nop
+ #
+ # entries-in-buffer/entries-written: 4/4   #P:8
+ #
+ #                                _-----=> irqs-off/BH-disabled
+ #                               / _----=> need-resched
+ #                              | / _---=> hardirq/softirq
+ #                              || / _--=> preempt-depth
+ #                              ||| / _-=> migrate-disable
+ #                              |||| /     delay
+ #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+ #              | |         |   |||||     |         |
+              cat-1331    [001] ...5.  2944.787977: openat: (synthetic.filename) filename="/etc/ld.so.cache"
+              cat-1331    [001] ...5.  2944.788480: openat: (synthetic.filename) filename="/lib/x86_64-linux-gnu/libc.so.6"
+              cat-1331    [001] ...5.  2944.793426: openat: (synthetic.filename) filename="/usr/lib/locale/locale-archive"
+              cat-1331    [001] ...5.  2944.831362: openat: (synthetic.filename) filename="trace"
+
+Example 3
+---------
+
+If syscall trace events are available, the above would not need the first
+eprobe, but it would still need the last one::
+
+ # echo 's:filename u64 file' >> dynamic_events
+ # echo 'hist:keys=common_pid:f=filename' > events/syscalls/sys_enter_openat/trigger
+ # echo 'hist:keys=common_pid:file=$f:onmatch(syscalls.sys_enter_openat).trace(filename,$file)' > events/syscalls/sys_exit_openat/trigger
+ # echo 'e:openat synthetic.filename filename=+0($file):ustring' >> dynamic_events
+ # echo 1 > events/eprobes/openat/enable
+
+And this would produce the same result as Example 2.
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index cc1dc5a087e8..b4a429dc4f7a 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -36,6 +36,7 @@ the Linux kernel.
    kprobes
    kprobetrace
    fprobetrace
+   eprobetrace
    fprobe
    ring-buffer-design
 
-- 
2.47.2



