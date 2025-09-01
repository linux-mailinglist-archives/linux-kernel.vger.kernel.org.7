Return-Path: <linux-kernel+bounces-794362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1429EB3E099
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC17D3B4B4A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F15246778;
	Mon,  1 Sep 2025 10:50:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5AA19DF4A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723837; cv=none; b=PeXfEWKq0Ru2LavHX0F7PnooyEKpRrWgYxj45rCWl3dkIIPB1KnSGg3yEiC7/xguIT+sfpL3kIXb3yBglHEmwS2yw/hCaUy1yw2YqItCSHd4RYqxzSr3HykzJzY8S61yg9SYaDTB6gz87qqh6guFAjI9K68e5nkUmEc3+qHIIN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723837; c=relaxed/simple;
	bh=JY4nN22IRUYGqIwovVvxnnDJT9Tx3pnktgQJfDzu+l8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIMw4AiM782orj9gWSV1Ds/BODeLU9N5+enyZW8SrIfV2NnXHBuVs4nmq7zIP5aLPiN9hmze8aEZD6vAsMyyKY5zB28VE8kfI/fPiByZXKwwHk4R29eE/n4x+97d1WdqQJ7sKMZoCsQlUCvBK1GrWYujTuPwCFwDyyBdUPk9qw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cFlgs4DDhz9sSK;
	Mon,  1 Sep 2025 12:37:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fIX_k0S4RAlZ; Mon,  1 Sep 2025 12:37:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cFlgs3YJCz9sSC;
	Mon,  1 Sep 2025 12:37:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 646F38B78C;
	Mon,  1 Sep 2025 12:37:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id anueRLxppAms; Mon,  1 Sep 2025 12:37:45 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 43BED8B77B;
	Mon,  1 Sep 2025 12:37:45 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/32: Restore clearing of MSR[RI] in interrupt_exit_kernel_prepare()
Date: Mon,  1 Sep 2025 12:37:42 +0200
Message-ID: <e6166d2568386517de96a89e6cb3c7bd67e71eec.1756723048.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756723062; l=990; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=JY4nN22IRUYGqIwovVvxnnDJT9Tx3pnktgQJfDzu+l8=; b=y2rc7jN2J4jQtRTKtfGfL5xNOKpQuFwxU3QJQyLve6PYon5aub7ayqEdEj+rSIf2/kbus6dAD EkNdMGwCCR4D+OWc98sj/rbbjIwHY8/23Gq4YSj/7kDxd6cfzYuvS2n
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 13799748b957 ("powerpc/64: use interrupt restart table to speed
up return from interrupt") removed the inconditional clearing of MSR[RI]
when returning from interrupt into kernel. But powerpc/32 doesn't
implement interrupt restart table hence still need MSR[RI] to be
cleared.

Fixes: 13799748b957 ("powerpc/64: use interrupt restart table to speed up return from interrupt")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/interrupt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index e0c681d0b076..e63bfde13e03 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -443,6 +443,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 
 		if (unlikely(stack_store))
 			__hard_EE_RI_disable();
+#else
+	} else {
+		__hard_EE_RI_disable();
 #endif /* CONFIG_PPC64 */
 	}
 
-- 
2.49.0


