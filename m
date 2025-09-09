Return-Path: <linux-kernel+bounces-806942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D68B49DD4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D261891137
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033E2C2C9;
	Tue,  9 Sep 2025 00:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I2nSe9qC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527194A3E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 00:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757376412; cv=none; b=q2lEKy3CgrPTk96i7n5ub9/AvoFW05ztvk/cq9s67XaWmzZCmRwS2TCvOs4fjNIwZgY3c+n3ytNlBo1SoUdn3nseMTeDUt539Fuyrw65kBbHi6IIv92iY+lWQJSq7xVctkKmNS/KAR/w1W69bqAavW7rzP0/ipDfpvL0GB4QVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757376412; c=relaxed/simple;
	bh=W7ol01lPQCi9U0PzekdKliJMNYlWPZdelv3Gv7IpeyA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gI7Ag2NqfHtBZgl84+r0paaGADGwZuwRahqrMbh4n6DHPmvK2hyIM1t0V/hx4a9pxJGWPgcPDIUINc28jQfOV9mFV/FRnug9jaT3R8mBH51dDDsYM3QS1MvKW5x4a7xXuwuH/Pw6WPTAuPcI30/vsX7Y8k+bAgvI+GFK5aHl3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I2nSe9qC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C258C4CEF1;
	Tue,  9 Sep 2025 00:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757376411;
	bh=W7ol01lPQCi9U0PzekdKliJMNYlWPZdelv3Gv7IpeyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I2nSe9qC01GSe7mwpS8oGS/2GQ+9h7D00mXiH8V25ANgBEAEGCtWHot8cAkGokvqR
	 kHLnjUasBBPh8aAIHEpcikfsMgnu2NGhSP3CD8uL0sieEDCbQluja2GF8D5AA82mHI
	 JQKFiUzQ5KhIHpbuiaklwqgYqYvJh/AcKtcEvo2U=
Date: Mon, 8 Sep 2025 17:06:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chanwon Park <flyinrm@gmail.com>
Cc: vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
 zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: re-enable kswapd when memory pressure subsides or
 demotion is toggled
Message-Id: <20250908170650.8ede03581f38392a34d0d1f7@linux-foundation.org>
In-Reply-To: <aL6qGi69jWXfPc4D@pcw-MS-7D22>
References: <aL6qGi69jWXfPc4D@pcw-MS-7D22>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Sep 2025 19:04:10 +0900 Chanwon Park <flyinrm@gmail.com> wrote:

> If kswapd fails to reclaim pages from a node MAX_RECLAIM_RETRIES in a
> row, kswapd on that node gets disabled. That is, the system won't wakeup
> kswapd for that node until page reclamation is observed at least once.
> That reclamation is mostly done by direct reclaim, which in turn enables
> kswapd back.
> 
> However, on systems with CXL memory nodes, workloads with high anon page
> usage can disable kswapd indefinitely, without triggering direct
> reclaim. This can be reproduced with following steps:
> 
>    numa node 0   (32GB memory, 48 CPUs)
>    numa node 2~5 (512GB CXL memory, 128GB each)
>    (numa node 1 is disabled)
>    swap space 8GB
> 
>    1) Set /sys/kernel/mm/demotion_enabled to 0.
>    2) Set /proc/sys/kernel/numa_balancing to 0.
>    3) Run a process that allocates and random accesses 500GB of anon
>       pages.
>    4) Let the process exit normally.

hm, OK, I guess this is longstanding misbehavior?

> 
> Since kswapd_failures resets may be missed by ++ operation, it is
> changed from int to atomic_t.

Possibly this should have been a separate (earlier) patch.  But I
assume the need for this conversion was inroduced by this patch, so
it's debatable.

> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1411,7 +1411,7 @@ typedef struct pglist_data {
>  	int kswapd_order;
>  	enum zone_type kswapd_highest_zoneidx;
>  
> -	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
> +	atomic_t kswapd_failures;	/* Number of 'reclaimed == 0' runs */

This caused a number of 80-column horrors!  I had a fiddle, what do you
think?

--- a/mm/page_alloc.c~mm-re-enable-kswapd-when-memory-pressure-subsides-or-demotion-is-toggled-fix
+++ a/mm/page_alloc.c
@@ -2860,29 +2860,29 @@ static void free_frozen_page_commit(stru
 		 */
 		return;
 	}
+
 	high = nr_pcp_high(pcp, zone, batch, free_high);
-	if (pcp->count >= high) {
-		free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
-				   pcp, pindex);
-		if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&
-		    zone_watermark_ok(zone, 0, high_wmark_pages(zone),
-				      ZONE_MOVABLE, 0)) {
-			struct pglist_data *pgdat = zone->zone_pgdat;
-			clear_bit(ZONE_BELOW_HIGH, &zone->flags);
+	if (pcp->count < high)
+		return;
 
-			/*
-			 * Assume that memory pressure on this node is gone
-			 * and may be in a reclaimable state. If a memory
-			 * fallback node exists, direct reclaim may not have
-			 * been triggered, leaving 'hopeless node' stay in
-			 * that state for a while. Let kswapd work again by
-			 * resetting kswapd_failures.
-			 */
-			if (atomic_read(&pgdat->kswapd_failures)
-			    >= MAX_RECLAIM_RETRIES &&
-			    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
-				atomic_set(&pgdat->kswapd_failures, 0);
-		}
+	free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
+			   pcp, pindex);
+	if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&
+	    zone_watermark_ok(zone, 0, high_wmark_pages(zone),
+			      ZONE_MOVABLE, 0)) {
+		struct pglist_data *pgdat = zone->zone_pgdat;
+		clear_bit(ZONE_BELOW_HIGH, &zone->flags);
+
+		/*
+		 * Assume that memory pressure on this node is gone and may be
+		 * in a reclaimable state. If a memory fallback node exists,
+		 * direct reclaim may not have been triggered, causing a
+		 * 'hopeless node' to stay in that state for a while.  Let
+		 * kswapd work again by resetting kswapd_failures.
+		 */
+		if (atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES &&
+		    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
+			atomic_set(&pgdat->kswapd_failures, 0);
 	}
 }
 
--- a/mm/show_mem.c~mm-re-enable-kswapd-when-memory-pressure-subsides-or-demotion-is-toggled-fix
+++ a/mm/show_mem.c
@@ -278,8 +278,8 @@ static void show_free_areas(unsigned int
 #endif
 			K(node_page_state(pgdat, NR_PAGETABLE)),
 			K(node_page_state(pgdat, NR_SECONDARY_PAGETABLE)),
-			str_yes_no(atomic_read(&pgdat->kswapd_failures)
-				   >= MAX_RECLAIM_RETRIES),
+			str_yes_no(atomic_read(&pgdat->kswapd_failures) >=
+				   MAX_RECLAIM_RETRIES),
 			K(node_page_state(pgdat, NR_BALLOON_PAGES)));
 	}
 
_


