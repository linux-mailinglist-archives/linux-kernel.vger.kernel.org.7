Return-Path: <linux-kernel+bounces-841748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE3DBB81E4
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCF819E259A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3C7258EF0;
	Fri,  3 Oct 2025 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4+iEoqp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E6257853;
	Fri,  3 Oct 2025 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759523939; cv=none; b=LNVKgKr2zjjmY6Czowmv13hSJUcVq8bCl1lAnIUXxTlBiwek9lrgsV2lf1alZCYX2hyecRFNwPHTqyEQiA134elWXM+THBCbBGXiPAUVud0PdLwgde0uD3zf3kYqn9mLEvq4oWPiwPUrmcaCkZhQbxzcV88r8b41qmHBaToHQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759523939; c=relaxed/simple;
	bh=ZzB74e8fLVOerMDvAZBDXxkrkPTdnq0MummdffmxbJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G0A7aAjL6WbpbIrbPkxphpFMJC2J0GTz2stiZMHh/PXqdDKQm7UgpMm+36ct6AvJzom5A0IcnaCxZYEikzi3If3ldJy9HeNhKaTn7X2SWJhn6oGbV+UR3X3phd/9Ni/vq+OesgyFMFfcgxiDBEMxGxvwYAif7+f1fB4OqQvJ+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4+iEoqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4037FC4CEF5;
	Fri,  3 Oct 2025 20:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759523938;
	bh=ZzB74e8fLVOerMDvAZBDXxkrkPTdnq0MummdffmxbJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4+iEoqpATZKahzganyMTsVKl1kJ/wiQ8Px8RLzYdqh37tRpnjf8uOl3qaMEL7pXh
	 x6Omcw0vWP61pTvKgdbVG4UQgRqnNy63jcSGLu95EnAnANKV/y3oezHWVN0XVtlnDn
	 vsni74areUTyOWzbC4zHIDP0PSdxtqmpx45wohX2Hq3tW5fknR4t0/snPQ1jgktqKs
	 kFbhSneQRpzrwMXrOqys6faN4d65Ai/1HsxjyGMC7Qjc30QeOzNT2U/IxEK7PYpRK1
	 hWiAPQk+/4yVV/43rRDfVYP5fmu9cbh5rI8HJSeyg0i48Z+MVm/jABJDTBkU9IMMKx
	 5OPN0qtXCQ7ZA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/4] Docs/admin-guide/mm/zswap: s/red-black tree/xarray/
Date: Fri,  3 Oct 2025 13:38:51 -0700
Message-Id: <20251003203851.43128-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251003203851.43128-1-sj@kernel.org>
References: <20251003203851.43128-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The change from commit 796c2c23e14e ("zswap: replace RB tree with
xarray") is not reflected on the document.  Update the document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/zswap.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index 283d77217c6f..2464425c783d 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -59,11 +59,11 @@ returned by the allocation routine and that handle must be mapped before being
 accessed.  The compressed memory pool grows on demand and shrinks as compressed
 pages are freed.  The pool is not preallocated.
 
-When a swap page is passed from swapout to zswap, zswap maintains a mapping
-of the swap entry, a combination of the swap type and swap offset, to the
-zsmalloc handle that references that compressed swap page.  This mapping is
-achieved with a red-black tree per swap type.  The swap offset is the search
-key for the tree nodes.
+When a swap page is passed from swapout to zswap, zswap maintains a mapping of
+the swap entry, a combination of the swap type and swap offset, to the zsmalloc
+handle that references that compressed swap page.  This mapping is achieved
+with an xarray per swap type.  The swap offset is the search key for the xarray
+nodes.
 
 During a page fault on a PTE that is a swap entry, the swapin code calls the
 zswap load function to decompress the page into the page allocated by the page
-- 
2.39.5

