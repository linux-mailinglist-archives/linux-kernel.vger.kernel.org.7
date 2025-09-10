Return-Path: <linux-kernel+bounces-810623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF38B51D16
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3201C877AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6367A335BC5;
	Wed, 10 Sep 2025 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRC/dZij"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351F5335BB7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520542; cv=none; b=pD5GPb4VQ9Zs0124Q/V5ubOpw6QqDkS+SQHh0tu0Mj/sf0PwcuUsM45NU7sYzjgPxNujK+bO40zaO+suwQw64eps6mlCl0cTarYBf9t82gMqgANq7XqPYtEl4XhQG0Pw8KheFuX8rsQd/ml3Cy81O5FoFy8YOJMHgjyGr9Q/rko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520542; c=relaxed/simple;
	bh=Khh5987+1u6MVC/NKJ8ASpt3UuFIKNSR0pBiIhzVLUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atmuSu3o1mzqrEf05osasHOUL2A2XgNV1oCwmIfEL02ZyhP67iq+axPvUcSEV305vaGQ0lEM71pt4yUZWuXtnbLdKpyQKYwYs9FdoJcoEKp/48zkJhwZSnObWZxydAeKxGtUzyf8I3wK+mRjyLznjMGHyz5QCyXlPtdXaqpD6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRC/dZij; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32d3e17d927so4912418a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520540; x=1758125340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xvXia67Cq9g+cEA2tdQsRO5nx9SORMf8wIBhDb/3W4o=;
        b=KRC/dZijvkM0r08bV52WxKoE+t94KIfQgDz5IElSkU7cM/RFUsF85hEfbp6vlx/c65
         bDkaIE2cp2INehPaSye75JBZ6mTU/WZ7FJkFMBYJVpfHPPjKR9MNnBfVePUo5fn+rK7u
         E48J+ul7yIPMuWhFdcSA5g18bkhngAHhhECs+1vJWJSqUWxugJYVoxxzC8QEr4puFUI2
         lTtyI6iKpTb+uPDxCdqtSgsB3aWX282UWpp3X9gaQsxlMa5CaC9TwwyiWrugB6EfWlNY
         a/g0pQS0IxJXRma7aPKTOkq7eXjemkEYPPDiQFimPEN3lumHllFFsOWnK/8OMfOL4Kex
         pCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520540; x=1758125340;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xvXia67Cq9g+cEA2tdQsRO5nx9SORMf8wIBhDb/3W4o=;
        b=ei8OSdTP9gVj/NsfXIiqQYbcI3LgVWAt6qKmhIcyXDWYdNXjxo4AzwyL8Eaa63WvFj
         V5RJ0WReRE0e+EQ/GcXCboRGwKISA5VpyrbR2BNGQHIuCtTn1rIVSKhJyrQ9l7Fe2RKs
         HEGCfDQ7NWAmGUgR32ccyzHoO8QMxaySXzEAsubCYz0EPiIjsDnblsfqUsW32jThYPvi
         JipPSq2claF05GzHHf8PMjKFiyksviTP2arXSTIkr4jPrOW3ZInh2CVloxfR99EdhFXu
         yN+CXjluXM67vAeSIUizDThq0NnEXdHTDohMY0GVfCHVAnio0rJEetrmCkTcQaUYf84S
         6cFA==
X-Forwarded-Encrypted: i=1; AJvYcCXvYx115yVChNT76GtjFGAJ5/07a8hNJSZR0ohT9Zm81J4nNQ96c0/XJ2JXkHurLpCQT0u0aa8dfAgVk/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAA3jSC4uVHW3vghcsobj57YOKas8UQ/epuNGaknh3QtlYLdTG
	o5e1sOVZht9nHknhndFsLYp3uTrcJ3jIoVJzFm4MNizzxH+gJKNJPSuC
X-Gm-Gg: ASbGncsltQAk11ymZXlQNhMDSPB1APNN7EM6hXbuRaiTz5ApKIy4xGOz06y9+JbSLe3
	1aFkKXx7plMAWa9nyPa2KYbmveyu3bnAZU+82P6l7VF6Uen4fGHb6nwsC9I4/XfuXS1t/z13ko0
	fHJs7hUae0mIDtoo8iNddbY6md3J17MEq25tOjjmJAruU5lOvwBthQp6nqdt31RR96jFhWHdXtX
	UI1HluZyLNbPoo9pnebwk0v5rNh462iZlTOujcYTDun2vIWKToEgYtRn36oIIaTvdf5dYHIuCFf
	7aTXL+8TEchMLbD1nf3CILZO2MO5jacXKIcsBscuV0/12QeV8V2iRApX+g0rGRUjQAE6sq66nnj
	FtmJLPlOY+www1fj2LlgYSGVcJaCKmK4w605lVH+IPxL0rHmt/YHi2/2LiA==
X-Google-Smtp-Source: AGHT+IEVwQm61s1dQOtymtJfnxETL8PNIjVzDNadoWh1/HbK11a27qV9e2wO2k/6lR4hXgcT7hmMCA==
X-Received: by 2002:a17:90a:c2c7:b0:321:6e1a:1b70 with SMTP id 98e67ed59e1d1-32d43e11be3mr22608409a91.0.1757520540507;
        Wed, 10 Sep 2025 09:09:00 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54998a1068sm1000142a12.31.2025.09.10.09.08.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Sep 2025 09:08:59 -0700 (PDT)
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
Subject: [PATCH v3 03/15] mm, swap: fix swap cache index error when retrying reclaim
Date: Thu, 11 Sep 2025 00:08:21 +0800
Message-ID: <20250910160833.3464-4-ryncsn@gmail.com>
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

The allocator will reclaim cached slots while scanning. Currently, it
will try again if reclaim found a folio that is already removed from
the swap cache due to a race. But the following lookup will be using the
wrong index. It won't cause any OOB issue since the swap cache index is
truncated upon lookup, but it may lead to reclaiming of an irrelevant
folio.

This should not cause a measurable issue, but we should fix it.

Fixes: fae8595505313 ("mm, swap: avoid reclaiming irrelevant swap cache")
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Chris Li <chrisl@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/swapfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4b8ab2cb49ca..4baebd8b48f4 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -212,7 +212,7 @@ static bool swap_is_last_map(struct swap_info_struct *si,
 static int __try_to_reclaim_swap(struct swap_info_struct *si,
 				 unsigned long offset, unsigned long flags)
 {
-	swp_entry_t entry = swp_entry(si->type, offset);
+	const swp_entry_t entry = swp_entry(si->type, offset);
 	struct swap_cluster_info *ci;
 	struct folio *folio;
 	int ret, nr_pages;
@@ -240,13 +240,13 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	 * Offset could point to the middle of a large folio, or folio
 	 * may no longer point to the expected offset before it's locked.
 	 */
-	entry = folio->swap;
-	if (offset < swp_offset(entry) || offset >= swp_offset(entry) + nr_pages) {
+	if (offset < swp_offset(folio->swap) ||
+	    offset >= swp_offset(folio->swap) + nr_pages) {
 		folio_unlock(folio);
 		folio_put(folio);
 		goto again;
 	}
-	offset = swp_offset(entry);
+	offset = swp_offset(folio->swap);
 
 	need_reclaim = ((flags & TTRS_ANYWAY) ||
 			((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||
-- 
2.51.0


