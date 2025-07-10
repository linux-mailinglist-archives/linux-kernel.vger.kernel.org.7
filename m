Return-Path: <linux-kernel+bounces-724860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C57AFF7A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA2F7B48BB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D94F285CB9;
	Thu, 10 Jul 2025 03:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbxdw2uJ"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD81A285CA3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118678; cv=none; b=f/qS/G4q4ZDhchMape9PO4ZFLTcarMJbJNtSmwxqvLNAu2UZDGtpwstMnN85nNJtJiG0dCAymzqovKXJIe1BklEIBm7KvqmTZxWMgprIGszKXsOmOkZ8MHntgJ9xa2yljQVm3M5bVyPGxHK6P00e/KGmJctx8ahwjyahC4KDkjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118678; c=relaxed/simple;
	bh=HC+6k1nQxzhsFuk4wMlDLb43FdK20wLRM0oWZgL7y8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqLCZfk19BfIW52T2b0QoyNZQlEdbjC+uivrRBF0ypHJ1I80R3H5t+1ZY17MUoz2uIul0pT5co6/cbgorXM2LdgtVoRQSNVgV0roakdDCJtGJCDd4pI8qMnXbCeaEULpUmyghYHl7krgtinMxVLWpnIGwueW2N7OVbDr2rcRabI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbxdw2uJ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so553715a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 20:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752118676; x=1752723476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nILRlzs6W9f6pBIwoLukcSVGtWgUoN//llJCwXGQtks=;
        b=cbxdw2uJXTh1RwZZ1jBU3lS82pFzHs9wnwtxzPV7FHgJqkf4Yk6V9qqu2HHmtcZlqF
         g/eZT14h6limsqKTq8HdWIXlJOliEjY8JxJT0YE1UWwMzWmKrFhnTep4JG+t3764n2V7
         BUgL4iCnUAdYwsWyXHgJJVlazgsbOaYrAT1x1PGI9EISUObw0JFcKEqo21YQdfX4+FK5
         Eoh8xnBtOMwVmOpl4R3n6vmRbUI+mg/ofd8tYMKi9JgiSpv99SEy3Pc+7axpCALToAdF
         u3HC62mENaVi7fX5wjSwU4J+GQcKKZkDGIPBnT+LeMwHk0Z9n9AJUy4ar8h0doL1rl+z
         o30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752118676; x=1752723476;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nILRlzs6W9f6pBIwoLukcSVGtWgUoN//llJCwXGQtks=;
        b=bKVKh0y/Ofh1zGjTaDc1oB4Vp9A1qdJlCvmP2v3uni92ahB1/tQ4cwFhfFenDrCQKe
         MYiqykNKaPIYHUTLBYxs7sLXWiTMD8a6OnqlrjlkJEV6MJmFklEvLuxOw5VBMo3CQjY3
         CmA8nhc6p+RicolyyNXoEAyQJgKAtCiTfli49KMHG3dicX7FWhSvxRrvrBhFVnhTcgP/
         4dQtY4gJhm2tR++F13vJIewlXQ32Mwmkl/SFrZD2o7Ns6DVqfvGNthCHLMKyNW+pT4Ey
         MhqJutBFcDi0xAn13hAdSKWfeGo9uk4m5YSenkrvGntXD2ANeMkw6OZCfjaJwpJDuPx0
         VJ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUU69F8kmFTlusMtbwjuX8Rj6u2jp/jXqrPf8saFTZGCqgctWus0A32VxRa5CCvtV1GqE1rZ6AeeiXQOOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpFeWfCk+Hem5wkxK7UjZwgdini61kTb+dGDOSvRWTiO4WoUjt
	7VaB0v3GZIKEm5wsk5LOVq3nNTrD41E6u3b5pt0mXrvnpeIbc5RB8CLf
X-Gm-Gg: ASbGncu+PdaSQy7SOLMKFw+0vqI9fU9uDt9W3v5Fwrf/zYdqu7ldd9XGNlQ+3MWflL/
	U0bmMOaY5hdHfg7YcNKeKb2CCy/k7PzklOkWpKONmva1q7bfu2467KmE6yi3bBF+PXmNsNxU559
	DOMCk3jZt0cMrRRyZYaWpIEhjhmQNPJNvcKf8z77QvN8WCKbJYzebNTGf1jELr+xwqOJsvz2Smm
	Pj9b/qNKz7z1ISTqYo3bQwUK7rUGK+vT080XN5DYB5x2qhSpS/dNnbLkKyVD0Ve8nD3Hzttu8u6
	pHSiBpJOOeY3SNS64sfzWCgR55GeBsK02U1vdGYQ0x53t+cmPvjCch80ku/7kUmiebrbnUSxqXQ
	52PDsDKHK2zY=
X-Google-Smtp-Source: AGHT+IFJyIDBVba3HKojPZjn0y6Nwa/FH+Rj3zhl8LqZ048q0mLYJ8pfJLTIBQJSD1OjkoOOQrO06g==
X-Received: by 2002:a17:90a:d40c:b0:312:1cd7:b337 with SMTP id 98e67ed59e1d1-31c3c255d05mr3461618a91.5.1752118675880;
        Wed, 09 Jul 2025 20:37:55 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300689aasm3716320a91.13.2025.07.09.20.37.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Jul 2025 20:37:55 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v5 6/8] mm/shmem, swap: simplify swapin path and result handling
Date: Thu, 10 Jul 2025 11:37:04 +0800
Message-ID: <20250710033706.71042-7-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710033706.71042-1-ryncsn@gmail.com>
References: <20250710033706.71042-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Slightly tidy up the different handling of swap in and error handling
for SWP_SYNCHRONOUS_IO and non-SWP_SYNCHRONOUS_IO devices. Now swapin
will always use either shmem_swap_alloc_folio or shmem_swapin_cluster,
then check the result.

Simplify the control flow and avoid a redundant goto label.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 847e6f128485..80f5b8c73eb8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2320,40 +2320,33 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			count_memcg_event_mm(fault_mm, PGMAJFAULT);
 		}
 
-		/* Skip swapcache for synchronous device. */
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
+			/* Direct mTHP swapin skipping swap cache & readhaed */
 			folio = shmem_swap_alloc_folio(inode, vma, index, swap, order, gfp);
-			if (!IS_ERR(folio)) {
-				skip_swapcache = true;
-				goto alloced;
+			if (IS_ERR(folio)) {
+				error = PTR_ERR(folio);
+				folio = NULL;
+				goto failed;
 			}
-
+			skip_swapcache = true;
+		} else {
 			/*
-			 * Direct swapin handled order 0 fallback already,
-			 * if it failed, abort.
+			 * Cached swapin only supports order 0 folio, it is
+			 * necessary to recalculate the new swap entry based on
+			 * the offset, as the swapin index might be unalgined.
 			 */
-			error = PTR_ERR(folio);
-			folio = NULL;
-			goto failed;
-		}
-
-		/*
-		 * Now swap device can only swap in order 0 folio, it is
-		 * necessary to recalculate the new swap entry based on
-		 * the offset, as the swapin index might be unalgined.
-		 */
-		if (order) {
-			offset = index - round_down(index, 1 << order);
-			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
-		}
+			if (order) {
+				offset = index - round_down(index, 1 << order);
+				swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
+			}
 
-		folio = shmem_swapin_cluster(swap, gfp, info, index);
-		if (!folio) {
-			error = -ENOMEM;
-			goto failed;
+			folio = shmem_swapin_cluster(swap, gfp, info, index);
+			if (!folio) {
+				error = -ENOMEM;
+				goto failed;
+			}
 		}
 	}
-alloced:
 	if (order > folio_order(folio)) {
 		/*
 		 * Swapin may get smaller folios due to various reasons:
-- 
2.50.0


