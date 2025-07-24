Return-Path: <linux-kernel+bounces-743411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A26B0FE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8AE1C2792A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B50186E2E;
	Thu, 24 Jul 2025 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWjFs6eF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC42114B08A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753320958; cv=none; b=ddYsYdBjJIX05Y9/NjQ9zwC7Gp2T2+iIhqCtYL4VWrK7su9ycqzvK86t3351+XWzBP9u8gZp/O1kKO/+evJuNi5Dy9N0om1s+4x8xU9C7nO1b908ob3Dg5rUP20HBcK5I1PwSdmCD+PqTb3NAo/+2R3587rAYwL4i1ngqBNg7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753320958; c=relaxed/simple;
	bh=Fpts88Ytj/ky9jWGuM5QKIJrxhwMNnRA9WLn/QMCJLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQZQaMCoTOxe7iAkl7IleUv8h7ys0Ep3JlkT//fsabbVDZ8b9HSaoNfI38pHGPP+FsnAW6L+gWQaYKZMfcwmqidt9antlXxE0Ue8hiI/cWLT4kBO4F+WtrDlrKjm608t5zMBKEjyB/pYdtK7PbvyEhsF3qMOrgP8LQSBV3MrCSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWjFs6eF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753320957; x=1784856957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fpts88Ytj/ky9jWGuM5QKIJrxhwMNnRA9WLn/QMCJLE=;
  b=UWjFs6eFYou4wYun9bXheslYc/M7bdpJO9llglbQl1I0TqYB+pmFaf0R
   Psj+YlWy+0JkoOqfq9MGEScAqGW+TI2vh5klJw30+HslKjQevGb4AmZYG
   NN1Zw/6Xnufx3j8tOym1Rs4qR6LziGFfL0/lyNOvr0H4xSTIAhQ4H2lNO
   Yd14zrpTBuNS4rrd4Zjj/JUOtjUSwGyR+yHq8EGlICCpl2pFiobJ/phBc
   vFEbw+TX904CIMbF90kRLBTV3EAwCpC6+FvxRPVyu3Tmoi0kYpCDIqZqI
   HIxYOY3kyeHDykDbbrkKPb/lYsya6P07pkwnIK+Sh7b+8cqTbbN2rF4w+
   w==;
X-CSE-ConnectionGUID: pzljkzu8SemlUWo1EbVuWw==
X-CSE-MsgGUID: FXT05yXGSQ+mZj6JqY0bPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59434484"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="59434484"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 18:35:56 -0700
X-CSE-ConnectionGUID: EBCejcjZQhO5MsbdzoIjEw==
X-CSE-MsgGUID: Na/tR0yDSTGqfWFG65mmJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="164010229"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa003.fm.intel.com with ESMTP; 23 Jul 2025 18:35:56 -0700
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
	Fushuai Wang <wangfushuai@baidu.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] x86/fpu: Update the debug flow for x86_task_fpu()
Date: Wed, 23 Jul 2025 18:34:22 -0700
Message-ID: <20250724013422.307954-2-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724013422.307954-1-sohil.mehta@intel.com>
References: <20250724013422.307954-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel threads aren't expected to directly access struct fpu using
x86_task_fpu(). They typically access the FPU state using pairs of
kernel_fpu_begin()/kernel_fpu_end().

When CONFIG_X86_DEBUG_FPU is set, any usage of x86_task_fpu() by kernel
threads is flagged with a WARN_ON_ONCE(). However, along with the
warning, x86_task_fpu() returns a NULL pointer, which deviates from the
flow without the debug config.

Changing the return value could make failures harder to debug by masking
problems or introducing its own set of issues. Keep the behavior of
x86_task_fpu() consistent across debug and non-debug configurations,
except for the warning.

Also, update the warning to include PF_USER_WORKER, as these tasks are
treated as equivalent to kernel threads during FPU state management as
well as context switch.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v3: Improve commit message
v2: New patch

This patch is less urgent than Patch 1, which fixes the real issue.
---
 arch/x86/kernel/fpu/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index ea138583dd92..ba16dda697b1 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -58,8 +58,7 @@ DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 #ifdef CONFIG_X86_DEBUG_FPU
 struct fpu *x86_task_fpu(struct task_struct *task)
 {
-	if (WARN_ON_ONCE(task->flags & PF_KTHREAD))
-		return NULL;
+	WARN_ON_ONCE(task->flags & (PF_KTHREAD | PF_USER_WORKER));
 
 	return (void *)task + sizeof(*task);
 }
-- 
2.43.0


