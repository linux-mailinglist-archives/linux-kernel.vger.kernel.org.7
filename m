Return-Path: <linux-kernel+bounces-826041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4A7B8D650
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C7717F7F8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828832D73B3;
	Sun, 21 Sep 2025 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FteWC7FS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AE52D63ED
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758438710; cv=none; b=c/u3oNFO/H+zIbqU13vgTnfFQxAw88ufpL5BDDWMwXw4ZTZJ9YUlS+77gvvKXkyEV9M+Av2F2CFOJfxQvpg6ZnUvsl73XV+q6YBOgEaRLraPt2z91XM+IQpYpgHFcGIgS945GpABrfB7/2VLhjAH7dHIKPkpNVbICTB5y+1GTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758438710; c=relaxed/simple;
	bh=qCEQM2DB6f88IU0QnUh9B721GoRdDOJ5sQGEUrhnDMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJP4MTHInjU+GrlDr0LBg/1ncBXb+mt5YraIV1wdH37pA50jGOfX9AakrY0l6at5RXuLrDZyxS+ZhsV7s2/LHAaM+iiUgFJlP8hQ9gxE26LQ6y+uPyPcp0We9X8GbwlTjZYTRv4i/U4i6/ZCY4PeLFVp2N4WOqCPAXLQKTSNEnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FteWC7FS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L4jSgB011453
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6ZI3/sTOd53UxwGm0A52HiBP54BTXnRIEQmLXh5SLBY=; b=FteWC7FS67Uh2fzd
	4P7u6hi35ptCV57iVQJqI9MWb4CovprlS37vw0xOvdk83Z2b3HDAuK3ljvt+o5RY
	0sNM1UJAzA6h7NxDg5E++HncLd0iCw93qEwbbVcKhxhD/dSubbNN+JkwqDerPpWl
	B7gIAwLKYKJ9fGqkvZo/vhdFtacsRFpzuomI2pUXuVPsD+XWGGZm3f4K9yU0brAK
	VZ3ytxLuHnjEuFx8uu1zrwSA6+FCooRpBlawxgllWND0UKcdqjUFVnhc6nIQVkzZ
	VoooWAKJNC2PiejwJD+m+k4X2+BHyUIZYykW85YH75OKfe85Cm2HtaCpQOCkzB04
	epSAsQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mg31t59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5d58d226cso74042701cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 00:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758438705; x=1759043505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZI3/sTOd53UxwGm0A52HiBP54BTXnRIEQmLXh5SLBY=;
        b=BF2hXDMYGOUpQ0umh2bJSN2SkNhpcM2x0qOospEO5TGPSsYJQL4voktpI4OOAZuoV6
         FqwYfEqqn/ypIyyjjgF7g5dm1pnFT3QJYTVReJGW7LDTpgsKIbaf8+HqNgaZHdOna8JQ
         69AMzre8imcaqU4LsLu0Q9lvnEJiJe5iyueAKtk/JgG2fALMzDsUXk7Ij5SB7N9KuS4a
         NZYHe5H2gLu0ulflY26tAXaxFlijEnZKwtdjDvfQ3adCw9/IlJJCchjrgpXjokzij5PM
         d6m7VQVEz5DRpq7RbR+Bla2vwMyVLfuhmGFatuB9FfDccO99pkOPFEprOkDOOnRrxA6T
         OpkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN68vSrYE6JjSVQbtAOLz9fDo9mMe+wz+y2SpxuEHmpDKXBbJG7m1OEV+gpHFWT/Qb13/9a+vlyVcr2Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxns+HDlVmw7sQJ/+YHzcfcO8b2YFGm5Gxd+/GTHjPIzOnrVj7B
	uPSRj7+5XNSITRraOrNU7e07k3S5SXwLMEi6fW34sotdLvrNzlXxgsl2qA0AQNtTYKgsmBdarn4
	rkEGU9fHLHolHyVRRaupBL1VQ1hFg1cLCBCyHidJ1lNziJp2gMcowVbuOY0vKdomQjrVIVSkwJr
	k=
X-Gm-Gg: ASbGnct7MyZ1mCWMq2akhjxyMxY6hAJ3NhwkxV3ITVN2HY5pu3hyUWVtPievxVh95mu
	7AxfF99pjgHKY6tzFpGH3u5Kq+BjW4q69fpJsWd8BoAX+XFMjalmUhiH+6nAU2J1yc68475DS4s
	U+uD4fCY8r8QBaQu5LU0K0venDMtCrWtMQnPN5YUKHx0XrR2ZNdBk82rEDyfg5FX46QAfFDp/SJ
	8WdT/nBlesOnR8y0vDz8XFtqYUPMJoZz9ZIjN9X89uM9AYtfR495UusiFYbPoWgAjuVYt3vD1Nx
	JfQ3SZD2W31gHUd0dWiOaofJkP1+bFfvgJ9fhDco3mEG6l40kxo94VurYuR33gEoog8wwcLQ+rR
	qXpbPBfqSMrlNn7fxls3DbBn+FlGp0YfQxvIBlrsiSJQJjdQJ4E9k
X-Received: by 2002:a05:622a:5e18:b0:4b7:95f2:ddf with SMTP id d75a77b69052e-4c229dbc347mr47103501cf.45.1758438704714;
        Sun, 21 Sep 2025 00:11:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8igKf7oPEZN6ecPgg1/seoDl0exTVNvJeCVzqaNoTDKnyzm4uNnLY4vc+NsVP3OVYIVBGyw==
X-Received: by 2002:a05:622a:5e18:b0:4b7:95f2:ddf with SMTP id d75a77b69052e-4c229dbc347mr47103341cf.45.1758438704280;
        Sun, 21 Sep 2025 00:11:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57e06875c2csm144031e87.4.2025.09.21.00.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 00:11:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 10:09:23 +0300
Subject: [PATCH 07/14] arm64: dts: qcom: sdm670: add refgen regulator and
 use it for DSI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-refgen-v1-7-9d93e64133ea@oss.qualcomm.com>
References: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
In-Reply-To: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=qCEQM2DB6f88IU0QnUh9B721GoRdDOJ5sQGEUrhnDMA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoz6UhNq1ZeCcT2DxmV9U+SRXxrfryFhuhPp/Uv
 Z2uVouXhBGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaM+lIQAKCRCLPIo+Aiko
 1VsvB/4vCprWpiGSewAa+7hJuIhqBJDTEYP5gFk3jzJRzLpQra1O3jivB9iWQ7UBa9SHHD4QzLR
 hC0rSkgR49HD7CXJ+4c92+xjEu4q4V+bIxaoP0Hoc8gq7II6QzhPgPtbCcXll4sg54hyHdoTgi+
 tLfZz+Laxuugux8mjDoj8WrJUAs5xR/mTDaBWE9n65FBN97oesTCH2wlPuJ2KMY2Z/kWnn+p2Lg
 TQ4kxhTnpm3HVTlw+SxWYqVBeGRotAcqe8WibpsvFDiRFRVde0iYM2G3oMl3MMHVaenF2W5vXLM
 DAiDxEczfsmL+R/oXuCpLM9hQe3o5zQInAnpKrPUBlOhAYeG
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMiBTYWx0ZWRfXwA4ZKxQI3+fN
 IAvPErGqIBDGph/1MUcEwG7Prl4cC9oWo4ZwyGB5d1ScsIMNSeEfXtdMhpUh398tOxWedx2Vnj2
 PoJbuoqdqZENJVWIqgbyhELmpjm1lrGUMmgKvzh7AQhgQ0w9J9yrkZvyW1upOhEjiBPz+ozJyRY
 YAcLWILRHVhI+6PoU9ApTgdoNaV+DDx+82ZOosuUElmgooYqu9kcCWJUuolu0pr+hD+yoKe8TzR
 ewatWqIG/YB71seSsTn6Ip5Ywq9mHbigA5ODEyPeyBDyZ35vQgntKkmIegvN1oCf1TMtJHW3S8C
 S7Nkr0pymVOGJuzmPp3Ap+8tX8EBclbr9dMR82dHAdZQ+9ACZwN+9HtEwdIb3ittCGzHzZNakHB
 wBN/Dn48
X-Proofpoint-GUID: B1HTWvdrVakW1u_VpIzotBZ1bXuPxvnq
X-Authority-Analysis: v=2.4 cv=UvtjN/wB c=1 sm=1 tr=0 ts=68cfa532 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JxVd-jRfK3spBIq9QYkA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: B1HTWvdrVakW1u_VpIzotBZ1bXuPxvnq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200032

Add the refgen regulator block and use it for the DSI controllers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index c33f3de779f6ef457a3336fa4fbe39175c378cce..c3264a31bccf25fca9eae7fa7734ff43c9db410a 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -1124,6 +1124,12 @@ i2c15: i2c@a9c000 {
 			};
 		};
 
+		refgen: regulator@ff1000 {
+			compatible = "qcom,sdm670-refgen-regulator",
+				     "qcom,sdm845-refgen-regulator";
+			reg = <0x0 0x00ff1000 0x0 0x60>;
+		};
+
 		mem_noc: interconnect@1380000 {
 			compatible = "qcom,sdm670-mem-noc";
 			reg = <0 0x01380000 0 0x27200>;
@@ -1926,6 +1932,8 @@ mdss_dsi0: dsi@ae94000 {
 
 				phys = <&mdss_dsi0_phy>;
 
+				refgen-supply = <&refgen>;
+
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -2000,6 +2008,8 @@ mdss_dsi1: dsi@ae96000 {
 
 				phys = <&mdss_dsi1_phy>;
 
+				refgen-supply = <&refgen>;
+
 				#address-cells = <1>;
 				#size-cells = <0>;
 

-- 
2.47.3


