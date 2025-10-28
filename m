Return-Path: <linux-kernel+bounces-873820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC97C14CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57D75E2A71
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97C42FD1B0;
	Tue, 28 Oct 2025 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpHT2uwk"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363E311C39
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657773; cv=none; b=EJc6NSgSzuVNQASC4AeYkC1YkrT0Ij4JxqU28PzToeo4CCNYiN5TkvM8RF3WhGt1ZOY+De5zO7y4aTQMHWnft8fRamSNvofWjUjbkUCPuPkeQCnQzPmRKkJk/IAoAxGawu6EKqPmAEbDDpDUQSeJ0Q1QDU/O7JAN+8RCsPPFx+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657773; c=relaxed/simple;
	bh=kd8QbGKjD1tQbzXFq8tvaq30cEyG7L7KJCAoA6QUGxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iW7T474z0a3HG69MjjvL5BzOLWUTPeORorSCU63Ds3yYkG/4MUpNPyQfarEKThyFuSkMJNyXnTlig20r53zGYUydIhkiqvWvafyc4UKNlDufayWDnAusjr4HXKgobzanGtK1WVfVWLVRR9POITVD4A8t3E36b0zpzaXbPgfg9/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpHT2uwk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290deb0e643so55319045ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761657771; x=1762262571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8hdoqzDw0ciKJ5R5py/N5NF6XV/5atOOkFGVbOI51o=;
        b=FpHT2uwkcaI3eyMC6OLE3aOcmtHBYs1sfEWUAHQSiqrtZlMI7ds4ACGvZyjUEpmDN7
         OXBFGPbCSuRVfImiur8taomy9VFZHNRUWVhgecCViye6/XnUAtd4+sauLxrAfuWc+u07
         U1ZCPqGbHPdOCkieTPJyBtbtKsq/ktvHTb799gNL44/eID7Wzh+YUou/XxNbjIBzJMAJ
         4z43aPrkepDCjG0zln2LnIqRe1swLexaiak5ltLPTcYB2HGcxIyyh+PlXanMlUzJ7OLt
         oegI1WNg+7V8eDL7xp/xyuimenr2o6GtmBNb6OBentZF7n2qbJZo4OI+SRq69rokJyS/
         Z6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761657771; x=1762262571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8hdoqzDw0ciKJ5R5py/N5NF6XV/5atOOkFGVbOI51o=;
        b=gMzn7yLxIbgIr7lt09P2ZlwDyj/F9K4i+IsJgkmmwTHebvN0kiCmg5dvycCz7MR0QW
         wrkTfRZAEnvnBc+O/xB/+NCik7sWY/anIIdt3dacNGNRkZpV4erZa8yyl8MRebNt3Knj
         lq5hwkoEMMcbeWy6JcjFrnSPlU0TgPygRLDb5FaYo0pKp6QayIk0yxXUZIK2D/OOxcdY
         VbFI2ovBymvd1rImNDfWgR0weWrhnWCwirLDjhrpq2MTH8zryl/32oWqgkRDcqscHKLo
         Z+2IlgUW1nTeGjZJmOgdPnQaWy2n0Hl77MBS0nDvImUjEtsaRiewwVW6cb8UugxVuBYi
         pbKw==
X-Forwarded-Encrypted: i=1; AJvYcCWNtIikvakdOUznOUE4N34mevjBCDcKsBg0BrQANKtCtnN64ukI3J6hRB5Gvyf8/dj982DhmF6ykkoEdyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFK4Y9dXvO4sKV0O67fWCRXbDUHv/0MEAL9wX96gsj+7xVwwW
	dtn3WPqMCMxKV0Ezm9qRkwrcWKg5JszRvX9DqmpCl7bgt0YkYon83DwZ
X-Gm-Gg: ASbGncvPVFd21h/H0aOmvA49JsZiU/sI3KDeAnEP3k4pPk9sQF31Sv3I4tdlqJVpGvw
	/mjNjczfw4KUNjwkC7Vk/JudIZJ9vBrKddQUmEtHZRXk+QAZ6pca+FLJln/iuVWioxAKcwte6gB
	7E/zTR/Dfhd+rC+IcGW2xItZNbl9U197vy8Uhkd0p/JOhCv7y1lfxM4/+HeC7pJwqfHRoH74Cg/
	3Ydk6fPcE4Fa3+SvrVgnmUI0ax1Q02xN5s7g907LC9DWSdew/W3BY2DSyZ+B0ffaG6hXe+XGtjM
	Vq+rHZAnN47CM3tuDUq7tNyS4cJ7SPMGOQ7krsE7BTor12Tqbp5/3Y3laHfj3zt7rfQMG117Out
	u99yLfhkC1sBZy/RxP8Ysc1O+bCEb2YliuJ5Qi0KXiFjpcubLtOonG4D36syQsKT5nNn7Iscd0Y
	S4dFEynOxK6a7R/bVwoWjds80l
X-Google-Smtp-Source: AGHT+IGvfrMDVGrg441E1EtxSS6ZivFeFQGgm+/YRUqoXlfT71nRhB4BmF1WcXFrbzSBiX2fpHfJEA==
X-Received: by 2002:a17:903:2f0e:b0:290:c0d7:237d with SMTP id d9443c01a7336-294cb50e4bbmr45976505ad.36.1761657771357;
        Tue, 28 Oct 2025 06:22:51 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0c6eesm117446235ad.42.2025.10.28.06.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:22:49 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH 3/3] ksm: replace function unmerge_ksm_pages with break_ksm
Date: Tue, 28 Oct 2025 10:19:45 -0300
Message-ID: <20251028131945.26445-4-pedrodemargomes@gmail.com>
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

Function unmerge_ksm_pages() is unnecessary since now break_ksm() walks
an address range. So replace it with break_ksm().

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 1d1ef0554c7c..18c9e3bda285 100644
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
@@ -1077,25 +1089,6 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
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
@@ -1233,7 +1226,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 		for_each_vma(vmi, vma) {
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
 				continue;
-			err = unmerge_ksm_pages(vma,
+			err = break_ksm(vma,
 						vma->vm_start, vma->vm_end, false);
 			if (err)
 				goto error;
@@ -2861,7 +2854,7 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
 		return 0;
 
 	if (vma->anon_vma) {
-		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end, true);
+		err = break_ksm(vma, vma->vm_start, vma->vm_end, true);
 		if (err)
 			return err;
 	}
@@ -3013,7 +3006,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 			return 0;		/* just ignore the advice */
 
 		if (vma->anon_vma) {
-			err = unmerge_ksm_pages(vma, start, end, true);
+			err = break_ksm(vma, start, end, true);
 			if (err)
 				return err;
 		}
@@ -3395,7 +3388,7 @@ static int ksm_memory_callback(struct notifier_block *self,
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


