Return-Path: <linux-kernel+bounces-699941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8B6AE61AA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 11:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944891B61C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 10:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9ED27C17E;
	Tue, 24 Jun 2025 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="en+Swl5/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B6281376
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750759164; cv=none; b=JMRkQUxcOC06iHETeoAjf61unCZOyvJbQc8TT1jsI/LI09bQ6gJfZ4TtO044zUQG1viObbmOhCq4PDSHWPQ5K3Btr27dcz6cm2gm5ZXujGifxk1BhhoOK3nycd86rmfk8pJToRdVhLiqB3eG2EJBoOwTf/i1ybI48FCDyeAA5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750759164; c=relaxed/simple;
	bh=et35v3M7TxsjDUdYnfvCws+vnx6i7tsXV6qRDyo3wjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hy4gtfaKeCsZnhX3fmUsAbV5IkOpcDtKFNrcAyiXOA8X4dxJdKzEHh4D2dTHuc5ZMRqpnN3TKSSBD2Qi3zuRMpf2AhttoeJj/afi+ZE8Z6NxsbIuGmU693y+/YbXvVPsdgEPjXdQ9v/CM7Sn7alWJG4A7r3LhYtvpgCfY4TOzPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=en+Swl5/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O8w2UR024367
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 09:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Optt2rO6XBQ
	Q9qmEhMi7dr5/Hn4l28mMtAmngi1crsY=; b=en+Swl5/w9p2wH8r61K+ARLr7j+
	LfOXviK9hYpZeR12z2sFPU4DjPfV4w/Cd8GuFXWmbqLFNNbGI5ur0fcXqaw5bIK/
	Rz0O49WBeMEmBP5e8GA1RQ9pQOOoN0I6n5EBlAr9rmh5k4kJho1J6QbqPKcX6xQZ
	bK7V00dVGBiVMs9k+j3Z5j6zFSrZHYNOcWubtMej9VgMsyZ2odtZVp8Bh1JfHKzn
	5FcxaKkOSLMyBR/oL4TBUd96Xl2mWR4oUE3ceGCyJwvteavdITD/ZJu2MrrAVetJ
	jRqjnHvaJuMQ6M6jhLi4Fy38GfyA0+jLJ05GkaKv+YXydp2ANLEni2+ZeIA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bgbn64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 09:59:22 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7489d1f5e9fso458977b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 02:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750759161; x=1751363961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Optt2rO6XBQQ9qmEhMi7dr5/Hn4l28mMtAmngi1crsY=;
        b=lDW9EgvTJWUqr9MjlY+kyrBxa6Ffyz73bFm6npkxHcEICFvUZeoWvxDHsV10nV1tb2
         k3p33V5f9O76OmFklW0R7QquE/h/UxATt5fo618m1++OUy6Pzy75d+6xMkUjLLMf+WZV
         WyIBnLEtGQBYinEWZsgPriRf383CBnCro1oRRfSDGajwLQFG5knJ/ZINmhc+GWoLmVo7
         fgwiHlvpKuoRZcqVZjKQb3n36g2W++FBXzGLzs/B07CDtZHzezvwSuQDep1KtBLxfWKt
         6j7GtR7eIYg0rB3QiWyFSJ3t2YhrUGAyePzyv74wSK3mc8BEpwXvN5O8Z7Vv3RtgLoW4
         Imiw==
X-Forwarded-Encrypted: i=1; AJvYcCUM+C+L37IihzaQxrodxGY8dp+h7ADBHXtUXsD8zp1JmdT+Hp2bbz/VbtazwAOrYu0IysadnAzpUo8z1ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvz8sFWh2Qpr/Is85CVjN08ohLyYwWbYlN2KSGa20fRXw0qjMV
	+KmmqefApTgw7gmbYLqa3EOxKWLn523jOH1NWT3dhhPdUkrvaAa2Ew81z+b5TQ+4vLSEMcQLRXc
	IPkyK/wPZQrjGkSNkdshH1+/zU6xbEGpnVxiLB7GP1UP73qf8xDYelBd5+0pP3xOmAUo=
X-Gm-Gg: ASbGncsdcucTiwhXxa5G5FkXDpM53IObSuV+/H6h+iZ90YNLfpkqwEBqRTkV8jQVkaz
	QEHGFKT0cLRe9Hceajw0wDyOB9k26Nv3bLMpw0WK9sdp5ksaYvIsbxhr1anXhET55LAimv/GxlT
	BKcxp2JbWDQiEbiT8OIttLTmMWbD1mND8Rz2LLtNgjWJGeMKdPNURwqULGN1jzbHsEvl6jB+eqx
	Vco69eTQsC88ZYdW//xS3qAEqlIAPDjeFvimK1pqOoLwdDZqmrY4hMw6RUYNuTlU+mME0RLvUY9
	mf+YRshfeFulJwN0k9hccEkYxP9lkImE7c8lBNMCD+nLbh7bL62T0p7qxNZP9z8auGwZjNM2mBD
	+jw==
X-Received: by 2002:a05:6a00:2da0:b0:749:b41:2976 with SMTP id d2e1a72fcca58-7490d47815fmr27481313b3a.3.1750759160873;
        Tue, 24 Jun 2025 02:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFm5LAXLi5rxd+dY2ZkrdXXi6904cVirbcf/nlfRIpnodVbXQw/BL2vCoOboUruU9o4q+2PA==
X-Received: by 2002:a05:6a00:2da0:b0:749:b41:2976 with SMTP id d2e1a72fcca58-7490d47815fmr27481281b3a.3.1750759160492;
        Tue, 24 Jun 2025 02:59:20 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e08ccfsm1456443b3a.6.2025.06.24.02.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 02:59:20 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jie.gan@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v2 2/2] arm64: dts: qcom: qcs8300: Add CTCU and ETR nodes
Date: Tue, 24 Jun 2025 17:59:05 +0800
Message-Id: <20250624095905.7609-3-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624095905.7609-1-jie.gan@oss.qualcomm.com>
References: <20250624095905.7609-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FtIocaI1px09ksaHDWTL7B187q3F6TfT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA4NCBTYWx0ZWRfXz4I6TJOcjDQf
 SQpOpzajJwpFgh7cAUcSxoxeLv3X3tH7ZYksjGDTgCrqHDAyo2tVuy/+jxA2gfvevzyfowM4E5l
 hsLZQXpwa2zA8IQlf1kjuUqil7zgoFu2NG91kpp4anOzlCVLqCBw+bTDQ7qYFHroBrIQynKiiRG
 lfryw6iiYTw31uq4vJopQbs8ElbwMeJs0i9up6bbc/0P5/R8kJVg+VBnC0q225bm02i+9SiNgBW
 l/9Me/pQ+s/+Hb/Q9iBLn3IjVtLPUsc5/Z0KCoYOjEq75dzBE8Qor0t7MEki5hnvweA92yhyb98
 udHwVhgME8YEy+CoEh5doiiA6RhvteHKiRdjljrY9xcyZW7MwHBNdmyGJPRbU5lcMWE5WD1nP2C
 vpRfGr8OAM3F7d+OrcDZrhyGyXyMEYMGISEnsu1AmOQudDzSrE4+vF0kRiyhkx8XNPULOAON
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685a76fa cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=xJyy5nzPNu-aANFJA0oA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: FtIocaI1px09ksaHDWTL7B187q3F6TfT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_03,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240084

Add CTCU and ETR nodes in DT to enable expected functionalities.

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300.dtsi | 153 ++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
index 7ada029c32c1..7c235dc7cbdd 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -2154,6 +2154,35 @@ lpass_ag_noc: interconnect@3c40000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		ctcu@4001000 {
+			compatible = "qcom,qcs8300-ctcu", "qcom,sa8775p-ctcu";
+			reg = <0x0 0x04001000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					ctcu_in0: endpoint {
+						remote-endpoint = <&etr0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					ctcu_in1: endpoint {
+						remote-endpoint = <&etr1_out>;
+					};
+				};
+			};
+		};
+
 		stm@4002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x0 0x04002000 0x0 0x1000>,
@@ -2348,6 +2377,122 @@ qdss_funnel_out: endpoint {
 			};
 		};
 
+		replicator@4046000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x0 0x04046000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					qdss_rep_in: endpoint {
+						remote-endpoint = <&swao_rep_out0>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					qdss_rep_out0: endpoint {
+						remote-endpoint = <&etr_rep_in>;
+					};
+				};
+			};
+		};
+
+		tmc@4048000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x0 0x04048000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			iommus = <&apps_smmu 0x04c0 0x00>;
+
+			arm,scatter-gather;
+
+			in-ports {
+				port {
+					etr0_in: endpoint {
+						remote-endpoint = <&etr_rep_out0>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					etr0_out: endpoint {
+						remote-endpoint = <&ctcu_in0>;
+					};
+				};
+			};
+		};
+
+		replicator@404e000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x0 0x0404e000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					etr_rep_in: endpoint {
+						remote-endpoint = <&qdss_rep_out0>;
+					};
+				};
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					etr_rep_out0: endpoint {
+						remote-endpoint = <&etr0_in>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					etr_rep_out1: endpoint {
+						remote-endpoint = <&etr1_in>;
+					};
+				};
+			};
+		};
+
+		tmc@404f000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x0 0x0404f000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			iommus = <&apps_smmu 0x04a0 0x40>;
+
+			arm,scatter-gather;
+			arm,buffer-size = <0x400000>;
+
+			in-ports {
+				port {
+					etr1_in: endpoint {
+						remote-endpoint = <&etr_rep_out1>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					etr1_out: endpoint {
+						remote-endpoint = <&ctcu_in1>;
+					};
+				};
+			};
+		};
+
 		tpdm@4841000 {
 			compatible = "qcom,coresight-tpdm", "arm,primecell";
 			reg = <0x0 0x04841000 0x0 0x1000>;
@@ -2777,6 +2922,14 @@ out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
+				port@0 {
+					reg = <0>;
+
+					swao_rep_out0: endpoint {
+						remote-endpoint = <&qdss_rep_in>;
+					};
+				};
+
 				port@1 {
 					reg = <1>;
 
-- 
2.34.1


