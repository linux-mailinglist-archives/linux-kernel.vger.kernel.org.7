Return-Path: <linux-kernel+bounces-830411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 603DAB99941
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED6A4A6E17
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401592ECE9D;
	Wed, 24 Sep 2025 11:29:17 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D22E7F04
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713356; cv=none; b=neEMkBFwOPa5Ruy9BgHJvd0nWhNjoTFaQfJXqM3noFbucDtY3BvLB1PeTJ788WMmJQewpA9fS8OFggCubeY4nhq4pQ4FxYH13gSthrSjsz5xdX1/QeTBJbSaWJgKu06yxJqvCgs67+fX9vrCF1uRZP4eASTQieElT/5ncBugnLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713356; c=relaxed/simple;
	bh=ToVhFsgTaUkSAbbRQI5th+VEOqb/+MGFW5F4/tcHWWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdnlUMGUMyw7JAXeRMYQOAMJyd/00qdOZDnCY1tfqxv/oNWu26BBF+w8OT0XFwDP0yYxaHut7EQOEqMDXK9QcemaYkYLO/eZadiw7cuOIXzsY9H7EAjQu74nYJIiqJuoXnCkpcv/pzvZl4L/e8cjv2OuDL1s8C5xIwFeRjbJEos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=unknown smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 58OBSTgl074423
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 19:28:29 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Wed, 24 Sep 2025
 19:28:29 +0800
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
Subject: [PATCH v4 1/5] PCI: dwc: Skip failed outbound iATU and continue
Date: Wed, 24 Sep 2025 19:28:16 +0800
Message-ID: <20250924112820.2003675-2-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924112820.2003675-1-randolph@andestech.com>
References: <20250924112820.2003675-1-randolph@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 58OBSTgl074423

Previously, outbound iATU programming included range checks based
on hardware limitations. If a configuration did not meet these
constraints, the loop would stop immediately.

This patch updates the behavior to enhance flexibility. Instead of
stopping at the first issue, it now logs a warning with details of
the affected window and proceeds to program the remaining iATU
entries.

This enables partial configuration to complete in cases where some
iATU windows may not meet requirements, improving overall
compatibility.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501..91ee6b903934 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -756,7 +756,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (resource_type(entry->res) != IORESOURCE_MEM)
 			continue;
 
-		if (pci->num_ob_windows <= ++i)
+		if (pci->num_ob_windows <= i)
 			break;
 
 		atu.index = i;
@@ -773,9 +773,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret) {
-			dev_err(pci->dev, "Failed to set MEM range %pr\n",
-				entry->res);
-			return ret;
+			dev_warn(pci->dev, "Failed to set MEM range %pr\n",
+				 entry->res);
+		} else {
+			i++;
 		}
 	}
 
-- 
2.34.1


