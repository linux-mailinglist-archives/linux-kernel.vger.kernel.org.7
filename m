Return-Path: <linux-kernel+bounces-889043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0012C3C8B1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD231899A05
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7E234D4D6;
	Thu,  6 Nov 2025 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQIPSKLL"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5C13451C8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447214; cv=none; b=TUKxAaXkNizTpHfWvsAczZGF1WGS/cBfiByI+RzV+QjRYWTK1BAT+hB+oeiic9hTwl2qnkUYPGdsCD05roGgQ2D617RkbFKKYMk67K14dvmV3Xk3VkJZDJVJy5GfkewP9Xw63/i9yClz61tFOvoUc/qH30ujoROjK5CG2c/2PNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447214; c=relaxed/simple;
	bh=NQFUpooTxwel5bKTK83SG1NYi4wOT9pFGjG9pCWdTI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aQK0kaeoGOl3VpJwf7KV67Sif1BO9CQuImimi05N9ksnAhpanCLA0gJ9kV01g9wUM9thi6WrFvzdbFD00lwcvcngT/hdllynOkFISBkNfAuYOToHGzXfVtYytKyEFsvzOEA/lQp1kOFvqlhxDYCJ0dmnHP5NDagDVx0U3jGXHUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VQIPSKLL; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477632c240bso8580615e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762447211; x=1763052011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tSiZ7a1SAJCcKkBVDBEHEQqlSOfVk/u+1v4U8UB7ILg=;
        b=VQIPSKLLg+Q8mRixsje8+SgimBsTX8D5SsMV8WY9y+iwvFEMITB7nMCuWpCUvWcu75
         7U6VJbXmXzv81lPBMuhWoL84g+qqtWiW+Yk8f2wsH+qnwwyxH+WianBGjb8L2v6lGl7m
         GHyyl+JREmVBBamvXBp59E5VZDKtDXco+xL6ZpmcS8K5vucY5yJufJQtxUmR375uFwQo
         CcbJ2YSmZTpc4ExBqtKBokwU4HFS6hC1iroa5PfXP91epWbiUwmA8E0OdK4gM4zBq0eW
         mQSWkU/++Shq/8iDTUCZdtSOsdcIBqRc57LiJlvvtJ/Avv0/2PIgpQE0o3CAbBB04X3v
         9Q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447211; x=1763052011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSiZ7a1SAJCcKkBVDBEHEQqlSOfVk/u+1v4U8UB7ILg=;
        b=sFcdQPRZFqQ8tK/Vm8sKoeNnDnfmhqzG56W2rJXOtEcq6QGIAIO+vFRuwwlsrzaEbk
         lvbpVl2ruMDzL4GsK7czTIADL+RvV6K91jStSgyVzQ+2s4W+6jmW+oACWNc6wyZdiDyh
         w/OOPqdQJCyD1d6G7fKpNZesESXUtc/QVDBSiryWyXghu7QlpanYP+OTDo5Ws8KuWrWv
         /A+KfTg5na3YFZrfG/NJB1BlH90vF7czPqJpV+dnQW2wygJ7TJbK+03p4g3lcrbr4KxI
         LOPQAHB201F3aUsZxzL5M611Q5fbvOIkp2efJ0atr+JUfCeZh0+Eb//BB0Z64lbvE/Fe
         T/dg==
X-Forwarded-Encrypted: i=1; AJvYcCXXACM/A8FZLeL5Xh8Re+KFyMf/mFdF8re837wkOVlu2/Cmxfl4qt70jx7hnrwoTr7ce39nlv/C8TIBf70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2DwHVeRTZvnbry+C5i8KgP07GQkRBNoc7CgOhiqdjRcaQu3B
	rnx5HBQl+B7FmklMnu2eN23AufJMI9ZfLONVtM3ThTNsB8NBrMNh9yIK9dAuKUGjJgAoM34TPmv
	SBKawP3JcTbho2w==
X-Google-Smtp-Source: AGHT+IEulRepKpg83hX8wGoEp36I0gmjB5yebzIOWO3BeWZ0yZNLjb0D/EtrwnuCx8tGevmN/RGY3y+bKKt1iw==
X-Received: from wmnc9.prod.google.com ([2002:a05:600c:1709:b0:477:31ea:6473])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1987:b0:471:56:6f79 with SMTP id 5b1f17b1804b1-4775ce3c5b5mr66270665e9.41.1762447210611;
 Thu, 06 Nov 2025 08:40:10 -0800 (PST)
Date: Thu,  6 Nov 2025 16:39:51 +0000
In-Reply-To: <20251106163953.1971067-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106163953.1971067-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106163953.1971067-3-smostafa@google.com>
Subject: [PATCH v2 2/4] drivers/iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	Mostafa Saleh <smostafa@google.com>, Qinxin Xia <xiaqinxin@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Add calls for the new iommu debug config IOMMU_DEBUG_PAGEALLOC:
- iommu_debug_init: Enable the debug mode if configured by the user.
- iommu_debug_map: Track iommu pages mapped, using physical address.
- iommu_debug_unmap: Track iommu pages unmapped, using IO virtual
  address.
- iommu_debug_remap: Track iommu pages, already mapped using IOVA.

We have to do the unmap/remap as once pages are unmapped we lose the
information of the physical address.
This is racy, but the API is racy by construction as it uses refcounts
and doesn't attempt to lock/synchronize with the IOMMU API as that will
be costly, meaning that possibility of false negative exists.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 23 ++++++++++++
 drivers/iommu/iommu.c                 | 14 ++++++-
 include/linux/iommu-debug-pagealloc.h | 54 +++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
index 385c8bfae02b..a6a2f844b09d 100644
--- a/drivers/iommu/iommu-debug-pagealloc.c
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -5,11 +5,13 @@
  * IOMMU API debug page alloc sanitizer
  */
 #include <linux/atomic.h>
+#include <linux/iommu.h>
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kernel.h>
 #include <linux/page_ext.h>
 
 static bool needed;
+DEFINE_STATIC_KEY_FALSE(iommu_debug_initialized);
 
 struct iommu_debug_metadate {
 	atomic_t ref;
@@ -25,6 +27,27 @@ struct page_ext_operations page_iommu_debug_ops = {
 	.need = need_iommu_debug,
 };
 
+void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
+{
+}
+
+void __iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
+{
+}
+
+void __iommu_debug_remap(struct iommu_domain *domain, unsigned long iova, size_t size)
+{
+}
+
+void iommu_debug_init(void)
+{
+	if (!needed)
+		return;
+
+	pr_info("iommu: Debugging page allocations, expect overhead or disable iommu.debug_pagealloc");
+	static_branch_enable(&iommu_debug_initialized);
+}
+
 static int __init iommu_debug_pagealloc(char *str)
 {
 	return kstrtobool(str, &needed);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 59244c744eab..f374ac0fdf95 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/host1x_context_bus.h>
 #include <linux/iommu.h>
+#include <linux/iommu-debug-pagealloc.h>
 #include <linux/iommufd.h>
 #include <linux/idr.h>
 #include <linux/err.h>
@@ -231,6 +232,8 @@ static int __init iommu_subsys_init(void)
 	if (!nb)
 		return -ENOMEM;
 
+	iommu_debug_init();
+
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
 		nb[i].notifier_call = iommu_bus_notifier;
 		bus_register_notifier(iommu_buses[i], &nb[i]);
@@ -2544,10 +2547,12 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
 	}
 
 	/* unroll mapping in case something went wrong */
-	if (ret)
+	if (ret) {
 		iommu_unmap(domain, orig_iova, orig_size - size);
-	else
+	} else {
 		trace_map(orig_iova, orig_paddr, orig_size);
+		iommu_debug_map(domain, orig_paddr, orig_size);
+	}
 
 	return ret;
 }
@@ -2609,6 +2614,8 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 
 	pr_debug("unmap this: iova 0x%lx size 0x%zx\n", iova, size);
 
+	iommu_debug_unmap(domain, iova, size);
+
 	/*
 	 * Keep iterating until we either unmap 'size' bytes (or more)
 	 * or we hit an area that isn't mapped.
@@ -2628,6 +2635,9 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 		unmapped += unmapped_page;
 	}
 
+	if (unmapped < size)
+		iommu_debug_remap(domain, iova, size - unmapped);
+
 	trace_unmap(orig_iova, size, unmapped);
 	return unmapped;
 }
diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-debug-pagealloc.h
index 83e64d70bf6c..180446d6d86f 100644
--- a/include/linux/iommu-debug-pagealloc.h
+++ b/include/linux/iommu-debug-pagealloc.h
@@ -8,10 +8,64 @@
 #ifndef __LINUX_IOMMU_DEBUG_PAGEALLOC_H
 #define __LINUX_IOMMU_DEBUG_PAGEALLOC_H
 
+struct iommu_domain;
+
 #ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
 
+DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);
+
 extern struct page_ext_operations page_iommu_debug_ops;
 
+void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys,
+		       size_t size);
+void __iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova,
+			 size_t size);
+void __iommu_debug_remap(struct iommu_domain *domain, unsigned long iova,
+			 size_t size);
+
+static inline void iommu_debug_map(struct iommu_domain *domain,
+				   phys_addr_t phys, size_t size)
+{
+	if (static_branch_unlikely(&iommu_debug_initialized))
+		__iommu_debug_map(domain, phys, size);
+}
+
+static inline void iommu_debug_unmap(struct iommu_domain *domain,
+				     unsigned long iova, size_t size)
+{
+	if (static_branch_unlikely(&iommu_debug_initialized))
+		__iommu_debug_unmap(domain, iova, size);
+}
+
+static inline void iommu_debug_remap(struct iommu_domain *domain,
+				     unsigned long iova, size_t size)
+{
+	if (static_branch_unlikely(&iommu_debug_initialized))
+		__iommu_debug_remap(domain, iova, size);
+}
+
+void iommu_debug_init(void);
+
+#else
+static inline void iommu_debug_map(struct iommu_domain *domain,
+				   phys_addr_t phys, size_t size)
+{
+}
+
+static inline void iommu_debug_unmap(struct iommu_domain *domain,
+				     unsigned long iova, size_t size)
+{
+}
+
+static inline void iommu_debug_remap(struct iommu_domain *domain,
+				     unsigned long iova, size_t size)
+{
+}
+
+static inline void iommu_debug_init(void)
+{
+}
+
 #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
 
 #endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
-- 
2.51.2.1026.g39e6a42477-goog


