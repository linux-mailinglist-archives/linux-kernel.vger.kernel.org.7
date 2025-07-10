Return-Path: <linux-kernel+bounces-724859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7496BAFF7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66927563797
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C50285C81;
	Thu, 10 Jul 2025 03:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si/mmUnT"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C672857CF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118674; cv=none; b=Czdd72/BvB7TlM5D3F5nvbrQYjUptnBqYIRrpzaC4B43NA1YpeV//hAoHB55u/EdJ3tObtrE94sgQhj/uYNKltUExVmAJOawJRR2nTSgK40ugKgwzvl84qOfYVKlLZx74Be1QGZuJW3GwCefQ+QsV44lvTUu5NEgiVO91E/A2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118674; c=relaxed/simple;
	bh=+Gr4ZaK6+CEBXdeWK8bvMKktBfxCGaOLP73eUiHj55A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMH/1gVDgpDbI1dFkGyf0FXOda8SYZh4e0aBFfmRuu0Gxz6jXpAT2f+fo2dKqry5syjo5/ina4GrMqjdDkm+NhGDRSnGtY1ermfVSEhF+l1BbtycH7ibwPX2SCsPWSu/rngjKELCkGDTGRm9BZdi7TCG9H1/0g4Wq0MoFC98trs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si/mmUnT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso554892b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 20:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752118672; x=1752723472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6c/3UTjwUomIURBx5sx1cWF1vLKF6eZKQiVovtdE0rk=;
        b=Si/mmUnTT3vHlk03PeTUfVeq8t4YkSB9acqpTAjVTi09/h25+F9effVGzV32/L1ksQ
         SlOE5/yqCDfr6llWLP2DT6svooejPGIIJ+tLZsaQbbfwJC1TAT0Z0vmn1NrG+o+KuflD
         3AoQYhWagZsNepR1gwXus8Sl6A/nZ2dH6KgZvR1D8lJQvkWZq/yD1VOh4gJVip6ps/Ed
         cv5abF3y7OgR0mnA7VBgkd564kCjj/jUoVJBKvAw/kWDBAc7G005uw+YcDwbZYoIeYj7
         Rpgp/hTOa2xt80n0cuT7DZfs9KRnJtVRh2tktWOJIuHReiPknm7j7jv43a3Uly2zis13
         deTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752118672; x=1752723472;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6c/3UTjwUomIURBx5sx1cWF1vLKF6eZKQiVovtdE0rk=;
        b=aXGzpaNXs8KX39WREO7qovaxnRJt5iE8qpup8u1x7GeymOBMEVLWjslF9mOCORpXF1
         /sWMHovRzMRFFLAevMaJHM+N/Pz3Zqwf+oexj12Hxv3sg/qmDdro9IBO18c7GryHsNA9
         j2J5Bpevc60pefDhBDQLy9V7d6mDUYcmbZMzoJk/5htK0d0GgEEcv+azBtccD0ZF45o4
         5M9BDNwXtEo361sARbW1/tYf0w0lZ1gC8c2hmYhCmr3+OBDldtlxdAjbfcJn2zzitiZY
         c5x0GRBtjaINzbUfaH+X/VFZAA2xTeoMQwSGROLfxOmz+CndBUj5PBX+JoemSp5QSIP0
         uyLA==
X-Forwarded-Encrypted: i=1; AJvYcCV9B8hCDgZK1s5OkO5zO3b/+Fk0igosJsvFghSfiR2hhsj5pvDIIfNpPlP+CbFc24Ul71/nu/+ZnxA8SVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrPXwmaGyvgONQKA0/5p65iHqdFlyg4iZZs4ozK3YJbEjIHzFZ
	fCFsP8OJkLwlzVIdFFBlSl+dO6WoHWStpqMeNZUqfFOF0gPuERq3bnEf
X-Gm-Gg: ASbGnctvkE4TuDtFxzbtU1zvIjdkSbUGNUy137gDJCs9piSCNM03ID5ZO4aRKGcaAXX
	RZnfDWbE8LhWD2pOao9ITJ1vt6O/H/i+uIvyiEoU3CfG6Jhu8Deyx1tg9mVmYbYaceiW9ngpj8F
	ZLD9J1N9P2nWXBgMCp/rcZyJJRe1b+MgAw5/LY8IzMsvfaQIwnijsz+qLkAGwhDJ07QS6MJyzSg
	KqwWidZJLxogYEzJAMUgD+LNi4HqLkANgqoIC60UNjCitoB1snU9ivGuQfRk9m19dZAhEQzMD/9
	YoZlVzMTXGEZiBD9i6UbcM0VP5TXQkb5lbtQBmp/k/VD+7lRvyfSe1nDJYBwj098T7dec0HhRbt
	c
X-Google-Smtp-Source: AGHT+IFo+hUv+hE7jl8qtNFOz6BmwhbqfgrE8NbpYioKLZ+rFaC6z2kjXG11U2fuldmQTgRk7Yr+Sw==
X-Received: by 2002:a17:903:234d:b0:234:d7b2:2ac4 with SMTP id d9443c01a7336-23de481b3b4mr15669525ad.17.1752118672195;
        Wed, 09 Jul 2025 20:37:52 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300689aasm3716320a91.13.2025.07.09.20.37.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Jul 2025 20:37:51 -0700 (PDT)
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
Subject: [PATCH v5 5/8] mm/shmem, swap: never use swap cache and readahead for SWP_SYNCHRONOUS_IO
Date: Thu, 10 Jul 2025 11:37:03 +0800
Message-ID: <20250710033706.71042-6-ryncsn@gmail.com>
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

For SWP_SYNCHRONOUS_IO devices, if a cache bypassing THP swapin failed
due to reasons like memory pressure, partially conflicting swap cache
or ZSWAP enabled, shmem will fallback to cached order 0 swapin.

Right now the swap cache still has a non-trivial overhead, and readahead
is not helpful for SWP_SYNCHRONOUS_IO devices, so we should always skip
the readahead and swap cache even if the swapin falls back to order 0.

So handle the fallback logic without falling back to the cached read.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 97db1097f7de..847e6f128485 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1982,6 +1982,7 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	int nr_pages = 1 << order;
 	struct folio *new;
+	gfp_t alloc_gfp;
 	void *shadow;
 
 	/*
@@ -1989,6 +1990,7 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 	 * limit chance of success with further cpuset and node constraints.
 	 */
 	gfp &= ~GFP_CONSTRAINT_MASK;
+	alloc_gfp = gfp;
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 		if (WARN_ON_ONCE(order))
 			return ERR_PTR(-EINVAL);
@@ -2003,19 +2005,22 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 		if ((vma && unlikely(userfaultfd_armed(vma))) ||
 		     !zswap_never_enabled() ||
 		     non_swapcache_batch(entry, nr_pages) != nr_pages)
-			return ERR_PTR(-EINVAL);
+			goto fallback;
 
-		gfp = limit_gfp_mask(vma_thp_gfp_mask(vma), gfp);
+		alloc_gfp = limit_gfp_mask(vma_thp_gfp_mask(vma), gfp);
+	}
+retry:
+	new = shmem_alloc_folio(alloc_gfp, order, info, index);
+	if (!new) {
+		new = ERR_PTR(-ENOMEM);
+		goto fallback;
 	}
-
-	new = shmem_alloc_folio(gfp, order, info, index);
-	if (!new)
-		return ERR_PTR(-ENOMEM);
 
 	if (mem_cgroup_swapin_charge_folio(new, vma ? vma->vm_mm : NULL,
-					   gfp, entry)) {
+					   alloc_gfp, entry)) {
 		folio_put(new);
-		return ERR_PTR(-ENOMEM);
+		new = ERR_PTR(-ENOMEM);
+		goto fallback;
 	}
 
 	/*
@@ -2030,7 +2035,9 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 	 */
 	if (swapcache_prepare(entry, nr_pages)) {
 		folio_put(new);
-		return ERR_PTR(-EEXIST);
+		new = ERR_PTR(-EEXIST);
+		/* Try smaller folio to avoid cache conflict */
+		goto fallback;
 	}
 
 	__folio_set_locked(new);
@@ -2044,6 +2051,15 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 	folio_add_lru(new);
 	swap_read_folio(new, NULL);
 	return new;
+fallback:
+	/* Order 0 swapin failed, nothing to fallback to, abort */
+	if (!order)
+		return new;
+	entry.val += index - round_down(index, nr_pages);
+	alloc_gfp = gfp;
+	nr_pages = 1;
+	order = 0;
+	goto retry;
 }
 
 /*
@@ -2313,13 +2329,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			}
 
 			/*
-			 * Fallback to swapin order-0 folio unless the swap entry
-			 * already exists.
+			 * Direct swapin handled order 0 fallback already,
+			 * if it failed, abort.
 			 */
 			error = PTR_ERR(folio);
 			folio = NULL;
-			if (error == -EEXIST)
-				goto failed;
+			goto failed;
 		}
 
 		/*
-- 
2.50.0


