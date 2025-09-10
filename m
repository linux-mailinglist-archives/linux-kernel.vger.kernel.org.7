Return-Path: <linux-kernel+bounces-809851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB6EB512CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196E01C21C96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5E03148C2;
	Wed, 10 Sep 2025 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPsCd9YX"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC00241139
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497212; cv=none; b=KCCSKhalLzcvF4BGsnwQeiSMXcx4LGOmNArT9mNJxphVzE4F3Bbo5i2J4xbvKbyKwO5HTJNvDISHsb/m30f0MNrYrzbKBj1cyArO1IvajI3wVKkg/oAOr6pep/KZjBNAMBmPV8VQxJZWUZe1/3OKFsyt8gcMcxlJX5mQrLXpR04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497212; c=relaxed/simple;
	bh=k+BVyUjc1/ijg+hKJGRZW7dodqYh8m+xox9iQQB2VLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0d2H98PpzHtoaBg9Dranstuf03VUCG8tUePtAQhcN6Afx+brMZxr9sok+kkD8THAlnXehBTfAUiEUTFWUMF7TZADhIbmkLsEbUNpqUnOw5ZgjqFrQootxDA4Z0VhhP45qw+NQBpxyBqCrWppNz3Ppzy+DOkuFAZj/pFVYwmTzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPsCd9YX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7722bcb989aso4950291b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757497210; x=1758102010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JW1P5S5qmkkCKwfUO8dX3zbIhUBUQoSb8MahPsyAhEk=;
        b=RPsCd9YXYJW3rkXCVKNJ68582Tp7zwfFP17NhSomQrt06MIjqTW+YQA6YLVel2Khx7
         54s9nn7vNnJ7MeMJGtKNmWMQBh/4IPMKKNy5BDiOjZtSL4kD16ANuJ2nhDikSBQNAJ+A
         jQJg2uHofdW14jBnjwlzECx7O0hyDtFv9LbEPOOXTIlGe5YT4Ge+QaHEyFewVqTlm6EC
         99cEsjf5rad9mR1Fq7Rp2JnL2fY/YshlNa28vKQUfnJgi5ds6loChovzz3OafgJVaMbg
         MvC4///asgaLVM6sio33f9q4gbyUOtWV0oBbByPqwfiz9vA1a80yh5EOK7Bnfgg3tOP0
         Pb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497210; x=1758102010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JW1P5S5qmkkCKwfUO8dX3zbIhUBUQoSb8MahPsyAhEk=;
        b=Y2xJc7zmju1JYPAt/6siIoESEqqYRgBslNPcZqd5AvQbijbFqOWKDPP7NUQAoST2k2
         iMLE9FV9jxwbzLKgg8OKKTzBWFpL512E8eKI5bO33YA51kLCQuFGdxkWqPnOrwTZ44TX
         Oh0Y2VLqaxC0gqDUquhO6U1UHJKyzQFAzs/vypzvws6nHFnta7dEevqB8GbTwBxX/B+w
         JHd8JD7IWFs4GJzU8RjxMNWn0Q9yz0MHrbWIh4p5zvjpWrnwsokBjPz926ESQAQ2A8lH
         4Vwvu1z7In2yRDP7YoGblNO0F9EJlUYk8bA6L3d/S6eSw1387aRfqMOijmgpXpkceSBf
         nToQ==
X-Gm-Message-State: AOJu0YzKVoy4CLGLdO+/YzRSoACJnfSWbOinaM7BZzKLxELboi0qNfM/
	7jubrppSixlVMxfKZr3aP4U0P80NoecCW4+07i4V0eW5dZPIAzAGp0lB
X-Gm-Gg: ASbGnctinP49rjoz0qWDGOgIqyahwSaMk6w0NiRfNZBe9y9X6k8ieCJZIZuVo3QLlD1
	SxQ58kYSpRNpnayLpx2fyX9nuxladn21aiYatDqhYRpsVKAAT+0AKKY+OSrO2KK5uD5sM6vQPKa
	bRuQTbAAFvuu8PNzxd5tbvrNpsesoTRyuSZ68DFLBE2vCDeBtzYBmHiOU6zZRWvafvWMmdOyiyl
	E6+cSsyE8RN/ZHVtZULHPScjXau/cVUhewXTnbpl+AYp7p5KAQaekKPrNC7gVEM5nM60/OawVpe
	NpFZMJaW5wAM8bgEWmnYyP1393+hDAK9FG9oMM9MV369oBMps/dvu4vAxDqQ0b8WUJE3zt+7wLA
	FPK5NL4ApLtJDVu+g2AE4reeV7StWGWDj5vohcDLI
X-Google-Smtp-Source: AGHT+IH351r3/PWRbrn7AeUm2jcyJ0o41qVS8jYUr+vMEqCqJrGzNu89abDolCYPrP6ig0HfNxTAvA==
X-Received: by 2002:a05:6a20:6a10:b0:248:e0f7:1331 with SMTP id adf61e73a8af0-2533e94fa7fmr22952626637.3.1757497210400;
        Wed, 10 Sep 2025 02:40:10 -0700 (PDT)
Received: from localhost ([45.90.208.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a61bdc4sm2041078a12.23.2025.09.10.02.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:40:09 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jinchao Wang <wangjinchao600@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/hw_breakpoint: Unify breakpoint install/uninstall
Date: Wed, 10 Sep 2025 17:39:34 +0800
Message-ID: <20250910093951.1330637-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate breakpoint management into a single helper function to
reduce code duplication. This introduces new static helpers for
slot management and debug register manipulation.

Also, add `<linux/types.h>` to the header file to fix a build
dependency.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/x86/include/asm/hw_breakpoint.h |   7 +-
 arch/x86/kernel/hw_breakpoint.c      | 151 ++++++++++++++++-----------
 2 files changed, 96 insertions(+), 62 deletions(-)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index 0bc931cd0698..bd437a30dbf2 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -3,8 +3,8 @@
 #define	_I386_HW_BREAKPOINT_H
 
 #include <uapi/asm/hw_breakpoint.h>
-
 #define	__ARCH_HW_BREAKPOINT_H
+#include <linux/types.h>
 
 /*
  * The name should probably be something dealt in
@@ -18,6 +18,11 @@ struct arch_hw_breakpoint {
 	u8		type;
 };
 
+enum bp_slot_action {
+	BP_SLOT_ACTION_INSTALL,
+	BP_SLOT_ACTION_UNINSTALL,
+};
+
 #include <linux/kdebug.h>
 #include <linux/percpu.h>
 #include <linux/list.h>
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index b01644c949b2..1736063a82b7 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -48,7 +48,6 @@ static DEFINE_PER_CPU(unsigned long, cpu_debugreg[HBP_NUM]);
  */
 static DEFINE_PER_CPU(struct perf_event *, bp_per_reg[HBP_NUM]);
 
-
 static inline unsigned long
 __encode_dr7(int drnum, unsigned int len, unsigned int type)
 {
@@ -84,54 +83,115 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
 	return (dr7 >> (bpnum * DR_ENABLE_SIZE)) & 0x3;
 }
 
-/*
- * Install a perf counter breakpoint.
- *
- * We seek a free debug address register and use it for this
- * breakpoint. Eventually we enable it in the debug control register.
- *
- * Atomic: we hold the counter->ctx->lock and we only handle variables
- * and registers local to this cpu.
- */
-int arch_install_hw_breakpoint(struct perf_event *bp)
+static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long *dr7;
-	int i;
+	struct perf_event *old_bp;
+	struct perf_event *new_bp;
+	int slot;
+
+	switch (action) {
+	case BP_SLOT_ACTION_INSTALL:
+		old_bp = NULL;
+		new_bp = bp;
+		break;
+	case BP_SLOT_ACTION_UNINSTALL:
+		old_bp = bp;
+		new_bp = NULL;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	lockdep_assert_irqs_disabled();
 
-	for (i = 0; i < HBP_NUM; i++) {
-		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
+	for (slot = 0; slot < HBP_NUM; slot++) {
+		struct perf_event **curr = this_cpu_ptr(&bp_per_reg[slot]);
 
-		if (!*slot) {
-			*slot = bp;
-			break;
+		if (*curr == old_bp) {
+			*curr = new_bp;
+			return slot;
 		}
 	}
 
-	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
-		return -EBUSY;
+	if (old_bp) {
+		WARN_ONCE(1, "Can't find matching breakpoint slot");
+		return -EINVAL;
+	}
 
-	set_debugreg(info->address, i);
-	__this_cpu_write(cpu_debugreg[i], info->address);
+	WARN_ONCE(1, "No free breakpoint slots");
+	return -EBUSY;
+}
 
-	dr7 = this_cpu_ptr(&cpu_dr7);
-	*dr7 |= encode_dr7(i, info->len, info->type);
+static void setup_hwbp(struct arch_hw_breakpoint *info, int slot, bool enable)
+{
+	unsigned long dr7;
+
+	set_debugreg(info->address, slot);
+	__this_cpu_write(cpu_debugreg[slot], info->address);
+
+	dr7 = this_cpu_read(cpu_dr7);
+	if (enable)
+		dr7 |= encode_dr7(slot, info->len, info->type);
+	else
+		dr7 &= ~__encode_dr7(slot, info->len, info->type);
 
 	/*
-	 * Ensure we first write cpu_dr7 before we set the DR7 register.
-	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 * Enabling:
+	 *   Ensure we first write cpu_dr7 before we set the DR7 register.
+	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
 	 */
+	if (enable)
+		this_cpu_write(cpu_dr7, dr7);
+
 	barrier();
 
-	set_debugreg(*dr7, 7);
+	set_debugreg(dr7, 7);
+
 	if (info->mask)
-		amd_set_dr_addr_mask(info->mask, i);
+		amd_set_dr_addr_mask(enable ? info->mask : 0, slot);
+
+	/*
+	 * Disabling:
+	 *   Ensure the write to cpu_dr7 is after we've set the DR7 register.
+	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 */
+	if (!enable)
+		this_cpu_write(cpu_dr7, dr7);
+}
+
+static int arch_manage_bp(struct perf_event *bp, enum bp_slot_action action)
+{
+	struct arch_hw_breakpoint *info;
+	bool install = true;
+	int slot;
+
+	if (action == BP_SLOT_ACTION_UNINSTALL)
+		install = false;
+
+	slot = manage_bp_slot(bp, action);
+	if (slot < 0)
+		return slot;
+
+	info = counter_arch_bp(bp);
+	setup_hwbp(info, slot, install);
 
 	return 0;
 }
 
+/*
+ * Install a perf counter breakpoint.
+ *
+ * We seek a free debug address register and use it for this
+ * breakpoint. Eventually we enable it in the debug control register.
+ *
+ * Atomic: we hold the counter->ctx->lock and we only handle variables
+ * and registers local to this cpu.
+ */
+int arch_install_hw_breakpoint(struct perf_event *bp)
+{
+	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
+}
+
 /*
  * Uninstall the breakpoint contained in the given counter.
  *
@@ -143,38 +203,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
  */
 void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long dr7;
-	int i;
-
-	lockdep_assert_irqs_disabled();
-
-	for (i = 0; i < HBP_NUM; i++) {
-		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
-
-		if (*slot == bp) {
-			*slot = NULL;
-			break;
-		}
-	}
-
-	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
-		return;
-
-	dr7 = this_cpu_read(cpu_dr7);
-	dr7 &= ~__encode_dr7(i, info->len, info->type);
-
-	set_debugreg(dr7, 7);
-	if (info->mask)
-		amd_set_dr_addr_mask(0, i);
-
-	/*
-	 * Ensure the write to cpu_dr7 is after we've set the DR7 register.
-	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
-	 */
-	barrier();
-
-	this_cpu_write(cpu_dr7, dr7);
+	arch_manage_bp(bp, BP_SLOT_ACTION_UNINSTALL);
 }
 
 static int arch_bp_generic_len(int x86_len)
-- 
2.43.0


