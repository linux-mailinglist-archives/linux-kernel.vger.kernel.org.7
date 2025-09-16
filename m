Return-Path: <linux-kernel+bounces-818820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1156B596CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6118A189ED75
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FBC30DED0;
	Tue, 16 Sep 2025 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L9Ok/tn9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFE127FB1B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027585; cv=none; b=BHHtKsavWYh7gepqifyadG8WKPvfPVwDv87Ua6xxI65IMzxQc4bd6nVRc4jaBFL5kde/MJEBA6UCfgj/nb/pyGg2iSC4FHWBm97ukVwB6gccXaaDbLjEWsh8bIkPrtYzsJyBogAK3pV1wCg3/91mNrQ+S9JJTqibFQaWlgtAygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027585; c=relaxed/simple;
	bh=8DjiqF9dsirZN8Wj8tPx56+m+sxSZo9peHaaF1KXOOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o5sEX3W7Iv8Qxci9wQ7KuYNg4bIVn8mDSwr/6LqlfDBgjnniawWk26McXdLleEklFF8AnA6tTOD4Y7Ie35zoQ6N/2ruDaHVd6QKTVOO6BZrulm5KarBzuEK5a1Tx29HtHBDHhe9524f7TKw+EJgx61g0hxJy1MQ4HnGfb1MwBcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L9Ok/tn9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAInOL010531
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xI6mJO0WSpiUbkh3Fk6DlwuwlKEmE4hv9DpqkjAEEq4=; b=L9Ok/tn9VHvrO8H7
	U6zPJ7ZcwNrKLXJcmg57z5q/2fmI+ei3gFfnk7UfkVhG1PnlecQDiCH0lyOxe7tI
	zw2urHqp/GcrJNSXtKXAABxavlYWdNRDdPw6mnUaZEXNWu5bPFkEHlTqvT8AjTUV
	YoO+iQ/olCTZinYmJOwfjHVrUffgO94xf6fVnPRGnAUC3mD7oboOwDgE0ZVaCodO
	Pae/FlaP1Wizo6yp47eQ1oHLGgBvoy/gTenZX1CYR/mTxOtUe6qDI5uGtjKURsCX
	X7RxFHYRIxU3m02+xGFk1lu2sZHisNn7DkPGtHPriZs6WCp5hsL/xjvc85OHReF6
	/Zm42g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snrq0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:59:42 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7725c995dd0so5046607b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758027582; x=1758632382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xI6mJO0WSpiUbkh3Fk6DlwuwlKEmE4hv9DpqkjAEEq4=;
        b=orEkp453P8VMHaYLuOESWz1Q8QX5BnCWPEtb4phM03dOSlcbWi5uCHqlRR2rF+PSJx
         07UKuaZ2ywVx3/hzDmCFVTwtoQCLOicwQaOqKVXMjvuFxK+y8TelLD9uwIRi86kkTOYj
         wnOopI4DvVIq7rDgfKpbqusZ56NeuY+FFEhfhObD+b2000zJm5NpDQfxcAna6jGTc/Ei
         806xNwdGPlfEXgTx9XXwwZy0HOjnDdXw1pv+YtZYYk1XfKI+w/UG622DIMaUl6+GnQFa
         gfyjXJNRPTDAn1QdDUbp/ScsYL5cURMYUbNf+3Y1LfnyiN8mUT59NQHNG/3wX9DDJxTf
         aRfA==
X-Forwarded-Encrypted: i=1; AJvYcCVKtazgd9PJPX3Q/iVMF7rMsjdZYHk4brlaMGe8aphMLmQ4n/r3YwoBxpsWJR4jw5iRhFpSrl4li+NRzeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxE8dHN70YVFakL4Uuof4fl6FJRIdZp/J/Ev0LBUGGmZVBKBf/
	CvhmiLXgwJeckZNTdW54hV/tGuRtjykxCfQg44uXPDAoESe/swtauJuByjvaguCi+wRu2DhZkqv
	8GPO0eEc29q/0Kjh3W1y/ypiYpKUXyREtiNya6YAsJXflE7EMYF8GyPmv0h8urso4qkk=
X-Gm-Gg: ASbGncsQdtIg34uxDAzpmQ0DKOWnDZl0eIjJZlNf/CyiNx66CxQhdVwUvpm225y28Tq
	dkpPS5pqFcdImPSHnGmoOFKwRZy0Af/QNNkGzgc2Spy1e6pbLIPgHs6Rcj0rbO18rpJ+jhkiHga
	YcrL63ft+OwwjX1IoXLRjbj+FJs3hc4yPYCqCuUip9IXYuxnocYV3dD2MnrwONw4gMcATAPYBqJ
	X/IYZrEh1uDutfEpV9q9ou/pCsZnDrocKTgN7EPlplrq2juN0zMXJZvVF7wGLUYSzY+dAVOXliP
	1aat588FVtmpScnX07Dw47AMH/0+ySQVY5cZXPrhZqTCgoFJBZg7A9JrrorvX5Rj1ypFVG/U2e8
	gGbDmyNKWVBww+3heHJEtiC/qrg==
X-Received: by 2002:a05:6a00:198f:b0:777:b207:47b2 with SMTP id d2e1a72fcca58-777b2074ad9mr9441672b3a.2.1758027581738;
        Tue, 16 Sep 2025 05:59:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhN4Xzzrl+1mDMnm/2AZgUf02oPH6Ty5Luf35YfHuhuk676H+GKWavY6ePU8C2eVYv8/mpfw==
X-Received: by 2002:a05:6a00:198f:b0:777:b207:47b2 with SMTP id d2e1a72fcca58-777b2074ad9mr9441648b3a.2.1758027581257;
        Tue, 16 Sep 2025 05:59:41 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a46b7asm16057113b3a.22.2025.09.16.05.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 05:59:40 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 18:28:55 +0530
Subject: [PATCH v2 4/4] regulator: rpmh-regulator: Add RPMH regulator
 support for Glymur
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-glymur-rpmh-regulator-driver-v2-4-c6593ff9b4be@oss.qualcomm.com>
References: <20250916-glymur-rpmh-regulator-driver-v2-0-c6593ff9b4be@oss.qualcomm.com>
In-Reply-To: <20250916-glymur-rpmh-regulator-driver-v2-0-c6593ff9b4be@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        jishnu.prakash@oss.qualcomm.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758027561; l=10504;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=8DjiqF9dsirZN8Wj8tPx56+m+sxSZo9peHaaF1KXOOo=;
 b=8YG5ki8tMtB1zV4wZ78LeW34v3Znai26VsfAPDX65i2h9ZJb/wdHh/Mm2tYcQS1s53XO1V2fF
 ZuXQoDGIfS5ARb7oSSeQQg+Dh0CMUD/YsjBwk4YdsBM6izYsfjMcCMh
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c95f3e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=dDmaFaQidGiDpGwu2EkA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: E0T584yfpGaOeT6LP7gEfH4T3xxxs-g3
X-Proofpoint-GUID: E0T584yfpGaOeT6LP7gEfH4T3xxxs-g3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfX3BerJwJUTI8O
 e3+obQT2UlaXoIF8nfNfeTHfSlCISRieyR/fQ9PO6rVuU73bE/reut3z6P6GYzucBDSznftZ314
 aOkeYRZdFQvqY4IYFLUcaUG/Z1zM+AZ4krrGODnMk1bog1ejmSxPCkcRkSgAHm20EqRB+2u5jCd
 UEOqmitveu5bwMPdYD8y6ahkSyoqLM2N9WRQEJY4z9Y6GG4swgc9ZEeVX5A6oV+3uwtERZ8825l
 /4TgCp5SZP/sqDXuC+yUbEmK4oK6ynjy2KqLtPAxNa5NegrSCxUAn2Op/309LEZAydNYVZfVjsh
 NtcE+GjtxUPd4yzA0ipOOyvU/Tt1Lr4D26fpl7HDfgVVhE9BkDp/HlsRwuNP3NTFIYgknHdiZQt
 ZwG3arwF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040

Add support for PMH0101/PMCX0102/PMH0110/PMH0104 PMIC voltage
regulators which are present on Glymur boards.

Introduce new LDOs & SMPSs under them (PMIC5 subtype 530 for
both).

For these new LDOs support a new optimum power mode(OPM). In
this mode LDO will automatically switch between high power mode
(HPM) and low power mode (LPM) based on the real-time LDO load
current. Its operation is analogous to SMPS AUTO mode.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Co-developed-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
 drivers/regulator/qcom-rpmh-regulator.c | 188 +++++++++++++++++++++++++++++++-
 1 file changed, 187 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 525904956705cbb94a5abb63fb050eb967de4109..52e5499453b6931b6ab2e7aaa4bdba1978c4d69d 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018-2021, The Linux Foundation. All rights reserved.
-// Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
 
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
@@ -91,6 +91,11 @@ static const struct resource_name_formats vreg_rsc_name_lookup[NUM_REGULATOR_TYP
 #define PMIC5_BOB_MODE_AUTO			6
 #define PMIC5_BOB_MODE_PWM			7
 
+#define PMIC530_LDO_MODE_RETENTION		3
+#define PMIC530_LDO_MODE_LPM			4
+#define PMIC530_LDO_MODE_OPM			5
+#define PMIC530_LDO_MODE_HPM			7
+
 #define PMIC_ID_LEN				4
 /**
  * struct rpmh_vreg_hw_data - RPMh regulator hardware configurations
@@ -556,6 +561,14 @@ static const int pmic_mode_map_pmic5_ldo_hpm[REGULATOR_MODE_STANDBY + 1] = {
 	[REGULATOR_MODE_FAST]    = -EINVAL,
 };
 
+static const int pmic_mode_map_pmic530_ldo[REGULATOR_MODE_STANDBY + 1] = {
+	[REGULATOR_MODE_INVALID] = -EINVAL,
+	[REGULATOR_MODE_STANDBY] = PMIC530_LDO_MODE_RETENTION,
+	[REGULATOR_MODE_IDLE]    = PMIC530_LDO_MODE_LPM,
+	[REGULATOR_MODE_NORMAL]  = PMIC530_LDO_MODE_OPM,
+	[REGULATOR_MODE_FAST]    = PMIC530_LDO_MODE_HPM,
+};
+
 static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int rpmh_mode)
 {
 	unsigned int mode;
@@ -578,6 +591,30 @@ static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int rpmh_mode)
 	return mode;
 }
 
+static unsigned int rpmh_regulator_pmic530_ldo_of_map_mode(unsigned int rpmh_mode)
+{
+	unsigned int mode;
+
+	switch (rpmh_mode) {
+	case RPMH_REGULATOR_MODE_HPM:
+		mode = REGULATOR_MODE_FAST;
+		break;
+	case RPMH_REGULATOR_MODE_AUTO:
+		mode = REGULATOR_MODE_NORMAL;
+		break;
+	case RPMH_REGULATOR_MODE_LPM:
+		mode = REGULATOR_MODE_IDLE;
+		break;
+	case RPMH_REGULATOR_MODE_RET:
+		mode = REGULATOR_MODE_STANDBY;
+		break;
+	default:
+		mode = REGULATOR_MODE_INVALID;
+		break;
+	}
+	return mode;
+}
+
 static const int pmic_mode_map_pmic4_smps[REGULATOR_MODE_STANDBY + 1] = {
 	[REGULATOR_MODE_INVALID] = -EINVAL,
 	[REGULATOR_MODE_STANDBY] = PMIC4_SMPS_MODE_RETENTION,
@@ -941,6 +978,71 @@ static const struct rpmh_vreg_hw_data pmic5_bob = {
 	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
 };
 
+static const struct rpmh_vreg_hw_data pmic5_nldo530 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(320000, 0, 210, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 211,
+	.hpm_min_load_uA = 30000,
+	.pmic_mode_map = pmic_mode_map_pmic530_ldo,
+	.of_map_mode = rpmh_regulator_pmic530_ldo_of_map_mode,
+};
+
+static const struct rpmh_vreg_hw_data pmic5_pldo530_mvp150 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1504000, 0, 255, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 256,
+	.hpm_min_load_uA = 10000,
+	.pmic_mode_map = pmic_mode_map_pmic530_ldo,
+	.of_map_mode = rpmh_regulator_pmic530_ldo_of_map_mode,
+};
+
+static const struct rpmh_vreg_hw_data pmic5_pldo530_mvp300 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1504000, 0, 255, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 256,
+	.hpm_min_load_uA = 20000,
+	.pmic_mode_map = pmic_mode_map_pmic530_ldo,
+	.of_map_mode = rpmh_regulator_pmic530_ldo_of_map_mode,
+};
+
+static const struct rpmh_vreg_hw_data pmic5_pldo530_mvp600 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1504000, 0, 255, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 256,
+	.hpm_min_load_uA = 40000,
+	.pmic_mode_map = pmic_mode_map_pmic530_ldo,
+	.of_map_mode = rpmh_regulator_pmic530_ldo_of_map_mode,
+};
+
+static const struct rpmh_vreg_hw_data pmic5_ftsmps530 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_ops,
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(252000, 0, 305, 4000),
+		REGULATOR_LINEAR_RANGE(1480000, 306, 464, 8000),
+	},
+	.n_linear_ranges = 2,
+	.n_voltages = 465,
+	.pmic_mode_map = pmic_mode_map_pmic5_smps,
+	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
+};
+
 #define RPMH_VREG(_name, _vreg_hw_type, _index, _hw_data, _supply_name) \
 { \
 	.name		= _name, \
@@ -1375,6 +1477,74 @@ static const struct rpmh_vreg_init_data pm6350_vreg_data[] = {
 	RPMH_VREG("ldo22",  LDO,  22, &pmic5_nldo,      NULL),
 };
 
+static const struct rpmh_vreg_init_data pmcx0102_vreg_data[] = {
+	RPMH_VREG("smps1",   SMPS, 1,    &pmic5_ftsmps530, "vdd-s1"),
+	RPMH_VREG("smps2",   SMPS, 2,    &pmic5_ftsmps530, "vdd-s2"),
+	RPMH_VREG("smps3",   SMPS, 3,    &pmic5_ftsmps530, "vdd-s3"),
+	RPMH_VREG("smps4",   SMPS, 4,    &pmic5_ftsmps530, "vdd-s4"),
+	RPMH_VREG("smps5",   SMPS, 5,    &pmic5_ftsmps530, "vdd-s5"),
+	RPMH_VREG("smps6",   SMPS, 6,    &pmic5_ftsmps530, "vdd-s6"),
+	RPMH_VREG("smps7",   SMPS, 7,    &pmic5_ftsmps530, "vdd-s7"),
+	RPMH_VREG("smps8",   SMPS, 8,    &pmic5_ftsmps530, "vdd-s8"),
+	RPMH_VREG("smps9",   SMPS, 9,    &pmic5_ftsmps530, "vdd-s9"),
+	RPMH_VREG("smps10",  SMPS, 10,   &pmic5_ftsmps530, "vdd-s10"),
+	RPMH_VREG("ldo1",   LDO,  1,    &pmic5_nldo530,      "vdd-l1"),
+	RPMH_VREG("ldo2",   LDO,  2,    &pmic5_nldo530,      "vdd-l2"),
+	RPMH_VREG("ldo3",   LDO,  3,    &pmic5_nldo530,      "vdd-l3"),
+	RPMH_VREG("ldo4",   LDO,  4,    &pmic5_nldo530,      "vdd-l4"),
+	{}
+};
+
+static const struct rpmh_vreg_init_data pmh0101_vreg_data[] = {
+	RPMH_VREG("ldo1",   LDO, 1,  &pmic5_nldo530,      "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo2",   LDO, 2,  &pmic5_pldo530_mvp300,      "vdd-l2-l13-l14"),
+	RPMH_VREG("ldo3",   LDO, 3,  &pmic5_nldo530,      "vdd-l3-l11"),
+	RPMH_VREG("ldo4",   LDO, 4,  &pmic5_nldo530,      "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo5",   LDO, 5,  &pmic5_pldo530_mvp150,      "vdd-l5-l16"),
+	RPMH_VREG("ldo6",   LDO, 6,  &pmic5_pldo530_mvp300,      "vdd-l6-l7"),
+	RPMH_VREG("ldo7",   LDO, 7,  &pmic5_pldo530_mvp300,      "vdd-l6-l7"),
+	RPMH_VREG("ldo8",   LDO, 8,  &pmic5_pldo530_mvp150,      "vdd-l8-l9"),
+	RPMH_VREG("ldo9",   LDO, 9,  &pmic5_pldo515_mv,      "vdd-l8-l9"),
+	RPMH_VREG("ldo10",  LDO, 10, &pmic5_nldo530,      "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo11",  LDO, 11, &pmic5_nldo530,      "vdd-l3-l11"),
+	RPMH_VREG("ldo12",  LDO, 12, &pmic5_nldo530,      "vdd-l12"),
+	RPMH_VREG("ldo13",  LDO, 13, &pmic5_pldo530_mvp150,     "vdd-l2-l13-l14"),
+	RPMH_VREG("ldo14",  LDO, 14, &pmic5_pldo530_mvp150,     "vdd-l2-l13-l14"),
+	RPMH_VREG("ldo15",  LDO, 15, &pmic5_nldo530,      "vdd-l15"),
+	RPMH_VREG("ldo16",  LDO, 15, &pmic5_pldo530_mvp600,      "vdd-l5-l16"),
+	RPMH_VREG("ldo17",  LDO, 17, &pmic5_pldo515_mv,   "vdd-l17"),
+	RPMH_VREG("ldo18",  LDO, 18, &pmic5_nldo530,      "vdd-l18"),
+	RPMH_VREG("bob1",   BOB, 1,  &pmic5_bob,          "vdd-bob1"),
+	RPMH_VREG("bob2",   BOB, 2,  &pmic5_bob,          "vdd-bob2"),
+	{}
+};
+
+static const struct rpmh_vreg_init_data pmh0104_vreg_data[] = {
+	RPMH_VREG("smps1",   SMPS, 1,    &pmic5_ftsmps530, "vdd-s1"),
+	RPMH_VREG("smps2",   SMPS, 2,    &pmic5_ftsmps530, "vdd-s2"),
+	RPMH_VREG("smps3",   SMPS, 3,    &pmic5_ftsmps530, "vdd-s3"),
+	RPMH_VREG("smps4",   SMPS, 4,    &pmic5_ftsmps530, "vdd-s4"),
+	{}
+};
+
+static const struct rpmh_vreg_init_data pmh0110_vreg_data[] = {
+	RPMH_VREG("smps1",   SMPS, 1,    &pmic5_ftsmps530, "vdd-s1"),
+	RPMH_VREG("smps2",   SMPS, 2,    &pmic5_ftsmps530, "vdd-s2"),
+	RPMH_VREG("smps3",   SMPS, 3,    &pmic5_ftsmps530, "vdd-s3"),
+	RPMH_VREG("smps4",   SMPS, 4,    &pmic5_ftsmps530, "vdd-s4"),
+	RPMH_VREG("smps5",   SMPS, 5,    &pmic5_ftsmps530, "vdd-s5"),
+	RPMH_VREG("smps6",   SMPS, 6,    &pmic5_ftsmps530, "vdd-s6"),
+	RPMH_VREG("smps7",   SMPS, 7,    &pmic5_ftsmps530, "vdd-s7"),
+	RPMH_VREG("smps8",   SMPS, 8,    &pmic5_ftsmps530, "vdd-s8"),
+	RPMH_VREG("smps9",   SMPS, 9,    &pmic5_ftsmps530, "vdd-s9"),
+	RPMH_VREG("smps10",  SMPS, 10,   &pmic5_ftsmps530, "vdd-s10"),
+	RPMH_VREG("ldo1",   LDO,  1,    &pmic5_nldo530,      "vdd-l1"),
+	RPMH_VREG("ldo2",   LDO,  2,    &pmic5_nldo530,      "vdd-l2"),
+	RPMH_VREG("ldo3",   LDO,  3,    &pmic5_nldo530,      "vdd-l3"),
+	RPMH_VREG("ldo4",   LDO,  4,    &pmic5_nldo530,      "vdd-l4"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pmx55_vreg_data[] = {
 	RPMH_VREG("smps1",  SMPS, 1,  &pmic5_ftsmps510, "vdd-s1"),
 	RPMH_VREG("smps2",  SMPS, 2,  &pmic5_hfsmps510, "vdd-s2"),
@@ -1727,6 +1897,22 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
 		.compatible = "qcom,pmc8380-rpmh-regulators",
 		.data = pmc8380_vreg_data,
 	},
+	{
+		.compatible = "qcom,pmcx0102-rpmh-regulators",
+		.data = pmcx0102_vreg_data,
+	},
+	{
+		.compatible = "qcom,pmh0101-rpmh-regulators",
+		.data = pmh0101_vreg_data,
+	},
+	{
+		.compatible = "qcom,pmh0104-rpmh-regulators",
+		.data = pmh0104_vreg_data,
+	},
+	{
+		.compatible = "qcom,pmh0110-rpmh-regulators",
+		.data = pmh0110_vreg_data,
+	},
 	{
 		.compatible = "qcom,pmm8155au-rpmh-regulators",
 		.data = pmm8155au_vreg_data,

-- 
2.25.1


