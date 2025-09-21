Return-Path: <linux-kernel+bounces-826038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC4DB8D629
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507F32A0850
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF15E2D5416;
	Sun, 21 Sep 2025 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ap6LPfdv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D062D3ED9
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758438705; cv=none; b=jTGX60do5feft/azsz7tYi559PLYMJhDjf47FW58F9oEvx5fc9JCLlIfdFiPlSzwBb6MjGea0VjKIhvdSAZEYU9wh9Wpl9JqJoQpv2y3PO59p2D4sQ4OYVdyJqcZ171aXB44KenBz7MPiZE4jyQ6WFEMK5W7m/4DpIbIu1jKsCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758438705; c=relaxed/simple;
	bh=lsvPVAhvWIt6qgcJJNGeAaF8fmCuLwTbNR9/ddUeXCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOxFoWyS2UD3Jl5cyJ9HulIEa8I2iCuh7a+bpEiIB4+kSfjNUXT5pERCVEFobC0KaDmUpWs+zdVckwgsRzNNE29a2MwCnswE9WJvExybGGqE68jHADSOePZpaVSOUAc73ZEOSF55YOlgERE3UeQb60hzo94iX87Bwj6A8VOgQpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ap6LPfdv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L5wx1B005492
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XIRYBzVD4zAzZs4Sd96qz7o8F0QfQKuflAC2lSliaeA=; b=ap6LPfdv91sdpLIB
	LASfxR8bORmOia7yTKXWAyJyhsvpNfZYdRzHGPY8FbscCCU+fZLURAadtxP0oATg
	DWLOtfIu5CRMV9qIBo1e9KQ96rQTaWTcaGhf4M28COztlQMolxTa7oM52WAZhRAC
	ycdaYcv+W3b/LSuiKRNoHLRps414QoVczRD17GOCOUh9rPRlE7yVlbXWan9CcNof
	rXo/96XJiRKdtNj3i1q4ENG8szmnZ3piYfA8b9oqf1TneHpyFZASxtghqJRnqN5Z
	S43sZ2muwgrHz8FG8l8Bh/KLEMM7BZy+ynN21jb5kSUEZRkKhUZEfcpZN2J6Y94s
	fF5nVA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyej2f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5d58d226cso74042101cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 00:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758438702; x=1759043502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIRYBzVD4zAzZs4Sd96qz7o8F0QfQKuflAC2lSliaeA=;
        b=e0ILHzvPI+hB4/Fgt1W0VPV9tgyZezxNgOMm/UfYILfvNQy59IpK9nqRMdd3vp00IJ
         b9bTEIBJK9Ci3lQ7ThBR8RwjmmTNeAt6W72FGyt8Z13whT3LtFHXC0mv6uHg5X+GYMI0
         DSJNC6VYzJ9iaCi3qViwv7oSHlMG9eCpK0y9mnsoRz3gSyU5fxl0hCYIQYhLHo5Vf/i6
         bUCTgAdU9+YFnT0kKvFMu7TEFUAyU5n9mEfhbMv/39qDixK2R/LEoRwR7p77fTxjvoGX
         sgYVWEOKFFAdcH4p1qr/zyN8Tcq+crWjLWEZxJIjM2EVnw6EkmY1iiIsz9f0TJ0oNLV2
         xgNg==
X-Forwarded-Encrypted: i=1; AJvYcCXf6c037UB1A4KEsvhE4TPGS2LcG5+AOuxrnZVfg6Vvj9aC9zqyNT1wx/rOuLsyjn8I1Np4RZ9MRSmRiD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE7MfHdK/yRsCN0AgBRXi0542L1Ol8N1WC4AU1PzhK+GVsLpJQ
	YEJdB58ktNANA7EofzEHUUA+/3GjxAlua22zwnNRk3eNO2WVMAX7PXkkFa1Yt0AOgs7SCOkkRSF
	kdQKxTnSIcVtB7e6u7hgs5PPVVdo0TIg6a8r0krF7g05Z5ehTFpEs1PHCKOMIeee78sU=
X-Gm-Gg: ASbGncsiQ2rY5pLbiqtauqye5FnxyvnTKY4InO7V4pih+qpNPhyjJiIzdqcxq/poT01
	w7c9CE/c4wAkDQ2x11oFpZM0cORErttQUtJ18hGfbo/IBZvkowAHaFVKJKTpPoYg1y2vrIMCSMD
	uSHo8uokg21SkDfXtng2ifK2N2eNOU74To2LMJJxGDnjqhMgnQU1pcPFkRwfML3jaj49zMR2Qxv
	593olyJUA0lP0llukGB3u8hHEnIVW/Dt5kpdecbUd8Xi4t3c1ZPNLr1VfXfq7y0xNfR7bTfZCqC
	uMgICPV9smTn/e93NUUnvsHHkMVCrx400YwN8hDHqH1PiCTS/Kl5e9DsPRL/T1ynJ2C31TRQggU
	sC6IfZ5xP9GBgVqmW9gDr9avGOd91khoU3smit9CDFKlCcc+y2b6I
X-Received: by 2002:a05:622a:4891:b0:4bc:d9dc:7ab5 with SMTP id d75a77b69052e-4c06fc180e0mr86818951cf.14.1758438701724;
        Sun, 21 Sep 2025 00:11:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJOLD5EhBNmxNOaUpZUMaaH3ujKQNgRNp2sNdSJD7I+wRNyWeeKZmhg8M+NbTr52RvqNc/9Q==
X-Received: by 2002:a05:622a:4891:b0:4bc:d9dc:7ab5 with SMTP id d75a77b69052e-4c06fc180e0mr86818731cf.14.1758438701350;
        Sun, 21 Sep 2025 00:11:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57e06875c2csm144031e87.4.2025.09.21.00.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 00:11:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 10:09:21 +0300
Subject: [PATCH 05/14] arm64: dts: qcom: sc7280: add refgen regulator and
 use it for DSI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-refgen-v1-5-9d93e64133ea@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=lsvPVAhvWIt6qgcJJNGeAaF8fmCuLwTbNR9/ddUeXCI=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ8b5pYoadunMh9RsXQNu5bcrXhPRkmFqSSr+VNDt9Ouww
 A+f/vmdjMYsDIxcDLJiiiw+BS1TYzYlh33YMbUeZhArE8gUBi5OAZiIlA37f69zDocDdHe1vP/3
 5+uhoMgfIgkbItlvHVpj8mXvO1/VvBku4l7Lo/vnv8556+edNfnOfiFx7t+STqYZR5KsueVmVJh
 fE3LJ8Xnl05SxSXZLy2qZEg+F1qvZZ7Nd/vc2sJT7PliUoP/+/wS1evN1j44Gsk9K1G5jrrdScV
 OV5btvGxOptX7iNCNdO5F5DPf/ro8L097pYNL9RtrjbFnQ+ezExGOGz8L2PkmdlHRgB+vGwMwvM
 27cLgr1Zr0ocqHfz83p8Dau0+tmaryVv9S/NYrnS3NzpuyZZWyuzXfTj+bOd1Lo1Io9Y8809cGm
 xWKqIbMfPq54InQ5p36J6iavd3JrLJg37b7DHpO2RrwYAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: eKUJEvZrVgpI2hGfTS0F6fkSbeO5utac
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68cfa52f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=y7dFmsyBxbbY7zPF4KsA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX14/F+VMuln5+
 HhM2KHeS6t2gCOtm5M9RLI4q6PMzsJo4VqGaBdCuXcxvgCk2XL8IaxjH+dJw2hYccjfohdmFf8W
 XNthy/DIfaf8b3TWO3WFje5teJZ4sdca+iiWH5ptLxosn4jwwx6c9rmWRn98XocaHYndCUQnhvw
 7r+qH3RnB1GWzO4Jks4AHmNVGyTvfS+nCKwvvpyU+F2dSW7beZGVZ4Rp/qU7wDqJoUMAXfuMYS6
 OZa6CXtYGbBo05amdgfTw27EGjCIDaOAxT8+c0MiVNDE+T0QBMEnq3uWO8+x+m2DyPBnmFTIYAb
 4QN0jdwycaIk5MSnmzyBdfhB2LHNCnHVkUSn8h6uGx+fJcnpINB9hanFva3CJHLm/QnSmtfCW2z
 +Pj8WOGJ
X-Proofpoint-ORIG-GUID: eKUJEvZrVgpI2hGfTS0F6fkSbeO5utac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

Add the refgen regulator block and use it for the DSI controller.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 4b04dea57ec8cc652e37f1d93c410404adaadd5d..834596fc3fc0a7f9a7e60ac412d39d09c16d6550 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3885,6 +3885,12 @@ usb_2_hsphy: phy@88e4000 {
 			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
 		};
 
+		refgen: regulator@88e7000 {
+			compatible = "qcom,sc7280-refgen-regulator",
+				     "qcom,sm8250-refgen-regulator";
+			reg = <0x0 0x088e7000 0x0 0x84>;
+		};
+
 		usb_1_qmpphy: phy@88e8000 {
 			compatible = "qcom,sc7280-qmp-usb3-dp-phy";
 			reg = <0 0x088e8000 0 0x3000>;
@@ -5074,6 +5080,8 @@ mdss_dsi: dsi@ae94000 {
 
 				phys = <&mdss_dsi_phy>;
 
+				refgen-supply = <&refgen>;
+
 				#address-cells = <1>;
 				#size-cells = <0>;
 

-- 
2.47.3


