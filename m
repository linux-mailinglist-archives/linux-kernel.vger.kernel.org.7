Return-Path: <linux-kernel+bounces-777948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D31B2DF66
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF365E0191
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6258C272E6E;
	Wed, 20 Aug 2025 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ce4PT4Cx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F323E273D6D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700128; cv=none; b=cAtexA64Twfn7kcTTDIN1mg7H0JyJlb3uN4ZpfPbvNeurajFbqtUZvMEkSc+ebWCP5hCX30Ac0WuaKibyFvptfDvqkqDrIR9w9VO2rnt0TNIFOHH3f8mi/U4XAtjJ/EFRXxgZXIIktBn47EZ3mO7cmBpuXAxrhKxWrgzSXUXuEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700128; c=relaxed/simple;
	bh=neZ49KyTVZEtGa1LBEivdDxTGFlLG2vQYfbGidEXrKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qk0F76mWW7nLmki+6kzX6F9SDuTqeOifNvpEa2Zc99xapTqZibGQqwuMfq2LtuJOU5CY0SuDpgVU/TabMaGTwKm0mjWEXepmU/4/YJ6TQl4ME7w1ULbSrYMM9QqsEG5cxrFRLDvuDuvUDaqNfc2gmPGCTnrKiZXCrC8NTF+TNuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ce4PT4Cx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KAQffi028549
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sPyP5LFvODeWiNRqv7MyVr
	8luCj0S9G/q4eynThmEkc=; b=Ce4PT4Cx2GuCNFZiAB3J96wj4oP7R1bingf/wl
	wNlxiVroMfdewBX9TwQ8aFA9DZvroLPws7Syw7KgAaTmpnDXn+mYnz02+1RJhwJF
	OSHebsffe/dCNUhnaDS94REGFNQQzbO8+2B4R5VHcEHbfgpoUdlnyHN/0RmcKJJC
	pIFYm9cvqLUVK0ITVTLIZw7iCc2K4i4OzbOXjaVgA+DNk44J8KjRKzFKe6bXhWjW
	UKz3eI95Zcu0ryLLU6Dswfu73rRNDm9K//4ZDJ2EmfilMF1/5PgMqj4QO1QpwyHS
	YYQZPOWEvvaB1CdM/Tvqgkglto7oJ1f3y2Cn6+U3JnLXuOew==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52asxqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:28:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-244581ce13aso132764315ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755700124; x=1756304924;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPyP5LFvODeWiNRqv7MyVr8luCj0S9G/q4eynThmEkc=;
        b=wiHWQv5vUnRJpqAlYIyUwYRPvJ/2J4DqL0dza3KgwKow89Z13uBIOliPPyzJGhEMjh
         Odac38OfSwse+4ToMXtgI67/hCLPfxcnYKraD8/CjNG8WbiftWXdTw8LPAniteIFY4kA
         C88VM3qcMgQALFHrC8IySm91IfdiA8dIfZLMA+SJSzpbEwdtB+/zuoBlkC8edpqOp5um
         SE5azsfeQ08SxYTRfma1S5iiVV+NjdpqqdLgqLRx8vo57JDe1M5LEG+mPSFAxfgB8xdX
         ash/ukSHdVEIauvOrz91ZzdPX/Iv9vzSs1s2ovMbXtaYwOzFL9NmYadyn5QIXXRbt9TM
         YRWw==
X-Forwarded-Encrypted: i=1; AJvYcCUxxEqTmjD07O0J2n9ye6FPVbzXx41NGui5r3BAq8sWi4VB4EBo/1TQXCEoEtAa6xdIwYAwgOOte8vf5J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuHsGzVlv8fz4rQ69EkS4bR2xN/4cFWuD6zeGQnyC6J7/hOpOU
	FePkUR3ehy0zvCir5lrBt2h/9gePSZ5tl2TzOyTrnRoufIbnIuCKV/ISiEYxhrSUEl1rLAPP9In
	ETQ+m8Yix1h9sWWvM6Zdlx71fBu+g4vC5gYuvOt3ObolOC082qz2/4XKpqq1HotdpmEpPzXdGHt
	aHDQ==
X-Gm-Gg: ASbGnctcUTwRG0JVJBk6EYLY+WdmQ4LvqpKVjcmRgPWHFN0Xq/msZpW/dnxLDNVPxMl
	yF87N4Ol7mvBvrxEp/MFieWpXSO2G8vXq/DETET9Za6Empfi+y9viHEdt56afSlGyAPXxypFJtM
	2fQYsAAs5hAm6g/Ry5G5pcMyJ+sQ419JWoDqd8Yg1u7YN/I2O2ywsAF+DGIbPrHKL1szbfIjLpq
	wU48cmDqyCxZYKPfC8EZPbsHfjjLIa8nYx/IUCXli/fcsGBD059AUzKZS4QP5SAPhN5MMbVCJPF
	pNDRONGoAP0SGZVpKahT4Fw/QfC5HKzFz4Pb6gJYquvQFY8b+er+PHt6E8gVd6LIKtnqJRyrmJx
	U
X-Received: by 2002:a17:903:41ca:b0:242:8a7:6a6c with SMTP id d9443c01a7336-245ef150ae5mr48360875ad.17.1755700124113;
        Wed, 20 Aug 2025 07:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcKKwNxAixqEvxQMv3bygAQ2ikirzD0wkL7Np597naqBY/v6S8MzZ47RtfUCn28knGEKgkxg==
X-Received: by 2002:a17:903:41ca:b0:242:8a7:6a6c with SMTP id d9443c01a7336-245ef150ae5mr48360085ad.17.1755700123520;
        Wed, 20 Aug 2025 07:28:43 -0700 (PDT)
Received: from hu-vvalluru-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed519787sm28551305ad.143.2025.08.20.07.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 07:28:43 -0700 (PDT)
From: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 19:58:35 +0530
Subject: [PATCH v2] arm64: dts: qcom: lemans-evk: Enable Display Port
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-enable-iq9-dp-v2-1-973c9ca22474@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJLbpWgC/3WOywrCMBBFf6XM2kimaZvElf8hLvKYaED7SGpRp
 P9urGs3A+fCPXPfkClFynCo3pBoiTkOfYF6V4G7mv5CLPrCUPO65RKRUW/sraSTZn5kxnunnUT
 dOg2lMyYK8bn5TucfJ5oeRTv/QrAmE3PD/R7nQ4XGtNxroUip4IxHgXXTSeu5ttRwIW2gToUAX
 9c15nlIr23qgpvsz6oFGbLOC4WEvG2kOA4576eHuX0f78uB87quH4k3/X/9AAAA
X-Change-ID: 20250711-enable-iq9-dp-addc9c7195c9
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shashank Maurya <quic_ssmaurya@quicinc.com>,
        Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755700120; l=3004;
 i=venkata.valluru@oss.qualcomm.com; s=20250711; h=from:subject:message-id;
 bh=9yBiuRq/b37ygaYnKeX77bHnFkhApr+QDXwALNrB5Sw=;
 b=1bsu50TNA9TZbqwrGV6oUL1bym9pGMHIkLOj5tFGh0xK9kmRJaWhzeW0/0C6/9Bp1Z6MPKhBq
 kV+EFapaR7fDSjHrGGjjUgGD2MmNMqfNukkSdTZKRDOfzhaPYBmnvPW
X-Developer-Key: i=venkata.valluru@oss.qualcomm.com; a=ed25519;
 pk=f/CAPG1ZGl5SP8S1GuC97WMhUEV87h0JheHkNMt1nhM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX8dKlVfoP7lWc
 q7FpcBzwNfI+vVezgTLWUpyOPx5imR8CfwpybSryDHLIy8mqPd1cpc+HXxYXtCxY0OmXyTvvV3n
 H+Fbz75qa0+G1y4DQLJ4VviGLukON94K+Py5OEKExn1cIDUuDkEiag6w6IrNi3EVsebs7vEsFf4
 ASalHsM1vx2lCxzJ1hwO86w9Py1JM3HUGm724QQ1VCNCd15Snez+cM69SHxsjjBJQuJLWceWRA1
 0C0GaOOSxty8hYyh/1w49enbvdDxGkNGuP8bOS1BoH+k8hvlXUh9x64aZ556k2t6ed5ln6Bb4x2
 zMlFW27/JgqY3Cj1P6zE7ft/WEW/ImiYL04zsitoo41dRTiyl4E/S6FizqtrNyPMIBa6kMl/Zlp
 76lqoM0uQIXloWMH88dWaWvaFGKE8w==
X-Authority-Analysis: v=2.4 cv=TIIci1la c=1 sm=1 tr=0 ts=68a5db9d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=ZQucwW7hKNWrINUWBWsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 3OIbllqr5MhBxfpwY1uH1A51MOgb_a28
X-Proofpoint-GUID: 3OIbllqr5MhBxfpwY1uH1A51MOgb_a28
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

From: Shashank Maurya <quic_ssmaurya@quicinc.com>

Lemans EVK board has two mini-DP connectors, connected to EDP0
and EDP1 phys. Other EDP phys are available on expansion
connectors for the mezzanine boards.
Enable EDP0 and EDP1 along with their corresponding PHYs.

Signed-off-by: Shashank Maurya <quic_ssmaurya@quicinc.com>
Signed-off-by: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
---
Changes in v2:
- added dp-connector nodes for edp0 and edp1.
- Link to v1: https://lore.kernel.org/r/20250711-enable-iq9-dp-v1-1-6d381e105473@oss.qualcomm.com
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 84 +++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 669ac52f4cf6aece72141416068268531fd9f79a..40becda317ef2546e16ecd44476f76a4cde98be4 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -22,6 +22,30 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	edp0-connector {
+		compatible = "dp-connector";
+		label = "EDP0";
+		type = "mini";
+
+		port {
+			edp0_connector_in: endpoint {
+				remote-endpoint = <&mdss0_dp0_out>;
+			};
+		};
+	};
+
+	edp1-connector {
+		compatible = "dp-connector";
+		label = "EDP1";
+		type = "mini";
+
+		port {
+			edp1_connector_in: endpoint {
+				remote-endpoint = <&mdss0_dp1_out>;
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -253,6 +277,52 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&mdss0 {
+	status = "okay";
+};
+
+&mdss0_dp0 {
+	pinctrl-0 = <&dp0_hot_plug_det>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&mdss0_dp0_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+
+	remote-endpoint = <&edp0_connector_in>;
+};
+
+&mdss0_dp0_phy {
+	vdda-phy-supply = <&vreg_l1c>;
+	vdda-pll-supply = <&vreg_l4a>;
+
+	status = "okay";
+};
+
+&mdss0_dp1 {
+	pinctrl-0 = <&dp1_hot_plug_det>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&mdss0_dp1_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+
+	remote-endpoint = <&edp1_connector_in>;
+};
+
+&mdss0_dp1_phy {
+	vdda-phy-supply = <&vreg_l1c>;
+	vdda-pll-supply = <&vreg_l4a>;
+
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
@@ -261,6 +331,20 @@ &sleep_clk {
 	clock-frequency = <32768>;
 };
 
+&tlmm {
+	dp0_hot_plug_det: dp0-hot-plug-det-state {
+		pins = "gpio101";
+		function = "edp0_hot";
+		bias-disable;
+	};
+
+	dp1_hot_plug_det: dp1-hot-plug-det-state {
+		pins = "gpio102";
+		function = "edp1_hot";
+		bias-disable;
+	};
+};
+
 &uart10 {
 	compatible = "qcom,geni-debug-uart";
 	pinctrl-0 = <&qup_uart10_default>;

---
base-commit: 1aa50d938e88fcad1312467bd09be4037bfe68ff
change-id: 20250711-enable-iq9-dp-addc9c7195c9

Best regards,
-- 
Prahlad Valluru <venkata.valluru@oss.qualcomm.com>


