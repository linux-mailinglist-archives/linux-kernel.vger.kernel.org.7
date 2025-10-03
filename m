Return-Path: <linux-kernel+bounces-841588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9261CBB7C26
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C1E19C7354
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272762DEA70;
	Fri,  3 Oct 2025 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9xltinL"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7605A2DC773
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512773; cv=none; b=HyqssA6vNgyiB/gAGGI+G0Asw4JfBz2M6b/KuJwa3j7LJpufb12DVj6HyDRIxXlwOiATsl8FSMyBvhBc4zksr7qLJ3lJSIq27SHL9MI6wQpHJft7CL/uI0L+ni2lh9IvsOQs0VPrJXySfiX+ByNS6Y/AXAwAJwPepkaZk2dNbTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512773; c=relaxed/simple;
	bh=Ppoa9QsZOoSTV+IPfX4/odA4ZuwL+h+gqoPsnDxPufY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AgVd6jnQ8jeS9OqkfCS+4DcFHbX4SSpdmxJssKcxfonrafAEjAXx/p8PPrDbn9nDtWEhY2IKh3LEfUBB7aDRhsYmgeKce7AeEKNTPhgKHxnWCFSLQEtNciDoOLkhwB8pzE6lZlW8Bawdo7iCHGDp54P1yX3dD4m9OWUEGAcDkP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y9xltinL; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6305c385adbso2706611a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759512770; x=1760117570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsO4Y9+CDsR/9B2sBMziOZN6BaFGbVnMznIuFrkfbBE=;
        b=Y9xltinLofTfplfLEyXdU9qcihyxyb7ymbBTzK6/kMb4aiA/G08AvuEwhE6ICg2sTW
         Ll84pC7Qgx0kfWzJEKfatH9O6TkDm/Y9N2YCQKAV7CLLpCFWG6oD7L7IF9gWnUrIdmPf
         fj9ZyU64wtmdHK7X3DpPlPRpqpMYLfWXKCTVxA11M5KH9n0DQnWX6qhzlnaw/672W3ED
         2jHNznATssRuYlEcBDRBFTnN74OPdIM/7jDMTbtxJpuvmqJBzmlmmN8nyX0fHZKESNq9
         lctm3veeqx+xRrf9rNvPjeylCmJh9eViA4JnNA6CE5E9UZdzqGe11DxOknKWXfp2kAY1
         3Ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512770; x=1760117570;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rsO4Y9+CDsR/9B2sBMziOZN6BaFGbVnMznIuFrkfbBE=;
        b=EABXCIRSl2pvRtI0A4ap/m3esyKN56Q9WAYYWlVaGNGrPACjrDirSXp2d4I5omQpTY
         qjvd+rDQBNGbdqXhb4Gk4Q24GoDZ0SJreOfFCerm2vyTHwqX0z3LEbgnSWa9ZGwvXJ9u
         TyYYcspuGa36se/NvN5X1bbWmgVexffb4Yl0yE/VWosPznFz02CdjPmhbCXbXyLzpHuw
         tZW7zrbuoIyQdLw46WrzVRqrQvyfY4kHelvU/7bzWZZ0x9k7xq8TLcIiPAYFewzkiam4
         nrLgS35dNFEVbBXeZ7QTASWAfd6hmv95q6F/KYArWZRzYlyPHXdOLrpOdJfCppkzXccs
         978Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3QQ3cKXPegW/SNl/R5hUVa+lXaEO+PJdakAMWmOmiEZsVG/kh44Klhq7Y/RFqs+SwJeppavsiiBjihlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN47UZo6vxmZe13XAOP2yJAS1qOnkxucVCvkDpML+BLYdlkCeb
	vw+KI7kEJGcBKfMTBPiM7cP1Rde5C01/TBGDOP1v26qGFHI8PTzWFk0PHF7zr/w90/eYp+VYKUg
	OOtytrUe4681tvg==
X-Google-Smtp-Source: AGHT+IEICQMptfCkkk6D3e73QyAc9gpdDen9PXr6jWCu1S1AfhHO09M/A91ku8VJ/Ju4zq0R9Vac76YEgDbAjg==
X-Received: from edqm10.prod.google.com ([2002:aa7:c48a:0:b0:636:871c:c865])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3508:b0:639:102b:b8db with SMTP id 4fb4d7f45d1cf-63939c20419mr3602021a12.24.1759512769531;
 Fri, 03 Oct 2025 10:32:49 -0700 (PDT)
Date: Fri,  3 Oct 2025 17:32:29 +0000
In-Reply-To: <20251003173229.1533640-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003173229.1533640-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003173229.1533640-5-smostafa@google.com>
Subject: [RFC PATCH 4/4] drivers/iommu-debug: Check state of mapped/unmapped
 kernel memory
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Now, as the page_ext holds count of IOMMU mappings, we can use it to
assert that any page allocated/freed is indeed not in the IOMMU.

The sanitizer doesn=E2=80=99t protect against mapping/unmapping during this
period. However, that=E2=80=99s less harmful as the page is not used by the
kernel.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu-debug.c | 22 ++++++++++++++++++++++
 include/linux/iommu-debug.h |  1 +
 include/linux/mm.h          |  7 +++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/iommu/iommu-debug.c b/drivers/iommu/iommu-debug.c
index cec8f594c7fa..09157fef697e 100644
--- a/drivers/iommu/iommu-debug.c
+++ b/drivers/iommu/iommu-debug.c
@@ -71,6 +71,28 @@ static size_t iommu_debug_page_size(struct iommu_domain =
*domain)
 	return 1UL << __ffs(domain->pgsize_bitmap);
 }
=20
+static unsigned int iommu_debug_page_count(unsigned long phys)
+{
+	unsigned int ref;
+	struct page_ext *page_ext =3D get_iommu_page_ext(phys);
+	struct iommu_debug_metadate *d =3D get_iommu_data(page_ext);
+
+	ref =3D atomic_read(&d->ref);
+	page_ext_put(page_ext);
+	return ref;
+}
+
+void iommu_debug_check_unmapped(const struct page *page, int numpages)
+{
+	if (!static_branch_likely(&iommu_debug_initialized))
+		return;
+
+	while (numpages--) {
+		WARN_ON(iommu_debug_page_count(page_to_phys(page)));
+		page++;
+	}
+}
+
 void iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t=
 size)
 {
 	size_t off;
diff --git a/include/linux/iommu-debug.h b/include/linux/iommu-debug.h
index 8d3ea661660f..aaf893cfafd0 100644
--- a/include/linux/iommu-debug.h
+++ b/include/linux/iommu-debug.h
@@ -17,6 +17,7 @@ void iommu_debug_map(struct iommu_domain *domain, phys_ad=
dr_t phys, size_t size)
 void iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova, si=
ze_t size);
 void iommu_debug_remap(struct iommu_domain *domain, unsigned long iova, si=
ze_t size);
 void iommu_debug_init(void);
+void iommu_debug_check_unmapped(const struct page *page, int numpages);
=20
 #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
=20
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 06978b4dbeb8..00f5de44faa0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -36,6 +36,7 @@
 #include <linux/rcuwait.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
+#include <linux/iommu-debug.h>
=20
 struct mempolicy;
 struct anon_vma;
@@ -3806,12 +3807,18 @@ extern void __kernel_map_pages(struct page *page, i=
nt numpages, int enable);
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static inline void debug_pagealloc_map_pages(struct page *page, int numpag=
es)
 {
+#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
+	iommu_debug_check_unmapped(page, numpages);
+#endif
 	if (debug_pagealloc_enabled_static())
 		__kernel_map_pages(page, numpages, 1);
 }
=20
 static inline void debug_pagealloc_unmap_pages(struct page *page, int nump=
ages)
 {
+#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
+	iommu_debug_check_unmapped(page, numpages);
+#endif
 	if (debug_pagealloc_enabled_static())
 		__kernel_map_pages(page, numpages, 0);
 }
--=20
2.51.0.618.g983fd99d29-goog


