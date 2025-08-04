Return-Path: <linux-kernel+bounces-755572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F42CB1A898
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61187189E3E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1428C2D2;
	Mon,  4 Aug 2025 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLy5W/PR"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9E28B4FC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754328297; cv=none; b=OR/vlTlIBOZHzdlEWnaLHQV2c8Sbhz0WA1jB6bN1t+MzvAU/J5t6597epWgCFfXB6vRwKhz1WGUHAQxW317m/2RGI0FYSCwvdFMB6bogNBt6AjxkWselad9aDUIJRMHZEjdEgrjY0LPG9XvguPP701yAlK0GaqxJMU4wTXGKnR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754328297; c=relaxed/simple;
	bh=qO5Ew7xotEf+LSjx9i7tRW9PtT+V4Seu5gf4adD9WvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dt0nCF8/h0TEPHTM6Rx9F/jd66C6mkk8PSmMl5BR+N9bzr+jdPNATKjTdbC64RN6goK2r2aeNgrrVK9bmiNuV6aaHtrHIB8ZnyPK7+K99AJIUBGuBiRqsqhXycHlNGtt2B+prKLh2CXNJVZpDVglPl8oweUcWW4k4s6Afx2AZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLy5W/PR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76bd9d723bfso2845139b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754328295; x=1754933095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PZR0jWbWu/lG5CSlpgwY9+3+NvurMoK+b/pH3fKR8CI=;
        b=lLy5W/PRbT/GSa7DX2lX4KP9nqw1p2/sOGnayQRLII894Hjo4PkEiUBn5bQw6aRjHw
         nM8a4ISD8JwDa4A8PkU/NxJXCzzxDLW3yMc+Xss0lqgGYtsdAIZaGVBoOzJtJE74PN/s
         Mt9emuODF/dSGoF9JncTrr9kxcl2vm2T6A9RXej9B6TrTO+yxfgd4sLUXRZ/mLr5Jf2x
         zk4AB6nX7my9njbdJz1IX0tLtlSSnGKEYRZ6x1t1v4kurnwVeVL29Id+tZ6oS4AZooAW
         110kIseJi9QkrTO/0PAXzMCLRc/kR6SqOR1y/Hy1eYuZkQEA5i1dvzm8WuSkASGnzEo2
         8d0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754328295; x=1754933095;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZR0jWbWu/lG5CSlpgwY9+3+NvurMoK+b/pH3fKR8CI=;
        b=ppq0zpQA0pGuyWipURJQNqGUsRnESqlJ2SK0keaPkaheuNO70NXlGK7mqhE3hYJ4+x
         IQvbGfx17cUCjzyPtxS8tWxaEM4aMQspjeaieSYMlzn9p1P39ebp/qzV71GviHRrHSJ0
         puvhJJRYEug2KlsG/v+8bBbIt4hTM1ZuRusMfWn3McUHmmbn8Mcaq+WDxe2QzcbVTZjO
         vVkX67GjgMGiO9ms2wFDNSQfVMywH0I6/ni7xr6mK4nzWuCuxZzAhG60nm5LA2Sfuqjz
         F/f/XXt+nHuUy5v0OfajKpcO3Kj4DsdGLB679VYHpGBAC782rMwnS7eUEGVH9sqDnybw
         6osg==
X-Forwarded-Encrypted: i=1; AJvYcCXzifH9kTr03E0n3+JOMUPbbXckde+fzoDx5xNNLJH14NLnNLTEwCps5O6EFMTTcHQt2gz7fRnIkxOHoR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7aZvjBhiLTBNkzElHPOX/oXJpahlmgm45H4yjyIEu/h0rTyp5
	cxWrM57w2rACAlcp2Z5PD1srMWW1lrF2Vn2lPYH4ONgeXaVgMLtzNQC6b3lP+E+Cn+Q=
X-Gm-Gg: ASbGncvilovlnIzXgHnq7VorE04R4DFqMBwDp2kMeAkablVyVqB5aB78sj/b0jF8UMr
	/Dn1U+qCqkPkbdGrphgZEVE6dhAaPn1gpStsVxfqXUoICNHWb5hsvMbrkqcBmz9sQJ+/7/s1zY0
	L1M/Zjga9IRSwputjy8yAIR0ApsNQoPws5TrQsRk8eGSeButflNmFaB+lUsopW2JfSRgU2io5Sj
	hnlPRHGc/I+xB4yNhLBOCv8MJJ84DbcjaLT9sFlwazJaARi5asHXDPW/vbi3ZpzQevzvUu6XwHx
	BJkbSWRzx/PkFZoHizyALEEDrtp1su0RLPunCZ7MW0DCXfY3dEDorWRlxCFw4F2OIDvMVtm0tqh
	w6hzFfszWSiw48/i8sdzmNscteCc=
X-Google-Smtp-Source: AGHT+IGHdiNC7GNzQLwpVWRh03+lnLLmoCulHv8RNEfhsU1tU00VgfdWrwm2VCOx+cO0qpIIb4oOtg==
X-Received: by 2002:a05:6a00:1701:b0:76b:f5c3:2af9 with SMTP id d2e1a72fcca58-76bf5c337ecmr9874395b3a.24.1754328295484;
        Mon, 04 Aug 2025 10:24:55 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bfcb26905sm4194530b3a.123.2025.08.04.10.24.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Aug 2025 10:24:54 -0700 (PDT)
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
Subject: [PATCH 2/2] mm, swap: prefer nonfull over free clusters
Date: Tue,  5 Aug 2025 01:24:39 +0800
Message-ID: <20250804172439.2331-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250804172439.2331-1-ryncsn@gmail.com>
References: <20250804172439.2331-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

We prefer a free cluster over a nonfull cluster whenever a CPU local
cluster is drained to respect the SSD discard behavior [1]. It's not
a best practice for non-discarding devices. And this is causing a
chigher fragmentation rate.

So for a non-discarding device, prefer nonfull over free clusters. This
reduces the fragmentation issue by a lot.

Testing with make -j96, defconfig, using 64k mTHP, 8G ZRAM:

Before: sys time: 6121.0s  64kB/swpout: 1638155  64kB/swpout_fallback: 189562
After:  sys time: 6145.3s  64kB/swpout: 1761110  64kB/swpout_fallback: 66071

Testing with make -j96, defconfig, using 64k mTHP, 10G ZRAM:

Before: sys time 5527.9s  64kB/swpout: 1789358  64kB/swpout_fallback: 17813
After:  sys time 5538.3s  64kB/swpout: 1813133  64kB/swpout_fallback: 0

Performance is basically unchanged, and the large allocation failure rate
is lower. Enabling all mTHP sizes showed a more significant result:

Using the same test setup with 10G ZRAM and enabling all mTHP sizes:

128kB swap failure rate:
Before: swpout:449548 swpout_fallback:55894
After:  swpout:497519 swpout_fallback:3204

256kB swap failure rate:
Before: swpout:63938  swpout_fallback:2154
After:  swpout:65698  swpout_fallback:324

512kB swap failure rate:
Before: swpout:11971  swpout_fallback:2218
After:  swpout:14606  swpout_fallback:4

2M swap failure rate:
Before: swpout:12     swpout_fallback:1578
After:  swpout:1253   swpout_fallback:15

The success rate of large allocations is much higher.

Link: https://lore.kernel.org/linux-mm/87v8242vng.fsf@yhuang6-desk2.ccr.corp.intel.com/ [1]
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5fdb3cb2b8b7..4a0cf4fb348d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -908,18 +908,20 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 	}
 
 new_cluster:
-	ci = isolate_lock_cluster(si, &si->free_clusters);
-	if (ci) {
-		found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
-						order, usage);
-		if (found)
-			goto done;
+	/*
+	 * If the device need discard, prefer new cluster over nonfull
+	 * to spread out the writes.
+	 */
+	if (si->flags & SWP_PAGE_DISCARD) {
+		ci = isolate_lock_cluster(si, &si->free_clusters);
+		if (ci) {
+			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
+							order, usage);
+			if (found)
+				goto done;
+		}
 	}
 
-	/* Try reclaim from full clusters if free clusters list is drained */
-	if (vm_swap_full())
-		swap_reclaim_full_clusters(si, false);
-
 	if (order < PMD_ORDER) {
 		while ((ci = isolate_lock_cluster(si, &si->nonfull_clusters[order]))) {
 			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
@@ -927,7 +929,23 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 			if (found)
 				goto done;
 		}
+	}
 
+	if (!(si->flags & SWP_PAGE_DISCARD)) {
+		ci = isolate_lock_cluster(si, &si->free_clusters);
+		if (ci) {
+			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
+							order, usage);
+			if (found)
+				goto done;
+		}
+	}
+
+	/* Try reclaim full clusters if free and nonfull lists are drained */
+	if (vm_swap_full())
+		swap_reclaim_full_clusters(si, false);
+
+	if (order < PMD_ORDER) {
 		/*
 		 * Scan only one fragment cluster is good enough. Order 0
 		 * allocation will surely success, and large allocation
-- 
2.50.1


