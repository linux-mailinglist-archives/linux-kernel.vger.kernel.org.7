Return-Path: <linux-kernel+bounces-739761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F8BB0CA90
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161196C10EA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024682E4992;
	Mon, 21 Jul 2025 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mNot2AE5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DAA2E267A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122605; cv=none; b=Vq2lcROJfkXmOYAjbP/drcjqQ5s++AwmPr0y8jneMbGv9tonZFoX0qfONwluBL+2TFCZ3BemGhb8k483W9HVL6ExfTKjlxEI4O/LTh5HXsoWwBQ3IjFzEdYzp3xzug01/a4GOfsklujj3mW4yJ7ewXbJPTmwkbgNPYjBXAY8sVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122605; c=relaxed/simple;
	bh=bDYj8SCrzcBMYL0De2l91EChlN4ZQ8qlnKnsadPkWH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rofN6u84+Uk6sr9dKRgqMsqpqZCRYGVzpdArvd8g6hj1FvQ6Z63xNB/WE3pKQbkN0ButNoo/vS4nf+66LiDZpyLiQ8KsL/jrzVSwhzD/I/BUsE6HM1aOF6bQlYoXB5YDTJbJrnhqs/B/6tNL2/xCjyUfa2So3Csk/KyDqE3MWLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mNot2AE5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LGNSBl016585
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zO1m4Mu1s9USWMxZJk5OY8bYzy46q5JS7Is6cMJU9ok=; b=mNot2AE5X+lLUtlJ
	fUnS3BfpKFpZ7Bj90v3GMQNCk0NCARF4DgF0lher6/I/WSnZ42DJrD9xo9KOGNzv
	2LH5sxsi1FluiEm2/xdjkQ/P+n9rkh7MmW0q6zBu9A4qrzpExhGmZNoIZVE1hZUQ
	JK15qBRcsUBN+fXDTBbBAdoJw/hYNW8+2txn1UWlYcwqhsNjtXqghCEHcDOs1x/c
	DtJcqtQiPaTGyfJdVETmQ0qfDi2b3tMYAxNjbM6nQRUD/XQ19j9Jkf+9WZ+2tlvn
	8tJGquyfU9KF+LfsVrYU6/UHMXrWkMS12EPSwBg3rt/YBxXFJxHAbKbwaBMCRWnI
	gyTBhw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048rxv57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:30:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235089528a0so46066005ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753122601; x=1753727401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zO1m4Mu1s9USWMxZJk5OY8bYzy46q5JS7Is6cMJU9ok=;
        b=qIos3iV+iGhAjFhHowNor8dsj6qsNYSaNCtQ6FFCccYa+I7PMSBVwCeYJZ/9d5PU3W
         yHqgx51RQj8A6yxpNTYr7FhCacOdueGlp8T2Sy859iAx3mvOkVO/gSPYT/mwBnof6gQu
         qvIUbtuNtPCylynGUOuF6sVe1ddeo9D5071ofKRTHgBPjEvwunkD/xb45Gh7uUxPI3QB
         MVkfhBadEJHKCsLZbrVMhBwF02v1Y+sHLf4zlePjoqFZ9LSjuelaBlIw/z5YqH5EU0w2
         /QL01mSkGuuMYspQRk9eDUBwQv0V6EB1MWmLtLJ00cp3gP6eFxZmGJLFjOKBp4P1bKZN
         xPlw==
X-Forwarded-Encrypted: i=1; AJvYcCVXLXZtT+4YhuZeHcritvhaECYMkwDaWJXBYLq/muD36MQG4iREpxp5YNPV7pdjUNF59Z2aTqCfKyKZSmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfYlbHeFoebAy95i8c/jEyLHIPkZrLtWo0pM8kMKZng/Oz4r/
	BgZBK17oDLkxmvrDVBkKmWW+8h5KDhsTA9CAABDX8YluRA39K/UIo0kJd0+0eEjZYciR9SgTcTl
	qIfKcFaqSUddkDFeNDUzfG+Ckfh/HwQR3Gje/KcTO6D8AvipFnXmWLOc/T+iXVm1QCC8=
X-Gm-Gg: ASbGncvIIRwOPY/YEph2gKUYePQ5jV3qE6ecdF34HZvjjzhG3ifPT4aYZ19y4F4n1bs
	eojEs6fRI4upL2ZN+fNtcDwUoFP8Def+uHC+CW1qXyVbI47O1YS2dnVs+H2l+q9zIy/G5Q1T/b5
	Dxej+BQ3G+5Lktcmgmqrwb/56eDPIILAzxHTfyYu7ll54h6zDaRfmuz8wKuagARpfZ1v+0y1444
	+189UBpT1RTqigvBw7kZJUHknTNM44SoWnahT4QXamUVJH/adzttbMkaR1A2umg3eHl8O3jAHeu
	Lkvkz21maGNM+gO74nchQv7JjnIkCQx251Fbh4NUWU0cPJWdx88on/Ne4DjKG2F8vLy0A3x8dun
	s
X-Received: by 2002:a17:903:1247:b0:236:15b7:62e3 with SMTP id d9443c01a7336-23f8ac5c086mr6239575ad.9.1753122600871;
        Mon, 21 Jul 2025 11:30:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEiVeGtNV9GmrNVrD6U4nu+8UhEiUkMzdQ/98qBAr+cTMXNUdE4x3JFAM19mTP1eT+MB3fNw==
X-Received: by 2002:a17:903:1247:b0:236:15b7:62e3 with SMTP id d9443c01a7336-23f8ac5c086mr6239105ad.9.1753122600430;
        Mon, 21 Jul 2025 11:30:00 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef4b8sm61414545ad.194.2025.07.21.11.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:30:00 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 23:58:54 +0530
Subject: [PATCH v12 7/8] arm64: dts: qcom: sa8775p-ride: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-arm-psci-system_reset2-vendor-reboots-v12-7-87bac3ec422e@oss.qualcomm.com>
References: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
In-Reply-To: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753122539; l=1668;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=nykICX8hQVOI73Pb+LH6QfNsfIbx6Lek13GmZ+0SmB4=;
 b=g3A+MwUIEuwhNYH7AEZ+1Tszhqr06K8jZVVPYm2Soy7Wcl0QigvUOomREQzxuSnNsq9GSDF2n
 TBAB47HabTaB4SXq+0WPD3nEzI4RciQ7fU3duwR5zUVb3BDxCSqUvDf
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE2NCBTYWx0ZWRfX2TXWRjyn/jZA
 c/bERqlb8T8Cg4HYNidi/Knn1cNxMsag5z/iNvKEkIlEd7M67fevwwFA9gcDRL5zzZTDwVJCLyR
 C6DGLixRUBrURIMEErwbdZEtEz/SMJuwICF1OhBB0KwDo4brL1CfBLaYM2ik6UelNOS9MMunL9j
 JbCSnPD2oUnCwIEx9lJ+dDrt61wVP+Yq5SxZzgmywozg9rpkysfoS9l/g2QMvfi9QC3+2/0RIwS
 HdUteexKucoCoc4TPsrRBaszi+nIJdW+UjhGsZbVLncVcu6H0Oh9YE2571jo3i4wFHH2YN5qcPy
 uVQyIONKuPA+qg2KUMCTMpdcCIA+7z5ohUnQ6BMrLxSUogbFZ2inQT/LT0ozZSnQfCpggvs1V8k
 SWd2Rfz8WQXdiJWQsoOznL0hiG4Bg1xa+PbGfcVhnVSbnxT7EQN3mz7qP3eVFwq5Z/0j8MrW
X-Proofpoint-ORIG-GUID: CXfQnmTHWoaEY4_qEc_0IbUeoSgfbOlH
X-Proofpoint-GUID: CXfQnmTHWoaEY4_qEc_0IbUeoSgfbOlH
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687e872a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=w06kbW2hXDg5FjFnD0gA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210164

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add support for SYSTEM_RESET2 vendor-specific resets in
sa8775p-ride as reboot-modes.  Describe the reset types:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode.  "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 7 +++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi      | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
index 63b3031cfcc15fe2cce58c0fb7502b19f058b80c..b1bbd3270afc65e9e036e8098ae7cec3d3363a32 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
@@ -874,6 +874,13 @@ &pmm8654au_3_gpios {
 			  "GNSS_BOOT_MODE";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x10001 0x2>;
+		mode-edl = <0 0x1>;
+	};
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 9997a29901f57d7894dc1eacb6a809caa427c6c4..52466607035e663f4dc6e5c97223d5c0404650e2 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -622,7 +622,7 @@ pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


