Return-Path: <linux-kernel+bounces-831807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17482B9D987
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C042E0949
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ECF2E8E11;
	Thu, 25 Sep 2025 06:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Snp8mKSv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7E92E92A3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781759; cv=none; b=FSYDkWl2Iw/dLUHs182GnFXtXzaF0nWfrZJcpISjoGGtf/FLodHozubGuqbdwPCFUhgaleDyjp20Z6bJfQ7zz0r3LpXXv9QxTt0iwSEh9CuiwctzpF0YS1V1L3SxX6UwANtcB0fCtZfCtodB2IlMdzXMYf2IFlqZVjCBzZqwItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781759; c=relaxed/simple;
	bh=0ByBaAtNUicSKEoYgTLZP7f79bhHaD+AnUFmHZjk2hM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ap+hb2lh4fyjDzCjBdJx7QoYmOzpvHldyhK4kCSWG2hQCQpqW7cNp+Gd6nyN6UxVlQOOvoNwyJH2N8YSh/H1q98pPuDBruVTSGO+UIRZ9VhpzPiYFIGWBvcT1DceV3TFC7MBhA0ws7w0mKNGDZ7gChdkHMHbjkmqaa+a2xYiXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Snp8mKSv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONiVvb029044
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y85dl0qhn/qWZkruGbGchDHEq8jegQjlHb886r0PTP8=; b=Snp8mKSvZc0Sn0Yt
	APTZjZz03aCzoT+bBZFlEhwVUvuKsabdBV8o1tPkR6/kRHJ9CALdPPWRmWkR27qP
	D3xo+Ywb0WHqz+JogloCa7PWF9V6zDybVrgxBaHBWFYCltH1rBFMtEhSqiwkbpZs
	L2CtZ0hazPpUvR8hxf4prtgF4FclxrxlF4YEeU7H4nhhxh++SFkth4qVmtZR+J5d
	JtR385ZG1zVpFaAtvg9uGzf47QqussUx7rXUbiL+TcBC/AX5Wp1Cejy408bQKMkJ
	xMSWeYKsAr5xZNIyNykFupaA9+4+pHZ6Bgyb8RvC0qX1yNu8DzlopEiLIaUZv+Sl
	ZqL6Rw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnycb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b5535902495so540984a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781754; x=1759386554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y85dl0qhn/qWZkruGbGchDHEq8jegQjlHb886r0PTP8=;
        b=o4jereHEyJXDX+PufNgEn/6CDklvPKktbwsBOOXfbYP1rvDhxATaD42OQmFuW3GCqP
         aFagpyhA8RJVD3Q4iUlDEMMpMK4LTZj3qB6WKDQBBSrXWcBzQPLXwgcQRKroMqw9+375
         8grSpGeh+25zA+H22CT65LcsomS1gCSeoTvbyyswxvpRJ5FRqX/0c2u+zYzTqNTz0RW3
         FDyG66zqnuSQAYSwo30Ehl3Bz9gJUWbxIJaHQRQ9sD9yUnD9AVxcMjWCBacojmkTOXUC
         CV7E8HWxVGSwDB/hyESpBIYXpHWRr7gdUUT+F+bpSFE6R3k28fRgIv41DMWdnh7y/8Tg
         GXgA==
X-Forwarded-Encrypted: i=1; AJvYcCV0VJvyt5ZT+7rl3WIOEiC1vqZQuY3s4AVL934qo5She4px0tTBlkSperTXb8FoYTUYF/u0NGhMI8IAC00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1Qe1AQJfNtt1pHsx/WluWBZavvUlcqeeEG2ut3EnbOYhbWeX
	nnYLIOC/CDAFSs1P+QcobgI7zvJPLTBwJUHgaxiMZMZ2ra0gCGiaPinSbpXIdb6ZUMJ6Igb3DJi
	z99D/CaWa3QgRAU61BcGQ06TQHWpmsRalXb0TAMvEKy+W70reCtjlytUqHwiSeGYN0Vo=
X-Gm-Gg: ASbGnctTz7Jjasjf2ZGSZl/Px6+iEEJde2Bt7Gn/urlcjhdkGQCHLoUVRjpwdnhIprX
	BlNctqMSsR9VD38KSzABR208zo8B9DundUDhjyI2SWzyN976NiH87vLlz4O3Etx3YImmvZZs4Z6
	Qvi4mB1gGWEwqOQRfAoXI/U/kOT2kUMcW/z5aRnAAxKXdPeD0hSHMXnoNJGpguKxdS8hC8q/mks
	rPol5wSnvgAVvZHxTWxrZMqMnzDllhXoDjzwMo9KBSyVOJOmL0QOipTexd8Oaj4+zgoEwhdvrbH
	e1hwcXJIGk0vuVjkoJqIrknSXpCg5aNrW1hgaoXfRaqGifhf5ODDm3y3reVlWFKyPWx+Q8nnSdV
	rsrfBpBkoglcIbGgmDxCESrVcFoFbL7LQEDS1bm5tj/D19/rVLJDyD1lP5GC1
X-Received: by 2002:a05:6a20:158d:b0:2bd:2798:7ae7 with SMTP id adf61e73a8af0-2e7cdda05e1mr2585810637.31.1758781753860;
        Wed, 24 Sep 2025 23:29:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHX/ccJ7YWOrNdd9EFOtAWca/CkmiRBUYeVcZ/2QlVZ57BWXQoAaqP3D02wLFLmKoyfyuWuw==
X-Received: by 2002:a05:6a20:158d:b0:2bd:2798:7ae7 with SMTP id adf61e73a8af0-2e7cdda05e1mr2585775637.31.1758781753385;
        Wed, 24 Sep 2025 23:29:13 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:29:13 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:11 +0530
Subject: [PATCH v2 05/24] arm64: dts: qcom: glymur: Add cpu idle states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-5-8e1533a58d2d@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d4e13c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ITxuB3Ybzs-vxhr1UFYA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: qsj8rUSBKvuwik5OzPCRbfVKpq-FbFNZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfXwA8M41g7p9JO
 CEbzKg+Tqh/DT5GzAw1V+DsF3EMK4Nfa4FeAQGIni9IX3EA4l5U2A18FKzmCFldEm9BLbp5R/BE
 1tMjaaXpQBzsIaQQzEjGJ87LFHYKx9P7xzrJwtqO3CSSCu5cRiCTKgMhZmuC+OAZtT5YMKFhsn5
 Y4e1ddFV5yxtF0YUB7k5KdhRRsBO6YNKd+zd9dneNzs0TooZP7QjZEssvfvjnFbWlsjAcna8a49
 Kai2B4t/tsA5xKzD2ljAW5umBsEy8Sd6gvd03VpFuvWP4EyFTeu/DrzEyB/pELCb/OlLuAkQ9hu
 TBJ0vM/EKxB50Xpu1y5LNXXJYDH4VKOhgbufcKY7RCgT2ow0KwiCna5SqC6+8mhXQiMz0mMiW8k
 TwNcplKI
X-Proofpoint-GUID: qsj8rUSBKvuwik5OzPCRbfVKpq-FbFNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

From: Maulik Shah <maulik.shah@oss.qualcomm.com>

Add CPU power domains

Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 235 +++++++++++++++++++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 8674465b22707207523caa8ad635d95a3396497a..66a548400c720474cde8a8b82ee686be507a795f 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -46,6 +46,9 @@ cpu0: cpu0@0 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER0_C4>;
 			next-level-cache = <&l2_0>;
 
 			l2_0: l2-cache {
@@ -60,6 +63,9 @@ cpu1: cpu1@100 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER0_C4>;
 			next-level-cache = <&l2_0>;
 		};
 
@@ -68,6 +74,9 @@ cpu2: cpu2@200 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER0_C4>;
 			next-level-cache = <&l2_0>;
 		};
 
@@ -76,6 +85,9 @@ cpu3: cpu3@300 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER0_C4>;
 			next-level-cache = <&l2_0>;
 		};
 
@@ -84,6 +96,9 @@ cpu4: cpu4@400 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x400>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD4>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER0_C4>;
 			next-level-cache = <&l2_0>;
 		};
 
@@ -92,6 +107,9 @@ cpu5: cpu5@500 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x500>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD5>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER0_C4>;
 			next-level-cache = <&l2_0>;
 		};
 
@@ -100,6 +118,9 @@ cpu6: cpu6@10000 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10000>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD6>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER1_C4>;
 			next-level-cache = <&l2_1>;
 
 			l2_1: l2-cache {
@@ -114,6 +135,9 @@ cpu7: cpu7@10100 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10100>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD7>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER1_C4>;
 			next-level-cache = <&l2_1>;
 		};
 
@@ -122,6 +146,9 @@ cpu8: cpu8@10200 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10200>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD8>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER1_C4>;
 			next-level-cache = <&l2_1>;
 		};
 
@@ -130,6 +157,9 @@ cpu9: cpu9@10300 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10300>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD9>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER1_C4>;
 			next-level-cache = <&l2_1>;
 		};
 
@@ -138,6 +168,9 @@ cpu10: cpu10@10400 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10400>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD10>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER1_C4>;
 			next-level-cache = <&l2_1>;
 		};
 
@@ -146,6 +179,9 @@ cpu11: cpu11@10500 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10500>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD11>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER1_C4>;
 			next-level-cache = <&l2_1>;
 		};
 
@@ -154,6 +190,9 @@ cpu12: cpu12@20000 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20000>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD12>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER2_C4>;
 			next-level-cache = <&l2_2>;
 
 			l2_2: l2-cache {
@@ -168,6 +207,9 @@ cpu13: cpu13@20100 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20100>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD13>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER2_C4>;
 			next-level-cache = <&l2_2>;
 		};
 
@@ -176,6 +218,9 @@ cpu14: cpu14@20200 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20200>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD14>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER2_C4>;
 			next-level-cache = <&l2_2>;
 		};
 
@@ -184,6 +229,9 @@ cpu15: cpu15@20300 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20300>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD15>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER2_C4>;
 			next-level-cache = <&l2_2>;
 		};
 
@@ -192,6 +240,9 @@ cpu16: cpu16@20400 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20400>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD16>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER2_C4>;
 			next-level-cache = <&l2_2>;
 		};
 
@@ -200,8 +251,78 @@ cpu17: cpu17@20500 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20500>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD17>;
+			power-domain-names = "psci";
+			cpu-idle-states = <&CLUSTER2_C4>;
 			next-level-cache = <&l2_2>;
 		};
+
+		idle-states {
+			entry-method = "psci";
+
+			CLUSTER0_C4: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "ret";
+				arm,psci-suspend-param = <0x00000004>;
+				entry-latency-us = <180>;
+				exit-latency-us = <320>;
+				min-residency-us = <1000>;
+			};
+
+			CLUSTER1_C4: cpu-sleep-1 {
+				compatible = "arm,idle-state";
+				idle-state-name = "ret";
+				arm,psci-suspend-param = <0x00000004>;
+				entry-latency-us = <180>;
+				exit-latency-us = <320>;
+				min-residency-us = <1000>;
+			};
+
+			CLUSTER2_C4: cpu-sleep-2 {
+				compatible = "arm,idle-state";
+				idle-state-name = "ret";
+				arm,psci-suspend-param = <0x00000004>;
+				entry-latency-us = <180>;
+				exit-latency-us = <320>;
+				min-residency-us = <1000>;
+			};
+
+			cluster0_cl5: cluster-sleep-0 {
+				compatible = "domain-idle-state";
+				idle-state-name = "ret";
+				arm,psci-suspend-param = <0x01000054>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <9000>;
+			};
+
+			cluster1_cl5: cluster-sleep-1 {
+				compatible = "domain-idle-state";
+				idle-state-name = "ret";
+				arm,psci-suspend-param = <0x01000054>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <9000>;
+			};
+
+			cluster2_cl5: cluster-sleep-2 {
+				compatible = "domain-idle-state";
+				idle-state-name = "ret";
+				arm,psci-suspend-param = <0x01000054>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <9000>;
+			};
+
+			APSS_OFF: cluster-ss3 {
+				compatible = "domain-idle-state";
+				idle-state-name = "apps-pc";
+				entry-latency-us = <2800>;
+				exit-latency-us = <4400>;
+				min-residency-us = <10150>;
+				arm,psci-suspend-param = <0x0200C354>;
+			};
+		};
 	};
 
 	cpu-map {
@@ -669,6 +790,119 @@ pmu {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD0: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER0_PD>;
+		};
+
+		CPU_PD1: power-domain-cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER0_PD>;
+		};
+
+		CPU_PD2: power-domain-cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER0_PD>;
+		};
+
+		CPU_PD3: power-domain-cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER0_PD>;
+		};
+
+		CPU_PD4: power-domain-cpu4 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER0_PD>;
+		};
+
+		CPU_PD5: power-domain-cpu5 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER0_PD>;
+		};
+
+		CPU_PD6: power-domain-cpu6 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER1_PD>;
+		};
+
+		CPU_PD7: power-domain-cpu7 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER1_PD>;
+		};
+
+		CPU_PD8: power-domain-cpu8 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER1_PD>;
+		};
+
+		CPU_PD9: power-domain-cpu9 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER1_PD>;
+		};
+
+		CPU_PD10: power-domain-cpu10 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER1_PD>;
+		};
+
+		CPU_PD11: power-domain-cpu11 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER1_PD>;
+		};
+
+		CPU_PD12: power-domain-cpu12 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER2_PD>;
+		};
+
+		CPU_PD13: power-domain-cpu13 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER2_PD>;
+		};
+
+		CPU_PD14: power-domain-cpu14 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER2_PD>;
+		};
+
+		CPU_PD15: power-domain-cpu15 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER2_PD>;
+		};
+
+		CPU_PD16: power-domain-cpu16 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER2_PD>;
+		};
+
+		CPU_PD17: power-domain-cpu17 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER2_PD>;
+		};
+
+		CLUSTER0_PD: power-domain-cpu-cluster0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER3_PD>;
+			domain-idle-states = <&cluster0_cl5>;
+		};
+
+		CLUSTER1_PD: power-domain-cpu-cluster1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER3_PD>;
+			domain-idle-states = <&cluster1_cl5>;
+		};
+
+		CLUSTER2_PD: power-domain-cpu-cluster2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER3_PD>;
+			domain-idle-states = <&cluster2_cl5>;
+		};
+
+		CLUSTER3_PD: power-domain-cpu-cluster3 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&APSS_OFF>;
+		};
 	};
 
 	soc: soc@0 {
@@ -3927,6 +4161,7 @@ apps_rsc: rsc@18900000  {
 					  <SLEEP_TCS 3>,
 					  <WAKE_TCS 3>,
 					  <CONTROL_TCS 0>;
+			power-domains = <&CLUSTER3_PD>;
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";

-- 
2.34.1


