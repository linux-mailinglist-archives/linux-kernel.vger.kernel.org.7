Return-Path: <linux-kernel+bounces-745091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ECCB114BD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B90C07A433A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE3D24A047;
	Thu, 24 Jul 2025 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1ESIE0d8"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349F12475CD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400245; cv=none; b=mhtjKv+ZrotWHDnOUwywbiLl1qsPFn2fgtUm2oNnvkmmTiEB5T73nP3snqvdtaMWy9Hkhn4SYij0nLqxs7m8oxx5Ir6qcsVfU3eE5/uMCvpJvdGiTpToHStLhfVwshcmbiZdcVReXcKOnv5jYOmjyshA7GQzXF+soc/FH0VJkjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400245; c=relaxed/simple;
	bh=EW2PkKQb8PALH7VHtcvoMjflrjhMoi4wOo8ufNW8w7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBJ1LTgA4OsT6nPZ+mxRZ1wuWT8P/CEVXq023zZB397v7LsJvO6gAA+LJjnWUpuYjPiMUgijrrnB8bMliSAO5S5/EiptE3XuwM8uz/6o/O++XIsRTN2eHM1ZWjvJMbWPAj1I+kwW9W3gACN2mP5E3PEhgmI0bZs400UZgcMNML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1ESIE0d8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23c8f179e1bso17967215ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753400243; x=1754005043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pn/2JSdO71rXzNO2stWjtKSzEMWnL5mCAakTnDwVXrM=;
        b=1ESIE0d8zjjkmP0gmA/Sb0x8jTV1sAoTbFKu2nmt+9l+bo158xRmYU3CoxivWZLCHb
         PgIUsW2Mq0wfNkUDNHN++FVUD70CfjmTniqRPHhMNtxBfZo+W8CGoroMJHLZVkFC76D0
         0ODr1M69kerovbB4KaBlmJzYXIuRIYn3AaCyjdWU7JRymcIViesE4aYiwAjJZoMDcEzp
         JM5DSS0HhniKmUg8JKhr1+M8xwIGFTn3OrU3eP6HGqMNZX900rhLLmA5o9huXB3NRK7c
         6WY5bkrfuxYUKmWrRxTMPCs4BSEDqSlBYbKQlC+5P7FYcfIOYbslQaYFvBzuSMQ4mhOC
         SKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753400243; x=1754005043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pn/2JSdO71rXzNO2stWjtKSzEMWnL5mCAakTnDwVXrM=;
        b=disF2FE/vaxZ1yrrTS3UweN89El0jDFS99JpEhuTt/V/xWLPozDw/qeYfHmG2dbO79
         rx0+Sa2G8Y/zSuG0d64FSEKyPyedvyGhVwljt8B2y7WfGzWre9hermTye6pPeDlrJqbr
         08c4rx/emv8HfT+JNt41PA3hjf3+/2dU/Ccuv3aBA7Nkr6vcbbZl9M6l/ynQJBrc7Qr1
         zQhMTWsIeO7pfZu1PeMwYdF7J2ohurnrXHf7j6zUucYzB2cdmGgo4Q3NfxyQTOV9zXi8
         x/lSw3VHewidmSz0E7btuzPDHihVJdQNcsJUKAN8UbZei6+yNTJydoSTgYd1GNkS6Pze
         GOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKEQ5w+ZrErmkY2H6ILRLSHTg3ASli91LPikHIpqRtScPbejUmEqLPE9snGmofC/DwEinLmcGomRF45Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOGZf8qgPWKmENKZUh6feYkpnSRQ5qVMnDRLVIDygvHSZpStRG
	nMcKXbGMczMR6hC3S1AZ40mhXZygWg0YbA02hFwb5MgTDIqSPcB61o2GkNXQ+OtJEh8=
X-Gm-Gg: ASbGncv/oOOcvQpRRp27WyQ/BU1dGvrMGm7FWrndfWqUCU2j/9WnjRbakSwabPZCyz8
	pSB6biNC18ZgMKijL4BJ/E7P16jEBkDLhWG2d8GDgsRaGAuRPrFF8UIof4VRxZs75VO0UMx7XhT
	33Lcc+ttfQgXsdQq6C6GIFOs9PUEURRoCbVPeu6EcN7d+G5lmD2l5Or7v5iaJ1n2u8ArC0Ls3DN
	uS467O1QAYbcBCecrDJeZ7R4EAZb3k+5dbLnjHAUFyTE++TdRwgiTbe4/bpMTNh3Lj+PsjFSpZb
	mTU22Qr0D417zBauxumgK5B3I05LCgzsOPtoZkN5iXyBUl2LFVZZHH+MWi2lSUi5PdLgFP78hqV
	Rnd+YEjU25OxvRq3YI/BfROaT6W7F2aSX
X-Google-Smtp-Source: AGHT+IG/G30hZbdmg+vYLTFJ4nOwJXxTBe4ZWwYMeNmIug6yYy0RZhNu1ZgYT+kQPlkJisfs0XgYFA==
X-Received: by 2002:a17:902:e54e:b0:235:ea29:28e9 with SMTP id d9443c01a7336-23f981b0a15mr141134525ad.38.1753400243473;
        Thu, 24 Jul 2025 16:37:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc706sm23598685ad.106.2025.07.24.16.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 16:37:23 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Jul 2025 16:37:01 -0700
Subject: [PATCH 08/11] riscv/mm: prepare shadow stack for init task
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-riscv_kcfi-v1-8-04b8fa44c98c@rivosinc.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
In-Reply-To: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Monk Chiang <monk.chiang@sifive.com>, 
 Kito Cheng <kito.cheng@sifive.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev, 
 rick.p.edgecombe@intel.com, broonie@kernel.org, cleger@rivosinc.com, 
 samitolvanen@google.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor.dooley@microchip.com, charlie@rivosinc.com, samuel.holland@sifive.com, 
 bjorn@rivosinc.com, fweimer@redhat.com, jeffreyalaw@gmail.com, 
 heinrich.schuchardt@canonical.com, andrew@sifive.com, ved@rivosinc.com, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

With CONFIG_SHADOW_CALL_STACK, shadow call stack goes into data section.
CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK indicates hardware assisted shadow
stack are used. Hardware assisted shadow stack on riscv uses PTE.R=0, PTE.W=1
& PTE.X=0 encodings. Without CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK, shadow stack
for init is placed in data section and thus regular read/write encodings are
applied to it. Although with CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK, they need to
go into different section. This change places it into `.shadowstack` section.
As part of this change early boot code (`setup_vm`), applies appropriate
PTE encodings to shadow call stack for init placed in `.shadowstack`
section.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h     |  4 ++++
 arch/riscv/include/asm/sections.h    | 22 ++++++++++++++++++++++
 arch/riscv/include/asm/thread_info.h | 10 ++++++++--
 arch/riscv/kernel/vmlinux.lds.S      | 12 ++++++++++++
 arch/riscv/mm/init.c                 | 29 ++++++++++++++++++++++-------
 5 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index f04f3da881c9..bb80667d3c13 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -202,6 +202,10 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
 #define PAGE_KERNEL_READ_EXEC	__pgprot((_PAGE_KERNEL & ~_PAGE_WRITE) \
 					 | _PAGE_EXEC)
 
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+#define PAGE_KERNEL_SHADOWSTACK __pgprot(_PAGE_KERNEL & ~(_PAGE_READ | _PAGE_EXEC))
+#endif
+
 #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
 
 #define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
index a393d5035c54..ae7c6fcbaaeb 100644
--- a/arch/riscv/include/asm/sections.h
+++ b/arch/riscv/include/asm/sections.h
@@ -14,6 +14,10 @@ extern char __init_data_begin[], __init_data_end[];
 extern char __init_text_begin[], __init_text_end[];
 extern char __alt_start[], __alt_end[];
 extern char __exittext_begin[], __exittext_end[];
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+extern char __init_shstk_start[], __init_shstk_end[];
+#endif
+extern char __end_srodata[];
 
 static inline bool is_va_kernel_text(uintptr_t va)
 {
@@ -31,4 +35,22 @@ static inline bool is_va_kernel_lm_alias_text(uintptr_t va)
 	return va >= start && va < end;
 }
 
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+static inline bool is_va_init_shadow_stack_early(uintptr_t va)
+{
+	uintptr_t start = (uintptr_t)(kernel_mapping_pa_to_va(__init_shstk_start));
+	uintptr_t end = (uintptr_t)(kernel_mapping_pa_to_va(__init_shstk_end));
+
+	return va >= start && va < end;
+}
+
+static inline bool is_va_init_shadow_stack(uintptr_t va)
+{
+	uintptr_t start = (uintptr_t)(__init_shstk_start);
+	uintptr_t end = (uintptr_t)(__init_shstk_end);
+
+	return va >= start && va < end;
+}
+#endif
+
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index e066f41176ca..5bcc62cf5a0a 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -79,12 +79,18 @@ struct thread_info {
 };
 
 #ifdef CONFIG_SHADOW_CALL_STACK
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
 #define INIT_SCS							\
-	.scs_base	= init_shadow_call_stack,			\
+	.scs_base	= init_shadow_call_stack,	\
+	.scs_sp		= &init_shadow_call_stack[SCS_SIZE / sizeof(long)],
+#else
+#define INIT_SCS							\
+	.scs_base	= init_shadow_call_stack,	\
 	.scs_sp		= init_shadow_call_stack,
+#endif /* CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK */
 #else
 #define INIT_SCS
-#endif
+#endif /* CONFIG_SHADOW_CALL_STACK */
 
 /*
  * macros/functions for gaining access to the thread information structure
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 61bd5ba6680a..e65c0c099ed0 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -129,6 +129,18 @@ SECTIONS
 		*(.srodata*)
 	}
 
+	. = ALIGN(SECTION_ALIGN);
+	__end_srodata = .;
+
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+	.shadowstack : AT(ADDR(.shadowstack) - LOAD_OFFSET){
+		__init_shstk_start = .;
+		KEEP(*(.shadowstack..init))
+		. = __init_shstk_start + PAGE_SIZE;
+		__init_shstk_end = .;
+	}
+#endif
+
 	. = ALIGN(SECTION_ALIGN);
 	_data = .;
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 1af3c0bc6abe..dba1cf3f8dfc 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -794,14 +794,22 @@ static __meminit pgprot_t pgprot_from_va(uintptr_t va)
 	if (IS_ENABLED(CONFIG_64BIT) && is_va_kernel_lm_alias_text(va))
 		return PAGE_KERNEL_READ;
 
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+	/* If init task's shadow stack va, return write only page protections */
+	if (IS_ENABLED(CONFIG_64BIT) && is_va_init_shadow_stack(va)) {
+		pr_info("Shadow stack protections are being applied to for init\n");
+		return PAGE_KERNEL_SHADOWSTACK;
+	}
+#endif
+
 	return PAGE_KERNEL;
 }
 
 void mark_rodata_ro(void)
 {
-	set_kernel_memory(__start_rodata, _data, set_memory_ro);
+	set_kernel_memory(__start_rodata, __end_srodata, set_memory_ro);
 	if (IS_ENABLED(CONFIG_64BIT))
-		set_kernel_memory(lm_alias(__start_rodata), lm_alias(_data),
+		set_kernel_memory(lm_alias(__start_rodata), lm_alias(__end_srodata),
 				  set_memory_ro);
 }
 #else
@@ -959,14 +967,21 @@ static void __init create_kernel_page_table(pgd_t *pgdir,
 static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
 {
 	uintptr_t va, end_va;
+	pgprot_t prot;
 
 	end_va = kernel_map.virt_addr + kernel_map.size;
-	for (va = kernel_map.virt_addr; va < end_va; va += PMD_SIZE)
+	for (va = kernel_map.virt_addr; va < end_va; va += PMD_SIZE) {
+		prot = PAGE_KERNEL_EXEC;
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+		if (early && is_va_init_shadow_stack_early(va))
+			prot = PAGE_KERNEL_SHADOWSTACK;
+#endif
 		create_pgd_mapping(pgdir, va,
-				   kernel_map.phys_addr + (va - kernel_map.virt_addr),
-				   PMD_SIZE,
-				   early ?
-					PAGE_KERNEL_EXEC : pgprot_from_va(va));
+					kernel_map.phys_addr + (va - kernel_map.virt_addr),
+					PMD_SIZE,
+					early ?
+					prot : pgprot_from_va(va));
+	}
 }
 #endif
 

-- 
2.43.0


