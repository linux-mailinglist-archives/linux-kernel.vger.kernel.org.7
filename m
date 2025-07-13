Return-Path: <linux-kernel+bounces-729174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8C8B032C6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 21:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9363AE1AB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 19:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691B0230BE3;
	Sun, 13 Jul 2025 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pXixQJwI"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44D82AEE4
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752436655; cv=none; b=eYpes3OUgiTOVHmnR2DWsdA56MXUqUmKRNCbGWkfCPZgHwFhYGAnyhtbTzf6IZRU3qYLSN7sDDba7VvoZ4MWFrDFAm2p350uWPdT1RIend9XSeiECZZAgFMmv3tMqoiUb2XmGA/YEKbg/tvbh9cQ3DjW/fe63t4pvDTSSl1KTKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752436655; c=relaxed/simple;
	bh=68VKlfi/unlat6GBcyA8Q9LQyImwYI5jZsAkCtlT4JE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XM5FuF/DGGR927UBk5uyKMTN+CG12/5BfDRLPfQoV5YMA0f0hZREdXpwdvBb3Muz7CPFxthHcC519k9bBESXv19OabtdmG7J5rvz1RfHspFkAkOK6KnI7l1jAyoXAV84RN8DP48Hv/sZAQnwkuaPfPnULLfHDl4kdW3KZ3Sj9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pXixQJwI; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e64b430daso37532657b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 12:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752436653; x=1753041453; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=puv99ouo5wHgk+GBtNR2PPe4/WSCIo0qF8be0U1ROe4=;
        b=pXixQJwIuh2lmre0PWmIDK8SsNVaWWQ4StkxcJJOuCr3FaNxbqBsxTcSgOJm+j0y7u
         yE3gBZL++kdFAx/TL6YzotX1xFv9xQqgexYr5S9EzCtOup34RDFxH6PfnZaF5H4yIsZe
         5Hi0i86guNOVVrO/yjNR8TaEx6rjkjipfZ6yvOTKonlitf+yNvZYfHZISJdftUltGnQE
         pf/jy/4zzE12ZLxwqL9/dGaLvg1/TOFDLwwpWz4eWNvHtkGSvfSOSfz6aEgsl9f/XoM1
         vziLNX6iSvDpFSUUDPFxRpB4s/z0mygq467k+ljwYsi9k4PB1ETqnyEVZHvX6VwJRmew
         3UUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752436653; x=1753041453;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puv99ouo5wHgk+GBtNR2PPe4/WSCIo0qF8be0U1ROe4=;
        b=j9wMcF8WxoNPqD4kg10tEVqCzPzsESIg6xJ1SfTcK7lm6YM2/Y1o+w1Q9dNr0+/DMG
         NZ+ScyYImf2Cveh/LBkYsoUuMbcGYHDpMlWihjWiVUX/uC7NkXBlNchcRLjzXlXDZAEK
         gWm9cAtahzYDP3+mmO/t7F4WkPZc6zNWjO1BcMZbmOUKHt6z41Sx2ZAPKKdd3dPQdoRw
         f2NOh6iaU1ng4KFC+LvYLZsYcffLBcYMjhDRwAGUamYHnb6ILmRUUyAM907tBVHolmot
         pTlYekHQltiUXTWkOxNowXxRGyUwHNQHP/x6zDzJRRlWqfHxiKrB86FDhtMRNHDvXq0L
         C+GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPIOdB9Su8ZXW+onFjZv3EpySRgBIfudrzs2ZenogWC/UCx0pTNpnvsfEpFlUGY15WJJ9CuaMRU1yVQy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOrBwMV328Aipa1Comw8UE0gVTYZeuDASZLGC+bkbIopn+bRG
	SkxpjY0QAxlCs3gTPTjPTl4MnD/oosMzuXmFkId79etpzdpezXQu5bXpR/XFY7Q2Xg==
X-Gm-Gg: ASbGncvZUHGGS76lIoV1jGcpAoY457+6HRsv5LHS78MKFznqQ0f7hvaSa6ZddwY40Vx
	ZWjYMZ7ntH3S5yIsjdRkEvCp6CQivfUBmX1KeeZVgwEvq3NrfxVZNUtDiVc01pCRExuSDcUTEH/
	b4VgI3XtZdMiFThAZdPnRIAjnqKWIwEOTcRldlrE37Wd7dxw6twIbrTZkm8gTy+8Js2sqM+cwYU
	2OFO4bMFahW9KZpLq8yWaGGs+diVBu9szyvwALy4DjnHPbclw/WeBv2bVeAAbaTCVaKqRujdy15
	h7IPYBQgK1OCebgbJ9EU5DrxZduzM/LFRGFrwyW9BjxCVotR6KYVfWSMEfwZuNBO0hiFPPcoYFX
	7wD3exH7xSk5DGUpe5z+vsWkeqK2x7STYdxffv6fB27UD2lMnTJVKJ4ztO1WSDZtmCsCpojevae
	4hKRFzX2M=
X-Google-Smtp-Source: AGHT+IFiebH+PL/0Lj4regqiAiXa4Tp91yy4FPEaY5u8sBCHF/ZH06ecEQwinRXyZ05uwCsN02PPzg==
X-Received: by 2002:a05:690c:6802:b0:712:d70b:45d5 with SMTP id 00721157ae682-717d7a60057mr149542037b3.33.1752436652590;
        Sun, 13 Jul 2025 12:57:32 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c61eae7bsm16518917b3.104.2025.07.13.12.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 12:57:31 -0700 (PDT)
Date: Sun, 13 Jul 2025 12:57:18 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: skip lru_note_cost() when scanning only file or
 anon
In-Reply-To: <8734b21tie.fsf@linux.dev>
Message-ID: <21100102-51b6-79d5-03db-1bb7f97fa94c@google.com>
References: <20250711155044.137652-1-roman.gushchin@linux.dev> <8734b21tie.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 11 Jul 2025, Roman Gushchin wrote:

> Sorry, sent a wrong version with a trivial bug. Below is the correct
> one. The only difference is s/&sc/sc when calling scan_balance_biased().
> 
> --
> 
> From c06530edfb8a11139f2d7878ce3956b9238cc702 Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <roman.gushchin@linux.dev>
> Subject: [PATCH] mm: skip lru_note_cost() when scanning only file or anon
> 
> lru_note_cost() records relative cost of incurring io and cpu spent
> on lru rotations, which is used to balance the pressure on file and
> anon memory. The applied pressure is inversely proportional to the
> recorded cost of reclaiming, but only within 2/3 of the range
> (swappiness aside).
> 
> This is useful when both anon and file memory is reclaimable, however
> in many cases it's not the case: e.g. there might be no swap,
> proactive reclaim can target anon memory specifically,
> the memory pressure can come from cgroup v1's memsw limit, etc.
> In all these cases recording the cost will only bias all following
> reclaim, also potentially outside of the scope of the original memcg.
> 
> So it's better to not record the cost if it comes from the initially
> biased reclaim.
> 
> lru_note_cost() is a relatively expensive function, which traverses
> the memcg tree up to the root and takes the lruvec lock on each level.
> Overall it's responsible for about 50% of cycles spent on lruvec lock,
> which might be a non-trivial number overall under heavy memory
> pressure. So optimizing out a large number of lru_note_cost() calls
> is also beneficial from the performance perspective.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  mm/vmscan.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c86a2495138a..7d08606b08ea 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -71,6 +71,13 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/vmscan.h>
>  
> +enum scan_balance {
> +	SCAN_EQUAL,
> +	SCAN_FRACT,
> +	SCAN_ANON,
> +	SCAN_FILE,
> +};
> +
>  struct scan_control {
>  	/* How many pages shrink_list() should reclaim */
>  	unsigned long nr_to_reclaim;
> @@ -90,6 +97,7 @@ struct scan_control {
>  	/*
>  	 * Scan pressure balancing between anon and file LRUs
>  	 */
> +	enum scan_balance scan_balance;
>  	unsigned long	anon_cost;
>  	unsigned long	file_cost;
>  
> @@ -1988,6 +1996,17 @@ static int current_may_throttle(void)
>  	return !(current->flags & PF_LOCAL_THROTTLE);
>  }
>  
> +static bool scan_balance_biased(struct scan_control *sc)
> +{
> +	switch (sc->scan_balance) {
> +	case SCAN_EQUAL:
> +	case SCAN_FRACT:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
>  /*
>   * shrink_inactive_list() is a helper for shrink_node().  It returns the number
>   * of reclaimed pages
> @@ -2054,7 +2073,9 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>  	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
>  	spin_unlock_irq(&lruvec->lru_lock);
>  
> -	lru_note_cost(lruvec, file, stat.nr_pageout, nr_scanned - nr_reclaimed);
> +	if (!scan_balance_biased(sc))
> +		lru_note_cost(lruvec, file, stat.nr_pageout,
> +			      nr_scanned - nr_reclaimed);
>  
>  	/*
>  	 * If dirty folios are scanned that are not queued for IO, it
> @@ -2202,7 +2223,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
>  	spin_unlock_irq(&lruvec->lru_lock);
>  
> -	if (nr_rotated)
> +	if (nr_rotated && !scan_balance_biased(sc))
>  		lru_note_cost(lruvec, file, 0, nr_rotated);
>  	trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate,
>  			nr_deactivate, nr_rotated, sc->priority, file);
> @@ -2327,13 +2348,6 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
>  	return inactive * inactive_ratio < active;
>  }
>  
> -enum scan_balance {
> -	SCAN_EQUAL,
> -	SCAN_FRACT,
> -	SCAN_ANON,
> -	SCAN_FILE,
> -};
> -
>  static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
>  {
>  	unsigned long file;
> @@ -2613,6 +2627,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  	calculate_pressure_balance(sc, swappiness, fraction, &denominator);
>  
>  out:
> +	sc->scan_balance = scan_balance;
> +
>  	for_each_evictable_lru(lru) {
>  		bool file = is_file_lru(lru);
>  		unsigned long lruvec_size;
> -- 
> 2.50.0

Roman, I'm expressing no opinion on your patch above, but please may I
throw the patch below (against 6.16-rc) over the wall to you, to add as a
1/2 or 2/2 to yours (as it stands, it does conflict slightly with yours).

My attention needs to be on other things; but five years ago in
https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2009211440570.5214@eggly.anvils/
I noted how lru_note_cost() became more costly with per-memcg lru_lock,
but did nothing about it at the time.  Apparently now is the time.

Thanks,
Hugh

[PATCH] mm: lru_note_cost_unlock_irq()

Dropping a lock, just to demand it again for an afterthought, cannot be
good if contended: convert lru_note_cost() to lru_note_cost_unlock_irq().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/swap.h |  5 +++--
 mm/swap.c            | 26 +++++++++++++++++++-------
 mm/vmscan.c          |  8 +++-----
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index bc0e1c275fc0..a64a87cda960 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -376,8 +376,9 @@ extern unsigned long totalreserve_pages;
 
 
 /* linux/mm/swap.c */
-void lru_note_cost(struct lruvec *lruvec, bool file,
-		   unsigned int nr_io, unsigned int nr_rotated);
+void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
+		unsigned int nr_io, unsigned int nr_rotated)
+		__releases(lruvec->lru_lock);
 void lru_note_cost_refault(struct folio *);
 void folio_add_lru(struct folio *);
 void folio_add_lru_vma(struct folio *, struct vm_area_struct *);
diff --git a/mm/swap.c b/mm/swap.c
index 4fc322f7111a..37053f222a6e 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -237,8 +237,9 @@ void folio_rotate_reclaimable(struct folio *folio)
 	folio_batch_add_and_move(folio, lru_move_tail, true);
 }
 
-void lru_note_cost(struct lruvec *lruvec, bool file,
-		   unsigned int nr_io, unsigned int nr_rotated)
+void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
+		unsigned int nr_io, unsigned int nr_rotated)
+		__releases(lruvec->lru_lock)
 {
 	unsigned long cost;
 
@@ -250,8 +251,12 @@ void lru_note_cost(struct lruvec *lruvec, bool file,
 	 * different between them, adjust scan balance for CPU work.
 	 */
 	cost = nr_io * SWAP_CLUSTER_MAX + nr_rotated;
+	if (!cost) {
+		spin_unlock_irq(&lruvec->lru_lock);
+		return;
+	}
 
-	do {
+	for (;;) {
 		unsigned long lrusize;
 
 		/*
@@ -261,7 +266,6 @@ void lru_note_cost(struct lruvec *lruvec, bool file,
 		 *    rcu lock, so would be safe even if the page was on the LRU
 		 *    and could move simultaneously to a new lruvec).
 		 */
-		spin_lock_irq(&lruvec->lru_lock);
 		/* Record cost event */
 		if (file)
 			lruvec->file_cost += cost;
@@ -285,14 +289,22 @@ void lru_note_cost(struct lruvec *lruvec, bool file,
 			lruvec->file_cost /= 2;
 			lruvec->anon_cost /= 2;
 		}
+
 		spin_unlock_irq(&lruvec->lru_lock);
-	} while ((lruvec = parent_lruvec(lruvec)));
+		lruvec = parent_lruvec(lruvec);
+		if (!lruvec)
+			break;
+		spin_lock_irq(&lruvec->lru_lock);
+	}
 }
 
 void lru_note_cost_refault(struct folio *folio)
 {
-	lru_note_cost(folio_lruvec(folio), folio_is_file_lru(folio),
-		      folio_nr_pages(folio), 0);
+	struct lruvec *lruvec;
+
+	lruvec = folio_lruvec_lock_irq(folio);
+	lru_note_cost_unlock_irq(lruvec, folio_is_file_lru(folio),
+				folio_nr_pages(folio), 0);
 }
 
 static void lru_activate(struct lruvec *lruvec, struct folio *folio)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f8dfd2864bbf..5ba49f884bc0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2059,9 +2059,9 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 		__count_vm_events(item, nr_reclaimed);
 	count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
 	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
-	spin_unlock_irq(&lruvec->lru_lock);
 
-	lru_note_cost(lruvec, file, stat.nr_pageout, nr_scanned - nr_reclaimed);
+	lru_note_cost_unlock_irq(lruvec, file, stat.nr_pageout,
+					nr_scanned - nr_reclaimed);
 
 	/*
 	 * If dirty folios are scanned that are not queued for IO, it
@@ -2207,10 +2207,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-	spin_unlock_irq(&lruvec->lru_lock);
 
-	if (nr_rotated)
-		lru_note_cost(lruvec, file, 0, nr_rotated);
+	lru_note_cost_unlock_irq(lruvec, file, 0, nr_rotated);
 	trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate,
 			nr_deactivate, nr_rotated, sc->priority, file);
 }
-- 
2.43.0

