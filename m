Return-Path: <linux-kernel+bounces-818528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D5B592E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B091890553
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B67229BD88;
	Tue, 16 Sep 2025 10:04:47 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F932D6417
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017087; cv=none; b=AYRV5XfGY7dOf2xN/sOT8qpgi5C91Vn7h/7NzVD9K9NoOXXskJo4PZ+lrOSVWr6Tv0HM5uPUdYX7mDEmen281Vd/ezhXQGkzEsgwha0L+xQYri3EMaBR2VblWuCBhy/LBw2Y2RjFnX1RdGFXVSQaekghEy79BzLG/iDiMKjYhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017087; c=relaxed/simple;
	bh=xR9zyNh0/DFcmmP7cs/1muupiwP2IACH/7FctIVi4zY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWVzuXS9bgfGVWnMfOukK5VOxUQwbTPQmSxbm1WHaFlsXh5C3xprVTVpth+xvSGm39MbtSAOGcS0unZQvZf78V6GWuK+gN5CU1uUiTtFsvyZBo7HubKp7JCmjgChiIxv6fmXbE09jTe19h4dYklZSIlvkoMUsFsKTa764wrCR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 58GA4PEC067798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 18:04:25 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Tue, 16 Sep 2025
 18:04:25 +0800
From: Randolph Lin <randolph@andestech.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alex@ghiti.fr>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ben717@andestech.com>, <inochiama@gmail.com>,
        <thippeswamy.havalige@amd.com>, <namcao@linutronix.de>,
        <shradha.t@samsung.com>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v2 1/5] PCI: dwc: Add outbound ATU address range validation callback
Date: Tue, 16 Sep 2025 18:04:13 +0800
Message-ID: <20250916100417.3036847-2-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916100417.3036847-1-randolph@andestech.com>
References: <20250916100417.3036847-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 58GA4PEC067798

Introduce an optional callback for outbound ATU address range
validation to handle cases that deviate from the generic check.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 29 ++++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.h |  3 ++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 89aad5a08928..087f9077cf21 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -528,6 +528,28 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
 	return val | PCIE_ATU_TD;
 }
 
+static
+bool dw_pcie_outbound_atu_addr_valid(struct dw_pcie *pci,
+				     const struct dw_pcie_ob_atu_cfg *atu,
+				     u64 *limit_addr)
+{
+	u64 parent_bus_addr = atu->parent_bus_addr;
+
+	if (pci->ops && pci->ops->outbound_atu_addr_valid)
+		return pci->ops->outbound_atu_addr_valid(pci, atu, limit_addr);
+
+	*limit_addr = parent_bus_addr + atu->size - 1;
+
+	if ((*limit_addr & ~pci->region_limit) !=
+	    (parent_bus_addr & ~pci->region_limit) ||
+	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
+	    !IS_ALIGNED(atu->pci_addr, pci->region_align) ||
+	    !atu->size)
+		return false;
+
+	return true;
+}
+
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      const struct dw_pcie_ob_atu_cfg *atu)
 {
@@ -535,13 +557,8 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	u32 retries, val;
 	u64 limit_addr;
 
-	limit_addr = parent_bus_addr + atu->size - 1;
-
-	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
-	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
-	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
+	if (!dw_pcie_outbound_atu_addr_valid(pci, atu, &limit_addr))
 		return -EINVAL;
-	}
 
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
 			      lower_32_bits(parent_bus_addr));
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 00f52d472dcd..6d4805048048 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -469,6 +469,9 @@ struct dw_pcie_ep {
 
 struct dw_pcie_ops {
 	u64	(*cpu_addr_fixup)(struct dw_pcie *pcie, u64 cpu_addr);
+	bool	(*outbound_atu_addr_valid)(struct dw_pcie *pcie,
+					   const struct dw_pcie_ob_atu_cfg *atu,
+					   u64 *limit_addr);
 	u32	(*read_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			    size_t size);
 	void	(*write_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
-- 
2.34.1


