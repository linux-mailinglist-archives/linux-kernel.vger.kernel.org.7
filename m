Return-Path: <linux-kernel+bounces-775371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC15AB2BE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59494179F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E4C3218D2;
	Tue, 19 Aug 2025 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Je9JxUrY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345C3203B6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597729; cv=none; b=q3pW3lQw+vZQDK5fqLwx9a+AsY2uvBdjuozwZ8BW8nTONfN60TwiRsZn3oC/RofscwD+x0cSMqpsuKij09sb+AK2tNKCVDEWSoNgUoemuMF1RpT+nb/8CDgDUduEUCIuxbJQs8Wbw/do8bagfErxsmK5VjdE5Ey5go0xs9lMYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597729; c=relaxed/simple;
	bh=Nxi0Bidenhap9cy9yhPxUe6B3/q8TTTaqSUBpij6HY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrlBaOegETf9qki0CfstnBxjuWYO4wbgqdimp6nRnUgaSHXReU9Eda2aLvYAvqIdHlSVFPTvN3zGu0KMx4Dsdfa440U2y5RwSNthW14JxDgdvxtCHyrhi8jnJz3IVwe7MLApwkuf9xUP5rFbNSb3UEo4fNZKJO19AOI5xeB8lwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Je9JxUrY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90XTC030332
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=THJxLq0EGFK
	SHTbEou4KGPig+UVopLb+QSBxv3D1Czk=; b=Je9JxUrYO1MYQVBk/sy6o16JBAQ
	fMXurRGK2QENt/MrN5y08wPT3bp5gcomxOs8hy41vAq9Blrh5E/WmatsGMfzkaX7
	GHH+rCBnRpY63o9TKQ6OV/UVHPb6pIPgwkou1vyplyUIPUIaU0uWgxh2AsX9s7F1
	O/WdSD051Oc6timTyBH7b1rYYPT7U7WJ4RYVKqifV57SRHVf3tSKOJ8rY3ru7DFp
	uFFuecuSJn6H8iEvgWCCrsyqfL7y7KkQV8S4IsJ5bHtlxkJpLLw27YxLC8dDjJ1r
	3sGIiazntYXALoKOSo4xSQGshsMMvZmzRW5kG3vFIIha0FdXJRWz8sMaO8Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyunvava-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:07 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a9384d33aso45085406d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597726; x=1756202526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THJxLq0EGFKSHTbEou4KGPig+UVopLb+QSBxv3D1Czk=;
        b=rQFrFzwDJsk0iPGmz8oJcJNPGFHUcmtCDztNRvqBRXQ/EFWPhxeQrssduzYvl3PSWu
         cbPnAcNmVxSOxDRN8v4swLmLCbssB19fz0C9LaJVWrPICYEe8i0ZaQdFcPZrASsn87QZ
         gutdDpNXfqLqHa0E4hsnZN2ptaTsPA5+EvC/ddp1NRg5XIca6LLT974fOwsqiqj1/U+f
         /CIU2xmdVu78oKakdrfk5TH2e6DVT5NLDsoc8oJMyV/uW0q9/6kOhmFzp/fYDlgMFijE
         E5/QIhojxew1JeatUwf8uholEz8X4z+B5gHi9r4pqGsKbqHJmtuEwY8jyfZ1oe7xcvL6
         eb2w==
X-Forwarded-Encrypted: i=1; AJvYcCXDoVEvTWx1fZcesaiG+1ApMvx8nvcqohGWSYaqw6lRWkk9vLmLcgmPdPIULwjaToSuH4a3vsPFJiBYAuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+bF2EKK71nJvcrJuU0wKTUqP4P/Z7D2pKAtktotGqnFmZaxRt
	Fe1z2WX7EHEc0klsx+apkywwgqp8izsW9q1WLdJxMkcBr5nEJ88xUO4xbwj4Poc/Q+PtZ1JiCnr
	SkOZcksXKch4xxMrf78E+9z7WYR3/5KhwVgGv8UW+fnf+cZqzj6gX5V8sFCYIiX1i4pU=
X-Gm-Gg: ASbGncs5IOytDJiUgc68pEpcX4Bavj670Yi2vzf3MU2yuk2Lj03dtCbPUh2EBK1SZy6
	j7xA1gPmQSx0ZeE+IUDKiYvU7gSAzoiRZh3JpiuKPJhOuvAcgfJZL405Adfoc/Eih71ujfO9+3M
	S/DG/6Hl9Y+KIrmtGS2+eRaSO7MtTTj0YdpjPY1BO9CUYetN8bMPrdd/hFvUyDMaNCfaVxXt/6a
	V5v187izX5TucuerZk6j0aPcL8LbNF4Oy5ul24GKySZLwk4ZwjHhCH3cPOz8g6Df7K36V3wqkmN
	I5U/aK8wRrP3mNGLmLWOsqwdBeczYcLLHbXfpMQVa8d8Gn3hdVT1wQ==
X-Received: by 2002:a05:6214:2b05:b0:707:6161:5988 with SMTP id 6a1803df08f44-70c2b5be2cemr22622316d6.7.1755597726129;
        Tue, 19 Aug 2025 03:02:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9ANpoSUVhLH2Vcl4jJV2fZu1fKwBudjv9iiCIhqRJgJR9L03CXR7iurdsDGOqFENhFyeGtg==
X-Received: by 2002:a05:6214:2b05:b0:707:6161:5988 with SMTP id 6a1803df08f44-70c2b5be2cemr22621746d6.7.1755597725521;
        Tue, 19 Aug 2025 03:02:05 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78b410sm216169635e9.24.2025.08.19.03.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:02:05 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [RESEND PATCH v4 5/6] ASoC: qcom: audioreach: sort modules based on hex ids
Date: Tue, 19 Aug 2025 11:01:50 +0100
Message-ID: <20250819100151.1294047-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250819100151.1294047-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250819100151.1294047-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jyOkDvJcrR2aq5J9m1cujs5d87MsUOu5
X-Authority-Analysis: v=2.4 cv=N6UpF39B c=1 sm=1 tr=0 ts=68a44b9f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=8nb5IOs2KV4HrawvOq4A:9
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA3MSBTYWx0ZWRfX830f271ZdbSo
 EhZlOLiqvgOjRQkJTUQwIBn0i4FIkBGZqPfIdPXFt2AAexWglTM0wyu1kVDyD48W3CIVSrs4iC5
 O08RpDZ06ZXnAg3uUxtmoKr82vOpAEzMC11yZL9DD4U9NjCG73G0GUEGJ9/oUv0hAENx6ft8smi
 g9E7tapmoIwfIdt5BKOHpNc47bnzgme6+jP1ov1kesKXa0q3uIKCkQF5o7SE+7eB08NasjjtZzZ
 T+Dv55p623WpT4fe55HLkjGpDikVZFKo/sCrBafNxJV5Wd1+9Zte6oGA+ceFiE86ZE6TRJgxLSp
 6c6y3Q0NBxVzH/dPpj44vY2AqQBDm+kxy9bWy4QKh2HPMcR8/goBkYYAUbTEysxL+GsqiWwjxt7
 k8O/ADKS
X-Proofpoint-ORIG-GUID: jyOkDvJcrR2aq5J9m1cujs5d87MsUOu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180071

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Sort the module defines based on its hex ids.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index efc918452e2a..e4babf9a44ff 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -18,14 +18,14 @@ struct q6apm_graph;
 #define MODULE_ID_PCM_DEC		0x07001005
 #define MODULE_ID_PLACEHOLDER_ENCODER	0x07001008
 #define MODULE_ID_PLACEHOLDER_DECODER	0x07001009
-#define MODULE_ID_SAL			0x07001010
-#define MODULE_ID_MFC			0x07001015
-#define MODULE_ID_CODEC_DMA_SINK	0x07001023
-#define MODULE_ID_CODEC_DMA_SOURCE	0x07001024
 #define MODULE_ID_I2S_SINK		0x0700100A
 #define MODULE_ID_I2S_SOURCE		0x0700100B
+#define MODULE_ID_SAL			0x07001010
+#define MODULE_ID_MFC			0x07001015
 #define MODULE_ID_DATA_LOGGING		0x0700101A
 #define MODULE_ID_AAC_DEC		0x0700101F
+#define MODULE_ID_CODEC_DMA_SINK	0x07001023
+#define MODULE_ID_CODEC_DMA_SOURCE	0x07001024
 #define MODULE_ID_FLAC_DEC		0x0700102F
 #define MODULE_ID_MP3_DECODE		0x0700103B
 #define MODULE_ID_GAPLESS		0x0700104D
-- 
2.50.0


