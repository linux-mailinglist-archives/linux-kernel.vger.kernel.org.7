Return-Path: <linux-kernel+bounces-831817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0343B9D9E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0271819C01E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DFD2EC569;
	Thu, 25 Sep 2025 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aSBLA5FV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E822EB87C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781786; cv=none; b=HavJVKqttfQOP5QgFIo8npLdb+Eht6EYln+4IQgmMsLQ1EXPKitixfYdfJcEJNCrwaxWBEy5Vd8PdU9D3MhmzW8iBdI7x51lTGc/+EpF6GHcfkPvdBg9KFdqk094zAOMUwgZhL9eXeZ78oULOyh6JSKFlAe4kZJCdBh0W+f6U/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781786; c=relaxed/simple;
	bh=OV/aaJzgqGLB3+eDxXdtVetaq7X7QyfyLBw2k9nuYD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkRWEE4SaVwwWb7pai1FT5/nbQ++SoMRrmh0ozSRwBMX7Lcc1pT+WXwBLQTGQjtKr6hWbpftuhMKNnRB6jC8ffnlmRprEbwNDrfEa8RUVo/BRzw4r4LkZjBr8cwNOdPw2HosBMlmcPZ9x8Lyr5BPe9fbQSonCERyXVOSWjpdnds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aSBLA5FV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P03wmq027848
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k69QmMaDJytSlpNex0Fnt5aK4VFtTpI8VjRIFrBY1m4=; b=aSBLA5FV3TyJ4zm9
	OfX7C/kXrhMdfiSrhOoExIkF3KseaFR9db5egXYQNXxoFHpGkyyvZy9N5L+zf6Pc
	GFVpe2HpQnFWXPZRgSCACZSdgJKBm4+tfSZsJLAJxo5R83dtiEJKyrRBgQq8GJMx
	O+WtKYXVs//QZeRtGWcOU/GBCKZHrz9SHwlzaAZN61cHFiwbxQ5OIMupm7cTCLsM
	btWpJOZNEWw+LdaClJWf1d3d9oP87InXC8g1snlL4O5NmOtk2qpVq30N6s7Hvkxo
	ZJRXrXeb5k10TqDckI2fjsvt7g7f1bFli/a/nDJwgsdErA1elsHK1bn0flcJn4iS
	AGUjnw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnycd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4f87c691a7so1019665a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781782; x=1759386582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k69QmMaDJytSlpNex0Fnt5aK4VFtTpI8VjRIFrBY1m4=;
        b=FSGszHOcOYGrsZRbpvC61r7I7P/Ihy2D3M7DGt5Sj6kCt1z6gIFeDOYxgnI75HFAiB
         qUyukC+NBFxaZvyICbEtdokySr5q0sIESlc4+qjuOlj1radAmL+jb4xSXzMaJryLH11/
         FXju+DEuB7TGCbUq5AlVCJBuqP8gTPTUW5DixEMR+HlelOiLhKKxKYaJ2IvjglorTI+p
         DsTity/RaAqStkPciU6V50W0Q9j2MgC2QkX/dfcFGUxgJ73QTwU/PCXN+L+N774qArcI
         of0NS1Vwjey+sGWpjygfkExR4MV1LK4ekw3d3DMeWu49FVQGRcEIOdB3fVnuT9wWsICp
         qxYA==
X-Forwarded-Encrypted: i=1; AJvYcCXVFo7NIbUS/HfFD+MOtNvJ/xd7KScLO7OZWTCE1kKiY1LVzd1c0Oq22Vtd03ywCORAvQN9+pdGcFx4cPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUkxVSIBPugfmMa03kyhvuaalu5MQ9/sT/J58HQzm06QlcRtAc
	bcyAfX07nAxBkXZL7ZaxlwgGI5YMeqg7jwpCYW7A6p4ZBga4GGyb+YguZLX0oCg2J+I7mgWzalL
	eWhoa5D8LjNXQL3PKcq9BaEVwJS3Qw2M5Dfcopu5key9pJUYF+OkuR1BErcqIPBfVzhI=
X-Gm-Gg: ASbGnct935MiadzxQnJKsSXuT/Jb6cqqZk+Mtd3vq6Y0mdx8lyAXmil0w9vCCwC+set
	/HNOiGeI0DNXZ/m79SK8ZNFNbrc66Z7n1E5zxvMoTN4iNVqU9JvNNuLMRD+8BXZUvDSLWvNXbs9
	xZY+YekbLF2J+M7l1kHZdI0yk1yjwTMHYHkhnEi41CEcTyB2Z3SvCj+TueCutk8cK/Wt6qEFtt2
	dcN880a412OouXPjoTN5v6GaBPoi6CWdiSIxh+6qkuIdIDL3kGsQnZ2sVrttUJEOFIHeeapeSZm
	2uPoIuWeBHCEFya5bFqR7kgnBahcr+q6JutqPxGzBTfl7zKC3NJFM/PBFCuj/ed15mWydn1mnZ9
	/aSwPr5wwyaXJU0A1v1bMhIaZ8zlg80Fg/zTfn3P6tTpbFNQ3p9eAKs4mOcCb
X-Received: by 2002:a05:6a20:7347:b0:2b7:949d:63da with SMTP id adf61e73a8af0-2e7c79c5b05mr2873387637.18.1758781782100;
        Wed, 24 Sep 2025 23:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEm9E38Wgj5S9u3TjDbt+GZyj5st0rxcpU/9nw8YpZ3MxL8wwmeQznljBNiTQAgW5yYm4HrQ==
X-Received: by 2002:a05:6a20:7347:b0:2b7:949d:63da with SMTP id adf61e73a8af0-2e7c79c5b05mr2873352637.18.1758781781689;
        Wed, 24 Sep 2025 23:29:41 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:29:41 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:20 +0530
Subject: [PATCH v2 14/24] arm64: dts: qcom: Update the pmh0110.dtsi for
 Glymur
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-14-8e1533a58d2d@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d4e157 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=EOUZnPL1Ke5HISHMaDUA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: nOoUvWwDHt2N6SdJmBdTncbrfmpHArsY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX5lCf1lL+tVvL
 UYuDYSuc/S/ZICGH3fTU+2VPXqLC4RLVDAN/al7K0KW7Doo1gVWzEyTXv14L7bM7zWiJPO4F2NX
 MBoW53camqbqD7jUlnyJXzDYjfhZxrG9kxkaRkW2Ka9xNtdp20tHC1WlECC0QgheMoGNz3GUQQp
 /Oi/0cB+7aaEebw6J2LjPbo064DOH7QhuscoeN009VZTKjoSheLST1O02FesJ2tE/V8ody0zutj
 aZ8myCLVGFGLjUsiZqU2GB9wbpu7mAuwT8kMnVYrY6cHyhU6EA0Xe1BM/AxyzZqlda3h5zw9FpQ
 zQgVuyMXM628mUgUSBxHEt9eFaNVTpRF97wULr+Ps44E2D/vOlenGNAZBWmS3cyMZz09HqKRaho
 OUx0AU0z
X-Proofpoint-GUID: nOoUvWwDHt2N6SdJmBdTncbrfmpHArsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Add multiple instance of PMH0110 DT node, one for each assigned
SID for this PMIC on the spmi_bus0 and spmi_bus1 on the Glymur
CRD.

Take care to avoid compilation issue with the existing nodes by
gaurding each PMH0110 nodes with `#ifdef` for its corresponding
SID macro. So that only the nodes which have the their SID macro
defined are the only ones picked for compilation.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/pmh0110.dtsi | 66 ++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pmh0110.dtsi b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
index b99c33cba8860f1852231db33a127646c08c1e23..4a5c66e5c9fbc35cedb67601f4568844dc41fbea 100644
--- a/arch/arm64/boot/dts/qcom/pmh0110.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
@@ -7,6 +7,8 @@
 #include <dt-bindings/spmi/spmi.h>
 
 &spmi_bus0 {
+
+#ifdef PMH0110_D_E0_SID
 	pmh0110_d_e0: pmic@PMH0110_D_E0_SID {
 		compatible = "qcom,pmh0110", "qcom,spmi-pmic";
 		reg = <PMH0110_D_E0_SID SPMI_USID>;
@@ -31,13 +33,14 @@ pmh0110_d_e0_gpios: gpio@8800 {
 			#interrupt-cells = <2>;
 		};
 	};
+#endif
 
+#ifdef PMH0110_F_E0_SID
 	pmh0110_f_e0: pmic@PMH0110_F_E0_SID {
 		compatible = "qcom,pmh0110", "qcom,spmi-pmic";
 		reg = <PMH0110_F_E0_SID SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		status = "disabled";
 
 		pmh0110_f_e0_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
@@ -56,7 +59,9 @@ pmh0110_f_e0_gpios: gpio@8800 {
 			#interrupt-cells = <2>;
 		};
 	};
+#endif
 
+#ifdef PMH0110_G_E0_SID
 	pmh0110_g_e0: pmic@PMH0110_G_E0_SID {
 		compatible = "qcom,pmh0110", "qcom,spmi-pmic";
 		reg = <PMH0110_G_E0_SID SPMI_USID>;
@@ -81,7 +86,36 @@ pmh0110_g_e0_gpios: gpio@8800 {
 			#interrupt-cells = <2>;
 		};
 	};
+#endif
+
+#ifdef PMH0110_H_E0_SID
+	pmh0110_h_e0: pmic@PMH0110_H_E0_SID {
+		compatible = "qcom,pmh0110", "qcom,spmi-pmic";
+		reg = <PMH0110_H_E0_SID SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		pmh0110_h_e0_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <PMH0110_H_E0_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmh0110_h_e0_gpios: gpio@8800 {
+			compatible = "qcom,pmh0110-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmh0110_h_e0_gpios 0 0 14>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+#endif
 
+#ifdef PMH0110_I_E0_SID
 	pmh0110_i_e0: pmic@PMH0110_I_E0_SID {
 		compatible = "qcom,pmh0110", "qcom,spmi-pmic";
 		reg = <PMH0110_I_E0_SID SPMI_USID>;
@@ -106,4 +140,34 @@ pmh0110_i_e0_gpios: gpio@8800 {
 			#interrupt-cells = <2>;
 		};
 	};
+#endif
+};
+
+&spmi_bus1 {
+#ifdef PMH0110_F_E1_SID
+	pmh0110_f_e1: pmic@PMH0110_F_E1_SID {
+		compatible = "qcom,pmh0110", "qcom,spmi-pmic";
+		reg = <PMH0110_F_E1_SID SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		pmh0110_f_e1_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <PMH0110_F_E1_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmh0110_f_e1_gpios: gpio@8800 {
+			compatible = "qcom,pmh0110-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmh0110_f_e1_gpios 0 0 14>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+#endif
 };

-- 
2.34.1


