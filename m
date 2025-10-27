Return-Path: <linux-kernel+bounces-872044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B2CC0F306
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D524E56064B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D840B31062C;
	Mon, 27 Oct 2025 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h4lV+2Ed"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E12530B518
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580296; cv=none; b=bOU/MWJDfPZJ2/vAVnFQgKsKziQYVeoEp8RKlDD2diyQQ87CJmWdOaMEEb3s8Nj1N0qrh5xdlz7ZNeyikiSWzgGpvEJkP+1A4VKEAv5d0kGqRffAVFgC96+RlDclrUFoBfCPC73yZNlXG3X+vbR27bLpTneyWhWD4t5G4x5x3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580296; c=relaxed/simple;
	bh=eFzlaxy03OkylLEsT3hFax4Zyxh5cXxd99ItnpPuKL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwDD7GuzxbLzlSXc+pkXneXgEa0HdWBf0Iar5DrfEHNx3gpQjhVFePVaaJrTpfjfCYovYDxQ8roKHD2iUtlX2L4h/hEofsAEMDMuK3BjXzr/fGrh0286B3YIOm3+GXtV/yXlcXtxBBTzfIaxpDWR3KlVXWI6hAMg0ynOciPHjRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h4lV+2Ed; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761580290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/MS10e7yIxOn6BqiiQzXU5LRaQWFGzhy1OFHDfAgar4=;
	b=h4lV+2EdifuX3tC5nWuMdkfrhdLOHVokPIz0ZuQ+eQPpPXxAj5GmUcL91SPGKPO5hSly+i
	oX29mbwLgLM1mkMbF9LDuDyyAxhn7lk/q6bIWKmNtivTGlyg2hx5KCZ6Uob0HeSef/XCY8
	iLANEwv46QMyNj7pztvJLn/BUijOo/4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Thomas Huth <thuth@redhat.com>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Zheyun Shen <szy0127@sjtu.edu.cn>,
	Kevin Loughlin <kevinloughlin@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Li Chen <chenl311@chinatelecom.cn>,
	Tim Chen <tim.c.chen@linux.intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Ingo Molnar <mingo@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/smpboot: Mark native_play_dead() as __noreturn
Date: Mon, 27 Oct 2025 16:51:02 +0100
Message-ID: <20251027155107.183136-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

native_play_dead() ends by calling the non-returning function
hlt_play_dead() and therefore also never returns.

The !CONFIG_HOTPLUG_CPU stub version of native_play_dead()
unconditionally calls BUG() and does not return either.

Add the __noreturn attribute to both function definitions and their
declaration to document this behavior and to potentially improve
compiler optimizations.

Remove the obsolete comment, and add native_play_dead() to the objtool's
list of __noreturn functions.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/include/asm/smp.h | 2 +-
 arch/x86/kernel/smpboot.c  | 8 ++------
 tools/objtool/noreturns.h  | 1 +
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 22bfebe6776d..84951572ab81 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -109,7 +109,7 @@ int common_cpu_up(unsigned int cpunum, struct task_struct *tidle);
 int native_kick_ap(unsigned int cpu, struct task_struct *tidle);
 int native_cpu_disable(void);
 void __noreturn hlt_play_dead(void);
-void native_play_dead(void);
+void __noreturn native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
 void wbinvd_on_all_cpus(void);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index eb289abece23..a4ba735842a8 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1328,11 +1328,7 @@ void __noreturn hlt_play_dead(void)
 		native_halt();
 }
 
-/*
- * native_play_dead() is essentially a __noreturn function, but it can't
- * be marked as such as the compiler may complain about it.
- */
-void native_play_dead(void)
+void __noreturn native_play_dead(void)
 {
 	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS))
 		__update_spec_ctrl(0);
@@ -1351,7 +1347,7 @@ int native_cpu_disable(void)
 	return -ENOSYS;
 }
 
-void native_play_dead(void)
+void __noreturn native_play_dead(void)
 {
 	BUG();
 }
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 802895fae3ca..14f8ab653449 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -36,6 +36,7 @@ NORETURN(machine_real_restart)
 NORETURN(make_task_dead)
 NORETURN(mpt_halt_firmware)
 NORETURN(mwait_play_dead)
+NORETURN(native_play_dead)
 NORETURN(nmi_panic_self_stop)
 NORETURN(panic)
 NORETURN(vpanic)
-- 
2.51.0


