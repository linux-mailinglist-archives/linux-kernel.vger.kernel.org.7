Return-Path: <linux-kernel+bounces-792051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1754B3BFD0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B273A24B12
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1023321F35;
	Fri, 29 Aug 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVBbMmoB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931C1FDA8E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482501; cv=none; b=oGf0g0KYnre8yzbM33wuWe6RCLS7kTpzY4f8QK5nJx7TT1dSC7Ncon0ItB8GNIF+CB4273u4wsoY2+HZceCBqDXeB0kuA9VVkpNElY/nAkLUAtDUOBHC5c4WPeFV2/zHkedktXnwrPjBQbzZryoIdW8L8J0a46sMeg9obWYLJWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482501; c=relaxed/simple;
	bh=Tuj4oRlgkdRU+a2854uaZQYdOyfFypoS1kMiG2+tm6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nXPj1cjJFdwA3r5Ax/wuyHy98EnGQonPWhoNReNWAhLDsAal5Bmp5JxsQrVyAJc1CPuzCvpcz3QAodJJX3vHLgEkjkhWx7itU12gmB9XqNzjniCqk3hBdyoTedNZTxV7AExugAI3nrgOyoxJn6OcKPO++LdIfxqEnLaNpafABH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVBbMmoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74726C4CEF0;
	Fri, 29 Aug 2025 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482500;
	bh=Tuj4oRlgkdRU+a2854uaZQYdOyfFypoS1kMiG2+tm6o=;
	h=From:To:Cc:Subject:Date:From;
	b=aVBbMmoB1WQCXxUeqxJCSnmV6rrm57j0Z/HnfLiN/H455AhXxdALH+4qDj/uJzZZ9
	 3sJuNuiadfRMqY3NogVJSxvrGB0km9QAFF4QNg9MFwXevv1+lf8m+IXM4SxVRy3mSL
	 VJOzkgXL8rJXuspehuy6gZsxDdxvbUcmpii3J2LtT+sZUpoYNRKxyGKjNh+yMBLiCd
	 TaLlYMzzwAVw8tzBCC+erBgU+TQ++I0TaayYoUGeXuPkY1+RjnhGMkHXJMlNHTLAr+
	 YrqI8MYMBM2mGCOpT/Ouc/FXS6/7VaXcOvbNkZlgu/919eM69YUfTmw45TJzuUl6ib
	 MxczcgqSyPjtw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 00/33 v2] cpuset/isolation: Honour kthreads preferred affinity
Date: Fri, 29 Aug 2025 17:47:41 +0200
Message-ID: <20250829154814.47015-1-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The kthread code was enhanced lately to provide an infrastructure which
manages the preferred affinity of unbound kthreads (node or custom
cpumask) against housekeeping constraints and CPU hotplug events.

One crucial missing piece is cpuset: when an isolated partition is
created, deleted, or its CPUs updated, all the unbound kthreads in the
top cpuset are affine to _all_ the non-isolated CPUs, possibly breaking
their preferred affinity along the way

Solve this with performing the kthreads affinity update from cpuset to
the kthreads consolidated relevant code instead so that preferred
affinities are honoured.

The dispatch of the new cpumasks to workqueues and kthreads is performed
by housekeeping, as per the nice Tejun's suggestion.

As a welcome side effect, HK_TYPE_DOMAIN then integrates both the set
from isolcpus= and cpuset isolated partitions. Housekeeping cpumasks are
now modifyable with specific synchronization. A big step toward making
nohz_full= also mutable through cpuset in the future.

Changes since v1:

- Drop the housekeeping lock and use RCU to synchronize housekeeping
  against cpuset changes.

- Add housekeeping documentation

- Simplify CPU hotplug handling

- Collect ack from Shakeel Butt

- Handle sched/arm64's task fallback cpumask move to HK_TYPE_DOMAIN

- Fix genirq kthreads affinity

- Add missing kernel doc

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	kthread/core-v2

HEAD: 092784f7df0aa6415c91ae5edc1c1a72603b5c50
Thanks,
	Frederic
---

Frederic Weisbecker (32):
      sched/isolation: Remove housekeeping static key
      PCI: Protect against concurrent change of housekeeping cpumask
      cpu: Revert "cpu/hotplug: Prevent self deadlock on CPU hot-unplug"
      memcg: Prepare to protect against concurrent isolated cpuset change
      mm: vmstat: Prepare to protect against concurrent isolated cpuset change
      sched/isolation: Save boot defined domain flags
      cpuset: Convert boot_hk_cpus to use HK_TYPE_DOMAIN_BOOT
      driver core: cpu: Convert /sys/devices/system/cpu/isolated to use HK_TYPE_DOMAIN_BOOT
      net: Keep ignoring isolated cpuset change
      block: Protect against concurrent isolated cpuset change
      cpu: Provide lockdep check for CPU hotplug lock write-held
      cpuset: Provide lockdep check for cpuset lock held
      sched/isolation: Convert housekeeping cpumasks to rcu pointers
      cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
      sched/isolation: Flush memcg workqueues on cpuset isolated partition change
      sched/isolation: Flush vmstat workqueues on cpuset isolated partition change
      cpuset: Propagate cpuset isolation update to workqueue through housekeeping
      cpuset: Remove cpuset_cpu_is_isolated()
      sched/isolation: Remove HK_TYPE_TICK test from cpu_is_isolated()
      PCI: Remove superfluous HK_TYPE_WQ check
      kthread: Refine naming of affinity related fields
      kthread: Include unbound kthreads in the managed affinity list
      kthread: Include kthreadd to the managed affinity list
      kthread: Rely on HK_TYPE_DOMAIN for preferred affinity management
      sched: Switch the fallback task allowed cpumask to HK_TYPE_DOMAIN
      sched/arm64: Move fallback task cpumask to HK_TYPE_DOMAIN
      kthread: Honour kthreads preferred affinity after cpuset changes
      kthread: Comment on the purpose and placement of kthread_affine_node() call
      kthread: Add API to update preferred affinity on kthread runtime
      kthread: Document kthread_affine_preferred()
      genirq: Correctly handle preferred kthreads affinity
      doc: Add housekeeping documentation

Gabriele Monaco (1):
      cgroup/cpuset: Fail if isolated and nohz_full don't leave any housekeeping

 Documentation/cpu_isolation/housekeeping.rst | 111 +++++++++++++++
 arch/arm64/kernel/cpufeature.c               |  18 ++-
 block/blk-mq.c                               |   6 +-
 drivers/base/cpu.c                           |   2 +-
 drivers/pci/pci-driver.c                     |  50 ++++---
 include/linux/cpu.h                          |   4 +
 include/linux/cpuhplock.h                    |   1 +
 include/linux/cpuset.h                       |   8 +-
 include/linux/kthread.h                      |   2 +
 include/linux/memcontrol.h                   |   4 +
 include/linux/mmu_context.h                  |   2 +-
 include/linux/percpu-rwsem.h                 |   1 +
 include/linux/sched/isolation.h              |  30 +++--
 include/linux/vmstat.h                       |   2 +
 include/linux/workqueue.h                    |   2 +-
 init/Kconfig                                 |   1 +
 kernel/cgroup/cpuset.c                       | 131 +++++++++++++-----
 kernel/cpu.c                                 |  42 +++---
 kernel/irq/manage.c                          |  47 ++++---
 kernel/kthread.c                             | 195 +++++++++++++++++++--------
 kernel/sched/isolation.c                     | 185 ++++++++++++++++---------
 kernel/sched/sched.h                         |   4 +
 kernel/workqueue.c                           |   2 +-
 mm/memcontrol.c                              |  25 +++-
 mm/vmstat.c                                  |  15 ++-
 net/core/net-sysfs.c                         |   2 +-
 26 files changed, 639 insertions(+), 253 deletions(-)

