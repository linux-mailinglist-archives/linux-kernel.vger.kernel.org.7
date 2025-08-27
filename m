Return-Path: <linux-kernel+bounces-788504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C43FBB38573
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBACB3AFC39
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEDE21CC68;
	Wed, 27 Aug 2025 14:50:42 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E413C21CC59
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306241; cv=none; b=l/YAqZHTOuc7vT0J3BDOmNFPIC7aKWq+kmUg6cyxJmnTN/e74VbcR+Kde7iZMAyiT5dSgYn2OqzlbnnmlOs8Fcav3U7r6jjrEAaxxhYqMKFI5hh76jvxLMgRhLvi1SyhlBlOLG20W7F05g59Gllz8XWjZBjDDre77C83oTRcRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306241; c=relaxed/simple;
	bh=2npINxb8oQMKnIaxjh0X0IDfdSNnY9TlWZbMisNq49c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbjyhzbF00CnXrLCH40wYk4et0ZcOEs4zCNq9wL98PAwJ4V7ygpWUDuq5m2y05LUFkn0PsnYVytZWa5MM57jte6ZH4buWqYCASCLDeFVrE3yGC4hfMSBJalipLCqkPia8x6vpgFKZAqIYOclyrUWvUcj3h5D5fJbEDuJqrG72zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cBmql4Fsnz9sSS;
	Wed, 27 Aug 2025 16:19:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kZDcgQWG095e; Wed, 27 Aug 2025 16:19:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cBmql3cMxz9sSN;
	Wed, 27 Aug 2025 16:19:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 69E468B764;
	Wed, 27 Aug 2025 16:19:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id n6IPFYSBYu05; Wed, 27 Aug 2025 16:19:15 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.202.221])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 17A178B763;
	Wed, 27 Aug 2025 16:19:15 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/32: Fix unpaired stwcx. on interrupt exit
Date: Wed, 27 Aug 2025 16:19:14 +0200
Message-ID: <465f323523f677816cc4f26d5e988279a277a37d.1756304342.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756304354; l=1523; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=2npINxb8oQMKnIaxjh0X0IDfdSNnY9TlWZbMisNq49c=; b=+J17fCe7FTmIs0xyopfCDFVHCs4IOzvmvwDQNQ6+MAJb7k5f7tHn3CrKcOx+hK4tjdtz6m9qD 5QS2YKfjkchDGwyXrGBK2T646f0PyE/iPIl8BHm8lF9Yk69/V/J2S8S
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit b64f87c16f3c ("[POWERPC] Avoid unpaired stwcx. on some
processors") erroneouly copied to powerpc/32 the logic from powerpc/64
based on feature CPU_FTR_STCX_CHECKS_ADDRESS which is always 0 on
powerpc/32.

Re-instate the logic implemented by commit b64f87c16f3c ("[POWERPC]
Avoid unpaired stwcx. on some processors")

Fixes: b96bae3ae2cb ("powerpc/32: Replace ASM exception exit by C exception exit from ppc64")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 762df811433c..c37480176a1c 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -260,10 +260,9 @@ interrupt_return:
 	mtspr	SPRN_SRR1,r12
 
 BEGIN_FTR_SECTION
+	lwarx   r0,0,r1
+END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	stwcx.	r0,0,r1		/* to clear the reservation */
-FTR_SECTION_ELSE
-	lwarx	r0,0,r1
-ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 	lwz	r3,_CCR(r1)
 	lwz	r4,_LINK(r1)
@@ -303,10 +302,9 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	mtspr	SPRN_SRR1,r12
 
 BEGIN_FTR_SECTION
+	lwarx   r0,0,r1
+END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	stwcx.	r0,0,r1		/* to clear the reservation */
-FTR_SECTION_ELSE
-	lwarx	r0,0,r1
-ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 	lwz	r3,_LINK(r1)
 	lwz	r4,_CTR(r1)
-- 
2.49.0


