Return-Path: <linux-kernel+bounces-748455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEC2B14178
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D54E67A996E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5464127510F;
	Mon, 28 Jul 2025 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jpOA/iuS"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D0277C9E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725221; cv=none; b=YuhOXAuaESYNWgnRoM1ATpqSPvQcMTU4plqQY0J/+pXXG/KwkcgCtlO3EMhU/k4B37dr8JHFgeTjbVs5EygQfPcO7q4o85iZ4zdPdZbH33oxUlD/r+dZLjDRQNEp4e1whTYATZ5GVKr6OpzINsTs21Bxde2vIGPbqyiEcve41qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725221; c=relaxed/simple;
	bh=cc4qIV7R4IboXoEryrgrWSTN4pA0n7UvacWmOG9Xt0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RzhUstk+ZIPlqxH8MSKwI1+6BIVANnCukqupXdaYb6d0wurEysTOMVm1ajiHl9xsW5Kpd+qCZYXfSrnR4G5LMz1zGQG650kabJHO6tnPpHmdq65Z4JdCYBxwIELtLg0Jj/yTSbGCTn00NejD8yHO9HstsMMpYWPvWBDetn95FAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jpOA/iuS; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-61525af8a0bso1818648a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725218; x=1754330018; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R18CRwRipna7yM1UAYryO2eun2b5lSz7TequZZhl+Fo=;
        b=jpOA/iuS3CoahCz8ZZHW1ZRmwBgtO1tiGWNVYw4XL8IXy7axBH9RbyZ+Up4t7JDmdY
         XptzuryZtewBFsplLtPxLPOHwsy79alGIcbLhMyQXFL4zlspMbNxPfl2kEvc/EGWg6RT
         nMHQGqAUbHPZcYNsPykg6wRyEDfgqLoiLug81J1b/awGhrIM9w+r+tA59JIA8YnBGXaO
         yqzj044/xzhFThOPpFNJUXUARipFPWpHJ6zNzmBzB6258GjSbClG/ZkroylesQTPuDOS
         vKJ395sJTg/x/S1KEZZkzlwkJWJp8h5fvBdTqvJINA2rQ4DT+cadYM1KPKf+Fi2f6u/z
         ILxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725218; x=1754330018;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R18CRwRipna7yM1UAYryO2eun2b5lSz7TequZZhl+Fo=;
        b=FAhxor8R5GhNdSKN2BMYtJVUW0MgUuE0pnNFpxOD5GvamSDTR+mFmOUQR6/0iCGSri
         SG80z5mjzCtnXa4LXf4lTxkcYzJuvqwGhnU/Uw/e4y4y1LsfafgfY372TdCxoGllbAN3
         4CWa0WUaPNv+Y/vaZcGOBE+MFNrjL3p3MLbI+tXb0FYg9D6QUD3MOiMaefULRwdbs9kB
         ZPJMxmOCofTU25TRPokd/K1z2VO0bztkdEyOXobA9Peb4KTGPDbTfbZoTnaEZRVdwt9i
         D+88t0RUsirlh+YsE0JGCe/NvHeZL9sq6xOs7YIlLNTRX1he+tWAYf02jcMEeQ/MXRGO
         iPUQ==
X-Gm-Message-State: AOJu0Yw+QBbA4HoR10xqNEQrt+femSX1dw4XhuhE7De7xgg2+8ouhGCa
	jXK+I+2e3iwV/Q9w6Y+yWOVNGYhtN1oGBWL8d27LtKs9+OftN+XPlUAHz3D78lOCvsEjPda2dJW
	SYFJmoeMER+hAx0qknwwFqP1LvXTHHCKnps0GxkuTc+224tFJIRrqSzUxCsUI7hKCKrBKijZ++q
	MpG4mOjZVbyb5uRLJ/IEwjizt6Co3n/3gvcTVQexGPrAzfzOCfMOm7Rc4=
X-Google-Smtp-Source: AGHT+IGIrNMQeE/kWCI/brr7kS87BOY/bq6CCQ1xjchC98i6bmhfhF9J/7LevHBGbUwRoLbmWwCwzxtv61jC5A==
X-Received: from eddf14.prod.google.com ([2002:a05:6402:354e:b0:612:c149:d25d])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:268f:b0:60c:9d90:93c7 with SMTP id 4fb4d7f45d1cf-614f1f12240mr12562721a12.34.1753725217591;
 Mon, 28 Jul 2025 10:53:37 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:52:54 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-8-smostafa@google.com>
Subject: [PATCH v3 07/29] iommu/arm-smmu-v3: Extract driver-specific bits from
 probe function
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

As we're about to share the arm_smmu_device_hw_probe() function with the
KVM driver, extract bits that are specific to the normal driver.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 10cc6dc26b7b..801b792dda36 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4353,7 +4353,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	if (reg & IDR0_MSI) {
 		smmu->features |= ARM_SMMU_FEAT_MSI;
-		if (coherent && !disable_msipolling)
+		if (coherent)
 			smmu->options |= ARM_SMMU_OPT_MSIPOLL;
 	}
 
@@ -4504,11 +4504,6 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		smmu->oas = 48;
 	}
 
-	if (arm_smmu_ops.pgsize_bitmap == -1UL)
-		arm_smmu_ops.pgsize_bitmap = smmu->pgsize_bitmap;
-	else
-		arm_smmu_ops.pgsize_bitmap |= smmu->pgsize_bitmap;
-
 	/* Set the DMA mask for our table walker */
 	if (dma_set_mask_and_coherent(smmu->dev, DMA_BIT_MASK(smmu->oas)))
 		dev_warn(smmu->dev,
@@ -4522,9 +4517,6 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	arm_smmu_device_iidr_probe(smmu);
 
-	if (arm_smmu_sva_supported(smmu))
-		smmu->features |= ARM_SMMU_FEAT_SVA;
-
 	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
 		 smmu->ias, smmu->oas, smmu->features);
 	return 0;
@@ -4794,6 +4786,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (arm_smmu_sva_supported(smmu))
+		smmu->features |= ARM_SMMU_FEAT_SVA;
+
+	if (disable_msipolling)
+		smmu->options &= ~ARM_SMMU_OPT_MSIPOLL;
+
+	if (arm_smmu_ops.pgsize_bitmap == -1UL)
+		arm_smmu_ops.pgsize_bitmap = smmu->pgsize_bitmap;
+	else
+		arm_smmu_ops.pgsize_bitmap |= smmu->pgsize_bitmap;
+
 	/* Initialise in-memory data structures */
 	ret = arm_smmu_init_structures(smmu);
 	if (ret)
-- 
2.50.1.552.g942d659e1b-goog


