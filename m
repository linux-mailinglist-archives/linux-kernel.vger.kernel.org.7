Return-Path: <linux-kernel+bounces-846157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA85BC728F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B83D634E6C1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB3721772A;
	Thu,  9 Oct 2025 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U52OwROE"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8719F12D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975150; cv=none; b=O4k6s2xegifUJzx3BKC9urwgcSEvWTtadxTaBOyZwdjEQwKROOcepdpBE0DMt9vz9t95niYSouMf5YOZ3X3cb25KGj9sM24g+8S4G2CzNptxrc2mpe12wYDyS/Medbqi84MaISAyKzflAKKXm04xJtlk0MrGLGVRMhB/WK78H/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975150; c=relaxed/simple;
	bh=vJ61a417QPWxjgaA8+Jtn/PvO+bIrzLbpFkpFGzeF7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwfuKFfjdZVXfQAzmBRVx7cTIaUusIahx5VV5RyccZ7iwol0ihzanjIOzn/pvAGes8mTByf8MR786amTeOcqVJJZSPLQonHDfZvOTL5+B3MWH54sdQ6m07WoVMGFPs9bLvABqH4ezft0ui0ybFPiKdEEJsRLhxGJPQvXakvYKrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=U52OwROE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27edcbbe7bfso5771885ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975141; x=1760579941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9q1+NRseWKfUTLpTRf8HDVLHy+6zl45nVa2e8q797C8=;
        b=U52OwROEwicNNSaAdi1Qkc5NSX0oXVDQ9kgnFTAfBX2Vq6Nk2bidxsk2+5gUxbf6Ux
         B2nt7v/SxkEi5fQWbl6jSLZpJh7HcHASEkVODHPoCqvW9uU32AD1PP+GbjS7SWbkNy9p
         v1Nn7/IAK6Z8Svu1edUTbcf9lH/7PZST6X8XEr82xN6+KHkxLDuPDbsbAft8LDLKXnhb
         ilzJI4a1Rh8iOhS7yJXJU7TKDr/U2ftxiqFCAtsTQZx+EeH/3KhRIII0LtdB/CggFEpN
         F4occI2Yc8AONwCOunIUasitSqnPj/0vX2Z8wX6wrcukCBd5WndVr6fd6An/dd9PU5HI
         1SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975141; x=1760579941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9q1+NRseWKfUTLpTRf8HDVLHy+6zl45nVa2e8q797C8=;
        b=lLZcFPXL62cAaPKJb+sD4XjuxsCaa/2N+s3L5TK/iy03hYZ6/X2SYrqIWYUjy1RAN7
         IJ7DcEfBZwXnO67z0h3VyEI8NbONj5smIQVzUTGBJHEOwyOmn7/v4vCKETpkhCptzUVO
         98dhwjpKohKAYB2VP0jyMi0Px30nOpaFDAWShdspbG7Bqua+hMg5TsPdm/aI2uKtJiso
         oCT4l/6w20W3FDiHhDzs2hyOmGFpdqs4surT/2FCb3b/V03RCxqwB+Dt+Gv5plYa7smb
         dS7gAblOd0/OaHAbmKoNCvwAoNJwfjfRmdm4zExEX7mw3aGjthnK4SyZb4hpsNKTPx3q
         xyPg==
X-Forwarded-Encrypted: i=1; AJvYcCURKYInbdHmRKTCIBsWj1I2fyv4prgY0j8IRuWHVg7l2ACfdQboU0Km+krU5GpKer+5jAX2EDRgsNdaZhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYRuj/jYzpE51BdzIIjVpRWtqdWXGXNOXs3nD2CpWsVRTT1UuS
	ie7W0nMySUwCNE1oKLMGHyGM18U8qG7IcwEFYLrzhhUYZQTxBjV6ESXWC+blRbhNuf4=
X-Gm-Gg: ASbGncuoPQXzyOhS3/aRp5yhqt5VW0apJYG9J6ml1NlBnwsrX9UqeBsNhNO4IBwsVP7
	fva+6ssVc5E9ouJzEAOmZsfTocZ6Jibif7wR9QbTps3hruwm1OJY+YMdXkCZYBL6UF9cNTMBTmc
	7R/chq8Rnk/pN2INK2iQcPu0pb/9ozHmYToCNIjKQgOJyUCBSlm46YsUxyqR4+Dqt5J8HYVi9Q1
	hZ/aR5kdWsNWboe1QKqBEHzVylHoMoxNN1zDVfDW97QuAo01LPHpjo8Sr9l1zBSztjGSTGurx4A
	8jWG0Oe1PM0w0zQwABb1s7saDJkPF5W0bZ1TM/WoML+pqdd3PQN7/pjK/Ntb1HwAoG+Q8TLXErm
	3h82ZuWLWYthxqmh1mkhQlKNiaI96oZ94mdojDtGGmQFrPjCUBHSTJY1cJJ58Vh+2N95i
X-Google-Smtp-Source: AGHT+IGHPU9/iVX5Ud8D5Es3cH4G+7xlgwuzFWFaCEYVHmYTlH0i4nMQlJ1VHDlSvFYfFYRC22It8g==
X-Received: by 2002:a17:903:1a90:b0:269:d978:7ec0 with SMTP id d9443c01a7336-290272c19bdmr71839945ad.28.1759975140781;
        Wed, 08 Oct 2025 18:59:00 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:59:00 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Conor Dooley <conor@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 16/18] riscv: mm: Use physical memory aliases to apply PMAs
Date: Wed,  8 Oct 2025 18:57:52 -0700
Message-ID: <20251009015839.3460231-17-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251009015839.3460231-1-samuel.holland@sifive.com>
References: <20251009015839.3460231-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some RISC-V platforms, RAM is mapped simultaneously to multiple
physical address ranges, with each alias having a different set of
statically-determined Physical Memory Attributes (PMAs). Software alters
the PMAs for a particular page at runtime by selecting a PFN from among
the aliases of that page's physical address.

Implement this by transforming the PFN when writing page tables. If the
memory type field is nonzero, replace the PFN with the corresponding PFN
from the noncached alias. Similarly, when reading from the page tables,
if the PFN is found in a noncached alias, replace it with the PFN from
the normal memory alias, and insert _PAGE_NOCACHE.

The rest of the kernel sees only PFNs from normal memory and
_PAGE_MTMASK values as if Svpbmt was implemented.

Memory alias pairs are determined from the devicetree. A Linux custom
ISA extension is added to trigger the alternative patching, as
alternatives must be linked to an extension or a vendor erratum, and
this behavior is not associated with any particular processor vendor.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Put new code behind a new Kconfig option RISCV_ISA_XLINUXMEMALIAS
 - Document the calling convention of riscv_fixup/unfix_memory_alias()
 - Do not transform !pte_present() (e.g. swap) PTEs
 - Export riscv_fixup/unfix_memory_alias() to fix module compilation

 arch/riscv/Kconfig                    |  16 ++++
 arch/riscv/include/asm/hwcap.h        |   1 +
 arch/riscv/include/asm/pgtable-64.h   |  44 +++++++--
 arch/riscv/include/asm/pgtable-bits.h |   5 +-
 arch/riscv/include/asm/pgtable.h      |   8 ++
 arch/riscv/kernel/cpufeature.c        |   6 ++
 arch/riscv/kernel/setup.c             |   1 +
 arch/riscv/mm/Makefile                |   1 +
 arch/riscv/mm/memory-alias.S          | 123 ++++++++++++++++++++++++++
 arch/riscv/mm/pgtable.c               |  91 +++++++++++++++++++
 arch/riscv/mm/ptdump.c                |   6 +-
 11 files changed, 290 insertions(+), 12 deletions(-)
 create mode 100644 arch/riscv/mm/memory-alias.S

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 51dcd8eaa2435..72c60fa94c0d7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -890,6 +890,22 @@ config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 	  versions of clang and GCC to be passed to GAS, which has the same result
 	  as passing zicsr and zifencei to -march.
 
+config RISCV_ISA_XLINUXMEMALIAS
+	bool "Use physical memory aliases to emulate page-based memory types"
+	depends on 64BIT && MMU
+	depends on RISCV_ALTERNATIVE
+	default y
+	help
+	  Add support for the kernel to alter the Physical Memory Attributes
+	  (PMAs) of a page at runtime by selecting from among the aliases of
+	  that page in the physical address space.
+
+	  On systems where physical memory aliases are present, this option
+	  is required in order to mark pages as non-cacheable for use with
+	  non-coherent DMA devices.
+
+	  If you don't know what to do here, say Y.
+
 config FPU
 	bool "FPU support"
 	default y
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index affd63e11b0a3..6c6349fe15a77 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -107,6 +107,7 @@
 #define RISCV_ISA_EXT_ZALRSC		98
 #define RISCV_ISA_EXT_ZICBOP		99
 
+#define RISCV_ISA_EXT_XLINUXMEMALIAS	126
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
 #define RISCV_ISA_EXT_MAX		128
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 60c2615e46724..34b6f4ef3aad8 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -95,7 +95,8 @@ enum napot_cont_order {
 #define HUGE_MAX_HSTATE		2
 #endif
 
-#if defined(CONFIG_RISCV_ISA_SVPBMT) || defined(CONFIG_ERRATA_THEAD_MAE)
+#if defined(CONFIG_RISCV_ISA_SVPBMT) || defined(CONFIG_RISCV_ISA_XLINUXMEMALIAS) || \
+	defined(CONFIG_ERRATA_THEAD_MAE)
 
 /*
  * ALT_FIXUP_MT
@@ -105,6 +106,9 @@ enum napot_cont_order {
  *
  * On systems that support Svpbmt, the memory type bits are left alone.
  *
+ * On systems that support XLinuxMemalias, PTEs with a nonzero memory type have
+ * the memory type bits cleared and the PFN replaced with the matching alias.
+ *
  * On systems that support XTheadMae, a Svpbmt memory type is transformed
  * into the corresponding XTheadMae memory type.
  *
@@ -127,22 +131,35 @@ enum napot_cont_order {
  */
 
 #define ALT_FIXUP_MT(_val)								\
-	asm(ALTERNATIVE_2("addi	t0, zero, 0x3\n\t"					\
+	asm(ALTERNATIVE_3("addi	t0, zero, 0x3\n\t"					\
 			  "slli	t0, t0, 61\n\t"						\
 			  "not	t0, t0\n\t"						\
 			  "and	%0, %0, t0\n\t"						\
 			  "nop\n\t"							\
 			  "nop\n\t"							\
+			  "nop\n\t"							\
 			  "nop",							\
-			  __nops(7),							\
+			  __nops(8),							\
 			  0, RISCV_ISA_EXT_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,		\
+			  "addi	t0, zero, 0x3\n\t"					\
+			  "slli	t0, t0, 61\n\t"						\
+			  "and	t0, %0, t0\n\t"						\
+			  "beqz	t0, 2f\n\t"						\
+			  "xor	t1, %0, t0\n\t"						\
+			  "1: auipc t0, %%pcrel_hi(riscv_fixup_memory_alias)\n\t"	\
+			  "jalr	t0, t0, %%pcrel_lo(1b)\n\t"				\
+			  "mv	%0, t1\n"						\
+			  "2:",								\
+			  0, RISCV_ISA_EXT_XLINUXMEMALIAS,				\
+				CONFIG_RISCV_ISA_XLINUXMEMALIAS,			\
 			  "srli	t0, %0, 59\n\t"						\
 			  "seqz	t1, t0\n\t"						\
 			  "slli	t1, t1, 1\n\t"						\
 			  "or	t0, t0, t1\n\t"						\
 			  "xori	t0, t0, 0x5\n\t"					\
 			  "slli	t0, t0, 60\n\t"						\
-			  "xor	%0, %0, t0",						\
+			  "xor	%0, %0, t0\n\t"						\
+			  "nop",							\
 			  THEAD_VENDOR_ID, ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)	\
 			  : "+r" (_val) :: "t0", "t1")
 
@@ -150,9 +167,9 @@ enum napot_cont_order {
 
 #define ALT_FIXUP_MT(_val)
 
-#endif /* CONFIG_RISCV_ISA_SVPBMT || CONFIG_ERRATA_THEAD_MAE */
+#endif /* CONFIG_RISCV_ISA_SVPBMT || CONFIG_RISCV_ISA_XLINUXMEMALIAS || CONFIG_ERRATA_THEAD_MAE */
 
-#if defined(CONFIG_ERRATA_THEAD_MAE)
+#if defined(CONFIG_RISCV_ISA_XLINUXMEMALIAS) || defined(CONFIG_ERRATA_THEAD_MAE)
 
 /*
  * ALT_UNFIX_MT
@@ -160,6 +177,9 @@ enum napot_cont_order {
  * On systems that support Svpbmt, or do not support any form of page-based
  * memory type configuration, the memory type bits are left alone.
  *
+ * On systems that support XLinuxMemalias, PTEs with an aliased PFN have the
+ * matching memory type set and the PFN replaced with the normal memory alias.
+ *
  * On systems that support XTheadMae, the XTheadMae memory type (or zero) is
  * transformed back into the corresponding Svpbmt memory type.
  *
@@ -170,7 +190,15 @@ enum napot_cont_order {
  */
 
 #define ALT_UNFIX_MT(_val)								\
-	asm(ALTERNATIVE(__nops(6),							\
+	asm(ALTERNATIVE_2(__nops(6),							\
+			  "mv	t1, %0\n\t"						\
+			  "1: auipc t0, %%pcrel_hi(riscv_unfix_memory_alias)\n\t"	\
+			  "jalr	t0, t0, %%pcrel_lo(1b)\n\t"				\
+			  "mv	%0, t1\n\t"						\
+			  "nop\n\t"							\
+			  "nop",							\
+			  0, RISCV_ISA_EXT_XLINUXMEMALIAS,				\
+				CONFIG_RISCV_ISA_XLINUXMEMALIAS,			\
 			  "srli	t0, %0, 60\n\t"						\
 			  "andi	t0, t0, 0xd\n\t"					\
 			  "srli	t1, t0, 1\n\t"						\
@@ -234,7 +262,7 @@ static inline pgd_t pgdp_get(pgd_t *pgdp)
 
 #define ALT_UNFIX_MT(_val)
 
-#endif /* CONFIG_ERRATA_THEAD_MAE */
+#endif /* CONFIG_RISCV_ISA_XLINUXMEMALIAS || CONFIG_ERRATA_THEAD_MAE */
 
 static inline int pud_present(pud_t pud)
 {
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index 18c50cbd78bf5..4586917b2d985 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -38,7 +38,8 @@
 #define _PAGE_PFN_MASK		GENMASK(31, 10)
 #endif /* CONFIG_64BIT */
 
-#if defined(CONFIG_RISCV_ISA_SVPBMT) || defined(CONFIG_ERRATA_THEAD_MAE)
+#if defined(CONFIG_RISCV_ISA_SVPBMT) || defined(CONFIG_RISCV_ISA_XLINUXMEMALIAS) || \
+	defined(CONFIG_ERRATA_THEAD_MAE)
 /*
  * [62:61] Svpbmt Memory Type definitions:
  *
@@ -54,7 +55,7 @@
 #define _PAGE_NOCACHE		0
 #define _PAGE_IO		0
 #define _PAGE_MTMASK		0
-#endif /* CONFIG_RISCV_ISA_SVPBMT || CONFIG_ERRATA_THEAD_MAE */
+#endif /* CONFIG_RISCV_ISA_SVPBMT || CONFIG_RISCV_ISA_XLINUXMEMALIAS || CONFIG_ERRATA_THEAD_MAE */
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
 #define _PAGE_NAPOT_SHIFT	63
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 03b5623f9107c..f96b0bd043c6d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -1110,6 +1110,14 @@ extern u64 satp_mode;
 void paging_init(void);
 void misc_mem_init(void);
 
+#ifdef CONFIG_RISCV_ISA_XLINUXMEMALIAS
+bool __init riscv_have_memory_alias(void);
+void __init riscv_init_memory_alias(void);
+#else
+static inline bool riscv_have_memory_alias(void) { return false; }
+static inline void riscv_init_memory_alias(void) {}
+#endif /* CONFIG_RISCV_ISA_XLINUXMEMALIAS */
+
 /*
  * ZERO_PAGE is a global shared page that is always zero,
  * used for zero-mapped memory areas, etc.
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 743d53415572e..1449c43eab726 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -1093,6 +1093,12 @@ void __init riscv_fill_hwcap(void)
 		riscv_v_setup_vsize();
 	}
 
+	/* Vendor-independent alternatives require a bit in the ISA bitmap. */
+	if (riscv_have_memory_alias()) {
+		set_bit(RISCV_ISA_EXT_XLINUXMEMALIAS, riscv_isa);
+		pr_info("Using physical memory alias for noncached mappings\n");
+	}
+
 	memset(print_str, 0, sizeof(print_str));
 	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
 		if (riscv_isa[0] & BIT_MASK(i))
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f90cce7a3acea..00569c4fef494 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -353,6 +353,7 @@ void __init setup_arch(char **cmdline_p)
 	}
 
 	riscv_init_cbo_blocksizes();
+	riscv_init_memory_alias();
 	riscv_fill_hwcap();
 	apply_boot_alternatives();
 	init_rt_signal_env();
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index b916a68d324ad..b4d757226efbf 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -33,3 +33,4 @@ endif
 obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
 obj-$(CONFIG_RISCV_DMA_NONCOHERENT) += dma-noncoherent.o
 obj-$(CONFIG_RISCV_NONSTANDARD_CACHE_OPS) += cache-ops.o
+obj-$(CONFIG_RISCV_ISA_XLINUXMEMALIAS) += memory-alias.o
diff --git a/arch/riscv/mm/memory-alias.S b/arch/riscv/mm/memory-alias.S
new file mode 100644
index 0000000000000..e37b83d115911
--- /dev/null
+++ b/arch/riscv/mm/memory-alias.S
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 SiFive
+ */
+
+#include <linux/bits.h>
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <asm/pgtable.h>
+
+#define CACHED_BASE_OFFSET	(0 * RISCV_SZPTR)
+#define NONCACHED_BASE_OFFSET	(1 * RISCV_SZPTR)
+#define SIZE_OFFSET		(2 * RISCV_SZPTR)
+
+#define SIZEOF_PAIR		(4 * RISCV_SZPTR)
+
+/*
+ * Called from ALT_FIXUP_MT with a non-standard calling convention:
+ *	t0 => return address
+ *	t1 => page table entry
+ *	all other registers are callee-saved
+ */
+SYM_CODE_START(riscv_fixup_memory_alias)
+	addi	sp, sp, -4 * SZREG
+	REG_S	t2, (0 * SZREG)(sp)
+	REG_S	t3, (1 * SZREG)(sp)
+	REG_S	t4, (2 * SZREG)(sp)
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+	REG_S	t5, (3 * SZREG)(sp)
+
+	/* Save and mask off _PAGE_NAPOT if present. */
+	li	t5, _PAGE_NAPOT
+	and	t5, t1, t5
+	xor	t1, t1, t5
+#endif
+
+	/* Ignore !pte_present() PTEs, including swap PTEs. */
+	andi	t2, t1, (_PAGE_PRESENT | _PAGE_PROT_NONE)
+	beqz	t2, .Lfixup_end
+
+	lla	t2, memory_alias_pairs
+.Lfixup_loop:
+	REG_L	t3, SIZE_OFFSET(t2)
+	beqz	t3, .Lfixup_end
+	REG_L	t4, CACHED_BASE_OFFSET(t2)
+	sub	t4, t1, t4
+	bltu	t4, t3, .Lfixup_found
+	addi	t2, t2, SIZEOF_PAIR
+	j	.Lfixup_loop
+
+.Lfixup_found:
+	REG_L	t3, NONCACHED_BASE_OFFSET(t2)
+	add	t1, t3, t4
+
+.Lfixup_end:
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+	xor	t1, t1, t5
+
+	REG_L	t5, (3 * SZREG)(sp)
+#endif
+	REG_L	t4, (2 * SZREG)(sp)
+	REG_L	t3, (1 * SZREG)(sp)
+	REG_L	t2, (0 * SZREG)(sp)
+	addi	sp, sp, 4 * SZREG
+	jr	t0
+SYM_CODE_END(riscv_fixup_memory_alias)
+EXPORT_SYMBOL(riscv_fixup_memory_alias)
+
+/*
+ * Called from ALT_UNFIX_MT with a non-standard calling convention:
+ *	t0 => return address
+ *	t1 => page table entry
+ *	all other registers are callee-saved
+ */
+SYM_CODE_START(riscv_unfix_memory_alias)
+	addi	sp, sp, -4 * SZREG
+	REG_S	t2, (0 * SZREG)(sp)
+	REG_S	t3, (1 * SZREG)(sp)
+	REG_S	t4, (2 * SZREG)(sp)
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+	REG_S	t5, (3 * SZREG)(sp)
+
+	/* Save and mask off _PAGE_NAPOT if present. */
+	li	t5, _PAGE_NAPOT
+	and	t5, t1, t5
+	xor	t1, t1, t5
+#endif
+
+	/* Ignore !pte_present() PTEs, including swap PTEs. */
+	andi	t2, t1, (_PAGE_PRESENT | _PAGE_PROT_NONE)
+	beqz	t2, .Lunfix_end
+
+	lla	t2, memory_alias_pairs
+.Lunfix_loop:
+	REG_L	t3, SIZE_OFFSET(t2)
+	beqz	t3, .Lunfix_end
+	REG_L	t4, NONCACHED_BASE_OFFSET(t2)
+	sub	t4, t1, t4
+	bltu	t4, t3, .Lunfix_found
+	addi	t2, t2, SIZEOF_PAIR
+	j	.Lunfix_loop
+
+.Lunfix_found:
+	REG_L	t3, CACHED_BASE_OFFSET(t2)
+	add	t1, t3, t4
+
+	/* PFN was in the noncached alias, so mark it as such. */
+	li	t2, _PAGE_NOCACHE
+	or	t1, t1, t2
+
+.Lunfix_end:
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+	xor	t1, t1, t5
+
+	REG_L	t5, (3 * SZREG)(sp)
+#endif
+	REG_L	t4, (2 * SZREG)(sp)
+	REG_L	t3, (1 * SZREG)(sp)
+	REG_L	t2, (0 * SZREG)(sp)
+	addi	sp, sp, 4 * SZREG
+	jr	t0
+SYM_CODE_END(riscv_unfix_memory_alias)
+EXPORT_SYMBOL(riscv_unfix_memory_alias)
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 604744d6924f5..de79a2dc9926f 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <asm/pgalloc.h>
+#include <dt-bindings/riscv/physical-memory.h>
+#include <linux/bitfield.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
+#include <linux/memblock.h>
+#include <linux/of.h>
 #include <linux/pgtable.h>
 
 int ptep_set_access_flags(struct vm_area_struct *vma,
@@ -160,3 +164,90 @@ pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
 	return old;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+#ifdef CONFIG_RISCV_ISA_XLINUXMEMALIAS
+struct memory_alias_pair {
+	unsigned long cached_base;
+	unsigned long noncached_base;
+	unsigned long size;
+	int index;
+} memory_alias_pairs[5];
+
+bool __init riscv_have_memory_alias(void)
+{
+	return memory_alias_pairs[0].size;
+}
+
+void __init riscv_init_memory_alias(void)
+{
+	int na = of_n_addr_cells(of_root);
+	int ns = of_n_size_cells(of_root);
+	int nc = na + ns + 2;
+	const __be32 *prop;
+	int pairs = 0;
+	int len;
+
+	prop = of_get_property(of_root, "riscv,physical-memory-regions", &len);
+	if (!prop)
+		return;
+
+	len /= sizeof(__be32);
+	for (int i = 0; len >= nc; i++, prop += nc, len -= nc) {
+		unsigned long base = of_read_ulong(prop, na);
+		unsigned long size = of_read_ulong(prop + na, ns);
+		unsigned long flags = be32_to_cpup(prop + na + ns);
+		struct memory_alias_pair *pair;
+		int alias;
+
+		/* We only care about non-coherent memory. */
+		if ((flags & PMA_ORDER_MASK) != PMA_ORDER_MEMORY || (flags & PMA_COHERENT))
+			continue;
+
+		/* The cacheable alias must be usable memory. */
+		if ((flags & PMA_CACHEABLE) &&
+		    !memblock_overlaps_region(&memblock.memory, base, size))
+			continue;
+
+		alias = FIELD_GET(PMR_ALIAS_MASK, flags);
+		if (alias) {
+			pair = NULL;
+			for (int j = 0; j < pairs; j++) {
+				if (alias == memory_alias_pairs[j].index) {
+					pair = &memory_alias_pairs[j];
+					break;
+				}
+			}
+			if (!pair)
+				continue;
+		} else {
+			/* Leave room for the null sentinel. */
+			if (pairs == ARRAY_SIZE(memory_alias_pairs) - 1)
+				continue;
+			pair = &memory_alias_pairs[pairs++];
+			pair->index = i;
+		}
+
+		/* Align the address and size with the page table PFN field. */
+		base >>= PAGE_SHIFT - _PAGE_PFN_SHIFT;
+		size >>= PAGE_SHIFT - _PAGE_PFN_SHIFT;
+
+		if (flags & PMA_CACHEABLE)
+			pair->cached_base = base;
+		else
+			pair->noncached_base = base;
+		pair->size = min_not_zero(pair->size, size);
+	}
+
+	/* Remove any unmatched pairs. */
+	for (int i = 0; i < pairs; i++) {
+		struct memory_alias_pair *pair = &memory_alias_pairs[i];
+
+		if (pair->cached_base && pair->noncached_base && pair->size)
+			continue;
+
+		for (int j = i + 1; j < pairs; j++)
+			memory_alias_pairs[j - 1] = memory_alias_pairs[j];
+		memory_alias_pairs[--pairs].size = 0;
+	}
+}
+#endif /* CONFIG_RISCV_ISA_XLINUXMEMALIAS */
diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index ed57926ecd585..ba5f33a2c2178 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -140,7 +140,8 @@ static const struct prot_bits pte_bits[] = {
 		.clear = ".",
 	}, {
 #endif
-#if defined(CONFIG_RISCV_ISA_SVPBMT) || defined(CONFIG_ERRATA_THEAD_MAE)
+#if defined(CONFIG_RISCV_ISA_SVPBMT) || defined(CONFIG_RISCV_ISA_XLINUXMEMALIAS) || \
+	defined(CONFIG_ERRATA_THEAD_MAE)
 		.mask = _PAGE_MTMASK,
 		.set = "MT(%s)",
 		.clear = "  ..  ",
@@ -216,7 +217,8 @@ static void dump_prot(struct pg_state *st)
 		if (val) {
 			if (pte_bits[i].mask == _PAGE_SOFT)
 				sprintf(s, pte_bits[i].set, val >> 8);
-#if defined(CONFIG_RISCV_ISA_SVPBMT) || defined(CONFIG_ERRATA_THEAD_MAE)
+#if defined(CONFIG_RISCV_ISA_SVPBMT) || defined(CONFIG_RISCV_ISA_XLINUXMEMALIAS) || \
+	defined(CONFIG_ERRATA_THEAD_MAE)
 			else if (pte_bits[i].mask == _PAGE_MTMASK) {
 				if (val == _PAGE_NOCACHE)
 					sprintf(s, pte_bits[i].set, "NC");
-- 
2.47.2


