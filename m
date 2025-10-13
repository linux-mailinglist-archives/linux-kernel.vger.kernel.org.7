Return-Path: <linux-kernel+bounces-850063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD38BD1C13
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0B904E2DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF37E2E0B5F;
	Mon, 13 Oct 2025 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KkC4YF5i"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7F145B3E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760339921; cv=none; b=k3YGw73Cj7gTocmdAGMd/gGnkbS2TrpM/KOsZ2gWrF6keajp/3DXkKlKzyYde2mLVEV1jrPiqJL5oqd1ZoXHJ5P+wI1eYjlZVvvN2SEOWtGvyfEZkCN1hAJw6i2O8R8QAcN5DdQcRg7/Dtz+B/+K66yqlgQaKBwE+fzSdRySorc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760339921; c=relaxed/simple;
	bh=AsZguMqS69uq0vmy0Z2umWqzJMVQ/SCvoFGictiiC6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLNjvpD8SKWC8S3r6xM8+/kSMhQCwfOoj3ElKuotKqdMdDHQkxBoHNvX2ELesZDFUdZcN7c5ipH981twrbeyClsMd8n/izWopCHcdlguwlCcJsj9rhHW7LPCgLhV1YwCGJ9v4He/MQKuuDDkeg//CuVxuk6zlOSWeSiQnX6Z+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KkC4YF5i; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760339915; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lOeDT9ckER1tkhIt+7awMozpl8nbNXBjXI6dnR0g7lM=;
	b=KkC4YF5iaxtYyYFfGY1vn/Jkj6rdN1BfcjU0xSvLqxVHszBnKTAhcSmzC/GhzlRDmwVWErwnbkXl1yQi2wGw/RkyehB7pBY2BqPKhHxtBLrdN0YrW73Zh9T1A94ZZvcZ22gTuINfZAZ2/ptkcyppRm3Nl+myFNka1eB/n4ops64=
Received: from j63c11469.sqa.eu95.tbsite.net(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0Wq0efgB_1760339907 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Oct 2025 15:18:34 +0800
From: Cruz Zhao <CruzZhao@linux.alibaba.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	catalin.marinas@arm.com
Cc: linux-kernel@vger.kernel.org
Subject: [BUG RESEND] Kernel panic in update_cfs_rq_h_load() on aarch64
Date: Mon, 13 Oct 2025 15:17:58 +0800
Message-ID: <20251013071820.1531295-1-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all. We are encountering a kernel panic in our production environment
running Linux kernel version 5.10.134, on aarch64 architecture (aarch64
architecture only).

Summary:
- Kernel Version: 5.10.134
 - Architecture: aarch64
 - Problem Type: panic
 - Reproducibility: About 40 times per week

This issue leads to system-wide unresponsiveness and requires a hard reboot.
We have collected the panic logs and backtraces, which I will include below
for your reference. We tried to analyze the vmcore but have not found out
the root cause.

Backtrace from dmesg:
[352245.601209] Unable to handle kernel paging request at virtual address 006410a84bf5c71c
[352245.609208] Mem abort info:
[352245.612077]   ESR = 0x96000004
[352245.615208]   EC = 0x25: DABT (current EL), IL = 32 bits
[352245.620595]   SET = 0, FnV = 0
[352245.623723]   EA = 0, S1PTW = 0
[352245.626938] Data abort info:
[352245.629893]   ISV = 0, ISS = 0x00000004
[352245.633803]   CM = 0, WnR = 0
[352245.636845] [006410a84bf5c71c] address between user and kernel address ranges
[352245.644059] Internal error: Oops: 96000004 [#1] SMP
[352245.728419] CPU: 98 PID: 2075637 Comm: execution_task_ Kdump: loaded Tainted: G           OE     5.10.134-xxx.al8.aarch64 #1
[352245.740578] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 1.2.M1.AL.P.153.00 05/23/2023
[352245.750306] pstate: 82401089 (Nzcv daIf +PAN -UAO +TCO BTYPE=--)
[352245.756400] pc : update_cfs_rq_h_load+0x80/0xb0
[352245.761007] lr : wake_affine_weight+0xa8/0x158
[352245.765525] sp : ffff800093d53af0
[352245.768915] x29: ffff800093d53af0 x28: ffff0411e6fecc00 
[352245.774302] x27: 0000000000000062 x26: ffff0444a69ecf00 
[352245.779689] x25: 0000000000000062 x24: 0000000000000000 
[352245.785075] x23: ffff800009cd0c70 x22: 0000000000000043 
[352245.790462] x21: ffff040001b56800 x20: 00000000000001f7 
[352245.795848] x19: ffff800009956280 x18: 0000000000000000 
[352245.801233] x17: 0000000000000000 x16: 0000000000000000 
[352245.806619] x15: 0000000000000000 x14: 0000000000000000 
[352245.812004] x13: 0000000000000000 x12: 0000000000000000 
[352245.817390] x11: 0000000000000000 x10: 0000000000000000 
[352245.822775] x9 : ffff8000080b3a68 x8 : 0000fffe7a402568 
[352245.828161] x7 : 0000fffe7a402568 x6 : 0000000000000008 
[352245.833546] x5 : 6eb725d198bfab04 x4 : 00000001053e82d7 
[352245.838931] x3 : 0000000000000001 x2 : ffff04128c023c00 
[352245.844317] x1 : 0000000000000000 x0 : 176410a84bf5c4f4 
[352245.849705] Call trace:
[352245.852232]  update_cfs_rq_h_load+0x80/0xb0
[352245.856489]  wake_affine+0x158/0x168
[352245.860143]  select_task_rq_fair+0x364/0x3a8
[352245.864488]  try_to_wake_up+0x154/0x648
[352245.868400]  wake_up_q+0x68/0xd0
[352245.871707]  futex_wake_op+0x280/0x4c8
[352245.875530]  do_futex+0x198/0x1c0
[352245.878919]  __arm64_sys_futex+0x11c/0x198
[352245.883100]  el0_svc_common.constprop.0+0x84/0x248
[352245.887967]  do_el0_svc+0x74/0x90
[352245.891362]  el0_svc+0x1c/0x28
[352245.894493]  el0_sync_handler+0xa8/0xb0
[352245.898405]  el0_sync+0x168/0x180
[352245.901798] Code: 9b057c21 91000463 f9413840 9ac30821 (f9411402) 
[352245.907970] ---[ end trace fe8ad954839d06b0 ]---
[352245.912667] Kernel panic - not syncing: Oops: Fatal exception
[352245.918488] SMP: stopping secondary CPUs
[352245.963079] Kernel Offset: disabled
[352245.966641] CPU features: 0x0,19850817,7a60a838
[352245.971244] Memory Limit: none
[352245.975887] Starting crashdump kernel...
[352245.980654] Bye!

The assembly code of update_cfs_rq_h_load() follows:
0xffff8000080b1788 <update_cfs_rq_h_load>:      mov     x9, x30
0xffff8000080b178c <update_cfs_rq_h_load+4>:    nop
0xffff8000080b1790 <update_cfs_rq_h_load+8>:    adrp    x1, 0xffff800009cc9000 <managed_irqs_free_cpumsk+5760>
0xffff8000080b1794 <update_cfs_rq_h_load+12>:   ldr     x3, [x0,#560]
0xffff8000080b1798 <update_cfs_rq_h_load+16>:   ldr     x2, [x0,#592]
0xffff8000080b179c <update_cfs_rq_h_load+20>:   ldr     x4, [x1,#2432]
0xffff8000080b17a0 <update_cfs_rq_h_load+24>:   ldr     x1, [x0,#544]
0xffff8000080b17a4 <update_cfs_rq_h_load+28>:   ldrsw   x3, [x3,#3280]
0xffff8000080b17a8 <update_cfs_rq_h_load+32>:   ldr     x2, [x2,#304]
0xffff8000080b17ac <update_cfs_rq_h_load+36>:   cmp     x1, x4
0xffff8000080b17b0 <update_cfs_rq_h_load+40>:   b.eq    0xffff8000080b1818 <update_cfs_rq_h_load+144>
0xffff8000080b17b4 <update_cfs_rq_h_load+44>:   ldr     x1, [x2,x3,lsl #3]
0xffff8000080b17b8 <update_cfs_rq_h_load+48>:   str     xzr, [x0,#552]
0xffff8000080b17bc <update_cfs_rq_h_load+52>:   cbnz    x1, 0xffff8000080b17cc <update_cfs_rq_h_load+68>
0xffff8000080b17c0 <update_cfs_rq_h_load+56>:   b       0xffff8000080b181c <update_cfs_rq_h_load+148>
0xffff8000080b17c4 <update_cfs_rq_h_load+60>:   ldr     x1, [x1,#608]
0xffff8000080b17c8 <update_cfs_rq_h_load+64>:   cbz     x1, 0xffff8000080b181c <update_cfs_rq_h_load+148>
0xffff8000080b17cc <update_cfs_rq_h_load+68>:   ldr     x0, [x1,#616]
0xffff8000080b17d0 <update_cfs_rq_h_load+72>:   ldr     x2, [x0,#544]
0xffff8000080b17d4 <update_cfs_rq_h_load+76>:   str     x1, [x0,#552]
0xffff8000080b17d8 <update_cfs_rq_h_load+80>:   cmp     x2, x4
0xffff8000080b17dc <update_cfs_rq_h_load+84>:   b.ne    0xffff8000080b17c4 <update_cfs_rq_h_load+60>
0xffff8000080b17e0 <update_cfs_rq_h_load+88>:   ldr     x2, [x0,#552]
0xffff8000080b17e4 <update_cfs_rq_h_load+92>:   cbz     x2, 0xffff8000080b1818 <update_cfs_rq_h_load+144>
0xffff8000080b17e8 <update_cfs_rq_h_load+96>:   ldr     x1, [x0,#536]
0xffff8000080b17ec <update_cfs_rq_h_load+100>:  nop
0xffff8000080b17f0 <update_cfs_rq_h_load+104>:  ldr     x5, [x2,#736]
0xffff8000080b17f4 <update_cfs_rq_h_load+108>:  ldr     x3, [x0,#352]
0xffff8000080b17f8 <update_cfs_rq_h_load+112>:  mul     x1, x1, x5
0xffff8000080b17fc <update_cfs_rq_h_load+116>:  add     x3, x3, #0x1
0xffff8000080b1800 <update_cfs_rq_h_load+120>:  ldr     x0, [x2,#624]
0xffff8000080b1804 <update_cfs_rq_h_load+124>:  udiv    x1, x1, x3
0xffff8000080b1808 <update_cfs_rq_h_load+128>:  ldr     x2, [x0,#552]
0xffff8000080b180c <update_cfs_rq_h_load+132>:  str     x4, [x0,#544]
0xffff8000080b1810 <update_cfs_rq_h_load+136>:  str     x1, [x0,#536]
0xffff8000080b1814 <update_cfs_rq_h_load+140>:  cbnz    x2, 0xffff8000080b17f0 <update_cfs_rq_h_load+104>
0xffff8000080b1818 <update_cfs_rq_h_load+144>:  ret
0xffff8000080b181c <update_cfs_rq_h_load+148>:  ldr     x1, [x0,#352]
0xffff8000080b1820 <update_cfs_rq_h_load+152>:  str     x1, [x0,#536]
0xffff8000080b1824 <update_cfs_rq_h_load+156>:  str     x4, [x0,#544]
0xffff8000080b1828 <update_cfs_rq_h_load+160>:  b       0xffff8000080b17e0 <update_cfs_rq_h_load+88>

The source code of update_cfs_rq_h_load() follows:
static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
{
	struct rq *rq = rq_of(cfs_rq);
	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
	unsigned long now = jiffies;
	unsigned long load;
	if (cfs_rq->last_h_load_update == now)
		return;
	WRITE_ONCE(cfs_rq->h_load_next, NULL);
	for_each_sched_entity(se) {
		cfs_rq = cfs_rq_of(se);
		WRITE_ONCE(cfs_rq->h_load_next, se);
		if (cfs_rq->last_h_load_update == now)
			break;
	}
	if (!se) {
		cfs_rq->h_load = cfs_rq_load_avg(cfs_rq);
		cfs_rq->last_h_load_update = now;
	}
	while ((se = READ_ONCE(cfs_rq->h_load_next)) != NULL) {
		load = cfs_rq->h_load;
		load = div64_ul(load * se->avg.load_avg,
			cfs_rq_load_avg(cfs_rq) + 1);
		cfs_rq = group_cfs_rq(se);
		cfs_rq->h_load = load;
		cfs_rq->last_h_load_update = now;
	}
}

The crash occurred because the line of code "cfs_rq->h_load = load;" accessed
an invalid pointer 006410a84bf5c71c when trying to access cfs->h_load. The
variable cfs_rq was obtained via "cfs_rq = group_cfs_rq(se);". According to
the assembly code, the value of se is stored in register x2, with the pointer
ffff04128c023c00. However, upon inspecting its fields, it turns out that
this object is not a valid sched_entity. We've analyzed the logic of code,
and checked the cfs_rq and se in memory, which are all correct, but we cannot
find out where the pointer ffff04128c023c00 came from. And we've also
analyzed most of the vmcores, and identified a common pattern: all corrupted
pointers belong to the kmalloc-1k slab type, the same as cfs_rq and
sched_entity.

We currently suspect that this is not caused by a scheduler bug. Has anyone
encountered a similar crash stack? Does anyone know why this issue only
occurs on aarch64?

