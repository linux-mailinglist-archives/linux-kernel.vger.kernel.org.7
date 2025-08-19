Return-Path: <linux-kernel+bounces-775275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED747B2BD62
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB61165630
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156DC31CA61;
	Tue, 19 Aug 2025 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XROCsWtZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3631A057
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595621; cv=none; b=a0yBbeErV13bnp/QrEnuM+AbqMPJ5JI3DTpF2yDoBtLjnv0uZmrAUqahuD6lA5UMCpngXCR8W/63daNbvGjLmky/6uDf0sf2Q+hjg2laaR+v3l+DWxM1GsOebD+Xe9sZeOPDycyaBRgWzcTpTdFtm408j92oImzJhuR/f6D8ZsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595621; c=relaxed/simple;
	bh=qwuYqZpPtHuX/2WTSLKobMX+4muge/nS9jt2JifQjdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrYS4zwuEeToAwF19Qg7GMBB0miy4dbB04jWIudA8YHdCa9puVJ8lpjSsbk1x4wkrzsdJtS15hBemCC9I0k8UAPpCwCcZAqdzWHC9/UwbQTbhiyecOP0JJK861WnhmZnKb8NnI30ehZbKqH+9w9XHql/6QV0tcDLxGHOZMxcLVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XROCsWtZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90Ymh000864
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JQBp3mqbspP
	8PIJt9/SllqFn7BROE0fyDwOwOB0VX5s=; b=XROCsWtZdLU9OlrL9JXQ80VNU4S
	fV9cR27u+nJS/0bQgu9RLMZV4rbo6b6jM57Fxy+/AtPE/IOY6hPiFXlxQqOpZujI
	+3umOBaVK8DVMWbTTMULMW+yWFVcmtBC6cZFsApsewBs/u177n/cg9DwBboPiBe1
	EdDLmdANWI9UtDxav9JA8IUnF+s9Fn/zw9cO3sU1WtlyRccmjYXzAy+2LDWHjeT1
	x+i2DFr/ceCKZmCMuRYCLq6jwowte0AWuT4LccPAU/WHYk8xuh8QBFAOHZz5HBxM
	5FFhyU//w5EPwj4jgRgdoK1LECQGcOrRtrv3cY17JdFaD95XsZ08f9b4g8w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh077yvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:26:58 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f55836dso120034336d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755595617; x=1756200417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQBp3mqbspP8PIJt9/SllqFn7BROE0fyDwOwOB0VX5s=;
        b=sj4udodMC+3wK0gHFm9BFI1FyFrKdvO7WGxKf2crvNoceYJT+CQb/NedJzOR9LQ0dB
         1l9YkcWDYH37zOKWKv/dxYFIR034rREqZWG3DwotQIin+OMj/u0XuusvHDAvQ4+eWlP/
         KBmcWfePdEJ5ER9l7a0bubsZIqyf1b86L1GTbQYOxZguy90V2sQNhfc3bnFYJt9ghYHI
         ImIxpSguLEQY29X3B3Ywg70bdVG9HlfVIr9+Tf7J93dIn2ehWAL/4djNfPXWSBjERgSp
         pAPW/p3JN6Z+hEREnmcb+gAEJP/TBS/04oBvpzlFPNhDDQSvlfCtv5e/0MmNX091+zLi
         S21g==
X-Forwarded-Encrypted: i=1; AJvYcCXk3hx2vt5NuhntS76MZN3UGSmDGvqvuh0Bmog3wiw9Ij5CARo10ngGekXL82rCbph5nXP5XAyBj05lx7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg9iXzD2Nnio9EX8JaiFuzSdwQY9o/yJLuPeHqfU4fhudEQ9+q
	pyp3BlbuGjio4xwH+Ld5AoeC1nwf8DPIYd+jrHnIpaFKTvnl6so/iCnpX8c3Bxx4j0/mRI3yNre
	tqoiRf9PKGU87vqesqyKFpArL0KCbsBTG2NHxNS+jYaN/+iIZWMHXPc0yeksctY/+FqE=
X-Gm-Gg: ASbGncsNYYlA37tuE+8Rdi46IpRZ/tmRL258BHGxqei4oFwV7DinkmqeUTSFU3iTuUs
	72lMVhSaChz2UMHTM89alcl8QvgPIISzA4FcBpCSyc89OwspMf44eXRMV1O9VeCXWABZ0o6bufj
	IcU+jruqpDeGA5zaylVI7g/9P4wA9pif95ySMVu+2Zf+XB1Zjfr0/+jLONDQqSSo1MLecLfGNSe
	+6QhNgahCmJ3rVzDGH10+FFY+XHq3S7ILIqFEEJwcdgiChPBMQtBcqldTxJdQEb2Rhlxnp92Sab
	/IpKnRsJy8wbJfoatlK0p1RqiF4cz2SJxOZcEUZYJFz1fQnYz/ylvw==
X-Received: by 2002:a0c:f108:0:b0:70d:6de2:1b37 with SMTP id 6a1803df08f44-70d6de22760mr4529356d6.67.1755595617575;
        Tue, 19 Aug 2025 02:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzftwVvjZcbKx/aSVqHKdnD4XxyQfgbD2fI7yrWqryMV1/2Uiqfb40Par5qwmq0JDIgoaFYg==
X-Received: by 2002:a0c:f108:0:b0:70d:6de2:1b37 with SMTP id 6a1803df08f44-70d6de22760mr4529136d6.67.1755595617115;
        Tue, 19 Aug 2025 02:26:57 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077788df7sm2942284f8f.48.2025.08.19.02.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:26:56 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v4 2/6] ASoC: qcom: audioreach: add documentation for i2s interface type
Date: Tue, 19 Aug 2025 10:26:48 +0100
Message-ID: <20250819092652.1291164-3-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: WWEKtoIC84_FavqVjUSTetAcsdjPFbIn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX5eS28Vy1qauN
 doiyd1Wgrsk866RLitxtZ39vCbLAEi+F8LyhZkmSnQu3wTC5isekJ+5YSRpjOLDoHS8ioUlT0mB
 +raM89SBUyVDofc4ZIa2w17YVjamPJ4zKzIhuHi4mFyWmIwPfqZ8ticxAWDd7tnPIIXTBFoXCj6
 BIB8qhQsJlY4uCuldeugeHQteukYO6xHy5AZyyLedh1kHQxaEDWmvSXTWN1QxPiALINjs6i7toF
 4aB6NQkb7md+GRyhZBm0f6TRA6aCMK+75GrMMPO4WmFEcqhIj6OteX1NEARI5gkkDndVPqUmZkW
 22FjHhRB256+frmzvXZt0l4ttlhuC0IdbNHL4oflQL+SLAyjsOAPqxln2onzblKOZOxIutF1bHG
 M2D9H/lI
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a44362 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=FY2npp4C09wRtmNKfY8A:9
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: WWEKtoIC84_FavqVjUSTetAcsdjPFbIn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Add documentation of possible values for I2S interface types,
currently this is only documented for DMA module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/uapi/sound/snd_ar_tokens.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/sound/snd_ar_tokens.h b/include/uapi/sound/snd_ar_tokens.h
index bc0b1bede00c..92cf72a6fdd4 100644
--- a/include/uapi/sound/snd_ar_tokens.h
+++ b/include/uapi/sound/snd_ar_tokens.h
@@ -118,6 +118,12 @@ enum ar_event_types {
  *						LPAIF_WSA = 2,
  *						LPAIF_VA = 3,
  *						LPAIF_AXI = 4
+ * Possible values for MI2S
+ *						I2S_INTF_TYPE_PRIMARY = 0,
+ *						I2S_INTF_TYPE_SECONDARY = 1,
+ *						I2S_INTF_TYPE_TERTIARY = 2,
+ *						I2S_INTF_TYPE_QUATERNARY = 3,
+ *						I2S_INTF_TYPE_QUINARY = 4,
  *
  * %AR_TKN_U32_MODULE_FMT_INTERLEAVE:		PCM Interleaving
  *						PCM_INTERLEAVED = 1,
-- 
2.50.0


