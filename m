Return-Path: <linux-kernel+bounces-846150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B479BC7274
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110C719E2E58
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913FE192B90;
	Thu,  9 Oct 2025 01:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GkCaVBRn"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F171DFE26
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975142; cv=none; b=qz7C1/4hAbhlkKMuGxPU9WlH3n16IxcOfwRQJ6yCVh+MSKcF0YJn8lIRe7rwPUB603R4AbUVp2Il9LoMhRLbP/2E4IA4+0tv+/9oJfBzC8Z6YRg8HbGrUtpb8GVk179jCiJOFokFupTawfiMIqEUntlLP2GKBaijW8dgRJCW8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975142; c=relaxed/simple;
	bh=Z3PGA/IExFuz4J9is+0KdJMXKe4IKcUzxs9piNLi0Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bx3OzCyq8V/l0iONaG/aVRnsufleYIDnOVHoX8eu8qOO/4Kljwt4Sh1vVfaYvTFCmUzJ2B/BGJrZ6DpSVq8P6nV4sJLZfI68WBXuluZRfV7/XR5sB39i9DfUqBS01MYYkBXHvMdmZHsWo/Fs752lzNFRql/j87Jm94Yd0VCnthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GkCaVBRn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27d3540a43fso4217955ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975135; x=1760579935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CenIuzXpxApsKzkUyACEQ0jjKpKilW6kJlIT8GgEJGc=;
        b=GkCaVBRnX048A6xTmhLQcwFQDhj13GVpQpQsNdNO0EGdZ9pdkCsKcwbK6urqRRriy7
         m4i59IZ4X9xdZ3guayhHRTxJT6Kdd1Ud7gcwUPIanEUiZe/aro6Q5rheLSEGlci7VCx8
         oFh6dm+VZtkNsOiqOvHRKpk+bGqN+xpm44mNBRGsdN+qbUnH5Rp8ZzZePG08aFaVGBoj
         rzLRHG3jNuTRCooGowJB8KN/M95c3g2YUHEMdZNs1qRxhwWrmn6fsoUgXnbWkFUGqUWd
         BUp4AoBQlMpzecPmVGYx3xA7WKBua19UpeGHPcd9oU9ePeGgX+ZbXGkthyiLbbXbW6KQ
         pYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975135; x=1760579935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CenIuzXpxApsKzkUyACEQ0jjKpKilW6kJlIT8GgEJGc=;
        b=VpAc6/KFVKWAMBMo1mDQ7Gx88agi9hgDLo8gorZgy7GlBoswzv4F0J+R6fyfoaRMnl
         ON7h7xISv9ZZkd0WIdtDD1iRIFdJC2uYyoqWd9Ig/twg0b/gtL/FlZfT34JgWM+HhXmg
         BM4AtvZi0cQ5Ne/qmMgXPF8++jcZavfpu2C2ZxQplOmPgQ9pqlTXdxCOC7zeyvBSBC1U
         b2GpYC2JiLR3vXt4rpjZfH+LToymR216NSbUzydODUABx2+Df7thHQ9fmBbSo98kaWt6
         FyUUi/VQzpTwwpoqx+MJqgc2/cR5CpuWF4oRVdHiZlIWHVvrMSqcDAvCKgesR6a4L75q
         s2xw==
X-Forwarded-Encrypted: i=1; AJvYcCVxwxm4esgdur8+3GqiEHQFTsZ3TY/FOnjLA0IZZfJzWfL5u2NXpIF0BgXC5OG4qF6WAhxA7p0+LRcP8H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSKcdxStWcHXxOEiYcTzqBoD3ijb3yDQZhiYo0Rbqrl8DdAPKa
	qOaiBnsrWg9bhaTixw7YxDBC4poIg77jS2NobTes2FIEaptHjy17xH+tKREAwe9YuEE=
X-Gm-Gg: ASbGncvYFja/L1f4k2ab12FP9gwHCuwrIg8eJDuhocojLch71T/gUhNvnwhF+p/jnje
	wns4+9L+3KnmcCL3lYAXmh/7i6EzyHD+kJjI3YEPOCWgPjWbTK2sb0tek5IA6YdNX+N7biqSuRu
	g0Nvr+xsz0DJ2NwX+6EmtVyvU2Xpcjxyw331buDzbxovhXBMcj8F41RF2QX5lxznTG93PukbZA2
	uwXpDCDhf3jDKzCpSQoVWSYq6Rfz8cIlcXe169chCRVUGAxTRW2+iWdBEAlO0VzFnQSx9ayY5H7
	CFURaWgOcdKaWlSinDpaizgwtRHBg7QSXZ0Egyf3zQjsdx8CvJ9tiqiQ0YlpUQGN5JgIMz/93qA
	w06HrA6AeRAyCedy1zbYtB8wHb2+DqyFuCfirJGJnK/IACvW49AX6r/NclrxpRWcwzCeN
X-Google-Smtp-Source: AGHT+IE89szqaNtwL7rV4bj88ZY+SdoVTevQxbpQrOA8RfTnb5TmsiChXULlplUdtG27xkBnWYgvJg==
X-Received: by 2002:a17:903:1b4b:b0:26d:353c:75cd with SMTP id d9443c01a7336-290272409c7mr75848955ad.21.1759975134617;
        Wed, 08 Oct 2025 18:58:54 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:58:54 -0700 (PDT)
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
Subject: [PATCH v2 11/18] riscv: mm: Fix up memory types when writing page tables
Date: Wed,  8 Oct 2025 18:57:47 -0700
Message-ID: <20251009015839.3460231-12-samuel.holland@sifive.com>
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

Currently, Linux on RISC-V has three ways to specify the cacheability
and ordering PMAs of a page:
 1) Do nothing; assume the system is entirely cache-coherent and rely on
    the hardware for any ordering requirements
 2) Use the page table bits specified by Svpbmt
 3) Use the page table bits specified by XTheadMae

To support all three methods, the kernel dynamically determines the
definitions of the _PAGE_NOCACHE and _PAGE_IO fields. However, this
alone is not sufficient, as XTheadMae uses a nonzero memory type value
for normal memory pages. So the kernel uses an additional alternative
sequence (ALT_THEAD_PMA) to insert the correct memory type when
generating page table entries.

Some RISC-V platforms use a fourth method to specify the cacheability of
a page of RAM: RAM is mapped to multiple physical address ranges, with
each alias having a different set of statically-determined PMAs.
Software selects the PMAs for a page by choosing the corresponding PFN
from one of the available physical address ranges. Like for XTheadMae,
this strategy also requires applying a transformation when writing page
table entries. Since these physical memory aliases should be invisible
to the rest of the kernel, the opposite transformation must be applied
when reading page table entries.

However, with this last method of specifying PMAs, there is no inherent
way to indicate the cacheability of a page in the pgprot_t value, since
the PFN itself determines cacheability. This implementation reuses the
PTE bits from Svpbmt, as Svpbmt is the standard RISC-V extension, and
thus ought to be the most common way to indicate per-page PMAs. Thus,
the Svpbmt variant of _PAGE_NOCACHE and _PAGE_IO is made available even
when the CPU does not support the extension.

It turns out that with some clever bit manipulation, it is just as
efficient to transform all three Svpbmt memory type values to the
corresponding XTheadMae values, as it is to check for and insert the
one XTheadMae memory type value for normal memory. Thus, we implement
XTheadMae as a variant on top of Svpbmt. This allows the _PAGE_NOCACHE
and _PAGE_IO definitions to be compile-time constants, and centralizes
all memory type handling to a single set of alternative macros.

However, there is a tradeoff for platforms relying on hardware for all
memory type handling: the memory type PTE bits must now be masked off
when writing page table entries, whereas previously no transformation
was needed.

As a side effect, since the inverse transformation is applied when
reading back page table entries, this change fixes the reporting of the
memory type bits from ptdump on platforms with XTheadMae.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Keep Kconfig options for each PBMT variant separate/non-overlapping
 - Move fixup code sequences to set_pXX() and pXXp_get()
 - Only define ALT_UNFIX_MT in configurations that need it
 - Improve inline documentation of ALT_FIXUP_MT/ALT_UNFIX_MT

 arch/riscv/include/asm/errata_list.h |  45 -------
 arch/riscv/include/asm/pgtable-32.h  |   3 +
 arch/riscv/include/asm/pgtable-64.h  | 171 ++++++++++++++++++++++-----
 arch/riscv/include/asm/pgtable.h     |  47 ++++----
 arch/riscv/mm/pgtable.c              |  14 +--
 arch/riscv/mm/ptdump.c               |  12 +-
 6 files changed, 174 insertions(+), 118 deletions(-)

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 6e426ed7919a4..56335eba899ea 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -59,51 +59,6 @@ asm(ALTERNATIVE("sfence.vma %0, %1", "sfence.vma", SIFIVE_VENDOR_ID,	\
 		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
 		: : "r" (addr), "r" (asid) : "memory")
 
-/*
- * _val is marked as "will be overwritten", so need to set it to 0
- * in the default case.
- */
-#define ALT_SVPBMT_SHIFT 61
-#define ALT_THEAD_MAE_SHIFT 59
-#define ALT_SVPBMT(_val, prot)						\
-asm(ALTERNATIVE_2("li %0, 0\t\nnop",					\
-		  "li %0, %1\t\nslli %0,%0,%3", 0,			\
-			RISCV_ISA_EXT_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,	\
-		  "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,	\
-			ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)	\
-		: "=r"(_val)						\
-		: "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIFT),		\
-		  "I"(prot##_THEAD >> ALT_THEAD_MAE_SHIFT),		\
-		  "I"(ALT_SVPBMT_SHIFT),				\
-		  "I"(ALT_THEAD_MAE_SHIFT))
-
-#ifdef CONFIG_ERRATA_THEAD_MAE
-/*
- * IO/NOCACHE memory types are handled together with svpbmt,
- * so on T-Head chips, check if no other memory type is set,
- * and set the non-0 PMA type if applicable.
- */
-#define ALT_THEAD_PMA(_val)						\
-asm volatile(ALTERNATIVE(						\
-	__nops(7),							\
-	"li      t3, %1\n\t"						\
-	"slli    t3, t3, %3\n\t"					\
-	"and     t3, %0, t3\n\t"					\
-	"bne     t3, zero, 2f\n\t"					\
-	"li      t3, %2\n\t"						\
-	"slli    t3, t3, %3\n\t"					\
-	"or      %0, %0, t3\n\t"					\
-	"2:",  THEAD_VENDOR_ID,						\
-		ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)		\
-	: "+r"(_val)							\
-	: "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_MAE_SHIFT),		\
-	  "I"(_PAGE_PMA_THEAD >> ALT_THEAD_MAE_SHIFT),			\
-	  "I"(ALT_THEAD_MAE_SHIFT)					\
-	: "t3")
-#else
-#define ALT_THEAD_PMA(_val)
-#endif
-
 #define ALT_CMO_OP(_op, _start, _size, _cachesize)			\
 asm volatile(ALTERNATIVE(						\
 	__nops(5),							\
diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index fa6c87015c480..90ef35a7c1a52 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -28,6 +28,9 @@
 #define _PAGE_IO		0
 #define _PAGE_MTMASK		0
 
+#define ALT_FIXUP_MT(_val)
+#define ALT_UNFIX_MT(_val)
+
 static const __maybe_unused int pgtable_l4_enabled;
 static const __maybe_unused int pgtable_l5_enabled;
 
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index d17382c0fbe59..5531752b608e4 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -8,7 +8,7 @@
 
 #include <linux/bits.h>
 #include <linux/const.h>
-#include <asm/errata_list.h>
+#include <asm/alternative-macros.h>
 
 extern bool pgtable_l4_enabled;
 extern bool pgtable_l5_enabled;
@@ -109,6 +109,8 @@ enum napot_cont_order {
 #define HUGE_MAX_HSTATE		2
 #endif
 
+#if defined(CONFIG_RISCV_ISA_SVPBMT) || defined(CONFIG_ERRATA_THEAD_MAE)
+
 /*
  * [62:61] Svpbmt Memory Type definitions:
  *
@@ -117,53 +119,152 @@ enum napot_cont_order {
  *  10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
  *  11 - Rsvd   Reserved for future standard use
  */
-#define _PAGE_NOCACHE_SVPBMT	(1UL << 61)
-#define _PAGE_IO_SVPBMT		(1UL << 62)
-#define _PAGE_MTMASK_SVPBMT	(_PAGE_NOCACHE_SVPBMT | _PAGE_IO_SVPBMT)
+#define _PAGE_NOCACHE		(1UL << 61)
+#define _PAGE_IO		(2UL << 61)
+#define _PAGE_MTMASK		(3UL << 61)
 
 /*
+ * ALT_FIXUP_MT
+ *
+ * On systems that do not support any form of page-based memory type
+ * configuration, this code sequence clears the memory type bits in the PTE.
+ *
+ * On systems that support Svpbmt, the memory type bits are left alone.
+ *
+ * On systems that support XTheadMae, a Svpbmt memory type is transformed
+ * into the corresponding XTheadMae memory type.
+ *
  * [63:59] T-Head Memory Type definitions:
  * bit[63] SO - Strong Order
  * bit[62] C - Cacheable
  * bit[61] B - Bufferable
  * bit[60] SH - Shareable
  * bit[59] Sec - Trustable
- * 00110 - NC   Weakly-ordered, Non-cacheable, Bufferable, Shareable, Non-trustable
  * 01110 - PMA  Weakly-ordered, Cacheable, Bufferable, Shareable, Non-trustable
+ * 00110 - NC   Weakly-ordered, Non-cacheable, Bufferable, Shareable, Non-trustable
  * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareable, Non-trustable
+ *
+ * Pseudocode operating on bits [63:60]:
+ *   t0 = mt << 1
+ *   if (t0 == 0)
+ *     t0 |= 2
+ *   t0 ^= 0x5
+ *   mt ^= t0
+ */
+
+#define ALT_FIXUP_MT(_val)								\
+	asm(ALTERNATIVE_2("addi	t0, zero, 0x3\n\t"					\
+			  "slli	t0, t0, 61\n\t"						\
+			  "not	t0, t0\n\t"						\
+			  "and	%0, %0, t0\n\t"						\
+			  "nop\n\t"							\
+			  "nop\n\t"							\
+			  "nop",							\
+			  __nops(7),							\
+			  0, RISCV_ISA_EXT_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,		\
+			  "srli	t0, %0, 59\n\t"						\
+			  "seqz	t1, t0\n\t"						\
+			  "slli	t1, t1, 1\n\t"						\
+			  "or	t0, t0, t1\n\t"						\
+			  "xori	t0, t0, 0x5\n\t"					\
+			  "slli	t0, t0, 60\n\t"						\
+			  "xor	%0, %0, t0",						\
+			  THEAD_VENDOR_ID, ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)	\
+			  : "+r" (_val) :: "t0", "t1")
+
+#else
+
+#define _PAGE_NOCACHE		0
+#define _PAGE_IO		0
+#define _PAGE_MTMASK		0
+
+#define ALT_FIXUP_MT(_val)
+
+#endif /* CONFIG_RISCV_ISA_SVPBMT || CONFIG_ERRATA_THEAD_MAE */
+
+#if defined(CONFIG_ERRATA_THEAD_MAE)
+
+/*
+ * ALT_UNFIX_MT
+ *
+ * On systems that support Svpbmt, or do not support any form of page-based
+ * memory type configuration, the memory type bits are left alone.
+ *
+ * On systems that support XTheadMae, the XTheadMae memory type (or zero) is
+ * transformed back into the corresponding Svpbmt memory type.
+ *
+ * Pseudocode operating on bits [63:60]:
+ *   t0 = mt & 0xd
+ *   t0 ^= t0 >> 1
+ *   mt ^= t0
  */
-#define _PAGE_PMA_THEAD		((1UL << 62) | (1UL << 61) | (1UL << 60))
-#define _PAGE_NOCACHE_THEAD	((1UL << 61) | (1UL << 60))
-#define _PAGE_IO_THEAD		((1UL << 63) | (1UL << 60))
-#define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
 
-static inline u64 riscv_page_mtmask(void)
+#define ALT_UNFIX_MT(_val)								\
+	asm(ALTERNATIVE(__nops(6),							\
+			  "srli	t0, %0, 60\n\t"						\
+			  "andi	t0, t0, 0xd\n\t"					\
+			  "srli	t1, t0, 1\n\t"						\
+			  "xor	t0, t0, t1\n\t"						\
+			  "slli	t0, t0, 60\n\t"						\
+			  "xor	%0, %0, t0",						\
+			  THEAD_VENDOR_ID, ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)	\
+			  : "+r" (_val) :: "t0", "t1")
+
+#define ptep_get ptep_get
+static inline pte_t ptep_get(pte_t *ptep)
 {
-	u64 val;
+	pte_t pte = READ_ONCE(*ptep);
 
-	ALT_SVPBMT(val, _PAGE_MTMASK);
-	return val;
+	ALT_UNFIX_MT(pte);
+
+	return pte;
 }
 
-static inline u64 riscv_page_nocache(void)
+#define pmdp_get pmdp_get
+static inline pmd_t pmdp_get(pmd_t *pmdp)
 {
-	u64 val;
+	pmd_t pmd = READ_ONCE(*pmdp);
+
+	ALT_UNFIX_MT(pmd);
 
-	ALT_SVPBMT(val, _PAGE_NOCACHE);
-	return val;
+	return pmd;
 }
 
-static inline u64 riscv_page_io(void)
+#define pudp_get pudp_get
+static inline pud_t pudp_get(pud_t *pudp)
 {
-	u64 val;
+	pud_t pud = READ_ONCE(*pudp);
+
+	ALT_UNFIX_MT(pud);
 
-	ALT_SVPBMT(val, _PAGE_IO);
-	return val;
+	return pud;
 }
 
-#define _PAGE_NOCACHE		riscv_page_nocache()
-#define _PAGE_IO		riscv_page_io()
-#define _PAGE_MTMASK		riscv_page_mtmask()
+#define p4dp_get p4dp_get
+static inline p4d_t p4dp_get(p4d_t *p4dp)
+{
+	p4d_t p4d = READ_ONCE(*p4dp);
+
+	ALT_UNFIX_MT(p4d);
+
+	return p4d;
+}
+
+#define pgdp_get pgdp_get
+static inline pgd_t pgdp_get(pgd_t *pgdp)
+{
+	pgd_t pgd = READ_ONCE(*pgdp);
+
+	ALT_UNFIX_MT(pgd);
+
+	return pgd;
+}
+
+#else
+
+#define ALT_UNFIX_MT(_val)
+
+#endif /* CONFIG_ERRATA_THEAD_MAE */
 
 static inline int pud_present(pud_t pud)
 {
@@ -193,6 +294,7 @@ static inline int pud_user(pud_t pud)
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
+	ALT_FIXUP_MT(pud);
 	WRITE_ONCE(*pudp, pud);
 }
 
@@ -243,11 +345,7 @@ static inline bool mm_pud_folded(struct mm_struct *mm)
 
 static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
 {
-	unsigned long prot_val = pgprot_val(prot);
-
-	ALT_THEAD_PMA(prot_val);
-
-	return __pmd((pfn << _PAGE_PFN_SHIFT) | prot_val);
+	return __pmd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
 }
 
 static inline unsigned long _pmd_pfn(pmd_t pmd)
@@ -255,6 +353,9 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
 	return __page_val_to_pfn(pmd_val(pmd));
 }
 
+#define pmd_offset_lockless(pudp, pud, address) \
+	(pud_pgtable(pud) + pmd_index(address))
+
 #define pmd_ERROR(e) \
 	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
 
@@ -266,6 +367,7 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
 
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
+	ALT_FIXUP_MT(p4d);
 	WRITE_ONCE(*p4dp, p4d);
 }
 
@@ -325,11 +427,15 @@ static inline struct page *p4d_page(p4d_t p4d)
 
 #define pud_index(addr) (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
 
+#define pud_offset_lockless(p4dp, p4d, address) \
+	(pgtable_l4_enabled ? p4d_pgtable(p4d) + pud_index(address) : (pud_t *)(p4dp))
+
 #define pud_offset pud_offset
-pud_t *pud_offset(p4d_t *p4d, unsigned long address);
+pud_t *pud_offset(p4d_t *p4dp, unsigned long address);
 
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
+	ALT_FIXUP_MT(pgd);
 	WRITE_ONCE(*pgdp, pgd);
 }
 
@@ -380,8 +486,11 @@ static inline struct page *pgd_page(pgd_t pgd)
 
 #define p4d_index(addr) (((addr) >> P4D_SHIFT) & (PTRS_PER_P4D - 1))
 
+#define p4d_offset_lockless(pgdp, pgd, address) \
+	(pgtable_l5_enabled ? pgd_pgtable(pgd) + p4d_index(address) : (p4d_t *)(pgdp))
+
 #define p4d_offset p4d_offset
-p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
+p4d_t *p4d_offset(pgd_t *pgdp, unsigned long address);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline pte_t pmd_pte(pmd_t pmd);
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 61de71a8ba978..03b5623f9107c 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -252,6 +252,7 @@ static inline bool pmd_leaf(pmd_t pmd)
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
+	ALT_FIXUP_MT(pmd);
 	WRITE_ONCE(*pmdp, pmd);
 }
 
@@ -262,11 +263,7 @@ static inline void pmd_clear(pmd_t *pmdp)
 
 static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
 {
-	unsigned long prot_val = pgprot_val(prot);
-
-	ALT_THEAD_PMA(prot_val);
-
-	return __pgd((pfn << _PAGE_PFN_SHIFT) | prot_val);
+	return __pgd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
 }
 
 static inline unsigned long _pgd_pfn(pgd_t pgd)
@@ -342,11 +339,7 @@ static inline unsigned long pte_pfn(pte_t pte)
 /* Constructs a page table entry */
 static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 {
-	unsigned long prot_val = pgprot_val(prot);
-
-	ALT_THEAD_PMA(prot_val);
-
-	return __pte((pfn << _PAGE_PFN_SHIFT) | prot_val);
+	return __pte((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
 }
 
 #define pte_pgprot pte_pgprot
@@ -485,11 +478,7 @@ static inline int pmd_protnone(pmd_t pmd)
 /* Modify page protection bits */
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	unsigned long newprot_val = pgprot_val(newprot);
-
-	ALT_THEAD_PMA(newprot_val);
-
-	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | newprot_val);
+	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
 }
 
 #define pgd_ERROR(e) \
@@ -546,9 +535,10 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
  * a page table are directly modified.  Thus, the following hook is
  * made available.
  */
-static inline void set_pte(pte_t *ptep, pte_t pteval)
+static inline void set_pte(pte_t *ptep, pte_t pte)
 {
-	WRITE_ONCE(*ptep, pteval);
+	ALT_FIXUP_MT(pte);
+	WRITE_ONCE(*ptep, pte);
 }
 
 void flush_icache_pte(struct mm_struct *mm, pte_t pte);
@@ -597,6 +587,7 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 {
 	pte_t pte = __pte(atomic_long_xchg((atomic_long_t *)ptep, 0));
 
+	ALT_UNFIX_MT(pte);
 	page_table_check_pte_clear(mm, pte);
 
 	return pte;
@@ -866,6 +857,7 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 {
 	pmd_t pmd = __pmd(atomic_long_xchg((atomic_long_t *)pmdp, 0));
 
+	ALT_UNFIX_MT(pmd);
 	page_table_check_pmd_clear(mm, pmd);
 
 	return pmd;
@@ -883,7 +875,11 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 				unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
 	page_table_check_pmd_set(vma->vm_mm, pmdp, pmd);
-	return __pmd(atomic_long_xchg((atomic_long_t *)pmdp, pmd_val(pmd)));
+	ALT_FIXUP_MT(pmd);
+	pmd = __pmd(atomic_long_xchg((atomic_long_t *)pmdp, pmd_val(pmd)));
+	ALT_UNFIX_MT(pmd);
+
+	return pmd;
 }
 
 #define pmdp_collapse_flush pmdp_collapse_flush
@@ -952,14 +948,9 @@ static inline int pudp_test_and_clear_young(struct vm_area_struct *vma,
 static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long address,  pud_t *pudp)
 {
-#ifdef CONFIG_SMP
-	pud_t pud = __pud(xchg(&pudp->pud, 0));
-#else
-	pud_t pud = pudp_get(pudp);
-
-	pud_clear(pudp);
-#endif
+	pud_t pud = __pud(atomic_long_xchg((atomic_long_t *)pudp, 0));
 
+	ALT_UNFIX_MT(pud);
 	page_table_check_pud_clear(mm, pud);
 
 	return pud;
@@ -982,7 +973,11 @@ static inline pud_t pudp_establish(struct vm_area_struct *vma,
 				   unsigned long address, pud_t *pudp, pud_t pud)
 {
 	page_table_check_pud_set(vma->vm_mm, pudp, pud);
-	return __pud(atomic_long_xchg((atomic_long_t *)pudp, pud_val(pud)));
+	ALT_FIXUP_MT(pud);
+	pud = __pud(atomic_long_xchg((atomic_long_t *)pudp, pud_val(pud)));
+	ALT_UNFIX_MT(pud);
+
+	return pud;
 }
 
 static inline pud_t pud_mkinvalid(pud_t pud)
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index c4b85a828797e..604744d6924f5 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -42,20 +42,14 @@ int ptep_test_and_clear_young(struct vm_area_struct *vma,
 EXPORT_SYMBOL_GPL(ptep_test_and_clear_young);
 
 #ifdef CONFIG_64BIT
-pud_t *pud_offset(p4d_t *p4d, unsigned long address)
+pud_t *pud_offset(p4d_t *p4dp, unsigned long address)
 {
-	if (pgtable_l4_enabled)
-		return p4d_pgtable(p4dp_get(p4d)) + pud_index(address);
-
-	return (pud_t *)p4d;
+	return pud_offset_lockless(p4dp, p4dp_get(p4dp), address);
 }
 
-p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
+p4d_t *p4d_offset(pgd_t *pgdp, unsigned long address)
 {
-	if (pgtable_l5_enabled)
-		return pgd_pgtable(pgdp_get(pgd)) + p4d_index(address);
-
-	return (p4d_t *)pgd;
+	return p4d_offset_lockless(pgdp, pgdp_get(pgdp), address);
 }
 #endif
 
diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 6608162459ae0..ed57926ecd585 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -140,8 +140,8 @@ static const struct prot_bits pte_bits[] = {
 		.clear = ".",
 	}, {
 #endif
-#ifdef CONFIG_RISCV_ISA_SVPBMT
-		.mask = _PAGE_MTMASK_SVPBMT,
+#if defined(CONFIG_RISCV_ISA_SVPBMT) || defined(CONFIG_ERRATA_THEAD_MAE)
+		.mask = _PAGE_MTMASK,
 		.set = "MT(%s)",
 		.clear = "  ..  ",
 	}, {
@@ -216,11 +216,11 @@ static void dump_prot(struct pg_state *st)
 		if (val) {
 			if (pte_bits[i].mask == _PAGE_SOFT)
 				sprintf(s, pte_bits[i].set, val >> 8);
-#ifdef CONFIG_RISCV_ISA_SVPBMT
-			else if (pte_bits[i].mask == _PAGE_MTMASK_SVPBMT) {
-				if (val == _PAGE_NOCACHE_SVPBMT)
+#if defined(CONFIG_RISCV_ISA_SVPBMT) || defined(CONFIG_ERRATA_THEAD_MAE)
+			else if (pte_bits[i].mask == _PAGE_MTMASK) {
+				if (val == _PAGE_NOCACHE)
 					sprintf(s, pte_bits[i].set, "NC");
-				else if (val == _PAGE_IO_SVPBMT)
+				else if (val == _PAGE_IO)
 					sprintf(s, pte_bits[i].set, "IO");
 				else
 					sprintf(s, pte_bits[i].set, "??");
-- 
2.47.2


