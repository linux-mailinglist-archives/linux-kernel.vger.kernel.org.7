Return-Path: <linux-kernel+bounces-799012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE31B425D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951923BBD00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430E2283CB0;
	Wed,  3 Sep 2025 15:48:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB1F3AC1C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914517; cv=none; b=R02QXmttSJUu0hoELYnbQGxNN9hSPAjLY+fQRvEywFDe7a9r+mzbIVLlHb7N3MrvyP6I739Aw7Yd3ootj6qAxxKIGtRFC/WBsstn6Ws2IkrR2eoXnJNDdgpPXhmeqZst/RkbouukiVAKllhpXzdy92wvz3ZoUt5tZFmDSguLoIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914517; c=relaxed/simple;
	bh=uXB1yTCdoWdSCeC647+R2D8+SGQ8jzdC0pPuLCNv4sI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uuQfDjV0y09umuIq3ygfJme4s4GmN1o23nG1i/hJJT7DUsC2rIQRtEm6TiDVaBLqt7PWPb7z1E6s6WU+rTJGYlmilelTYkOxCOCPNd1iCbXOt4iPK+Gpqcg8lWoj0aGHeUKCAWsFN9OaCCSxUqY4URMEjZULW8cHWStNlxwVIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FA89FEC;
	Wed,  3 Sep 2025 08:48:26 -0700 (PDT)
Received: from [10.1.28.62] (e127648.arm.com [10.1.28.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9D5B3F694;
	Wed,  3 Sep 2025 08:48:33 -0700 (PDT)
Message-ID: <1ae868cf-470b-44d8-bda3-20a64dedd8b8@arm.com>
Date: Wed, 3 Sep 2025 16:48:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Thomas Gleixner
 <tglx@linutronix.de>, yury.norov@gmail.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>, Valentin Schneider <vschneid@redhat.com>
From: Christian Loehle <christian.loehle@arm.com>
Subject: PATCH] sched: Fix sched_numa_find_nth_cpu() if mask offline
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

sched_numa_find_nth_cpu() uses a bsearch to look for the 'closest'
CPU in sched_domains_numa_masks and given cpus mask. However they
might not intersect if all CPUs in the cpus mask are offline. bsearch
will return NULL in that case, bail out instead of dereferencing a
bogus pointer.

The previous behaviour lead to this bug when using maxcpus=4 on an
rk3399 (LLLLbb) (i.e. booting with all big CPUs offline):

[    1.422922] Unable to handle kernel paging request at virtual address ffffff8000000000
[    1.423635] Mem abort info:
[    1.423889]   ESR = 0x0000000096000006
[    1.424227]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.424715]   SET = 0, FnV = 0
[    1.424995]   EA = 0, S1PTW = 0
[    1.425279]   FSC = 0x06: level 2 translation fault
[    1.425735] Data abort info:
[    1.425998]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[    1.426499]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    1.426952]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    1.427428] swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000004a9f000
[    1.428038] [ffffff8000000000] pgd=18000000f7fff403, p4d=18000000f7fff403, pud=18000000f7fff403, pmd=0000000000000000
[    1.429014] Internal error: Oops: 0000000096000006 [#1]  SMP
[    1.429525] Modules linked in:
[    1.429813] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-rc4-dirty #343 PREEMPT
[    1.430559] Hardware name: Pine64 RockPro64 v2.1 (DT)
[    1.431012] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.431634] pc : sched_numa_find_nth_cpu+0x2a0/0x488
[    1.432094] lr : sched_numa_find_nth_cpu+0x284/0x488
[    1.432543] sp : ffffffc084e1b960
[    1.432843] x29: ffffffc084e1b960 x28: ffffff80078a8800 x27: ffffffc0846eb1d0
[    1.433495] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[    1.434144] x23: 0000000000000000 x22: fffffffffff7f093 x21: ffffffc081de6378
[    1.434792] x20: 0000000000000000 x19: 0000000ffff7f093 x18: 00000000ffffffff
[    1.435441] x17: 3030303866666666 x16: 66663d736b73616d x15: ffffffc104e1b5b7
[    1.436091] x14: 0000000000000000 x13: ffffffc084712860 x12: 0000000000000372
[    1.436739] x11: 0000000000000126 x10: ffffffc08476a860 x9 : ffffffc084712860
[    1.437389] x8 : 00000000ffffefff x7 : ffffffc08476a860 x6 : 0000000000000000
[    1.438036] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
[    1.438683] x2 : 0000000000000000 x1 : ffffffc0846eb000 x0 : ffffff8000407b68
[    1.439332] Call trace:
[    1.439559]  sched_numa_find_nth_cpu+0x2a0/0x488 (P)
[    1.440016]  smp_call_function_any+0xc8/0xd0
[    1.440416]  armv8_pmu_init+0x58/0x27c
[    1.440770]  armv8_cortex_a72_pmu_init+0x20/0x2c
[    1.441199]  arm_pmu_device_probe+0x1e4/0x5e8
[    1.441603]  armv8_pmu_device_probe+0x1c/0x28
[    1.442007]  platform_probe+0x5c/0xac
[    1.442347]  really_probe+0xbc/0x298
[    1.442683]  __driver_probe_device+0x78/0x12c
[    1.443087]  driver_probe_device+0xdc/0x160
[    1.443475]  __driver_attach+0x94/0x19c
[    1.443833]  bus_for_each_dev+0x74/0xd4
[    1.444190]  driver_attach+0x24/0x30
[    1.444525]  bus_add_driver+0xe4/0x208
[    1.444874]  driver_register+0x60/0x128
[    1.445233]  __platform_driver_register+0x24/0x30
[    1.445662]  armv8_pmu_driver_init+0x28/0x4c
[    1.446059]  do_one_initcall+0x44/0x25c
[    1.446416]  kernel_init_freeable+0x1dc/0x3bc
[    1.446820]  kernel_init+0x20/0x1d8
[    1.447151]  ret_from_fork+0x10/0x20
[    1.447493] Code: 90022e21 f000e5f5 910de2b5 2a1703e2 (f8767803)
[    1.448040] ---[ end trace 0000000000000000 ]---
[    1.448483] note: swapper/0[1] exited with preempt_count 1
[    1.449047] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    1.449741] SMP: stopping secondary CPUs
[    1.450105] Kernel Offset: disabled
[    1.450419] CPU features: 0x000000,00080000,20002001,0400421b
[    1.450935] Memory Limit: none
[    1.451217] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

Fixes: cd7f55359c90 ("sched: add sched_numa_find_nth_cpu()")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 977e133bb8a4..6e2f54169e66 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2201,6 +2201,8 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 		goto unlock;
 
 	hop_masks = bsearch(&k, k.masks, sched_domains_numa_levels, sizeof(k.masks[0]), hop_cmp);
+	if (!hop_masks)
+		goto unlock;
 	hop = hop_masks	- k.masks;
 
 	ret = hop ?
-- 
2.34.1

