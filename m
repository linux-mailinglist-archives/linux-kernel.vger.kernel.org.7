Return-Path: <linux-kernel+bounces-887058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAF3C3721F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EF9F5078EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2519338912;
	Wed,  5 Nov 2025 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA0RpS2s"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776612D9481
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363822; cv=none; b=QU85WA83Vl1YlSMKLacnh7PzUB4RHirFE8drUQrxRUYQDc5cpdfFewYVwmgya/aXicEAHOVmiAaDxlTiMFjGiKqk85+9ABkfrruOCkygme3yLkgwSfUzEjJ2VSp19CkNb2TFxFbJLAkOktjVUivHptVEyMravRj14LEMx+UGc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363822; c=relaxed/simple;
	bh=Vw3oDB87MEUxRUWFvQMjoC2affq/wtOrOfd1yATVqF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSJRRFueokUO76bW1B95JaSgGz5HzM4xni4T46/alnAP9eK26citGYE0jrEtInIUQMJyYldLE7VsUm/z91rslyuGNggs/46+OPTW3TZ42E4WLhK2WfAr2CI2mL+WmPZ6HPEqKZUTemtfmk6yKSehUhK8ndJo0w3dvsgDM+jVSME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hA0RpS2s; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c284d4867eso1945965a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762363819; x=1762968619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/i7MZkNHnwcGwYWKTXHoQSCF+TqXVB+QQ7fHjYAukA=;
        b=hA0RpS2s3Y6gRNhwvn2lmC+jUO4VqBA+x2gOtqe3r3rOMy2D6Q/ETxCkd+fn683lhI
         a/LpUwDSPBn2mNmHKwLaXT/XLCH4uYwGQO4Z4wz5rGCtm307Y0VStdSTfB+I48VFmCbI
         Zi4psZXVDY5d3C4Xz4d5CIjpcPEvOAO1J41oDU5mVu2rWLukzu87FRc0MOxCmcYnPqtC
         H/GGWx7X3mOhmPD2q0Tpy09E8oJCvOa7GurHBDG5ybafKGwW/flezz6Rq5WlRi7LHVJX
         N0g4yuL3kIyGmfC37LZVbeO9sQBaQwBPFrqHm2UJmB9AgUiyKjxFUt+MDn8hmAPCawSk
         YM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762363819; x=1762968619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/i7MZkNHnwcGwYWKTXHoQSCF+TqXVB+QQ7fHjYAukA=;
        b=c2UUjiDFO8VngJ9smg0DVXCpnplh7JXxcNmT8BE1Mjn2uhGsAikIXGCzuetmA25wIx
         RcfrN4twRrENGiqLEMBpVBME38Ilo221TZ5iv73HC4Dor4IlXU3yF+hAOr30XhkKcWbH
         0R/DARTkUygPOdLX/PDQt//kJJiuVf1r30X4maaUw+SW0Th4eUVY6kfu3VQzuLgaMvVN
         dpWCvsGBZp5WEJJ10tU5EEav8KgpnsnJfLBm/KaUQi/JOfWKh1dX/hI4l4VwmpDxChe9
         9tK/48w5QqB5N/FyGQPyru15u0kfo/SZ1cEJzSAdEUqG5kbhJNpPyrGKSd7sRVUNEJrZ
         bIOA==
X-Forwarded-Encrypted: i=1; AJvYcCXERdgKNXH1P4GAKHHIR9+XwXO82blNG9VgsI+ZX7PgY4QWGSAxO6Zbi3+1S4A9oqCPXcXKF95zsfjygto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGWqMQu7jjRjBVSDAOPsPZTrlGjkdPka2RaXn7jvfatLRzuM7
	DCs3pZ6vlWfV6QHGOAeXCPG3bVfipyBycvh9Ej+h1AKHErhjW9YWyi6/HS8Vhf1tDyc=
X-Gm-Gg: ASbGnctMlCjjawcwKd+lkGdWhl2IauaMBoLhgDDDnp8t/BOWitsSRcBEMbtptn2JMHn
	cIwWAZt8KpicMj6CG0TAoUOVuNWIFKenO42wbD7qcxdnNbmDSAyA6oUAvdfJaVsC/EWIAgfUbHL
	hQOJiYYpc9spEEyO+sF8vr4KnTXkKnMspJ9o/+FxxQn/IPv8bng78pSkcGUSoBvcGc//GGmep8J
	DaB3alPfJ1UlDCAVQ/kOMPuYcDrYHWZfwx4rrIrS69WkhpdJ5rlII3avVUpQT7W2GQdEgbyWZBa
	Cnny56WyhalOy9nk6XenE584l5oaqA5euZDo9oRxq6jeoset9jgZLIOsoWl309pFg3llznJkdq4
	KrnKGwhfzmoi2Bdxo4po7pZexWXrL4jnSpOBG6SCWhXAoWcYfw2iFE1K7hKQ/V1ypO7uJYmlVV8
	sIbfZbtMTM0gWd1Dl6jKPH8yQXmQPHcP1hyT62f36mZtyzn97NP+Ag0t+T
X-Google-Smtp-Source: AGHT+IGbfNFoEK9x1jFcWstI6BiHgzpe4FTe/whRBvh9s/FjxTvOCYLIbaIAvuJbi6r52ipnPV3d7Q==
X-Received: by 2002:a05:6830:620c:b0:7c6:8c48:924a with SMTP id 46e09a7af769-7c6d1498595mr2812045a34.25.1762363819369;
        Wed, 05 Nov 2025 09:30:19 -0800 (PST)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6c25108b3sm2248313a34.30.2025.11.05.09.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:30:18 -0800 (PST)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH v3 1/3] Revert "mm/ksm: convert break_ksm() from walk_page_range_vma() to folio_walk"
Date: Wed,  5 Nov 2025 14:27:54 -0300
Message-ID: <20251105172756.167009-2-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105172756.167009-1-pedrodemargomes@gmail.com>
References: <20251105172756.167009-1-pedrodemargomes@gmail.com>
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

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 64 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 16 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 4f672f4f2140..de10ebcf3509 100644
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
+	found = (folio && folio_test_ksm(folio)) || (pte_present(ptent)
+		&& is_ksm_zero_pte(ptent));
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


