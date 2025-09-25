Return-Path: <linux-kernel+bounces-831815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E0BB9D9CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3148B17E29C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61CF2EC09D;
	Thu, 25 Sep 2025 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NRymTrTa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E66C2E8B8A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781779; cv=none; b=hKjmx+cSVdQ67qKu8hU+VcHNNAcmAfpvTvk0gKZ+4sOIrwnhjVugq9ztKqqeeawS4r7VNW3kkYBj8WopwhaYr2+pzGshguK7QSfX1oK0D7SF+KsPtmzeyJdJf1VVynf2YTzoC9ejNxqcV3kTWcx7HXz4VGLGcscfjr48YmSmo2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781779; c=relaxed/simple;
	bh=uBpyNXxBek34lXoKZHB1xpUK1S6YGoyCu6EJBXVQ9MU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLU6EONSYQN0+6eV5a2mjMHu/rGcXZErfuejNLi/dyhhxC1xQayQ3wdgMndVWEy9WbO+uh1EAeu3k4lagLY3BMUKYConp2SgLPdOYp5fi+SuXbVZT27usDQtaCaBVl5wpGkhXZ7p8CXfXCk6+1OU7+jbwAfqokGxiMh0MP7jacg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NRymTrTa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P11NNu024516
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Kj8zpXnqTa4oRX6rrL1uXULQtmQx7l8fFyKB5TkaB0=; b=NRymTrTaVbTqwIDA
	ahXZKTCphI17ZXDXkuq6iv3filsdRoEEQXlGJ8V0PkZuBpLppV8WGsfISpCz/fAv
	AldXlofCIfIz9ajP27cJEgR4Kk6QSX17/tDhrC4JZKmO0zPH4Xqv9yoP6JbLWYDL
	zUqjffn/dCA/cK+2zhNF2EklVijOM0eoer4Ua3U8j/1NUBhqSUprJO1QEkpFg6kX
	O0nGqHuRhC3ce/3wpwZSiZ8SLH+jw74n8KI+RKE+N9Ed8aTxqPNR2W+PID/kKzdw
	D+LISo5nDiF4cncYwxqXOL2J8xSHooEvM/z1XMAiCCim/aOY2fpOUPqS8jfB8agX
	n0O1BQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0e1vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:37 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-781044c8791so326648b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781776; x=1759386576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Kj8zpXnqTa4oRX6rrL1uXULQtmQx7l8fFyKB5TkaB0=;
        b=e1TDv7+hO1U8byLS2hIaOiaHBzkp+m6qpYk/CKqikpdmfchAQEFEO3uUO7vX+uva8x
         wRk8fUTet7h4yQkj8rxKFXqRJOUFj/7SB6KntrSMco6ADNr5R0i9JeMcwDApuGb/Xdhm
         axTN9XXTso+kWuiRT9FMqRHAbAq/JEO/lSO0UwlgXqj5c44wCYb4bHeT8DBLM4aK9WkW
         Lga+YODQUaZWTijscw/C9MrQ4zPrI7UzqHJyGnHISqFMJJh+50W96YFnz6zQhQQCdpiF
         /kx3z2PUjdlpdDueKU93d4/F1ejABIPxVxHO+bYRUEAfUU/Jb/slGuakToGnIscnuQSZ
         dIvg==
X-Forwarded-Encrypted: i=1; AJvYcCXJWfWckALtyZYHr1/9/uIfiaSwkNwsJ+2DKFKTXuPrKK3nU4F+P3YSD9MO3Pq0Vj0KapcpGW79ZhIO+4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGxT/w+7rvwJPus4FVyFQQKw65ydBqG032ggVqoN9ieLOR5WJm
	xCFOonXrzAoQ+cLfU2cHtuAE18Fv5qgccl1QpR/cQsd15J5JiWMD4MlE20HzjnBBBWvQR2frvzM
	mklSTvnoS/6TljYWnd6DO61J8B/jh9xKwtYrWj+SnnG7qF4IktxFCL1JcrvYUG6GtpMQ=
X-Gm-Gg: ASbGncu2s3lrkX+TKCZXKIaQt07CB26ZbGk2nq5eNUKmbjANAcAow8RV+wGRJ1gmgs3
	TPC8++vs1ToXuGMNLj2YuEhbN/+lMJp6QRAv3aHXlM+yR1qBymhNQX2owFIv3Vmkpe5xuke4oRR
	MiuLBbr79tfe95xssQwAOugu93MxA/nvCqfZ6kpP4s9rpzHyhJtcC5KgisKw+4rzmgnf2r5moF3
	VscHqJpaB/Q0gbEXuVzPMtTjCSkqRGMUyTtan+EVtKkNSIhvcbAp7MZwHC0lGau38DaZoavCfRQ
	WL3O3rLPLtBEHxXuE9NSpkDDow59l5cuTcaKpSHvkWRqPEOkw2jwyh3USIS7EhRzkjlKoxAjGQE
	PdxOAQSOGlkqA4p2ec0NlXXaPSP361lZmD9niarISgkG611h4mg8d2HyaHRJ4
X-Received: by 2002:a05:6a00:ae17:b0:781:802:45b7 with SMTP id d2e1a72fcca58-781080255aamr585823b3a.12.1758781775916;
        Wed, 24 Sep 2025 23:29:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL5HniixRjeNZsKDdR3SnJ8q5xPlBnuviI9FZhv0rIK1xC3ldyzmknTaSHiKLvhCp4H7O/qQ==
X-Received: by 2002:a05:6a00:ae17:b0:781:802:45b7 with SMTP id d2e1a72fcca58-781080255aamr585799b3a.12.1758781775512;
        Wed, 24 Sep 2025 23:29:35 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:29:35 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:18 +0530
Subject: [PATCH v2 12/24] arm64: dts: qcom: Add SMB2370 pmic dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-12-8e1533a58d2d@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d4e151 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=SyH_bpr75tbjU19HRJsA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: IRfAuNQfkyVr9DYnumeo2uWtco9Gz-bj
X-Proofpoint-ORIG-GUID: IRfAuNQfkyVr9DYnumeo2uWtco9Gz-bj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfXyEg03GS0yXmH
 UK9OdQ/M9G9D9/uvlR161gbO29urR3yQ3rcsHK5yF7C04EX0aygiRnsiDKgC46S/paRb6l2MDnO
 a+cXmU1rB3M9Ohjo/ANXHWNXvpOmfi3Z4sjEhoUxlXHxVdpvnq9wL1LgQfWJsDydxLzOoApdCzX
 YSEm4ZZ9rtvwWpR7h7C9rYe9K/0g/skG1p7MaHJfo2WpGQ3Rv5NQDES24RzxEhTBf31oj0IgB6B
 yPCcl0q9G0sqBJPWZpNdrwyWYUQfWrWUQMZ5zFPhFrDvgBW6MRLXSBU4vBe+eo3zwC+ujIa48Gb
 hryXQ9x8ls1dI9vpPmpX8uo9RQT4VAVIAn0pL+rrU8f+/wAU293uGOcL9usDSSm1IFvYH/LP+vY
 G5Woqcrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

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


