Return-Path: <linux-kernel+bounces-834163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B42BA414E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49B9622DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02DB19E992;
	Fri, 26 Sep 2025 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSJsv4go"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513E634BA4D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896259; cv=none; b=IFFPoW0IepbJ5RgLbW1HHLd7jUXulaoPespMW35U4v7qryLe3kv5948ynWO3Uew3VX9aDDAlH7FMih7y7WH4+ob5Q1a1KaQHdGsiaEVhcJExaTCrCW268NFewjXyU6vb4AXPhmwXGOeAD74lc2qiJF2F4UyUvxM6Gdx8CZoV8qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896259; c=relaxed/simple;
	bh=OTubWr8aGIM8X5wNilenHrSAF+Iaw2t6j52eFnya6/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cRN3AvFSXEubsKGnYRVOtmgKSNQ12EMgZMJ6cEdGzjVbqmJ1ZJtqJB8ky327grScEBYg5T0idBEiYFexavas6ZnzdOnXpWtNfTSel/oyDLHm8CQFVTSCJ8pdK+05BmwuCHSg27cFMO6vC/HNsuVGkXsbPcIX+A2rF7iY4Ye/Lfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSJsv4go; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E949C4CEF4;
	Fri, 26 Sep 2025 14:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896258;
	bh=OTubWr8aGIM8X5wNilenHrSAF+Iaw2t6j52eFnya6/0=;
	h=Date:From:To:Cc:Subject:From;
	b=mSJsv4gotqv7s0b7LicrMIWuV+EeYkJU/dit1x+80sQ6yQU9frl+BQ/oXSUkmIusx
	 CK/8Wu2wJkEE2R10xvOkZLE/0TFVrteVrjTUyVJmSDsGORrPdSNxdErHzgWp3M3SKq
	 XUJjVisQxBs2KjT2M5t1NaI7B+1uo8/Waxr8a/wPm5ucVOE/V86QcQ4xjk6jasJlZI
	 C8Bni1Y3WaTETuULyI1hNugLBcZpslfPQ81wEHBm1rmSQC1B85x6nKYDoGuxbE4avg
	 SUzmzHTq8U+vGKVcpoU1WTtlHfbORzfMUuLIKiL1yk+lnXMsAqfB7yemN+TFaY71oE
	 XFudY4tlerhzA==
Date: Fri, 26 Sep 2025 16:17:33 +0200
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
Subject: [GIT PULL] Scheduler updates for v6.18
Message-ID: <aNagfRAEhfbLelo9@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2025-09-26

   # HEAD: 45b7f780739a3145aeef24d2dfa02517a6c82ed6 sched: Fix some typos in include/linux/preempt.h

( Merge note: we've stopped using Link tags for the purpose of tip-bot 
  lkml email notifications during the v6.18 development window, and 
  thus commits applied after September 15-ish only have Links if they 
  are particularly informative. Commits before that still have the 
  old-style Link tags. )

Scheduler updates for v6.18:

Core scheduler changes:

 - Make migrate_{en,dis}able() inline, to improve performance
   (Menglong Dong)

 - Move STDL_INIT() functions out-of-line (Peter Zijlstra)

 - Unify the SCHED_{SMT,CLUSTER,MC} Kconfig (Peter Zijlstra)

Fair scheduling:

 - Defer throttling when tasks exit to user-space, to reduce the
   chance & impact of throttle-preemption with held locks and
   other resources. (Aaron Lu, Valentin Schneider)

 - Get rid of sched_domains_curr_level hack for tl->cpumask(),
   as the warning was getting triggered on certain topologies.
   (Peter Zijlstra)

Misc cleanups & fixes:

 - Header cleanups (Menglong Dong)

 - Fix race in push_dl_task() (Harshit Agarwal)

 Thanks,

	Ingo

------------------>
Aaron Lu (6):
      sched/fair: Task based throttle time accounting
      sched/fair: Get rid of throttled_lb_pair()
      sched/fair: Propagate load for throttled cfs_rq
      sched/fair: update_cfs_group() for throttled cfs_rqs
      sched/fair: Do not special case tasks in throttled hierarchy
      sched/fair: Do not balance task to a throttled cfs_rq

Harshit Agarwal (1):
      sched/deadline: Fix race in push_dl_task()

Menglong Dong (4):
      arch: Add the macro COMPILE_OFFSETS to all the asm-offsets.c
      rcu: Replace preempt.h with sched.h in include/linux/rcupdate.h
      sched: Make migrate_{en,dis}able() inline
      sched: Fix some typos in include/linux/preempt.h

Peter Zijlstra (3):
      sched/fair: Get rid of sched_domains_curr_level hack for tl->cpumask()
      sched: Move STDL_INIT() functions out-of-line
      sched: Unify the SCHED_{SMT,CLUSTER,MC} Kconfig

Valentin Schneider (3):
      sched/fair: Add related data structure for task based throttle
      sched/fair: Implement throttle task work and related helpers
      sched/fair: Switch to task based throttle model


 Kbuild                               |  13 +-
 arch/Kconfig                         |  38 +++
 arch/alpha/kernel/asm-offsets.c      |   1 +
 arch/arc/kernel/asm-offsets.c        |   1 +
 arch/arm/Kconfig                     |  18 +-
 arch/arm/kernel/asm-offsets.c        |   2 +
 arch/arm64/Kconfig                   |  26 +-
 arch/arm64/kernel/asm-offsets.c      |   1 +
 arch/csky/kernel/asm-offsets.c       |   1 +
 arch/hexagon/kernel/asm-offsets.c    |   1 +
 arch/loongarch/Kconfig               |  19 +-
 arch/loongarch/kernel/asm-offsets.c  |   2 +
 arch/m68k/kernel/asm-offsets.c       |   1 +
 arch/microblaze/kernel/asm-offsets.c |   1 +
 arch/mips/Kconfig                    |  16 +-
 arch/mips/kernel/asm-offsets.c       |   2 +
 arch/nios2/kernel/asm-offsets.c      |   1 +
 arch/openrisc/kernel/asm-offsets.c   |   1 +
 arch/parisc/Kconfig                  |   9 +-
 arch/parisc/kernel/asm-offsets.c     |   1 +
 arch/powerpc/Kconfig                 |  11 +-
 arch/powerpc/include/asm/topology.h  |   2 +
 arch/powerpc/kernel/asm-offsets.c    |   1 +
 arch/powerpc/kernel/smp.c            |  27 +-
 arch/riscv/Kconfig                   |   9 +-
 arch/riscv/kernel/asm-offsets.c      |   1 +
 arch/s390/Kconfig                    |   8 +-
 arch/s390/kernel/asm-offsets.c       |   1 +
 arch/s390/kernel/topology.c          |  20 +-
 arch/sh/kernel/asm-offsets.c         |   1 +
 arch/sparc/Kconfig                   |  20 +-
 arch/sparc/kernel/asm-offsets.c      |   1 +
 arch/um/kernel/asm-offsets.c         |   2 +
 arch/x86/Kconfig                     |  27 +-
 arch/x86/kernel/smpboot.c            |   8 +-
 arch/xtensa/kernel/asm-offsets.c     |   1 +
 include/linux/preempt.h              |  11 +-
 include/linux/rcupdate.h             |   2 +-
 include/linux/sched.h                | 118 +++++++++
 include/linux/sched/topology.h       |  29 +--
 include/linux/topology.h             |   2 +-
 kernel/bpf/verifier.c                |   1 +
 kernel/sched/core.c                  |  66 ++---
 kernel/sched/deadline.c              |  73 ++++--
 kernel/sched/fair.c                  | 489 +++++++++++++++++++++--------------
 kernel/sched/pelt.h                  |   4 +-
 kernel/sched/rq-offsets.c            |  12 +
 kernel/sched/sched.h                 |   7 +-
 kernel/sched/topology.c              |  73 ++++--
 49 files changed, 686 insertions(+), 496 deletions(-)
 create mode 100644 kernel/sched/rq-offsets.c

