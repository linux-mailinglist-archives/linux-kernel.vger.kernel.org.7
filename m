Return-Path: <linux-kernel+bounces-810621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B181BB51D20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63B35819DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C346F334701;
	Wed, 10 Sep 2025 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+aXVfId"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6933436A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520533; cv=none; b=GNu6kTtw8oc4LbEBqO2RS4ckObveD/oaK26wcQiD83j8Tlu6c9XO9sBQWjKMzQHxijo9wpxVh96dItqiQjpDQpTjzca75jfIAGZ9pOplGT/dPb82LJuxM5fT4YW0LftUUc5i8NfnJD4sa0UnEjE6iPWgv+eDkY+8RiH3e5bjXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520533; c=relaxed/simple;
	bh=1RcgNooYVkUukgc0lvOVRhy9e13KiuRZjCpuMpTyTSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZ511r5bTacnNl7TWDWwksHyCBNAIGh6YTyUlfA4TfW0+/2gG7pC9Jy1+Srtzj9m7cpjcoGidZC3GygP8eBsvZSQ/Ul7w182J5XjXpLUmGf3KYYKFbHNauPzqfAn72jM6oy9mlP515VEz59VTwcEOecml+pURpr2KIsAlQ9zqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+aXVfId; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so868363b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520531; x=1758125331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+iG/DaIyXWsx1WWZmoqNKoMlpLoSTABw5yoCvRsMNiQ=;
        b=I+aXVfId8uJC7l7JJ2cI9hNv857p4ibTX7z9T5S1EDdTFWAvBtRUIopijY7L5qqr+H
         MVDlpjIJLoChbo6Nnadnb4hPG9CFIB0a/WOO77FcoZAef3tHqlNVv0x1waW7jHWuoGcj
         40iL+gaRiN5dlY5pGVFCHOH+WoaMI1jqEYFfAMAU6zhZGXj7LXQnyawHbyj0AOCRdItl
         xUpxKkFs974e6+Xtt3K6dvtPSSb1kjXYdrmLm6t2KUvVVFPVzuVYHU226M4qurFsM4kk
         22hnfGOI+i7XbyDOvRuZrgeE+DIX5RyabHkVpX5lRst+tm4pupP7Ta0Vo4TAf+toOTdF
         dFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520531; x=1758125331;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+iG/DaIyXWsx1WWZmoqNKoMlpLoSTABw5yoCvRsMNiQ=;
        b=NvBTvqtJ83mVMKAG5Wl4d/9+s/hbuE/k11lGtixxlmDls74m7oNufjMcY1Aat7JJZx
         +8JxeoJ09QuIP2dvSifha1SJaYlXwfm1MdWE6LqFC9DGLOYSjBd4LnSqxbezgnMvVdHo
         3OiQsFZ5cHCTI2slsYYOznTqbA95s5V21lBwzvptQHqs8gVYM9d2pFdpHUgOSduNOkOy
         qtUoNLvOeyhZ8VJNnn8Jf4PyJKjJBSHDTty1oiz6pOnC9vbGZ7juxKwJtgw096wkny1r
         DXHg784mkQRdfmMKj9Wva6cVjUBeIQDeR2GPTFCJiyvsDAEuAxfjZAxAywX2sRBlMu/A
         ykQg==
X-Forwarded-Encrypted: i=1; AJvYcCWbXJf2HjkSy3DGHMWN1w5MOk7lZcz69Y/rlbwOZV1khXiSRqTVVY7ing9bdCSf8MI1Jl5wK1Uouua5BmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznZDitteztuYqnTmr+kkxaAY9Hjki2WPbx9AHU47YLrDxMCe1x
	Llo/XkE1gdwrLyQhQqOMBfhxYtYQJw4TpYP0TNYhIerqgtdoOYvMP81J
X-Gm-Gg: ASbGnctvUfwP9d/eBXLDIKDrTIse+6MG7qE0YR+RPB6xPDcT2ppXcPZhG//htycCBOR
	/6faayYWWqimv7ZzXE76X11Exu6NrNz1etrR4jq3cOMWVK9KCDV2VY8eI1orGUCQMIMwM8WxMCJ
	a56pZMj/TuRjMlNRhZawD+mZDwyGfLCfS4sCdeoIoSNwmGrYriT01aw4EBvHsWAA1ZzF6f7qHkA
	1/NKyCumS3h+n32gP24d4SlD4Oyi8eYV5PEJdn7MVYO0CI/dc2Z4ZPELhZxlZA5h6nt4NkZ7qBF
	6zTFGMNiUm9QEuy+sUSRq7yiHklxQWIqwmC36++47NCoAgoiRjhKW4mG4AwiUOqMkMC/Uj29GVV
	qDMR8QyK1tjfDRPYtcx6D08vsYaUTQX1izbcg06tLj87FmEE=
X-Google-Smtp-Source: AGHT+IHGtESNtbI/xZsyuKB3DJLeJiycjaitn//SnhhsXY3KbjYMDyPR0k+gvTRPXGFd9JgFnAJd4g==
X-Received: by 2002:a05:6a20:258e:b0:243:d3d3:61d4 with SMTP id adf61e73a8af0-25cf6c38869mr168609637.16.1757520530570;
        Wed, 10 Sep 2025 09:08:50 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54998a1068sm1000142a12.31.2025.09.10.09.08.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Sep 2025 09:08:50 -0700 (PDT)
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
Subject: [PATCH v3 01/15] docs/mm: add document for swap table
Date: Thu, 11 Sep 2025 00:08:19 +0800
Message-ID: <20250910160833.3464-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910160833.3464-1-ryncsn@gmail.com>
References: <20250910160833.3464-1-ryncsn@gmail.com>
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

From: Chris Li <chrisl@kernel.org>

Swap table is the new swap cache.

Signed-off-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 Documentation/mm/index.rst      |  1 +
 Documentation/mm/swap-table.rst | 72 +++++++++++++++++++++++++++++++++
 MAINTAINERS                     |  1 +
 3 files changed, 74 insertions(+)
 create mode 100644 Documentation/mm/swap-table.rst

diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index fb45acba16ac..828ad9b019b3 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -57,6 +57,7 @@ documentation, or deleted if it has served its purpose.
    page_table_check
    remap_file_pages
    split_page_table_lock
+   swap-table
    transhuge
    unevictable-lru
    vmalloced-kernel-stacks
diff --git a/Documentation/mm/swap-table.rst b/Documentation/mm/swap-table.rst
new file mode 100644
index 000000000000..acae6ceb4f7b
--- /dev/null
+++ b/Documentation/mm/swap-table.rst
@@ -0,0 +1,72 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Author: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
+
+==========
+Swap Table
+==========
+
+Swap table implements swap cache as a per-cluster swap cache value array.
+
+Swap Entry
+----------
+
+A swap entry contains the information required to serve the anonymous page
+fault.
+
+Swap entry is encoded as two parts: swap type and swap offset.
+
+The swap type indicates which swap device to use.
+The swap offset is the offset of the swap file to read the page data from.
+
+Swap Cache
+----------
+
+Swap cache is a map to look up folios using swap entry as the key. The result
+value can have three possible types depending on which stage of this swap entry
+was in.
+
+1. NULL: This swap entry is not used.
+
+2. folio: A folio has been allocated and bound to this swap entry. This is
+   the transient state of swap out or swap in. The folio data can be in
+   the folio or swap file, or both.
+
+3. shadow: The shadow contains the working set information of the swapped
+   out folio. This is the normal state for a swapped out page.
+
+Swap Table Internals
+--------------------
+
+The previous swap cache is implemented by XArray. The XArray is a tree
+structure. Each lookup will go through multiple nodes. Can we do better?
+
+Notice that most of the time when we look up the swap cache, we are either
+in a swap in or swap out path. We should already have the swap cluster,
+which contains the swap entry.
+
+If we have a per-cluster array to store swap cache value in the cluster.
+Swap cache lookup within the cluster can be a very simple array lookup.
+
+We give such a per-cluster swap cache value array a name: the swap table.
+
+Each swap cluster contains 512 entries, so a swap table stores one cluster
+worth of swap cache values, which is exactly one page. This is not
+coincidental because the cluster size is determined by the huge page size.
+The swap table is holding an array of pointers. The pointer has the same
+size as the PTE. The size of the swap table should match to the second
+last level of the page table page, exactly one page.
+
+With swap table, swap cache lookup can achieve great locality, simpler,
+and faster.
+
+Locking
+-------
+
+Swap table modification requires taking the cluster lock. If a folio
+is being added to or removed from the swap table, the folio must be
+locked prior to the cluster lock. After adding or removing is done, the
+folio shall be unlocked.
+
+Swap table lookup is protected by RCU and atomic read. If the lookup
+returns a folio, the user must lock the folio before use.
diff --git a/MAINTAINERS b/MAINTAINERS
index 68d29f0220fc..3d113bfc3c82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16225,6 +16225,7 @@ R:	Barry Song <baohua@kernel.org>
 R:	Chris Li <chrisl@kernel.org>
 L:	linux-mm@kvack.org
 S:	Maintained
+F:	Documentation/mm/swap-table.rst
 F:	include/linux/swap.h
 F:	include/linux/swapfile.h
 F:	include/linux/swapops.h
-- 
2.51.0


