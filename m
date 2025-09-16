Return-Path: <linux-kernel+bounces-819202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F30B59CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01588169528
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDACC2BCF68;
	Tue, 16 Sep 2025 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0rUsDvO"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5D828D830
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038482; cv=none; b=gP9zKDj1ZX7hul+qS+oN+3JtmFI6Ppp0dlm3WtJF7mR9SNst7ejz0WJQ9tuqOGJ3F0l6oqbsbymUshJsN2qqt6jyCGKrr7gGL5ZKgZ2nMJ+GI0LFTn9lZfCcgL9h5CTQrhDnmPUkx/xm/mWw7hrSuEumvuNmqPcy85c9uSAAFwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038482; c=relaxed/simple;
	bh=o6kb0md5MeaHDAk1URWbr4k37vvjaRoINUoHP5a7lag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jplwl+fHuaRQFFKhTtQR1KImKb04mk6jGXgqoqio/VtkzP51aC+Z1HccOSizrttcyYNfwlXm+zSPR6AOh4yrj7frVwZEr85YQXCH0VGUUxaGbnJsYk+ypBEJ/N6wC4uE1zegnvbZk7/VA1TmYdmy+k2INxQbYtAE0icgIWpZlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0rUsDvO; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8117aef2476so570606585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038478; x=1758643278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y/10HhICLTBAM9DGxW+AJtzORYwGHaxVefpsLmsvFfE=;
        b=R0rUsDvOgshr1H/nzsI2i+pJeW9xYW3tb7HCntXcGEx/2fziTRISupLgTEacJz7M6a
         tYdv9o78H9kQrYLPGXwm5ey7YrXjLlGCLJM2nirNlSiO22C6+vvJnyIlmLkLeBGK0k7L
         Iegzr2x5pq7B8SvbFbSbS9P+RhiMgJ2r6YeDUStIblX6crFLTYnr3N0DS9OyHQajCWMD
         vBzQnm3ub2PblgHMnsM7tv+OyPhmYSr34be3F2oBCZ2yiZMmmwylJc26FzkEVEuTD+xR
         0uyrBi9wNAhWYwZnyFJCE7OcPkV8x/Xn4DVvsXAW80JMLFiwps/UJtYZHIvleaRBOV4i
         oUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038478; x=1758643278;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/10HhICLTBAM9DGxW+AJtzORYwGHaxVefpsLmsvFfE=;
        b=KmGs2hnMloeNoj8AUEoBq0PuNP5aiCVm2m3v6qdgaYwaOhYv7xHSlqbqapPBLNAEsX
         ixKDUoP4Kc/kiVYOa301g4x/poCYlqBXn3EFwm+jvvY7OxaHh9ZfFPHiIWxkSFA1/nhq
         6kapxDomRs6bQMhavWsoyraCUKQwCxbntpdHksmFMFJsuazqKe8OJRo3XACLLpvc4yMy
         vHdW4sWLaTq2EJi6EiKlldAfcmRFsZkAlaAduEQ1IR46iUfbx8771Cwr05ES+F7YgeBC
         SAaYdRf+aekTihYWzQJzE6+pC0+t/W012DzxCLRNAYwwd0CuL47zno5hcXdHTEIGVAfu
         WRwg==
X-Forwarded-Encrypted: i=1; AJvYcCU77UT6Ig3ECcwF+qim7gmnzfnLlhUDnUO3eVi2DO9wCTBAMklMCgUcK7pmxOYci8Chg6q7pWqt5igGVDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTVR/byTIUPBbhq/GchK+RnGlRJsWxilcWFVvJ2xsx9gG1sxAK
	WLNIPZRGzpRuv74gPoHqO2lYZuLCGxY4ihhGZ0ivPKyWjiYuYp6M9EhV+O5NlFfsY2U=
X-Gm-Gg: ASbGncuMi47RagMosPAhs4E4rdxsP0/wSrzon2YxH0mNJ7K+NX3pONX3Xj4XuaTnGsN
	UUPeJMNR2Hsq8uMMR2GfOi6fxQ6bGPX8wlKKfaxsswxkYMaDmjrbwKNeWjbqY+R6tmxJTR3QrOF
	Fl1s742ILVJm8bB1nj0V/ZGzzfNM2pq4KOCiujZD+NVtzRXaTJA/dtauk3ZVDEyxdeg6TEZafmQ
	7cGSbMfsBOCLy1/gdInViEoECrXELw/5wd+Gr1KqK3n6X3HGA9DnesqbpIvQMewanzntHLyVHNT
	AY4tPv2kF1mHxkPVgY9+XBPKEk1byFdkREWsgJ460sf3xws8p8ajfswOe4ZeFNLoedsAHaeYZym
	VnwlQgCqPTwZ2v8KXKdtIyVUGsrH2hhPkzg8Y8yd63nn4RCQ=
X-Google-Smtp-Source: AGHT+IEk/B7drObHLtIjBOcJtdSnUnQFiVQtqdOA5y3ysTkFfJWgXvqapxngSvusLiINI+bB9tXJnQ==
X-Received: by 2002:a05:620a:7112:b0:82f:4be4:3788 with SMTP id af79cd13be357-82f4be438e1mr36800185a.45.1758038477821;
        Tue, 16 Sep 2025 09:01:17 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd703f54sm969765485a.37.2025.09.16.09.01.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Sep 2025 09:01:17 -0700 (PDT)
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
Subject: [PATCH v4 01/15] docs/mm: add document for swap table
Date: Wed, 17 Sep 2025 00:00:46 +0800
Message-ID: <20250916160100.31545-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916160100.31545-1-ryncsn@gmail.com>
References: <20250916160100.31545-1-ryncsn@gmail.com>
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


