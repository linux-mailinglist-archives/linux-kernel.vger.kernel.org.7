Return-Path: <linux-kernel+bounces-607693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A64EA9097C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 18:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CC81891EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C68521767A;
	Wed, 16 Apr 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AfEvETeU"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE422215F6C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822689; cv=none; b=qYhjLyYOsznqsE8rtvdferO2v86LiSs8UtU6OM61o+cjtgb6RkXi/baqLYdCFRtTPydk19t6OvgHCpkTogLY2k2jrNUrFNM6n9A6mrBjeyxsERnllri9GSkg0gXVS8E9l7BAEejNrldfSEa7X9rKiqBMZO3/yaWa4o4ZVlwGixI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822689; c=relaxed/simple;
	bh=PgEJaJgE0LXiQJDQNeoBnr/Xemmrs41II8OE/SAPKgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j0Att3m0BrIMXRDuyzWJc59z/ZLvKqpvY9qqkAfdXLu6N4ckFLoC7yg4fcR10nZBxb+LoV+7+dwEe88iFvPMnzaPLmJ4LZE6shPGcK95x/F7K57C9LWOTri8OuNUWxrYkvT0cwCWdqiSqALKfFV3chqdPLhSoxV5F4bg4bpxjns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AfEvETeU; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so53372825e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744822686; x=1745427486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+AXQAr6DEdb53aAovtH1m4o5iLjqGheV49k9eDzwzjU=;
        b=AfEvETeUuP+uvuWet7jyjKtftUuQ5Oe1E5JYDytxCC2eMArX2OWgCrhcZqPH2+R2CP
         rH04rRmankp0H6lQx0AzMbDWi9wgugbO75F67Z9xOLqVzTGXdDyiWn70fQF3yeaVluOZ
         ox56j/s8HLd+wMD9QinApsZakoOToMxjAa7js2TciLfW0xdvJj/TsFurgiaTVO+DUBVA
         EeE6F8Zxqt9wQIylQ5h4/Vh/w/kjZIcaceMqV60a1ZQVO/xW7jG/OMBeRcT0UvldD8W5
         9OFLfdPrgZXidRQZG4UrFY80HKPGmdF82iZgm5zkJDZg0+Gq6YmQHruIiVc8cHzUHuTb
         hJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744822686; x=1745427486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AXQAr6DEdb53aAovtH1m4o5iLjqGheV49k9eDzwzjU=;
        b=SUBGOGphc54cJ+0f9Y8+sH3Im9iqhvVI4PJubhtNRc23FXJAUZnGH4J1zNPZpA7YLM
         ZDAB0NILW74ryDpXscDJOB9AzIzCMdPiAfG/63RKF5pFvvJ1tKwPJ52slm/vh+B/68tc
         P/IoNHPZASdhL2GHnt4X1fVEkIsbaOtQxItoHOgujqsNGx3KEBS6mNdgV9srO6Axyjey
         K0jbB1XYw3E1DgqnELx2AuaP82LxlXS+2dJTb80Ndo2m409mEIYnVbkzpRIdpjKHqfkt
         BgAi286kGKiOobGjQQGXWt3CRuuiYUfxuw6g9KQCSLHLUkyBttCyuiLh6J8yspwdPLLk
         Vplw==
X-Forwarded-Encrypted: i=1; AJvYcCWsWUXIv1EYU6byZFwXCQs1QLnv9663W6YHk6Ojb1pOPq2tRfDSolpYVlJ6iexju8NcyzY1Du5wlOcOaJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXWyS4dcdtzTe7TsUk48ILspPB+rBA8OyiC2KVUCinMkN5DKz6
	ZkPXeafpjDemuhC9kBxTG0PmOvL4wH+suP7PWslaOnWGtlwZc5S5dGIFnfgYF6I3krY2MA==
X-Google-Smtp-Source: AGHT+IHTV/3RUCyKhwGqdBj/wC/EfEt6jOyqE3Rh/VKi0y7pMFXpDis+ib55sXylrUCf9El9T3zmxV+y
X-Received: from wmbh25.prod.google.com ([2002:a05:600c:a119:b0:43d:586a:9bcb])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5020:b0:43d:83a:417d
 with SMTP id 5b1f17b1804b1-4405d625d68mr28618735e9.12.1744822686421; Wed, 16
 Apr 2025 09:58:06 -0700 (PDT)
Date: Wed, 16 Apr 2025 18:57:47 +0200
In-Reply-To: <20250416165743.4080995-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416165743.4080995-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6446; i=ardb@kernel.org;
 h=from:subject; bh=aJ31HuwoQHpuIXtoeQRHoQQiwMzqJa0G33NiTtuOfdc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3/w57UIk4xtjCBaC7XkvoO3VPzv06dEFqe+EK8wW975
 lW52R4dpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJckQz/c+s/6/e6357yw/+t
 +8V/NWd90ttm1zt7Xrnz37TUJHjpJkaGYxPMcrQ4f6vO3dwW+1Xh+uPSL3G8SotNv1vwTd+lnr6 MEQA=
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250416165743.4080995-9-ardb+git@google.com>
Subject: [PATCH v2 3/4] x86/sev: Unify SEV-SNP hypervisor feature check
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The decompressor and the core kernel both check the hypervisor feature
mask exposed by the hypervisor, but test it in slightly different ways.

This disparity seems unintentional, and simply a result of the fact that
the decompressor and the core kernel evolve differently over time when
it comes to setting up the SEV-SNP execution context.

So move the HV feature check into a helper function and call that
instead. For the core kernel, move the check to an earlier boot stage,
right after the point where it is established that the guest is
executing in SEV-SNP mode.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      | 19 +----------
 arch/x86/boot/startup/sme.c         |  2 ++
 arch/x86/coco/sev/core.c            | 11 -------
 arch/x86/coco/sev/shared.c          | 33 +++++++++++++++-----
 arch/x86/include/asm/sev-internal.h |  3 +-
 arch/x86/include/asm/sev.h          |  2 ++
 6 files changed, 32 insertions(+), 38 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 26ba997c45fa..aeee011a6486 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -611,24 +611,7 @@ void sev_enable(struct boot_params *bp)
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
 	}
 
-	/*
-	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
-	 * features.
-	 */
-	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
-		u64 hv_features;
-
-		hv_features = get_hv_features();
-		if (!(hv_features & GHCB_HV_FT_SNP))
-			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
-
-		/*
-		 * Running at VMPL0 is required unless an SVSM is present and
-		 * the hypervisor supports the required SVSM GHCB events.
-		 */
-		if (snp_vmpl > 0 && !(hv_features & GHCB_HV_FT_SNP_MULTI_VMPL))
-			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
-	}
+	snp_check_hv_features();
 
 	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 5738b31c8e60..11caa343790d 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -533,6 +533,8 @@ void __head sme_enable(struct boot_params *bp)
 	if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
 		snp_abort();
 
+	sev_hv_features = snp_check_hv_features();
+
 	/* Check if memory encryption is enabled */
 	if (feature_mask == AMD_SME_BIT) {
 		if (!(bp->hdr.xloadflags & XLF_MEM_ENCRYPTION))
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index aeb7731862c0..4618ab64c767 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1582,17 +1582,6 @@ void __init sev_es_init_vc_handling(void)
 	if (!sev_es_check_cpu_features())
 		panic("SEV-ES CPU Features missing");
 
-	/*
-	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
-	 * features.
-	 */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
-		sev_hv_features = get_hv_features();
-
-		if (!(sev_hv_features & GHCB_HV_FT_SNP))
-			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
-	}
-
 	/* Initialize per-cpu GHCB pages */
 	for_each_possible_cpu(cpu) {
 		alloc_runtime_data(cpu);
diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index a7c94020e384..514e2d42700b 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -99,16 +99,10 @@ sev_es_terminate(unsigned int set, unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
-/*
- * The hypervisor features are available from GHCB version 2 onward.
- */
-u64 get_hv_features(void)
+static u64 __head get_hv_features(void)
 {
 	u64 val;
 
-	if (ghcb_version < 2)
-		return 0;
-
 	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
 	VMGEXIT();
 
@@ -119,6 +113,31 @@ u64 get_hv_features(void)
 	return GHCB_MSR_HV_FT_RESP_VAL(val);
 }
 
+u64 __head snp_check_hv_features(void)
+{
+	/*
+	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
+	 * features.
+	 */
+	if (RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED) {
+		u64 hv_features;
+
+		hv_features = get_hv_features();
+		if (!(hv_features & GHCB_HV_FT_SNP))
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+		/*
+		 * Running at VMPL0 is required unless an SVSM is present and
+		 * the hypervisor supports the required SVSM GHCB events.
+		 */
+		if (snp_vmpl > 0 && !(hv_features & GHCB_HV_FT_SNP_MULTI_VMPL))
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
+
+		return hv_features;
+	}
+	return 0;
+}
+
 void snp_register_ghcb_early(unsigned long paddr)
 {
 	unsigned long pfn = paddr >> PAGE_SHIFT;
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index 73cb774c3639..81abef86b1d0 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -4,7 +4,6 @@
 
 extern struct ghcb boot_ghcb_page;
 extern struct ghcb *boot_ghcb;
-extern u64 sev_hv_features;
 
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
@@ -117,6 +116,6 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 void snp_register_ghcb_early(unsigned long paddr);
 bool sev_es_negotiate_protocol(void);
 bool sev_es_check_cpu_features(void);
-u64 get_hv_features(void);
+void check_hv_features(void);
 
 const struct snp_cpuid_table *snp_cpuid_get_table(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index a8661dfc9a9a..8637a65973ef 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -418,6 +418,7 @@ struct svsm_call {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u8 snp_vmpl;
+extern u64 sev_hv_features;
 
 extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
@@ -494,6 +495,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __noreturn snp_abort(void);
+u64 snp_check_hv_features(void);
 void snp_dmi_setup(void);
 int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attest_call *input);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
-- 
2.49.0.805.g082f7c87e0-goog


