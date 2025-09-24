Return-Path: <linux-kernel+bounces-831407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD38B9C942
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE841761EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D462C0261;
	Wed, 24 Sep 2025 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YywSEuG/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386729BD83
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756659; cv=none; b=bR92ndcH7nBHBSXpJQ7HuF2gfsB+6XRTyV/OyrXJvTqz8ROx8IlltjPYeJVjuntYI7nmuNFSwb3gRAfsjmhGCf3FxUAcHmZcubang00TVIvKMW08HWGkvvYo20sGPLY4ya/BiOa/UJbti3S5+bPWrBZQ78ekxDYBdwLMTgOlnf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756659; c=relaxed/simple;
	bh=PmL3qEb4yVlmb1Rm54bnjC1dI7aoNvZYOOkqVoRZxXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ayTpaPeLmwsRrbXfU1kYqG0Xio2EAM0Dm+fg2kC9iyFraVN44D/OAjgycHH7bIIGeO9NtwGw3NlfsTJFniqEe5xTsQh+O5lSrMFzbm7M9iOX9qXtuFxnmbuJKqU7lLpfd9uJM1d+q6MvmyNobEua2aaIqNvAkUxNyvW8ChwBeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YywSEuG/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCoZGT016452
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ox0nCprWF4+A8izOuWkf1k4m6mNZb7YM7KVt0A8RT4s=; b=YywSEuG/MWSdwNfC
	aDysg8djKeAZknC3tWDpxWchZdWdD6MQ8/TPWElIo3JxlZxEXD+JPIZmRvr+mhgj
	VRLBpWE0uOsi/ROy7Qy4+nb+H/ymnOjpNZJOnnH4+iWz9UiJm0EKEbP90ZmRirvT
	BrjZ7tQW5m5KQiKVcvKYPaoqT2Ps+cDq6S8mjl3SuLH4E2txk8D+7GgLbDJyj7V4
	GWZXcdzaWw2zRF970/65rgNgPepS00V8Q13eMU5hXFqP+MdSJ+zbdK8fFovue4ov
	5e12ap5nqkOXV487RkOCzaylWMVqGYmKCvu7SYc88F/z60XI1nkaqvbFxKg5bRsX
	v0d9Zg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyhusr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:30:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-269880a7bd9so3392435ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756657; x=1759361457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox0nCprWF4+A8izOuWkf1k4m6mNZb7YM7KVt0A8RT4s=;
        b=L2yZfd70tgW5r9rG6Iv1nzPInc0XYfzm8qH5V2d3S/hhf2/pYRjDlujiP/5c+fmA73
         nOGydKXTx/YWwGFr16j+AnOud9hrfJ6fYSE1kJyzK//CHS7KCUEY9jkkXKMclzvDRqgX
         iTLgN257Da/JB9q44YwtwJ8VVAHtF1s0nkpdm3C3n0sC9bro8GDuKeAT/Z4YU+HDV0zC
         /OnEXzlbMD872Ki2OoxH1t5SUQmJDh4NS8ZOUlBOrq1M+rtcFWo//mGHV6hBtBFHK12g
         a4ntafkxdJvI0nQ7cd8BK7UKpJtkwpQoTYAlBP0pUtqcLBiZu2LWdbqnEV+tihT871hj
         gy+A==
X-Forwarded-Encrypted: i=1; AJvYcCXkVDEU+OPozzoL7lJDi//wG6ojMFziD5kvj2NKR0G8jDy6MvtJc6BAXiiJ4AQo4/BSe9JuealSs1jhaP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmRFaJZXQ7AWsZIiQxo+7c1zsvq4pcOULT6IMHRUpiOwdKeazN
	lQjOpJnpTXQISbRaZyk64xlkfyz1M9fkAd5lOLHgXWbDN6RmQoDXZUUYW9t/DjrjG3zUNBcI6pO
	zoZ0Sr44YzSAsClqLHocTpK5AJtmGyCN9wVbG0KE9fSgmgKu/aO+Wi0dbfb3S7LJzyx71Ua1eE7
	9TrA==
X-Gm-Gg: ASbGnct2zZb6cGE8l8mufB9fnWwY4owJvZCVbGglExRePHAhPR+FxunKz7KPzikLeWv
	EE0Y73doMu2WR5k5+fgJqGlDVjJ6Yj30SBNquL509lvhi4ePjf+zyKnKv71CLWwyWqcMA2yc27J
	G5eVrfQSl5tz7doSOKJeFr2JHpHmgrMn1HV7TIYrQTLXVxnx4ujRskiVwSBOTQQOX8TudwF/+1z
	MkVk5wyNP7tR1QqWXWNpQWr3FwEUCei6YIh9vW/7dmDvJp2kkuEbY1EeKzQ/U+00P/+tpfYiQjT
	axI+sHPsXVyG/ITOYQP3Hl9JEUz3SnaKWvcV5TiCsVBjqg9XP/peIS9A6lh9g/WUK7QE1eAPTqa
	hrIbatcv1Z4lH/1g=
X-Received: by 2002:a17:902:ecc8:b0:279:fa:30fe with SMTP id d9443c01a7336-27ed4a57523mr16338745ad.26.1758756656544;
        Wed, 24 Sep 2025 16:30:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJWJUtaosoOWJu9zdo7V2/a2iUuMknzjFtOvEXGGz49IZ5GXzmazinpLXS9hgbZdWyeRxt1Q==
X-Received: by 2002:a17:902:ecc8:b0:279:fa:30fe with SMTP id d9443c01a7336-27ed4a57523mr16338385ad.26.1758756656118;
        Wed, 24 Sep 2025 16:30:56 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882284sm4122655ad.69.2025.09.24.16.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:30:55 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:30:48 -0700
Subject: [PATCH 2/2] regulator: rpmh-regulator: Add RPMH regulator support
 for PMR735D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-regulator-v1-2-d9cde9a98a44@oss.qualcomm.com>
References: <20250924-knp-regulator-v1-0-d9cde9a98a44@oss.qualcomm.com>
In-Reply-To: <20250924-knp-regulator-v1-0-d9cde9a98a44@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756652; l=1779;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=B8yhaavfkxt6JKBViaCPbm+SHPFCWCrNlU/GJH7eclc=;
 b=pH6PVbu9oBsPoQSQH402I6zaaJCMTLXX560o3b4lF5s/C6ztNvwoLy+/xfbn+3oiRTYsvEvRu
 lX2WbPGWEUlAFmAttj8s22fXYpYdLokGSCAZ5u9JfEqUs1MQ0s2T/se
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d47f31 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_-KOIAberI60gMQzDgIA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: tGUSLtCOKImEogkjlos1WKQbyrgtxGNO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfX2PylTyd6umjp
 P1cZrnTKwvb5uaYhfrwkf82Le9AVFzM8vYlopKXGdbvU9hRNRCWXYcchvI/gPIZXBc1FCwDOMrI
 zzw+P7qU1MmHSPz2X+7rVXfTtS8o7jjJalswW625XNIY3RuRrAdU+cE9iDn8i2x2e6vCxaQZoEc
 UXrFHzcSQ8MfhlWWwd6aapNFAEiJayj4jPGZI88Cpu4fkHW2K69tGc2ywRt1uATqL6mwxyjXTq8
 cuOnIAYqxg4T2T3rreDUFpSffWySztiaaygtnc2IHU57CNjqFRlAgXzyw2227B97j49/wNpuJLj
 3eNdRBcyrRlRCw0XifH9ns/uymcl50vz10lBMhtdf/PF7WozInVRAWUHT0B078I4xpJAvdo42jJ
 dzS4lvgQ
X-Proofpoint-ORIG-GUID: tGUSLtCOKImEogkjlos1WKQbyrgtxGNO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

Add support for PMR735D PMIC voltage regulators which are present on
Kaanapali boards.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/regulator/qcom-rpmh-regulator.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 52e5499453b6..d154dda977ce 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1734,6 +1734,17 @@ static const struct rpmh_vreg_init_data pmr735b_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pmr735d_vreg_data[] = {
+	RPMH_VREG("ldo1",   LDO,  1,  &pmic5_nldo515,      "vdd-l1-l2-l5"),
+	RPMH_VREG("ldo2",   LDO,  2,  &pmic5_nldo515,      "vdd-l1-l2-l5"),
+	RPMH_VREG("ldo3",   LDO,  3,  &pmic5_nldo515,      "vdd-l3-l4"),
+	RPMH_VREG("ldo4",   LDO,  4,  &pmic5_nldo515,      "vdd-l3-l4"),
+	RPMH_VREG("ldo5",   LDO,  5,  &pmic5_nldo515,      "vdd-l1-l2-l5"),
+	RPMH_VREG("ldo6",   LDO,  6,  &pmic5_nldo515,      "vdd-l6"),
+	RPMH_VREG("ldo7",   LDO,  7,  &pmic5_nldo515,      "vdd-l7"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pm660_vreg_data[] = {
 	RPMH_VREG("smps1", SMPS, 1,  &pmic4_ftsmps426, "vdd-s1"),
 	RPMH_VREG("smps2", SMPS, 2,  &pmic4_ftsmps426, "vdd-s2"),
@@ -1949,6 +1960,10 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
 		.compatible = "qcom,pmr735b-rpmh-regulators",
 		.data = pmr735b_vreg_data,
 	},
+	{
+		.compatible = "qcom,pmr735d-rpmh-regulators",
+		.data = pmr735d_vreg_data,
+	},
 	{
 		.compatible = "qcom,pm660-rpmh-regulators",
 		.data = pm660_vreg_data,

-- 
2.25.1


