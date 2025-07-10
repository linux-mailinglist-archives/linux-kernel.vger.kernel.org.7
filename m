Return-Path: <linux-kernel+bounces-724855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FF0AFF79D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D4417B253D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEE128467A;
	Thu, 10 Jul 2025 03:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwjFQVaT"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779D283CB1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118663; cv=none; b=iTGUZn/jCBQsgLasA7Hx7Poo8VrLPwgnB7up3y85Uz7b19o9MhLq4s/OCf/hSR+7jQcu7M7woDrJaNdLMyhdCwTYPYNsVnpTNpxg8WAZA9olfGN2DEvxZDMNPMhGzgz3My65HzAGYNjJL4+3cJzOVTBABlJkwuuYJAU2ewlFSIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118663; c=relaxed/simple;
	bh=RYXgK8Gp6hun7PA1bn+yuH+2nP2F6yKWp32CpxJop20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6/GofnHhLfUVrjBtyhXu7+i7bLY7f8o8psoqzY6OhF1zp3h9UEgnVc/wb+fk41PxBDxvG0eBvdgywXsoXkOOr04JQDvuiXc0WaoDdnuF5+HghfpKweFLCBPb327olTUg/HI8HJ16U2nPexb3GiOLqeEMeitJwiz0TSGwCnqZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwjFQVaT; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3138e64b3fcso610942a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 20:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752118661; x=1752723461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZHcB8oljduSMbeVIzGe/KyVk4jWAgvGawIHTov+tfUg=;
        b=AwjFQVaT0He+qDS43867MFgvIXKio9qkrKWhphM3/gcPM7SrUvtu0wEdFjHCqKT7I+
         50uJKpQypHcHtkWW+LGzL5NnezM1FaT1AFzE5/+5+IKbRtg71ehEV1X93Jr84embCc4Q
         lp3BblcPp4aXiANRSUCn52Ab2wo9IsCoZDVYrhC5AyEJVF8c2w10uD0aSxTcmFk9jm1g
         FseIZGsFgfpieZ8sY1TzzMsQ5yS/uhdQBOohMFl1s3pASZSPT/n7KrIahIPg/HC9WGq8
         BIu5UddAtEx8DhLSfKHspfUevwfiBQsQEmsn0fO4thlt1WrYsaRiMPVXCVa5hFhFTdA9
         o2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752118661; x=1752723461;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHcB8oljduSMbeVIzGe/KyVk4jWAgvGawIHTov+tfUg=;
        b=BpY89uC8/BzPFfsRJgtzTxiy2KT8rCkHk/IVIYuPFyR8oWz1rfnjU/OvWvTA79XZ1p
         LemPqTt7Ql+jv5IINrnzWMzPPU+5m202heTFl9m/RGhCQKjQfXhzNEdnptBzhsHBB5Kn
         cKz+b5NkWtFfFD6ZBfiypUqILLzmSwdJWvEDMhHRPlBMD6b4xYkukafP9Wur4BbQJH38
         Ydnqlg+24OBTPB/ai6ULcumxBEiIe/4EW0QlO/B8fXrZmgM23kwqJKi3jS/X7kNQJSUv
         oEboMQGdW/S5ynOS+S501WV+7L2Rn0Oz8wh/5qDUpUmew2SOEO+Yc9N6OZLqmP78bg1f
         euRA==
X-Forwarded-Encrypted: i=1; AJvYcCXMmMyEKqqBokk182mGyJo85a2J8SkBG+MTFR+h911XUhvvbmff/GBiGgPTxdtLRuFlgnbYRBO1/CWMB9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhkSOSP8ygYkpnRtDUY2JhUVQafn/ST7ZNboTr0CS2lHkheYeP
	PJK2l+TtAS892WXB1fZoLE0TXomRGFyoBmzGcYnH3gkgyr+LB5KKnG1N
X-Gm-Gg: ASbGnctMwsizV/W7Cp9E0gRCPFXK1t16+Ph+KbFvmd8PoFabQc4443PXPabd3abhdon
	pod8YsYUDn8n2niNSBFQvRx1ZHH0mjXnacDqo3GX+c30IREF8I84l/Mp68lNEJ3Dyi7haPaxqkz
	dFqmxj8lxGWB/LcqDLELrCpW/6aUMt1THuqg3sN9JWBM/v0HXDA4GULnG69S4lMSenD6fU7gGPp
	gNJRkOYuoCFsskxCnUkPfbvXGCvCpdSVumWTykpqKa5njWIv3BqortVKkqh2t7r9J253EJ45hXJ
	zccnJj7nAigNV2aOmvUtXZk18P3kzzdnVuRaoX+TbRI/eE+QSByvkwQpTWeQWCHmRiLYGiUSWAF
	1
X-Google-Smtp-Source: AGHT+IEerNWA6q17dFVLFW54pLNpCFs1CG/nuAgw8pHTzR/43YyD7Fsi4qinNk+ExteACuyvRH0b1g==
X-Received: by 2002:a17:90b:5249:b0:313:1a8c:c2d3 with SMTP id 98e67ed59e1d1-31c3f00a92bmr1520670a91.22.1752118661187;
        Wed, 09 Jul 2025 20:37:41 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300689aasm3716320a91.13.2025.07.09.20.37.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Jul 2025 20:37:40 -0700 (PDT)
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
	Kairui Song <kasong@tencent.com>,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v5 2/8] mm/shmem, swap: avoid redundant Xarray lookup during swapin
Date: Thu, 10 Jul 2025 11:37:00 +0800
Message-ID: <20250710033706.71042-3-ryncsn@gmail.com>
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

Currently shmem calls xa_get_order to get the swap radix entry order,
requiring a full tree walk.  This can be easily combined with the swap
entry value checking (shmem_confirm_swap) to avoid the duplicated lookup,
which should improve the performance.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e3c9a1365ff4..85ecc6709b5f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -505,15 +505,27 @@ static int shmem_replace_entry(struct address_space *mapping,
 
 /*
  * Sometimes, before we decide whether to proceed or to fail, we must check
- * that an entry was not already brought back from swap by a racing thread.
+ * that an entry was not already brought back or split by a racing thread.
  *
  * Checking folio is not enough: by the time a swapcache folio is locked, it
  * might be reused, and again be swapcache, using the same swap as before.
+ * Returns the swap entry's order if it still presents, else returns -1.
  */
-static bool shmem_confirm_swap(struct address_space *mapping,
-			       pgoff_t index, swp_entry_t swap)
+static int shmem_confirm_swap(struct address_space *mapping, pgoff_t index,
+			      swp_entry_t swap)
 {
-	return xa_load(&mapping->i_pages, index) == swp_to_radix_entry(swap);
+	XA_STATE(xas, &mapping->i_pages, index);
+	int ret = -1;
+	void *entry;
+
+	rcu_read_lock();
+	do {
+		entry = xas_load(&xas);
+		if (entry == swp_to_radix_entry(swap))
+			ret = xas_get_order(&xas);
+	} while (xas_retry(&xas, entry));
+	rcu_read_unlock();
+	return ret;
 }
 
 /*
@@ -2256,16 +2268,20 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		return -EIO;
 
 	si = get_swap_device(swap);
-	if (!si) {
-		if (!shmem_confirm_swap(mapping, index, swap))
+	order = shmem_confirm_swap(mapping, index, swap);
+	if (unlikely(!si)) {
+		if (order < 0)
 			return -EEXIST;
 		else
 			return -EINVAL;
 	}
+	if (unlikely(order < 0)) {
+		put_swap_device(si);
+		return -EEXIST;
+	}
 
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap, NULL, 0);
-	order = xa_get_order(&mapping->i_pages, index);
 	if (!folio) {
 		int nr_pages = 1 << order;
 		bool fallback_order0 = false;
@@ -2415,7 +2431,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	*foliop = folio;
 	return 0;
 failed:
-	if (!shmem_confirm_swap(mapping, index, swap))
+	if (shmem_confirm_swap(mapping, index, swap) < 0)
 		error = -EEXIST;
 	if (error == -EIO)
 		shmem_set_folio_swapin_error(inode, index, folio, swap,
-- 
2.50.0


