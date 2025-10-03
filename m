Return-Path: <linux-kernel+bounces-841587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71764BB7C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD5C4A343B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D042DCF58;
	Fri,  3 Oct 2025 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yUuZG1AP"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444CC2DC335
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512772; cv=none; b=U2/Yqy/QToTeO7Dals41jTchVH27HAqznPAjMYsouV846k3r7fgCTvVWvPyMEieqFFryBf9jGS+6D/5ylqeJRRngfsV40cUeRkyDw5Gj14y4/1Au8xkBXi1/F7twkjn8Pli+euGjeYnR82iyuJrmRLDVjx2ni4Xf9BGL2fhsgtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512772; c=relaxed/simple;
	bh=yI6VMn+rJIop9uglbD/KsbP7syNK0e5JT3wJcuKCcIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KCx28hNmXOdvFSBzOhBi+/VpY5i/+PSEAg2UssNIrtYL9qVL9Kk9w7/cdb866Vw43v62Pk5KcL/DmVEZYwi7ZN9kndG1TNpGCXsXg/JVWvG3wRFgfetsCceC3mbyDQ8MH624lkEdYcfe5rBCuemyhPyQDcx6d2Zg8f+0c/omXNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yUuZG1AP; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e4943d713so18227735e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759512768; x=1760117568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgDVF0Sn62dc4Fy33aQ885t/YxSjHp9XC3s20FTM60M=;
        b=yUuZG1AP+P1tvwByN5zKPtBVgY1tEx/0R9eeo74TwaVAFRiB8JTv6HUtmLjempE93O
         vTVKVASwjtJUbZEuyA+Rvtvq9zsEx2WhY9LqS8+GefZvNhOcaqB3Oebkf09zz8aiJ1lK
         tbIK542vK0W1gi90ujvg4sLQz7yb83KySy9sFPGxQPvrrU0TTi7Zn2EdfCyOj3/veE46
         WRMzNyX/Bg0tpmc5ZX8YByMJzesoIKEmbSyCyHWH4mK+XB/LaeMBiigZMDpcSdXvoogV
         LQdP7Z13q2/lAO3QSQUcMbPUIdXVzT42PYfwLQmV7lqQZRKCx+kDFa+ae/2+k5XGLMeq
         VezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512768; x=1760117568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgDVF0Sn62dc4Fy33aQ885t/YxSjHp9XC3s20FTM60M=;
        b=f67xcmJSci7WYyptk/X7Rj8WxCGViYUbXFvNlfTMQo4pBrcoEeGJke4JU0vSy55Fmf
         M+8qZ3jfq8RVLaKwRmmlWYzzs9Rcixbi732SdjBFCUlrWGa7ghyt5hFZsEQ0uicuDxTJ
         hEEuhe7Cr3y8kXTgJpJWmtRC1zwfqP+XkoGFXck5p7jCsK1bKJ2fLgkiCKJLdNrhIL4P
         yQXvR3h6klXnB/+MZG7ZJTpMWdOjLHF5yDqhBYkg9/znEeeaGznOr/FtEo47DtxFNn59
         2IEb8k/YVrGXRVsFFZ4ONOvK/U4RqVQHuJjog/QOKerjr2EBcxTSkMX0w23ajspnzgpw
         bOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCURjYwzwv3x+inW6IjW7PpRY4uTz6yJoXDZF77XdNQPoz38AfKN2LdN6ol+FrcjbpCL4vt+1OgnkjMpt0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYtLad5iS6+UrrP5ySF0UHE4MJVejoriUPj4PbSbG1z3gYGmXE
	GQdH02X0XSti9bP1CW4Gj8V0D2Ng3J7vvCENno/U20VcK/2pE5VuZinoLC+T3lJ1BD8Qil5P84+
	ik5RhOtdc/lAV+Q==
X-Google-Smtp-Source: AGHT+IE28Cn+D6RTRtX91pYwDnd5zfpJjbOEGfORhMIoLTvvcoagejiT2Mcgwr5tybnnq3WA/m4ZzUqRkVc5Cw==
X-Received: from wmcn6.prod.google.com ([2002:a05:600c:c0c6:b0:45d:d522:48a9])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8115:b0:46e:3b81:c3f9 with SMTP id 5b1f17b1804b1-46e71143012mr33226465e9.17.1759512768358;
 Fri, 03 Oct 2025 10:32:48 -0700 (PDT)
Date: Fri,  3 Oct 2025 17:32:28 +0000
In-Reply-To: <20251003173229.1533640-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003173229.1533640-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003173229.1533640-4-smostafa@google.com>
Subject: [RFC PATCH 3/4] drivers/iommu-debug: Track IOMMU pages
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Using the new calls use an atomic refcount to track how many times
a page is mapped in any of the IOMMUs.

For unmap we need to use iova_to_phys() to get the physical address
of the pages.

We use the smallest supported page size as the granularity of tracking
per domain.
This is important as it possible to map pages and unmap them with
larger sizes (as in map_sg()) cases.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu-debug.c | 83 +++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/iommu/iommu-debug.c b/drivers/iommu/iommu-debug.c
index 607f1fcf2235..cec8f594c7fa 100644
--- a/drivers/iommu/iommu-debug.c
+++ b/drivers/iommu/iommu-debug.c
@@ -27,16 +27,99 @@ struct page_ext_operations page_iommu_debug_ops = {
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
+ * IOMMU pages size might not match the CPU page size, in that case, we use
+ * the smallest IOMMU page size to refcount the pages in the vmemap.
+ * That's is important as both map and unmap has to use the same page size
+ * to update the refcount to avoid double counting the same page.
+ * And as we can't know from iommu_unmap() what was the original page size
+ * used for map, we just use the minimum supported one for both.
+ */
+static size_t iommu_debug_page_size(struct iommu_domain *domain)
+{
+	return 1UL << __ffs(domain->pgsize_bitmap);
+}
+
 void iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
 {
+	size_t off;
+	size_t page_size = iommu_debug_page_size(domain);
+
+	if (!static_branch_likely(&iommu_debug_initialized))
+		return;
+
+	for (off = 0 ; off < size ; off += page_size) {
+		if (!pfn_valid(__phys_to_pfn(phys + off)))
+			continue;
+		iommu_debug_inc_page(phys + off);
+	}
 }
 
 void iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
+	size_t off;
+	size_t page_size = iommu_debug_page_size(domain);
+
+	if (!static_branch_likely(&iommu_debug_initialized))
+		return;
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
 
 void iommu_debug_remap(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
+	size_t off;
+	size_t page_size = iommu_debug_page_size(domain);
+
+	if (!static_branch_likely(&iommu_debug_initialized))
+		return;
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
2.51.0.618.g983fd99d29-goog


