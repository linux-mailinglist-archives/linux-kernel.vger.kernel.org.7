Return-Path: <linux-kernel+bounces-831508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39495B9CDB1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DB74C0E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5EE216E1B;
	Thu, 25 Sep 2025 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EtuGyUBM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D391E98F3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758759467; cv=none; b=UHogZhzQS49MUaiNCTywb3S6W/9KQYwG+VTo1/7RVRmmW3mZKXqOCriaLiLhSoHmhQvbKOk2tyth8zP5Qh2iOvkii53cZYeslHDQMBwte6uOah6hdqGByxMY+1Axh8wKKw743QRT7Eb0SWrBm2eBweDot2NE/e6fYcHucrJua4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758759467; c=relaxed/simple;
	bh=nIpTB0NeAUptoXv4uxWQfL7M88V4nsYNIHhSqJZnTHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QadncmIW1r6m9BMD0Fi/Q4Dv6pKiagWAdPO07vrs3ItU/NDetapPkB7Q9CyxfnVsa0LnmKvwFxuH5s2xGsP3UyQ/FqoWDVwkFSS4gh3p3xr3iYgB04Va10cdmAVkuNZHbwEPs9ZW+QDTFqM8tS+q4glcurdLcIfny/q/qa5ynr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EtuGyUBM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONqWec023856
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z41//8vHcA5fSlqMz3I2iIH0TKSTeYCJ9WHm1jj5e08=; b=EtuGyUBMuOIIgZ0O
	0ESUKQydhRP5kbxZFvC/zZI74PyfVnwCAElVBfTtPmL9Exd8qgtkY+jkdagoVQWt
	Pui+mIKp23ABsMbaSXe7oT6nyi6BCm/A+myHYzXxW2kXAtRKisgx2laU7cVtwElx
	XupNlOmCzYBxZvXXLPSPQ9028C+ibEeLFyfrXC9rH963qP0FDpLbsEfGlzLdxb69
	aNKB9kVpKU4PZz56gVMEbY+DmgCTDRiK4hrdZQ9eZ+6BJbTbhs491R3seMqWRsyC
	Z+bU+TopYcLlijryWU5V+tNvtfUPI1IpQ3Aor5bBDHY3qiwobK+9ShxPUPGaKLJq
	aII55w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0d5wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:44 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77e5a77a25aso538903b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758759463; x=1759364263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z41//8vHcA5fSlqMz3I2iIH0TKSTeYCJ9WHm1jj5e08=;
        b=Ge8G2QdMOtsC3PcplYjJAeFoYgN4+QsbLR23G1wmKkSZy38r+BBeavELF0pp4p2hk0
         cTB78s9HD1Ugv8ZtY8iabUBI3LyRJ1NtODNDq0abAgasWLXFHLAFOoJpft5f0Jq9+s57
         sHwdB0brO2jxoyPaUNNuG8BgXMpQacrCpbjwou0gNwMwk8Qg/8JQeLGBAXyWZAV5kqVE
         I3cjZB/vwMxmaf7+akZtVYVgFP0ESP6iDRLXsgXBCYxW4RJ6QKoRKmmgXQ7092L6SWZ5
         GdAXk7Uwdu3/ITDdO3tDV4WvixvTI1FHxbn4mw7RWISNQGohY23e2FVg+7J4dVXVhpgB
         BevQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXCWoG+YoS1lFy+WKY05DKx4l1xt6MdZumNnytSIMRkpkRfoeYCUNSD8yamvVCTyD2fFpZw2OHe5b7fBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7DXDyoXLgBX64DI+xTFQBZgAif8UyFj1UlNow8HIaYB+MPsaQ
	g28sZscOcTUOsKKs57Hgt8BEkfw6o2d1Q00ltvrdSx+0cg9T8MiSkGFQpyxCclOy6eu5cZltNEI
	EeXYp/LVbDO6uWKxWKa/3ddkXGBV6gBq+FncaWA/Fhag+3KtO3mmIe1iDhEGhg9rXvYc=
X-Gm-Gg: ASbGncswWck5smO9zj/ffpTfpLc7hS+vNtdcMaPyf4Ppy+80kw8er669VERd47JAuqb
	eTSff8k+kqFbxbPKt/nDrVL0As1AIwId7AO/lb7LrFCpaQYQ6JKOSae3NbeN/CE9qhEbLOm/vpN
	ZT0RkN+W/L83flVvAU6pk7Jy20HAeBWup/dgZCASZcXfh5uRexXiIKP3GxCAFvFkIOJdz5WDplZ
	zbGmB/nGxt91UVU9SfLQxp1lZOhjwLhsvaZB0T6CWV7vaA4FnGWGFYCAlYuSF721y99VPY9C3vv
	8CM1jmMRIWsaXTOGysSVM8CNxAqzjMY3+SL6YAuUtpjIeNUJ/tnfJEH1Up51D2EwHQSDtJ5Vpls
	HncVguo0tlqFGJcw=
X-Received: by 2002:a05:6a00:98d:b0:77f:6914:ed1d with SMTP id d2e1a72fcca58-780fced499emr1878240b3a.27.1758759463563;
        Wed, 24 Sep 2025 17:17:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXFps2R9Lt4KZbIoLbgABdeFUsajRzhyvUdyW9Ku8o8y03n5rHoNIZC3NOGcdofL5GqUsl6w==
X-Received: by 2002:a05:6a00:98d:b0:77f:6914:ed1d with SMTP id d2e1a72fcca58-780fced499emr1878213b3a.27.1758759463149;
        Wed, 24 Sep 2025 17:17:43 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238e6fasm262748b3a.1.2025.09.24.17.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:17:42 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 17:17:27 -0700
Subject: [PATCH 10/20] arm64: dts: qcom: Add PMH0104 pmic dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-dts-v1-10-3fdbc4b9e1b1@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758759448; l=1536;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=PzGxNgs80hK/Q5JCvCqK5GCBIMfHwdCKONuBi7AoAB8=;
 b=/PYsSCARnprSR1JyZ9fqJ945vYHz6O5QqJ+Eg18n+k063EglvXO9TibRsFhZvFfe+r7KDxpWq
 POg2zkuB4QdB+25CLFax0wuBen5X5yVmyyebz4lPYcepV8OrnRZMXYW
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d48a28 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=tfDFkgPjZAY9trorV74A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: JsapX-fM2VkmAdDygXXkCOZ9G33uaF_Y
X-Proofpoint-ORIG-GUID: JsapX-fM2VkmAdDygXXkCOZ9G33uaF_Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfXxVuaI4jpUzdo
 vNabI+71yjsnX07Z2LgEVJF487BQ1bMMHHWBGU3jtrQqkkJwpDZ53vnifJx7/Mq1SFEAD/RuS1H
 YBKz9e+F+4mjQaDLrX/Qs1PvX+SRAc2EwpRNAthBsnRqdkSn17+voeYr3SNxv8tkMm9+80bzBo2
 LHUmMNnWsc89TvI7chGFILeGiHDK4RwBvetsEqY75BwMET7kZE0uB38v44GfaA/fLQs+wRBYWLX
 d6F0alzpXAeqqGdepkBbwVtnwWyujng7wWTb6rx5u9Ohf4x77/a2v7t3RlDKYHcYoEtYxLrr5BG
 XAB1eSOKSAZop4ZtVSuxhmA/hFwBKJlEENERlD6p37Ja6mzm0AUFcwou8ovpQ+qaLffn0sfrb0s
 jBvC8ycR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

Add base DTS file for PMH0104 inclduing temp-alarm and GPIO nodes.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/pmh0104.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmh0104.dtsi b/arch/arm64/boot/dts/qcom/pmh0104.dtsi
new file mode 100644
index 000000000000..f5393fdebe95
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmh0104.dtsi
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus1 {
+	pmh0104_j_e1: pmic@PMH0104_J_E1_SID {
+		compatible = "qcom,pmh0104", "qcom,spmi-pmic";
+		reg = <PMH0104_J_E1_SID SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmh0104_j_e1_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <PMH0104_J_E1_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmh0104_j_e1_gpios: gpio@8800 {
+			compatible = "qcom,pmh0104-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmh0104_j_e1_gpios 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};

-- 
2.25.1


