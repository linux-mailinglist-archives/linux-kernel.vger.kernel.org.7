Return-Path: <linux-kernel+bounces-821075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35F7B804F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA388483977
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268CA32E75A;
	Wed, 17 Sep 2025 14:54:06 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAB432E72F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120845; cv=none; b=JFk8OeNM8Pee9pxBrOFbnP3D46giZr2lnTV6McHYuTh/J3NtNBjYxR6Dc+Z4CAa2lIByAJGnUs2/mdmr7sXZzOGzkWiQqWJz8oF3ckrpc7v3+zqqTEkb3kRTQgKt1muFnruH4VgCMby3pCjVqv9WkiQB8/NckRINoEiC3ZN8mO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120845; c=relaxed/simple;
	bh=2dSVmAT6pf6K/tKli03cHD9SNoWE8VVA05u0bvqnNDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlTXodmJkMtFuwmg+k5WJa0Ki+47HFWqUCsleE5N/DUPDEzti4me6wHTX8ubGGJNlVNfdgoBsuLoHAe1b4PXBOWimwZMWBrUrfHqya40dKzh1/j4AH3HgxOSh8Lad6jmsl3zxPDwzWPqprel4wbazvN8X7cUGZbpqwbsJIDgFg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5BF222073D;
	Wed, 17 Sep 2025 14:54:00 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 009E11368D;
	Wed, 17 Sep 2025 14:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ng47OofLymh3EwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 17 Sep 2025 14:53:59 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v2 16/21] x86/xen: Drop xen_cpu_ops
Date: Wed, 17 Sep 2025 16:52:15 +0200
Message-ID: <20250917145220.31064-17-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917145220.31064-1-jgross@suse.com>
References: <20250917145220.31064-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)]
X-Rspamd-Queue-Id: 5BF222073D
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

Instead of having a pre-filled array xen_cpu_ops for Xen PV paravirt
functions, drop the array and assign each element individually.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/xen/enlighten_pv.c | 82 +++++++++++++++----------------------
 tools/objtool/check.c       |  1 -
 2 files changed, 33 insertions(+), 50 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 26bbaf4b7330..45ce2be41628 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1213,54 +1213,6 @@ static const struct pv_info xen_info __initconst = {
 	.name = "Xen",
 };
 
-static const typeof(pv_ops) xen_cpu_ops __initconst = {
-	.cpu = {
-		.cpuid = xen_cpuid,
-
-		.set_debugreg = xen_set_debugreg,
-		.get_debugreg = xen_get_debugreg,
-
-		.read_cr0 = xen_read_cr0,
-		.write_cr0 = xen_write_cr0,
-
-		.write_cr4 = xen_write_cr4,
-
-		.read_msr = xen_read_msr,
-		.write_msr = xen_write_msr,
-
-		.read_msr_safe = xen_read_msr_safe,
-		.write_msr_safe = xen_write_msr_safe,
-
-		.read_pmc = xen_read_pmc,
-
-		.load_tr_desc = paravirt_nop,
-		.set_ldt = xen_set_ldt,
-		.load_gdt = xen_load_gdt,
-		.load_idt = xen_load_idt,
-		.load_tls = xen_load_tls,
-		.load_gs_index = xen_load_gs_index,
-
-		.alloc_ldt = xen_alloc_ldt,
-		.free_ldt = xen_free_ldt,
-
-		.store_tr = xen_store_tr,
-
-		.write_ldt_entry = xen_write_ldt_entry,
-		.write_gdt_entry = xen_write_gdt_entry,
-		.write_idt_entry = xen_write_idt_entry,
-		.load_sp0 = xen_load_sp0,
-
-#ifdef CONFIG_X86_IOPL_IOPERM
-		.invalidate_io_bitmap = xen_invalidate_io_bitmap,
-		.update_io_bitmap = xen_update_io_bitmap,
-#endif
-		.io_delay = xen_io_delay,
-
-		.start_context_switch = xen_start_context_switch,
-		.end_context_switch = xen_end_context_switch,
-	},
-};
-
 static void xen_restart(char *msg)
 {
 	xen_reboot(SHUTDOWN_reboot);
@@ -1411,7 +1363,39 @@ asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 
 	/* Install Xen paravirt ops */
 	pv_info = xen_info;
-	pv_ops.cpu = xen_cpu_ops.cpu;
+
+	pv_ops.cpu.cpuid = xen_cpuid;
+	pv_ops.cpu.set_debugreg = xen_set_debugreg;
+	pv_ops.cpu.get_debugreg = xen_get_debugreg;
+	pv_ops.cpu.read_cr0 = xen_read_cr0;
+	pv_ops.cpu.write_cr0 = xen_write_cr0;
+	pv_ops.cpu.write_cr4 = xen_write_cr4;
+	pv_ops.cpu.read_msr = xen_read_msr;
+	pv_ops.cpu.write_msr = xen_write_msr;
+	pv_ops.cpu.read_msr_safe = xen_read_msr_safe;
+	pv_ops.cpu.write_msr_safe = xen_write_msr_safe;
+	pv_ops.cpu.read_pmc = xen_read_pmc;
+	pv_ops.cpu.load_tr_desc = paravirt_nop;
+	pv_ops.cpu.set_ldt = xen_set_ldt;
+	pv_ops.cpu.load_gdt = xen_load_gdt;
+	pv_ops.cpu.load_idt = xen_load_idt;
+	pv_ops.cpu.load_tls = xen_load_tls;
+	pv_ops.cpu.load_gs_index = xen_load_gs_index;
+	pv_ops.cpu.alloc_ldt = xen_alloc_ldt;
+	pv_ops.cpu.free_ldt = xen_free_ldt;
+	pv_ops.cpu.store_tr = xen_store_tr;
+	pv_ops.cpu.write_ldt_entry = xen_write_ldt_entry;
+	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry;
+	pv_ops.cpu.write_idt_entry = xen_write_idt_entry;
+	pv_ops.cpu.load_sp0 = xen_load_sp0;
+#ifdef CONFIG_X86_IOPL_IOPERM
+	pv_ops.cpu.invalidate_io_bitmap = xen_invalidate_io_bitmap;
+	pv_ops.cpu.update_io_bitmap = xen_update_io_bitmap;
+#endif
+	pv_ops.cpu.io_delay = xen_io_delay;
+	pv_ops.cpu.start_context_switch = xen_start_context_switch;
+	pv_ops.cpu.end_context_switch = xen_end_context_switch;
+
 	xen_init_irq_ops();
 
 	/*
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 14ae91cc246a..c2a3079fe5f8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -592,7 +592,6 @@ static int init_pv_ops(struct objtool_file *file)
 {
 	static const char *pv_ops_tables[] = {
 		"pv_ops",
-		"xen_cpu_ops",
 		"xen_mmu_ops",
 		NULL,
 	};
-- 
2.51.0


