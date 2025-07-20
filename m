Return-Path: <linux-kernel+bounces-738082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF60B0B415
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BE217D24B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 07:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E801DC9BB;
	Sun, 20 Jul 2025 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FVPP6r+E"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCBA1B4242
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752996112; cv=none; b=mPdSFxYGLp51Osbt2v/I/kjc0YvanzNMZKlkvVh2kQWSnd8lPh7aiaYXlvJ1qruoHyRm9VHLqbbKYXV1WUrcW7xI22/TatUceOESd6jSd9cK4qDV9YVAJow7uVNPxojcwc0ydLWYgd++47qwylYE7wgDeNw4wfVB6XF9xQNkfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752996112; c=relaxed/simple;
	bh=q5dFyPSKzoOAh+WaNwTAwU0DgLXb0FDwbrfGiHFnX0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uTpqwyZFL9O9asEPCw48NzLXP0M9zlQPYJqlxRDIcaL+B6XDluPxPOnuAZcyKy9rXVNvPA6uCt9lxP6asSqLZIbB+x8og0lBf5zsvZsAmUB2I/ifOzGyqcezV8+ZUO7ZBXRWWe9I/vmycI01JpXZYyM2G19GbR/TQBh9GKCoEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FVPP6r+E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56K5rgKm010296
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=S0qMC8iWPilpYL7kcDpX+g1J31I4WsZ38+6
	cMf0mIt0=; b=FVPP6r+EdIKk/7OHuD1RWi6NzyDkfwsrqYEPA8OMQeXFoQv5TwL
	M18rPNk8ZiyIahYzilqmB9gWjU/FNOmsb6wsfmqgi2yIKB5dHILjwbNS1YvNGn8b
	Pzh8/4DNaK9plEedVMLZyHjxLS+o/Qz/B0NncS1MZc4sn9hC3ZaOlb2542yHhwwc
	q8bUNCmhkQC+0BOu5zfRy9KWN4OHU09y4uTwCoeXJfRkR55RM/6wmRwtt60Pb6t5
	mrTqw3QByAnPXWRhM+sfyLEmccAKopEYxAMndY9uWiiEpfR1dbiu3etGyspyv2oP
	7fsA53EkSfeLsdjqsWmoj657xfreXXfc6tA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480459huev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:21:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3beafa8d60so4170022a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752996109; x=1753600909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0qMC8iWPilpYL7kcDpX+g1J31I4WsZ38+6cMf0mIt0=;
        b=KDBC8yRH+esfZ9FEi3Wdn1IVl4NTPXJeahoSNuGoq7mK6zGhnYqixDb+Gf3m0FnNwl
         FiMMH4Om17b8ZJwBRE8iguzUgS+V9zoHFs2GThowPk7NazdPmRxaPOvGv2mE3cbOGWV0
         tVMG3GeBQjIb8oxyvdwHkRLDvBVRkkus+sCm6IL79rCapiVcoXX85YlF3K7KBFz+tg3s
         sG8EPgnAkATvNRmad9X9BTFfxqVPRX7iC8sakRUcSxjgVeUO8OCh6uV3vIIdzL4RxnXV
         ejZO5ViUZAtJnd6Pjy5RIIZojvZ74YDJZt3shuTcJzlMIfi6OA+V1QmojwaSrAqabamR
         lP8w==
X-Forwarded-Encrypted: i=1; AJvYcCXIJPOz+dF0aX2yswrNkfLCwloDIwQItmbjB67JhXHl3Mf8itUpMpxn4rX8hd4ZTpnQUVSjZ6tY9KAuvvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3oL5idVdsXTD81rvXqknLJ2q+Zlx+YY7hPtwu+VzYNq1k9cG/
	oZtnE8rW3b8qjKfG1eUd/cZqpbLIjIWZ6SU9Q578tzISeciGFcXNZkH9Yf+R7mFvVN1sNclrWCy
	du02ctTpMT+j2oIuvT5wkab4x7rgeXjdrHwI/jNtuwPELSdbYvZiBiYfF/qv9XeaQXg4=
X-Gm-Gg: ASbGncu4jt2EoX2cYXZuK04MpZEsNizZrHyy78JOVq5jVpg4n3KOkz00EfMi58MxJGr
	gcW5YTO0wAx7j6C1cNKz1ZRuHB+oBwLmL7tyqpE4hIb/D2P6P/Sz6AYw0bOZ4Fxe6NygEoXuvHH
	cYpXQ7fvrZgmC+P8vD/UaihLfR1wty7i3xdlCybL9jK494nrx7h5OhnAhbZyY6XQbXCOWW4Iok1
	RkaNXhjqH8mTtnpkp/CUO4eBU0zBM45q2GrOIkjtUKhINjnEKy9z9VXPnQMsu4C4QfXbc+ON3MK
	kqR3VJ9aLkieIs9hzqmcSN8Mp2a7bNkNqKxoweq/lBY+gHo0Uhg4J7tqYULeMHkewtrQ22J+wyM
	h2A==
X-Received: by 2002:a05:6a21:6005:b0:201:b65:81ab with SMTP id adf61e73a8af0-23812947ed1mr27155916637.23.1752996109228;
        Sun, 20 Jul 2025 00:21:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVrw5F+lDh+D6GQbLzCucJeKgpkFGNHFBY9wenkPd6GC2O/TewO4YnOZqFOKVaFKIP2y3mUw==
X-Received: by 2002:a05:6a21:6005:b0:201:b65:81ab with SMTP id adf61e73a8af0-23812947ed1mr27155895637.23.1752996108750;
        Sun, 20 Jul 2025 00:21:48 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe8cae9sm3425243a12.18.2025.07.20.00.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 00:21:48 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [RFC PATCH] arm64: dts: qcom: sc7280: Flatten primary usb controller node
Date: Sun, 20 Jul 2025 12:51:25 +0530
Message-Id: <20250720072125.1514823-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5xxUYiyhTRAl7BdazrubWwVcbdSCakoR
X-Authority-Analysis: v=2.4 cv=fdyty1QF c=1 sm=1 tr=0 ts=687c990e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=F1BopdVJQ9INZIdvojUA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 5xxUYiyhTRAl7BdazrubWwVcbdSCakoR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDA2OSBTYWx0ZWRfX2y/gx28Rxc+b
 C/ZT9WNBBMPvFaqNqVP7abydsNWqiVK6pME+lu8tC4+BH7ULgbhQmcRtALIbmWr2EIngblyl0zA
 Wd7Js0HWy3UU3JZF42xvfvvK/8Ze8PvVsbA32e+oROqcP3Ufs5WyXuvrCmVTihu6wJ/IeHj7fNd
 86ht00V0fkbI9wYtIDnPabdCPxUZumR9eMKPO/WTkCRTZcsxKzQQQiid5/mTYRzUn4mwUKbw70W
 wUg5CoX1IqA99LlIXwlB4fxmCd2G1cmBHawjSTH0WVyVDCGDPj3KMPdwIiUQKwmFkqAhVeRLgfQ
 sHOW8wsTCzgTlZkTDYQ1M1jYEq+JpW4mM0hX/V1PaNk+vptswvH3DtVYJlYcuzhWBvnIdvTKpp+
 LWkSy5m+2CcESm3/GUwuA+YqjxZcWmeglPwqPJhF82l6wIFqUkMamO+b5ZtLdnyPbdIxRSOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200069

Flatten primary usb controller node and update to using latest
bindings and flattened driver approach.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
DTBS check has been done on all platforms. This patch has only been
compile tested since I dont have access to many of the platforms.
If folks from community can help test on any platforms, it would be
helpful. Thanks in advance.

 .../boot/dts/qcom/qcm6490-fairphone-fp5.dts   |  6 +-
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts      |  7 +--
 .../boot/dts/qcom/qcm6490-shift-otter.dts     |  6 +-
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |  6 +-
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  6 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts       |  6 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  6 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 59 ++++++++-----------
 .../boot/dts/qcom/sm7325-nothing-spacewar.dts |  6 +-
 9 files changed, 42 insertions(+), 66 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index e115b6a52b29..f17ac3dc9b06 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -1364,12 +1364,10 @@ &ufs_mem_phy {
 };
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	dr_mode = "otg";
 	usb-role-switch;
+
+	status = "okay";
 };
 
 &usb_1_dwc3_hs {
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 7a155ef6492e..8ed6e28b0c29 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -751,12 +751,9 @@ &ufs_mem_phy {
 };
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
-	/delete-property/ usb-role-switch;
 	dr_mode = "peripheral";
+
+	status = "okay";
 };
 
 &usb_1_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index b9a0f7ac4d9c..eb8efba1b9dd 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -910,12 +910,10 @@ &ufs_mem_phy {
 };
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	dr_mode = "otg";
 	usb-role-switch;
+
+	status = "okay";
 };
 
 &usb_1_dwc3_hs {
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 5fbcd48f2e2d..01f0b460305c 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -1127,12 +1127,10 @@ bluetooth: bluetooth {
 };
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	dr_mode = "otg";
 	usb-role-switch;
+
+	status = "okay";
 };
 
 &usb_1_dwc3_hs {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 2ba4ea60cb14..5c5e4f1dd221 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -621,15 +621,13 @@ CROS_STD_MAIN_KEYMAP
 };
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	dr_mode = "host";
 
 	#address-cells = <1>;
 	#size-cells = <0>;
 
+	status = "okay";
+
 	/* 2.x hub on port 1 */
 	usb_hub_2_x: hub@1 {
 		compatible = "usbbda,5411";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index b5fe7356be48..3103f94cd685 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -81,11 +81,9 @@ channel@403 {
 };
 
 &usb_2 {
-	status = "okay";
-};
-
-&usb_2_dwc3 {
 	dr_mode = "otg";
+
+	status = "okay";
 };
 
 &usb_2_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 90e5b9ab5b84..ccd39a1baeda 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -520,11 +520,9 @@ &ufs_mem_phy {
 };
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	dr_mode = "host";
+
+	status = "okay";
 };
 
 &usb_1_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index b1cc3bc1aec8..e94e21301bdd 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4245,13 +4245,9 @@ compute-cb@14 {
 		};
 
 		usb_1: usb@a6f8800 {
-			compatible = "qcom,sc7280-dwc3", "qcom,dwc3";
-			reg = <0 0x0a6f8800 0 0x400>;
+			compatible = "qcom,sc7280-dwc3", "qcom,snps-dwc3";
+			reg = <0 0x0a6f8800 0 0xfc100>;
 			status = "disabled";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-			dma-ranges;
 
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
 				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
@@ -4268,12 +4264,14 @@ usb_1: usb@a6f8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					      <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "pwr_event",
+			interrupt-names = "dwc_usb3",
+					  "pwr_event",
 					  "hs_phy_irq",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq",
@@ -4290,37 +4288,32 @@ usb_1: usb@a6f8800 {
 
 			wakeup-source;
 
-			usb_1_dwc3: usb@a600000 {
-				compatible = "snps,dwc3";
-				reg = <0 0x0a600000 0 0xe000>;
-				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
-				iommus = <&apps_smmu 0xe0 0x0>;
-				snps,dis_u2_susphy_quirk;
-				snps,dis_enblslpm_quirk;
-				snps,parkmode-disable-ss-quirk;
-				snps,dis-u1-entry-quirk;
-				snps,dis-u2-entry-quirk;
-				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
-				phy-names = "usb2-phy", "usb3-phy";
-				maximum-speed = "super-speed";
+			iommus = <&apps_smmu 0xe0 0x0>;
+			snps,dis_u2_susphy_quirk;
+			snps,dis_enblslpm_quirk;
+			snps,parkmode-disable-ss-quirk;
+			snps,dis-u1-entry-quirk;
+			snps,dis-u2-entry-quirk;
+			phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
+			phy-names = "usb2-phy", "usb3-phy";
+			maximum-speed = "super-speed";
 
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
 
-					port@0 {
-						reg = <0>;
+				port@0 {
+					reg = <0>;
 
-						usb_1_dwc3_hs: endpoint {
-						};
+					usb_1_dwc3_hs: endpoint {
 					};
+				};
 
-					port@1 {
-						reg = <1>;
+				port@1 {
+					reg = <1>;
 
-						usb_1_dwc3_ss: endpoint {
-							remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
-						};
+					usb_1_dwc3_ss: endpoint {
+						remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
 					};
 				};
 			};
diff --git a/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts b/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
index befbb40228b5..f16b47b6a74c 100644
--- a/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
+++ b/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
@@ -1425,16 +1425,14 @@ &ufs_mem_phy {
 &usb_1 {
 	/* USB 2.0 only */
 	qcom,select-utmi-as-pipe-clk;
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	dr_mode = "otg";
 	usb-role-switch;
 	maximum-speed = "high-speed";
 	/* Remove USB3 phy */
 	phys = <&usb_1_hsphy>;
 	phy-names = "usb2-phy";
+
+	status = "okay";
 };
 
 &usb_1_dwc3_hs {
-- 
2.34.1


