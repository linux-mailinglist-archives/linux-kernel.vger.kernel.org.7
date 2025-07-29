Return-Path: <linux-kernel+bounces-749924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4406BB154D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C674E4B99
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DEA277813;
	Tue, 29 Jul 2025 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cerea.dev header.i=@cerea.dev header.b="IlUSMY4q"
Received: from mail.cerea.dev (vps-88effe85.vps.ovh.net [51.89.23.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297CD2737E2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.89.23.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753825802; cv=none; b=aLR3G7CcZIQpH0C4FXZneG8314/a+MPGa1GluZnqS3K14y5roZ8bIuBANTf0gAPY88xDnfp5/LhqgVQOrnVm4xtqylVodFIioaY9dVtlWPQsHi9X6rO0JTMi4VwKJqsznjDsFU5adQV40lqBb2q8cpTWg1/ljBY+SskwSLitjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753825802; c=relaxed/simple;
	bh=+1h87gPNPItRPxtA7CzC85HZrt1ZHnGmj651uJENtnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pjqhen3+GiWqhdrjPm0x4pJPRzpmZPw3iTYy0Di/D1ADigevwckg+JVw79472M/CHQ1N37ziau08rTNNtV+RZ0Sh5qIy3Zov29h2LBNnOowCMQOg6yP9kic9mCbHYWIG4Mf862wEoc1vY6QV1xpfJ6BL5cxcwhwRJGNZgHTu34M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cerea.dev; spf=pass smtp.mailfrom=cerea.dev; dkim=pass (2048-bit key) header.d=cerea.dev header.i=@cerea.dev header.b=IlUSMY4q; arc=none smtp.client-ip=51.89.23.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cerea.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cerea.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cerea.dev; s=mail;
	t=1753825481; bh=+1h87gPNPItRPxtA7CzC85HZrt1ZHnGmj651uJENtnU=;
	h=From:To:Cc:Subject:Date:From;
	b=IlUSMY4qLu9kRmsHWRgXAHgrWerP/xpOnlYsCsf7zZyoX904X86ZKYGKnZkNYGdH7
	 eSy5fhPAEwkCOoPnyddx/hiwIQLHNzbNIvraXChJhRPDL2GBeqvWSmFkU9cDtq1RcI
	 CmC7q3yAm9cKotJESMFqkQzsrY2mWz1r4vvyFoM1EUO5mnPQQ78xgQ282JWYl6vq84
	 yli8GiEgwo7f7t+c6hb5GtineWH9NakLTlvhHJSJjgLPTV9aWn8Ix+L3D9i23A4SDl
	 tQf4Ts9ILibAKObYMuAq7TbtHzAA/C1hpgijZnMP3XfgiTGdrPFlJUvARXbFDeVaR3
	 TypiNNCknGyNQ==
From: Samuele Cerea <samuele@cerea.dev>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	Samuele Cerea <samuele@cerea.dev>
Subject: [PATCH] x86 Handle trap flag when instruction is emulated
Date: Tue, 29 Jul 2025 23:44:33 +0200
Message-ID: <20250729214433.734459-1-samuele@cerea.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the kernel emulates an instruction (for UIMP instruction emulation
and iopl emulation) the trap flag (TF) is currently ignored. As a result no
SIGTRAP event is delivered when the instruction is emulated successfully,
breaking the expected behavior for signle-stepping in debuggers.

This patch checks if the TF is set and sends the expected SIGTRAP signal
to the user. Other exception take precedence over the trap flag the SIGTRAP
signal is sent only if the emulation was successful.

The bug can be reproduced by signle-stepping in this code:
    nop
    sldt rax
    sldt rax
    nop
The two sldt instruction will be skipped an the debugger will step directly
to the second nop instruction.

Signed-off-by: Samuele Cerea <samuele@cerea.dev>
---
 arch/x86/kernel/traps.c |  9 +++++++++
 arch/x86/kernel/umip.c  | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 36354b470590..6e7d07a5f587 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -705,6 +705,15 @@ static bool fixup_iopl_exception(struct pt_regs *regs)
 	}
 
 	regs->ip += 1;
+
+	/* If the instruction was emulated successfully, emulate trap flag */
+	if (regs->flags & X86_EFLAGS_TF) {
+		t->cr2 = regs->ip;
+		t->trap_nr = X86_TRAP_DB;
+		t->error_code = 0;
+		force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)regs->ip);
+	}
+
 	return true;
 }
 
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 5a4b21389b1d..c4c462074f1d 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -342,6 +342,7 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	unsigned long *reg_addr;
 	void __user *uaddr;
 	struct insn insn;
+	struct task_struct *tsk = current;
 
 	if (!regs)
 		return false;
@@ -407,5 +408,14 @@ bool fixup_umip_exception(struct pt_regs *regs)
 
 	/* increase IP to let the program keep going */
 	regs->ip += insn.length;
+
+	/* If the instruction was emulated successfully, emulate trap flag */
+	if (regs->flags & X86_EFLAGS_TF) {
+		tsk->thread.cr2 = regs->ip;
+		tsk->thread.trap_nr = X86_TRAP_DB;
+		tsk->thread.error_code = 0;
+		force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)regs->ip);
+	}
+
 	return true;
 }
-- 
2.50.1


