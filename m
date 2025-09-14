Return-Path: <linux-kernel+bounces-815630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A4EB5692B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772503BC899
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF0F223DDA;
	Sun, 14 Sep 2025 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PX3oYHsu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141AD19DFA2
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757855779; cv=none; b=aS5GuLCPklw+QxPPDCPMXITEFaloFcr/bpgTpiSGnd62Nx+sq5Qhwv7+7IV0nO8EubSEX/i3h+MoyYVXkChtVJuU2cx+CqWPSWWmJQIOyPVuEVxTrxHJxPATTVzzcUDjucLLDwmUcSgQz/acb8UUC2kfE9gLSDsl9zJEXNUXTL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757855779; c=relaxed/simple;
	bh=ASTRe5VOEhSFShtU7AUd8KiTkDSRQRHKvy7Cf4rPWBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hz5QdL3TqTN/UOSapiwSkCbWdxvirliKH4q+Gr+Ex7RKdlbVgAGQFlHRtlMaVOTN6Tp06Sg/Rt2ZlTgYK0lp0d9Xw60mWSg+xH4jvAjFO3LbzWs2RBqRaWZDip/Xe3JoF2vg6tnWyRH2EnPv+jK4tiMJ/yO30A3EWPvdAbDiOTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PX3oYHsu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58E9mtQH013107
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=cFsUhwbH3X0sd7hf9crCeGPj7gKsS7ptnZR
	waiXgaJw=; b=PX3oYHsu8T4Z6xb2oqG3grWhQA4zLO3eQsKhLHqogZoHw5RWlT4
	KI/zzo2H2Y/Tk7uZzv8lOiB2LutOJtU1MMXT0qQL5RmPPwa37zyVbCGPxRtFPJGT
	kBqv8fXlaUPKluNVTQl4bWRUs7A9d3zI0WoAtTlZw1GZy4zR5tsJliT0LEMxaZIw
	d8y0V5VyzbS3kSQk8jl4It+PywezVjrXyU5Wceyb47YYSp5nOKovHG6B8dnx60Tf
	FlKo8YNBA/xUEk/jkKTrLComVq9SV2rFj8cPsvu+nUCTNF+iptPXszMeWSy+ai4l
	43YJ5uTRBYrtW0h3cRMT9rTYOdS7NcWFjPA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951wba5c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:16:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-265c4769c9eso1555835ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757855775; x=1758460575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFsUhwbH3X0sd7hf9crCeGPj7gKsS7ptnZRwaiXgaJw=;
        b=tF7NiMMIlvVf+8GzMELrRnuwaVgX0BDkM6S78RQyUL+vCjcnVlSavmYW2cgiXDGJe0
         XzgH+dBwhmi22NLR8MLNFruP8yvG9xSK9+CaJ4c7jJSowSwfX+xzW29OX5i3zgp/7DL3
         T2B7Q8/e1vuGxKMUnzrTgISYLyAVOPdmrZyYKgZW8ST2SI2bSwKFLCDX7wo4sL+pUjcG
         /RMbPuQaBPjiXqpztgusIJOHzgRXaTG1AkTYrmzOhCFlPV5+Q4y9O2xWT2eSO8vtqM2E
         akS4Y60QlyS/kbPh3iOzrxnzNZG0dW+EU597D9XzzRB0/H5UFrzYEwCMEq/5th7lZ63n
         ekbg==
X-Forwarded-Encrypted: i=1; AJvYcCVhCJc018g7RLXCWByQxCbsrmpRDZpKYQAJgFnk6vAPRNKi6AGSv+5qrSJMkQnMazpXhrKCQW4uTl2D0A8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6e4UotKOPLScuWuX4UmTBUbbiWHpGiCOP1yTaUa7zju5g1Vzz
	Q/Yj2WQc73xed56q+kAvF5nl7NzOEVtSaF73g3aBETd8zvghlYj/jZ9/FDGBb7pHJws7QvIwmN6
	NaKIQ+qQORGbjFRunjJ/CEFxG/MqQQEdIklnFaHaLNsMDfWZEZEESkaiy5VfXTUFrd/8=
X-Gm-Gg: ASbGncsw3HSxT/QLdcYBZvUjIIuEUofYU82SpdR4WDVqwRpnnHniUax5Hw1dGeqgxrF
	uOxxKSu+Z6/qslTVJj/ICKUww41ddAYqz1VfqYQZJxYR1pGZ29bKYCayhwXEbZpcRz0hVq5706M
	k/dzhIIba5p5J5CVXEGsp01pYTfmq3rxdrH2eTgKmHx30gBk0+TDTzU/nSIh9Hv2BheCVt7Znws
	AA1DnJ2RjYsW8CAdwKsKzg58R7vuuuYJZooPbLlWQNHRWKbr2w/2SkoxAi2XI60gw60CI09je1u
	mJPXAmSfU4LinjYQSZlkACFPtcieNi1a/Rn12f26zjhQnhclVbjl+yVGASiuhJ3YW/nT76DmJmh
	M
X-Received: by 2002:a17:902:d4c6:b0:25c:4902:7c0 with SMTP id d9443c01a7336-25d23d1bb3bmr118454015ad.3.1757855775134;
        Sun, 14 Sep 2025 06:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJuy1SPEO/XjEKKhYEvmFIgN+JNIp7NY0Hu7kXU50Dz/94OCkRLrYzCtcat0KvAIgfcL9GgA==
X-Received: by 2002:a17:902:d4c6:b0:25c:4902:7c0 with SMTP id d9443c01a7336-25d23d1bb3bmr118453725ad.3.1757855774712;
        Sun, 14 Sep 2025 06:16:14 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad33ff0sm97871205ad.115.2025.09.14.06.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:16:14 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com,
        stable@vger.kernel.org
Subject: [PATCH v1] ASoC: qcom: sc8280xp: Fix sound card driver name match data for QCS8275
Date: Sun, 14 Sep 2025 18:45:49 +0530
Message-Id: <20250914131549.1198740-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XYKJzJ55 c=1 sm=1 tr=0 ts=68c6c020 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=687F3S6WDAOtLpWcfGQA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: zlBcYMPeZIXTy3XL6r5tQ-6xc3DBLntD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MiBTYWx0ZWRfX7v/d9EcsR+2z
 efpJtyPtwUg69VAif7/5/entUL4bN6GYk+X+Uv7eAAODZ9V+Bzs5GaIL3t2bPjNo+bWHm7Lpz8n
 CMLbaZYv7pdHxCmMJ+M/HD5G/6xX7stLHtTJoRIGKZSWdMsWoxzTez6e8RfBSar5Dx0LMIOIFe0
 4OJzLUYU3SqykQOVv1NoMQYFo3X1aPTPM9ZUeqXHbsLxwhxaHg6W0umaPMK0KImySHBWgKHOw1x
 R5rV0dxxo4zNooCqpxMIRMzVCvPmqE5O9DjYqFjLOA0uE6nc4tUtzKJW40MNJPGmXCN/FB5XrKv
 Ui3jB6FxIhxOggmZ31kEc3b3594+XKW5BSNNiO1WHyzb5aFLHt5cDz6vG8eEeO9rm8apbip+QhP
 9u0OaPpw
X-Proofpoint-GUID: zlBcYMPeZIXTy3XL6r5tQ-6xc3DBLntD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130042

The QCS8275 board is based on Qualcomm's QCS8300 SoC family, and all
supported firmware files are located in the qcs8300 directory. The
sound topology and ALSA UCM configuration files have also been migrated
from the qcs8275 directory to the actual SoC qcs8300 directory in
linux-firmware. With the current setup, the sound topology fails
to load, resulting in sound card registration failure.

This patch updates the driver match data to use the correct driver name
qcs8300 for the qcs8275-sndcard, ensuring that the sound card driver
correctly loads the sound topology and ALSA UCM configuration files
from the qcs8300 directory.

Fixes: 34d340d48e595 ("ASoC: qcom: sc8280xp: Add support for QCS8275")
Cc: stable@vger.kernel.org
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/sc8280xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 73f9f82c4e25..db48168b7d3f 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -186,7 +186,7 @@ static int sc8280xp_platform_probe(struct platform_device *pdev)
 static const struct of_device_id snd_sc8280xp_dt_match[] = {
 	{.compatible = "qcom,qcm6490-idp-sndcard", "qcm6490"},
 	{.compatible = "qcom,qcs6490-rb3gen2-sndcard", "qcs6490"},
-	{.compatible = "qcom,qcs8275-sndcard", "qcs8275"},
+	{.compatible = "qcom,qcs8275-sndcard", "qcs8300"},
 	{.compatible = "qcom,qcs9075-sndcard", "qcs9075"},
 	{.compatible = "qcom,qcs9100-sndcard", "qcs9100"},
 	{.compatible = "qcom,sc8280xp-sndcard", "sc8280xp"},
-- 
2.34.1


