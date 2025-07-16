Return-Path: <linux-kernel+bounces-733196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 441B1B07169
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834A01AA1E26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2669328A1C8;
	Wed, 16 Jul 2025 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQnI1kBn"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F81230997
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657416; cv=none; b=j4fa8bSId2V2bfBDmeCTR1Z3h9ND9TmIHHrTSl85wsCsIGit4ebRSoRzpMpUjBgYQFjVewXV4ReRftSpaAEVtx8XvF9IV85OhblDheM1i7M+0nS4lKkDfbVJnA2BlPCX2C7gpek/zq5UCbuGwFv+Mxt07jUMqJ29qmrKFmRnPWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657416; c=relaxed/simple;
	bh=x+ThiAf2IfpTUIJqeyKJ44bSEUgDEng6wJcVgmUVm1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S+W1i5kdNv6wb2mbyAVQ8tdGDRYcio4CgkjIsHMIpgKjwTaIEUJf9cOhndbLRa5S417+U4T8v/DdzjXwLD6PR2QcwRM2lNELtKJfzwltjua7bt5Bl/gxvBBUjc+PWLdbZRcaFG89r5ExwJElafHbQULkCAthrWOQRGXqbVKVUMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQnI1kBn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae9be1697easo131281966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752657413; x=1753262213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hv6Hl+2YyPTqtc8nGbHZ9ko3Hunk3VMkk1zOQdOepio=;
        b=JQnI1kBnLC8zGpM4fDySoE6O0smUyfNETw663MbJZ4Zt/du+3OCHavLBgbvpTsRfKG
         PipxI6sopFcatBBabXuQtsYOb4XQA4Pk3DYlRDh7tWNYRHgJojSeQC+GxQLDaBshj2Rh
         /yQgoMg0rx1rMt6Q3Wf6RMd3YebGYiRrK7XubLhLO8NEEBbX1+DS5JxOCsyjf8NbvwwZ
         snIRg07G695BGT0FxQsIDyxanIhYFSacdsMoxokTpV/GUCMg5u2+rBzO7vj1SJfjBHXK
         4L1BhMZGU0+MisnfylM38pgcWCn+siUP4I1ej/rhTqb5DaKQTphtXp4E9XycTZs/iNvP
         MTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752657413; x=1753262213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hv6Hl+2YyPTqtc8nGbHZ9ko3Hunk3VMkk1zOQdOepio=;
        b=k7Sr5bBhoX1QfagDaUqPVnUmQ7/Kts3A0eNt/1U7egLHKL0U2hk/nA4NF5i6QKK/WM
         z/JsFOeF7bhloMtGiE3Ndu0LLYZGiVZYdBueg7xmP5tN1SAPLm08V9/kSEasWJWG9Yaa
         n40jYDwNkKXnXNHi0uSwcVipiZdtrPELrf/Qh+NWBcJmyjvLRGtA4e8z/k0kmpwt1J1K
         Mm4N6A4npPQ9SusOJv3p0v4HWKquVLrKBYeRHeqYjwbyhbA0gYBjNHuMte0azIOPwVF0
         A3wNYWUhSdMwOMiWpXoRMd+AtiXtlTncPlca7cb8cLuoogUEzGh9cNgJNTWx8VLXPOqE
         PESw==
X-Forwarded-Encrypted: i=1; AJvYcCX2P/iayqWaYEYTZ4BuIsOURgPRaSGI3fKiQ8GDnkprDcO46cg0W+aXDlURUODfYuyiTQw4RGmnfk5jS5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUN5JznpA9zx4+Rv+ltBHNCVh7+MJuvO/duO98gy9RF4OnqdAz
	DuLn3E/CXQLMmBgACADgrwykExlvscVwn+crCkDnX+Gbq8eZj1nv0n11
X-Gm-Gg: ASbGncvH/8dvPjgCG5SmpDF2ATcb+bLxFsm4Qa9O9JB6lLa27BolNYicSiAtfeNEyY+
	wXE+N2FMgEmgdEB9NloqG4MQOPyykQ/Hj/gGM/oKRO66bGWnpFDIn40krvSYj0JGHNpWZjwdkPY
	udYOeyJRFJ+KFBwPoX4f46VAtDQ/lSBNKvXXncJq6itjcs4F+5D2g0M5r9I7awIDGrR3i1Th7hm
	ZRnCaZOevh6Vs8o6JTS8cCsLaC1paIA6/cSePmnH7Gi7sXo7ujKzEdjukbkzPHcZJcS04HWdTGL
	HOr8qaBEIy1XwlJwXA6D+q0sZbFmqf4EXpe+6G3/3xB/DUTBhNdnDPBpMdzDdWT7DPhlPxiG/sk
	0StkmCoc4y9/fHMKl7ll94MZQ8FiU3qBR1c8hmA==
X-Google-Smtp-Source: AGHT+IEppGO69kxYrvFU5r2wACB/kXIKp4N/uEY2pkQF7RTfdUcKYPxBeIMgNGHrsc4gW1mBZ2l5SA==
X-Received: by 2002:a17:906:fe08:b0:ae0:c1c4:645 with SMTP id a640c23a62f3a-ae9b5d7f353mr570037166b.21.1752657412664;
        Wed, 16 Jul 2025 02:16:52 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82dee16sm1156966066b.152.2025.07.16.02.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:16:52 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Khalid Ali <khaliidcaly@gmail.com>,
	Kai Huang <kai.huang@intel.com>
Subject: [PATCH v8] x86/boot: Don't return encryption mask from __startup_64()
Date: Wed, 16 Jul 2025 09:11:34 +0000
Message-ID: <20250716091332.737-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khalid Ali <khaliidcaly@gmail.com>

Avoid returning encryption mask to callers of __startup_64().

The encryption mask is available to callers and canbe accessed
sme_get_me_mask() in C code and sme_me_mask symbol in assembly code.

This change aligns the way the mask is retrieved in
secondary_startup_64_no_verify().

No functionality change intended, only consistency improvement, so the
code becomes cleaner.

On intel processors sme_me_mask is zero. So, it is safe to add mask only
if CONFIG_AMD_MEM_ENCRYPT.

Signed-off-by: Khalid Ali <khaliidcaly@gmail.com>
Acked-by: Kai Huang <kai.huang@intel.com>
---

Changes in v8:
  * Improve commit message for clarity.

Changes in v7:
  * Improve commit message for better clarity.
  * Add Huang, Kai Ack tag.
  * Fix parameter aligment.
  * Fix patch style issues.

 arch/x86/boot/startup/map_kernel.c | 17 ++++++-----------
 arch/x86/include/asm/setup.h       |  2 +-
 arch/x86/kernel/head_64.S          | 14 ++++++++------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/startup/map_kernel.c b/arch/x86/boot/startup/map_kernel.c
index 332dbe6688c4..d25e849af563 100644
--- a/arch/x86/boot/startup/map_kernel.c
+++ b/arch/x86/boot/startup/map_kernel.c
@@ -30,9 +30,9 @@ static inline bool check_la57_support(void)
 	return true;
 }
 
-static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
-						    pmdval_t *pmd,
-						    unsigned long p2v_offset)
+static void __head sme_postprocess_startup(struct boot_params *bp,
+					   pmdval_t *pmd,
+					   unsigned long p2v_offset)
 {
 	unsigned long paddr, paddr_end;
 	int i;
@@ -68,11 +68,6 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
 		}
 	}
 
-	/*
-	 * Return the SME encryption mask (if SME is active) to be used as a
-	 * modifier for the initial pgdir entry programmed into CR3.
-	 */
-	return sme_get_me_mask();
 }
 
 /*
@@ -84,8 +79,8 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
  * the 1:1 mapping of memory. Kernel virtual addresses can be determined by
  * subtracting p2v_offset from the RIP-relative address.
  */
-unsigned long __head __startup_64(unsigned long p2v_offset,
-				  struct boot_params *bp)
+void __head __startup_64(unsigned long p2v_offset,
+			 struct boot_params *bp)
 {
 	pmd_t (*early_pgts)[PTRS_PER_PMD] = rip_rel_ptr(early_dynamic_pgts);
 	unsigned long physaddr = (unsigned long)rip_rel_ptr(_text);
@@ -213,5 +208,5 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	for (; i < PTRS_PER_PMD; i++)
 		pmd[i] &= ~_PAGE_PRESENT;
 
-	return sme_postprocess_startup(bp, pmd, p2v_offset);
+	sme_postprocess_startup(bp, pmd, p2v_offset);
 }
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 692af46603a1..c09a4bf18706 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -50,7 +50,7 @@ extern unsigned long acpi_realmode_flags;
 
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
-extern unsigned long __startup_64(unsigned long p2v_offset, struct boot_params *bp);
+extern void  __startup_64(unsigned long p2v_offset, struct boot_params *bp);
 extern void startup_64_setup_gdt_idt(void);
 extern void startup_64_load_idt(void *vc_handler);
 extern void early_setup_idt(void);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3e9b3a3bd039..0cba493cab26 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -106,18 +106,20 @@ SYM_CODE_START_NOALIGN(startup_64)
 
 	/*
 	 * Perform pagetable fixups. Additionally, if SME is active, encrypt
-	 * the kernel and retrieve the modifier (SME encryption mask if SME
-	 * is active) to be added to the initial pgdir entry that will be
-	 * programmed into CR3.
-	 */
+	 * the kernel.
+	*/
 	movq	%r15, %rsi
 	call	__startup_64
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	leaq	early_top_pgt(%rip), %rcx
-	addq	%rcx, %rax
+	leaq	early_top_pgt(%rip), %rax
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
+	/* Retrieve the modifier (SME encryption mask if SME
+	 * is active) to be added to the initial pgdir entry that will be
+	 * programmed into CR3.
+	 */
+	addq	sme_me_mask(%rip), %rax
 	mov	%rax, %rdi
 
 	/*
-- 
2.49.0


