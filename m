Return-Path: <linux-kernel+bounces-856142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 671BABE336C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A6A04FC5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759EA307491;
	Thu, 16 Oct 2025 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9KFZiL1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE612E7179
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616068; cv=none; b=Dvb0pTCwfmjmXildahqJEcFRjgMhaEYs7CHxoIwtRq5xAimeICYtdazG1CRvx3aa17B4izRtmUc5ob38Cr2wkhjTiCQz/CbhGHB+3x9MDody2rjfySeTZWP3kim1N8doIVQfj8lMutRsvnZCWhJopMyAMQuLyxgc14qjdZdXgVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616068; c=relaxed/simple;
	bh=CMesGRB60oKYGSrk63K0XurnHz6hebmxbo4SU40RAcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BrjOw3d/RI0ae0UVj+YjwX/nBsW8Jyiap5m9U1JNqPfnaVTaFMuhp9DNAwZOQmQrpvNMNXUlkXOflEkrKDSroGuEpfeEKR/2Dgnq3OaUuCee+H7LW7cOYzJSFQAlI2l2GYXe6qooEyFxxyAZoQYMc3Rgomb4yZohXO3T5ZbyTiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9KFZiL1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760616062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4U/DBOuRpSFJ1MA5oyNsYSZg42+qdzaY0gA3xtNmkX4=;
	b=h9KFZiL15igf/9VDYBFEPdAw6SxaFzWjs04KTYRARAyFDSeVhspwE3qGz1xbqbc5sOajew
	8MWrgxkDTBzBdgEOJB/x10f/ES6nfPYSShOKtM9Idkgk0vcFZcsVsFiT9rV26V39/E2T5q
	XLfxtLISN8cgr0H00xBWai3n/dY9EEs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-fyY7xprLMd66xxoCZye19Q-1; Thu,
 16 Oct 2025 08:00:58 -0400
X-MC-Unique: fyY7xprLMd66xxoCZye19Q-1
X-Mimecast-MFC-AGG-ID: fyY7xprLMd66xxoCZye19Q_1760616057
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2B1118002E4;
	Thu, 16 Oct 2025 12:00:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.96])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D542A19560AD;
	Thu, 16 Oct 2025 12:00:48 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCHv2] sched/deadline: Walk up cpuset hierarchy to decide root domain when hot-unplug
Date: Thu, 16 Oct 2025 20:00:41 +0800
Message-ID: <20251016120041.17990-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When testing kexec-reboot on a 144 cpus machine with
isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
encounter the following bug:

[   97.114759] psci: CPU142 killed (polled 0 ms)
[   97.333236] Failed to offline CPU143 - error=-16
[   97.333246] ------------[ cut here ]------------
[   97.342682] kernel BUG at kernel/cpu.c:1569!
[   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
[   97.353281] Modules linked in: rfkill sunrpc dax_hmem cxl_acpi cxl_port cxl_core einj vfat fat arm_smmuv3_pmu nvidia_cspmu arm_spe_pmu coresight_trbe arm_cspmu_module rndis_host ipmi_ssif cdc_ether i2c_smbus spi_nor usbnet ast coresight_tmc mii ixgbe i2c_algo_bit mdio mtd coresight_funnel coresight_stm stm_core coresight_etm4x coresight cppc_cpufreq loop fuse nfnetlink xfs crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt nvme nvme_core nvme_auth i2c_tegra acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler dm_mirror dm_region_hash dm_log dm_mod
[   97.404119] CPU: 0 UID: 0 PID: 2583 Comm: kexec Kdump: loaded Not tainted 6.12.0-41.el10.aarch64 #1
[   97.413371] Hardware name: Supermicro MBD-G1SMH/G1SMH, BIOS 2.0 07/12/2024
[   97.420400] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   97.427518] pc : smp_shutdown_nonboot_cpus+0x104/0x128
[   97.432778] lr : smp_shutdown_nonboot_cpus+0x11c/0x128
[   97.438028] sp : ffff800097c6b9a0
[   97.441411] x29: ffff800097c6b9a0 x28: ffff0000a099d800 x27: 0000000000000000
[   97.448708] x26: 0000000000000000 x25: 0000000000000000 x24: ffffb94aaaa8f218
[   97.456004] x23: ffffb94aaaabaae0 x22: ffffb94aaaa8f018 x21: 0000000000000000
[   97.463301] x20: ffffb94aaaa8fc10 x19: 000000000000008f x18: 00000000fffffffe
[   97.470598] x17: 0000000000000000 x16: ffffb94aa958fcd0 x15: ffff103acfca0b64
[   97.477894] x14: ffff800097c6b520 x13: 36312d3d726f7272 x12: ffff103acfc6ffa8
[   97.485191] x11: ffff103acf6f0000 x10: ffff103bc085c400 x9 : ffffb94aa88a0eb0
[   97.492488] x8 : 0000000000000001 x7 : 000000000017ffe8 x6 : c0000000fffeffff
[   97.499784] x5 : ffff003bdf62b408 x4 : 0000000000000000 x3 : 0000000000000000
[   97.507081] x2 : 0000000000000000 x1 : ffff0000a099d800 x0 : 0000000000000002
[   97.514379] Call trace:
[   97.516874]  smp_shutdown_nonboot_cpus+0x104/0x128
[   97.521769]  machine_shutdown+0x20/0x38
[   97.525693]  kernel_kexec+0xc4/0xf0
[   97.529260]  __do_sys_reboot+0x24c/0x278
[   97.533272]  __arm64_sys_reboot+0x2c/0x40
[   97.537370]  invoke_syscall.constprop.0+0x74/0xd0
[   97.542179]  do_el0_svc+0xb0/0xe8
[   97.545562]  el0_svc+0x44/0x1d0
[   97.548772]  el0t_64_sync_handler+0x120/0x130
[   97.553222]  el0t_64_sync+0x1a4/0x1a8
[   97.556963] Code: a94363f7 a8c47bfd d50323bf d65f03c0 (d4210000)
[   97.563191] ---[ end trace 0000000000000000 ]---
[   97.595854] Kernel panic - not syncing: Oops - BUG: Fatal exception
[   97.602275] Kernel Offset: 0x394a28600000 from 0xffff800080000000
[   97.608502] PHYS_OFFSET: 0x80000000
[   97.612062] CPU features: 0x10,0000000d,002a6928,5667fea7
[   97.617580] Memory Limit: none
[   97.648626] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]

Tracking down this issue, I found that dl_bw_deactivate() returned
-EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
When a CPU is inactive, its rd is set to def_root_domain. For an
blocked-state deadline task (in this case, "cppc_fie"), it was not
migrated to CPU0, and its task_rq() information is stale. As a result,
its bandwidth is wrongly accounted into def_root_domain during domain
rebuild.

The following rules stand for deadline sub-system:
  -1.any cpu belongs to a unique root domain at a given time
  -2.DL bandwidth checker ensures that the root domain has active cpus.
And for active cpu, cpu_rq(cpu)->rd always tracks a valid root domain.

Now, let's examine the blocked-state task P.
If P is attached to a cpuset that is a partition root, it is
straightforward to find an active CPU.
If P is attached to a cpuset which later has changed from 'root' to 'member',
the active CPUs are grouped into the parent root domain. Naturally, the
CPUs' capacity and reserved DL bandwidth are taken into account in the
parent root domain. (In practice, it may be unsafe to attach P to an
arbitrary root domain, since that domain may lack sufficient DL
bandwidth for P.) Again, it is straightforward to find an active CPU in
the parent root domain. (parent root domain means the first ancestor
cpuset which is partition root)

This patch walks up the cpuset hierarchy to find the active CPUs in P's
root domain and retrieves valid rd from cpu_rq(cpu)->rd.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org
---
 include/linux/cpuset.h  |  6 ++++++
 kernel/cgroup/cpuset.c  | 15 +++++++++++++++
 kernel/sched/deadline.c | 30 ++++++++++++++++++++++++------
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 2ddb256187b51..478ae68bdfc8f 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -130,6 +130,7 @@ extern void rebuild_sched_domains(void);
 
 extern void cpuset_print_current_mems_allowed(void);
 extern void cpuset_reset_sched_domains(void);
+extern struct cpumask *cpuset_task_rd_effective_cpus(struct task_struct *p);
 
 /*
  * read_mems_allowed_begin is required when making decisions involving
@@ -276,6 +277,11 @@ static inline void cpuset_reset_sched_domains(void)
 	partition_sched_domains(1, NULL, NULL);
 }
 
+static inline struct cpumask *cpuset_task_rd_effective_cpus(struct task_struct *p)
+{
+	return cpu_active_mask;
+}
+
 static inline void cpuset_print_current_mems_allowed(void)
 {
 }
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 27adb04df675d..25356d3f9d635 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1102,6 +1102,21 @@ void cpuset_reset_sched_domains(void)
 	mutex_unlock(&cpuset_mutex);
 }
 
+/* caller hold RCU read lock */
+struct cpumask *cpuset_task_rd_effective_cpus(struct task_struct *p)
+{
+	struct cpuset *cs;
+
+	cs = task_cs(p);
+	while (cs != &top_cpuset) {
+		if (is_sched_load_balance(cs))
+			break;
+		cs = parent_cs(cs);
+	}
+
+	return cs->effective_cpus;
+}
+
 /**
  * cpuset_update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
  * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 72c1f72463c75..fe0aec279c19a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2884,6 +2884,8 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct rq_flags rf;
 	struct rq *rq;
 	struct dl_bw *dl_b;
+	unsigned int cpu;
+	struct cpumask *msk;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
@@ -2891,16 +2893,32 @@ void dl_add_task_root_domain(struct task_struct *p)
 		return;
 	}
 
-	rq = __task_rq_lock(p, &rf);
-
+	/* prevent race among cpu hotplug, changing of partition_root_state */
+	lockdep_assert_cpus_held();
+	/*
+	 * If @p is in blocked state, task_cpu() may be not active. In that
+	 * case, rq->rd does not trace a correct root_domain. On the other hand,
+	 * @p must belong to an root_domain at any given time, which must have
+	 * active rq, whose rq->rd traces the valid root domain.
+	 */
+	msk = cpuset_task_rd_effective_cpus(p);
+	cpu = cpumask_first_and(cpu_active_mask, msk);
+	/*
+	 * If a root domain reserves bandwidth for a DL task, the DL bandwidth
+	 * check prevents CPU hot removal from deactivating all CPUs in that
+	 * domain.
+	 */ 
+	BUG_ON(cpu >= nr_cpu_ids);
+	rq = cpu_rq(cpu);
+	/*
+	 * This point is under the protection of cpu_hotplug_lock. Hence
+	 * rq->rd is stable.
+	 */
 	dl_b = &rq->rd->dl_bw;
 	raw_spin_lock(&dl_b->lock);
-
 	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
-
 	raw_spin_unlock(&dl_b->lock);
-
-	task_rq_unlock(rq, p, &rf);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 }
 
 void dl_clear_root_domain(struct root_domain *rd)
-- 
2.49.0


