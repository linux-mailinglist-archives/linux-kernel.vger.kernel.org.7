Return-Path: <linux-kernel+bounces-836331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C186ABA95CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600231663BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072613054DB;
	Mon, 29 Sep 2025 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMljKKju"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C919066D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152987; cv=none; b=nsB3TUEVgf9EScfm/29AkGGghTVSZHVk9UrupXvrmBqfiDU6cUK9qRsd1TT3tLOphhiSK/1IJCxlfnc+QpHI5YZ0T92nfu5q2dmPlH2i+Q8rli50nHcENhJJ1tftPyWGvuhSn0a7izlurJSPigkYHBKciIs99CFdtWF62o+8sM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152987; c=relaxed/simple;
	bh=IoYmJE6xUO51qxTlCnz4/qwMWgN2uAtF8WI4WTJsGj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Re+0CTESSvQ73hB4kr1jXF7fZY7ZtPAIGFTgqZjdTVES2p7r1uQr9yNZSA/lUAf1mig2UU2DiAQZMYOFO7mDqBrZ+Sg0jgtDvhUWPjTgK40rQ0avytcpVrJ4wi7heIbrJRYi1tc9FMd/8bc4G50Slcb3aY2CbJtj8mq5NoSeu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMljKKju; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759152983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nKWbUw+A1LD5jIXsmedW4kYmmi0jrgFRNlN70cgPfcs=;
	b=gMljKKjuHQFe5QpPdYOaRckxdmzih8xJVDNapu8sDuwZM+KmHB3YQL2uC9T1/ttcplWB4I
	fVXP2gSbRbMSP87CW8m2k4r5BenZ53CGzx8qes+KHuPV6gqMGNaqRMPgpjgoNYU7uXuUS4
	ytzBula2Z2veldFMMSyKNVaaWHCKRgE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-FWp9gdWMNpiUErvqD3IWSA-1; Mon,
 29 Sep 2025 09:36:22 -0400
X-MC-Unique: FWp9gdWMNpiUErvqD3IWSA-1
X-Mimecast-MFC-AGG-ID: FWp9gdWMNpiUErvqD3IWSA_1759152981
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8AFB419560B0;
	Mon, 29 Sep 2025 13:36:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E72830001A4;
	Mon, 29 Sep 2025 13:36:14 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] sched/deadline: Derive root domain from active cpu in task's cpus_ptr
Date: Mon, 29 Sep 2025 21:36:02 +0800
Message-ID: <20250929133602.32462-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
When a CPU is inactive, its rd is set to def_root_domain. For an S-state
deadline task (in this case, "cppc_fie"), it was not migrated to CPU0,
and its task_rq() information is stale. As a result, its bandwidth is
wrongly accounted into def_root_domain during domain rebuild.

This patch uses the rd from the run queue of still-active CPU to get the
correct root domain.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org
---
 kernel/sched/deadline.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f25301267e47..bb42b82d6366 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2913,6 +2913,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct rq_flags rf;
 	struct rq *rq;
 	struct dl_bw *dl_b;
+	unsigned int cpu;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
@@ -2920,16 +2921,23 @@ void dl_add_task_root_domain(struct task_struct *p)
 		return;
 	}
 
-	rq = __task_rq_lock(p, &rf);
-
+	lockdep_assert_cpus_held();
+	/*
+	 * If @p is not in R state, task_cpu() may be not active.  task_rq()'s
+	 * root_domain may be invalid. But the rest active cpus on cpus_ptr
+	 * share the same root domain.
+	 */
+	cpu = cpumask_first_and(cpu_active_mask, p->cpus_ptr);
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


