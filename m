Return-Path: <linux-kernel+bounces-835546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756F2BA76AB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24E37A53EF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7FD26A0C6;
	Sun, 28 Sep 2025 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOWhe5tY"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47DF269D06
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086475; cv=none; b=OFnT1E7xRubExUlvEt0u363mNQ7RKfj7Rdpx4ScLaLoyjL+Rcvh7hhoJWmtLSCiQJhObdbNw3QzVcHGWjmruohUn7jqspdwDPlp9qD7b8q2dxwYpIykLmc9H6xwalFxUd6KqXZfx0DOc0UKrx4R9JdU9UBcEXNbH9wDUr/hg87U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086475; c=relaxed/simple;
	bh=QR2Gs/iwXVTCtcLMACOzt1mygqy+KIwEpFthZZnCaC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tN0RsExJl608HvwFJGZlxh2LQkTzj/JkSYTDPIsLgXgrQ34PMU/K/KBN++DLasnwCl5S3aEWH4S518gP3LRqOvw0jJdVbv4AJt8Spc0+UWZjTdDLDCR82JnzvxNWxo3XSUNcWbVr1Bq5cRf36QFkRKArn4DlP8GfpAnmtHuB6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOWhe5tY; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-780fb254938so3219005b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086473; x=1759691273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QcKsX07BcsLgJUGWNvmQKTHOi+pK9yuzTPJl0W1HDJo=;
        b=MOWhe5tYuT3LEn+MDfpHj3DlqZTURsmJpmWt+ql9+jF2Tdu6b8jiPDFC+8lwBUap8c
         o62kPy+97VRcWCkYYgd96Dqt2Mu0NV5nECHJ7+xodthXd4sQ9otWvDimUi75XjHP2mo+
         I5goS+20xwZhjpb16MgNW4DlUHnocw+JrZ9+Gkk3RKeLM24vk/4NmiOqSHhqi7fjLHb9
         bycdxLtasIE8Xy6ifArmEiGNAlVR5NoOkoWt/ygOvGewpj0yA1oFMVRAE+Jqbdtt1fyp
         F9vBv+isApQioa4bJ/Bu1I3kZ9yLUXk0rmwWiDc33UuzwIBdWPbh2lNLTu7LgDY2iBU0
         fI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086473; x=1759691273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcKsX07BcsLgJUGWNvmQKTHOi+pK9yuzTPJl0W1HDJo=;
        b=X6enHpH1D0vKcUCILGZh5QFmJ8x/hIXSi9Wle3tfk/TE0D8t/gCLSaWv2/7OKWg+84
         Xj5TgNDwf5swEgngkJIidLf3iAikWOUBpwoFFhJzK4NVTd2ueOBD0kuiCSUEYfGU+lt8
         haVqrvY7BV4Wrq/h4GouF6WSlsh0/b1yLHuOcom5I6YVHE94ia3NeWDvxTuVWn/3LgtT
         t89Ul34ibEiaEEnc2Ww0q7uTWgaE4pLRA8c+Ywn1jwOqG5JmcqYnZ/cijKYh+HJ+6EP6
         7pYO1Vwg+w5AnOSOIDrxpcm2ET8PS4ScgfmMkZizxfbfBrUJu3Vai863xQ0Nzp4F+XJ8
         y+vw==
X-Forwarded-Encrypted: i=1; AJvYcCUZnTwGlzLAm7BE4FdXxAn7EvoML9KFi7h9VXb8vusgEWjbEqqW5JPeW0uP5IeOvPcSyO9ZZTBNwc26JlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyle0ol4S9hK7yHKBxyb3KjdBLtMV3D8NuNZtZu9vE67cq9J5tJ
	EkBf1z56icFbQKAQTR11z/HuxlswVBhuVJ4XcJIKzZB7sUyRjMgetIEuet/j8V51hqEDD+zlemL
	seS3lvjK9UkrKnQ==
X-Google-Smtp-Source: AGHT+IGFAKSNmw8iYSKRrK9GJvSB49WtExb49RjLckPU3ZxW1Xt1iEJUBMJZeDOD3UW4tcj2DZSh10gOcwSWPA==
X-Received: from pfbf6.prod.google.com ([2002:a05:6a00:ad86:b0:77c:37c1:4bef])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:6d5a:20b0:782:ec0f:d279 with SMTP id d2e1a72fcca58-782ec0fd804mr2724979b3a.10.1759086473198;
 Sun, 28 Sep 2025 12:07:53 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:16 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-9-skhawaja@google.com>
Subject: [RFC PATCH 08/15] iommu/vt-d: Implement live update preserve_iommu_context
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

Add implementation of preserve_iommu_context to preserve the root_table
and the associated context tables. Also mark the iommu unit as
preserved.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      |  2 -
 drivers/iommu/intel/iommu.h      |  1 +
 drivers/iommu/intel/liveupdate.c | 80 +++++++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7035ffca020f..caac4fd9a51e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -67,8 +67,6 @@ static int force_on = 0;
 static int intel_iommu_tboot_noforce;
 static int no_platform_optin;
 
-#define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
-
 /*
  * Take a root_entry and return the Lower Context Table Pointer (LCTP)
  * if marked present.
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 93ac55eb49f0..273d40812d09 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -556,6 +556,8 @@ struct root_entry {
 	u64     lo;
 	u64     hi;
 };
+
+#define ROOT_ENTRY_NR (VTD_PAGE_SIZE / sizeof(struct root_entry))
 
 /*
  * low 64 bits:
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 94aabf025a60..fb214736aa3c 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -59,11 +59,87 @@ static int preserve_device_state(struct pci_dev *dev, struct device_ser *ser)
 	return 0;
 }
 
+static int unpreserve_iommu_context(struct intel_iommu *iommu, int end)
+{
+	struct context_entry *context;
+	int i;
+
+	if (end < 0)
+		end = ROOT_ENTRY_NR;
+
+	for (i = 0; i < end; i++) {
+		context = iommu_context_addr(iommu, i, 0, 0);
+		if (context)
+			WARN_ON_ONCE(kho_unpreserve_folio(virt_to_folio(context)));
+
+		if (!sm_supported(iommu))
+			continue;
+
+		context = iommu_context_addr(iommu, i, 0x80, 0);
+		if (context)
+			WARN_ON_ONCE(kho_unpreserve_folio(virt_to_folio(context)));
+	}
+
+	return 0;
+}
+
+static int preserve_iommu_context(struct intel_iommu *iommu)
+{
+	struct context_entry *context;
+	int ret;
+	int i;
+
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		context = iommu_context_addr(iommu, i, 0, 0);
+		if (context) {
+			ret = kho_preserve_folio(virt_to_folio(context));
+			if (ret)
+				goto error;
+		}
+
+		if (!sm_supported(iommu))
+			continue;
+
+		context = iommu_context_addr(iommu, i, 0x80, 0);
+		if (context) {
+			ret = kho_preserve_folio(virt_to_folio(context));
+			if (ret)
+				goto error_sm;
+		}
+	}
+
+	return 0;
+
+error_sm:
+	context = iommu_context_addr(iommu, i, 0, 0);
+	WARN_ON_ONCE(kho_unpreserve_folio(virt_to_folio(context)));
+error:
+	WARN_ON_ONCE(unpreserve_iommu_context(iommu, i));
+	return ret;
+}
+
 static int preserve_iommu_state(struct intel_iommu *iommu,
 				struct iommu_unit_ser *ser)
 {
-	pr_warn("Not implemented\n");
-	return 0;
+	int ret;
+
+	spin_lock(&iommu->lock);
+	ret = preserve_iommu_context(iommu);
+	if (ret)
+		goto error;
+
+	ret = kho_preserve_folio(virt_to_folio(iommu->root_entry));
+	if (ret) {
+		unpreserve_iommu_context(iommu, -1);
+		goto error;
+	}
+
+	ser->phys_addr = iommu->reg_phys;
+	ser->root_table = __pa(iommu->root_entry);
+	atomic_set(&iommu->preserved, 1);
+error:
+	spin_unlock(&iommu->lock);
+	return ret;
 }
 
 static void unpreserve_state(struct iommu_ser *ser)
-- 
2.51.0.536.g15c5d4f767-goog


