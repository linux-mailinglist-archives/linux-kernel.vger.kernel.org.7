Return-Path: <linux-kernel+bounces-866001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA67DBFE912
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2CA3A9E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0808314B63;
	Wed, 22 Oct 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="M2UxPvze"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85CD308F05
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761175802; cv=none; b=LoD3+MmuEGZdGf3LLIAVdXVOhiyEhBekshbhc7Dmz5R8vs5cjUOJaEHYKDuplMgTmi7F54u+xlbZj0qITZ2AIxZa57HGjwCi1PBkX+l+0azQhxigNRM66vxTQN/7HM7dd98gock6Bi+ey+eVFfKqn5SscS1cPhJVy1s/ZIgBe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761175802; c=relaxed/simple;
	bh=zG1PvbsubgVB7UstpLjRtN915FxsRLFbcnYegAn0YwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YYoigiPVDL1UH/o8FXVeLjWzZcu0Y1yBrip9UHDyTNTVkSr+e8LbKMUWEhqjgp5/3WCZqKt9tyDjXKwRKOlEFnYrIbPMqH+OobRbcxDb832dfyHN1gLDBNqWcaMdDSgeR46K0sIIXF8daffM0qb/rslBvFQTpUXO5vXFm9hLneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=M2UxPvze; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a2754a7f6aso195316b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761175798; x=1761780598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=M2UxPvzegW3UPK/kr7EBb5sfb5uGoRtVl8ZR00l90MpRTixwQoliSU4QsSj9dw2W+Y
         9IN3rSNurecjXegjivtbb3gee2rLapdljOmuonXwztrzXzqLLUfT3ZnGQqhm6n3JKqDx
         4PwYydxrapXsGIq2ZNXFiuYsneSp3ZYKmc880evAKqPqxYqfidtsXk+CTPfgbQ9pQMiD
         LaaZu4VAM6/xCqvc89wkbrmnsDxDuV9juq6RyGMTwMjV4Zb7n6/gaaXbC/sVyumPIDDU
         +BJlTJ53vJzrjJo0IMoQMSOnRUfoqhZuEqLGivdFWYswa8ka0Jbtk3r6TW61etb7rMFF
         od/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761175798; x=1761780598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=S7JzO1nAtefFRbdYqWmkkipPGN2KUGrICW6thl5kyCt46ddcNPqn69XXCglfn7Fq2k
         esvuPgvW2zyUicA6PCj6ocstRRzQYWAUMqj/QdYp0Rjj3Gh6XWSSjaR2OEg2Lebi4lmM
         MAIYSpMKIJO7AeHa7PB/lVVr0KQDp/3Ph6pQdA98HNfDoxSU2CDn/J6ItV9XM+ho4AOj
         VWLNG9lJ3kb0xc+1Bc3ZaE56wAdjj1+1eGqX/dpEvsxddSEigpTtdbRG+FygioHnPsih
         t++/9WbOw0H5weherBKMEl2Ls26qrMehUDJSJplDRponYYiy89lCN6SA7X6dVcXXMJAV
         tu4Q==
X-Gm-Message-State: AOJu0Yw4rbGMelT88bxlaNAEu9N3Y8TwYt3ZDWWXjjdxFD8ifQe/uycx
	4eVFPwkYxSNNHlfJL+aWbeUJkVdsbk9PLtSsE22ltFRdqXFmMRog55vSgZ7iVVJU9yI=
X-Gm-Gg: ASbGncvuEU2g8yuVk5jqU+ABSpygmzs54U1CQHkncCm4CuFavvTBLGRki7j5Jt69WPB
	jHJfxEnMQdAu7BGm7RnxXc7BCZX4GJs/3tFy8SOX4Re6Uy++BmDLiUqd1tvj/Y0a8+FIdZ4e5Q6
	jno5Lerk93RpCmJbebqemU3hi6GzNPhWWSv1X7JLLZ5yVhCQoZmWvrGx5dA4gq+Nd82PW8BT0Wh
	IKo7XMwAAurxf0XWRzfMlHHTBp+7nn2zonuUrO0bf5pmNryRd/Knh/VYDyUI8Ge9PluCoGPDoyK
	cRuLklItCL3/ijD9gU7CPdXup5WxmBhntVpcK1cn5k18FCHv9RFPAK4WM2bgAe0GRt/rCtMXoMF
	vlpBA8YImE0O8T/x91OTxYNp4Fc5fe7KEsBdY7NewnMZcNQIU9Ci/Gb1O5aON45h4Q7SA9Nh1dJ
	5PaNOYHz6Y2w==
X-Google-Smtp-Source: AGHT+IGvZf6To3hIDIuPP1h5aY9xKK3vy32PO8rqsycDPXi+APixSYDQ01ElkQxBZ+x0aZsdxcUr1A==
X-Received: by 2002:a05:6a00:6f8c:b0:7a2:6519:f90c with SMTP id d2e1a72fcca58-7a26519fb7fmr4281251b3a.1.1761175797589;
        Wed, 22 Oct 2025 16:29:57 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc12b2sm392646b3a.67.2025.10.22.16.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:29:57 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 22 Oct 2025 16:29:35 -0700
Subject: [PATCH v22 09/28] riscv/mm: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-v5_user_cfi_series-v22-9-fdaa7e4022aa@rivosinc.com>
References: <20251022-v5_user_cfi_series-v22-0-fdaa7e4022aa@rivosinc.com>
In-Reply-To: <20251022-v5_user_cfi_series-v22-0-fdaa7e4022aa@rivosinc.com>
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

`fork` implements copy on write (COW) by making pages readonly in child
and parent both.

ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
Assumption is that page is readable and on fault copy on write happens.

To implement COW on shadow stack pages, clearing up W bit makes them XWR =
000. This will result in wrong PTE setting which says no perms but V=1 and
PFN field pointing to final page. Instead desired behavior is to turn it
into a readable page, take an access (load/store) fault on sspush/sspop
(shadow stack) and then perform COW on such pages. This way regular reads
would still be allowed and not lead to COW maintaining current behavior
of COW on non-shadow stack but writeable memory.

On the other hand it doesn't interfere with existing COW for read-write
memory. Assumption is always that _PAGE_READ must have been set and thus
setting _PAGE_READ is harmless.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index b03e8f85221f..df4a04b64944 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -415,7 +415,7 @@ static inline int pte_special(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -611,7 +611,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pte_t *ptep)
 {
-	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
+	pte_t read_pte = READ_ONCE(*ptep);
+	/*
+	 * ptep_set_wrprotect can be called for shadow stack ranges too.
+	 * shadow stack memory is XWR = 010 and thus clearing _PAGE_WRITE will lead to
+	 * encoding 000b which is wrong encoding with V = 1. This should lead to page fault
+	 * but we dont want this wrong configuration to be set in page tables.
+	 */
+	atomic_long_set((atomic_long_t *)ptep,
+			((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE) | _PAGE_READ));
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH

-- 
2.43.0


