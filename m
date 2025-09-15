Return-Path: <linux-kernel+bounces-817699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A79B5857F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE40520841A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2547C28750B;
	Mon, 15 Sep 2025 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JO1Jy62r"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE4927FB03
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965941; cv=none; b=uziKvpkMxagqdeqF7TWLMQQ0fBgWv6wAMXPu9/e0e/GrlAi/XdMp2hBqdJB3arZ7XpHO6mbTDQS/BPpj8c+NmZ2DeW4yRYrWud1zKsWmOuhu/tVX7r5pWQMWpUBVpeQYAXiLRI+dwVxeaeIDokSWfAjaMGsawnCubuzkkhlWZPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965941; c=relaxed/simple;
	bh=WAwmYK+Wk+ezVkxFs6fZH7WJMojACKwK7Id+MTs3ixo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QwD9RqyD4LGEmcZCOhg73iNKSUO/uDBHR5D+WlI5GVQg+ilqM3CR3eoE9IuPFK5AdRNlImjodO5hUbTsyTJWn+t1iK6VgU78QcuBtgsghlhgy/ZtY83qfNt6t8N3vtN/7QeUJ1GQsnNHMP5G65fR/P9k2rkrT9Ae3xH+ICh7DP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JO1Jy62r; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b54d1ae6fb3so851313a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757965939; x=1758570739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MEHSxUH62Eh+PKLeZWp21wGeWPgaNRIAu0LrXAExrg=;
        b=JO1Jy62r4cfIH05C/bhc8GT0MN2z1dZon+Ou/zdYzsMj5MM7N1uLMM6gTw/z39k548
         OWDpqdxLNjQzvNctR6IYezMrFCHFpJAgSEhFSkfd6coedRutau60NrHSex14ok1d5eza
         AS+ICBwACIRhOzEVkdUsXLMqhpvChwmQ2tSocCJRG6NZg7ByC0ZfuDtXHbPOOkb80zKP
         Ezqz7kV7oXM5LjozOj+3Y2UwEAn490xwE49ChcYEu+bjFSIJcL90kLjW+K+hALoHgCJG
         9Him7g64QDAid8zxJlhVsZMFhmZY7V9Qxe54igXlygFtbiptwjoRYe1bCVcVz9+g1L9W
         ZBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965939; x=1758570739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MEHSxUH62Eh+PKLeZWp21wGeWPgaNRIAu0LrXAExrg=;
        b=CwOLHJ54Q1X/uZEQE+KBpysceHBOS9rdXM1334Wqh5aVeKnugL3Vtf9lS8pVXffWrV
         jQV2QLDCjkAAZdquDUGXK03AoIFJoeREm0TbLpenDdzU/5OmwrFlDLuJVCqgM+jdRihZ
         OJyfGpRTQ7rdZHnPlkGAI5o8yeMV8zw4bB1BazCPB2WVriAR+8gtlSIDSIgMSFOfp05E
         Uhvs2xVtoZylD7X7MfwSIkTKymz9aMglzc9vrvrjvaviJfE7mHFqEhaVLaqdp+aIAYeB
         Eov1LQ+Y3hG8rfM7+RLH6DLatrwVbbXch56EhQPITo17KsBEb3TP7hVLEYk3Fduup+F9
         v2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWL02KlhO/pDd8M4ZTiHWa7VmWSF09GNCs7yyRZkWnedR2zM1vc4Sv4C2ZmP/THIQiCPOwUbxIlwmr8y0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0LrN/E/JSFssy6OasvlX9uEmiaCe/sbz3Lav5GblDFsI05OPi
	EvqQE8YRaurZkp/23EHZeBnBaIvXOcU05P/rn7tKRsS4f7drXczDpsOo8rHP+E8llmRJJ92RPQ=
	=
X-Google-Smtp-Source: AGHT+IGZlYJ0mle+xbHh0xSRjwktI5S74Ce+g2IBDqSwNJEmJuGQ84hMG5BDqQiRTBYzVAJcWam5sKXU
X-Received: from pjss8.prod.google.com ([2002:a17:90a:1c08:b0:32e:12f0:20e3])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1209:b0:246:2e9:daaa
 with SMTP id d9443c01a7336-25d242f23f6mr188309855ad.2.1757965939122; Mon, 15
 Sep 2025 12:52:19 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:51:42 +0000
In-Reply-To: <20250915195153.462039-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915195153.462039-1-fvdl@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915195153.462039-2-fvdl@google.com>
Subject: [RFC PATCH 01/12] mm/cma: add tunable for CMA fallback limit
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a tunable to experiment with the circumstances under which
movable allocations should use CMA pageblocks first, to avoid
false OOM conditions.

The limit is the percentage free memory which is being taken up
by CMA. If the amount of used memory in CMA pageblocks is above
this limit, CMA will be used first. So, 0 would mean always using
CMA first, and 100 means never use CMA first.

Currently the default is 50, which matches the existing behavior,
so there is no functional change.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 include/linux/mm.h |  4 +++
 mm/page_alloc.c    | 84 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ae97a0b8ec7..313ab38dc398 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3253,6 +3253,10 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...);
 
 extern void setup_per_cpu_pageset(void);
 
+#ifdef CONFIG_CMA
+extern int cma_first_limit;
+#endif
+
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d1d037f97c5f..d3966d31c039 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2446,6 +2446,54 @@ enum rmqueue_mode {
 	RMQUEUE_STEAL,
 };
 
+#ifdef CONFIG_CMA
+/*
+ * The percentage of free CMA pages as part of the total number of free
+ * pages above which CMA is used first.
+ * 0 = always, 100 = never
+ */
+int cma_first_limit __read_mostly = 50;
+EXPORT_SYMBOL_GPL(cma_first_limit);
+
+/*
+ * Return values:
+ *
+ * -1 - never try CMA (!ALLOC_CMA or !IS_ENABLED(CONFIG_CMA))
+ *  0 - don't try CMA first
+ *  1 - try CMA first.
+ */
+static __always_inline int use_cma_first(struct zone *zone,
+					 unsigned int alloc_flags)
+{
+	unsigned long free_cma, free_pages, cma_percentage;
+
+	if (!(alloc_flags & ALLOC_CMA))
+		return -1;
+
+	free_cma = zone_page_state(zone, NR_FREE_CMA_PAGES);
+	if (!free_cma)
+		return -1;
+
+	if (!cma_first_limit)
+		return 1;
+
+	if (cma_first_limit == 100)
+		return 0;
+
+	free_pages = zone_page_state(zone, NR_FREE_PAGES);
+	if (!free_pages)
+		return 0;
+
+	cma_percentage = (free_cma * 100) / free_pages;
+	return (cma_percentage > cma_first_limit) ? 1 : 0;
+}
+#else
+static inline int use_cma_first(struct zone *zone, unsigned int alloc_flags)
+{
+	return -1;
+}
+#endif
+
 /*
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
@@ -2455,20 +2503,13 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 	  unsigned int alloc_flags, enum rmqueue_mode *mode)
 {
 	struct page *page;
+	int cma_first;
 
-	if (IS_ENABLED(CONFIG_CMA)) {
-		/*
-		 * Balance movable allocations between regular and CMA areas by
-		 * allocating from CMA when over half of the zone's free memory
-		 * is in the CMA area.
-		 */
-		if (alloc_flags & ALLOC_CMA &&
-		    zone_page_state(zone, NR_FREE_CMA_PAGES) >
-		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
-			page = __rmqueue_cma_fallback(zone, order);
-			if (page)
-				return page;
-		}
+	cma_first = use_cma_first(zone, alloc_flags);
+	if (cma_first > 0) {
+		page = __rmqueue_cma_fallback(zone, order);
+		if (page)
+			return page;
 	}
 
 	/*
@@ -2487,7 +2528,11 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 			return page;
 		fallthrough;
 	case RMQUEUE_CMA:
-		if (alloc_flags & ALLOC_CMA) {
+		/*
+		 * Try CMA if we should, and haven't done so yet,
+		 * which is indicated by cma_first == 0.
+		 */
+		if (cma_first == 0) {
 			page = __rmqueue_cma_fallback(zone, order);
 			if (page) {
 				*mode = RMQUEUE_CMA;
@@ -6672,6 +6717,17 @@ static const struct ctl_table page_alloc_sysctl_table[] = {
 		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
 #endif
+#ifdef CONFIG_CMA
+	{
+		.procname	= "cma_first_limit",
+		.data		= &cma_first_limit,
+		.maxlen		= sizeof(cma_first_limit),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE_HUNDRED,
+	},
+#endif
 };
 
 void __init page_alloc_sysctl_init(void)
-- 
2.51.0.384.g4c02a37b29-goog


