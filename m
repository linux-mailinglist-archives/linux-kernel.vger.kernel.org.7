Return-Path: <linux-kernel+bounces-818317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191BFB58FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40322A5C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC0528B4F0;
	Tue, 16 Sep 2025 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TTLh0RxD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EEF283FCD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009534; cv=none; b=Ng2+ZyL95Y2LE7ZXYpC353NTWNxA1cKAtwdmNsIZpAsFoUxP5fLjtYu6HvGH0at6alrxeihhLJ3YS39jRaa+IhoVS0bpZNV0EhnTy8pc6v9c+SDPtk1wBxGI+NXJzi3200elFKDOnWx6dSiUP4Mm6IT6FjoqZ7hjX1vhDJvAGM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009534; c=relaxed/simple;
	bh=2aXZmh6F3xOiaqscU9l6NzhkcAQGluwavusGXS7pIzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sZOKnMhhf4ffOPUCiY23TLZ1p8fEfamRat5dgfsW7NS3npXuCA/nQhcf8J4S1Rpdcy51JKJVSOTCr5EInfMCJFDvdG+Qi3ZW5hIYq3EUq6EZSxdq3gvHR9UBD24QrAraCwSNWkniGmjO9GNfJ2KpqcKCsLYWDt68FL8ztj5BX4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TTLh0RxD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3pcWv004961
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JR5nfKZ7+zaEZ5/1Y8IMPP7/hoX23enteT8aPv3ltBU=; b=TTLh0RxDnNphpL8m
	5DP0vt9kWTw0muEXgKKbNt/f9CH64VrEEMgnaLZMm7SnMtaojkTwOu8QMiF4W6Hr
	/eS/bXv/CLepxeHUTQsvh413T/4g7gKxKccfhZfoVsFc9QNlA0nrblb/Nyciy2Je
	Q3lPjgG+6/1eL2bSPhGiNIgAMxUNo8t6gAQvc/GRVbQ+wS2L5HdgYmSvaCjuK/5v
	sYxVe8I12/cRV5i+sucEnZBz1HP7Pus1qsesdXJTCIq4dHuqvYfVQKniUHLTPkXa
	ynKkoL5GfAHSvLXOdXzUbSbuO1YhAuOrcElHEItPF8MPkdW9oN25zmkA/KbYR9Kp
	W40wDA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950u57w0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:58:51 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7724bca103dso5109684b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758009530; x=1758614330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JR5nfKZ7+zaEZ5/1Y8IMPP7/hoX23enteT8aPv3ltBU=;
        b=lJ7GEb/XJ3fDLSGgviJHBgKlXC1UlgWuBSoZtlnmaTF+rmK+L3yGlTj+owNgjNUylj
         z3Lxl/9pQkBZqtxKk6GeFFK0RNt7ltuvTx81ktFtjbdRtgHlxhW1GPUc3dk+Jw+73V70
         p5nKWGiKMMlkIm6P2KfNVV+d79nsrdDLfTgByi2+TAEl2EjFI/9NZziWY0NlbdTRNhL/
         DB0h+o12+PAvXyV4Mu4rZqPuR2dJJxET4QD72hhNQBSwE++3sL838FgoHCLgC26k4eMx
         C/Ydt2F1SMYzc0tPBna2I1M3phyERz4tMPSzBEKXXu0cErGk3dDqoONbwuPlXmKo4kbO
         vlqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnEX8GQaLBn3cSGNfCimMUi4G2jOYGN6NJApw9iVknVs8CQd9ZlIwL0WvfCkd8I4qfyLw9AvxFK0zGvsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5RyHs6mEad7/6sBqxOPGjnWHRhN9MP6dhjefGrqjo6OLv92Ma
	NhQW3XpXnYhDTQG6v+3Jixi1e8HnGaQyj235GnNrGUkQRZ79hvXBgjH4OuJ1VBvOSoXeHmNf0m0
	bHwNlIaZTtJifgBmLvtoA2idH/9In4Mk71XZXHT7KwVXqNTPpqNcplqEk3HPNCYHO/auVzPN2A4
	U=
X-Gm-Gg: ASbGncv2rixH/1t3WxHZG8C9MyOrE9R3mMpwCNnOuxJVHujXS1+Rz4BfnrnClj3T250
	pEDKV7xIcpv0CW8JBRYq5JMZjYw1JugZn+lnZfbwGfvNpICr/yvP+5hHFNxOTD3ADwOgPAou18V
	9qasBFvn+DYd69oqU9MZVx5ya+0qZ4N35F7XD8Ry9GFvoAFnNyzxGLy45JXpB08vFlFypo/SUFo
	mzfZ1gYP4lariXDvNjppew0bHN3uPcLLOkgqDxRnE9yVdZDi2jigSSNcKontTE9MJKiJkEaMFr2
	SWc0RA7OIBllNVnwn++y9HPj5Lp61cEEVP9RyBBwrLf4nbJokOq9cRkDBBmXile2+Nx8U1Zx7cZ
	ZHbG92aHEWfiZ06J9OMvD87K1jw==
X-Received: by 2002:a05:6a00:a96:b0:772:5b16:1081 with SMTP id d2e1a72fcca58-77612197533mr17561420b3a.28.1758009530212;
        Tue, 16 Sep 2025 00:58:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkHGS4ZNO8tD/dElI9ocK/ppPjjLxZcs/o51PwTeXveLlzzWlmipuiggD2VPOZ9NxnEuEF0w==
X-Received: by 2002:a05:6a00:a96:b0:772:5b16:1081 with SMTP id d2e1a72fcca58-77612197533mr17561388b3a.28.1758009529743;
        Tue, 16 Sep 2025 00:58:49 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7761af2e09dsm11292222b3a.76.2025.09.16.00.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 00:58:49 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 13:28:18 +0530
Subject: [PATCH 4/4] regulator: rpmh-regulator: Add RPMH regulator support
 for Glymur
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-glymur-rpmh-regulator-driver-v1-4-bb9b00e93a61@oss.qualcomm.com>
References: <20250916-glymur-rpmh-regulator-driver-v1-0-bb9b00e93a61@oss.qualcomm.com>
In-Reply-To: <20250916-glymur-rpmh-regulator-driver-v1-0-bb9b00e93a61@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758009510; l=10437;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=2aXZmh6F3xOiaqscU9l6NzhkcAQGluwavusGXS7pIzY=;
 b=8JMyDqU2YTv2BQNEPEkawf83D/Njru0h3yoPecuOat20QmiznVms5Zn1ybr+WWTcEgZa+zre6
 ACFYGlyg+uLAKHOM3cU6KJcxZtVKCaVEdNTj5Z5ytGwgT+HXfL8FN7/
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-GUID: YbqbJbvAd5KlsfyDT0L_blswBEhD1ibY
X-Proofpoint-ORIG-GUID: YbqbJbvAd5KlsfyDT0L_blswBEhD1ibY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMSBTYWx0ZWRfX/QSVFkOWLpb/
 JtZzEiv9dS2XKrgyGf2fmNQ1Ckt7z5zBlO1gvaX9WIyjbaOSWyWi+EWeR35utd2LcymCTu3q8zk
 vocrflvHKIEraOBSopeSniLsyQR6oO3A4XurCS5sukI9m+Ef4iJBySmi6YrUi9W3JK18recldYZ
 JbCrVcg+WxbMBedNEeqp9/9WZW8E3JWYolHcatKpffegkCLjvfWtcniMZSjEobrKxLFL53Blmd5
 nbYgKSMP8ccczzavWNix7GtCGts4x0L/Xeyi/UjlGpHDo22wlm/AWgxVpAkshIY1WQ+Ft3Bfi6R
 WefkCfOUpODXo6DOGMu+XW/gfEniKt0I2Pm5r7FJCmHdBwyvHiwt3NToT3TFM1VgnKA4bl7peQZ
 MSBbbI3e
X-Authority-Analysis: v=2.4 cv=JvzxrN4C c=1 sm=1 tr=0 ts=68c918bb cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=dDmaFaQidGiDpGwu2EkA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130031

Add support for PMH0101/PMCX0102/PMH0110/PMH0104 PMIC voltage
regulators which are present on Glymur boards.

Introduce new LDOs & SMPSs under them (PMIC5 subtype 530 for
both).

For these new LDOs support a new optimum power mode(OPM). In
this mode LDO will automatically switch between high power mode
(HPM) and low power mode (LPM) based on the real-time LDO load
current. Its operation is analogous to SMPS AUTO mode.

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


