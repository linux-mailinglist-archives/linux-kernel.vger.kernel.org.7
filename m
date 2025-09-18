Return-Path: <linux-kernel+bounces-789444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545BBB39581
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938263641D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC64304BC9;
	Thu, 28 Aug 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ug2zcyFE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479EC2E54A0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366541; cv=none; b=puCdgOOL7ZQug8MUNeFhWCAeQKqVciP9600kSUGiOUObpN6MiOHGl3mEjBCWc9oMHC2GRoo61+DXMm3xKkzxpeTJ+3MLByM3O93myfNvkV7CurJG4cvYWHkZ5lV1YaYKcGKPUpI+beWhCXmcRCHc1n0ApvrbkvVp3Q72Opln54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366541; c=relaxed/simple;
	bh=SOT5cGlpb58tUYLt/M6MzsCLIazUCm6K/kilP0NCvb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h8TPNPwY3FVHzO5rmp1HWHFilrGvJtVNB1tsdVlEBc/jKgKtfJKsK+YYqgbLHyTkET81F+Ej8fPXSwwR8JsibI0Z3dB9ds2++jlLaE2LUeo8VvaWL/Kw5W8cZhzZPTjY2z/OENaK6RTLKP60er7uNztvtsJ4nRhBJzg9STq8Yn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ug2zcyFE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5rOr5014879
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mdI99dLf1C1ECl5BQMbQ2XzHbC/9lRRaEhwE6+uDPVk=; b=Ug2zcyFEn0nb6vUc
	zEN8ehc6zn8mgzT6A4bq189Wj2S1Gzvk27eB1WqZ34vU8RRJMvy2vwneVcug1tOR
	5Qq8SbgXI92AeMGe9sezEquKJXpVuHSiZnqk/+1jU8+IGHsUFOgAo2KW6Q2gQMZT
	egZRSp90tlk26ObkdRmwJh1N+wK2RCcCxRF823sYygDC2xb51qqhYiir1yvbnmhk
	c62fbQLEh/1IqtZsBA/A2o1Wl+Exu6KUpuN9JATxAgYZHRHjtxCm2D2kdi7CFZC5
	prydrxJS7Sk3BnZx2UJJjuPqCl4UZSvi56+spZTNs+uHCYp0wHOoXHtvR9nqoi6F
	N+8WYA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we72y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:35:38 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4c2c09a760so539753a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366537; x=1756971337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdI99dLf1C1ECl5BQMbQ2XzHbC/9lRRaEhwE6+uDPVk=;
        b=Y0DOtoMDmCP+HVu45owPKO9hlB2kCT64eESmfD9HM5oBV9ZjZGZC4bPIA0OIef9JJ+
         BfrChk8gDHQGEYf0r9L0qKr2+fEw8ZQi7KDOjw8q8EHiOF8QfEHCM7RzDmY2NyOiq80i
         G3J7dpBuHx9zspAEviCy0rSHZZn1Pq4+c4D3AHwIZGYtJlT5ddl2C6178+6cr9b9tBFu
         dvSeKj30yZ6lWbWC0o66jCuOiY+FUI3R1cZev890MV9ibY9F0btnvKBXTZ9Fd8zSRYE3
         yfuisQnoiOZR8ZIpPpmNDRDybdJdZYhWh+kKXkH3V4DKvbYBV0ZrAYYavTxJvghnMHfD
         sZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNaemTVnr5s2I62YWLyTVxRGqIbJirCg+sZO+wVlK9nvNlT5i03BkHXGKGNmROFJW6Ft9pnrJoQNe6a0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1mDxJMFTfC8PiGBqbyHUSOYLjQw8KGJmG3bC+EnmGMH479hSV
	grJeBgA6lpC4P9/xp0cJAMLQe1yiMtnQr4y5kIrrzFeJdjeEMuYyxg+H/G751DaGHAC7nhS8AVJ
	6f2zLX3S0of/iEookzsfFnUqnaMBnZhm9Iy99WX8x5Pk2mYNoJ8ziBmWK2dd8AIuZ0u8=
X-Gm-Gg: ASbGnctNqXg01XK/vlW7v6u6yKyuNaQJvD1/QxcDB01H3fNLZja8sZ+2fX3tHm7SW5A
	OARCB/Uxd6ayYmaUglqsgiLEmCAbTuCs3Elv+Zi0rLTLx2ZxKDrQWKlycwRgDW3jyI7RTKOOjJ4
	F3yDa9g0P/ungS6WC2HztFSQXW2HQH6t71WVLOtKVyYg7R6ubSEoZS0mKgsSq502D/p1qWxWFGh
	k7ovcVVZVVipBuRF7cARKjMB6sIK1E9erdMWgvKoqZcfvH00m2XERH5SctWEyW2CDSGTsiD6Zxu
	BNnxvFOtfWI0KLtfuaKu4Ckrb2mo2iyYJMVLPkk/dGETt9SCiTNjObir4PxJkLQIQE/IMR9SaIE
	=
X-Received: by 2002:a05:6a20:4303:b0:23f:f99d:4661 with SMTP id adf61e73a8af0-24340d1223emr34775097637.38.1756366536972;
        Thu, 28 Aug 2025 00:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPKJkzrPSYvs6SE5D7ZnDcbQs3kZDqycFu9LsGoSOfVI+xGTIg/YwbRJj7uy+bE4H3E/2NVA==
X-Received: by 2002:a05:6a20:4303:b0:23f:f99d:4661 with SMTP id adf61e73a8af0-24340d1223emr34775058637.38.1756366536454;
        Thu, 28 Aug 2025 00:35:36 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4b77dc7614sm9605810a12.8.2025.08.28.00.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:35:35 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 13:04:26 +0530
Subject: [PATCH v8 5/5] PCI: qcom: Add support for ECAM feature
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-ecam_v4-v8-5-92a30e0fa02d@oss.qualcomm.com>
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
In-Reply-To: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756366503; l=5936;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=SOT5cGlpb58tUYLt/M6MzsCLIazUCm6K/kilP0NCvb8=;
 b=5T7mKEC+kVDYoC8offDWdkOBIkRE3N+aVHczCvfVmcR1obmYogBI6TeVqii3vsCdDruF6AYZO
 XXeluSKeFsTBDToJ4BVJaGv8mqiz5X/fhRY57CZ03NY1LGVbYYxKyG9
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: TqKtUr1ha7MrhATNVfNx4eNwhfLkiDC2
X-Proofpoint-ORIG-GUID: TqKtUr1ha7MrhATNVfNx4eNwhfLkiDC2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXwVd2PmxQp3WY
 RK/v57h/JHzhi6OcwYL1rs0B0U/+B/9Db7Yo9la2TgpJfewjxaYR4s3kHRuscYLk1MiDTo9rJ3R
 K774W8Qcc426h+eA60julBtv5QsAnkyTO9nF8iv1sOQmn74degdlySHC5h1FeFZROUtCZerEh0s
 b0+eHMpmuC97n0+zSmXF+pU1cZCU7pHfY033tR9vCyJhEniTwmCK12/pbXmYc/GNod0D5rilXab
 BfQbtNkVBd1nwvM37JyVlVNIq52g6BVeNpwK0aby1Er5vTG2g6GJqsgvdrLHdmaY8jgNrQUpjYS
 BFcj2kEOqZUMy+O8Si2Cc552FiG61Wijg+mg7m+UlO+qlNtDGz2705Esh72R2M+c0Or5Wb100C1
 ZfCF7Gi8
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68b006ca cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=oQbQ34n3Jerzy_GFPTkA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
gives us the offset from which ELBI starts. So override ELBI with the
offset from PARF_SLV_DBI_ELBI and cfg win to map these regions.

On root bus, we have only the root port. Any access other than that
should not go out of the link and should return all F's. Since the iATU
is configured for the buses which starts after root bus, block the
transactions starting from function 1 of the root bus to the end of
the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
outside the link through ECAM blocker through PARF registers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 70 ++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5092752de23866ef95036bb3f8fae9bb06e8ea1e..8f3c86c77e2604fd7826083f63b66b4cb62a341d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -55,6 +55,7 @@
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
 #define PARF_Q2A_FLUSH				0x1ac
 #define PARF_LTSSM				0x1b0
+#define PARF_SLV_DBI_ELBI			0x1b4
 #define PARF_INT_ALL_STATUS			0x224
 #define PARF_INT_ALL_CLEAR			0x228
 #define PARF_INT_ALL_MASK			0x22c
@@ -64,6 +65,16 @@
 #define PARF_DBI_BASE_ADDR_V2_HI		0x354
 #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
 #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
+#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
+#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
+#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
+#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
+#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
+#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
+#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
+#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
+#define PARF_ECAM_BASE				0x380
+#define PARF_ECAM_BASE_HI			0x384
 #define PARF_NO_SNOOP_OVERRIDE			0x3d4
 #define PARF_ATU_BASE_ADDR			0x634
 #define PARF_ATU_BASE_ADDR_HI			0x638
@@ -87,6 +98,7 @@
 
 /* PARF_SYS_CTRL register fields */
 #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
+#define PCIE_ECAM_BLOCKER_EN			BIT(26)
 #define MST_WAKEUP_EN				BIT(13)
 #define SLV_WAKEUP_EN				BIT(12)
 #define MSTR_ACLK_CGC_DIS			BIT(10)
@@ -134,6 +146,9 @@
 /* PARF_LTSSM register fields */
 #define LTSSM_EN				BIT(8)
 
+/* PARF_SLV_DBI_ELBI */
+#define SLV_DBI_ELBI_ADDR_BASE			GENMASK(11, 0)
+
 /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
 #define PARF_INT_ALL_LINK_UP			BIT(13)
 #define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
@@ -317,6 +332,48 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 	qcom_perst_assert(pcie, false);
 }
 
+static void qcom_pci_config_ecam(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u64 addr, addr_end;
+	u32 val;
+
+	/* Set the ECAM base */
+	writel_relaxed(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
+	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
+
+	/*
+	 * The only device on root bus is the Root Port. Any access to the PCIe
+	 * region will go outside the PCIe link. As part of enumeration the PCI
+	 * sw can try to read to vendor ID & device ID with different device
+	 * number and function number under root bus. As any access other than
+	 * root bus, device 0, function 0, should not go out of the link and
+	 * should return all F's. Since the iATU is configured for the buses
+	 * which starts after root bus, block the transactions starting from
+	 * function 1 of the root bus to the end of the root bus (i.e from
+	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.
+	 */
+	addr = pci->dbi_phys_addr + SZ_4K;
+	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
+	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
+
+	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
+	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
+
+	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
+
+	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
+	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
+
+	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
+	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
+
+	val = readl_relaxed(pcie->parf + PARF_SYS_CTRL);
+	val |= PCIE_ECAM_BLOCKER_EN;
+	writel_relaxed(val, pcie->parf + PARF_SYS_CTRL);
+}
+
 static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
@@ -326,6 +383,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 		qcom_pcie_common_set_16gt_lane_margining(pci);
 	}
 
+	if (pci->pp.ecam_enabled)
+		qcom_pci_config_ecam(&pci->pp);
+
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
 		pcie->cfg->ops->ltssm_enable(pcie);
@@ -1314,6 +1374,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u16 offset;
 	int ret;
 
 	qcom_ep_reset_assert(pcie);
@@ -1322,6 +1383,15 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
+	if (pp->ecam_enabled) {
+		/*
+		 * Override ELBI when ECAM is enabled, as when ECAM
+		 * is enabled ELBI moves along with the dbi config space.
+		 */
+		offset = FIELD_GET(SLV_DBI_ELBI_ADDR_BASE, readl(pcie->parf + PARF_SLV_DBI_ELBI));
+		pci->elbi_base = pci->dbi_base + offset;
+	}
+
 	ret = qcom_pcie_phy_power_on(pcie);
 	if (ret)
 		goto err_deinit;

-- 
2.34.1


