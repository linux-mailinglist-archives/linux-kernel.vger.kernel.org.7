Return-Path: <linux-kernel+bounces-889046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A02C5C3C8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB78C1889F79
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EF534E759;
	Thu,  6 Nov 2025 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3WylvHt"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6E34BA53
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447217; cv=none; b=h6js9MffG+U8pCF8n1tUEdDLLvJwCFHNdmrJIQAT8qhJ/niMl55rK9S4utzyoc9LZg9RvHoHXG6OSbvwA6J8GuzodVmtFalGZZso5HwX/3MUU6WoFxzoVaY1e40Vm4q59Sc+yCRByIvNDFQ4Fgy3Ri+U/8s3gGF5bM3yc+MdLbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447217; c=relaxed/simple;
	bh=QPnuTeoHkJAdsy3GLHh3OinUFPR46uTzV5UBwbwi06c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GVXCpeMKPXBSma3D0UPGuhxNwKbL4X1kc2HhQJ38FMWWI5VW/l52DA7eJiVvDzvEXIz7ianbfGjhC+uEg66isqvtP6dqXPleA+B22aVq/52711F2bzeqgna0YYrm6Xn6GIs9RDj5tIKFoHECJlBJU19s9V6FTVngKE481KENt7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3WylvHt; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429f0907e13so517475f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762447212; x=1763052012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NM/GZbyZiL8bh5z49/8PTeWfbgNSwSL55H6jI2E+lmQ=;
        b=k3WylvHth50gK6qApAeHkMJsGWajNky8dUpWySaoNpFfHI1c87KNlb6NqJqH/qO22q
         fEH2hziWn1rIzGcSi37TvguDB0dp4dVQdo/VjlnK+xHDKT7hRJhjgG6uq3+L1iSSTDT3
         L1yy5UksmzIIgMxXPirJvMZkPTEVwqZQIYTyGAd0ryveWarhmdOUxQ8vUZwO7qXWMbzS
         7UNKMEdJ+IefjJSh+UiQuyT962HOePlcP12VKOsn0jigriqeW8zQ32oSRxGlJNLu+QSO
         /511l4eQNRGKr/eT0UcML+jV2OP8k3dOOUiT5dELd/1cDN9ki5ZN4JFne6yJOG8t2xD5
         PRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447212; x=1763052012;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NM/GZbyZiL8bh5z49/8PTeWfbgNSwSL55H6jI2E+lmQ=;
        b=vIRjgBr9vt7MX4sOOilXr1uiqhbihezQPZYl8k22d36NLjuynV4w2+CWZSQ4U3WeY+
         We39Y+AemNI6yDM8CMqinkZfFDW02W6lgewm/HNi1wCanR3zysZ+NseqklOsF5q6Wyz2
         XvO4OkF8Tfp1H6IUlBz5e+IEIXJ2mcDTD7Scv5Y/7f099sVjczXMcl5orJ6ymVYixSFP
         xpyPiBtzrLAdR+f4StXKj0IWiYpekjDRK9KQVcDUB/ZDD9P5g/KuRSMxRchWQfFPqGQe
         pv0jJPuEfvOaZNGkzF4Lo1LDPl9iXnRgd3rjtlh4+pkVRi0VynohRBLSN/N39NEC6v4M
         jr+w==
X-Forwarded-Encrypted: i=1; AJvYcCUWSzfPVJmNh74B9fR5Rr/mLbPqVAMnYiZ0IyCSqU4Do6dBCUCa356MwX9IXNFpXA7g42hKVmU2nL4uB9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEj/D8SYW01HdaRSCeLocbLIXefTykVV5elB8mEOAJInnrANe7
	u2LaYrHZUZOpnOS0/9jdmfDlytlI9nGRw57vr9IDg0Lh50hJ25pRX4F/9KBZdskv5hNrCJe4+aJ
	oEmC+7v916cc8yA==
X-Google-Smtp-Source: AGHT+IFXE6Qsd8iIgYNiQDlI0sqI8FtMmoIupsqXvZU2YQ+mpshBBiH57cinC3fDVEftkTGmawxtksFJp1JKIw==
X-Received: from wrsy17.prod.google.com ([2002:a5d:4ad1:0:b0:429:dc18:dd64])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f87:0:b0:429:b7cd:47ff with SMTP id ffacd0b85a97d-429e33083c8mr6867222f8f.40.1762447212631;
 Thu, 06 Nov 2025 08:40:12 -0800 (PST)
Date: Thu,  6 Nov 2025 16:39:53 +0000
In-Reply-To: <20251106163953.1971067-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106163953.1971067-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106163953.1971067-5-smostafa@google.com>
Subject: [PATCH v2 4/4] drivers/iommu-debug-pagealloc: Check mapped/unmapped
 kernel memory
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	Mostafa Saleh <smostafa@google.com>, Qinxin Xia <xiaqinxin@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Now, as the page_ext holds count of IOMMU mappings, we can use it to
assert that any page allocated/freed is indeed not in the IOMMU.

The sanitizer doesn=E2=80=99t protect against mapping/unmapping during this
period. However, that=E2=80=99s less harmful as the page is not used by the
kernel.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 19 +++++++++++++++++++
 include/linux/iommu-debug-pagealloc.h | 12 ++++++++++++
 include/linux/mm.h                    |  5 +++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-de=
bug-pagealloc.c
index 0e14104b971c..5b26c84d3a0e 100644
--- a/drivers/iommu/iommu-debug-pagealloc.c
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -71,6 +71,25 @@ static size_t iommu_debug_page_size(struct iommu_domain =
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
+void __iommu_debug_check_unmapped(const struct page *page, int numpages)
+{
+	while (numpages--) {
+		WARN_ON(iommu_debug_page_count(page_to_phys(page)));
+		page++;
+	}
+}
+
 void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size=
_t size)
 {
 	size_t off;
diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-de=
bug-pagealloc.h
index 180446d6d86f..84110e4ecfaa 100644
--- a/include/linux/iommu-debug-pagealloc.h
+++ b/include/linux/iommu-debug-pagealloc.h
@@ -22,6 +22,7 @@ void __iommu_debug_unmap(struct iommu_domain *domain, uns=
igned long iova,
 			 size_t size);
 void __iommu_debug_remap(struct iommu_domain *domain, unsigned long iova,
 			 size_t size);
+void __iommu_debug_check_unmapped(const struct page *page, int numpages);
=20
 static inline void iommu_debug_map(struct iommu_domain *domain,
 				   phys_addr_t phys, size_t size)
@@ -44,6 +45,12 @@ static inline void iommu_debug_remap(struct iommu_domain=
 *domain,
 		__iommu_debug_remap(domain, iova, size);
 }
=20
+static inline void iommu_debug_check_unmapped(const struct page *page, int=
 numpages)
+{
+	if (static_branch_unlikely(&iommu_debug_initialized))
+		__iommu_debug_check_unmapped(page, numpages);
+}
+
 void iommu_debug_init(void);
=20
 #else
@@ -66,6 +73,11 @@ static inline void iommu_debug_init(void)
 {
 }
=20
+static inline void iommu_debug_check_unmapped(const struct page *page,
+					      int numpages)
+{
+}
+
 #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
=20
 #endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d16b33bacc32..895a60a49120 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -36,6 +36,7 @@
 #include <linux/rcuwait.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
+#include <linux/iommu-debug-pagealloc.h>
=20
 struct mempolicy;
 struct anon_vma;
@@ -3811,12 +3812,16 @@ extern void __kernel_map_pages(struct page *page, i=
nt numpages, int enable);
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static inline void debug_pagealloc_map_pages(struct page *page, int numpag=
es)
 {
+	iommu_debug_check_unmapped(page, numpages);
+
 	if (debug_pagealloc_enabled_static())
 		__kernel_map_pages(page, numpages, 1);
 }
=20
 static inline void debug_pagealloc_unmap_pages(struct page *page, int nump=
ages)
 {
+	iommu_debug_check_unmapped(page, numpages);
+
 	if (debug_pagealloc_enabled_static())
 		__kernel_map_pages(page, numpages, 0);
 }
--=20
2.51.2.1026.g39e6a42477-goog


