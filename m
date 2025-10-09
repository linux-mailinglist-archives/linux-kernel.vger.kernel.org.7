Return-Path: <linux-kernel+bounces-846149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53897BC7292
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764893E3DAB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F6B1F130A;
	Thu,  9 Oct 2025 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dy8UtTad"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FCF19D07A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975138; cv=none; b=h7fjcuvPShvSPp3X5vIyhmoJFUSgUkcczE3t2zY7DUoxE2LuMAlgZjHpI4ICcqTOzQYMqQAXyCQhm2Utgyzyewnv/Wg+nKpyamt3p+93owyoeUfBOhPeIc1viMRW4YL+3dzNh7brTB2Q25GDZSzrFRRTbheVI8+sRRYeaL4my60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975138; c=relaxed/simple;
	bh=qz9bk1u6iDBGKd2foT2PRUb6ijZpGxNdXBiAeqzx1Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyhbtoYtC7BFPVSQS2xL+uL2Zs7eUNFk9qb1bbSHc0aWeb34ixa/88r8gxwrW/uU/Jvl6Sbkun0AiQq+C1QP5sWn13LLoyPE7JmyrXZ4AaTpu/AGlhwlAuBNk1LQW9Vlq9XIRBRXo2U6w6xFSFyukk1aPcWEdoNEnVeif1Fb6pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dy8UtTad; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-273a0aeed57so19490345ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975132; x=1760579932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQzFW213rLwxUVwSIOmReg2LsoZscZFNSwvkZCWkhKs=;
        b=dy8UtTadLbxKLPOkThV/2iI4OIwYV9uaEmmJYJ8JSZeA/aHQ5Ez9q5cFy3OWHH90fR
         Ub/jzRHJtxtY/nenRydA8wGBL/rJj2ro2guu9bvyniLebceLGaTG3tegB82Aig4C+IEY
         C/9ibKMpDLrE9sHRUKRWu9U/IVPlEMZqZ92Nfj8/lnnym6LhBhJr7AJrNkEdCV9w2zxy
         GPUwpGGFj7pHYtL5vqgOJ/e0UvxhkN5cXVExvfH8Taqcp23DKPsfnFEjQM4qCl/krO4G
         xKrs+SgNTaTmcm2Zdxk6qts6ofzsNb0w8/zsr/SqqyZuEGslU/gNWYxAFGfRQB5PjWNJ
         tC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975132; x=1760579932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQzFW213rLwxUVwSIOmReg2LsoZscZFNSwvkZCWkhKs=;
        b=h9shtXwpfr2HMJd6kDLLXTIFqwJVay9Bsc0J9bnQrrllZuJJ1hN7Ipi4uBkcvuY0tE
         3ypYKbU2hIZieV+XvmrNBtloziWFdxhA7JrUEMOOxKhQYdxAWCjmee5TecWx55alyJgr
         MM/uk0BX+UsKb97Aa3NGMt0f/EV6C77XM4qlQJk/dugkwdgWrUkTgLPN9S88yrppLAgJ
         3r3nCIZLIkorN/z8Z0Bznv8nT0BIZEhjBrlYAaapE688czNMCFMIU1xSdJruheSRKfGF
         yNOL0uYFBnU+iuw1v+76GYWtf84KAGx6h2T8PB6edgvq6iqW750BniswJvCTISrFJkcK
         QJcA==
X-Forwarded-Encrypted: i=1; AJvYcCWJK+MERaSU2j1hNfOdQUx8jVcF98c44K6xn9Ob2/ynJVIMc2LmGoSnMmoD6g0TIjy2+aZvTLT3otWF+g0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3R2Sl2hT2AV6xyh6BS5DHvNKQshlwXtcK9PlcIWEkQNBJCT3n
	P8J/YC40A6aIgQoUHk/cnVQdIqRYf4LRu2f38uujRuveWcoRy7MDPrJXyJJ0sfwduUA=
X-Gm-Gg: ASbGncvuJOrny5wEt3xlDWE/vOt4itvvz+TlBjH86cSg/lrmPpQTU1nnU+1cWQxBiK/
	kMr6yiOMk7xDLZbIh98aqXzndwt/+GYh39+SeeLcpncwAijcx8Z9Coej7104FzFjJmYry5V54xj
	psGX1oE0XrYraEmT8X68ZmwdHzVr7UGDS7CaZx49FMKV6UsJuXE3eRvaAKVDgEgDkMNsrK1N92g
	2Did6+kF3nHCR/U4scyRq9sfmUWNOa9DEC/9n60GU1F4zTBjewSHTw08fVqqGEhq6912D7eQ/J6
	3xiItOnJHN9lrOcSt6K0KwrjT5tKsZVNYBpRvI0I7HCa5QW9v48omh2Ef2RFtwXujCykREbVmpw
	rt3jlgqdVKHyVBrGx9SgwAZYjyPcz3A6tUJ1UHMZLEsfPdX202vLJl4JQWXXSIQnxDtoU
X-Google-Smtp-Source: AGHT+IFM9Uy17P2+rIA5+/u+UBcAfOioBDn47CFCZ3Wn+HT4qk9AYA0AUJYNGbTh1SkHtKAVK04UZA==
X-Received: by 2002:a17:902:f788:b0:274:506d:7fcc with SMTP id d9443c01a7336-28ec9c0c7e1mr134257655ad.6.1759975132141;
        Wed, 08 Oct 2025 18:58:52 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:58:51 -0700 (PDT)
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
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 09/18] riscv: mm: Deduplicate _PAGE_CHG_MASK definition
Date: Wed,  8 Oct 2025 18:57:45 -0700
Message-ID: <20251009015839.3460231-10-samuel.holland@sifive.com>
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

The two existing definitions are equivalent because _PAGE_MTMASK is
defined as 0 on riscv32.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/include/asm/pgtable-32.h | 5 -----
 arch/riscv/include/asm/pgtable-64.h | 7 -------
 arch/riscv/include/asm/pgtable.h    | 6 ++++++
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index 00f3369570a83..fa6c87015c480 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -28,11 +28,6 @@
 #define _PAGE_IO		0
 #define _PAGE_MTMASK		0
 
-/* Set of bits to preserve across pte_modify() */
-#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
-					  _PAGE_WRITE | _PAGE_EXEC |	\
-					  _PAGE_USER | _PAGE_GLOBAL))
-
 static const __maybe_unused int pgtable_l4_enabled;
 static const __maybe_unused int pgtable_l5_enabled;
 
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 7eb23c24310f9..d17382c0fbe59 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -66,7 +66,6 @@ typedef struct {
 
 #define pmd_val(x)      ((x).pmd)
 #define __pmd(x)        ((pmd_t) { (x) })
-
 #define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
 
 /*
@@ -166,12 +165,6 @@ static inline u64 riscv_page_io(void)
 #define _PAGE_IO		riscv_page_io()
 #define _PAGE_MTMASK		riscv_page_mtmask()
 
-/* Set of bits to preserve across pte_modify() */
-#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
-					  _PAGE_WRITE | _PAGE_EXEC |	\
-					  _PAGE_USER | _PAGE_GLOBAL |	\
-					  _PAGE_MTMASK))
-
 static inline int pud_present(pud_t pud)
 {
 	return (pud_val(pud) & _PAGE_PRESENT);
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 2bc89e36406da..61de71a8ba978 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -206,6 +206,12 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
 #define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
 #define PAGE_KERNEL_IO		__pgprot(_PAGE_IOREMAP)
 
+/* Set of bits to preserve across pte_modify() */
+#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
+					  _PAGE_WRITE | _PAGE_EXEC |	\
+					  _PAGE_USER | _PAGE_GLOBAL |	\
+					  _PAGE_MTMASK))
+
 extern pgd_t swapper_pg_dir[];
 extern pgd_t trampoline_pg_dir[];
 extern pgd_t early_pg_dir[];
-- 
2.47.2


