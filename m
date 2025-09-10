Return-Path: <linux-kernel+bounces-810630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 421A2B51D21
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC0CA0363B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0100B33CE8D;
	Wed, 10 Sep 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UirNdaie"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7259632F774
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520573; cv=none; b=tzGZBu/78Dh84VP9lF7PKlfqMu2Xooh/XzqDz3ArI60unRFc5Fr7wLQDlZbMVDrjrPKkEzYRo539g9+y3IHM2m7DU0SlYHcI0Kh70bjBoucZ+yfC8V7ZtC8CnSCIUaihKIBzUcm9QHoQ5oos4FXKDSm5IglKBMXr4RgOz8h0w3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520573; c=relaxed/simple;
	bh=89lTN+lYG5EkPRgJ5HkI886n9BOFunertfvU1h3jT8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FN8Rzcf75s3ExLX0DQVlq1qJ6snt549n8N8ojUmpJGqFY2eXtxyiwAIxQQ2y+0s9swNRXEEJwFZxgMWVwaIHRxzS2iSgjttp2+Sl99CsMQ1202fnHjpbAOp8WaD2yhve63Nu39K0yBmhWHtxyZhnj+q4m5miGZTm3XsEJtygtg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UirNdaie; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7724cacc32bso5634629b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520571; x=1758125371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=griGxIh9GEE3HF6pE5uHZRdQ9DQCWTXYvIepBVp/qTo=;
        b=UirNdaieFTuSuNpGd80X4zDZ6YrTKRenJQietkMGjOWkaV8oXWRkBvtxJiFjs9DiwO
         c6ZTOyamudGPe5YbiqhcVzlsBh2k51qjkhTh53s1B3TAmdQg0no7vgXK3L2t/AEdhgjk
         y4Foubef244pFM5srpAuREmxM8lW+IfWlVq54nvid3nkuEizuKUiEOV7cu0oz1LnQjvY
         0X8XFYKCgeBUWOTlQixIYdquZ8ll1UKaDJljXJHz0noGgqx0yeGlbosab8eXf6Rj073A
         4ztXXC8RvJw6NB3A8bVpK9O0yWzc76NpcVROF7h5v4IsY8PJZaC4lmZ9gY8BZsrGjqOH
         1XCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520571; x=1758125371;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=griGxIh9GEE3HF6pE5uHZRdQ9DQCWTXYvIepBVp/qTo=;
        b=uQM2irV93lHsgTJ4fBG1/x3jeqiAKV36jh0JIC7FWBGvAPenb8UZaOx9645wxt/uOP
         zzBz4wjPg0E4ypeNCogTsJzk6pMzgrBVKJKzEo2Z4J8m6Wn1xJLCHz9pBKvzO+Tj3vHB
         tOn9JoHpMOT8p0HIHfIdi4ua2vOsqxWOFcstFqZu9OOiH11fHJ4CEJKRvPjTYx6O95cb
         V3b67EBeeJUkVXuJyH6mFpLIBusoTTdq32tfsjGTzI0lynjtuQSebU66soqrrAZwKt/6
         ej30cUlkEozVJ3c6siVAg/Sz0abvYFiLO38Np9J2ln9cdYESK2EgfpY7xsFO8Y/AKYS6
         ISxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN/089L60zDC/o+NN6NRxs5Z83HCGJwStrZjzMDKEYmHE4i4L3/a7vPXDzkYGJGLtbDrvOQgAOXHg80wE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0W4RHm7qO/IDREyEvAIsWEnSdVJiCbQ8TMw1/kKYqCGvHm0hS
	jtptc90o85MPZyWtzafiEcKxnmslvrTvnkI3kwDr/Kh/s5+3u7DZS1hO
X-Gm-Gg: ASbGncuStsBH1u0+HwbzARSKewk80gYXCEUBHM2IwG7JOj3yZjl7Mf/rKaYIsoJNu+F
	jHEyE3ZnhE7ZsrJ0rcAbfmaWktYKm7nUplJ6xW0tYmMN2/mhY3FpE6t0qGVsIAsvRy/O2cGNZ9z
	QtfiFBS1uB2ot1isF4CjgT7XPp58YxxRzpsA5mB3IgJonMSJh9Qh4+YUlTwzYuu8JLDlmNlJ8d4
	qjybExTZjO+75ywM1xSOh8Uf14xkpT6BQEwO3wLR6lxv3lVAA5oxftzK2E6HycNkT4OwkXFY46t
	pfmZQti5BAnZaGQK+YUMiP5hOjhE8kBl7sGLFi4b0xjFdWWXQ9CaEDkCdTFBEE5USVVvX/SeK3q
	flod1nX6D/FPyNB8aRdF8HgaDnHgsDcASmnMsY+hVDy7A0RM=
X-Google-Smtp-Source: AGHT+IF79Trm+wcbzKOddKHrBqAVQp9c3H0wicsNS7W5K+jd07nVhIvIvzw66BfjwtQW3jqIqjmWZQ==
X-Received: by 2002:a05:6a20:7484:b0:250:9175:96df with SMTP id adf61e73a8af0-25344415c9bmr25513067637.48.1757520570590;
        Wed, 10 Sep 2025 09:09:30 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54998a1068sm1000142a12.31.2025.09.10.09.09.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Sep 2025 09:09:30 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Kairui Song <ryncsn@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 09/15] mm/shmem, swap: remove redundant error handling for replacing folio
Date: Thu, 11 Sep 2025 00:08:27 +0800
Message-ID: <20250910160833.3464-10-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910160833.3464-1-ryncsn@gmail.com>
References: <20250910160833.3464-1-ryncsn@gmail.com>
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Shmem may replace a folio in the swap cache if the cached one doesn't
fit the swapin's GFP zone. When doing so, shmem has already double
checked that the swap cache folio is locked, still has the swap cache
flag set, and contains the wanted swap entry. So it is impossible to
fail due to an XArray mismatch. There is even a comment for that.

Delete the defensive error handling path, and add a WARN_ON instead:
if that happened, something has broken the basic principle of how the
swap cache works, we should catch and fix that.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/shmem.c | 42 ++++++++++++------------------------------
 1 file changed, 12 insertions(+), 30 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 410f27bc4752..5f395fab489c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1661,13 +1661,13 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 		}
 
 		/*
-		 * The delete_from_swap_cache() below could be left for
+		 * The swap_cache_del_folio() below could be left for
 		 * shrink_folio_list()'s folio_free_swap() to dispose of;
 		 * but I'm a little nervous about letting this folio out of
 		 * shmem_writeout() in a hybrid half-tmpfs-half-swap state
 		 * e.g. folio_mapping(folio) might give an unexpected answer.
 		 */
-		delete_from_swap_cache(folio);
+		swap_cache_del_folio(folio);
 		goto redirty;
 	}
 	if (nr_pages > 1)
@@ -2045,7 +2045,7 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 	new->swap = entry;
 
 	memcg1_swapin(entry, nr_pages);
-	shadow = get_shadow_from_swap_cache(entry);
+	shadow = swap_cache_get_shadow(entry);
 	if (shadow)
 		workingset_refault(new, shadow);
 	folio_add_lru(new);
@@ -2121,35 +2121,17 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	/* Swap cache still stores N entries instead of a high-order entry */
 	xa_lock_irq(&swap_mapping->i_pages);
 	for (i = 0; i < nr_pages; i++) {
-		void *item = xas_load(&xas);
-
-		if (item != old) {
-			error = -ENOENT;
-			break;
-		}
-
-		xas_store(&xas, new);
+		WARN_ON_ONCE(xas_store(&xas, new));
 		xas_next(&xas);
 	}
-	if (!error) {
-		mem_cgroup_replace_folio(old, new);
-		shmem_update_stats(new, nr_pages);
-		shmem_update_stats(old, -nr_pages);
-	}
 	xa_unlock_irq(&swap_mapping->i_pages);
 
-	if (unlikely(error)) {
-		/*
-		 * Is this possible?  I think not, now that our callers
-		 * check both the swapcache flag and folio->private
-		 * after getting the folio lock; but be defensive.
-		 * Reverse old to newpage for clear and free.
-		 */
-		old = new;
-	} else {
-		folio_add_lru(new);
-		*foliop = new;
-	}
+	mem_cgroup_replace_folio(old, new);
+	shmem_update_stats(new, nr_pages);
+	shmem_update_stats(old, -nr_pages);
+
+	folio_add_lru(new);
+	*foliop = new;
 
 	folio_clear_swapcache(old);
 	old->private = NULL;
@@ -2183,7 +2165,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	nr_pages = folio_nr_pages(folio);
 	folio_wait_writeback(folio);
 	if (!skip_swapcache)
-		delete_from_swap_cache(folio);
+		swap_cache_del_folio(folio);
 	/*
 	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks
 	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
@@ -2422,7 +2404,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		folio->swap.val = 0;
 		swapcache_clear(si, swap, nr_pages);
 	} else {
-		delete_from_swap_cache(folio);
+		swap_cache_del_folio(folio);
 	}
 	folio_mark_dirty(folio);
 	swap_free_nr(swap, nr_pages);
-- 
2.51.0


