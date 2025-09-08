Return-Path: <linux-kernel+bounces-805069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA96B483A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E9E164A2D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54BA2367C0;
	Mon,  8 Sep 2025 05:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cUG2nH/C"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A64231829
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 05:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309844; cv=none; b=KeVKTjAZGRUF2G7+5vRdcOVoE4Be5po7TgiuZISYjk+S2eqLv+0EaEV4CIp4/0loy4TDalPeW0h9UnNyFcKQ8EVsKo8Zko69WdG+JvOUGtygnt3q0BEhlhk2wqeREhfEpwBhH/pJtW1vwZ8l6GwcT7dYTkn8HZ0/YWReLEaIgRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309844; c=relaxed/simple;
	bh=3CtwootO+el+RrOJXyCia5V9rqAmA+AuWVwZzlzSH4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UhZrlm9BYQOlthKcXFyVoy2c8GlcKvy9hjG6XPv6c01bWceurVEXJ7NTNEz/17JLg2dm440FymE2jC3vkxnQaYLRvVH1KhBew5OMAI8+DBSMLT1QUbcc4pQsv7rpXzmwLSa/ijWDqxOBYObIh8f8WKEilp1g9lj/TXvWxigmgZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cUG2nH/C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587LGpFB004713
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 05:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LDwAG0QNYm3
	TJZCTHSe3Hq/KAWIgtpSzOrrjr5E3qM4=; b=cUG2nH/CXmCrTEOy2M53lSEGEyJ
	6s6rH9V9rLnvZPXzaX2u/aI/pBXwiCE70E0lb4x81vnwMGqxsmMW1x7e8Nkc2qWR
	ZQAxgyeiA2YxOQKK4gTG1fNAEmt6z8m89LYgyBhsRSXARozIq1Xeqc8r3WfLLqqK
	kGugwoiocLi/g5jPuTuwLsgCsaUiMEisldMAr4zll32wE0MOXjF3tftHpZtHPCXt
	I+5ETvHX4rlqOwjPIq62M3W5HIpvWTDrYIMF3aM3xT2ti1obnOXZbJgs1j6t8cQF
	9hBITDIPMt7lR+xIwK85ALi7eFu+1mbWG5z2gSLnRKlyfc/JcW7crNDG/dA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d63bae0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:37:21 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77283b2b5f7so8702243b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 22:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309841; x=1757914641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDwAG0QNYm3TJZCTHSe3Hq/KAWIgtpSzOrrjr5E3qM4=;
        b=f0nnj9EpW7BKgDJGmw1hZSmSjfj9uPECfQ6qWHDVIzIKIVq2znqbN7QqOEmEWq+OdN
         luJ0Ys0yGmVpDCVVd/WZrk/fWcCrpPkUwHGY6c72kYmFVWD67a7F8TMs8HObV8FW2hhP
         2ZL/yEmRicYf0qa5Su5J3/zp4j9DsPw+sJ2x31cQCcCTRoHwvfpeY4p3mujPzLBo9G8J
         pWLAW+Qc7yfN3aMt4lA5awoSoL6dJ+YFdi5rnUEjINRlMu/qmM55vegqr/1bx4WfZb3a
         CcsFyItPRVhOeJ3oXothuf7BvbTHHGYsaSoCFa7qxlyuKZScisIwlsCcgNEssxCIjvF8
         ACfw==
X-Forwarded-Encrypted: i=1; AJvYcCUbypjWNgIiK4rLRtpJ/BEc18B6Fs3UxlPBCEiV0h3b7Oca240q0tCyS6XCIUvLM0//lO40CJ2hlQ/BGGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcU1Rg+AtPPR28uj9q/A6CNXF/Yrx1qYPCEqViy6EkKqJo3j1j
	UaBxFxvfvf884SzvaGmX1Ihjav9nfLG7LXqwC3UKWaJ7VINo45vLh00Sxhx/+i1Xun2/DX03k7A
	yz90ynwnYfxZ3Uch/idA5HtCycALoJtxQNuovEPCFKlcYEDTFI5SshqKNFgf9l3Ttu9w=
X-Gm-Gg: ASbGncsII4KiUgUqLvjQBQj4dKndBYj2NO2TXIm71X1MkPLP+TJp2t5FyUwFAggJx+1
	NddK2RFRLmhgrplOmCs942+H70fwT3BrX6PBNVOw0XE9VehLHeBaowA+HeW8xn5uvSgo8cCasM5
	93NPOaUa7qUiaRzTl9xgDjE8/MReCQhC3Q9tNrlyajoihHb+jm9V57XJaH02FCt2Z1g78u9tGph
	c+zB3U/vpf3YuaWcQr91CoF19Q7Ryxf3F4RFhImalDmphg803DgQNBnwt3Ul5JQebGrY3Ka7d/T
	Ssegyo0XeU5Y8KjYv5UEJy8VkSe3MhiuM/8X+kHWQyLX/q9D1dHCwb1YQLnpdzWx1atcMGWA6U+
	J
X-Received: by 2002:aa7:8882:0:b0:771:e179:343a with SMTP id d2e1a72fcca58-7742dea0275mr10773500b3a.17.1757309840823;
        Sun, 07 Sep 2025 22:37:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtn70IgXvQ4aGWZkJAzdfomHZs4vLGdZ2n6w4YrYjD5Z31iweF4zdq2ah09rQn9ZRQmSTSlA==
X-Received: by 2002:aa7:8882:0:b0:771:e179:343a with SMTP id d2e1a72fcca58-7742dea0275mr10773474b3a.17.1757309840408;
        Sun, 07 Sep 2025 22:37:20 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d4fsm28013488b3a.73.2025.09.07.22.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:37:20 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v4 1/3] ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S interface
Date: Mon,  8 Sep 2025 11:06:29 +0530
Message-Id: <20250908053631.70978-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908053631.70978-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250908053631.70978-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyOSBTYWx0ZWRfX2FVyoimRqxfs
 y2NmVEuPbXMtN2HtenFAjVlmNXhIl6u/SMPJeuqeiJLb/vEaVekuZPosxpo6P3/0jBYbs/fyg2u
 zihCkd3KzU1JsdLqeHdDi1IPCWflgSjheF8A8XWByqD6h+tlHl+XgRMaIcNoXg0tuWR0ZWJTBTO
 eHLKXaJoYe6KVNPwX3K2ZFYZPbsSV2NknGqDMQHCaUF6s9/+5snVpX+Js2f1F4TU1splr6fg6lB
 Qp4PniCwsvrtYkBEjX/glbTXv/ZfbV+e5RrYhVGj/pxHHuvxqD0fIsjEiQT2kpsohWS9TQ7SL3k
 nKtjSvAYZcoJrYXc/6OdwBHMaGFMJdyyzdoqdL1UkMUVI0WkPAFRsCEInJ7mnUjZKSm2QzZbJnk
 jn14nOf4
X-Proofpoint-GUID: P9eNKkoJ2pu6pOXlcPWCex8j8ofEcN9X
X-Proofpoint-ORIG-GUID: P9eNKkoJ2pu6pOXlcPWCex8j8ofEcN9X
X-Authority-Analysis: v=2.4 cv=DYgXqutW c=1 sm=1 tr=0 ts=68be6b91 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5HF5tzHaENt2U_M8s7UA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060029

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


