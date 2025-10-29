Return-Path: <linux-kernel+bounces-877033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCA7C1D066
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB6F188783A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229D13590C8;
	Wed, 29 Oct 2025 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IABwTOm4"
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB71FF1C4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766587; cv=none; b=gIEiQ8y5yEgEU+Hfcv0d3RTGRooilQ33lIkf/WWxKQw+lnsCxF9kpWXO6ShC7veQ0GmMQCYl58oz/EexIImFkwVrtECKF1qp/d1a4Jklp7FqR+JuiXHMCXT+4A/knZUUAZpwAob6GgThEUUw8O3qd+p+VkpngeDpRZ45EtVmY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766587; c=relaxed/simple;
	bh=+uLXOevcin9GX8uM8pwPTi35EjkCinCKRxZQkv7MOrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HD9Au8gURT4dJ+sQ9jdIry67V+KWYD385Zk0/qw7kkR9uwxItrGQ13wxn+j69F9dPCd/ig5D0nqRPKPc+upAWrodnN2e3kB0rX8fK08hsnmVQdqpkpLlM+aBZyXp/c7snN667BxHZDqblZbcE4WKwc5QuD3Mp7GIEAgNiXlYdP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IABwTOm4; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-7a28226dd13so273921b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761766586; x=1762371386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbpDWJdZfVTVSB8z3KjE43n+mbMdK6iqWDy5+ydNGZc=;
        b=mSSjVnyy+gNUFrL0D89Tvg+0MWoG0ycbJl6Ukn0og+NNP20OFk5LAch+twBTAjNaz1
         gj4s70ueR/cXZXFYAxtIDfck8aoaD5k2r8aBxAvWKOPLREzrxy0zgkvwv3OQ6PfI1Pkt
         tqA+adix5vWm8fCw9/ellFZyzOMZkJGsT404Oy4WUsHXX0xe7FLhlCN0EwTJNiPWtXt3
         89k53iLBijFQIS0pX71XKHfhuj1Sb9yHiUuy5ZNTxtX43oduPvjmWussBpGt+dwYHnMw
         Nm8Y5pIuljgOmwGCOAIeRGNaUY9a2B7uPvOthEm+BVdyP40uNPVDmR7QV5eMUTLdAWzK
         YI+w==
X-Forwarded-Encrypted: i=1; AJvYcCUhfs9brx1jpdUXqo7yT3FYczk6WD8X5vM2HG4o+ycsFIBHoqcdBlu+93z+GBLRc/S25V+6JYapiQn9tZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwghlJqVPtTBX2MJrMV4uZynZ/T/Ef8d6D8QWbh8xtuCMzNnCO3
	9rA5j9RCqRjPA2LD7eubKBBtzrBDNC5M/bBDPtPBo+DTThfO9fiYZZJfhwojXWULm/eQ1NE4MeM
	mbOsOTLfQivh38QgfdBzdpk35XmGWXO5FYY2Cm8h2lv/rQHx7fORSDxiEW3gHK6yJvVglFk8++N
	rKvxcqMx7y0wCYeQ0YeNHfzJ+svaEg8hlJORZB51WYHEUCFc4xc7xUC063jS4amXzDPUxfoLAs9
	lAGMed0Z9eiQ8c06BEq
X-Gm-Gg: ASbGncsHUVEQ4eN3W5jSK/bqddRuQXHw6YvduQi3GOimiVZxKuqAhIhnBI0p2Fyx/3R
	T3y57mA2hHH6cjzMdsaAtQ/AI7cT6dk/zl8OPltD1ppQXg+HumCYH4JCnGPxdRUK/EiDLAon2Ph
	lvwZcJSqrm0cLZ44KKMcsiBbR50zHgEgrlR97zqVMUfkx+FWy0jcKRFaveXMSlXDX2JmPg3Jxx6
	XEAsmjU5Y6xlur6zz8/FjKGtS0ex2fw8pLmNfKN71ILuosbu5C+SnHiRBBWZVNVxiHAf9IildJb
	p0UsriCa/Fi8mn6/IJBiZFuL3nwmOq51P783uATc6qmWw0e32cRPByRHNZIIzLTP/FlGDdHSAdP
	uYc/iD/lKz3WgKamjYMBmRm4m7mfRfWUnGo6DwsMCCP3DFsM3Rikydma/QQq4RP+indFbtLDv9n
	GXiBIBjunU/TYNrvSIl9BGpx6L26GgsSShDtoYnQ==
X-Google-Smtp-Source: AGHT+IF2IFDvRf74B4Qmv/HrUaNHX/rnuZV018Ewa26Llx0qNkKJIZNdfLsoIffq9GsiRM4hFDCbOS5Rkk9F
X-Received: by 2002:a05:6a20:244c:b0:334:9b5d:3876 with SMTP id adf61e73a8af0-34784e3657cmr761353637.4.1761766585701;
        Wed, 29 Oct 2025 12:36:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b712c87b656sm935485a12.7.2025.10.29.12.36.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2025 12:36:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a285bb5376so213483b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761766584; x=1762371384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbpDWJdZfVTVSB8z3KjE43n+mbMdK6iqWDy5+ydNGZc=;
        b=IABwTOm4C8oTrRwjiXv9cREc0r7Y7q16xnQrEH4H1rKENPJCU1z8nDgKGz+qCb5TyJ
         fnp4ejoGlHaJAO33eH+hnSp+/QyEZ5CUWZ6VuRUOcW/icJ1mFysk6oTPPrNXyzxKP3j/
         kFUe4TetzPVRzz3Nm6TFsdUqdxZTXmE3CVgQc=
X-Forwarded-Encrypted: i=1; AJvYcCWXNgkvbO3Whu+mSf2K4ZZGtqEZaFPLIKT05p9aYA0jlv2oBY5TNCPOZd4LqB+9d7fNYOGcSo0YT8eunAY=@vger.kernel.org
X-Received: by 2002:a05:6a00:c95:b0:78c:97fa:619c with SMTP id d2e1a72fcca58-7a6275ee9e7mr645014b3a.32.1761766583716;
        Wed, 29 Oct 2025 12:36:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:c95:b0:78c:97fa:619c with SMTP id d2e1a72fcca58-7a6275ee9e7mr644977b3a.32.1761766583175;
        Wed, 29 Oct 2025 12:36:23 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140a0d47sm15895260b3a.73.2025.10.29.12.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 12:36:22 -0700 (PDT)
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
Subject: [PATCH v4 1/2] PCI: brcmstb: Add a way to indicate if PCIe bridge is active
Date: Wed, 29 Oct 2025 15:36:14 -0400
Message-Id: <20251029193616.3670003-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029193616.3670003-1-james.quinlan@broadcom.com>
References: <20251029193616.3670003-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

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
 drivers/pci/controller/pcie-brcmstb.c | 40 +++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9afbd02ded35..9f1f746091be 100644
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
+	bool			bridge_in_reset;
+	spinlock_t		bridge_lock;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -310,6 +314,24 @@ static inline bool is_bmips(const struct brcm_pcie *pcie)
 	return pcie->cfg->soc_base == BCM7435 || pcie->cfg->soc_base == BCM7425;
 }
 
+static int brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32 val)
+{
+	unsigned long flags;
+	int ret;
+
+	if (pcie->cfg->has_err_report)
+		spin_lock_irqsave(&pcie->bridge_lock, flags);
+
+	ret = pcie->cfg->bridge_sw_init_set(pcie, val);
+	/* If we fail, assume the bridge is in reset (off) */
+	pcie->bridge_in_reset = ret ? true : val;
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
@@ -1081,7 +1103,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	int memc, ret;
 
 	/* Reset the bridge */
-	ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
 	if (ret)
 		return ret;
 
@@ -1097,7 +1119,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-	ret = pcie->cfg->bridge_sw_init_set(pcie, 0);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
 	if (ret)
 		return ret;
 
@@ -1565,7 +1587,7 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 
 	if (!(pcie->cfg->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
 		/* Shutdown PCIe bridge */
-		ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
+		ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
 
 	return ret;
 }
@@ -1653,7 +1675,9 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 		goto err_reset;
 
 	/* Take bridge out of reset so we can access the SERDES reg */
-	pcie->cfg->bridge_sw_init_set(pcie, 0);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
+	if (ret)
+		goto err_reset;
 
 	/* SERDES_IDDQ = 0 */
 	tmp = readl(base + HARD_DEBUG(pcie));
@@ -1921,7 +1945,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
 
-	pcie->cfg->bridge_sw_init_set(pcie, 0);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not de-assert bridge reset\n");
 
 	if (pcie->swinit_reset) {
 		ret = reset_control_assert(pcie->swinit_reset);
@@ -1996,6 +2023,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (pcie->cfg->has_err_report)
+		spin_lock_init(&pcie->bridge_lock);
+
 	return 0;
 
 fail:
-- 
2.34.1


