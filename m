Return-Path: <linux-kernel+bounces-735024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F635B08996
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F0717BAE8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B906728A702;
	Thu, 17 Jul 2025 09:45:01 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C228A3FC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745501; cv=none; b=WfkOY2TKojqYWcMdnJRP04kQwbQYcFbDWzZRdAW0ZbYMcUOdVFRt7qeXgdmP18ol8lIQechjaaFssejdcibWuSCa7oLmV12SbUKK1EGFjBSZVb7L7IDpyKpeJ5Ib5lGoREAj2bhOK6zEs+dbPceNfqIew/FbaRv+UQ+NRVH3Smg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745501; c=relaxed/simple;
	bh=CKWUAx3I1kSr/hGyutDFcPettfcApk3ft9EYC5zonDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XRa3d3A5xigm/c32a5V/aqQvNSGZQhAHdHk0g9lQHgvAJvHpKWybaY+w+ZMJSw595OI+I5RIC+HLiIia9IDJOrzPu22XfO6ljwhi8Od6xSwNxi+Lq6bVy+J+BTPn2R+h6jxUjG04x+zLAvRtgxXA2HnZeCRjc52Rm9yHwxPcSHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<chang.seok.bae@intel.com>, <sohil.mehta@intel.com>, <peterz@infradead.org>,
	<vigbalas@amd.com>, <aruna.ramakrishna@oracle.com>, <seanjc@google.com>
CC: <linux-kernel@vger.kernel.org>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH] x86/fpu: Fix potential NULL dereference in avx512_status()
Date: Thu, 17 Jul 2025 17:43:08 +0800
Message-ID: <20250717094308.94450-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc7.internal.baidu.com (172.31.3.17) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

When CONFIG_X86_DEBUG_FPU=y is set, x86_task_fpu() returns NULL for
kernel threads. The avx512_status() function would then dereference this
NULL pointer via READ_ONCE(x86_task_fpu(task)->avx512_timestamp).
when reading /proc/*/arch_status, causing a kernel NULL pointer dereference
and system will crash.

[ 8215.540977] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
[ 8215.542290] CPU: 3 UID: 0 PID: 9285 Comm: cat Kdump: loaded Tainted: G        W           6.16.0-rc1 #4 PREEMPT(full)
[ 8215.543000] Tainted: [W]=WARN
[ 8215.544481] RIP: 0010:proc_pid_arch_status+0x30/0xe0
[ 8215.545408] Code: 1f 44 00 00 55 48 89 fd 48 89 cf 53 48 83 ec 08 e8 e5 64 ff ff 48 ba 00 00 00 00 00 fc ff df 48 8d 78 08 48 8
9 f9 48 c1 e9 03 <80> 3c 11 00 75 7d 48 8b 58 08 48 c7 c2 ff ff ff ff 48 85 db 74 3d
[ 8215.548456] RSP: 0018:ff11000194107b08 EFLAGS: 00010202
[ 8215.549443] RAX: 0000000000000000 RBX: ff11000211a9c9a0 RCX: 0000000000000001
[ 8215.550581] RDX: dffffc0000000000 RSI: ffffffff96d0d020 RDI: 0000000000000008
[ 8215.551740] RBP: ff11000111792490 R08: 0000000000000001 R09: ffe21c002117d61d
[ 8215.552917] R10: ff11000108beb0eb R11: 0000000000000000 R12: ff11000108a80b80
[ 8215.554111] R13: ff11000108beb0e8 R14: ffffffff96d0d020 R15: 0000000000000001
[ 8215.555323] FS:  00007f75c18ad740(0000) GS:ff11000e266d1000(0000) knlGS:0000000000000000
[ 8215.556629] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8215.557880] CR2: 00005605184020f8 CR3: 0000000164499005 CR4: 0000000000771ef0
[ 8215.559553] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 8215.560882] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 8215.562205] PKRU: 55555554
[ 8215.563277] Call Trace:
[ 8215.564338]  <TASK>
[ 8215.565383]  proc_single_show+0x10c/0x1c0
[ 8215.566568]  seq_read_iter+0x3e5/0x1050
[ 8215.567787]  seq_read+0x24b/0x3b0
[ 8215.569305]  ? __pfx_seq_read+0x10/0x10
[ 8215.570509]  ? __pfx_handle_pte_fault+0x10/0x10
[ 8215.571782]  ? __pfx_arch_get_unmapped_area_topdown+0x10/0x10
[ 8215.573142]  ? __pfx_cp_new_stat+0x10/0x10
[ 8215.574417]  vfs_read+0x186/0xad0
[ 8215.575657]  ? __pfx_mas_prev+0x10/0x10
[ 8215.576947]  ? __pfx_vfs_read+0x10/0x10
[ 8215.578234]  ? count_memcg_events+0x1ce/0x410
[ 8215.579523]  ? fdget_pos+0x1c9/0x4c0
[ 8215.580737]  ksys_read+0xef/0x1c0
[ 8215.581896]  ? __pfx_ksys_read+0x10/0x10
[ 8215.583265]  ? do_user_addr_fault+0x4c6/0xb50
[ 8215.584633]  do_syscall_64+0x73/0x330
[ 8215.585773]  ? irqentry_exit_to_user_mode+0x32/0x210
[ 8215.586967]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 8215.588137] RIP: 0033:0x7f75c17147e2
[ 8215.589209] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 8a b4 0c 00 e8 a5 1d 02 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 8
5 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
[ 8215.592896] RSP: 002b:00007fffd6935ef8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[ 8215.594238] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f75c17147e2
[ 8215.595551] RDX: 0000000000020000 RSI: 00005605183e2000 RDI: 0000000000000003
[ 8215.596876] RBP: 00005605183e2000 R08: 0000000000000000 R09: 00005605183e10f0
[ 8215.598187] R10: 00005605183fe000 R11: 0000000000000246 R12: 0000000000000000
[ 8215.599494] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
[ 8215.600807]  </TASK>

Fixes: 22aafe3bcb67 ("x86/fpu: Remove init_task FPU state dependencies, add debugging warning for PF_KTHREAD tasks")
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 arch/x86/kernel/fpu/xstate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9aa9ac8399ae..16f813a42f42 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1859,9 +1859,14 @@ long fpu_xstate_prctl(int option, unsigned long arg2)
  */
 static void avx512_status(struct seq_file *m, struct task_struct *task)
 {
-	unsigned long timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
+	unsigned long timestamp = 0;
 	long delta;
 
+#ifdef CONFIG_X86_DEBUG_FPU
+	if (!(task->flags & PF_KTHREAD))
+#endif
+		timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
+
 	if (!timestamp) {
 		/*
 		 * Report -1 if no AVX512 usage
-- 
2.36.1


