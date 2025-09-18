Return-Path: <linux-kernel+bounces-781499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9CB31330
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14ED1C221F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9EC2EC54B;
	Fri, 22 Aug 2025 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hp3LNij+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E61A2F39A9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854898; cv=none; b=GjwJagORZbcQ7wV/9srYWhKvCYRKu8LVeyC6gVd/rp3I5oCq/rOm79yzo3QcOHBBPfANPQzFetgrJ6SxhO87c95i3lvc5+8TApNy/n7jV9sEt34f8HLImYWlvgctN03AGQ+ZeYmCenrUOVPAWQCaOPBMuBXyOp7MXHlah6dpXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854898; c=relaxed/simple;
	bh=SOT5cGlpb58tUYLt/M6MzsCLIazUCm6K/kilP0NCvb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WJ7sAv3NgkmRcnONN1UlisKIQ3beysUQEQLNnKv/0RLcCdxqVvrBSEt+v0tkYE6SLxygYLBfO3qCokdsxTqYGUklviWsOveGZ0zoag/jtwv73LRHsdyKKQ1+QlYFhLVGZlMRCzzHWhiEEHv2NBe0ae73bPsMMEPOQHWDlgBahUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hp3LNij+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UOwd024194
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mdI99dLf1C1ECl5BQMbQ2XzHbC/9lRRaEhwE6+uDPVk=; b=Hp3LNij+hhmAgt0W
	Qz603IKO6AGRWBBsM4I/cWVuRInqyXVApRJ7Evt2AIbmKYWN/mFEFbxAaW04pERg
	Cz05Vl6qyIgzKwyLayo2nNbN1GIryaduRTGHG6KCy8ab68ANGAP4XRZg0KfLkTqZ
	64XWtVbm+iCudMMJuUTAUmwZbNX2I6ArF2ss0e7MBX6YAyDoZZZW+EAuqOjHzS7S
	gYs49gwroJRTt8cxp/fJdKB9XEBj21az+WjgwNseVgAI/WadAg5RvOeFqqa9RfC+
	1eDjue23wbYe+a2h62RiytoHBX4LrZh9WoOBaGv36kkvEHpml5lovrUXfGAoAcOO
	mbIJiQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52agrgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3252a37fda8so319934a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854894; x=1756459694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdI99dLf1C1ECl5BQMbQ2XzHbC/9lRRaEhwE6+uDPVk=;
        b=b3lCtN6apAmwShB7O8uJgfLTA6Bi+aT4xGWeVNqpdXgaBHAq1K0s6LqZk7Xl6p+TNj
         3QU9aojwvWjtM/b88uloJ8Zx1Z2lSYbkT9LXhRbWLnFoCt8KFC4JK4+6fkrXgm8EXx7+
         a4bhjf9oD2eprw7LQ3pNywSPfXl4dVLu1Cco2lRbV8d/SW+9sFpndiWiuNs7gBwSkTy0
         foyCIfXv6LaND0fxD1iKXBe8DEhJcRFxZDIGMVSrnruGSGpf9emEfaX4kV+RBljm+2rY
         AZTbvuS3cRrUioXE5m22tzPeYYY7lnVnz8WGOPP4q5LhN/e3hq27E4nhyBvhsRS6hcq/
         NCfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWDxyobq+FHJVlEwGUpejwUeQIdiAXIwShRtyNsIeEHTIug1lx5EnP/36fbb5/yZR+Hj3pH5/Uqj5Lm5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0g79+X2Sz4ZqRyObjxd5kFAWKmVvdrGNC9d9ZZyZr8ZYeRPYv
	2FnytX+Qlharxs0C321AtpUAzINX4OSIGFPnE+ULM69xjz0xuFE7GwtZbWSf2CcGBJuIvMEoUAb
	IJ0TtuCIW/eR1or32/Y5z5Miy+iA49VaVUGH3oD4enJefn62tGTxqw7bmJYLyy4D14k8=
X-Gm-Gg: ASbGncsEQQjL3Qhr9i5gMiLuMlKrl5fCJjBhKjaWiYvbNpkibo/j3t4o2/Ju+3dAUxe
	u5tyK0YpNUp1tckWlkapdibeun7IooItzhZDbvvo5qNkRyUIJKUmSGiN+e0lIMy1JIQ3FAUC89D
	b43Ovcbg48tjldj2XYEjDpC3AczaXsGwIT0oMtVmg/TpsHdcJRzGF4fXe5crd8ua3IWuD5zZcxF
	cYViivyDgB067kEk7W67rFA4s/rrxetFv2B7UibcJf4M0ZrXEmwWUD0UEF1U0IE7PfCCIn3BZfl
	f1W0i6MXwM8JFzbbOs6Z+Kg1nL3Ye4EEg9M5raqwGxbRTazlRl3KuIgA/ok36m4sb17fD4w5B2I
	=
X-Received: by 2002:a17:90b:278b:b0:323:7e7f:b8f4 with SMTP id 98e67ed59e1d1-32518b80cfamr3394092a91.37.1755854893866;
        Fri, 22 Aug 2025 02:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7VrExFnDlGbeOR1PxrtvPDRrJOKWRFkczToKjKFje2jrXPwafW08yHjZroWItQyC6aiaimQ==
X-Received: by 2002:a17:90b:278b:b0:323:7e7f:b8f4 with SMTP id 98e67ed59e1d1-32518b80cfamr3394041a91.37.1755854893306;
        Fri, 22 Aug 2025 02:28:13 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32525205d1csm549417a91.4.2025.08.22.02.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:28:12 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 14:57:33 +0530
Subject: [PATCH v7 5/5] PCI: qcom: Add support for ECAM feature
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-ecam_v4-v7-5-098fb4ca77c1@oss.qualcomm.com>
References: <20250822-ecam_v4-v7-0-098fb4ca77c1@oss.qualcomm.com>
In-Reply-To: <20250822-ecam_v4-v7-0-098fb4ca77c1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755854858; l=5936;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=SOT5cGlpb58tUYLt/M6MzsCLIazUCm6K/kilP0NCvb8=;
 b=PF3Wa+0tr/NJw7WQoFVepnVqF4s/maNySJH6w91uf6PxfRpxdKYWzXvtiHWI00ODmZi0e+AyM
 cFpVdfFbJotBfmpnqZpairwKVe3mtoiCKIThAB27sQVUiXkXXjyy32N
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: C5UAP94iDZhLFzd3ONNHeJS-bfA6KNDE
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a8382f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=oQbQ34n3Jerzy_GFPTkA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: C5UAP94iDZhLFzd3ONNHeJS-bfA6KNDE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXzlSRfWJ0+PJe
 KzFGBpLd8RzvWGULzAc8jikX8uckvc+B4piIzJ/rNyFMHj1JprrkHwNbfAfUnXRM1l5a+qPALCL
 xfaOho5R1egRz/eW7+jG9vbKC3oisa21YF2lbpolmWILO7tALgI/SOro2npBY3V4+pxYn3ixehB
 pProYniz255R+4oAtxXcllneED9o9L0D4uwt4MIH7kNMPDRoepos0fRL3+Vo6et8WlAwolpf0pu
 hsw8PvwotvMphtumjWLUL8goAMAl6Yt3KFJcNLwXuiCcizKJYxh1dmSyxhvpzyt6X36ywvDyHGd
 FjtoJoUnVg4zMqNxz2Th7LZjibFwK1piiPhDEmZtTw6Y43IPw6T7pvc52V3Cuilcvs/GF3Ghj4D
 bicit9efr8oZCdHEQloEJvr0+2qCXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

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


