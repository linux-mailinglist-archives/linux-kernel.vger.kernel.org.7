Return-Path: <linux-kernel+bounces-788503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B742B38570
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1F418827D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182B32185B8;
	Wed, 27 Aug 2025 14:50:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47FC1F63CD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306236; cv=none; b=JyDbOkCcGLSSlZ6dgz2+MAQQCcFizwDjn4qmXrO9s19wgS+nT+GTjclcTASxtVHm3CDNhI4x3nB4cyQ/8n9Ql5QgnU0K2SN31prwBRMqo8kvZxDptwofujNqxm/M0MM0iPtjBcIBflbEtQJv7pI8uIs1+pVtEGfyb2lq/TuunU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306236; c=relaxed/simple;
	bh=BGqk+ZHtbDcp14hLUoVWqfA4Qu7UUwR0VhirzMOLS8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmrIFB+dWnIcA/B9g1lSXE1a2ZkdzZF+C55Mtr+RjPIYofzHSZLY/y39PdqltgTG/X3SbvQ5UlJSdqKmzg0y9FrM56mY4Yf3mqGUcM+/lvxrjDf47Uj95KqN/BWBFdPL1upKB0/WAxYmZHDQ3QSz8FdL5XJYWi++MxtLBc6kjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cBmqM2Vk7z9sSL;
	Wed, 27 Aug 2025 16:18:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQd1F6GM_ru7; Wed, 27 Aug 2025 16:18:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cBmqM1qYbz9sS7;
	Wed, 27 Aug 2025 16:18:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2AB9F8B764;
	Wed, 27 Aug 2025 16:18:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id yo6pDWUFDWhs; Wed, 27 Aug 2025 16:18:55 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.202.221])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C3C938B763;
	Wed, 27 Aug 2025 16:18:54 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/8xx: Remove specific code from fast_exception_return
Date: Wed, 27 Aug 2025 16:18:53 +0200
Message-ID: <39de3e0f0122b571474b1ba352a2dc3ad8cb71dd.1756304318.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756304333; l=1240; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=BGqk+ZHtbDcp14hLUoVWqfA4Qu7UUwR0VhirzMOLS8M=; b=TywMfj0R83yFULH9w5LpdDXqVvfuNGlJLKTmnTgLg/J/yv3hzhDHn/oXsxSwLhDvP635D9jbb 0Ct3wus2JeGAM70cOMLXglmfPswHTfcOFOsMSsMidVB6CQyBdnJ9IFS
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

The label 2: in fast_exception_return is a leftover from
commit b96bae3ae2cb ("powerpc/32: Replace ASM exception exit by C
exception exit from ppc64"). Once removed, we see that
fast_exception_return is a standalone function that is called only
from pieces of assembly dedicated to book3s/32 or booke, never by
common code or 8xx code.

So remove the clear of MSR[RI] enclosed in #ifdef CONFIG_PPC_8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index f4a8c9877249..762df811433c 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -216,7 +216,7 @@ fast_exception_return:
 	beq	3f			/* if not, we've got problems */
 #endif
 
-2:	lwz	r10,_CCR(r11)
+	lwz	r10,_CCR(r11)
 	REST_GPRS(1, 6, r11)
 	mtcr	r10
 	lwz	r10,_LINK(r11)
@@ -225,9 +225,6 @@ fast_exception_return:
 	li	r10, 0
 	stw	r10, 8(r11)
 	REST_GPR(10, r11)
-#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
-	mtspr	SPRN_NRI, r0
-#endif
 	mtspr	SPRN_SRR1,r9
 	mtspr	SPRN_SRR0,r12
 	REST_GPR(9, r11)
-- 
2.49.0


