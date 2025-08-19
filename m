Return-Path: <linux-kernel+bounces-776553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC27B2CEC4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19BC87B76D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3709031DDAF;
	Tue, 19 Aug 2025 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRdtOuyN"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C93054CA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640361; cv=none; b=EHqO9FmYzRqoL2jY3HWRZB/8HkAxakrf9p1SbRO5OblJZOrIUVNZdSfBMs8u2hbkT/3dw3n46WLTGMTPDKkTGM1LlEivxlAr6T+0Z9NqAbdrSdEDt0WMQ3zA+mtRy5t0OEElWr4lnqJ+ZtYM5cvyfGD5C0y1LxINI3jLcshqI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640361; c=relaxed/simple;
	bh=3r8oXH7nsfm/ONpYF9TIZSokbPzVQMcEKf/AvnlgvDw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=plnCUZnsEadGnzMHynkO3h1mfSAMYzSH7NJ01oWNUrKHqKec+glgWMVSHu0Z0EgQO8zbEjmoap/oIn2VfA3yg74a3Bx5dhb/u5hr1XnF29Z3RaPE7nN8lGgoXL098IS2+0eUAni4sRXwXDIwsSmbJdal9bmibTTGFEhFhJv4Njw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRdtOuyN; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b00352eso22034225e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640357; x=1756245157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X4PaN1FBVh+xdnfphbKwqZhoaGiNxq0bOXNDJ6vx+5U=;
        b=kRdtOuyNL7+JmopG/IhWNHex8pKqAONtnWh7OLIUmBQzFBuCGXasY0xxh1KlMy3lCI
         np38Z+ItsUZzSqFcn91NPkOtDPH91Mw1RT+4IwWaBGyMkeM/cpuWePlrUWd2KC7+rSjc
         qyv4az4vy8UdIIs4w8g/jWnA7v2JSz13cNRTUOZmRYqCEQdWerW4IQAgH7PcYMLgPnMP
         Dj6PcUWaeWbwKOFIypGHN9eCCKAQi2EZPILiB2ggHgjxcuH82uIuA0gxZKm8QavJQuaZ
         r4cXNk4fD3i16Hgpz52+YR9sWeXGTZjxF8NZ+wvoXoF++U2MOyAb1O1jqaYVzrMugQuJ
         hr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640357; x=1756245157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4PaN1FBVh+xdnfphbKwqZhoaGiNxq0bOXNDJ6vx+5U=;
        b=IfI/H9ppJ4m3ARqBSATLb/rb2mU9W0nPNvI7a4bCw4qnLVrqVsNewmZFrwgs8y65tt
         l6bFqiT+ipRqS8BaBren+vQuSFfMKk40HTUwBUBX1u5f+DiZHkHcEgsTgAaOGKfjGX1C
         jw77n2+o9wJlIX+FyCcCGjlNCpRpf1Jr4rgdI1eTzu2XJxKWPYmvOgA8djHBz/JY3NEU
         x0u3knHtel6raK/2fS6DcmLS+mc0Fhfq5YdnU0/CO5m6qt3PXKgP8pyiluVI5Z/SXMYm
         ezSUDVx/ildkNRKYsYBmAicm0fhYB7ZRX2c9AOB6kpWFIg+KG1C5+L8E7I1qFZ0KF8lS
         7mnQ==
X-Gm-Message-State: AOJu0YyMNCrAn8La00AWwfSaOWMMuNayJ3G9yMzKfnmGQbei2QcvYGKx
	7ye3ulHeNYZby5wP1tSib02e5bxC++GkaTkvVGYqTewIzbygvnfZ+054DqnTKGV3mlsL1Zzoklo
	zf2HU5Fxd0nCQLcP6RhzqFPLr5kdXwhodPmkDTLV+aAWlw8w7GN/R6z5ZweNQj5z/j+tMDW362v
	vH398PI0287h6Qe+Pmyd8VWR8enzUiiLNB3tXY0K/2z48N/45vIBTPy0Q=
X-Google-Smtp-Source: AGHT+IFsd9NA8cMc7rDL27Ho1qYY/f8xjo3m+B7JdKk4faCMk1aV/KdUXjy/UILcCgJqjvIHpGxiAh/dHHuItw==
X-Received: from wmcn3-n2.prod.google.com ([2002:a05:600c:c0c3:20b0:45b:4777:8063])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e89:b0:459:e398:ed80 with SMTP id 5b1f17b1804b1-45b47a0700bmr2494445e9.32.1755640357365;
 Tue, 19 Aug 2025 14:52:37 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:42 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-15-smostafa@google.com>
Subject: [PATCH v4 14/28] iommu/arm-smmu-v3: Add KVM mode in the driver
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a file only compiled for KVM mode.

At the moment it registers the driver with KVM, and add the hook
needed for memory allocation.

Next, it will create the array with available SMMUs and their
description.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/include/asm/kvm_host.h             |  4 +++
 arch/arm64/kvm/iommu.c                        | 10 ++++--
 drivers/iommu/arm/arm-smmu-v3/Makefile        |  1 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 36 +++++++++++++++++++
 4 files changed, 49 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index fcb4b26072f7..52212c0f2e9c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1678,4 +1678,8 @@ struct kvm_iommu_ops;
 int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops);
 size_t kvm_iommu_pages(void);
 
+#ifdef CONFIG_ARM_SMMU_V3_PKVM
+size_t smmu_hyp_pgt_pages(void);
+#endif
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/iommu.c b/arch/arm64/kvm/iommu.c
index 5460b1bd44a6..0475f7c95c6c 100644
--- a/arch/arm64/kvm/iommu.c
+++ b/arch/arm64/kvm/iommu.c
@@ -17,10 +17,16 @@ int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops)
 
 size_t kvm_iommu_pages(void)
 {
+	size_t nr_pages = 0;
+
 	/*
 	 * This is called very early during setup_arch() where no initcalls,
 	 * so this has to call specific functions per each KVM driver.
 	 */
-	kvm_nvhe_sym(hyp_kvm_iommu_pages) = 0;
-	return 0;
+#ifdef CONFIG_ARM_SMMU_V3_PKVM
+	nr_pages = smmu_hyp_pgt_pages();
+#endif
+
+	kvm_nvhe_sym(hyp_kvm_iommu_pages) = nr_pages;
+	return nr_pages;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 1918b4a64cb0..284ad71c5282 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -4,5 +4,6 @@ arm_smmu_v3-y := arm-smmu-v3.o arm-smmu-v3-common-hyp.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_IOMMUFD) += arm-smmu-v3-iommufd.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
 arm_smmu_v3-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
+arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_PKVM) += arm-smmu-v3-kvm.o
 
 obj-$(CONFIG_ARM_SMMU_V3_KUNIT_TEST) += arm-smmu-v3-test.o
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
new file mode 100644
index 000000000000..ac4eac6d567f
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pKVM host driver for the Arm SMMUv3
+ *
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+#include <asm/kvm_mmu.h>
+#include <asm/kvm_pkvm.h>
+
+#include <linux/of_platform.h>
+
+#include "arm-smmu-v3.h"
+#include "pkvm/arm_smmu_v3.h"
+
+extern struct kvm_iommu_ops kvm_nvhe_sym(smmu_ops);
+
+size_t smmu_hyp_pgt_pages(void)
+{
+	/*
+	 * SMMUv3 uses the same format as stage-2 and hence have the same memory
+	 * requirements, we add extra 500 pages for L2 ste.
+	 */
+	if (of_find_compatible_node(NULL, NULL, "arm,smmu-v3"))
+		return host_s2_pgtable_pages() + 500;
+	return 0;
+}
+
+static int kvm_arm_smmu_v3_register(void)
+{
+	if (!is_protected_kvm_enabled())
+		return 0;
+
+	return kvm_iommu_register_driver(kern_hyp_va(lm_alias(&kvm_nvhe_sym(smmu_ops))));
+};
+
+core_initcall(kvm_arm_smmu_v3_register);
-- 
2.51.0.rc1.167.g924127e9c0-goog


