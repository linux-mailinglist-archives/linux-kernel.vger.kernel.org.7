Return-Path: <linux-kernel+bounces-878693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8780C21481
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D96E4F09A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C52366FDE;
	Thu, 30 Oct 2025 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="danKfheQ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE78A36335F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842628; cv=none; b=NVsWbjjHawQotP/0XcUufiG9cbDu4yOAwofhvczBRY8VwYT1XBb7tNrsIii4uuEI0yVE2BhG93YXOHVHnKavAjaqzDlCveZ09U0FhvPUuWU5s0IcxZNfp/TohWBXIxDuHevWUsiv8gQB3eSKGaNstDK5bkNrCNIjTi1UsiE/ybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842628; c=relaxed/simple;
	bh=4zaCyBIC8VEbo9JXfiIJAaPiA7m1foXZ6IKGyWxmuhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qeynn8si6RygxvOdsWAohE9XDI6OeHot83wNtwoc8JaJhaxL8E7JOswRvLksJgfK9+J0SbR4O5OJOaeu7N5WiknSK2Y7reyTlYHLT/LbRIIaV7Vwv9apqzyNYZbXw8/ZAH8mAFWRSTJCwiSHMinFJTNOtIF9tw9IDjcFhVevbp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=danKfheQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429b85c3880so1057929f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842625; x=1762447425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8NaKFIa21x2HNBN6xbLMzza2GzAoImbWtV6ctvvfMU=;
        b=danKfheQ/vxzCQAmjJQaXL6Hp0udgXn8W9zFYWGLQ0FFchFqf+O55BBToKI15BtI/S
         6JWlML/G9+IRjy+aUXgZnQMiNRvjeLcDSSZVVNZDBnH5861WbQGKXt0LPCEqD6DM8Pzn
         rLINZbYrIUujXpuxkzmIlvp+fIGk1PI4HTMLXhrm6ejJOkd+eVsNNkHWxVaEJJbc+3M/
         np0McxBxCw9B3KQqp/sGS+hNEw4nQYIYcyGqjcYhs/n3uQSM/XJuVhxebtEFd4BSqsKN
         ZIlejQvcoHEwcLN/VbrADb6zLNF8r2GymzAMIIEBmNyEDSQZmbhsoOdpM2noD7aOeEBO
         gCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842625; x=1762447425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8NaKFIa21x2HNBN6xbLMzza2GzAoImbWtV6ctvvfMU=;
        b=vDZ8sH3STEusSqJ3HUmuxuyTZe8vQMhp7/oyaNW/sc+Sy3/+2veOE0AIaa+pA9jWY4
         1ksjkkszobPNpBKzVRZHPmZ4dmaYK5RJcO4WQoJBuKEWN5KxPg0ZspQ68RHjZjUH/IjQ
         Jie/CYEpULrh52Xd2KMszAVmRXALXhToCCJgjSb9/q2MK1uvDQxiGib23pZEgrkNAUFN
         yUzWgI1HdhBMgXERk48vRetrdNCqfn90dUrOcpfxPPENhD0wDTyBj8o9SnfM+YxQQ7/I
         TiY0nkKNn57qdftQnyD+G8cmAP2qy7XgqvCVLkrzK40T/NvrbKEOCoGEZEI0IMpQLMqP
         HvZw==
X-Gm-Message-State: AOJu0YwGt0kXM5byTF/Xtp6Q1aiKUYR8fmA2d6PiAn+2XfqqIy1Ncrne
	y9QUxdlnHr28lyItZEYlKytBIcAaFBO9RwIH77XsW1Z8crCJstnujdERBgNDvyii444=
X-Gm-Gg: ASbGnctSPRL1zAYyn3XGPqBMKJUmj4F417DA7vsKpGg0Sgx9aFuh6J12aUe2Owk/34j
	yd0+OGCQoQNPMd49uUB3Sl1qtsLGZSYLR8Hx6fxhqe82mOF0PFS5MCbJHsqvwjVjXXJ/NC5j7Kj
	FDBGF/NDXmx2Qj096ShBOsmH+G5o7OYyi/g2FMKWygggIMmlHCaI0E4ahTF2rdkqzid1mxu3zfV
	PLw9F1R1QW1NVbpsEQh4u8ZQXNHCPHMilGs/S/INsU0ZoxIbsaUK6/7nKNrLvsQa48U40RQNXjp
	rq8QH96Iy9vtURvnmEuJ2dnFi9mCCR+10KmwiR3+8wiKyEwPT4zPxjLZdp9FVNjj8fsyRsrr9Ea
	G1C7//2Vs10VL9JXKKuPTw0B3nSwKQLA6/zs794T2sB50ZRt6EYEhriglehy3JR4SI9S3/vYlqC
	21OTkeQOrgeStvN32vIK6u7HV964bEi98KB4I6fujC0xzo/3XOIQI=
X-Google-Smtp-Source: AGHT+IEq0NtBB9os8AQrwNuf6RMTKhTbnzYUGptUR5F6h/jQOa3dSLBo8JhgapieccnR/IZAc9uxSA==
X-Received: by 2002:a05:6000:2382:b0:427:151:3db6 with SMTP id ffacd0b85a97d-429bd68384dmr244092f8f.24.1761842624150;
        Thu, 30 Oct 2025 09:43:44 -0700 (PDT)
Received: from fedora (cpc92878-cmbg18-2-0-cust539.5-4.cable.virginm.net. [86.16.54.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429952df62dsm36796839f8f.45.2025.10.30.09.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:43:43 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [RFC PATCH 2/4] mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
Date: Thu, 30 Oct 2025 09:43:28 -0700
Message-ID: <20251030164330.44995-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251030164330.44995-1-vishal.moola@gmail.com>
References: <20251030164330.44995-1-vishal.moola@gmail.com>
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
index b86c36d51833..76c060ef2bf7 100644
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


