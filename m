Return-Path: <linux-kernel+bounces-758009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F2EB1C9A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F8018C2018
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A982A29B797;
	Wed,  6 Aug 2025 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhyu1uMT"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7817A29B216
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497128; cv=none; b=Mo9mR1y+yoBLMhNIuZ4MIqEAq80kEU+72voP0h5yPwj0f04NRa5SGvSA9SOuSXdnV8nSPEb5fO8MWI5lSGqrZ7hz3FQPnC65viVLQa+7VSflgFTrfk1ss4icNCjDgJMVo10lnQdDPdkM46Co2uijxO6bQ8EG9swDlyFMftF/na4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497128; c=relaxed/simple;
	bh=D/90zl+iZ+yT5khZEgBn2baqUJ8jl1dXxhgL2921rzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MozuSBYHuM+PHm4OJht3pYrXzd6AfYM2M/ZtzOwqpbspjUqB33Xio01vYZI5ZUZ9oobTS25U/0nMEbTszhRP73t3NZvz61rIy0v0tgg0ZJ+1FI6OuudbdS5cKGSWUjWJwGwF6aH3OeftbxNZotPYzhXwjGkppmBm/M/gPQVbq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhyu1uMT; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e80ba947cfso5805185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754497125; x=1755101925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7xTP21K+jB6LayI4lbO9257BksRaVlqE7Ti1iQOs5KI=;
        b=lhyu1uMTDzmFWHD52YWpLaOxFhBAbj0PRDdxxYQLM2Mxd4dFdGWTYP66PppLzKy6vY
         6dt7JVaPZ/FPPrBnKF8gG7MYoRFHd/1P3cgugwR1sbKAf9UB4b5USBW4ljpuLWHYp0cE
         YJ1WHRQN4NXkG52BxOSQrufQqUGHSHbqmohR75MsgHc4YUaEqcEezLb7ivUgf6Hgd5hf
         ac8ZR25Ie3SIk74mYWXDM2hXuyFB83ZbMkMeQgSD2jTpsIMbF0nZKpac1aR9VgebUqJ7
         VrGPlNa/mjZtwdnlqq7K/TLgulb5QDHh+xy2h5sgxuzRqlaSfSf4nYQHT7tkxNf4r9pf
         SPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497125; x=1755101925;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7xTP21K+jB6LayI4lbO9257BksRaVlqE7Ti1iQOs5KI=;
        b=k8oUgX+kCWpIlxbsCkYEpz6NDFus5VIAb6/cSTqw885UgPz1hbs1SVdlq0UiAD7Odq
         3ikaU31FNXmKSXMah82/h5jj6WoEHbRx+d28ygFUCWFMEK6L0+hlnJeB5R6D302XYxBM
         krws2sbd7j9hnW9Wx075JFuo11hj7Mi6iMpADRuTDKdzgZTvdEjq6IJNBkJqUofBwPtd
         i1x0ZKBiVB6nz0zn08t9TaCw2H5tAylNIg6eJWk9DkVeVacnHLE12vuYpANBVlor2pvm
         5JOmr6ldTYog5Nr6qNEoplmu00SxrTiNJC5tLrChoJeW4jbC3GYYNsrTLodTyIetcBoP
         9/2w==
X-Forwarded-Encrypted: i=1; AJvYcCXsvVUoXedb9XHrW7NbyBxpQRnUk26PUbQo+3uwDv1gyDLYeuFYb/NL6aI1MfDhhDOYtk3rnezkXSYTtuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vvSb+9Tp1AB2kbMdS9veLtFGwxhNy183CNrazJq3XcMQQGhm
	nWOsL086yYAhh4ecNdzOQKUpch6U6B7ifcRe7YAKeEv3hOJQsPFRx3be
X-Gm-Gg: ASbGncuOeLYWII/HKqpDOprT0j8zxE6WHwqkP3eyBR/2M7aCX7r0cZU869MXZ+VNDAR
	DYhXuKSkHa+l0/S1qXhTNk3ScyaaD0IXBv4dYKZPa7SH+OjIL68JK69/AsKyhr0QynfR50AX/bI
	lHLGZEQQKe7E8AHGnmIeWQAg2PWan+KoHu3koEizeubAWIFoCBmDDgVu8sh1KAEaB8Dkdj8SV+0
	XeV55bdmR1SPsFv9mYbtAgcudkJmVvBdXIVv41gaWtUcJh040Pmjd7ddfrRx9yRN4MkQOSxcTPK
	zZZb8GmzZvtRp1QNTde5QbazZtfvi0m8UhVLTCDcHg6nEpPgxyUylkKKLGFNOkKkthLiq3cxwG9
	x1Ah/gWmha69JitRPABCHvFd0lEc=
X-Google-Smtp-Source: AGHT+IEiDj+VysZpnFBYXYgnr7uq4D1H/+DepEQer1BDI3uxqce/V9Sjo60cv+6UqW8BMCTnSCbvyg==
X-Received: by 2002:a05:620a:4513:b0:7e8:848:64c1 with SMTP id af79cd13be357-7e8165f603dmr442638985a.12.1754497125020;
        Wed, 06 Aug 2025 09:18:45 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e7fa35144esm464081885a.48.2025.08.06.09.18.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Aug 2025 09:18:44 -0700 (PDT)
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
Subject: [PATCH v2 3/3] mm, swap: prefer nonfull over free clusters
Date: Thu,  7 Aug 2025 00:17:48 +0800
Message-ID: <20250806161748.76651-4-ryncsn@gmail.com>
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

We prefer a free cluster over a nonfull cluster whenever a CPU local
cluster is drained to respect the SSD discard behavior [1]. It's not
a best practice for non-discarding devices. And this is causing a
higher fragmentation rate.

So for a non-discarding device, prefer nonfull over free clusters. This
reduces the fragmentation issue by a lot.

Testing with make -j96, defconfig, using 64k mTHP, 8G ZRAM:

Before: sys time: 6176.34s  64kB/swpout: 1659757  64kB/swpout_fallback: 139503
After:  sys time: 6194.11s  64kB/swpout: 1689470  64kB/swpout_fallback: 56147

Testing with make -j96, defconfig, using 64k mTHP, 10G ZRAM:

After:  sys time: 5531.49s  64kB/swpout: 1791142  64kB/swpout_fallback: 17676
After:  sys time: 5587.53s  64kB/swpout: 1811598  64kB/swpout_fallback: 0

Performance is basically unchanged, and the large allocation failure rate
is lower. Enabling all mTHP sizes showed a more significant result.

Using the same test setup with 10G ZRAM and enabling all mTHP sizes:

128kB swap failure rate:
Before: swpout:451599 swpout_fallback:54525
After:  swpout:502710 swpout_fallback:870

256kB swap failure rate:
Before: swpout:63652  swpout_fallback:2708
After:  swpout:65913  swpout_fallback:20

512kB swap failure rate:
Before: swpout:11663  swpout_fallback:1767
After:  swpout:14480  swpout_fallback:6

2M swap failure rate:
Before: swpout:24     swpout_fallback:1442
After:  swpout:1329   swpout_fallback:7

The success rate of large allocations is much higher.

Link: https://lore.kernel.org/linux-mm/87v8242vng.fsf@yhuang6-desk2.ccr.corp.intel.com/ [1]
Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
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


