Return-Path: <linux-kernel+bounces-887148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B11C37649
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A080189B6A3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9BE307AF8;
	Wed,  5 Nov 2025 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPlYf+Cl"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939C2F8BF4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368709; cv=none; b=GUrNwAySfhA2/fkAOrEgk3EliXVjAMgfTMV3vBQSug3ecSScP1CnMWBJHj/4gnzrNbuwQVtzEuGtPFqYTWJazOCjlL5zRSWOJJXD2zfl8xHiqfjOHNoa+ECYH5VlTjd4hl24QMUDWhO1khE7NjaIlCxoG0d9jwL6oz5OXi0FY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368709; c=relaxed/simple;
	bh=HlEe6xr2wZUvTY9nVvy2UqFgREy4gnaEsg0EhE2v+f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7SXkT46BQFov5NGPh6w9vP2mLQZy6erWRJ5vKWTVNTkngi/5RteGH/ytmOFuT7Mk38sG5sX+LMpWeYXftJeeq4qbuCu5ED9cqqPOMg48HQ1M6RYeUuGUYE3CxxLvOrjsLTl7RFbQFgX39N89P7VxxeOcdyWnRa3F8Kyown++fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPlYf+Cl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a9e8a15502so222807b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762368707; x=1762973507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmLEmnzV4CrNqkySbGU+qJrkaecvk4DLsCPkYeJhZjk=;
        b=OPlYf+Cls/QME1MnPj7pToCtzoapx65aIHjPd9MXFqf9xKvOlhro+DIf2l8jRavN4K
         Epxv4dzwFoKUAiBgAELPIbn3qQlya7dXBPAZejLXvI9U4oUaTVp4DM8LiUXCFvPOz7QA
         v8fJ19msp0jNpOM5ohNgMFpvGWdqAkdVuUwrltl65WDxWUxPRDkBEEItcRnXOzG+n/+/
         H9RwEvEPXMceDac8heuuT58+nTBnd6FzRqsHMfEe9W1YpV8rqITZQH+r7/hMcOa8X42z
         sW61Yi6MtONRitZ0DksqiYzcfF+XnY2+1Uz+z3kvFiH7j5xK4xOKTXKA3kysksUwM81q
         8Jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762368707; x=1762973507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmLEmnzV4CrNqkySbGU+qJrkaecvk4DLsCPkYeJhZjk=;
        b=OtDhlHWXKGcYZohy4Gp+ok/+dIidoiWQcg1RdRhtbDjwEqKmAf/4M+1nRGD+UPqcah
         4a6LOX9hXAOEgFB0dyEIkW/OYA3l656OSbhTB/bm+bmz8QGbC2e/xeTW76As8BjUJUy5
         7gH/y7A4qRAOeYR85RD2+VizPKfUAvDWDjsuQcAJo/cg/hXyiSZn9vwLSb8bSDXmUXoQ
         kOy3ZKstBNJwdexnTHUHYcKCyFBQWnKtFVFgCYam09f6Shoz9sul37D1sy9NryDK/Ju2
         TNoJFILvvTmKGrXYCPA1mtoej06bv2NW2xKJpzW63lSDAiUwHuwTcg+gRYdgoqnE7jre
         FeRA==
X-Forwarded-Encrypted: i=1; AJvYcCWiiwyYtiKtdT/skzScVO5qUW+LHH3+aOREBUjlT/DiaX4dhGh9hsVTscdEzgs6BWfYmGp5eBkJrQ0zcTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzglH4S+SCebt90uI0gfD7y32PSulETWlisjq4tW0GPmr09wj7x
	+MqpVwyBtXdVk3c1L5O+opK3IXIifPyxeJcuwEtQatlAOI4/NaeVv3PC
X-Gm-Gg: ASbGncs7167QLfGfXdW9esBcekqTDYw0+GUyeXIsZqm7euI+6BO4085EsdNi3uxivvz
	qSuLWjMrlaRZvqJ+TDjxVaCGFdqmgc+Zg/5L8nvXPMK59KTe1X2WjqHZuNZCW0IP6GQGHyY/i4R
	drb1TGUwuta1v03JemfzYH6SZPTfva6SJiWKRVhwEfoDBGFHJH9jag8hkQYm7IoVGGP+yiHPxLG
	nPnaaF1hRRMrquU+yYI9BxKaeIN4C+9dII5j4OIvTwCenPewg69w6AJx67pkCzUDkBBg6t30k+m
	tmWfKPNRr4ZIIFxkvOH608TthoR6vgtYRv2Av7lkFp9ImxYO1IUBtjtS3Dth0qe2PxzT+q9c8CY
	o5vHSmFi9B7FUkC2x3UygJ/8iVHcJTE0VM538lnm+X8rBz+MHx/8mWk5O7VGNUiabuL+NaoA9Ea
	LK7x11WtJ3h5RChc+1yXAcAnP1X67b/zikLqk14PI70xUcV4e/9SlFIJsL
X-Google-Smtp-Source: AGHT+IEyUJorx7igb5KOutnZidsynnr3yECYJZmO9q0c+o5+U9+fi/41fwXrPf0Q6XYPeJTYKLVFmA==
X-Received: by 2002:aa7:888a:0:b0:7ae:d1d:d500 with SMTP id d2e1a72fcca58-7ae1cb64cadmr5041801b3a.4.1762368707099;
        Wed, 05 Nov 2025 10:51:47 -0800 (PST)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af827effebsm118409b3a.57.2025.11.05.10.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 10:51:46 -0800 (PST)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	David Hildenbrand <david@kernel.org>
Subject: [PATCH v4 1/3] Revert "mm/ksm: convert break_ksm() from walk_page_range_vma() to folio_walk"
Date: Wed,  5 Nov 2025 15:49:10 -0300
Message-ID: <20251105184912.186329-2-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105184912.186329-1-pedrodemargomes@gmail.com>
References: <20251105184912.186329-1-pedrodemargomes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit e317a8d8b4f600fc7ec9725e26417030ee594f52 and changes
function break_ksm_pmd_entry() to use folios.

This reverts break_ksm() to use walk_page_range_vma() instead of
folio_walk_start().
Change break_ksm_pmd_entry() to call is_ksm_zero_pte() only if we know
the folio is present, and also rename variable ret to found.
This will make it easier to later modify break_ksm() to perform a proper
range walk.

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 64 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 16 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 4f672f4f2140..9f74baf01e46 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -607,6 +607,48 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
 	return atomic_read(&mm->mm_users) == 0;
 }
 
+static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
+			struct mm_walk *walk)
+{
+	struct folio *folio = NULL;
+	spinlock_t *ptl;
+	pte_t *pte;
+	pte_t ptent;
+	int found;
+
+	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
+	ptent = ptep_get(pte);
+	if (pte_present(ptent)) {
+		folio = vm_normal_folio(walk->vma, addr, ptent);
+	} else if (!pte_none(ptent)) {
+		swp_entry_t entry = pte_to_swp_entry(ptent);
+
+		/*
+		 * As KSM pages remain KSM pages until freed, no need to wait
+		 * here for migration to end.
+		 */
+		if (is_migration_entry(entry))
+			folio = pfn_swap_entry_folio(entry);
+	}
+	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
+	found = (folio && folio_test_ksm(folio)) ||
+		(pte_present(ptent) && is_ksm_zero_pte(ptent));
+	pte_unmap_unlock(pte, ptl);
+	return found;
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
@@ -623,26 +665,16 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
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


