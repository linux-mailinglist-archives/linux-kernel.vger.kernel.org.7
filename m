Return-Path: <linux-kernel+bounces-687843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 614CAADA9E9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 09:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4B318840C5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 07:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4C2212B38;
	Mon, 16 Jun 2025 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TlQxslvx"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4B202F83
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750060402; cv=none; b=D1yAVvZvKoKJK9ZX761jVOHHAj5D81C3Byg5r+zDIknxVcLjyMEGe3uZTkp3k9Y7iWu8fQ4efoM01WbSB0qVxLF+Y1xR54XQ8xrhPm5xlgBzeBJfuHXp5Lq+JDleAhqpsfJoVuybkeKdV9Mp5PqRDlJXdVaK6UNYiVT9oyoKegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750060402; c=relaxed/simple;
	bh=O9FzMl/0pLM8ITXzRkwIuDxtoPR8E1WLSspFa0GpXdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTDRTqFIDopUxxDcmMAi1v4a9OLZyGNdzGVK2nWSchPZAInUGXkUZ7Vzok7+rJ7lWHea2L342NHr3P6o39/OUNCNCizLLlicz0hql9/qymVdEcMuIFUj/1OYLirHvQ2yElK7Omy+KGCmBAYHAMgYi3db6Ma/nP66r1JJHzvx2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TlQxslvx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234bfe37cccso52194895ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 00:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750060400; x=1750665200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjKN4DuCSz3Sv5u8siSrsq6cRZWJ/q7Cflfq198rGjM=;
        b=TlQxslvxb4hr0GJ3Igj9Dljqrve5M8zbKrQyN+gLorTIwjyA7fAM5msv+R7llpmv1G
         UzVIWL2l2y4ApeoKW5nwRZWwPwyMOFbTWbpGXWQ3v4+wvi3fWz8wvB9MIOatBWAR8KO8
         NsRxclJ3H8jWsPYD1VEOSk0D5W6oS43kNdK+J3Z7L11fkS+iYq/E63RG7zMEXq3pFGYJ
         zv/3llZtm0T7+Gb+oLkM0S1Si1NQiKEl29E07NuI/aV5b23UW5SePmSy1VjVaVUJl0Pf
         YEhPLUImz2ti0pukhW09WEwZvAl8cJtJNVXOlmKbyS4amvBZK37yMHz3N8bSQBT3tZUI
         TdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750060400; x=1750665200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjKN4DuCSz3Sv5u8siSrsq6cRZWJ/q7Cflfq198rGjM=;
        b=WfVucyq6DJVlzeSIJljBHkwFU0xglON7oNPfXokg/xQxozJVnS+NUXzwuqjqpTiyjo
         wlMkExAlIG/t4A1+w3bTv1RasOCFujSIv0mn4PFPYF7LQNC/XkTgx8SC8fXO5RguqJkI
         w/tl/lK/Tun/uDCTpo2GdQFGoGm+XYLQSRVWvsmboew4iXSnUhbdE0oSxhIYYxU/7+9/
         440P4m61TK0PxrMFlGZfzN8exSlyTQ8EDoQZCfpbTVGlVR1mZLnSFBBNgpB1F/cjQgIo
         rRVmmAj1QuDgNgpjK8o2yPSUWiJ4Wq2zhw5ML9frqBrgu0n2FMcqFngg5e69aFXz14TZ
         rgYA==
X-Forwarded-Encrypted: i=1; AJvYcCXZCfAqF5fDRFv6LfrW66AgEEVUFM7Aj+GwVJHXc7i/vhpws2oqAPm9Rv5BmM7a/jYw/pCwgpAmoW/yVUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+9scMb/C87/L2vxxvRb5DDkm4GeV2ViaM+6Xh2LhUgmarhp/
	Dpul+mosr+iRlwiSU+6YGqU+noSy2759ViBhq9udR6W1OZcuTFCP97gLe7Ylnda4UEM=
X-Gm-Gg: ASbGnctQDCeV6ExZ8NZLJNgz9lLBN3FGsTekWKxkFz2qnMI1TcKwFPohhUotNMrGr3E
	8GiaokLpA2fgLVP4A66G+jemb1BloAnhaojmQTfdzOPCVGmc/2HsFUaZySJX0ZcL/sHv4dEpwpb
	9zK9WX4rFXrfEqTgPExBqFIFVYzj6MU4UzhTrIhJKczdyN5ZAMFzy/jPRiPxvCisSLLf45wz0Js
	fzGWsRkzt3bbgK3M51S4U1do8KLlxN+gYFo9LDTZ6ccyj6Rq9SHCpDdAgv/T+RuVZ2moSZBA9CD
	E4BU7WNW6M1UWYgnx2oyawwxj0N42/LgzO5Gs0HdbP4kdqfwjs+w/naIR3+MK6DCccKUsEeHoEZ
	2yOtje+AKLwmiZw==
X-Google-Smtp-Source: AGHT+IFknmeqFqjZM8iA+jzGoB5DpwsgBAGmaUTgoZHwqKSE3woXG3/0u4QyOP/kvX1A5HmBrIvWSg==
X-Received: by 2002:a17:902:900b:b0:234:f4da:7eed with SMTP id d9443c01a7336-2366b17b673mr99674185ad.44.1750060400021;
        Mon, 16 Jun 2025 00:53:20 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88be76sm55179045ad.32.2025.06.16.00.53.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Jun 2025 00:53:19 -0700 (PDT)
From: lizhe.67@bytedance.com
To: alex.williamson@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	peterx@redhat.com,
	lizhe.67@bytedance.com
Subject: [PATCH v3 2/2] vfio/type1: optimize vfio_unpin_pages_remote() for large folio
Date: Mon, 16 Jun 2025 15:52:51 +0800
Message-ID: <20250616075251.89067-3-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250616075251.89067-1-lizhe.67@bytedance.com>
References: <20250616075251.89067-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Zhe <lizhe.67@bytedance.com>

When vfio_unpin_pages_remote() is called with a range of addresses that
includes large folios, the function currently performs individual
put_pfn() operations for each page. This can lead to significant
performance overheads, especially when dealing with large ranges of pages.

This patch optimize this process by batching the put_pfn() operations.

The performance test results, based on v6.15, for completing the 16G VFIO
IOMMU DMA unmapping, obtained through unit test[1] with slight
modifications[2], are as follows.

Base(v6.15):
./vfio-pci-mem-dma-map 0000:03:00.0 16
------- AVERAGE (MADV_HUGEPAGE) --------
VFIO MAP DMA in 0.047 s (338.6 GB/s)
VFIO UNMAP DMA in 0.138 s (116.2 GB/s)
------- AVERAGE (MAP_POPULATE) --------
VFIO MAP DMA in 0.280 s (57.2 GB/s)
VFIO UNMAP DMA in 0.312 s (51.3 GB/s)
------- AVERAGE (HUGETLBFS) --------
VFIO MAP DMA in 0.052 s (308.3 GB/s)
VFIO UNMAP DMA in 0.139 s (115.1 GB/s)

Map[3] + This patchset:
------- AVERAGE (MADV_HUGEPAGE) --------
VFIO MAP DMA in 0.027 s (598.2 GB/s)
VFIO UNMAP DMA in 0.049 s (328.7 GB/s)
------- AVERAGE (MAP_POPULATE) --------
VFIO MAP DMA in 0.289 s (55.3 GB/s)
VFIO UNMAP DMA in 0.303 s (52.9 GB/s)
------- AVERAGE (HUGETLBFS) --------
VFIO MAP DMA in 0.032 s (506.8 GB/s)
VFIO UNMAP DMA in 0.049 s (326.7 GB/s)

For large folio, we achieve an approximate 64% performance improvement
in the VFIO UNMAP DMA item. For small folios, the performance test
results appear to show no significant changes.

[1]: https://github.com/awilliam/tests/blob/vfio-pci-mem-dma-map/vfio-pci-mem-dma-map.c
[2]: https://lore.kernel.org/all/20250610031013.98556-1-lizhe.67@bytedance.com/
[3]: https://lore.kernel.org/all/20250529064947.38433-1-lizhe.67@bytedance.com/

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 drivers/vfio/vfio_iommu_type1.c | 55 +++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index e952bf8bdfab..09ecc546ece8 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -469,17 +469,28 @@ static bool is_invalid_reserved_pfn(unsigned long pfn)
 	return true;
 }
 
-static int put_pfn(unsigned long pfn, int prot)
+static inline void _put_pfns(struct page *page, int npages, int prot)
 {
-	if (!is_invalid_reserved_pfn(pfn)) {
-		struct page *page = pfn_to_page(pfn);
+	unpin_user_page_range_dirty_lock(page, npages, prot & IOMMU_WRITE);
+}
 
-		unpin_user_pages_dirty_lock(&page, 1, prot & IOMMU_WRITE);
-		return 1;
+/*
+ * The caller must ensure that these npages PFNs belong to the same folio.
+ */
+static inline int put_pfns(unsigned long pfn, int npages, int prot)
+{
+	if (!is_invalid_reserved_pfn(pfn)) {
+		_put_pfns(pfn_to_page(pfn), npages, prot);
+		return npages;
 	}
 	return 0;
 }
 
+static inline int put_pfn(unsigned long pfn, int prot)
+{
+	return put_pfns(pfn, 1, prot);
+}
+
 #define VFIO_BATCH_MAX_CAPACITY (PAGE_SIZE / sizeof(struct page *))
 
 static void __vfio_batch_init(struct vfio_batch *batch, bool single)
@@ -806,11 +817,37 @@ static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
 				    bool do_accounting)
 {
 	long unlocked = 0, locked = vpfn_pages(dma, iova, npage);
-	long i;
 
-	for (i = 0; i < npage; i++)
-		if (put_pfn(pfn++, dma->prot))
-			unlocked++;
+	while (npage) {
+		long nr_pages = 1;
+
+		if (!is_invalid_reserved_pfn(pfn)) {
+			struct page *page = pfn_to_page(pfn);
+			struct folio *folio = page_folio(page);
+			long folio_pages_num = folio_nr_pages(folio);
+
+			/*
+			 * For a folio, it represents a physically
+			 * contiguous set of bytes, and all of its pages
+			 * share the same invalid/reserved state.
+			 *
+			 * Here, our PFNs are contiguous. Therefore, if we
+			 * detect that the current PFN belongs to a large
+			 * folio, we can batch the operations for the next
+			 * nr_pages PFNs.
+			 */
+			if (folio_pages_num > 1)
+				nr_pages = min_t(long, npage,
+					folio_pages_num -
+					folio_page_idx(folio, page));
+
+			_put_pfns(page, nr_pages, dma->prot);
+			unlocked += nr_pages;
+		}
+
+		pfn += nr_pages;
+		npage -= nr_pages;
+	}
 
 	if (do_accounting)
 		vfio_lock_acct(dma, locked - unlocked, true);
-- 
2.20.1


