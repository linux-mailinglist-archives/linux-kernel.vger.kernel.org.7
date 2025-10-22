Return-Path: <linux-kernel+bounces-864397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823DDBFAB20
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA435581725
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F7F2FD668;
	Wed, 22 Oct 2025 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bQPLxohE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412382FD7CD
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119544; cv=none; b=dPIVVQLXOdQxJw1FFM5ul4AwnLzeQGLWasgYs+HKj3ahvgYvTwaA3WWkK4itcDw9QrFsOUJU5fF6Gd5H9lmDNiX0zetgo5h3cNeAqXBpx4JpgsT1Qi/q1yWHQGRlRrED5ecBdcnWoexNxMUfqY1acAtz4mFI+c47AHCloBx3tDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119544; c=relaxed/simple;
	bh=m8A7Z+/Uzej0uFR6h+286Hezui6tZ0S/gW9IbjKQFa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rlpe311vk80Cbrf//XUHtkEhGzV0f7mgs7ReFcrgDbg8A4EXP712jjlwY5xdE4Gzo6H/zgQ4of/x8p1t2BdV9tyDD42TNUYb6U41LWQwHVvltKbslOM/1Ef2FfVcVwBE9p2NTo7MQGQOzCx5p1UkJR0WfUi9m0Iv+ssmsQl4ROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bQPLxohE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M40IRA027963
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5n1dR5aX+zAriBU+NGLJBsi8Hal8RuHW2RBllIFUj10=; b=bQPLxohEMDFWGsQH
	Fz8WKZ3W3aPBF+9ytOw1UybxNJWJucWrC33OGj0VmeqNHsNBZTG5P3pYPZiWKWd2
	kRlX1W0l9w67FmengmSaAYkYwoqLL4soCFi0OxZ9leNdm9fCKrxEdzBmgHVEj7J8
	D1mSnYjwO2zUtIiNS5LPV619yZoO73aJSRJByXuTsw74mervdvt0xQE+uZY89aKc
	nQ/deq5YOokqRYeHri85I8tQ/y5Y1FAlIo8Hrum36MJdKyJYdQjy0rwaqIw+Yg0T
	zzlP/ppTxSE33UJs1SU5VO25HaR8N1vHuiUy3DxL+I5ugqvPBuOsqpyIuBr+Gcif
	HAeKPw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j3rhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:52:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290d860acbcso115656735ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761119538; x=1761724338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5n1dR5aX+zAriBU+NGLJBsi8Hal8RuHW2RBllIFUj10=;
        b=Qw+t2h0qmyxiGdkqi6NWrrd2XLYAGUHkTuGL4a1PmPqt5mo5zaLKEETsLwRlVPSBMQ
         sevtfOKN5aAYs7O01ApsSSAOEbUEIbIlG8qF0cS4spVxcwb6lT1kFavFWn1XzjwakEe8
         dcafYVHiJRlhPl17vu/vi0gcjfCoFdTeiOifdVwLWXdmI3TU5evCWcXqXFkR/8r6GY6S
         aCcQ4tmeSt5zBUNIEiG8HAJUOkLht3jXUP91hj3vq31ZLMjh7O8vRSdJGUnBahu4BV5g
         G1iPddJhzlNP+E9rw6cRJx83d3oG4xxajlCffgG4l+As7gUY2whYDhZOmHBtzSQjEVZM
         jIxA==
X-Forwarded-Encrypted: i=1; AJvYcCXIainHHkTadqQeEjHQH6Zy7xPB2QT1bamLoUEntId4z6039tNH9PdZy7/tyJcRa8zbAH+AAVzrSbdl5Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwxInr43YFuNl2kygo9vCts5Z3DCRiZ3SOyjEmB8/QDw0N5gWi
	dXRXafY69neu4aGbVt4ptKFmVFvoDFsPCjwfQ1GJHsfY8TPKHg4oIQIzfejc9MlXwuz17wwoqXF
	+np45+smrNqzmq71meGHglPLzxCEHynkvfVNcNQtCrbbd9om4K9l3Hg+OiSYsQxFedps=
X-Gm-Gg: ASbGncvODqJfRKSImmBS+SD5sSEDQ1FNFB9HS8bD6qjI525gKQit+mGtU4RDqVdz1/o
	SWgqPsuXK4CXk/VZYkfuY5d7sTWnVH4HdJ3XbdUxeCfJJVqPapTo5W7kwX93Q7+vxo/ozc/Ag7Q
	S7dGEHfMZe3GnMltQJgtOgeVp1Ff2A9tq2I2CS0D+6fLwlM6ON54zqybnCTCQ3EAJxAcdpzljJ4
	Wn1ZSh0fjGuXgUFUepGU6hhuLokQFavRXf/Bm7IGytdto8iU8t2MMlEkbTxqh4F2z9Cntv3zY5E
	fSfun13rXKYFB3eH5wWkzKngD8Xe0FrKBAGfI7StC817MafmyBr3QkfCHxMVONIPde6kYcoI7es
	Mf6L3n2aVnp8TOBZnOYzDrWrIbx7R72GT1g==
X-Received: by 2002:a17:902:ea01:b0:267:d2f9:2327 with SMTP id d9443c01a7336-290c9cf2d88mr292037245ad.27.1761119537975;
        Wed, 22 Oct 2025 00:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYK0e81sFkQ1GS8jd2/K+lvCaeoR7f2RXyJh4m31HaVclGbSgGzk/dlUQFYsltNq+HqA+vWg==
X-Received: by 2002:a17:902:ea01:b0:267:d2f9:2327 with SMTP id d9443c01a7336-290c9cf2d88mr292036735ad.27.1761119537526;
        Wed, 22 Oct 2025 00:52:17 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe2c2sm130962275ad.79.2025.10.22.00.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:52:17 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 13:22:01 +0530
Subject: [PATCH v2 2/2] PCI: dwc: qcom: Revert "PCI: qcom: Prepare for the
 DWC ECAM enablement"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-ecam_fix-v2-2-e293b9d07262@oss.qualcomm.com>
References: <20251022-ecam_fix-v2-0-e293b9d07262@oss.qualcomm.com>
In-Reply-To: <20251022-ecam_fix-v2-0-e293b9d07262@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761119527; l=5541;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=m8A7Z+/Uzej0uFR6h+286Hezui6tZ0S/gW9IbjKQFa0=;
 b=34vohxe/AB9YoqTIM7uXejhqFiItgP7v8j14SzhWcI4Jcnu7AgBmd1twlTqLM5Lway7ovQ2fV
 T5uuqcePZ0RAa1wELx0iFoIZ3lEFHexKnuS1ri9mdGZ4oRIVS3tAQoe
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX0kOvcLdEUqJP
 zzzMged3NF0CdED87wfBqQSkm6DAervfvBzMuKNd0m/4YhxTFcJxv7+8l08ndL77Jor6qMkP+0X
 PCYnJJv3jYhhvq885Q8g/EBpY3BF/ENNa1tepFlryia75c4KbEYLxLRtQ3QiYWqH+zU4C1ujPrl
 cY62775JcU/SeLizAVXcC3wNDt7YWWU33cHkpxK3S+1SPglEXWS+tFDtcsyri7Ne+L5qoathKdz
 rdpE9zy4ptdWKu+FYFjzmfNoJoRdZEP/uNyB6drtDT2Eh9LFX4FthTd9khh/1VUNg56LvBnoQ3L
 0O9a4Ab32gV+2I0aPk+jTpxJGVtWM3eXeja0Sj/UsKBvkJIgmXG3uzdEHqA54p9k5TGIRneH2FU
 8q/K8Faajzx4VXXLW4lX7FwY/Gb1Kw==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f88d33 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=oQbQ34n3Jerzy_GFPTkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: tJBl9Ub9cuaQ3fUULhbA5Au5aNdFs57j
X-Proofpoint-ORIG-GUID: tJBl9Ub9cuaQ3fUULhbA5Au5aNdFs57j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

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


