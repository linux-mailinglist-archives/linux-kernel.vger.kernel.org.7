Return-Path: <linux-kernel+bounces-831843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 238DCB9DAF5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 255DB7A7823
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AFC2F7AC0;
	Thu, 25 Sep 2025 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OyTDdLWN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4489E2F6560
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782042; cv=none; b=fOF8nndrGnQcMx9speGN81DSawKjid8XU/R47sT6RAaOtPzuJuInQe++NsTkYcwdxk6SSshe73M1St9Bl5iw5SmNy57s7DoskrcN07aHxrzwIa4sLvdKaeikRoVe5YKar/ujbg3clRiAg76R2lpRuILPP03Rs+lEWctJhzzGWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782042; c=relaxed/simple;
	bh=uBpyNXxBek34lXoKZHB1xpUK1S6YGoyCu6EJBXVQ9MU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T6mBwdFANpXUuyfogf6usIuiam7nCMJROsIGYDkF0vOBn//EyXMVgeUO3m9Gve3evxpCkHl1iG9WA6Rt+KCyTEWrJc00ZlTg2bClvvNgh7zw5fs1oyoajJ4YMu13frVBdzwMiuj+wH/3/sdGlqNF5HzCnr0o4BHR8FOwqeVLRbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OyTDdLWN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1T9B9029974
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Kj8zpXnqTa4oRX6rrL1uXULQtmQx7l8fFyKB5TkaB0=; b=OyTDdLWNRyJpLFEv
	h4nEJ4PiNatMEUfQpInyFBR28ciRoGvk+OudJKnw7QuPtXjG63cFboCdHiYANwzB
	akgvgmV/BX8MYdTqnq5FsfY3MeHzWSEF3cPJJfSeZv9CPRIHu/Pvi/qdj4pt29vr
	DSgxADBX3lxxfxQP9MPvMRKUsU9v71ZVDijG+NCw0vpYHD8NBZNtVi4Ain2ZzrX5
	hYmrOXJmOKFIeiCf5oqJaMJ4cZReZj9P5K1fGcUPD4GqDP1eGtlVJ2QQorITWpHP
	5IAA5SLUDUIytj+RoeQlWg7+mPo0vJ3H8oVj/vl1i0WXMuxcYkuog8sar2D/q6uU
	aXtUoQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fpwv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26983c4d708so6169695ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782039; x=1759386839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Kj8zpXnqTa4oRX6rrL1uXULQtmQx7l8fFyKB5TkaB0=;
        b=ghmanvENjF/hTs5uSI7OlEGgpnrqelzDYD5jEQc7jHfQw/q4xFrnIHJeTPs3Xu3TN2
         SD6ZSut1hYBh7qoXQo4xxxSKaNDqngSJG5PTCDHp77mh49tYJb+gT7mRzZ8nyXLNaMa5
         e1sDzYaCC5oEvJXujcfgXuTcms7Lt0ALtO44hPS3M6vDJO78nBRH5/j3lcs8vL4159uu
         A0R87PeQR3y9yZhuWjBX5o+fseZSITzdTCBHygbRUWDvRodjPArluccgn/LS164ymDMZ
         NWRWnigSkyBpYZEYqXx8Xe0gx6rOvVmJXsAjEm9Y4TiNnkuKJmcVwWDmI+LCUlP7kt/S
         psMA==
X-Forwarded-Encrypted: i=1; AJvYcCU+GEopiknLqA1atJMt2TPzoxVlq328zx0q1kFTWv7I8c/GjGrtabI7As1otecSU0Zn9PZl2/OV1mwfBXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg/ThRaOrKPC7Sxt8OGsevj9WE3BqopkdhjmXTrHq15cMTdvdJ
	oxaiIfxAuc/beeA9lolrWq0JYOVVXNig54x1R2/sZlZ2rdwbSypAOjUla3CBImiKQKh0Xgh/eIB
	VRtK0K+BVrYqheprJsY6oG05TMQxlxniFYMf4gr7TfLAko9xCzclGqcN2F4795x5XHhc=
X-Gm-Gg: ASbGncs6h8MbKn4DejhlDmcSN6/sI6rXJnzcXanJLBMEYDFgkJjTqUMuKSJdR4NW9Bc
	wD3RZR1AV9cu+XJTuz57VgxWQLyTJMfqO3FvntE6lpGt6f71Mvk14ZVHl/ebXlu5ANhiufKJ2Ja
	gc2sDoY1DaliV886IFJ2nN0QdTAbZp/kdBjhswt7xxKNFC8IAvwPxanf0YTgGCM2bZ3F5FSMYBs
	89qTLriL9DIIJHusAdndzr+52ASDlzeF44NWwZ38ucINrEVL/9dbrMW4U4hG5hcyh4kzs9PyDPd
	CFz0uAtwCTpZX8AQbbc2J5VANew9W/20+921ud+g1PjSdRBNaWDUO58dLmW6zHYZ6fu4fJ/eYHe
	QEIsjac3z4VrUneRuxVtKGfu8IsxFknXwuMXdiMTpuhXh8G9PMxljOdDAvM72
X-Received: by 2002:a17:902:f64d:b0:259:5284:f87b with SMTP id d9443c01a7336-27ed49d0965mr28719525ad.16.1758782038760;
        Wed, 24 Sep 2025 23:33:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp683rEPgCw8NvSk1RJU72jidt199quQvoOhetoHVrSwP2pinXYMmPcugbmk4ZmPCU9x8PAA==
X-Received: by 2002:a17:902:f64d:b0:259:5284:f87b with SMTP id d9443c01a7336-27ed49d0965mr28719235ad.16.1758782038289;
        Wed, 24 Sep 2025 23:33:58 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:33:57 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:20 +0530
Subject: [PATCH 12/24] arm64: dts: qcom: Add SMB2370 pmic dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-12-24b601bbecc0@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: MgEZzojBZtnBiu_L8ZeAmhbUgmWSyTdt
X-Proofpoint-GUID: MgEZzojBZtnBiu_L8ZeAmhbUgmWSyTdt
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d4e257 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=SyH_bpr75tbjU19HRJsA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfXybWQ+2rMs6xJ
 NJqRRMjJiWm4w0OKuENWpC6Rsjnd0jF6esGGNXXxBdTNCSu0Wp2fjUY1ltpey+b0z82dHCywLA9
 z9j9JJhKD+oBX1xV0V4SkyHU/b/76mQcU5XGMT0DQwefLjrHezc3wzR63ZBz9KR18UtnG3QYejU
 SIi+4GiqjlvH73OyemO0omcOsavFh6h9bMmc4xbAj30eyU4DgJub6Mg9HFORaIADkQyAdnle1VH
 rSqVoSUDs+ydNXZ0oUDrdX65csfb7BXMOMG7NmIFI2G+HbSMvQ+uUNp4+s4+v3OHHFvxNDFfklG
 9idRRcb/8X9P/+AVpWjh3HlzS0yg9/2tH21APRNhE2PJcCR1mITKgKLEWBsiULUl3MdBfL7FssE
 X85mnSqM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Add base DTS file for SMB2370 along with the eUSB repeater
node.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/smb2370.dtsi | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/smb2370.dtsi b/arch/arm64/boot/dts/qcom/smb2370.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..80f3fdae5705044b5bd422ac3fc3a6fa6b0fc23c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/smb2370.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+&spmi_bus2 {
+	smb2370_j_e2: pmic@9 {
+		compatible = "qcom,smb2370", "qcom,spmi-pmic";
+		reg = <0x9 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		smb2370_j_e2_eusb2_repeater: phy@fd00 {
+			compatible = "qcom,smb2370-eusb2-repeater";
+			reg = <0xfd00>;
+			#phy-cells = <0>;
+		};
+	};
+
+	smb2370_k_e2: pmic@a {
+		compatible = "qcom,smb2370", "qcom,spmi-pmic";
+		reg = <0xa SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		smb2370_k_e2_eusb2_repeater: phy@fd00 {
+			compatible = "qcom,smb2370-eusb2-repeater";
+			reg = <0xfd00>;
+			#phy-cells = <0>;
+		};
+	};
+
+	smb2370_l_e2: pmic@b {
+		compatible = "qcom,smb2370", "qcom,spmi-pmic";
+		reg = <0xb SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		smb2370_l_e2_eusb2_repeater: phy@fd00 {
+			compatible = "qcom,smb2370-eusb2-repeater";
+			reg = <0xfd00>;
+			#phy-cells = <0>;
+		};
+	};
+};

-- 
2.34.1


