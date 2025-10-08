Return-Path: <linux-kernel+bounces-845015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD53BC3498
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065983A6DA9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9142BE653;
	Wed,  8 Oct 2025 04:21:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C0F29B8F8
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897297; cv=none; b=YotXrV+cwa9gdGxFy9sx1wwttQss8/2+QTCHvFaPN0liU4hmLE97LQDRLhl5mw2Hsxf7V6wwqTnjEQvhydijuJ8xMol0rOPyiKW9PoqDCqEiFXuOJi7X6bIXxj9rRCkBkxUtbwqAuCVheyjZmJZC8icAV1GEudwN+AQ6jUSpd2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897297; c=relaxed/simple;
	bh=z87BLegyEF33UQuQEaBxe3mjgZuRVFrt39YuYai/vw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hy21SY3kwIU9brXrweiEJGOkrT2X92jezDHyVryGl2dS1VjY4LpUzXpuw5QBhdc4HjUInPb3VH+ZwnZsKwZYbFDB7fcXDzHP5aHB+nosnr8ZgKc4Bqk48GibQb/jC2+VN+D8XrJYF1aPDhrFZ8azjSkdsKnNYsxq1Ig/pIEb4GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D41F22EE;
	Tue,  7 Oct 2025 21:21:23 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AA2BC3F738;
	Tue,  7 Oct 2025 21:21:30 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] drivers/sgi-gru: Use pxdp_get() for page table access
Date: Wed,  8 Oct 2025 05:21:26 +0100
Message-Id: <20251008042126.2408106-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace all READ_ONCE() with a standard page table accessors i.e pxdp_get()
that default into READ_ONCE() in cases where platforms do not override.

Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/misc/sgi-gru/grufault.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 3557d78ee47a..60e55facd8d7 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -212,19 +212,19 @@ static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
 	pte_t pte;
 
 	pgdp = pgd_offset(vma->vm_mm, vaddr);
-	if (unlikely(pgd_none(*pgdp)))
+	if (unlikely(pgd_none(pgdp_get(pgdp))))
 		goto err;
 
 	p4dp = p4d_offset(pgdp, vaddr);
-	if (unlikely(p4d_none(*p4dp)))
+	if (unlikely(p4d_none(p4dp_get(p4dp))))
 		goto err;
 
 	pudp = pud_offset(p4dp, vaddr);
-	if (unlikely(pud_none(*pudp)))
+	if (unlikely(pud_none(pudp_get(pudp))))
 		goto err;
 
 	pmdp = pmd_offset(pudp, vaddr);
-	if (unlikely(pmd_none(*pmdp)))
+	if (unlikely(pmd_none(pmdp_get(pmdp))))
 		goto err;
 #ifdef CONFIG_X86_64
 	if (unlikely(pmd_leaf(*pmdp)))
-- 
2.30.2


