Return-Path: <linux-kernel+bounces-842671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0C6BBD447
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC8374E9C94
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465C1267B9B;
	Mon,  6 Oct 2025 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WeTR9cDo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WeTR9cDo"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E52B267B01
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736870; cv=none; b=lG0YwnAkUGyvxxDppsbOF9Kk/Zw9zhxMoxqNA69skrQfECMi3OCIHd0LJS6MfC5cUbP3LEe5GLifTRB6V9SOT+2cpSITEdYlvKMW3CbFDe71ilM5Tfq6KOvJm+rHSqEi8k6k0f3F3pi2FTeNDCQE3TzM9xozzIVarpKYduTMwzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736870; c=relaxed/simple;
	bh=no87mo8EmG95dWfPVUT/L/uXuwjdQ8A8K+XQdNC84UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPeEQTpzosLF+7uqy6xpw1coO4M1m/4xKG0t15INgLjMS9ZqbyHdJrd+774z0PNoGbQCaVIu4Wk4w4OISmj6RCIYuY4RqkfXuT1h7Qd7Ud1NTbjGeV8H7YIwKC61Xhb8rK+KaXE+Jg/SunHyVrtOV3mOW4SvBEeSNUyV0Hsc9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WeTR9cDo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WeTR9cDo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 164AF1F452;
	Mon,  6 Oct 2025 07:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759736867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khFUei9zGttp3ubr1DRkpJBkISV+KPtxkI+g0B1J/iU=;
	b=WeTR9cDouII4QaEVBNqfSl51u+0oMClEC2kzx9/U9r25byIui5glqGqHKy7Bx4wn78ASdd
	HdL0vV13+tkp+MOrm1h0gitTUeNyZnxm72wzisrSZ99+G+Xlhotf7EIfCcCIuqLLjvGIjR
	0xUy8XSlWXMFa3tznzyYCwkzqxLsWm8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759736867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khFUei9zGttp3ubr1DRkpJBkISV+KPtxkI+g0B1J/iU=;
	b=WeTR9cDouII4QaEVBNqfSl51u+0oMClEC2kzx9/U9r25byIui5glqGqHKy7Bx4wn78ASdd
	HdL0vV13+tkp+MOrm1h0gitTUeNyZnxm72wzisrSZ99+G+Xlhotf7EIfCcCIuqLLjvGIjR
	0xUy8XSlWXMFa3tznzyYCwkzqxLsWm8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A308913A7E;
	Mon,  6 Oct 2025 07:47:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vQgPJiJ042i2HgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 06 Oct 2025 07:47:46 +0000
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
Subject: [PATCH v3 16/21] x86/xen: Drop xen_cpu_ops
Date: Mon,  6 Oct 2025 09:46:01 +0200
Message-ID: <20251006074606.1266-17-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006074606.1266-1-jgross@suse.com>
References: <20251006074606.1266-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

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
index 4806cc28d7ca..65df3a0d9cf3 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1212,54 +1212,6 @@ static const struct pv_info xen_info __initconst = {
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
index d66eb37ff294..3d8a5ffb0fee 100644
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


