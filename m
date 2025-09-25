Return-Path: <linux-kernel+bounces-831825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90751B9DA32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 325404E222B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCCD2F39A2;
	Thu, 25 Sep 2025 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nwmtjt+8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9C2F2608
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781810; cv=none; b=a08OamfMxI2SZctBb+iuYcq4/LRCrlp9+WzF8V6APSYQbeQDcHfBGYXfKrapDL9dTnlpYzOevOEKNdXZQdj+VrEADCY9hTRG9ObOGMZ3XXLBzq3DD+y1O59WHow9+kaevD5LtZTgyjs7GbbdlhPfcWxV5BBcQCObeFCHKrA5mOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781810; c=relaxed/simple;
	bh=xY45EdffrBMLQN3eDVB38ZJyhhLfVOUzPeIepRrp9PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bpDKM5U9GdnS6VzK5wKp0BRJ46f+nH8Q2tQc6zGY6fMjRy4YbOdMyhHzGROaTaacD/Kl4xcQtQvxwKix8DvUodKyAGXH3u3lqom9xqVb0W/P/Pxl6ESnKCeTO2WF7ek1QeIPMUPo9APqmS0DL3Kfr2QKNzsTfRoceilbAZMcc84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nwmtjt+8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4a81j026654
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W/gQlYDqE+6SroS9br906aV1Ete64sbGoTONP1SpgC4=; b=Nwmtjt+8hLjTTqnt
	AYVOppAoqcxw5Jsd2cHYgXDBFLJYFIe7qtZfYmDNaXc06TkSFCLy9pwybYZs9sBO
	9QglMFfgWjn4SsuQpmANvIs93fxtOcVum6aOiSkiwJa5gMesB7RkhmHYRjqtH1lB
	kdS7L328CLyALGJUF/zYeUBV+azplrMEo4qQYXjP/GlzQwAqCVvraWfXjMHZFWtn
	jDtIqiGBZceKrsU0RPtus3Y+HICyGhlFOJkcP1MrV/gmd8kqgJcT8jX523Hy0up8
	G8TOqztq03+glgt8jSHSKFKr/XUQU3P9ZhoLmA/CQm604AOnoXBBEliVwHwWBnBj
	fIAvaA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup08da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:30:05 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77b73bddbdcso547136b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781805; x=1759386605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/gQlYDqE+6SroS9br906aV1Ete64sbGoTONP1SpgC4=;
        b=SJpVe7mWAXUVPuhYUt2hA8lIIqQldk9UHZ9HnjSxvLwVS2kQHyE1s8DDHAdqAjOKxU
         IeubrlYL/7X1H0+YM+/jcyFW80Uh717KCOqBEDB5PKdCAxvEJm2tJsaFLs/2ThL4aHl9
         gPWTWbq+FnrEH1FNanad2/dHiKeL5DtLfaVgr5SsfvZSSIqhICVStxNlR+g9Cd++3yOx
         WeLbCv1fgjps+rhErEoGHBh5GFAyjYs38D/GGmoZaf6JXCgW6HT04+N6DyZqwVGTrHoo
         r0WPbzTdSM1/Ll/BkkAksW9jlQbh21SIgVu2/JUl5QDtxX4X6EM/RUP4X+mGUPb7FhvB
         M20A==
X-Forwarded-Encrypted: i=1; AJvYcCXa+RApdh/B8o2S5CNEgELM25GigMVX5UA8m27F1Vgj1USVuZJ9K5Yg1eLUQ8fn6fUUOIjQB01KMYzhjSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEE0Q0++4Qgz5ffJVS3GGlm1SBQQo7OeoRhO6wLk+ZsmhqubXj
	Xm4NxSWkrHewhG2EauU2Y6BLToGPjYc66ssSfnaWcID8owvEfM06skPSI8ZwG6d7hTq9yRN9P5c
	nIHu/REsygppBt+YbKhFpGeB3ZfZSdZHLcnawduBVLiXUTvUgH0+xqD36a7cMODZlmsk=
X-Gm-Gg: ASbGncuuz7UvwQRqKXuetFrOhOYM4IrtEapcA7+PlzbD0IcrOXXEN9SUvq/rGxdKfhp
	0Zj2E6ZYEVDHkxUp1Td12kR4cx06PT7BdyAF3lvKetsK/DEtZa2ro4tebW59sLevqyAByebiiqk
	W/W83JxN7qcXMEiv9dY3fuKFEkO+daMewxL+M/k+P+Ef9gwgighvh4EkML/KZztSk/4hHhWBUYp
	aBD39HnrJa/2R3wSzXuWoSkCH24qyBuXdhyKIxF5YT7UtJCbDXYswFO7Xass9sqqyCAp3j/wkT+
	GY4XcHAUK/X0qyCvz5ZUmkCj5H/NASNCAtYAl6TzFBZxdceAOUzmNCxGgd85cn/t8E8Nq3oqSJK
	17GaF/N+is13yOD+ArViCOJ6X6ydEu1eMT6xYyNYOTxaIrXLZPi/HGK/y4GtQ
X-Received: by 2002:a05:6a00:600e:b0:76b:ecf2:7ece with SMTP id d2e1a72fcca58-78100fef9e8mr1637263b3a.12.1758781804354;
        Wed, 24 Sep 2025 23:30:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmlubtUqC/iUihYrvWOZ+ReF1mmWxGH49RoVao+QzbnBHYeUZnpiiDwovdcguzPsY8LpVphw==
X-Received: by 2002:a05:6a00:600e:b0:76b:ecf2:7ece with SMTP id d2e1a72fcca58-78100fef9e8mr1637224b3a.12.1758781803672;
        Wed, 24 Sep 2025 23:30:03 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:30:03 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:27 +0530
Subject: [PATCH v2 21/24] arm64: dts: qcom: glymur: Enable tsens and
 thermal zone nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-21-8e1533a58d2d@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d4e16d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=l4z_L_1xOpJQCbPnF-wA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfX1jCinrBNmIbw
 JnfPrCeQEDGGZjUmsxCtYm9LYJN6yiqxALJaRflTKYguWcDZfRdcRTOooMMskoWFKmky8oPyeRn
 bKH2E8WayWnrhxeQ6Rf95lQ3VinLVLtJKYQe+cwHhzzxqfy8wZMaccSLHG4R3eEj2cEJ19iwCyZ
 iF8xfjwYbIsGvBDyiwkA21GiSQ3pEZTOuBXQmn1sSmWC4AvVuHmpLSDf3QnmiWmwljS2ffrugpS
 SM86zxSByXJSe29GNlJ1u5sAdt664aV13bFvNddKDEqraME349Cz86Kfj0VxziCEOLIsi9oGhxo
 DJ1aGxVYxSZCEmP9xDZOXTidIN+/4/TPeuzw6Y4uqav9NowAJq09WLkUVOeyWRhscd4KJpg9qcD
 YfVYgsJX
X-Proofpoint-GUID: pZ7dEypyEFhy_hF7u-QRRynoztZnMMc3
X-Proofpoint-ORIG-GUID: pZ7dEypyEFhy_hF7u-QRRynoztZnMMc3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042

From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>

Add tsens and thermal zones nodes for Glymur SoC.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 1998 ++++++++++++++++++++++++++++++++++
 1 file changed, 1998 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 17a07d33b9396dba00e61a3b4260fa1a535600f2..986dc385200029071136068ab79ff8dd66d5284a 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -2790,6 +2790,134 @@ pdc: interrupt-controller@b220000 {
 			interrupt-controller;
 		};
 
+		tsens0: thermal-sensor@c22c000 {
+			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c22c000 0 0x1000>, /* TM */
+			      <0 0x0c222000 0 0x1000>; /* SROT */
+
+			interrupts = <GIC_SPI 771 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 861 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "uplow",
+					  "critical";
+
+			#qcom,sensors = <13>;
+
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: thermal-sensor@c22d000 {
+			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c22d000 0 0x1000>, /* TM */
+			      <0 0x0c223000 0 0x1000>; /* SROT */
+
+			interrupts = <GIC_SPI 772 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 862 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "uplow",
+					  "critical";
+
+			#qcom,sensors = <9>;
+
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens2: thermal-sensor@c22e000 {
+			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c22e000 0 0x1000>, /* TM */
+			      <0 0x0c224000 0 0x1000>; /* SROT */
+
+			interrupts = <GIC_SPI 773 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 863 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "uplow",
+					  "critical";
+
+			#qcom,sensors = <13>;
+
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens3: thermal-sensor@c22f000 {
+			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c22f000 0 0x1000>, /* TM */
+			      <0 0x0c225000 0 0x1000>; /* SROT */
+
+			interrupts = <GIC_SPI 774 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 864 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "uplow",
+					  "critical";
+
+			#qcom,sensors = <8>;
+
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens4: thermal-sensor@c230000 {
+			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c230000 0 0x1000>, /* TM */
+			      <0 0x0c226000 0 0x1000>; /* SROT */
+
+			interrupts = <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 865 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "uplow",
+					  "critical";
+
+			#qcom,sensors = <13>;
+
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens5: thermal-sensor@c231000 {
+			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c231000 0 0x1000>, /* TM */
+			      <0 0x0c227000 0 0x1000>; /* SROT */
+
+			interrupts = <GIC_SPI 619 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 814 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "uplow",
+					  "critical";
+
+			#qcom,sensors = <8>;
+
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens6: thermal-sensor@c232000 {
+			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c232000 0 0x1000>, /* TM */
+			      <0 0x0c228000 0 0x1000>; /* SROT */
+
+			interrupts = <GIC_SPI 620 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 815 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "uplow",
+					  "critical";
+
+			#qcom,sensors = <13>;
+
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens7: thermal-sensor@c233000 {
+			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c233000 0 0x1000>, /* TM */
+			      <0 0x0c229000 0 0x1000>; /* SROT */
+
+			interrupts = <GIC_SPI 621 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 816 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "uplow",
+					  "critical";
+
+			#qcom,sensors = <15>;
+
+			#thermal-sensor-cells = <1>;
+		};
+
 		aoss_qmp: power-management@c300000 {
 			compatible = "qcom,glymur-aoss-qmp", "qcom,aoss-qmp";
 			reg = <0 0x0c300000 0 0x400>;
@@ -4611,4 +4739,1874 @@ timer {
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+	thermal_zones: thermal-zones {
+		aoss-0-thermal {
+		thermal-sensors = <&tsens0 0>;
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+				aoss-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-0-0-thermal {
+			thermal-sensors = <&tsens0 1>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-0-0-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-0-1-thermal {
+			thermal-sensors = <&tsens0 2>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-0-0-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-1-0-thermal {
+			thermal-sensors = <&tsens0 3>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-0-1-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-1-1-thermal {
+			thermal-sensors = <&tsens0 4>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-0-1-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-2-0-thermal {
+			thermal-sensors = <&tsens0 5>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-0-2-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-2-1-thermal {
+			thermal-sensors = <&tsens0 6>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-0-2-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-3-0-thermal {
+			thermal-sensors = <&tsens0 7>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-0-3-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-3-1-thermal {
+			thermal-sensors = <&tsens0 8>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-0-3-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-4-0-thermal {
+			thermal-sensors = <&tsens0 9>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-0-4-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-4-1-thermal {
+			thermal-sensors = <&tsens0 10>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-0-4-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-5-0-thermal {
+			thermal-sensors = <&tsens0 11>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+				cpu-0-5-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-5-1-thermal {
+			thermal-sensors = <&tsens0 12>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-0-5-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		aoss-1-thermal {
+			thermal-sensors = <&tsens1 0>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				aoss-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpullc-0-0-thermal {
+			thermal-sensors = <&tsens1 1>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpullc-0-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpullc-0-1-thermal {
+			thermal-sensors = <&tsens1 2>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpullc-0-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		qmx-0-0-thermal {
+			thermal-sensors = <&tsens1 3>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				qmx-0-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		qmx-0-1-thermal {
+			thermal-sensors = <&tsens1 4>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				qmx-0-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		qmx-0-2-thermal {
+			thermal-sensors = <&tsens1 5>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				qmx-0-2-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		ddr-0-thermal {
+			thermal-sensors = <&tsens1 6>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				ddr-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		video-0-thermal {
+			thermal-sensors = <&tsens1 7>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				video-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		video-1-thermal {
+			thermal-sensors = <&tsens1 8>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				video-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		aoss-2-thermal {
+			thermal-sensors = <&tsens2 0>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				aoss-2-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-0-0-thermal {
+			thermal-sensors = <&tsens2 1>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-1-0-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-0-1-thermal {
+			thermal-sensors = <&tsens2 2>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-1-0-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-1-0-thermal {
+			thermal-sensors = <&tsens2 3>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-1-1-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-1-1-thermal {
+			thermal-sensors = <&tsens2 4>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-1-1-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-2-0-thermal {
+			thermal-sensors = <&tsens2 5>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-1-2-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-2-1-thermal {
+			thermal-sensors = <&tsens2 6>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-1-2-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-3-0-thermal {
+			thermal-sensors = <&tsens2 7>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-1-3-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-3-1-thermal {
+			thermal-sensors = <&tsens2 8>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-1-3-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-4-0-thermal {
+			thermal-sensors = <&tsens2 9>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-1-4-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-4-1-thermal {
+			thermal-sensors = <&tsens2 10>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-1-4-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-5-0-thermal {
+			thermal-sensors = <&tsens2 11>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-1-5-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-5-1-thermal {
+			thermal-sensors = <&tsens2 12>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-1-5-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		aoss-3-thermal {
+			thermal-sensors = <&tsens3 0>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				aoss-3-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpullc-1-0-thermal {
+			thermal-sensors = <&tsens3 1>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpullc-1-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpullc-1-1-thermal {
+			thermal-sensors = <&tsens3 2>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpullc-1-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		qmx-1-0-thermal {
+			thermal-sensors = <&tsens3 3>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				qmx-1-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		qmx-1-1-thermal {
+			thermal-sensors = <&tsens3 4>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				qmx-1-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		qmx-1-2-thermal {
+			thermal-sensors = <&tsens3 5>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				qmx-1-2-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		qmx-1-3-thermal {
+			thermal-sensors = <&tsens3 6>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				qmx-1-3-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		qmx-1-4-thermal {
+			thermal-sensors = <&tsens3 7>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				qmx-1-4-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		aoss-4-thermal {
+			thermal-sensors = <&tsens4 0>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				aoss-4-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-2-0-0-thermal {
+			thermal-sensors = <&tsens4 1>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-2-0-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-2-0-1-thermal {
+			thermal-sensors = <&tsens4 2>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-2-0-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-2-1-0-thermal {
+			thermal-sensors = <&tsens4 3>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-2-1-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-2-1-1-thermal {
+			thermal-sensors = <&tsens4 4>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-2-1-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-2-2-0-thermal {
+			thermal-sensors = <&tsens4 5>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-2-2-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-2-2-1-thermal {
+			thermal-sensors = <&tsens4 6>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-2-2-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-2-3-0-thermal {
+			thermal-sensors = <&tsens4 7>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-2-3-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-2-3-1-thermal {
+			thermal-sensors = <&tsens4 8>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-2-3-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-2-4-0-thermal {
+			thermal-sensors = <&tsens4 9>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-2-4-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-2-4-1-thermal {
+			thermal-sensors = <&tsens4 10>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-2-4-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-2-5-0-thermal {
+			thermal-sensors = <&tsens4 11>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-2-5-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-2-5-1-thermal {
+			thermal-sensors = <&tsens4 12>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				cpu-2-5-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		aoss-5-thermal {
+			thermal-sensors = <&tsens5 0>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				aoss-5-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpullc-2-0-thermal {
+			thermal-sensors = <&tsens5 1>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpullc-2-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpuillc-2-1-thermal {
+			thermal-sensors = <&tsens5 2>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpullc-2-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		qmx-2-0-thermal {
+			thermal-sensors = <&tsens5 3>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				qmx-2-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		qmx-2-1-thermal {
+			thermal-sensors = <&tsens5 4>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				qmx-2-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		qmx-2-2-thermal {
+			thermal-sensors = <&tsens5 5>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				qmx-2-2-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		qmx-2-3-thermal {
+			thermal-sensors = <&tsens5 6>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				qmx-2-3-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		qmx-2-4-thermal {
+			thermal-sensors = <&tsens5 7>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				qmx-2-4-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		aoss-6-thermal {
+			thermal-sensors = <&tsens6 0>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				aoss-6-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		nsphvx-0-thermal {
+			thermal-sensors = <&tsens6 1>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				nsphvx-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		nsphvx-1-thermal {
+			thermal-sensors = <&tsens6 2>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				nsphvx-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		nsphvx-2-thermal {
+			thermal-sensors = <&tsens6 3>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				nsphvx-2-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		nsphvx-3-thermal {
+			thermal-sensors = <&tsens6 4>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				nsphvx-3-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		nsphmx-0-thermal {
+			thermal-sensors = <&tsens6 5>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				nsphmx-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		nsphmx-1-thermal {
+			thermal-sensors = <&tsens6 6>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				nsphmx-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		nsphmx-2-thermal {
+			thermal-sensors = <&tsens6 7>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				nsphmx-2-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		nsphmx-3-thermal {
+			thermal-sensors = <&tsens6 8>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				nsphmx-3-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		camera-0-thermal {
+			thermal-sensors = <&tsens6 9>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				camera-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		camera-1-thermal {
+			thermal-sensors = <&tsens6 10>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				camera-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		ddr-1-thermal {
+			thermal-sensors = <&tsens6 11>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				ddr-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		ddr-2-thermal {
+			thermal-sensors = <&tsens6 12>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				ddr-2-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		aoss-7-thermal {
+			thermal-sensors = <&tsens7 0>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				aoss-7-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-0-0-thermal {
+			thermal-sensors = <&tsens7 1>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpu-0-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-0-1-thermal {
+			thermal-sensors = <&tsens7 2>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpu-0-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-0-2-thermal {
+			thermal-sensors = <&tsens7 3>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpu-0-2-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-1-0-thermal {
+			thermal-sensors = <&tsens7 4>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpu-1-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-1-1-thermal {
+			thermal-sensors = <&tsens7 5>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpu-1-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-1-2-thermal {
+			thermal-sensors = <&tsens7 6>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpu-1-2-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-2-0-thermal {
+			thermal-sensors = <&tsens7 7>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpu-2-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-2-1-thermal {
+			thermal-sensors = <&tsens7 8>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpu-2-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-2-2-thermal {
+			thermal-sensors = <&tsens7 9>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpu-2-2-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-3-0-thermal {
+			thermal-sensors = <&tsens7 10>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpu-3-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-3-1-thermal {
+			thermal-sensors = <&tsens7 11>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpu-3-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-3-2-thermal {
+			thermal-sensors = <&tsens7 12>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpu-3-2-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpuss-0-thermal {
+			thermal-sensors = <&tsens7 13>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpuss-0-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpuss-1-thermal {
+			thermal-sensors = <&tsens7 14>;
+
+			trips {
+				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpuss-1-critical {
+					temperature = <110000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };

-- 
2.34.1


