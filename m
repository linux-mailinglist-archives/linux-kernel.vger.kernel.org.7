Return-Path: <linux-kernel+bounces-876625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A788C1C021
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FD655C082E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FF3341678;
	Wed, 29 Oct 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJxrLYD7"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04A34F485
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753587; cv=none; b=dFRdkaICNtk/D10oHSiOpRH3hOkcEf8gLPdh21vYbUgGpk8wiws7BsU9bcn3BzB/69qP9uVMRGK28p0zzuvyLoTeri8r+rTsNhgcXluxUBkuZL8JZECdm35VYXZLscwWWvtTCTEXNhP0jzRN1ERIBZ+t0LA/PowNO60EPHM1JPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753587; c=relaxed/simple;
	bh=q7eu28LCPIzbssMIEYStlUI1LdlwlH8d7M3kS1M9/04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oceF2meG/gN7wKL8LS+DchrRDCUkIpT/wVTrH16ykldLVTEpvCP3PtvyL7XS5E+QXIJMxZSe1nBExUDym9nSWe2Q6iMFdUwpPjV//Rf548mKnflVqbeax59NQsgR/TgVlELyNpZsEHHiU7THsk2BGIv9eswzvDwjpQjJsqOpl2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJxrLYD7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34003f73a05so110136a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753585; x=1762358385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tq6PoOm8fNGczgugQnE/jPj2Q0Y+cXCuawf9c8Nqzkk=;
        b=AJxrLYD7fJMw2/ko5ab3zJXitbkW2D0ABzNCz38XkH7gFk0E6x1cB0sZ50vzpnmvgK
         LSqDiZD65FDH6JKMzekYLyZdKi+i/sO4mhBl2+yyK4XMlmE+PefG7ImVTOoTgxUgFjXu
         KobHtJOWbZoXa1x+3xs5TIJypMPpIxTj59NTfYFVytiSDwf7iAtjXu5C9ExqUF8r+7WQ
         pEYz9QQ1Cf67J7FEugFhvn2yrMY4tFqi6+yEBDH5BD/8C4fbe2WpQMZC+S9SVzygEQq7
         BLMkCdTgg0tyKVM7iGC/oTwkitvd0AqVfAR3XhUQmgHtu1pysrMuVAE/RiaLEqFdcXmB
         ROyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753585; x=1762358385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tq6PoOm8fNGczgugQnE/jPj2Q0Y+cXCuawf9c8Nqzkk=;
        b=XrPiKIC1Zab62vGJzicwN3ia2Mbfvpu+sUPA9cBrc9a1+AoM3ZjAf6KcugPtN6oUus
         J93oby5z8sFMIvc3yrCnfh1fON6xtQmxakirxsJbIQI7BW7vRCx8OYgTi8sBiAO8X27T
         iOdPHv/pXryrHe2S6/As45HeS6dzwoyiv7SKPbq/uJFd6fG7+v7jLc4H9MM+bYd/j4g4
         SHlXUEEV33Q6p5n7bN95B3cqgrHwOZLWmiacBMitRf17HAFO3QMCvEZcmkOra1teUoS3
         DlSz3VErxN3Vl288Qrj+WGQXVO5++PHD2CkVC016vrfE69gp8u/ma2nfy+YGO+2jQUfu
         GPUA==
X-Forwarded-Encrypted: i=1; AJvYcCVPHXH9d1crQq/hlOWGeHrC1MDekpcg0UixtkfPcodb2CF6R3olpmDj//y9nAay209wu+AzzNzD4j7Wgt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp4iXdK1KXDjDjx1PSOEUdlrxdx5YlhGW0Jw24oZDrR9dHGP0o
	6WoLyw8Pi9/ERgRPoN02PYZ7kegVSAzHQyRDvVH8O2+yRdusPHrJ4Fqq
X-Gm-Gg: ASbGncsk16o4UgkTzA8CjxSsBLz6pJLmnjUSTgvl9sxBsEVXGpSwsvTGW1VnwmdA2PE
	TugzeQB0YElMlFENMo9wso3rizmpPXQQgrRr8J7Gt5zfBJPIS0+baO2Ucf/foio+6mxwFdYqBQd
	Evz7AGhxrE9MIdRKWJkFj19yGnNa2msSyqxEaulC2QttqXsuuyGlRDYnetpfV2CIi11PbeD87aW
	d/2ss5Skyy1mriZ1vPt+8MkDjzIBNxL1ZZ+EpyxhMk/7A5JqxfLa/JJ9A7zyDq34zpWrHVyKIdC
	+C8tIOVR+fGJHvQtMEBmria39/eMm2sMqV9ORUzLbCV0eL24ClMaK8lUHBULLIld2EXsmqvjyGF
	S91o9Skw+6USWcVJBg3ZYEaKpt0CwNb+SLI8Zm20fqbabcowiTUjL/9FHLK5ZQ0u4oYP+sYF67I
	CrX9Oydcxm7AIpp5gcfYOp
X-Google-Smtp-Source: AGHT+IEJiZ7ou6E9Ow56ntpYQ8NsRTNR+WJ+uc6HP4HPdJyD9fOV4yH1D0+/1zf2TYa8UuiYOuvhFQ==
X-Received: by 2002:a17:90b:3ec1:b0:33b:dff1:5f44 with SMTP id 98e67ed59e1d1-3404ac129demr113628a91.6.1761753585029;
        Wed, 29 Oct 2025 08:59:45 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.08.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:59:44 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:36 +0800
Subject: [PATCH 10/19] mm, swap: consolidate cluster reclaim and check
 logic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-10-3d43f3b6ec32@tencent.com>
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

Swap cluster cache reclaim requires releasing the lock, so some extra
checks are needed after the reclaim. To prepare for checking swap cache
using the swap table directly, consolidate the swap cluster reclaim and
check the logic.

Also, adjust it very slightly. By moving the cluster empty and usable
check into the reclaim helper, it will avoid a redundant scan of the
slots if the cluster is empty.

And always scan the whole region during reclaim, don't skip slots
covered by a reclaimed folio. Because the reclaim is lockless, it's
possible that new cache lands at any time. And for allocation, we want
all caches to be reclaimed to avoid fragmentation. And besides, if the
scan offset is not aligned with the size of the reclaimed folio, we are
skipping some existing caches.

There should be no observable behavior change, which might slightly
improve the fragmentation issue or performance.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index d66141f1c452..e4c521528817 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -778,42 +778,50 @@ static int swap_cluster_setup_bad_slot(struct swap_cluster_info *cluster_info,
 	return 0;
 }
 
-static bool cluster_reclaim_range(struct swap_info_struct *si,
-				  struct swap_cluster_info *ci,
-				  unsigned long start, unsigned long end)
+static unsigned int cluster_reclaim_range(struct swap_info_struct *si,
+					  struct swap_cluster_info *ci,
+					  unsigned long start, unsigned int order)
 {
+	unsigned int nr_pages = 1 << order;
+	unsigned long offset = start, end = start + nr_pages;
 	unsigned char *map = si->swap_map;
-	unsigned long offset = start;
 	int nr_reclaim;
 
 	spin_unlock(&ci->lock);
 	do {
 		switch (READ_ONCE(map[offset])) {
 		case 0:
-			offset++;
 			break;
 		case SWAP_HAS_CACHE:
 			nr_reclaim = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
-			if (nr_reclaim > 0)
-				offset += nr_reclaim;
-			else
+			if (nr_reclaim < 0)
 				goto out;
 			break;
 		default:
 			goto out;
 		}
-	} while (offset < end);
+	} while (++offset < end);
 out:
 	spin_lock(&ci->lock);
+
+	/*
+	 * We just dropped ci->lock so cluster could be used by another
+	 * order or got freed, check if it's still usable or empty.
+	 */
+	if (!cluster_is_usable(ci, order))
+		return SWAP_ENTRY_INVALID;
+	if (cluster_is_empty(ci))
+		return cluster_offset(si, ci);
+
 	/*
 	 * Recheck the range no matter reclaim succeeded or not, the slot
 	 * could have been be freed while we are not holding the lock.
 	 */
 	for (offset = start; offset < end; offset++)
 		if (READ_ONCE(map[offset]))
-			return false;
+			return SWAP_ENTRY_INVALID;
 
-	return true;
+	return start;
 }
 
 static bool cluster_scan_range(struct swap_info_struct *si,
@@ -901,7 +909,7 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 	unsigned long start = ALIGN_DOWN(offset, SWAPFILE_CLUSTER);
 	unsigned long end = min(start + SWAPFILE_CLUSTER, si->max);
 	unsigned int nr_pages = 1 << order;
-	bool need_reclaim, ret;
+	bool need_reclaim;
 
 	lockdep_assert_held(&ci->lock);
 
@@ -913,20 +921,11 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 		if (!cluster_scan_range(si, ci, offset, nr_pages, &need_reclaim))
 			continue;
 		if (need_reclaim) {
-			ret = cluster_reclaim_range(si, ci, offset, offset + nr_pages);
-			/*
-			 * Reclaim drops ci->lock and cluster could be used
-			 * by another order. Not checking flag as off-list
-			 * cluster has no flag set, and change of list
-			 * won't cause fragmentation.
-			 */
-			if (!cluster_is_usable(ci, order))
-				goto out;
-			if (cluster_is_empty(ci))
-				offset = start;
+			found = cluster_reclaim_range(si, ci, offset, order);
 			/* Reclaim failed but cluster is usable, try next */
-			if (!ret)
+			if (!found)
 				continue;
+			offset = found;
 		}
 		if (!cluster_alloc_range(si, ci, offset, usage, order))
 			break;

-- 
2.51.1


