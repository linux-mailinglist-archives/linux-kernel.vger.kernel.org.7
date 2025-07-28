Return-Path: <linux-kernel+bounces-747608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F317B135E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E6616EA3E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0101227BA4;
	Mon, 28 Jul 2025 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBDFWtPm"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B6822577E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689223; cv=none; b=XcH87bftXDIK7fLI3hdyBu8+xdmeaO1Sy5Wb1emTzJJ0fI4IO79Dm5ejnk39W61V1Hb+vIMUy86ZGfKDHF+qdadV3TcaYVkMNJLiaSkeO4WBWTIyuvndM7VyY6gQiFSUXzzPmjB9qUWxphky/8nBZloecY7239R0ED4n7OIuFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689223; c=relaxed/simple;
	bh=ehyX7jsFmVcumacy/IVKlhxgf84bhBqyqaV9j8Q3bGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGsWiUdnSxGdfv4RL3LNCzwNtqprs4thpgWxT2KFhkTNt8iW6HMFEQ0uQoJBLaq+tio1vUAOWOmDMBM/T35qrug5xESrnxKkpz9LgCzjrb6cS9zujhYUMomfBX2FRKAukD9ORPN/0sEuaq/fClD5cln1WXJXMvLZY0PH9BV+oOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBDFWtPm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23636167afeso35312035ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 00:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753689221; x=1754294021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WK9dh6JH6yfakGJA4pFDq4glQrsDDuFzovtqS8CVL90=;
        b=IBDFWtPmzcp0efPFp3x4l1Ewsh6CtQP+jzor13dcIUY/LDi/c4jMv2BLRoIl2foXBE
         RWQlTo3MwT3zjPKlt/aCJ3Q9z5br3VpfQUpJmRiz4XuwGUxrEVdDGnDmSlivSh1+DU7g
         MfZkmxAMFr7FHPsLwsFQQdTt4dYMrG4w2Ewzbb/rtGatsLTvOj0KWIajOQrYIrK3ncao
         Nh1Xu1I3UC6HoRWZj1RMWfKLrcoC6tjYZCyVGCUbcw9AQRmjRD+GKtZtdW02LWWHMIKg
         g661DgBLrhOFs5EjXF/gUJTg4uTc4/WwzMvBMcZDeXzaCAwKf6Ov1owmcZt9XqhpCsY5
         XUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753689221; x=1754294021;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WK9dh6JH6yfakGJA4pFDq4glQrsDDuFzovtqS8CVL90=;
        b=AsSs+0asXRzHNTD4MbcYNT8AFLFc630F42yQeL8ItWp0xeghWxaEEPlSV6GjeZAjMX
         +K01f1UcyCnV2GtwqSKalJlLEM1WT+0jUd9YQUCntqoUgaNFL3nQVp6SZtUmkXBWr30z
         S3KQE2eP2aIF6IvPXBh6FAkRlu2FXPv6TamOFyaPl1vjEV3ysPCzwEEcmr8+u7yODaI5
         td9YRSuTNk+vindMfMKvyUgxSUKLfRhzPpcUpTMMTknSW4TP0gHuJz39RBO+azvboTxd
         KfU6cppIHAEJdYDpcPrPVSme/zfJAn/rYKWwVAp1tjGoNTxzhy9HapMlph9AxvbQ2cTk
         5/+w==
X-Forwarded-Encrypted: i=1; AJvYcCVjHt+dyivnCxHDkRRyjrDnp7Di7SjewOXmTaBSaYy79jileBu+RsvQSNKAALQWxoNbDoU+tgIbqvMxwLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCh3uD8+B1ncXf+ZjjHCFD++1YwnZPk6fDjGvXY/+ZPDunDAs
	014XmlzNYrz+uIwf2ZmNqUulZTk3r8ERmqJgTKOeiCTJM3Hm+sgDT7S1
X-Gm-Gg: ASbGnctBwQLDRD1tGQlOMAk+S8POfpxMS+g3GCv9WI5ez7qHT5fmKkx2wyoGPevZQB3
	YLLtAP5ACZD43E0jouxSBhGCx8hEPnnAcBDLHzvjiAGShZDVFHWIT7O/lLGFuClFQ/vPBFDmT3v
	/tU6v4hMsvfChVdVqlLe7of8V6s8kxCtxTp0lt0rIuvbxHFtCGrK8FZo4G4uP/ubATAJaTQVZlv
	tUryp2LnkxQD6Sy+vd7DbsIFCBKpAwJg3h3zCl+l5zRDLNtAnTF9FIs88szFxKXKv1wR8YbQOR/
	lZqzH37AWPnSDy0Q3+/DdtyQvb8KTReHZ7J0iYhsakrJ8kKo5cfitNzaeIoliwoQM3lHLs23YRD
	0ik0GP7zvsqA0U+Uzxiac4OFk65AokRWtbTBJ
X-Google-Smtp-Source: AGHT+IFulF7WReIYQE4qMeTpC92VcxNTmoJq5nsI6JchU0KIZO8LUZI5RQWcxlYsmeHQlANMK3MvXQ==
X-Received: by 2002:a17:902:fc84:b0:23f:e51b:2189 with SMTP id d9443c01a7336-23fe51b27dcmr99934935ad.17.1753689221027;
        Mon, 28 Jul 2025 00:53:41 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401866c2a1sm20272305ad.4.2025.07.28.00.53.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Jul 2025 00:53:40 -0700 (PDT)
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
Subject: [PATCH v6 2/8] mm/shmem, swap: avoid redundant Xarray lookup during swapin
Date: Mon, 28 Jul 2025 15:53:00 +0800
Message-ID: <20250728075306.12704-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728075306.12704-1-ryncsn@gmail.com>
References: <20250728075306.12704-1-ryncsn@gmail.com>
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
entry value checking (shmem_confirm_swap) to avoid the duplicated lookup
and abort early if the entry is gone already. Which should improve the
performance.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1d0fd266c29b..da8edb363c75 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -512,15 +512,27 @@ static int shmem_replace_entry(struct address_space *mapping,
 
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
@@ -2293,16 +2305,20 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
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
@@ -2412,7 +2428,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	 */
 	folio_lock(folio);
 	if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
-	    !shmem_confirm_swap(mapping, index, swap) ||
+	    shmem_confirm_swap(mapping, index, swap) < 0 ||
 	    folio->swap.val != swap.val) {
 		error = -EEXIST;
 		goto unlock;
@@ -2460,7 +2476,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	*foliop = folio;
 	return 0;
 failed:
-	if (!shmem_confirm_swap(mapping, index, swap))
+	if (shmem_confirm_swap(mapping, index, swap) < 0)
 		error = -EEXIST;
 	if (error == -EIO)
 		shmem_set_folio_swapin_error(inode, index, folio, swap,
-- 
2.50.1


