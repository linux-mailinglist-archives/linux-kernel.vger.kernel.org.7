Return-Path: <linux-kernel+bounces-813053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACC0B54024
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD48C167745
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C440819F11E;
	Fri, 12 Sep 2025 02:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTuUS4G7"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611D819CC02
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642884; cv=none; b=tqhVR713rIRi5ZkaKQIEcRDEHtPmI+nXXUc0aCC3pu4sw8txRX5rYugaS6smKnMWGivNsikC1OXf4fU3n7nzWOspLftuWQTHGdb8mjRxp0HK8GNbtpQ2zRcZkeaZ9w4iHtdzzv/VotSUI5Ju/grEgVfA/cLA+oideaEQpkYjowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642884; c=relaxed/simple;
	bh=Gq8WbWGZDbtxbSy99nwezsr4RVhQ9WWTubjsriupjEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7wfVJmomwYYDPqhsoTSJe7dJP2yaWg3I5JcRSRJpD8R7dQOn/jTF+zgoZW8CEDomuxKxKtpQHL8BesDwOzDOSffV6I2V+aT6184ozmFP+nQ+FYxqNQutsaQkrRnJ+RueCXby2M6p1B9TPIVjUlO9gsM21Cp+mjvxSb7b2KihEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTuUS4G7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7741991159bso2100046b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757642881; x=1758247681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VcnRq3GBAAvvDcqSNcqv6KJsMa3h2clcJUEaek05ffk=;
        b=LTuUS4G7s0MZb+mexqFviV1gN0Nrd+X5Gdi8OzV06dn2m5OgNA/hMzkgT/cVK6s9mS
         SYiwwLoAfQc1Ujo7Y8nKM8MC1IqhprG/7DAeFk8cU4Rck7+C/sV4Q6sFD73A2ZqT0C/o
         aW2+PpK8Viw3qL01mkpxqOtZYTrXGnNGlnpLuAXuoZs9//sTEI8KfbAbcvSYsyqXmsV/
         y7RB1YoUGkFnymRuBLSkbci7VwLpT4g9ee+xwhl69cAawxchaUkRssygYXX7ZNjLy70b
         ATEipvud4NPDy0qr75Vr29IQ0D6kVqeDpH+brh10ITZxtsz/L9TyafzBVyaexFAhBzCP
         VUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757642881; x=1758247681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcnRq3GBAAvvDcqSNcqv6KJsMa3h2clcJUEaek05ffk=;
        b=pk657ksyYpi2ETBM/a36Vnj71HsnREtirsgQe0ErPYhwaPLB1UMQack9NY4hTkQTKS
         wmpxOK8mv61nUSU3jRDYsvlJAz8fxTCsGzgSU5CHsOPrBp3ccLAD7KtpJoYxwELoSJao
         bB+XEGvX4Ta5uxcudq/oQSAcOMD73vWJWWwOM+JeClw5YM+eSEaqmSRQ4FzICoTkZYdl
         4UYY+9dIznB/U65yuFUjd4BO5qbm4S2UkosaERTJkk6N36VWdLmrCiyzKOjvGME6VjXR
         MOlVqoDHg6IR6GpZ2OvWt6kROdnTpSeAIoLALeakKv9t5gpx6Fdj0GSLirAaA4N1nlmZ
         bFdA==
X-Gm-Message-State: AOJu0YzSkq8CU+duzJCq/rJhz57wHY44BH5ySplY3KPiG8lPA9tVaGyQ
	pTMcn6jX9lC2aao+uV8uI7LC5i8/DwGwmxPdubr8Ym9xB8/9AkNv9o1v
X-Gm-Gg: ASbGncu53SLugctV8cn152auYPUrk7JLfA9vCH6WnXME4fSvQ6sT4qDK4vHYkJuu4dY
	cns1jwS8TgsGZWsMf2U2MnbFyPHYy/2yKxi72gY996btyFbcSYEs8c/P9gww/DT+Xn9/Si8xMfo
	x2DOnF0FSAoOiPn7pS1jPjmsfP8D7cuZrldVv+yHp5ZYEcwbx+YgvXi7SBFxb00kKplafov/GLu
	91Lde1mwgvTaRXIIUAnOoTZyQVuJRTeIlYNYOqUl76o4Hml8pkGDOWL/BtCJuZ9593QQ2v5GHPu
	+pvpuEAZmnqeBevqEWvUpJX0P0ovQLA+PgcqrMKFGd5DAuPvurGUIsj6R31yblty/nNGtZtHisV
	WliXc1AuHjQf9RKe1XdS7YswJlYIjq0iuKyrCMWVmBwIVTE75/y4gIdGuJ6nrNOw=
X-Google-Smtp-Source: AGHT+IGihVcXsTSE2GygDw+r6IIL+GjYYpM99gesrIfo5UsI6LcXoM9B58c/vc0rPJQo4oN9chpzsQ==
X-Received: by 2002:a05:6a00:18a8:b0:772:2850:783d with SMTP id d2e1a72fcca58-776121885e2mr1950056b3a.22.1757642880515;
        Thu, 11 Sep 2025 19:08:00 -0700 (PDT)
Received: from localhost ([103.121.208.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b347f8sm3536333b3a.82.2025.09.11.19.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:08:00 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 1/2] x86/hw_breakpoint: Unify breakpoint install/uninstall
Date: Fri, 12 Sep 2025 10:07:26 +0800
Message-ID: <20250912020742.193292-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate breakpoint management to reduce code duplication.
The diffstat was misleading, so the stripped code size is compared instead.
After refactoring, it is reduced from 11976 bytes to 11448 bytes on my x86_64
system built with clang.This also makes it easier to introduce
arch_reinstall_hw_breakpoint().

Also, add <linux/types.h> to the header file to fix a missing build dependency.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
changes:
- Inline enable parameter for setup_hwbp() in arch_manage_bp()
- move lockdep_assert_irqs_disabled() to arch_manage_bp to fast fail
- update comments to match the refactored functions

v1:
https://lore.kernel.org/all/20250910093951.1330637-1-wangjinchao600@gmail.com/
---
 arch/x86/include/asm/hw_breakpoint.h |   6 ++
 arch/x86/kernel/hw_breakpoint.c      | 141 +++++++++++++++------------
 2 files changed, 84 insertions(+), 63 deletions(-)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index 0bc931cd0698..aa6adac6c3a2 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -5,6 +5,7 @@
 #include <uapi/asm/hw_breakpoint.h>
 
 #define	__ARCH_HW_BREAKPOINT_H
+#include <linux/types.h>
 
 /*
  * The name should probably be something dealt in
@@ -18,6 +19,11 @@ struct arch_hw_breakpoint {
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
index b01644c949b2..3658ace4bd8d 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -48,7 +48,6 @@ static DEFINE_PER_CPU(unsigned long, cpu_debugreg[HBP_NUM]);
  */
 static DEFINE_PER_CPU(struct perf_event *, bp_per_reg[HBP_NUM]);
 
-
 static inline unsigned long
 __encode_dr7(int drnum, unsigned int len, unsigned int type)
 {
@@ -85,96 +84,112 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
 }
 
 /*
- * Install a perf counter breakpoint.
- *
- * We seek a free debug address register and use it for this
- * breakpoint. Eventually we enable it in the debug control register.
- *
- * Atomic: we hold the counter->ctx->lock and we only handle variables
- * and registers local to this cpu.
+ * We seek a slot and change it or keep it based on the action.
+ * Returns slot number on success, negative error on failure.
+ * Must be called with IRQs disabled.
  */
-int arch_install_hw_breakpoint(struct perf_event *bp)
+static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long *dr7;
-	int i;
-
-	lockdep_assert_irqs_disabled();
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
+
+	WARN_ONCE(1, "No free breakpoint slots");
+	return -EBUSY;
+}
+
+static void setup_hwbp(struct arch_hw_breakpoint *info, int slot, bool enable)
+{
+	unsigned long dr7;
 
-	set_debugreg(info->address, i);
-	__this_cpu_write(cpu_debugreg[i], info->address);
+	set_debugreg(info->address, slot);
+	__this_cpu_write(cpu_debugreg[slot], info->address);
 
-	dr7 = this_cpu_ptr(&cpu_dr7);
-	*dr7 |= encode_dr7(i, info->len, info->type);
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
 
-	return 0;
+	/*
+	 * Disabling:
+	 *   Ensure the write to cpu_dr7 is after we've set the DR7 register.
+	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 */
+	if (!enable)
+		this_cpu_write(cpu_dr7, dr7);
 }
 
 /*
- * Uninstall the breakpoint contained in the given counter.
- *
- * First we search the debug address register it uses and then we disable
- * it.
- *
- * Atomic: we hold the counter->ctx->lock and we only handle variables
- * and registers local to this cpu.
+ * find suitable breakpoint slot and set it up based on the action
  */
-void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+static int arch_manage_bp(struct perf_event *bp, enum bp_slot_action action)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long dr7;
-	int i;
+	struct arch_hw_breakpoint *info;
+	int slot;
 
 	lockdep_assert_irqs_disabled();
 
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
+	slot = manage_bp_slot(bp, action);
+	if (slot < 0)
+		return slot;
 
-	dr7 = this_cpu_read(cpu_dr7);
-	dr7 &= ~__encode_dr7(i, info->len, info->type);
+	info = counter_arch_bp(bp);
+	setup_hwbp(info, slot, action != BP_SLOT_ACTION_UNINSTALL);
 
-	set_debugreg(dr7, 7);
-	if (info->mask)
-		amd_set_dr_addr_mask(0, i);
+	return 0;
+}
 
-	/*
-	 * Ensure the write to cpu_dr7 is after we've set the DR7 register.
-	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
-	 */
-	barrier();
+int arch_install_hw_breakpoint(struct perf_event *bp)
+{
+	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
+}
 
-	this_cpu_write(cpu_dr7, dr7);
+void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+{
+	arch_manage_bp(bp, BP_SLOT_ACTION_UNINSTALL);
 }
 
 static int arch_bp_generic_len(int x86_len)
-- 
2.43.0


