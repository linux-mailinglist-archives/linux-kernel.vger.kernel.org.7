Return-Path: <linux-kernel+bounces-821076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D703EB804FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0E2487339
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82961333A8F;
	Wed, 17 Sep 2025 14:54:10 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CAB32E72F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120850; cv=none; b=Pe5G++xPsmJVsaW3KB66T2oBH39U80Byd3Mh7S0/5RWQs/IcgGepCYuv3oPNt6WPr2ltGayQ61B6qBEjCehtJi6Jl5/o2W5k5vkY7U7nRAfodQqoWWeg2zrMUro1rYx4CCgOCvHQfoN6AohPCWor1L6IOW7829ykln95KB8Y1mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120850; c=relaxed/simple;
	bh=A/XAUFNzChM3tivqR1cgg9NO3QgHOYW+4B79Aj6VAyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuRrlLRl8dC4BuBNJUtKjeXmy7qNWdy1o1RHINLW7hNCs6w5UKD9QiVHTKyiUwcYcj0eq04Xar7I8vwQq298aI76A+Y7LDRJsMg0SESu+vfUnkelX5oACTuoPKee5FKd8HQ17M6HGH/qXN36+0eHClEPhGr2Ect/BAol3wrdBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6AA9A219ED;
	Wed, 17 Sep 2025 14:54:06 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06F581368D;
	Wed, 17 Sep 2025 14:54:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5FO2K43LymiBEwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 17 Sep 2025 14:54:05 +0000
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
Subject: [PATCH v2 17/21] x86/xen: Drop xen_mmu_ops
Date: Wed, 17 Sep 2025 16:52:16 +0200
Message-ID: <20250917145220.31064-18-jgross@suse.com>
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
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)]
X-Rspamd-Queue-Id: 6AA9A219ED
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

Instead of having a pre-filled array xen_mmu_ops for Xen PV paravirt
functions, drop the array and assign each element individually.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/xen/mmu_pv.c | 100 ++++++++++++++++--------------------------
 tools/objtool/check.c |   1 -
 2 files changed, 38 insertions(+), 63 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 2a4a8deaf612..9fa00c4a8858 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2175,73 +2175,49 @@ static void xen_leave_lazy_mmu(void)
 	preempt_enable();
 }
 
-static const typeof(pv_ops) xen_mmu_ops __initconst = {
-	.mmu = {
-		.read_cr2 = __PV_IS_CALLEE_SAVE(xen_read_cr2),
-		.write_cr2 = xen_write_cr2,
-
-		.read_cr3 = xen_read_cr3,
-		.write_cr3 = xen_write_cr3_init,
-
-		.flush_tlb_user = xen_flush_tlb,
-		.flush_tlb_kernel = xen_flush_tlb,
-		.flush_tlb_one_user = xen_flush_tlb_one_user,
-		.flush_tlb_multi = xen_flush_tlb_multi,
-
-		.pgd_alloc = xen_pgd_alloc,
-		.pgd_free = xen_pgd_free,
-
-		.alloc_pte = xen_alloc_pte_init,
-		.release_pte = xen_release_pte_init,
-		.alloc_pmd = xen_alloc_pmd_init,
-		.release_pmd = xen_release_pmd_init,
-
-		.set_pte = xen_set_pte_init,
-		.set_pmd = xen_set_pmd_hyper,
-
-		.ptep_modify_prot_start = xen_ptep_modify_prot_start,
-		.ptep_modify_prot_commit = xen_ptep_modify_prot_commit,
-
-		.pte_val = PV_CALLEE_SAVE(xen_pte_val),
-		.pgd_val = PV_CALLEE_SAVE(xen_pgd_val),
-
-		.make_pte = PV_CALLEE_SAVE(xen_make_pte_init),
-		.make_pgd = PV_CALLEE_SAVE(xen_make_pgd),
-
-		.set_pud = xen_set_pud_hyper,
-
-		.make_pmd = PV_CALLEE_SAVE(xen_make_pmd),
-		.pmd_val = PV_CALLEE_SAVE(xen_pmd_val),
-
-		.pud_val = PV_CALLEE_SAVE(xen_pud_val),
-		.make_pud = PV_CALLEE_SAVE(xen_make_pud),
-		.set_p4d = xen_set_p4d_hyper,
-
-		.alloc_pud = xen_alloc_pmd_init,
-		.release_pud = xen_release_pmd_init,
-
-		.p4d_val = PV_CALLEE_SAVE(xen_p4d_val),
-		.make_p4d = PV_CALLEE_SAVE(xen_make_p4d),
-
-		.enter_mmap = xen_enter_mmap,
-		.exit_mmap = xen_exit_mmap,
-
-		.lazy_mode = {
-			.enter = xen_enter_lazy_mmu,
-			.leave = xen_leave_lazy_mmu,
-			.flush = xen_flush_lazy_mmu,
-		},
-
-		.set_fixmap = xen_set_fixmap,
-	},
-};
-
 void __init xen_init_mmu_ops(void)
 {
 	x86_init.paging.pagetable_init = xen_pagetable_init;
 	x86_init.hyper.init_after_bootmem = xen_after_bootmem;
 
-	pv_ops.mmu = xen_mmu_ops.mmu;
+	pv_ops.mmu.read_cr2 = __PV_IS_CALLEE_SAVE(xen_read_cr2);
+	pv_ops.mmu.write_cr2 = xen_write_cr2;
+	pv_ops.mmu.read_cr3 = xen_read_cr3;
+	pv_ops.mmu.write_cr3 = xen_write_cr3_init;
+	pv_ops.mmu.flush_tlb_user = xen_flush_tlb;
+	pv_ops.mmu.flush_tlb_kernel = xen_flush_tlb;
+	pv_ops.mmu.flush_tlb_one_user = xen_flush_tlb_one_user;
+	pv_ops.mmu.flush_tlb_multi = xen_flush_tlb_multi;
+	pv_ops.mmu.pgd_alloc = xen_pgd_alloc;
+	pv_ops.mmu.pgd_free = xen_pgd_free;
+	pv_ops.mmu.alloc_pte = xen_alloc_pte_init;
+	pv_ops.mmu.release_pte = xen_release_pte_init;
+	pv_ops.mmu.alloc_pmd = xen_alloc_pmd_init;
+	pv_ops.mmu.release_pmd = xen_release_pmd_init;
+	pv_ops.mmu.set_pte = xen_set_pte_init;
+	pv_ops.mmu.set_pmd = xen_set_pmd_hyper;
+	pv_ops.mmu.ptep_modify_prot_start = xen_ptep_modify_prot_start;
+	pv_ops.mmu.ptep_modify_prot_commit = xen_ptep_modify_prot_commit;
+	pv_ops.mmu.pte_val = PV_CALLEE_SAVE(xen_pte_val);
+	pv_ops.mmu.pgd_val = PV_CALLEE_SAVE(xen_pgd_val);
+	pv_ops.mmu.make_pte = PV_CALLEE_SAVE(xen_make_pte_init);
+	pv_ops.mmu.make_pgd = PV_CALLEE_SAVE(xen_make_pgd);
+	pv_ops.mmu.set_pud = xen_set_pud_hyper;
+	pv_ops.mmu.make_pmd = PV_CALLEE_SAVE(xen_make_pmd);
+	pv_ops.mmu.pmd_val = PV_CALLEE_SAVE(xen_pmd_val);
+	pv_ops.mmu.pud_val = PV_CALLEE_SAVE(xen_pud_val);
+	pv_ops.mmu.make_pud = PV_CALLEE_SAVE(xen_make_pud);
+	pv_ops.mmu.set_p4d = xen_set_p4d_hyper;
+	pv_ops.mmu.alloc_pud = xen_alloc_pmd_init;
+	pv_ops.mmu.release_pud = xen_release_pmd_init;
+	pv_ops.mmu.p4d_val = PV_CALLEE_SAVE(xen_p4d_val);
+	pv_ops.mmu.make_p4d = PV_CALLEE_SAVE(xen_make_p4d);
+	pv_ops.mmu.enter_mmap = xen_enter_mmap;
+	pv_ops.mmu.exit_mmap = xen_exit_mmap;
+	pv_ops.mmu.lazy_mode.enter = xen_enter_lazy_mmu;
+	pv_ops.mmu.lazy_mode.leave = xen_leave_lazy_mmu;
+	pv_ops.mmu.lazy_mode.flush = xen_flush_lazy_mmu;
+	pv_ops.mmu.set_fixmap = xen_set_fixmap;
 
 	memset(dummy_mapping, 0xff, PAGE_SIZE);
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c2a3079fe5f8..e2736b462c90 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -592,7 +592,6 @@ static int init_pv_ops(struct objtool_file *file)
 {
 	static const char *pv_ops_tables[] = {
 		"pv_ops",
-		"xen_mmu_ops",
 		NULL,
 	};
 	const char *pv_ops;
-- 
2.51.0


