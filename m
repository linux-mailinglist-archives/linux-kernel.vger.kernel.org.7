Return-Path: <linux-kernel+bounces-841700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ACFBB803F
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 21:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955664A6BE1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 19:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E452222A0;
	Fri,  3 Oct 2025 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O2edgYvk"
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1C7212FB3
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521379; cv=none; b=G5/KDAavEZ8zWLOatj9vTAj7CZlGXiRtXihC4EuuBpPdBkXe55UoredFqxbjKK2RA/K5DkYrsQ6w65P5/RFB2HcABdET7uy8nt5FSy4Io0Z4P/kpiXnu34eBD9hzhq952U0taWuDKD9L39PutwmsfbyVCnGrtBap1qqtf29OI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521379; c=relaxed/simple;
	bh=+uLXOevcin9GX8uM8pwPTi35EjkCinCKRxZQkv7MOrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h3SzZfk7hGCfdktwfj4qAYfgke/9qE7Zf0XFcG151K+gOGRZXZZ24YZRBA9MYNwLoRKmuGl6PZhPvaR4wQt/KPqUJPRaKpjIv84PfNrGpASw1bmJ2QOh/wiCAILq3hnGLmnbVmQ1rug4vDeoALitJRpUO9I9ZePCfLOIEGCcR68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O2edgYvk; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-27edcbbe7bfso37799135ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 12:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759521377; x=1760126177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbpDWJdZfVTVSB8z3KjE43n+mbMdK6iqWDy5+ydNGZc=;
        b=O8pv2j1qdyEZbSDp4sXGT9Jk9tbNNrgIVZgIZThXArdsD6Nn+ZAfE1tSY80jj2BQeq
         T1/fartUsmo9Vx2W0kP3DWpnn/KhQUlFk8BHAVyTW4/r+vgzw2el5VWZotwt7cPG5GHH
         VpHavTfj8zSxY9rE5bcj+d35eV1hFcaGDNuhKKvXz0J9I+9JYFBm0rLnR+ekec1T7K4I
         cYTvab/rqrpdrXfXgDiwQvMX7cKjIbhmUouFHuxfmp7eoAvOjgRqP4JJ4d/pdYA62b1t
         euL3+mk0aoxY4ul2oGtcmGbL5FsbSAm7Jw0BSOFPUEEbam48lEYZuPHGKAINs7FzTGd4
         GBHw==
X-Forwarded-Encrypted: i=1; AJvYcCXodJFbxipxWq8X8FnpORIMOZ+UwAD7k/B0yINsUeQgIpYAGnWg3sia/8WbpyM69vubjBpw8e2M17C+S6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBIng2OLmMAeQTHRHj1Dpv3Ww9hizeAUwFUMr+0B4aDXSzGQ8
	Ov7y9yttQ/RZVzvtQj6XDhzXbz9EqXMIJcsQElHOdycFeO21ydvpTP9jJVoCnMXAGMKMs2We7tD
	xR4swyNr9iHgC706sYNf2M6NdTiM2PIwdw16fFdCVmSz/DqpkUVQgxpvK3QBzuhIMXg6/fTN21t
	vFxN6D0kU/E+D0hqUCM34dxtJEIpYLK1P43nSAowP/pYD0pnUH4fg4QLaphmSBDpnTPGlqXTGec
	RMGF7fLDCekWbPDCTzS
X-Gm-Gg: ASbGnculHTMUAOC9CbugOIN7pc6p5vNV6WjOSFMBjguefZCITh9mH6Xpbfy0EFYMu/G
	Yp155IQ/uaER2s0b4br3Zmn+Ypw6QX3uTl/1/reTyMqkwY87wDNF59ZLrbxkFb/E2LbGcw3Qg25
	Dcy1HoW8ed0ZtaLAihPZWoOn/C6qQgncD4tAcxo9pOpCo/HiJqZScKPEDHcdZGhBcL7qL2CDJZ4
	oh6zFHXUt5xqiEYuKGEvJR9KgRvNo+IEUMWcG8CCc90n7juQOLfUwevJcYAcXHrOpTD6DEai0n4
	dCDBTLKAmU245qfQ9xxlSMa9gJZHMCD4JahMdygtn2wUoM7tABfw4PND10zqDCY+tMGMYl75G82
	BLa0TMvrKgTilUz4lraJRiLT+uQuYAB+kmqU3qfCyeHQcoxr2kvqYzTTGMH3Xvumy66Pq9g83Om
	CtZV1J2g==
X-Google-Smtp-Source: AGHT+IGWypXN4YPmO8R8MCaNfznJzce2F/z0pK3qnW2SfwGUD4/YOqh29/epXq1mc7WOiwCEwMdhpX/eQsC6
X-Received: by 2002:a17:903:2ecd:b0:264:7bf5:c520 with SMTP id d9443c01a7336-28e9a65c7b1mr47046135ad.44.1759521377236;
        Fri, 03 Oct 2025 12:56:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-28e8d19ce8fsm3889525ad.54.2025.10.03.12.56.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Oct 2025 12:56:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b552f91033cso3138699a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759521375; x=1760126175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbpDWJdZfVTVSB8z3KjE43n+mbMdK6iqWDy5+ydNGZc=;
        b=O2edgYvk5XjC5vNnRWKB8xdnOeqI3QG249AOH0UbUNQXRLt2e9ATCRW3T/6xnLs7Hk
         DlpqM3tNZLOAjautRPW3WtzJTZBanjpnqK+bbQ2oTLK96s3YqF07LRZ60pgaD1BaK57i
         28a+Xp4OlxvntgmI7PcUePxbz7xJ2XCc5NduI=
X-Forwarded-Encrypted: i=1; AJvYcCW3mq2NnJ8aKbudhKgb0qzwpsUFF2D1IFd5Swljz2OTG7+i0IIWiG+ysUlnG2fvkocKkoDs3MybdI77rwU=@vger.kernel.org
X-Received: by 2002:a05:6a20:2583:b0:2e5:c9ee:96fa with SMTP id adf61e73a8af0-32b6208e921mr6127492637.34.1759521375318;
        Fri, 03 Oct 2025 12:56:15 -0700 (PDT)
X-Received: by 2002:a05:6a20:2583:b0:2e5:c9ee:96fa with SMTP id adf61e73a8af0-32b6208e921mr6127464637.34.1759521374911;
        Fri, 03 Oct 2025 12:56:14 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099add13esm5371162a12.8.2025.10.03.12.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:56:14 -0700 (PDT)
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
Subject: [PATCH v3 1/2] PCI: brcmstb: Add a way to indicate if PCIe bridge is active
Date: Fri,  3 Oct 2025 15:56:06 -0400
Message-Id: <20251003195607.2009785-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003195607.2009785-1-james.quinlan@broadcom.com>
References: <20251003195607.2009785-1-james.quinlan@broadcom.com>
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


