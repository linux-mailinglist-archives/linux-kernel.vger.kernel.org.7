Return-Path: <linux-kernel+bounces-752691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E413B17994
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDB61C80520
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D406286435;
	Thu, 31 Jul 2025 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="esi24A8t"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382F3285C84
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003987; cv=none; b=HFJI0iD/kmewkb6b7kiCtGh5p1AWHQzelF2W8zSDQUtGH4RwuaodX8jFwcz982+zhf6eXp39j7q/llIo03uGiPJAvWiQx1Wsn0PIi2JMoHruXDCeejda/TxSl/dVcNtv4GMixqCQ+v7dz27RjrboE75VUW3iob6RpFeniEiEtTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003987; c=relaxed/simple;
	bh=WL15EkC9r/moKkRq13zdFyUaooKGHVsvH33BXrA8W6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svUltcIhabFPmuaQy0jnoX0KSHzi8cMK6bvvg+hbSp78EU3uUhDJLG4Ff4PbQjvvUCBrodud9QZXOJacsN9/dDReZIFbyerlMAGyPC1i/FyY0vP69mQkbfSXsJjIzVDTw5GlXm0Ki8s7RepyTPFT241sdImSO3/caR/zC6rrOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=esi24A8t; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b3226307787so244575a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1754003986; x=1754608786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcQNf+l7CrEDLiT/8fKsbXFpHxmlSwLjUqKyq0Di2lQ=;
        b=esi24A8tVgRD0pOnIj8jJVuAI6SgYQwP+JlH84xUA+gHuQHHeW2HkukfDfvqKDPsen
         ejS8inY1Q82nIrFpRYa4oPs80PXUlvZaDEiQjdign8EPmK9dyqYN/AStZ4oNH5OCklI+
         6NSf6Sqescc4mnPWZjtddFnbMsS/3AJASmG/P83UHFt2CKN/n8olvWD5wllMa4RCLBGJ
         wkI1ozP+QQf/V+Abxjy1JMQVsJsSa3K9LIivIhxYNpz4FfS81ffcMcIs6Jg/QVsvGJdX
         uqeGPoIyxZ9bkrhJWtJJUi8EBpoAu0L4xxnqT3G14eTGA8E20f54F8p+6CSE6r8oTMVJ
         ZuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754003986; x=1754608786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcQNf+l7CrEDLiT/8fKsbXFpHxmlSwLjUqKyq0Di2lQ=;
        b=e+TGsNv5fuxqs13rxgL2Xsy0hmW5xLo9YtromI1kD9wrNZ0JGfG8jD5CR++n7K2YSK
         YsVpfxhlO5eFzZOYmCKeBA6Vw3OAp+S4fgf+hcuX2nZ6fONFMXE+LAIbFP7X9Vr/BVOn
         hsPm8O1ygSBbPwO9QFqFy/ZRH2GEICyWlpUlHWrkTC2v6Sz44w8SQd8hKLowjG387X1b
         SoM7O9DZpK2XhxF7v2IXGGQBx2aa5pD1pvYxIOwg8XQPwy5TXMCN+xiKIMwmszs8Kuz6
         Hv8bb0NisEo2decvGGaqoW3iKV7rDUdTjGb2g2+oM+hmHblZLjmG71Yum6p19yq5nUYy
         jpUw==
X-Gm-Message-State: AOJu0Yzg7xKscdOH650NDK2oMtxGnRfDpikT/+k7LOl1XzBONxAPVEdq
	mBaerm/0aTQVcW+uAigmXSf5lmjLzADic9SYAo6fnX8TUWllpVlZHZlLjRFJmTB8deI=
X-Gm-Gg: ASbGncsC9i28gYKo9d6JP2HhOJrY0ujK9BRa4eAAsVZD3AeK/js1Pasl1XerNOfljne
	46VHjrzASrgmYTofcJd0ejq2gyaoIh7++gPELoco7RhItfPfvsHvdxhaMPtGTCcvYM7WnmK2MNQ
	P/B8I0hTXMM2hK7YT1WitG023hNVlE4CDL6PUgjXCzemwSVFfVUJYvFSCtCTsfMKesV7eJ47QJ+
	ZEdudNFl+XNhMcnMEeq9Hpnt+PJVNMNmW3id8tEOwpmnJqVOx12hhF4b38Wv28E6lpztSe1f89/
	9rrrSV8XPhCM6APssRjvbSCowJGWhv2iM+DUT2ASr3oiOk0Uj6wwItHx9VCHkkgh2y44QKggGNb
	3fd3UZ7J5ZdABrBAFMMwe6sGJi54dLeLp
X-Google-Smtp-Source: AGHT+IG8ZrpcBM3q8FKgO6zVDJahKZxTWTdKtWExGJVc83acMzp6RQIhGZEeMfzbTsLImUCGugdoLw==
X-Received: by 2002:a17:902:d547:b0:234:8e78:ce8a with SMTP id d9443c01a7336-24096bfd5e2mr130518645ad.48.1754003985662;
        Thu, 31 Jul 2025 16:19:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da8fcfsm5773085a91.7.2025.07.31.16.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:19:45 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 31 Jul 2025 16:19:19 -0700
Subject: [PATCH v19 09/27] riscv/mm: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-v5_user_cfi_series-v19-9-09b468d7beab@rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
In-Reply-To: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
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
index 2b14c4c08607..f04f3da881c9 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -421,7 +421,7 @@ static inline int pte_devmap(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -622,7 +622,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
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


