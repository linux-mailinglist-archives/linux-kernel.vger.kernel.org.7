Return-Path: <linux-kernel+bounces-794819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4AFB3E79F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CE4161658
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1FF33CE93;
	Mon,  1 Sep 2025 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rE/UMgkN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C722EF653;
	Mon,  1 Sep 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737880; cv=none; b=IegbCq4PK074yQDH8vwiW4QYUxrSVjV/LTS+b0DdKb3B8NafP2WsPF3/drnIgkKxXZAVga34j3Y0E0sLU1zlZTsHbzutMABwFb51xY3rUJgGu9TzeQnl0Ds5fNTPOqG2BjqYH+sl4Knz+c2mR5ZHT2+LjOI67CiWRkgorMldbdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737880; c=relaxed/simple;
	bh=rOQuaa8RDkK43QH4byDdVI+QZow0U6m4AZGslI0lojk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BjBv9aM98h3OtWKlICoJ4vJxS+yOz76IdcHrO3stpBNc9jCsbp50ZFL/W39BOMhUnlRIHYaKfC3Qo29Md8DvHW3uDF40bZMcVENW05Xj+0z1mYXT/67N7Un4RBgXsi8zpd43+lpTEPuPduukqSi1gKd4WMF++t18/99AhLGl1fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rE/UMgkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54952C4CEF0;
	Mon,  1 Sep 2025 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737880;
	bh=rOQuaa8RDkK43QH4byDdVI+QZow0U6m4AZGslI0lojk=;
	h=From:To:Cc:Subject:Date:From;
	b=rE/UMgkNnYVi4ZNLy8sjvPBhINyu5faw4K0yw857IeiDzM82os/aOyNuW6Wj8YdH6
	 3QGsDyOpCCQAqmq43Bk5LlQ0cVMl5Q7jZki+gmCkk7lZL2citbZSzH0Wow5q8oUgga
	 7LGVs4CURcQ7X06kjMbR+lOIcXVH+jDsK+BZeJfi0Jffg3Rtl2fx7OoPwKt2ojGBWI
	 I59xIKRMfFJa4SLxDXI+y/yidmO6aKwfGpqciBpWLJ957jHbJCqSjrNcOD3pHkMsje
	 z5QtHULPQ7rpw0DGpMQO/wiGuWKI4mmTDz67K4fha8Sar6ZPt0xrrURTe7OWsq3/Y8
	 RYcAsnZouu0GQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [RFC PATCH 0/6] tracing: wprobe: Add wprobe for watchpoint
Date: Mon,  1 Sep 2025 23:44:35 +0900
Message-ID: <175673787502.478080.3342912952394010967.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is an RFC series for adding new wprobe (watch probe) which
provides memory access tracing event. Moreover, this can be used via
event trigger. Thus it can trace memory access on a dynamically
allocated objects too.

In this version, I reuse Jinchao's arch_reinstall_hw_breakpoint()
patch[1].

[1] https://lore.kernel.org/all/20250828073311.1116593-6-wangjinchao600@gmail.com/

The basic usage of this wprobe is similar to other probes;

  w:[GRP/][EVENT] [r|w|rw]@<ADDRESS|SYMBOL[+OFFS]> [FETCHARGS]

This defines a new wprobe event. For example, to trace jiffies update,
you can do;

 echo 'w:my_jiffies w@jiffies:8 value=+0($addr)' >> dynamic_events
 echo 1 > events/wprobes/my_jiffies/enable

Moreover, this can be combined with event trigger to trace the memory
accecss on slab objects. The trigger syntax is;

  set_wprobe:WPROBE_EVENT:FIELD[+ADJUST]
  clear_wprobe:WPROBE_EVENT

For example, trace the first 8 byte of the dentry data structure passed
to do_truncate() until it is deleted by __dentry_kill().
(Note: all tracefs setup uses '>>' so that it does not kick do_truncate())

  # echo 'w:watch rw@0:8 address=$addr value=+0($addr)' > dynamic_events

  # echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
  # echo 'set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger

  # echo 'f:dentry_kill __dentry_kill dentry=$arg1' >> dynamic_events
  # echo 'clear_wprobe:watch' >> events/fprobes/dentry_kill/trigger

  # echo 1 >> events/fprobes/truncate/enable
  # echo 1 >> events/fprobes/dentry_kill/enable

  # echo aaa > /tmp/hoge
  # echo bbb > /tmp/hoge
  # echo ccc > /tmp/hoge
  # rm /tmp/hoge

Then, the trace data will show;

# tracer: nop
#
# entries-in-buffer/entries-written: 16/16   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#    [    7.026136] sh (113) used greatest stack depth: 12912 bytes left
          | |         |   |||||     |         |
              sh-113     [002] .....     7.024402: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880069194b8
              sh-113     [002] ..Zff     7.024822: watch: (lookup_fast+0xaa/0x150) address=0xffff8880069194b8 value=0x200008
              sh-113     [002] ..Zff     7.024830: watch: (step_into+0x82/0x360) address=0xffff8880069194b8 value=0x200008
              sh-113     [002] ..Zff     7.024834: watch: (step_into+0x9f/0x360) address=0xffff8880069194b8 value=0x200008
              sh-113     [002] ..Zff     7.024839: watch: (path_openat+0xb3a/0xe70) address=0xffff8880069194b8 value=0x200008
              sh-113     [002] ..Zff     7.024843: watch: (path_openat+0xb9a/0xe70) address=0xffff8880069194b8 value=0x200008
              sh-113     [002] .....     7.024847: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880069194b8
              sh-113     [002] ...1.     7.025364: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff888006919380
              sh-113     [002] ...1.     7.025511: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880069195f0
              rm-118     [003] ...1.     7.027543: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880069194b8
              sh-113     [002] ...2.     7.027825: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880044429c0
              sh-113     [002] ...2.     7.027833: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff888004442270


Thank you,

---

Jinchao Wang (1):
      x86/HWBP: introduce arch_reinstall_hw_breakpoint() for atomic context

Masami Hiramatsu (Google) (5):
      tracing: wprobe: Add watchpoint probe event based on hardware breakpoint
      HWBP: Add modify_wide_hw_breakpoint_local() API
      tracing: wprobe: Add wprobe event trigger
      selftests: tracing: Add a basic testcase for wprobe
      selftests: tracing: Add syntax testcase for wprobe


 Documentation/trace/index.rst                      |    1 
 Documentation/trace/wprobetrace.rst                |  129 ++
 arch/Kconfig                                       |   10 
 arch/x86/Kconfig                                   |    1 
 arch/x86/include/asm/hw_breakpoint.h               |    3 
 arch/x86/kernel/hw_breakpoint.c                    |   61 +
 include/linux/hw_breakpoint.h                      |    6 
 include/linux/trace_events.h                       |    3 
 kernel/events/hw_breakpoint.c                      |   36 +
 kernel/trace/Kconfig                               |   24 
 kernel/trace/Makefile                              |    1 
 kernel/trace/trace.c                               |    9 
 kernel/trace/trace.h                               |    5 
 kernel/trace/trace_probe.c                         |   20 
 kernel/trace/trace_probe.h                         |    8 
 kernel/trace/trace_wprobe.c                        | 1111 ++++++++++++++++++++
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   68 +
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   20 
 18 files changed, 1513 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/trace/wprobetrace.rst
 create mode 100644 kernel/trace/trace_wprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

