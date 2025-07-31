Return-Path: <linux-kernel+bounces-752271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467F5B1735D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5201C24440
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67AB1A3155;
	Thu, 31 Jul 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/wWLwah"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505FD1991D4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973079; cv=none; b=EeWSnbEBVn5LRuky+bjoZuvVRniclBps157qL50/Bb0SYZ9pKMakp3KcHXiskpyqv4Mq3KqCrvnOCulz+aA7IXlyP9GLWVY0mLWKyX3B6nGvi7uPoY8wtBDaz4aIl0KVUIR6VMh/gpNAhuCfhlZ8w0eWrvO7451SR2T6iBM1iww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973079; c=relaxed/simple;
	bh=uO6JqQZIr//xPPdRWmqTk0qzriWXeePZU1lNA+yO5hg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jpziooleThusbeww2w9fKfr8k3sg88UWtFdxFzbclkI3Mq0bkxAOz+o67637rFYBvRGKKsoWnXj3JUJBORD70Iv8i8drS8Se47FfHk9c+SWNVBC3lVjreNUWmGlXrmMMOmmcT4MwnOJQ9hPBOaWC/wIi9K2zBpE8Pg6NqGB2uBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/wWLwah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C579C4CEEF;
	Thu, 31 Jul 2025 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753973075;
	bh=uO6JqQZIr//xPPdRWmqTk0qzriWXeePZU1lNA+yO5hg=;
	h=From:To:Cc:Subject:Date:From;
	b=Z/wWLwah4Li5c+pfrKApTo5VXzHxfARVihf4AGVCD3RuuhwAj3rtImIwXRqVIk9VJ
	 bSzQcZRYsrg7fZWOcGarXnwD2+cP/KgFD8iq4ox1wcHHZoK4FD/dFa6oxFwn4yaScL
	 rzSEL+bVcdeNocSoqrv4Ci5FRk5Cs06R48x8otlYn5WKb+ZlXz74NwJ7htNa5HFk2/
	 2eDV/0CUMiZ4lbc9gY7W87l1urHZP0Wx3WrrFwnFTYCefnowfIWbS3p8Ab9mtR8oBl
	 hRbmX+v9wQbuguQb7GnHUSL0hZV8GsOUEjtUIOEGCMDmnn7GUQTJ9n/pAIzhOT/1fJ
	 ZrwIrY/rhClmA==
From: Sasha Levin <sashal@kernel.org>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	surenb@google.com,
	aarcange@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] mm/userfaultfd: fix kmap_local LIFO ordering for CONFIG_HIGHPTE
Date: Thu, 31 Jul 2025 10:44:31 -0400
Message-Id: <20250731144431.773923-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_HIGHPTE on 32-bit ARM, move_pages_pte() maps PTE pages using
kmap_local_page(), which requires unmapping in Last-In-First-Out order.

The current code maps dst_pte first, then src_pte, but unmaps them in
the same order (dst_pte, src_pte), violating the LIFO requirement.
This causes the warning in kunmap_local_indexed():

  WARNING: CPU: 0 PID: 604 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
  addr \!= __fix_to_virt(FIX_KMAP_BEGIN + idx)

Fix this by reversing the unmap order to respect LIFO ordering.

This issue follows the same pattern as similar fixes:
- commit eca6828403b8 ("crypto: skcipher - fix mismatch between mapping and unmapping order")
- commit 8cf57c6df818 ("nilfs2: eliminate staggered calls to kunmap in nilfs_rename")

Both of which addressed the same fundamental requirement that kmap_local
operations must follow LIFO ordering.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Co-developed-by: Claude claude-opus-4-20250514
Signed-off-by: Sasha Levin <sashal@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/userfaultfd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8253978ee0fb..bf7a57ea71e0 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1453,10 +1453,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		folio_unlock(src_folio);
 		folio_put(src_folio);
 	}
-	if (dst_pte)
-		pte_unmap(dst_pte);
+	/*
+	 * Unmap in reverse order (LIFO) to maintain proper kmap_local
+	 * index ordering when CONFIG_HIGHPTE is enabled. We mapped dst_pte
+	 * first, then src_pte, so we must unmap src_pte first, then dst_pte.
+	 */
 	if (src_pte)
 		pte_unmap(src_pte);
+	if (dst_pte)
+		pte_unmap(dst_pte);
 	mmu_notifier_invalidate_range_end(&range);
 	if (si)
 		put_swap_device(si);
-- 
2.39.5


