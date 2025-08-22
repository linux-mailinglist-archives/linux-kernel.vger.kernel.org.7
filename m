Return-Path: <linux-kernel+bounces-781496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED204B3132E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A9D62540B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAED32F28FA;
	Fri, 22 Aug 2025 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="euDquhTu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9861B2F0C5C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854885; cv=none; b=eCJVBpo0kyzSrlIDSDSeVSYnPEWwrG83y8TAcgxonfZxrqV/YcPpIGUIRpw4vYhFw+tfR39VE7jG1m7Gwj7K/WSLZQPhtLB08RBgsXkrMYiO/aVdYTZIz/pOfVwcuLb8NmL24dgx6o2jtXhT2TA0SqyNOXdCaBkBBi/0qi5+QiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854885; c=relaxed/simple;
	bh=KBp6nSRvIcRzTpSQhn0xmjkXEw3wCkCaBQEeNdgizT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q9eLSXXZTWFOieGAXRexPKqTaRLTl+mQ4TlWxEmASO6q1Ra/n25MVGgQ/0qNy8thrg8P+dROTu1NvW5hWvm58Mr+iaMdXkQSuASUAYN0Hhzc12dKuupa+eAm+8fppo+sNaZZracno+bgUbeKjmKvp93xS0/keh0FCy2PIEbofOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=euDquhTu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UIar024021
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WJK4jm7RiyIMS3SdVA3437OyfLU1Kx1wG7QYMtyssFY=; b=euDquhTu/ucAegwr
	sRsjVVucPzpJLIpEPrKj5Cmra5+yQgiV3k2cEdEXD9mhMB68u2UWpsD2OyXCbm0f
	K0cZW7r7HPpybTLSUqq/5r8AFB/XqQnXXsBri3Ml1e63Me95hHnd6R7mI26v3enn
	bddoGtm4FUEJSKA/X9zYaoaUUIfKdXZOIWE8/NwySqdjlZTnWRwJYrd0Tza90ty0
	rqHGeK3SlN+SEC0qM2rIqk7Yi4FCl27WQVVsSGPFoTzeD7oTeyxnXpl2XeRCq8QQ
	Jh/A08EEPw/3cQslEEgsmq0cAqsaJi0cF24IuCge8bDo5sXEy3Fop+HscwxEyBH3
	fv68oA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52agrdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471737e673so3371727a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854882; x=1756459682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJK4jm7RiyIMS3SdVA3437OyfLU1Kx1wG7QYMtyssFY=;
        b=E+G6N6rTjfAEhPwP4GfagEZTvJujdsNP5Pzwga6iWVmfhKNgXLmuG1GQWwgzqLs/Sb
         MusIOqYNxL7BXu5iopmVs+zQbt4DTNa3Oz/Z0SKh7dWqjhgoybS91EPkIZGIOzrpyhK0
         DCrd/EzvN2NBffHWGCxssHgyVgTCqKhn7wt5i1bOfqGL6gdF+UzRxG8ffMmbOdjzlp8C
         35M6oLV62xaCDrO1oYAuuPfw+po9xssyn0QKlr2LdGgriBfQx4VBC/VbOe3lH9MtCAgi
         Ecq81zO8KljTQQGoMDy2ykdzQAqRJPHFMpVHBir69PC9GhVMTZ+TzvMUrQ/M+fIWHBSy
         clPA==
X-Forwarded-Encrypted: i=1; AJvYcCVrQpYPKSx/egdEyMbML0+koorZ+Cnu1kTYhDdKIoRKTRe1jX65LoFZ4Yuva2ywL4X4+00aACDIOuxC/O0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxua5khJr4MWhqRHLkV9/vqLTfRGDOeyyiwyd9ldEeTIAFqqsEW
	WLi/WX8ij0d0LcGzLtRldFqfrRrqzukpb1Y7mofPWPbYFKkUhncUv8QH0AQW3lydS4+EMfxe8Rc
	RevcKBnoVAUtZLxEersJXEwUwRzhxgUvn/MTGAnNOwdCSpyrn/SAkvaQD8QNhOgbBzDM=
X-Gm-Gg: ASbGncvxwmlLc/A3XmJM/2OvRUHtqooDNGVPlHciqHATGcD6RNBbxy0iV4oMRqcIqFB
	jqH0GKFFVQmOlB+Vr4esbCRrQ3M/RPGm+3mTY3EU9h6h/1QgU5MFfQtJUIkeH1f9ErqRF4jPs1d
	RM+0ts5KUb5P9PaMkyHCP0HyDTiX1uWCC/Lsr2aBKUy9nDiXP3pt0tGjwOD/lBfbcgqVk3c/1c8
	6FyKuokRGdboqrpzeMjIcZ0VIoYc6pbTWE1oyjw/Dsj8oaN4448vLzUPO5wnna2nRXikg4GuPvc
	NiUwWgGGkD5Z5mZi0Sni1agOCfV99sL6KTz+YNGF83prNGnZkdtyxrzOC52m2QV3qzkmCU2oeh8
	=
X-Received: by 2002:a05:6a20:3d87:b0:243:25b0:2324 with SMTP id adf61e73a8af0-24340e6c885mr3572756637.50.1755854882128;
        Fri, 22 Aug 2025 02:28:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErgeNlZZ3m9zZEU4DFuk4AWE8QrCvzoihF9b2xvmNf1xFNoCh3S8xIrxIN7DbWrNSGU4njQQ==
X-Received: by 2002:a05:6a20:3d87:b0:243:25b0:2324 with SMTP id adf61e73a8af0-24340e6c885mr3572721637.50.1755854881669;
        Fri, 22 Aug 2025 02:28:01 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32525205d1csm549417a91.4.2025.08.22.02.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:28:01 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 14:57:31 +0530
Subject: [PATCH v7 3/5] PCI: dwc: qcom: Switch to dwc ELBI resource mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-ecam_v4-v7-3-098fb4ca77c1@oss.qualcomm.com>
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
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755854858; l=1995;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=KBp6nSRvIcRzTpSQhn0xmjkXEw3wCkCaBQEeNdgizT0=;
 b=FxAcYjubv2407Ih8C9wrp9VHcvr+HHvpAVCt3J0qt5lQ+3kXOTeXaZHvFSccVZCwsgGp0S/YA
 VKNYdLGH3MtCpsND0xyAgf0RvbF72ImpVk1pjGGfo4rgRjrugdLCbRS
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: IIC2DN8c_cm90GTqLgpWR6kweCiR_YCD
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a83823 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: IIC2DN8c_cm90GTqLgpWR6kweCiR_YCD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX4vnAh8FwX39p
 WDUMl63PSd861IXAFf7R79IlFp+wOZJn4FvfXonzoyQCu9wqctAM4jYFmjnf+sChh9f8zgjh5Br
 HgMVR4u2CZpsC0+sTlT5XhVoj8d6HxsffFYLzgiQA2KR9RBifwfBeYRobEeHpgRefjO8oJ//UaA
 MhlxcWTEfaBOzdZg3zJF+XFe+jJfdCZGdp2N5l2Gu411YJejX4/3wTWQ+4RPA6eDRFb8oTxzR0D
 S3qbj7iebTrWhvl5To2k2GabWi74tbONEryGXSMFgE1iRUu1MEa72GoGOAlML6qAXD2GUz3EhoP
 dmZfG3MNhNGwemDb9zBd0ccvqA3VQdS9jI6MkV1FTVsf4xuFO+EJ07dPJYR/qDG0NkmGSYCVLco
 n6RYRUsvMoNxJRhMt46uQl0gxSFrJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Instead of using qcom ELBI resources mapping let the DWC core map it
ELBI is DWC specific.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..5092752de23866ef95036bb3f8fae9bb06e8ea1e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -276,7 +276,6 @@ struct qcom_pcie_port {
 struct qcom_pcie {
 	struct dw_pcie *pci;
 	void __iomem *parf;			/* DT parf */
-	void __iomem *elbi;			/* DT elbi */
 	void __iomem *mhi;
 	union qcom_pcie_resources res;
 	struct phy *phy;
@@ -414,12 +413,17 @@ static void qcom_pcie_configure_dbi_atu_base(struct qcom_pcie *pcie)
 
 static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 {
+	struct dw_pcie *pci = pcie->pci;
 	u32 val;
 
+	if (!pci->elbi_base) {
+		dev_err(pci->dev, "ELBI is not present\n");
+		return;
+	}
 	/* enable link training */
-	val = readl(pcie->elbi + ELBI_SYS_CTRL);
+	val = readl(pci->elbi_base + ELBI_SYS_CTRL);
 	val |= ELBI_SYS_CTRL_LT_ENABLE;
-	writel(val, pcie->elbi + ELBI_SYS_CTRL);
+	writel(val, pci->elbi_base + ELBI_SYS_CTRL);
 }
 
 static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
@@ -1861,12 +1865,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
-	pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
-	if (IS_ERR(pcie->elbi)) {
-		ret = PTR_ERR(pcie->elbi);
-		goto err_pm_runtime_put;
-	}
-
 	/* MHI region is optional */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mhi");
 	if (res) {

-- 
2.34.1


