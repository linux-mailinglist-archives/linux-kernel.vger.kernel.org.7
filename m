Return-Path: <linux-kernel+bounces-835544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095EFBA769F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A669B1794D0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEFF26657B;
	Sun, 28 Sep 2025 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F5/OONwZ"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FD925A2C7
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086472; cv=none; b=LdAV7TqGLdRvEMUlYr2s2CRBuLhEYU1DyRnDerIECDHMXypnewI5oBXo2Oq3VBT1DTAV5iUchglqN6CbVtPRrvI6TlRZ6NUpulSLdf27Y46J2A4lZ6FqrVdk95LaHpUUFTDZ8q4T+bW6TfGl4wG30j8L0Kx3E3XiQC4yblkKNts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086472; c=relaxed/simple;
	bh=EeovTi/1CEJ8oPAob1Hj6uM2MPZDtSjBccEqrgz0EFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e3lGF03bFV+/Xb7PACrX2EDnIBFs6vHaLmdaFpVg5E3YoI7eW63wp19p2WbQZqFwcv1Q8Y/2/+gbgPkt1c6LorCeM9vAU8j3S7N2tMbL3P2Meum0iIZHBUxdtSr9PEAy9cNoDTjk7Gg3f07MwLZ4DnaDKvUYiA18FeO4qlnVQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F5/OONwZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27356178876so29150225ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086470; x=1759691270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TH/9Jtoynp6nkNgBt5pZU0cN3mVwJHyFDfFaXLb+GfA=;
        b=F5/OONwZi/9UhhytjzF4xJx3mtwD7NjYfk+hGIjoafLd7ygfRmHj0dUWDcjfTYNv95
         JTLH1jej1thhAyOpGqGrslK3y5jIkZS+HRCrm5PP/xqSlqLW5TEZP4YFMi6UyhwwtzMs
         /XLVH778YzfFFVR6vQTE6Tt2at9E/g4OTKrT9prMV4Va0ebenH9kFiMBrepIIRxEL4LM
         LuaZ39j/feavWPjnqj7lV8tjOMcZ10mBioxPaZtzdOsSkOXm/c5WNTgT5+4NSWdyxWFj
         Dz0NVph/xMFevhUKMpoghibtbq3g+Hh8r/h8eTO3FnbMCvOcxyA6IMPeIKcqDPD4j2b+
         h/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086470; x=1759691270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TH/9Jtoynp6nkNgBt5pZU0cN3mVwJHyFDfFaXLb+GfA=;
        b=PFzDndlSiF4aeSGvIsMC11bIoICl28kiY0aLRrmugDfXTxnpo/j0Ahtgz05JYvjtYt
         mYR5xvFK/JsrEtyeL6oTto60k0LDVN7BrtmfXrfXmYusZIhx+56TXRk0Xvl1mZGyLQq2
         7rNlNY9PfOp91K+0QdBGinZgs3ZXxcc31dmSTn4vLM9KQjKoahkUt7dMJEqT906uYuHW
         KAJh826OubH5c4O3D/uKRHyMeP1lOBeIWMT+VUiO0w8iXktPVSW6SeO2SvG51xR9Ppry
         lfX0bUb1tI+00El0SkA+uvpVszXDC3BWnhr8fY5y7VkZohvr3zjILaUu8lWBZaaVr4Cv
         LPkA==
X-Forwarded-Encrypted: i=1; AJvYcCUlAakFSmjLQ5S14cywvaRXZBEglvAll3LIvkPSnzc20DiSyVS6HiU7MGw2JjGNx326M8DAHJ20VAbsDwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXLSW9u6PJ7AIJfNOJtUhPPXx9pecHVhCYG1eh6L8wU4d/5a/K
	+xg9yF8TOVzL4w/n8d+bWw8Us3Z5nMJ2Dx8E7snkKU/FKn7kdcUigXTx4J+Af1Weh8Eca7foWBm
	JTg5s2brHkHEjdQ==
X-Google-Smtp-Source: AGHT+IEDySm4AN2rcWd3tpaQUgR+ObHMHdJfAIbGRY3+AD4vHP4FnsnrIni5cOLhrFkNB0nMmOkCgtANf3ycPg==
X-Received: from pjbjx1.prod.google.com ([2002:a17:90b:46c1:b0:32d:df7e:66c2])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f786:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-27ed4aab57bmr154999485ad.38.1759086470179;
 Sun, 28 Sep 2025 12:07:50 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:14 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-7-skhawaja@google.com>
Subject: [RFC PATCH 06/15] iommu/vt-d: Add stub intel iommu domain preserve op
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Add a stub implementation of iommu domain preserve for intel iommu
driver. This is required so that the iommu_domain is marked as
preserved.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      | 6 ++++++
 drivers/iommu/intel/iommu.h      | 4 ++++
 drivers/iommu/intel/liveupdate.c | 9 +++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e236c7ec221f..7035ffca020f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4472,6 +4472,9 @@ const struct iommu_domain_ops intel_fs_paging_domain_ops = {
 	.iova_to_phys = intel_iommu_iova_to_phys,
 	.free = intel_iommu_domain_free,
 	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency_fs,
+#ifdef CONFIG_LIVEUPDATE
+	.preserve = intel_iommu_domain_liveupdate_preserve,
+#endif
 };
 
 const struct iommu_domain_ops intel_ss_paging_domain_ops = {
@@ -4485,6 +4488,9 @@ const struct iommu_domain_ops intel_ss_paging_domain_ops = {
 	.iova_to_phys = intel_iommu_iova_to_phys,
 	.free = intel_iommu_domain_free,
 	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency_ss,
+#ifdef CONFIG_LIVEUPDATE
+	.preserve = intel_iommu_domain_liveupdate_preserve,
+#endif
 };
 
 const struct iommu_ops intel_iommu_ops = {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 3056583d7f56..6b69232efffd 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1345,6 +1345,10 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
 	return 0;
 }
 
+#ifdef CONFIG_LIVEUPDATE
+int intel_iommu_domain_liveupdate_preserve(struct iommu_domain *domain);
+#endif
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
 struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index d73d780d7e19..a15feef4d9ca 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -9,6 +9,14 @@
 #include <linux/liveupdate.h>
 #include <linux/module.h>
 
+#include "iommu.h"
+
+int intel_iommu_domain_liveupdate_preserve(struct iommu_domain *domain)
+{
+	pr_warn("Not implemented\n");
+	return 0;
+}
+
 static int intel_liveupdate_prepare(struct liveupdate_subsystem *handle, u64 *data)
 {
 	pr_warn("Not implemented\n");
-- 
2.51.0.536.g15c5d4f767-goog


