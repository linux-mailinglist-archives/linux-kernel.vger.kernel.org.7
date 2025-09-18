Return-Path: <linux-kernel+bounces-789723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EF7B399A0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52131C80559
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D6D30DD3F;
	Thu, 28 Aug 2025 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qe7saVXC"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BECA30C631
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376567; cv=none; b=cYlyGKxl6469CEKMN+nUbcLIsbX2GTS9Io8olNKq2ogOLLILxp2i/4xT7pfvd5RzDbSKGrssmRi859rJVPQxdxMbmMzttcOWOV9T/+iRkmNUxxEtkssDgaYnNsTpxJTwnoVT2LAVYfflFIxUUS0DgT3FhO03isVlCpPnLKMHswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376567; c=relaxed/simple;
	bh=tLaPhUguUM/PI9xAxwsDHXuGsrdgnKL0BD0Opxo8h24=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DB/gEC8bU9PaLIz7b1Gr1PhQBeEQ6mZJRTKAPSVeoOD1ORm5mNUMgqG6zV6jjzsKTyVYWyiBHloeFJez/J2rOVdUOhk97iLwWpQ6PzR9q/SrDabsCWBIaC7ZHcsY78qF1B8EZlu9enD7jr/WAljxf2Kl1HFK3JCyiHMgWvZtnkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qe7saVXC; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b72ef3455so3102945e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376564; x=1756981364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNCY6N69YmEJE7R1qRiSebg4lbkiA/HE7mx7CXEi9Ik=;
        b=Qe7saVXCJWQKjgylVEHJsaIDmNWI9vKqm1f3O81xef6+8DthzEB7zXDOCvpdJZqmBS
         wzo9isAPlMbLtdKXz92Oy7+an4dS1pEUpZpPDlLcV9HanSr/fGEwpk+RBbcWcMj919Wh
         LxQKm45Q85KwyEhD74UvTSKx/6cdCd0zLJuCVDDf0LR5WqjOPOA6bvqPBHxVtQ6TcgGe
         vOkU3c36B6ovYs1yc5Splr1Xw9xToK2HH04XtPsDKyU5cWAZxaeRV+qHMofGG65yMDXU
         JDCVdKaM9ROCTzkx9PL4srYax+JQJWO7s/6JD8zj+gU3z/TaUcCE/YJd53wjuJYMl91L
         +m+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376564; x=1756981364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNCY6N69YmEJE7R1qRiSebg4lbkiA/HE7mx7CXEi9Ik=;
        b=a74SpYb6rORYUULGlDBWr02bBxeLJh5UvXSZqdw6Ts/Zq+vaJcl6zq+Zj0L4bLg+35
         scjIslC5G50wSteWR7vLZN+Wkc01wmPuTufN7HkODPW4D5gqoS6jVqSeh65lLl1I1eFO
         kijhliEPqfqrWnQJNhDtApqkC/ZPyj4RKZbOaQznQZxQIXJPp/rJUsODtHpbQrz6WjcM
         9+DF9xyrolpSPy0ABhsoP0pPVXtkjjkPUfHQUa4EV4NwWn0QD3K+tiFL+V0vQk/qft4Y
         5Vet2w+izkWLnHQsP8OVlQuEvQDg27hFP38c2sqv+zoE9OW/IRFJtxYeZf0ckpIxV4QN
         YrZQ==
X-Gm-Message-State: AOJu0Yxv+r2+d0hFxFMJVQKX71lSYFqZA9bNB/h3+0CvsqPf/nZOCBiu
	SIcSGq7jPeQ7i6R0FAMwQtInbca9h+58kqlmJjiCr0ghzuXYYD+5TUiEpTzhVcUzOUOdMawLaCV
	cD5+vWkqe/pAw3PXMTClspj8jKHKNOZkUXyAGKkD/p5ci/l7U5XPbnkAHl7/AVRVShWwSOe51rj
	ipC6XH2Mt3/WH+u5qNr+VBTWSMEbhJWWC5xw==
X-Google-Smtp-Source: AGHT+IGqmtxQAOqEMOYjKGtwkS5jpnqk7ur2o3gyegX4NXm3c1WylL/q8jt8awmhO8UwmrwNWz3lyfa1
X-Received: from wmbdo20.prod.google.com ([2002:a05:600c:6814:b0:45a:2855:e836])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:45cc:b0:456:1e5a:8879
 with SMTP id 5b1f17b1804b1-45b517a067cmr199832635e9.9.1756376563788; Thu, 28
 Aug 2025 03:22:43 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:11 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=9416; i=ardb@kernel.org;
 h=from:subject; bh=epKBfGpTOldMVfw8yHDo9rbn8A28IptnON9A0982n2I=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7hUO0TLeJr63l3Nrf9zbuWN1wE0V2xUlUU5/AiSzq
 2Wr0z51lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImUsTAyrM48UzT5SQmjwac5
 5t6b3+9nzlyq83fr/yY/GX7dHO2rJxn+u1002RsdU77lSyVDabxaUsqCziSJOfv/MHh8b3r59a4 sLwA=
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-32-ardb+git@google.com>
Subject: [PATCH v7 08/22] x86/sev: Pass SVSM calling area down to early page
 state change API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The early page state change API is mostly only used very early, when
only the boot time SVSM calling area is in use. However, this API is
also called by the kexec finishing code, which runs very late, and
potentially from a different CPU (which uses a different calling area).

To avoid pulling the per-CPU SVSM calling area pointers and related SEV
state into the startup code, refactor the page state change API so the
SVSM calling area virtual and physical addresses can be provided by the
caller.

No functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      | 24 +++++++++++++++++---
 arch/x86/boot/startup/sev-shared.c  | 23 ++++++++++---------
 arch/x86/boot/startup/sev-startup.c | 16 +++++++++----
 arch/x86/coco/sev/core.c            |  7 ++++--
 arch/x86/include/asm/sev-internal.h |  2 +-
 arch/x86/include/asm/sev.h          |  6 +++++
 6 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index f714235d3222..dffe607e6d8b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -62,18 +62,30 @@ static bool sev_snp_enabled(void)
 
 void snp_set_page_private(unsigned long paddr)
 {
+	struct psc_desc d = {
+		SNP_PAGE_STATE_PRIVATE,
+		(struct svsm_ca *)boot_svsm_caa_pa,
+		boot_svsm_caa_pa
+	};
+
 	if (!sev_snp_enabled())
 		return;
 
-	__page_state_change(paddr, paddr, SNP_PAGE_STATE_PRIVATE);
+	__page_state_change(paddr, paddr, &d);
 }
 
 void snp_set_page_shared(unsigned long paddr)
 {
+	struct psc_desc d = {
+		SNP_PAGE_STATE_SHARED,
+		(struct svsm_ca *)boot_svsm_caa_pa,
+		boot_svsm_caa_pa
+	};
+
 	if (!sev_snp_enabled())
 		return;
 
-	__page_state_change(paddr, paddr, SNP_PAGE_STATE_SHARED);
+	__page_state_change(paddr, paddr, &d);
 }
 
 bool early_setup_ghcb(void)
@@ -98,8 +110,14 @@ bool early_setup_ghcb(void)
 
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
+	struct psc_desc d = {
+		SNP_PAGE_STATE_PRIVATE,
+		(struct svsm_ca *)boot_svsm_caa_pa,
+		boot_svsm_caa_pa
+	};
+
 	for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
-		__page_state_change(pa, pa, SNP_PAGE_STATE_PRIVATE);
+		__page_state_change(pa, pa, &d);
 }
 
 void sev_es_shutdown_ghcb(void)
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 4c94d88f5ac8..b86027d9a968 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -600,7 +600,8 @@ static int __head svsm_call_msr_protocol(struct svsm_call *call)
 	return ret;
 }
 
-static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
+static void __head svsm_pval_4k_page(unsigned long paddr, bool validate,
+				     struct svsm_ca *caa, u64 caa_pa)
 {
 	struct svsm_pvalidate_call *pc;
 	struct svsm_call call = {};
@@ -613,10 +614,10 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	 */
 	flags = native_local_irq_save();
 
-	call.caa = svsm_get_caa();
+	call.caa = caa;
 
 	pc = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
-	pc_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+	pc_pa = caa_pa + offsetof(struct svsm_ca, svsm_buffer);
 
 	pc->num_entries = 1;
 	pc->cur_index   = 0;
@@ -642,12 +643,12 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 }
 
 static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
-				     bool validate)
+				     bool validate, struct svsm_ca *caa, u64 caa_pa)
 {
 	int ret;
 
 	if (snp_vmpl) {
-		svsm_pval_4k_page(paddr, validate);
+		svsm_pval_4k_page(paddr, validate, caa, caa_pa);
 	} else {
 		ret = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
 		if (ret)
@@ -663,7 +664,7 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 }
 
 static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
-				       enum psc_op op)
+				       const struct psc_desc *desc)
 {
 	u64 val, msr;
 
@@ -671,14 +672,14 @@ static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
 	 * If private -> shared then invalidate the page before requesting the
 	 * state change in the RMP table.
 	 */
-	if (op == SNP_PAGE_STATE_SHARED)
-		pvalidate_4k_page(vaddr, paddr, false);
+	if (desc->op == SNP_PAGE_STATE_SHARED)
+		pvalidate_4k_page(vaddr, paddr, false, desc->ca, desc->caa_pa);
 
 	/* Save the current GHCB MSR value */
 	msr = sev_es_rd_ghcb_msr();
 
 	/* Issue VMGEXIT to change the page state in RMP table. */
-	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
+	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, desc->op));
 	VMGEXIT();
 
 	/* Read the response of the VMGEXIT. */
@@ -693,8 +694,8 @@ static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
 	 * Now that page state is changed in the RMP table, validate it so that it is
 	 * consistent with the RMP entry.
 	 */
-	if (op == SNP_PAGE_STATE_PRIVATE)
-		pvalidate_4k_page(vaddr, paddr, true);
+	if (desc->op == SNP_PAGE_STATE_PRIVATE)
+		pvalidate_4k_page(vaddr, paddr, true, desc->ca, desc->caa_pa);
 }
 
 /*
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 5eb7d939ebd3..8009a37d53c1 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -132,7 +132,7 @@ noinstr void __sev_put_ghcb(struct ghcb_state *state)
 
 void __head
 early_set_pages_state(unsigned long vaddr, unsigned long paddr,
-		      unsigned long npages, enum psc_op op)
+		      unsigned long npages, const struct psc_desc *desc)
 {
 	unsigned long paddr_end;
 
@@ -142,7 +142,7 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 	paddr_end = paddr + (npages << PAGE_SHIFT);
 
 	while (paddr < paddr_end) {
-		__page_state_change(vaddr, paddr, op);
+		__page_state_change(vaddr, paddr, desc);
 
 		vaddr += PAGE_SIZE;
 		paddr += PAGE_SIZE;
@@ -152,6 +152,10 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 					 unsigned long npages)
 {
+	struct psc_desc d = {
+		SNP_PAGE_STATE_PRIVATE, svsm_get_caa(), svsm_get_caa_pa()
+	};
+
 	/*
 	 * This can be invoked in early boot while running identity mapped, so
 	 * use an open coded check for SNP instead of using cc_platform_has().
@@ -165,12 +169,16 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	  * Ask the hypervisor to mark the memory pages as private in the RMP
 	  * table.
 	  */
-	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE);
+	early_set_pages_state(vaddr, paddr, npages, &d);
 }
 
 void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned long npages)
 {
+	struct psc_desc d = {
+		SNP_PAGE_STATE_SHARED, svsm_get_caa(), svsm_get_caa_pa()
+	};
+
 	/*
 	 * This can be invoked in early boot while running identity mapped, so
 	 * use an open coded check for SNP instead of using cc_platform_has().
@@ -181,7 +189,7 @@ void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 		return;
 
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
-	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
+	early_set_pages_state(vaddr, paddr, npages, &d);
 }
 
 /*
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ff1e2be8b5a8..a833b2b31d3d 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -607,8 +607,11 @@ static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
 	unsigned long vaddr_end;
 
 	/* Use the MSR protocol when a GHCB is not available. */
-	if (!boot_ghcb)
-		return early_set_pages_state(vaddr, __pa(vaddr), npages, op);
+	if (!boot_ghcb) {
+		struct psc_desc d = { op, svsm_get_caa(), svsm_get_caa_pa() };
+
+		return early_set_pages_state(vaddr, __pa(vaddr), npages, &d);
+	}
 
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index ffe4755962fe..9ff824540b48 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -55,7 +55,7 @@ DECLARE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DECLARE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 
 void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
-			   unsigned long npages, enum psc_op op);
+			   unsigned long npages, const struct psc_desc *desc);
 
 DECLARE_PER_CPU(struct svsm_ca *, svsm_caa);
 DECLARE_PER_CPU(u64, svsm_caa_pa);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index fd11b266a67a..416715aaadf7 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -569,6 +569,12 @@ bool sev_es_check_cpu_features(void);
 extern u16 ghcb_version;
 extern struct ghcb *boot_ghcb;
 
+struct psc_desc {
+	enum psc_op op;
+	struct svsm_ca *ca;
+	u64 caa_pa;
+};
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define snp_vmpl 0
-- 
2.51.0.268.g9569e192d0-goog


