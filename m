Return-Path: <linux-kernel+bounces-819204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79D3B59CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17213161F37
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4563127713;
	Tue, 16 Sep 2025 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/uQ8Rc2"
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1154424DD00
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038494; cv=none; b=Y9IHOLD4fi8EMB5GwDBnrM4ucWNimEkWVjE60CJJEVwwMtwKdkM7GMiAXxzoBtC7GxNSZyP9lgRfP1mqHclqOrqEAYMNl+7YdVrbRf3Ot2uJcEXz8UuCOnVDfH9R0wUfH2E5d6X8w7ZZ88IfkItLZ3oXAGULcY9HlKMfsiBV1dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038494; c=relaxed/simple;
	bh=Khh5987+1u6MVC/NKJ8ASpt3UuFIKNSR0pBiIhzVLUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFDKsSdyDUwabKZJcUPAEkN7RCGy08v3FpH/0UBIYeZuqqoNBzQ1FpLs8AazVzeDA98U5QBeN/Qy5dG8cLDsH5gkYrvh7H3bM5+t3i7icfeIhnoq+Bc+cMwM7W8LGBUVPINGjufx/p/5wn7LRH8gnxDaY9CrFc9J7yw0igu8v0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/uQ8Rc2; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6294ff16bacso1656406d50.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038491; x=1758643291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xvXia67Cq9g+cEA2tdQsRO5nx9SORMf8wIBhDb/3W4o=;
        b=c/uQ8Rc2gmptwcLCkmmxAB5JgpM+s/6WnQ/XtpBQCWoniynK22xzsx5IvR3bLu3gZK
         v5ZhUIGLRH4wfFd8LPu0vjn2jFXnYzOLZtt6Wfr29dUgM8tUBT6OzovasKIZipziRaIz
         /V9f8X+Y/49unfmKeqKJiSHCC2CtMRcinnJvU6o1TPHyzYfhl9KjLXGxUSWDjY7CQsvu
         mMwQa0/s0uqq6LZ+tfZvN5Dj0jzHX8VxRv/IZJOuRTcjXMrIgWhTpp4z56D6zkYhux0z
         mZTkTSAo+/dBs3Xph16f0rL52H95lgV4hK9Pl6+liAWDVunpNivHUpQCV9BxRYb9mIlQ
         jsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038491; x=1758643291;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xvXia67Cq9g+cEA2tdQsRO5nx9SORMf8wIBhDb/3W4o=;
        b=kgevRlDNqg46A3naAaIAr8xg6RdP1H5FzhHsgfjbFCwk6Q2DIYoQVY5NuQtqbGO9AZ
         PxMIF5ZERMwBfQp1Gvu7WhJF5+vxgRJJOCy113njfQGxUEUM+hDMtANM/ThMlfBaiKDj
         mHtRjyzs8rDLDP6pgU3Lk7dFEBCJdJm9h2QWkzwDmFAV8jrsShE9ni+XG+MMQQZ6ehqw
         GICH2yGnAtwZ7qsztKQluOpUj2oRBEY6JL1VDAHCSjhKZM5tIDrIMykq/GHJFORHvgvP
         W7Qw4OG/NJgh5Px31SHhDvWrNNGx1VcsFNYG0cyTe8NMEnucPUvvUtKPGwdToCMev7so
         UIsw==
X-Forwarded-Encrypted: i=1; AJvYcCViCGLYWHOs5yCC4DmpvFYSb9AgeTpfaqEMCgtZ0hQQNvMTxhRwVOE4yHqcL6hhqIUGab0SLCGZvXMlSls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWs9qtDtYzBaTDhPiaErHhMQPlAMrRjVH1U9zwTL4QjtG7Dxkz
	gyuLzgdazchOvvcP+ypRquaTWNazBl1B1XaZJ8gF99RDtZkg1mpc5iyh
X-Gm-Gg: ASbGncvaxE8aW3LZjjgbfN+6F9wQx1uaTXNqdbEtqzCODPCf11CZwOieDriL9pi6rcf
	7R3XkDf8PEUgwmpTHicAvkvYFW74GPZypOI4T7iz9StNGaVD/j7FXker2ueFfsy37uwR3IvNJXz
	CJ60AxwF+qPEcb8VcZgCE0e9NAxW4pr/EPfVh/ExqYz33dKD1dpAh6TxOeMRsIyGzh04pgnA/bu
	Whti2PAwYQALX5KKFLFLQDjnkdPmZsd7ZDqcal7++EnOdUJyRT4IDUIGIBZt+kITy/1oycuCbp4
	i/zzsIyrEGWZ5gIgetp9Wl443i9INfvBJJ2b8hI9A1UNAASTGtZSqVfv/bLVs90FlYsH0iFbi1E
	kMuXZ+XAqmVFUD/geRVb/85oNWfT8uJuNUrEbLbfR8RkowRE=
X-Google-Smtp-Source: AGHT+IEH+JurO6Pqf+3vm5jI9TQTunBdyoFl7E4dFaoXc2kYbDIILkBmSJJMNdbYEyyRHGeHv0wzRQ==
X-Received: by 2002:a53:864f:0:b0:600:d00d:f4eb with SMTP id 956f58d0204a3-6271c5cfcc6mr11388302d50.12.1758038490342;
        Tue, 16 Sep 2025 09:01:30 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd703f54sm969765485a.37.2025.09.16.09.01.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Sep 2025 09:01:29 -0700 (PDT)
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
Subject: [PATCH v4 03/15] mm, swap: fix swap cache index error when retrying reclaim
Date: Wed, 17 Sep 2025 00:00:48 +0800
Message-ID: <20250916160100.31545-4-ryncsn@gmail.com>
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


