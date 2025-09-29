Return-Path: <linux-kernel+bounces-836014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 244CFBA894E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2941891BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669B3286D4E;
	Mon, 29 Sep 2025 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLVh3ay5"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6316121FF23
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137747; cv=none; b=bP1Pa4SPm3FFPA9iS5Maf94fuUee1mjT/K3wFrpauMJg7zgb2x9YGxG6DCyEiG2abcCzRAD9paKzaJGsa/oiCdco1ci/viBRrut1YjHu0vHuEbeYGnR4EvJ/6BvSqMxd00Gb6yvrSpP5ScvMufBhCjdnb3/y8oxvnIcW5htdRIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137747; c=relaxed/simple;
	bh=I/aktwGo8Qo7qNKSEAuYs+SYS0Jet6DccxNE/NQAM3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4ptRODBKFRM/MTwGoUcmuX/w8q0G0r0iSjOf1b9Kfo5QTzJha9two39yHCKAceAWlwGpuy8qhHdJXeV6cofSmZW1PrEKxI40ZPS1GDC6TtvXcHmUmMHr5laYridNikUuFB6x0+vr/cZzRvAnprV2sEkvMfuuLmn1Z1RQ0J4FkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLVh3ay5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso208573466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137744; x=1759742544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zCTEeSK/ZHc7kNha81hnHCa1TBYpj5x5N+P5M+/ssL8=;
        b=hLVh3ay5ClJaHWxH/3vqq5EetLEl51spgeZQKNGm93g6maf99Np0q2EPwRCnuZoSGb
         sgjNYZpxaqsXjBkZiENmDH01xzxFDwKneyUliLSwBC/Ym+gxDFgSGXFFg6m51rrk8vND
         zq7/Dl9w3D340Tm93s2WiIf/7MEemKwXiIHyS0L1GzKBfDpMNZy07P6VuyfQMgB6qLno
         3zG4+ufzdcB8P2lqWvMvbmIhs5MfR4VxwnCLkOnKoixFDFoSER2lZ036I3Y9rJWb7f+E
         ukVftQLl6ROuOUNRPcvBac7/pFbuZ7iUwt136WJKqXjuDYVwWNVB85Na2SHv9npVmSDP
         eMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137744; x=1759742544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCTEeSK/ZHc7kNha81hnHCa1TBYpj5x5N+P5M+/ssL8=;
        b=FtW339rE04G8AXyeb73vaSO6gksQaIGGQ3+yzE46ChAcBnbOqzUsx3Wzoob4eCuEO3
         HbpZHaQgSVo0LwwkaEHppCXXbXsnz/mk+iyYhgMwtnuiiCRpfuLVM8bL+pLC0PEVi0Xe
         ixDKJ+n7E6eULWxRqShrJH0Qo6656+297LUTK6V4zuOoRrsR73xuNFXFTJv8aQRlal8z
         OWOVR+5D4m8VvUFSKMBT5hE/rN4CCWzUZfBl1g4WYdF8UhAefPZyBUqmS6JBxjz79WKD
         3BYCl70WkGyM1eE9bw7pmyAZ7yRbbsiFaCylMf3YSAYF9jRvF+csFdeZVM+3fC/g7cYD
         8JTw==
X-Gm-Message-State: AOJu0YyquXx5s2K3P2yYG+Gt/xpYRiGawH7qtMyI/DqgDmH9mVtkVbkL
	Hm6eJcT2Kl2OvT3YhFoxjrdoXkZ2ZtF6hfxILLIQBJYRx+i36yS/QkA3
X-Gm-Gg: ASbGncsBSkTL4WfQqGaElNNgUfEkv+Qlc1VJN2iqMKnWUPMiFvVWcUwz3hkq4a1QZXL
	0EQFO617HIkADKxJLCsSFfsLBP8pFQpjvp+SAbNZWFhLDL6uitPto3B1rH7r8L0Ka7Wes7jgtua
	po1o/btrqognBIA/MSzPDrvUJtYuA+cECZ8xDBW0+H0Nw9xX88mT4euIBvOQxiPY2GShNfF9Qpq
	yXLkVuLocStM0gRutMqZterG0KgGs/kCpWhBzAa3F46udde5Z19IDTleU/TI3ahj+bJyK0YrQug
	ONasxDVZQy+poAfATwEil7S6aym+uWDw0skbPCcDeUx9+jSRXzla4a4gpdovi9OK1Fk4UIrp2ud
	41uXe2Klvn/nuhWXbeprLXSucIcqdM/iUVKLhTUQCmOxqaMRtaYrToQz390I=
X-Google-Smtp-Source: AGHT+IGCJVkx6dNS9MtGXsoCIBe9tEJRiBFbh0wQ9OAvRY7gT4l5DpV19RhN1Q6KJh7baHLQyfrebA==
X-Received: by 2002:a17:906:f58a:b0:b04:6412:9612 with SMTP id a640c23a62f3a-b34bc876274mr1954386366b.46.1759137743202;
        Mon, 29 Sep 2025 02:22:23 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:22 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v3 00/24] Hierarchical Constant Bandwidth Server
Date: Mon, 29 Sep 2025 11:21:57 +0200
Message-ID: <20250929092221.10947-1-yurand2000@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is the v3 for Hierarchical Constant Bandwidth Server, aiming at replacing
the current RT_GROUP_SCHED mechanism with something more robust and
theoretically sound. The patchset has been presented at OSPM25
(https://retis.sssup.it/ospm-summit/), and a summary of its inner workings can
be found at https://lwn.net/Articles/1021332/ . You can find the previous
versions of this patchset at the bottom of the page, in particular version 1
which talks in more detail what this patchset is all about and how it is
implemented.

This v3 version further reworks some of the patches as suggested by Juri Lelli.
While most of the work is refactorings, the following were also changed:
- The first patch which removed fair-servers' bandwidth accounting has been
  removed, as it was deemed wrong. You can find the last version of this removed
  patch, just for history reasons, here:
  https://lore.kernel.org/all/20250903114448.664452-1-yurand2000@gmail.com/
- A left-over check which prevented execution of some of wakeup_preempt code has
  been removed.
- Cgroup pull code was erroneusly comparing cgroup with non-cgroup tasks, now it
  has been fixed.
- The allocation/deallocation code for rt cgroups has been checked and reworked
  to make sure that resources are managed correctly in all the code paths.
- Some signatures of cgroup migration related functions where changed to match
  more closely to their non-group counterparts.
- Descriptions and documentation were added where necessary, in particular for
  preemption rules in wakeup_preempt.

For this v3 version we've also polished the testing system we are using and made
it public for testers to run on their own machines. The source code can be found
at https://github.com/Yurand2000/HCBS-Test-Suite , along with a README that
explains how to use it. Nonetheless I've reported a description of the tools and
instruction later in the page.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Summary of the patches:
   1-4) Preparation patches, so that the RT classes' code can be used both
        for normal and cgroup scheduling.
  5-15) Implementation of HCBS, no migration and only one level hierarchy.
        The old RT_GROUP_SCHED code is removed.
 16-17) Remove cgroups v1 in favour of v2.
    18) Add support for deeper hierarchies.
 19-24) Add support for tasks migration.

Updates from v2:
- Rebase to latest tip/master.
- Remove fair-servers' bw reclaiming.
- Fix a check which prevented execution of wakeup_preempt code.
- Fix a priority check in group_pull_rt_task between tasks of different groups.
- Rework allocation/deallocation code for rt-cgroups.
- Update signatures for some group related migration functions.
- Add documentation for wakeup_preempt preemption rules.

Updates from v1:
- Rebase to latest tip/master.
- Add migration code.
- Split big patches for more readability.
- Refactor code to use guarded locks where applicable.
- Remove unnecessary patches from v1 which have been addressed differently by
  mainline updates.
- Remove unnecessary checks and general code cleanup.

Notes:
Task migration support needs some extra work to reduce its invasiveness,
especially patches 21-22.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Testing v3:

The HCBS mechanism has been evaluated on several syntetic tests which are
designed to stress the HCBS scheduler and verify that non-interference and
mathematical schedulability guarantees are really enforced by the scheduling
algorithm.

The test suite currently runs different categories of tests:
- Constraints, which are tasked to assert that hard constraints, such as
  schedulability conditions, are respected.
- Regression, to check that HCBS does not break anything that already exists.
- Stress, to repeatedly invoke the scheduler in all the exposed interfaces,
  with the goal to detect bugs and more importantly race conditions.
- Time, simple benchmarks to assert that the dl_servers work correctly, i.e.
  they allocate the correct amount of bandwidth, and that migration code allows
  to fully utilize the cgroup's allocated bw.
- Taskset: given a set of (generated) periodic tasks and their bandwidth
  requirements, schedulability analyses are performed to decide whether or not a
  given hardware configuration can run the taskset. In particular, for each
  taskset, a HCBS's cgroup configuration along with the number of necessary CPUs
  is generated. These are mathematically guaranteed to be schedulable.
  The next step of this test suite is to configure cgroups as computed and to
  run the taskset, to verify that the HCBS implementation works as intended and
  that the scheduling overheads are within reasonable bounds.

The source code can be found at https://github.com/Yurand2000/HCBS-Test-Suite .
The README file should explain most if not all questions, but I'm writing
briefly the pipeline to run these tests here:

- Get the HCBS patch up and running. Any kernel/disto should work effortlessly.
- Get, compile and _install_ the tests. 
- Download the additional taskset files and extract them in the _install_
  folder. You can find them here:
  https://github.com/Yurand2000/HCBS-Test-Suite/releases/tag/250926
- Run the `run_tests.sh full` script, to run the whole test suite.

Expect a total runtime of ~3 hours. The script will automatically mount the
cgroup and debug filesystems (if not already mounted) and will move all the
already running SCHED_FIFO/SCHED_RR tasks in the root cgroup, so that the
cgroups' CPU controller can be mounted. It will additionally try to reserve all
the possible rt-bandwidth for cgroups (i.e. 90%) to run all the later tests, so
make sure that there are no running SCHED_DEADLINE tasks if the script fails to
setup.

Some tests specifically need a minimum amount of CPU cores, up to a maximum of
eight. If your machine has less CPUs then the tests will simply be skipped.

Notes:

The tasksets minimal requirements were computed using a closed-source software,
explaining why the tasksets are supplied separately. A open-source analyser is
being written to update this step in the future and also allow for more
customization for the testers.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Future Work:

While we wait for more comments, and expect stuff to break, we will work on
completing the currently partial/untested, implementation of HCBS with different
runtimes per CPU, instead of having the same runtime allocated on all CPUs, to
include it in a future RCF.

Future patches:
 - HCBS with different runtimes per CPU.
 - capacity aware bandwidth reservation.
 - enable/disable dl_servers when a CPU goes online/offline.

Have a nice day,
Yuri

v1: https://lore.kernel.org/all/20250605071412.139240-1-yurand2000@gmail.com/
v2: https://lore.kernel.org/all/20250731105543.40832-1-yurand2000@gmail.com/

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Yuri Andriaccio (6):
  sched/rt: Disable RT_GROUP_SCHED
  sched/rt: Add rt-cgroups' dl-servers operations.
  sched/rt: Update task event callbacks for HCBS scheduling
  sched/rt: Allow zeroing the runtime of the root control group
  sched/rt: Remove support for cgroups-v1
  sched/core: Execute enqueued balance callbacks when migrating task
    betweeen cgroups

luca abeni (18):
  sched/deadline: Do not access dl_se->rq directly
  sched/deadline: Distinct between dl_rq and my_q
  sched/rt: Pass an rt_rq instead of an rq where needed
  sched/rt: Move some functions from rt.c to sched.h
  sched/rt: Introduce HCBS specific structs in task_group
  sched/core: Initialize root_task_group
  sched/deadline: Add dl_init_tg
  sched/rt: Add {alloc/free}_rt_sched_group
  sched/deadline: Account rt-cgroups bandwidth in deadline tasks
    schedulability tests.
  sched/rt: Update rt-cgroup schedulability checks
  sched/rt: Remove old RT_GROUP_SCHED data structures
  sched/core: Cgroup v2 support
  sched/deadline: Allow deeper hierarchies of RT cgroups
  sched/rt: Add rt-cgroup migration
  sched/rt: Add HCBS migration related checks and function calls
  sched/deadline: Make rt-cgroup's servers pull tasks on timer
    replenishment
  sched/deadline: Fix HCBS migrations on server stop
  sched/core: Execute enqueued balance callbacks when changing allowed
    CPUs

 include/linux/sched.h    |   10 +-
 kernel/sched/autogroup.c |    4 +-
 kernel/sched/core.c      |   65 +-
 kernel/sched/deadline.c  |  251 +++-
 kernel/sched/debug.c     |    6 -
 kernel/sched/fair.c      |    6 +-
 kernel/sched/rt.c        | 3069 +++++++++++++++++++-------------------
 kernel/sched/sched.h     |  150 +-
 kernel/sched/syscalls.c  |    6 +-
 9 files changed, 1850 insertions(+), 1717 deletions(-)


base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
-- 
2.51.0


