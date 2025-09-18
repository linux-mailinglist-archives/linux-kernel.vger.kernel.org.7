Return-Path: <linux-kernel+bounces-821993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4463CB82CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA163B4A44
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9F6245006;
	Thu, 18 Sep 2025 03:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G0v9Xvi7"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDF123D2B1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167233; cv=none; b=EPk00FJVt1bZYxHJYz9uh7XciiTGbAurloFKjsYK+e49VkU0l2K0FzR4QI8/DuEEQ/jmImUaLFaVyR/aLvJ15ZDObTtKbwCj9+o7MB51ggLaj3p4oD98TbMAKTI2S8jxCIsChimulgo/NXmraJthKTmx4aX/C7wih3u8H9GeYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167233; c=relaxed/simple;
	bh=VRyvcqyft2EmKUPenh6MlVnwpQVUVGX6pJlXXXm0450=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZLctH6XDeHUCiLSE4QVoaiznV6iDvIQgF3U/EM22+ArEzPLx3XCG1DPhE3DaCe12qHwiDK5/091DFwQJoGZIBiZouLblOR7O+U5SvpY6e7yfTb31W61mTual3OrD6jdiEPBB3+jnw6i3ij1uiNmIdoVQSXMdnXHlXUbNyYjopA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G0v9Xvi7; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758167223; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=sYxzI8uxfIUVEucc9dtDZh68r/k0MKv1E3eAeGSpuhw=;
	b=G0v9Xvi7KlyrbdMLnL6/s1VQEGSxTkwzY/YLuLJLndEvGGX5G5ooOzkUF04kpqBOX4+BUX+6OPYy6SpiP1egALp3ivDsFx7wvNlqU7Ga2bJ0BsqdITziTuZqTKOddkHFpjh2qPYq7lJbUpmEfaJVSQ3ePr+wha7EpOSL1qGzuuE=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WoEU2v0_1758167221 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Sep 2025 11:47:02 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: david@redhat.com,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	hughd@google.com,
	willy@infradead.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm: vmscan: remove folio_test_private() check in pageout()
Date: Thu, 18 Sep 2025 11:46:53 +0800
Message-ID: <9ef0e560dc83650bc538eb5dcd1594e112c1369f.1758166683.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1758166683.git.baolin.wang@linux.alibaba.com>
References: <cover.1758166683.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The folio_test_private() check in pageout() was introduced by commit
ce91b575332b ("orphaned pagecache memleak fix") in 2005 (checked from
a history tree[1]). As the commit message mentioned, it was to address
the issue where reiserfs pagecache may be truncated while still pinned.
To further explain, the truncation removes the page->mapping, but the
page is still listed in the VM queues because it still has buffers.

In 2008, commit a2b345642f530 ("Fix dirty page accounting leak with ext3
data=journal") seems to be dealing with a similar issue, where the page
becomes dirty after truncation, and it provides a very useful call stack:
truncate_complete_page()
      cancel_dirty_page() // PG_dirty cleared, decr. dirty pages
      do_invalidatepage()
        ext3_invalidatepage()
          journal_invalidatepage()
            journal_unmap_buffer()
              __dispose_buffer()
                __journal_unfile_buffer()
                  __journal_temp_unlink_buffer()
                    mark_buffer_dirty(); // PG_dirty set, incr. dirty pages

In this commit a2b345642f530, we forcefully clear the page's dirty flag
during truncation (in truncate_complete_page()).

Now it seems this was just a peculiar usage specific to reiserfs. Maybe
reiserfs had some extra refcount on these pages, which caused them to pass
the is_page_cache_freeable() check. With the fix provided by commit a2b345642f530
and reiserfs being removed in 2024 by commit fb6f20ecb121 ("reiserfs: The
last commit"), such a case is unlikely to occur again. So let's remove the
redundant folio_test_private() checks and related buffer_head release logic,
and just leave a warning here to catch such a bug.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/vmscan.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f1fc36729ddd..930add6d90ab 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -701,16 +701,10 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 		return PAGE_KEEP;
 	if (!mapping) {
 		/*
-		 * Some data journaling orphaned folios can have
-		 * folio->mapping == NULL while being dirty with clean buffers.
+		 * Is it still possible to have a dirty folio with
+		 * a NULL mapping? I think not.
 		 */
-		if (folio_test_private(folio)) {
-			if (try_to_free_buffers(folio)) {
-				folio_clear_dirty(folio);
-				pr_info("%s: orphaned folio\n", __func__);
-				return PAGE_CLEAN;
-			}
-		}
+		VM_WARN_ON_FOLIO(true, folio);
 		return PAGE_KEEP;
 	}
 
-- 
2.43.7


