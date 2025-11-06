Return-Path: <linux-kernel+bounces-889045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE3CC3C8D1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 005364F2221
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6720C3491C9;
	Thu,  6 Nov 2025 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l21vwygq"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30184346799
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447215; cv=none; b=k2h6v/omXRUu0Ucd6N8e4PTaeWGYtpd3Mf7gEYlwQal5Yw6CRjR7HTg4pfyKZxA0a8v/mdwKSqUkJOpC8B7xytpdNdGCGa+62uG5EZWHOGOiYgRJ19pm/lhx8v1013+9c2XUc73WKy5j0SMFUWcqx2yp6flVHeENln6nskd9iaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447215; c=relaxed/simple;
	bh=YwTj3xPUl5UlBDRODGhVqQxa9CgJ+NfuerK8zGcP/W8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y9yC23egop8uwtYmhQOtNcYoM4Jkr6ZWgjwaZBvuYT6qzZ/n9lMrm87SDS2B3WWJrlHoisaPSDYcyuCLh96+S6izLrUk9Wy52njq+9zgkqaXwtPbh99haH8TPg0HJ0oIED0ctXvImwT+e27poVuDJuYX0DJ5TggaV9O5Ykppfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l21vwygq; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429c76c8a1bso868257f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762447211; x=1763052011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1MuGWRmebEyeJKEBuBok+7/p5tCLW5lhor0NHCb2aik=;
        b=l21vwygqxJCC3adJzkhXiBTTp7wrmjQyT4WPNlh9SFWiXY0gogHsn+CGo1EhtgorCc
         D6NIlaitgGg0rCTwKDwzFNgdfB7/LZMZv++Q20q3uTx65v3O+U/FNbxtNG4mVM7WnDic
         ZPIZavbN1sEYzH08N/ot6rBWfmVXibWkVXeliWzTH7C34zYtLOlH84y5dBDS5UQr5fdO
         Z02Y3s5xAgsUhIH+4LFoOw0usTKk6Tdj/p95KUcP4jLMO6zBpr2yVlV/S928iPMiGJZj
         34DiSMqDbuBpyjdbIrjFELmId+W4+mrnj3a2MP7c9yuje1q7Q8ZoWkpErgwa4aG6hkj4
         41Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447211; x=1763052011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MuGWRmebEyeJKEBuBok+7/p5tCLW5lhor0NHCb2aik=;
        b=VL37zYrBNTKSw3RGyfQzoJUWaQ1nDjWY08slf7ntRtIlxruSGTsgAtcL0G9IY+Jegk
         E12OSKTL5jBjWrwAkiS5z8TLNSNWcujdQQ6qrnhfOMxkM46NGkupa6lJbTiKEFo4GTGe
         dryqdHPWh+lAHrf2jJX5fx68m305BEOpoKtpfdOpwjTo7SJlKjw2EhNetazIW+kPo521
         xXS630lVPSyKTzu/n/TxpwA46i0xq1aUK/qsWCq9g2R3tw6zs1wqzYbVAwzL+3U4PhFb
         sdAEYTtyb6QPA0qk/hsdMnTlKzytU4/GOpwlsaH43O3TkPbC0F934ns1QOkNBxLrD5KR
         da6g==
X-Forwarded-Encrypted: i=1; AJvYcCUosH03v1RxCLy3k2m3Gwz/UQCeWCg4Rm3t7o8JwCOtmrHf40aPO/jIDwgMnTbS3u8wQLJ5P1DuRvCDirg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziJ5qK+o5K4uiP6humOTqsb7AawCQj7jhKhSTnHOn1DAoVoy0M
	ICwMooXscJQSqk1IT7RsHm6WCYjUbc5EI9FvhJTEqqSbnlcl4p26uCnysSZpjUqbYuEZ+YmVJbl
	IBqMQXsjorHMRWw==
X-Google-Smtp-Source: AGHT+IHysWr4kZOr+q4Pq/IsxPJWwhd0Upf8H/2toPB1V7pns+GJ5i8QYBGBp3tQwp2KTNC96A5o74tpeTcSWw==
X-Received: from wrf23.prod.google.com ([2002:a05:6000:43d7:b0:429:eeb3:9047])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:220c:b0:429:d4e1:cb9d with SMTP id ffacd0b85a97d-429e32c879dmr5734101f8f.8.1762447211597;
 Thu, 06 Nov 2025 08:40:11 -0800 (PST)
Date: Thu,  6 Nov 2025 16:39:52 +0000
In-Reply-To: <20251106163953.1971067-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106163953.1971067-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106163953.1971067-4-smostafa@google.com>
Subject: [PATCH v2 3/4] drivers/iommu-debug-pagealloc: Track IOMMU pages
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	Mostafa Saleh <smostafa@google.com>, Qinxin Xia <xiaqinxin@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Using the new calls, use an atomic refcount to track how many times
a page is mapped in any of the IOMMUs.

For unmap we need to use iova_to_phys() to get the physical address
of the pages.

We use the smallest supported page size as the granularity of tracking
per domain.
This is important as it possible to map pages and unmap them with
larger sizes (as in map_sg()) cases.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 74 +++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
index a6a2f844b09d..0e14104b971c 100644
--- a/drivers/iommu/iommu-debug-pagealloc.c
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -27,16 +27,90 @@ struct page_ext_operations page_iommu_debug_ops = {
 	.need = need_iommu_debug,
 };
 
+static struct page_ext *get_iommu_page_ext(phys_addr_t phys)
+{
+	struct page *page = phys_to_page(phys);
+	struct page_ext *page_ext = page_ext_get(page);
+
+	return page_ext;
+}
+
+static struct iommu_debug_metadate *get_iommu_data(struct page_ext *page_ext)
+{
+	return page_ext_data(page_ext, &page_iommu_debug_ops);
+}
+
+static void iommu_debug_inc_page(phys_addr_t phys)
+{
+	struct page_ext *page_ext = get_iommu_page_ext(phys);
+	struct iommu_debug_metadate *d = get_iommu_data(page_ext);
+
+	WARN_ON(atomic_inc_return(&d->ref) <= 0);
+	page_ext_put(page_ext);
+}
+
+static void iommu_debug_dec_page(phys_addr_t phys)
+{
+	struct page_ext *page_ext = get_iommu_page_ext(phys);
+	struct iommu_debug_metadate *d = get_iommu_data(page_ext);
+
+	WARN_ON(atomic_dec_return(&d->ref) < 0);
+	page_ext_put(page_ext);
+}
+
+/*
+ * IOMMU page size might not match the CPU page size, in that case, we use
+ * the smallest IOMMU page size to refcount the pages in the vmemmap.
+ * That is important as both map and unmap has to use the same page size
+ * to update the refcount to avoid double counting the same page.
+ * And as we can't know from iommu_unmap() what was the original page size
+ * used for map, we just use the minimum supported one for both.
+ */
+static size_t iommu_debug_page_size(struct iommu_domain *domain)
+{
+	return 1UL << __ffs(domain->pgsize_bitmap);
+}
+
 void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
 {
+	size_t off;
+	size_t page_size = iommu_debug_page_size(domain);
+
+	for (off = 0 ; off < size ; off += page_size) {
+		if (!pfn_valid(__phys_to_pfn(phys + off)))
+			continue;
+		iommu_debug_inc_page(phys + off);
+	}
 }
 
 void __iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
+	size_t off;
+	size_t page_size = iommu_debug_page_size(domain);
+
+	for (off = 0 ; off < size ; off += page_size) {
+		phys_addr_t phys = iommu_iova_to_phys(domain, iova + off);
+
+		if (!phys || !pfn_valid(__phys_to_pfn(phys + off)))
+			continue;
+
+		iommu_debug_dec_page(phys);
+	}
 }
 
 void __iommu_debug_remap(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
+	size_t off;
+	size_t page_size = iommu_debug_page_size(domain);
+
+	for (off = 0 ; off < size ; off += page_size) {
+		phys_addr_t phys = iommu_iova_to_phys(domain, iova + off);
+
+		if (!phys || !pfn_valid(__phys_to_pfn(phys + off)))
+			continue;
+
+		iommu_debug_inc_page(phys);
+	}
 }
 
 void iommu_debug_init(void)
-- 
2.51.2.1026.g39e6a42477-goog


