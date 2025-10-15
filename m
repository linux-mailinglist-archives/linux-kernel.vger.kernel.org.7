Return-Path: <linux-kernel+bounces-854561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69716BDEB87
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DE8D505A77
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D076921E0AF;
	Wed, 15 Oct 2025 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WX0EQMAt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F101EDA26
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534294; cv=none; b=WZNEff9KaRi71yfNE6OcLXCc838axLQG8Hyz/epOOS5LhAa52qi9+3KefdwKh12g8WvmK9cnOYaJaPK+RUdsOQctSJFUXqxtgUwblpo7ZwbeahzSf5n+gB9CFVSrp0buHBPY4af3bOQYdX/21WInvm8W5OJ2DBgfKTXkUQirVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534294; c=relaxed/simple;
	bh=HfYmjuwrOg7v2qvvURtfwZZNDS6Z63hBaD8sZwee7fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbNhc0LjV5KLP9pSONymmklXHL8w38hfrL5KAysKOF+FLNFMdkrieZ1NsYjvp+ebtvKQG5IOevWDrrpjja4B4FZwo8kmB1s5251Xtc+uk4m/3qLsD13CsR2ysUKbqQUoqekClQANTmp6cdnnnZvaG2Aj8OEX9KDeI95CkH5bs5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WX0EQMAt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FB0rZa014785
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ocdibrsg4QK
	6oNvgystrIsFuQNDpepXOkPernNyibCM=; b=WX0EQMAtstiub/cyNMRVC4ElcP5
	B66aQcPojC3LngkU1/COz1+/Dv/QF0ojC/00YhNnMiS8EknscHQf4j6MO136PawD
	8LKK2R6PqfBiADK4ghBUGcPouLrvSUXS44IzDi6h23beg1TIolAQxdPsW5LxQptj
	ayeHrXCTGNAz9nmNGa6eOngLyY0/MCaHT7/lPY8RCg1JLRNYQje7x+Qo6MXCOJ2Q
	B4ThcuiRwaCKPu1Ob7UROSEjLeqIAW5jQgNgqVEQOv+jDYfIWedsiaR2JyUJkjZb
	8taVvBj5aLtfTJVS6QzP5JDousnpoKp18aNKk6OoqKm5EWHh6l9xvZDR58A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbj4hbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88ec911196aso115788785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534288; x=1761139088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocdibrsg4QK6oNvgystrIsFuQNDpepXOkPernNyibCM=;
        b=kkIPDqYmAPvOPzv6NREZlFo3W7zFHJS0yoeJSp4gdPPMPsdB5x0OdOs9sdn2BUeORl
         qYLDIUe5zt1IGMKeS5mcKR5r0m6bsbxwDFNd2pf846fwfnXWE7dIQrOeQ8dV4pcTOrHc
         uTeDzuk73QDK7R4pN21Tori+qz9epBmZQJ1phF8ECnpBNKA3x9sbexGJTV6gsEJskCAY
         d892Om1lrKwEfUGM6QoU67jYSEsDy8hi+uChzPPoZYKqKlzzT7Kxfb4E6eLfXB8lqInr
         QloOlnEy5ropXy3LQpKBO1TG/C4rubVcqarPbDuo+ecJ1IfgIVFPorxDBPw/x43pAwTp
         l7zw==
X-Forwarded-Encrypted: i=1; AJvYcCXFsNp3G7CaFH36kwxTnq674IgdPvU7AaR4LJucysYAsYeDRIN9hdirVUB52DIRcuR7OI32zHtWKttS9Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwegC9Ai1mNqQAAJDcGb6u2gWFa5KM5ELSGN8p4LoFAgCJNV0Bx
	HdtG5VCj21vMj19MxjAmVnRBDWZTZY8DEkofumwrnWw6ulHcAX/ZtU66WufPsx/x8MZeVklP1Xn
	NV+9SSx5vQTWcUj/yUXHl33jqdHRFfZLD38SFv+0ex66UWx+65pEnILCNueuXui5DwmM=
X-Gm-Gg: ASbGncuAIr/rDgVBloNvgne5GOStnGMHPgnay9jWNh7ASa9s0V6yrqQkOONqGI2oggU
	bEelIb7i0q4djBnm0kloBy5K4kMxH5ZniVX4058TLObqWR7fNmUrsvHFG+3X4S+4l5DR1Kfzfev
	M24T3MjWzZKR2wj3elVVimoxQNW+Dg2stU0Gg31yPcLzLU/Dwv760iQ3YH5H68CfY2Ua+LBGCnV
	Ts2us1Lh0DlpiGdpstthag8cWMRtLu8/NRMoFWCjS0cyQ+NOlnLQpV52JMil6mht1HpOMBuJZqP
	LpXxbRppZWCSMJ5KASHRMUro7NY+QYKmGogAn/c2p5Lc3y4EaNQotg==
X-Received: by 2002:a05:622a:1116:b0:4e7:2644:f3cd with SMTP id d75a77b69052e-4e72644f434mr135028011cf.70.1760534288433;
        Wed, 15 Oct 2025 06:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzw5RKXMUAYsikIggquflBgezust1UvJBHDF7SI2jiFbC8VMnSSIP38h2hOOqJ/sUiesXeqQ==
X-Received: by 2002:a05:622a:1116:b0:4e7:2644:f3cd with SMTP id d75a77b69052e-4e72644f434mr135027391cf.70.1760534287838;
        Wed, 15 Oct 2025 06:18:07 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc155143fsm262081245e9.11.2025.10.15.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:18:07 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH 1/9] ASoC: qcom: q6apm-dai: set flags to reflect correct operation of appl_ptr
Date: Wed, 15 Oct 2025 14:17:31 +0100
Message-ID: <20251015131740.340258-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX0WPxv5UvzIaA
 WXE38945yn6L/kuzjHmOTOx3nXrA3Mw66+yIZBJAQu8w8cLcDVJCesEjDm3Cv3L7eDc6E1NHc/q
 GqLONlptT+Gi512AnwyOGms974OgZySoyqLbJZzggTCNLz8q8vOnfPrGqBniW7axB2IuG1Q2y2d
 BaxtQjDOzz/nqojZnNvMrm3HntRjNi4Ec36kpkeTvRY90fgs42/J3W8kVwaMHlCuxlxT4URRq4L
 pFaQYmR4/wjKV9WAitZ7M4SrlPxVN3dHkql0ESHAG/MV09s1oMOe+/FD+llavF2h4NN6bIt72NB
 gltkPe29f9/HhVl6nP3eSe3bgYM6hw6edmaqkwhehe0SyXfFmHKGyDl6IZQQ9NOuWpmRKKvxUHV
 0PrijmMuAsbtKMFoC6D3/Wz3/svuNw==
X-Proofpoint-ORIG-GUID: JQxbP1L3uSr78of3fWFgMMscq7AEBdTE
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ef9f11 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=-7q2M0jigxX2LbQM1jMA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: JQxbP1L3uSr78of3fWFgMMscq7AEBdTE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

Driver does not expect the appl_ptr to move backward and requires
explict sync. Make sure that the userspace does not do appl_ptr rewinds
by specifying the correct flags in pcm_info.

Without this patch, the result could be a forever loop as current logic assumes
that appl_ptr can only move forward.

Fixes: 3d4a4411aa8b ("ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 4ecaff45c518..786ab3222515 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -86,6 +86,7 @@ static const struct snd_pcm_hardware q6apm_dai_hardware_capture = {
 	.info =                 (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME |
+				 SNDRV_PCM_INFO_NO_REWINDS | SNDRV_PCM_INFO_SYNC_APPLPTR |
 				 SNDRV_PCM_INFO_BATCH),
 	.formats =              (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE),
 	.rates =                SNDRV_PCM_RATE_8000_48000,
@@ -105,6 +106,7 @@ static const struct snd_pcm_hardware q6apm_dai_hardware_playback = {
 	.info =                 (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME |
+				 SNDRV_PCM_INFO_NO_REWINDS | SNDRV_PCM_INFO_SYNC_APPLPTR |
 				 SNDRV_PCM_INFO_BATCH),
 	.formats =              (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE),
 	.rates =                SNDRV_PCM_RATE_8000_192000,
-- 
2.51.0


