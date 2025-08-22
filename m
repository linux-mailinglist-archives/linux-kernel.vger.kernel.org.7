Return-Path: <linux-kernel+bounces-782617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC12B322C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E2A1CC9253
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA51C2D1F61;
	Fri, 22 Aug 2025 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1VIzKwx"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152D2D1F72
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890479; cv=none; b=cUTjQO+RWln46Qur1rZIpPuV5V2ACRjg0cQt2EDJQv+zzWJr+k+bUGWTXbRAImlNYCDzLExK6ZBKZK/U3QQHK1vcseA6ff1dzbzMe91oZ8pOLWWn2CNBdb4VVhFH6v5xLHU7P8kUx61ItNyU9qcuFZFpzX2z4py4rEuJ64h3UJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890479; c=relaxed/simple;
	bh=hkV/oHy+HIoT70HKWrLByT/zKjgDhCAbTjC+wex07lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9fHoxJGZI8JbncotP18TQb1eHeNXSTzN81vn9Yl417tjbSQjfFJYAS7BpGhbNbMkXIA1SJ4OHK1kRT3Cy/WMiJYPDUx1njPoVhI2fRu//yVQu8qdC+YFw6XoZU8O5A38SYZFVc7/VrmpRdonIOx/Kd6Rbhd3y48hm0SpwuPDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1VIzKwx; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-70ba7aa131fso29606296d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755890474; x=1756495274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vDJ8d/bHR7O8n6mBegJlo1lM3XBldB6kCH+6HxYRPK8=;
        b=g1VIzKwxfvaNG+8JO5RTjLnGB0wrroslrmZXX8lSCZKjY7juaHAOxBlO8MGCGVZKsp
         bDJ9hsgXfEJY4vwBwgJ4xgYFDNAgbbP+CE65CYUaNcxAcQSmA1vSGFaTggvrAuFmLubX
         TSAyBh0+Ma7hAOw+n6ls0Ve9V0DpvrtbyGzgSI4zr0WOlN089e3CcWL1ptzl/WtD5JM0
         CO+82bYR+Bllfn+Es1gaVa6EFGbLy20LO4UFeA0wiPgZgHmVe3InUFOJwq4o6GmBSJ0b
         mZ//RzTOrWc3z6ULFBJbhnRgJnsr39AQYtYhiLleF68i3bRzkUsQ2qV/YNbdE2b/hWOM
         q0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755890474; x=1756495274;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vDJ8d/bHR7O8n6mBegJlo1lM3XBldB6kCH+6HxYRPK8=;
        b=JuE9rKXagBbibD6H5HWiB6+NjVLJ/7lLSHnHjdCe1ChniyU58tZ71rU4rLsmWovO6f
         BkGpRKFSaCh3O1h5f4Am81Yi5GwtuS9zJ/C0HzqOeGsMEKpg3yb4pc3DriuXpKtYNjCS
         jPhrDDtY3FWlKRcipjO9gfQTIEW3AKXEuZnfzqvsUzdECihXC7fOJXp3zlcKbCBnhBRS
         Dsioi0POyPHVPff5ZVDmdWv9VULXSZlM5iB3nZ4ISZrVMfMsRnFN7sAA7LVV1zwxcIQE
         3G8KYCR7zaBbUbcI2fFiL+bBOmTgXWxuGUARYJW++7DcnMWBURKjUSKxygQhU2m3BeFk
         r9aA==
X-Forwarded-Encrypted: i=1; AJvYcCVsAwezRD2yRrSYpYAfDu58OfsiLFhqh5dE+IrexqLQ2/4O9N2SL0XwYnsg4ph25Rte4X/ibzLMfNrrYD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdgdDA+yIzD9hEyzOjWF4GJWAMT5BshYI8rjyAYimwb6u20yIg
	6DzqrQXbrOjlOSxwMCVCCo2I3zqgutYo4iyXZGk4HW8l88tpomPy/aXD
X-Gm-Gg: ASbGncv2QMNHsmpa29JPfY9GJcv28xR7zGt3WIvvCPRaWmFFzals5R0H575LmBZF1Ij
	JH9dkXOt1aZ7jVD1XGWARS9Xrnc+YaxjG63mEkGoYEbQ+xTSG60WVi4OjNs2ZznV7QnesrUa5FM
	lyb/shXoyTpuGzMorGVmDDE3pLOEKyMjHhv5CotYEAtKriap1J375Z0G14Is7dpbSnyxUeSQYjU
	4IrnshUcbG3Hun2hK+15ZoeAmwagkHQWX50YHDBS7xr2xaykSqjnldXSRKhDXxgJF9H3VkdE1xl
	3E6woLb5x2gs+jFpIlqEudUZFHjNw+P7KgHnn1SNPRMpOgK2aLpOFg/KflhLrpQ7JAn/vClM8Ml
	V/+SyjhH+P8Xvu3nmoy2B8Vfzlv4HRDEZ5TDK5x8G53s=
X-Google-Smtp-Source: AGHT+IHAPlr2J3KCV0LUW3oevZ44eqeFOr5c9XUGP5N3YDy/mqVt/tLuB8Hg/3fh/SZEIT3/dJDT8A==
X-Received: by 2002:a05:6214:4b02:b0:70d:9f16:9a37 with SMTP id 6a1803df08f44-70d9f16c223mr31439766d6.62.1755890474481;
        Fri, 22 Aug 2025 12:21:14 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72b04a6sm3843656d6.52.2025.08.22.12.21.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Aug 2025 12:21:14 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [PATCH 5/9] mm/shmem, swap: remove redundant error handling for replacing folio
Date: Sat, 23 Aug 2025 03:20:19 +0800
Message-ID: <20250822192023.13477-6-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250822192023.13477-1-ryncsn@gmail.com>
References: <20250822192023.13477-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
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
fail due to an Xarray mismatch. There is even a comment for that.

Delete the defensive error handling path, and add a WARN_ON instead:
if that happened, something has broken the basic principle of how the
swap cache works, we should catch and fix that.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b4d39f2a1e0a..e03793cc5169 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2158,35 +2158,13 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
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
+	folio_add_lru(new);
+	*foliop = new;
 
 	folio_clear_swapcache(old);
 	old->private = NULL;
-- 
2.51.0


