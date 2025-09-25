Return-Path: <linux-kernel+bounces-831852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF814B9DB58
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E984C45A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550DD2FC003;
	Thu, 25 Sep 2025 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C9X9GSR8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D01C2FB60B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782074; cv=none; b=TJQJuK15XTydtIdbb7hFnmx9zpIC2p+S2DNRUcJIdpXa9qDSycy7gtSEGUiNJpDWQ0DwfZqzUcrCRj/rZwKlONXvJLfcDKXDabSghRh8X2TGV0lKoUURhvwi94jVeGzf+N/6IiVRdxFBpmzMH/gEoahzeNlEopojCmFW8IxnWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782074; c=relaxed/simple;
	bh=xY45EdffrBMLQN3eDVB38ZJyhhLfVOUzPeIepRrp9PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N4Cut4U007gMUl1S3EOflLqunW0ojVzs/oVER09NboatMGJCSDmU/QEoV/nClxo409NaJdWjtUnG0fF6r88TQbnVWx/LXN7BrRZVgqBuCra74QJC2/pxwLPhAcXe/JGfv743iXOasRzqpVGx4zegqH54RD8/lDuDqQpTr/AUSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C9X9GSR8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONwXO3001842
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W/gQlYDqE+6SroS9br906aV1Ete64sbGoTONP1SpgC4=; b=C9X9GSR86qn6b3uI
	3VpHd8o2FEaAQzEsXwgp5NzMFsCOj3CYZHh8Lkb6XsP2BOl6q85TyRH4evN4OGkL
	bWesPNCERx+LiludiB2oKzS0QxuAdWLvJUxRpeW/9xZPemxgQckZh9taMl9xQZGe
	Cr2UzBQwDUT4nM/Fjqi1MMc1Ipqtx0nMLR8pI+fsa+RsJDNeQmAxvwv6MlZFBuId
	G/TncMDpYJa1JgRwU6VETSwyUL5sFzPjYo/pnEwJwhtMzJMvX9izaKD+RO9vaLRm
	VmQZFgrmhSCwQq6fIngc41RPpeGlq1TdDyJ07nxMq5F2Zi5MftNuKrW/lYrHC5d5
	SAtxHw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98q12h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:30 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4f86568434so447878a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782069; x=1759386869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/gQlYDqE+6SroS9br906aV1Ete64sbGoTONP1SpgC4=;
        b=SnV2rNuX0rww8yACfyxf/1MBHyEjDTo4WFiiLlqWbsIJUo3WWEt2zNS5Ig6L3s39ep
         9S6ppQneZtnNoGiOLWB4pP2XjPqH0LN809ygmUTdAAO0g4uZZvdlHX3pjYvzup9RePvY
         kUG7LqFzWe6yqUpFxNXES+MS6S/FbYP1KqHwMxcHyVjs7pMAH31bKSZBrkDlOXyyl7T9
         ShSsIflVfjs8TvKOwJfg7Bk5NEb2S8qt2PKsieO5sXXpEVi2Yp5Xkcpobcb+oKn1c59+
         zIyRiZLimbpARK8u3k2rXbMeH/JEfvP+srO7wnw9SM0/KAFHmBMGQSv6tzn70POqCF/k
         un8w==
X-Forwarded-Encrypted: i=1; AJvYcCW7479/TBv3pMGucLArDzZjXDOwsGxbke/2uhXopX0JCft6fkDd9z8I314qlcUbLJ1CTdvxNdkxsIzyqzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGAAmj8PgQMbgeQKx1ZKTw6mQL3u3UQk1Ll0anILW19qdODHB8
	OOHC1xcdfKq7+1e2nF97FPNzcpRMZF2WzIBrmtMdNq/0cbfSSUErTEthhy6YUH1Fu3lUQJMMCpX
	elZK/knYAXiqXx5ZWmTmC/iWw09zFrcAJ6rHE/P5Ji04JJgfSOcG1hwqjs7Dlr8HKXOQ=
X-Gm-Gg: ASbGncsaqP7FDjIsDFUS79KZgoHgoGtHnHjpYYjsB6/50uyDNGdfaz3RstGg1h/Jg3U
	Wjv/ub+V0Wo/Pp4R+1hKp2c1gG3FOW2XglUuPfzNHj5hTtxUQQJPWCrTTXgGdDc6c5tUcS2c0z7
	hNLGX2ZTPy7d/OtVPsl6nT/aQX0eYEVAjIVWrK28GZTM1HOml2N9KcZJaDiNNaiuYhdMFPwra37
	OuOInWP6zB+PagsP6HcTyfn4hNqwiIiYWTXMa/JIEyw9ltXoJSEObrRgNeBtn0D1zjY83iXhARc
	ID8i6Xf5Koq17Lzasj18HE8AJOPitQqzP1MYtCD4bnsvKbBxnBwilUKoX0VNwA5gySfhdZGikIR
	XLUKcK9ZwS6UMLeLrFD4o8ri5ODnlOUv7wr7nkYBVLBizHUjAnmzo0t8ya/O6
X-Received: by 2002:a17:903:1a43:b0:269:8072:5be7 with SMTP id d9443c01a7336-27ed4ab368fmr23764945ad.56.1758782068169;
        Wed, 24 Sep 2025 23:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENFBnxpD0DWLQRStVU1Z0hHXFOdPlHVifb79LouVrmIW+2J+KcxDkF6i0W59n+O9VAFiveww==
X-Received: by 2002:a17:903:1a43:b0:269:8072:5be7 with SMTP id d9443c01a7336-27ed4ab368fmr23764525ad.56.1758782067448;
        Wed, 24 Sep 2025 23:34:27 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:34:27 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:29 +0530
Subject: [PATCH 21/24] arm64: dts: qcom: glymur: Enable tsens and thermal
 zone nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-21-24b601bbecc0@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Nyp6i7m6DXNjYEKKkTgORw7uZNp2LWWQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX1QnI9z3GqT2V
 VFDwgNhyrjCVoT+KmHpaNwe6cE2bvkSfRKRuzJ6YqMtvI3l2HVL9xLJlv9vYoY7MfKBh6MB64rD
 P+mX8YKYZKg77fDkWg/lbbyxhYNNnjRoH3T8Y8O7PkQUXe+WckhmFJsgeXXppKCWHvsztoLv3dj
 qlM3pWV3QGpYTW2uHqK8LiSb2PdM/S69ia4a4vm8ho5HqD3DqF0JbnQ6lxMfcmjneAJMXTPsjL7
 jw8zkGtVH0FXXzomEUEviC2oe7tuxgS42WGcH+1gM2qIp1r6QOKq1bS4Y9+0m5Ah3uqpASO7jAM
 lJQw4C6gKSi8IFnaBtLu2Z4UQcXUfboaoc4VbZqZH0M1twzpN1ZDjCQJfyxJOjxy6BQOEy2w3Pr
 AmBcrm1J
X-Proofpoint-ORIG-GUID: Nyp6i7m6DXNjYEKKkTgORw7uZNp2LWWQ
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d4e276 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=l4z_L_1xOpJQCbPnF-wA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

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


