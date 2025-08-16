Return-Path: <linux-kernel+bounces-772054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E671EB28E51
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB4A7B71A3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF3C2EAB8A;
	Sat, 16 Aug 2025 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Io4UyUmK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210BA927
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755352830; cv=none; b=DGFy6aH0Zy+eShqPBzk6hSWjhB33ADpKftkJFgeuk/vnxUE8hVNQY+SKKEarXs/cs2lxB9Ndpd1r8DWxh41AnZUqRHrPkU2rHMHlQac4Fky0zRdXwkOyoCwBtYECdObtEdE6bCHyYj2a5CyH7mNKbIo9EfScIPpRe3ZeQGaB8SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755352830; c=relaxed/simple;
	bh=RL/rsnR5aIAYzAjSVYLobpvMvzAmlX/T8F2y9bqHz0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MyvLAB5Uxvjw22Aj2RYJy8wg7B8Ck7MmXhialVvgJof60eSRWMUVdEXiTtZCO02Dv088apqDvvulf0Kj7/bSGEt06F/3taE9CKLAbPi+v6BJBHl1f1ttGloUxc3xJ+AWonHy3ykV0x8ebmPY8pQCtGZlEzd6au5EGck5OyrfR3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Io4UyUmK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G3BLCN031545
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 14:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xJ2Yikson/V3wcUfK1ILZb
	SYi+u4PVTMRzNVSCyCxj4=; b=Io4UyUmKyDxvuo6ZN5CndUNEqLLnd24pQEXyyf
	q/kGOdZLS2JNoQZgBpskgMcnDb1q88NVQOuZbij/Pk+/AOAnitIWfY8oL8Rn8XsI
	LN/7erOJ+sgxJAEmdW0is+h5krIuj4kd73+/R9E5vhsZUXW2RfqbtoHf9Wx+b12R
	p4CZdSV2QkUjiaQ6jpKB1JsPWn9maChaudQTp3zspaGtINIZJzsNKfbJtJvLHjIx
	HDeJKIxTBZhEhk9qgSoB0okCdi+6cnspH6CxD1IFnPY+23ROgDgFbEoMG1KrJOwR
	WT/hfY7KF/sGtZzVr0AESxLjPzR/UeyOPj2uT8pXRvrKaN6w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh070sxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 14:00:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a9f534976so89001506d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 07:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755352827; x=1755957627;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJ2Yikson/V3wcUfK1ILZbSYi+u4PVTMRzNVSCyCxj4=;
        b=vAvJzh4oGvmI+9Ooptgn8EArowduO8hZogESyK8xMIYA0HUfK6WeQdPzZxGNqlhFS7
         nUjikOBboWXbOqUOmoUA9GrMJzJFwz1hP0ClTbopbJmURpsQBD9vqD34SIGNX5VLfK4H
         EblOx7SK8/3xBxjQlSatHBhfrNVhcA5TTbQjOHs54Wd7wXxAJCJJ5dyGJz9FbiQGCWS5
         NZyE2jLYXRnQyQYlEVIPc3WDovnTqK3Z6t+D4p0B3y9lJxghfbsU+yapLRst2KUAPtvB
         3ZZGdhSnz2W8Qd1EaCNDC0ZZ63IFnvpziEqTcA3dDmYJ6wzrgNgqULPX61BjrIrrUUCS
         EyWg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9s9Dn9YvANBjt02zd27IIh1lGHb2Uqj954SxGgm3MhGKDO2TBzGn4qTfd5kJ1yt0/yB4jjiJVlMxQBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH0J3EWx3H8oRpdMEZ6E1fPCUeqW8S1V9lgEXNkwl05fm7MIVy
	axuBnkMUE+6p35YAhfRrLbPTWp53zDx96v5aHKUKIj6s3vjbh10mdUYSQQaPE0+JuKQGBS30roa
	C+/fou1iyJ4hk0GNWYGIHq4Z+wEoROUGZwC5IILB45VvZvFJ3POqKHQ1MxBerD0pNOZUE6xF8aJ
	s=
X-Gm-Gg: ASbGncuOcHQXdzFNyPcnvIqJXKj6sK8sGK85fC9ziEn5vsb3u2r33awcE1SwmqXNKSj
	xdlalPo1yaX/KVqGkkkYnt5aYPRpPa8s9tDVl/lgkfDsIARv6ZIF4tnzHg1qbIUSapMQ18h0cUv
	wLuRwnZvbw0PEEi5suTRphgLAysoUEubIY63l5antPplnnpOirKw2uRD67/s5d/ZKPoRuenk/Dq
	spdl82RHlCKoFOQRTSFPFrZWxtuvuLpLJyROYOLANwqx0fHGpjAt5rj/wNRaW4F7L9zgH1xQ+hy
	GoI99qlWPN6xNLh7K0ndKJr8fbWJgApj4ocnC/aLWufxkgfzeN+F1cC95riyh6aFFrul5svA4H9
	7iKnsVsljF5t9eUnC1SEzV4OPROE7aqx6Vmt8Lavo43E2ECmViJrJ
X-Received: by 2002:ad4:5ce5:0:b0:707:ba3:8ea6 with SMTP id 6a1803df08f44-70ba7c93456mr80869696d6.45.1755352826533;
        Sat, 16 Aug 2025 07:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaTZBQg0LFxjZYt2CqEDwIwfTvHiMmXKvuDNSkh6fcuts2sPG5rbySUWlozzzE87Db3D4mjA==
X-Received: by 2002:ad4:5ce5:0:b0:707:ba3:8ea6 with SMTP id 6a1803df08f44-70ba7c93456mr80868536d6.45.1755352825912;
        Sat, 16 Aug 2025 07:00:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f3932sm864486e87.109.2025.08.16.07.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 07:00:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 Aug 2025 17:00:20 +0300
Subject: [PATCH] arm64: dts: qcom: sm6150: move standard clocks to SoC dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-qcs615-move-clocks-v1-1-bc5665d6e1c3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPOOoGgC/x3MSwqAMAwA0atI1gZssVq9iriQNmrwU21ABPHuF
 pdvMfOAUGQSaLMHIl0sHPYElWfg5mGfCNkngy60Kayq8HRSKYNbuAjdGtwiSL7RjSlr6+0AKTw
 ijXz/065/3w/AghziZAAAAA==
X-Change-ID: 20250816-qcs615-move-clocks-ed9295478d8a
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2444;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=RL/rsnR5aIAYzAjSVYLobpvMvzAmlX/T8F2y9bqHz0w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBooI731WgJqUgqbGJzogVaqCrQsSurSAIwoD65R
 BVxaAsVqX+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKCO9wAKCRCLPIo+Aiko
 1WdPCACnF+iOZLiFrcYoT5es17uVFh/1hanxHkFrbgOaB328WPLvpdbBSi3XCLqy2hbOVqY2wwy
 kF90GXMVS0aC+L8iSdHtNSm++D3Zk/ciZe80Df9ebj0ZOJGewB2/ZJRgs405Qx1sR/oGgBJ2sfs
 4v5HmrIGW5hDHyvzDfdnPyZJn3H0YYCDB/1ytqTkRjQGPb5dU78fPwpBTVqoeyYRhtOuKetLXjA
 vbVTJeEjKw9M61n9AmR8EIX9b/K4JSXFOD9AvORIffy8Pr8hnExHxPcNV+O9/EaWZHpzvbMcjQ3
 yWalKL+HKpEte8Hc1BlBxkWYtx4TbMXh3vLLpjkGh85dePVe
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: gio8fKlDvNQtMIXkTe06Um5egiOsWDr1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX/JurDGOPeLUd
 rrkVNqKBGyHuaWcp+6/JPR/CGF24MIAjjl65sqMTPZWuCdDLTs1Jxaup70b2BPXVoAaE/PN1tLk
 7zPYlygQ6TxqRQqmFYMs9gYHriCxon00cmm7Q59I+cqFnLwP/6IJ0dkbLAS5/bTQkLd7CUFsR5Z
 izFNj0dUIPL7mCiY7h5AEOBJJVgnHaq7BKvKLPuCcMbQzQVy0EyIhVYpXLPXB8Fb0sy5Bihyh1p
 5Y4sAnotVrfJPSrr0p8gztGqdt+rcAvezkAJo08/Hv+/ehT3jhg1eMYmvjhQod7PwDqo5icig43
 UQyPEhYMpSIi7Hzh+r4JdTdQEfcT5zPenV7cX053+WHxB8dz+Mqqw46CvsBb2IpFNHOfrBLSghu
 wuMzGm/x
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a08efb cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=iyTG0-ia8al12V6RUoUA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: gio8fKlDvNQtMIXkTe06Um5egiOsWDr1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020

Follow the example of all other platforms and reference standard clocks
(XO, sleep) from the SoC DT even if they are defined in the board DT
file.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 14 --------------
 arch/arm64/boot/dts/qcom/sm6150.dtsi     |  5 +++++
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index 59582d3dc4c49828ef4a0d22a1cbaba715c7ce8c..e663343df75d59481786192cde647017a83c4191 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -288,12 +288,6 @@ vreg_l17a: ldo17 {
 	};
 };
 
-&gcc {
-	clocks = <&rpmhcc RPMH_CXO_CLK>,
-		 <&rpmhcc RPMH_CXO_CLK_A>,
-		 <&sleep_clk>;
-};
-
 &pcie {
 	perst-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;
@@ -369,10 +363,6 @@ &remoteproc_cdsp {
 	status = "okay";
 };
 
-&rpmhcc {
-	clocks = <&xo_board_clk>;
-};
-
 &tlmm {
 	bt_en_state: bt-en-state {
 		pins = "gpio85";
@@ -523,7 +513,3 @@ &ufs_mem_phy {
 
 	status = "okay";
 };
-
-&watchdog {
-	clocks = <&sleep_clk>;
-};
diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index b66bc13c0b5e337bf9a95b4da4af33b691c14fb5..69e013a17c9f9556f2cc504afefeb6b5f62e3325 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -495,6 +495,9 @@ soc: soc@0 {
 		gcc: clock-controller@100000 {
 			compatible = "qcom,qcs615-gcc";
 			reg = <0 0x00100000 0 0x1f0000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK_A>,
+				 <&sleep_clk>;
 
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -3676,6 +3679,7 @@ watchdog: watchdog@17c10000 {
 			compatible = "qcom,apss-wdt-qcs615", "qcom,kpss-wdt";
 			reg = <0x0 0x17c10000 0x0 0x1000>;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sleep_clk>;
 		};
 
 		timer@17c20000 {
@@ -3765,6 +3769,7 @@ apps_bcm_voter: bcm-voter {
 
 			rpmhcc: clock-controller {
 				compatible = "qcom,qcs615-rpmh-clk";
+				clocks = <&xo_board_clk>;
 				clock-names = "xo";
 
 				#clock-cells = <1>;

---
base-commit: 1357b2649c026b51353c84ddd32bc963e8999603
change-id: 20250816-qcs615-move-clocks-ed9295478d8a

Best regards,
-- 
With best wishes
Dmitry


