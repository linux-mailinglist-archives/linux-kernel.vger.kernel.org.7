Return-Path: <linux-kernel+bounces-831834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EE7B9DAA7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2C332672B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371F42EBDE5;
	Thu, 25 Sep 2025 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tuupdz8O"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174392EBBB5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782019; cv=none; b=n0vkMGzsn8sqg1l6vgPjUXT83QjS0S8cXjhfiH07i5sf3mg26S9ITZGwCJTR9lY0jLJuSZC9SejDrCgMxwtwvrXLxGYC3uC83/DZAKguTGKhTkZj+69eWL1iDmep2CwD/CMMlIrc7K6wbuxAmo/vIpOQa1qTp98L5JAw7KAQUuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782019; c=relaxed/simple;
	bh=0ByBaAtNUicSKEoYgTLZP7f79bhHaD+AnUFmHZjk2hM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aine89jQiDQfQ3avi0EGry3y9dYTp5WUr+ZJHuDs7RqXvCfzYQagwAZkz6fIg5m3BPhWzLQN02rciH6I/QbGZgS8c5GTxv1N+eKEnEIxRwPYG5ILv1NLcXJKadU7cbMkYHbn6W3ltXGJHbelvDXniGf839wTDyxgXQOIB6shJkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tuupdz8O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1kNdW017437
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y85dl0qhn/qWZkruGbGchDHEq8jegQjlHb886r0PTP8=; b=Tuupdz8OfPLU/9Vr
	qR5kNslbbE0rN+1aaIQj944dIXPJtAUbuwnFsamvDR2+L0eaTXcyi44PpR3un+NM
	7sEZi+LMUmK4vX8btFySeDxmeS+oKynUPxz/GfADv2WKSRZK+n/erQcSZXCIvrgw
	Ai3UJMV+OBSaPltgLJqM4Wj46H+BRwcMLBB/6g2wscb/GhR+xkPGd/JlcK31GVBe
	6HVB1Bf1G7Usd+TXDx9vFTs0M2m3xshEzi7dI6TxmXlO4/LwNHbrr27Ssi42EgBu
	6S+oG46ulLizpTff0MeYQV9HcCQrbLQGGE+R4Mp0gzABxeoubSoR5Na6k1HIWjCg
	4S6Qcw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvk0c65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-268141f759aso6300305ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782016; x=1759386816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y85dl0qhn/qWZkruGbGchDHEq8jegQjlHb886r0PTP8=;
        b=qmljVDzJR8KlsITVrJCcfe+QK9I/6XJ01PACH+zFp9BQZX62kxy5jcqHMFU/0XJk7H
         fTEYmzQ/3T8/Qp2K38mSq8HJrQ7u7f23TLOkbgsydI4JcXgCvKHiSNE2cmUxKMSzZ1q+
         XlkHR+Kai63ygit3XnpJvM7xmzWmEAIHvkYjMZPBPEouqjByS02Rr00kmWI72IVQZAi3
         zTvm3zTVytLZqM40tpdrZKZdn+ERu0WAHcThguLwu1NxOnJRLLXoRPVhkuuhm2jvtcYQ
         ptLPb8RqD/IWq51OAvTbEerDFD9nAq+uihWi0Jl0qoSZ0shivttKIIAiNZ62kDNcAND8
         5ebg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Fy+4ThZfXVBoGn1Qg8BpGy/MW7axwbcCMBwNnlGY30+vtJEiP2+us7cAyhqobogYN7VxZWMVLW1p3vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpYbuUDZc8Ep8dsvc2mSZFclIcfrK+DWYngQmHBwFMEgfuLSGP
	ylf3/JVWPEJr/+HD0w4zq1QNS2cH0So4jr/LGV1xDBvt3GquJLn2yFVySnZED1kBXuCSz1irU4g
	uD35A2G6kDSOHEyNItxgsMz5oyj+2oQUqXhlAaI1s4bPoVIRbIvw5ZqOylIr9/sKCUJI=
X-Gm-Gg: ASbGncvD0S8QFnP7nB/lJcWWGUGAf5fV7N5iWSwLvddmrIRq8P79N++I1wYDDE8DJso
	xcGuUH4jTJln77VfE4We8HQ+xyBti4jjD05DQIrsnePV7M5SLsAzNvEjfHCBSBvcGFyWYmKTxIx
	5YbyceplOrWxNL8/CXvmVw+wc0ovmJdSCphDwws30rdN9J85eeX9jU1Qpg2pxs036rh9pP8wSUU
	rfuCB7xbBjJ9BzTxiwj66HWpxFHdYc3Vq5wOLiy/MDMVsPGYgrt+lEplDjVgIWvNWNU4J0aWFSl
	fw1VngmhUs/Urjv/vGd7+LxgJstg0Cv8QVRdytS4og1UiUrU218f8r6p95nfrsILYL73WdJBwoG
	qSG7l+KkcT+FLoktK+hT3K65yvzuc0WVl6gn9Dh6GhTKiqTk/yWFqyFyWQFXs
X-Received: by 2002:a17:902:d507:b0:278:9051:8ea9 with SMTP id d9443c01a7336-27ed4a496efmr27909505ad.40.1758782016367;
        Wed, 24 Sep 2025 23:33:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERNqL/XYX2Ig5teLxMMtY/ABx0dDuTlU0OfYiRMxqecem6Opx2k2u8DPVToHCqfxEsSIuQBw==
X-Received: by 2002:a17:902:d507:b0:278:9051:8ea9 with SMTP id d9443c01a7336-27ed4a496efmr27909155ad.40.1758782015869;
        Wed, 24 Sep 2025 23:33:35 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:33:35 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:13 +0530
Subject: [PATCH 05/24] arm64: dts: qcom: glymur: Add cpu idle states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-5-24b601bbecc0@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: SpHcKu_bvr95gEGwRoJqtiLNMZDU73Vj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX0wMqCKwea+f5
 VxARBjZubAkXfaftwDRilMZvYaZblOo/srQJuBvwmMuC3EtDirAAQoqsiJNMW7MzfCaPRW9fiFZ
 tTMYTAlxHx+NGjlsMvxi+W0fSJ3Y/2KEV5TbGiCP9oUel3PUHVLsDOTOJgjwuBYirfdjhkCKGoN
 SavviZVgPTIs6GICJTCEqO14TDw3d+P6l028cZbr06Py3fAFStBaba2HSlgRVbk4di0KBjozTBA
 +2OyBDW1aw2MENycC/3zX/HcT9DAxPVkEUIpZ901EV7lz20vZqAfgqwKiEuh1153VFHXEWJ8gxu
 8B1Ae/THhRDbUbmBt1DncgedMseo2jPS9qcjj1jJWLc4cvz+tblBWFmKlqd5PaiqhBvOtxyU0Ya
 0kjDM829
X-Proofpoint-GUID: SpHcKu_bvr95gEGwRoJqtiLNMZDU73Vj
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d4e241 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ITxuB3Ybzs-vxhr1UFYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

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


