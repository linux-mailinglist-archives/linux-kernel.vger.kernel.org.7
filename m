Return-Path: <linux-kernel+bounces-813473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637CAB545F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE313BFBAB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18A425D202;
	Fri, 12 Sep 2025 08:50:41 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466E017BA1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667041; cv=none; b=HBbo8Wem6wwM76T8NSI2hLvrpKaH+vAmvm7cg5CVNiiMiyv2/IHmF9ZOYaiP1FzKoU3JAX0OsoVhFgBx9ejevytisgEPO6uS4cu+uMrzA00ZqoAzed/TfpAn959NGkDnj2yqnJEItdotC/6Kjv+2nJ/2vCIM1XIaJcbgf49OsZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667041; c=relaxed/simple;
	bh=5vI3e5CRVNaH9YfMQbqIK6M5whINX0HsBG3gpHpgdQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMdOFC23eLOZdnPExGa0P1EI6OMaMPUQ/P4x4g2tadGqCBdDea77GXdhDCF83QYRqjRHcaK8UikcZsSZSjo60KOSlVEQgwwED9dN9+iwrpKF1bYfexGZTJOAGVHIYEFB5LHuEc+NxfnIEPtZO7/FWgLqRw9myh9TN/CoQjCZjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cNSV810Hnz9sjH;
	Fri, 12 Sep 2025 10:37:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dJsHGcZ--gTw; Fri, 12 Sep 2025 10:37:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cNSV80JmJz9sjD;
	Fri, 12 Sep 2025 10:37:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EA7988B7A7;
	Fri, 12 Sep 2025 10:37:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WbMpPa6hMifm; Fri, 12 Sep 2025 10:37:35 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B0EF98B764;
	Fri, 12 Sep 2025 10:37:35 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/32: Fix unpaired stwcx. on interrupt exit
Date: Fri, 12 Sep 2025 10:37:34 +0200
Message-ID: <6040b5dbcf5cdaa1cd919fcf0790f12974ea6e5a.1757666244.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757666254; l=1672; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=5vI3e5CRVNaH9YfMQbqIK6M5whINX0HsBG3gpHpgdQU=; b=3HUtWsJBTeDbibwPdJ+3dy4s3u4+rRHfi40L3ROeVYjn4DCFzLT+fuMd9GQJOPMQI2Z2zJv9x WmDkcA8GXr7A0KnhVg1qliOBwOZ7lBUUSEBBZA5Gt1eNPpoFDVaMahj
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit b96bae3ae2cb ("powerpc/32: Replace ASM exception exit by C
exception exit from ppc64") erroneouly copied to powerpc/32 the logic
from powerpc/64 based on feature CPU_FTR_STCX_CHECKS_ADDRESS which is
always 0 on powerpc/32.

Re-instate the logic implemented by commit b64f87c16f3c ("[POWERPC]
Avoid unpaired stwcx. on some processors") which is based on
CPU_FTR_NEED_PAIRED_STWCX feature.

Fixes: b96bae3ae2cb ("powerpc/32: Replace ASM exception exit by C exception exit from ppc64")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Fixed the commit message (Wrong patch reference in the beginning)
---
 arch/powerpc/kernel/entry_32.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 61ffd2989e7b..16f8ee6cb2cd 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -275,10 +275,9 @@ interrupt_return:
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
@@ -319,10 +318,9 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
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


