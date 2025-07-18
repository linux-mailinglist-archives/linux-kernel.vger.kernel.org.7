Return-Path: <linux-kernel+bounces-736883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EA4B0A499
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C246A5C0596
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5242D97B4;
	Fri, 18 Jul 2025 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WZE4u3Ay"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E22DBF73
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843451; cv=none; b=AHmyiG1mMs2IfCOLYEnaU3opO3DVXkTWf9rtJSTEvhDifYkKifY5geSp0I6fewcrk5tWKFnz8FE17POag+SPE8PKGbtumU1k/VYfMMIRp2crYcEZJyTbJAqaUpv//dLpYL4FVCEiSSXx/1ehYPY8TUAKhWdUBLQNVryHPGDApL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843451; c=relaxed/simple;
	bh=cKGR0zU7s3E7oC57YRtxwLHqmhnJa97I1Yo8wxaA6/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GmHdr8kZxpccJUo29f8QWNZb0qaNfrfLo824PfFOAp4qJZ6uPkGMRpBUmF9OOwJ28hU9Od1ETFKeFA4NoiCbvF2QDoFzB7zl+rj3Rex7kWxvkUimLGQqvoaAVxJZm149fFAWeuwD4Zs7/1vbJo/HKHMRlUUlIj3gNgC+nVWxmtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WZE4u3Ay; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I9OKLH021791
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	86sPeJjsQ6KRGA2VS9+la7ElomzbtmNHgwe5CMceEL0=; b=WZE4u3AyaDYwX1Xl
	uwxlB7F/aOeHMbV8VSOE1fVOI5SM3K9RqEPP4P5VNiRx0/FvjumZ9ctUFFEbJwXI
	YZPfe/WUK8fufB2zQ6pDF/61Xxbkm4VUZ4qZxL0Xil9kPXFm82kD11gDy9SwNZbz
	uw0twJyI6jo2aLR3hIag4t+Pf+pSrwmBGtRhSU9fjXXsX7QU0AXGpHzqmkNdL5QW
	LyQ4GvQ9rJDv/OCo5JgXPi9uQqwtSv3Qr747Xggx6LhxG5CkYzZGeZ5aHSsh8bIF
	wRRVKMu9jVTBxeh+x4YYkJzZZ0CYYd0lBssDkhWCVDB4v1GuvGlW8kS6uobtPC6w
	Ybuehg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu8kc96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:57:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3141a9a6888so2018576a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 05:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752843448; x=1753448248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86sPeJjsQ6KRGA2VS9+la7ElomzbtmNHgwe5CMceEL0=;
        b=He/og5b0CnhQQCspNCgcseFKrRj577XgRHGils4Me+TnN/tVt03p3yXdaAqvtHXv/R
         rbhqPkinV2MiRudKxQLB2c8FPmRSMqJFwNqa3kXeGUkUc6+f9o+65cUO+ieC+2H7BzM5
         1fLho97YDUD75k2MEbuc+aKkcyKUFzpjuGfFPLHyk0bOSWAWGCmfvWUPJFouf0gYme11
         3nUn9nowPITzD0TG5ByuceMCIiSAeJyYGx2VYNWSHsIJuj4/V7c1N/Ilp4vxKMGPAnG4
         HVMkhjNe2oEYRtbEqAh0RUlyQvksAHKVC8JcwCYVZHZFt2mi9UFMnJa2NeVdY+v2gNAg
         HPIA==
X-Forwarded-Encrypted: i=1; AJvYcCWIaNZpRK1DviCfdxI99+b1+Y8wgtd7PpCzISBGO4xjcAl6hQUb+c71eDBhiXItv4FZvdREA8U9qfAQPBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/KaSAPx1H27GBLZb7pwFmwHEeVLgcHGbUtu/ft7en+wrHhhBM
	OFAeFto3cdTtE8RwSri4kX7B0iDLvE0B1i67jTacF/R5k5+GxrWj1CDU3OZSGSYgGUgiURp+gDT
	wNMDe2+mukB3f1hJtrl7aviyDn2IoVH+xqUFGBcQVdFCjrz0gKPtUh3uFGzdEE/CPpiw=
X-Gm-Gg: ASbGncu4C2BHPZ0JrQlt8ICJSJBxF5moUMWsrwV2YXeEZoObUULWzCMjgnzo65bOn43
	g7dAoUQneIWZf9/pS6X2Oy2V2QGPy7EtPIL8oSTO9ODrJL+DtgcihtOaRwKc7suNT7t981M0PDm
	8tt8kDqV3YUlY168k6TbaKCdlNd3d+CqxE2nAfJrVbZ5jlxLchjS3HuDW/jaaYL6m86QGycViCI
	7i9/SNEVEGzFuIwnrKUZaY4WB0hwmI6IJq/Ro/r6fMLXSk0U5916g3eF7cFeUxLhB3bVOdx15IX
	4thJhjUzPRtCRmUWNCTbpPEsWmJUImXsAoZLO2Wm/BdH5PIyGr/n9lwuX/AQdzs9i5fb47ELY9k
	ytYSqDFx7mjgujA==
X-Received: by 2002:a17:90a:d44c:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-31c9e761788mr15380322a91.21.1752843447714;
        Fri, 18 Jul 2025 05:57:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw0ZMchemW/BxrHg+O4GUogX2V+2SB2S/yCDt9/ia77pHKXWliKDjCnNxwxrDAi0XV8zA0aQ==
X-Received: by 2002:a17:90a:d44c:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-31c9e761788mr15380271a91.21.1752843446895;
        Fri, 18 Jul 2025 05:57:26 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3bdfe68csm12332435ad.183.2025.07.18.05.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 05:57:26 -0700 (PDT)
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 20:56:33 +0800
Subject: [PATCH v5 2/2] arm64: dts: qcom: Add display support for QCS615
 RIDE board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-add-display-support-for-qcs615-platform-v5-2-8579788ea195@oss.qualcomm.com>
References: <20250718-add-display-support-for-qcs615-platform-v5-0-8579788ea195@oss.qualcomm.com>
In-Reply-To: <20250718-add-display-support-for-qcs615-platform-v5-0-8579788ea195@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fange Zhang <fange.zhang@oss.qualcomm.com>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
        Li Liu <quic_lliu6@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752843427; l=2660;
 i=fange.zhang@oss.qualcomm.com; s=20250714; h=from:subject:message-id;
 bh=HPPkd23RAXZhBC6QdfhvqrWN3kBAQ/AeNsE7Zd1V/E8=;
 b=a4WgfiCQDKJ6C63WPlA+4uQbQt3dxH2N7vlIXCddhAhWWBvQkTTpLeRNgm1ADhWhaH05hVVke
 MUMC1NfB6kkDDMtU2aGQIZTuFlvZR1ed8udVyy/b36naq2KOOSeWwco
X-Developer-Key: i=fange.zhang@oss.qualcomm.com; a=ed25519;
 pk=tn190A7bjF3/EyH7AYy/eNzPoS9lwXGznYamlMv6TE0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA5OSBTYWx0ZWRfXxbgIGT8u5S0Y
 hUeoP7bOKpCFO3WwrTNrCYsPFfUwYnXtZD6kPmRp+sQfK+UvG/qN+3uKnk/BPXEzGSGVz/a0xAG
 hzXIqHmLrXBUHJqTkScCyc0ogyWDOwZYKtjkfeUV2suoxLgajw8xbPmyib02Jd2uddSfo42grcZ
 Igx5qme6mDpLmkJBHiDUJagvLyTXENQnqSVp08K56Fs50GK5LoIaaF0VjEpIVRWDsYhm8yP1GTp
 5o5lH6qXmecpDCCVivJFoOJwe8ErV6V+5IQyyCMCjxEIXRvFqM0V+LAC4FdWVGWy081nuBCB50c
 ngDpQaxAFwuywf6vBVtKzS9Z3Hso2KQ6D6QDxYDiMFpmt0udgjW+4Rl2CmI9hFK/ifIj1A2SxL7
 3WWY3nwXm9w2iqnVE7B0SMOxLTU7Pr0lKdxN3h46X8u6xDqME15Omc1U4KZSu7fUqvbdvYp4
X-Proofpoint-ORIG-GUID: z4ec2eWhesqsQU85WRq6KqGdFdMzOoOy
X-Proofpoint-GUID: z4ec2eWhesqsQU85WRq6KqGdFdMzOoOy
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=687a44b9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=TqExVNhVPFZef0qJFWwA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180099

From: Li Liu <quic_lliu6@quicinc.com>

Add display MDSS and DSI configuration for QCS615 RIDE board.
QCS615 has a DP port, and DP support will be added in a later patch.

Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 90 ++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index a6652e4817d1c218c7981b04daeb035e2852ac1a..f41e0763170df40c5d10497049ae74ab4aee4950 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -38,6 +38,18 @@ xo_board_clk: xo-board-clk {
 		};
 	};
 
+	dp-dsi0-connector {
+		compatible = "dp-connector";
+		label = "DSI0";
+		type = "mini";
+
+		port {
+			dp_dsi0_connector_in: endpoint {
+				remote-endpoint = <&dsi2dp_bridge_out>;
+			};
+		};
+	};
+
 	regulator-usb2-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "USB2_VBUS";
@@ -217,6 +229,84 @@ &gcc {
 		 <&sleep_clk>;
 };
 
+&i2c2 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	io_expander: gpio@3e {
+		compatible = "semtech,sx1509q";
+		reg = <0x3e>;
+		interrupts-extended = <&tlmm 58 IRQ_TYPE_EDGE_FALLING>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		semtech,probe-reset;
+	};
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9542";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			bridge@58 {
+				compatible = "analogix,anx7625";
+				reg = <0x58>;
+				interrupts-extended = <&io_expander 0 IRQ_TYPE_EDGE_FALLING>;
+				enable-gpios = <&tlmm 4 GPIO_ACTIVE_HIGH>;
+				reset-gpios = <&tlmm 5 GPIO_ACTIVE_HIGH>;
+				wakeup-source;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						dsi2dp_bridge_in: endpoint {
+							remote-endpoint = <&mdss_dsi0_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						dsi2dp_bridge_out: endpoint {
+							remote-endpoint = <&dp_dsi0_connector_in>;
+						};
+					};
+				};
+			};
+		};
+	};
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l11a>;
+	status = "okay";
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&dsi2dp_bridge_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l5a>;
+	status = "okay";
+};
+
 &pm8150_gpios {
 	usb2_en: usb2-en-state {
 		pins = "gpio10";

-- 
2.34.1


