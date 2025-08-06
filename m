Return-Path: <linux-kernel+bounces-758007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE428B1C9A3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4754D18C2068
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBC929AB1C;
	Wed,  6 Aug 2025 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB5cUDxj"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216029A9C9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497121; cv=none; b=XVXK1zfpetNsOYSDAfFYuzeEXv4qkRVpMwGUXdUz8JNFcPoIK9nDWZbked5o7Y4sym544iHAmIrBBGaGIACfTA6DKNk1MtyX8vDODrPNVwhhimZ7rH2yOBfyNTR6/rJ6zYIskGCvHm3oUPaLY6ZHCrvurto5v626/PRk3bNYQDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497121; c=relaxed/simple;
	bh=avwlZ+c/zpvHhbg85xbrO7KU1flaZtAHfckjXFJRz2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXzd0qIFwnu2VdUzq64HayUKFg+EuMUQxPaRj+2MBnzvx+sH85MV/hfepbeNf7sMcJg52OELl57gS7c+AtReJABga83iLfD6EbmrhX13LZm3Hl0wZILB/W/jsmgB09iagaoVr4TxeSLKAXUU3lbPG+XFMGqfcsAHzBbCAaMRHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hB5cUDxj; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e7fb58425cso6185485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754497118; x=1755101918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S2V8Av5scJE14Rv5wfsiXUc3HN8xsIIfjL3a9op53nI=;
        b=hB5cUDxjEVyZ4lfAHJofVSuhwHguUIyws0rnsMjYUUWozidrolsiPb1VIEhf7VRYkz
         7LDe14ONGH0CWJzcaq3wgytufOrLERoqQCwEKzSkGNEuHw4+rbTTK6LMV2WmnTWifbXO
         Sb0XYTDg+qGLDf45DJz/ckNd8J1LnHvM203xCYBs5htDzTNLdPIjY/EvDpmoyRIOkRxl
         tS9oNCbsonOe1bCBEozcoOmBenV4Mih2by6QwJf9rn+MdOgSkXacp9fB8AuFtijYvnk2
         LBX4t/fvUgMj+qMR5vRg7pBxSTtN4QicmNW/WwUqYmuAxeMqQDvWWY4/EnE1rEDAfyCy
         hRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497118; x=1755101918;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2V8Av5scJE14Rv5wfsiXUc3HN8xsIIfjL3a9op53nI=;
        b=kQdLFoe7lxoecBIuNzD7hfSxfQSiXGi2VghauSVI1Zu877eJ+j/zB27HGJcETTY/nH
         zXi+nFQisJLgDS/JgbByIP9W/cxoDDmZQqjWWlBvsZr9e7wr5r0YzyCbUNBugftRNTnM
         a9hXMRp+X2q2HycBxqLCIgjnbq84xZkelJPhoMf95BIGBPOi+w43u4RggSHrH81FCHFp
         0JOEE9nlYOOe6gFDObGclBhoGyZf/AOTXd1D0iP5tCprZ0lXgKUiqtJKhAfta1mOFRqA
         KKLnDbuRgAW8/qnxOf2m0kkl6j4yA+zCPKnVEuQdR3DiPboHFypxYuxy0+23KgzVm52u
         7ihg==
X-Forwarded-Encrypted: i=1; AJvYcCXFL2+qCj6x234u8Y8h90DtItU5mihKWfS+aQP5wc6Xj8a70Myw7oEhPOmQrCsexJTE+pOx89TaeQxQFJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgq7bDAnmKwPpdd6f7KUfFFLI/iR2d2o7ocXXmrSQc576LvEYe
	T9QrcwFuvntyDmRPTdh8o3NJy63nRstds8B7NMGoPOmiPQjpjPjS7iFG
X-Gm-Gg: ASbGncsEQjTxG+1XTFvaeho7/b2pbk8JI4xOjVk+QFnibtQXKsEZjjJx1CIDVx9CPIm
	ClYJf32qzI4in6+fiyCRKsCyvN9qFzyHxq1sYt/DyIzRETk4fcgUkSaThK7py9OS4lXcRR9XpiO
	ghocc9RzubqwXY9ZjDF4jvdFn3HZqn/IzP26CtaSTJm1gJJvHygo1xmk07Agc7AKnXcA36PEEWn
	KXUCL/EYaUmlG6axIaJVEX2v9JfkbYc9YwX5q37ZxNB6upDCOO5I1b6Y1UBA7bvZruMoiRpNH9u
	I99i/AIlfcH8JnpVvY5CCcRPLiUsJowjtpV/0BDiev3YU+es+ovcslFtz1Svw+5oLN9w1ImPoOS
	4pGQZCRTsWfx8l8VpxMpx7dEeiQHkvuUy3A2SkQ==
X-Google-Smtp-Source: AGHT+IGtwj+7xMQjpcrNPb4NOoKMCSSUbHYA/8w8TOKtmXnOhSASyNJ1d9KeQ8Tqwyjf9iYGjSUHLw==
X-Received: by 2002:a05:620a:4150:b0:7e6:7c82:f0ec with SMTP id af79cd13be357-7e814d27a51mr553391185a.17.1754497117544;
        Wed, 06 Aug 2025 09:18:37 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e7fa35144esm464081885a.48.2025.08.06.09.18.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Aug 2025 09:18:37 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 1/3] mm, swap: only scan one cluster in fragment list
Date: Thu,  7 Aug 2025 00:17:46 +0800
Message-ID: <20250806161748.76651-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806161748.76651-1-ryncsn@gmail.com>
References: <20250806161748.76651-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Fragment clusters were mostly failing high order allocation already.
The reason we scan it through now is that a swap slot may get freed
without releasing the swap cache, so a swap map entry will end up in
HAS_CACHE only status, and the cluster won't be moved back to non-full
or free cluster list. This may cause a higher allocation failure rate.

Usually only !SWP_SYNCHRONOUS_IO devices may have a large number of
slots stuck in HAS_CACHE only status. Because when a !SWP_SYNCHRONOUS_IO
device's usage is low (!vm_swap_full()), it will try to lazy free
the swap cache.

But this fragment list scan out is a bit overkill. Fragmentation
is only an issue for the allocator when the device is getting full,
and by that time, swap will be releasing the swap cache aggressively
already. Only scan one fragment cluster at a time is good enough to
reclaim already pinned slots, and move the cluster back to nonfull.

And besides, only high order allocation requires iterating over the
list, order 0 allocation will succeed on the first attempt. And
high order allocation failure isn't a serious problem.

So the iteration of fragment clusters is trivial, but it will slow down
large allocation by a lot when the fragment cluster list is long.
So it's better to drop this fragment cluster iteration design.

Test on a 48c96t system, build linux kernel using 10G ZRAM, make -j48,
defconfig with 768M cgroup memory limit, on top of tmpfs, 4K folio
only:

Before: sys time: 4432.56s
After:  sys time: 4430.18s

Change to make -j96, 2G memory limit, 64kB mTHP enabled, and 10G ZRAM:

Before: sys time: 11609.69s  64kB/swpout: 1787051  64kB/swpout_fallback: 20917
After:  sys time: 5572.85s   64kB/swpout: 1797612  64kB/swpout_fallback: 19254

Change to 8G ZRAM:

Before: sys time: 21524.35s  64kB/swpout: 1687142  64kB/swpout_fallback: 128496
After:  sys time: 6278.45s   64kB/swpout: 1679127  64kB/swpout_fallback: 130942

Change to use 10G brd device with SWP_SYNCHRONOUS_IO flag removed:

Before: sys time: 7393.50s  64kB/swpout:1788246  swpout_fallback: 0
After:  sys time: 7399.88s  64kB/swpout:1784257  swpout_fallback: 0

Change to use 8G brd device with SWP_SYNCHRONOUS_IO flag removed:

Before: sys time: 26292.26s 64kB/swpout:1645236  swpout_fallback: 138945
After:  sys time: 9463.16s  64kB/swpout:1581376  swpout_fallback: 259979

The performance is a lot better for large folios, and the large order
allocation failure rate is only very slightly higher or unchanged even
for !SWP_SYNCHRONOUS_IO devices high pressure.

Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swapfile.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index b4f3cc712580..1f1110e37f68 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -926,32 +926,25 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		swap_reclaim_full_clusters(si, false);
 
 	if (order < PMD_ORDER) {
-		unsigned int frags = 0, frags_existing;
-
 		while ((ci = isolate_lock_cluster(si, &si->nonfull_clusters[order]))) {
 			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
 							order, usage);
 			if (found)
 				goto done;
-			/* Clusters failed to allocate are moved to frag_clusters */
-			frags++;
 		}
 
-		frags_existing = atomic_long_read(&si->frag_cluster_nr[order]);
-		while (frags < frags_existing &&
-		       (ci = isolate_lock_cluster(si, &si->frag_clusters[order]))) {
-			atomic_long_dec(&si->frag_cluster_nr[order]);
-			/*
-			 * Rotate the frag list to iterate, they were all
-			 * failing high order allocation or moved here due to
-			 * per-CPU usage, but they could contain newly released
-			 * reclaimable (eg. lazy-freed swap cache) slots.
-			 */
+		/*
+		 * Scan only one fragment cluster is good enough. Order 0
+		 * allocation will surely success, and large allocation
+		 * failure is not critical. Scanning one cluster still
+		 * keeps the list rotated and reclaimed (for HAS_CACHE).
+		 */
+		ci = isolate_lock_cluster(si, &si->frag_clusters[order]);
+		if (ci) {
 			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
 							order, usage);
 			if (found)
 				goto done;
-			frags++;
 		}
 	}
 
-- 
2.50.1


