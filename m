Return-Path: <linux-kernel+bounces-747552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3F1B13514
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3FD3B8633
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3FC221FD8;
	Mon, 28 Jul 2025 06:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0DrZofB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3146216E24
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753685329; cv=none; b=IPGdGVwcQ2isaTOwqUbZMVH1fbIDx+hv34Qb51/wdoxlZA0jhW8kuamcDYhy8F7mOgwIp5WmgjrHDkON8gZ8D749wk5Br5KCRNsbuoIyxd/5OCB1sxWnEBpnfbttT71rVsHUu72qz6eO3ioLv+gIEPx66fG+L0mjqesx2GoW6Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753685329; c=relaxed/simple;
	bh=FTin81NIldxhK2y6cPQq3VtubEXGGKyEE5sUNuQu+tw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VEAJLlUKwrX8aIFyzAwKjXv4v/RFQjQTNEgk2iINmZbHcwz11cUTNYFB4MfaiQPMYObiA22EpArZqm+YBoWJfN8Q5ATHnkXGh06kb3FYiquW6ET0sE4o34YRjt6GTzUnmZoBo7JApGSEAhFBLNSGp1tS0OF+oZnTIi0NuZS168g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0DrZofB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B762FC4CEE7;
	Mon, 28 Jul 2025 06:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753685329;
	bh=FTin81NIldxhK2y6cPQq3VtubEXGGKyEE5sUNuQu+tw=;
	h=Date:From:To:Cc:Subject:From;
	b=K0DrZofBBGqKH33/7oVSY03etmbPUo0xA+ldlos0zrUJYypjyspXyXfCEF9Kc0Zw7
	 E4k1yehRvzXeP4ZUOYqlOn4bRAg9l5YTCjr7tv8rMD2NCsO+KjGE8R7mwLRhE0uh9t
	 IpYt37Tj/UTBqpHa8Yqf8h2x3kVS7eu8qpulQfO3yljUCYiSrm89Z/lOzklTPgKkVt
	 4UfsEU26KZqqgmoPeZUuh4zrzQRNC05XG6h/XIYbhx21b1fB+k1T4QhdiEjkIUxmY3
	 GpkGu3GzUgbRypVoYiRQnvrslzAptUrFcYwld68JBM3T9qrpVQ34XLA/2C186PQgCk
	 +uOXkQDJ3pDJw==
Date: Mon, 28 Jul 2025 08:48:44 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Tejun Heo <tj@kernel.org>, Valentin Schneider <vschneid@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [GIT PULL] Scheduler updates for v6.17
Message-ID: <aIcdTI3e04W_RdM_@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest sched/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2025-07-28

   # HEAD: 1b5f1454091e9e9fb5c944b3161acf4ec0894d0d sched/idle: Remove play_idle()

Scheduler updates for v6.17:

Core scheduler changes:

 - Better tracking of maximum lag of tasks in presence of different
   slices duration, for better handling of lag in the fair
   scheduler. (Vincent Guittot)

 - Clean up and standardize #if/#else/#endif markers throughout
   the entire scheduler code base (Ingo Molnar)

 - Make SMP unconditional: build the SMP scheduler's
   data structures and logic on UP kernel too, even though
   they are not used, to simplify the scheduler and remove
   around 200 #ifdef/[#else]/#endif blocks from the
   scheduler. (Ingo Molnar)

 - Reorganize cgroup bandwidth control interface handling
   for better interfacing with sched_ext (Tejun Heo)

Balancing:

 - Bump sd->max_newidle_lb_cost when newidle balance fails (Chris Mason)
 - Remove sched_domain_topology_level::flags to simplify the code (Prateek Nayak)
 - Simplify and clean up build_sched_topology() (Li Chen)
 - Optimize build_sched_topology() on large machines (Li Chen)

Real-time scheduling:

 - Add initial version of proxy execution: a mechanism for mutex-owning
   tasks to inherit the scheduling context of higher priority waiters.
   Currently limited to a single runqueue and conditional on CONFIG_EXPERT,
   and other limitations. (John Stultz, Peter Zijlstra, Valentin Schneider)

 - Deadline scheduler (Juri Lelli):

   - Fix dl_servers initialization order (Juri Lelli)
   - Fix DL scheduler's root domain reinitialization logic (Juri Lelli)
   - Fix accounting bugs after global limits change (Juri Lelli)
   - Fix scalability regression by implementing less agressive dl_server handling
     (Peter Zijlstra)

PSI:

 - Improve scalability by optimizing psi_group_change() cpu_clock() usage
   (Peter Zijlstra)

Rust changes:

 - Make Task, CondVar and PollCondVar methods inline to avoid unnecessary
   function calls (Kunwu Chan, Panagiotis Foliadis)

 - Add might_sleep() support for Rust code: Rust's "#[track_caller]"
   mechanism is used so that Rust's might_sleep() doesn't need to be
   defined as a macro (Fujita Tomonori)

 - Introduce file_from_location() (Boqun Feng)

Debugging & instrumentation:

 - Make clangd usable with scheduler source code files again (Peter Zijlstra)

 - tools: Add root_domains_dump.py which dumps root domains info (Juri Lelli)

 - tools: Add dl_bw_dump.py for printing bandwidth accounting info (Juri Lelli)

Misc cleanups & fixes:

 - Remove play_idle() (Feng Lee)

 - Fix check_preemption_disabled() (Sebastian Andrzej Siewior)

 - Do not call __put_task_struct() on RT if pi_blocked_on is set
   (Luis Claudio R. Goncalves)

 - Correct the comment in place_entity() (wang wei)

 Thanks,

	Ingo

------------------>
Boqun Feng (1):
      rust: Introduce file_from_location()

Chris Mason (1):
      sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails

FUJITA Tomonori (1):
      rust: task: Add Rust version of might_sleep()

Feng Lee (1):
      sched/idle: Remove play_idle()

Ingo Molnar (43):
      sched: Clean up and standardize #if/#else/#endif markers in sched/autogroup.[ch]
      sched: Clean up and standardize #if/#else/#endif markers in sched/clock.c
      sched: Clean up and standardize #if/#else/#endif markers in sched/core.c
      sched: Clean up and standardize #if/#else/#endif markers in sched/cpufreq_schedutil.c
      sched: Clean up and standardize #if/#else/#endif markers in sched/cpupri.h
      sched: Clean up and standardize #if/#else/#endif markers in sched/cputime.c
      sched: Clean up and standardize #if/#else/#endif markers in sched/deadline.c
      sched: Clean up and standardize #if/#else/#endif markers in sched/debug.c
      sched: Clean up and standardize #if/#else/#endif markers in sched/fair.c
      sched: Clean up and standardize #if/#else/#endif markers in sched/idle.c
      sched: Clean up and standardize #if/#else/#endif markers in sched/loadavg.c
      sched: Clean up and standardize #if/#else/#endif markers in sched/pelt.[ch]
      sched: Clean up and standardize #if/#else/#endif markers in sched/psi.c
      sched: Clean up and standardize #if/#else/#endif markers in sched/rt.c
      sched: Clean up and standardize #if/#else/#endif markers in sched/sched.h
      sched: Clean up and standardize #if/#else/#endif markers in sched/stats.[ch]
      sched: Clean up and standardize #if/#else/#endif markers in sched/syscalls.c
      sched: Clean up and standardize #if/#else/#endif markers in sched/topology.c
      sched/smp: Always define sched_domains_mutex_lock()/unlock(), def_root_domain and sched_domains_mutex
      sched/smp: Make SMP unconditional
      sched/smp: Always define is_percpu_thread() and scheduler_ipi()
      sched/smp: Always define rq->hrtick_csd
      sched/smp: Use the SMP version of try_to_wake_up()
      sched/smp: Use the SMP version of __task_needs_rq_lock()
      sched/smp: Use the SMP version of wake_up_new_task()
      sched/smp: Use the SMP version of sched_exec()
      sched/smp: Use the SMP version of idle_thread_set_boot_cpu()
      sched/smp: Use the SMP version of the RT scheduling class
      sched/smp: Use the SMP version of the deadline scheduling class
      sched/smp: Use the SMP version of scheduler debugging data
      sched/smp: Use the SMP version of schedstats
      sched/smp: Use the SMP version of the scheduler syscalls
      sched/smp: Use the SMP version of sched_update_asym_prefer_cpu()
      sched/smp: Use the SMP version of the idle scheduling class
      sched/smp: Use the SMP version of the stop-CPU scheduling class
      sched/smp: Use the SMP version of cpu_of()
      sched/smp: Use the SMP version of is_migration_disabled()
      sched/smp: Use the SMP version of rq_pin_lock()
      sched/smp: Use the SMP version of task_on_cpu()
      sched/smp: Use the SMP version of WF_ and SD_ flag sanity checks
      sched/smp: Use the SMP version of ENQUEUE_MIGRATED
      sched/smp: Use the SMP version of add_nr_running()
      sched/smp: Use the SMP version of double_rq_clock_clear_update()

John Stultz (4):
      sched: Add CONFIG_SCHED_PROXY_EXEC & boot argument to enable/disable
      sched: Move update_curr_task logic into update_curr_se
      sched: Fix runtime accounting w/ split exec & sched contexts
      sched: Add an initial sketch of the find_proxy_task() function

Juri Lelli (5):
      sched/deadline: Initialize dl_servers after SMP
      sched/deadline: Reset extra_bw to max_bw when clearing root domains
      sched/deadline: Fix accounting after global limits change
      tools/sched: Add root_domains_dump.py which dumps root domains info
      tools/sched: Add dl_bw_dump.py for printing bandwidth accounting info

K Prateek Nayak (1):
      sched/topology: Remove sched_domain_topology_level::flags

Kunwu Chan (2):
      rust: sync: Mark CondVar::notify_*() inline
      rust: sync: Mark PollCondVar::drop() inline

Li Chen (4):
      smpboot: introduce SDTL_INIT() helper to tidy sched topology setup
      x86/smpboot: remove redundant CONFIG_SCHED_SMT
      x86/smpboot: moves x86_topology to static initialize and truncate
      x86/smpboot: avoid SMT domain attach/destroy if SMT is not enabled

Luis Claudio R. Goncalves (1):
      sched: Do not call __put_task_struct() on rt if pi_blocked_on is set

Panagiotis Foliadis (1):
      rust: task: Mark Task methods inline

Peter Zijlstra (5):
      sched: Make clangd usable
      sched/psi: Optimize psi_group_change() cpu_clock() usage
      sched/deadline: Less agressive dl_server handling
      locking/mutex: Rework task_struct::blocked_on
      sched: Start blocked_on chain processing in find_proxy_task()

Sebastian Andrzej Siewior (1):
      lib/smp_processor_id: Make migration check unconditional of SMP

Tejun Heo (4):
      sched/fair: Move max_cfs_quota_period decl and default_cfs_period() def from fair.c to sched.h
      sched/core: Relocate tg_get_cfs_*() and cpu_cfs_*_read_*()
      sched/core: Reorganize cgroup bandwidth control interface file reads
      sched/core: Reorganize cgroup bandwidth control interface file writes

Valentin Schneider (2):
      locking/mutex: Add p->blocked_on wrappers for correctness checks
      sched: Fix proxy/current (push,pull)ability

Vincent Guittot (6):
      sched/fair: Use protect_slice() instead of direct comparison
      sched/fair: Fix NO_RUN_TO_PARITY case
      sched/fair: Remove spurious shorter slice preemption
      sched/fair: Limit run to parity to the min slice of enqueued entities
      sched/fair: Fix entity's lag with run to parity
      sched/fair: Always trigger resched at the end of a protected period

wang wei (1):
      sched/eevdf: Correct the comment in place_entity


 Documentation/admin-guide/kernel-parameters.txt |   5 +
 MAINTAINERS                                     |   1 +
 arch/powerpc/kernel/smp.c                       |  25 +-
 arch/s390/kernel/topology.c                     |  10 +-
 arch/x86/kernel/smpboot.c                       |  51 +-
 include/linux/cpu.h                             |   5 -
 include/linux/preempt.h                         |   9 -
 include/linux/psi_types.h                       |   6 +-
 include/linux/sched.h                           | 148 ++--
 include/linux/sched/deadline.h                  |   4 -
 include/linux/sched/idle.h                      |   4 -
 include/linux/sched/nohz.h                      |   4 +-
 include/linux/sched/sd_flags.h                  |   8 -
 include/linux/sched/task.h                      |  31 +-
 include/linux/sched/topology.h                  |  39 +-
 init/Kconfig                                    |  15 +
 kernel/fork.c                                   |   3 +-
 kernel/locking/mutex-debug.c                    |   9 +-
 kernel/locking/mutex.c                          |  18 +
 kernel/locking/mutex.h                          |   3 +-
 kernel/locking/ww_mutex.h                       |  16 +-
 kernel/sched/autogroup.c                        |   9 +-
 kernel/sched/autogroup.h                        |   6 +-
 kernel/sched/build_policy.c                     |   6 +-
 kernel/sched/build_utility.c                    |   9 +-
 kernel/sched/clock.c                            |   7 +-
 kernel/sched/completion.c                       |   5 +
 kernel/sched/core.c                             | 869 ++++++++++++++----------
 kernel/sched/core_sched.c                       |   2 +
 kernel/sched/cpuacct.c                          |   2 +
 kernel/sched/cpudeadline.c                      |   1 +
 kernel/sched/cpudeadline.h                      |   4 +-
 kernel/sched/cpufreq.c                          |   1 +
 kernel/sched/cpufreq_schedutil.c                |   6 +-
 kernel/sched/cpupri.c                           |   1 +
 kernel/sched/cpupri.h                           |   5 +-
 kernel/sched/cputime.c                          |  17 +-
 kernel/sched/deadline.c                         | 208 +++---
 kernel/sched/debug.c                            |  47 +-
 kernel/sched/fair.c                             | 408 ++++-------
 kernel/sched/idle.c                             |  15 +-
 kernel/sched/isolation.c                        |   2 +
 kernel/sched/loadavg.c                          |   6 +-
 kernel/sched/membarrier.c                       |   2 +
 kernel/sched/pelt.c                             |   5 +-
 kernel/sched/pelt.h                             |  67 +-
 kernel/sched/psi.c                              | 129 ++--
 kernel/sched/rt.c                               | 112 +--
 kernel/sched/sched-pelt.h                       |   1 +
 kernel/sched/sched.h                            | 243 ++-----
 kernel/sched/smp.h                              |   7 +
 kernel/sched/stats.c                            |   5 +-
 kernel/sched/stats.h                            |  10 +-
 kernel/sched/stop_task.c                        |   5 +-
 kernel/sched/swait.c                            |   1 +
 kernel/sched/syscalls.c                         |  15 +-
 kernel/sched/topology.c                         |  57 +-
 kernel/sched/wait.c                             |   1 +
 kernel/sched/wait_bit.c                         |   3 +
 kernel/smpboot.c                                |   4 -
 lib/smp_processor_id.c                          |   2 -
 rust/helpers/task.c                             |   6 +
 rust/kernel/lib.rs                              |  48 ++
 rust/kernel/sync/condvar.rs                     |   3 +
 rust/kernel/sync/poll.rs                        |   1 +
 rust/kernel/task.rs                             |  33 +
 tools/sched/dl_bw_dump.py                       |  57 ++
 tools/sched/root_domains_dump.py                |  68 ++
 68 files changed, 1472 insertions(+), 1463 deletions(-)
 create mode 100644 tools/sched/dl_bw_dump.py
 create mode 100644 tools/sched/root_domains_dump.py

