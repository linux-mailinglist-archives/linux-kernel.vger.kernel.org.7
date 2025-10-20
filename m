Return-Path: <linux-kernel+bounces-861703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3DDBF3688
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E51B4F7B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B2C334C06;
	Mon, 20 Oct 2025 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="XPP/CeFm"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00356333750
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991775; cv=none; b=EwBKgvLh/23u4yZ/Oj4orG2hCXy7EyV7PFglUom0VXC7DgLoOuJw6khl821OTNtS/mFpEa/hOg6o+nAWIIi1eCb/8W+v/umhNLeS1yisTH1XSwmDWhjYs28qPF5a8xBtjtUZoh+rCC43Fxw0yyccGg3h/z0kNZ5pqUX0LWMcI7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991775; c=relaxed/simple;
	bh=w8K8YWqvQ+k+ul0JfJs7USW+kWSgKZqY/8VTLLDGvdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i+5Ay8M3QP6ck+FWwS8I1xupWRxHVZ2aYk0vUZoIMReoFI/Q9SMtrkBbwJYaEckPksBlr5QsMLtbUOGkLl4MgvVr/RC01LCnN9ELj23wZySFhfGGP2zDeHxAz5eoFerLxdKI+mxgQt1OLtbXQ6Ka/kpUpm2u2A99WJFf7rCakwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=XPP/CeFm; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4338028b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760991773; x=1761596573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRwldBzHIQH4g/MXesqTddRa2wH3mKxscowbsdJ3rFs=;
        b=XPP/CeFm0Hi/WJJwiw1rXrmau3NkKsOl0GHaqNM+IKyIRfn4NJjHR/qC0HdV4s0MID
         N5d3YzGxOLBfFKGCa3ZGtVRFW7qk8TnpAjyDIPgZ95xkYyIDqIjSpJ91BW1hr+w0/KSc
         D0WUSYcp8ia/IqXMb6TPEFKmOYHLUelS5PYS+wxl+PI+NSn4Fm4bp31wAFf3bUweXNvF
         SUR52RUPQtOXcnimFzgrqyfSDsb8IWenem9VLjxK74NE+gq/s93daxbURM0JrNBpXhDq
         yqOG4/oUnSpg6bYynqaf19nqVIj6oGt+weNS3mkJFj9USHlG3UPsOWMnIcIPrKqWNJq5
         +pWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991773; x=1761596573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRwldBzHIQH4g/MXesqTddRa2wH3mKxscowbsdJ3rFs=;
        b=GWQ7KQSzLplG9Cgfwk7JZuhSFX1DMVzn3q4UnslVYhGZ/8CaSwb2wfvRvg9LPb1Ysk
         VCGrTfa/wXjz6FVWIBYxiwuD8WAcEZLz7mOkOE3gx8RT58iiskspbJrDUpnmmRlExex3
         OFOMISeAb8mLHk/Dn+X07SWdFI5+onoGMWajgjyUCA6im95huUwsWvz83bABTi6IrvPw
         q5s7NIgm64lnuyB/WvgsY7srklWIaiDj7QfzSBcBr+4P+s3OWEqa7XkXOM4xSCwmanbS
         CO0EM/lHyfalLHodoRCdzhGM5myIXgr2gjtpzctNRtfq60DuAIUCMd0VbZg14LdmiYcf
         bx6Q==
X-Gm-Message-State: AOJu0YwvqDGnRJs4oRDqQucz+8S9xJMj5XJ26hQWqnCWCcQZ2H7TCW53
	71HVeGSqwyMbPylKEtOZHkrcQJS0nj8/AbK/PkHH8mkJhvu5V04BWIBEbnG8XItANnQ=
X-Gm-Gg: ASbGncvGdmiopSI34+UATGsd6UfU0YtOu6J0jxKGQPiGz8ywRj/vED3U/X/LxsOUaGD
	eP6o7+7aL0/xKd//8/VswBDe8+CvfWCrPat0xNUYS/qcxybTFKQtAvf5T/BBFarPpu183er405a
	Hh1D0i0XjLfeXqnFTseyQKp69KFuM9Qg6qu/ofiW+S4f9NsyrzWC/mzOa1PAYpKPWZO11AQh/OH
	EL42Ujs0XoIfF5gV5eFhCl6OJKUGcETUuvYVSJqEzp7HHCb3hlyf11BySkNbB5Tp0c5CoYacugx
	7oqG5kJL/7hDtOdhZdjYw0Enntx97bEvYXpXc/5rrT2etcmci3jSBLlxgRtZO3tCdt5bNBva07f
	8+C3C8m8+xaDk0Olqc3fGoUqaHzjnK0eXosB3PYxGntJTTH6NhiiLdt9ccrPtuVMoq4eFkej/DE
	uMiEKllQujpA==
X-Google-Smtp-Source: AGHT+IEWBLf7wq6f3FV6257yUouPbLkY/Mk/oWHqmnpiJ0fcsMsMtz1kgTZV512lCf/qTagDTur4QA==
X-Received: by 2002:a05:6a20:9148:b0:2be:8ead:1bec with SMTP id adf61e73a8af0-33495e6781fmr24121585637.24.1760991773177;
        Mon, 20 Oct 2025 13:22:53 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a766745dasm8443240a12.14.2025.10.20.13.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:22:52 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 20 Oct 2025 13:22:36 -0700
Subject: [PATCH v22 07/28] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-v5_user_cfi_series-v22-7-66732256ad8f@rivosinc.com>
References: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
In-Reply-To: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
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
2.45.0


