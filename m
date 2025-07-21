Return-Path: <linux-kernel+bounces-739913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE06B0CCF8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB55173EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1495A2417EF;
	Mon, 21 Jul 2025 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l60rIk08"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C923F431
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753134871; cv=none; b=cHtdNW/1MPFZORyg8ileHrtyFckVfXtyzuajqQyIKweBwKghTTxh6xNFSr8UFX+0HoKcZ8VcXMxxQmlFBIXcHPCbO9CgK4DJRa08v+mi2jXZ/MGDfjV1OwVZfqCnbXhB0rRLd55lzp3pLbGGDXx93GzlGiWYRKzRfDCRRgdsSN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753134871; c=relaxed/simple;
	bh=6hpMy2nbwKxOxc7tIJ9FXpgDwOWlhGBRBQnNGA1DyX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDZwpGZY98gTn69E8f0I6EybX1Zn8uKPCXzRhC9M3fWroyU2WkUiqUB58KDa8UnNhzqJUSmijq3o3VVdHuYuSzfIdwYGMg1ZKLj/gFWExzlkkAOXIHCQpEpIXpRwz5WKCE0OfngF9B4ct/XlniN19OjmdD7RZ6P4rtIghhKR/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l60rIk08; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753134870; x=1784670870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6hpMy2nbwKxOxc7tIJ9FXpgDwOWlhGBRBQnNGA1DyX4=;
  b=l60rIk08imjIhNxA1dqVJV6yk02O1j/9eUDSiWulzi8lxiWoN4KvIxk3
   PttsF0TePZRhHdIvbRXZXuIkMzeECreIImxr/PowsmNg5oyusz0luNU+u
   PpbKzYJ8AbvK4+2pumbd/CrnmGPMgUpHGaJYenaDKjU27rjghGvWJ1O4g
   8jx2xMnSl8yZ8Pm9Ff6lu6nlkaGM2nsuDUJOIGQk12rl3SeI+31t0yTUf
   L+hCXyAPDLxyaZ8crmvmevRbwxJ4ky89I6wJ8OM89X+XCfdQe+d/Z79aM
   pVi1G8pLVKwR2zw7Cpz8WQaIADU2vRlyRoJ0h9ruL/bDxQhBKw40Eqh2a
   g==;
X-CSE-ConnectionGUID: REQ0DrjDSpag9UEsjPrBSg==
X-CSE-MsgGUID: wAEBGelcSBejd8VeqrB2qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="66709224"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="66709224"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 14:54:28 -0700
X-CSE-ConnectionGUID: 6Wqv46mURBCNafyuYp8i8A==
X-CSE-MsgGUID: S/9v6ZKJSC+2FF500hGzvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="182665266"
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
Subject: [PATCH v2 2/2] x86/fpu: Update the debug flow for x86_task_fpu()
Date: Mon, 21 Jul 2025 14:53:02 -0700
Message-ID: <20250721215302.3562784-2-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721215302.3562784-1-sohil.mehta@intel.com>
References: <20250721215302.3562784-1-sohil.mehta@intel.com>
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

When CONFIG_X86_DEBUG_FPU is set, any unintentional usage of
x86_task_fpu() by kernel threads is flagged with a WARN_ON_ONCE().
However, along with the warning, x86_task_fpu() returns a NULL pointer,
which deviates from the flow without the debug config.

Changing the return value could make failures harder to debug by masking
problems or introducing its own set of issues. Keep the behavior of
x86_task_fpu() consistent across debug and non-debug configurations
except for the warning.

Also, update the warning to include PF_USER_WORKER, as these tasks are
treated the same as kernel threads in the FPU context.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v2: New patch

This patch is less urgent than Patch 1 which fixes the real issue. I
haven't used a Fixes tag since this addresses a potential problem rather
than fixing an actual bug.
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


