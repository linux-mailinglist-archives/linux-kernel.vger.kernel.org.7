Return-Path: <linux-kernel+bounces-789722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 412DCB399A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B287AD92E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA8B30C632;
	Thu, 28 Aug 2025 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbUQos/H"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A130C354
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376566; cv=none; b=YUIH6eOBtNv8r1P3YKEQu1C4OJAeAb0lFTdyIq2sjTpk4ffGT5VoKXwgdFOMGzkrwhgb4I9dYH9jDtooWoYkgsVnbpJkUX8Fbsa8ODzoRACMqrWzN0pPqu7OFW78gQku2KaiW7HXTO0zb0ICM3EdnfH4GHEv2ee+Yt0n8Ou57pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376566; c=relaxed/simple;
	bh=J0HWu+JaKQaX0Z7iCITlcV0GYZYb/YTPivFBQy0/1r4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o00Xj6PIkLz8AIzXT1cu4LtJw+rqV5PcL1jjh+adYcAQ51rBPfsVec44ZacXPCON6Dq3vdmsBW9LOL6D2Ba8T++GHTJhynjl8Dnp9KjeQ421aHkrD4dNNXqK+5kA4ILbS42YHSfiYQJ29sonDCTGIEojudHZdn2i96D9ydm5uMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KbUQos/H; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3c6ae25997cso485794f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376561; x=1756981361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m/CpCaZQ2UKXQXcDVGzYz8uWRfMMQ/9Iyko498fjtpo=;
        b=KbUQos/H9gizWlIc1Y6zRlb4JXck1aAQEViIVls0pwsx8K1NIw09Qhz3y0CDhS3dqO
         NvjE53ts/1bPyfKzhtj3BdEp0egBJMbwVTpnsDFruIcYLK+eIQtrrzmOy1Ug5DqR7w7y
         wZuLbgttQNywx/xeupHU/N/nKPIylWWfWmrqHyBE4Mj7wlPKbIQibbv73D+HI6f/d3x3
         ZXYlcHPuB6BQ8+Z6Q3JVwcK9N+Iq6WG6Nc6iiUzvUF1zIq9tsY3z++Ie6fWfZIL+XPWc
         m7sRfZza7rHf6W7K6FCjE4znQu4g6/Z0/OpkWHs+LJ2QyTYuUZ557h/Sh6xD3bpi5km4
         eOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376561; x=1756981361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/CpCaZQ2UKXQXcDVGzYz8uWRfMMQ/9Iyko498fjtpo=;
        b=uzhVG/2XAgdDXhGaKySONYG41YDaogTKK8QOTOmxNbSja8B/C0Ko8Plfu0bkTY8qjy
         7xQOzQh0BggQ8Q0erGUdQ93UrCI0E+v37d9syVxlhQw+1t2awW1zcrcuST5OPO4TU7Ye
         /UI9mfUbEr7Zwacy6dK1nbYJjJpi68xUJeLFt0sragzT9DoUczzW+RqC0s1oma1BSp9d
         EP94joZpo3ymN6CJxwGL3esu8XMxguKlRDuBB/PLKDnrFjCtqEL77ETgogQVQHDu83S2
         GwiLsSpqMNvPY5OhNMvqHOGi/zEpqwrDWfzRYzt0IRqm9B7zvcSv4CcNl3kUqWQ5hyHM
         uqng==
X-Gm-Message-State: AOJu0Yz8Tbr20M1xqbqT6oigGebFIS3N3Q8N3RicKaIkir+9GEDSQE3r
	bo+npMD63g+AYJCMIFOTkmOPUCirwsPuZpBKwmO/yWMvfHdlITRPUaSf60SHb5EX8wDU72Z50yH
	2rw8c5rdoYl4OZZm85zKzN8y46gKMM4Bbge/iUV+WrJxIAit2B9YXQCUxp7GWvRHFlj1Nm2BVWA
	sryBVrDoB4f77WY3TSrATM4ThJjmIkJlmxsw==
X-Google-Smtp-Source: AGHT+IGvK4nASCJWNa2GfqaIyEMKaZ+zowcii8Jb7tChcUNNBbqX/uDXLGDEtkWZZD2G8DMxuPU77Cnr
X-Received: from wrvb15.prod.google.com ([2002:a5d:550f:0:b0:3cc:7885:d1be])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2906:b0:3c7:f9a9:7b33
 with SMTP id ffacd0b85a97d-3c7f9a97ecbmr12395590f8f.19.1756376561283; Thu, 28
 Aug 2025 03:22:41 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:09 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7523; i=ardb@kernel.org;
 h=from:subject; bh=o12TCmlojnWO0vYwCgxFT2avm5pq2qLd7FFwwFeGT2A=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7iXm+0FvhO4sPFJn8NPrVO723k0vfm1gfrdw3boXX
 5wZFmg/6yhlYRDjYpAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQATyf3K8N+/4vpNr9bIWPXU
 QpbHagWr4t+sTTvlN8expm2f8+wXxq4M/zS3OtyWSdu4/cqZfZ/FuTxFZJ/c0NAReBJb/GTePY7 KcG4A
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-30-ardb+git@google.com>
Subject: [PATCH v7 06/22] x86/sev: Avoid global variable to store virtual
 address of SVSM area
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The boottime SVSM calling area is used both by the startup code running
from a 1:1 mapping, and potentially later on running from the ordinary
kernel mapping.

This SVSM calling area is statically allocated, and so its physical
address doesn't change. However, its virtual address depends on the
calling context (1:1 mapping or kernel virtual mapping), and even though
the variable that holds the virtual address of this calling area gets
updated from 1:1 address to kernel address during the boot, it is hard
to reason about why this is guaranteed to be safe.

So instead, take the RIP-relative address of the boottime SVSM calling
area whenever its virtual address is required, and only use a global
variable for the physical address.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c      | 5 ++---
 arch/x86/boot/startup/sev-shared.c  | 7 +------
 arch/x86/boot/startup/sev-startup.c | 9 +++++----
 arch/x86/coco/sev/core.c            | 9 ---------
 arch/x86/include/asm/sev-internal.h | 3 +--
 arch/x86/include/asm/sev.h          | 2 --
 arch/x86/mm/mem_encrypt_amd.c       | 6 ------
 7 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 3628e9bddc6a..6c0f91d38595 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -37,12 +37,12 @@ struct ghcb *boot_ghcb;
 
 #define __BOOT_COMPRESSED
 
-extern struct svsm_ca *boot_svsm_caa;
 extern u64 boot_svsm_caa_pa;
 
 struct svsm_ca *svsm_get_caa(void)
 {
-	return boot_svsm_caa;
+	/* The decompressor is mapped 1:1 so VA == PA */
+	return (struct svsm_ca *)boot_svsm_caa_pa;
 }
 
 u64 svsm_get_caa_pa(void)
@@ -530,7 +530,6 @@ bool early_is_sevsnp_guest(void)
 
 			/* Obtain the address of the calling area to use */
 			boot_rdmsr(MSR_SVSM_CAA, &m);
-			boot_svsm_caa = (void *)m.q;
 			boot_svsm_caa_pa = m.q;
 
 			/*
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 24cbeaf7ff4f..68044c11524c 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -13,6 +13,7 @@
 
 #ifndef __BOOT_COMPRESSED
 #define error(v)			pr_err(v)
+#define has_cpuflag(f)			boot_cpu_has(f)
 #else
 #undef WARN
 #define WARN(condition, format...) (!!(condition))
@@ -26,7 +27,6 @@
  *   early boot, both with identity mapped virtual addresses and proper kernel
  *   virtual addresses.
  */
-struct svsm_ca *boot_svsm_caa __ro_after_init;
 u64 boot_svsm_caa_pa __ro_after_init;
 
 /*
@@ -718,11 +718,6 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
 	if (caa & (PAGE_SIZE - 1))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
 
-	/*
-	 * The CA is identity mapped when this routine is called, both by the
-	 * decompressor code and the early kernel code.
-	 */
-	boot_svsm_caa = (struct svsm_ca *)caa;
 	boot_svsm_caa_pa = caa;
 
 	/* Advertise the SVSM presence via CPUID. */
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index fd18a00f000e..8a06f6026101 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -252,6 +252,7 @@ static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 
 static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 {
+	struct snp_secrets_page *secrets = (void *)cc_info->secrets_phys;
 	struct svsm_call call = {};
 	u64 pa;
 
@@ -272,21 +273,21 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	pa = (u64)rip_rel_ptr(&boot_svsm_ca_page);
 
 	/*
-	 * Switch over to the boot SVSM CA while the current CA is still
-	 * addressable. There is no GHCB at this point so use the MSR protocol.
+	 * Switch over to the boot SVSM CA while the current CA is still 1:1
+	 * mapped and thus addressable with VA == PA. There is no GHCB at this
+	 * point so use the MSR protocol.
 	 *
 	 * SVSM_CORE_REMAP_CA call:
 	 *   RAX = 0 (Protocol=0, CallID=0)
 	 *   RCX = New CA GPA
 	 */
-	call.caa = svsm_get_caa();
+	call.caa = (struct svsm_ca *)secrets->svsm_caa;
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
 	call.rcx = pa;
 
 	if (svsm_call_msr_protocol(&call))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
 
-	boot_svsm_caa = (struct svsm_ca *)pa;
 	boot_svsm_caa_pa = pa;
 }
 
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 2a28d14425d4..ff1e2be8b5a8 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1666,15 +1666,6 @@ void sev_show_status(void)
 	pr_cont("\n");
 }
 
-void __init snp_update_svsm_ca(void)
-{
-	if (!snp_vmpl)
-		return;
-
-	/* Update the CAA to a proper kernel address */
-	boot_svsm_caa = &boot_svsm_ca_page;
-}
-
 #ifdef CONFIG_SYSFS
 static ssize_t vmpl_show(struct kobject *kobj,
 			 struct kobj_attribute *attr, char *buf)
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index 6199b35a82e4..ffe4755962fe 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -60,7 +60,6 @@ void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 DECLARE_PER_CPU(struct svsm_ca *, svsm_caa);
 DECLARE_PER_CPU(u64, svsm_caa_pa);
 
-extern struct svsm_ca *boot_svsm_caa;
 extern u64 boot_svsm_caa_pa;
 
 static __always_inline struct svsm_ca *svsm_get_caa(void)
@@ -68,7 +67,7 @@ static __always_inline struct svsm_ca *svsm_get_caa(void)
 	if (sev_cfg.use_cas)
 		return this_cpu_read(svsm_caa);
 	else
-		return boot_svsm_caa;
+		return rip_rel_ptr(&boot_svsm_ca_page);
 }
 
 static __always_inline u64 svsm_get_caa_pa(void)
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 096307dc8f39..fd11b266a67a 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -519,7 +519,6 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
-void snp_update_svsm_ca(void);
 int prepare_pte_enc(struct pte_enc_desc *d);
 void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot);
 void snp_kexec_finish(void);
@@ -600,7 +599,6 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
-static inline void snp_update_svsm_ca(void) { }
 static inline int prepare_pte_enc(struct pte_enc_desc *d) { return 0; }
 static inline void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot) { }
 static inline void snp_kexec_finish(void) { }
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index faf3a13fb6ba..2f8c32173972 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -536,12 +536,6 @@ void __init sme_early_init(void)
 		x86_init.resources.dmi_setup = snp_dmi_setup;
 	}
 
-	/*
-	 * Switch the SVSM CA mapping (if active) from identity mapped to
-	 * kernel mapped.
-	 */
-	snp_update_svsm_ca();
-
 	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 }
-- 
2.51.0.268.g9569e192d0-goog


