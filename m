Return-Path: <linux-kernel+bounces-887060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DABF0C37174
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C82518C3E38
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A06B31D757;
	Wed,  5 Nov 2025 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyit8yh9"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E990533B97B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363841; cv=none; b=J1qkyK554TwZ/OnUgVEeAwtqCrce8H+88dnr+7lOE9XWWehYektWWZG6DZS1aFO9i277gpEnMZ2tpOT3sdEqDC5J9s99fu4csjuRt6zVJLNQABPhd4dkjlSxWEL4ZoX59APmnt/PhVDvDhOHx4ZdwoIaKJ+dzsymsd+SBYAZYkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363841; c=relaxed/simple;
	bh=quGAGyZ78djsPo2+I+REOlFLU8wZEyYPOcHKcfLEtww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaNBQd/g29ppTy4UBGcF+kNyevcJo+i243VxKa+k0sQ8CKVPNxNv28ySE7FSj9MXrmDexVMhppcUy5FO5IOvjtL62NmsEGLWJgxsY7+L5666fseZiqhs/VtknrfunlRXmkL9vlbG21/OBmIEp8y4fOgodmGGhoXK4kOeK9oMC7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qyit8yh9; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c5333e7099so4150122a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762363839; x=1762968639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtG8m3lKC5YzUVxybdhftXK279x1q4y+tfqJb0ojn9g=;
        b=Qyit8yh9n8KtGvhEdAqlGxkeDSESaeurDnbd0ZPpSnhPQjZLbDVcRi5st0ajQS5hr+
         a0AjtPcWh7DzAe8T4OH1/5fYq3PiiQWWzPyUbUzHkIiPB7kmXdLlqNMezh/kJXUHLUWa
         LXGbapvUtkz9y42GG2dR/AvRX8cryeeI4EhI6wzylAoBKV88zyq45zxL54zBYseTiDT+
         SojiEOnBxWxQ+qT4YoXz+E3FFPu44Yc7PFSmKxRPNPoHoCZTQ6otmOngE2+4jj62Anaz
         gPTCEIIJeuVlle/Ck554dO9prjIVP6Mplspj6Bw/XcjclF+aHqUvljVrP47cbWTq00Re
         iTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762363839; x=1762968639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtG8m3lKC5YzUVxybdhftXK279x1q4y+tfqJb0ojn9g=;
        b=a53EeqBtc63AFOBg62y5bbLe2SxRTNycL2dFjGFxN9740Fp3lfFX1Z25ZWJ1utVy5B
         kh1otlP6Yuw68NR4whZmRnRh7PcBAQfcIUqg/zQ5lF9knewI6xdMZ8OZguSt+QfUgX+J
         w42uxynaVbkGU0riIFuqQieSgtKXBlhpDzoTonMXRYSVeKxMQ2g/uxewrak6pCoAoJeu
         4T/JgDd2lvejYwJ4NKCKN0rI7Nn152i0NqPkUE4dQibCCgI7myovyvVPmJWML0V+I3Ex
         FvI3UDXbMdRx0ayUHpezeTu5d4y3bv++QX+L4GqaIZ2OCTKgIn5P58VlVT2kz9Lqio4R
         M8dg==
X-Forwarded-Encrypted: i=1; AJvYcCUsS5ZXfETfkd/ubLtC8bH+1R9M30ntiCleImjtQHnvZov7cOOENQJDua2axUYpk5QY5GJZhbIr0rGTeHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQBjB8fcnK8FVunccMkeNW1mWUNbf4+xUcGKRHWG5u1yGBznDJ
	1Q38+unyPnvvzqV8LmwArw6Um64y4r1xY1LafinjQO+45wjH/zcyRQJz
X-Gm-Gg: ASbGncsVkFqpy1n/KjWIjSKfwWI8oO6xuJCwHaXeGU/hflAU7HPwv+DbYU1fM4uDyfE
	ooIEI99ttePldBreFP+pTorYxoIOIb1DoP2NGpCIenWWoGPhDE2O8D4jyW/phexq1OwkNGZt2lh
	zP8OGf4oaw9lHIX6x044FwLSOJrCQ8WihDzsqagWv2l3eJIx9qHxocGe8yAyuBWThsEHSwPJ2rJ
	0EwXg4BONSoTzvX0yENtR/gFDSpY4M4rsmC0mv2fURwJ1iAqHiplxa8hJH5OGyD4pMAsS3IDQq+
	sgncsQHb7IjW2X8gctyEJ/+7A5X3wAZgXUc5DR7HtosfrKs5h9fey5th1WNx20L4LLjYxGNhi5i
	iHXsX1krPzR/zNq4goyqep+YTzkelkyJuoNpb+hFj9P+8Hxbl7LelZwtzlOPqnlw/AL7p4PNSrS
	2LJ6cmK0ytUKNoV67VuPgoEt3nwaM1D9AjkD3Bu4IflTt+0X1zU1Ru9HiI
X-Google-Smtp-Source: AGHT+IFsqa3f21t/TPiouRwC1NNyll3RzLZxNHIyUXMLTJDkC0oghDxR3kOoLF+y4ihKIeUnycY3mA==
X-Received: by 2002:a05:6830:3155:b0:7c5:411a:9204 with SMTP id 46e09a7af769-7c6d1106516mr2563202a34.0.1762363838805;
        Wed, 05 Nov 2025 09:30:38 -0800 (PST)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6c25108b3sm2248313a34.30.2025.11.05.09.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:30:38 -0800 (PST)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH v3 3/3] ksm: replace function unmerge_ksm_pages with break_ksm
Date: Wed,  5 Nov 2025 14:27:56 -0300
Message-ID: <20251105172756.167009-4-pedrodemargomes@gmail.com>
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

Function unmerge_ksm_pages() is unnecessary since now break_ksm() walks
an address range. So replace it with break_ksm().

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 5fe3d9c2cd20..a78346bfeb91 100644
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


