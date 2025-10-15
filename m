Return-Path: <linux-kernel+bounces-855048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4112FBE00B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBB719C84AB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D243B34164E;
	Wed, 15 Oct 2025 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Exwb/QXP"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925C6340D9F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552041; cv=none; b=VhYiYGxP5XYkjU1MTeV5u+rKi31y1CYb16ZLrmlPfg3yckwE4F0AiENajHXn5smJ0+ecLH8E5Oe7rl1iaEcsqq0+9dtJl4HMjCIjy55Hg/JdQSl52jkRp4HrDlyDPARHy7Dus+3lLiTdZebvXM5DQeMx80y8nwsquSZdjr8eth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552041; c=relaxed/simple;
	bh=9AtWvDKQ9q5op9YLRgkrDiWaHEAhrRbEgloHu05lQww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKr+NrSvbvIHQiQvIWIMrzIggtYpdFeML8hXAcDgzkv4SPf2umUkLKeiA4Ke+oEyBYh+dSYM+mMVR7+JCQs+cvZWmEIqGDJrQ/tpFkJONXpD2ecBzFcezbFdBnNTa12w9/SgXlFIdX99sTvhzp82PL5KSvIAPubXFExJX4hvArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Exwb/QXP; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b62e7221351so5671521a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552039; x=1761156839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=Exwb/QXPbXfTOGKP7tu8Nf+GnckXTCgO3BYpd7Cp6ZZmF4JBSu7v65V7OQg5628JQh
         mrfP5+WbGWFkv8usSO0tOTQksriHHmb5tatsmPN/qWRpuZ0rZBv2ZNzgaURgJ9O8asIX
         oQqa59/xel+mVz/UP9DgoS3liRs8q3sI8sr8vud2xzFq2GZ9oWJnBa1+Jmj2LCarrFrw
         +H+ZAu3u2G7oy0u/rAi7yXtNm/xumj99wekv3M6e1Fc7YewqajUcJClxNcSqenB0HZU2
         pWYCRNiKDBePIm4hyRYQMOTlANSE8cU3pE8w8EKAQ13buypysM+OTiB333atTIkCOS2O
         Smgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552039; x=1761156839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=mbwLPydt45obCrR4j+4m28fyCNsyf/sJJb7FussvH1QEt/tIqmLscznkXcWy05M+Y+
         moplCkG4Og+Yi5GLZ4HnUKaR/z3ZZzCp40oEUS3ExgWyH6hVvQbApyzldiNADvzaSY5R
         D3DJLct3eCig4nwYnaCUrbdvvhSCJk+ovF0Z5uS9XFF5CX6xRa1pPbw87X0YrddR+H2j
         lO/LiIinQ9gkX9zmNozNJhneYNkVAX8vj55nwfOw895njDQO3QfuPS5nz5DjNR96pJD2
         9zv+gk0SCnRGJh+dMMHVJK4JOEFGD7o6lVEIsK7xru8tO9C3Q/UHTUweAp5S5EWj2YVw
         2wFQ==
X-Gm-Message-State: AOJu0YyERqvZQsEYuer31WQrMoviJa75txWiJ9v/7gy5pjrAUw+abOXE
	01CQQv5HIaq0tWuDfQLIlnIwIopmSDkZ/WEBtSTT2dboFX3YE9uDtcB7C70lrPsNXfs=
X-Gm-Gg: ASbGncsZNpucpwpwxFcySXPKsGVCx2s8x3T2WeeqEqs6zSglYZ2XvZpc/jwHuUGedBr
	yyTXDnXKcZp7lWdsLjNkTGCoUQesdHs4W9bwyv8RNOAqC0D34con/zWnoTmNXI5v+4grjJfiJAQ
	RPSdKSrrTWoNCdxwthdHn+mORab6CbuLsYfxjp+rnb4rD+W6KlChJGlIOGKIOrh7n2N/rB+21KE
	GG7tWUQjfBcyfIV437VhqLxFtFYna3Ma+9HquQdCS90+zUJu9erDR8x5xQKaCFV7XFaFFO6OdqF
	8znZMujVVkvwidpLIuEVWdMYrPcw9YvS8qcO36xxTNIiJJES9gwp+524fZxv3k8dkf4uGIgxIiW
	CsyERyEytvqJ9tFJJ599FGUaRmhRpc0o3wBc+sSj+KzMhpG5XHQI=
X-Google-Smtp-Source: AGHT+IF7+0siZoxu9qB67nOXjy9vTyzrCE83G46axDJgPfnYJq92ADj9EdTAyl+KZI2DWODagqgyog==
X-Received: by 2002:a17:902:e786:b0:26e:7468:8a99 with SMTP id d9443c01a7336-290272c18e1mr357750345ad.36.1760552038791;
        Wed, 15 Oct 2025 11:13:58 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:13:58 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:39 -0700
Subject: [PATCH v21 07/28] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-7-6a07856e90e7@rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
In-Reply-To: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4c4057a2550e..e4eb4657e1b6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -425,6 +425,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -765,6 +770,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
+{
+	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));

-- 
2.43.0


