Return-Path: <linux-kernel+bounces-749921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60879B154C8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80262188967D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BB92797BE;
	Tue, 29 Jul 2025 21:43:30 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE3522539D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753825409; cv=none; b=BR1DGYrBguSZVy+LhXKbGVtHLyt8g32fwK29ml5V02p/gxNt13jfZuCpO7emxUel88SIEFEPkABYKET98wT5WGHTSzTzrw5f5pSLbk39G4J8BFSY0ZOa4FuxOEsKueaMtO5L0GB46dDE9NumXnn69MEG2XJ6xcHR/EE0jQImeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753825409; c=relaxed/simple;
	bh=CL/fsgsK6+/fEWHFkGUXEJnhZNeeGFFAmoLaV1R2ifQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AAjKhMBv8QTGPb5ZwD++Gs1LOikPU73lNfxLGKcbI1dVObhy5UAw1VguHvDnKPr0xQskL9ynRAUt0bC8diSbaWrJ827eam1KZ1YBK+G53m9hv7lugbRWWbT52qJj6VEMtDpgFk1uYGuhSV90GQJC40WBsDLigQwWa0KrmB4tZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 60888113184;
	Tue, 29 Jul 2025 21:43:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 9AEB820011;
	Tue, 29 Jul 2025 21:43:17 +0000 (UTC)
Date: Tue, 29 Jul 2025 17:43:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>, John Kacur
 <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>
Subject: [GIT PULL] runtime verification: Updates for 6.17
Message-ID: <20250729174332.3acd1a86@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: u6zchandicifgt5y5krkgse6ddkofrcx
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 9AEB820011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ON4qOlSlcpwo//qtLB9Emszes1Vt6NNg=
X-HE-Tag: 1753825397-580515
X-HE-Meta: U2FsdGVkX19Y+GSb/KTFPmIrsT2Jab6kYZNzgvtlP+y719In9tB11pfLPQIo8p5rTdzHUGxdMT3mVjXpK3Rx2+kHQM2n1di/xpAE2RbXHyk8e6A46qQfj8Sc9v/3FmzYtBb0seQZ7W5UQtc48/cjVl4fTIKaPM0WQSpo6/YsUaV/MCbMJuBYfPqKJV6sJbjWa7myWgp01gYyMdGKeeL38x1ImQpG6vXfeMK8GsWRhJ2o8hmY6/HuIcHsJVkqX1fCV3C4/vaAlIZKrGOidus7C0UsfpTvsevSzeiwxTpAG7xQQmZTSBerdaEw7WikCPEk8OkC8iuei3pWQQeecQBiNLQhOp2jQL5ihK9BAm7fnfPmKS2TubHMkQ==


Linus,

Runtime verification changes for 6.17

- Added Linear temporal logic monitors for RT application

  Real-time applications may have design flaws causing them to have
  unexpected latency. For example, the applications may raise page faults, or
  may be blocked trying to take a mutex without priority inheritance.

  However, while attempting to implement DA monitors for these real-time
  rules, deterministic automaton is found to be inappropriate as the
  specification language. The automaton is complicated, hard to understand,
  and error-prone.

  For these cases, linear temporal logic is found to be more suitable. The
  LTL is more concise and intuitive.

- Make printk_deferred() public

  The new monitors needed access to printk_deferred(). Make them visible for
  the entire kernel.

- Add a vpanic() to allow for va_list to be passed to panic.

- Add rtapp container monitor.

  A collection of monitors that check for common problems with real-time
  applications that cause unexpected latency.

- Add page fault tracepoints to risc-v

  These tracepoints are necessary to for the RV monitor to run on risc-v.

- Fix the behaviour of the rv tool with -s and idle tasks.

- Allow the rv tool to gracefully terminate with SIGTERM

- Adjusts dot2c not to create lines over 100 columns

- Properly order nested monitors in the RV Kconfig file

- Return the registration error in all DA monitor instead of 0

- Update and add new sched collection monitors

  Replace tss and sncid monitors with more complete sts:
  Not only prove that switches occur in scheduling context and scheduling
  needs interrupt disabled but also that each call to the scheduler
  disables interrupts to (optionally) switch.

  New monitor: nrp
   Preemption requires need resched which is cleared by any switch
   (includes a non optimal workaround for /nested/ preemptions)

  New monitor: sssw
   suspension requires setting the task to sleepable and, after the
   switch occurs, the task requires a wakeup to come back to runnable

  New monitor: opid
   waking and need-resched operations occur with interrupts and
   preemption disabled or in IRQ without explicitly disabling preemption


Please pull the latest trace-rv-6.17 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-rv-6.17

Tag SHA1: 70f4131d758600306632a4263c3b3c592a726f22
Head SHA1: 614384533dfe99293a7ff1bce3d4389adadbb759


Gabriele Monaco (14):
      tools/rv: Do not skip idle in trace
      tools/rv: Stop gracefully also on SIGTERM
      tools/dot2c: Fix generated files going over 100 column limit
      verification/rvgen: Organise Kconfig entries for nested monitors
      rv: Return init error when registering monitors
      rv: Add da_handle_start_run_event_ to per-task monitors
      rv: Remove trailing whitespace from tracepoint string
      rv: Use strings in da monitors tracepoints
      rv: Adjust monitor dependencies
      rv: Retry when da monitor detects race conditions
      sched: Adapt sched tracepoints for RV task model
      rv: Replace tss and sncid monitors with more complete sts
      rv: Add nrp and sssw per-task monitors
      rv: Add opid per-cpu monitor

Nam Cao (34):
      rv: Add #undef TRACE_INCLUDE_FILE
      printk: Make vprintk_deferred() public
      panic: Add vpanic()
      rv: Let the reactors take care of buffers
      rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
      rv: Add support for LTL monitors
      rv: Add rtapp container monitor
      riscv: mm: Add page fault trace points
      rv: Add rtapp_pagefault monitor
      rv: Add rtapp_sleep monitor
      rv: Add documentation for rtapp monitor
      rv: Allow to configure the number of per-task monitor
      objtool: Add vpanic() to the noreturn list
      panic: Fix up description of vpanic()
      rv/ltl: Do not execute the Buchi automaton twice on start condition
      verification/dot2k: Make a separate dot2k_templates/Kconfig_container
      verification/dot2k: Remove __buff_to_string()
      verification/dot2k: Replace is_container() hack with subparsers
      verification/dot2k: Prepare the frontend for LTL inclusion
      Documentation/rv: Prepare monitor synthesis document for LTL inclusion
      verification/rvgen: Restructure the templates files
      verification/rvgen: Restructure the classes to prepare for LTL inclusion
      verification/rvgen: Add support for linear temporal logic
      Documentation/rv: Add documentation for linear temporal logic monitors
      verification/rvgen: Support the 'next' operator
      verification/rvgen: Generate each variable definition only once
      verification/rvgen: Do not generate unused variables
      rv: Remove unused field in struct rv_monitor_def
      rv: Merge struct rv_monitor_def into struct rv_monitor
      rv: Merge struct rv_reactor_def into struct rv_reactor
      rv: Remove rv_reactor's reference counter
      rv: Remove struct rv_monitor::reacting
      rv: Fix wrong type cast in monitors_show()
      rv: Fix wrong type cast in reactors_show() and monitor_reactor_show()

----
 Documentation/trace/rv/da_monitor_synthesis.rst    | 147 ------
 Documentation/trace/rv/index.rst                   |   4 +-
 Documentation/trace/rv/linear_temporal_logic.rst   | 134 +++++
 Documentation/trace/rv/monitor_rtapp.rst           | 133 +++++
 Documentation/trace/rv/monitor_sched.rst           | 307 +++++++++--
 Documentation/trace/rv/monitor_synthesis.rst       | 271 ++++++++++
 arch/riscv/mm/fault.c                              |   8 +
 include/linux/panic.h                              |   3 +
 include/linux/printk.h                             |   7 +
 include/linux/rv.h                                 |  86 +++-
 include/linux/sched.h                              |  15 +-
 include/rv/da_monitor.h                            | 172 +++----
 include/rv/ltl_monitor.h                           | 186 +++++++
 include/trace/events/sched.h                       |  12 +-
 kernel/fork.c                                      |   5 +-
 kernel/panic.c                                     |  18 +-
 kernel/printk/internal.h                           |   1 -
 kernel/sched/core.c                                |  13 +-
 kernel/trace/rv/Kconfig                            |  43 +-
 kernel/trace/rv/Makefile                           |   9 +-
 kernel/trace/rv/monitors/{tss => nrp}/Kconfig      |  12 +-
 kernel/trace/rv/monitors/nrp/nrp.c                 | 138 +++++
 kernel/trace/rv/monitors/nrp/nrp.h                 |  75 +++
 kernel/trace/rv/monitors/nrp/nrp_trace.h           |  15 +
 kernel/trace/rv/monitors/opid/Kconfig              |  19 +
 kernel/trace/rv/monitors/opid/opid.c               | 168 ++++++
 kernel/trace/rv/monitors/opid/opid.h               | 104 ++++
 .../{sncid/sncid_trace.h => opid/opid_trace.h}     |   8 +-
 kernel/trace/rv/monitors/pagefault/Kconfig         |  20 +
 kernel/trace/rv/monitors/pagefault/pagefault.c     |  88 ++++
 kernel/trace/rv/monitors/pagefault/pagefault.h     |  64 +++
 .../trace/rv/monitors/pagefault/pagefault_trace.h  |  14 +
 kernel/trace/rv/monitors/rtapp/Kconfig             |  11 +
 kernel/trace/rv/monitors/rtapp/rtapp.c             |  33 ++
 kernel/trace/rv/monitors/rtapp/rtapp.h             |   3 +
 kernel/trace/rv/monitors/sched/Kconfig             |   1 +
 kernel/trace/rv/monitors/sched/sched.c             |   3 +-
 kernel/trace/rv/monitors/sco/sco.c                 |   7 +-
 kernel/trace/rv/monitors/scpd/Kconfig              |   2 +-
 kernel/trace/rv/monitors/scpd/scpd.c               |   7 +-
 kernel/trace/rv/monitors/sleep/Kconfig             |  22 +
 kernel/trace/rv/monitors/sleep/sleep.c             | 237 +++++++++
 kernel/trace/rv/monitors/sleep/sleep.h             | 257 ++++++++++
 kernel/trace/rv/monitors/sleep/sleep_trace.h       |  14 +
 kernel/trace/rv/monitors/sncid/sncid.c             |  96 ----
 kernel/trace/rv/monitors/sncid/sncid.h             |  49 --
 kernel/trace/rv/monitors/snep/Kconfig              |   2 +-
 kernel/trace/rv/monitors/snep/snep.c               |   7 +-
 kernel/trace/rv/monitors/snep/snep.h               |  14 +-
 kernel/trace/rv/monitors/snroc/snroc.c             |   3 +-
 kernel/trace/rv/monitors/{sncid => sssw}/Kconfig   |  10 +-
 kernel/trace/rv/monitors/sssw/sssw.c               | 116 +++++
 kernel/trace/rv/monitors/sssw/sssw.h               | 105 ++++
 kernel/trace/rv/monitors/sssw/sssw_trace.h         |  15 +
 kernel/trace/rv/monitors/sts/Kconfig               |  19 +
 kernel/trace/rv/monitors/sts/sts.c                 | 156 ++++++
 kernel/trace/rv/monitors/sts/sts.h                 | 117 +++++
 .../monitors/{tss/tss_trace.h => sts/sts_trace.h}  |   8 +-
 kernel/trace/rv/monitors/tss/tss.c                 |  91 ----
 kernel/trace/rv/monitors/tss/tss.h                 |  47 --
 kernel/trace/rv/monitors/wip/Kconfig               |   2 +-
 kernel/trace/rv/monitors/wip/wip.c                 |   3 +-
 kernel/trace/rv/monitors/wwnr/wwnr.c               |   3 +-
 kernel/trace/rv/reactor_panic.c                    |   8 +-
 kernel/trace/rv/reactor_printk.c                   |   8 +-
 kernel/trace/rv/rv.c                               | 220 ++++----
 kernel/trace/rv/rv.h                               |  39 +-
 kernel/trace/rv/rv_reactors.c                      | 138 ++---
 kernel/trace/rv/rv_trace.h                         | 166 ++++--
 tools/objtool/noreturns.h                          |   1 +
 tools/verification/dot2/Makefile                   |  26 -
 tools/verification/dot2/dot2k                      |  53 --
 tools/verification/models/rtapp/pagefault.ltl      |   1 +
 tools/verification/models/rtapp/sleep.ltl          |  22 +
 tools/verification/models/sched/nrp.dot            |  29 ++
 tools/verification/models/sched/opid.dot           |  35 ++
 tools/verification/models/sched/sncid.dot          |  18 -
 tools/verification/models/sched/sssw.dot           |  30 ++
 tools/verification/models/sched/sts.dot            |  38 ++
 tools/verification/models/sched/tss.dot            |  18 -
 tools/verification/rv/src/in_kernel.c              |   4 +-
 tools/verification/rv/src/rv.c                     |   1 +
 tools/verification/rvgen/.gitignore                |   3 +
 tools/verification/rvgen/Makefile                  |  27 +
 tools/verification/rvgen/__main__.py               |  67 +++
 tools/verification/{dot2 => rvgen}/dot2c           |   2 +-
 .../verification/{dot2 => rvgen/rvgen}/automata.py |   0
 tools/verification/rvgen/rvgen/container.py        |  32 ++
 tools/verification/{dot2 => rvgen/rvgen}/dot2c.py  |  22 +-
 tools/verification/rvgen/rvgen/dot2k.py            | 129 +++++
 .../{dot2/dot2k.py => rvgen/rvgen/generator.py}    | 265 +++-------
 tools/verification/rvgen/rvgen/ltl2ba.py           | 566 +++++++++++++++++++++
 tools/verification/rvgen/rvgen/ltl2k.py            | 271 ++++++++++
 .../rvgen/templates}/Kconfig                       |   0
 .../rvgen/rvgen/templates/container/Kconfig        |   5 +
 .../rvgen/templates/container/main.c}              |   3 +-
 .../rvgen/templates/container/main.h}              |   0
 .../rvgen/templates/dot2k}/main.c                  |   3 +-
 .../rvgen/templates/dot2k}/trace.h                 |   0
 .../rvgen/rvgen/templates/ltl2k/main.c             | 102 ++++
 .../rvgen/rvgen/templates/ltl2k/trace.h            |  14 +
 101 files changed, 4860 insertions(+), 1265 deletions(-)
 delete mode 100644 Documentation/trace/rv/da_monitor_synthesis.rst
 create mode 100644 Documentation/trace/rv/linear_temporal_logic.rst
 create mode 100644 Documentation/trace/rv/monitor_rtapp.rst
 create mode 100644 Documentation/trace/rv/monitor_synthesis.rst
 create mode 100644 include/rv/ltl_monitor.h
 rename kernel/trace/rv/monitors/{tss => nrp}/Kconfig (51%)
 create mode 100644 kernel/trace/rv/monitors/nrp/nrp.c
 create mode 100644 kernel/trace/rv/monitors/nrp/nrp.h
 create mode 100644 kernel/trace/rv/monitors/nrp/nrp_trace.h
 create mode 100644 kernel/trace/rv/monitors/opid/Kconfig
 create mode 100644 kernel/trace/rv/monitors/opid/opid.c
 create mode 100644 kernel/trace/rv/monitors/opid/opid.h
 rename kernel/trace/rv/monitors/{sncid/sncid_trace.h => opid/opid_trace.h} (66%)
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
 delete mode 100644 kernel/trace/rv/monitors/sncid/sncid.c
 delete mode 100644 kernel/trace/rv/monitors/sncid/sncid.h
 rename kernel/trace/rv/monitors/{sncid => sssw}/Kconfig (58%)
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw.c
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw.h
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw_trace.h
 create mode 100644 kernel/trace/rv/monitors/sts/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sts/sts.c
 create mode 100644 kernel/trace/rv/monitors/sts/sts.h
 rename kernel/trace/rv/monitors/{tss/tss_trace.h => sts/sts_trace.h} (67%)
 delete mode 100644 kernel/trace/rv/monitors/tss/tss.c
 delete mode 100644 kernel/trace/rv/monitors/tss/tss.h
 delete mode 100644 tools/verification/dot2/Makefile
 delete mode 100644 tools/verification/dot2/dot2k
 create mode 100644 tools/verification/models/rtapp/pagefault.ltl
 create mode 100644 tools/verification/models/rtapp/sleep.ltl
 create mode 100644 tools/verification/models/sched/nrp.dot
 create mode 100644 tools/verification/models/sched/opid.dot
 delete mode 100644 tools/verification/models/sched/sncid.dot
 create mode 100644 tools/verification/models/sched/sssw.dot
 create mode 100644 tools/verification/models/sched/sts.dot
 delete mode 100644 tools/verification/models/sched/tss.dot
 create mode 100644 tools/verification/rvgen/.gitignore
 create mode 100644 tools/verification/rvgen/Makefile
 create mode 100644 tools/verification/rvgen/__main__.py
 rename tools/verification/{dot2 => rvgen}/dot2c (97%)
 rename tools/verification/{dot2 => rvgen/rvgen}/automata.py (100%)
 create mode 100644 tools/verification/rvgen/rvgen/container.py
 rename tools/verification/{dot2 => rvgen/rvgen}/dot2c.py (92%)
 create mode 100644 tools/verification/rvgen/rvgen/dot2k.py
 rename tools/verification/{dot2/dot2k.py => rvgen/rvgen/generator.py} (51%)
 create mode 100644 tools/verification/rvgen/rvgen/ltl2ba.py
 create mode 100644 tools/verification/rvgen/rvgen/ltl2k.py
 rename tools/verification/{dot2/dot2k_templates => rvgen/rvgen/templates}/Kconfig (100%)
 create mode 100644 tools/verification/rvgen/rvgen/templates/container/Kconfig
 rename tools/verification/{dot2/dot2k_templates/main_container.c => rvgen/rvgen/templates/container/main.c} (92%)
 rename tools/verification/{dot2/dot2k_templates/main_container.h => rvgen/rvgen/templates/container/main.h} (100%)
 rename tools/verification/{dot2/dot2k_templates => rvgen/rvgen/templates/dot2k}/main.c (96%)
 rename tools/verification/{dot2/dot2k_templates => rvgen/rvgen/templates/dot2k}/trace.h (100%)
 create mode 100644 tools/verification/rvgen/rvgen/templates/ltl2k/main.c
 create mode 100644 tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
---------------------------

