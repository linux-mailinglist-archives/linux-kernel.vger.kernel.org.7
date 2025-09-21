Return-Path: <linux-kernel+bounces-826042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5317B8D644
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E1D18A0471
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652552D837B;
	Sun, 21 Sep 2025 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aNylwbN7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93D22D6E7C
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758438712; cv=none; b=JwqmS3dNioG2IYiEI6ncYOE3ugUZs5ZQLuKUGQJwatQrJz5ZtTVGSQHTi3ABKqMW87EBNVNGlPStXvjEUi1yV41y4/hQmxrb9UCyE/DaeOMZZ3gZ4hqJJf2V91u6Wu2CSLUShoKZZhE3ls1ch6IYZL6LPtZg0TwoEop98N7IikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758438712; c=relaxed/simple;
	bh=VhYTzUolbufxaESghv8gZLpsgZz+FTDDDwev4YUsveU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cCe04YM7ufscThFfwUv6mtde41rLmCGqPrzD2QuMI3vskSSIA/Y0PtQgJ6dTpgojg9+kcYU56hvti6jEqPJ6264xyR4+mCQQ8LLeLwTAq25l456j0T7ujXHEMS4bEgdsuD4W2Mu6Vjv5aSch8OU3Jh3nTOv+QVvzfQVi2oXzj7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aNylwbN7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L6a16R028189
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mypQ42Drvrrn6IxGswDfWm115whUcdxGQ7XhaSL+ChY=; b=aNylwbN7J8ioBZ11
	ur29I1P8MvfngSFE6WlanoKH3g4b6a2ln19nNwj2M2IhuB9PowkxNBrcJZjEg9pn
	am7JPgIEvI4Zw6z3m9rYbEn0fX6UCDwK3dBU873XM/TXBfjADU86EyF7dRtapgCh
	eIU+jrKBFh+2KXEKiFjL36vZq1/H/QrwXNWFOo2BQ3P57z+S9coPMKEMaC+fgjU/
	h4Y87l5iUCppW1zbHz+fGfCPiB9cD9Cgq0DkbQqXgJNybON4dnsUHjx/KAs/DRxV
	E6CUQ76yXe5VTxVw3odCESa0aGWe6QprrEnx3xV/VjBUScOjUGF+4lzwfvNN7kgh
	ObP9Ng==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499nj8spyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5fbf0388eso44318891cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 00:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758438709; x=1759043509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mypQ42Drvrrn6IxGswDfWm115whUcdxGQ7XhaSL+ChY=;
        b=A/4qyCOV17nqDcERrF2P0+LcmhFjC7O/EXozHlqsxzuzUSxSVZDglaTLJYcN4g5Ff5
         RBehQkIbnGzBxvO+sIs8ZMq3aiVZ8vL7Udgf/NU9zBTBnaQlZypj5YCCsOZ2Z5WDXowl
         eYudgiv+ENVtgmoA5VNKmSSOORyA51fX2qIVi8w7+RiXyvMklw3WFKsmG/uGg0yR1DUH
         totNmQjq78SvQwu7faVI8koesw/O/NKtD+/+U54zxtyb7mekjGN1or1bspTE5SbuLYHR
         jOK6EwefGlb/x5aED4Y5gfRUj5phu9DDgck+zOaITHGXy7Eizaz7Nyyl/xl9Bk+JL44u
         4oIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXStFWAbbghqyLTF7RDGLoiOwvfGnJX7Sc7ltVLPFCOE5uFvJGTWz7SWigzjvBnlfrVtTJJRoepVj8+OiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKIb/JCfskCrHCjSc+etZZ1zH/Z34QtJi65B2C1yA2N8FGtL8S
	gzBO+B33dQenUrDpbtaUeukGUVeCRT+6il+3DE+0i509BBdQWzb+Od4x3QH0XrqhwCYwCnwAYxX
	f4UxHPfitREX0KftDMVlK5h8keLtMPCTJDujRHDuyrpOL1gCY0AlcHeJkRzywIw/prZU=
X-Gm-Gg: ASbGncuv2S9mZI0+vW/Y1Mix/CtXGZ0toVLfr5YzhR4siQgW7Qu8dA1lqGacuQ9LFaO
	1a3f8LvqT2uP/wNUctJzkpCoIOkSSMFffgFsyI4hKUaebylYxmkYoKSnioUbZJ432cGFBqaK/Mv
	fuUZBYY8xYmRwgyWdFNCWs4amc4JgFfduxFe+Jl3GMdp060N8d4txcfoGj6xPmRuZooUScdcKU8
	1SHCtl9wusv8+im7sT+sVOQC6mN+bOxK2jpIzopbS6JPT2EWnDoICeB9ch9w31p6zLAfSw0g7gN
	D5RUqsM88JQCTd0pDUm219RpooGVVoyQ+wxe13TPe5zGe/bwErQ/Z6sh+zny3XjXh/5ZFBxVMBR
	ynXKeLbpIErrL/i12vOay7JXHSSRON8gFwXKRZJdK7/2hb1nh3JG4
X-Received: by 2002:a05:622a:4d91:b0:4b7:aa6b:222f with SMTP id d75a77b69052e-4c074b0a761mr107021841cf.75.1758438709061;
        Sun, 21 Sep 2025 00:11:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNR1J5Pc2zYhnImJLqEirstFrMP5PnaezKgVKx6fA4rYy15rPRo3GIcTIcJwGJSG9y9CUW6Q==
X-Received: by 2002:a05:622a:4d91:b0:4b7:aa6b:222f with SMTP id d75a77b69052e-4c074b0a761mr107021611cf.75.1758438708584;
        Sun, 21 Sep 2025 00:11:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57e06875c2csm144031e87.4.2025.09.21.00.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 00:11:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 10:09:26 +0300
Subject: [PATCH 10/14] arm64: dts: qcom: sm8150: add refgen regulator and
 use it for DSI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-refgen-v1-10-9d93e64133ea@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=VhYTzUolbufxaESghv8gZLpsgZz+FTDDDwev4YUsveU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoz6UiKYMiqw/uDGIPTMbKt+3T2R4H8usE6oqD2
 P3oyEs6cfSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaM+lIgAKCRCLPIo+Aiko
 1ee2B/0WkIHg/IJdqp2iyDLzmPkQpeq1+UiuDFBF7CFYor+P3PI0dHKferWbKWQNM9A7dT3/Pmi
 eBSpNH1dzMkqcg/bQUpZt4rzojfgZQhQDTSsOkJDCePd9YQEHoh0tqcnoFlSN+tvoHuTy2QkB/M
 9Sh+SsJ1pH41qwFsnPlY/+L0t4pFwM3ZLCt5bD7qQJpSFHN5ZMSN6OFpSQSmH7YjqzEsujB82WX
 LSeHc6BcH69WUxm2szwvyro66aSYOwGGpDJyXM+HbR5aX+Jkeucv3RjHaeJZjV3YU7Z6HTn0GOx
 55XYUcOnXsAooAHyTSm1B7IzqB7LTBxetQX7PE0FR/fDrYg+
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=dZ6A3WXe c=1 sm=1 tr=0 ts=68cfa536 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=XZOqtvWFhPgZnOB8h3YA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: S1Z1zm5DLtPLrIVF4Dr_nYkL-2aYYa5n
X-Proofpoint-GUID: S1Z1zm5DLtPLrIVF4Dr_nYkL-2aYYa5n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0MyBTYWx0ZWRfXxl2CsAEDHtLe
 4+gmIv/7liWesxUAWzeUkvNvs0r48E7tttz6UdKo/s+R2bOs/L2Y+osICNQEGN3zXYhWLViH9jc
 x62A4fQZMy3JlQO9VPSXWb/+yBZmAl2NTmOARgSfspVji2VHQoSLQSCZQnvp6D2KUoK91QJVeLC
 NrJYm0ae2zrEM056o6RRRUoC894sXat96kuTPqAZ1f2oadjoX7vN7wsKPgXvl51QdAvV7lliAom
 eRD0ipe4jvnNdVT0tRbIAJ93nB+gcJ+UMqwi4U2OHI3zn2kFAp+V2Y/ru27l5x9bdoGpPdA0VPt
 QYHBnIzP25WSVbjkUn2ipMhdZnNwVv0/DA1xbPPDAGR+TUDwXlmp/ZXEPPwfAGiyKB5O0BLfDwJ
 hnf+vVcc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200043

Add the refgen regulator block and use it for the DSI controller.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index acdba79612aa8f8ad714ffd93d84ac572afdd47a..1ea2beb9e2eaccf0e39dd2baea853d0152e48477 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3469,6 +3469,12 @@ usb_2_hsphy: phy@88e3000 {
 			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
 		};
 
+		refgen: regulator@88e7000 {
+			compatible = "qcom,sm8150-refgen-regulator",
+				     "qcom,sdm845-refgen-regulator";
+			reg = <0x0 0x088e7000 0x0 0x60>;
+		};
+
 		usb_1_qmpphy: phy@88e8000 {
 			compatible = "qcom,sm8150-qmp-usb3-dp-phy";
 			reg = <0 0x088e8000 0 0x3000>;
@@ -3992,6 +3998,8 @@ mdss_dsi0: dsi@ae94000 {
 
 				phys = <&mdss_dsi0_phy>;
 
+				refgen-supply = <&refgen>;
+
 				status = "disabled";
 
 				#address-cells = <1>;
@@ -4085,6 +4093,8 @@ mdss_dsi1: dsi@ae96000 {
 
 				phys = <&mdss_dsi1_phy>;
 
+				refgen-supply = <&refgen>;
+
 				status = "disabled";
 
 				#address-cells = <1>;

-- 
2.47.3


