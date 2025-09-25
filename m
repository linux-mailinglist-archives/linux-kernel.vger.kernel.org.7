Return-Path: <linux-kernel+bounces-831812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F79B9D9B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2581BC35EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910962E9743;
	Thu, 25 Sep 2025 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I0LFLVex"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B3F2EB5CF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781772; cv=none; b=mZNN43tCMDZ4GWhI+fUG5d9CfgnX8qQH+2FR+GK7NgH69BUvixf1sH3hvh8J9oEqEUlXpmkCDEg5x3uR+z9RmJGbbpXe39Wcf01s5zs+RNpmcSaqVgtXHZvcnXPdiHTU+LQnGuxBf0UsRU1yXqRSQj6rzQYnzpPXpp6SyI6CQSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781772; c=relaxed/simple;
	bh=Gx7LAj1bLHkM3ae/ars2GWKLPfoM+orSucVr6r8Phes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OSEPBAL8KL2seSyL+83+Q7zXgOiWnuzrEqv/nSh6JWBOR/mo120cdvWKKL3pIB3bCh1RIud3NN7R5AtqA8F48eUx/ITHNXr/Fzg0zxMf/0Doej1Z0nuDX4LlezWrUg8SyOXmfNXKFzBqS9MVJ1D3fOtemoW5NdVKIrSw8ttC25k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I0LFLVex; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1WAFd001919
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1fmqxKh+jzkDMKKYvFGikJmfoa8mVGElYbYaFr43cL8=; b=I0LFLVexvPXJHQsu
	lA/Gk4HG1mT7VAMuDdinoBZG2o6PLRsPeVaRT32ZL2REb7//SC0JSfnXQ24cIpOQ
	cUrC6/EDYzWjFy1aHT5PO0k1FzAr01rb3a5KmWdT9oSy/70l9phzmXk7bmyBc7mC
	X/U7p88QkUiLcp3sYMFc4vWeTw6HO/zzRE8FiyypbHiQm1tIflAPxxhCALtCItDU
	4FC8QqAUrZDifCB0ReDLfytoEwhCVnVzJyQRpicnmnGoh6d352D67kWsYEZeWALd
	zJDtbUbLlDR9UJ6F8ErZYbuVneYhARpmWPbkW3h9q9UyLYpafhtvK7iJ+ZPc6+er
	FxdzTg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98q0eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:28 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77f18d99ebaso527532b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781767; x=1759386567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fmqxKh+jzkDMKKYvFGikJmfoa8mVGElYbYaFr43cL8=;
        b=NloRaBdptMNNFuid7Q2dAwy3jHkKoT+OF6YZ1G0dCVNfYzS6MdD6csncI8xfljGs3I
         +Vbmx0HmSTQlugDAF7Lyi2Cn4pz981GIf3x0iZQmxdLTjRHUDfhLiYK/9FYT/NKKow40
         rXgyJFK2BakaBMBau33PFu9St9377Hlja75wQzCDzuP/TjUqDrVmr5sopPMsI3TSJD31
         rAVpdsH302h56z6raCo9gqsECUhX7XnBKT6wHFQ0D3NtebIipiYa9NAh9fGjEOG+o5LT
         XcfqKlONWW9s2sn11kIrktm2DLKbrX2DnuQit8OmAmXF+2mnjFsuue1essIORoSfornd
         zPiA==
X-Forwarded-Encrypted: i=1; AJvYcCVjsTyu4WHgaGPOilXZFqxyRpJ+IW1twVP3ENAuK7QXjklni/0EsuFgAM56jwkcLmpNwqLgd+2rFs30kuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1uHkk6q8btFeK/orcqn7oOcjVQG8oO4Dv1QVMBIak/Vhbq+AZ
	ZGQKwt3JE5nF2KSCLpjEBpROGcY9oJOY3ltsOJJp3K4YBfbbw3b/LfYSctMa+0PvKfCggzGbuWN
	QG74Bj95/IqcfzsLlFncATLDtQq4g14Nx635ucoYF+IUDxlFwCwl9MJ0/QmZdpgLgMdE=
X-Gm-Gg: ASbGncv1Tk05OjEQS+7U0CfheJVk5vjEeiVnfw2G9NPC44blndlv1w83XV9j5TLb8HK
	AKU6rAzXPpfdH8QDD46rmNJMiYk2tARl7c63zZA4xnRDWAWRcGS/EKYKdfwMIAIBKqkMU0moFok
	7Un/C2GdpHe2S7rD2h9Wnqz+2TiCb/n8cLhrOhh4GQIrG2QSxgD5G5CrS8qsL9IRVs7RxttWKOH
	NvWI7bq8qvtuiX6GWbRIWITOAFiCgn6yzjfyewnc09naURbyZLqK9/0SohX2bNqHQkyvKr0UPVw
	+DKzCAjQuS6MQctvS2aO7SNZuMD5B2Pl6B1QcabNvUWXiqdzt1kOoOgesXPkdHOlHNwWw/bXnGf
	O2mJ1RfpQgmvsV1v62KYMBEhqjNlHbInkH+tmDx2EYy/JTPFoGu7S9GBBCR6F
X-Received: by 2002:a05:6a20:e293:b0:2c8:416:647b with SMTP id adf61e73a8af0-2e7cb166cf3mr2633430637.26.1758781766839;
        Wed, 24 Sep 2025 23:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8M4KmrkSYGYN8FC1x7uA7RyGNo0pu53ZoZrt/zQwFik9VEhWlVRhmTUXB6ZIImykrnjYpXw==
X-Received: by 2002:a05:6a20:e293:b0:2c8:416:647b with SMTP id adf61e73a8af0-2e7cb166cf3mr2633381637.26.1758781766221;
        Wed, 24 Sep 2025 23:29:26 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:29:25 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:15 +0530
Subject: [PATCH v2 09/24] arm64: dts: qcom: glymur-crd: Add RPMH regulator
 rails
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-9-8e1533a58d2d@oss.qualcomm.com>
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
X-Proofpoint-GUID: rQCBuaZRvHdFLy5hjxDbDmhoRNN0e0hQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX2xq2qen7wAwd
 p4CRCSuxXoZ4MP7tQ+kdOGxXjAE8CKHGOdVpCowN+wtEWfpWsjF6To4hEfuzd3/oWVF2gS7nQHO
 7WoEu+nZaPVMfJl0+IRmpbLWqNnB9a9Z2jdg1qUIR/W48P+MRnPekpowiaMnwfc3EzqKp1oG+0X
 AcS+OwfHq93H188vD6YdtaOpuYztNmjJyM+gl6cU5n3/x5g8ylxWuATkwLEOjDI2QgMh4H6SnJx
 2iX4BDxTxc6FvEHqmP975r/852enyXJftQURS/w+SIo1JuBgTezE5rJf2tbE8iGJjPw6OPFFUOR
 rwC8hyaOx8vIQ17idEeuRHJw9QJqsG//AVP2JsvH7Yt+J4Z8VmBKRudWtRI0aJIRn1pVSX9ZF9L
 MWHH3jGt
X-Proofpoint-ORIG-GUID: rQCBuaZRvHdFLy5hjxDbDmhoRNN0e0hQ
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d4e148 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=6u9sh_BIoH2fqP3TwikA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Add RPMH regulator rails for Glymur CRD.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts | 332 ++++++++++++++++++++++++++++++++
 1 file changed, 332 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index 4561c0b87b017cba0a1db8814123a070b37fd434..e89b81dcb4f47b78307fa3ab6831657cf6491c89 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "glymur.dtsi"
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. Glymur CRD";
@@ -66,3 +67,334 @@ chosen {
 &tlmm {
 	gpio-reserved-ranges = <4 4>, <10 2>, <44 4>; /*Security SPI (TPM)*/
 };
+
+&apps_rsc {
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+	};
+
+	regulators-0 {
+		compatible = "qcom,pmh0101-rpmh-regulators";
+		qcom,pmic-id = "B_E0";
+
+		vdd-bob1-supply = <&vph_pwr>;
+		vdd-bob2-supply = <&vph_pwr>;
+		vdd-l1-l10-l15-supply = <&vreg_s9f_e0_1p9>;
+		vdd-l2-l7-l8-l9-l16-supply = <&vreg_bob1_e0>;
+		vdd-l11-l12-l18-supply = <&vreg_s7f_e0_1p32>;
+		vdd-l17-supply = <&vreg_bob2_e0>;
+
+		vreg_bob1_e0: bob1 {
+			regulator-name = "vreg_bob1_e0";
+			regulator-min-microvolt = <2200000>;
+			regulator-max-microvolt = <4224000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
+
+		vreg_bob2_e0: bob2 {
+			regulator-name = "vreg_bob2_e0";
+			regulator-min-microvolt = <2540000>;
+			regulator-max-microvolt = <3600000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
+
+		vreg_l1b_e0_1p8: ldo1 {
+			regulator-name = "vreg_l1b_e0_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2b_e0_2p9: ldo2 {
+			regulator-name = "vreg_l2b_e0_2p9";
+			regulator-min-microvolt = <2900000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7b_e0_2p79: ldo7 {
+			regulator-name = "vreg_l7b_e0_2p79";
+			regulator-min-microvolt = <2790000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8b_e0_1p50: ldo8 {
+			regulator-name = "vreg_l8b_e0_1p50";
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9b_e0_2p7: ldo9 {
+			regulator-name = "vreg_l9b_e0_2p7";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10b_e0_1p8: ldo10 {
+			regulator-name = "vreg_l10b_e0_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11b_e0_1p2: ldo11 {
+			regulator-name = "vreg_l11b_e0_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12b_e0_1p14: ldo12 {
+			regulator-name = "vreg_l12b_e0_1p14";
+			regulator-min-microvolt = <1140000>;
+			regulator-max-microvolt = <1260000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15b_e0_1p8: ldo15 {
+			regulator-name = "vreg_l15b_e0_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17b_e0_2p4: ldo17 {
+			regulator-name = "vreg_l17b_e0_2p4";
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <2700000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l18b_e0_1p2: ldo18 {
+			regulator-name = "vreg_l18b_e0_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pmcx0102-rpmh-regulators";
+		qcom,pmic-id = "C_E0";
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+
+		vreg_s1c_e0_0p3: smps1 {
+			regulator-name = "vreg_s1c_e0_0p3";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s8c_e0_0p3: smps8 {
+			regulator-name = "vreg_s8c_e0_0p3";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-2 {
+		compatible = "qcom,pmcx0102-rpmh-regulators";
+		qcom,pmic-id = "C_E1";
+
+		vdd-l2-supply = <&vreg_s7f_e0_1p32>;
+		vdd-l1-l3-l4-supply = <&vreg_s8f_e0_0p95>;
+
+		vreg_l1c_e1_0p82: ldo1 {
+			regulator-name = "vreg_l1c_e1_0p82";
+			regulator-min-microvolt = <825000>;
+			regulator-max-microvolt = <958000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2c_e1_1p14: ldo2 {
+			regulator-name = "vreg_l2c_e1_1p14";
+			regulator-min-microvolt = <1140000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3c_e1_0p89: ldo3 {
+			regulator-name = "vreg_l3c_e1_0p89";
+			regulator-min-microvolt = <890000>;
+			regulator-max-microvolt = <980000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4c_e1_0p72: ldo4 {
+			regulator-name = "vreg_l4c_e1_0p72";
+			regulator-min-microvolt = <720000>;
+			regulator-max-microvolt = <980000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-3 {
+		compatible = "qcom,pmh0110-rpmh-regulators";
+		qcom,pmic-id = "F_E0";
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+		vdd-l2-supply = <&vreg_s8f_e0_0p95>;
+		vdd-l3-supply = <&vreg_s8f_e0_0p95>;
+		vdd-l4-supply = <&vreg_s8f_e0_0p95>;
+
+		vreg_s7f_e0_1p32: smps7 {
+			regulator-name = "vreg_s7f_e0_1p32";
+			regulator-min-microvolt = <1320000>;
+			regulator-max-microvolt = <1352000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s8f_e0_0p95: smps8 {
+			regulator-name = "vreg_s8f_e0_0p95";
+			regulator-min-microvolt = <952000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s9f_e0_1p9: smps9 {
+			regulator-name = "vreg_s9f_e0_1p9";
+			regulator-min-microvolt = <1900000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s10f_e0_0p3: smps10 {
+			regulator-name = "vreg_s10f_e0_0p3";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2f_e0_0p82: ldo2 {
+			regulator-name = "vreg_l2f_e0_0p82";
+			regulator-min-microvolt = <825000>;
+			regulator-max-microvolt = <980000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3f_e0_0p72: ldo3 {
+			regulator-name = "vreg_l3f_e0_0p72";
+			regulator-min-microvolt = <720000>;
+			regulator-max-microvolt = <980000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4f_e0_0p3: ldo4 {
+			regulator-name = "vreg_l4f_e0_0p3";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-4 {
+		compatible = "qcom,pmh0110-rpmh-regulators";
+		qcom,pmic-id = "F_E1";
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-l1-supply = <&vreg_s8f_e0_0p95>;
+		vdd-l2-supply = <&vreg_s8f_e0_0p95>;
+		vdd-l4-supply = <&vreg_s8f_e0_0p95>;
+
+		vreg_s1f_e1_0p3: smps1 {
+			regulator-name = "vreg_s1f_e1_0p3";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s5f_e1_0p3: smps5 {
+			regulator-name = "vreg_s5f_e1_0p3";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s6f_e1_0p3: smps6 {
+			regulator-name = "vreg_s6f_e1_0p3";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s7f_e1_0p3: smps7 {
+			regulator-name = "vreg_s7f_e1_0p3";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1f_e1_0p82: ldo1 {
+			regulator-name = "vreg_l1f_e1_0p82";
+			regulator-min-microvolt = <825000>;
+			regulator-max-microvolt = <950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2f_e1_0p83: ldo2 {
+			regulator-name = "vreg_l2f_e1_0p83";
+			regulator-min-microvolt = <830000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4f_e1_1p08: ldo4 {
+			regulator-name = "vreg_l4f_e1_1p08";
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1320000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-5 {
+		compatible = "qcom,pmh0110-rpmh-regulators";
+		qcom,pmic-id = "H_E0";
+
+		vdd-l1-supply = <&vreg_s8f_e0_0p95>;
+		vdd-l2-supply = <&vreg_s8f_e0_0p95>;
+		vdd-l3-supply = <&vreg_s9f_e0_1p9>;
+		vdd-l4-supply = <&vreg_s7f_e0_1p32>;
+
+		vreg_l1h_e0_0p89: ldo1 {
+			regulator-name = "vreg_l1h_e0_0p89";
+			regulator-min-microvolt = <825000>;
+			regulator-max-microvolt = <950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2h_e0_0p72: ldo2 {
+			regulator-name = "vreg_l2h_e0_0p72";
+			regulator-min-microvolt = <830000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3h_e0_0p32: ldo3 {
+			regulator-name = "vreg_l3h_e0_0p32";
+			regulator-min-microvolt = <320000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4h_e0_1p2: ldo4 {
+			regulator-name = "vreg_l4h_e0_1p2";
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1320000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};

-- 
2.34.1


