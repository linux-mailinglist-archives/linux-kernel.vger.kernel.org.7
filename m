Return-Path: <linux-kernel+bounces-773611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AE4B2A27D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D85189794D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0313203BA;
	Mon, 18 Aug 2025 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y/5HYH3U"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B6831E112
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521466; cv=none; b=fkjYIe2uJbe6GIvKwWdZNmMzbF3PBcquXGolPuL9aZEjaZEl1xQo3zyTGBNfPR8zcG3bZhb5x+p7Ay8OWy7LgSOdcn3GqwVAMSu1uhMF4bwdN67on3mR1U1I8xpR2XnDvYMCcy1kZvkQDNo5OBm/n2uJ8UnlpwR/PklTdwAUqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521466; c=relaxed/simple;
	bh=Nxi0Bidenhap9cy9yhPxUe6B3/q8TTTaqSUBpij6HY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVYDTYB9Rar7Ywd9v+NRKkHlaAUoerTGlZZUakNqbRdJ1WfGEm5/yUCRa5yemhyM6SWn3k8jg4aFLt/faw5t6vpaPXC9rmoSrGjh87MdB/9dekE/utJwowEzoTp1tY5z3RDvh0Ttk0pRcbMoZQQ2u7PLQ7weC4danoCVMEus+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y/5HYH3U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8ikhB011921
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=THJxLq0EGFK
	SHTbEou4KGPig+UVopLb+QSBxv3D1Czk=; b=Y/5HYH3U8HCYy07u1PTCIT9+5wj
	GhdRbmRgQOxCpjwWSmISsUDCnnfP4Vra9KMnXTRrShMEWUWh0Gdkh28aa5sEq8Z/
	pnha+mdIFjS1Uv7Cm7JKaoMOx/iauyMXXgqQ99MrbPJ98mPAyHuhFlG40Ia7mbNk
	gfqPnkgHcd02mndnPJ7WKDjSqULhYX0Fb8UPAG0Q/q3RNVJKq7GKxl6y/TnMwfyc
	mx3XeJ65COEnrG11HYPAoHuDy6/WmkAEdnVDfAJJMTqbaT3tmfJpUiohuXMsBpYY
	O5AONcRu0Bs9Dd6dijGosu58ZWzyHQP10HIfpM1iE7c/IH+VkpitdrTMDJA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhjycs6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:03 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f6346f8so90332926d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755521463; x=1756126263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THJxLq0EGFKSHTbEou4KGPig+UVopLb+QSBxv3D1Czk=;
        b=fI9ncKyo5kuNNCXAujBP18oQ2g69W8INJEHcnhFLgA17HzUutFlGcmtHnIcNnlv4kw
         Lv8sm9mln/27KTtWlUxj7xsLhwqxIIj2rq3LqPmffaey4xccsWFQMy1Levotm9NUj4sy
         Y6PqLbpMLmJ82PtyaNMBHD6YglJBaLlGkf5cfuJ0fIx95gJ+cws5d68SCepqDhYM5Gqb
         2PeQcjPW74miB8bwFVTcDsKXAeb7UpDm0/dOYPCHJrBPncdQarXG9B4pif24TbIJqsvP
         +36d/ce8XWuQ8OmqpEuXKmdSgNziFruyzyyVn2GHzipdYzSDLaDsoNuFsheQiIWnxqic
         bM6A==
X-Forwarded-Encrypted: i=1; AJvYcCVmUxecgOw3K1GQ49spp5anA/W+wJ28kzsv1JiIFrU1f2rfLSkCAfaqwyUIPphWp6iPADzcZEth4Djy0mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcvcvT41kmvuTiXo5QN2aDdNyqKpyhp6qRcSaTK/rDYWO9OIGo
	NtgQg9uS13NmzqV4pgGV2BY1imv4SLqHFY3ehNuZlxeigR7dNFBuz1lru96JWANhzj2KDPbWUjR
	fxeKhQ3zjE/9gD/HOtdIfcZ/bXRZueNAqNOar1WC9S/FAHCyoYl+tuT69nNmzYBXnnP0=
X-Gm-Gg: ASbGncvBDjHhHQI1ZUaNHQ/KvtMzBF7AVWiI1jT+WXkcm0eMA9gozo4KSJRk0Qw2Rld
	szGx6np5pX1GpW84HjHcDkaUY3IIBkrUVzd6HJgZtW6LDVKpZrZPOB7gPcVzq+EuvknkYni+S9i
	3LeL8JvBhFEDZOTPWfPn++lkmnlGdTW14/Gz7GIruHQ2I4ZGghfgBSeWsmS5I7VqIP280IiFP6Z
	rIeh3kNWJNaYC+wq3wns43G+3Pg2z2/9nhWCUbSfSp3FllvVh0bYrKvaCHvQOanAf5Y3qbf2icg
	AV8yMY0isKbFcui+ka9Lik2jpk+1sHsOPD8LomtCW2IkV7R1l0Gh0g==
X-Received: by 2002:ad4:5ae5:0:b0:707:6306:28bf with SMTP id 6a1803df08f44-70ba7c0c9damr167850836d6.36.1755521462636;
        Mon, 18 Aug 2025 05:51:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw2J2bQ08LkYou8sMxp36+xBcanOX9SVxq6Bkq4h+DIiG2jVnraa+J944RcLiyYyzlRt3cOQ==
X-Received: by 2002:ad4:5ae5:0:b0:707:6306:28bf with SMTP id 6a1803df08f44-70ba7c0c9damr167850466d6.36.1755521462146;
        Mon, 18 Aug 2025 05:51:02 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9b27sm12537347f8f.44.2025.08.18.05.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:51:01 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 5/6] ASoC: qcom: audioreach: sort modules based on hex ids
Date: Mon, 18 Aug 2025 13:50:54 +0100
Message-ID: <20250818125055.1226708-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250818125055.1226708-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250818125055.1226708-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0smXnaOGWK8SG8iXX8MLMPridjuYREhm
X-Authority-Analysis: v=2.4 cv=ZJHXmW7b c=1 sm=1 tr=0 ts=68a321b7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=8nb5IOs2KV4HrawvOq4A:9
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0smXnaOGWK8SG8iXX8MLMPridjuYREhm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyOCBTYWx0ZWRfX+glWbWYOp4/R
 BRdRIc5P74OL0xbfOEisl5JJN+dBcRknD20VlXcPSSj6ufrhKfsnUlFkuo5ZdPoYbcyCBWKJZlp
 4txU7hiGVBCmmOrJXap4BhrrqLe6Rj6q7E2NF+qPqwDPvm7L2IXMuyV3rF6m4agdfIyOpNCr5Yz
 pbpxqlQdkorNJlieofeHQNUL5nzIAPF6tW4utWzcdV7wwalvwxK0GHPPESVBNZi5akyLwVZUpAK
 TAM4KD0U50GLTj8EO+sVYvExuYsA0P0dyg7AhRKftVUP+lJY9dJIlk7Fb8NMoNYfk7XieKxhusE
 wHgi4tJIy0kGoQfFKfzbZGKaY5+R2ZAfB0Fe7krJvIOnY0r3G/a1f1osNd7XWNlJCGYLb3GF56U
 NmVjZVHr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160028

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


