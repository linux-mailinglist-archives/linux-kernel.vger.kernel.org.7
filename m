Return-Path: <linux-kernel+bounces-587180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F047FA7A8DD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 19:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EABA1779CA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 17:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4492252910;
	Thu,  3 Apr 2025 17:47:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD39253B71
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743702442; cv=none; b=o4+dtqNddw5zHz61FTR3f6nPW061SBJjPiu9ocK0ZDueDsmUfm/076EojA7Mmxp06iJaFvGfb3JD66WscVPLrZBvzS5QzB8KxZ9XDT2+yim22kfy3sAX2bHdDkC1veJjhy00W8dCppnL6YQsGx0kJ/79V2DQfT5keM4fcxLKcas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743702442; c=relaxed/simple;
	bh=afGq6vaBuCHVV4TwQlk/pOOSz5YsAKgn4eZzYrQlYYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g46GcLV0CZGNvQ0+DRtjx0J0/vrykR890BI4u+8H9RJgc0IGK84ugZJtn1qPvOCvkteDQeQqRxRY1PimvWrC9T8Hdol0z4bQowDHTkFqZBV3VrOR+wEaqMjs3GT+dvW9NyW2LyS0MEOUMFGBuCoyV88I2j4YnziqkLwas65Yb0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0CB815A1;
	Thu,  3 Apr 2025 10:47:22 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 710F53F63F;
	Thu,  3 Apr 2025 10:47:16 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	anshuman.khandual@arm.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	frederic@kernel.org,
	james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io,
	shameerali.kolothum.thodi@huawei.com,
	huangxiaojia2@huawei.com,
	mark.rutland@arm.com,
	samuel.holland@sifive.com,
	palmer@rivosinc.com,
	charlie@rivosinc.com,
	thiago.bauermann@linaro.org,
	bgray@linux.ibm.com,
	tglx@linutronix.de,
	puranjay@kernel.org,
	david@redhat.com,
	yang@os.amperecomputing.com,
	mbenes@suse.cz,
	joel.granados@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2 3/4] arm64/kernel: support store-only mte tag check
Date: Thu,  3 Apr 2025 18:47:00 +0100
Message-Id: <20250403174701.74312-4-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403174701.74312-1-yeoreum.yun@arm.com>
References: <20250403174701.74312-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce new flag -- MTE_CTRL_STORE_ONLY used to set store-only tag check.
This flag isn't overrided by prefered tcf flag setting but set together
with prefered setting of way to report tag check fault.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/processor.h |  2 ++
 arch/arm64/kernel/mte.c            | 11 ++++++++++-
 arch/arm64/kernel/process.c        |  6 +++++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 1bf1a3b16e88..61d62bfd5a7b 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -23,6 +23,8 @@
 #define MTE_CTRL_TCF_ASYNC		(1UL << 17)
 #define MTE_CTRL_TCF_ASYMM		(1UL << 18)
 
+#define MTE_CTRL_STORE_ONLY		(1UL << 19)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/build_bug.h>
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 2fbfd27ff5f2..e5e773844889 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -200,7 +200,7 @@ static void mte_update_sctlr_user(struct task_struct *task)
 	 * program requested values go with what was requested.
 	 */
 	resolved_mte_tcf = (mte_ctrl & pref) ? pref : mte_ctrl;
-	sctlr &= ~SCTLR_EL1_TCF0_MASK;
+	sctlr &= ~(SCTLR_EL1_TCF0_MASK | SCTLR_EL1_TCSO0_MASK);
 	/*
 	 * Pick an actual setting. The order in which we check for
 	 * set bits and map into register values determines our
@@ -212,6 +212,10 @@ static void mte_update_sctlr_user(struct task_struct *task)
 		sctlr |= SYS_FIELD_PREP_ENUM(SCTLR_EL1, TCF0, ASYNC);
 	else if (resolved_mte_tcf & MTE_CTRL_TCF_SYNC)
 		sctlr |= SYS_FIELD_PREP_ENUM(SCTLR_EL1, TCF0, SYNC);
+
+	if (mte_ctrl & MTE_CTRL_STORE_ONLY)
+		sctlr |= SYS_FIELD_PREP(SCTLR_EL1, TCSO0, 1);
+
 	task->thread.sctlr_user = sctlr;
 }
 
@@ -371,6 +375,9 @@ long set_mte_ctrl(struct task_struct *task, unsigned long arg)
 	    (arg & PR_MTE_TCF_SYNC))
 		mte_ctrl |= MTE_CTRL_TCF_ASYMM;
 
+	if (arg & PR_MTE_STORE_ONLY)
+		mte_ctrl |= MTE_CTRL_STORE_ONLY;
+
 	task->thread.mte_ctrl = mte_ctrl;
 	if (task == current) {
 		preempt_disable();
@@ -398,6 +405,8 @@ long get_mte_ctrl(struct task_struct *task)
 		ret |= PR_MTE_TCF_ASYNC;
 	if (mte_ctrl & MTE_CTRL_TCF_SYNC)
 		ret |= PR_MTE_TCF_SYNC;
+	if (mte_ctrl & MTE_CTRL_STORE_ONLY)
+		ret |= PR_MTE_STORE_ONLY;
 
 	return ret;
 }
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 42faebb7b712..cea4a23a15de 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -815,10 +815,14 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
 	if (is_compat_thread(ti))
 		return -EINVAL;
 
-	if (system_supports_mte())
+	if (system_supports_mte()) {
 		valid_mask |= PR_MTE_TCF_SYNC | PR_MTE_TCF_ASYNC \
 			| PR_MTE_TAG_MASK;
 
+		if (cpus_have_cap(ARM64_MTE_STORE_ONLY))
+			valid_mask |= PR_MTE_STORE_ONLY;
+	}
+
 	if (arg & ~valid_mask)
 		return -EINVAL;
 
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


