Return-Path: <linux-kernel+bounces-871759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19298C0E44F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8FC64FD2E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA84308F05;
	Mon, 27 Oct 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SLK2W076"
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790BE3074BA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573783; cv=none; b=u/RtQYnbaaQcNEeiYXesi9QxPzBQ7vtqoI74AsowVsnKwetfACE/hbdq967APHxZqcM3RnX54yXuY0KJiYxWxh0TSdM8Q03Z0qb7/6WAShSIAm14PfTAb4bed2GyFTJX1UpLNf0un2qEfmz8xCbTJs0umaBR5uSXAWvf5s0RprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573783; c=relaxed/simple;
	bh=LW15w7xQg9gRWAa895g7wUF8rHVvxn2WMkj3cgKTHHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0vIqgZsMJZm6yBoTDpa3OejjNY20836xPU1FjS010fjRn4Jn1Ezwue7MdfLsII5BKYelNwrFCnul0jDz+GQjeLZR/E/tqqL2Y+dvqa2Wzfpd1V4k/ofJ9pqu8vyU+wJ48KtGkmxn91+OGm7Nqnj7yckOImcYTRqI+wScYun2j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SLK2W076; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aF4TpgFPzQfQ4TxKLvGD5GPPUdCoPIU4OMOOCRwa9L8=;
	b=SLK2W076Ok61yovfnWNUbNrMOgVjZYGy30HtbXGUgj1rSQ5AKi3f589GAdFlixGk2LTeF74hD
	SD+8xT9PHE7iVCCKiyCs5wIOKJIIL2dNa3mD4XkBQr/dmyg6JVW+guG3ysoM1iTRIDrdFBypPf3
	PWS7WLF4OIInXquuCFg4EFU=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cwFZH3YChzLlSH;
	Mon, 27 Oct 2025 22:02:31 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (unknown [7.185.36.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 44F69140259;
	Mon, 27 Oct 2025 22:02:59 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf500012.china.huawei.com
 (7.185.36.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 27 Oct
 2025 22:02:58 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<jannh@google.com>, <pfalcato@suse.de>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [RFC PATCH 3/3] mm/mremap: Use can_pte_batch_count() instead of folio_pte_batch() for pte batch
Date: Mon, 27 Oct 2025 22:03:15 +0800
Message-ID: <20251027140315.907864-4-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027140315.907864-1-zhangqilong3@huawei.com>
References: <20251027140315.907864-1-zhangqilong3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500012.china.huawei.com (7.185.36.8)

In current mremap_folio_pte_batch(), 1) pte_batch_hint() always
return one pte in non-ARM64 machine, it is not efficient. 2) Next,
it need to acquire a folio to call the folio_pte_batch().

Due to new added can_pte_batch_count(), we just call it instead of
folio_pte_batch(). And then rename mremap_folio_pte_batch() to
mremap_pte_batch().

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 mm/mremap.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index bd7314898ec5..d11f93f1622f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -169,27 +169,17 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 		pte = pte_swp_mksoft_dirty(pte);
 #endif
 	return pte;
 }
 
-static int mremap_folio_pte_batch(struct vm_area_struct *vma, unsigned long addr,
+static int mremap_pte_batch(struct vm_area_struct *vma, unsigned long addr,
 		pte_t *ptep, pte_t pte, int max_nr)
 {
-	struct folio *folio;
-
 	if (max_nr == 1)
 		return 1;
 
-	/* Avoid expensive folio lookup if we stand no chance of benefit. */
-	if (pte_batch_hint(ptep, pte) == 1)
-		return 1;
-
-	folio = vm_normal_folio(vma, addr, pte);
-	if (!folio || !folio_test_large(folio))
-		return 1;
-
-	return folio_pte_batch(folio, ptep, pte, max_nr);
+	return can_pte_batch_count(vma, ptep, &pte, max_nr, 0);
 }
 
 static int move_ptes(struct pagetable_move_control *pmc,
 		unsigned long extent, pmd_t *old_pmd, pmd_t *new_pmd)
 {
@@ -278,11 +268,11 @@ static int move_ptes(struct pagetable_move_control *pmc,
 		 * make sure the physical page stays valid until
 		 * the TLB entry for the old mapping has been
 		 * flushed.
 		 */
 		if (pte_present(old_pte)) {
-			nr_ptes = mremap_folio_pte_batch(vma, old_addr, old_ptep,
+			nr_ptes = mremap_pte_batch(vma, old_addr, old_ptep,
 							 old_pte, max_nr_ptes);
 			force_flush = true;
 		}
 		pte = get_and_clear_ptes(mm, old_addr, old_ptep, nr_ptes);
 		pte = move_pte(pte, old_addr, new_addr);
-- 
2.43.0


