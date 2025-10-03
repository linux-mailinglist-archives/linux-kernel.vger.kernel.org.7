Return-Path: <linux-kernel+bounces-840957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887BABB5CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 04:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76FC3C1134
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 02:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9732D6E4A;
	Fri,  3 Oct 2025 02:36:11 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96AB2D592F
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 02:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759458970; cv=none; b=ghiUvdsvvDfqMOSvRpC+C6WESmNuX8zMsWfrK3sWBWukcHjzJrGVZs9gjDkSv2NsCk1nH8t6rubZjyVQwXNyge+Bfctw87FaQblrZGqv/lF3Vk+nRAnYed3GmwRwmDUtj8+xkrfKegLyL2lEN18yWOkK/mL8vgMO1boqCmPQMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759458970; c=relaxed/simple;
	bh=wA/yhoDXkPXDFDtBTLBNE8yDTcYFQKFGB1ZHSi7YXfc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZerHSaHJfwANmHhzwNfL1RQhYC2uM/zlfiZNqb/QAFCAygLKtanE17gljufuvkoTqvhME+F8F3XCVuIPgA83MqEzg4I4fon7PnZ2Hesp57k3lCghjJ0GevdXfY0mIk0ix6tBzUmCc/aqYRhxpADyvFGHVqjVeClwPE11n4dRSvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 5932Ze70070293
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Oct 2025 10:35:40 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Fri, 3 Oct 2025
 10:35:40 +0800
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
        <shradha.t@samsung.com>, <pjw@kernel.org>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v6 1/5] PCI: dwc: Allow adjusting the number of ob/ib windows in glue driver
Date: Fri, 3 Oct 2025 10:35:23 +0800
Message-ID: <20251003023527.3284787-2-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003023527.3284787-1-randolph@andestech.com>
References: <20251003023527.3284787-1-randolph@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 5932Ze70070293

The number of ob/ib windows is determined through write-read loops
on registers in the core driver. Some glue drivers need to adjust
the number of ob/ib windows to meet specific requirements,such as
hardware limitations. This change allows the glue driver to adjust
the number of ob/ib windows to satisfy platform-specific constraints.
The glue driver may adjust the number of ob/ib windows, but the values
must stay within hardware limits.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 89aad5a08928..56c1e45adc06 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -907,8 +907,16 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 		max = 0;
 	}
 
-	pci->num_ob_windows = ob;
-	pci->num_ib_windows = ib;
+	if (!pci->num_ob_windows)
+		pci->num_ob_windows = ob;
+	else if (pci->num_ob_windows > ob)
+		dev_err(pci->dev, "Adjusted ob windows exceed the limit\n");
+
+	if (!pci->num_ib_windows)
+		pci->num_ib_windows = ib;
+	else if (pci->num_ib_windows > ib)
+		dev_err(pci->dev, "Adjusted ib windows exceed the limit\n");
+
 	pci->region_align = 1 << fls(min);
 	pci->region_limit = (max << 32) | (SZ_4G - 1);
 
-- 
2.34.1


