Return-Path: <linux-kernel+bounces-833352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF4ABA1BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C7C1C27182
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDBF319870;
	Thu, 25 Sep 2025 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="LDlINN8O"
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB5235358
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758838311; cv=none; b=avks25I6sWzP/A6NwouH+8MMG7DOe09syG4WkBU/c6SGI393qn2qRJSKjze9VpcLb1uV79hriI5AivPy9kaoFyoSDOaYf4b0BiqA5shYU8WI4x2vG392JOukICkbC+7fMfnlkJVK2GJyCXCBf2+vtj/SBcrtxhK3Ia2xnVL82sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758838311; c=relaxed/simple;
	bh=Gp/6ffGOP7iZI9CGEDj3yzg0tEsKP4qoYYv3v6jO/1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujP+alMuahRhuJKPzcdvTHgkn7VVaQHrJGAKR2fC/k1DWOw4bGjmivpBab7s7aLibndM4b/2Vtw0hAxSKWVknLvMMyslm/h4ultvYmZGWRcLixeopSDOmLQc8Zzyqf94NMK8uzXcN9M7eMqS0QFpUiviWwmGiXPWbKKd50hQ+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=LDlINN8O; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cV19K2kHwbzsptwnWHvhPs0HRaJ8ZbKRyVa4qDbsSX8=; b=LDlINN8O1LAKs2p5yHxLeWpBOw
	1/sCr+l5elgqI6Gv4YhA2Q05sQWwyTH3hXXFtaocpJjuPd99GX9HZdwZ6zi634uAZ/7Db0xPDpIdW
	jdKHhbcSuKjMOAf1HnSDqANuFp3MpZsVtsPiEdit3k7viRy/62ZmD2YYsr9cr6eqJBzFXewZA4ysr
	0d3kYU3u7rwwzI6NoZH4cqRRkRRwwbjcoftoaLuHWiioh51XJ5CAs47S/4/ru8oqX1ks6fGDWzCjS
	8Fb2TakL10qWB/IpR7rJFhW4eOMbe8sTNLL2jgxWZtqhNlo/CS2/S/L2yQXr5JdQvLF5fwc7SWO0v
	605RQA7w==;
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1v1uBA-000000008PK-1RQG;
	Thu, 25 Sep 2025 18:11:08 -0400
Date: Thu, 25 Sep 2025 18:11:06 -0400
From: Rik van Riel <riel@surriel.com>
To: Frank van der Linden <fvdl@google.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, hannes@cmpxchg.org, david@redhat.com,
 roman.gushchin@linux.dev, kernel-team@meta.com
Subject: [RFC PATCH 13/12] mm,cma: add compaction cma balance helper for
 direct reclaim
Message-ID: <20250925181106.3924a90c@fangorn>
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
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Sep 2025 19:51:41 +0000
Frank van der Linden <fvdl@google.com> wrote:

> This is an RFC on a solution to the long standing problem of OOMs
> occuring when the kernel runs out of space for unmovable allocations
> in the face of large amounts of CMA.

In order to make the CMA balancing code useful without hugetlb involvement,
eg. when simply allocating a !__GFP_MOVABLE allocation, I added two
patches to invoke CMA balancing from the page reclaim code when needed.

With these changes, we might no longer need to call the CMA balancing
code from the hugetlb free path any more, and could potentially
simplify some things in that area.

---8<---
=46rom 99991606760fdf8399255d7fc1f21b58069a4afe Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@meta.com>
Date: Tue, 23 Sep 2025 10:01:42 -0700
Subject: [PATCH 2/3] mm,cma: add compaction cma balance helper for direct r=
eclaim

Add a cma balance helper for the direct reclaim code, which does not
balance CMA free memory all the way, but only a limited number of
pages.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 mm/compaction.c | 20 ++++++++++++++++++--
 mm/internal.h   |  7 +++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 3200119b8baf..90478c29db60 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2541,7 +2541,7 @@ isolate_free_cma_pages(struct compact_control *cc)
 	cc->free_pfn =3D next_pfn;
 }
=20
-static void balance_zone_cma(struct zone *zone, struct cma *cma)
+static void balance_zone_cma(struct zone *zone, struct cma *cma, int targe=
t)
 {
 	struct compact_control cc =3D {
 		.zone =3D zone,
@@ -2613,6 +2613,13 @@ static void balance_zone_cma(struct zone *zone, stru=
ct cma *cma)
 		nr_pages =3D min(nr_pages, cma_get_available(cma));
 	nr_pages =3D min(allocated_noncma, nr_pages);
=20
+	/*
+	 * When invoked from page reclaim, use the provided target rather
+	 * than the calculated one.
+	 */
+	if (target)
+		nr_pages =3D target;
+
 	for (order =3D 0; order < NR_PAGE_ORDERS; order++)
 		INIT_LIST_HEAD(&cc.freepages[order]);
 	INIT_LIST_HEAD(&cc.migratepages);
@@ -2674,10 +2681,19 @@ void balance_node_cma(int nid, struct cma *cma)
 		if (!populated_zone(zone))
 			continue;
=20
-		balance_zone_cma(zone, cma);
+		balance_zone_cma(zone, cma, 0);
 	}
 }
=20
+void balance_cma_zonelist(struct zonelist *zonelist, int nr_pages)
+{
+	struct zoneref *z;
+	struct zone *zone;
+
+	for_each_zone_zonelist(zone, z, zonelist, MAX_NR_ZONES - 1)
+		balance_zone_cma(zone, NULL, nr_pages);
+}
+
 #endif /* CONFIG_CMA */
=20
 static enum compact_result
diff --git a/mm/internal.h b/mm/internal.h
index 7dcaf7214683..5340b94683bf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -942,6 +942,7 @@ struct cma;
 void *cma_reserve_early(struct cma *cma, unsigned long size);
 void init_cma_pageblock(struct page *page);
 void balance_node_cma(int nid, struct cma *cma);
+void balance_cma_zonelist(struct zonelist *zonelist, int nr_pages);
 #else
 static inline void *cma_reserve_early(struct cma *cma, unsigned long size)
 {
@@ -950,6 +951,12 @@ static inline void *cma_reserve_early(struct cma *cma,=
 unsigned long size)
 static inline void init_cma_pageblock(struct page *page)
 {
 }
+static inline void balance_node_cma(int nid, struct cma *cma)
+{
+}
+static inline void balance_cma_zonelist(struct zonelist *zonelist, int nr_=
pages)
+{
+}
 #endif
=20
=20
--=20
2.47.3


