Return-Path: <linux-kernel+bounces-775277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 002FBB2BD69
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8E45A2446
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896BD31197E;
	Tue, 19 Aug 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PwgMvqx6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0026D4EF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595664; cv=none; b=tVHhV2LgzS3qvdFS7s7hGHT1RGkKThAJLo5oeU5zCNU+G0m9Xi80beTi2vLmt/0TNRxFUes3+JmpMdIKfLVm6cdmhaKKeB6DeNj/53R4CNfVgl88Uvszzi0+ROfJgz/MkjWI8zrCs/COdI5xSVhSH7nU5KyEnYiM3IftnW0Q5cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595664; c=relaxed/simple;
	bh=mQUBUhTJIkEVd17LK62zreRv2cywfgL18mzSnA6eK8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAhO6UWRO/xCpt3mksPMakj3OlG186dCA/omlwmLsyd2KCk4TnWLnVAhuoQ2I/1gvcvw6kFdo/ndNgnYwCBO4KVwL4D6koYvLjwnS1yeJditN9W9R8lfBVc2IOkjeruXtqXn1KOCQJS4FUiJQXmkZV6PC+42QYMed9j9UK/tKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PwgMvqx6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90XNo030332
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CyLYEil3TgY
	GIEbJLbRwKXtE0JhM9xLvHblciK6/Lyo=; b=PwgMvqx63YPuSxOJG+FYmgYCFMb
	sff3WprLut+iB4k4pW3+74b2MH6T+igimwSvHFuEcm9p7phUiCwBgUoAMewk4W71
	l/vqjaTii/wAL5HzLQxiIKXAYUrsOtYmJEl/RarK1r3mNDeBWBwEyabeJlWWD81x
	xQTCUqiVG6EWMKAN/iQ4N8plJS1/17b0KwnZ8bNjfp64a7a5zOJfy4/RQzAIT5ke
	oq+GUs0qdyLEMBKc/sG1WQjLtuZsEkkjeTmhs1V7m9rvgfEWkkVgWlut3C1rCEMO
	jqYqourv0VccXMGMoJL0Nt4pLYJWMBKigEoprJbb95/VzBY5gHd/xSb8r7w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyunv77g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:27:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e8706a5e78so2339485585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755595661; x=1756200461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyLYEil3TgYGIEbJLbRwKXtE0JhM9xLvHblciK6/Lyo=;
        b=rilAOcNpQXraCb/hVVf31c8HtGZnH7v+PgaozYPqJCSQuZXwdE60xQ0QTHo9KyuW24
         MKktlWniJQ5D1J1/xQvVwE2o/2pLidtvgfYq5pL4jELJe5DDt3SzPjutHIunAjKJVaVF
         OPlmjtetVcLldQPKz7tYMePwSK8VFXrFMBFDHlBjrP0yi/ZDkpavQOZxIJKriUBeV6WL
         Nv3vnh6Yk7Kyx0Fejoal2WHcIjwqAHRaga0L3pw2s+VaK2/obfYuZQ0B8ECa6qbjcXLr
         Mn1KtjqLKSwdNFfGsQUklfCXBQI3Fu7nYTDULXVZzlL9I5R5y4tof9+A4c2TCemVHaHs
         f3ww==
X-Forwarded-Encrypted: i=1; AJvYcCXQgd9fQZu90uHyWHROAap8W4ObTd2b3BZ6c2kh/dXcDPWmewHY2mHJ4DjumnqSetafQvrlfwxMyMhHucg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzU9OKLSY1xnBUQNF9eT039KhCiJ/rehzd+9qaddTG6175QG1R
	2mkKSLOZNcSRhcNhS4YH8M+Vbdgajuz8z4mW6GoJqlx9YNoxwinVyPjeX563KTbqKFYoWGlZsuf
	qLozCQ6OcbrFrLYb43qNbRI3flK7wZNa+UmEl58+DSadaT2pauTOhazy++JHhn/0yulEDzVucVo
	I=
X-Gm-Gg: ASbGncu6kS0bgOGBt8vj0KjO55bEbj6LpwG7gEyqaneBhkVaWbTME903RD0w+NJuP4H
	4beLoEN1oBb9gvVBCkT3TcnZ8FvdFX7dsKgO8zVU1Tkc8HBnoF5zgjIFZztmWWreb+M9c4i417M
	EgtZEtvTA7NIrviA84Pl9eupsCDXkXFmwO9ihcJA6FTLMBdd5vLVVyvZCk228nJzq1bQULElKK+
	4K1ebwuBq7T4xyxO50A8JSDNBG9gOCkOZ+6MfAd5AlREJzQP/T8PE246pnIy549cSXiCsZgOwkV
	66Vp3BhGhd7brVmAC95Dm5lZnJs1S8I98Lp43DWy1ZivHaDFquhVSg==
X-Received: by 2002:a05:620a:4088:b0:7e6:7d14:6fed with SMTP id af79cd13be357-7e9f3396beamr227019085a.57.1755595660948;
        Tue, 19 Aug 2025 02:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1TjeG+Qnr0RzGfLzCytOelnNfUVpxdZzDk0Sv5IjBfeYEtkk+eUnZHC+HPE6u1SpsAIizbg==
X-Received: by 2002:a05:6214:c28:b0:709:e1c3:cbbd with SMTP id 6a1803df08f44-70c2b63c5bbmr17392576d6.21.1755595619040;
        Tue, 19 Aug 2025 02:26:59 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077788df7sm2942284f8f.48.2025.08.19.02.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:26:58 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v4 4/6] ASoC: qcom: audioreach: fix typos in I2S_INTF_TYPE
Date: Tue, 19 Aug 2025 10:26:50 +0100
Message-ID: <20250819092652.1291164-5-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250819092652.1291164-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250819092652.1291164-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: az4_SH8UDp817C6lhBRqvoEv66ofNZBz
X-Authority-Analysis: v=2.4 cv=N6UpF39B c=1 sm=1 tr=0 ts=68a4438d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=2ggkzc9sqBovd5WwaRoA:9
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA3MSBTYWx0ZWRfXziVF2zitilLh
 +nv3ELonQEFsTMu5VV4u+t75OMVMkGeCk5e48ArRfNBUIuKbkj0jk97V6jlUaVHZxjXAZBalbDG
 hKzV91Q2IsYRU+H+bg8SGbKG16p+VAPdCX8WixLiGlxi9k5b6+c2/IP+LMCZq0i+2p7LGodSHhD
 XZqxV0ISsBZptT3m0QnilZRTfsZ/0VlD498vvU4rJ6GAlV3wMIpNRkedNmgCZgR16814Ol4FvP7
 0x8YyqrzTv4vMP4focwYAyHmUVIXU2ZjzAfir5xzmcfHS5x/SkeJ8aWWJ/w4HjhLIfAGsJyOndn
 Gw7vdo8GdzWIMovKgH5ynR4jJPYHOPwZejCu9llWJCNnJy5Bhlgl9DSDJ6f9Fs0tFrc+cYm2TPx
 EtcZIiVA
X-Proofpoint-ORIG-GUID: az4_SH8UDp817C6lhBRqvoEv66ofNZBz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180071

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Fix spelling mistakes in I2S_INTF_TYPE defines.

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 617bda051cf8..efc918452e2a 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -462,8 +462,8 @@ struct param_id_i2s_intf_cfg {
 } __packed;
 
 #define I2S_INTF_TYPE_PRIMARY		0
-#define I2S_INTF_TYPE_SECOINDARY	1
-#define I2S_INTF_TYPE_TERTINARY		2
+#define I2S_INTF_TYPE_SECONDARY		1
+#define I2S_INTF_TYPE_TERTIARY		2
 #define I2S_INTF_TYPE_QUATERNARY	3
 #define I2S_INTF_TYPE_QUINARY		4
 #define I2S_SD0				1
-- 
2.50.0


