Return-Path: <linux-kernel+bounces-819210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90729B59CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DF45241B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0DB2475D0;
	Tue, 16 Sep 2025 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4bq4ATx"
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2216337C0FE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038535; cv=none; b=nLHgm8BwtvxKVI8I3+A/y3jPWg0LE+bv4Sosr7wpqZ0eCmQCESebhP/lGHtR64aB56+GuyEa+LI7upurqX2orZFHXrvTr/elBDS/LQqhQ7zXaKuHGHO6YTCgHqOg0m9uGAorZ2P1FBaBo/1zeyBjURVFf8mjkTAH2jW2wQ+rsOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038535; c=relaxed/simple;
	bh=tgqzSLm3L6Kwjq+1cjXCXcPc8nBnZnJjP/JEia/8Nus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rz2rDB77T058EoVaOhphS5SZ1XqTLOzacLLqAkbbJymH7mdxfzsIseQRzn90hvBn8kAEHxLbaZPNcTdazJNZX/XHVLsXWMkUIzAaPCOfeIDhD4qI1RRh5KGWw2kvOX3GntJgRWYDMR05SXz5fhnfrWP/Sd7P7Jvn/JkcD1I722w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4bq4ATx; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-62bbc95b4dfso1692363d50.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038533; x=1758643333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iGZJewVWtmBg1AhubXnc5kIP+Etaz+JfrYGw6S6fAgs=;
        b=U4bq4ATxclevnu20C/0uOe+q2zIk6wxFxLii9L6ErJHgSqRZEZXkJDyWAUHVuncwN1
         nFWBgFE6CCNFpE5aGnGED4XC0eqb1XwIUg0a6QSqBXXyEdhSRzIma7HPdoEGS/7IxxdL
         9DP30Lk1Cimn7wf42WuZfqBeAqOWv5FfTrJgHfqOlWDkmS6fxQpOYjjiHPpkLJYXR7lP
         1urhBZsB21h6WFmaORdp0CeuTfyELFEKCQBBcjUqREtNBSp2ztgwCBeXS0zlQUaTOWHT
         ZB7R4/sr5KnXTcUQGWdCsRtpbOChobGZtgvp1hS1siU8mNDJD0PFG46cVscu4sTkQd2l
         j9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038533; x=1758643333;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGZJewVWtmBg1AhubXnc5kIP+Etaz+JfrYGw6S6fAgs=;
        b=a7eN9ZI+04DxT13+PHleYwioOAdVRqOZpWOvxPr7JZM38FAO/xJKs/5wkxhzXJJjK0
         53W1WUTNIMj+RxgT9kIH8CDNJDzxjI9jbjgu8Pcgc/S2qnWlH22L4/PJtEJM1v/zvWgl
         XKhOWCGFUv6axkbqxBuBmCWVpcno0hketz/FIIvd3dXenD+5GO5YLA9feDrOeoe+qZB3
         0wzjVHI1HiwqYRuKIefX7QhKQgrUu7nElr08ZQ32d7xtAVW4pV7MFBMrPLHBmXMA4sWy
         QprEhbP4SchQsy/poU5bgqV72JnchGL0fVU+t7DFad3rdklog663Fs6oXh+VLO5Z/cAj
         7TQg==
X-Forwarded-Encrypted: i=1; AJvYcCUna1TGOb+7k0pHyMcseqpY6KCGUDLTir8MM/WR8WhKQX2gbfq9R6PHHaQgbvHHhkJLt1hJO5s41ffB2gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoOUljCRHZEtKVOm0wMWA9YRTlW35BoLkkhuxPnd1xcKywzbK5
	AI1GPAZUz1Al42uNjncKRQ288vnriktTQ593WuroRi8cXhY5Wu3bcwnh
X-Gm-Gg: ASbGncu0DYPGymmAqNgqVtFh94G5dFylBPR6Ycde4Gls5MyLrH3g69bCdCPoZJ2/o+p
	9aCnml+WOsNdsg9DB0Jcxad3ETmE2B6z2pnD6Oy2yizBH6rGIQ62hu4TD0JV/SyYdb2emncAaje
	Q+nx/Cppp30v6o+z576KUTgLMct0M2UNRlT2a8Hk5Y3Eeh9Qn0hD5aYxOetssFp8vKzGpHW5QMV
	HCwv7K8YpoXsgzA7E4Na0ROluwwnjazH8/rfe/xqZ2vI4BCK2NPz7ZtJYxR1mlUW6VtRwpC/2KC
	xWbsqm/MxHhOL9woft0D5EG8KCzNKlK/XNeIwhgcfaS0pGWVl9f5F7+ZfPKpkg5eCjjIX0zXIrB
	Rf/BawpCG6LDcctyGDN0RUWBM7aGV
X-Google-Smtp-Source: AGHT+IEcPZ6zAaIN8e2Ph8IHvM0WXbapzodJjPQRaKLbM7twTGX8w0w/0UkhEBY/MLHBJSqkT1Ar8g==
X-Received: by 2002:a05:690e:250d:20b0:5fe:ec6a:4d3 with SMTP id 956f58d0204a3-627258617c0mr12912263d50.27.1758038531125;
        Tue, 16 Sep 2025 09:02:11 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd703f54sm969765485a.37.2025.09.16.09.02.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Sep 2025 09:02:10 -0700 (PDT)
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
Subject: [PATCH v4 09/15] mm/shmem, swap: remove redundant error handling for replacing folio
Date: Wed, 17 Sep 2025 00:00:54 +0800
Message-ID: <20250916160100.31545-10-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916160100.31545-1-ryncsn@gmail.com>
References: <20250916160100.31545-1-ryncsn@gmail.com>
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
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 077744a9e9da..dc17717e5631 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
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
+		WARN_ON_ONCE(xas_store(&xas, new) != old);
 		xas_next(&xas);
 	}
-	if (!error) {
-		mem_cgroup_replace_folio(old, new);
-		shmem_update_stats(new, nr_pages);
-		shmem_update_stats(old, -nr_pages);
-	}
+
+	mem_cgroup_replace_folio(old, new);
+	shmem_update_stats(new, nr_pages);
+	shmem_update_stats(old, -nr_pages);
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
+	folio_add_lru(new);
+	*foliop = new;
 
 	folio_clear_swapcache(old);
 	old->private = NULL;
-- 
2.51.0


