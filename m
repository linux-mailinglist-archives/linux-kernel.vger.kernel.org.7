Return-Path: <linux-kernel+bounces-811242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D4AB5265A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136373BD1B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775B720C037;
	Thu, 11 Sep 2025 02:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Krq9irbK"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163291F63CD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757556961; cv=none; b=uJhS4JrC5B0g/Yqk5u4ZJR8d6OrzE7DEpZuGWOHp5f9o5k0s00Fl3JysePpxBo8WarhYfxxR7te/8PEzccV/pShqsBVvh08tO8tJB7FHvghbWYJeaPNNhf/VX9W0l0+gcVnv5PwWUp0h1TaNE6g6T9lRML1XHJ2PlnR9pBIfa+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757556961; c=relaxed/simple;
	bh=EFooMqeSxJgGNMIq1ytiXHwMDc0UgGJe/pqSiVLSh1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p/f1WQctFUkQzF3oCItQGetHRHL+KtaXCfqXbx3w+M3bZxvZYQz0lGB8yn8fCu/JPbWUH96sdaRwXfEZRGjSbybrpYbfT/IhlmVBb2LCB8O5k9/8hBkU/XSCZYX/MkiQB5RLjQ3t/mgksqOwdLwqJvpoTS32UamXR7licEfnBZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Krq9irbK; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3dcce361897so145812f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757556958; x=1758161758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z61Ud91XiDdZmJa+FtI6083ufxhXzmGdnKS68dPkBBs=;
        b=Krq9irbK2WyLiumOwf1RnKnR4Pqqr8bphjj+oMCJhaHq0Tljhnj+w6+0FUWYBm6Jve
         KbpqjwofTtC0J+g8/CnimssqyPZ51tdK3OihIPmHZgN40Ec+BNOITRYsYd2Y3kf6TqyK
         L5X425nwZBrt1ev2+s4TfC9BnXCa7BOSfktyVG81QycDTYBYEDRp6NMSEB4zCWjXIr8R
         HkTYlV0T1vLLkYIfP+ete67VvmEw77hYtHT9CJjxgzC9RQW+V15Ov9Vmglh+ggv0mZrM
         VTo3werD7qzfFR1/0lKfsUO9Bb6vQnssrepEf/NYejkIQpT7cRmSaAarK7C8bVEabYA+
         GYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757556958; x=1758161758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z61Ud91XiDdZmJa+FtI6083ufxhXzmGdnKS68dPkBBs=;
        b=HXJUbfApYPk+AOsCfZrClKjigkddylj6qEoFG4nTSgPJ54Mx33PKJI6869Xndws7oa
         FIjg4zRa/BOjeJD/LkLBq/hT45f1G9eSRqwKeGehjxQxMi+4kSqzleo9igaTiz6pqjup
         mcvewwaD4IEWuCFu8W+yYbJ2iiZpzmPeI6faOY2K3UTAFs5Si5+2Y1NAYw31jLgvXtfw
         1icdHVqlxH8Fok/B+5E+9QgDOWuiS8tXO/3jA3T1dV9PxgQbAh9VqeKTbou2sw2JQZwp
         b16RWTESBD18ticNNgfs42af6mG52+bFvykcvWVR/l0U35W4dA4r5o5OrCBQrQdHykLG
         TK2w==
X-Forwarded-Encrypted: i=1; AJvYcCX0+i5jxo/k9OagMVu7g/RkhdRr5KcrsuvPsDWx2v9Ng8o78/gklVTknHcX8j6ph6srSL+cC10puES8pN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEUag7PL31qIqvYeyImoUuhRXbpUK8Zjs24uv8uNk8ZbUut1vT
	FPphLs4hVvCK7JTQ2y0M7pCn2wIFHTnf2l2bvcW+joh8LaT/Wp4E2kKJ
X-Gm-Gg: ASbGncuNNrpgZ7AElTCeJGT6el4VGqKyuYONlhqS5cqRNx0xhgGxIPA2l+zOzeSgaeN
	5dViM1Lx4RGEE3PHCNMW4o+YhPJaBnSjKH3ViOWvXWlrOy5NjHA2447KLWvu5aJKpKmgkD4xdWP
	l2hkg1qEmQ3zZTHR+fsElAavXCH6ZTuB6/ROqfM/wraHTYyitpolvHC9rUbrJhm6bxExBiF2JaI
	zO9AbMJ+1yvOdzf9253eg0YAflPR9gk25HljMg3qIaCljBNIIZ2AOMM0TVbBDQ8rnjKhx4b+CU7
	QjrS315OXfwSvFABoMCQK6/GM+X7AIqXGyesmvYKY857ZRJjhcnfzK89Egq3D/rmkUO7w16G0qb
	ja2Lt5lDHBFqaL3ym5xbGV5yMz95e8XmbFs0oeBRlka/SE03uYA==
X-Google-Smtp-Source: AGHT+IEwiGxM2I2tMq/8NUzlNs+PXpwDcsY0NskG+ulCgXKuPzRP1yl+Ca4cmuleeQvEp32B4oqTzg==
X-Received: by 2002:a05:6000:2081:b0:3e4:64b0:a76a with SMTP id ffacd0b85a97d-3e641f3155emr11788137f8f.9.1757556958076;
        Wed, 10 Sep 2025 19:15:58 -0700 (PDT)
Received: from localhost.localdomain ([82.213.227.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd43csm503301f8f.29.2025.09.10.19.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 19:15:57 -0700 (PDT)
From: Andrew Zaborowski <balrogg@gmail.com>
X-Google-Original-From: Andrew Zaborowski <balrogg+code@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH] mm: avoid poison consumption when splitting THP
Date: Thu, 11 Sep 2025 04:14:01 +0200
Message-ID: <20250911021401.734817-1-balrogg+code@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handling a memory failure pointing inside a huge page requires splitting
the page.  The splitting logic uses a mechanism, implemented in
migrate.c:try_to_map_unused_to_zeropage(), that inspects contents of
individual pages to find zero-filled pages.  The read access to the
contents may cause a new, synchronous exception like an x86 Machine
Check, delivered before the initial memory_failure() finishes, ending
in a crash.

Luckily memory_failure() already sets the has_hwpoisoned flag on the
folio right before try_to_split_thp_page().  Don't enable the shared
zeropage mechanism (RMP_USE_SHARED_ZEROPAGE flag) down in
__split_unmapped_folio() when the original folio has has_hwpoisoned.

Note: we're disabling a potentially useful feature, some of the
individual pages that aren't poisoned might be zero-filled.  One
argument for not trying to add a mechanism to maybe re-scan them later,
apart from code cost, is that the owning process is likely being
killed and the memory released.

Signed-off-by: Andrew Zaborowski <balrogg+code@gmail.com>
---
 mm/huge_memory.c    | 3 ++-
 mm/memory-failure.c | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9c38a95e9f0..1568f0308b9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3588,6 +3588,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		struct list_head *list, bool uniform_split)
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
+	bool has_hwpoisoned = folio_test_has_hwpoisoned(folio);
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	struct folio *end_folio = folio_next(folio);
 	bool is_anon = folio_test_anon(folio);
@@ -3858,7 +3859,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (nr_shmem_dropped)
 		shmem_uncharge(mapping->host, nr_shmem_dropped);
 
-	if (!ret && is_anon)
+	if (!ret && is_anon && !has_hwpoisoned)
 		remap_flags = RMP_USE_SHARED_ZEROPAGE;
 	remap_page(folio, 1 << order, remap_flags);
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fc30ca4804b..2d755493de9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2352,8 +2352,10 @@ int memory_failure(unsigned long pfn, int flags)
 		 * otherwise it may race with THP split.
 		 * And the flag can't be set in get_hwpoison_page() since
 		 * it is called by soft offline too and it is just called
-		 * for !MF_COUNT_INCREASED.  So here seems to be the best
-		 * place.
+		 * for !MF_COUNT_INCREASED.
+		 * It also tells __split_unmapped_folio() to not bother
+		 * using the shared zeropage -- the all-zeros check would
+		 * consume the poison.  So here seems to be the best place.
 		 *
 		 * Don't need care about the above error handling paths for
 		 * get_hwpoison_page() since they handle either free page
-- 
2.45.2


