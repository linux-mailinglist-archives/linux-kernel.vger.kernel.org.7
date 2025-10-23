Return-Path: <linux-kernel+bounces-866695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A711C00756
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 810914FCBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E5030BF62;
	Thu, 23 Oct 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bHD3C6ag"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA2E30B505
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215162; cv=none; b=sMhG+1/iIflgWUzpMOWzRdm2mTb0wS+3e8YxOuB1n7P5kiGpEtyHx8WOFzG9bi2jI92g1iWg86x0WP/Ok5lbLbM7Px8TMXEJMLtUl/eUFBPthF3Bqp4HRp3OvTrxMPrJQ6WL6F2KMnGXnokYSMKAY3R7RQYebvPwzQIciyJRBGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215162; c=relaxed/simple;
	bh=+pEzU2CaP92P+tjHZGLYMYsO+p/lLdluRH2vfoyibvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROYRsr1Ci3lUKMliArha7LfxiYsivQzJwwMHfHUz5p8Pc/I+GgTR2qqMSrz4NdcoEgV7v1LBgs/MJPDWfkaSorTkJaBb16LBNSPbZOpwspEThdYUrQdSYtd9MuaUYkVHyQ6fz8dqoYjiLUfFRJMT7xGfxcI/ej7KEPibTNsOtqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bHD3C6ag; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7ArQp011696
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hugy+iqvLUJ
	2cjxOk55z+UZwKkAMqHXBccnGqDcDbTE=; b=bHD3C6agXJdHa6WOJPjq+k2cj2e
	Efmk65n6JaL9JQox4iXtAsYb3tUz5HRd2dNh03JvSMyQtls+BNIfRxZvW4HZAJRN
	R/FJ1hCidjA/3meuFLicg/UNMQ7U9Hl3/IAndNM5JK3dzuRD1j72gruOQv35jdmu
	OuhMW7b3Qrc1CjZIIj4YzBEyseY7jF12jWxMzgjlqUafKIFybYBXHImFYPxZGQIV
	y8IuxH5luwGauiSOSHgMs7FaHx1Qa/aoLVJo/igQJXK8wrT775Rh+9qYj8uK0nEK
	0rbJlfPmxx/QSNrZAMeuf/9hUSQqtBJpVarEDIJtLDgCr2LFJpCfLwAJI+g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524a74m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e894937010so18236331cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215159; x=1761819959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hugy+iqvLUJ2cjxOk55z+UZwKkAMqHXBccnGqDcDbTE=;
        b=drXumgXL/KGndDkiEB+CMMI/RJtVT7CYygqYYucCAdIy0izJzZvNFvgUprqKc5fre1
         0/ttAyk6w0okgGUs6D5MD4tZT+h+/+zvQfZqrmPxqntmoWX8AwjLSr/WRXLOW2UwQTYy
         u1cLNwgQ1xsLqPgZyArqEdj1rlp5YznKrds69GybR7adirBoQX09A3ld4JRo2Ao3qTe3
         Or0dZyD/QDw0etuiH9twpIOx9EVfDYc5cX9OOwoMFqI+o50gF/B8zJIrKVmTFDwaII4W
         G/42/bbQ/zjNW1r2IcMYIgHHI4MuuZ++WHYyolyjKx5UQhGaPKzZV1rJ2n/mvFUiAICs
         ILzw==
X-Forwarded-Encrypted: i=1; AJvYcCWw5Fi/dSuZ/aEPHbR2vWgFS7cTovZ+XPc2Y8MMwLJAG2yyJVpv6YG3ReqhYV1XP52PwdiqjxG6WrVyxKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw4b9LL0aPkfDoZUOxvmthK/hBBJy7tDcYiHf88BwwP54XyaeF
	bEnBywHn2GDRJDIX8imywnsUhwZtziQgNafE1kqv45EXA9pERjU8OAgQSpA3x1qLnmcG+dkpc1R
	/yYcVFD3fQ7DYPA6Q3lM2b5tbwtVWkY5rwekHhlHtEMYWPPD7fTzRWWx3udqrnC0pwHE=
X-Gm-Gg: ASbGncsmkGzQab3wvtCwXLJDg5EMvBkotkJwk52aH6Wd6WF1i7JLD2k72MdlXjygNrV
	CLNDMCaoE7FGiD4jvfWDLdAHo0JCauaGptY+9HruFUTHe/kzvg1eGY31T09UULRXcjulIoUmPJD
	pVK5uYIGV22F7Y/aJA6yRgPCIO98J/TX1Cf88QXiUt1qgOXPmn7zLMoWk2F0h2uiGrAIlMwLjMf
	4KMShKtNmt5vXmX9AuHD1xUQ5fGpOsgeNfcbCGr8So02zd/W+YHGMgbvruYEXQI7q0AVHAjiZff
	Ke1+Of2iv89uNxomovbCl6f6kM3Rvh/8gWqmrn+Sg9zOQXkSQCvvh36o6DPmxAWAoK3hXDmVe1a
	Vl0QCS4LfRm/S
X-Received: by 2002:a05:622a:d:b0:4e8:b669:990 with SMTP id d75a77b69052e-4e8b6690c9emr204361751cf.22.1761215159010;
        Thu, 23 Oct 2025 03:25:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbFZ/aAh022rvOoagwONZHMEh0MEWdYvgy0BQ8CSY0tqtrarJPhK0oSiMEE6Ys8biKzppMkQ==
X-Received: by 2002:a05:622a:d:b0:4e8:b669:990 with SMTP id d75a77b69052e-4e8b6690c9emr204361541cf.22.1761215158490;
        Thu, 23 Oct 2025 03:25:58 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:25:58 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org, Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 03/20] ASoC: qcom: qdsp6: q6asm-dai: set 10 ms period and buffer alignment.
Date: Thu, 23 Oct 2025 11:24:27 +0100
Message-ID: <20251023102444.88158-4-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfX8DKG5EtLdkcS
 A88qDH/De7jeJFLHjDexkK4S49HF1iPi83xBSMssVE48IlkS5gVVOJ1Pgo5WrTW9bMCki0y33uP
 LXtTE0JvldtKXzhTkCLclgnz6gd570F8m1/kJxJ5/DH3fMpMjaXnog5XvR/VzBBiUOJx0Dfucq1
 s0IMKhG0kjrS7BTCKXnxMg9BWPrAfxzv28W6PfsXeOBZ/6s16VwMoLfnt5zAjZZFPuVhKGohcQj
 qoLTlNrY9iretlg4IxSo+fcnYWwGu8w9eNfgba/IgI+LIn0/BvrqioDBuZ0Rkr410gHsrkOzeA5
 8xidKpR/5GzP5TvJvbTtXrT4dyShNB9I5XIPmCf1ZB+jhPajnmHLKyBCrefUpyBCnoO8BE1LZAY
 j4wMSCpNSuDBxubrCDmNIBqeQfe6RA==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68fa02b8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=Ubk33e6zxpvlPXQfVdEA:9 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jbS5oIKJla4-bgCm_zYRZZkMgJtz8Qfc
X-Proofpoint-ORIG-GUID: jbS5oIKJla4-bgCm_zYRZZkMgJtz8Qfc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

DSP expects the periods to be aligned to fragment sizes, currently
setting up to hw constriants on periods bytes is not going to work
correctly as we can endup with periods sizes aligned to 32 bytes however
not aligned to fragment size.

Update the constriants to use fragment size, and also set at step of
10ms for period size to accommodate DSP requirements of 10ms latency.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # RB5, RB3
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index b616ce316d2f..e8129510a734 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -403,13 +403,13 @@ static int q6asm_dai_open(struct snd_soc_component *component,
 	}
 
 	ret = snd_pcm_hw_constraint_step(runtime, 0,
-		SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
+		SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 480);
 	if (ret < 0) {
 		dev_err(dev, "constraint for period bytes step ret = %d\n",
 								ret);
 	}
 	ret = snd_pcm_hw_constraint_step(runtime, 0,
-		SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
+		SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 480);
 	if (ret < 0) {
 		dev_err(dev, "constraint for buffer bytes step ret = %d\n",
 								ret);
-- 
2.51.0


