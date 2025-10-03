Return-Path: <linux-kernel+bounces-841560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61976BB7A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0567D4EA457
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C59E2D77F7;
	Fri,  3 Oct 2025 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NjkSElPJ"
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6512D73B8
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511085; cv=none; b=fpMF4RuLYcUp1dNSgUQw6EJdvZ6yYu+BNNtCA/QhhfWuH2U6OIdmT/Ou+nbf7/KNkhpwHyTZj3Ff1cuVEc5uWMlCXcLyvNy3mvgdRP7j0YEMIrzYGv2XCXhdwyDuvGTzoyPmo0W+If3iflacRijuR9Y+ULjurYEuE2VIb7j+/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511085; c=relaxed/simple;
	bh=0P4l5HE9JICpSWU5DgWz3pTjZ6YmStuMYlU7hTnIXF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bTsybNR8qKiQAdF6qz2vjQrOGjm8P4nOtWTJBtJYbwjI4tc+xrjo7ayQbMlZp8t8iUauzwRgzR+mUmlyzfKV47Mg+G4UQEq7fBP4OlRG6j3+If8unxX88dh8rHOxfcn7Ilp9pMlZ1KrxRbIVta978NiFcnIoYvOjWWpCHTZXuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NjkSElPJ; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-33274fcf5c1so2656237a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759511083; x=1760115883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVnrp7WE13kwvvN6B2l11O4oBl8ExmT/hll5Efsm98E=;
        b=QNihFaPyARd+ZfNNpPVDSe6+moWBczq8iVmuq56bmzD6V823IZhzVxgn/qUAZvZTM9
         QBLVowkLAZa3wYnC/y9H/jkUxcfwBCMFXBHd7X6OyTdlGRFIz+U0aRrPDdjCbye37SZ3
         FQCQcEf28Qg3NHTSxMYe933E1oqIiTXd2DG0VLfT9E+gIjuOhrzzfln0zWiSJarhQD5x
         357x1wHEHvhMTIVOmqSsVG9GSfPeQHUPeTtBXggQiQ5uNrfc3wxKIqKDEplS6hAA5WyZ
         vN6vYN3udI97lzsUgF9cL/BnfwdjhBIIrDl4QBV0jsXwo1v+O6Pzq7kRXCMrzynTxsf/
         sjDw==
X-Forwarded-Encrypted: i=1; AJvYcCUAFQMxWbCaKUG1+H8ad7c2c9mNzlrYG7h8Frgqd13XnyZ9cQEUTszZkbz9Po7uH7OR9vqOGFE1I2YUm4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6rwBwtigjqDIkSSKqlpJ7rUBYjtVaM48Z18+dNRmPmpZibzK3
	cGrK29QZXkcbhlc/RWQJfm+L5BPKkBm4Obq4UOBafZWyRRZlmfaNTRQ4kaUfEXqffh7zbcJyZEy
	aaueUgALOljPSP4ZKq/miRRHBqDpG/SgtZPXcuKSOg5/Ec5Dfq0hUAiP77SwIDXA3zvd7AWvHFg
	sukONm6ZLE1OUGphqjCCdWPu/j0BE+ZB+pHC/txHGkn8D7odNm6awdGqGnzSg9K37TXM/zFo5aI
	MnhwaIuLpHpN08FvP/t
X-Gm-Gg: ASbGnctRQDMPa4FU+eMmn6HegTqyB945bJcN7ygZaBFPKbVGhpz/U0e0h10JhZ9ifL2
	Nq1DZFJpX+DMI7O/oK7yYsWYiwuXIsDJx0KrNMVYiuGaqePE2h2OTJoWJ/xoBRZcYayLQGuP2/n
	pNObABuRQMg5Dr5VWp0305T5XfAuTLHhRerRlx28JL5TQzHsF4LZHdd/ew2puM+bKj+8FCt1O1X
	BcN5YN36l45fuXXcVbV+iOlQ4MdQ+FxYuxvKiyHDMPID230WqwZONKFPp4XWvJgWJc6BP8BLILG
	+jHhaOF7QwSZdth7nxSBdwaE7cK/12tsiWBE/bT8jKOa3JrRWeUjWvpMkyU0S4SIFmJBOKQY6Z5
	TlSaw8F/ROalcK9ei0M3uHMYATpSsOjv/aCWM5rcf9ns1wIk/i53jbd7B2uhheh+awc+ehuHPqM
	Nkq93j8LlF
X-Google-Smtp-Source: AGHT+IFXqQhV7mt4wv+CZmQN/D4DCVgV7H53enu+ie/DuFvkZ4yym+sY33tEWgO9zyFaoOPV9TXfDveed5f0
X-Received: by 2002:a17:90b:1b0e:b0:330:6d5e:f17e with SMTP id 98e67ed59e1d1-339c278eb63mr4166836a91.24.1759511082898;
        Fri, 03 Oct 2025 10:04:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-339a6f95ecbsm712523a91.8.2025.10.03.10.04.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:04:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-828bd08624aso491756685a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759511081; x=1760115881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pVnrp7WE13kwvvN6B2l11O4oBl8ExmT/hll5Efsm98E=;
        b=NjkSElPJrg6Cery3jkYLti++z60ATRSNwnOaRSblHPoZ4aVXl/gr2yKt5N2HFi3Tjm
         BuuItWeC+KD0Ux7UcRBgKIpnSkLTCTeHsiV1LJM04kLxM2uKHEq4yI34W22N0NTVS6Ib
         8fpqwjqmFGOo9sDIeBE00xVR4CwQfDxcPQWCE=
X-Forwarded-Encrypted: i=1; AJvYcCXU25vI2Vbut0q5m5mtVQ6vJuHkPNwNnT2ZifMVtt7ckUs4EcFkbJFZHoq45OhjCYMnGdrHpgNmgDeqmsA=@vger.kernel.org
X-Received: by 2002:a05:620a:414d:b0:84d:26f0:613 with SMTP id af79cd13be357-87a37cb2c5dmr525097885a.33.1759511081260;
        Fri, 03 Oct 2025 10:04:41 -0700 (PDT)
X-Received: by 2002:a05:620a:414d:b0:84d:26f0:613 with SMTP id af79cd13be357-87a37cb2c5dmr525092085a.33.1759511080652;
        Fri, 03 Oct 2025 10:04:40 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55a34b6bfsm46472271cf.7.2025.10.03.10.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:04:39 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Subject: [PATCH] PCI: brcmstb: Fix use of incorrect constant
Date: Fri,  3 Oct 2025 13:04:36 -0400
Message-Id: <20251003170436.1446030-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The driver was using the PCIE_LINK_STATE_L1 constant as a field mask for
setting the private PCI_EXP_LNKCAP register, but this constant is
Linux-created and has nothing to do with the PCIe spec.  Serendipitously,
the value of this constant was correct for its usage until after 6.1, when
its value changed from BIT(1) to BIT(2);

In addition, the driver was assuming that the HW is ASPM L1 capable when it
should not be telling the HW what it is capable of.

Fixes: caab002d5069 ("PCI: brcmstb: Disable L0s component of ASPM if requested")
Reported-by: Bjorn Helgaas <bhelgaas@google.com>

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9afbd02ded35..7e9b2f6a604a 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -48,7 +48,6 @@
 
 #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
 #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK	0x1f0
-#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
 
 #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
 #define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK	0xf8
@@ -1075,7 +1074,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	void __iomem *base = pcie->base;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
-	u32 tmp, burst, aspm_support, num_lanes, num_lanes_cap;
+	u32 tmp, burst, num_lanes, num_lanes_cap;
 	u8 num_out_wins = 0;
 	int num_inbound_wins = 0;
 	int memc, ret;
@@ -1175,12 +1174,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 
 
 	/* Don't advertise L0s capability if 'aspm-no-l0s' */
-	aspm_support = PCIE_LINK_STATE_L1;
-	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
-		aspm_support |= PCIE_LINK_STATE_L0S;
 	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
-	u32p_replace_bits(&tmp, aspm_support,
-		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
+	if (of_property_read_bool(pcie->np, "aspm-no-l0s"))
+		tmp &= ~PCI_EXP_LNKCAP_ASPM_L0S;
 	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
 	/* 'tmp' still holds the contents of PRIV1_LINK_CAPABILITY */

base-commit: 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
-- 
2.34.1


