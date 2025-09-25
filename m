Return-Path: <linux-kernel+bounces-831846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09258B9DB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CDF6189A7EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4090A2F0C7E;
	Thu, 25 Sep 2025 06:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I3d/0jBt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F2C2F99A5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782051; cv=none; b=eWYPseIGfc3pJz1jQANpSlaNXdbwsavzsTTMcz4yAL4s9Yo6cdAfOlv/9RS5EUkSS5hEQrS5tpYC5emkMhCP5yZylgC67OAzuV5Tn2Ay8qStJtX7kIKhecF7Wn21Hn52e33ClHCn+Y5QOdD5AwCE+6PxSXiRf7T3aET/Trls+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782051; c=relaxed/simple;
	bh=yedJEEqL4ZUtTo4ypXp6TiEKX/zqnJ9N75AqBUCVR0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nONyOqyqbx5YFUUaa0dY2TYn/2H8CCt7ysCwh3auXcm0JAay3fY/HttaD12ZoVjtgi4mVDqEnDWc0dJ7ruTqCTFkIP8tIS7HjGn1oZikUzeHyS5yCREzpVPnfn225KdjcvEOlp2aCPFTZeWJ2uYLliGVgaTVd1D0hn3zHMCeKTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I3d/0jBt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1Rx4G019931
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M+AtpvCg1CmpAe9sYGyWQJouaSiovRLjPzDEo50wF9Y=; b=I3d/0jBt86AqBxzc
	t24PNTRjUmNhpRlQ8ynOBwPJieYujq9GIIwsE91xzS6DAuRs9N9YxygtthLAn51i
	3dThV63mQF7pIwitdXiMj40qkf01Vi7OWHpA5g4dgsYHL7AhxXY5HqLyjx/O5xIz
	JvnenCEp7utn7irzfnP0v4z89SUoFDANLsOK2eWlU8DFm9UDz9EF6WBoigUPT/9e
	5WYTrlW3EFT2xqboDwvYo1ZgTgUEbreY+QB2LslmTW0dOBDJ7QczzBuhYZbIrZ3E
	qd6zvJHtlqmEAjtP0w9xgkyTQuiiUsIqD2bc8mGHY/KFPX8TDbe+6jwTDwCEtd4k
	nwJvSQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpe08xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-25d21fddb85so11142245ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782048; x=1759386848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+AtpvCg1CmpAe9sYGyWQJouaSiovRLjPzDEo50wF9Y=;
        b=Tw6rjmCFBvmMYcEvb+hRNKXQ4Vw4Vpf8pIg/LBJM290qU0W9wbh0VhmMuGCbVlszBr
         DRVi+dHX0P8+UqkQMOMnkHeljoI/LZn5NVQs59uWhbcgj2PN49GJJh1VUSBTk0aSN5UN
         hJz2i8XCK34em2TOE52jCcLK1SRqly8BfOXpKu0GfLxauVKFOCctirKUY1gpGRAN5ZSL
         3+2y6PwSs2bbYiO+e69s0Cp+vTkMMvkWH2r1s8uvOhdxD97hG4AmL3LpB84bpkid+4Ax
         KQtQBAmc5YQjbjAeZdST7CNGHtq5x72uFzPOLe81ra2bfhVMz/hBbgS3MSONcNliWt7l
         xVUg==
X-Forwarded-Encrypted: i=1; AJvYcCUMR3aGPt4Uoz4brhqCd766h3NFNSDwcGuN05qfBDQI2PhJozU5+1VhwSWlU0vk+6WfYFiNYnAcp03Id8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG0Q15mUgnZPwyKBMfJ6/LKJX3dBBnk2p1a2NI/7bXdmzNTrwu
	EZzwSnFts5XDrhjq/EVJ7Ao35JUC9y1KbW6ytW5zj7Bkeknvwp8GfY0uyEmUkQazW9zU7FclCzo
	k3aZnHww9bU1h6QeIAVfFb6eRryL4m4/0swRBsroY1CQUFr0U6Eu0XeeozbAOymQxhQ8=
X-Gm-Gg: ASbGnctjudKFrIiS5ZVkTFhmKvEuDyUQIfSKbf7rKhJE4+kJV5M0JnIHeEajQiGDe4N
	Pj9Eh/VZWfVAVa8LW8pN+2YPmAHieNu6bEIpdIHP5xiAECF5Dh3itsFmAlZYpGCdoBKYehOzbc8
	IxxO0VHkTMj+7NALJIeoRwveBAGDkTGAwdNoU6Jf/t1k3rf/xzpmlJPz2l1yiE1eU4PCpVK+W1o
	hVOYQLiHGiAJn+8dJ3c/EsYaTpC6zJ7Iu4tRd1ofMg1whCSFhPezd3I5KefX1RSG+I33qZ5zoqR
	7yaJ7nL1cXsu62YNM2Sq6Ut7Iy+w20Cti983CFjtCGdDXjDaoWo7vZAHSXCH14fDudEwnAlmWDY
	zJrO6RnDzJM4v1fT9Ztq7n8J1YfyLJEwTThSRtpawMJM1iEt3ZM54jx9rxkMm
X-Received: by 2002:a17:902:c94d:b0:26f:7db2:3e1e with SMTP id d9443c01a7336-27ed4a492b5mr23503965ad.47.1758782048361;
        Wed, 24 Sep 2025 23:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgrF8YXI5qrH2oGWaWVaROurOESlVDpfoWAlJYyO0U4Gqvvnt9Hj5fX1Qq40tnD437M10PWw==
X-Received: by 2002:a17:902:c94d:b0:26f:7db2:3e1e with SMTP id d9443c01a7336-27ed4a492b5mr23503725ad.47.1758782047864;
        Wed, 24 Sep 2025 23:34:07 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:34:07 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:23 +0530
Subject: [PATCH 15/24] arm64: dts: qcom: glymur: Add PMICs dtsi for CRD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-15-24b601bbecc0@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: JFuyHGeaLP3OpRv1Yj_JC0nwwXFBQG38
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d4e261 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=-PhwRXPgPXS4kyLjRL8A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: JFuyHGeaLP3OpRv1Yj_JC0nwwXFBQG38
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX3MVx7NOEEjkg
 oRIjChXr/dyj5vb+LQGfZUgFJs2yqJ0xRTJrSCTEE3xh3uAhU2RZrY4PBlkhEe75gUIPwf10Or0
 wdv/sSXb4cJEA+l4ikrMA69clcKHvZrV0Pp+3eSc/jcoICtn5tY/j7qVpUBjXXaWlyZuTeL6LcT
 l3iNZoe/iyqXP5Kkzy+tCDumQsF7opiIYJhrXBkFq9RqckcjlMtyWpCUNOBmfuwwNsz35I2N55x
 nFbd39JwlnYhJAhCyhcQ9d7EOOk+gEvaFi5ZRM7vtw/IRMpyQEtooka4mnieXbSAeJP39tDr6Df
 h+RYD/WkBjcRnoo7vaEAwGw5eEUzJ+Jo7vVUJq6hRLADQ3Gh+bQ9Nloo1UIn73Oiq/t09jpIYX2
 GPj/rW8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Include all the PMICs present on the Glymur board into
the glymur CRD DTS file.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts    |  1 +
 arch/arm64/boot/dts/qcom/glymur-pmics.dtsi | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index e89b81dcb4f47b78307fa3ab6831657cf6491c89..97f6eedd7222368f5cbfdd02e9c4d87261d7f19a 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "glymur.dtsi"
+#include "glymur-pmics.dtsi"
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/glymur-pmics.dtsi b/arch/arm64/boot/dts/qcom/glymur-pmics.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..59dcfb67a203a7c576406037377fc9fbdce51a97
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/glymur-pmics.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#define PMH0110_F_E0	0x5
+#define PMH0110_H_E0	0x7
+#define PMH0104_I_E0	0x8
+#define PMH0104_J_E0	0x9
+
+#define PMH0110_F_E1	0x5
+#define PMH0104_L_E1	0xb
+
+#include "pmk8850.dtsi"	/* SPMI0: SID-0*/
+#include "pmh0101.dtsi"	/* SPMI0: SID-1*/
+#include "pmcx0102.dtsi"	/* SPMI0: SID-2/3/4/6	SPMI1: SID-2/3/4 */
+#include "pmh0110.dtsi"	/* SPMI0: SID-5/7	SPMI1: SID-5	*/
+#include "pmh0104.dtsi"	/* SPMI0: SID-8/9	SPMI1: SID-11	*/
+#include "smb2370.dtsi"	/* SPMI2: SID-9/10/11*/

-- 
2.34.1


