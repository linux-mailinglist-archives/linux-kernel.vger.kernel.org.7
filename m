Return-Path: <linux-kernel+bounces-857978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD332BE8700
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA9919C0A14
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C92332EC3;
	Fri, 17 Oct 2025 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WKynOOb+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88541332EBE
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701272; cv=none; b=qFufj6ooYAATl9YI5Ounb5QBUVqxWM9cP79QUD/xbjP5xv3fvcn7bS15Bw7bRXShzcRYX4eh46CunRkgzrKzn1AZ/Sdb8GjoYpXDYvTFmepDjHHTeRomDXl/i3hQfYEnWVLsgaRpdNNLeBCuDV+z9nyQh5j+5FBCIYxg7ZFMdRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701272; c=relaxed/simple;
	bh=m8A7Z+/Uzej0uFR6h+286Hezui6tZ0S/gW9IbjKQFa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kjmIIkyz6U6pgNMtCUrKEHCUK+iB/YWfwXSz3J81KdGVvD+rOvcs/O1cr/mpu52uiYAtON3WdBGOxs0KbQZrZuwN3bCUCY3r+shsS/G9Y1UwH18sq0yHisrdfQtHlbht72Bli3BmhEbMIXMm/u3m71p+TvqwVly/BRZU5XEKYaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WKynOOb+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8PF8G001722
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5n1dR5aX+zAriBU+NGLJBsi8Hal8RuHW2RBllIFUj10=; b=WKynOOb+fb/pSCyt
	OIjuFO3J6G21QmJ6ZmWPwwH+JQV++S33w7++gDM5XhkpUiDqrf+x0EyVzrVRgDM2
	A7/u+NeX73Iw09+66nFG50f4kmR3nwty0UlxARTVCzl3MjLbqo2VWhd6HuHViFRq
	ZWTlkqgy2woi+hDW3SmHC86ikCnRP2hEYU37LcWHbSjDhyUBWHzQj5oD4ecFY58Q
	Xyeo3oqYmm1XNS94ZTj4w2chR1WV8MS8nO8GBqPOaAGfk5G7c2nqid9T0MY6jZjE
	geWeGCOFroLm0EatkRBWlVLO3PjMr+Kyh3aDLLg1CooqfyGWf7vpt2mIaA+OHg51
	0C8gEw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd9c4a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:41:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290b13e3ac0so16273505ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760701268; x=1761306068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5n1dR5aX+zAriBU+NGLJBsi8Hal8RuHW2RBllIFUj10=;
        b=lS5zPXDhPieG4pa0AaKfQjZ3N2T1CDj0SJJ/J79dki1gqGRrxTbiqLDd4FfQKHoijv
         qBSY97xe0qZYYTc9FLtIM3Fro1h+2uz4SZEjD8nBOKMgBUvq0GrbjJAL4tnre9Dkl5ia
         2Sx6qSnmltFRgTQOqF+7u6xuKY+bsHKq684UIEYsqwb4GGGXzgeha8QJaAdv8ncV7KNb
         bdjjrQrovgtmCji4C+Ep2ufZfc6EKVFm6a79OxWDUe7FSerEhH1PkZ8sJjvplX4OTy+8
         iwRRf5tyw6t/7pwWzja9ZKeBeL13PtkztJp0Zd0q150teayUGztMghnGwM7k7HQ9/j5V
         O1gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtCfxtJA8YjrhxLSSzu7MzVzFfbbrfI9Ho9vcYRakfAwi9A0CmuaMCWf1SFpAfJkVD8NOyDfRXVYWR2kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1dkYQaJAQrM4nrMCTH09a9AFuZCv2F45+zPcrE8IkAnW/MmZu
	MW26LO9B67h9j5uxo3OLlCxsIP4eFeTdSlaWjzrOXZO8/Emt7teT5z1OfYcFnGKRicYUZ0aDM9X
	Na/jZ/8KtCkx7IYPN2jQXY27+ofCXbrrY7N93rsRaLgG+iYpYmu5iEBPkGWQCLyecHu8=
X-Gm-Gg: ASbGncuDBz76te/gqq2X1h20RreqqKyyH6RwyBQgPuTPt40+k6rjDK7AMojnlonpq1Q
	Uh/7b5VShrlq8MjF+cm2jXm4DdTpMR3nN99F32Hr29+OcHDpnJDc750MknXQmsuqL++lAutkVvk
	TSImJMIKna3Q0CJnUXXEYs21V6mPswjPps/di17Isx+isuk8S8E+4JYM6C6mQA6/ZD+GSo8lnVr
	mrT/cnYM8q+6fgU3m+aWYH3Vm+2yVMs6iiWLESulEYHaBoEQFTKwDgNmYhRLKsncnlw3VAg+NLj
	jrcGspxcYgTUhkTkcfz4qljSBKQgC7SP+UbP2E/soISJTuhTunmBAF8wvp+L+sbknR/eFTXDGIA
	XNCvfYavvognfI8slgaEdISzzxrPoYmT/1Q==
X-Received: by 2002:a17:902:d4c4:b0:275:27ab:f6c8 with SMTP id d9443c01a7336-290c9cae467mr41612685ad.20.1760701268384;
        Fri, 17 Oct 2025 04:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjocfv2Bwqp1t3hLZTsL2tXXiGCuqJgYvVcqzCxvcCoJluwhDdXDTl9H3Va3U0brH8h+pMYg==
X-Received: by 2002:a17:902:d4c4:b0:275:27ab:f6c8 with SMTP id d9443c01a7336-290c9cae467mr41612325ad.20.1760701267877;
        Fri, 17 Oct 2025 04:41:07 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7de45sm61489675ad.54.2025.10.17.04.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 04:41:07 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 17:10:54 +0530
Subject: [PATCH 2/2] PCI: dwc: qcom: Revert "PCI: qcom: Prepare for the DWC
 ECAM enablement"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-ecam_fix-v1-2-f6faa3d0edf3@oss.qualcomm.com>
References: <20251017-ecam_fix-v1-0-f6faa3d0edf3@oss.qualcomm.com>
In-Reply-To: <20251017-ecam_fix-v1-0-f6faa3d0edf3@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760701257; l=5541;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=m8A7Z+/Uzej0uFR6h+286Hezui6tZ0S/gW9IbjKQFa0=;
 b=cntfPsyXyoirVDrMCNoRoHZw0o6UlinA5S64MEYfYQ9uWQ6+z2m78Vufta8QLAA1FtD4hQxIt
 tIZpfQRmkdsBUII32Na0gIJiMEFma6lce6GHdsIVmNBz6p7TNs96b1Z
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: 7RC1KMKqbkb6N0kQ5ifilp4KT7D1WbZd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX6oXwciyLqHmO
 PPGbSVK0qf9qB3gpsbs5Lj35j6gJ3f504ijX+MP4MzTJtUzvCoUMB01jssKsVU9kXcLfPJtDqRp
 xU4wyfEmHickUaTB3ady55qTekm/HANCvyUGTapXs3MlP6ZkleA0r34h79uFD1pQhIFpio9OEXD
 WIxnZwCZSlNpM+DoVE+bJNKwG3FLBEUEsyRzz2b1i2HUC9clU0UtSOUcokrC+pa+hAh/fmTeC86
 2vhcf0enHizRjahngFVqBpDYKWHiLNr0QhlCn3V1EWCWw/tZGUo/HJYHkLELo8xWLYiAokAjNyy
 zCWJa822X2lCtpSiJBgXd4URDregQv7bc1YuItUg6H3xfJQRq4QQOYf90+jgGJiQ4QG5L46MASD
 22kKOKdZbNeP4Mqk8WOT47n6aP/TKw==
X-Proofpoint-GUID: 7RC1KMKqbkb6N0kQ5ifilp4KT7D1WbZd
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f22b55 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=oQbQ34n3Jerzy_GFPTkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Commit f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM
mechanism using iATU 'CFG Shift Feature'") enabled ECAM access by
using the config space start as DBI address.

However, this approach breaks vendor drivers that rely on the DBI
address for internal accesses, especially when the vendor config space
is 256MB aligned.

To resolve this, a new design avoids using the DBI as the start of
config space and instead introduces a custom ECAM PCI ops
implementation. As a result, the qcom specific ECAM preparation
logic is no longer necessary and is being reverted.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 68 ----------------------------------
 1 file changed, 68 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 805edbbfe7eba496bc99ca82051dee43d240f359..6948824642dcdcb1f59730479b5a3d196ebf66ee 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -55,7 +55,6 @@
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
 #define PARF_Q2A_FLUSH				0x1ac
 #define PARF_LTSSM				0x1b0
-#define PARF_SLV_DBI_ELBI			0x1b4
 #define PARF_INT_ALL_STATUS			0x224
 #define PARF_INT_ALL_CLEAR			0x228
 #define PARF_INT_ALL_MASK			0x22c
@@ -65,16 +64,6 @@
 #define PARF_DBI_BASE_ADDR_V2_HI		0x354
 #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
 #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
-#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
-#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
-#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
-#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
-#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
-#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
-#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
-#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
-#define PARF_ECAM_BASE				0x380
-#define PARF_ECAM_BASE_HI			0x384
 #define PARF_NO_SNOOP_OVERRIDE			0x3d4
 #define PARF_ATU_BASE_ADDR			0x634
 #define PARF_ATU_BASE_ADDR_HI			0x638
@@ -98,7 +87,6 @@
 
 /* PARF_SYS_CTRL register fields */
 #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
-#define PCIE_ECAM_BLOCKER_EN			BIT(26)
 #define MST_WAKEUP_EN				BIT(13)
 #define SLV_WAKEUP_EN				BIT(12)
 #define MSTR_ACLK_CGC_DIS			BIT(10)
@@ -146,9 +134,6 @@
 /* PARF_LTSSM register fields */
 #define LTSSM_EN				BIT(8)
 
-/* PARF_SLV_DBI_ELBI */
-#define SLV_DBI_ELBI_ADDR_BASE			GENMASK(11, 0)
-
 /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
 #define PARF_INT_ALL_LINK_UP			BIT(13)
 #define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
@@ -326,47 +311,6 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 	qcom_perst_assert(pcie, false);
 }
 
-static void qcom_pci_config_ecam(struct dw_pcie_rp *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct qcom_pcie *pcie = to_qcom_pcie(pci);
-	u64 addr, addr_end;
-	u32 val;
-
-	writel_relaxed(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
-	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
-
-	/*
-	 * The only device on the root bus is a single Root Port. If we try to
-	 * access any devices other than Device/Function 00.0 on Bus 0, the TLP
-	 * will go outside of the controller to the PCI bus. But with CFG Shift
-	 * Feature (ECAM) enabled in iATU, there is no guarantee that the
-	 * response is going to be all F's. Hence, to make sure that the
-	 * requester gets all F's response for accesses other than the Root
-	 * Port, configure iATU to block the transactions starting from
-	 * function 1 of the root bus to the end of the root bus (i.e., from
-	 * dbi_base + 4KB to dbi_base + 1MB).
-	 */
-	addr = pci->dbi_phys_addr + SZ_4K;
-	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
-	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
-
-	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
-	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
-
-	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
-
-	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
-	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
-
-	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
-	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
-
-	val = readl_relaxed(pcie->parf + PARF_SYS_CTRL);
-	val |= PCIE_ECAM_BLOCKER_EN;
-	writel_relaxed(val, pcie->parf + PARF_SYS_CTRL);
-}
-
 static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
@@ -1320,7 +1264,6 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
-	u16 offset;
 	int ret;
 
 	qcom_ep_reset_assert(pcie);
@@ -1329,17 +1272,6 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
-	if (pp->ecam_enabled) {
-		/*
-		 * Override ELBI when ECAM is enabled, as when ECAM is enabled,
-		 * ELBI moves under the 'config' space.
-		 */
-		offset = FIELD_GET(SLV_DBI_ELBI_ADDR_BASE, readl(pcie->parf + PARF_SLV_DBI_ELBI));
-		pci->elbi_base = pci->dbi_base + offset;
-
-		qcom_pci_config_ecam(pp);
-	}
-
 	ret = qcom_pcie_phy_power_on(pcie);
 	if (ret)
 		goto err_deinit;

-- 
2.34.1


