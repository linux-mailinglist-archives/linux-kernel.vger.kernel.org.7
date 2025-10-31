Return-Path: <linux-kernel+bounces-880758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 527BFC2678B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB0B3351BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4745934F25C;
	Fri, 31 Oct 2025 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8J4fe5y"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB5217705
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932926; cv=none; b=P0a2YEtqDCGMTatkyCjxSXOxwVqqHUZgxVCBmUV1HzBB2NBnC00jwcLV7eiA/BbQIjTZ1hKfayRPHr05zmdBeXBIQu4UnasETOjgSfFFyVGPEws6wbAw84GkMmA+GQw8GQeQjvba3ruqAlYtL5KQvTYreFWg6qt+3t5p/01H7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932926; c=relaxed/simple;
	bh=ynE32cVhIxc0WLGtktnzUD/OUTR5RW1yAe38UEyx9e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u289JBj68VNT9SsMhCat1RQL1saQbftb1rlTJAN04nXvjWkIY1DfCemNi94TwCWChE/fGBoBOQMi59TXJBr5yGX5OZGojSnH6qzrj0FohS2GROzRIe6GPzK21j6u2qu52mrsg5fOwfIxIEVfAClr96PPmK8g+QSI0zVfssT4x2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8J4fe5y; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29555415c5fso130515ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761932923; x=1762537723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICLN39FJdVD/075eTRkrmHvRsCawcGixIB7gQzMC3KY=;
        b=P8J4fe5y1VECTxaWv85Wb1pI03DDO8JWVwWfdRE06j2K8jwl6stWzQIxIMWeor+G8W
         k4iNmgmAJp6LQhufi8dIOiSdIuqGFXajrDdFORGVp/BQyL/4kpb7QdXVIrol3kOmHSMq
         5vKBaI0kReMYqo9Zze1cJDLD4a0WqtRbOx8DX8pgycaKppLG4zOlioESzEppaK5PiFAT
         GmXzjHximqdMXeJ8QIvgMpQNZ7rem8thrCjX2F3uxnVKtuhjovu2HbDVPb/ppoYPPF0+
         +Tl236l15f+/Wp2tuaxPt6jUsCvpH6JLQMYuMvpUIVqANvyX5jpOQkcBwp/eSRcOpMiP
         GYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932923; x=1762537723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICLN39FJdVD/075eTRkrmHvRsCawcGixIB7gQzMC3KY=;
        b=OsTHH2nnDUm/f3Q/u1W0S7lnGiEda7UPe+7w5/6V6cOU05HHqQ7wrAjlwnBi5OIPxT
         hW652AKvQmtDdBHf65LV5huO5NZMjQT12BcZvDLTwrRk9D9GxaZvV3KS0V//j9UqS+Jc
         ZsRNIC1qd6GzLgry/2ctKXl+eXSmN0cavIVdIDI9OeQai8ubkHS9U0epoS9KHQ/YIjm+
         QgjtpQGop+jJ7BZ7/CE9UG/OoBwHHLrP/pVOpBY0lTwTmXGKWB0DNq7G9tPAwg43GHXO
         9CxvA20iaLqxvHOCYVF865A0vH0KFw6hkzVudZX3yC9pV+S4xia65kPejARP1uc41xGN
         qvVA==
X-Forwarded-Encrypted: i=1; AJvYcCU4/LOb6hmbh/3ihAAHuqoDgYdh31ffULpgyUbOMaCqd6zkXBrFX/bHSNl5lok8pVm7S2TuKzC1X8NTYs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqqIktsGwksxx9MXQWBAfrxqYAmslj5tBlre1MYUNzH2ADPWRu
	U9AlZS2fKas/H2U/UICXkkb52Dh8z2zZNFdJW81+snPGN3ZyZfD1tKnA
X-Gm-Gg: ASbGncvtIO0ip0sdTbsYGdiyILnTZz2VgiZVu7J3xRKrBHom3brWI/+xikBJXCmj1Hd
	7cWwRtl4giX2j8tQGiG0jDhosJQWwzTXJqhGKZ4D8bbmpZfxADe9JpRNOaIGrB+S4UY9OPpAWvu
	+9KcdySLdIqhA8Ax4Z+33RBzmJcUpMBAg3fChkRhI9Qdf2Rimx8d1Us45AY9q5jhqgVGdqSTToF
	Y43RCy/SYttKSE5+IKZ2p4nvvvSbPbgSdzc3KqUzAbKYVZzCMntEwbtJEuFQYKM0FyV07p6WCWV
	MVOzEjU2Gv825PA2yE6sCedNyQIU9D2qEV4Ro74cNtAS5eJdzfcIQuwebBcoNOzblAaseTk6K0P
	v117203jIXELa+cF1hlpODKEDj7/rZojGVvDVF0QeJy5DCgis6dqNwr16xQXIPem0ETtQQNvkTh
	hc2vRuRQgYv/0J+QsiF++eti+7
X-Google-Smtp-Source: AGHT+IFLP8ni/MiCCDGUKUMnRDX4e3jWK/OtkBZosJW9tmtouHuYrj2fu9vWtsB0S6HQVfeXxnga7w==
X-Received: by 2002:a17:902:e5cc:b0:280:fe18:847b with SMTP id d9443c01a7336-2951a4dfc29mr68076395ad.33.1761932923531;
        Fri, 31 Oct 2025 10:48:43 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526871693sm30113185ad.20.2025.10.31.10.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:48:43 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH v2 1/3] Revert "mm/ksm: convert break_ksm() from walk_page_range_vma() to folio_walk"
Date: Fri, 31 Oct 2025 14:46:23 -0300
Message-ID: <20251031174625.127417-2-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031174625.127417-1-pedrodemargomes@gmail.com>
References: <20251031174625.127417-1-pedrodemargomes@gmail.com>
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
This will make it easier to later modify break_ksm() to perform a proper
range walk.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 63 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 4f672f4f2140..922d2936e206 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -607,6 +607,47 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
 	return atomic_read(&mm->mm_users) == 0;
 }
 
+static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
+			struct mm_walk *walk)
+{
+	struct folio *folio = NULL;
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
+	ret = (folio && folio_test_ksm(folio)) || is_ksm_zero_pte(ptent);
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


