Return-Path: <linux-kernel+bounces-853749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16798BDC865
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21A185022A6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEBF2FC025;
	Wed, 15 Oct 2025 04:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="msPOCJZx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41C92FE57F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503203; cv=none; b=do3Z7V5YtQSrdiBUEvRqeS+BgpBswkqcUMbVoQ7y2Vjmn2RMBdChdx7zkL/LLVExM3zjeg8kHmPa4f5qQhQRJFw4F4BhFANfACXjm5b09Px0qF5s5CUx3Rl47uwU0l9omsSn6LXS6nea6z6TEFBNLBTO313xAykxU8Ov1pO2IJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503203; c=relaxed/simple;
	bh=BQbA1PfTf4T3catTnFJyQPDRyKoNlBdFRYRrfUNeAx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ba/GpeEiRJPy5OrHMs/2XezGh3HSDWVTYzVRSxX/jA1ZXuRAaxh6nGYgKKXqaQxI0uDCiaFL/nCEzBRMXemSd3cpoDV9nmMDjAg2K1G3zfvqbWSt2irApLlOkklrMP8/rgl0ZSYfMRYDKrJudYJmXmPBbiC9MR50fXouPAERv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=msPOCJZx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sCpj024854
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rJQkYNJ2ptgfx/Tld3lEk18PrZsK416NnAJeaB5RM4o=; b=msPOCJZxEE3uULcc
	MC+h/g08u9WGbFghGMnkBDqCEUVs7YqwOkQPLyeX/JOhMaQmAAmdMrnJbudQyrDf
	hat7XaOi5Q99fxRLeYhocHYd70hVqeyC2UOTpCVI+X1NYHE69htytLFg0/BNYgkn
	RgLcHWeFUckj2+MDusmTrcIpxkj7EvX8/psHeTh/8Wrg1uTUUwuZ+kPDDCq90jfX
	uH3u6/1Bf+QXk8K4iWtvZqlVnDbtsEV08qzAhuay9tuQVdPrS378lCT7yWgNy/bN
	PHOXTDP6hZ2BDIqHNOs+Phvbvu7qpY8ak/HPhrLIpT1XCI5V7i7HrIIPbe5C4d6k
	Zjg+Dw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0u1m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:40:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33428befb83so13618823a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503200; x=1761108000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJQkYNJ2ptgfx/Tld3lEk18PrZsK416NnAJeaB5RM4o=;
        b=GBa4Smggf3g7YW1gN8/B/juM5wBGvExH+705GjUgqQe5JRoHLxEJljEunFCwfKqvZo
         XZrCROMQgfDGPf+/xUOrk3VXaPrPykTzrQm83Lc+5iaHRlK/DYB+uF4/akdqpTTCE9EE
         Vo2kMr+97oDhWYpYshbWg9KhZfbUC8IH9+KMsYFBSHcCI7pnqwIbaDaXMkGoZBtbpUhZ
         DUekLs2+FWMWe/eMH3E6nrCvXjrbYlGicIdQCtj9tbJwajusfSGIw4FOC5Pcs1XSsWyv
         y8vIWAowobePOZkekImtf96TmsLbG7bp8a5Dr0WaAgcl3mXsavEZiYihWBMTB68iDIpF
         Vyww==
X-Forwarded-Encrypted: i=1; AJvYcCVmDp9WruYNbGm7HTqtnGLd7sP6GgvTIWOA0U27iut293iq3Sc3fkR9BNEtd6FqDnqQENDS/CunuxUlYqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgC4PTTXncb4DXSwjClfMphqDXmPfepWpQklbrnPMmJajxPe6R
	2PAcf3GDJ6GUGylnqu9Tw35SrJE4TvM1qTzDp2nMr0DgRRhmALCpzeX40H82aTlqDDU2M1xm//9
	CIMkPmHQauSj7YfUAO5lSRe1ofihvDkPMYhgaeNaahky1Mj4QMnsRruf5Ybrvg3lb3jk=
X-Gm-Gg: ASbGncutOPQvpx2Dc9GDT08EVQzNCB3y80ZsBNI/+hsB/ZiRWbFhWcDz2pTSSe+xPtl
	FrNC5rI8xCnzrdawPsFXloT0i0uYyL5n+jIW+2jOVecfCeFF1QwXVgzepAoQbl+4ZnUiNgTptcq
	FQ+f8I69tsRErTMi10n84Y5kgiNwrrfuF/Y2AmWJYHWiUIv6Kr7b8qbB3zLNLkPItyDHLwyk1Dn
	j0gSjp67TpYY1Tc+f72nL2SeHa0VtAriStJiHkmb881l46w0cyZzIJ/Uwi00uLFcks/CSE6DyUy
	Yyrq8IBK1WaHT0oVrtKx8QAfhaKhh04NvIZ5mkqfLVeEtsf16LndtzrUjfWreycaKjHFc0yyjsQ
	p
X-Received: by 2002:a17:90b:33d1:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-33b51149957mr40663629a91.12.1760503200049;
        Tue, 14 Oct 2025 21:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzhSUdPcBNtpuWSbeLJvXggYqhWYI2i+smtNsSh5TePFlbEjw8lNbvl3tdNRydAZ2+8EAKWg==
X-Received: by 2002:a17:90b:33d1:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-33b51149957mr40663569a91.12.1760503199250;
        Tue, 14 Oct 2025 21:39:59 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:39:58 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:24 +0530
Subject: [PATCH v16 09/14] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-9-b98aedaa23ee@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=1185;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=fkRav5QA/W0o9Ycg3/xbut6S1Npfgr1jXzERBrOotDE=;
 b=skcrZstdabB94QPMmNvmUBmgXo2iDP/K2PrViGd7XleSuwoAEkPT9UvVVi5uAiw0VXmzxWXoP
 MuzJD13LH3EBKpAvsTX2o9knFlhccW9FSl09RtowPFeXjC+ycWwLPRj
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8r2P7jnW04Vz
 UZ/49SwdfJ7ISnCQCP+LmgIOWPGA5sZURtRipJ/dJ7ZBKbpuPl19vuBY6bpzRFwHPE4Ewr5UH7l
 vweI00kH3p/Bkbltn/h6rx/L1Png+JYwX1PCs2sSxWZsuCH4yJxVJKaTJVQTpkNsm2SDvdI+uQv
 on+LiuDwu/APAHhBdPhYmlt2xfxLo7e5XBU6Gmrqoo7Tie8q7fcfzN4XUi64wPcJNNbDQ4ASonz
 SQORlF8q2UxgTyY9o4Cj2iFvKiqEU60h0vO3cfb2Q/SkaZPZCFupd6vVIY/3x5YNJkT1UszMO/Z
 4ZD/DSZexp8vKORqPlhfQ8P5aaYZHRFIS7tG2lgow==
X-Proofpoint-GUID: 3fYpbkCbka6Wn7m6_D_WyvxRMNqRlODX
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ef25a1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=w06kbW2hXDg5FjFnD0gA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 3fYpbkCbka6Wn7m6_D_WyvxRMNqRlODX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add support for SYSTEM_RESET2 vendor-specific resets in
qcs6490-rb3gen2 as reboot-modes.  Describe the resets:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode. "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 18cea8812001421456dc85547c3c711e2c42182a..f38fa2e52a635100a7505c615c0e96f1111d0b5a 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -975,6 +975,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x10001 0x2>;
+		mode-edl = <0 0x1>;
+	};
+};
+
 &qup_uart7_cts {
 	/*
 	 * Configure a bias-bus-hold on CTS to lower power

-- 
2.34.1


