Return-Path: <linux-kernel+bounces-792085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5EEB3C00A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093121884F73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B688634A32B;
	Fri, 29 Aug 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkYd/pOm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE59D33437F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482591; cv=none; b=AeddXrbIx+ABO/PUnnWwcjhVz+rY3KuYt2EcXSm2NU3pROHVU/5kkGxRodhn8l9JFg/Fgl/lu+WVK9Y62OlDlsA54RC1TPG+QX/LoNFJJcDR7Yr2NajALsox7FUjc2JdwtD3JQ4cRLGh7foGafyf5Y9W+RxIR3oxLrJsNKvrqqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482591; c=relaxed/simple;
	bh=Jrc2SP9zuO/q8lVKXeMSZQ2TjjYp5fXU9+UkI2oxxh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POT1kIPacOFO2Ya4bHrmh5M9ph39q01gPPdppew9lAJxtW6c8JA5nGE2NnuQG4dTilFwMlHsPENQoDE+py3zKa59Po6qydlTWOdhvCHBDpf3WzpiTLHrgFzczaXz1rcwuztO0bS+WNHDV6s5IlpGWGWSqVUEtS7lskJgBkm95oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkYd/pOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09F0C4CEF6;
	Fri, 29 Aug 2025 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482590;
	bh=Jrc2SP9zuO/q8lVKXeMSZQ2TjjYp5fXU9+UkI2oxxh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkYd/pOmb9GnGKg5lfavP7nDSvh/s8W9bL6YX4KotaTa+2qjTPlmnudrn1vD/k9QS
	 oJcz+Akb4MOrivK6cknt4ZqSpiLWVnTD4nHf1gTxtH6XsGXzBlAIGpCEsrblxNP46A
	 iXeQXkXVGjJqkA4MUT46nkS+QCQSW66qGj0UWbaE+COLFUWKPsYPvrdZ8S1nyTm1bx
	 +6e+9+oyapC4lYTFTm8aGzbUPNa4Gd8d+sIL+9GXW08U4YFtVkDO2j9ve46E6uf60J
	 yNqI40EOQ/wPTRJ8J1c9EzRcQdKQgC6KAAF4X4DaWaaqg0SLucqT54i5eojQooCT95
	 u8kbLlTMAt/jQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 33/33] doc: Add housekeeping documentation
Date: Fri, 29 Aug 2025 17:48:14 +0200
Message-ID: <20250829154814.47015-34-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 Documentation/cpu_isolation/housekeeping.rst | 111 +++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/cpu_isolation/housekeeping.rst

diff --git a/Documentation/cpu_isolation/housekeeping.rst b/Documentation/cpu_isolation/housekeeping.rst
new file mode 100644
index 000000000000..e5417302774c
--- /dev/null
+++ b/Documentation/cpu_isolation/housekeeping.rst
@@ -0,0 +1,111 @@
+======================================
+Housekeeping
+======================================
+
+
+CPU Isolation moves away kernel work that may otherwise run on any CPU.
+The purpose of its related features is to reduce the OS jitter that some
+extreme workloads can't stand, such as in some DPDK usecases.
+
+The kernel work moved away by CPU isolation is commonly described as
+"housekeeping" because it includes ground work that performs cleanups,
+statistics maintainance and actions relying on them, memory release,
+various deferrals etc...
+
+Sometimes housekeeping is just some unbound work (unbound workqueues,
+unbound timers, ...) that gets easily assigned to non-isolated CPUs.
+But sometimes housekeeping is tied to a specific CPU and requires
+elaborated tricks to be offloaded to non-isolated CPUs (RCU_NOCB, remote
+scheduler tick, etc...).
+
+Thus, a housekeeping CPU can be considered as the reverse of an isolated
+CPU. It is simply a CPU that can execute housekeeping work. There must
+always be at least one online housekeeping CPU at any time. The CPUs that
+are not	isolated are automatically assigned as housekeeping.
+
+Housekeeping is currently divided in four features described
+by the ``enum hk_type type``:
+
+1.	HK_TYPE_DOMAIN matches the work moved away by scheduler domain
+	isolation performed through ``isolcpus=domain`` boot parameter or
+	isolated cpuset partitions in cgroup v2. This includes scheduler
+	load balancing, unbound workqueues and timers.
+
+2.	HK_TYPE_KERNEL_NOISE matches the work moved away by tick isolation
+	performed through ``nohz_full=`` or ``isolcpus=nohz`` boot
+	parameters. This includes remote scheduler tick, vmstat and lockup
+	watchdog.
+
+3.	HK_TYPE_MANAGED_IRQ matches the IRQ handlers moved away by managed
+	IRQ isolation performed through ``isolcpus=managed_irq``.
+
+4.	HK_TYPE_DOMAIN_BOOT matches the work moved away by scheduler domain
+	isolation performed through ``isolcpus=domain`` only. It is similar
+	to HK_TYPE_DOMAIN except it ignores the isolation performed by
+	cpusets.
+
+
+Housekeeping cpumasks
+=================================
+
+Housekeeping cpumasks include the CPUs that can execute the work moved
+away by the matching isolation feature. These cpumasks are returned by
+the following function::
+
+	const struct cpumask *housekeeping_cpumask(enum hk_type type)
+
+By default, if neither ``nohz_full=``, nor ``isolcpus``, nor cpuset's
+isolated partitions are used, which covers most usecases, this function
+returns the cpu_possible_mask.
+
+Otherwise the function returns the cpumask complement of the isolation
+feature. For example:
+
+With isolcpus=domain,7 the following will return a mask with all possible
+CPUs except 7::
+
+	housekeeping_cpumask(HK_TYPE_DOMAIN)
+
+Similarly with nohz_full=5,6 the following will return a mask with all
+possible CPUs except 5,6::
+
+	housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)
+
+
+Synchronization against cpusets
+=================================
+
+Cpuset can modify the HK_TYPE_DOMAIN housekeeping cpumask while creating,
+modifying or deleting an isolated partition.
+
+The users of HK_TYPE_DOMAIN cpumask must then make sure to synchronize
+properly against cpuset in order to make sure that:
+
+1.	The cpumask snapshot stays coherent.
+
+2.	No housekeeping work is queued on a newly made isolated CPU.
+
+3.	Pending housekeeping work that was queued to a non isolated
+	CPU which just turned isolated through cpuset must be flushed
+	before the related created/modified isolated partition is made
+	available to userspace.
+
+This synchronization is maintained by an RCU based scheme. The cpuset update
+side waits for an RCU grace period after updating the HK_TYPE_DOMAIN
+cpumask and before flushing pending works. On the read side, care must be
+taken to gather the housekeeping target election and the work enqueue within
+the same RCU read side critical section.
+
+A typical layout example would look like this on the update side
+(``housekeeping_update()``)::
+
+	rcu_assign_pointer(housekeeping_cpumasks[type], trial);
+	synchronize_rcu();
+	flush_workqueue(example_workqueue);
+
+And then on the read side::
+
+	rcu_read_lock();
+	cpu = housekeeping_any_cpu(HK_TYPE_DOMAIN);
+	queue_work_on(cpu, example_workqueue, work);
+	rcu_read_unlock();
-- 
2.51.0


