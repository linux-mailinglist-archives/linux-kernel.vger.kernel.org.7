Return-Path: <linux-kernel+bounces-739912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D12B0CCFB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4FD1C2338B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E63A23B614;
	Mon, 21 Jul 2025 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1fLk7gu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8C23C514
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753134869; cv=none; b=gbkVd7CBD7WESJfC6HAvo00FILj/1+uSwpytTID6Hmgs1LUPNQZbvvWDw8F1llrur+YAaEZIBWcFhLvg7RQws/n20s+WhxIQ6drCuQClDMmQFepp0SLur0yOMERqGgql6xPfAHAZBDCcIAotEge7I1eLvCDTB6JRdpp8ashhEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753134869; c=relaxed/simple;
	bh=Gd6dSFshL9MIk0hnfcXivAabeD19AKm3RhdPMrp1PrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FN3RQ6L9utrZN8GMlvKxPHIG7hlntihQaSXWUoIN0XKTaUgSChA/0AKTQDtD0fZCk/q2UjM2kvCYFyMwLufZ5txOkdNqeXwKL4Qma+FmeTGT559PP1+ONHtcSfcDDuMzc+qkNAk5j5x1/trTbzbzM0Ha4Ch7nA5Py+QySRcZaQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1fLk7gu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753134868; x=1784670868;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gd6dSFshL9MIk0hnfcXivAabeD19AKm3RhdPMrp1PrA=;
  b=i1fLk7guJduNLiCsLB+9oESRhReU9sf/nNs8rQy7vC/KnUEjNWxAIuf7
   cFcOVDHRdkHmUb5hGgwrsvqpVRcsKjLLwl/XcPu1dTEDKZ731MNy6oU1X
   yrY78SfVzzmwhoSB2ZmD4vOdhMnC1sBVZVe1YQhouSgkVCy34uC73Sqz5
   LJqR2Rv+R9G11OkJM/tOJ21mL5SKHfeSXrSYgl5rsbE4u+ZUQbdRB9CFT
   1fAfvf+MO9N7XxUQ3PPAO+GFU0LtAkbq5ZGBo7/80dHl7jPCb+EwoZVRl
   HP5PwlBb1QV6XyWlWfSQFOKeoh3/MzC9Es+IJp5TPcfFIAn23JPaJTBGk
   A==;
X-CSE-ConnectionGUID: KE6e8frDT/ObipiHsC8VDw==
X-CSE-MsgGUID: +BCVvK6gTJKmXVXL9Z9q+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="66709214"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="66709214"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 14:54:28 -0700
X-CSE-ConnectionGUID: qxJE5/g0Ssa8jb9GwA1uEQ==
X-CSE-MsgGUID: lu/TkZxVSR6BGFVgMtuAfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="182665263"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa002.fm.intel.com with ESMTP; 21 Jul 2025 14:54:27 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
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
	Fushuai Wang <wangfushuai@baidu.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] x86/fpu: Fix NULL dereference in avx512_status()
Date: Mon, 21 Jul 2025 14:53:01 -0700
Message-ID: <20250721215302.3562784-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fushuai Wang <wangfushuai@baidu.com>

When CONFIG_X86_DEBUG_FPU is set, reading /proc/[kthread]/arch_status
causes a NULL pointer dereference.

For Kthreads tasks:
  proc_pid_arch_status()
    avx512_status()
      x86_task_fpu() => returns NULL when CONFIG_X86_DEBUG_FPU=y
      x86_task_fpu()->avx512_timestamp => NULL dereference

Kernel threads aren't expected to access FPU state directly. However,
avx512_timestamp resides within struct fpu which lead to this unique
situation.

It is uncertain whether kernel threads use AVX-512 in a meaningful way
that needs userspace reporting. For now, avoid reporting AVX-512 usage
for kernel threads.

Fixes: 22aafe3bcb67 ("x86/fpu: Remove init_task FPU state dependencies, add debugging warning for PF_KTHREAD tasks")
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Co-developed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v2:
 - Avoid making the fix dependent on CONFIG_X86_DEBUG_FPU.
 - Include PF_USER_WORKER in the kernel thread check.
 - Update commit message for clarity.

v1: https://lore.kernel.org/lkml/20250717094308.94450-1-wangfushuai@baidu.com/
---
 arch/x86/kernel/fpu/xstate.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9aa9ac8399ae..a75077c645b6 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1855,19 +1855,18 @@ long fpu_xstate_prctl(int option, unsigned long arg2)
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
+	unsigned long timestamp = 0;
+	long delta = -1;
 
-	if (!timestamp) {
-		/*
-		 * Report -1 if no AVX512 usage
-		 */
-		delta = -1;
-	} else {
+	/* Do not report AVX-512 usage for kernel threads */
+	if (!(task->flags & (PF_KTHREAD | PF_USER_WORKER)))
+		timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
+
+	if (timestamp) {
 		delta = (long)(jiffies - timestamp);
 		/*
 		 * Cap to LONG_MAX if time difference > LONG_MAX
-- 
2.43.0


