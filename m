Return-Path: <linux-kernel+bounces-896485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A3DC50800
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A0B3B2861
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5783E2D3731;
	Wed, 12 Nov 2025 04:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jy29sIOS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jwomfKGZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914C262FF6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921297; cv=none; b=VHyMSoJwFrfo7SC3dgXAdE9JH2pAgJL0rEgN95kJPLiddIMcP7W6EnXltm1jhMbQaEW3OQHIu5e/5QKkfXcmbq0IRkfZGnH1o2AmEFHtLWCmjiYz+1cZIkjhzdAQ+9ztIxl9gijruDn67zx49i180pTDJRL88ZxDRl9/nXRQ3Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921297; c=relaxed/simple;
	bh=ZxNm//b5hfNxwUZg8+VCBHFtlDwMpgGW0LDC0HCi4SU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DyW+VnV8mRCBbMyAiyv7YCgxjw6MZ+CEb8DHfa7rKgzKmp3tY5y9weJrnXIdMfbHX1XzWCsR6eedFsg3dx4naLn3iCEyLTiu6m7Uc5QPqk+xXlgziuloxfFRyb0zhhupV7m25kNKIBW6QiD1JJgG6Xhd7XdXtuAeHBpUIwCt2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jy29sIOS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jwomfKGZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC3oSJE2809786
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hAl2A02JXsl7owYX9eMxdo
	JVFo0PhLT84hEevmOwh2o=; b=Jy29sIOSPU5XbeiNbyLvWY5tXWWK0jVf5TmFW6
	CuCYrKcp7QPt4AVVCNZCT+ebbQINlObUZcBhjHpIgTzWIx7WROZLQuCrNfRvkGxL
	AFVe/BSENODiJLYl6zP0G3Uq9xW/Dw2YQMacqtfBGunTRVKf6cLnzGOTgENqgm1n
	y6ytkEXbvXDHI5mXRGiCQReN5ehPgVjKXpx7MewHVBchUFNPjiXM0hltFnD993Yw
	W0sF1TQBcoG2fk1iFMkzY5syuH1kcjLyhj5yyUGYA0zsw8B/fdLTWVfNK9WWmAYD
	0hhqgzoQZ4T4sYh3pTey9gRpYGEBCLTsXG3ZWN0Rp/fBNozg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac11x36m3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:21:34 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88041f9e686so11544666d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762921294; x=1763526094; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hAl2A02JXsl7owYX9eMxdoJVFo0PhLT84hEevmOwh2o=;
        b=jwomfKGZMVFbpqBgfYCTC412v5JAUuqcRYUeTuCWulkcHH177I31N0TrhDnT/cTDQT
         texAxhfCqqE198QAkm0uPU4DOdxnH+Osb42bEc3New/56irLwSDlb6KBxo88rOdtXxbn
         X2JiCAfmv3tVunyTT4Yyq8c3OMOdO7EmN5WGxBKgJbySpoVQZP9Y3EuSV+WljO57kRGW
         9IUimQJ/8mqlBikMe0TLbGd1e1h2K+b9FSkQo16jNCKqvPrdMRWs6uVWYGVXzbDnT1j1
         HX76wSZBhNSmVgcon4BPmTSskrY+lt1is4eL5nlV4YE9v0fl9YqknoYoaCNd/Tz6yMlb
         r3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921294; x=1763526094;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAl2A02JXsl7owYX9eMxdoJVFo0PhLT84hEevmOwh2o=;
        b=cABolil37nkLYxy0T2qVSJbjBnEpAG9dNzIRFGEI23y9gOJcV9Js6J28eqgKFA8vIk
         FDVSjyWvFHfJ98t9Y7e/X1pQtf8ZGb0r7Ig/8xRWoQRKTEFpH3FW1A7oJap3CVScECAI
         ggu0WauHa+FwcIMuvtblz37Wnsq9lX9HytXXw6JX5RXlX/v3yaHtF8Ok1IbSa0AvuDIe
         0hpmCMN20m+tv2jZ1OiRoIPydW67fSCWrkAsyikkKkhv2hD4IlB3XrPY/P6/0V/BHI0j
         TJGrI4N4Vqtqs5Yk5YoUg6AuTJduvnITovAjTd9eJ2KDAPg5KCUco035hEoPBhoYRwW3
         vjPw==
X-Forwarded-Encrypted: i=1; AJvYcCUYab5LEQozKiquGawGNfhN9Tmdl5RZaY4PRQcGLJfWrfiGea2vPV0y0gKYSLuDJ30kX0nj7PUFQmIIG3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7hKb+T8E1wGIj89WzPS1rtJjyRnftf+I+udBr//rrIBgFn6WD
	W+BlSQGbC2O00XbKdv56dVpzan+4UlMMzU8c0U6s73FN+90aM1G8nsEpqJ9AalOZqqZUChhrf60
	rSYF+igcPiJOkcz9fOM1sglrHRzt4wDGLgR0evwphFyNcTUfOkVQuiKsLmzWuxFuudmQ=
X-Gm-Gg: ASbGnct2nSTy5QU9rLbUO95qQUN7aVspY7A/eKAl9NXWjFzJSzcXxYrOnk/tBq0KFTm
	g/I/Clh2x9/0q9tV8ar8kFU+oSxCjxSmw9E9RgkV9zyYDAqnkvJDyKFGKf6Zp1HLn2f1YX3+U72
	XQjjC5dmPduqHR5rVu6vIz8j3RhmA7PmuuDrRRju/B+hchr+IGtMZD0+R1IjiLrBpZYoFCligd4
	9xufJ/llPoS6ldxiGMBMWSZylmktw71uGckktM5zh0B3pUw5QUaKaP5D9hkm4BwJuNgrOheEdm2
	08hlZSPfVqe7vDERnguOaUlYJYEeLlyMENFNFWiWjpvRrAvia5nTsBxfjTaVv4OYBUAzCx/vo2Y
	nhM2w0744VKpam0E4/dutOoXD
X-Received: by 2002:a05:622a:588:b0:4eb:a27b:b47c with SMTP id d75a77b69052e-4eddbe205b5mr18183281cf.80.1762921293864;
        Tue, 11 Nov 2025 20:21:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH26bwsOC7wIHsrxJbi7gvaTFcyEyyDYi5MHqIhiXbod9dK5IpjomhG3t9KgDSoBmfYg9Bs+g==
X-Received: by 2002:a05:622a:588:b0:4eb:a27b:b47c with SMTP id d75a77b69052e-4eddbe205b5mr18183141cf.80.1762921293416;
        Tue, 11 Nov 2025 20:21:33 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8823892bb91sm86467746d6.2.2025.11.11.20.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:21:32 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 12:21:23 +0800
Subject: [PATCH v3] arm64: dts: qcom: hamoa-iot-evk: Add backlight support
 for eDP panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-hamoa_dvt_backlight-v3-1-f35b44af7fc4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEILFGkC/33OzW7DIAwH8FeJOI+Kz0B62ntMVUXANGhNaYGiT
 lXefSQ97FLtYulv2T/7iTKkABntuydKUEMO8dIC/+iQnczlBDi4lhEjTFLCNJ7MHM3R1XIcjf0
 +h9NUMFdcMj0qCwpQ27wm8OGxqV+HV05wuze8vJpoNBmwjfMcyr7zyjGuNQBYJoa+91Y4aT1nT
 pHeE0mFZ4OxEq3WFHKJ6Wd7uNIN+/e3SjHFgwI7akeMI/Qz5ry73c15Pb9rZWMr+6Mo6d9TbKW
 8FsJqr9vYG2pZll9Qb6MBVAEAAA==
X-Change-ID: 20251028-hamoa_dvt_backlight-373528b7ce7e
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762921289; l=3258;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=ZxNm//b5hfNxwUZg8+VCBHFtlDwMpgGW0LDC0HCi4SU=;
 b=r9LJv8PzKGDjymGv1ky6QzeqN1P2shueL/+ADxLL7Cb+C+OnUqx8f0mQFKxvN55djGYYAft4g
 /OH9/bqBSDFAA2q+MjZYJjh5uLl0acFU2V+a1YUyayzX8W+o3ss4gsM
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDAzMSBTYWx0ZWRfX/gdD5qZ+Yk2/
 Lo392LWfTdYpypb3vwaNKFip0lhF5q0Ir5KA3girNwnovOV1S6kmkpi5PXuBvbP7d8tbU7EPlcw
 s29YIzoWh1LNO/+H6RWtbUVoelPf8Gp7S0H8nAw/UTspFmNyzt4/F3LoMrJlY22nJh7Bbhw3Khq
 xqCvK4SzfaEU37O/aSBy2MNd77Q1qDZxvB30Zyd3Xny1SlXJNzvfQTGw4g6Km8F/vsieFxbSC8A
 EPDLIEfDrLJTzZrrM14kkqZ9/1u3gVtsZvhgoesJ31LCCIMBRRCAsnEdOsqneJKzXJVEZPEirO6
 NUs7EK8GVD3ayQ4VVuyki2jZziMNFP6v17875wtVlIIBc4WCGAqT+2RtmO+zqVmmPo53mEt5Qhf
 xHzLc3dDdBuq85ALRTE/0b9fVatbgA==
X-Proofpoint-ORIG-GUID: p6p6DvgCqFDLPK-Ytn0dzzewPW9eo2yC
X-Authority-Analysis: v=2.4 cv=L94QguT8 c=1 sm=1 tr=0 ts=69140b4f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=-MRO8OXtnwBBe0WvxIgA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: p6p6DvgCqFDLPK-Ytn0dzzewPW9eo2yC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_01,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120031

The backlight on the Hamoa IoT EVK is controlled through a PWM signal.
Aligned with other x1e80100-based platforms: the PWM signal is controlled
by PMK8550, and the backlight enable signal is handled by PMC8380.

Describe the backlight device and connect it to the eDP panel to allow
for brightness control.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
Changes in v3:
- Optimize the description of the commit message. [Konrad]
- Drop empty line. [Abel]
- Link to v2: https://lore.kernel.org/r/20251106-hamoa_dvt_backlight-v2-1-9f844c8f8110@oss.qualcomm.com

Changes in v2:
- Add hamoa-iot-evk to the commit subject. [Konrad]
- Correct the property order in the vreg_edp_bl node. [Konrad]
- Link to v1: https://lore.kernel.org/r/20251028-hamoa_dvt_backlight-v1-1-97ecb8d0ad01@oss.qualcomm.com
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 54 ++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index 36dd6599402b..499db4d67583 100644
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
+		pinctrl-0 = <&edp_bl_reg_en>;
+		pinctrl-names = "default";
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
@@ -879,6 +907,21 @@ usb0_1p8_reg_en: usb0-1p8-reg-en-state {
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
+};
+
 &pmc8380_5_gpios {
 	usb0_pwr_1p15_reg_en: usb0-pwr-1p15-reg-en-state {
 		pins = "gpio8";
@@ -890,6 +933,17 @@ usb0_pwr_1p15_reg_en: usb0-pwr-1p15-reg-en-state {
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


