Return-Path: <linux-kernel+bounces-863613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE10BF84E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B8D1881461
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1503269806;
	Tue, 21 Oct 2025 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0e4Qg8K"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D48350A3E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075976; cv=none; b=oGPJG77FL897vfc8szPGP9uh1IpKsFg3o8T927Iro7epbFOAgbRL7AVOc/8EysyiFrmdFlS7W8pjuG1VBk9Y6TgFX0Rz6l9AWazaI1chZTYXHWErfdb3Hck+zrtXLSkiNAuveTCqERYrO541qbDt9zWKFPydEgio7SN/BQodOt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075976; c=relaxed/simple;
	bh=oAPvmMHGaBgcFmNYeH5VWaGSTpXmRxKwhtO8zmzCzTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GpBNkwn7/SX/eBQTmF4Zi4LohQFCwFc4TEHp0jrbxSxNchvjAxxB3w62tHPz3sMqF+vfV/9+yj38S478RwknhDttbdG+vQEi65wNdTkdYO6z3qbrIooUt8URoMx6DQ5Cvz/eB0kQW6uDyQpkUxfglGyJvncGOlrCMwhX5fmGWvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0e4Qg8K; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee12807d97so5651999f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761075972; x=1761680772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qFcHRErR3E6NpM+7IUll+f8tDVmMlaLL6Mv+17zBFxY=;
        b=A0e4Qg8KN3XSIfyQ/q3n/BdtdCZjyjHtaKxN6eZroz5Fp7SQNDzxxZIntxaXSIhgCU
         m3u4VurqlN9+6OzIJhEiZQ7kFBEBgCclQMKjdO4Lrj18JR7zO+u0yzFiMzGw78E3WukY
         9bOFvh4ABeaiCMy4M5OYRY+BxQqfZCeCuvyftAah3TwCDMFpo0E6RdsaYyKVR1zNFJ2s
         OL4RitIT1vzkhTGeBpSsNTegXOiMnO38vlQfR9ofaCqyKdbrdwP7EMAUVHokIpUe+UtC
         1cPDk+gTSCfcrfDK4ce9QgOV2AVLKsL3tcKf5dDfBNzFb4WaXGvSN79Q0h+YVbEmjyNE
         5GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761075972; x=1761680772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFcHRErR3E6NpM+7IUll+f8tDVmMlaLL6Mv+17zBFxY=;
        b=tJ84TAARCmx1ZzB/66Ri+SKMalP7yNmtA81lkutfZmUbHEl/0cZWmMS80Nr2OMQAfG
         YPaNhxdW45puhzl9iPRhQ4JMR3i2YfdMCHkr391X+SjJm4XhR8nR595088jsk/wTLrBj
         uc1l/OiO0ZVqGN1dGqD+XtjtVD0fQp4qbY1sRTMTxfR4SvL8Ps0WEJ/vZTiPUVqHq9mw
         Up6tgIQvp3m8cKJqznc/ReuskMO3WjR92puSI9xlhmaL8ROW0/LdZnWxnb46xvPUmnLJ
         58mkrasuuuw5bTWyNydGU0MssChf5Gy0QFs160WUY8Qhj2uoP/lFv+giKy3NudowrLyC
         yDfA==
X-Forwarded-Encrypted: i=1; AJvYcCWFJecMyUQvWpp8+1khFsB+ubOUj16NqrOQX5sy9bZvl0gkMj/isPkqts7MgMKRKMiQtFy+0T/vKh2oIIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdwDNPvlXD8k6Tpm1KGzKiWyhzCuwcuZPuPg2HFMPmF4r1B6I6
	0+Zwts0RJTB3+0GKHtI3lVDkeP98mzHXAqOfW8mL6KPhlv+oJPCZcQN3
X-Gm-Gg: ASbGncvptDmETNWxoaxFRfc1vOJTDljQDRGmE2iIPavyj0Ok/sAonvMfTuIDefdp6zb
	dN4BQ4LSwmzZnTtJkBBMKyB6ksU8ilvgbfx9xDWig6oG91YTrNwg+1RhOreGJrB8GHYJygShTZM
	KzWHNOGK1sS7XKEdLS9hdPy2e2ywB9l1P4b7cjsBoLuG+A29YK8jL+DBQ3CJjdiAhX7lRS/mux4
	FGCU24LJ1BoyzocduQVWxmBzRjmOobxVTaRdZNEsUULDeMYGHv2M/t7KQS6ikWApdybIrtF6voM
	a9vndRH8hdF+HBimMbZ7Xtc1riMzFEOV9hdIVuKahBhcmELrDgbGr4FterlMPWvNXzf9wIFNiH4
	iTsEZN/e8pwtMz+BNcMs8ncun5TPC8evpio0c+ScF3YIgT53nsisLzCsx86vN0nlU7IFFXN96vs
	QA8LUUMJhKSn+CWnz+Y/iQBQ/vRgvfGWLjsYhV5svg9w==
X-Google-Smtp-Source: AGHT+IGa66oK1Ku/F3PiZN50n0zTqmr5IA7b19DfK2SzeLpd1kEHYq8mnoX0k3rpIbXU5X4W0Hzr1w==
X-Received: by 2002:a05:6000:2005:b0:427:9d7:8715 with SMTP id ffacd0b85a97d-42709d788b9mr9713022f8f.34.1761075972252;
        Tue, 21 Oct 2025 12:46:12 -0700 (PDT)
Received: from fedora.customer.ask4.lan ([31.205.15.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-427ea5a0febsm21667227f8f.6.2025.10.21.12.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:46:11 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH] mm/vmalloc: request large order pages from buddy allocator
Date: Tue, 21 Oct 2025 12:44:56 -0700
Message-ID: <20251021194455.33351-2-vishal.moola@gmail.com>
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
	real    46.310s			real    0m34.582
	user    0.001s			user    0.006s
	sys     46.058s			sys     0m34.365s

10000 200kb allocations:
	[Baseline]			[This patch]
	real    56.104s			real    0m43.696
	user    0.001s			user    0.003s
	sys     55.375s			sys     0m42.995s

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

-----
RFC:
https://lore.kernel.org/linux-mm/20251014182754.4329-1-vishal.moola@gmail.com/

Changes since rfc:
  - Mask off NO_FAIL in large_gfp
  - Mask off GFP_COMP in large_gfp
There was discussion about warning on and rejecting unsupported GFP
flags in vmalloc, I'll have a separate patch for that.

  - Introduce nr_remaining variable to track total pages
  - Calculate large order as (min(max_order, ilog2())
  - Attempt lower orders on failure before falling back to original path
  - Drop unnecessary fallback comment change
---
 mm/vmalloc.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index adde450ddf5e..0832f944544c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3619,8 +3619,44 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		unsigned int order, unsigned int nr_pages, struct page **pages)
 {
 	unsigned int nr_allocated = 0;
+	unsigned int nr_remaining = nr_pages;
+	unsigned int max_attempt_order = MAX_PAGE_ORDER;
 	struct page *page;
 	int i;
+	gfp_t large_gfp = (gfp &
+		~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL | __GFP_COMP))
+		| __GFP_NOWARN;
+	unsigned int large_order = ilog2(nr_remaining);
+
+	large_order = min(max_attempt_order, large_order);
+
+	/*
+	 * Initially, attempt to have the page allocator give us large order
+	 * pages. Do not attempt allocating smaller than order chunks since
+	 * __vmap_pages_range() expects physically contigous pages of exactly
+	 * order long chunks.
+	 */
+	while (large_order > order && nr_remaining) {
+		if (nid == NUMA_NO_NODE)
+			page = alloc_pages_noprof(large_gfp, large_order);
+		else
+			page = alloc_pages_node_noprof(nid, large_gfp, large_order);
+
+		if (unlikely(!page)) {
+			max_attempt_order = --large_order;
+			continue;
+		}
+
+		split_page(page, large_order);
+		for (i = 0; i < (1U << large_order); i++)
+			pages[nr_allocated + i] = page + i;
+
+		nr_allocated += 1U << large_order;
+		nr_remaining = nr_pages - nr_allocated;
+
+		large_order = ilog2(nr_remaining);
+		large_order = min(max_attempt_order, large_order);
+	}
 
 	/*
 	 * For order-0 pages we make use of bulk allocator, if
-- 
2.51.0


