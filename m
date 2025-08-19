Return-Path: <linux-kernel+bounces-776554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD2DB2CEC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5906C1C40F35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3635B3451A0;
	Tue, 19 Aug 2025 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhsqjdB/"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C263054EB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640362; cv=none; b=Y6icnk6VcKUG7xWQ8v5uzoRqghjNRXVkVxB0j5m09wmIl6EQicpCbp+m2V8Zw/KcRkFGdYnTmtsSDpcvQCQObvh4B3SVMm1vG8+36wMQQO7jnivy74e6Rxb9JTda/Qw4m5lBGWCgEutj6OG1xAhtSWKYyMiV5Cx6FnYQ2KkP68Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640362; c=relaxed/simple;
	bh=cMrRujJwddEPtHhK0JXsWsznkc7gKRpUZGwRSJ6bEwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IGesdwJfv7PPzA8snz4QsJeX6CFmZPkn7TP/fdFRb0CTwo4fwc1+zr7lJXLMzKZNRH+N6ny+AVChC2lNRPWY0i62Ft6IxO+mEbVR/P91ZgW6313ppefy2LnaJ0Ud1yPPIcqPReFKOngOWM7j3BTxuc1bsHJycwND8e771jqlqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BhsqjdB/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0ccb6cso29972475e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640358; x=1756245158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNj1S5Tjh+MTuuSgivTU6GhE64woFcS5FBFIpdALKxk=;
        b=BhsqjdB/Csl6HZd1/ovKouxJ4papOadhDLCHcQsGKZ7biJKA9loiSLPoX8XCMYdBlq
         0WRwRjEz3klc5L8m1Ks2ejqD62LzCJetjbPjw0tqStgr++D0ooSzlmP+vOT+v/tqiczt
         7PNu0oP6tA5YXRSAi5mDpQmuYUTWai6llgecke4dj7ExlGIZBsVQuJBxzoZEP0wtmlql
         F49S2UTT9dLtFFAiGkVWps4JSWhWOq9eVnwdNteH7lp5ncZOqxtg4CBe/WI+Q6gGTTuI
         UCeKozkRtjcD0iRJ/Fu+qOUZ77olWb0IYLaYjjG0P1gZnKRPZ/FevUrpvF478KmvuROb
         4mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640358; x=1756245158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNj1S5Tjh+MTuuSgivTU6GhE64woFcS5FBFIpdALKxk=;
        b=Q+5IUG8qZ+m+rZmCQAMlnT8Q6MtEVqhCCOF7BV8uyEQS8l+yddHpyglgswEQUgeMq7
         3lzgyMt2b+GSxzXviDrWKn4PHVCjBb4Uzvcm3ikoOBQJWi3frULDcI0dWQhpeHruo0CR
         vB1qnmPTm0ZLNFLt2n39dJjPhvXFGlLAM2jH6LyeZGXlLx2lXdEUa1NQn83DR8/JcnJS
         1vgQWqoIt+FL/c6dNvrQ7LmJP8nbgFoji1izX/pcaiWBA219BBqEVz2Bt/jmPWxPk2h5
         Psk0Fwge6kpZlR+5sBZB5YxjW31MeP5Qd/EF0M0ZGO6xGtF6kWJ5bQjuh6SZ9LSwIN1W
         tZRw==
X-Gm-Message-State: AOJu0YzKcTZvGDjVnN5xn3S85LZ1Z6inkxSpb1JbvESlz3sHfh4k0Hbe
	G+nvOkl/PT6Z5crmMdWMRtHZptir7sgZqKTYyy1xc7rYejZjKAhfXTY9zdTC3QsRo3dhELQR01W
	wwhZtiiQZ2CyzwVQbqLvq5Wp3t/nxZ3J1Mfv6W3bjOKtVBJTPSTv9eiBgvEcb1d6qBScwmfuiXG
	fcU63tVAyi3XOWyBblIlMgJnKxZPCj07GZeDijRSdxBP7jqNSrC1rbBOA=
X-Google-Smtp-Source: AGHT+IHhXE5eFe6Mvs1Uc4cVRo8SUsVH79pNU31b0EWqV1qHu+8OuogNqLM1q4nApTxhxyHGYIGINP4HjbEypA==
X-Received: from wmsd13.prod.google.com ([2002:a05:600c:3acd:b0:459:10dd:2e55])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b4b:b0:456:161c:3d6f with SMTP id 5b1f17b1804b1-45b479b8ed5mr2712295e9.11.1755640358514;
 Tue, 19 Aug 2025 14:52:38 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:43 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-16-smostafa@google.com>
Subject: [PATCH v4 15/28] iommu/arm-smmu-v3: Load the driver later in KVM mode
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

While in KVM mode, the driver must be loaded after the hypervisor
initializes.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 ++++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 10ca07c6dbe9..a04730b5fe41 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4576,12 +4576,6 @@ static const struct of_device_id arm_smmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
-static void arm_smmu_driver_unregister(struct platform_driver *drv)
-{
-	arm_smmu_sva_notifier_synchronize();
-	platform_driver_unregister(drv);
-}
-
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name			= "arm-smmu-v3",
@@ -4592,8 +4586,27 @@ static struct platform_driver arm_smmu_driver = {
 	.remove = arm_smmu_device_remove,
 	.shutdown = arm_smmu_device_shutdown,
 };
+
+#ifndef CONFIG_ARM_SMMU_V3_PKVM
+static void arm_smmu_driver_unregister(struct platform_driver *drv)
+{
+	arm_smmu_sva_notifier_synchronize();
+	platform_driver_unregister(drv);
+}
+
 module_driver(arm_smmu_driver, platform_driver_register,
 	      arm_smmu_driver_unregister);
+#else
+/*
+ * Must be done after the hypervisor initializes at module_init()
+ * No need for unregister as this is a built in driver.
+ */
+static int arm_smmu_driver_register(void)
+{
+	return platform_driver_register(&arm_smmu_driver);
+}
+device_initcall_sync(arm_smmu_driver_register);
+#endif /* !CONFIG_ARM_SMMU_V3_PKVM */
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will@kernel.org>");
-- 
2.51.0.rc1.167.g924127e9c0-goog


