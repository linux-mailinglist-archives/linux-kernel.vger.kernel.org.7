Return-Path: <linux-kernel+bounces-723043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9803FAFE219
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7D93A7F61
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5848C2797BF;
	Wed,  9 Jul 2025 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="St8BGQUE"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB11B27817A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048685; cv=none; b=DubaZx3/yk8Dif4IMiLW6OnTSryiVqHZRO9d8NO4RDkXvCU4j9iEIyS0iweB/wTTIK4t8nVy6Dqm788u3H9ZWJp1kc1ePVPv2yl/GXfoRP+JuY1Ddkn8Hz9QM67e7Wg+hDm6IcBDmFeUOcN/70X23L6UP41urg6DSRdYMcgAAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048685; c=relaxed/simple;
	bh=VAOnmYQ3SMHzhVxwmk5WbPYCXwepq2DTTWyblYZ56nA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rejRRVObt6MgIfxh1YzXDZ/0x8gotZ4WO+4GKiyplg4eJS0RrtQiADmeHdP9vnLwZBciXwNCMG4bGUB52PX6wStkiiPVEmzomzj0I5Erza9ksodRSz9UW5kwVKZ25rRc7i46dh3jiNieaA3giQl6yLzhge6jjOcwrKXkvwDI1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=St8BGQUE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4532ff43376so42938755e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048682; x=1752653482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mlklEssr6PHY4FCf1/KdHvDxuzxyPCLNFCMLVOpB+/U=;
        b=St8BGQUEEB3YHEwloXvVBgRIDoKienwpp7agk3RHjujqRNVQMH/M3WWwd8CBNvthdK
         YANVR+vSTuUgPcKvTg5uxz9l3YVT8hcheO9te9GD3JLl8ovFLjDej1EnNPR/iq/VdIgr
         kWM01oU0IufYsB+xrSDpzS481G5xCbtpVL/Aqi/spDiZcTSUCg7j1TG+PcLehXhDgOxv
         LaDt1tXy7IxkICadzwESOOjyURGjsnxdBBo3jv+3Dsw7Zd1jOAx8TxSNOS29LkvvURgB
         9Ko69vQFzkhCbsQaYiYo/KiNPyPQSdBzkJXdDrcdEXqnWRWe/bIQfSKAbWxgIkHEsLL+
         WyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048682; x=1752653482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlklEssr6PHY4FCf1/KdHvDxuzxyPCLNFCMLVOpB+/U=;
        b=eNE44fpGsxSNS3EJicYqR8bSx4L6YriRcePy5m2/rHnkLpmGlFoFf28bDoIPEcJrWZ
         hgwWhLi9dXRL8Iee4UL6l6oQBJ+yFskBbCyFob7yXnrAQS8RoGG0VL+yD9wHTQxBv0O7
         UEDjnT2rajq6JbBXGhEmN7LMj1R+umOi+Y/wKTU5d7EnrPzPKU1AGueyW3nzDIWxwYMM
         1KC3Jb6ZLJT2BLT465oneEvi4jwflwhM77iPGkzeqjNwunBv1GMuhl65CHKnoKl/R3kA
         i38J/87Nrb5nfBcZ7iKUZGJz3nNTrhVnsi70UjRL8TWUrMO2shI2ZcgIlT2IYfx51hb7
         jF1w==
X-Gm-Message-State: AOJu0Yy92JKoH06ZdeRybo54KE7X/66xkLyKF0ZS30hom/qfdO1t2C8o
	ljsgz8oHzDy0nVCSgaK5Hr9ru2S8kZV9xPnsXEDK2ZeuX3l8tdQe+9XQslGaGbvsr52n/ZOk1VH
	EzPJ0Zw1mg3ZRrO5MDSxhp9McTPYw77ITqsJyVUx/el5ZQP5mlmHgfj5mYGtpnsVJpe6SCb3B56
	/9JncOMtszdeW1KSYUr3UshEYvl3JutfbHvg==
X-Google-Smtp-Source: AGHT+IEQzVn/RrbZ5/xlZ32eVwUyzq1Nwx7Y3Fd7L2k7qxKx8b1dfb2qwWjr+wIc3+aHUtdnQ39jTjMV
X-Received: from wmbdv17.prod.google.com ([2002:a05:600c:6211:b0:451:edc8:7816])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5c01:0:b0:3a4:db49:94aa
 with SMTP id ffacd0b85a97d-3b5e4513287mr875885f8f.21.1752048682243; Wed, 09
 Jul 2025 01:11:22 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:51 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5481; i=ardb@kernel.org;
 h=from:subject; bh=sqtiD2Pgws6Z85gNpALOI39gz8WJANhOWEDVEVl7+KQ=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNPed+G8u72JbMjBaYkqR/2cmLhtdnAJ17mWfDknZrd6
 0V63w52lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImsymZk+Ds1ahuLyJwZSjV6
 ovcaXUI3nApInVf3+1nmdQ9N+Y/axYwME/tq+bbnrHzgfZbp9cYyialfw+LfnX+2IZiZp/Ofz8p qLgA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-36-ardb+git@google.com>
Subject: [PATCH v4 10/24] x86/sev: Use boot SVSM CA for all startup and init code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

To avoid having to reason about whether or not to use the per-CPU SVSM
calling area when running startup and init code on the boot CPU, reuse
the boot SVSM calling area as the per-CPU area for CPU #0.

This removes the need to make the per-CPU variables and associated state
in sev_cfg accessible to the startup code once confined.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      | 13 ------
 arch/x86/boot/startup/sev-startup.c |  7 +--
 arch/x86/coco/sev/core.c            | 47 +++++++++-----------
 arch/x86/include/asm/sev-internal.h | 16 -------
 4 files changed, 24 insertions(+), 59 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index bc23b3dabf1b..e67413bc78fd 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -37,19 +37,6 @@ struct ghcb *boot_ghcb;
 
 #define __BOOT_COMPRESSED
 
-extern u64 boot_svsm_caa_pa;
-
-struct svsm_ca *svsm_get_caa(void)
-{
-	/* The decompressor is mapped 1:1 so VA == PA */
-	return (struct svsm_ca *)boot_svsm_caa_pa;
-}
-
-u64 svsm_get_caa_pa(void)
-{
-	return boot_svsm_caa_pa;
-}
-
 u8 snp_vmpl;
 
 /* Include code for early handlers */
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index e253783f6aa5..cba4fb4cace0 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -50,9 +50,6 @@ u64 sev_secrets_pa __ro_after_init;
 /* For early boot SVSM communication */
 struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
 
-DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
-DEFINE_PER_CPU(u64, svsm_caa_pa);
-
 /*
  * Nothing shall interrupt this code path while holding the per-CPU
  * GHCB. The backup GHCB is only for NMIs interrupting this path.
@@ -167,7 +164,7 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	  * table.
 	  */
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE,
-			      svsm_get_caa(), svsm_get_caa_pa());
+			      rip_rel_ptr(&boot_svsm_ca_page), boot_svsm_caa_pa);
 }
 
 void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
@@ -184,7 +181,7 @@ void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED,
-			      svsm_get_caa(), svsm_get_caa_pa());
+			      rip_rel_ptr(&boot_svsm_ca_page), boot_svsm_caa_pa);
 }
 
 /*
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 7a86a2fe494d..4fe0928bc0ad 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -46,6 +46,25 @@
 #include <asm/cmdline.h>
 #include <asm/msr.h>
 
+DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
+DEFINE_PER_CPU(u64, svsm_caa_pa);
+
+static inline struct svsm_ca *svsm_get_caa(void)
+{
+	if (sev_cfg.use_cas)
+		return this_cpu_read(svsm_caa);
+	else
+		return rip_rel_ptr(&boot_svsm_ca_page);
+}
+
+static inline u64 svsm_get_caa_pa(void)
+{
+	if (sev_cfg.use_cas)
+		return this_cpu_read(svsm_caa_pa);
+	else
+		return boot_svsm_caa_pa;
+}
+
 /* AP INIT values as documented in the APM2  section "Processor Initialization State" */
 #define AP_INIT_CS_LIMIT		0xffff
 #define AP_INIT_DS_LIMIT		0xffff
@@ -1287,7 +1306,8 @@ static void __init alloc_runtime_data(int cpu)
 		struct svsm_ca *caa;
 
 		/* Allocate the SVSM CA page if an SVSM is present */
-		caa = memblock_alloc_or_panic(sizeof(*caa), PAGE_SIZE);
+		caa = cpu ? memblock_alloc_or_panic(sizeof(*caa), PAGE_SIZE)
+			  : &boot_svsm_ca_page;
 
 		per_cpu(svsm_caa, cpu) = caa;
 		per_cpu(svsm_caa_pa, cpu) = __pa(caa);
@@ -1341,32 +1361,9 @@ void __init sev_es_init_vc_handling(void)
 		init_ghcb(cpu);
 	}
 
-	/* If running under an SVSM, switch to the per-cpu CA */
-	if (snp_vmpl) {
-		struct svsm_call call = {};
-		unsigned long flags;
-		int ret;
-
-		local_irq_save(flags);
-
-		/*
-		 * SVSM_CORE_REMAP_CA call:
-		 *   RAX = 0 (Protocol=0, CallID=0)
-		 *   RCX = New CA GPA
-		 */
-		call.caa = svsm_get_caa();
-		call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
-		call.rcx = this_cpu_read(svsm_caa_pa);
-		ret = svsm_perform_call_protocol(&call);
-		if (ret)
-			panic("Can't remap the SVSM CA, ret=%d, rax_out=0x%llx\n",
-			      ret, call.rax_out);
-
+	if (snp_vmpl)
 		sev_cfg.use_cas = true;
 
-		local_irq_restore(flags);
-	}
-
 	sev_es_setup_play_dead();
 
 	/* Secondary CPUs use the runtime #VC handler */
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index 3b72d8217827..bdfe008120f3 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -63,22 +63,6 @@ DECLARE_PER_CPU(u64, svsm_caa_pa);
 
 extern u64 boot_svsm_caa_pa;
 
-static __always_inline struct svsm_ca *svsm_get_caa(void)
-{
-	if (sev_cfg.use_cas)
-		return this_cpu_read(svsm_caa);
-	else
-		return rip_rel_ptr(&boot_svsm_ca_page);
-}
-
-static __always_inline u64 svsm_get_caa_pa(void)
-{
-	if (sev_cfg.use_cas)
-		return this_cpu_read(svsm_caa_pa);
-	else
-		return boot_svsm_caa_pa;
-}
-
 enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *ctxt);
 void vc_forward_exception(struct es_em_ctxt *ctxt);
 
-- 
2.50.0.727.gbf7dc18ff4-goog


