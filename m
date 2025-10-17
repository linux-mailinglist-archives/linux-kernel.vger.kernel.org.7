Return-Path: <linux-kernel+bounces-857524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E00CBE703A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC63B4EEAEA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F2825CC74;
	Fri, 17 Oct 2025 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K4rAhMCJ"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDD5262FD1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687632; cv=none; b=d7bcvsu3kiaOYrozV1RUWNAFbYI5xfvtJD1z61uwmOO0Gi1bsoAzc+3a41W3vBJtf0BZEFDGXArIKzNOQOe6WbaeEhz7gw2lTn5MQE/m+c85XfuNx5tyxhILpbxWZKXOszOu1MbDiMJNVcz//rQYEbOeTGUF5Ea5p7IjmJ4ncBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687632; c=relaxed/simple;
	bh=C+sqd/1nPij690O0rir0ZEJTk53n77kuroVYS12UZ1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmcoP+Kbud92vIL+Vu6oeIp+S9YoXsgaY75EHWXaPngs2I3ND+NrlaT8ckah4YuxU8lUBLs/H+wDvS7REucLRyWxLILWC2yv9St/YmKCtGaY8aCcOEhYS+isWdwxwDIo2aMwWZM/5DRifPacoxbBtWP50+jmq0heqOV2j3ObAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K4rAhMCJ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760687625; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oHdZGMzoWgx8F2L9qwK1aYNWjA2JpQlzaq9Ae2oOJGE=;
	b=K4rAhMCJ3TvFplI1GkEZHLnJCDeSgtQLkIqa/CiL71G5bN4I5OT6vbEo66YHhQQ0n5ftCgNJWp2ixbOplFiTraOgCySd8RSv0eA7uTXvebXdXnn4Pt8g/1rq/nKhSDbLPahViJq7U+24KlJVsrlj7M397MNK9oSvGoLEYst8igA=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WqPA.uq_1760687623 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 15:53:43 +0800
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
Subject: [PATCH v2 2/2] mm: vmscan: simplify the logic for activating dirty file folios
Date: Fri, 17 Oct 2025 15:53:07 +0800
Message-ID: <ba5c49955fd93c6850bcc19abf0e02e1573768aa.1760687075.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1760687075.git.baolin.wang@linux.alibaba.com>
References: <cover.1760687075.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 6b0dfabb3555 ("fs: Remove aops->writepage"), we no longer
attempt to write back filesystem folios through reclaim.

However, in the shrink_folio_list() function, there still remains some
logic related to writeback control of dirty file folios. The original
logic was that, for direct reclaim, or when folio_test_reclaim() is false,
or the PGDAT_DIRTY flag is not set, the dirty file folios would be directly
activated to avoid being scanned again; otherwise, it will try to writeback
the dirty file folios. However, since we can no longer perform writeback on
dirty folios, the dirty file folios will still be activated.

Additionally, under the original logic, if we continue to try writeback dirty
file folios, we will also check the references flag, sc->may_writepage, and
may_enter_fs(), which may result in dirty file folios being left in the inactive
list. This is unreasonable. Even if these dirty folios are scanned again, we
still cannot clean them.

Therefore, the checks on these dirty file folios appear to be redundant and can
be removed. Dirty file folios should be directly moved to the active list to
avoid being scanned again. Since we set the PG_reclaim flag for the dirty folios,
once the writeback is completed, they will be moved back to the tail of the
inactive list to be retried for quick reclaim.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/mmzone.h |  4 ----
 mm/vmscan.c            | 25 +++----------------------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7fb7331c5725..4398e027f450 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1060,10 +1060,6 @@ struct zone {
 } ____cacheline_internodealigned_in_smp;
 
 enum pgdat_flags {
-	PGDAT_DIRTY,			/* reclaim scanning has recently found
-					 * many dirty file pages at the tail
-					 * of the LRU.
-					 */
 	PGDAT_WRITEBACK,		/* reclaim scanning has recently found
 					 * many pages under writeback
 					 */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 65f299e4b8f0..c922bad2b8fd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1387,21 +1387,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 		mapping = folio_mapping(folio);
 		if (folio_test_dirty(folio)) {
-			/*
-			 * Only kswapd can writeback filesystem folios
-			 * to avoid risk of stack overflow. But avoid
-			 * injecting inefficient single-folio I/O into
-			 * flusher writeback as much as possible: only
-			 * write folios when we've encountered many
-			 * dirty folios, and when we've already scanned
-			 * the rest of the LRU for clean folios and see
-			 * the same dirty folios again (with the reclaim
-			 * flag set).
-			 */
-			if (folio_is_file_lru(folio) &&
-			    (!current_is_kswapd() ||
-			     !folio_test_reclaim(folio) ||
-			     !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
+			if (folio_is_file_lru(folio)) {
 				/*
 				 * Immediately reclaim when written back.
 				 * Similar in principle to folio_deactivate()
@@ -1410,7 +1396,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 				 */
 				node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
 						nr_pages);
-				folio_set_reclaim(folio);
+				if (!folio_test_reclaim(folio))
+					folio_set_reclaim(folio);
 
 				goto activate_locked;
 			}
@@ -6105,11 +6092,6 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		if (sc->nr.writeback && sc->nr.writeback == sc->nr.taken)
 			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
 
-		/* Allow kswapd to start writing pages during reclaim.*/
-		if (sc->nr.unqueued_dirty &&
-			sc->nr.unqueued_dirty == sc->nr.file_taken)
-			set_bit(PGDAT_DIRTY, &pgdat->flags);
-
 		/*
 		 * If kswapd scans pages marked for immediate
 		 * reclaim and under writeback (nr_immediate), it
@@ -6850,7 +6832,6 @@ static void clear_pgdat_congested(pg_data_t *pgdat)
 
 	clear_bit(LRUVEC_NODE_CONGESTED, &lruvec->flags);
 	clear_bit(LRUVEC_CGROUP_CONGESTED, &lruvec->flags);
-	clear_bit(PGDAT_DIRTY, &pgdat->flags);
 	clear_bit(PGDAT_WRITEBACK, &pgdat->flags);
 }
 
-- 
2.43.7


