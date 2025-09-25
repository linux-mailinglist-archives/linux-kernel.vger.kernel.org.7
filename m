Return-Path: <linux-kernel+bounces-831844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7697CB9DAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E1B1888F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39AF2F8BE6;
	Thu, 25 Sep 2025 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WfpX62q/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF52F7ACE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782044; cv=none; b=JgXHHQn0wRHhtbJi0ZwglwX3tx/yE1AIpP+Bob02XSGHj50mVPyfSabBiGBkr4a6mGSDcUd+0o/JZ1sEpvRzDbo0M+M0amNsEkWcI+Y9yLEVFUvxsYGMjzcUDx7G2CeIECUODQzZZoT0gMuul3PhQ9/WEerhqOcnkgnBelVR7Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782044; c=relaxed/simple;
	bh=RDdBDErVPYkb7kQ40hn7vPiyirE4liN5DKCLZ9h9OKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FgXyvD265/h5jXyl99VvvKExqny1VD/ZBSx5h+uKqwC5sFovBAgKOLiIFQZgiZA725k7w3VZOWvdPz5bEDH04DuEH3NaFrtmHm/RmwN1LgJ14YBIa/5nbpvmPcehU9EUHK92iDxf9UE6WUvIlcUA/j373XnE7abUo3a5RdXgK2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WfpX62q/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0vIpS019952
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KPvdBTUqrNUETXTQBR3pTDVkd6wGbjn3B7OmL+KStu4=; b=WfpX62q/4GsiIfut
	uE+xpwlbsmoO9dtOoufieNFOXw//7IikGiemx9BQPxHgigzMzLyx6zesycWP/P7F
	j3qk0mmWUcd4jPouEqfBuRiUwvLfFeAoVayaihGH2UxyukRLbprRAeoUqUpDyG+R
	N+Q07r6V21Y8Z0Ir/KBuNxkEM7ygWmEXtlxHoD0va9KWYmTi6kkl3kYblTChTWex
	eYNBWr5xoj0+D2m8l2QP0tkgWjx5Gp392u7yjjGJsaw4xAf/wgVD9hoIajZZmnLb
	t1mmMxxLQA+Qy6PTUY91wnsD+Joi4GjqOHAlk7FFWCdZlRxbbF5xAnhgakVX3W9n
	Si/+/Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpe08xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2681623f927so6682285ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782042; x=1759386842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPvdBTUqrNUETXTQBR3pTDVkd6wGbjn3B7OmL+KStu4=;
        b=tsvsF3ZZaRhLjw9OlZ/9QedHS08q7ABuTLzUYUZ3T9tcAWd7QChAA1PT9x9WI5Kry4
         0NvusWVjvx2Va7gKhnhU5LtuLEJhXNiSrwbQbXWx5dXm4/miPftOtoVN4gU/T0yoyhfH
         kN3dZfrt31aRKMZstyMSNbmbNqyWbSMH4uz08QVzfrkE/GdUSTnENnpNw1poqISty0Os
         7JMHKR+ioo8Z14PhDHHGZltOM9HB8oiAsfT9x01/0yRS9x9F64cexDDyEbd9DYqMjh9e
         prIpn28d9k1sLLnl2wzD0OuGbIbJ1wikzCawI0GPp41zBDK8Am4fKV5wL9keC3LJWjyD
         3vLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlYyenKneofJ/C+s4BUX0/DxD2zT7ta8heWDPoZuuHmfvAro+JSFXq0zJf1p8VgXC85snwZwiOhSMgXtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiIExQsM0M4J9irBYGp6da5e3JTQYu/uQi+asM5+Xv9zf+r6Jg
	3dIQf+4YLn6m4q0QCQDytf3MhlFjrHBIbpm7ARCmZLWVwS/0+vzdgmLKlI79VvkUflYPf14jCCW
	je28/DrORnWzQywaJPHfvevuvpdJU2Lfx2nbg36jlba4STLPJUm2zknNAM0S6VFz6IZg=
X-Gm-Gg: ASbGncsQ+NvxgSL1l8hOOlJCqsROgombAsTn2k6tHfk819yqKGENyI6ctuFBUa7UHc8
	Iq/IcwXLIpjTaKc7Haer0ScIYayJXbd7Vx1BbV8eYm2bY9Ds8zWta4jBXE99l0D3PY1AvX4YPkG
	3Ey8rNwuN3LjP2Dy0oZvV7gxG7l6NMeJcQgCztp6ejX0eT5dSGH21SxWmcTYkEeh7BD4490lR5h
	N64rSfKfh1pfp9tQMovgeAyqKMzKEjYx8N6nYAz+JvleMtHzjlXkakRymdW3cC5tZFEo2RJuZ8t
	Ss3BGfU/ZAHc5pfpJY6a+2Nn1tpsQqsLCubAr+OLuZvhhY3CJaWn0zS+eE4cGuE7YGTzwotwB1z
	zhvK+WCqQOPpg7453D+0NPmJsgF/hXCX8k7eMy/Xr86dHJt8hWfbwn0j0LWan
X-Received: by 2002:a17:903:320e:b0:267:c8d3:531 with SMTP id d9443c01a7336-27ed4a315c1mr26738655ad.25.1758782041828;
        Wed, 24 Sep 2025 23:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQgcgZDU2SunFVKkD0cHmqO8lPq32ZQY5YtfTzu7YAWS30H85HYs0CKzASqq3pi5ekw9rxsg==
X-Received: by 2002:a17:903:320e:b0:267:c8d3:531 with SMTP id d9443c01a7336-27ed4a315c1mr26738365ad.25.1758782041421;
        Wed, 24 Sep 2025 23:34:01 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:34:01 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:21 +0530
Subject: [PATCH 13/24] arm64: dts: qcom: Update pmh0104 dtsi for Glymur CRD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-13-24b601bbecc0@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 4BGY-fDUk6_oye2EBVlUUGIwLnqehhgB
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d4e25a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Bl1eJC4Zh2N44W0__HIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 4BGY-fDUk6_oye2EBVlUUGIwLnqehhgB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX+FlFdDpTMp9U
 5cZWhfIlISztjiiqhkoAhGu2DJ9Gy6FXZrTyvRTuSIy90dM1tzuPApB+JmcdjVy2Wh8F33ayxC4
 0oo/KezeP3gw/xY0S9Z/rMH2eewVG9wlLahkHuK0rfOCsdGYIN9mTVH8oRzIk66bKu0xOJ/m4JT
 QPUydnTuqhgeK6XqXLUNFU0sMEQSgp8A0D86DMOvIpWBQtCTJ1ftKs+b7TykTil+nzo8VinPRLr
 manQeZyuG1c7uN6MdhQpnma2EPuQEMDZrUZDVpr6mozwjV76s4izH7vmOMQIWGZM7Gicyc4NZkD
 AZ8TGJouvCuU4Bff8R/lyCjOUXh9W6z4YnO2b33dwtS0Rn+Vf5Hv9XczgmRBP4qClzdKNk4cJh7
 6quu9WNM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Update the pmh0104.dtsi to include multiple instances of PMH0104
DT nodes, one for each SID assigned to this PMIC on the spmi_bus0
and spmi_bus1 in Glymur CRD board.

Take care to avoid compilation issue with the existing nodes by
gaurding each PMH0104 nodes with `#ifdef` for its corresponding
SID macro. So that only the nodes which have the their SID macro
defined are the only ones picked for compilation.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/pmh0104.dtsi | 84 +++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmh0104.dtsi b/arch/arm64/boot/dts/qcom/pmh0104.dtsi
index f5393fdebe957ea0caf4bbc16117374b4759bda3..d3ea7486d842ec813a79268fc1466e1513426d78 100644
--- a/arch/arm64/boot/dts/qcom/pmh0104.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmh0104.dtsi
@@ -6,7 +6,63 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
+&spmi_bus0 {
+#ifdef PMH0104_I_E0_SID
+	pmh0104_i_e0: pmic@PMH0104_I_E0_SID {
+		compatible = "qcom,pmh0104", "qcom,spmi-pmic";
+		reg = <PMH0104_I_E0_SID SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		pmh0104_i_e0_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <PMH0104_I_E0_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmh0104_i_e0_gpios: gpio@8800 {
+			compatible = "qcom,pmh0104-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmh0104_i_e0_gpios 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+#endif
+
+#ifdef PMH0104_J_E0_SID
+	pmh0104_j_e0: pmic@PMH0104_J_E0_SID {
+		compatible = "qcom,pmh0104", "qcom,spmi-pmic";
+		reg = <PMH0104_J_E0_SID SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmh0104_j_e0_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <PMH0104_J_E0_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmh0104_j_e0_gpios: gpio@8800 {
+			compatible = "qcom,pmh0104-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmh0104_j_e0_gpios 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+#endif
+};
+
 &spmi_bus1 {
+#ifdef PMH0104_J_E1_SID
 	pmh0104_j_e1: pmic@PMH0104_J_E1_SID {
 		compatible = "qcom,pmh0104", "qcom,spmi-pmic";
 		reg = <PMH0104_J_E1_SID SPMI_USID>;
@@ -30,4 +86,32 @@ pmh0104_j_e1_gpios: gpio@8800 {
 			#interrupt-cells = <2>;
 		};
 	};
+#endif
+
+#ifdef PMH0104_L_E1_SID
+	pmh0104_l_e1: pmic@PMH0104_L_E1_SID {
+		compatible = "qcom,pmh0104", "qcom,spmi-pmic";
+		reg = <PMH0104_L_E1_SID SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		pmh0104_l_e1_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <PMH0104_L_E1_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmh0104_l_e1_gpios: gpio@8800 {
+			compatible = "qcom,pmh0104-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmh0104_l_e1_gpios 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+#endif
 };

-- 
2.34.1


