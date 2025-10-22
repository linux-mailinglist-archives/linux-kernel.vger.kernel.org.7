Return-Path: <linux-kernel+bounces-865998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA7ABFE8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BBA1355AB2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE9330FC1E;
	Wed, 22 Oct 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="cd/ChilA"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB01830C62F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761175796; cv=none; b=nte9IVCAiWPk/I0Gyo9m+4AbRcMdnCzvTiadlORI25/tZqpMAIMfRYrdui1ycuKOnUlxtCzqTH/dl3go2AcsaynMwksD9dhTNAALeNjvx0U7669hio8HiOupJCxK+Bufk9BQU6QMwwObu38h048mmjv62mCo3TUNJYWVFIf5F/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761175796; c=relaxed/simple;
	bh=lpSh/4YF4b6DV2vqO7uhXaAxm8ZQQfhDo9tNU1Zgc2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ckbLYiX+QJ/5E/wuA5xZ9WAgXmp3/o/vezdISMuDAj+p8ov0gEc1nt5VP96xROQeJiSJPy6+KbssW4Gp3IzyyTYy+GnYkH6lqxef0E/79vXt3fVLzio0+P+rPaFsj9BbIqzZQ5a9c4LF7SZoTsP3NVAVZxbhWeD5rnzWK8q3hJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=cd/ChilA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so170367b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761175791; x=1761780591; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZlhaeGyn05OIbis6SfSAIFcz6IbZPi7uJh5910jbDw=;
        b=cd/ChilAw8FyFsxcM0Zu7I0QYin4Jew9AgD/Oy/Jv46KWuAOI4fXSb1rOzvgpPoVF9
         ZPczB8UzvQt7c3u7fsmbDzRwA1cnACNVNNQiIvacOIxhhtSyEnUEdyquLW7tLIe6cnWr
         YDOTTR6s9t6/fO8ylYXDhlcfJFLyaSlPd5d/NFy1FNBJPbsRqOISLoxiZrS0UliCFele
         4NhDQit1/M0pkpSNkAd2B/5N3wR7PJTwB+lINKB5tB/Pzr7RSROqhl8iDsMBbTy01Tbz
         OX+1lyQciQnY0vL9WkynLiDFiH8VesHOJOxpYLKkiNQZMkptibEZbvxWSLAftOI4xiwG
         9ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761175791; x=1761780591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZlhaeGyn05OIbis6SfSAIFcz6IbZPi7uJh5910jbDw=;
        b=f40nvXj349YKW6oadut8FxvwXfUYuQq6b9lTVj3/8Ws9UcQHl0pA4ECv+8VAmrWsIt
         m38uauXxVBhm0fWyBon94sTLv7HNsLBDv6gCDQ2saa3/6hKE14e1SbVRQ5KWNRlSSbvh
         zpBB24X8s3U9H6SH3C4jQQZ9xSR3mOlS6lgkKXCFfW11pXw4K3FuM/61PuRqIzyP0pnr
         vcerRqaakSaTroywvcn3nQ8L2ngjv5llCe7xL/0UFXsc3ebltljDkACTH8TgiCZa+hhB
         3TNt+t0S7TrwQtnkAlpvME01mSV4bK7HRpmZ/HndqylEUYTTa3T+yX8+bgW65gH+oNUE
         pCCw==
X-Gm-Message-State: AOJu0Yxv7j2d3tXBEL2FyMch14qKyRcLsJwua0I644YyQfYFNwCiZq3p
	osn5A0GrAoSCv7No4cwlpRNbLiKOWvivjC4XMQ9b60Y0fScCE43Q9DfumBlAMmexHO4=
X-Gm-Gg: ASbGncuwMC9icMcwI3qNSBOfGY6WEH5uBzsgWG+gD4M5oi3yLzKKLA31uR4sZmKhg8s
	Sudbjt63L7cEq1LtMXM/JbKHvZ7+t953yd0nJ05Au1wIEJxG3JwSVIa9a/+VP2zR5P3a7+aZ/QD
	0DKdCaPRmHf0E0AllkiQ3zeGNdwWUxc3qdQDWlXCNS2WdNWrM5kDFAI8/a4QY+9yZSkdwJwwEau
	dro8R2ojCxNNbawFDZcMbmSgqhVbu+vUbC8Rm9W8ZsYA2r/aDDAgbsrepo/B6wEyl369EF9u78N
	okB27aIp0jHOIQq/5KtATrMz/EeDnbVYwcuapB0ug3g2drDtL/oTo4tN9eNgTH9gHL76v0+DHqc
	a41+yJOB5JbIORvkZANj7T0QYI5RAhuCMjufKHoF6560HaRtv0PjMho/AqGiNxWrjK8m7C3JwkX
	HtjZjNcOcVNw==
X-Google-Smtp-Source: AGHT+IG4cbiBVjJNCgBYLEYEdqajOum54aXNq+CrIlTed76CQmY277uQptUVhs68Tc/ubzYSOTYfdg==
X-Received: by 2002:a05:6a00:bd11:b0:781:1fa9:151e with SMTP id d2e1a72fcca58-7a2647cb491mr5883654b3a.15.1761175790644;
        Wed, 22 Oct 2025 16:29:50 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc12b2sm392646b3a.67.2025.10.22.16.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:29:50 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 22 Oct 2025 16:29:32 -0700
Subject: [PATCH v22 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ |
 VM_WRITE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-v5_user_cfi_series-v22-6-fdaa7e4022aa@rivosinc.com>
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

`arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
This is to make sure that any existing apps using PROT_WRITE still work.

Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
encodings for shadow stack. Above changes ensure that existing apps
continue to work because underneath kernel will be picking
`protection_map[VM_WRITE|VM_READ]` PTE encodings.

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/mman.h    | 26 ++++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/kernel/sys_riscv.c    | 10 ++++++++++
 arch/riscv/mm/init.c             |  2 +-
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
new file mode 100644
index 000000000000..0ad1d19832eb
--- /dev/null
+++ b/arch/riscv/include/asm/mman.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <uapi/asm/mman.h>
+
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+						   unsigned long pkey __always_unused)
+{
+	unsigned long ret = 0;
+
+	/*
+	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
+	 * Only VM_WRITE means shadow stack.
+	 */
+	if (prot & PROT_WRITE)
+		ret = (VM_READ | VM_WRITE);
+	return ret;
+}
+
+#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
+
+#endif /* ! __ASM_MMAN_H__ */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 29e994a9afb6..4c4057a2550e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -182,6 +182,7 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
 #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
 #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
 					 _PAGE_EXEC | _PAGE_WRITE)
+#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
 
 #define PAGE_COPY		PAGE_READ
 #define PAGE_COPY_EXEC		PAGE_READ_EXEC
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 795b2e815ac9..22fc9b3268be 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -7,6 +7,7 @@
 
 #include <linux/syscalls.h>
 #include <asm/cacheflush.h>
+#include <asm-generic/mman-common.h>
 
 static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 			   unsigned long prot, unsigned long flags,
@@ -16,6 +17,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
 		return -EINVAL;
 
+	/*
+	 * If PROT_WRITE is specified then extend that to PROT_READ
+	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
+	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
+	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
+	 */
+	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
+		prot |= PROT_READ;
+
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
 			       offset >> (PAGE_SHIFT - page_shift_offset));
 }
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index d85efe74a4b6..62ab2c7de7c8 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -376,7 +376,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READ,
-	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE]					= PAGE_SHADOWSTACK,
 	[VM_WRITE | VM_READ]				= PAGE_COPY,
 	[VM_EXEC]					= PAGE_EXEC,
 	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,

-- 
2.43.0


