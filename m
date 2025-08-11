Return-Path: <linux-kernel+bounces-763463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F03B214F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F52C6806DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BD62E285F;
	Mon, 11 Aug 2025 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzAwqgTE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FF2E2841
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938350; cv=none; b=p7patvH0GuKE23mJXiYika69QlKCZ2DwJhyvwV+KpYjV11AEupXmn65Q5kA6k4KqcT3ZH0g+hfSYY81qWTtVIOijjaaJaMSt3Cq4jywb1PubLrLmXEHO5qUrpjaxJt8bDxJ7DHYpDRkQzmERl58+xPR06KvlFcMAaVhn5pTD91M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938350; c=relaxed/simple;
	bh=fYaF89ZGxZcA704JguwguapVs66UnX8+2glz1bwifTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8F5L58o4cvikhksJxaYNO+73CX4Mk6O+yyBBbYgl3FwcTzyadM3YzuCwR65atSFSxAoL6GGyQyKXMNmDQbq+wE864EluenSlivZ8leXOWMmFIrqOhdfWYrP865HYtQGGW1rJhZK85fmbRRx0s1NtovvzOxUNhs4NSOUW5Oxxag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzAwqgTE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754938349; x=1786474349;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fYaF89ZGxZcA704JguwguapVs66UnX8+2glz1bwifTY=;
  b=AzAwqgTElJ8YwSt+5s1Xvejrq6haRnthzXKPGaAxMi1JfsggzERjS5HV
   JQowAEtWE+LuSYUIo6CkZj4W2Iz4rs5HwDlmV5nDXpBGAatEyHsmLbxEy
   oTi6PO/PxWmdqLey7g6iuxnKwfDDrZJMmwVifujYdj1nKapFtDG6ngx+l
   aDmnxoHMN+y5pwvJps8AKwW8v60hB4NzO0/k/cD50SbhUGZEqLbChMej6
   I0jOweISqxz9f0/jCLEwIbI/bppmP1UtjFQewJ2t9HEoh2yI+nN+vK1JC
   foA1FAEcKwPJezdkBR1PUa1xXPL0GFXGeo1QyjJj2yGCmZ2qjwQuDpk9o
   A==;
X-CSE-ConnectionGUID: 6DQQhSZIQ5SLUhZ0Gnklmw==
X-CSE-MsgGUID: VDKu0NABQZWcdCVuo0FPCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="67801009"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="67801009"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:52:28 -0700
X-CSE-ConnectionGUID: gACR7yndTsK6svcyE/E9fg==
X-CSE-MsgGUID: MmSPUGWJS92icAXechi1TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="170439171"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 11 Aug 2025 11:52:28 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vignesh Balasubramanian <vigbalas@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Eric Biggers <ebiggers@google.com>,
	Kees Cook <kees@kernel.org>,
	Chao Gao <chao.gao@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Fushuai Wang <wangfushuai@baidu.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] x86/fpu: Fix NULL dereference in avx512_status()
Date: Mon, 11 Aug 2025 11:50:44 -0700
Message-ID: <20250811185044.2227268-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fushuai Wang <wangfushuai@baidu.com>

Problem
-------
With CONFIG_X86_DEBUG_FPU enabled, reading /proc/[kthread]/arch_status
causes a kernel NULL pointer dereference.

Kernel threads aren't expected to access the FPU state directly. Kernel
usage of FPU registers is contained within kernel_fpu_begin()/_end()
sections.

However, to report AVX-512 usage, the avx512_timestamp variable within
struct fpu needs to be accessed, which triggers a warning in
x86_task_fpu().

For Kthreads:
  proc_pid_arch_status()
    avx512_status()
      x86_task_fpu() => Warning and returns NULL
      x86_task_fpu()->avx512_timestamp => NULL dereference

The warning is a false alarm since the access isn't intended for
modifying the FPU state. All kernel threads (except the init_task) have
a "struct fpu" with an avx512_timestamp variable that is valid to
access. Also, the init_task (PID 0) never follows this path since it is
not exposed in /proc.

Solution
--------
One option is to get rid of the warning in x86_task_fpu() for kernel
threads. However, that warning was recently added and might be useful to
catch any potential misuse of the FPU state in kernel threads.

A better option is to avoid the access altogether. The kernel does not
track AVX-512 usage for kernel threads.
save_fpregs_to_fpstate()->update_avx_timestamp() is never invoked for
kernel threads, so avx512_timestamp is always guaranteed to be 0.

Also, the legacy behavior of reporting "AVX512_elapsed_ms: -1", which
signifies "no AVX-512 usage", is misleading. The kernel usage just isn't
tracked.

For now, update the ABI for kernel threads and do not report AVX-512
usage for them. Reading /proc/[kthread]/arch_status would display no
AVX-512 information. This avoids the NULL dereference as well as the
misleading report.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Fixes: 22aafe3bcb67 ("x86/fpu: Remove init_task FPU state dependencies, add debugging warning for PF_KTHREAD tasks")
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Co-developed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v4:
 - No significant change, minor wording improvements.

v3: https://lore.kernel.org/lkml/20250724013422.307954-1-sohil.mehta@intel.com/
 - Do not report anything for kernel threads. (DaveH)
 - Make the commit message more precise.

v2:
 - Avoid making the fix dependent on CONFIG_X86_DEBUG_FPU.
 - Include PF_USER_WORKER in the kernel thread check.
 - Update commit message for clarity.
---
 arch/x86/kernel/fpu/xstate.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 12ed75c1b567..28e4fd65c9da 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1881,19 +1881,20 @@ long fpu_xstate_prctl(int option, unsigned long arg2)
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 /*
  * Report the amount of time elapsed in millisecond since last AVX512
- * use in the task.
+ * use in the task. Report -1 if no AVX-512 usage.
  */
 static void avx512_status(struct seq_file *m, struct task_struct *task)
 {
-	unsigned long timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
-	long delta;
+	unsigned long timestamp;
+	long delta = -1;
 
-	if (!timestamp) {
-		/*
-		 * Report -1 if no AVX512 usage
-		 */
-		delta = -1;
-	} else {
+	/* AVX-512 usage is not tracked for kernel threads. Don't report anything. */
+	if (task->flags & (PF_KTHREAD | PF_USER_WORKER))
+		return;
+
+	timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
+
+	if (timestamp) {
 		delta = (long)(jiffies - timestamp);
 		/*
 		 * Cap to LONG_MAX if time difference > LONG_MAX
-- 
2.43.0


