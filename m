Return-Path: <linux-kernel+bounces-811437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF17DB5290C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A39D3A699F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A688827145C;
	Thu, 11 Sep 2025 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ntDBUzej"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2062701DC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572600; cv=none; b=J14U2bocItkJGiL9MTZvO+rlQCB0CvNMIhF2XVOFRp6WWel8ztWERmyQufSJFcTgEAtJQPyiPGkLOngPJLwbbZo7C/woEoM9NQKku1EgrpMtrnslV82LBY48b6vrK0Lw59/yuyxblH1Km7//g8C0SIhaUEbsjghGTvYE3yArBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572600; c=relaxed/simple;
	bh=3CtwootO+el+RrOJXyCia5V9rqAmA+AuWVwZzlzSH4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n5+jlGq8pAJSteKgS1IJSGLmTk11c2SFGMIXLGxV7NdeBosegyPjEiKJAode+r6e1G3DbMu5M6HtsMun68sRRKBtah9vbOePxqcoWBZx6jXoRUkUnYzUF1rMx70JLQ3qX6eIf/A1NRZrVNVfe+zvaLh1eI3V4K+8qhnHqYLg3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ntDBUzej; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2J5Lc026648
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LDwAG0QNYm3
	TJZCTHSe3Hq/KAWIgtpSzOrrjr5E3qM4=; b=ntDBUzejHlJ2XmULBN49Yg0/iAV
	tDqw8/f+eFEHDpEjp8OX033z1fsrIOeyduQS6CGswkWkuBJNQ1dqXcx4alhEHSOX
	85TMDmy9BnH0pe5y5f5kB8z5pSzgvKynSOtotsz/+NDKi3v+uYal05NSPwn6ORUx
	vpdnjsbVses99qJXb/ww9K4TKSWroF0+1exBHRMGuLw2RvRKUi/aom8xHBcPdNSQ
	l6/ntFgg7snVpVxwnl3x/gGFr39Jn+Lj9iNrp6adlUTLnXUYNennQn7P+d+dzHWd
	yXYYwbUsG35YLQSGgT5cruhcNdUCJ5pG5q4HJEhDTJbwoe7uUwzbQOvHwdA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0xfmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:36:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b521ae330b0so353558a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757572596; x=1758177396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDwAG0QNYm3TJZCTHSe3Hq/KAWIgtpSzOrrjr5E3qM4=;
        b=AkPoSdWJCEH/IrsAKAsqzdDrMyIOYAI3iO3mBA4M3uBUTYNcoVGjti7O4zADr0uGRA
         n6LWbhiSnknbNwly0zg8ZpL8otBNVFC9NAoO1FQ2toLUpRrq411xb9BImOG4aiw4xT5t
         4jM9+VjCtkVbtJH9llcm9LwY9+l87LsIvRZNBM4Ani6+2X1o54mm+4bevH5AOJyniz4r
         MxOusKjwNdvZNKR7WKMxhw1JzdhV3ZybcUPkVgRoOqVvobtAIOCVyXdUPX4p5yEHAth5
         Od4faRIT2exwRC/H5AsdEMcj79cIJhT9g/UNzhlThox/i6F4C4rh/EQhex9CSAGOgARx
         4Iog==
X-Forwarded-Encrypted: i=1; AJvYcCVGLOaVBn+ixz/2BAw3YVJj489TZumgHhFQEnFNLgJ92HnaPA4dsZVdTZgbOqNYr9O+Y38iGX9sMOYPeKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhVHMSzrHADGSNGQj4dGefTg5aSHf2GAFQ9tBU3wvh03XDjk+x
	jrdYzGIgq4OzwGJGzjtc2vFWRhbi2fbB41Tt0qGGa/Wdv3uxOqzJ2GcRwOIGoCVT0PTeA9s7Cv/
	8BOsZwybi5XOyG1gZhydV+9TbOso2TVXmLweThHpWlE1xvhKQqRI+4nP4X0VxvQSCR3A=
X-Gm-Gg: ASbGncskxSw5AgOOFrsgdYqOcTKV9zUbg3eh3dPLUTRcotrRPZqOJNkHhzb7XzeXsyB
	LR+OJV8gAi4s4Iuog0oJt6bQK7b68fjWY9wGw7rxlpFdl0rDLcoaNaz2uE+nvQvCdty3p8P4mxT
	5AvfgFiGuhd8mK9bSW3HzXntgZGJeiTagBeouHvfVwZ6y5E2hiIWulprJcRN+LlQ5k5jhujoANJ
	z+5BzhVeMQRFy31XtcM42O7UMyxQxJnon/fEF/6VKtaiwqa0jFddC2hO5J96tZL2YdcBS6jT75M
	HfuXkkFJZjGn6BJwPA/b84M51RffAjfrDvli0oiswvL6xd9ieUv7/x9lspu0YfSeTU6J3gGbTLU
	X
X-Received: by 2002:a17:902:ea0a:b0:246:80ef:87fc with SMTP id d9443c01a7336-25174c1a958mr256279865ad.45.1757572596442;
        Wed, 10 Sep 2025 23:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcacMkV67nbieIIaWIuOTTD3vj8ct2khst5MgT+t512ruIpzEk5hxAb/P/xJMf3FaHrDwZdg==
X-Received: by 2002:a17:902:ea0a:b0:246:80ef:87fc with SMTP id d9443c01a7336-25174c1a958mr256279695ad.45.1757572595996;
        Wed, 10 Sep 2025 23:36:35 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84f72fsm7739125ad.72.2025.09.10.23.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 23:36:35 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [RESEND PATCH v4 1/3] ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S interface
Date: Thu, 11 Sep 2025 12:06:10 +0530
Message-Id: <20250911063612.2242184-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911063612.2242184-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250911063612.2242184-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CO5uEgGvaXX-IIGe8zTBLfk98yJNw8TS
X-Proofpoint-GUID: CO5uEgGvaXX-IIGe8zTBLfk98yJNw8TS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX/ASncDaohWkX
 NCiLJipDsuEGnct+jSyPzfQr/930I2ByufVMrbkaImpKHa258Tv5c7fHMVn0HCDRKnPtuejT+dw
 jy+rtWyuqY1DYEsOJA12X3cwUmxbAZMqSlH92KBTiK5cN1DwrkObhSUg53Sq02wcYnAKNMim7so
 fyY9HOQhTd3sZaXsR0/ytughVUSwskTPNq34UcKw973Gxnh+lWoTQQInPuF3Q7mCKSTCSFEjPSO
 l/M+Gy/f55Pb4D/vvxKePLzDwfCvPnIydLbTN/M+l8yPtfSe68fuuvbG09NWyw3WtP/kCz9aHSJ
 dQgzBMvzGyD2n/po7XsV+OeiPghqjW3WiuAdfDZiuiR393IWhirCiEC/Bn3nMCWEqTr7aI8QGJX
 TgwufdI2
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c26df5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5HF5tzHaENt2U_M8s7UA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

Fix missing lpaif_type configuration for the I2S interface.
The proper lpaif interface type required to allow DSP to vote
appropriate clock setting for I2S interface.

Fixes: 25ab80db6b133 ("ASoC: qdsp6: audioreach: add module configuration command helpers")
Cc: stable@vger.kernel.org
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/audioreach.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index bbfd51db8797..be21d5f6af8a 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -995,6 +995,7 @@ static int audioreach_i2s_set_media_format(struct q6apm_graph *graph,
 	param_data->param_id = PARAM_ID_I2S_INTF_CFG;
 	param_data->param_size = ic_sz - APM_MODULE_PARAM_DATA_SIZE;
 
+	intf_cfg->cfg.lpaif_type = module->hw_interface_type;
 	intf_cfg->cfg.intf_idx = module->hw_interface_idx;
 	intf_cfg->cfg.sd_line_idx = module->sd_line_idx;
 
-- 
2.34.1


