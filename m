Return-Path: <linux-kernel+bounces-807853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF5FB4AA5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187D41883031
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5EA31B122;
	Tue,  9 Sep 2025 10:20:42 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73892EBB8C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413242; cv=none; b=s78aWrh8VDSms0Yu1UhPiBhVqkCe5yL3Gyu8LstBAo7YJcslP2FtXzLc2gbyvh6B9F3EbJcDSMlvPb2Z5z9LcMwmZrQCfPi4BWzFxH6S2wbv/aF8RAWZUcn5ReCn6uhCczw+QpD/E4LHil4aTD3X20Ro0Tqtzkt850PeBNkT1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413242; c=relaxed/simple;
	bh=AOEaSonLtPZErc53eenT+EFbdPGQtfmJuRx+JaONPkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMSjncdRmzXFFdcJixTVlxKRjMOmQUxzN8wIHGhQG0jJFOcf5RyGIOswO4qfRU0UweFDTOrMvJXG69uWCLIB/lqOf3VfA4jfj+xgMyv6o+7uIVvW64B+Wg0JHYt0t621ZGri3jyWseGzOwN/UIwmRck+0spP+t5fLKstEXLH1iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cLfY46PJVz9sRh;
	Tue,  9 Sep 2025 12:03:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zw6k5wfbw6r7; Tue,  9 Sep 2025 12:03:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cLfY44SkBz9sRg;
	Tue,  9 Sep 2025 12:03:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 66B198B766;
	Tue,  9 Sep 2025 12:03:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id E-gQL_c33zki; Tue,  9 Sep 2025 12:03:52 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 30CE98B764;
	Tue,  9 Sep 2025 12:03:52 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Erhard Furtner <erhard_f@mailbox.org>
Subject: [PATCH v2] powerpc/32: Remove PAGE_KERNEL_TEXT to fix startup failure
Date: Tue,  9 Sep 2025 12:03:49 +0200
Message-ID: <8e2d793abf87ae3efb8f6dce10f974ac0eda61b8.1757412205.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757412230; l=3895; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=AOEaSonLtPZErc53eenT+EFbdPGQtfmJuRx+JaONPkE=; b=ywqv6sdz3DMjOTmHk3oFWKHjRSP4YPTppu/hzY2nkVSPy0mIV3Pa03KSqpKs+Cy0q95UbwVC4 7DZITk8d5VSCcW209ZE+Co1DBdtVckdvzVQCqceWyMfAGH4MKw2BT0T
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

PAGE_KERNEL_TEXT is an old macro that is used to tell kernel whether
kernel text has to be mapped read-only or read-write based on build
time options.

But nowadays, with functionnalities like jump_labels, static links,
etc ... more only less all kernels need to be read-write at some
point, and some combinations of configs failed to work due to
innacurate setting of PAGE_KERNEL_TEXT. On the other hand, today
we have CONFIG_STRICT_KERNEL_RWX which implements a more controlled
access to kernel modifications.

Instead of trying to keep PAGE_KERNEL_TEXT accurate with all
possible options that may imply kernel text modification, always
set kernel text read-write at startup and rely on
CONFIG_STRICT_KERNEL_RWX to provide accurate protection.

Do this by passing PAGE_KERNEL_X to map_kernel_page() in
__maping_ram_chunk() instead of passing PAGE_KERNEL_TEXT. Once
this is done, the only remaining user of PAGE_KERNEL_TEXT is
mmu_mark_initmem_nx() which uses it in a call to setibat().
As setibat() ignores the RW/RO, we can seamlessly replace
PAGE_KERNEL_TEXT by PAGE_KERNEL_X here as well and get rid of
PAGE_KERNEL_TEXT completely.

Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Closes: https://lore.kernel.org/all/342b4120-911c-4723-82ec-d8c9b03a8aef@mailbox.org/
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Revised commit message
---
 arch/powerpc/include/asm/pgtable.h | 12 ------------
 arch/powerpc/mm/book3s32/mmu.c     |  4 ++--
 arch/powerpc/mm/pgtable_32.c       |  2 +-
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 93d77ad5a92f..d8f944a5a037 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -20,18 +20,6 @@ struct mm_struct;
 #include <asm/nohash/pgtable.h>
 #endif /* !CONFIG_PPC_BOOK3S */
 
-/*
- * Protection used for kernel text. We want the debuggers to be able to
- * set breakpoints anywhere, so don't write protect the kernel text
- * on platforms where such control is possible.
- */
-#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) || \
-	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
-#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
-#else
-#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
-#endif
-
 /* Make modules code happy. We don't set RO yet */
 #define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
 
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index be9c4106e22f..c42ecdf94e48 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -204,7 +204,7 @@ int mmu_mark_initmem_nx(void)
 
 	for (i = 0; i < nb - 1 && base < top;) {
 		size = bat_block_size(base, top);
-		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
+		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
 		base += size;
 	}
 	if (base < top) {
@@ -215,7 +215,7 @@ int mmu_mark_initmem_nx(void)
 				pr_warn("Some RW data is getting mapped X. "
 					"Adjust CONFIG_DATA_SHIFT to avoid that.\n");
 		}
-		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
+		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
 		base += size;
 	}
 	for (; i < nb; i++)
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 15276068f657..0c9ef705803e 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -104,7 +104,7 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 	p = memstart_addr + s;
 	for (; s < top; s += PAGE_SIZE) {
 		ktext = core_kernel_text(v);
-		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
+		map_kernel_page(v, p, ktext ? PAGE_KERNEL_X : PAGE_KERNEL);
 		v += PAGE_SIZE;
 		p += PAGE_SIZE;
 	}
-- 
2.49.0


