Return-Path: <linux-kernel+bounces-825172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD1BB8B2AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F450A81E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109472D2383;
	Fri, 19 Sep 2025 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S67EvqpJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA45B2D1F68
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758312059; cv=none; b=Cydu363ZXnM4RymU88nQsl451N/p3d/SFFp41elI3RJXazpJrd6y/MiYM+VbuI/okr5Z6lD3D9vQ5ceFhhoA+akpB4V4p/bzFCuuO1Cbqj2TIgahw1GWnMWvT+IW+pXYs00t+Gw09EZ5uCpV/gQB72L2GxS9kS/eaT1/GvLuD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758312059; c=relaxed/simple;
	bh=R9LLcQCUiDMiN4HDFZueMIWI3JFHTF0opHifX3sulLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mRV/vthRDDQWF1Bw2zyqD/Mk3ct7hPm3KFWYgAgO2y1W6zhHTg5pipBWohEHpZkFI/RZyvoNzTa6Zq1Iyh7p2CgvqKw7Pnb+q/OuPqbF2Jmpp8bx9k4OVDGYmye7e0taKLnn7ihTbBX6W/3mAG4gTBLj4jWV0uJnKRTpdDU771M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S67EvqpJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JHV3a2012714
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lg2dZN4a504FxnnfleNPhZdOEAS9VuA8ArU7WHTtyuQ=; b=S67EvqpJv4RgBtBI
	LkqRzNe2Uhl0+ITAvZZTiykrwc2vF+8Gp15tBAdDYgFBNojEJCEy67dzi//mSFdW
	gd0dUuiA08unkF0BcRG+k2580Mw/3gZwhD34GTHQZzb+kecJJp2gyVKWtzil0j0H
	iAdzn88obYQ1+dBsVghjDeuLz9JHcXXIO4Mz/dscOhC+DbmYBKUD3GUhU5pxImf0
	f5wOk68geI5X642vFfhPWcor5FCvC68ij0llOXsvEmIZenGCy6o7z2JrHVVDhSWX
	X0qdo1LVzHrgoyxftyMLsSDh91DoXc2YOqF3LAjRoApRnriBp8d/f/iPn+4Xf3Rf
	hL4/hg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499bmy0dt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:00:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244582bc5e4so27924905ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758312055; x=1758916855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lg2dZN4a504FxnnfleNPhZdOEAS9VuA8ArU7WHTtyuQ=;
        b=W0ctrg9laQngh9PLSq17ue6hYqZDkxmyBiSE0mlDYC076d4TBD9HzEFG0GVydbhCDm
         7Or9yht1TtdL03YS5UvmyDv3SUYyWeJ0DH/Ph07JPjAwfqLFa+ZU1FNSNHXcbNpWa8/s
         5SMIc82U+fj3eh3vKfW8ca44o/Fu6U77ih2fKttmNvBX73xws+Ppa6wH6M/NXbBgI6e8
         n8gwNeOVQtV8TJnfQkgD1CWjO/zSMS9MQO/AfbN3YSfP8fy3Y69UzFQhD8wv3jQspSR9
         wNW80m0igjJztQLf9pHINmOdBFE4178fsso8xZP6MkTCCq9NI4/GszxaxL6LXWNJsoyH
         xY7g==
X-Gm-Message-State: AOJu0Yw+erg2NZ6mT00k9NiTGo8f9VTdVm5ci5LdiA4o5T/eofRpdz4C
	ZMBF7pKg0gMd0I71fRN7z9gXKzd61KkfS0BJng/3wHAK2dxGtDlIGQKtN+cXrLmUNVkBVuy/fEi
	Q9KoaUtSdJFvgBI2vXMEJ46UfwqhPRo4nLOIZ3FfnQAHFCnBeVdtkah9JJ3PYIColjRn4HBdzl2
	0=
X-Gm-Gg: ASbGncsCGG72D1OaMY0qeFn//35f4l9KAXijkRPkVzMS2Rv2WgEH26j3gSnjpyKKq+l
	iO+d5FflpJzS4YPyb/1NGvMNyMn8nSIgRj3CDtf7uJ61Q0tv/h7d8scpqlNTuOOhsHraDYxqsLT
	F7VfIqzsU0EOFg47ALYMlOsisS00F8cd8Mm27rD96ePt9wk/XCoFT7B6vIlYehBXlExefV2tOBh
	6CZN59N+T+bneLwsZDj4vHmf73kO1zYim4dtipBpziqESQoaasPeQ6mH+lteC5ItPYYIndx1lzU
	aV/DBduxw09m4gnLmt9Bua83BG2TlFHOh3cYfetU7zTv61aNuUm9sb+T2fsbcs9WdEkkAYO3tWA
	utZWsSt3JGofTBzmLJFAiGq9YHg==
X-Received: by 2002:a17:902:cf4c:b0:267:776b:a315 with SMTP id d9443c01a7336-269ba508205mr60032275ad.32.1758312054931;
        Fri, 19 Sep 2025 13:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuTYvwq/wPby7Y4y7/K1/uv+U5nL9KZApekuONtplC0mHHJqgvJLkkDt+f1r0fIExybCz06Q==
X-Received: by 2002:a17:902:cf4c:b0:267:776b:a315 with SMTP id d9443c01a7336-269ba508205mr60031965ad.32.1758312054315;
        Fri, 19 Sep 2025 13:00:54 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698030ee20sm63053905ad.109.2025.09.19.13.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 13:00:53 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Sat, 20 Sep 2025 01:30:10 +0530
Subject: [PATCH 2/3] pinctrl: qcom: spmi-gpio: Add PMCX0102, PMK8850 &
 PMH01XX PMICs support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-glymur-spmi-v8-gpio-driver-v1-2-23df93b7818a@oss.qualcomm.com>
References: <20250920-glymur-spmi-v8-gpio-driver-v1-0-23df93b7818a@oss.qualcomm.com>
In-Reply-To: <20250920-glymur-spmi-v8-gpio-driver-v1-0-23df93b7818a@oss.qualcomm.com>
To: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758312044; l=2001;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=OMxkfnXwCtLZpUJ7o9Qn3c4tuFeCwxOJk11xghTOPb8=;
 b=t5iqFc6Jh8HL4OMjWMtXMVuq/3N2fVxA0RWwTjR4RjPpgcsghZWEWvsPpf4ka015GUSWvcOUf
 1E7ypyEqA6jAaxG5Mo6dDm1usLODpDG+S500ssgxCwxLcd9smZH4zSD
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-GUID: 76pyCfimcIKdc12Rt9ZPotGdxGE9w1QX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDE2NCBTYWx0ZWRfXztqlZ7/eNv3G
 JVC3szelPjzOHld0gXWw7JUK05pStRaU0yr86tK5rdzthleMnYsyeVfadEP2SMVLuNmnxdK6EuL
 xw61T+yv8Ieo3GbQ3fwTS6kTwRItrNGk45L3rMflugqcHD60Fvx2pCcU1bGGzfMWQW1GIihUElv
 StgMUp65BGtILSdzIcbJhQffAcPajifmmSDv/sDboiaYJd11pGQlT2Ncsw4CxP8NMbKXfLrICeM
 a+lw+bq/I4r3mgS6RttUlNPbmZvD98OKp4RJbP+UA1/dfyxDRGpA12IabVIGCPD/Gu7gW8hKxIb
 MWYvLt2I7EejHu3Dztz8ptojtFqMqUhkzOYJUFcnQXaxuLeqpxO5xcCHgdzZzl7PTNkTVfFz/6A
 kLfI+QqU
X-Proofpoint-ORIG-GUID: 76pyCfimcIKdc12Rt9ZPotGdxGE9w1QX
X-Authority-Analysis: v=2.4 cv=ftncZE4f c=1 sm=1 tr=0 ts=68cdb678 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Z8Dd91y0tYXrxlmI1QkA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509190164

From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>

Add support for PMCX0102, PMH0101, PMH0104, PMH0110 and PMK8850 PMIC
GPIOs with adding appropriate compatible strings.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 485b68cc93f8edac07c15aad50ff5c9c7894d8bc..c4f7d2d7a017684cd9c0d0850cb8d998668b543e 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1239,7 +1239,11 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm8998-gpio", .data = (void *) 26 },
 	{ .compatible = "qcom,pma8084-gpio", .data = (void *) 22 },
 	{ .compatible = "qcom,pmc8380-gpio", .data = (void *) 10 },
+	{ .compatible = "qcom,pmcx0102-gpio", .data = (void *)14 },
 	{ .compatible = "qcom,pmd8028-gpio", .data = (void *) 4 },
+	{ .compatible = "qcom,pmh0101-gpio", .data = (void *)18 },
+	{ .compatible = "qcom,pmh0104-gpio", .data = (void *)8 },
+	{ .compatible = "qcom,pmh0110-gpio", .data = (void *)14 },
 	{ .compatible = "qcom,pmi632-gpio", .data = (void *) 8 },
 	{ .compatible = "qcom,pmi8950-gpio", .data = (void *) 2 },
 	{ .compatible = "qcom,pmi8994-gpio", .data = (void *) 10 },
@@ -1248,6 +1252,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pmiv0104-gpio", .data = (void *) 10 },
 	{ .compatible = "qcom,pmk8350-gpio", .data = (void *) 4 },
 	{ .compatible = "qcom,pmk8550-gpio", .data = (void *) 6 },
+	{ .compatible = "qcom,pmk8850-gpio", .data = (void *)8 },
 	{ .compatible = "qcom,pmm8155au-gpio", .data = (void *) 10 },
 	{ .compatible = "qcom,pmm8654au-gpio", .data = (void *) 12 },
 	/* pmp8074 has 12 GPIOs with holes on 1 and 12 */

-- 
2.25.1


