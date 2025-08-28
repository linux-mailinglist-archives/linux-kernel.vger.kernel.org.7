Return-Path: <linux-kernel+bounces-789441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95AAB39568
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F4030363052
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482222E2290;
	Thu, 28 Aug 2025 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gdFsJQGq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4323009F0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366530; cv=none; b=CmDLr3Bq388FPwJoTactaV3Qa1Lfb3Ab55SktI/On9Rg4I55vaU/KW5OxSy7mcPydk0xgepNzlsuDecBLvXnNXcSh02sOFFglIhaFTTNicjHFsoxvVwvR2LrJIAxfBjqMQDJC7If6Ax2a10fn2Y6KN2KxnX1lCejx6q2iWtf6+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366530; c=relaxed/simple;
	bh=KBp6nSRvIcRzTpSQhn0xmjkXEw3wCkCaBQEeNdgizT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oyRUGcMeIhhLdrcORPivBmlUUevbsSTkFnAazW/YoMtXfqJD7qo1ELierwFXd3H+6mLsWssgFRENsFknQdP0BsEhpr+BWduKVk12xOX4xHphJgZja+Go2GpE8pOpi+ow2THTr0n1KSh7BnwDJsIDi3RiDrk8bBT/6Gojt7uinhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gdFsJQGq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S6547a015828
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WJK4jm7RiyIMS3SdVA3437OyfLU1Kx1wG7QYMtyssFY=; b=gdFsJQGqYz55xKds
	CDh/O1YqTzzh99grZt3qs0FAgX+aiYMIEraOuCHZQjnO17+x7jTZy/NrywqSsJKf
	Me+JTyt44f55pAeqKbSAPMp2tbxpN4zGEfr93+ssRlBbVMI1KocloPE79HUnbjr+
	lGc9BXFiEo74tqRjj/5Y7hccztxSyg9wAPfS+bdEzqObvUTa3H6mZkHhEsC9Tyg8
	uj6agE1JbCskozaCOWBxtt67tsYv4SACJgjJ8X5LMCZc2TQRabJ3vHAkAJicfXIF
	/V9yAWuBF5lgKKOflKOxtl6djEk5C9FwGZYXjEXbseZ1oHZoS/s7ylEZHKKr8DSH
	ah+rtw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpf1npv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:35:27 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b49d8b818d2so916370a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366526; x=1756971326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJK4jm7RiyIMS3SdVA3437OyfLU1Kx1wG7QYMtyssFY=;
        b=PAKnDVdVFV6P1k2OsfDo95IAikbM8TEOT7zu0/lO96Bh89LEF9cp23L5znzzxtHbsg
         23YJvoKaBRtuXw2lnIiSr/0nboI3fzB1YFGA1lv37C4qFdNwBzqZMVUYZkM/oHA7Vq3Q
         ZQKTkw6jVAqV+B6InEhNSsY741hFUAHb2ufhwrCuR+xcijl1a3d8b9txeOD0D7JaaoKu
         fifPUaR/eO6YEvbpw0QvCZgRBM6r98tz56U482jxMl19C//rM/3rAmJAtrTN9UIA1xiR
         HWjitBIj6sNwq4aK/c4nO6WK6ORKglFffvV2a+Vt47cNYlCw1POjo6n7m9tqXcAHsSQu
         +Wtg==
X-Forwarded-Encrypted: i=1; AJvYcCUI4tbnRLsSGVDWSSS8eaG4hJge0KbIVz9lUUll6udF2R1wLkli+Insa+YMeKp1iE8ZMHrjSKgXgiutJjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRd9GAhzvM/0QLQ9d7oLJdVrxYEmKlKR5a/vPfA+R67U4OBloc
	0IUzm7yDTPnci3Vh578sNfyJk7HoKL96ojMfVGfQGfPS3gCIdWlr7fTtsnunkpumTJ9omQlpGVx
	lmgpTIqRA8rASQnqsiktgRju+UzzdiD59FSyPk2HXXa8JJ40C1loKLnoUaRe3ZhA4/2k=
X-Gm-Gg: ASbGncs9q92T/8cJKzQKW1wU/mboxlOh1Ou0EjMvgdTAfzBk0/EJvPwYewdfOQiatay
	NJFSl8XUCHufvhRDajimPO3kPTiSvSe9kKqv7TSJuxQCQG0xkLszLc9qwnUG7dQFbYGF2k/wNB5
	tT74sYF7AWcyUAa/ZKVqu7LuY79fLC9XGfWGLN1+C8GrPIpMl+bKGA1P5/g9sgir0F8rGrZgiGc
	FRlRugeeHde3NxP8NBb1Ob0CAWnKULzumOGyBsSSx3NoCtto+GQnLlVvQulwVtgBPsJ9XMokhNB
	JDBNPBkDg1Fou8DpGeUgDHU71ULq1rmeF4kjEjF0eTWz0GsYgN7fo9xkySqjQ8vnea6a18++Fug
	=
X-Received: by 2002:a05:6a21:99a5:b0:243:a05d:7aae with SMTP id adf61e73a8af0-243a05d865emr7069722637.43.1756366526202;
        Thu, 28 Aug 2025 00:35:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEoFuJglFABJuxVf4orjreJLtLa4Oys5F+mE17UzaMHIHMwekOoVe1507tRqq6Fvj9qvtHSw==
X-Received: by 2002:a05:6a21:99a5:b0:243:a05d:7aae with SMTP id adf61e73a8af0-243a05d865emr7069681637.43.1756366525677;
        Thu, 28 Aug 2025 00:35:25 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4b77dc7614sm9605810a12.8.2025.08.28.00.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:35:25 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 13:04:24 +0530
Subject: [PATCH v8 3/5] PCI: dwc: qcom: Switch to dwc ELBI resource mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-ecam_v4-v8-3-92a30e0fa02d@oss.qualcomm.com>
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
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756366503; l=1995;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=KBp6nSRvIcRzTpSQhn0xmjkXEw3wCkCaBQEeNdgizT0=;
 b=oNV0PxO/r7YhMLERiBsCRDsXhtCB4hqyzujBvtZI4waA9lAZMe/RlJVDQFVqejVxU9MxfVrdZ
 t1pV5VoAoE7BTWts4EGqxE7hXlWO+5yOsh+8ziCrYnGV4mE6wHMf07x
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: cROVcVlA4jcsZyIWa_0-ihlLNw2f_r6U
X-Proofpoint-ORIG-GUID: cROVcVlA4jcsZyIWa_0-ihlLNw2f_r6U
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68b006bf cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX6EUKML7Ep3WW
 mmHTFVrF2jEtiH7JmfMutUiZfQ8C6PWiu2Nntu+o/KY8oeYaS29EcQCIRdl7PDjz6innYtfFP2d
 6/fN1IcAKcHq2UVL2XJVLNr8KwDd55fAWMFVdk0Ysq14HZZkjXdbMcrDCfIh3S8FKXVykAMWTH2
 Psumy39427gRrIxsW554Wv2rEEMZcxnsk/PO3Tze4Ydo70qpGyPXxnjLg6pptS+8TFqqOFKmZNY
 ZOAFZjNaZWu4lfTbSK0BX4jkvJ/MGwC2vU9baCst4e4iu70zLlwE1oxDI1KxJFG+G1ykn8q/+k+
 MZ3hThqIOlp/TCQwjBMrFCtKLkQSv1DZK6/Lg8I6b7I1g/FqkpBlV3pIOA0ljK6dko+C5ywf/aD
 MCZQF3tL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

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


