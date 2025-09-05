Return-Path: <linux-kernel+bounces-803194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3441B45BF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0E6188F084
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1C31B82B;
	Fri,  5 Sep 2025 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f7TAX/B8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE931B806
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084736; cv=none; b=QqbnEMzLgJGBJBGMQN8xNabBlwRu2EwIF5Gt3eAlj7hy7USuS3KIK7Jc+wzsoY0MDDReWP6cZ1oC2216V72khqsBlMx6linNpyTrQQOvev2cU9p8+SfmU2CGlYSfv3xe022XcQM8J6v1rgnymC/i/yU5F9euynsalusmZnQqLlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084736; c=relaxed/simple;
	bh=u65y2jSDRLaSgr2s4XMiseR1rskbbKzZS6Ts4b/elFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mxlRaUvBy7RyyRcpWeiIMdn3N+3eiilA7gmYzn23l+WLRIkWAA/W9uOkgQ27bPhgWoj7TM26BrWbt3FfQljwZoHxT2OC5byBCPUqr1ba1f8stCkWBswdROEqzrRbD2NE3hAreBNVvITJCIVYRiK9r/0TRnJwlOSSnN+ivz0HAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f7TAX/B8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856m1D4032210
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 15:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ln4QrHvRmvl
	Sj7VRoWV0fWCKQ+IjhQYN87ftM4Mr5ZQ=; b=f7TAX/B8rTXwsoc1S9Z/ygzk6Bs
	+XUSbGPFp6Ni3ax/u21rOusfDLgn66DM4elHq9EZj39wNzHzsudKmy/qLIFvfB8U
	5GpBbJuh/paJS9E2wE+G88FvdIY85UjwOIZFfx82oY1L8mmanN0f2Ok0BKvpnsPw
	eU8KtKKdIorvHZTc3m2ZkREnHcWJsQcbMOQTmY2HhJVGIY68Aw6FWdHbzg2GXRYZ
	WAk94UNBIlneT4dYQq8nNJJS3mZt3H1tsy1qSXhOCXw3xtoHl5bu/LtJAroBhaYD
	9SyW7h00x3vXtiUrF02ORanA2AycAEArrcMl3e7U/FeaY1M5xeFztDZNdOw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpkn1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:05:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-329e375d372so2907174a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084732; x=1757689532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ln4QrHvRmvlSj7VRoWV0fWCKQ+IjhQYN87ftM4Mr5ZQ=;
        b=e+1LjcXM+7CTwbvqWyzoazXFRwnP2BE8rXDhnik0G9MYDzJfTEhk1T2gAOCNKMsQku
         dW3VV7+Dpht7vHktePTBMGqMADKq155VWvV/+pitcr1nB+oWqJ5CO+W2+8N6S+16duBy
         CYTYQxeoQUPLXrrEDH6yvNDOBuUhpdRIvy7td6W8CajvQYcNrx3z9W+XPrRjtRel7NSp
         0rVwP3Zfkj3ecpVBAX/CuHlRi5olj+UQFccT2SgA3G0Knvx4i96fIcKHi/409tXSb5ux
         tGJlZcvVtjhxNnI/Cbn24vOT4wCOarMuqviypz3I+qteNci06I/k3uOYlmO9iKkMfsU/
         Tivg==
X-Forwarded-Encrypted: i=1; AJvYcCW6g2J/zEmeB0kJM9ouM/DnlZ2K7Tg4QvHPMEqUcxfFZzWTY/jWhzrtWtLvbhk6K9d788Zw1LR/8XFXlkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx49R30oUUdABJoD4uki/mKyta/kJ6GZrq+vaz2xnWq9KOBVXSt
	pDvNPSLf+ITzuhRg49vPY5nC+R24iTcyIVPz7Nt0I8rOHs9sA4dsFGXq4KPrXhJasrFaHb9n9yG
	jo6/9ZY1iyj5cbkeTue6ZKAOzCMJA11vNwep+5Bit2xtXMaWM00QxGSaFuiw5LTfHuh/33EkwlQ
	I=
X-Gm-Gg: ASbGncva2S+Tz/H5cnUGr9WDvei6wl1iDvJnDqeb2tLDOfO9OPfb6jbstj/qsQirQzy
	qgELYwygbczFVQjCsJolr2umq40TQQSNijShGdoxEz/PUto1jdOPKUfM6CDZaOerrAM76wOk0iZ
	5kL2ZV5kQdqYZM48qFJXhNVHmUFwUJfRNDRSbFxWLcgdV5prXYGwZyCAvc2ugg6XH6UolRIUekG
	D3i9EYEi9s8BfxMbEyAiqkdUk7p67+BcR4wjgV3AZG0l4tsPkvDfpr0BVeC4U/KT8jdGCLW3TqH
	+cFvinYlm2KAtmddiUD1aNdF7rA/5eFcPYiLvA4a6bgkwjgblrmK9SBPfhtYNlTWXvjpya/ZEHR
	i
X-Received: by 2002:a17:90a:d40c:b0:32b:e42d:649f with SMTP id 98e67ed59e1d1-32be42d656emr1455909a91.4.1757084732311;
        Fri, 05 Sep 2025 08:05:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDmM3rGXxEcUOcvGJH9jngE6DgxXhxZQFlWg53KST+M+4unP4or4/YJLIttQc0R5ta/Pf+0Q==
X-Received: by 2002:a17:90a:d40c:b0:32b:e42d:649f with SMTP id 98e67ed59e1d1-32be42d656emr1455857a91.4.1757084731777;
        Fri, 05 Sep 2025 08:05:31 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcf04b8sm28882840a91.26.2025.09.05.08.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:05:31 -0700 (PDT)
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
Subject: [PATCH v3 1/3] ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S interface
Date: Fri,  5 Sep 2025 20:34:43 +0530
Message-Id: <20250905150445.2596140-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xqrVINw_V1MRCYRlPan7aGm3KdSYne48
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68bafc3e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5HF5tzHaENt2U_M8s7UA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: xqrVINw_V1MRCYRlPan7aGm3KdSYne48
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX4B6I84yuYmS5
 +RRxeSNIfntSyoWCrjZn540shY4inOCMSurrh/oGwz0y0taBMRmgYf72G3L8sBbcdQCmWQ2KZmI
 Ald+2b6WvYjjYJIuwUYW2AeE40nA7UeUUnjWeTr6MEHP53d1fKcQiORxu0wwECGWJ3OzsCBaNZy
 sxjSj0plPBniy93jwS9sLgLIBgVVEm7co2+nP4I3G/UoK2/pYvIeWRO3E+ewToH8beRdUgTGywm
 /6Qlzsfz8k4Dg8i2bDU9o0n3DqrrnwfqirB87+v6tugOiFOiVxTrzevsD10p3jBhKfgcvaJN4KG
 mJ4FkBl4lJdZF39CpoR4c6Jd1Y4zpSLXz3rurqQNbtg/Hpl9gXX2P4XpOCpiWJk4O1LXdE2WO39
 v23Ff/MK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

Fix missing lpaif_type configuration for the I2S interface.
The proper lpaif interface type required to allow DSP to vote
appropriate clock setting for I2S interface.

Fixes: 25ab80db6b133 ("ASoC: qdsp6: audioreach: add module configuration command helpers")
Cc: <stable@vger.kernel.org>
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


