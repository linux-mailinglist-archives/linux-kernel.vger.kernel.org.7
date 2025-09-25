Return-Path: <linux-kernel+bounces-833351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C6DBA1BED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33FD47A9F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE3A31B824;
	Thu, 25 Sep 2025 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="InjnGNFI"
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD5322A7F1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758838311; cv=none; b=ARHYt3/2JaqNqnuDtm0BEMXwSRDNvQM9H2hU0q9qQSzOkfqRVkacZAhflCf+Asc7CkctMzA4xXqQAtaIpLIDTm2QUHowkeU6/x3tyNuVFgUl8iGfet3SFGXCjEId4RZv94MfBD86SvWZpeoUoOnvJGQl/XIrXZ1fse/SqYv5osw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758838311; c=relaxed/simple;
	bh=KRZUjIoTeC7m1z4qfK7KptC4MVbQ+rln0ITsg3ZUIys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7lRCcP1sWHMvLz6bfafMNMjvD+1dqUA1IpqNHaDRlXR6s/hOLZX92x5HPMnc1d+OVsf7ZFnY0hn1g0mAlGGDS6VSB9lXJ95Ch+czLYCStG04HcQOhiYilO+zuNj/61QSQpd/vtp0WqSpzxCJHVLafqLu1m9AXcctH2vsnYbskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=InjnGNFI; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GJH2ck5XEjk64tYSAUJ8Mmt99YWLK51DqiT3bpdAVPA=; b=InjnGNFI7HfscQkEpKolRkt3hu
	WYjmhUaN3ewDzXN71Pe6fy+3RPTlSXiwC1oIxmDA6tx5Rxnc2mVK5jCntHB7WhtfqhsK9Pn+2Yyjo
	OTMaMNtCMI7k7yqr78xtQ9oiiWqx1Tw9ue1I3rBro+tgS2y/fdEZ+f+E+xs5j4Q+RAnq9kEQyzUbR
	+kYSOGF4k+pVVCQKcRkKVHTqrh3+I77Ykj1TP8IvNlk7vGLIDGSxt0sMn80+4d37RKMY1+7wHaKlH
	esASzAqtFJxvUqEYuNCEosGAoa9q9F+//5JVntfr6Fl4Ihn5M7DQLtLRWdXWwRLBImCbLWiyypxZK
	BSfGCsnw==;
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1v1uBC-000000008PQ-0cEe;
	Thu, 25 Sep 2025 18:11:10 -0400
Date: Thu, 25 Sep 2025 18:11:09 -0400
From: Rik van Riel <riel@surriel.com>
To: Frank van der Linden <fvdl@google.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, hannes@cmpxchg.org, david@redhat.com,
 roman.gushchin@linux.dev, kernel-team@meta.com
Subject: [RFC PATCH 00/12] mm,cma: call CMA balancing from page reclaim code
Message-ID: <20250925181109.11dd36e5@fangorn>
In-Reply-To: <20250915195153.462039-1-fvdl@google.com>
References: <20250915195153.462039-1-fvdl@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Call CMA balancing from the page reclaim code, if page reclaim
is reclaiming pages that are unsuitable for the allocator.

To keep direct reclaim latencies low, kswapd will do CMA balancing
whenever some of the reclaimed pages are unsuitable for the allocator
that woke up kswapd, while the direct reclaimers will only do CMA
balancing if most of the reclaimed pages are unsuitable.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 mm/vmscan.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a48aec8bfd92..ec6bde5b07d3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -168,6 +168,9 @@ struct scan_control {
 	/* Number of pages freed so far during a call to shrink_zones() */
 	unsigned long nr_reclaimed;
 
+	/* Number of pages reclaimed, but unsuitable to the allocator */
+	unsigned long nr_unsuitable;
+
 	struct {
 		unsigned int dirty;
 		unsigned int unqueued_dirty;
@@ -1092,6 +1095,19 @@ static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
 	return !data_race(folio_swap_flags(folio) & SWP_FS_OPS);
 }
 
+#ifdef CONFIG_CMA
+static bool unsuitable_folio(struct folio *folio, struct scan_control *sc)
+{
+	return gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
+		folio_migratetype(folio) == MIGRATE_CMA;
+}
+#else
+static bool unsuitable_folio(struct folio *folio, struct scan_control *sc)
+{
+	return false;
+}
+#endif
+
 /*
  * shrink_folio_list() returns the number of reclaimed pages
  */
@@ -1103,7 +1119,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	struct folio_batch free_folios;
 	LIST_HEAD(ret_folios);
 	LIST_HEAD(demote_folios);
-	unsigned int nr_reclaimed = 0, nr_demoted = 0;
+	unsigned int nr_reclaimed = 0, nr_demoted = 0, nr_unsuitable = 0;
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
 	struct swap_iocb *plug = NULL;
@@ -1530,6 +1546,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					 * leave it off the LRU).
 					 */
 					nr_reclaimed += nr_pages;
+					if (unsuitable_folio(folio, sc))
+						nr_unsuitable += nr_pages;
 					continue;
 				}
 			}
@@ -1560,6 +1578,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * all pages in it.
 		 */
 		nr_reclaimed += nr_pages;
+		if (unsuitable_folio(folio, sc))
+			nr_unsuitable += nr_pages;
 
 		folio_unqueue_deferred_split(folio);
 		if (folio_batch_add(&free_folios, folio) == 0) {
@@ -1641,6 +1661,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 	if (plug)
 		swap_write_unplug(plug);
+
+	sc->nr_unsuitable += nr_unsuitable;
+
 	return nr_reclaimed;
 }
 
@@ -6431,6 +6454,10 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 
 	delayacct_freepages_end();
 
+	/* Almost all memory reclaimed was unsuitable? Move data into CMA. */
+	if (sc->nr_unsuitable >= sc->nr_reclaimed - 2)
+		balance_cma_zonelist(zonelist, SWAP_CLUSTER_MAX);
+
 	if (sc->nr_reclaimed)
 		return sc->nr_reclaimed;
 
@@ -7169,6 +7196,8 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	if (!sc.nr_reclaimed)
 		pgdat->kswapd_failures++;
 
+	if (sc.nr_unsuitable)
+		balance_node_cma(pgdat->node_id, NULL);
 out:
 	clear_reclaim_active(pgdat, highest_zoneidx);
 
-- 
2.47.3


