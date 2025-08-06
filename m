Return-Path: <linux-kernel+bounces-758008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFD6B1C9A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE117628305
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62FB29B206;
	Wed,  6 Aug 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFIbCEHZ"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C429ACE6
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497125; cv=none; b=nsUSb6MrYWbEtdebDA2WRMA0obCoFAp4bP/sflqNEvoQG8Te2XJw1d7hCNeuuUp3zD0SZFTEWoNt/PTmGyuN2vODToe3+Q0QN3Pr0/UxlZdR1KfOm3Dv5uYKbw6pbppC8nfjHyYBkhD0gU03tSQ393Id0p8p7Q7Ul1/XKBpYYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497125; c=relaxed/simple;
	bh=ldCQB4I5JXQ9U4l14mB3/8okrRjdZZ+mHBvLVZQeIFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7OdC6v3KikEV/IxfElK9si4ZFJ3tqeyyfOqgy8PqpOX1WKgrEqxu9iQU2x3+MfDQj0ZbOSmSNZXmJ+T1BNy6dB1Bgam/c7D6ssu5PHxJkYWpqLTnXV2949Fb069CjtYmW0HzpXnvORRTBCq3bDqptI7BRwyjH1jdTdMig0bZBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFIbCEHZ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e69960c557so6480585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754497121; x=1755101921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sMTOIN9uA6FtHcEuuMQ+RGlJRjFH2hc2yLEqKn8nGIg=;
        b=gFIbCEHZW/GX6uhPdnhAcqrzaqF6M/CE9J4SsCssJ8RgLyOR4IIBazeb2UEhDURx4K
         Ixo/080ctAWaALbt664HQUxN3F6147yf4TK4AfOVfttckeAyeAdKUhrPuwh73apfawwe
         0O3RLukmA447mdbKBaexOto8pheWCFmV9/cxeife0gULm3VkV30Pvj+VSQJonqgNkHq3
         EogvRTGRiOEDMETR7vzzeus8X1OZZusO3y/Zb+aFrOFv6/g6u5oX/Ki1JSKyjMMjudcT
         WUvy+G5dGTKzKQ1Xs84mHwcfSKBMpn1sRPWSU+QQNBuSxL0N26nqWEtF+w1ttzAwh/+Z
         pXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497121; x=1755101921;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMTOIN9uA6FtHcEuuMQ+RGlJRjFH2hc2yLEqKn8nGIg=;
        b=gDki8Ek0CrmwKTZ0BItu72nhh5L3LzO0xZ+uQ4rZtTFDaxW5ClYMZh8hPr+FKYn0+p
         XRVOEnNAV2iMYiJAjrjP/t8EK0mZr1KdMb5MK9Hg+iVBaZ33zcOO1clhE7gadMxZokgz
         96luh7G/h99LngSgT09Ydkqm1eTEenC4f8cNfPVf2lxng4cmeVKLbI/uPsVumfhwIFbt
         Z39Pd99D+vGO97kB+cGfakr2juVwkpgv3h2dlVlHyH/pZGoDRqFDx1b0/mGf8O/Nfmj4
         YdOVih+YpdVW4oxc8nP982GnKqApXj7Bhqe5w0UYDRGzTo5RNcKzSvYaWxreaWT1Vynx
         W2cA==
X-Forwarded-Encrypted: i=1; AJvYcCUgtrL68zdarLcrrfjFCH3MOidqIIckg56AmVs/+hqhiDN6WY6UzhWTvEqEjwF9p4yu/Khig2aBEK0TYTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqUbP9k0C03kpautKy/r9uWiHCRyCEhRAlja/HFxOBzVasqkwE
	7UAX0RqQAgK+xQGPCYtGkLV+Pnss6CGd5XOz+mIQuRD8ZoVbfAmzS76t
X-Gm-Gg: ASbGnctiv4yz+WGY7pUA6ck8i8gfNMtzk4Z1cVVs4NL1jn58b5rY5Mhu6a7BdIRo7Fj
	TWMoMb5CPZ8WTTak/3FSCweIpvR6//jCyqRnr/kYlfYsiDAtOme8UhXZ1psmRqHmSgFOFJUi88B
	95zYTnMsDIwB8XxCpoeX/bheq9xuxHpMGtcUWFOGOJi5eGawtKU56yEcaggMcOXm7z2nZZqA3JC
	euU0C0YDEKAH3lGlBMC/B+m3b+yjEvXTUaYWKMX3keJW76kcNaclASdJDxBhE9mhNPTqJ1d11RX
	+XyeUztE4+/cJt0RCWIVT27OEy9xQxq61pPhJCnoSsMzO2BpGcG3mRYG0Wn3UqqnSNQsJZrTYob
	7ZhWuOi0E833iexkAyGekkhutzBA=
X-Google-Smtp-Source: AGHT+IH2ToR5PB3gBgQpmqW6rQV+H4WJbPvMMoHldmsha2gx+ZjR+coMJuG5GMek6CdkUTk9HM3ITA==
X-Received: by 2002:a05:620a:1a1b:b0:7e0:6402:bece with SMTP id af79cd13be357-7e814df809dmr410774185a.38.1754497121240;
        Wed, 06 Aug 2025 09:18:41 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e7fa35144esm464081885a.48.2025.08.06.09.18.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Aug 2025 09:18:40 -0700 (PDT)
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
Subject: [PATCH v2 2/3] mm, swap: remove fragment clusters counter
Date: Thu,  7 Aug 2025 00:17:47 +0800
Message-ID: <20250806161748.76651-3-ryncsn@gmail.com>
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

It was used for calculating the iteration number when the swap allocator
wants to scan the whole fragment list. Now the allocator only scans one
fragment cluster at a time, so no one uses this counter anymore.

Remove it as a cleanup; the performance change is marginal:

Build linux kernel using 10G ZRAM, make -j96, defconfig with 2G cgroup
memory limit, on top of tmpfs, 64kB mTHP enabled:

Before:  sys time: 6278.45s
After:   sys time: 6176.34s

Change to 8G ZRAM:

Before:  sys time: 5572.85s
After:   sys time: 5531.49s

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h | 1 -
 mm/swapfile.c        | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2fe6ed2cc3fd..a060d102e0d1 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -310,7 +310,6 @@ struct swap_info_struct {
 					/* list of cluster that contains at least one free slot */
 	struct list_head frag_clusters[SWAP_NR_ORDERS];
 					/* list of cluster that are fragmented or contented */
-	atomic_long_t frag_cluster_nr[SWAP_NR_ORDERS];
 	unsigned int pages;		/* total of usable pages of swap */
 	atomic_long_t inuse_pages;	/* number of those currently in use */
 	struct swap_sequential_cluster *global_cluster; /* Use one global cluster for rotating device */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1f1110e37f68..5fdb3cb2b8b7 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -470,11 +470,6 @@ static void move_cluster(struct swap_info_struct *si,
 	else
 		list_move_tail(&ci->list, list);
 	spin_unlock(&si->lock);
-
-	if (ci->flags == CLUSTER_FLAG_FRAG)
-		atomic_long_dec(&si->frag_cluster_nr[ci->order]);
-	else if (new_flags == CLUSTER_FLAG_FRAG)
-		atomic_long_inc(&si->frag_cluster_nr[ci->order]);
 	ci->flags = new_flags;
 }
 
@@ -965,7 +960,6 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		 * allocation, but reclaim may drop si->lock and race with another user.
 		 */
 		while ((ci = isolate_lock_cluster(si, &si->frag_clusters[o]))) {
-			atomic_long_dec(&si->frag_cluster_nr[o]);
 			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
 							0, usage);
 			if (found)
@@ -3217,7 +3211,6 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	for (i = 0; i < SWAP_NR_ORDERS; i++) {
 		INIT_LIST_HEAD(&si->nonfull_clusters[i]);
 		INIT_LIST_HEAD(&si->frag_clusters[i]);
-		atomic_long_set(&si->frag_cluster_nr[i], 0);
 	}
 
 	/*
-- 
2.50.1


