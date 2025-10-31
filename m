Return-Path: <linux-kernel+bounces-880760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEE5C26794
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7867351D12
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6327E34F270;
	Fri, 31 Oct 2025 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRAmexoY"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3CA309EF6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932938; cv=none; b=Rt+d+PEPfk2F1AcEuJxKH4vrHlDv/iDVGdxngy6YHvXocYDbNHoB+cQ/3MOwF2qmm9BFlvE8u9UUGgE3IKVJOg8OkD9UpVAENy03l71SlRkILpIZVxzdy7L+aF64PHaeYrr52FdkltMLepJULTC6DlbUldiGGhAgxEX3HzDKkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932938; c=relaxed/simple;
	bh=8SXtQpPzzR/08szjDRCeR5eiZXk0L/vWm4qKLnT09G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIm04hdcbNcjgyTEd7ATvnsK88bWrD35P/uXKAXpJ68ZpYc64u2SVvVmJ+6dc2DTr1Ufhi+Rvjw/3+p3fIVzXgrSnYnBvLcmgTszMK9jq+wBJRed8CfA6sTnwtRUH2kyCri8I8gsi9z/m6Qpx8YE4Rs6C2ulE9Jug++V/p4bUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRAmexoY; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b556284db11so2071200a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761932936; x=1762537736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUPskgZ2IwxfUAiutZm0xbNgmm0EpWQfATFCqCIntuE=;
        b=TRAmexoY2yAMZDFwq2O2wSQVHw6V7ZmzXFDfIimckUomQn18n41uKyM+l0IiA5ww7i
         NlVYpAbTy0LYeOphbjiB9IbJAkKXX/d9zyaKKFO5hw87/MjXemkprQs97FeUrbN9qu37
         I4UIjtjCYAJLds6BB/FjvLXxwjJHGvsN3FUbiyXTbNcUr8ps6l5kDb/gYnxgBZ0myiHQ
         p/4x75gzYG3dLWwUznWYbsAymGq1NqQv0lK+b/XsvpU5L/an/Lvlv2v55NA5HB97ntzj
         Cz2pKHTl5L3n1GQ9dkuX7L1llwJwX2Uljt+Kh5V+Cvzz6b6TN4Z2ym18TMMNYC8uhw54
         4jxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932936; x=1762537736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUPskgZ2IwxfUAiutZm0xbNgmm0EpWQfATFCqCIntuE=;
        b=fJ2yfGWdi53omL1FS1TYcRMDt+K5T//kJIWJdp6LT2Chg7kLEwybqbVbzPoMPs0b6/
         YeWYx0n8QkX9RVu25QAe+m1Q60QfROwRtCxxA4wQlSwM9pfHyK1dOWRYqdTRqYQfT6Zo
         g+sovZ1+fMTd11xfkTDgUZMjdlR8ef3O9yXrwuZkpavjcFK41gKk7fjJl7atDldEaC/O
         ulnz6MjqjSUcZSlR4web9xPmt275Wg6YABDRWTdI/WdYNxdEd1SwHrwmnOM3DZ/n2Hzg
         Nkc+CD1dDjsjSC3Dacxs8dMSGIYQY1Uk8dTfbQtkN51P3/eTFR8XELUmYb+tFgIkcFy3
         BCcg==
X-Forwarded-Encrypted: i=1; AJvYcCUQHl7NQIXHSiIgwaGQMo0Pc/ZXdLkTAmVKgWb2svcFJ2vZUVmHVu8+E2yUjTU93hx+GRRHUBNNkHglOfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo8FiGi3/UOQP3WtGEgLCmgGHVZv1nK+F74rvTvevWVjI0uYs6
	AGM1PCB/h7+NL2xPHdcnWdwR9Hchte+V/UMNkdKH5Eb9kPzuI6ia44di
X-Gm-Gg: ASbGncubxzSHW0Uf/mSEx/TurEZ9ksAQMTLeaq6K4sf0Z1ypsWzyNUqYCJkxIyXddVi
	fFkWJNu0+R9rR9XXZinc2rvzyyKe/oQ93C7HA0XDF7tDUq/qdrBbVQpK66pcpkY49GDWhWR7rH9
	+JXM37s/JoZtKkQVs7HzdWgzYa9fJMCGj4CIarXyH0Q43XsO0+FQe77JM4ABi2fJ386XV27Ng2V
	vSFABFi5acQEuTL+dkKCJQ6Ab1DIEyfU9ddM4xDFA4mBTfLv5RdRrRjSX+fotcj5nhsZUHjhZYH
	G6wdL9hjuTNs0oKJRPywElR5xzyx4dGOtxHc2ltgeEBTYPYcP81Isonw/mHltdAL3Lk/agGZYyE
	nzE32Kj2HDhi53Dq4ugcTeLdh6M9vTKdJtpPd078+XbbwLltt6/dW5yttLPN9WS+P07KY/uozrM
	N1VwvRxsZePlfik5QcuZYYehMP
X-Google-Smtp-Source: AGHT+IFhSYtCMU4JzYA6EJXN00Jwg3bj+x1htmVLhTklDNpuQrO6NhH17BJNDWBo1Bau8BMQrknvKg==
X-Received: by 2002:a17:903:11c3:b0:290:c5e5:4d90 with SMTP id d9443c01a7336-2951a524561mr52125235ad.42.1761932935457;
        Fri, 31 Oct 2025 10:48:55 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526871693sm30113185ad.20.2025.10.31.10.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:48:55 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH v2 3/3] ksm: replace function unmerge_ksm_pages with break_ksm
Date: Fri, 31 Oct 2025 14:46:25 -0300
Message-ID: <20251031174625.127417-4-pedrodemargomes@gmail.com>
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

Function unmerge_ksm_pages() is unnecessary since now break_ksm() walks
an address range. So replace it with break_ksm().

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 64d66699133d..7cd19a6ce45f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -669,6 +669,18 @@ static const struct mm_walk_ops break_ksm_lock_vma_ops = {
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
@@ -1075,25 +1087,6 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
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
@@ -1231,8 +1224,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 		for_each_vma(vmi, vma) {
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
 				continue;
-			err = unmerge_ksm_pages(vma,
-						vma->vm_start, vma->vm_end, false);
+			err = break_ksm(vma, vma->vm_start, vma->vm_end, false);
 			if (err)
 				goto error;
 		}
@@ -2859,7 +2851,7 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
 		return 0;
 
 	if (vma->anon_vma) {
-		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end, true);
+		err = break_ksm(vma, vma->vm_start, vma->vm_end, true);
 		if (err)
 			return err;
 	}
@@ -3011,7 +3003,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 			return 0;		/* just ignore the advice */
 
 		if (vma->anon_vma) {
-			err = unmerge_ksm_pages(vma, start, end, true);
+			err = break_ksm(vma, start, end, true);
 			if (err)
 				return err;
 		}
@@ -3393,7 +3385,7 @@ static int ksm_memory_callback(struct notifier_block *self,
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


