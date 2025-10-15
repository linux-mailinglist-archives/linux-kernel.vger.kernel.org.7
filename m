Return-Path: <linux-kernel+bounces-853748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC76ABDC856
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDA8E4FF1CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69EC2FBE1C;
	Wed, 15 Oct 2025 04:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mKTU5L9p"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6D2FE57F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503194; cv=none; b=eRnOTzpLnvsnwpM12VlbcpCQ0IBa5VcYG+SM/3hlG8P1ycpNmiBuM5wPTYrnlXurUwtYod1UrmKGYwrImjflkyR+kaKQcImvTDkZnEaojy4c5a0zVQbpy+ob+K+XXaUdnzzzGAXRVWunUE0693p0UkfrRLUsV3rnYaoDKR//fE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503194; c=relaxed/simple;
	bh=SF0ZX2cFxEwhDHiUYZmJsI1YTJ7iLEFuK/SHB+KhRCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DePQtOmWdSr32NcDlqfR4nzd2HyU0TOSESRrBgMtwgPTqOvrFzSNXw1LElYgTq2ou9tIvOpF3hVsm2D87TlH6dBjZCXRgcoNnw6tbaf2OyA8mhbHZKfkPgRnr5uttmQMYDYf4oMVtTWI48zKasbQC7wwKcd58R9pEnQ3B4iR2hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mKTU5L9p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sSa8004236
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aIrqaoEgpUjH1gWqJbIHE0oWUKMM91MGVrTsMI//tac=; b=mKTU5L9pgpRzJhxe
	+Hew/+th7SmqB1lfHooMNMFvfhlMEd4BATgkfq36yxsuYzk9OtYH/f3c42kWkzRe
	rzim5UMj4qJL4ICHa22zaWxC2WGWk11iIBbrf5C+tHaNqhY9j54xBDFBi7yeK8rJ
	dPNlewCwdNeyHuv6eauzbBRTUf44kmZgihLeqtIS6cyMx9Vd8DLscKWXgzM2+58e
	DiDVjc3W2W1Dw2N+N3dhzVz+TQLmIr8A1rP9y5DcUb2yrO5MMvmyI2hnxWlnsa2O
	d6iR+gRcoInN1By7tGTMpH2D9YRa50oENZRhLKq2eufxbZU8lxNHkZ7tq8YOYM7S
	+9+MFw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwnbun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:39:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-339d5dbf58aso22959725a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503190; x=1761107990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIrqaoEgpUjH1gWqJbIHE0oWUKMM91MGVrTsMI//tac=;
        b=no4LdVdFpFbl9grujfGJYGWGmr56ZbIDvr8pob7Iaj9G8/WTY/yd7tnscSYiB/WonD
         sws1+bv78no5I6fjEn9YtlX99SLnZGoe1StlT0k7goTZ3tkRvdKmyO2CKsvDLiYLEVbf
         8SaBzRFNvgPd3RxfgZa5W/y0aMRVAhodAp1O69HctH8KCXrca7hCFua+jjntUaNZSeJO
         uxjvTVM+ekYFBOPS7sy9pn3nTRDqGRvIBRbEfhfKahy/CJB1TESs7liPMTvqVvtX0KnN
         SRdP8RZ0qMq07Di6hKUAT0rnppvKa1BwvvRdOc9CuZEMP4J23HP5P/+VeHnF2ae555YZ
         setA==
X-Forwarded-Encrypted: i=1; AJvYcCXFbGytGJvD1bgAKy6UfZ3ScHGRp0+v3oWWeKaAxi2RBAaIxNhzkAquFIdPAfuVE7NQ0mIF9KcZu5rYwk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMG/Up+OqGFpT2y48dd6WyxfChgEgLPJ8gtYfYf/ianDfBCeLH
	EBywzgFA4ds5vaLH+kk/Sk9JEC3jdDZk6MW290wTDGX5vCBnR/zZCzvgbSk1i2cU+GkkVJV4dnu
	of1//U8blqw5DJRg5zDEqHi+EfoCaGqM1c7/OrcnkRc00PrRjpvBhGFYHGBbYm3lHhMI=
X-Gm-Gg: ASbGnctjS0rqDJiEvvq49FoW0QMLAXdIVu2k3gwHDNufqdPumSv0CuB1ruIXgAmejGW
	WZJLni1vvsNMQfWGmXUqeK39cUDIk57LFiE+/Y4ovoic9WaGBA+NRH57VftW68QqjQ4i6D5edKM
	7hFgf5L6j6W3VeFHBAEyQZd8jBv6Sh7g/EbUGv8r3aguWVHSUTVza/gCFEV6AEi/nhTgAub5i1w
	vyEpCDAGHUkdU0mjAdH9te9qe+GsY82gMW3lZExz/gGIx9hPSbAds+ULol/O6aq+G0VtfRxpuxC
	pKqFf4h2beD+gGUBi17As1URevfGMpB8QktDpJckWa43sE07l5g5J+dWQj6Web3wE8MSOpeSQd9
	3
X-Received: by 2002:a17:90b:4d08:b0:330:793a:4240 with SMTP id 98e67ed59e1d1-33b513ced41mr35775303a91.31.1760503190392;
        Tue, 14 Oct 2025 21:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoIBdMWJbuvqOxHpsoJ2SXPuntZq046aG+M0v++nDpNVZ+bCmPJYBX3N9RPRNo9pLI7vYF4g==
X-Received: by 2002:a17:90b:4d08:b0:330:793a:4240 with SMTP id 98e67ed59e1d1-33b513ced41mr35775260a91.31.1760503189905;
        Tue, 14 Oct 2025 21:39:49 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:39:49 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:23 +0530
Subject: [PATCH v16 08/14] arm64: dts: qcom: qcm6490-idp: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-8-b98aedaa23ee@oss.qualcomm.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=1628;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=CXhzYLss6B84Tshec6CrBMIL7abCTu6KdaOnK+fDvoE=;
 b=e/n+X2V5Goy+lb5dOox9u//usFNX2UoiNBTuRW5PuKfbENSKiL3PsZTGWMHHawy/fOhX9mK3v
 xqtcZS1WfdSCVMHq3PDL9w+vAsdRovHMMHuZtGTssOxkDmn2YtVFCmB
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX2qWDJ3UrG/Jj
 ixSWwdPxxlFho0ITb/iw9wwzGPBXJtU/5PME2WdRXUZbzmBgZ+lFslhCbRCTfhDM2syFMUhJDN/
 V76y6S66sj/U6r4eCDp5g/SmJ+koqlceiDbDXMI7hcxCSjU6F1uTgLw0wJ4IFNq1MA3czg6N86F
 lPl+vsOBjGw0kHtWQ8APOUmuhupjmJgytt6Sd4CRGJ8nnbPJPnsNtQOoQ8kyaONFmHuR02nc7uq
 Mm+BU3txqJZibkwukIncQNftO+/DpbDM1m7FSCf8BalQCU9+TMMz6+BeDiplVQQ+jdttN3wJIZr
 3InSAYzCCoNoMKSRjjJYn0xXrGacFUEo7+MUD3kpBLwauZpokCnaNrBcRbymWwJi7ToMwpLI1vW
 FtYLL9C6h+KlqXVM34/mSm4j0Pit+Q==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68ef2597 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=w06kbW2hXDg5FjFnD0gA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 3hmWaRWksLFETqX_SEw_Ke74bzgQ0c8q
X-Proofpoint-ORIG-GUID: 3hmWaRWksLFETqX_SEw_Ke74bzgQ0c8q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add support for SYSTEM_RESET2 vendor-specific resets in
qcm6490-idp as reboot-modes.  Describe the resets: "bootloader"
will cause device to reboot and stop in the bootloader's fastboot
mode. "edl" will cause device to reboot into "emergency download
mode", which permits loading images via the Firehose protocol.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 7 +++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 73fce639370cd356687f14a3091848b8f422e36c..84322b74917f3a70adce5a4182adfa5d787ab11c 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -695,6 +695,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x10001 0x2>;
+		mode-edl = <0 0x1>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 4b04dea57ec8cc652e37f1d93c410404adaadd5d..211c2f223a03c63a79ddc736c18a5b79faec56a4 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -858,7 +858,7 @@ pmu-a78 {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


