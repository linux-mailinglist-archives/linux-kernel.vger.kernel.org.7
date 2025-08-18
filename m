Return-Path: <linux-kernel+bounces-773543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A60B2A1A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B1E18A1FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C7B32274E;
	Mon, 18 Aug 2025 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i4Okl02F"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2837320CBF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519778; cv=none; b=KoCftkm882aFYlQmn4PpF8QPLH4OCO3M++RZY850lPyeZt2CNSISm1DuWHWFg4Zxne/zoVTfROEdYssz9nmg3Oi8R2dPCFm0AbSr3F2I93lHx1V27xp7WFoKPowTK2JK7bSbpB4Mr16sV8nfJaw6QBaj5YczgEOAz1AoXI8B1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519778; c=relaxed/simple;
	bh=JCKIVW3Vnp7HuLWLnbUgbVk+bUV6UaYytum8NP0pPgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nD86k1MGC1DAnGNQRLQp2lwOiSImVGUKDHRpriLrd9DqZS+LRrMESXS3mKVnpeTeIRp7UP/b8MRwdF36tlsK6iH5bf0bc4kKCWr1uwOlTLcg75fb/HlSiBIViKqITMdvc4qxVpoO5tLhQqC2Jn3LWI8veV+8da1qcXVjSHcIl5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i4Okl02F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8QvOk016840
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Q1s0Zyj4qhx
	N9eeMbMRlym+e7IsQucdcHjllLnnn6HQ=; b=i4Okl02FpVqyfsGJmwyYg4lkCrY
	djDTnu0DzZsndu5uWBIIr7ndJk91LF1s2j7dWyHB9ut6FnDZZ1umhzbikjSBoXce
	/G8ic68fqTY1UKTYiXk93PahNH91OQi4vy5X6gmz42CiWNBHLhm5VkRRRGIRK7XS
	MVWmX6XfYsoHsCeUw2LVbVA0bt4RvA5Zz1/GNoHMVywPFL8OjujH23yd2rbclo6U
	dsyYeT9PDkUmDOhbvxIdbQwq02Z5vEIIi3Cr86wMeDumbkOOnfkKLs7klbEeiEFc
	7inxbEHH8SXSZ3Bik5wtATp2oNMHz0xMmcynPffzsuHCbCVF/WQTVS/W+uQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhjycpw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a92827a70so93719516d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519775; x=1756124575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1s0Zyj4qhxN9eeMbMRlym+e7IsQucdcHjllLnnn6HQ=;
        b=qv/vcJCU9kCCayhpJZSTcENiAAMNr3y5IteH8OA9F5avewFGpz3HUdG/sQSoxD/6y1
         gZU14A6f/cFCWRiougtm99K7wzZP7EFH9mag+bRCqnAruwO6e1P/0OPgEuOQus6Ut2rt
         oayiH2nFQI8o/J0UsWJ0ReIFhSBPiwAy+5LxttWMkodaHVSvRy/N6dP+fKKw4Et2HdEU
         RonW3dPpBDYgginKZj1Vgc+SPoCkH0/RZ85tS4IDb5UtlzhJFmAPo62MThjbma+NH/63
         NR+HpPXRp848CnOYgL6WHBb9P7pw6TRG526CBScdTQw15QuavZhKpf3jlIDfob79k0+o
         lkOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX8MfXonk7UX+CsDPuVaiEvSpX+sXnE0KKvG3kIXo1RtTV0TNG0FRKge6IQn9YN/5WZJ5pQ2OahLEqDy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH2MMWAJijBiqE56jgYoxusSuQI1Q+wSlczkZ9tKv9o4uJGNyt
	Clp9VLJlg0/FQKrs+QjQ+8yCqdkIl+N6cKNPz4jo0EP2y/tO/KG7ZiNngMDKEqmdZAWZII/x2Ts
	kr18EIGMrEMwudihBLpItxayQ5fi+sT0z0K2JjoVedqWTemFBsB/PtLi9B5kx8BXrVXE=
X-Gm-Gg: ASbGncuwflnKp8LU+MDQSV9yG+gHVNy0I7FRF+hgk0jGlaM1Bofr/YiWeoScb+bB++d
	OJpz6qs1B45iWGLtLXS+wtBmIba8sQY/uisTO3E9hlJOGOnIXOXb0uZQgB7oHsFTGTsbbRvAlLn
	5M2ounEnIyUzR0tHgeRLbPmqEhuJ5WZ9aqmCsYmvgDP4uwQe3IG+fcogO/VWtxHaEURuLkYjrMG
	+XVlRy/2a10oPBGiUjjCB4efAuy5oP9PIzW4/rSaEdNQgIORBzUGgMPgIJUNDwv6HgQewQ4ivSJ
	+on3KmyARuGKorftagFwaxjyqEnV3OWIqP+LVo6TeiDOe2P5N6cW3A==
X-Received: by 2002:a05:6214:20cb:b0:70a:cfa6:4028 with SMTP id 6a1803df08f44-70bb060c400mr102225326d6.25.1755519774769;
        Mon, 18 Aug 2025 05:22:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtod+zAN6dMjolYmwj14N6c1+Q0ATWvvWPcGCEBNXnfbj7vopuJbRImMQjax+QKZKBMkDymg==
X-Received: by 2002:a05:6214:20cb:b0:70a:cfa6:4028 with SMTP id 6a1803df08f44-70bb060c400mr102224866d6.25.1755519774299;
        Mon, 18 Aug 2025 05:22:54 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb653f657fsm12601563f8f.29.2025.08.18.05.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:22:53 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 5/6] ASoC: qcom: audioreach: sort modules based on hex ids
Date: Mon, 18 Aug 2025 13:22:39 +0100
Message-ID: <20250818122240.1223535-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250818122240.1223535-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250818122240.1223535-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1p_tPIGKSfW75mMJJaOEtNmq0P-FnprW
X-Authority-Analysis: v=2.4 cv=ZJHXmW7b c=1 sm=1 tr=0 ts=68a31b1f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=8nb5IOs2KV4HrawvOq4A:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 1p_tPIGKSfW75mMJJaOEtNmq0P-FnprW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyOCBTYWx0ZWRfXzkYdBZkm2jof
 5eZ9HX1x7oNADblKTICADjQRnrqPOjsZCtrfdzU6DBvy1fu+Y6tTzTZsO6METPQCaadDqrjOG59
 0gk21aMFkJ0/kvttlTjltgpvL1WZF/IHXdSFBfq5UkweIflfWg0IapZoEXJp3nzhvwDveWq+omE
 2KR3ugsLvNxLqX4TJolqCw5yLctXN7cmQ/D969kBXxSGN6ecTlhGaVpf65dQEeRDuJEm4cgWxuG
 Hme1RLbzFjZYOHIYoaJ+4SRQFirG+6cG65Mzvf1rVdU0H/Xochp5qTkk712DFWQx6vThqIYhAPg
 P2GvIR4rbnuoSNg+S5mdf46THJS41eMj+TiRxyoPMmDmB+w54FeYE9XsUyyvdT8M5qSgpxV7/FA
 taJZS2lA
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
---
 sound/soc/qcom/qdsp6/audioreach.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 512886042224..790fba96e34d 100644
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
 #define MODULE_ID_SMECNS_V2		0x07001031
 #define MODULE_ID_MP3_DECODE		0x0700103B
-- 
2.50.0


