Return-Path: <linux-kernel+bounces-876620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7C7C1C312
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94D265A52EF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8D934B41C;
	Wed, 29 Oct 2025 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWAkDcQA"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A15334B42B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753563; cv=none; b=Y10EXmAhH9rEWIxDfuyCO8f45kvafvwj3PTz6tFzN2YTvpfZ/8s6cMvOP4UCnFsz8ls3kQWEgQNsclUmWBhpFlmg/oQHMDd7FWVmntDu1SgXDRLk1pdqfxPRI5di6st5WQH9kQMmIV60gPgoPIieZYWZS72UEJ7AHBxUOKIWToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753563; c=relaxed/simple;
	bh=Y/8DN/bVrI1N0QSXJW/59K8K2Df8jsrwORtU+9uAPmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3Nks/hRWTEAG6ROReh9I68b/69NyuoMegTNRlFsrSaNEbiFHbd0KniVMuhivJWOjDA3tYtxiUQZWUYeRIZ2eG18IQvL5ubk2PR4rZQRatguvABzAr4suW0Ojt3CzkgLKYtd6UV1DCnLc/M2lge0/rNmzbNOlTBXtNVA4sB86vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWAkDcQA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34029c5beabso89487a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753561; x=1762358361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndK9rgLMnW0lXi4W8q46Dx/IRDzQ0optlFYL4qNTikM=;
        b=DWAkDcQAQJ37dTyCuA70uJMwJlo+V5ZUDe4FJ+oB0zCcbzdcvXwgc5rTqOqpqu8qkO
         8lJc72jGDG8az0L47RBpyT4DKXrm0hUAbU2xa/JQxqoKuo4JFBK0F8KZnyOdjhi7niiH
         Q2XmBvDcXcIwJM5NjcBj2YOKwwHwZIcTjTkf0ZhA/EjoPEslwV+0Rxy4bri73R1+dmHh
         K2NiDZIW4RRBhg503h7kRqUuSOswdBH5zN8H6hup9usyLHauDWHp5R1Bw5NfYhEPPuv6
         XooiW/3xSxur3xk4f+T7KB3wvtfRx+BTxhdsS7gBktefNWrVPLNUdp6j4BkRWOBh3p/9
         qDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753561; x=1762358361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndK9rgLMnW0lXi4W8q46Dx/IRDzQ0optlFYL4qNTikM=;
        b=pbXZca9c3ehUkGpMEPvaKQg2JO+dT2oequBV16UVy2M9vPWuFZ311uIKkQ6yqw0609
         gFAaUYt9x1TugYMYKFivlsFysj3De6EILxnb82hRbfSG6S1uHqwCrEI1y8hACJNAeLdg
         qv+ZdQHTQ3RNpWKnu7rBv9k5WlcHZF/rrnZXmwYt8mnGszBMUh6ReK6fV0p/egvhLjcS
         CmJKXcfT76CIEh0mQHJL14ZgfH/iTXBmAs8+1NML0JlljzDzIXe8x86LY4BD8e0z8dcy
         1HkqZRR3Nj8iFx5mZABEql0GcPkOvHGFS97BDiije0S16lqnckc4TJAPVlZyMT9WqTkz
         zKvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+OlgxfZBbWFkGDbI6gAZSXYg0Q9RLjFGg4GzlwSwncZDcBl1wuXXJeIlkfZO47bsED/ZYv6K2h++fpE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvuoKdocTR0Yhm0zRJ1yPdDRrEJo6Tsn+otvaQnh0Ioe5/cAG6
	ALIZt/6Eav2GfldidneNoBsne4Buu8tB2TIL/yNc++d3rDSFb6BuGgZh
X-Gm-Gg: ASbGnctrmrhuJW1Q9DCmXgUqO2+5taiF58pdzM4d3/EFmCJPFLmcJwu3H8iOFela69k
	dTi7IEmvMT9/Le4NXrN6zTIKdE120ZqgqAfi3q/0OS8HtqQwGd3SaL9TTg8uWb6Jjl8gCeUWiGw
	ng7pE3JjgXmy1gPVOaFTNUb/IAr2r9gpTYxCHuGu93TMzwzqhERfipv1j7ywBuQBwt32zHVkLau
	9onj/2NF/XWMMjRVIe7kvZyO+XyycWR+oTzqa6S1lh+KveaT2pxn7Rlv0n8tCsDULT59Rp+eEhs
	guN7lrbWO+/+WU+Sa7u7zolLoYwZgkM+z+4ihTEvIRU7CTexGhSyQnb9UvSa+8m3PeetkesfaZU
	sosxtgD/UR2mBrrwKRTx8IiOvaW0lmfMUkejUoex7KmVpz/kxz1QQrrZUUZWwZHDvxYEwGeBA+n
	ks4bj1Jr23CFrMlsQ9WPJS
X-Google-Smtp-Source: AGHT+IFLkRpwM32hzKfCMcykzpH7VmCSQ2IyTOtMyj93WrL2JrbkqW/t9fuG8FuM15oE3b/6CKBLRw==
X-Received: by 2002:a17:90b:288b:b0:338:3156:fc43 with SMTP id 98e67ed59e1d1-3403a15ab0emr4047870a91.11.1761753561487;
        Wed, 29 Oct 2025 08:59:21 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.08.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:59:21 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:31 +0800
Subject: [PATCH 05/19] mm, swap: simplify the code and reduce indention
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-5-3d43f3b6ec32@tencent.com>
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
In-Reply-To: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@redhat.com>, 
 Youngjun Park <youngjun.park@lge.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Huang, Ying" <ying.huang@linux.alibaba.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3

From: Kairui Song <kasong@tencent.com>

Now swap cache is always used, multiple swap cache checks are no longer
useful, remove them and reduce the code indention.

No behavior change.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c | 89 +++++++++++++++++++++++++++++--------------------------------
 1 file changed, 43 insertions(+), 46 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 78457347ae60..6c5cd86c4a66 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4763,55 +4763,52 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_release;
 
 	page = folio_file_page(folio, swp_offset(entry));
-	if (swapcache) {
-		/*
-		 * Make sure folio_free_swap() or swapoff did not release the
-		 * swapcache from under us.  The page pin, and pte_same test
-		 * below, are not enough to exclude that.  Even if it is still
-		 * swapcache, we need to check that the page's swap has not
-		 * changed.
-		 */
-		if (unlikely(!folio_matches_swap_entry(folio, entry)))
-			goto out_page;
-
-		if (unlikely(PageHWPoison(page))) {
-			/*
-			 * hwpoisoned dirty swapcache pages are kept for killing
-			 * owner processes (which may be unknown at hwpoison time)
-			 */
-			ret = VM_FAULT_HWPOISON;
-			goto out_page;
-		}
-
-		/*
-		 * KSM sometimes has to copy on read faults, for example, if
-		 * folio->index of non-ksm folios would be nonlinear inside the
-		 * anon VMA -- the ksm flag is lost on actual swapout.
-		 */
-		folio = ksm_might_need_to_copy(folio, vma, vmf->address);
-		if (unlikely(!folio)) {
-			ret = VM_FAULT_OOM;
-			folio = swapcache;
-			goto out_page;
-		} else if (unlikely(folio == ERR_PTR(-EHWPOISON))) {
-			ret = VM_FAULT_HWPOISON;
-			folio = swapcache;
-			goto out_page;
-		}
-		if (folio != swapcache)
-			page = folio_page(folio, 0);
+	/*
+	 * Make sure folio_free_swap() or swapoff did not release the
+	 * swapcache from under us.  The page pin, and pte_same test
+	 * below, are not enough to exclude that.  Even if it is still
+	 * swapcache, we need to check that the page's swap has not
+	 * changed.
+	 */
+	if (unlikely(!folio_matches_swap_entry(folio, entry)))
+		goto out_page;
 
+	if (unlikely(PageHWPoison(page))) {
 		/*
-		 * If we want to map a page that's in the swapcache writable, we
-		 * have to detect via the refcount if we're really the exclusive
-		 * owner. Try removing the extra reference from the local LRU
-		 * caches if required.
+		 * hwpoisoned dirty swapcache pages are kept for killing
+		 * owner processes (which may be unknown at hwpoison time)
 		 */
-		if ((vmf->flags & FAULT_FLAG_WRITE) && folio == swapcache &&
-		    !folio_test_ksm(folio) && !folio_test_lru(folio))
-			lru_add_drain();
+		ret = VM_FAULT_HWPOISON;
+		goto out_page;
 	}
 
+	/*
+	 * KSM sometimes has to copy on read faults, for example, if
+	 * folio->index of non-ksm folios would be nonlinear inside the
+	 * anon VMA -- the ksm flag is lost on actual swapout.
+	 */
+	folio = ksm_might_need_to_copy(folio, vma, vmf->address);
+	if (unlikely(!folio)) {
+		ret = VM_FAULT_OOM;
+		folio = swapcache;
+		goto out_page;
+	} else if (unlikely(folio == ERR_PTR(-EHWPOISON))) {
+		ret = VM_FAULT_HWPOISON;
+		folio = swapcache;
+		goto out_page;
+	} else if (folio != swapcache)
+		page = folio_page(folio, 0);
+
+	/*
+	 * If we want to map a page that's in the swapcache writable, we
+	 * have to detect via the refcount if we're really the exclusive
+	 * owner. Try removing the extra reference from the local LRU
+	 * caches if required.
+	 */
+	if ((vmf->flags & FAULT_FLAG_WRITE) &&
+	    !folio_test_ksm(folio) && !folio_test_lru(folio))
+		lru_add_drain();
+
 	folio_throttle_swaprate(folio, GFP_KERNEL);
 
 	/*
@@ -5001,7 +4998,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			pte, pte, nr_pages);
 
 	folio_unlock(folio);
-	if (folio != swapcache && swapcache) {
+	if (unlikely(folio != swapcache)) {
 		/*
 		 * Hold the lock to avoid the swap entry to be reused
 		 * until we take the PT lock for the pte_same() check
@@ -5039,7 +5036,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	folio_unlock(folio);
 out_release:
 	folio_put(folio);
-	if (folio != swapcache && swapcache) {
+	if (folio != swapcache) {
 		folio_unlock(swapcache);
 		folio_put(swapcache);
 	}

-- 
2.51.1


