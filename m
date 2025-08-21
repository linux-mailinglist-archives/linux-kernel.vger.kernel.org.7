Return-Path: <linux-kernel+bounces-780409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F23BB30184
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E73177B14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9479B341666;
	Thu, 21 Aug 2025 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dzKAwygS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222EB307AEB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798900; cv=none; b=iU5qMd/RLqy0IiNhduhxRRI4yYXM8GHMs+z3AO09AHHNHfJqQLMlk+VlSg37BK+rwdnT5UidtI+uGII5mbzGdYBGVfU7V4Q2iD7NmMtHBX+2CZYWliHDwnjpKudjJn+D0MadOxlCX68sLzpjNCf9KzvVaV3DIORVoE+v1xX3LjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798900; c=relaxed/simple;
	bh=PFa690eod7vbQoPrBTBGBZTqe+BMbVh+t4iOEti3jnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nGr6zctTbLBQaYQeka+elqGgRNaNKd1Ta359DCyde7c7F+JsqkLkfHlC1I8/h96nlsWf8ggeupgo0yFwxL9R5ObPvY/qi+NpjH013lGazUAtSXu7RLZqGsKpNPXl9FSKqtBfnLzlXFYzp+GH1MTF89WvIHWKJcYhNeDwHTRkstE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dzKAwygS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9b8TB012780
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7F2iS3xObjAX92GGdMnwxH
	2K3kJqgrYwHb57/wCGVV0=; b=dzKAwygSPajxfPtAWa1k3jE5nomgXSYgKLT5/k
	yp9Yt4uNmcdzb5Ga9TEQU5vDSr5UBRbZANGmMD4VwRPdNOADDMTcAJpqK//Q1Zc4
	FyhkwNYQSWOPiCfb/LsV5DuE/GSnMXSX7P9ZLd/SMNEPb2glg2aS/+ifqZ8PPWBT
	1mXS+/ay9PBm1LDhhePvR+7iSZ1/tZ10KY4mwLEZltv2BJLFkOPDQTmV1mGagPx3
	RPFj1ua//tJY0UMoqCkTUEtI4IdUq2Noj0Tq05aabNJSZwVxjqU5pnCr4FFfhFiN
	kG2fkJb55uYGRpZdZVvMBwLARc2dWN1TlAq5U5O3UH3uCv+w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngt8c5vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:54:57 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e54a1646aso1427161b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755798897; x=1756403697;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7F2iS3xObjAX92GGdMnwxH2K3kJqgrYwHb57/wCGVV0=;
        b=IjGU3PM1pSqCzo6RZs6PgN3Khn8Liuzr0+FHzpJeqxa6tlFEtL190CWHY+vfyLvKIB
         hj/lrta8Augc1ZEQsUUcqkZL+DV2DawWoVgX2L5fMMD0vDMsu0fOvoNmWJfJgr00xO8H
         rzUJHg12JtFs0/kWhic7jj2ZefwmzqDn8XiAApq6RFldkU7yvW3VwzNINt0YHYy8zvIz
         5ccvS2V5q4R5ccXb228ZDhpXoqxehRhQ7UFWhZuADtPeJn8O2wdtz+MKVlU4oUF4IQnl
         AP257EyAsdszaTEOX8nBtAeNxyxj9Ni6vo8Co4ZvCpIxA4WJAKjghdWTCTp4YdqwdQyP
         dYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWwv6daa5xpxSIJU8gCv2J3nqgny1ZiQovdpXEhXQAg7HUr57Tvt9rERMyLl3619u7ospdcJfs+BdukhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhU1CguEhiLCrl9DOeOgYlQUsx7yRFOsVngipNG5pvgaHIA1WS
	A1nvf4tABYbfAng2JtURzACCnCmqWtq+RStzADu4IKLMJg733eN7MmNNxQ9Rv0953RoG94UhOuX
	yHVx+b98G2r4BRmgyWDjYPuSv2EPIYlM1R7VBNwNIUZDu0O9/cNCn/vKYq5SwnwCcEzk=
X-Gm-Gg: ASbGncvndZuJq9ya3opARYoiuvdZGK+BsleADqaKkP2n8rZ10+xhra59+Y3crOB+oM4
	aMdP79h/mjH37rS2PhsR9jtgozau8FMNql9FsWTeK6QmvA5X3VDTJD61eyHIJP6ycgQ1wO/SnNX
	quiaVbgWFN4jF448v6TKYoWwnIR9Rsv82Dpn5N4FdWvoUU1G8Qu/+8nLChL0ODwuBo5PEUNIQWK
	KVLsD/WqjCi8LyR8rleB2Ml91E5nuX+3EfN+dzOWNFWwB502JvXtUM8r/Z1PeJUTscBXTuaJTM6
	m1DhkEB98CiBqsO23MqIGPSPHyQrQvn8s5/s+iT1rhTJpfHBt4iyZAP3GmsuDVVGOQTGe5W5eKL
	N
X-Received: by 2002:a05:6a00:1a8b:b0:76e:885a:c331 with SMTP id d2e1a72fcca58-7702fc7597cmr290725b3a.31.1755798896585;
        Thu, 21 Aug 2025 10:54:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHdfCq/ZDg3n95yEzjK9PbaokU3P+W+8kWA1gzRlO4XEPL8VOLZfw4yxx7aajJbuGBkf+VAQ==
X-Received: by 2002:a05:6a00:1a8b:b0:76e:885a:c331 with SMTP id d2e1a72fcca58-7702fc7597cmr290700b3a.31.1755798896124;
        Thu, 21 Aug 2025 10:54:56 -0700 (PDT)
Received: from hu-vvalluru-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e830d3558sm8053939b3a.75.2025.08.21.10.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 10:54:55 -0700 (PDT)
From: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 23:24:28 +0530
Subject: [PATCH v3] arm64: dts: qcom: lemans-evk: Enable Display Port
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-enable-iq9-dp-v3-1-8c3a719e3b9a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFRdp2gC/3XPwW7DIAwG4FeJOI8KAwnQ095j2sGAWZHapIE02
 lTl3UfTw6Rpu1j6LfmzfWeVSqbKjt2dFVpzzdPYgnrpWDjh+EE8x5aZFLIXBoDTiP7curPj8co
 xxuCCAdcHx9rMtVDKn7v39v7MheZbY5dnk3msxMN0ueTl2AFiL6JTlqxNASMokHowPgrnSQtlf
 KLBpsQe1inXZSpf+6kr7Ng/V63AgQ9RWSAQvTbqdar1MN/w/Fh8aGUHV/mDWCl+I7Ihzqj2H0q
 pjf4D2bbtGwZgUwlCAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755798892; l=3547;
 i=venkata.valluru@oss.qualcomm.com; s=20250711; h=from:subject:message-id;
 bh=V5g7F5RRDwJD+H4l8qjmFMShWrA8kWLy0TMticjfMnU=;
 b=MaekKgqai/A8QlOyblqrfq3lV3L6YCeYbTrz5UL0DviZdnmMUki016PkLEsXMMHwIHsJWJQ43
 o6nTJw6sVMADqQb55RJI7vcyn38WFZJ/vq4V6rqeAEp80LtoVJ/hPzX
X-Developer-Key: i=venkata.valluru@oss.qualcomm.com; a=ed25519;
 pk=f/CAPG1ZGl5SP8S1GuC97WMhUEV87h0JheHkNMt1nhM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNCBTYWx0ZWRfX4rQAzowE9rXF
 9DrTcqEn372WF0WJ81lc9GUAQZ30oZDuT05uWZY0QVS1ZqESfHbbdAfc0UvvshPGZwUd6ZVhwE3
 u30xZA5K7GEGoclE2LSenwJ1HJQNG4J8p92pVkrhQYCVJNq4nSzEoHAmgoshHANL2bVJJzg6rSm
 KP9QIpOP++yhNbVa0aLy2/i6uZyBjo6UpDs+mAo5Cu4Amtg3SeUDMQz/v8TUmS+jRQiQEFWpXvI
 PHQMGCKHLrZqiJox9LWvAIY05vG3bzslOm2oG3CscmeZAl3oihHC3sNpfXBZ835FQwSQGM/+rxN
 YIPDrrP/7ooKq+eyb4b55jiv181ickKlFxbe0LO8KQXqUnuQRnmOAbm4zc4avWPwmQatPu522Vy
 HfibZJRzfWHBiUo3NeICBXpPQgzxOw==
X-Authority-Analysis: v=2.4 cv=c/fygR9l c=1 sm=1 tr=0 ts=68a75d71 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=Zrbf0049nC-wOleC0xsA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: TdTirfivrD-afOjBTJGBe1qx0cbVQdrf
X-Proofpoint-ORIG-GUID: TdTirfivrD-afOjBTJGBe1qx0cbVQdrf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200134

From: Shashank Maurya <quic_ssmaurya@quicinc.com>

Lemans EVK board has two mini-DP connectors, connected to EDP0
and EDP1 phys. Other EDP phys are available on expansion
connectors for the mezzanine boards.
Enable EDP0 and EDP1 along with their corresponding PHYs.

Signed-off-by: Shashank Maurya <quic_ssmaurya@quicinc.com>
Signed-off-by: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
---
Changes in v3:
- moved pinctrl nodes to soc dtsi.
- Link to v2: https://lore.kernel.org/r/20250820-enable-iq9-dp-v2-1-973c9ca22474@oss.qualcomm.com

Changes in v2:
- added dp-connector nodes for edp0 and edp1.
- Link to v1: https://lore.kernel.org/r/20250711-enable-iq9-dp-v1-1-6d381e105473@oss.qualcomm.com
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 70 +++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi    | 12 ++++++
 2 files changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 669ac52f4cf6aece72141416068268531fd9f79a..9e415012140b8a0c17c36580b9c6d3ad6cadcbca 100644
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
diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 64f5378c6a4770cee2c7d76cde1098d7df17a24a..7c9972c28a54008dc0bc1b556d93c0707a278dd4 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -5004,6 +5004,18 @@ tlmm: pinctrl@f000000 {
 			gpio-ranges = <&tlmm 0 0 149>;
 			wakeup-parent = <&pdc>;
 
+			dp0_hot_plug_det: dp0-hot-plug-det-state {
+				pins = "gpio101";
+				function = "edp0_hot";
+				bias-disable;
+			};
+
+			dp1_hot_plug_det: dp1-hot-plug-det-state {
+				pins = "gpio102";
+				function = "edp1_hot";
+				bias-disable;
+			};
+
 			qup_i2c0_default: qup-i2c0-state {
 				pins = "gpio20", "gpio21";
 				function = "qup0_se0";

---
base-commit: 1aa50d938e88fcad1312467bd09be4037bfe68ff
change-id: 20250711-enable-iq9-dp-addc9c7195c9

Best regards,
-- 
Prahlad Valluru <venkata.valluru@oss.qualcomm.com>


