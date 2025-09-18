Return-Path: <linux-kernel+bounces-815660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063C3B5698C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA5F3A6AD2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE6E1F7575;
	Sun, 14 Sep 2025 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN+q9MN6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C235949;
	Sun, 14 Sep 2025 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757858981; cv=none; b=A+ilyATlZTmExa7a3a1G7YkYxLnAxLuiM2R8MJZOxwJz5Hz4SPpQiFepc4/XmBB15TkFiBuNx13/CdhzyGRgt1Pphx7+UUaGyBJRmL+VwhcBko4YSsjoRnr1bTDdDSgYUvh6565r0IpttV++K4jQeccC2r4NLQhOAPwg08OzJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757858981; c=relaxed/simple;
	bh=i+ny6Ky18Yzyw+7GOPO0nGOeA37URLQ1Nl7zUhqA/OE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YPjE72Bsclrzj4C360UuMsEaO6hwrr4+731M1TYzT5vm+jzSlflKd7AV4g7pKOhXAvHvEngqNAZOwLhwAavh46tz4xEIAULP65IYPpgjm001JfSKBv9N7KMXATCiQvdO0xSXfJ2RkmX3mYOQf7M4dbKfGzOUph+ba+n8Uo8MPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN+q9MN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E218DC4CEF0;
	Sun, 14 Sep 2025 14:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757858980;
	bh=i+ny6Ky18Yzyw+7GOPO0nGOeA37URLQ1Nl7zUhqA/OE=;
	h=From:To:Cc:Subject:Date:From;
	b=QN+q9MN6GGILPEm6cCYVy7ZHJtCOCBVFaap0ER8XCrF0TXRg1IVlfRwLjKUPPxC5S
	 atakCrBBKbQC7dArKFHUcHd2qD8hk1a1ri6wnsosKEz2POBO4WgJ1YdhkLVbC9fGie
	 HAHTX6pBCT34QSwQSH/rFO1GsUhkORPYRVuKyREe0cLxMg5leEmu/iaHZsY6F5CsQK
	 VayFb9a5cW0xB3lYyOb7IUwNuSqqomxuYk1CwpCyYjLfuepXVLOgibZvyPhvBji8F1
	 OcRk9oD5owosdZOeXhY08wglH8RNpEwQfJ7sKpPO4a8ikKlwJIolDSgIb0nhp99SzV
	 hhowbfYy12OWQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: [PATCH v4 0/8] tracing: wprobe: Add wprobe for watchpoint
Date: Sun, 14 Sep 2025 23:09:34 +0900
Message-ID: <175785897434.234168.6798590787777427098.stgit@devnote2>
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

Here is the 4th version of the series for adding new wprobe (watch probe)
which provides memory access tracing event. Moreover, this can be used
via event trigger. Thus it can trace memory access on a dynamically
allocated objects too.
The previous version is here:

 https://lore.kernel.org/all/175755135002.153203.324836519360617091.stgit@devnote2/

In this version, I updated to use Jinchao's x86 HWBP patches[1][2]
as [2/8][3/8], and update the kerneldoc for
modify_wide_hw_breakpoint_local() [4/8] according to Randy's comment[3].

[1] https://lore.kernel.org/all/20250912101145.465708-2-wangjinchao600@gmail.com/
[2] https://lore.kernel.org/all/20250912101145.465708-3-wangjinchao600@gmail.com/
[3] https://lore.kernel.org/all/6b5e5d3e-5db8-44f2-8dca-42f317be8e0d@infradead.org/

Usage
-----

The basic usage of this wprobe is similar to other probes;

  w:[GRP/][EVENT] [r|w|rw]@<ADDRESS|SYMBOL[+OFFS]> [FETCHARGS]

This defines a new wprobe event. For example, to trace jiffies update,
you can do;

 echo 'w:my_jiffies w@jiffies:8 value=+0($addr)' >> dynamic_events
 echo 1 > events/wprobes/my_jiffies/enable

Moreover, this can be combined with event trigger to trace the memory
accecss on slab objects. The trigger syntax is;

  set_wprobe:WPROBE_EVENT:FIELD[+OFFSET] [if FILTER]
  clear_wprobe:WPROBE_EVENT[:FIELD[+OFFSET]] [if FILTER]

set_wprobe sets WPROBE_EVENT's watch address on FIELD[+OFFSET].
clear_wprobe clears WPROBE_EVENT's watch address if it is set to
FIELD[+OFFSET]. If FIELD is omitted, forcibly clear the watch address
when trigger event is hit.

For example, trace the first 8 byte of the dentry data structure passed
to do_truncate() until it is deleted by __dentry_kill().
(Note: all tracefs setup uses '>>' so that it does not kick do_truncate())

  # echo 'w:watch rw@0:8 address=$addr value=+0($addr)' > dynamic_events

  # echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
  # echo 'set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger

  # echo 'f:dentry_kill __dentry_kill dentry=$arg1' >> dynamic_events
  # echo 'clear_wprobe:watch:dentry' >> events/fprobes/dentry_kill/trigger

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
#              | |         |   |||||     |         |
              sh-113     [004] .....     6.467444: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880044f0fd8
              sh-113     [004] ..Zff     6.468534: watch: (lookup_fast+0xaa/0x150) address=0xffff8880044f0fd8 value=0x200080
              sh-113     [004] ..Zff     6.468542: watch: (step_into+0x82/0x360) address=0xffff8880044f0fd8 value=0x200080
              sh-113     [004] ..Zff     6.468547: watch: (step_into+0x9f/0x360) address=0xffff8880044f0fd8 value=0x200080
              sh-113     [004] ..Zff     6.468553: watch: (path_openat+0xb3a/0xe70) address=0xffff8880044f0fd8 value=0x200080
              sh-113     [004] ..Zff     6.468557: watch: (path_openat+0xb9a/0xe70) address=0xffff8880044f0fd8 value=0x200080
              sh-113     [004] .....     6.468563: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880044f0fd8
              sh-113     [004] ...1.     6.469826: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880044f0ea0
              sh-113     [004] ...1.     6.469859: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880044f0d68
              rm-118     [001] ..Zff     6.472360: watch: (lookup_fast+0xaa/0x150) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472366: watch: (step_into+0x82/0x360) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472370: watch: (step_into+0x9f/0x360) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472386: watch: (lookup_fast+0xaa/0x150) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472390: watch: (step_into+0x82/0x360) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472394: watch: (step_into+0x9f/0x360) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472415: watch: (lookup_one_qstr_excl+0x2c/0x150) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472419: watch: (lookup_one_qstr_excl+0xd5/0x150) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472424: watch: (may_delete+0x18/0x200) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472428: watch: (may_delete+0x194/0x200) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472446: watch: (vfs_unlink+0x63/0x1c0) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] d.Z..     6.472528: watch: (dont_mount+0x19/0x30) address=0xffff8880044f0fd8 value=0x200180
              rm-118     [001] ..Zff     6.472533: watch: (vfs_unlink+0x11a/0x1c0) address=0xffff8880044f0fd8 value=0x200180
              rm-118     [001] ..Zff     6.472538: watch: (vfs_unlink+0x12e/0x1c0) address=0xffff8880044f0fd8 value=0x200180
              rm-118     [001] d.Z1.     6.472543: watch: (d_delete+0x61/0xa0) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] d.Z1.     6.472547: watch: (dentry_unlink_inode+0x14/0x110) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] d.Z1.     6.472551: watch: (dentry_unlink_inode+0x1e/0x110) address=0xffff8880044f0fd8 value=0x80
              rm-118     [001] d.Z..     6.472563: watch: (fast_dput+0x8d/0x120) address=0xffff8880044f0fd8 value=0x80
              rm-118     [001] ...1.     6.472567: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880044f0fd8
              sh-113     [004] ...2.     6.473049: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff888006e383a8

Thank you,

---

Jinchao Wang (2):
      x86/hw_breakpoint: Unify breakpoint install/uninstall
      x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint

Masami Hiramatsu (Google) (6):
      tracing: wprobe: Add watchpoint probe event based on hardware breakpoint
      HWBP: Add modify_wide_hw_breakpoint_local() API
      tracing: wprobe: Add wprobe event trigger
      selftests: tracing: Add a basic testcase for wprobe
      selftests: tracing: Add syntax testcase for wprobe
      selftests: ftrace: Add wprobe trigger testcase


 Documentation/trace/index.rst                      |    1 
 Documentation/trace/wprobetrace.rst                |  157 +++
 arch/Kconfig                                       |   10 
 arch/x86/Kconfig                                   |    1 
 arch/x86/include/asm/hw_breakpoint.h               |    8 
 arch/x86/kernel/hw_breakpoint.c                    |  148 ++-
 include/linux/hw_breakpoint.h                      |    6 
 include/linux/trace_events.h                       |    3 
 kernel/events/hw_breakpoint.c                      |   37 +
 kernel/trace/Kconfig                               |   24 
 kernel/trace/Makefile                              |    1 
 kernel/trace/trace.c                               |    9 
 kernel/trace/trace.h                               |    5 
 kernel/trace/trace_probe.c                         |   22 
 kernel/trace/trace_probe.h                         |    8 
 kernel/trace/trace_wprobe.c                        | 1115 ++++++++++++++++++++
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   68 +
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   20 
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |   48 +
 19 files changed, 1626 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/trace/wprobetrace.rst
 create mode 100644 kernel/trace/trace_wprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

