Return-Path: <linux-kernel+bounces-776556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A78B2CEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E608A7B81CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A83277BC;
	Tue, 19 Aug 2025 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gnL3s3Bj"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8C31DDAD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640364; cv=none; b=mW3iQJeH+zka2ZwfSMgUIdrOP4tr9Rj0o3gB6DQkLUxWfFBBATh/Vl6wy88B/HXFINEi/GOjuijUcQqdVQ7fdy2nIfgVC/5zFeJd1w+yYbFhimtwaku2KKn95+BblMD6L7s+JmTd1FsUSPOIGPQxQYO+mdlLLeaDJN/Y0Xvw/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640364; c=relaxed/simple;
	bh=3hKxHuU/XBxBW6Fz378wf7Rbaz+dVXKNYo3PuthQO9w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YpcSdCHWV3Q63/j0Wz45RZoibylDWG42psw/aNaDmbLQ/+lRf6kX7FwSA7/1594V/wL15923MkPQ73pggtkyjMSRocIPWTjlUUf9ScDTYnremXXx4s2t/YfsVMP0JOHEeJPBlrY8CjnqJukm8zd8FFanIFF7+j5gwmdQPE+ZMLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gnL3s3Bj; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3bb2fb3a489so2712236f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640361; x=1756245161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=No5rZzETEpiSYrnAp/3rx5tnKsAcr1mN2J0hRF7T4gc=;
        b=gnL3s3BjUW9rL9hW/oo0fzhXa2d4CvS1OLnvLVU/ZhXaqzLA4LUbRS5bKRbqecUJta
         Gvc6HBsKpE79KVDqbFYns3AP1wkgKP27mq+CtPKYdBmdwoC85rWY9gO2515cZPZMS8UJ
         VWOoLWq7nq4rYCwCrM/ovgqqj7IFcFJTI5ymg/SkGMqp7FVszhiiubxK+Gt+wwFEEl3E
         tSB1gVpJK1621LjTnqthMZPb+fN3pFiVRiaMs2e4g5pZg6Y2qkcYXFiwK8izDtoihneP
         WzYQ1f8zTzFJ84A7UFxJfDJ6TVRXZqIvjCDueV57adt3HCBZ6pzaFwmRJZ5+XQvHSedY
         IAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640361; x=1756245161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=No5rZzETEpiSYrnAp/3rx5tnKsAcr1mN2J0hRF7T4gc=;
        b=jca6psYF52xCiqkKN3Ed538e7tpUa9HSQlSG7zXMjsgyZbAWd6pv1BOgpU5SkbGFJb
         niT/e8AfMRmwmb029imn5/DHu/ynpPTTlLgST1Z+w/OtDAiACHfNp+/0Ouv3CnLVrSXf
         GwILqDaY3ANCqrxOd1bO/Dp02PxpgQmKzozRD5hUZz8bcQTxrpp1PSppxnt6KQ9cWxaz
         lfvEWDT25VFKe9kdBA02uwVZa3mE6Ku88I5y+PveyqyvczxkG0fOFu6QLZOlvlc2Gyns
         qRytfHFTrqRMCJ94NXs8qs2R+/oVVbes5ycGOmFMVutG/ujla/TB48ubH5qbkZo0coLs
         6dyw==
X-Gm-Message-State: AOJu0Yw6aXsrRE9uluTsCdvK52ZIQ0/I9bXxaQTbkJAfK8x/AhXgsr1i
	QfWFJ+/lStEpwoN05HLs7ulYQUDDHUPyqe7rg+z39zqQoR7BBXjK9q1//1uY6ZXHspqqgPzLdVn
	SjTgzwn7zTt0B2g0O+fQ8iG5djZ3JMtUScbuXIMUTnfQNK7X9UpT7aBCPdyGGcewZ9Ip9BfkbX/
	dkfQbz9JtL3exHmmsJxRsEtIU2pqDsAzCjXqiJJB/J2Nkkq1IB3wHmJNI=
X-Google-Smtp-Source: AGHT+IFejZ2I69Eqlg88g8PwiPvQhSLUEBHZrSmUeIH84olhnRxAOXDRbUsOIXtbc95r4ewB/WJLIdwuVFgT6Q==
X-Received: from wmbdw4.prod.google.com ([2002:a05:600c:6384:b0:459:dcf5:1b54])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:22c5:b0:3b8:f863:672c with SMTP id ffacd0b85a97d-3c32e13359bmr316604f8f.33.1755640360470;
 Tue, 19 Aug 2025 14:52:40 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:45 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-18-smostafa@google.com>
Subject: [PATCH v4 17/28] iommu/arm-smmu-v3-kvm: Take over SMMUs
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Donate the array with SMMU description to the hypervisor as it
can't be changed by the host after de-privileges.

Also, donate the SMMU resources to the hypervisor.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 81 ++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index fa8b71152560..b56feae81dda 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -7,15 +7,94 @@
 #include <asm/kvm_hyp.h>
 
 #include <nvhe/iommu.h>
+#include <nvhe/mem_protect.h>
 
 #include "arm_smmu_v3.h"
 
 size_t __ro_after_init kvm_hyp_arm_smmu_v3_count;
 struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
 
+#define for_each_smmu(smmu) \
+	for ((smmu) = kvm_hyp_arm_smmu_v3_smmus; \
+	     (smmu) != &kvm_hyp_arm_smmu_v3_smmus[kvm_hyp_arm_smmu_v3_count]; \
+	     (smmu)++)
+
+/* Transfer ownership of memory */
+static int smmu_take_pages(u64 phys, size_t size)
+{
+	WARN_ON(!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size));
+	return __pkvm_host_donate_hyp(phys >> PAGE_SHIFT, size >> PAGE_SHIFT);
+}
+
+static void smmu_reclaim_pages(u64 phys, size_t size)
+{
+	WARN_ON(!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size));
+	WARN_ON(__pkvm_hyp_donate_host(phys >> PAGE_SHIFT, size >> PAGE_SHIFT));
+}
+
+/* Put the device in a state that can be probed by the host driver. */
+static void smmu_deinit_device(struct hyp_arm_smmu_v3_device *smmu)
+{
+	int i;
+	size_t nr_pages = smmu->mmio_size >> PAGE_SHIFT;
+
+	for (i = 0 ; i < nr_pages ; ++i) {
+		u64 pfn = (smmu->mmio_addr >> PAGE_SHIFT) + i;
+
+		WARN_ON(__pkvm_hyp_donate_host_mmio(pfn));
+	}
+}
+
+static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
+{
+	int i;
+	size_t nr_pages;
+
+	if (!PAGE_ALIGNED(smmu->mmio_addr | smmu->mmio_size))
+		return -EINVAL;
+
+	nr_pages = smmu->mmio_size >> PAGE_SHIFT;
+	for (i = 0 ; i < nr_pages ; ++i) {
+		u64 pfn = (smmu->mmio_addr >> PAGE_SHIFT) + i;
+
+		/*
+		 * This should never happen, so it's fine to be strict to avoid
+		 * complicated error handling.
+		 */
+		WARN_ON(__pkvm_host_donate_hyp_mmio(pfn));
+	}
+	smmu->base = hyp_phys_to_virt(smmu->mmio_addr);
+
+	return 0;
+}
+
 static int smmu_init(void)
 {
-	return -ENOSYS;
+	int ret;
+	struct hyp_arm_smmu_v3_device *smmu;
+	size_t smmu_arr_size = PAGE_ALIGN(sizeof(*kvm_hyp_arm_smmu_v3_smmus) *
+					  kvm_hyp_arm_smmu_v3_count);
+
+	kvm_hyp_arm_smmu_v3_smmus = kern_hyp_va(kvm_hyp_arm_smmu_v3_smmus);
+	ret = smmu_take_pages(hyp_virt_to_phys(kvm_hyp_arm_smmu_v3_smmus),
+			      smmu_arr_size);
+	if (ret)
+		return ret;
+
+	for_each_smmu(smmu) {
+		ret = smmu_init_device(smmu);
+		if (ret)
+			goto out_reclaim_smmu;
+	}
+
+	return 0;
+
+out_reclaim_smmu:
+	while (smmu != kvm_hyp_arm_smmu_v3_smmus)
+		smmu_deinit_device(--smmu);
+	smmu_reclaim_pages(hyp_virt_to_phys(kvm_hyp_arm_smmu_v3_smmus),
+			   smmu_arr_size);
+	return ret;
 }
 
 static void smmu_host_stage2_idmap(phys_addr_t start, phys_addr_t end, int prot)
-- 
2.51.0.rc1.167.g924127e9c0-goog


