Return-Path: <linux-kernel+bounces-776557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CC8B2CEC6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698832A8204
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2FE334383;
	Tue, 19 Aug 2025 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aS/LaW+9"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70B3570A4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640365; cv=none; b=b6VoKHEFX9bnZTM6CMWkR1y1D8AcKwDILblocN1YGMhYTvuH3mlvSojcXjF9gP5iFZLMoge6LOaUAkmNuq0suSMbXVdlwT+YcIh+V5B7ECwHGI3ObfZwh+5+27fzQoV3zCtOXpt05dCi6dTwgGyVOa1sK8s7GMV0JrmICpVEDhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640365; c=relaxed/simple;
	bh=cLjOanwFCYbBZ+DeQcNx28zYJugfOvEDf7zTDH1asV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lThF9TWJE8akN8mQHN1961EENrc1N1yM2Yxe5gmJpR1b46z08GVp3e0rr8WOCDlFkDq6DQTcFwiyT/g0Rks5BuDRPBv5H1ny826eq6erKe0oko45vl9m+Viy/ouI3ufXDqdqIRmB5mMoKr2Hz4aP1ULWmqq2ZucxNdJN1Lwct7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aS/LaW+9; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b9e418aab7so2448251f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640362; x=1756245162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y1XMrJFUsZlHqUSwfaqqxufwXrUFJ8lXJIFDET8NUKg=;
        b=aS/LaW+9jY+USyVRl2CiCUNy8cJs/8afqFCdSAB/t9ppzKlHdlj8AtYi7nDcrA99fC
         tV+pymMtc2naQrNNsu6nvpIjhcVDQAIR6PCDw/JD6LsOINJTo23VmDHKpRLBnuGwBc5/
         xdL6rMl8QUYIzoqZd01YdVhx/zm6IjHB3QDwEpXFgYwIAnEd0Gf1w53q9uPbHG607cxO
         wckRJx22SnaEaWWqLUVwxt3M7hWkTBAe0jCh2gH34dq3Bb70IAU1l6WXjRdTwD9eEyB6
         NTyc4IDcp8jmWo9ReZI8nT/PsdwqqqPXl8IILbPkyI68idGq2sjsfrqoVgFYzKQ3Js14
         AN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640362; x=1756245162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1XMrJFUsZlHqUSwfaqqxufwXrUFJ8lXJIFDET8NUKg=;
        b=ZNL4Hwz882kEXvsDGV+8NIs5hsBFfTxWBgfdNbs+4DQZmljgxpVyE0I512Rws02hQv
         A3k0QWbY3UKigJTAGZe/pTJ0jkn84iPeOgqvNUbILjWs2eiFBVW19eV2j4ba1OLowVMz
         2jqUAJofHx/2ySRX3QAvkq6zgh6FnrDajeBCUtAgWany5Uc0FFjaDf5viT9uBWN93JVc
         LDRz8lrzgocPqWElC0TIXks9rts4c5ByejBD1qEgxJ8XgXGJFhszMz6YrE/jrS88dSzt
         d2bZbnpf3EKX/nZJ+C/OmG4zyie915Uk/sq7LbLD06OMFuIcwJJOl7j//0ISni6aleHr
         m/Mw==
X-Gm-Message-State: AOJu0YyBrdKsDrmqTpnM6agHIvTOZj39Cd/5LNUIE5YVkjBrN9Jh0i92
	SzxhjlbyuwAppUY8PU3Y+b/iSzGbSPldI3EBNHpL4g/n1+PP98NtQ9D/iX4c+eH8pl2xuR/0LXM
	u4tdWT0OK1z761p58E/iMAKXwy5+5rGwM/JpXhWjk6Joh+IOg2haXlUwDU+cgwn2ZwtbtGAGEIn
	4njF7WEkdiPVxYwvBnfZx36lpWt6CXnnQmNhR6CJQPI9ft7hDynwAa9AQ=
X-Google-Smtp-Source: AGHT+IGRK4bp6sesJCXzi77ty+REwj3D43YiESI0ZMsE4l0swwRaEoRodh4XIVE78li6aGNDnGWJRk469Etvfw==
X-Received: from wrqf13.prod.google.com ([2002:adf:f8cd:0:b0:3b7:8aed:a63d])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2309:b0:3b7:54b3:c512 with SMTP id ffacd0b85a97d-3c32e7fe680mr338963f8f.58.1755640361697;
 Tue, 19 Aug 2025 14:52:41 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:46 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-19-smostafa@google.com>
Subject: [PATCH v4 18/28] iommu/arm-smmu-v3-kvm: Probe SMMU HW
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Probe SMMU features from the IDR register space, most of
the logic is common with the kernel.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 57 ++++++++++++++++++-
 .../iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h  |  8 +++
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 8ffcc2e32474..f0e1feee8a49 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -48,6 +48,7 @@ struct arm_smmu_device;
 #define IDR0_S2P			(1 << 0)
 
 #define ARM_SMMU_IDR1			0x4
+#define IDR1_ECMDQ			(1 << 31)
 #define IDR1_TABLES_PRESET		(1 << 30)
 #define IDR1_QUEUES_PRESET		(1 << 29)
 #define IDR1_REL			(1 << 28)
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index b56feae81dda..e45b4e50b1e4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -10,6 +10,7 @@
 #include <nvhe/mem_protect.h>
 
 #include "arm_smmu_v3.h"
+#include "../arm-smmu-v3.h"
 
 size_t __ro_after_init kvm_hyp_arm_smmu_v3_count;
 struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
@@ -45,9 +46,56 @@ static void smmu_deinit_device(struct hyp_arm_smmu_v3_device *smmu)
 	}
 }
 
+/*
+ * Mini-probe and validation for the hypervisor.
+ */
+static int smmu_probe(struct hyp_arm_smmu_v3_device *smmu)
+{
+	u32 reg;
+
+	/* IDR0 */
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
+	smmu->features = smmu_idr0_features(reg);
+
+	/*
+	 * Some MMU600 and MMU700 have errata that prevent them from using nesting,
+	 * not sure how can we identify those, so it's recommended not to enable this
+	 * drivers on such systems.
+	 * And preventing any of those will be too restrictive
+	 */
+	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1) ||
+	    !(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
+		return -ENXIO;
+
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR1);
+	if (reg & (IDR1_TABLES_PRESET | IDR1_QUEUES_PRESET | IDR1_REL | IDR1_ECMDQ))
+		return -EINVAL;
+
+	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
+	/* Follows the kernel logic */
+	if (smmu->sid_bits <= STRTAB_SPLIT)
+		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
+
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
+	smmu->features |= smmu_idr3_features(reg);
+
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
+	smmu->pgsize_bitmap = smmu_idr5_to_pgsize(reg);
+
+	smmu->oas = smmu_idr5_to_oas(reg);
+	if (smmu->oas == 52)
+		smmu->pgsize_bitmap |= 1ULL << 42;
+	else if (!smmu->oas)
+		smmu->oas = 48;
+
+	smmu->ias = 64;
+	smmu->ias = min(smmu->ias, smmu->oas);
+	return 0;
+}
+
 static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 {
-	int i;
+	int i, ret;
 	size_t nr_pages;
 
 	if (!PAGE_ALIGNED(smmu->mmio_addr | smmu->mmio_size))
@@ -64,8 +112,13 @@ static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 		WARN_ON(__pkvm_host_donate_hyp_mmio(pfn));
 	}
 	smmu->base = hyp_phys_to_virt(smmu->mmio_addr);
-
+	ret = smmu_probe(smmu);
+	if (ret)
+		goto out_ret;
 	return 0;
+out_ret:
+	smmu_deinit_device(smmu);
+	return ret;
 }
 
 static int smmu_init(void)
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
index 744ee2b7f0b4..3550fa695539 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
@@ -12,12 +12,20 @@
  *
  * Other members are filled and used at runtime by the SMMU driver.
  * @base		Virtual address of SMMU registers
+ * @ias			IPA size
+ * @oas			PA size
+ * @pgsize_bitmap	Supported page sizes
+ * @sid_bits		Max number of SID bits supported
  */
 struct hyp_arm_smmu_v3_device {
 	phys_addr_t		mmio_addr;
 	size_t			mmio_size;
 	void __iomem		*base;
 	u32			features;
+	unsigned long		ias;
+	unsigned long		oas;
+	unsigned long		pgsize_bitmap;
+	unsigned int		sid_bits;
 };
 
 extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
-- 
2.51.0.rc1.167.g924127e9c0-goog


