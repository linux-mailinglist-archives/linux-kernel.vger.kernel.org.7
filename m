Return-Path: <linux-kernel+bounces-835550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F222CBA76B1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6BE1885DA8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16217253B59;
	Sun, 28 Sep 2025 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DOtNlOrY"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC2257858
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086481; cv=none; b=Fyr4JDPYbgpU1DybnZqKtEMYkxJa68mpIfgRvGK797ulZSGbkgSe83LvWxZG/ej2lLMd/IhT/DDOLxZ5kaEoZ/wfSAKNpavYuUXnvDkgUWGl59YBVl7mWfnoXLmeJ9zlhPfXgBZf7fQJcCf9GzN6aPKPGYsvSTzxSZ4jatg7rNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086481; c=relaxed/simple;
	bh=Hz08krsvo2uu8r8XXqocMeGrlRetPXduZzadaTl1c1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F2up0pKoUb/a5KdJziLywhXQSfcadK7g64F8G1ilcq4wyqye81jQKF6Tz5wphB4LZcdqzHXXY1Oy2GctS+TkrOiVzn9eD5c0rDEOBSTl/Rx855HFNUJ8yp18L305xGwEAeUnFXt63elGoBy9gfFqOvgnzEmtkUIS0obKxsNl9FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DOtNlOrY; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7810289cd5eso5458519b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086479; x=1759691279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMP1AXZR5K2DaLRM+QM+TDjG2L4fBux6TVzeNYZkXlc=;
        b=DOtNlOrY4PVX8Mc3NrL+O8hAPU9HugQruCvzdMxRWOsTb1LeHuBCQECMyetdvQhgp2
         jNCNYQVsKp3UxH9cgUPorWTbFnUosO2fqqt/T8KPWb8GXwyigsaj8qcV3EFz6ojpS6gw
         1ugd7reuzeafLLfRFzt982d3GpbFKZJLrjn/8IdanYdpyqmHL6/3ipA3vOt7U7uxJfOM
         X+EjBo/fUebgZUeYco5ZIYF5BceVtv5D1f3JmFiDtCTipicvdhnLMtcqMj8rAHe233NC
         zyUgWFfIdAUjdMFkU+jE9ZOOG2O88hfTUa7rSi5Fdw49K6oVP/Va/7ZrvcjXr6oqybN8
         sf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086479; x=1759691279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMP1AXZR5K2DaLRM+QM+TDjG2L4fBux6TVzeNYZkXlc=;
        b=Dp2u87K0mzsP0jyo52qCdf6upKkMVnwYOwPY9+6vs2flajnBOVz7oAyPZjy800AbL5
         LmoNjcZdBIWP4r7p5eGO7kl/JEo4QiZoqX9qUq6a0ewMkunfmcmcaMukcU90shcYUfOn
         X2QJNLu+znOW5JTFh8+3SE7umuyIuFPNwHol8me9RfzgNurUOfvpykv4fUeQd08pn53W
         HS/7JyjcUj8WLkMzjBK8Ljc1RVF2KvW87uaRC5r4eyAQdKC1Bwer/k6fmVSeyiUTcUc7
         kdalCbtx8mpNwTkfTBEjQHHzHoTewquTGgxNOb58BivvXFQkCBwHDYFVq5yaOuL8Ldls
         xmXg==
X-Forwarded-Encrypted: i=1; AJvYcCX7Dn0Rb9OJHGiLv2Sf5uNAr+BKVnqJBlDXjDAzhx9rjfcrLQKUkfFwpd7iK2lbMF+AvAHDIBrtIrNaMNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDw/13iEfsVaRL7u8f7ainyVeW5+Wymsi74X/4ALO8g5QOSbp3
	FuCVEC8QGNjmKONtOCedAyHcjLqTILlcViTSxgI8fEdgcVMICOGoRocXq6s9TB9AC1d/xTC1xJ3
	BwMPzGyejAs4PZQ==
X-Google-Smtp-Source: AGHT+IERI+oLKd9q7ro7oO/YEhndfr7WxtS0ghCxPXAfP/xH9RrAUds1QILDN/YJJkQWFDM4kRukWJPJlkXBxQ==
X-Received: from pfbct10.prod.google.com ([2002:a05:6a00:f8a:b0:77f:6432:dc09])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:189a:b0:776:20c2:d58b with SMTP id d2e1a72fcca58-780fced5d67mr17812026b3a.24.1759086478987;
 Sun, 28 Sep 2025 12:07:58 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:20 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-13-skhawaja@google.com>
Subject: [RFC PATCH 12/15] iommufd-luo: Implement basic prepare/cancel/finish/retrieve
 using folios
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: YiFei Zhu <zhuyifei@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

The actual serialization and de-serialization is implemented in
follow up commits.

- On prepare, a single folio is created and preserved to store
  all the structs.
- On cancel, the folio is unpreserved and freed.
- On retrieve, the folio is restored, then an fd with anon_inode
  is created, with data pointing to the folio.
- On finish, the folio is freed.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  12 +++
 drivers/iommu/iommufd/liveupdate.c      | 127 +++++++++++++++++++++++-
 drivers/iommu/iommufd/main.c            |   2 +-
 3 files changed, 137 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index faf48ca9e555..dfa17bfc9933 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -19,6 +19,9 @@ struct iommu_domain;
 struct iommu_group;
 struct iommu_option;
 struct iommufd_device;
+struct iommufd_lu;
+
+extern const struct file_operations iommufd_fops;
 
 struct iommufd_sw_msi_map {
 	struct list_head sw_msi_item;
@@ -55,6 +58,10 @@ struct iommufd_ctx {
 	/* Compatibility with VFIO no iommu */
 	u8 no_iommu_mode;
 	struct iommufd_ioas *vfio_ioas;
+
+#ifdef CONFIG_LIVEUPDATE
+	struct iommufd_lu *lu;
+#endif
 };
 
 /* Entry for iommufd_ctx::mt_mmap */
@@ -703,6 +710,11 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
 }
 
 #ifdef CONFIG_LIVEUPDATE
+struct iommufd_lu {
+	/* Only valid in restore, for lifetime purposes */
+	struct folio *folio_lu;
+};
+
 int iommufd_liveupdate_register_lufs(void);
 int iommufd_liveupdate_unregister_lufs(void);
 #else
diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
index 6d2a64966335..1bdd5a82af90 100644
--- a/drivers/iommu/iommufd/liveupdate.c
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -2,16 +2,52 @@
 
 #define pr_fmt(fmt) "iommufd: " fmt
 
+#include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include <linux/iommufd.h>
+#include <linux/kexec_handover.h>
 #include <linux/liveupdate.h>
+#include <linux/mm.h>
 
 #include "iommufd_private.h"
 
 static int iommufd_liveupdate_prepare(struct liveupdate_file_handler *handler,
 				      struct file *file, u64 *data)
 {
-	return -EOPNOTSUPP;
+	struct iommufd_ctx *ictx = iommufd_ctx_from_file(file);
+	struct iommufd_lu *iommufd_lu;
+	struct folio *folio_lu;
+	size_t serial_size;
+	int rc;
+
+	if (IS_ERR(ictx))
+		return PTR_ERR(ictx);
+
+	serial_size = sizeof(*iommufd_lu);
+
+	folio_lu = folio_alloc(GFP_KERNEL, get_order(serial_size));
+	if (!folio_lu) {
+		rc = -ENOMEM;
+		goto err_ctx_put;
+	}
+
+	iommufd_lu = folio_address(folio_lu);
+
+	rc = kho_preserve_folio(folio_lu);
+	if (rc)
+		goto err_folio_put;
+
+	*data = virt_to_phys(iommufd_lu);
+
+	iommufd_ctx_put(ictx);
+	return 0;
+
+err_folio_put:
+	folio_put(folio_lu);
+
+err_ctx_put:
+	iommufd_ctx_put(ictx);
+	return rc;
 }
 
 static int iommufd_liveupdate_freeze(struct liveupdate_file_handler *handler,
@@ -24,23 +60,108 @@ static int iommufd_liveupdate_freeze(struct liveupdate_file_handler *handler,
 static void iommufd_liveupdate_cancel(struct liveupdate_file_handler *handler,
 				      struct file *file, u64 data)
 {
+	struct iommufd_ctx *ictx = iommufd_ctx_from_file(file);
+	struct folio *folio_lu;
+
+	if (WARN_ON(IS_ERR(ictx)))
+		return;
+
+	folio_lu = pfn_folio(PHYS_PFN(data));
+	WARN_ON(kho_unpreserve_folio(folio_lu));
+	folio_put(folio_lu);
+
+	iommufd_ctx_put(ictx);
 }
 
 static void iommufd_liveupdate_finish(struct liveupdate_file_handler *handler,
 				      struct file *file, u64 data, bool reclaimed)
 {
+	struct iommufd_lu *iommufd_lu;
+	struct iommufd_ctx *ictx;
+	struct folio *folio_lu;
+
+	if (!reclaimed || !file) {
+		pr_warn("%s: fd not reclaimed\n", __func__);
+
+		folio_lu = kho_restore_folio(data);
+		if (WARN_ON_ONCE(IS_ERR_OR_NULL(folio_lu)))
+			return;
+
+		iommufd_lu = folio_address(folio_lu);
+	} else {
+		ictx = iommufd_ctx_from_file(file);
+		iommufd_lu = ictx->lu;
+		ictx->lu = NULL;
+		iommufd_ctx_put(ictx);
+	}
+
+	folio_put(iommufd_lu->folio_lu);
 }
 
 static int iommufd_liveupdate_retrieve(struct liveupdate_file_handler *handler,
 				       u64 data, struct file **file_p)
 {
-	return -EOPNOTSUPP;
+	struct iommufd_lu *iommufd_lu;
+	struct iommufd_ctx *ictx;
+	struct folio *folio_lu;
+	struct file *file;
+	int rc;
+
+	folio_lu = kho_restore_folio(data);
+	if (IS_ERR_OR_NULL(folio_lu))
+		return -EFAULT;
+
+	iommufd_lu = folio_address(folio_lu);
+	iommufd_lu->folio_lu = folio_lu;
+
+	file = anon_inode_create_getfile("iommufd", &iommufd_fops,
+					 NULL, O_RDWR, NULL);
+	if (IS_ERR(file)) {
+		rc = PTR_ERR(file);
+		goto err_folio_put;
+	}
+
+	rc = iommufd_fops.open(file->f_inode, file);
+	if (rc)
+		goto err_fput;
+
+	ictx = iommufd_ctx_from_file(file);
+	if (WARN_ON(IS_ERR(ictx))) {
+		rc = PTR_ERR(ictx);
+		goto err_fput;
+	}
+
+	if (WARN_ON(ictx->lu)) {
+		rc = -EEXIST;
+		goto err_ctx_put;
+	}
+	ictx->lu = iommufd_lu;
+
+	iommufd_ctx_put(ictx);
+
+	*file_p = file;
+
+	return 0;
+
+err_ctx_put:
+	iommufd_ctx_put(ictx);
+err_fput:
+	fput(file);
+err_folio_put:
+	folio_put(folio_lu);
+	return rc;
 }
 
 static bool iommufd_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
 					    struct file *file)
 {
-	return false;
+	struct iommufd_ctx *ictx = iommufd_ctx_from_file(file);
+
+	if (IS_ERR(ictx))
+		return false;
+
+	iommufd_ctx_put(ictx);
+	return true;
 }
 
 static struct liveupdate_file_ops iommufd_lu_file_ops = {
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index b3bf65bc8da4..a8b6daaca11f 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -577,7 +577,7 @@ static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
 	return rc;
 }
 
-static const struct file_operations iommufd_fops = {
+const struct file_operations iommufd_fops = {
 	.owner = THIS_MODULE,
 	.open = iommufd_fops_open,
 	.release = iommufd_fops_release,
-- 
2.51.0.536.g15c5d4f767-goog


