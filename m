Return-Path: <linux-kernel+bounces-799400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDD9B42B0F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CD91A8082A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8102E9731;
	Wed,  3 Sep 2025 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqxP/DyL"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343CC21FF46;
	Wed,  3 Sep 2025 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931789; cv=none; b=WcBeXhe+15Fgtioq5a59Pdn3CdVBvxSHNBk1Hvfkwn4xF/VepR06OBnYuCB8tkpINY/4OaLNe9VKLIVSrpavLTnJOQFElsKNkIcq2PAHgLMMLdAp5n2V5rLPnU5JzhTpeUwSDxnSNE/xyPf0Usm0V8MFPtwzdvVUIFyEji7CJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931789; c=relaxed/simple;
	bh=LgAX4+FAackY86daMK97x8INqJ00qHV/GqDmOF/Yubc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMlGnk9+D5jwd3G2UxbXcYHgfq0x3AeTuUs0DAoyztKAMB+N+4FKjLgUz2zy6NJZFF09ZLevkkN4Gb2iepT472St+wFawoM/ZKBpExEkFOKwCUCL1U5y/2MXFI1L3ACllB+24k4Kkdy3eb80JkjqeUNTkBKjspPIANw1k4Kjmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqxP/DyL; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f7cd8ec2cso320447e87.2;
        Wed, 03 Sep 2025 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756931785; x=1757536585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8U4j+J0xLCObTbvUCdxEDPgO2s2f8K0y6ZEwadKWKE=;
        b=RqxP/DyLX/r2k31Bbz9xKx1CVUGrmo/6F273bFphdlC4GfpohJJiW0S0oU89Yaw6rF
         DJ6dg19/Y5mFGfJa2UHfuaSlthGjmep2NWLepO3xdUnrTM/9imqH5R/yj3RRoq2R8lew
         C70uMhdrluT3hXlCHejQHYaBGtWTJfnxe5iCz7oi23jBPZ6+lhZ9DBkPrnxzu2/Rrp99
         yCqcXqoTw80hgPb4HzhqgVtimO6353u2TgKxVEDN/l4WZcsqcZwZIwU2u9dxvP0V8Mmo
         zds817u9HoF7JevHa20aRNWLU3F3ulkuJwvp7RFmRiSJkfqGgA4hYgksjikdbhSJyZnX
         b5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756931785; x=1757536585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8U4j+J0xLCObTbvUCdxEDPgO2s2f8K0y6ZEwadKWKE=;
        b=lCfzTjYXecngj5V2CcG//E1WNoS2xOPfVAipYdq1QM81zCGDB0hcCh6tdUM3EFiFCj
         INHRvPlvP21ZbEcmsTQiWX2ApBhTu72nEbhOd2+Z72czCffyPrPsIw2KWd6lPYdrNhPx
         qdO0KA1JuiUK31w1udrVbzncFjipP9lgrLLQ3T3Jq8Mn9ZzaO7eO/toVSYEsIZsjsGvw
         +PGgKP4Nt60HZhRG1s6KJHLsuPo622WGN3h31AY7Yh2o+VyxNVPNRjOE4AnFifAP8FVd
         OozRxZZ+tC9tq47Bj7dhXC7f1kLqXkoCmR8mMNoFRYkL53K4xy1wg3522wTIzUAaZYwN
         wO0A==
X-Forwarded-Encrypted: i=1; AJvYcCVdCpxtETAvrnwSVQbr6Q1krt7lW+sFnXQYNw7FWtrcUoniTIIesfLC1J0GAmpUltshEGjAkYP4Ywc3YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyVMmI2bFW4GORH6jkELJZC3pgDQbkZvqu6BXLiU5EBj3y16/2
	66gA8bxEP9+6J5hW1Hlbgxyq5wlYRtRiZ6km+WqbJW2UiWE6nFXQVu1J9LtHLsZp
X-Gm-Gg: ASbGnctVgaNvjFdjj9oPJwFHbwHhJwn/BARjL2oUQwoS5S+/w37d0hKhG5VaR2vltH4
	1OAnrV5leePnO+VFeiIJiBAEgeTu/JPI5fuy7SDUaJgd7wQDXCrAem9Mxqykz0IBQ+eqRA9t3J2
	7un+fxHp7L69V/LO0Ye6PDS0Oq+t1B6knE/r2Kp9/rEFCqe4OngtccuKI4BaFU+RxqLIguCYaSn
	ih/m9oC6WDbBmx3+2jl/gtHf5RevDafB3bjqmzHz6dhH6kIOJlndOxY0oqUIhDEX6wO4cA59C4a
	0x20aaPbhR1yys5H/3cE+mR5RM3676rHghhZcvInGa+eoSgfBo2gqQIiZDad+HAieb//QxocNUp
	A1vQPZT0f7McIoBSsB7mUPEWle30JwOREqxSMfy6ka0UbvZ+ZDlJF7k25WC8ojXpPCSb1VMAwU0
	6Zddu2chfLDA==
X-Google-Smtp-Source: AGHT+IE33Cvx37hEvscxrTQdWejAkM2J4aENaowcXJe/276vK9Fr6c2UAJtoCu5grbOt5UDtUZUYrQ==
X-Received: by 2002:a05:6512:3ca4:b0:55f:501e:7bf7 with SMTP id 2adb3069b0e04-55f709bdaa0mr5488594e87.57.1756931784570;
        Wed, 03 Sep 2025 13:36:24 -0700 (PDT)
Received: from buildhost.darklands.se (h-94-254-104-176.A469.priv.bahnhof.se. [94.254.104.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab5c299sm731722e87.8.2025.09.03.13.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 13:36:24 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	hch@infradead.org,
	macro@orcam.me.uk,
	glaubitz@physik.fu-berlin.de,
	mattst88@gmail.com,
	richard.henderson@linaro.org
Cc: Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 1/1] alpha: disable DAC for 32-bit PCI on tsunami
Date: Wed,  3 Sep 2025 22:29:44 +0200
Message-ID: <20250903203502.1155-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903203502.1155-1-linmag7@gmail.com>
References: <20250903203502.1155-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable DAC for 32-bit PCI cards on Tsunami.
This patch will effectively disable DAC for 32-bit PCI cards on
Tsunami based Alphas. This is done by setting bus_dma_limit to 32 bits
for devices that have no 64-bit memory BARs. Relevant functions in
pci_iommu.c are modified to take 'dev->bus_dma_limit' into
account.

Suggested-by: Maciej Rozycki <macro@orcam.me.uk>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/pci.c       | 25 +++++++++++++++++++++++++
 arch/alpha/kernel/pci_iommu.c | 18 ++++++++++++------
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 8e9b4ac86b7e..5b1e4782294b 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -117,6 +117,31 @@ static void pcibios_fixup_final(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_final);
 
+static void tsunami_dac_quirk(struct pci_dev *pdev)
+{
+	unsigned long flags;
+	int i;
+	bool mem64 = false;
+
+	/* If we're not on a Tsunami based system, do nothing */
+	if (hwrpb->sys_type != 34)
+		return;
+
+	for (i = 0; i < PCI_STD_RESOURCE_END + 1; i++) {
+		flags = pci_resource_flags(pdev, i);
+		if (flags & IORESOURCE_MEM)
+			mem64 |= flags & IORESOURCE_MEM_64;
+	}
+
+	/* Limit DMA to 32 bits effectively disabling DAC */
+	if (!mem64) {
+		pdev->dev.bus_dma_limit = DMA_BIT_MASK(32);
+		dev_dbg(&pdev->dev, "disabling DAC for device");
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tsunami_dac_quirk);
+
+
 /* Just declaring that the power-of-ten prefixes are actually the
    power-of-two ones doesn't make it true :) */
 #define KB			1024
diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index dc91de50f906..caf2407f80d3 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -208,7 +208,8 @@ static int pci_dac_dma_supported(struct pci_dev *dev, u64 mask)
 		ok = 0;
 
 	/* The device has to be able to address our DAC bit.  */
-	if ((dac_offset & dev->dma_mask) != dac_offset)
+	if ((dac_offset & min_not_zero(mask,
+		dev->dev.bus_dma_limit)) != dac_offset)
 		ok = 0;
 
 	/* If both conditions above are met, we are fine. */
@@ -228,7 +229,8 @@ pci_map_single_1(struct pci_dev *pdev, void *cpu_addr, size_t size,
 		 int dac_allowed)
 {
 	struct pci_controller *hose = pdev ? pdev->sysdata : pci_isa_hose;
-	dma_addr_t max_dma = pdev ? pdev->dma_mask : ISA_DMA_MASK;
+	dma_addr_t max_dma = pdev ? min_not_zero(pdev->dma_mask,
+		pdev->dev.bus_dma_limit) : ISA_DMA_MASK;
 	struct pci_iommu_arena *arena;
 	long npages, dma_ofs, i;
 	unsigned long paddr;
@@ -332,7 +334,8 @@ static dma_addr_t alpha_pci_map_page(struct device *dev, struct page *page,
 
 	BUG_ON(dir == DMA_NONE);
 
-	dac_allowed = pdev ? pci_dac_dma_supported(pdev, pdev->dma_mask) : 0; 
+	dac_allowed = pdev ? pci_dac_dma_supported(pdev,
+		min_not_zero(pdev->dma_mask, pdev->dev.bus_dma_limit)) : 0;
 	return pci_map_single_1(pdev, (char *)page_address(page) + offset, 
 				size, dac_allowed);
 }
@@ -638,7 +641,8 @@ static int alpha_pci_map_sg(struct device *dev, struct scatterlist *sg,
 
 	BUG_ON(dir == DMA_NONE);
 
-	dac_allowed = dev ? pci_dac_dma_supported(pdev, pdev->dma_mask) : 0;
+	dac_allowed = dev ? pci_dac_dma_supported(pdev,
+		min_not_zero(pdev->dma_mask, pdev->dev.bus_dma_limit)) : 0;
 
 	/* Fast path single entry scatterlists.  */
 	if (nents == 1) {
@@ -660,7 +664,8 @@ static int alpha_pci_map_sg(struct device *dev, struct scatterlist *sg,
 	/* Second, figure out where we're going to map things.  */
 	if (alpha_mv.mv_pci_tbi) {
 		hose = pdev ? pdev->sysdata : pci_isa_hose;
-		max_dma = pdev ? pdev->dma_mask : ISA_DMA_MASK;
+		max_dma = pdev ? min_not_zero(pdev->dma_mask,
+			pdev->dev.bus_dma_limit) : ISA_DMA_MASK;
 		arena = hose->sg_pci;
 		if (!arena || arena->dma_base + arena->size - 1 > max_dma)
 			arena = hose->sg_isa;
@@ -725,7 +730,8 @@ static void alpha_pci_unmap_sg(struct device *dev, struct scatterlist *sg,
 		return;
 
 	hose = pdev ? pdev->sysdata : pci_isa_hose;
-	max_dma = pdev ? pdev->dma_mask : ISA_DMA_MASK;
+	max_dma = pdev ? min_not_zero(pdev->dma_mask,
+		pdev->dev.bus_dma_limit) : ISA_DMA_MASK;
 	arena = hose->sg_pci;
 	if (!arena || arena->dma_base + arena->size - 1 > max_dma)
 		arena = hose->sg_isa;
-- 
2.49.0


