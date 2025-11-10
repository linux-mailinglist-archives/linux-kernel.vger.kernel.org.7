Return-Path: <linux-kernel+bounces-893612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E644DC47D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C4E188D53B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0CD27B34C;
	Mon, 10 Nov 2025 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6SpfGVg"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBB22777F9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790913; cv=none; b=bJNKCfQTjcM1OGe1JDzNgU5Q2PpMbqpkSDaZl7spWdLVXqVpOBbrpUMURR3AOjWsym7CcC785202gDonCmJ6ey4zwIsnU+8IgvulR2+UAN5IUSyc+9DMP33iMFCiM2BGvnBShEsI4VxEdqBR56HjC4eZKh2j5FLbKhO95/Bmt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790913; c=relaxed/simple;
	bh=7MfVjfH7lP5HITRpPa1Du8b4IBtOL6JXNOmOOlEoA30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l18NQKJC8FBtT1jtGmCo6Kp2vn6zIWSRWS9OBxAniq3pxpGMQup6cKJPYzqjzsYcxa6VfeBW9xHNV6EUCm7fyMaMUCBRUEtn9aAXFeCODq+vLkeFBlrM35IJ0QWZFM/wnQ6JeM3MVfwCPSZe2J5+DqiyzZjpcFPigCnh8vUS8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6SpfGVg; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3418ac74bffso2258426a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790911; x=1763395711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+nV/jZ5/FDcvQE4dxxEIUjR2wXP7vVmGSVjfrNRBXs=;
        b=L6SpfGVgNA3fSy6LJbjNyKj4Z3DO2h07ndfBbnNHPdhMOiTlY+GnA91aMwzXDiLn0r
         R9st4gOUTPmEP4NtluWzu53kJJd+QLm6T/IyQ1OeQVxFrxl+Nj63JnDn2GyN1KbTyI38
         0Sia2h7h2K5Cmy0gAvxBOnVGT8qN8nLaviqtHsz5iiFoWsXPcs2jeiPvssbf1sukadbM
         SsgX/B7pRWSdxJ4zFMTDydgfIOA1kd6cl6vYvzTkifrfF/Rd5aO6CEah77eNctlfh8xH
         Z5Kiuy1E9qxG6VUfrqklbExR03ArRnCkS5SWqH7R+iqbs+lMVRhOpn99Fant59Rcufcr
         jFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790911; x=1763395711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e+nV/jZ5/FDcvQE4dxxEIUjR2wXP7vVmGSVjfrNRBXs=;
        b=e26gA7XondmQRS7oPEAxECAdd5GlTsvCsBhlzHU7T1Vij1dZJhJDhPJr77hzmQVKPb
         02Egk4avjUosS861Vzg3cWiYSAGVWdNc1mSk86eMK6+TerM2kxqy3+iJERNo88ZvBSP7
         FOtr5/XQdpTRxgIRSti3QZZg8XbG+UVenG8/KGd2uz0L0EayfTT9Q9lap29B6HMqZ6n5
         pZeBR6kXlpdrg409s/yj5UIDK6qgFRqgE1r4+B+rCXVrq9ILUlXglXjf9qy+7vq5VTkD
         Zmnmk3xPt3HmGsnH+4qNWGe02ZKHgyKgyXFK3OOmB7IbkxsNnOkVsNaKftzsvlX5/J+y
         LJMg==
X-Gm-Message-State: AOJu0Yzx9/O+hJ/Ev2OcaXTSzo50rfUYAh/xZ/ZFWKPKb3r8cSO+iAPA
	IHCAochzqem926s+z0Pp7OJ+QTrLJTVkrHneAPkXGPMd8IVLR4g8EHNZCJS8P38o
X-Gm-Gg: ASbGncuOCHT0KKzLA8kwoKjUhLxnb/9SUfegWmm4uLL4SpkpNaZ7rRDGqanjIOF2PbW
	/2qLVP40e/AWz1DQ8giNyCzHxQ0xLtIIetAnN1Q4pvUsPleFp8we+650VmzuT7DDF/ha5/HGFbq
	nGwFAlaFT1Y3Dwh/59AAYjMpU22XsisxnS8z47Fx9YM4zSSsZ9O6KBhEwna2vEod4F1TVh0VZ9r
	glB9DPV/sWod5zS3XIAa4q6jaRJ4lq4iF/KnB3vFti4/KGd5t8Ly6an7asgglt6eQigh/XMFGyw
	wZA/kstJBBjYFVpKKxexKM77LEDVTFPl41PpKGRKHnNN5zKyiqjdzP899clfN4rOWiJdQelyMi7
	HzL1Q8MarLUtfU/WGMiCsDSns64/JEdITAEftfOvuthnwHiGciU7UW6klZQ9ju0kttjD/TLidt+
	AFhr/o2Y4lz5IJjLa+7e0SuzvqY6PgAtv6
X-Google-Smtp-Source: AGHT+IGiGpXb5t1syDzIJ+ZneRXYGIQwIEFnb4stWo4+PFBpOfXR7tAoh7nWQDaILvEgym3o0OPTcQ==
X-Received: by 2002:a17:90b:3512:b0:341:3ea2:b625 with SMTP id 98e67ed59e1d1-3436cb91984mr13954572a91.12.1762790911074;
        Mon, 10 Nov 2025 08:08:31 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34362f1f231sm9308893a91.10.2025.11.10.08.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:08:30 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/4] mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
Date: Mon, 10 Nov 2025 08:04:55 -0800
Message-ID: <20251110160457.61791-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110160457.61791-1-vishal.moola@gmail.com>
References: <20251110160457.61791-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vm_area_alloc_pages() attempts to use different gfp flags as a way
to optimize allocations. This has been done inline which makes things
harder to read.

Add a helper function to make the code more readable.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/vmalloc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 40d4bdcadb6d..8fbf78e8eb67 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3614,6 +3614,17 @@ void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot)
 EXPORT_SYMBOL_GPL(vmap_pfn);
 #endif /* CONFIG_VMAP_PFN */
 
+/*
+ * Helper for vmalloc to adjust the gfp flags for certain allocations.
+ */
+static inline gfp_t vmalloc_gfp_adjust(gfp_t flags, const bool large)
+{
+	flags |= __GFP_NOWARN;
+	if (large)
+		flags &= ~__GFP_NOFAIL;
+	return flags;
+}
+
 static inline unsigned int
 vm_area_alloc_pages(gfp_t gfp, int nid,
 		unsigned int order, unsigned int nr_pages, struct page **pages)
@@ -3852,9 +3863,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	 * Please note, the __vmalloc_node_range_noprof() falls-back
 	 * to order-0 pages if high-order attempt is unsuccessful.
 	 */
-	area->nr_pages = vm_area_alloc_pages((page_order ?
-		gfp_mask & ~__GFP_NOFAIL : gfp_mask) | __GFP_NOWARN,
-		node, page_order, nr_small_pages, area->pages);
+	area->nr_pages = vm_area_alloc_pages(
+			vmalloc_gfp_adjust(gfp_mask, page_order), node,
+			page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 	/* All pages of vm should be charged to same memcg, so use first one. */
-- 
2.51.1


