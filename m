Return-Path: <linux-kernel+bounces-873818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECADC14CEB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D063B63DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7DC3195F4;
	Tue, 28 Oct 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvYSrp1b"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDCC3043AF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657760; cv=none; b=XGAIr7KVFvGTujZaOpXsnWd0ugwsaBJb387tz0s/Npp9yOpx42c+3AUIrElPXwGZCPR1qIKk5M4azt0d+/eEAHlnV1x1oBxBxMLwMfFTD6IGSboSLAVOYe/pUtbY4Ro3HwGhB5T86N44Lgx5MMI5hbShepUrmI1GHo6nRBRZiiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657760; c=relaxed/simple;
	bh=MtVL95cvmOGqNG5wrZbg+v9pKV8i/qU3CFtaqmmyw3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzjUdNrKRBaXPxEgK/dKAd33n++c92QD1GWMb2i/ZnqZbqtmd+M636kS0CvKiLRdBHXrb9k4KmNZFxLrdVDzqP2ymdho6V8S/miN46BndljcORwGSaIA2BonpXXtBxXnOA3ieVEdQgCzctvaWmc/EFASuVOJ8dDnGgYNArB80Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvYSrp1b; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d3540a43fso62794965ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761657758; x=1762262558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrGZMy9hZEV5wyJpLWINpY79WwhAr5U2pevMnRBTDHY=;
        b=IvYSrp1bRz8l6mtq7anzanMekdJfVb9ZTq/XfevGxvVGprjgmiwPUBaQsqpFX72YQQ
         pl18dr4t9CWVUFhhKr8qXCJXkOWf9CkAR1GrJjFpnJT+VnwOHuhLXrJL2cQzPuHBXthr
         kb6PG3eB9EoRdDoHEbximS6IGh4Sz8I5aMBoLVdJ4XxF9caARfcJ3hr7gHzXM7f/8QeI
         4qUdiGL1Is3THLljvzi5XlYdiPCJ2PMgmO2e6srMMReATrj1Je+WfY0OTdee7sRU3QaQ
         /jNz2pOeQim85onMin4GjQW4FzbeTnS8gqpi4YaxwLnya+YxmJ0NsHD2eCFVKYIXV+Fz
         xXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761657758; x=1762262558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrGZMy9hZEV5wyJpLWINpY79WwhAr5U2pevMnRBTDHY=;
        b=JMoUUB0WNdJykR+7cIYD3u0maNfzaralZm/6+zE/HyD5nR+fnkWEJ5estvQbO3whX0
         lG0qKT9LuTBNk9sQsT5YGBEkGPp0d6GaDn05DFnPKK+uddq9yVstYL6M4x1ayqD2WIzM
         t0ciUCplE789XzPGOViE8V+opuSW/COIsT0mxrz/jcI0Wk5PtLQq7VuLPjeicLE45n+7
         ajQ5nRr373rOu4RmiZoXogbn2yePpR7L2HQ72GGHR6nQ3Zs1KVblzlBYR90Kgv9rWrmK
         X/0TEHcZEQdXML4Svgic7uxWyrl8PcAcs+AJImKw3/dRlXB9fYyIvkrJjSnNLNug1RHb
         5lFg==
X-Forwarded-Encrypted: i=1; AJvYcCUtuOFxzmiFXFxzvI5/ZyRFa+oDTf5BepJC3AIdMroMoT7lZi4vGStcY1Sy7zP0oHYpoOWXjWw5qgfuyvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhWZmrsMsaDwfhd6JmcrBXJVDWueGqygVJ+AL8lV2fmte/iRJK
	ZW3iCuZvy0doZ09LrV/fSsmp5z8t3gKlTqKNXnDTgdAkpv1GQKXtbiLn1vS4puGa
X-Gm-Gg: ASbGncs2ll9ZvquvBhiKrGK7n47pZjBsMbz0MFg5mS5iORiD+SwW1nRsp5VAa6U4T6v
	ghwWQZoNxo9C8JhTKkyCObx98MmUcOZDuoj9MIjke+/iDnhyuAIGOooZblDKBxEAxxPU9cGu3/S
	FSI9mhvGwMbWOpGCqn1s3jcbDLFaQzX8vnEu4SfGbF7RrXvBFxsDuOhdAXsYFqMLspxyfzSB3jp
	hCbuhJskNIMO7952a3f1ci1yOTSQ2A0IHtST0BPCxSMZrHU1WobSGtH7pigg9mZR+fvy5o+YRvY
	SckAyHdBt2tRWNkzjTHIWGzh1fgFQtHBK4ozlY8pDC40VUiLdwnjBzgn31iaG5DWJAsohR+y9sL
	9HF66FNClWwag2MbK62GFxIfds992cGLUpOu+JstmGXFtZvB+VFYEyNKc5AzChM/WUpeTZ/Bafl
	AIomykbnZVmwj9vaBYBGIvZsVy
X-Google-Smtp-Source: AGHT+IGPTXiA8UA4+WfFWcD2ez/aP+Nf0BeAoSyjUo3zq3lEFekz/Uq+3yLX6MS444LZrXu6WCeBVA==
X-Received: by 2002:a17:903:124c:b0:273:7d52:e510 with SMTP id d9443c01a7336-294cb5371c0mr44527505ad.58.1761657756035;
        Tue, 28 Oct 2025 06:22:36 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0c6eesm117446235ad.42.2025.10.28.06.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:22:34 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH 1/3] Revert "mm/ksm: convert break_ksm() from walk_page_range_vma() to folio_walk"
Date: Tue, 28 Oct 2025 10:19:43 -0300
Message-ID: <20251028131945.26445-2-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028131945.26445-1-pedrodemargomes@gmail.com>
References: <20251028131945.26445-1-pedrodemargomes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit e317a8d8b4f600fc7ec9725e26417030ee594f52 and changes
PageKsm(page) to folio_test_ksm(page_folio(page)).

This reverts break_ksm() to use walk_page_range_vma() instead of
folio_walk_start().
This will make it easier to later modify break_ksm() to perform a proper
range walk.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 63 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 4f672f4f2140..2a9a7fd4c777 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -607,6 +607,47 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
 	return atomic_read(&mm->mm_users) == 0;
 }
 
+static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
+			struct mm_walk *walk)
+{
+	struct page *page = NULL;
+	spinlock_t *ptl;
+	pte_t *pte;
+	pte_t ptent;
+	int ret;
+
+	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
+	ptent = ptep_get(pte);
+	if (pte_present(ptent)) {
+		page = vm_normal_page(walk->vma, addr, ptent);
+	} else if (!pte_none(ptent)) {
+		swp_entry_t entry = pte_to_swp_entry(ptent);
+
+		/*
+		 * As KSM pages remain KSM pages until freed, no need to wait
+		 * here for migration to end.
+		 */
+		if (is_migration_entry(entry))
+			page = pfn_swap_entry_to_page(entry);
+	}
+	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
+	ret = (page && folio_test_ksm(page_folio(page))) || is_ksm_zero_pte(ptent);
+	pte_unmap_unlock(pte, ptl);
+	return ret;
+}
+
+static const struct mm_walk_ops break_ksm_ops = {
+	.pmd_entry = break_ksm_pmd_entry,
+	.walk_lock = PGWALK_RDLOCK,
+};
+
+static const struct mm_walk_ops break_ksm_lock_vma_ops = {
+	.pmd_entry = break_ksm_pmd_entry,
+	.walk_lock = PGWALK_WRLOCK,
+};
+
 /*
  * We use break_ksm to break COW on a ksm page by triggering unsharing,
  * such that the ksm page will get replaced by an exclusive anonymous page.
@@ -623,26 +664,16 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
 static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_vma)
 {
 	vm_fault_t ret = 0;
-
-	if (lock_vma)
-		vma_start_write(vma);
+	const struct mm_walk_ops *ops = lock_vma ?
+				&break_ksm_lock_vma_ops : &break_ksm_ops;
 
 	do {
-		bool ksm_page = false;
-		struct folio_walk fw;
-		struct folio *folio;
+		int ksm_page;
 
 		cond_resched();
-		folio = folio_walk_start(&fw, vma, addr,
-					 FW_MIGRATION | FW_ZEROPAGE);
-		if (folio) {
-			/* Small folio implies FW_LEVEL_PTE. */
-			if (!folio_test_large(folio) &&
-			    (folio_test_ksm(folio) || is_ksm_zero_pte(fw.pte)))
-				ksm_page = true;
-			folio_walk_end(&fw, vma);
-		}
-
+		ksm_page = walk_page_range_vma(vma, addr, addr + 1, ops, NULL);
+		if (WARN_ON_ONCE(ksm_page < 0))
+			return ksm_page;
 		if (!ksm_page)
 			return 0;
 		ret = handle_mm_fault(vma, addr,
-- 
2.43.0


