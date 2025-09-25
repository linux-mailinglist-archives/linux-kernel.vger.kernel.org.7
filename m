Return-Path: <linux-kernel+bounces-831845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5F7B9DB07
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39D93A1A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACACB2F25F5;
	Thu, 25 Sep 2025 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eqL5k3Yd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614D62F90DC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782048; cv=none; b=G0CXK1y7/S7LRMSqX2UberZrwAuC2x8XWg7HM2vRy9A22vg7Hp6zmyXYhAO4Z7IPgZlhcMvAWKSNXVeu7hq4+Q56E85EODn5tOP+WcvtVGf1dCYiiVJa0oUpEGPxswce1ySfUbV7djDJAus2NFljdyTy+9kscg0grQLe9ywkbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782048; c=relaxed/simple;
	bh=OV/aaJzgqGLB3+eDxXdtVetaq7X7QyfyLBw2k9nuYD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M0sNVUeH40TAJUDwPfJ24Ks2Bj45HaQGnxsuHDnpJC4WK2YCy87ST0Xpl0ZYAa69xZHrqMyCpLZSRASVxyff6kRK4dZzqJ/vJlNaU32vZVAn6b3lRbCWRWAZlmXtw1X6bVN3FPev9X+9MQh4VicAdSouNUhJlepz6GLvfzQKd7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eqL5k3Yd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0Kf1L003961
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k69QmMaDJytSlpNex0Fnt5aK4VFtTpI8VjRIFrBY1m4=; b=eqL5k3Yd5mPx4ip0
	ohecm7Rq4L042mBZ22zZ+Bmo3cQNCFe2t7oQCOrFGhtH2DxreHPg71C7IHRh9ndU
	WLZ8RTuoenStCtJHQ67eUUnfy/SQJGtCdcCDb1RHn5BRzBujyYb8Tm+HfIZOYxH9
	NIGQG3DPkIURXvJ/hl2bgKw6CVkPiJ132cfO8G5mTRXitzRLsFNbnE/O2Scni0xY
	rKjtSEoeRfxFTPK+jL20e80ohf2wqeOmT0aEwUId6AVlegf+OHDgUUnH64IwIy+Z
	k9etCoO+1edvE8YN4EUPrFHfrY//9wRNIeRgnP96krY+8GNm2ELE8rZqmr+lqccz
	GwbGcg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf1jt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:06 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b56ae0c8226so470883a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782045; x=1759386845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k69QmMaDJytSlpNex0Fnt5aK4VFtTpI8VjRIFrBY1m4=;
        b=CUtQCW4btQwvj4w4u+0FCaY+/4SkTtHjc4hTlf+Pioyn91E0NSEzmul8bmo8dAJCPn
         W5/b3NRRS0QS47QY66eUXBgaO9ca9JeS1TxTF9wigamS59eVIl89v78VTqohvMFt1gUr
         OdIEmCr6ScSvKlXyz3QH27Rb4DamFkjDC0IdZFfQYvNi6/bONca1bL3OCa49ONZcjfvs
         yi063gWgewbofswQIMcaooXGnoJ1ladM3MskeNIVm/kVd7otfI+/ZZEgb0UFKG7y7qX4
         xr61hqKs2GA52JkJ7lK/EkUmKcQnN+9XVG9i0fo4CMOBQjZV8kng7+6oZrnr1yLJ3jIf
         bGRw==
X-Forwarded-Encrypted: i=1; AJvYcCWJzmtIgtknTPKkkRzKhie8K8ALmHiKH8Rp2ysKsFPO1Lh881DD4FS0sghV8BJE07Hd4CPaSDPTNnLK8Js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxat/QlLOSNoYCvPAj6un7RfhahJYqBbHM+4R+F2zfYVBt+k5ZQ
	e6dHvNfABJY3Cim1JEd1QzLrMe/WdC3BjqJKmP+/9aJ+ufa17oIcH/JPZ9sMZsPyJmrXt6MZQm/
	XND65GzDnnKEoHclXxECb//I5xg1oyvaq9OuIqdmKRyV1ql1bcScXnJn4ddeDX4zx6JY=
X-Gm-Gg: ASbGncurTmFqTmGl9Wv3a84H4MyNhkfjSFZK7OJbaK4WCMDog/xpN4Z46hOOYrgWPGq
	rKEnk83e0S28DIJBLeLlCJLZFtBcrrNZljh54Zj+PnXuPpDfOpdkaWsU1SS7yoLcsB/HKV3MXGD
	7dDzHbNqyV2TT8PP9Q8EwTzQYa4BuqpK8F0XjC8struWWFddKK7YCDPOLN0uDeXQTFLmf8y5vkY
	+XnFvcaw7HdEML767ZZFkptzqHgUOi1lQluVR2tZ0H6eXJx5XPcirbHWZR2Hh0CblORIPhIxruS
	et0NT3Ihh1OKwnmJ0A0MVLp9ObZvM9Xi3bMU0uNsjIPl1Kn5FxJ67Ww+mXebWiUn9bcmXemkCtJ
	Qb5BBtCPP2V4xGv+TAnBmj/gDRt61dpy8r6RPZ4pZWlqFrp3z/2MOdKlCT78F
X-Received: by 2002:a17:903:384c:b0:27d:69cc:990 with SMTP id d9443c01a7336-27ed4ad102cmr31767585ad.49.1758782045262;
        Wed, 24 Sep 2025 23:34:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCY0vsuqsg52Kj1LbmDogFkzA9N3hRQ5rkwaVhqkViWFBf6iC/yBGm41Zr3BQARnUmBBubqQ==
X-Received: by 2002:a17:903:384c:b0:27d:69cc:990 with SMTP id d9443c01a7336-27ed4ad102cmr31767275ad.49.1758782044840;
        Wed, 24 Sep 2025 23:34:04 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:34:04 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:22 +0530
Subject: [PATCH 14/24] arm64: dts: qcom: Update the pmh0110.dtsi for Glymur
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-14-24b601bbecc0@oss.qualcomm.com>
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
X-Proofpoint-GUID: c-aTDSk-xjCo8X_11uhDjkINNsPnNeVW
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d4e25e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=EOUZnPL1Ke5HISHMaDUA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfXybqaZNPQJ2tO
 BcMQ0LEfmAWApX8JAzONMZDPTlq84tSCXO48GH+UHnEg+h+sJtjfD6WxKGDVCnQbsI12C5HjdDL
 QRUU219wPFf4wE7vJ8/JyDOtV/YdqcYw1On7kqhYqqkeKovDt1A2zAi8uU9jChqfZyiM550Oku3
 o0KCxypoWpPBHQgeTenxv04VPfSqS/dSuyExnsJLB3LMy5jMvdqr76IxD/KjSqIw7ogFH7zL+Gw
 fSoieK0qllcQM1avT7zgptWhRSduzHxy3jRzkgAzk9r4ZrvvzUqxrqez9oRKZ1X8DN1JrXETfus
 cOQTNOJ2x2FNvO5zZ+S7we32vOCxs5+a7oEKe+fSZ9uvoDR0tOBGryuZDbr5N7fN43y+S3Duc7c
 qMFpB5je
X-Proofpoint-ORIG-GUID: c-aTDSk-xjCo8X_11uhDjkINNsPnNeVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

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


