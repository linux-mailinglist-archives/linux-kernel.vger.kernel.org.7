Return-Path: <linux-kernel+bounces-748460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 973CAB1417C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F2318826E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D39C27D77A;
	Mon, 28 Jul 2025 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xKzN3LaO"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C827A133
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725226; cv=none; b=tjSRpErDtjyewYC2WjBgTKSGQyq6Dw2fnUHE0pL2ii31Rb08pWbxerAcfh3uNw7YjUjkh7JxhIwf5waNtORdwTaynCYQyTRg3uJxTIq9CH01TYIWblr9l8BuebQmaXQCABTK2lXn4JFOgsl0pgnDAXO8OKYnDGcpMlDh7ZPq+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725226; c=relaxed/simple;
	bh=RxPbPhNqEx9akHkIou9iNguWeMIuxS6YzG17MY3jzBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TTsX7nGfEdSvTNNoBchDPLrVHLy6U8YmErPxvbID4WDZV8HYJ32pVMwXML/l5PcFWwLrgczZa11xRvFaW1a15vPj3guXtD39Fb1KL2asgxFcIOFy6CGruoWsIFBftvWyjzVDVSO2/+hG1m4s9IN0BMdddNltSi8Vf2GU4YyDoSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xKzN3LaO; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ae401eba66aso302741866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725221; x=1754330021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zYSaQxxv0yy3Y7EMVpbwK7SrDhDexuagcipLxM0lKzk=;
        b=xKzN3LaOytIPFNiBS4EXkb03AELuRADTeSaICQBnUp6CFfM2j6fTJDbrhspn7Bx2YT
         TeEj4qRPyLQtkVvUx20CmmNw1oZqUovWPI/PkEDdz5n904O/UyA4zTbgDbdqdfpDM3yo
         yZwh0ehzgC6n9lG7OwJ8Ym+VbM/70Tg3M20pSjjpBNTClAX1YopbJynBTH94wHCa/I9d
         Oq/HBKpml5Kv8AzX5DpLvlvmVr5dsX6IzTuzI315AjKEZNXrgLi4LwtmlcOfEiorVjoK
         mSgAq7zCEdXBWkSJ6kKE8LdXog/fy+0xjsjnCYh34iNokUUHre4f+pN643IHPjhpaniC
         j28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725221; x=1754330021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYSaQxxv0yy3Y7EMVpbwK7SrDhDexuagcipLxM0lKzk=;
        b=BAWUFoPjK6lVDqA7mtSvRfSuma+SCgWHEhzKu9fhHYIXJsxsdzferkEKH4eSxHJmmN
         Wsm8LGoQq24gaIiYOKF4SYruUOn4t4pcMLf0urh70KJ89QlLY7qyofeoZBtLE4S1Yo9M
         q3huaUcW3GTOsmisH+he5S3lQ9SE9+jTVdH1vElr5F0r/9lwyhbkFcRD8TztowIXx1Un
         ZMfJStwxZNFg13Y6QK3V5dDC8h5enrU/JTI4ickbBV6esvl0DxdeWUXQwiggJ1uImHEo
         7K2DSoM7+UrXUGAdMhHn95GfJcyiY/51kmSj16qyrS0ODI7RARgVRXziCwB1xH/hBxkP
         fKCQ==
X-Gm-Message-State: AOJu0YzSFWmYIVFq439RzYX+iLEYofc5a1VqCKiViQ2n9f4j7LMWmGNm
	cygdeK/Ba8TwUabOdqO2RpWFkcGT5HB+wZRLHXF7uMt1kVXOR7C1YE/r7VAm3Zq6T63bSTgz4SA
	yvT5aiMVzlKheWE1WVWg7TGk6PaeGk4vbTU5932qyYQyKiT3QFxSBLA9KdMw4LDZ//ZfInzvG8x
	UYXloCvnOS2OXBTngdGh3nJRF8wa5FF8YZGwMsUHYILr+MW0LOL3LuVho=
X-Google-Smtp-Source: AGHT+IEqJ30qZTbb5uhq7Ulncx7YgH8wYLGAX5KY0xkgcaQRC+MirKkQi/xoWXPkKjKloEcVMUK+yOS2vLoJOA==
X-Received: from ejcry7.prod.google.com ([2002:a17:906:8d87:b0:ae0:d1fb:d297])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7b8b:b0:ad8:914b:7d0b with SMTP id a640c23a62f3a-af61c2adce9mr1312173166b.11.1753725221260;
 Mon, 28 Jul 2025 10:53:41 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:52:58 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-12-smostafa@google.com>
Subject: [PATCH v3 11/29] iommu/arm-smmu-v3: Move IOMMU registration to arm-smmu-v3-common.c
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

The KVM driver will need to implement a few IOMMU ops, so move the
helpers to arm-smmu-v3-common.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-common.c      | 27 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 18 ++-----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 +++
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
index 835eeae3bf5e..7453d9894ca3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
@@ -671,3 +671,30 @@ int arm_smmu_fw_probe(struct platform_device *pdev,
 	else
 		return arm_smmu_device_acpi_probe(pdev, smmu);
 }
+
+int arm_smmu_register_iommu(struct arm_smmu_device *smmu,
+			    struct iommu_ops *ops, phys_addr_t ioaddr)
+{
+	int ret;
+	struct device *dev = smmu->dev;
+
+	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
+				     "smmu3.%pa", &ioaddr);
+	if (ret)
+		return ret;
+
+	ret = iommu_device_register(&smmu->iommu, ops, dev);
+	if (ret) {
+		dev_err(dev, "Failed to register iommu\n");
+		iommu_device_sysfs_remove(&smmu->iommu);
+		return ret;
+	}
+
+	return 0;
+}
+
+void arm_smmu_unregister_iommu(struct arm_smmu_device *smmu)
+{
+	iommu_device_unregister(&smmu->iommu);
+	iommu_device_sysfs_remove(&smmu->iommu);
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4cd0a115fc0e..8fbc7dd2a2db 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4138,21 +4138,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		goto err_disable;
 
 	/* And we're up. Go go go! */
-	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
-				     "smmu3.%pa", &ioaddr);
-	if (ret)
-		goto err_disable;
-
-	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
-	if (ret) {
-		dev_err(dev, "Failed to register iommu\n");
-		goto err_free_sysfs;
-	}
-
-	return 0;
+	return arm_smmu_register_iommu(smmu, &arm_smmu_ops, ioaddr);
 
-err_free_sysfs:
-	iommu_device_sysfs_remove(&smmu->iommu);
 err_disable:
 	arm_smmu_device_disable(smmu);
 err_free_iopf:
@@ -4164,8 +4151,7 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
-	iommu_device_unregister(&smmu->iommu);
-	iommu_device_sysfs_remove(&smmu->iommu);
+	arm_smmu_unregister_iommu(smmu);
 	arm_smmu_device_disable(smmu);
 	iopf_queue_free(smmu->evtq.iopf);
 	ida_destroy(&smmu->vmid_map);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 787296a2f0c2..e3c46b3344db 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -564,6 +564,9 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 			    size_t dwords, const char *name);
 int arm_smmu_fw_probe(struct platform_device *pdev,
 		      struct arm_smmu_device *smmu);
+int arm_smmu_register_iommu(struct arm_smmu_device *smmu,
+			    struct iommu_ops *ops, phys_addr_t ioaddr);
+void arm_smmu_unregister_iommu(struct arm_smmu_device *smmu);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-- 
2.50.1.552.g942d659e1b-goog


