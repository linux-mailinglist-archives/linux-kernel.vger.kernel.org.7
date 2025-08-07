Return-Path: <linux-kernel+bounces-759561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8BFB1DF4A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 00:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A2A77AA125
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 22:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B77239E75;
	Thu,  7 Aug 2025 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W8gQFF10"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA921D3EC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754604922; cv=none; b=OQOUddUE071vDy97JT1Ggi+SeEGjA8XkfuoLJ9gFerloV8SjbQLdhZZQoqHfE8rlskyGSqPWXLD/BqslvtMh+PVF3qQWlXjD82OypINr6vljahS0J6rhbsTQkNmH4639sCE/fkccXmzPZvqow4rdSo6OmmwvqxChEj+yifoFyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754604922; c=relaxed/simple;
	bh=bZhK3Ug6n0M7Y/KebJqwpWQBQMbBn47GnkGv84IdfUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jGACt72OUwd1liBy7ZfYVK4mHezlT3KGaXxGGpSpfYQYMEoJ6KlqCvfe6D94MiNQs3MFHA08pmOeL6i8l4TpNZ5bbwX+WTbNldX6Q7d11F4zHgU7uWn6N/kifaE6Ku9jKzOZB5DrGxGkb2micJzYuprYdD4JoVecfexv8m+w9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W8gQFF10; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b08c56d838so19480581cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 15:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754604918; x=1755209718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7aXLLLTdaewYlSZFKdW1YKq/QeHggS65uLCSdSCq1A=;
        b=W8gQFF10EyToeRtOA8nhHS5zVeriTpuUzn/PyrIIVB/SMo8WhQG9HpYtlYkBtSf8pA
         q27k5k0ly8xemar01OLO+FAyCBTAoNri2qg1hMBa8GDpnutEnTamZecq51D7gU7rTQ3E
         jvgGSSlMl1JrSVcGczmm94U17LQs1j//mbL+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754604918; x=1755209718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7aXLLLTdaewYlSZFKdW1YKq/QeHggS65uLCSdSCq1A=;
        b=VRjIPX1Su7hB21zpj2i40pFCEwRRIpoIjCjp9HaQ/licCTNrn5PRtxzWpV1JXCnX12
         ZXr6Aal7qa5ycoFzmPwMEvyJKVxa+YOYaneSTDPtsPDPzMLCHvfDHZ5Ko1Cw3779meJU
         4vMR8/yJBpeTo5ka+Gx4v8E5Hr1igScRx8rn/XmcSXfHO1P5UASRmY/eMaYDE9IzLHv7
         LAPXe3PX99Tv6wq7xcErZmlCCoQT9gk0Q2MmhestXG+61GZceWhfq6DWOmP7DqrFs43W
         4HQExKwQwL7mSotp0TGo1QADjSxT1KKYgSLC28y4fNTCscybejODUywwY+cX24sHNrIP
         ZgKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmzkYNU4EZPdssz9/eNG/unDeMSl+H640UOCInny7DZaXxr244k14iF26mB57VR00MHJ1sMXTWT7N3coY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4IxZFejXQrrqlZIUh345IIau2goSIQMEI9xilunZDR1bhBWN4
	SKk9UKpxRuLrcOFoq4ip1NtJNbqjZcbw2KwrBvymGcb/L9vagRFGXo+N1eHvY+/qeg==
X-Gm-Gg: ASbGnctvhsi1pBTjd6uMhAFXQZrQ8xfuELeTUxtiMullpYrhOPYeocJbtLnWMZkp9Yt
	mfd9DKxG/gzd3zsPHEdUV7lBY2B+1y77Y/IGtAOy2Ky4XG5oAl4epwd5Lee8IZxKOJIX2RaLGja
	nc+3/lBvIOx6YHgvmzdXFHeafXJeXOCKHwl0JiO551WVaDSfrHb4kUvqDsmssyZb9rkZ3oACX3c
	e6jgNe2SC/LSBeWKT/DwY8xQG2neLHvggNSAUUpP76/xR/L4w+XzktOOOOgwopbM+eIShimMGAG
	ord6PMCNemtxDF7ptIpVe4lFgOSu5RuXU0UGXBBlpXq22qYY+AisOYHn7QBnBAT9pnfdFiEyuUs
	qyRo380Mwhq9u+V52jByfGAXFa0g916fhtZEj6oZuvdktm8+ZVD8lSuHpkAHujI4eq9XbEgmH1J
	UL8s4erJvOXqRj
X-Google-Smtp-Source: AGHT+IFECAtHrfofLNszmttHHQwFVkK40S3ZHWrqpD2n3W0M30Gfsipiqbx2ZOcLlQJ+kKSkdKgcYg==
X-Received: by 2002:a05:622a:1a8a:b0:4a7:81f6:331e with SMTP id d75a77b69052e-4b0afd8200bmr6892381cf.6.1754604918375;
        Thu, 07 Aug 2025 15:15:18 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0aa1efe78sm9527421cf.8.2025.08.07.15.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 15:15:17 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] PCI: brcmstb: Add a way to indicate if PCIe bridge is active
Date: Thu,  7 Aug 2025 18:15:12 -0400
Message-Id: <20250807221513.1439407-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807221513.1439407-1-james.quinlan@broadcom.com>
References: <20250807221513.1439407-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a future commit, a new handler will be introduced that in part does
reads and writes to some of the PCIe registers.  When this handler is
invoked, it is paramount that it does not do these register accesses when
the PCIe bridge is inactive, as this will cause CPU abort errors.

To solve this we keep a spinlock that guards a variable which indicates
whether the bridge is on or off.  When the bridge is on, access of the PCIe
HW registers may proceed.

Since there are multiple ways to reset the bridge, we introduce a general
function to obtain the spinlock, call the specific function that is used
for the specific SoC, sets the bridge active indicator variable, and
releases the spinlock.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 51 +++++++++++++++++++++------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9afbd02ded35..ceb431a252b7 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -30,6 +30,7 @@
 #include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
@@ -259,6 +260,7 @@ struct pcie_cfg_data {
 	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	int (*post_setup)(struct brcm_pcie *pcie);
+	bool has_err_report;
 };
 
 struct subdev_regulators {
@@ -303,6 +305,8 @@ struct brcm_pcie {
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
 	const struct pcie_cfg_data	*cfg;
+	bool			bridge_on;
+	spinlock_t		bridge_lock;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -310,6 +314,24 @@ static inline bool is_bmips(const struct brcm_pcie *pcie)
 	return pcie->cfg->soc_base == BCM7435 || pcie->cfg->soc_base == BCM7425;
 }
 
+static inline int brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32 val)
+{
+	unsigned long flags;
+	int ret;
+
+	if (pcie->cfg->has_err_report)
+		spin_lock_irqsave(&pcie->bridge_lock, flags);
+
+	ret = pcie->cfg->bridge_sw_init_set(pcie, val);
+	/* If we fail, assume the bridge is in reset (off) */
+	pcie->bridge_on = ret ? false : !val;
+
+	if (pcie->cfg->has_err_report)
+		spin_unlock_irqrestore(&pcie->bridge_lock, flags);
+
+	return ret;
+}
+
 /*
  * This is to convert the size of the inbound "BAR" region to the
  * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
@@ -756,9 +778,8 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
 
 static int brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 {
-	u32 tmp, mask = RGR1_SW_INIT_1_INIT_GENERIC_MASK;
-	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
-	int ret = 0;
+	u32 tmp;
+	int ret;
 
 	if (pcie->bridge_reset) {
 		if (val)
@@ -774,10 +795,10 @@ static int brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 	}
 
 	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
-	tmp = (tmp & ~mask) | ((val << shift) & mask);
+	u32p_replace_bits(&tmp, val, RGR1_SW_INIT_1_INIT_GENERIC_MASK);
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 
-	return ret;
+	return 0;
 }
 
 static int brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
@@ -1081,7 +1102,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	int memc, ret;
 
 	/* Reset the bridge */
-	ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
 	if (ret)
 		return ret;
 
@@ -1097,7 +1118,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-	ret = pcie->cfg->bridge_sw_init_set(pcie, 0);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
 	if (ret)
 		return ret;
 
@@ -1565,7 +1586,7 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 
 	if (!(pcie->cfg->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
 		/* Shutdown PCIe bridge */
-		ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
+		ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
 
 	return ret;
 }
@@ -1653,7 +1674,9 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 		goto err_reset;
 
 	/* Take bridge out of reset so we can access the SERDES reg */
-	pcie->cfg->bridge_sw_init_set(pcie, 0);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
+	if (ret)
+		goto err_reset;
 
 	/* SERDES_IDDQ = 0 */
 	tmp = readl(base + HARD_DEBUG(pcie));
@@ -1921,7 +1944,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
 
-	pcie->cfg->bridge_sw_init_set(pcie, 0);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not un-reset the bridge\n");
 
 	if (pcie->swinit_reset) {
 		ret = reset_control_assert(pcie->swinit_reset);
@@ -1938,7 +1964,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		if (ret) {
 			clk_disable_unprepare(pcie->clk);
 			return dev_err_probe(&pdev->dev, ret,
-					     "could not de-assert reset 'swinit'\n");
+					     "could not deassert bridge reset\n");
 		}
 	}
 
@@ -1996,6 +2022,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (pcie->cfg->has_err_report)
+		spin_lock_init(&pcie->bridge_lock);
+
 	return 0;
 
 fail:
-- 
2.34.1


