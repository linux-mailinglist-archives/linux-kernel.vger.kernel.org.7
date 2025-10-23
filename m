Return-Path: <linux-kernel+bounces-867029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0640BC0168C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB5E1A64C7D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3981932E748;
	Thu, 23 Oct 2025 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="SnypopXr"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E732D42C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225955; cv=none; b=RiKzyGgg/25VcbxQLNNfTUF1imboMEjGYRugqFFYJjje4dIK6PXreIlCTvkbKjkcsDRCz8Ix6lip0mTvVM42wfGxZJL1FPrCemHgeqRXeXz7E2/RpIj1q9kZdc/I23ZbtzzMqZqnKspF+nSUS0ntvmcc5UnRwu7P3bqt1j779DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225955; c=relaxed/simple;
	bh=9AtWvDKQ9q5op9YLRgkrDiWaHEAhrRbEgloHu05lQww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ji8U0m7nK1xodBeN52vTxjUr4neGjcOwsjuTNVH89tnrLQCPA/dF/ik3IwL3WA8YO32oNOSgk9ejCC6uoLWyPxR1g6BCxRXrdWLHtqFxdO3Qe6loSQnO+uDyuMtpQKP2Iy9EeCPqZmKqcIyzWKxZfTevfwwlh8CvE4xNEq6IM94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=SnypopXr; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6cdba2663dso570227a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761225953; x=1761830753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=SnypopXrwxGqpv29G0ay1xS0eoIRdmPRzMXorS9Ua6v/UapYGLvKggfr4wIc43ppRz
         3/beOhqiwX015mlBypDUdvrSiTBic7bZfw37c5DI3OxkgFzQ2VLKp1OEa+PYLjRCa1hT
         tgbT/6loawSP9CYoiMzWpZqyil0mXdiAifgL3jciUV+0cKucIA60fj4+Cz/sp+1bwWEN
         VbPRkc03c1pgKcRSuI4PjPWucQvEpjKTy+DYJzLCXcfdl+LjNCp8yL7gy7FJS1FCzXQX
         FLBH4aT4CQWI2bArF6TX+NRiPaXd3fJyzliwmbWVXtGrBrcAZofrNm0SZmh19/Bus7io
         m4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225953; x=1761830753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=VVDd4EeK8CdBEKm6Nfrs65pQwGpJNJVqHlW4CIr2/otjwvXFh8gm8txAqk7UfFfQmo
         OPSuut0SuPx0d2VPDoV45UDXOd1b+KMHNg3nyfkmbOvCda6tcYBaYGyaAchiLH4P4s5t
         z2lIkACy5NtPk65/EgAccwnVPGdTICK0m0mP++usfEYf8vWqZI8h5mcLA8NqkVdQgv3m
         H0WQwTlEpqcC7MnpDCI6AaROGd9u6BlEl2csD7HEYrNAY80r6rxkxrNGSSK8wGdDycWY
         ClHx9ZMAwt011Ea+Tq3SJmRu7JRK0GpaSs951Kza5y/qUZksTCqGYjlhzG31ue1ILz40
         MTPA==
X-Gm-Message-State: AOJu0YxwLIXQl9wq7MRtfbbkXvFb5ixIcCcysQfrSvYdvC17I1LChILO
	ARl7QnXoOBvRsS0mnHkI6qdaSFGKUtck46nVWcSfubcjxoqloiS2adKU3cCnBzRcP/I=
X-Gm-Gg: ASbGncsbVrhgWhZsbg6n52Ekp8+jMPG8KNdtCxEuktQbIc1hznsqlyOw6LHuLId9ZOa
	tlYtkA0hs8TNHB/582gZjZ/pCq6r8udr1bKuFRqK64xT0/BM/GqFGmmVoShyzDy7ATWV/8o8I0g
	8ZsTh2FoNrSvquy5Ou0UxcE0BDNq/9Rc7k73z/JQdkbQ6U9MXfJGW0N9dfBwK/BE5B+CH2V3u29
	gP72z8c44+BqhQeYW5sf7nO2cuE8plkD8m58faYjESQRBqqGs+HFc5ny31XtGDXr7Png0bhqemv
	76qAVTS+Invwr/n4+NNi45Psn+3oHEoWeZMNY0NjcDU4pugRQ3YBmj301/YJd7NHWQH4xx6qZ2p
	wQer1182/5U4TnvmreG2lmio8p8S2rjsDHvS3cmFlQRYAr1bBnYeIMAcira3Q0TIPnN1c9uYWAQ
	oQhtttbD2YB37yrIohwyZl
X-Google-Smtp-Source: AGHT+IGAxsiF712OrLUPQ8MDODIL3Qk5KsmgHC3vsv1nzcwZbCFCIx22kpnWIeS8R2YjMhFzIyCVEQ==
X-Received: by 2002:a17:902:e5cf:b0:290:a32b:9095 with SMTP id d9443c01a7336-290cb7567fdmr344582925ad.54.1761225952677;
        Thu, 23 Oct 2025 06:25:52 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm23432035ad.103.2025.10.23.06.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:25:52 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 23 Oct 2025 06:25:36 -0700
Subject: [PATCH v22 07/28] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-v5_user_cfi_series-v22-7-1d53ce35d8fd@rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
In-Reply-To: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
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


