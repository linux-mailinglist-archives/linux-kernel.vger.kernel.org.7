Return-Path: <linux-kernel+bounces-846151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46AEBC729B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814523E5C3D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6831D618C;
	Thu,  9 Oct 2025 01:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="igWKcsjb"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8851E00A0
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975142; cv=none; b=ALR3BdIuQTB/902K0S0oK5kxpJYEoy3PSA10uuReZJzPIoMkb2jJWV2LETjbiE/XJOCF3Hff7Q7sSLbzR3OL0D7U+4QuRZpYD20fUQ6UGHHzDDbManE4baiwjXogiteB174pmUP/AH0weceeBqf5DmWWe9tdthztkQji4GGS0nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975142; c=relaxed/simple;
	bh=wRFMYBpHaprmwMkBGjqFZnnNTBugi5w/9MhAu1OLS08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPvNwgSzsUiR5uIiYTc9PQaOWfJ3P6nYo7b6HrxfAmGrDyzDrgx4TtV6VSrD4kPuMjx2lMfG3smiwbQuM4k4farg8eL+l0E+g+YBsrQgHwiEJKKKK0Ws+od3DUcY+Z19qjfmxWxZwtWwCEI8n5x9QjzQ8xeQbk2TkVjw4jxW3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=igWKcsjb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-279e2554b5fso4018185ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975136; x=1760579936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qox8adEL3NVTIaNLXzvlCmJaaMYPBhbok62G/+ufmI4=;
        b=igWKcsjb8N7t/SSLA/p6iDgW71ioBFxl4RCf6dR/q4WQEBKMjuUFTUqA1zaASGmQxF
         NwoB4GzAQrqD3TsBlkAQTkcNaFasIj4sOSMn1yaXY9swKCJtIBzVNhDLesy1BcL4vmSA
         JzpHOIw4hmaoNf3Vq54r3F6YAj8Mw0oSD6g5kJVPEFnRg9A/81S38EjiY3v8P6x9sn2U
         r64PS8P0V1tN2Tmn/jIUPnXIWz+RXMm7VQKKXJIhWONbAdDJsSq+vV6taVJ7zLfDutEY
         uakRfqbo1zvU0lJ9R7b4WCXTSyWc7vyTRkxyoYlSPXkd7uc1TxE7IldWwo1VBN7GdeTm
         pkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975136; x=1760579936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qox8adEL3NVTIaNLXzvlCmJaaMYPBhbok62G/+ufmI4=;
        b=u1+D6L7eYhwSu/ncXeE96bFCpNwb74Gu8bYy04R0lgtzX+6poNsFrJ6ismmxFA660E
         FG6gZmYymEMrIZuHH/1I8rLOAiMBPR8mGidFoMt0QOyoQsM9OAVs5lZ7G2OSN0Lceltg
         joUU9KDkalljvxco/KYYZKoLVKmZBvC527NvXKOvcE86N5+vpq7krNVx2vbr00lUp64c
         7fZh+NrvOB46k8ILJsKeNrSahs3y33CIUTtdIiAyLOMKvVzSvxkntSmVI7vmTpa8wEqI
         NFPArwWowRoZyui/7lpJWH9aXOWhn0oQhUuGQHC35dWIi9WRAMn7e+860weQcEVJm2hk
         Zuow==
X-Forwarded-Encrypted: i=1; AJvYcCV/ory1yk22UAHiHamW1xsK6z9ga2X4UpF8BF6dl5CyQoiRI3SlRnGMRlBhkzMAp6wNqGvk2/SserGdct4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBu5gDH4luARZf6M47KcaEEgBdUc7tGib6Csc4Eg4u47iwsSHI
	2XxxhWl2awQcebsH+0ayUOlY+3wiaKhLrqid+qOlcLuLfC8N6wviqw1grZSVH9y6u/w=
X-Gm-Gg: ASbGnctMfEEf2hlFZoQnDRrI2w8F/n7KCGctszjxU+InOwZpDk4JJfNOWpr3yyCsKvI
	qBTqhBAY+w3wWXcVfsxzjAqExTuEUiT5cxt37tMQgOMTpmXxRR7N1SZo444B4JK0zcpRysq5rSF
	8XmC8zhL8s2jTWucuPfxux4wp3Qtt8x3nk1VXIxHxqhSaYykOiKbgKG6wYwikuWx9g79dEWg16j
	XW9HgYsdn2J03b8QICIE2k5qVy0kV7jRTn1rc4Yi7bIKu7RfwqP7Djjn+zgPkU2GLyp2f99kr/+
	n7O5v7Z23hNglD3cR/QdRpxZfFKbwuwgDQIIQP6C6qrR2hra8R24e6Ns8wXNfu+QF9ZfDTpImDP
	wvc76pIqcWxwGyb8BQXyq6yGTq7ckemRH5jLneb+y5cKfWYZUlPLnRzmFEqPeub3Ul90Y
X-Google-Smtp-Source: AGHT+IHbkVL7EPb5KjicSw4KSoOokG99J04JG0lwtTo3UaOYe/evftUmF2hr4J/jh5vQhBOg6irmTg==
X-Received: by 2002:a17:903:1a03:b0:267:44e6:11d6 with SMTP id d9443c01a7336-29027e5d1efmr77364885ad.6.1759975135842;
        Wed, 08 Oct 2025 18:58:55 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:58:55 -0700 (PDT)
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
Subject: [PATCH v2 12/18] riscv: mm: Expose all page table bits to assembly code
Date: Wed,  8 Oct 2025 18:57:48 -0700
Message-ID: <20251009015839.3460231-13-samuel.holland@sifive.com>
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

pgtable-32.h and pgtable-64.h are not usable by assembly code files, so
move all page table field definitions to pgtable-bits.h. This allows
handling more complex PTE transformations in out-of-line assembly code.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/include/asm/pgtable-32.h   | 11 -------
 arch/riscv/include/asm/pgtable-64.h   | 30 -------------------
 arch/riscv/include/asm/pgtable-bits.h | 42 +++++++++++++++++++++++++--
 3 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index 90ef35a7c1a52..eb556ab95732d 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -17,17 +17,6 @@
 
 #define MAX_POSSIBLE_PHYSMEM_BITS 34
 
-/*
- * rv32 PTE format:
- * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
- *       PFN      reserved for SW   D   A   G   U   X   W   R   V
- */
-#define _PAGE_PFN_MASK  GENMASK(31, 10)
-
-#define _PAGE_NOCACHE		0
-#define _PAGE_IO		0
-#define _PAGE_MTMASK		0
-
 #define ALT_FIXUP_MT(_val)
 #define ALT_UNFIX_MT(_val)
 
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 5531752b608e4..60c2615e46724 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -68,20 +68,6 @@ typedef struct {
 #define __pmd(x)        ((pmd_t) { (x) })
 #define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
 
-/*
- * rv64 PTE format:
- * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
- *   N      MT     RSV    PFN      reserved for SW   D   A   G   U   X   W   R   V
- */
-#define _PAGE_PFN_MASK  GENMASK(53, 10)
-
-/*
- * [63] Svnapot definitions:
- * 0 Svnapot disabled
- * 1 Svnapot enabled
- */
-#define _PAGE_NAPOT_SHIFT	63
-#define _PAGE_NAPOT		BIT(_PAGE_NAPOT_SHIFT)
 /*
  * Only 64KB (order 4) napot ptes supported.
  */
@@ -111,18 +97,6 @@ enum napot_cont_order {
 
 #if defined(CONFIG_RISCV_ISA_SVPBMT) || defined(CONFIG_ERRATA_THEAD_MAE)
 
-/*
- * [62:61] Svpbmt Memory Type definitions:
- *
- *  00 - PMA    Normal Cacheable, No change to implied PMA memory type
- *  01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
- *  10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
- *  11 - Rsvd   Reserved for future standard use
- */
-#define _PAGE_NOCACHE		(1UL << 61)
-#define _PAGE_IO		(2UL << 61)
-#define _PAGE_MTMASK		(3UL << 61)
-
 /*
  * ALT_FIXUP_MT
  *
@@ -174,10 +148,6 @@ enum napot_cont_order {
 
 #else
 
-#define _PAGE_NOCACHE		0
-#define _PAGE_IO		0
-#define _PAGE_MTMASK		0
-
 #define ALT_FIXUP_MT(_val)
 
 #endif /* CONFIG_RISCV_ISA_SVPBMT || CONFIG_ERRATA_THEAD_MAE */
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index 179bd4afece46..18c50cbd78bf5 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -6,6 +6,16 @@
 #ifndef _ASM_RISCV_PGTABLE_BITS_H
 #define _ASM_RISCV_PGTABLE_BITS_H
 
+/*
+ * rv32 PTE format:
+ * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
+ *       PFN      reserved for SW   D   A   G   U   X   W   R   V
+ *
+ * rv64 PTE format:
+ * | 63 | 62 61 | 60 54 | 53 10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
+ *   N      MT     RSV     PFN    reserved for SW   D   A   G   U   X   W   R   V
+ */
+
 #define _PAGE_ACCESSED_OFFSET 6
 
 #define _PAGE_PRESENT   (1 << 0)
@@ -21,6 +31,36 @@
 #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
 #define _PAGE_TABLE     _PAGE_PRESENT
 
+#define _PAGE_PFN_SHIFT		10
+#ifdef CONFIG_64BIT
+#define _PAGE_PFN_MASK		GENMASK(53, 10)
+#else
+#define _PAGE_PFN_MASK		GENMASK(31, 10)
+#endif /* CONFIG_64BIT */
+
+#if defined(CONFIG_RISCV_ISA_SVPBMT) || defined(CONFIG_ERRATA_THEAD_MAE)
+/*
+ * [62:61] Svpbmt Memory Type definitions:
+ *
+ *  00 - PMA    Normal Cacheable, No change to implied PMA memory type
+ *  01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
+ *  10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
+ *  11 - Rsvd   Reserved for future standard use
+ */
+#define _PAGE_NOCACHE		(UL(1) << 61)
+#define _PAGE_IO		(UL(2) << 61)
+#define _PAGE_MTMASK		(UL(3) << 61)
+#else
+#define _PAGE_NOCACHE		0
+#define _PAGE_IO		0
+#define _PAGE_MTMASK		0
+#endif /* CONFIG_RISCV_ISA_SVPBMT || CONFIG_ERRATA_THEAD_MAE */
+
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+#define _PAGE_NAPOT_SHIFT	63
+#define _PAGE_NAPOT		BIT(_PAGE_NAPOT_SHIFT)
+#endif /* CONFIG_RISCV_ISA_SVNAPOT */
+
 /*
  * _PAGE_PROT_NONE is set on not-present pages (and ignored by the hardware) to
  * distinguish them from swapped out pages
@@ -30,8 +70,6 @@
 /* Used for swap PTEs only. */
 #define _PAGE_SWP_EXCLUSIVE _PAGE_ACCESSED
 
-#define _PAGE_PFN_SHIFT 10
-
 /*
  * when all of R/W/X are zero, the PTE is a pointer to the next level
  * of the page table; otherwise, it is a leaf PTE.
-- 
2.47.2


