Return-Path: <linux-kernel+bounces-802634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53240B454E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2213A05D1A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725C02E3B15;
	Fri,  5 Sep 2025 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fu50+kd7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE32D7DC8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068853; cv=none; b=g9y2fAiIn0uP7LmGNAHqQU2aoeILvQitSPIyEqDTjeV0QluNtYYPURN5qw4R11YIQ6Pzj/BizCrRZuQbsNjTW5RImu/vCJzd8UxuXcz5aIqLOhHurc+KNVJItFd9HorfyTK8Fi85cEe9PUGbHITHqwnkuF8kOMYw88LMmDIffjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068853; c=relaxed/simple;
	bh=o3+9zWqzop6Qirh/jUD98VgvGr+s/4CoqP1QajjE/Fk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwbVjiZ032m27F02F1FVAdtMEQcTrb9KC14FAd1eHNgU+O4E6Fis4/JanqU5fd/zaPWwjW83ddG6e6Dcq+ig/0B2h5T8BnaZKy/IjSVL2snFirF1umtJf+oWC9NpfkTLV+1lKH7k1EQfOxsTz5e2CQkHD2FPtpataS4gzp2Ce9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fu50+kd7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856i7dU007619
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 10:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LXDDf7M2VYT
	jvwwkHPq5BIaZwMjwTKn+8VWmbHt4iis=; b=fu50+kd72QmHR755kColGCGekPa
	w7tGLcod3efoyTJDXPGoT5lhNYhf1cRXphx0Tai6MWYl+unmYxBRBB1pJNnG5WNl
	vW3pPrsvqHRn4TgdV0rfy8WDSXuZsBsnU6+IDhjf/ix0f2FTyw/KfOI+KIxrIA/P
	pYDBrcLQF8PXPihc9dnT3coKATyYlkBLEYtRAM4l4rpB6qEVG6vUUHJaFwd45xMw
	7/EkHQWwHJVAR+LDzMPwTwYCInRIAVeWcGKNTorYa/NLkB4XosILnLkP08viCUFk
	IObPfP5/olssLVqDBalXlCPI4SkjRx7SOgEGpcRiAxeVMCRcDA4mC/bLr9w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura92q51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:40:51 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77278d3789cso3824232b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757068850; x=1757673650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXDDf7M2VYTjvwwkHPq5BIaZwMjwTKn+8VWmbHt4iis=;
        b=JYBKofRWMgSUGtTvYKRoTzOsNhMWDK5Oa1PH3gp/ci5rFEUHkrJarGve3+lCCE3qSu
         2WC2q7r9OyaocV7IkM8/KtMI09+xeai7wH80/26mfpN4rEJy9e4rYEskFNig4aczoIZm
         aFLT0ApkyD4Km/YPpcYguUyfvo5abk/LX6YZRSiUJBrReUzjxKQXyD19YVthNreGvboB
         XJjqSAztJenn+meWDGobzYZysBsWQaou09hexv8KaN8nCSEauTeeSIY5TDlraPxGjd9w
         rkBd13z2hDj/dsdKdb8PPdEriJVbIQLrJI60RyZhk2kkYMif1QQFsop+8wqAwr1yNyLi
         j/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgIncJKP2MiHiQQfE7F1k8YfPF6b+VVOBrMBJEaYT515LQnHR5ESEnjntSioBP1lTeTjh03DtE/eFC1hw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq73pKD4/fIwjGMob/z6XyV6tC58WGfpgnzDnNSnQrxWrM0x70
	h33FadUdWts0UoyrESQZsO25XmDH0Yb35ZqOmdMJhcUaktSxVNVvQDsyHHC9MT79vMQ4ozcfN6y
	aWcBloDTEa8QajYkVaSqgVZsBvuuRjqatjYv4Oz0amfBr35HuupwMutqvz/ACPYfKpec=
X-Gm-Gg: ASbGncvfim72F+J1W4Q8qpbl5ZsvqeQjGNqLVWePAwSRkv0G1XSjIJA2u87tXH+u+Rj
	kxFobW5k0bnwGUsFbcCMkyAZ085p/tyiBrJ0wbXrreCNhkSANaIlTUN2i/4LU9fga1Y+sKPKS8z
	KJMJJZY7VIkznRLhad/mzftOYSAppT3ri10lyimmHLSE/ufyNOMrHmn1OLfELV5536CyNahVLUW
	dGH2R4WTwWTm+jxq8JFTrcVZo4CDlLYAQxQg3fQNSnqOWFZaLoliKpQ65zbY1FdILxYsoGYtOdD
	ES23FReBjSngSXF6co4DsT0b8rEtB3+4WqdaIdAvvagh4r47+3GPP6QTdLSjtmMHNMc7m1yRZmN
	5
X-Received: by 2002:a05:6a00:2d86:b0:771:fdd9:efa0 with SMTP id d2e1a72fcca58-7723e36b457mr27393597b3a.15.1757068849852;
        Fri, 05 Sep 2025 03:40:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnK9/HS3NMRByU9Ib95AJxuy1rcwlfJDqcn6yMRx61rMf0Ranxs9dLAw+zWBYAe4AELefC2w==
X-Received: by 2002:a05:6a00:2d86:b0:771:fdd9:efa0 with SMTP id d2e1a72fcca58-7723e36b457mr27393565b3a.15.1757068849386;
        Fri, 05 Sep 2025 03:40:49 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a269e9csm21993859b3a.17.2025.09.05.03.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:40:49 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com
Subject: [PATCH v2 2/3] ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S
Date: Fri,  5 Sep 2025 16:10:19 +0530
Message-Id: <20250905104020.2463473-3-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905104020.2463473-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250905104020.2463473-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ut7UAis9eD6j5G-Ltg5uTaVYUEoUUgRk
X-Proofpoint-GUID: ut7UAis9eD6j5G-Ltg5uTaVYUEoUUgRk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX5XRBDMH16dN7
 bqzYAVxEUotdQlqGlj5kpTj2dxehU+qh1EEYrTQvvmTNdPkw5d133kHoxyTocJsxEC5bMHwAgBt
 oFCqg89HRF9WFhT9mOTjV8bjNzo9F5QB9EklyTpoZcn5+A4hKIv38GOA6xUsoZgT+gXJwKDDdNl
 pMyWH1Ap7C8a65wpOeNXzQHaIQ9wxHiRdiKgvqKapuawB9gFwPcaLLLn7vXhbhO5hwjl0DbiuWw
 H6oExJUYqUethE2bNiyVLppclVDwsmhlju+PYHYCB36iqYeMsDHuf+lhx/fRsrQfkwbyv5cjtWt
 o2Z395gKXb1RDWyfxfJ9GKjiiaudSVBX18J3SoOSKQoPztg9g/kPqN6eObNUR+vkGpjTBbaDDtn
 CkuDrivl
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68babe33 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=sT7cmTyyBTHRPr1aEM0A:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

The q6i2s_set_fmt() function was defined but never linked into the
I2S DAI operations, resulting DAI format settings is being ignored
during stream setup. This change fixes the issue by properly linking
the .set_fmt handler within the DAI ops.

Fixes: 30ad723b93ade ("ASoC: qdsp6: audioreach: add q6apm lpass dai support")
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 20974f10406b..528756f1332b 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -262,6 +262,7 @@ static const struct snd_soc_dai_ops q6i2s_ops = {
 	.shutdown	= q6apm_lpass_dai_shutdown,
 	.set_channel_map  = q6dma_set_channel_map,
 	.hw_params        = q6dma_hw_params,
+	.set_fmt	= q6i2s_set_fmt,
 };
 
 static const struct snd_soc_dai_ops q6hdmi_ops = {
-- 
2.34.1


