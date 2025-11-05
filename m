Return-Path: <linux-kernel+bounces-887151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A3EC3765B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709901A227FB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A5433C51A;
	Wed,  5 Nov 2025 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXyOXnbM"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599DA3346A6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368719; cv=none; b=t2FLqsAKDUMym3oLjVMoH4N2RGKJ+Iv8hzQVjF8X9e0+LfR5ymPA9Dh1kqFeW2dbVKx+oJ5TIEWCawb1OCJd3gvjM/aUgKIJzFZqFK9drJhPgqbp9eZccFvPf+0DBlO1VTF9NkmiE9eiphUWhHNBaCWmso7yfhVQOYEirnUVXy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368719; c=relaxed/simple;
	bh=u/gAyqSUxMX8K7Hu0QsI/GxoItfu1jrZOjfT1JOwcTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhDVo/B80N6uuCSXLz2jdJGyN3qnG+kmbDLX+IrR8DDelOIsIVdl9W2dmmD+ZXo4a9FKsD73e+pUgG4XdlZ7nrKNWuKd4Tre4x7qqwwTcUQDsqzc5sy5v7UYcMupDVOENYYE1KP6SDkF1A9pC0v8i5mYhmAIso7kyPALW6spMbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXyOXnbM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so190281b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762368718; x=1762973518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMA7sw10zzBGTRnd6W864RCQYC44z+Ca26/lGGYhhvE=;
        b=EXyOXnbMnHU6FjpX+iJlLJx/7cCewfa7674wxIvklsYiEL7rETLaEO5JSv/S2z+PDt
         qGnMLH0BT0mWpd35Dz73tVRs6z5Y+cjIlOAf/SrwT6/d0/nZ4Qq911LW2CkHWypNHKm+
         wnQfRpFZvhXlrdQlSIw1lf2uSix0/LDuwoFwc5hLc9/sobqMNOQYYkhF7QTLvCsru3Kh
         Jw5udl+fZdgguvax/7QvYAyaHkaqALjQbQ/1nX4vFifLUmoIg7n9M11RuxXJRUG0PX7l
         jbMGZ+Jr+7gyW3teNb/m0HKliQUd1g+6B9UEX25urhs2QgxBo0VDI/x05pxDJpqkMpf2
         cVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762368718; x=1762973518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMA7sw10zzBGTRnd6W864RCQYC44z+Ca26/lGGYhhvE=;
        b=DjuxLTwGtr4HIVL7HYFKzYA1nnJ+8MG1Pj8kZf7rRTCoGJ79qOrfgTlD+Moa2M3dSp
         zkvYQSsIQ104JJL2QBicIdDpIPgkxlM7jS3++ygnl1fwk2oB0gL9UWQ6V1++UWDmegiy
         /9CucZyJI5KBSKAVe0CdqYw3C4YY8d7s4Q7/CvYtUSManKp1oliHURhHwEE6m/1bp4KF
         GWujyEpr1ufsQX2bYyvgGdQJqnzJIbu09ehd8hC2QIg4lqrexMrgSu7dg2Et1v9MIPOO
         ZAkw6xbjWVKGMx0mQdSe30lv0DGfLK1YaSR2taE8CWR7VhwEbCl68zL613CuCvnyDNA5
         jycw==
X-Forwarded-Encrypted: i=1; AJvYcCVcM/N6E0NExZ0WpZ8G/CdWa3DCaHiY5eOQDvvS6zhtJKoKzUO/Ifgl+L6FlNf8B0wOaMG/FoqbEu5Rrek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8+0NZeIqZeWoCmPCK1WMKUNqf6BGiQ6LOHq5cOGQ3lyYFRsUF
	zrSBwOWNpJT4x/tFWlgClBVVysLvJU15vXBl4nkvVa/n6QUFoAW0ozol
X-Gm-Gg: ASbGncu3iAiERS87GlPIo9XC7vPyL2hLQogkIbLHFTCgYewb8iD8PFzi6stKi1UoTOP
	TnE+gpfOVGz9I2J87e4SRs1zkgrDHR7mr4RbOejf8L4/0nucGPXXBKYxqno1rTz2WNRG1HaThF9
	yzlg8rWSSSJwdVZcqu81czGuY3/egGepjXHKTabqDpPqlzoJJ1rS6uaO1f56S0fj1BbvxCh++j9
	SjT26LADmOzhRBYXtQkUC1aJIRn/DboK+8mOyLqjp17DxUfu0dTBmMAD95f59HZjmI7t6Ar37QE
	+4axEhBzaH9cUt+zl3ugf6g1tjoAmR889cNP32ny83nE4kWU5jAcVcA6MHZyw1vaHpfuuUFh38Z
	I86Z2zrH8w7C3Srt08jtBZe1+XnJp780FRM+vwy2PgT1hgCf56Ave5x8viFc6MEz8IAOs/r+2mw
	/96fWh4fyyVpsiwXtQz2ftCZvgw0Gv9vRq7As416fLLDpy8v+mLs9ilcdz
X-Google-Smtp-Source: AGHT+IE9rlhZBTu82T34zVJihWBAXwztYFNYRmxAoUK+dv/am6Ed9EkYnrQ4cegPPtTom5w0PIT93Q==
X-Received: by 2002:a05:6a00:10c7:b0:7aa:1e36:207 with SMTP id d2e1a72fcca58-7af71c668abmr500474b3a.15.1762368717560;
        Wed, 05 Nov 2025 10:51:57 -0800 (PST)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af827effebsm118409b3a.57.2025.11.05.10.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 10:51:57 -0800 (PST)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	David Hildenbrand <david@kernel.org>
Subject: [PATCH v4 3/3] ksm: replace function unmerge_ksm_pages with break_ksm
Date: Wed,  5 Nov 2025 15:49:12 -0300
Message-ID: <20251105184912.186329-4-pedrodemargomes@gmail.com>
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

Function unmerge_ksm_pages() is unnecessary since now break_ksm() walks
an address range. So replace it with break_ksm().

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 43be57a6a3fd..f9a1a3658ead 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -665,6 +665,18 @@ static const struct mm_walk_ops break_ksm_lock_vma_ops = {
 };
 
 /*
+ * Though it's very tempting to unmerge rmap_items from stable tree rather
+ * than check every pte of a given vma, the locking doesn't quite work for
+ * that - an rmap_item is assigned to the stable tree after inserting ksm
+ * page and upping mmap_lock.  Nor does it fit with the way we skip dup'ing
+ * rmap_items from parent to child at fork time (so as not to waste time
+ * if exit comes before the next scan reaches it).
+ *
+ * Similarly, although we'd like to remove rmap_items (so updating counts
+ * and freeing memory) when unmerging an area, it's easier to leave that
+ * to the next pass of ksmd - consider, for example, how ksmd might be
+ * in cmp_and_merge_page on one of the rmap_items we would be removing.
+ *
  * We use break_ksm to break COW on a ksm page by triggering unsharing,
  * such that the ksm page will get replaced by an exclusive anonymous page.
  *
@@ -1071,25 +1083,6 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
 	}
 }
 
-/*
- * Though it's very tempting to unmerge rmap_items from stable tree rather
- * than check every pte of a given vma, the locking doesn't quite work for
- * that - an rmap_item is assigned to the stable tree after inserting ksm
- * page and upping mmap_lock.  Nor does it fit with the way we skip dup'ing
- * rmap_items from parent to child at fork time (so as not to waste time
- * if exit comes before the next scan reaches it).
- *
- * Similarly, although we'd like to remove rmap_items (so updating counts
- * and freeing memory) when unmerging an area, it's easier to leave that
- * to the next pass of ksmd - consider, for example, how ksmd might be
- * in cmp_and_merge_page on one of the rmap_items we would be removing.
- */
-static int unmerge_ksm_pages(struct vm_area_struct *vma,
-			     unsigned long start, unsigned long end, bool lock_vma)
-{
-	return break_ksm(vma, start, end, lock_vma);
-}
-
 static inline
 struct ksm_stable_node *folio_stable_node(const struct folio *folio)
 {
@@ -1227,8 +1220,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 		for_each_vma(vmi, vma) {
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
 				continue;
-			err = unmerge_ksm_pages(vma,
-						vma->vm_start, vma->vm_end, false);
+			err = break_ksm(vma, vma->vm_start, vma->vm_end, false);
 			if (err)
 				goto error;
 		}
@@ -2855,7 +2847,7 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
 		return 0;
 
 	if (vma->anon_vma) {
-		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end, true);
+		err = break_ksm(vma, vma->vm_start, vma->vm_end, true);
 		if (err)
 			return err;
 	}
@@ -3007,7 +2999,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 			return 0;		/* just ignore the advice */
 
 		if (vma->anon_vma) {
-			err = unmerge_ksm_pages(vma, start, end, true);
+			err = break_ksm(vma, start, end, true);
 			if (err)
 				return err;
 		}
@@ -3389,7 +3381,7 @@ static int ksm_memory_callback(struct notifier_block *self,
 		 * Prevent ksm_do_scan(), unmerge_and_remove_all_rmap_items()
 		 * and remove_all_stable_nodes() while memory is going offline:
 		 * it is unsafe for them to touch the stable tree at this time.
-		 * But unmerge_ksm_pages(), rmap lookups and other entry points
+		 * But break_ksm(), rmap lookups and other entry points
 		 * which do not need the ksm_thread_mutex are all safe.
 		 */
 		mutex_lock(&ksm_thread_mutex);
-- 
2.43.0


