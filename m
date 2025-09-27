Return-Path: <linux-kernel+bounces-835106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D49BBA644D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 00:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A32F18973D3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC88B23D2B4;
	Sat, 27 Sep 2025 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1JN/gvF8"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551C23A995
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759012815; cv=none; b=p5OoEq+mYhdZYbJCm4zB337WD8bbHDM5YsH0yvfeMiK3RI++Xx0nYPdNlsTu5UBrva0Hxsnl0uEVkrEWaeDIdDTsYuklSUKL6lmuvmIVXXuWv/kQ/3QS2Z/Omb75QFq6o3Rfo2HLoLYSi2NHBrP2CKA4SqF+69Vh/FQQMZFRg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759012815; c=relaxed/simple;
	bh=b/oNVW2/yDoFBqwXnNKcqDo98sE8Dwz/kzjEHnPaqLI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jVgixzyLEze93eVM8dKyrLbMEV4fnD/eAnBoL5d93t4JxbUdOX48eUaWL0i++4n7hbD+YcHmdWIG1v52D6+ARaOqK/rpxY+97REJIvhN+GIeSupCRpex5tYtCs3uWpT/FZa/cs9Vf0f35P9Y35rBfppXDfK+BZTqs8oZQoRvN2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1JN/gvF8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-27eca7298d9so68359785ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759012813; x=1759617613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Q4ctgw3TCRfxdQOeE/B58PrVob15spvvnivVaYg/9A=;
        b=1JN/gvF8duZYHcD6ighCRIVc+z0kXOBme5YwHmpoC9ZBqTqK5uha+rZ8SoXwWXy9I2
         Il1jPgKnvTLckx7OJFN9CFYmlTUSrZ2aKhlC0xjNqa0Hla6dKYuoIlGX9ELGb6Smw+QK
         ihD6K/CzU0fUehmGTecBrEj4OdeZ2M9LqgAN1FkYMacJzDGGtDDKrhNBcx0BwRxv1YcG
         woSF1p1QIMM6l2hy2Fp/60bKidQIW+M20y8CC15b/AJhpon6FDavsGY6lSyQzYyeDBEI
         nb93Ugsqw8rsirrZJo4PNqoy7X+miU+IgSNoAvPlIaqO4rFFRNMWC8lcX3f/oUmMoGs5
         rlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759012813; x=1759617613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Q4ctgw3TCRfxdQOeE/B58PrVob15spvvnivVaYg/9A=;
        b=CYMsXKdwKovos+AHBnprvR+UlGFWyVzNqCcwyCOTR1tPxewzp9CE4Z4Wc+Tk8cf7hq
         xU2Ba75dN6j1mqbINDBw0EHyWysdS/ANYDnH7gYmxZ8kPDMKnIA2ivjHtNc2Fr9kn58c
         QQMJiv6TrAa6d4j1CMmAdIUukbYZKLSq14IaZGG54DWGFxolxYt984nR2IPIqjHlqDg8
         gsVJCsYhlSrE8K2UzkWwREQJTMOKuOrGIQ2tUeBXt2B8/ecI0yC9c7sTaT7iHpYb0PIW
         i4rLyHmE3wb8IVkhHf5Sgm36Y5zwa6U9yZFmFyDTQ2vdzc+eZGqxXXAEHia/VgKPeyUW
         8ApA==
X-Forwarded-Encrypted: i=1; AJvYcCW+FAFykxg55gr4tp6ssp/lEB/0aBMOCxRHCzIoAbnJK1N3gx2rktGxZJL7NlFQVXnFwTzaRi1fwuqFuxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNkwlB3ZN3X1oM1NOqtl5tv5XhnWQ0BY0Tk8THKsFSM6XcIjN
	yBd5FdnjkqBg0JQLLp38MhQ49e84di6EBiheze4WuQ+TF2eqOCTDUz7NDfORplFLi5F9kmO11zB
	hwXXXL45+iA+7cTNU0gvQmkAgCw==
X-Google-Smtp-Source: AGHT+IGYiMn3jieoglt5EaDwtTABS1lQ7XOYjstaJzvmaH1fcBe9vU372TzFLpDxOPfBcxSuOS8Twkd59UTtaIkCkg==
X-Received: from plau15.prod.google.com ([2002:a17:903:304f:b0:26a:e046:7605])
 (user=danielmentz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e946:b0:269:6052:3536 with SMTP id d9443c01a7336-27ed4a4937dmr133470415ad.45.1759012812970;
 Sat, 27 Sep 2025 15:40:12 -0700 (PDT)
Date: Sat, 27 Sep 2025 22:39:53 +0000
In-Reply-To: <20250927223953.936562-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927223953.936562-1-danielmentz@google.com>
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250927223953.936562-2-danielmentz@google.com>
Subject: [PATCH 2/2] drivers/arm-smmu-v3: Implement .iotlb_sync_map callback
From: Daniel Mentz <danielmentz@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement .iotlb_sync_map callback based on the new callback in the
io-pgtable code.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2a8b46b948f0..0ffcc6c8e4bf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2541,6 +2541,7 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= smmu->pgsize_bitmap,
 		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
+		.defer_sync_pte	= true,
 		.tlb		= &arm_smmu_flush_ops,
 		.iommu_dev	= smmu->dev,
 	};
@@ -3366,6 +3367,18 @@ static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
 	return ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot, gfp, mapped);
 }
 
+static int arm_smmu_iotlb_sync_map(struct iommu_domain *domain,
+				    unsigned long iova, size_t size)
+{
+	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
+
+	if (!ops || !ops->iotlb_sync_map)
+		return 0;
+
+	ops->iotlb_sync_map(ops, iova, size);
+	return 0;
+}
+
 static size_t arm_smmu_unmap_pages(struct iommu_domain *domain, unsigned long iova,
 				   size_t pgsize, size_t pgcount,
 				   struct iommu_iotlb_gather *gather)
@@ -3700,6 +3713,7 @@ static const struct iommu_ops arm_smmu_ops = {
 		.map_pages		= arm_smmu_map_pages,
 		.unmap_pages		= arm_smmu_unmap_pages,
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
+		.iotlb_sync_map		= arm_smmu_iotlb_sync_map,
 		.iotlb_sync		= arm_smmu_iotlb_sync,
 		.iova_to_phys		= arm_smmu_iova_to_phys,
 		.free			= arm_smmu_domain_free_paging,
-- 
2.51.0.570.gb178f27e6d-goog


