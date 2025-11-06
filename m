Return-Path: <linux-kernel+bounces-888352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9B2C3A907
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F234A1A44F6F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE2330F7F2;
	Thu,  6 Nov 2025 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aCcdLzIA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GnNiCVsA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4B630F7E8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428482; cv=none; b=sHU9INVHrf+U4+J8i8Y2djPZoO0NJHEt7rK1hQRn+CA7QTanOoJwy6bJyDbsHeU1zMEuENtUx1vAgcg+vM4tQmtqJLkW/H7YeigY5q/FCSfLeoTKRn4648FNCzkVQaxMmwKJKF0FVaRHgVQ0CBm2MnmdVloQEHtHQmCC6pMt6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428482; c=relaxed/simple;
	bh=mwR/yFYKcstYoJ10AjG3GZOJrZ5Qy9z5Uli1etRKCUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGPTArvVR2LeqKP/6PlFdUObjA3gNVpiqe23nIZx1f9yE2RPu25Mx0Z4KlWZc8vfgRZpuX6G51Sn50i+x1wSnDFGRoNp99m8BdahJXZUpvnRjDX4c0quX42zPqoJW3VXYdA7ulLBzc/KEQ5A3QSoYJ70Xr9DmkyxF9TfBWSQAzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aCcdLzIA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GnNiCVsA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A68l3w32389024
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 11:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0TyHZHy1wRz+vL12tq/NhtcctDrNMapUBKXF5sMxJ2c=; b=aCcdLzIAq/JQ+Bna
	NR21sZPTAPHwW7WbzwJzejbApuWTU0BYO2E8syqKaFA/wTmFeTAU+QIs5QIOVbDC
	/jNrPEGOrdMch2eoA/6Ff8hu4lZlAOqAtb6wJrxi8Er8IIcJmeSr0tTyfXkZuwPT
	+DJz3mE37ERWWPs973fI6aok+8irBamnEI3QiFQdX7zII5wt1NGsGYvoUGbfhVfa
	afSGbvMclEoCZ98vhsL6QqUQ74RXRgHfC49pDBmHRXbZU0giRyOWCJtKoO0o2Prp
	GL1hGvRi8fdPL9Qcf/lliGW+ikU3Ro2n1ghGHUC56ep4LY5Du9dRACyRXVCAEGKh
	4H4YYA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8h9usnrb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:27:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-294df925293so10694825ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762428479; x=1763033279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TyHZHy1wRz+vL12tq/NhtcctDrNMapUBKXF5sMxJ2c=;
        b=GnNiCVsAN1wmGOZQ4CEvATXGNcxdjxdO5HNI6GcoVfBuGZk3XwS8swUwau4i2ivU9t
         2uri7oA+WpdsqkzSHG/aLI4+9b3e2zS2ZnuZubosBcPFiDVHY5+SV4ltL56TLaaONKH5
         TG1OP0Cv4FqeLnr2IeSNGedQBx17kyGIe0eURjaaJZ7o36v+AT37Nlg8yNRkIAp4mKWO
         qokHKTuYky2NMqFGGq9Ch6+CZgPW2jDDUSMnB7nRpWxSpMmKkbkPA/BsWNAowak0OEZK
         zeATCBOjz/G3ixg4K87qxSfAagkAY+Mqu+D0I4hTvfudGpqeLoDYWzPs2eQbNg9zDcv2
         pS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428479; x=1763033279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TyHZHy1wRz+vL12tq/NhtcctDrNMapUBKXF5sMxJ2c=;
        b=d4CxAe+WNgxW+UBmIR96wxUhlvO2F4u1wrzum2iCyAvqWxaZZ/lsshOruVU0KbLpzP
         S72NtBLJ7TJKwscvsMPczt7/HriwLdyQ6QizwN/0k837lxTT1qCqA0blKyxZVqoLIJ4b
         aIxLSW9Pqe8LfoV1wNtmibtH7HzC+784BKOBMuzYLMfRxO7ZAWDWIWgmRiAtZn1uYL/8
         uidkBMmorlbs2uKCrLkCzrhbEZV5/zKSRK33NQAkozY1NMk8bSl8haIRqwsXd8uHYQ1+
         fQKJh3LlIooTTJl82mzn7ZJZ5B9UzXFgQlLdkUpNFiDbfdXxY/N0cxNulZFI5RQbW3cu
         vbXw==
X-Forwarded-Encrypted: i=1; AJvYcCX3bbiQnl/8TFUQ3dr32SL2ZFZDzQ9ihC19iYe5qcXOyypcCRDcpT4kokHaFj1gx3pPOXsctnJe20Z7wGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw3PQfOCm6YWx1+z9Tvs07tg2D20MkFFBteJkKwm4oQDklEN6s
	YRSJ0hDFRfe0oYbl4d6an6Dm0p8FXS0560Az6NDk7RI285o3eIcKtbkhyBkm2oy2z8r/9euycIf
	MpWFU0RjOwzSIhPypnBHjYDLOeAfG4X0n6jlEfVPPWXQHnKCj/E6OXB0eqD/ZRYmCKeY=
X-Gm-Gg: ASbGncsQTevWPjJwEEpojrFMHhcaP4d6f7uqTkbUDK/P0fiZ1JwE+P0/NH6a638mAG+
	sDbOKYfQmYSCPrDKzlIoAFpsDgAG0QoyYCtY+O+hhfj/JYojFA8z2wdSI5KaSruIqZrCNFe4vWI
	MJLBNCbZl/4eZ200tQX7CIeHWQN8C31Ju07r6LjdSE37pfcHr3o0ReIZDrclSSn9VctMT6f1iYt
	SIMxGJEvrl9ImluD+b0Ufq6kRb2x9J/94S6GAbG98ZjdRm7dNnG6hBydPaywlmQzULKAdC2U4WT
	2t0098AeZRNJc5H4V99xBbXs5O+bv7u7j2pP9uhxsER+KA3Jju31DHwrmTh0iqardcV3gJ7o5pK
	NzmA7hn6jPKPuM/lJ2rnUHsuDk7O/5A==
X-Received: by 2002:a17:902:e805:b0:283:c950:a76f with SMTP id d9443c01a7336-2962adb9aa9mr74228505ad.43.1762428478865;
        Thu, 06 Nov 2025 03:27:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU6rFo/pzsW3jk6QglGS+k+CL5s3XH40bNmasC4rf0DPFLcxK3UltT6ouJSMStoLO2JjN59g==
X-Received: by 2002:a17:902:e805:b0:283:c950:a76f with SMTP id d9443c01a7336-2962adb9aa9mr74228335ad.43.1762428478385;
        Thu, 06 Nov 2025 03:27:58 -0800 (PST)
Received: from [192.168.1.102] ([120.56.196.127])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c94ac5sm25577495ad.92.2025.11.06.03.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:27:58 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Thu, 06 Nov 2025 16:57:17 +0530
Subject: [PATCH v2 2/2] PCI: qcom: Treat PHY as optional for the new
 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-pci-binding-v2-2-bebe9345fc4b@oss.qualcomm.com>
References: <20251106-pci-binding-v2-0-bebe9345fc4b@oss.qualcomm.com>
In-Reply-To: <20251106-pci-binding-v2-0-bebe9345fc4b@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=mwR/yFYKcstYoJ10AjG3GZOJrZ5Qy9z5Uli1etRKCUk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpDIYqtyRKrCgw57SQE0Q7ZvvkNhPB2zmoyLBJU
 PM5nitBN6SJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQyGKgAKCRBVnxHm/pHO
 9Uk3CACilUFAbi7xgGu0iPY8Cv+66AWSh0Fk1LWByEyCtwKQ0XM0Nf1qe1PIoPSkXCflCoi7Hvp
 CcRGyoOJ4Z2WUOO6N0znJ+AkNJqktzjmR39uUeKS6WWXKF154Ucqqtq7YlEhHlZwB9qipOlKTrX
 qw8jYU040Xj3Oo+glCBzR1LJbHEx//I5Wi50UMBNUfn/q1bQP6lL/sRIrRnIQ3Z1hr2xMG29drm
 oAZJs2x3M1oS9TznIEyR/Bs2/aERl+KSNLjmO5OEBZE5MDHRXaL64nSYuoW+PH5mVSllmL3TI5x
 xl6vamKq2nZjw4F/qBsOeH3hV/aUU8SUthYYDPHAsafaj4uL
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Authority-Analysis: v=2.4 cv=R5UO2NRX c=1 sm=1 tr=0 ts=690c863f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=NqeMpCPRvvPHbudmJ2rC7w==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Pq7zNYhhCH6MgF7pbKMA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: i8tdphVWDhzXm6Kn13Z3IY-m4r0ACl14
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA5MCBTYWx0ZWRfX7qcdFmUzIPp8
 p4d3WZZNUN1jn5HKvUmE5uhnPgMfd+PipIJQsnjoSo1uA2z8VMovE2aU6iWT2AvZFvy8xtRcW18
 UpwTqgH7SXzS5IEqh3XKvM/4AozeGWVg66noV3NTbcJNvdKpOaGYZSpvqxt9h4Jw83hNUELjsAh
 pwqNfu5uTFsXNTrPSMYNCMZwmG55Gk/xPS3KAQA0kRhyWTx6VdO1XySxSws9z9GhH+6fDFJl+NK
 LY96xoEtS9q/aphNNkkDmmSx9V5b00QMIVqPLWaiu0+wkJZ/BAPFrNAK0urIR/42i7shxf3zAKx
 bG+Lo+/KD5GtbEIkjHNYWkCSmH47z4cr6ZzOGVyA/85JVvXQZA1XTBE5LI6L3ld9jpkl23f4Y40
 j10yGuD2HigRDf/ivZz6tHgY1krEbA==
X-Proofpoint-GUID: i8tdphVWDhzXm6Kn13Z3IY-m4r0ACl14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060090

Some platforms like the old ARM32 IPQ/APQ platforms do not supply the
'phys' property in devicetree. Hence, treat the PHY as optional in
qcom_pcie_parse_port(), so that they can work with the new binding model
of specifying PERST# in Root Port node.

Fixes: a2fbecdbbb9d ("PCI: qcom: Add support for parsing the new Root Port binding")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 805edbbfe7eba496bc99ca82051dee43d240f359..53b41dc98f11ab953f7f4f31da642abf8b6faf83 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1723,7 +1723,7 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 
-	phy = devm_of_phy_get(dev, node, NULL);
+	phy = devm_of_phy_optional_get(dev, node, NULL);
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 

-- 
2.48.1


