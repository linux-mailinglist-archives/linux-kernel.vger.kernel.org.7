Return-Path: <linux-kernel+bounces-773330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8808FB29E60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1A63A7A78
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2278A30F81C;
	Mon, 18 Aug 2025 09:50:46 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1675330F81E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510645; cv=none; b=mQzw/C43xC8vRL+CheYKY2leZ1RYZfLQpBoMlyTkdMH7dDgjEFr8EC/cmU78aLaVp0etV8JH6X+m0lF1DOWbrOgTi+nI3Q3gAwjI/PtdJjjvKnHLbiTudJYSJ1gsYoz72XAaNBM9TNJzCilPKnFKDk2yh0yiXZeD6LDCe4eLr9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510645; c=relaxed/simple;
	bh=TAsscSyJtpUCGKm9ZAZDquJX675SP3WAqWe4d5FCqsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nN5CaDzGoEsxzX7WxRenmQm4ILGv0M+UzimdoP75//2Iuizg30mOzaeo54nzgeGK6TPrLuhKXYRrkBUautwLVDh5XgZ/Y6a3xRP8DiEQKzFkNJtsAGXczcvlihxE/vmzWazE87zKTWRXeT5fx0wqqvwzqzuPdHlQcAQ7DcvgzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c56jh6bZ5z9sSb;
	Mon, 18 Aug 2025 11:24:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PrRcsrkZHasd; Mon, 18 Aug 2025 11:24:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c56jh5Kwwz9sSL;
	Mon, 18 Aug 2025 11:24:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A19568B764;
	Mon, 18 Aug 2025 11:24:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id iktC4Suv_m60; Mon, 18 Aug 2025 11:24:24 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F5358B763;
	Mon, 18 Aug 2025 11:24:24 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/8xx: Remove offset in SPRN_M_TWB
Date: Mon, 18 Aug 2025 11:24:22 +0200
Message-ID: <9710d960b512996e64beebfd368cfeaadb28b3ba.1755509047.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755509062; l=3826; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=TAsscSyJtpUCGKm9ZAZDquJX675SP3WAqWe4d5FCqsY=; b=RWSzwQK+jm9lIDUEzWeDOAVOPN+4fOow1YA3gENnqhWmpUJzpyJT8NKCSyZib+NMG+3ptGUcT 3jvCrlaLhTjCoCZHpuEYabHWnWnpcpW39JpthwYDm7O4y4Vo+lUyT9H
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

SPRN_M_TWB contains the address of task PGD minus an offset which
compensates the offset required when accessing the kernel PGDIR.
However, since commit ac9f97ff8b32 ("powerpc/8xx: Inconditionally use
task PGDIR in DTLB misses") and commit 33c527522f39 ("powerpc/8xx:
Inconditionally use task PGDIR in ITLB misses") kernel PGDIR is not
used anymore in hot pathes.

Remove this offset which was added by
commit fde5a9057fcf ("powerpc/8xx: Optimise access to swapper_pg_dir")

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S       | 16 +++++++++-------
 arch/powerpc/mm/nohash/mmu_context.c | 10 +---------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 56c5ebe21b99..78942fd6b4b9 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -190,7 +190,7 @@ instruction_counter:
 	INVALIDATE_ADJACENT_PAGES_CPU15(r10, r11)
 	mtspr	SPRN_MD_EPN, r10
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table */
-	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r10)	/* Get level 1 entry */
+	lwz	r11, 0(r10)	/* Get level 1 entry */
 	mtspr	SPRN_MD_TWC, r11
 	mfspr	r10, SPRN_MD_TWC
 	lwz	r10, 0(r10)	/* Get the pte */
@@ -233,7 +233,7 @@ instruction_counter:
 	 */
 	mfspr	r10, SPRN_MD_EPN
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table */
-	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r10)	/* Get level 1 entry */
+	lwz	r11, 0(r10)	/* Get level 1 entry */
 
 	mtspr	SPRN_MD_TWC, r11
 	mfspr	r10, SPRN_MD_TWC
@@ -375,7 +375,7 @@ FixupPGD:
 	mfspr	r10, SPRN_DAR
 	mtspr	SPRN_MD_EPN, r10
 	mfspr	r11, SPRN_M_TWB	/* Get level 1 table */
-	lwz	r10, (swapper_pg_dir - PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
+	lwz	r10, 0(r11)	/* Get the level 1 entry */
 	cmpwi	cr1, r10, 0
 	bne	cr1, 1f
 
@@ -384,7 +384,7 @@ FixupPGD:
 	lwz	r10, (swapper_pg_dir - PAGE_OFFSET)@l(r10)	/* Get the level 1 entry */
 	cmpwi	cr1, r10, 0
 	beq	cr1, 1f
-	stw	r10, (swapper_pg_dir - PAGE_OFFSET)@l(r11)	/* Set the level 1 entry */
+	stw	r10, 0(r11)	/* Set the level 1 entry */
 	mfspr	r10, SPRN_M_TW
 	mtcr	r10
 	mfspr	r10, SPRN_SPRG_SCRATCH0
@@ -412,9 +412,10 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	tophys(r11, r10)
 	mfspr	r11, SPRN_M_TWB	/* Get level 1 table */
 	rlwinm	r11, r11, 0, 20, 31
-	oris	r11, r11, (swapper_pg_dir - PAGE_OFFSET)@ha
+	oris	r11, r11, (swapper_pg_dir - PAGE_OFFSET)@h
+	ori	r11, r11, (swapper_pg_dir - PAGE_OFFSET)@l
 3:
-	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
+	lwz	r11, 0(r11)	/* Get the level 1 entry */
 	rlwinm	r11, r11, 0, ~_PMD_PAGE_8M
 	mtspr	SPRN_MD_TWC, r11
 	mfspr	r11, SPRN_MD_TWC
@@ -535,7 +536,8 @@ start_here:
 	li	r0,0
 	stwu	r0,THREAD_SIZE-STACK_FRAME_MIN_SIZE(r1)
 
-	lis	r6, swapper_pg_dir@ha
+	lis	r6, swapper_pg_dir@h
+	ori	r6, r6, swapper_pg_dir@l
 	tophys(r6,r6)
 	mtspr	SPRN_M_TWB, r6
 
diff --git a/arch/powerpc/mm/nohash/mmu_context.c b/arch/powerpc/mm/nohash/mmu_context.c
index a1a4e697251a..28a96a10c907 100644
--- a/arch/powerpc/mm/nohash/mmu_context.c
+++ b/arch/powerpc/mm/nohash/mmu_context.c
@@ -203,15 +203,7 @@ static unsigned int steal_context_up(unsigned int id)
 static void set_context(unsigned long id, pgd_t *pgd)
 {
 	if (IS_ENABLED(CONFIG_PPC_8xx)) {
-		s16 offset = (s16)(__pa(swapper_pg_dir));
-
-		/*
-		 * Register M_TWB will contain base address of level 1 table minus the
-		 * lower part of the kernel PGDIR base address, so that all accesses to
-		 * level 1 table are done relative to lower part of kernel PGDIR base
-		 * address.
-		 */
-		mtspr(SPRN_M_TWB, __pa(pgd) - offset);
+		mtspr(SPRN_M_TWB, __pa(pgd));
 
 		/* Update context */
 		mtspr(SPRN_M_CASID, id - 1);
-- 
2.49.0


