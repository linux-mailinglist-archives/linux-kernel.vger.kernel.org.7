Return-Path: <linux-kernel+bounces-748479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDF7B14195
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFC618C076A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEF8289E1B;
	Mon, 28 Jul 2025 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cT4SqjpS"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A02882A2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725242; cv=none; b=U77ATyWTvUpdtnz34xC+v7FSoLbDsUG9p4avzAU95mF4/LxEcEVeSfoQoRI2V150FgMnGIqM9b7+T4aS9VnoDpSwZHnS1pbxq71byvfek0CI7oEiwULoPpbvu9QyqXBrO2REWQoWBttLr8g73OfTwzrmmgw5xumfI4cZB916g04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725242; c=relaxed/simple;
	bh=EUy/vZvpysFQHz5jEN+YFsXxAIi1s9ZWwxbNZ5/CgdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZLF1NX0jjUvSufME7xkNIbYPL98XWpRGrSDNlqnl67sopXaHt9ensAoEW2AstdY6J1126OaHUfeH5XSrjeIq6EH7BA6LAlAtcU3RQa0yRWDXbZBKKzgLItL2cGs0mu6Pl2U1y1Dk2Ziz9d59sHSnzRr4NNL392zKwdnumhSNs2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cT4SqjpS; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b78a034d25so1038122f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725238; x=1754330038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QSr0fqvgX1Drng12G6ETMDdU03kWvJEQjrB6gLd0l4Y=;
        b=cT4SqjpSMINNboh+dYiltOSo0FrTu/1djItFx4GQoKfXYkqE7b/867lIBoHGq4KAlh
         JhwY0sncnBpV8uQwDaUQZK3gFGzwpyczq8TbBKWk4f/1/vTMZSvcirBINOQRW21s6cH+
         mkTIRa/Moq3sk2PGeIvldgGVl83qwEEB8ZckSjNwBVKzsPFsb4KeSTZkX+t4IK573Q7Y
         4cyX0XwapVDqKHr62pkKMftTODIllGIZgLB8hSAAHrS2DK3kegqlMUmXwIgA2Xh4z+Tl
         k/CW50wztmoB4XQ957/mtsHUEV+kODA2XMzBqthZwKuVz+AOAK+gBUfv+B0fugHTo0LC
         lGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725238; x=1754330038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSr0fqvgX1Drng12G6ETMDdU03kWvJEQjrB6gLd0l4Y=;
        b=N/hRkESIzYmor+RFANG62oelVVqt/MGiRb5zXZYghqv3RkeYZiRCG5bZ+bsGS+zsgy
         M/fPAVJOz9ErW/6c23nePhozi5Vw53nb9wgVnqx0TEhS7nZKmg/DhvrVF5Mhv4j4lbsh
         nOnq00B7GaPdwRadrI7qfFjVVQv6hgIDCsFR0Rr9bch0INHbReLZtJq+WZUbDb63iRFW
         U6xXWezorOIH5FZcgJmIgkHo2ucrC91o8H1/ho2iS3zHw9IkMufthLu760aLFIHDFuba
         etob6Ha2Fjeb3r5WhBdaivIEoHIRNDuqfhCOjgUKLWORug1d0LBSuNRbW/SQxCUkBvG3
         zGHg==
X-Gm-Message-State: AOJu0YzXFj69qbkT0ctv7ZQzFPKos9kLs/g5l9zvIdDat2fpwc5oZsac
	wLx+Wyi8XzChhECEQ8ViGuEvzcdw1dXlSw96sdUBr5ZttyHKy4i5IVQ8/ePmh5Wq1v4N/4LBtEP
	HJeW6FdBJhXUCpl9GlhfhncUQanYv06CovI9jlZZU7rbgd5hL+e2JGXRb+eT+BwIS/eBAt/pdVp
	3KQ3tR0cVopViSxWG7WtjztrKt8HQ285nx3pgKxD5zXpG+8mteGyLSR78=
X-Google-Smtp-Source: AGHT+IHJypg4BMzHTQELfiD77Icp1+iTSwb8rg42c8bIcH6n5fDLR43xwlqFaDtwSnP1AmX/74ubtwgfnroFOw==
X-Received: from wmbay36.prod.google.com ([2002:a05:600c:1e24:b0:456:1ccb:7fbc])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4011:b0:3a5:243c:6042 with SMTP id ffacd0b85a97d-3b7765e58a1mr8332580f8f.2.1753725237768;
 Mon, 28 Jul 2025 10:53:57 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:53:16 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-30-smostafa@google.com>
Subject: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Register the SMMUv3 through IOMMU ops, that only support identity
domains. This allows the driver to know which device are currently used
to properly enable/disable then.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 92 ++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index 2e51e211250d..d7b2a50a4cb2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -96,6 +96,95 @@ static int kvm_arm_smmu_device_reset(struct host_arm_smmu_device *host_smmu)
 	return 0;
 }
 
+static struct platform_driver kvm_arm_smmu_driver;
+static struct arm_smmu_device *
+kvm_arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct device *dev;
+
+	dev = driver_find_device_by_fwnode(&kvm_arm_smmu_driver.driver, fwnode);
+	put_device(dev);
+	return dev ? dev_get_drvdata(dev) : NULL;
+}
+
+static struct iommu_device *kvm_arm_smmu_probe_device(struct device *dev)
+{
+	struct arm_smmu_device *smmu;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (WARN_ON_ONCE(dev_iommu_priv_get(dev)))
+		return ERR_PTR(-EBUSY);
+
+	smmu = kvm_arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
+	if (!smmu)
+		return ERR_PTR(-ENODEV);
+
+	dev_iommu_priv_set(dev, smmu);
+	return &smmu->iommu;
+}
+
+static void kvm_arm_smmu_release_device(struct device *dev)
+{
+	int i;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_device *smmu = dev_iommu_priv_get(dev);
+	struct host_arm_smmu_device *host_smmu = smmu_to_host(smmu);
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		int sid = fwspec->ids[i];
+
+		kvm_call_hyp_nvhe(__pkvm_iommu_disable_dev, host_smmu->id, sid);
+	}
+}
+
+static phys_addr_t kvm_arm_smmu_iova_to_phys(struct iommu_domain *domain,
+					     dma_addr_t iova)
+{
+	return iova;
+}
+
+static int kvm_arm_smmu_attach_dev(struct iommu_domain *domain,
+				   struct device *dev)
+{
+	int i, ret = 0;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_device *smmu = dev_iommu_priv_get(dev);
+	struct host_arm_smmu_device *host_smmu = smmu_to_host(smmu);
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		int sid = fwspec->ids[i];
+
+		ret = kvm_call_hyp_nvhe(__pkvm_iommu_enable_dev, host_smmu->id, sid);
+		if (ret)
+			goto out_err;
+	}
+	return ret;
+out_err:
+	while (i--)
+		kvm_call_hyp_nvhe(__pkvm_iommu_disable_dev, host_smmu->id, fwspec->ids[i]);
+
+	return ret;
+}
+
+static struct iommu_domain kvm_arm_smmu_def_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= kvm_arm_smmu_attach_dev,
+		.iova_to_phys	= kvm_arm_smmu_iova_to_phys,
+	}
+};
+
+static struct iommu_ops kvm_arm_smmu_ops = {
+	.device_group		= arm_smmu_device_group,
+	.of_xlate		= arm_smmu_of_xlate,
+	.get_resv_regions	= arm_smmu_get_resv_regions,
+	.probe_device		= kvm_arm_smmu_probe_device,
+	.release_device		= kvm_arm_smmu_release_device,
+	.pgsize_bitmap		= -1UL,
+	.owner			= THIS_MODULE,
+	.default_domain 	= &kvm_arm_smmu_def_domain,
+};
+
 static int kvm_arm_smmu_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -170,7 +259,7 @@ static int kvm_arm_smmu_probe(struct platform_device *pdev)
 	hyp_smmu->features = smmu->features;
 	kvm_arm_smmu_cur++;
 
-	return 0;
+	return arm_smmu_register_iommu(smmu, &kvm_arm_smmu_ops, ioaddr);
 }
 
 static void kvm_arm_smmu_remove(struct platform_device *pdev)
@@ -184,6 +273,7 @@ static void kvm_arm_smmu_remove(struct platform_device *pdev)
 	 */
 	arm_smmu_device_disable(smmu);
 	arm_smmu_update_gbpa(smmu, host_smmu->boot_gbpa, GBPA_ABORT);
+	arm_smmu_unregister_iommu(smmu);
 }
 
 static const struct of_device_id arm_smmu_of_match[] = {
-- 
2.50.1.552.g942d659e1b-goog


