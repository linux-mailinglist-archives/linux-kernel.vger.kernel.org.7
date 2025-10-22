Return-Path: <linux-kernel+bounces-864396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88067BFAB1A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D19E5807C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F872FD699;
	Wed, 22 Oct 2025 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WVg9qXjo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725012FD66D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119539; cv=none; b=swmi0Shyrj5OIkezTl4Mq6dMEQVPj3HRV8VbxmtCs0COoPx3+g6tVhWEuLNjQXBC+sU8SWPLSK4laV9ed+p838lyI3T53L/wgfoxXJLHzODw/Zff4FFoYKLsGzsQzVifU6dGfagcS1cRyGhGvBE0QQTiNoti3MLFir1oklrboqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119539; c=relaxed/simple;
	bh=FPPlpLkszDfLj/huk9G6D1NresYhSMQaWaal3M8cqFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUGtBDL61FWsgmTTWsbKjFliY6fnF2iUJHgRx25vFyndxNUBtITRXcH7+zSeVlXjUCGUK4Tv12dKq4hxjwxI7e0qv2B4AY9zG63uDt0TKg9gBu4j7hjIhuyxrldljcTs6PeR99QFFrkXgp6GuZb9J8Vj5w5J5rWzwBeHVyiFZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WVg9qXjo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2rWKT024537
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1XhTQViaV/X39Anyp8PIXrWuoocdYUl600DmjKTyrwo=; b=WVg9qXjovDTGU7zR
	N/3nbr54qtCPkA0QVCqhggOOIU1SlVHrVhcVFQUrD7J1VQbqT0HwJJCXSpwit5i/
	FSr5E+nGEAGyfpzQ1kUE/Y9vk2NJZBWytzXlL9Rn0My4E+SVsLn0D/zV04fcVKqn
	iCo3XUWf17t4Jm68knN6ZHrcRIKwH36o9U1Wcale4v2KJVwET/lDRDlkTYVp/e5J
	DoOVXWMbSN6nBki2vYOQhJX77Ayff5K9V+hzNzDinAxMYiXN3wwz+XtKvzAhTckk
	RvH0LoO0F+TW+DI2uqnK5fotvboLOOIsl/mPyNZqr11SCR7Cm3OSxa8eltw2tngC
	tVt9fw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wsws65n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:52:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-277f0ea6ee6so69150785ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761119535; x=1761724335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XhTQViaV/X39Anyp8PIXrWuoocdYUl600DmjKTyrwo=;
        b=JAX3hc4fcVzIfnj6U5toxd66tLz2gzWnp/o9Q7+S9db6dO7j0os17fY06xQ8ArBf1A
         /4rsrV5skkVn0LFJ7eCqEAUH5qew8SE1q1j8YP2I1yFuUpX/pAYwuJAIanbHeQ+HOV/j
         lqxUEpgspOGh7Nxk/9fo/bGqzS4nciPnKmFgi4lji3dzXvi6cs3Imx9TrJTNz8tdeTeV
         FB9vQco8o+gcVRAMHDAyZRtq4SnyzgCA1xkg/d/6Frh4ICQIx+JXveNdVq+Stdmf9sjq
         ZtrOx4SgpxJ3L/E9HQePe2QRoVMpPzF8QeDdIjag25C0g8C5oh+yYmi7AFiQs8egA0wG
         lfQw==
X-Forwarded-Encrypted: i=1; AJvYcCVU7qP6N/mzZESoifBTLie0iLqt43H0NiHKjLk6LPPgWpxYx4TXBk0U+9ac2sFIZ92SQSHDPHBq5nhj5QY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6dTym0GYwdYXWkDssHdktz18rD04Ih4HV16SXurl6BZjPg8uJ
	rkQp20ETxgZsec2D8cYySr+Gw5knZok1FkQSwaV5wDLV6V8M/QZ+vnCWk169SRQMOuk1levQR/8
	cnKDx+Y4R+juXIWU1CK+8wTp/VrM/uEDOzWHO71lIjPNgmG6X7svnbosJ1o9gfUDz7Ss=
X-Gm-Gg: ASbGnctDEOQvEcs8HeQ/sjAgnX7/mGbuE4MTWPMJ1m0Rm2vqybRnbqaFtDneV61IU62
	xWBeycp4ShnXsjN3a3X3qvMwHmtCZGQ28M7MHqe3lxsj1JV4moF61cbrF2WMg0RVjjtWyhuQ7oX
	GBZtYi0ewddEYJjmqCCKPAoVcO4Dnvei+6f+654tLYcKm8CO2ig53LL+zVDymyc4tlu2LTNPr6P
	nMpi5C9MqOnlqeekSCH6VK53IQKbsm2BLNRvYkselLlRGDKYUExQ9INJ02VbTHQawan8FXo2R2a
	/CIc1Gz7q/pWYtfzcGpzGRWa1JBMv6ajUOmgEz15fY6OVtYZp8TWaYYNZsBrOD+IBacEXMH1GPU
	tAzpMDlGJllHPRV/BT84SsTQ2R+MD0pMUuw==
X-Received: by 2002:a17:902:c942:b0:290:c5c8:9419 with SMTP id d9443c01a7336-290cb65b8e4mr250331655ad.48.1761119534687;
        Wed, 22 Oct 2025 00:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGqlXT6fObHhgr1D2s85s+Pv0yavAO6a7DXv5jdQ3toDjpK+j4sVXiG3YIRDD8cQ3vqXRO0Q==
X-Received: by 2002:a17:902:c942:b0:290:c5c8:9419 with SMTP id d9443c01a7336-290cb65b8e4mr250331255ad.48.1761119534226;
        Wed, 22 Oct 2025 00:52:14 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe2c2sm130962275ad.79.2025.10.22.00.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:52:13 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 13:22:00 +0530
Subject: [PATCH v2 1/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-ecam_fix-v2-1-e293b9d07262@oss.qualcomm.com>
References: <20251022-ecam_fix-v2-0-e293b9d07262@oss.qualcomm.com>
In-Reply-To: <20251022-ecam_fix-v2-0-e293b9d07262@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Ron Economos <re@w6rz.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761119527; l=3184;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=FPPlpLkszDfLj/huk9G6D1NresYhSMQaWaal3M8cqFs=;
 b=uN/3l2SCGQPO7zxgVFtEl7qZ1QV32AyKSorVhSrZUlAabqbmVIrMdvtG1a4tyU6XQywyr8J0s
 eeOrhLz6yziBsLjSRO5ndXRi+0t507j5jlJg4dYjjJs+YoPjNj4I8I7
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE0OCBTYWx0ZWRfXxAOeiaeWcsoz
 M4swDwxgt9HYxAKSICHoYLRJtO9Uy00kLVE29E6MkxyZnlSMW/MyyV3CAokOdgq5EvosgrL4N1n
 Ht/zd0STvQGKcx6fk6lAYDpah64SeViNYJ2ae5cWUwb0Lt/3Yy0GE16iSY3GeGgk6FXD72r6ILT
 YC1QhYClomv1EYDHmAjaMtta2A7DhlSOIt85RwJc1bKy2YxzdpOjJHC4yMIliuHtP8UCy/UXkyk
 3/DBWfBN487icH8vgSvlwWjqSryzylN3Y7SqvAvukcWTd5RfGCjDkMXzGCoTTRPAQcvOPPAT5wQ
 2AAoDtbEz73drKd6aip0cpfydLaJ8xzG8SxHSsnKokvxRWZA9yLZ0atoErfyyUmnq/M76hT+7bl
 7YACBgQBegRrrQmXwpEdPNJHfUYjVA==
X-Proofpoint-GUID: UZZrcs7lpnVoKiqoL21E6LmxHcuHO96V
X-Proofpoint-ORIG-GUID: UZZrcs7lpnVoKiqoL21E6LmxHcuHO96V
X-Authority-Analysis: v=2.4 cv=a+E9NESF c=1 sm=1 tr=0 ts=68f88d2f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8 a=EUspDBNiAAAA:8 a=h4B-02p0z56_JbXvspoA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=nmWuMzfKamIsx3l42hEX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200148

When the vendor configuration space is 256MB aligned, the DesignWare
PCIe host driver enables ECAM access and sets the DBI base to the start
of the config space. This causes vendor drivers to incorrectly program
iATU regions, as they rely on the DBI address for internal accesses.

To fix this, avoid overwriting the DBI base when ECAM is enabled.
Instead, introduce a custom ECAM PCI ops implementation that accesses
the DBI region directly for root bus and uses ECAM for other buses.

Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
Reported-by: Ron Economos <re@w6rz.net>
Closes: https://lore.kernel.org/all/eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net/
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Ron Economos <re@w6rz.net>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 28 +++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c4812e2fd96047a49944574df1e6f..7d95d8ec9f8190dbde80283db78ca74925532d2e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -23,6 +23,7 @@
 #include "pcie-designware.h"
 
 static struct pci_ops dw_pcie_ops;
+static struct pci_ops dw_pcie_ecam_ops;
 static struct pci_ops dw_child_pcie_ops;
 
 #define DW_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
@@ -471,9 +472,6 @@ static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *re
 	if (IS_ERR(pp->cfg))
 		return PTR_ERR(pp->cfg);
 
-	pci->dbi_base = pp->cfg->win;
-	pci->dbi_phys_addr = res->start;
-
 	return 0;
 }
 
@@ -529,7 +527,7 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 		if (ret)
 			return ret;
 
-		pp->bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+		pp->bridge->ops = &dw_pcie_ecam_ops;
 		pp->bridge->sysdata = pp->cfg;
 		pp->cfg->priv = pp;
 	} else {
@@ -842,12 +840,34 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
 
+static void __iomem *dw_pcie_ecam_conf_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	struct dw_pcie_rp *pp = cfg->priv;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	if (bus == pp->bridge->bus) {
+		if (PCI_SLOT(devfn) > 0)
+			return NULL;
+
+		return pci->dbi_base + where;
+	}
+
+	return pci->dbi_base + where;
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
 };
 
+static struct pci_ops dw_pcie_ecam_ops = {
+	.map_bus = dw_pcie_ecam_conf_map_bus,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
+};
+
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);

-- 
2.34.1


