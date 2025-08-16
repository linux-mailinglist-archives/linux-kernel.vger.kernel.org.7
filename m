Return-Path: <linux-kernel+bounces-772179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9961B28FA1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 18:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8B41C82266
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4B72FD7B5;
	Sat, 16 Aug 2025 16:50:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0932D1D31B9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755363036; cv=none; b=iedXjjn9QN6THd57gBfiz7wNUZoBSm6c40iOOEHxh9r30f9hJAfSI3mljkWXo2ye8MGsMiqtvDHecexk04Bk1uwvYPMfNP/jF0sDMXKJtcdpTwj0h82AKsf42AQQDUTNyWwUh3xZqI18nWcNk+yuLkDfXz43sYaEbGxgQfHYNAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755363036; c=relaxed/simple;
	bh=AiHXMtFhh8Ce2WYooZYS7g9S+I96bwlKG8VhkoxFeF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WpQQk84t/3RihszlJXNo1LW91sw3J/X+XHR7T08XwC+wvqdRLMOu0up57dIimtOAsCEzGJDxb/Q1UCmkXKSGCXQbWsEF1Kzmefa3N4lUrGb8XvxlcOEvfbehzDCkSoWY1NK+SnEf+pepdBbZalNHY6xJQsya4OnTZxPuxeTfZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c44Kp47h3z9sRk;
	Sat, 16 Aug 2025 18:33:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lali5_hbY1bi; Sat, 16 Aug 2025 18:33:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c44Kp31YCz9sRh;
	Sat, 16 Aug 2025 18:33:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 462688B764;
	Sat, 16 Aug 2025 18:33:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 0_U2uxviJf6w; Sat, 16 Aug 2025 18:33:34 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BAB598B763;
	Sat, 16 Aug 2025 18:33:33 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/8xx: Remove left-over instruction and comments in DataStoreTLBMiss handler
Date: Sat, 16 Aug 2025 18:33:26 +0200
Message-ID: <5811c8d1d6187f280ad140d6c0ad6010e41eeaeb.1755361995.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755362007; l=2260; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=AiHXMtFhh8Ce2WYooZYS7g9S+I96bwlKG8VhkoxFeF0=; b=KnUG1yo8uoFsuqw9l+g5FYFCA3AOjMFrcRUhk0XhlPdq+TIpJlAO0U88/6USwdRjPo/o8CS+5 HR98q6h41BPDzJhoktpXyyFYxwWSA/83tfRokZIIyHLYWdBk86HK12s
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit ac9f97ff8b32 ("powerpc/8xx: Inconditionally use task PGDIR in
DTLB misses") removed the test that needed the valeur in SPRN_EPN but
failed to remove the read.

Remove it.

And remove related comments, including the very same comment
in InstructionTLBMiss that should have been removed by
commit 33c527522f39 ("powerpc/8xx: Inconditionally use task PGDIR in
ITLB misses").

Also update the comment about absence of a second level table which
has been handled implicitely since commit 5ddb75cee5af ("powerpc/8xx:
remove tests on PGDIR entry validity").

Fixes: ac9f97ff8b32 ("powerpc/8xx: Inconditionally use task PGDIR in DTLB misses")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 78942fd6b4b9..393e19ee1322 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -162,7 +162,7 @@ instruction_counter:
  * For the MPC8xx, this is a software tablewalk to load the instruction
  * TLB.  The task switch loads the M_TWB register with the pointer to the first
  * level table.
- * If we discover there is no second level table (value is zero) or if there
+ * If there is no second level table (value is zero) or if there
  * is an invalid pte, we load that into the TLB, which causes another fault
  * into the TLB Error interrupt where we can handle such problems.
  * We have to use the MD_xxx registers for the tablewalk because the
@@ -183,9 +183,6 @@ instruction_counter:
 	mtspr	SPRN_SPRG_SCRATCH2, r10
 	mtspr	SPRN_M_TW, r11
 
-	/* If we are faulting a kernel address, we have to use the
-	 * kernel page tables.
-	 */
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
 	INVALIDATE_ADJACENT_PAGES_CPU15(r10, r11)
 	mtspr	SPRN_MD_EPN, r10
@@ -228,10 +225,6 @@ instruction_counter:
 	mtspr	SPRN_SPRG_SCRATCH2, r10
 	mtspr	SPRN_M_TW, r11
 
-	/* If we are faulting a kernel address, we have to use the
-	 * kernel page tables.
-	 */
-	mfspr	r10, SPRN_MD_EPN
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table */
 	lwz	r11, 0(r10)	/* Get level 1 entry */
 
-- 
2.49.0


