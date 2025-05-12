Return-Path: <linux-kernel+bounces-643968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 126BBAB3537
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 12:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E305219E05AD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 10:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F101A267F74;
	Mon, 12 May 2025 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Jj9+QHm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BNlDAEkZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA872673B6;
	Mon, 12 May 2025 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047078; cv=none; b=Q9+VxX8XAZq0g+La/8CTR4/csg3Gq9poWnQZi4cJqRUYkIYvkt0P326OP0XCQ5rc3r2WADsYCYk4S4gKehZDZYV/nT9d/bXAC99xkUefx8sSKX7T191d70oR9khwQqy8B5hlSEGB29JpD1LvvTboP3T8mtwxwTUKAINttUfV89o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047078; c=relaxed/simple;
	bh=Vnbt8PYI0dnu1i1QQA1pUcRiFD9xVew0593yPtQCC6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nPHrP2iCWCc/3OLrApRvVs2HDD9n6sw65L+F6TWc/rQQ+T2NP1wPeQBEBofcoL10616sj07HBzRquKHbNnYCgG5D3V+0y2Nk1nYYDABfnYPbC+JT9SU5fingbfF7xYuFVv0F2+pKquQ5oEYVSHaAGK03n7V/kqB0nurW3Mb2p7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Jj9+QHm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BNlDAEkZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747047073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a8kL3YU/sHJ9zjArpCJJoXCwrYyVoqURYj+rWL9pYW8=;
	b=3Jj9+QHmbZXtWMN/wmjcGewwIgVQ2j8o0zxPJB6De2OlblE9s3XbNSB2NXZB6fwRcfx3/C
	/+tCwcjQ18XN+SdTp8MTysP1tUDSo/f2vr5lBZheNdVa9iYgntQay3wY5gKaaAojijQoI2
	Xxh9V5v+yLYt7czPKhOwyvmkMHBypU3mjCJ0XTIHmVXRBVhbPcsbeJpSkK5n+Pj5KoZ1cg
	ogcBeZmqQS9c3YQ4xiseLpgQzfG31Pl5l/FBYt9zzAZCyPtVG52teeXU5+riKLRu3K0Xn+
	Y7gMCem+HM82e9W80KC3RwFSeAesQZrVDV9vHMzr/Aa5E5QcXIiQ1i1PMz87kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747047073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a8kL3YU/sHJ9zjArpCJJoXCwrYyVoqURYj+rWL9pYW8=;
	b=BNlDAEkZCKYwqEsFhOIRs8EvA+AMfVZRvPAsO4EHDYmBVgPj0MYsS1kpTuwu3JkfknjvSs
	Oj+6Tvt32mjWqVAw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v8 00/22] RV: Linear temporal logic monitors for RT application
Date: Mon, 12 May 2025 12:50:43 +0200
Message-Id: <cover.1747046848.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Real-time applications may have design flaws causing them to have
unexpected latency. For example, the applications may raise page faults, or
may be blocked trying to take a mutex without priority inheritance.

However, while attempting to implement DA monitors for these real-time
rules, deterministic automaton is found to be inappropriate as the
specification language. The automaton is complicated, hard to understand,
and error-prone.

For these cases, linear temporal logic is found to be more suitable. The
LTL is more concise and intuitive.

This series adds support for LTL RV monitor, and use it to implement two
monitors for reporting problems with real-time tasks.

Patch 1-12 cleanup and prepare the RV code for the integration of LTL
monitors.

Patch 13 adds support for LTL monitors.

Patch 14 adds the container monitor "rtapp". This encapsulates the
sub-monitors for real-time.

Patch 15-18 prepares the pagefault tracepoints, so that patch 19 can add
the monitor which watches real-time tasks doing page faults.

Patch 20 adds the "sleep" monitor: it detects potential undesirable latency
with real-time threads.

Patch 21 adds documentation on the new monitors.

Patch 22 allows the number of per-task monitors to be configurable, so that
the two new monitors can be enabled simultaneously.

v7->v8 https://lore.kernel.org/lkml/cover.1746776116.git.namcao@linutronix.=
de/
  - Fix some pylint warnings
  - Fix some bugs with some currently-unused operators in the ltl2ba.py
    script
  - sleep monitor: Allow all FUTEX_WAIT_* as valid sleep reason

v6->v7 https://lore.kernel.org/lkml/cover.1745999587.git.namcao@linutronix.=
de/
  - Add missing parameter description for vpanic()
  - Remove the now-redundant CFLAGS_fault.o for x86
  - Change #if to #ifdef to resolve a build warning
  - rtapp/sleep monitor:
    + Handle the case where an RT task "aborts" the sleep by setting state
      to TASK_RUNNING. This case previously caused a false positive. Fix it
      by adding "ABORT_SLEEP" as an RT-safe wake.
    + Also allow CLOCK_TAI for real-time tasks.

v5->v6 https://lore.kernel.org/lkml/cover.1745926331.git.namcao@linutronix.=
de
  - sleep monitor: Drop the block_on_rt_mutex tracepoints. The contention
    tracepoints are sufficient.

v4->v5 https://lore.kernel.org/lkml/cover.1745390829.git.namcao@linutronix.=
de
  - sleep monitor: Fix a false positive due to a race with waking and
    scheduling.
  - sleep monitor: Add block_on_rt_mutex tracepoints and use them for
    BLOCK_ON_RT_MUTEX, instead of trace_sched_pi_setprio
  - sleep monitor: tighten the rule on nanosleep: only clock_nanosleep()
    with TIMER_ABSTIME and CLOCK_MONOTONIC is allowed
  - add comments explaining why it is correct to treat PI-boosted tasks as
    real-time tasks.

    It should be noted that due to the changes in v5, 'perf' does not work
    as well as before, because sometimes the errors happen out of the
    real-time tasks' contexts. Fixing this is left for future work.

    stress-ng is also far noisier in v5, because the rule on nanosleep is
    tightened.

v3->v4 https://lore.kernel.org/lkml/cover.1744785335.git.namcao@linutronix.=
de
  - support deadline tasks
  - rtapp_sleep: use sched_pi_setprio tracepoint instead of contention
    tracepoints for BLOCK_ON_RT_MUTEX, so that proxy lock is covered.
  - fix the scripts generating an "slightly" incorrect verification automat=
on
  - makes rtapp monitor depends on RV_PER_TASK_MONITORS >=3D 2
  - make the event tracepoint output a bit more readable
  - some documentation's format fixes

v2->v3 https://lore.kernel.org/lkml/cover.1744355018.git.namcao@linutronix.=
de/
  - fix a problem with sleep monitor's specification (around
    KTHREAD_SHOULD_STOP)
  - merge the patches that move the dot2k/rvgen scripts around
  - pull panic/printk changes into separate patches
  - fixup some build errors
  - fixup monitor's init function return code
  - fix some flake8 warnings with the scripts
  - add some references to LTL documentation
  - fixup some mistakes with rtapp documentation
  - fixup capitalization mistake with monitor_synthesis.rst
  - remove the now-redundant macro RV_PER_TASK_MONITORS

v1->v2 https://lore.kernel.org/lkml/cover.1741708239.git.namcao@linutronix.=
de/
  - Integrate the LTL scripts into the existing dot2k tool, taking
    advantage of the existing monitor generation scripts.
  - Switch the struct ltl_monitor to use bitmap instead of an array, to
    optimize memory usage.
  - Correct the generated code to be non-deterministic state machine,
    instead of deterministic state machine
  - Put common code for all LTL monitors into a single file
    (include/rv/ltl_monitor.h), reducing code duplication
  - Change the LTL monitors to make user of container. Add a bug fix to
    container while at it.
  - Make the number of per-task monitor configurable

Cc: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org

Nam Cao (22):
  rv: Add #undef TRACE_INCLUDE_FILE
  printk: Make vprintk_deferred() public
  panic: Add vpanic()
  rv: Let the reactors take care of buffers
  verification/dot2k: Make a separate dot2k_templates/Kconfig_container
  verification/dot2k: Remove __buff_to_string()
  verification/dot2k: Replace is_container() hack with subparsers
  rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
  verification/dot2k: Prepare the frontend for LTL inclusion
  Documentation/rv: Prepare monitor synthesis document for LTL inclusion
  verification/rvgen: Restructure the templates files
  verification/rvgen: Restructure the classes to prepare for LTL
    inclusion
  rv: Add support for LTL monitors
  rv: Add rtapp container monitor
  x86/tracing: Remove redundant trace_pagefault_key
  x86/tracing: Move page fault trace points to generic
  arm64: mm: Add page fault trace points
  riscv: mm: Add page fault trace points
  rv: Add rtapp_pagefault monitor
  rv: Add rtapp_sleep monitor
  rv: Add documentation for rtapp monitor
  rv: Allow to configure the number of per-task monitor

 .../trace/rv/da_monitor_synthesis.rst         | 147 -----
 Documentation/trace/rv/index.rst              |   4 +-
 .../trace/rv/linear_temporal_logic.rst        | 122 ++++
 Documentation/trace/rv/monitor_rtapp.rst      | 116 ++++
 Documentation/trace/rv/monitor_synthesis.rst  | 256 +++++++++
 arch/arm64/mm/fault.c                         |   8 +
 arch/riscv/mm/fault.c                         |   8 +
 arch/x86/include/asm/trace/common.h           |  12 -
 arch/x86/include/asm/trace/irq_vectors.h      |   1 -
 arch/x86/kernel/Makefile                      |   1 -
 arch/x86/kernel/tracepoint.c                  |  21 -
 arch/x86/mm/Makefile                          |   2 -
 arch/x86/mm/fault.c                           |   5 +-
 include/linux/panic.h                         |   3 +
 include/linux/printk.h                        |   5 +
 include/linux/rv.h                            |  74 ++-
 include/linux/sched.h                         |   8 +-
 include/rv/da_monitor.h                       |  45 +-
 include/rv/ltl_monitor.h                      | 184 ++++++
 .../trace/events}/exceptions.h                |  27 +-
 kernel/fork.c                                 |   5 +-
 kernel/panic.c                                |  18 +-
 kernel/printk/internal.h                      |   1 -
 kernel/trace/rv/Kconfig                       |  27 +-
 kernel/trace/rv/Makefile                      |   3 +
 kernel/trace/rv/monitors/pagefault/Kconfig    |  11 +
 .../trace/rv/monitors/pagefault/pagefault.c   |  87 +++
 .../trace/rv/monitors/pagefault/pagefault.h   |  57 ++
 .../rv/monitors/pagefault/pagefault_trace.h   |  14 +
 kernel/trace/rv/monitors/rtapp/Kconfig        |   7 +
 kernel/trace/rv/monitors/rtapp/rtapp.c        |  33 ++
 kernel/trace/rv/monitors/rtapp/rtapp.h        |   3 +
 kernel/trace/rv/monitors/sleep/Kconfig        |  13 +
 kernel/trace/rv/monitors/sleep/sleep.c        | 236 ++++++++
 kernel/trace/rv/monitors/sleep/sleep.h        | 250 ++++++++
 kernel/trace/rv/monitors/sleep/sleep_trace.h  |  14 +
 kernel/trace/rv/reactor_panic.c               |   8 +-
 kernel/trace/rv/reactor_printk.c              |   8 +-
 kernel/trace/rv/rv.c                          |  10 +-
 kernel/trace/rv/rv_reactors.c                 |   2 +-
 kernel/trace/rv/rv_trace.h                    |  52 +-
 tools/verification/dot2/Makefile              |  26 -
 tools/verification/dot2/dot2k                 |  53 --
 tools/verification/models/rtapp/pagefault.ltl |   1 +
 tools/verification/models/rtapp/sleep.ltl     |  22 +
 tools/verification/rvgen/.gitignore           |   3 +
 tools/verification/rvgen/Makefile             |  27 +
 tools/verification/rvgen/__main__.py          |  67 +++
 tools/verification/{dot2 =3D> rvgen}/dot2c      |   2 +-
 .../{dot2 =3D> rvgen/rvgen}/automata.py         |   0
 tools/verification/rvgen/rvgen/container.py   |  22 +
 .../{dot2 =3D> rvgen/rvgen}/dot2c.py            |   2 +-
 tools/verification/rvgen/rvgen/dot2k.py       | 129 +++++
 .../dot2k.py =3D> rvgen/rvgen/generator.py}     | 249 ++------
 tools/verification/rvgen/rvgen/ltl2ba.py      | 540 ++++++++++++++++++
 tools/verification/rvgen/rvgen/ltl2k.py       | 245 ++++++++
 .../rvgen/templates}/Kconfig                  |   0
 .../rvgen/rvgen/templates/container/Kconfig   |   5 +
 .../rvgen/templates/container/main.c}         |   0
 .../rvgen/templates/container/main.h}         |   0
 .../rvgen/templates/dot2k}/main.c             |   0
 .../rvgen/templates/dot2k}/trace.h            |   0
 .../rvgen/rvgen/templates/ltl2k/main.c        | 102 ++++
 .../rvgen/rvgen/templates/ltl2k/trace.h       |  14 +
 64 files changed, 2865 insertions(+), 552 deletions(-)
 delete mode 100644 Documentation/trace/rv/da_monitor_synthesis.rst
 create mode 100644 Documentation/trace/rv/linear_temporal_logic.rst
 create mode 100644 Documentation/trace/rv/monitor_rtapp.rst
 create mode 100644 Documentation/trace/rv/monitor_synthesis.rst
 delete mode 100644 arch/x86/include/asm/trace/common.h
 delete mode 100644 arch/x86/kernel/tracepoint.c
 create mode 100644 include/rv/ltl_monitor.h
 rename {arch/x86/include/asm/trace =3D> include/trace/events}/exceptions.h=
 (55%)
 create mode 100644 kernel/trace/rv/monitors/pagefault/Kconfig
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault.c
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault.h
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault_trace.h
 create mode 100644 kernel/trace/rv/monitors/rtapp/Kconfig
 create mode 100644 kernel/trace/rv/monitors/rtapp/rtapp.c
 create mode 100644 kernel/trace/rv/monitors/rtapp/rtapp.h
 create mode 100644 kernel/trace/rv/monitors/sleep/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep.c
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep.h
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep_trace.h
 delete mode 100644 tools/verification/dot2/Makefile
 delete mode 100644 tools/verification/dot2/dot2k
 create mode 100644 tools/verification/models/rtapp/pagefault.ltl
 create mode 100644 tools/verification/models/rtapp/sleep.ltl
 create mode 100644 tools/verification/rvgen/.gitignore
 create mode 100644 tools/verification/rvgen/Makefile
 create mode 100644 tools/verification/rvgen/__main__.py
 rename tools/verification/{dot2 =3D> rvgen}/dot2c (97%)
 rename tools/verification/{dot2 =3D> rvgen/rvgen}/automata.py (100%)
 create mode 100644 tools/verification/rvgen/rvgen/container.py
 rename tools/verification/{dot2 =3D> rvgen/rvgen}/dot2c.py (99%)
 create mode 100644 tools/verification/rvgen/rvgen/dot2k.py
 rename tools/verification/{dot2/dot2k.py =3D> rvgen/rvgen/generator.py} (5=
2%)
 create mode 100644 tools/verification/rvgen/rvgen/ltl2ba.py
 create mode 100644 tools/verification/rvgen/rvgen/ltl2k.py
 rename tools/verification/{dot2/dot2k_templates =3D> rvgen/rvgen/templates=
}/Kconfig (100%)
 create mode 100644 tools/verification/rvgen/rvgen/templates/container/Kcon=
fig
 rename tools/verification/{dot2/dot2k_templates/main_container.c =3D> rvge=
n/rvgen/templates/container/main.c} (100%)
 rename tools/verification/{dot2/dot2k_templates/main_container.h =3D> rvge=
n/rvgen/templates/container/main.h} (100%)
 rename tools/verification/{dot2/dot2k_templates =3D> rvgen/rvgen/templates=
/dot2k}/main.c (100%)
 rename tools/verification/{dot2/dot2k_templates =3D> rvgen/rvgen/templates=
/dot2k}/trace.h (100%)
 create mode 100644 tools/verification/rvgen/rvgen/templates/ltl2k/main.c
 create mode 100644 tools/verification/rvgen/rvgen/templates/ltl2k/trace.h

--=20
2.39.5


