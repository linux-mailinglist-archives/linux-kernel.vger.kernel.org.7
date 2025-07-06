Return-Path: <linux-kernel+bounces-712102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863A2AF04BF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 22:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF1C441DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 20:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4F42E3AE1;
	Tue,  1 Jul 2025 20:26:05 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C8528505A
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751401564; cv=none; b=RwZzJczqXMQ5RQInWlVGLgWmNWr8HoXUzazJuQ1NJhBPYFO7Jo6B65nftI4p/qKtZfIer3GDIGgOmzh5OpXrE+ITKeAinHqSdptkDeSNYrKj/gAV+hCJuj+2V8GSnpMkBMUK82Xyqk0L+/22HDxnTZYGuGhXQ2wM+79481LVc5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751401564; c=relaxed/simple;
	bh=Mm1GAhP6V3e16p24XRVC9ib3qMhwwndOrGC6Njnhr28=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y4aOrvo4iRlpK0RG3gc2WWC8T0o16rc+ibkAnd4JVYpi7fVX+y0Bk6IDeZSP/WBiyePxnaA+VMDC7lllsUr9/m131PnZ2VYNK+LDu1zVFSOaFfoZa9oHhG6crzUKSC773P+rE8iVFWI72ruyt4WHAJVk1elANL4DcElii1MtC3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=df7cb.de; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=df7cb.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bWvgB3cZwz9tLX;
	Tue,  1 Jul 2025 22:25:58 +0200 (CEST)
Date: Tue, 1 Jul 2025 22:25:55 +0200
From: Christoph Berg <myon@debian.org>
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	"open list:MEMORY MANAGEMENT - MEMORY POLICY AND MIGRATION" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] mm/migrate: Fix do_pages_stat in 32-bit mode
Message-ID: <aGREU0XTB48w9CwN@msg.df7cb.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From c5d55a4c6d8674ee30c14bf4291a507f11885de1 Mon Sep 17 00:00:00 2001
From: Christoph Berg <myon@debian.org>
Date: Tue, 24 Jun 2025 16:44:27 +0200
Subject: [PATCH v4] mm/migrate: Fix do_pages_stat in compat mode

For arrays with more than 16 entries, the old code would incorrectly
advance the pages pointer by 16 words instead of 16 compat_uptr_t.
Fix by doing the pointer arithmetic inside get_compat_pages_array where
pages32 is already a correctly-typed pointer.

Discovered while working on PostgreSQL 18's new NUMA introspection code.

Signed-off-by: Christoph Berg <myon@debian.org>
Acked-by: David Hildenbrand <david@redhat.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Fixes: 5b1b561ba73c ("mm: simplify compat_sys_move_pages")
Reported-by: Bertrand Drouvot <bertranddrouvot.pg@gmail.com>
Reported-by: Tomas Vondra <tomas@vondra.me>
Closes: https://www.postgresql.org/message-id/flat/6342f601-77de-4ee0-8c2a-3deb50ceac5b%40vondra.me#86402e3d80c031788f5f55b42c459471
---
 mm/migrate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8cf0f9c9599d..2c88f3b33833 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2399,6 +2399,7 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 
 static int get_compat_pages_array(const void __user *chunk_pages[],
 				  const void __user * __user *pages,
+				  unsigned long chunk_offset,
 				  unsigned long chunk_nr)
 {
 	compat_uptr_t __user *pages32 = (compat_uptr_t __user *)pages;
@@ -2406,7 +2407,7 @@ static int get_compat_pages_array(const void __user *chunk_pages[],
 	int i;
 
 	for (i = 0; i < chunk_nr; i++) {
-		if (get_user(p, pages32 + i))
+		if (get_user(p, pages32 + chunk_offset + i))
 			return -EFAULT;
 		chunk_pages[i] = compat_ptr(p);
 	}
@@ -2425,27 +2426,28 @@ static int do_pages_stat(struct mm_struct *mm, unsigned long nr_pages,
 #define DO_PAGES_STAT_CHUNK_NR 16UL
 	const void __user *chunk_pages[DO_PAGES_STAT_CHUNK_NR];
 	int chunk_status[DO_PAGES_STAT_CHUNK_NR];
+	unsigned long chunk_offset = 0;
 
 	while (nr_pages) {
 		unsigned long chunk_nr = min(nr_pages, DO_PAGES_STAT_CHUNK_NR);
 
 		if (in_compat_syscall()) {
 			if (get_compat_pages_array(chunk_pages, pages,
-						   chunk_nr))
+						   chunk_offset, chunk_nr))
 				break;
 		} else {
-			if (copy_from_user(chunk_pages, pages,
+			if (copy_from_user(chunk_pages, pages + chunk_offset,
 				      chunk_nr * sizeof(*chunk_pages)))
 				break;
 		}
 
 		do_pages_stat_array(mm, chunk_nr, chunk_pages, chunk_status);
 
-		if (copy_to_user(status, chunk_status, chunk_nr * sizeof(*status)))
+		if (copy_to_user(status + chunk_offset, chunk_status,
+				 chunk_nr * sizeof(*status)))
 			break;
 
-		pages += chunk_nr;
-		status += chunk_nr;
+		chunk_offset += chunk_nr;
 		nr_pages -= chunk_nr;
 	}
 	return nr_pages ? -EFAULT : 0;
-- 
2.47.2


