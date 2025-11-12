Return-Path: <linux-kernel+bounces-897968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA5AC54094
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5DE3AF4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26C034D4CC;
	Wed, 12 Nov 2025 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7knOLgO"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B334B663
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973927; cv=none; b=NGRkJBfihZHnFCiU7ZUzOoG9pPxHyAptC6+ptO0X8bNXBl45cU4bvtv2GfmUJixuUA3zHS2RbwYtWjjcCs6uxzrBhAmZZkBTGaFQbhuLp8oYSGfi/+zQyybqw2E1PVZVhMCpdxWzeNi0x+rzhsjanf1Vt9xI1BMf5I/H/xuv3j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973927; c=relaxed/simple;
	bh=rcvkjrTXMnJLziWH8zqVfRZ78IP9ZlW60rUNeTsh1wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0Q4UStITjF369OAlIlvChzXsjH1a8o/upNW0NbKBwv/IVvgn/EWoj09gIf4bId+HGZeeRsxPE/vTczxYf1d0VC1Gr7ierBK0S0UPqcC6Isx+//sp+b/vDb2VZB5PO9dNNtUIqaKFpD7x1FIfz8woYAOZ54w5Fx1hBsnrh5KlKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7knOLgO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3410c86070dso893320a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762973925; x=1763578725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA8cP4S3Tl3Wh5mUe69KyfI7cCSKipKpnkLZNCnzqEA=;
        b=S7knOLgOgnl+9TKwbK2bIMhslp3VQrmhZHPQX/VYm41XXPG5oQx7LF8Px7AkGjbhZp
         3yiLehtk731OLJsUaU9OjrSoBh1bHAUq9spQMCaN7pdPjV1QEAhcd5hHTURX8E8FXxjg
         z00U0moAzEkCV142wuaVPIhj0chzze7zHK3wuwNaiFrBp9wj/hYfiY288wiYa9H2XhqT
         NJH5lQbqc6yqGWZu1YALl9uMVs81aReVrlkUNxs/xuTHi9h3oIkJiiY25ZnTl7ADgJJJ
         rD/vHqisyF8AJv+VreqbVzPUVagyaAYhN/VhDLo4KXi6cfXUANgZ+dcIqnyXIgj6Qc4u
         Ov3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762973925; x=1763578725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qA8cP4S3Tl3Wh5mUe69KyfI7cCSKipKpnkLZNCnzqEA=;
        b=kE1VLPCKnFDAO6yps+lhWP8fQY+Jgq9PwDepQ0lcSzLDsFtUIeE63CunhynTFiHGUY
         dqcgI/g/7Ak44XhkwaM3DU35NA87nWFPH7SrIYVsU/L+giy1R8j1SjEic2zFHOlFEdXH
         Qa69CTsAke3IEGj/+ACgH8/D1e+y6cAFRWR3ybPyXHp1Pf3rSFxVOb1BAK5V2UTxuCIK
         6bYvp9NDkRKiSWAx1Elf8ZRdxu/pmAzkbc6Srg6JFzpG8DUqdzeodQk0votyx3gVpl0c
         89B+1FT6pRpwz83L6T6c5XCA8r8mo8yxUZYTFHeyH+MtLilQOUo3olR9V02XWbm7HhWA
         eBcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUW7QQiRAwfX83nMo1r8L+Atl9WUG+V/c476Lh5dVtwOrDY9taFXY8hU+hT5lEuTSH6Afg67yKDnC0rA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4Uy0hArVx+IviT80ZRhgPXHa1h1m6loTWLBKtKmHJjP6NMTM
	KICqZC++zLEs6Ldd7rc4UlKWduLDXexM8fhVdXLyXsKIUON2TYKGlkEC
X-Gm-Gg: ASbGnctKQP4y2Dgs5ew4FxWYUnJVD8DYGZx5K3Y6zIeyVjHoh8rVkZqUGJRKrdcwvkQ
	fzQ40JQqqAVx52r2DlkCqcvvHgx3+ybMBnu/7o5/24X+4eUnl4bzCcuaP4wNWqPX2p2kX7Ql2Pz
	svXUFaE9hFp0GB7UiXzb7BO61la8J3mBPLBQjrx8I2yJTnXjkxZRPtwyhZlfkFxyJGSvIOtNtRe
	x6HEhveIJbY7OL960hIe0GsVh6cu0URi147rHBtJXpsfI8pS5sCBHXnZJKOv4fIDtgzgQBTRD75
	1PqlbSt2n73nPAxCPuOrT3GHtrTCNJOJLnSNUJViqy3wjxAu7wbX0DS9IWOwkvENv4ZrxNsqfrj
	sPAs526PrS5uWxrYENAzZKQXVFZSiCX6M1vCxi6lt9s8BTr2F6Vuu7oRt9WgySHUARX6fa+MqEj
	HCT6ev5+fpL1whydjNvvBwhtJ1BmoG3vbb
X-Google-Smtp-Source: AGHT+IFVZWew3uxTlI2SxVBJMfOtL/w/zYRfLdI2Xrhh6UsbcQNHvvYj4pBEwbgZsC/LfWpQC5/usw==
X-Received: by 2002:a17:90b:50:b0:33b:938c:570a with SMTP id 98e67ed59e1d1-343ddefbbbemr5088912a91.33.1762973924869;
        Wed, 12 Nov 2025 10:58:44 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-343e06fe521sm3491565a91.1.2025.11.12.10.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:58:44 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 2/4] mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
Date: Wed, 12 Nov 2025 10:58:31 -0800
Message-ID: <20251112185834.32487-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112185834.32487-1-vishal.moola@gmail.com>
References: <20251112185834.32487-1-vishal.moola@gmail.com>
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
index 802a189f8d83..c0876ccf3447 100644
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


