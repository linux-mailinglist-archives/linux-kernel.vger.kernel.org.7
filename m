Return-Path: <linux-kernel+bounces-759727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C84FB1E1B6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3FA57A99E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7998C21E0AF;
	Fri,  8 Aug 2025 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LI97VAG+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C3721C167
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 05:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754631031; cv=none; b=jFT731Hacr6KmMXhFzlluf0JKP6YuC0KbuiGWd6r6r14YT+Xw2xK9F44gxB82VmhRPJX91QEhFr7f4WhfY6mZKSiIdBCqtpXXSCzfxUYLbfxKdOPJOmsrIp33/0NpWKX5UhzTEsOPcl0Jqt5zCWUm2oHijL7pzhq3wo+ZHu+c+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754631031; c=relaxed/simple;
	bh=G6ac+SWY/rURugemv7DYJT3mKGq/Y+PeHZuD6sHOijM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jZyclcN23piO8xi59IGbJcgcarXQGqNC6btK5Hrxp7PJwlNSYCS+ErPcqUZ5LrnCp5vD/9kBPgsM9FfZ9Z3NP0oKrDhOlfkJz0aqo8Z+h0BZIo3EJwYLDwh5D4Ny+7AJpN1gLPwtrqK8ZB9nUkgaXVS2I972PW4pME6ZqPe53Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LI97VAG+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5782N9D0014567
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 05:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0A4nigMR2hF
	ud2hxwH/0Vp9R/PK6z3adOcLeHWmQMUU=; b=LI97VAG+K3WCULoTpT9VAjvxKKL
	xACyV/n5GJdgH7LwqmDCAuJtOpok1K6MMA0O70/4VqbKwF/QuBjBqD1ur3z6P0ON
	WiyaYUWSl3Z8ehb/2Sxwy8ffzkeYAQyIt8YTdffOe5Dk2bWWGqDqYPJ+Vtwqvgif
	+cUcPibbW1bd8Hg4XCtsz1sQHjegSZfz+ZLTW0ymP5n5KAplDKDHhuG5jOpbmP8n
	HZNayiBzNcWWAV5V8p4j05VOlprJBg3W4xtcX8nlRo2GGRUceplXjVvX3Gn7sgmU
	SviuWA2ACyRtiqg/wm+PKyVW9r6/arL1nyBN5MIHxMQAyc8tSzgEDX2JwnQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw30n43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:30:29 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-75e28bcec3bso3511967b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 22:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754631028; x=1755235828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0A4nigMR2hFud2hxwH/0Vp9R/PK6z3adOcLeHWmQMUU=;
        b=v7USHa6T8O3FkeJvB7gBtmkuotpjEEQJprMmBJBZWEPJa5OPE6A5/+NwUJmYjSj3Iu
         D27TNKyEL4tcFGwqN90EDfU7njo4sFzNKlKyzNLECIEw25J39SEib9oVcYFVpXIILe/3
         IahEw1RtEiSHx17s3u8WpYDWSE30HIEuAk341ZxQzvfESk5WYnbGkxcHF6XVq6VhXw4u
         TuocGfQb0OTj4n1DPErwaej/iE6WBnzs8L1erWVDeolrtqBvG4WqIzQmU5df5tFTdgeF
         5f2UCaG9tgMDY7Kdd2tSPP2MvTCH7NiZ7av3bKTMoAnXXCRNjYlzzGiowdSxsUSbJZx5
         vX0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaKHE04+UuHGAaG3H1YeVZNa0fN5wYVrEzbRTE3WX+fmgmgM7h2qdVrSb8thpYP/wYRTKky3hgHox09qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrSf4dkMIZGsft1pO5qJ5tUZh6+UMdQIc81i5/+YCAPpp6NRQ9
	bH6O7lt5dMCQ1ntvxLFrPj1jPaKouIIdlPRNb5ldba2jw+4f08uqInhbsr6IGQ8a2sUCX0WF9g0
	jZS9C7Sjo6VSHsbpqHpa0nb/dslDOFQ3zFI0JTypSJechnYVFauCsOQ5U3CDTl6fGUAY=
X-Gm-Gg: ASbGncuFtF+/WGGCdmcAYAGExiws9tCTVnOfhDZkeSp1i0pLXQ1unRBKdAMD6SSnYxv
	mi/aaKBSy9P9Ocl3WWdvhikWIGMU87gWVvtqpyLF2le0GnBPOgU1o+EELeVKgmEU9FsC5gMtXx0
	z1jIi2JjIQO1jVKliOiMS1jdsMYgT7/iiPGV7kVXhdMJ1UsgpGJBy1r7N+UrTZ+IGDvCJbPBPPU
	lOe4iHGiGE+RvdA6SX3fCuUkoKxJS/GwXZrEtOoVF/NO719zMeV09IuHFtpK4GciD5Dn2qC1taY
	lPF13P3oiJL1nAC/s+z8JVfIizhismPT08rBwUnP+W9SmXjzNOlQUFp/j1cBl4IoLYwwRTOdnHH
	r
X-Received: by 2002:a05:6a00:2d1b:b0:748:2ac2:f8c3 with SMTP id d2e1a72fcca58-76c461afafbmr2708153b3a.24.1754631027660;
        Thu, 07 Aug 2025 22:30:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrHFiuePg86xrK1PFssXX8l7W08X7w5SCuN0QKuo0C5ijMt0crnPIurgj02P1TLUN3vqCV4A==
X-Received: by 2002:a05:6a00:2d1b:b0:748:2ac2:f8c3 with SMTP id d2e1a72fcca58-76c461afafbmr2708081b3a.24.1754631027091;
        Thu, 07 Aug 2025 22:30:27 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f483sm19278662b3a.31.2025.08.07.22.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 22:30:26 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com
Subject: [PATCH v1 2/2] ASoC: qcom: sc8280xp: Add sound card support for lemans-evk and monaco-evk
Date: Fri,  8 Aug 2025 10:59:39 +0530
Message-Id: <20250808052939.1130505-3-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808052939.1130505-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250808052939.1130505-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vbz3PEp9 c=1 sm=1 tr=0 ts=68958b75 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=i_bJiae3Nsw47DEeRZ4A:9 a=zgiPjhLxNE0A:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: PZz6T-6X-ooeaqaJiXdHkDr_ybiPWwmX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfXxH71wv2bOp0m
 KdtFhaVRzNoNfOZouY1U/3QAMQLGlu3WVJ7Y/6V/Lb0mKjss3RasmC8TaWLSfeEQ/Nw9FW7A9Vj
 hu8V/9IPW/IGLWpA1JlbIHv5oLrempWkjclw6eRNodT8zeJjf5iE+Q8dMoq3f3j07/WRdZEl91w
 U29qw25a4ixIgxPAHgyN6c3mVZ1gipj0yA9gmubZbtxvOiJXzWlqvJqgix/KpVcV7CidIAhowW2
 BvFyPGrjdVHtmtnYMpsIaBJlfgEzZtmxPNybWERtMMscTyBG+7HDSUnbBflKVgMKbwYfk3k8cfb
 NEj3sybVazz6YMYQ+aweLiKCnqRAWjqC5WMtWGBto0vSmShMh8Z+blPxPw5OvBIUO2/hxSkq/5l
 IlCv7l1c
X-Proofpoint-GUID: PZz6T-6X-ooeaqaJiXdHkDr_ybiPWwmX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

Add compatibles for sound card on Qualcomm LEMANS-EVK and
MONACO-EVK boards.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/sc8280xp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 73f9f82c4e25..386e671d17f7 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -184,6 +184,8 @@ static int sc8280xp_platform_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id snd_sc8280xp_dt_match[] = {
+	{.compatible = "qcom,lemans-evk-sndcard", "lemans"},
+	{.compatible = "qcom,monaco-evk-sndcard", "monaco"},
 	{.compatible = "qcom,qcm6490-idp-sndcard", "qcm6490"},
 	{.compatible = "qcom,qcs6490-rb3gen2-sndcard", "qcs6490"},
 	{.compatible = "qcom,qcs8275-sndcard", "qcs8275"},
-- 
2.34.1


