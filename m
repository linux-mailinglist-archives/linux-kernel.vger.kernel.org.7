Return-Path: <linux-kernel+bounces-873150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 174A9C133B5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B9844E86EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249E0221DAE;
	Tue, 28 Oct 2025 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mzP4qywS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E0517BA6
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761635079; cv=none; b=mq5HFtEOrgrY4V5IhacaHU0/vQYzjrxXbE729E8jyPHILHXdjpoZNcPbpiFQrkJu9dClFoYWDHxzvlhyq4CN6B0Oa7Cx2tuXwKYlCLduBYeR9wDmPrDx5sledtwD2GfK3LdyE+gGcoLqfO3KzkkPK8Mtr6bnpfY9g9E08iaUz04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761635079; c=relaxed/simple;
	bh=AYT3RVzsICMpupLHCjCVqyv7YtWQ3D8cjixobbkFe+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NJCh8decx/fkPUP9RlyxSEK/8GuH77PCrhs2jp/T19dN/TEMhPNMH6YjA0R2rzSAw3MdYWSAGpEzNrZ8YzRQ+dRRodBvVwOjWXyBwDGua9SYeWQPS29F6DnFqL7j6nvFyINWkXQDEdZE+Be/bIUAmIblW4ugrGGbQoPhDfBTcTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mzP4qywS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RM2TBe2753176
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FmwXGY0VP8BuzjMKMv6qvB
	O3JftdefFSQp4wgibsrNI=; b=mzP4qywSj/KO186n/qZHRJquB3qVzJy/vWtzJW
	0HFpfmdBzNUKp9ulGxRmv8sfgxV+F+cK/AeyXB4y0tY15Fp/QPVfNJJTyPFEfmSy
	aMAlh8XH50Cad7QN4xyjvdb1aJOkkGTAKB32cVEuvX5fuwgXm4N1GDS7zeHSlKYu
	45mpIV3UCtr6TKm1dCOdZIqKjxTOR6Q3niVk7fubziZ6Y6kNa4g29U7UThnc6mzE
	H2/GpTN4eTnedDtHOz0KgCJnsfAHXPxu5XxOlBiGYIZHbsqVpUb0qafqk3rIctyR
	N8k4+xXRxIL3O/OcDbY19SszC+47rbmw8tj/PLrurehq1Mvg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a28nsu0d3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:04:37 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77f610f7325so4229262b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761635076; x=1762239876;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmwXGY0VP8BuzjMKMv6qvBO3JftdefFSQp4wgibsrNI=;
        b=lYZD1HYXwLbapyBaaodM81ysMD08fu3ZfwU72OLFMTrA5MEOfNFhl4MUyONXxVUh/5
         Drmr8l5C/GYI6B9BGQabFIxPzzQyhXV0+F5PofwOu0QyRFjmZnFL80pJEnk7umSu8vNM
         nh8t1SiOhXLe2cfzlkh4H91sTtITpeWJHO/64VU9E0Dd8oH1j8/nJjEBWZUPXMjigGmm
         znT+KS813qIcP7rskR6i47viGEDs+6kBzpSUe20oKjD5IwWpVNscskx5lqyI+u9FTjLX
         kLJvTKtQAl51799pMPtCd0fdtPRVsWOFSfTnm4ffGbns+iFnDTLSh8c4knE/bcbS3BnT
         A3BA==
X-Forwarded-Encrypted: i=1; AJvYcCU5QqRNHVtI/RE98AJq241psrTwoOkHz9Lj0iG8QxSQb8BMz6sY9MPhUjLBgFVI7r5lmEEXYghq56J6Fh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGoKgUHyHdurxqq1JeL4P/mlH6+/j2HW0UBfhwPu6CJ99XEy+A
	aG56pVDNoHPL+uWX/1naGNnD69mrj9ud5z+5JLBBojF7s9bEPRCOhuYCxe7A59QSSmy2n73pFQJ
	r61CpaxrvP4UNMEUajPmLFSW8nfgsKfTHh68h5fAtBwULApNFKzAljtiTwGzrhtt7aNo=
X-Gm-Gg: ASbGncsh1G1TjX0BdCuUfLAWE4cOygkLRxBAn3zvSAFbi6//lY2MSTWzG/G8tta6BfO
	+HL73vG4SFxmjhTRYoi0NGveCpyTr192+5f5fdugimSKrGRLkyjGze+Hzs2Dj1dQoktCwtWyjXq
	TEn/tB+x/7cUy047CWKAFrgPfPEv8WrFuEXrj/JahwOyPi1JxwkqSJPClkPAum5kFt3OGI3crrh
	m3xj/VDXsm/EYOSVZ68aBqrNdSrkMP83Z9DR7EQamjtVVjVbl8bUeoilKXvW4vg+OscQPpuT8LS
	uANwwqGm86KP52I5jtPG9JuB36ZCtT3eokr03tJ18/AoCgLtlX9xhzPkkWFpJADgq7jRm91xouc
	0VtDeLqJkFLbe7JUpczxSyNgE6EPszJxgQ72+saGSWa+pD0Vy7ziEFIfzV9meXhrjOelASxg=
X-Received: by 2002:a05:6a00:2b44:b0:7a2:6caa:38b6 with SMTP id d2e1a72fcca58-7a441c5feeemr2192870b3a.29.1761635076535;
        Tue, 28 Oct 2025 00:04:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv9hWQskoOsPqVsxZXg35dKJmU8ygeh5oH20cYyBIOZftSEP3su6q91llCCVtocmFxd0LfKg==
X-Received: by 2002:a05:6a00:2b44:b0:7a2:6caa:38b6 with SMTP id d2e1a72fcca58-7a441c5feeemr2192845b3a.29.1761635076082;
        Tue, 28 Oct 2025 00:04:36 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414065418sm10662426b3a.41.2025.10.28.00.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 00:04:35 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 15:04:26 +0800
Subject: [PATCH] arm64: dts: qcom: Add backlight support for eDP panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-hamoa_dvt_backlight-v1-1-97ecb8d0ad01@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPlqAGkC/yXM4QqDIBSG4VsJf0+wU6Z1KyPCjseSrdrUxSC69
 8n6+XzwvQeLFDxF1hUHC7T76Lc1o7wVDGezTsS9zWYgQJYCNJ/NspnB7mkYDT6efpoTr1QlQY8
 KSRHLz1cg57//6r2/HOj9yfF0jWw0kThuy+JTVzhlodKaiBDqtmkc1laiq8Aq0Tghy9pBa1Cy/
 jx/iCzMobEAAAA=
X-Change-ID: 20251028-hamoa_dvt_backlight-373528b7ce7e
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761635073; l=2798;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=AYT3RVzsICMpupLHCjCVqyv7YtWQ3D8cjixobbkFe+4=;
 b=MeacmXm4s2Vc6Tv/AqoCu1wPSkQUq+YAckqk0Y8QOTdRpiSa6cCzG6uqyC8z0iK68h42Q2fhb
 s7tosjseM7GDR+jFL0bhE+J9Gp2Qy9FqgJB2h82xNNe/QikJ4T0lN32
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA1OSBTYWx0ZWRfX+XdqOT2pJnNd
 pAEzLlQUnOgSXF6Wei9Kcph30+QpydUFBvgDBeWZRB6KJ/WfYUd2Hgp0JN/ZfSXmrGyqUfvz7y6
 dgZTel4ukYzXpe7zJRjQ6z0j3TZmlPBrDRJkbYVRZVcTzQzg/KgnlICzU6qeZgRR/LUeNI4aa8A
 RCpqIvsFC7AZ4LagvjUjHtgprKGguzZJuLYfknkiXDzBpgQ95Tm4omyU0M0ox44Z3wkyZUBBZ1p
 TqElSdot3/be63g5RgXHPNYWZ8S2ZCPyA/iCo29kHgL66XtHOpCqi0AK4IKVmxQwmLzLAAYKnIG
 C6UEZL8EFZ6BJ8uyp0BbOOWNz0a7M+wGGqHawA6ujWmVR7eH6gxuga3nFwKaWuH1l0RQ45PtSAx
 xSi1aZsY1LawmqH2wHrT3pakOPnTLg==
X-Authority-Analysis: v=2.4 cv=RIW+3oi+ c=1 sm=1 tr=0 ts=69006b05 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=I4knr0C1cHqesIZZmIQA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: Af_O_gZed7P8uxcLJffFRQAkZdeU_gPa
X-Proofpoint-GUID: Af_O_gZed7P8uxcLJffFRQAkZdeU_gPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280059

Previously, the eDP panel backlight was enabled via UEFI. Added backlight
control node in kernel DTS due to some meta may not enable the backlight.

Aligned with other x1e80100-based platforms: the PWM signal is controlled
by PMK8550, and the backlight enable signal is handled by PMC8380.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 55 ++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index 36dd6599402b4650b7f8ad2c0cd22212116a25fe..fda1b3a3c7673be74832c27849231cba4bc1f25f 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -17,6 +17,16 @@ aliases {
 		serial1 = &uart14;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pmk8550_pwm 0 5000000>;
+		enable-gpios = <&pmc8380_3_gpios 4 GPIO_ACTIVE_HIGH>;
+		power-supply = <&vreg_edp_bl>;
+
+		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
+		pinctrl-names = "default";
+	};
+
 	wcd938x: audio-codec {
 		compatible = "qcom,wcd9385-codec";
 
@@ -183,6 +193,22 @@ vreg_edp_3p3: regulator-edp-3p3 {
 		regulator-boot-on;
 	};
 
+	vreg_edp_bl: regulator-edp-bl {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VBL9";
+		regulator-min-microvolt = <3600000>;
+		regulator-max-microvolt = <3600000>;
+
+		gpio = <&pmc8380_3_gpios 10 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_bl_reg_en>;
+
+		regulator-boot-on;
+	};
+
 	vreg_nvme: regulator-nvme {
 		compatible = "regulator-fixed";
 
@@ -819,6 +845,8 @@ &mdss_dp3 {
 	aux-bus {
 		panel {
 			compatible = "edp-panel";
+
+			backlight = <&backlight>;
 			power-supply = <&vreg_edp_3p3>;
 
 			port {
@@ -879,6 +907,22 @@ usb0_1p8_reg_en: usb0-1p8-reg-en-state {
 	};
 };
 
+&pmc8380_3_gpios {
+	edp_bl_en: edp-bl-en-state {
+		pins = "gpio4";
+		function = "normal";
+		power-source = <1>;
+		input-disable;
+		output-enable;
+	};
+
+	edp_bl_reg_en: edp-bl-reg-en-state {
+		pins = "gpio10";
+		function = "normal";
+	};
+
+};
+
 &pmc8380_5_gpios {
 	usb0_pwr_1p15_reg_en: usb0-pwr-1p15-reg-en-state {
 		pins = "gpio8";
@@ -890,6 +934,17 @@ usb0_pwr_1p15_reg_en: usb0-pwr-1p15-reg-en-state {
 	};
 };
 
+&pmk8550_gpios {
+	edp_bl_pwm: edp-bl-pwm-state {
+		pins = "gpio5";
+		function = "func3";
+	};
+};
+
+&pmk8550_pwm {
+	status = "okay";
+};
+
 &smb2360_0 {
 	status = "okay";
 };

---
base-commit: f7d2388eeec24966fc4d5cf32d706f0514f29ac5
change-id: 20251028-hamoa_dvt_backlight-373528b7ce7e

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>


