Return-Path: <linux-kernel+bounces-725260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D467AFFC86
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25ECAB418E3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0D328B519;
	Thu, 10 Jul 2025 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JqbaVEmS"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B6224B14
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136721; cv=none; b=m0SES5cSVIkhPdiX4Cor8/woC3o8C3Z+px82YP4uXP+yhSIcXs7/bikmJObodZ13HWj7HnevE94HlPeBaHde51xSHE4qFPCiLwaYE+32QMHTPu2SRCSQFdOfdNR9VkRAZX1Ga/Ej1sZhsDd0EI4oHVNidbK2XNn0Ma95SVmSlkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136721; c=relaxed/simple;
	bh=iPTSG8rWX5/aMDwwlMBzG13CC+5ujaQ3LSalqG4mVLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrfLmlmfs0NjrBqQ3z9g6m8CE6HCQ5ssAuJr9U/wOtSQip+dqRhdhv0FEfKQvIoDsDnQhZLDBtMgsimB5GllVXOWchm+X6eN6smFLW2SY4HqxiM0UJesu3hOlJhqvpAHCPDMIGa3VOASnyp7SKCQf/RWdc2HMCPjvsPC+fX4+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JqbaVEmS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4e62619afso39271f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752136716; x=1752741516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AsOzu/Shb8U/5A8M6vSewxAHPdIcygl1ZysXscFwvaU=;
        b=JqbaVEmSS7Y3UXpAlxqwopo/eQKoCtHQYFUXalnyKyihntyXS+xTYG6iKYNOFF/xOY
         iO5hRhbwwmcIMuMl0XXNxsi8czJ9fjEEtxfVbgGpovdQ6habQLvqwHjV9RkWIgAXYsZD
         voOPLQToiFiq2cC8bxHTGU6h/gjWeCERUIyNoGacPH0z6h2QuF4ipfUmwZOkxYvOnfv+
         mJsuj8IH6gZ0JE8RizAwWy8DgZQGJU6zWYnBMZQB64OLOC7uBJQJsa9Qz98gdVOYErX5
         K1fv4ii0WSnAg8HHu4usXF39B+NJ+RqXWnhwEm0wyPCqkN1RDA2sKsJud0SxrDn26nFz
         bLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752136716; x=1752741516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsOzu/Shb8U/5A8M6vSewxAHPdIcygl1ZysXscFwvaU=;
        b=QThdRFlRYO2oF98y1V7298He4fd/iXPSyEP2EksA5jgNmJZCs/bV2fTUtrdhkoAlkL
         O8ueIAAGPtgMzG6ZJMPkXE8WlKCkoqYPG++t7GCzWppxLOki/jU58WZII6M0zAnsglxu
         qrg6qgPCDkplfjuxtiPpPzbZkYteu5pTEY24aCyGYbMU6KPF9r1qIG1fU3ortzq77VDq
         tvckiysAqog8jtdHk8srfKnNhOflgYe76Yq5Ug1TNEceX9XnjvvcAmiJAlAYisHAFDIv
         AuxCk6j/2x3+GlzxFEFj9/WHrzX7fkQs5lZYPf2oQSWfZuhx25OeL3Fra8P7ZxGIyBy4
         bMvg==
X-Forwarded-Encrypted: i=1; AJvYcCXNKCtOv/DyMxjskxrIRcGdkr4C+mc2EfaUdd6fagey49BmRpXyCQYjzUzdpWJbXltY0MIPGMCOgUfQgW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2APguayNmxds7uqk2iTxrjEwl8Ezrw0tsQ1oi/QKU2X5TTIGT
	VfiCOdvSCxrQ2Fa1M9ll80q8ALQ18LUX9Gieibj6SMwZD8ECADl824C50QbuDSUwsIw=
X-Gm-Gg: ASbGncuW3NuPwIq1fFKCIlsLF/7gcSOPTcn7GCa5uE4cIY9NAqtq57dOTwD+5sP+yxW
	CNzmd0MR7GG8zKNlZTG4BwXqABtlQ1yKHVgQIekAjCpV3P3CH4xEZh0fi5LGzB/Ilnj4zLKQqpP
	C49iIkyvxPNzvvTKvJtozZs/LXkHECgiyytuXEVavVwLrzhvWdn/tlnwtRDS2dbIpc4INxuMc6T
	NpUQ47p3ktLpCh8JVvm4LZreFvI19IHF13mctu6miLINgnhrfXF0Ty/9fDCafF22xqdCEoiDdnQ
	7NTHSrTC1NaxVY1842YmR9yzeM/YcLzA4AtX2BHX0KHptrIjJiI6bqmluLARyDQMQe+Ew5AZwDu
	gZE3a9rM/YzyNS1itVM+cr79XuNjpmmooiH8fMR1ajDle9aaVm3CF
X-Google-Smtp-Source: AGHT+IHjCyeYWj52MzibDcNe6h6uxoz7typzxZX5pbdy/ikZ9QMY/8GfHCHLtrwQvn8P5u6F0KuPsw==
X-Received: by 2002:a5d:584e:0:b0:3a3:584b:f5d7 with SMTP id ffacd0b85a97d-3b5e45114b1mr1462475f8f.5.1752136716324;
        Thu, 10 Jul 2025 01:38:36 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-b223-ac12-b926-9872.ipv6.o2.cz. [2a00:1028:83b8:1e7a:b223:ac12:b926:9872])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454d50df5a1sm51191525e9.22.2025.07.10.01.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:38:35 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH] dma-direct: clean up the logic in __dma_direct_alloc_pages()
Date: Thu, 10 Jul 2025 10:38:29 +0200
Message-ID: <20250710083829.1853466-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert a goto-based loop to a while() loop. To allow the simplification,
return early when allocation from CMA is successful. As a bonus, this early
return avoids a repeated dma_coherent_ok() check.

No functional change.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 kernel/dma/direct.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 24c359d9c879..302e89580972 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -120,7 +120,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		gfp_t gfp, bool allow_highmem)
 {
 	int node = dev_to_node(dev);
-	struct page *page = NULL;
+	struct page *page;
 	u64 phys_limit;
 
 	WARN_ON_ONCE(!PAGE_ALIGNED(size));
@@ -131,30 +131,25 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
 	page = dma_alloc_contiguous(dev, size, gfp);
 	if (page) {
-		if (!dma_coherent_ok(dev, page_to_phys(page), size) ||
-		    (!allow_highmem && PageHighMem(page))) {
-			dma_free_contiguous(dev, page, size);
-			page = NULL;
-		}
+		if (dma_coherent_ok(dev, page_to_phys(page), size) &&
+		    (allow_highmem || !PageHighMem(page)))
+			return page;
+
+		dma_free_contiguous(dev, page, size);
 	}
-again:
-	if (!page)
-		page = alloc_pages_node(node, gfp, get_order(size));
-	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
+
+	while ((page = alloc_pages_node(node, gfp, get_order(size)))
+	       && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		__free_pages(page, get_order(size));
-		page = NULL;
 
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
 		    phys_limit < DMA_BIT_MASK(64) &&
-		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
+		    !(gfp & (GFP_DMA32 | GFP_DMA)))
 			gfp |= GFP_DMA32;
-			goto again;
-		}
-
-		if (IS_ENABLED(CONFIG_ZONE_DMA) && !(gfp & GFP_DMA)) {
+		else if (IS_ENABLED(CONFIG_ZONE_DMA) && !(gfp & GFP_DMA))
 			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
-			goto again;
-		}
+		else
+			return NULL;
 	}
 
 	return page;
-- 
2.49.0


