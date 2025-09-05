Return-Path: <linux-kernel+bounces-803651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F56B46358
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4135E192D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4DE28688E;
	Fri,  5 Sep 2025 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt7/0cj8"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F9283FDF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099695; cv=none; b=ZX4ZH6DjM2+qJzWnszg3GSLT+PaApk+vz6TMdn2Wjjxucnq/DQm7Wr5/MsCdM0UB27nhGK97yJUP3s1UnoKB/75oK1Lmy8DbEsDGRwmn9MqqjIcRVLVUlRr1/1TbJwLIl0+l3ZDDZ7ahuSlObglVn+T/adJKEd7vV5+y9E+vvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099695; c=relaxed/simple;
	bh=H1N9v0PSjC5bjNISerZDYJC4cOIRGv8nLszk4ayzCB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlShVXLo0tI14NUlHurOr1oP6ShPqeaSY16WIQ4PtnkVZ+3LKN38nvvGCSROL4TzWZb4/s+Niq8ml+MDOkXNshtXCKoapyIqFnpStRroDJ7k8ttubfOvT4MPlGsPcOx7z7iG0aDHf4g7GcK/kIo5db9HZXh95ASPl0TUTaz4juY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt7/0cj8; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-772481b2329so2640553b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099693; x=1757704493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ox30d6DM6rDiHJuPv69STkw16eZZKgiB3gZs68VZQi4=;
        b=Gt7/0cj8JOOU2Kb1c/zGqevLJq0nyppKPi9Q23Lz4LAvbs3LZBa3/KDEpkZEV00xsH
         h5Gt2B8qkRWvkk7xfrIA/2aOlXVQy/exHGbxodULmzDynCof6CEDHGRq8YfO2827Ovv+
         kOTnfxerf+CQVZbhkLJzrEKNsVD4k5RhaYVtaMbLwBQI3IQgsO0petoIwJKaioK6wVJz
         pjV55x9xaHfcybupyoATOhukfqun+moUubiPy6SkaYOpuRy76h6PlC1nAd7gvHWAUIsD
         kIrQeodOEfiYcSlaINmKdsBn3cxcvSnmGQbqKTOqTV2gWzBig/WxWtm5R72NXchVAR49
         2aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099693; x=1757704493;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ox30d6DM6rDiHJuPv69STkw16eZZKgiB3gZs68VZQi4=;
        b=lBqkW7GajgCLkpCF6Fo0ggHLnomO9pvuesovo8xoVkYEAtgnDxrbuuoigXUxADasW3
         VpwsKSLwCX/eTXGPYCjWPiL34j8QtUlV5nu8JLfT1czPuuFRpQbT+I0jQ7CQ8WYBhaWH
         L5eQJa4xMIk07V++qhPNstid0a7rEM8wgqSXYiPOA4ZS4X6dT+bsj+4dpMDsXfCG19Vw
         LADingwzkcMv0bA8I+2RCtB0az6zSjVCoR8t/FajPQurdJ84SX0tvP2QfCjNtoB0c9wI
         r00LX5pgxFVPAdqmZzkUTawQeq2/yOhkLGx6grRhylbmT3nsaK06q1yaVaVckt8WFGtD
         MpZA==
X-Forwarded-Encrypted: i=1; AJvYcCW+hY0fRC3ARPnDZ+ubY0zRDFzHFyNhPYWUY2MxZq2WzkbUCcZqzWv8VPiTcLY5zHQWMbaolxAcLReHHMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPhMxPupZbOGkG0NPVd+MQyQaDSYvQhFe8hummeSr/JUO/JSfG
	dzmvBKBlhzePc06JWFG4cZSVL3yJGnP6/3tHiGBZ4yGATx+/RAHyuL+v
X-Gm-Gg: ASbGncvfCIIC7UDVnIAZBcP0tjUkVdP2hI3YU/OJrM6vGLg2Q37xmBnH7FL52ZBmNfz
	MK6493Z1Z30SmuQK+Ww869v7ed/wJKdfEQDr3tRRCrXa2ITKxL4hfztTBqjNzGIRpeVzCmaP+Ln
	5+AI+2mEIcA0mMrNAwuUJfNvoQxDaT47hFQT4F2P30DpFZwO9vq6xvFZmnq0RvXXE2anEOTcRSO
	YinBi7aU7T6jcaPLWxH4M6pEEXH7iuLOwEYaiygDU2zNPo/EVLn/AttyBXYZt4IxpKOLLwg/Cow
	sjkq/lS8sq5YLRhPXu9MbVw5Dw/cSiXJuVZzZe4grkO55i3pnKRMIRD0Nxr0REvx/MhY/JWRexZ
	onRWppdKpGH5iaLPV6EPP6YplTxMQR0CnUXsU783zAiUA+xk=
X-Google-Smtp-Source: AGHT+IHkfM1wQBbs4k5VXAzI/0q78S/BXsy7LEozPN1l6mv9TC/7dXb738MOmgCmXvDJRIWgub+l9A==
X-Received: by 2002:a05:6a00:10cd:b0:772:398a:7655 with SMTP id d2e1a72fcca58-7723e38ae13mr26648003b3a.23.1757099693154;
        Fri, 05 Sep 2025 12:14:53 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77256a0f916sm15871442b3a.63.2025.09.05.12.14.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Sep 2025 12:14:52 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [PATCH v2 08/15] mm/shmem, swap: remove redundant error handling for replacing folio
Date: Sat,  6 Sep 2025 03:13:50 +0800
Message-ID: <20250905191357.78298-9-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905191357.78298-1-ryncsn@gmail.com>
References: <20250905191357.78298-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Shmem may replace a folio in the swap cache if the cached one doesn't
fit the swapin's GFP zone. When doing so, shmem has already double
checked that the swap cache folio is locked, still has the swap cache
flag set, and contains the wanted swap entry. So it is impossible to
fail due to an Xarray mismatch. There is even a comment for that.

Delete the defensive error handling path, and add a WARN_ON instead:
if that happened, something has broken the basic principle of how the
swap cache works, we should catch and fix that.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/shmem.c | 42 ++++++++++++------------------------------
 1 file changed, 12 insertions(+), 30 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 4e27e8e5da3b..cc6a0007c7a6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1698,13 +1698,13 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 		}
 
 		/*
-		 * The delete_from_swap_cache() below could be left for
+		 * The swap_cache_del_folio() below could be left for
 		 * shrink_folio_list()'s folio_free_swap() to dispose of;
 		 * but I'm a little nervous about letting this folio out of
 		 * shmem_writeout() in a hybrid half-tmpfs-half-swap state
 		 * e.g. folio_mapping(folio) might give an unexpected answer.
 		 */
-		delete_from_swap_cache(folio);
+		swap_cache_del_folio(folio);
 		goto redirty;
 	}
 	if (nr_pages > 1)
@@ -2082,7 +2082,7 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 	new->swap = entry;
 
 	memcg1_swapin(entry, nr_pages);
-	shadow = get_shadow_from_swap_cache(entry);
+	shadow = swap_cache_get_shadow(entry);
 	if (shadow)
 		workingset_refault(new, shadow);
 	folio_add_lru(new);
@@ -2158,35 +2158,17 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	/* Swap cache still stores N entries instead of a high-order entry */
 	xa_lock_irq(&swap_mapping->i_pages);
 	for (i = 0; i < nr_pages; i++) {
-		void *item = xas_load(&xas);
-
-		if (item != old) {
-			error = -ENOENT;
-			break;
-		}
-
-		xas_store(&xas, new);
+		WARN_ON_ONCE(xas_store(&xas, new));
 		xas_next(&xas);
 	}
-	if (!error) {
-		mem_cgroup_replace_folio(old, new);
-		shmem_update_stats(new, nr_pages);
-		shmem_update_stats(old, -nr_pages);
-	}
 	xa_unlock_irq(&swap_mapping->i_pages);
 
-	if (unlikely(error)) {
-		/*
-		 * Is this possible?  I think not, now that our callers
-		 * check both the swapcache flag and folio->private
-		 * after getting the folio lock; but be defensive.
-		 * Reverse old to newpage for clear and free.
-		 */
-		old = new;
-	} else {
-		folio_add_lru(new);
-		*foliop = new;
-	}
+	mem_cgroup_replace_folio(old, new);
+	shmem_update_stats(new, nr_pages);
+	shmem_update_stats(old, -nr_pages);
+
+	folio_add_lru(new);
+	*foliop = new;
 
 	folio_clear_swapcache(old);
 	old->private = NULL;
@@ -2220,7 +2202,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	nr_pages = folio_nr_pages(folio);
 	folio_wait_writeback(folio);
 	if (!skip_swapcache)
-		delete_from_swap_cache(folio);
+		swap_cache_del_folio(folio);
 	/*
 	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks
 	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
@@ -2459,7 +2441,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		folio->swap.val = 0;
 		swapcache_clear(si, swap, nr_pages);
 	} else {
-		delete_from_swap_cache(folio);
+		swap_cache_del_folio(folio);
 	}
 	folio_mark_dirty(folio);
 	swap_free_nr(swap, nr_pages);
-- 
2.51.0


