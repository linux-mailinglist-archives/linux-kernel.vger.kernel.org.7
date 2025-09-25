Return-Path: <linux-kernel+bounces-831913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077CB9DDC2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABE33801FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E502E974D;
	Thu, 25 Sep 2025 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bI+IYdDI"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DDD285CB5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785561; cv=none; b=eO9mdTSkg64PMhsXSc8TLREfkmNTthpFXdMArD4mdl11u/M+NIMcXvOj7kzfPdrQ9qGipLE8HG7/oW9WXTHA8hUD3/8WrUa9q4dGOEzAWyuYut32JH0QxoEMQ6cRQ/cluw6o7sh3u1Ryn0LLIEOtEHTbiGuqfr4NbiMoO1PWDiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785561; c=relaxed/simple;
	bh=fYYrfU17h52x8wI6I2bvVJQMVWO+yEoZ214frCEkpQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrR80cRjgrLTW0sA0JTyIvomEAl3nSAL2u6CSMIhcc12Yo63mWpaf9iq77TR4Q918rs9sta12auArrSfLlt2M6Rznoj8IjbcmVAx0TFSJw8z2U/3u5wISuTYJXlwqJMCA858Ze9nIY/qh3RG1xIGynz0yg/vgxPtycLeelrk41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bI+IYdDI; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758785555; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/iV+2qSDfbqGJGlOtg+T5iAut/k8Wvw7Udwono6Cens=;
	b=bI+IYdDIN3eZDnkyuSzPBruuTjve8Mu9w09hHNio2SJHX6DecdDJTjPJ5atDzxKnJ1zYcDCxLnfYxSJn0yNX+tSxLAFAIakyorlxbaQFEK3XP8iU+l4d9NntKp37SQ+TBw+w83k2g8RSbIbKSbtZAfflr66wphdAOhYheKRmURE=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WomvkMn_1758785553 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 15:32:33 +0800
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
Subject: [PATCH 2/2] mm: vmscan: simplify the logic for activating dirty file folios
Date: Thu, 25 Sep 2025 15:32:12 +0800
Message-ID: <166c482b066b7da2aeaf780f0ef5ab4ae150d440.1758785194.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1758785194.git.baolin.wang@linux.alibaba.com>
References: <cover.1758785194.git.baolin.wang@linux.alibaba.com>
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
index f347865edc70..b1f8eea67c8e 100644
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
+				if (folio_test_reclaim(folio))
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


