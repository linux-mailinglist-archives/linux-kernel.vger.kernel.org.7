Return-Path: <linux-kernel+bounces-779075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B4FB2EEB9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAD15E65B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82092E718E;
	Thu, 21 Aug 2025 06:50:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6667D2E88B2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759037; cv=none; b=Cqqxby9xYsfx4vUjpK81D3587i6S4y2xCcskxdNG3jNo1Ij01c+h8oY3q47Ig6SVg82smVcTPZYLGzagj4qizQCZ0XqJf6qiywpQ/RHgYJm8fpUJmvl4PuZxBnrqtO57LSdatPzn/0STU6Od4CezSf/mI7PQ+Xi5IGXdrEzPgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759037; c=relaxed/simple;
	bh=iyl6104RZSrIlJicOe4iR8mRE0MXWiG2nNwBytsDVko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F9+bGYO1qmMhfMSq/pEYJLfzK14uTDgNBTa1cUU4XUfBYhGqgguonbdaVTjn1p1a47Y3GszB2S9qLERA5CqmSqQesVT9rm81vhnq5H2o1C4vBynL4bEfz3HwyjAPsoIks0yGeorVJM1uSK/qIoGAooiN1ZoMfx8ILnCGjju7pnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c6tjb6Dxlz9sRs;
	Thu, 21 Aug 2025 08:30:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cBZ596fMmV_9; Thu, 21 Aug 2025 08:30:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c6tjb5Sflz9sRk;
	Thu, 21 Aug 2025 08:30:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A473D8B76C;
	Thu, 21 Aug 2025 08:30:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 9xKpAQnhDf4U; Thu, 21 Aug 2025 08:30:27 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 372FB8B763;
	Thu, 21 Aug 2025 08:30:27 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/603: Really copy kernel PGD entries into all PGDIRs
Date: Thu, 21 Aug 2025 08:30:18 +0200
Message-ID: <752ab7514cae089a2dd7cc0f3d5e35849f76adb9.1755757797.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755757819; l=2209; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=iyl6104RZSrIlJicOe4iR8mRE0MXWiG2nNwBytsDVko=; b=jrtj+Mhrve85dIiULvqBIHwkjs+0MUxfUNNTTBQwdFwyoZP1NSdSfQbyzXeXuAyUbarBVHbC4 1ab825nC7UaBkYOka/LjRy2gDK1c8nbIQ1duIz9ax+0mbH9198THgdr
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 82ef440f9a38 ("powerpc/603: Copy kernel PGD entries into all
PGDIRs and preallocate execmem page tables") was supposed to extend
to powerpc 603 the copy of kernel PGD entries into all PGDIRs
implemented in a previous patch on the 8xx. But 603 is book3s/32 and
uses a duplicate of pgd_alloc() defined in another header.

So really do the copy at the correct place for the 603.

Fixes: 82ef440f9a38 ("powerpc/603: Copy kernel PGD entries into all PGDIRs and preallocate execmem page tables")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 10 ++++++++--
 arch/powerpc/include/asm/nohash/pgalloc.h    |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index dd4eb3063175..f4390704d5ba 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -7,8 +7,14 @@
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
-			pgtable_gfp_flags(mm, GFP_KERNEL));
+	pgd_t *pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+				      pgtable_gfp_flags(mm, GFP_KERNEL));
+
+#ifdef CONFIG_PPC_BOOK3S_603
+	memcpy(pgd + USER_PTRS_PER_PGD, swapper_pg_dir + USER_PTRS_PER_PGD,
+	       (MAX_PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+#endif
+	return pgd;
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
diff --git a/arch/powerpc/include/asm/nohash/pgalloc.h b/arch/powerpc/include/asm/nohash/pgalloc.h
index bb5f3e8ea912..4ef780b291bc 100644
--- a/arch/powerpc/include/asm/nohash/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/pgalloc.h
@@ -22,7 +22,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	pgd_t *pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
 			pgtable_gfp_flags(mm, GFP_KERNEL));
 
-#if defined(CONFIG_PPC_8xx) || defined(CONFIG_PPC_BOOK3S_603)
+#ifdef CONFIG_PPC_8xx
 	memcpy(pgd + USER_PTRS_PER_PGD, swapper_pg_dir + USER_PTRS_PER_PGD,
 	       (MAX_PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
 #endif
-- 
2.49.0


