Return-Path: <linux-kernel+bounces-853219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B85BDAF21
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 422094F6B44
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517D9299A81;
	Tue, 14 Oct 2025 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2XmSelU"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A42877D4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466481; cv=none; b=MosWch0mHbyM9I9s5leJVty0G5VI58XbtdAbbqxOWIEtTK0QnUsaen2qY66QSkGNg4Mh+uKI8AfJzT7HWIkXf+Ftzr7LWCufR/32K6Lwn3S2ssCFZiwdSMDmmfnpTck0QMxUHG6Hj15JWDVxAILzWxEo7cfSl7kI91Z3LYyA984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466481; c=relaxed/simple;
	bh=LbAa6ULbr03Ni3LX3ztCRzJBIg12HnCmOmnre3hfid0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AIHQ123Nov2kKZdsdFbJrFXQG0SiYCcuyvvUub0wOckG0hJf45ojheG/myqsjYvBlEVyc/t9GjZCNm7PKVW0Z41MV0+9P49DE5SU6rECvMNawonwCNugKxCXO5pwOIr8Ei6P7xlSopwGD2BW08DOb6Z3RipNYBI32Y9yXTR44kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2XmSelU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so3254521f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760466478; x=1761071278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LBBmR5pAf4HbXTBeQ1kPK+D1rmObAEhbuan+OuQ0JhE=;
        b=G2XmSelU5JmRhZ3jh1vvN37wNgFtAPkiZdZ/d1f+QFzJTe9lY+fDTiywZ7MBZTPYkf
         9iBq48TC1gEgsJ+ZqeibA9xEte6AvOPpWvjsU47LKhlW9e66LiSd2DiTZvqfMY/NVNV+
         TIWPY47tzKIg0cNx01huGdacqCmXh0pSr19uhwa0pQfZWTVCezm9wK4XVAfn5KjeQ1fn
         iK047Cp0ug/z9APFYjMFtviB8z3SDZQRVFsHSO15q5G45BJf5S5I7qE+60nSZ5rYzyeq
         9UcanFxqo0E0fowHiQ85SaM/jySobHJ0UuvzGZ63MB1onJHFRf7FOxV7AkTGyuvffGzt
         ml2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760466478; x=1761071278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBBmR5pAf4HbXTBeQ1kPK+D1rmObAEhbuan+OuQ0JhE=;
        b=V4O/QENgN777Kgkvg3F1kr7dDH59ydkwTrFitsAI+dLJ4Ff98XsmfN6xsSEKxp2dez
         jYYYnJnaPuqi5ERAU5CqinMvAeqbZ2umzGBaHAW/BM9Nn7fUXWIV6XDFcMr3dlN66IC+
         AZDyXEzRlHw0V2b1DSfAOKjUFjo8H1TcJzu/5MwmyKmzsMODk+Hq1ADZ1UelK8L+zwqq
         czd2ybqOLJaGD+GcySKWF6QAAdx+yaQb75gT5tc4SgWK7AQO4fmoMKUzB00mm8n9ufNO
         D66c2xmbfBpp9FmiUmNUIYm21gGiV2wdBOrXv2uUuNbHUiGBEj9VPiq4tu10rsbaoXQK
         zGvA==
X-Forwarded-Encrypted: i=1; AJvYcCUwfsidePJftfWnuw3j2H20iQ9YAgBEpQ+mMd6jS7XNrkC3lbEMOkLjm8FsVwIZ4/8jspnYXtr/FffQpIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybjSbN7+orrsdDna5B9EoTyjbpwJL4/HPiFJIdIALo3cPLAbM7
	B7Uh3mY2kDS/75T7bGHexfJtzTp/SWh7TUPDe2vR6Los3IguclAe6OAI
X-Gm-Gg: ASbGncuoDe7VAyPh8WUA1mQ9GTQU36EF61MvmZKWfYnmAxP8o0JsZuLa8Sp6cmPNotg
	U7pAPsTIyGoTlotZOCE82ddCrkK/P053R0wo+CaqqzNKxazFsfpTIdTHyDcZj8AR1NFHnfAdP4M
	K3wqnvUUCEHE/uAv5q6HpAAo7rhc8ZGjwWwBNnQiMjlNmXZPPZZ0LOqJodOmJ3x2I1kXNSHm5jB
	yHsfV8U8HVeb2KPI2oq8VI3+B6VkAQhWh+Jyt0Xnf+5AR86C2XWHn/i7D5DZ39o4C1utxUafjXB
	OJvw1QX37pWPmxjhOhLQQHywpeAjN5RTllKlJqq4ZauVuxU7fP35ZNdsyrPIPnCf9dcrsfJz593
	xnwoKkVYZ0Cg5TcrhlTUrGay/UKYJqFCI4MQFk7VUSWX1r/QqXKz54//Hv2Z7jfNtN8c=
X-Google-Smtp-Source: AGHT+IHSJpI2+SslPqhOIWr8+fra5n1+waQpCkYtL5Nh0y1DMOBU4t5TaQtKsalwtXTnAPToZ83UfQ==
X-Received: by 2002:a5d:584b:0:b0:3ee:1461:1654 with SMTP id ffacd0b85a97d-4266e8d92e8mr18056477f8f.50.1760466477644;
        Tue, 14 Oct 2025 11:27:57 -0700 (PDT)
Received: from fedora.castlerock.net ([31.94.68.142])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-426ce5833dcsm24789309f8f.19.2025.10.14.11.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 11:27:57 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [RFC PATCH] mm/vmalloc: request large order pages from buddy allocator
Date: Tue, 14 Oct 2025 11:27:54 -0700
Message-ID: <20251014182754.4329-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes, vm_area_alloc_pages() will want many pages from the buddy
allocator. Rather than making requests to the buddy allocator for at
most 100 pages at a time, we can eagerly request large order pages a
smaller number of times.

We still split the large order pages down to order-0 as the rest of the
vmalloc code (and some callers) depend on it. We still defer to the bulk
allocator and fallback path in case of order-0 pages or failure.

Running 1000 iterations of allocations on a small 4GB system finds:

1000 2mb allocations:
	[Baseline]			[This patch]
	real    46.310s			real    34.380s
	user    0.001s			user    0.008s
	sys     46.058s			sys     34.152s

10000 200kb allocations:
	[Baseline]			[This patch]
	real    56.104s			real    43.946s
	user    0.001s			user    0.003s
	sys     55.375s			sys     43.259s

10000 20kb allocations:
	[Baseline]			[This patch]
	real    0m8.438s		real    0m9.160s
	user    0m0.001s		user    0m0.002s
	sys     0m7.936s		sys     0m8.671s

This is an RFC, comments and thoughts are welcomed. There is a
clear benefit to be had for large allocations, but there is
some regression for smaller allocations.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/vmalloc.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 97cef2cc14d3..0a25e5cf841c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3621,6 +3621,38 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	unsigned int nr_allocated = 0;
 	struct page *page;
 	int i;
+	gfp_t large_gfp = (gfp & ~__GFP_DIRECT_RECLAIM) | __GFP_NOWARN;
+	unsigned int large_order = ilog2(nr_pages - nr_allocated);
+
+	/*
+	 * Initially, attempt to have the page allocator give us large order
+	 * pages. Do not attempt allocating smaller than order chunks since
+	 * __vmap_pages_range() expects physically contigous pages of exactly
+	 * order long chunks.
+	 */
+	while (large_order > order && nr_allocated < nr_pages) {
+		/*
+		 * High-order nofail allocations are really expensive and
+		 * potentially dangerous (pre-mature OOM, disruptive reclaim
+		 * and compaction etc.
+		 */
+		if (gfp & __GFP_NOFAIL)
+			break;
+		if (nid == NUMA_NO_NODE)
+			page = alloc_pages_noprof(large_gfp, large_order);
+		else
+			page = alloc_pages_node_noprof(nid, large_gfp, large_order);
+
+		if (unlikely(!page))
+			break;
+
+		split_page(page, large_order);
+		for (i = 0; i < (1U << large_order); i++)
+			pages[nr_allocated + i] = page + i;
+
+		nr_allocated += 1U << large_order;
+		large_order = ilog2(nr_pages - nr_allocated);
+	}
 
 	/*
 	 * For order-0 pages we make use of bulk allocator, if
@@ -3665,7 +3697,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		}
 	}
 
-	/* High-order pages or fallback path if "bulk" fails. */
+	/* High-order arch pages or fallback path if "bulk" fails. */
 	while (nr_allocated < nr_pages) {
 		if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
 			break;
-- 
2.51.0


