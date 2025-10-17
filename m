Return-Path: <linux-kernel+bounces-857640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8CCBE7526
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0557A6240B3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0292D9497;
	Fri, 17 Oct 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vvs8WIIa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03B32D7DD3
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691400; cv=none; b=Xn0rUlJl3YE0SRXUOfCdEBMCLH4Z1zHijzdxdHxI2l8IrXzhgujH7hi1IcFgZGaIgPRbz3UihMKBaWkuaROLuOMhbggmQ7LpJKdZ6+gLGDms3qAgmUNvwk6+Aw/Us4VRlfYNrMXjO2us34ajdREueWOW61WiV6y+fkpbgA5V5Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691400; c=relaxed/simple;
	bh=LESmruKeD2k8Y/UOmXpKXEPzU2PTrrL35FLqSlgIXnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DW28edjAOrkGcCAyABPct8ublYPvoel2xwdnQ7jFyEeqhhB8xZJ7q+JFrsahDwMg+fjui4lZdADnFP4rlO/JqWEcS3GhEEyDTAl6gLafzKiWJ1s/8QZlUdJCCV0yGOXZ5i/2WYOtfhzE9nnJKpVFX36l//wtmc7SbgYEG1QBPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vvs8WIIa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H87lUd002626
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Jds3ynaWk7m
	aZGNZjrrK77wITeMIM7azLHelkM5HaYE=; b=Vvs8WIIaA+MClM56+aqCOe6SuSr
	1AbISnzMQpH3rhNAPS8FpKvEITIBIiq2LxEhryRNoCVUcWDlaqqhUSiZPBIbDIDZ
	Pr/bUyWeBK+56UtEViuutFvXskd/ajkFGF8o+l1jJrNge9CistZlldZr3HCYxtsv
	Go6iiXuIU2BngdgpnwRHXVLHK0r1qZIjopbgF+9/4H/kHzZr+SIt44h02hvI50Dh
	BkXDN/YJOstnq78wPy14n3FPd2Mv3vSAFDH8BmYggU5cxJ86Uz98wnFqFvMsG3mj
	wh03OIgvSnKAQTFV0L8t+O3+fnS4Ya/hrTgk4hr/gyt8GsSGVr2grBDybwQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd9bm9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:37 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78e30eaca8eso73411916d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691396; x=1761296196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jds3ynaWk7maZGNZjrrK77wITeMIM7azLHelkM5HaYE=;
        b=QkWw5pPmUB5ePQTLAVYsP6LjBaPWiqQDCSzU3GbcOgFXyHvcX0FpfMTupMLMqb8uV9
         SCQ8y4GX5GXgRVDqbkG3sfjVp6Cxazcy7dvqz16aqMnW7iM4XveYaaFM0ZSMK7TBjP02
         8QyRyRK84nd4rhFukzEBFKKoxmNsrM31Z6dQ6DjnVEbtHIiQ7dTG6BN1+sMMteu1rW65
         rkIhbvBJUmueLkBO9yk1fUVi3XJ7PUC4X6+gg+aXtS3YzdKQUgyGJex088fefXGEtcF8
         D5Geec5xc9GXloFOkk0nUVLuIdrQA2NBSskmLXiSv5MxlE1PDa9STCCnPa32m5NJhXJ7
         ZzHA==
X-Forwarded-Encrypted: i=1; AJvYcCVDQdFm/tSA8j1Bc90c0grbtfwdKktvNClS3r3nF6UvObRe0TlUAV6POgmqL7Mol9JZ2PwaE4EJDXD/tAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXqLhxN+7Z+fLaafvbZLMksbsKyKnYM19i4tKyNwuSvsHdXfY
	enxA5pQ0t3aP+PEZTdcBLzmLFeYf/C/zCpJp98KxpPUkTXPK1gQjc1DjamKF0k4F2lFvKSHgFU1
	6USV8bRgLml7VdUXh4TFFPTkI3nYOKK9NjZu3woovNob50ybc3VAExlVYPHVDm4aY+fw=
X-Gm-Gg: ASbGncveN1Rg/vlfLQDjVAUkVfM5mt+fDhF1Yqz/yrJYkEIk9oTgdVEPnMOZAO/SLAm
	hRALEFDMxoIx4XJJFMZbq+iSFj3+52eYa7SBRHSOQEnSLYQOjhsjBZnrkbnn1IKCOfBVMwQOv23
	iW8LOYm3qxjr7IFQeCOWrfMUObW7Eb26VJ7sCqIUSSGlbHfOQb8xt84AWakm/5kc8KOdd3PahJ/
	4WnYbiU0rMpw22MMzcLkdAFy/HZY/QGvsd+QXSjRHwM+/pi3bnx2IP/u1yi0WcngFW5ONaaB0eW
	dwnwme1ld567sa/K5hdo+D28NkOgsLQAL04JuZuHSNLfwKCHZMt9eGcCq+LCvwcWKFGGRNJQkG3
	Y1Vu5zKtB8w3r
X-Received: by 2002:ac8:5749:0:b0:4dd:9798:38d9 with SMTP id d75a77b69052e-4e89d397004mr38905891cf.67.1760691395744;
        Fri, 17 Oct 2025 01:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJT3vbnCxYuVgQ4mEr8+d9Mj708NZgxZGZG8reI6nw6g7Yp3T00H1A9aIFVKRbqUf7+MnIqw==
X-Received: by 2002:ac8:5749:0:b0:4dd:9798:38d9 with SMTP id d75a77b69052e-4e89d397004mr38905791cf.67.1760691395327;
        Fri, 17 Oct 2025 01:56:35 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444d919sm70764985e9.14.2025.10.17.01.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:56:34 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 10/12] ASoC: qcom: q6apm-dai: Use guard() for spin locks
Date: Fri, 17 Oct 2025 09:53:05 +0100
Message-ID: <20251017085307.4325-11-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017085307.4325-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251017085307.4325-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eihBzCUAT3lHBtKG2MVgiBS888BCd2at
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX6toxospcTzr0
 A0T7IJh46DJ18XblF4yDf3T9LuQ3GofizoNjcNGB0DFf9jOxDzbqse09l9WM0ZZtH47ojGVOvL0
 R+jtEPr1PBbfl7r+B8T4QhD23FaTn8BazpduuM3IURKYTzyZROrLCTImXPifk5n1S3mugUGqaG8
 AyePiTcKP8siz4QYMXQIfL3WMEhdLwxswXcBfUVzwoRMfZVDiwhJH7rdGMX+Fl1xTBtIBgZ0P+f
 ApWmCI9zR89FwXj4G9Ym+34y1lVaTiQ3dreDp0MoQVIqhgwVKB6LK0pBj2AHqgnF0soz3r/AeG5
 e/AKFZt1TDzjemvYEQ4BvLBF/E4NESYY6iSzNuL0lgjk09omTmhmFDeLqzrZqyohYk9nFyPntm4
 TEqnTfqGwXXzP1mhIpiZznV9y5brkg==
X-Proofpoint-GUID: eihBzCUAT3lHBtKG2MVgiBS888BCd2at
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f204c5 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=ctYtm_-0jrJ_p8CCq-gA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Clean up the code using guard() for spin locks.
No functional changes, just cleanup.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 4ecaff45c518..865fb0b3bc06 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -149,33 +149,28 @@ static void event_handler_compr(uint32_t opcode, uint32_t token,
 {
 	struct q6apm_dai_rtd *prtd = priv;
 	struct snd_compr_stream *substream = prtd->cstream;
-	unsigned long flags;
 	uint32_t wflags = 0;
 	uint64_t avail;
 	uint32_t bytes_written, bytes_to_write;
 	bool is_last_buffer = false;
 
+	guard(spinlock_irqsave)(&prtd->lock);
 	switch (opcode) {
 	case APM_CLIENT_EVENT_CMD_EOS_DONE:
-		spin_lock_irqsave(&prtd->lock, flags);
 		if (prtd->notify_on_drain) {
 			snd_compr_drain_notify(prtd->cstream);
 			prtd->notify_on_drain = false;
 		} else {
 			prtd->state = Q6APM_STREAM_STOPPED;
 		}
-		spin_unlock_irqrestore(&prtd->lock, flags);
 		break;
 	case APM_CLIENT_EVENT_DATA_WRITE_DONE:
-		spin_lock_irqsave(&prtd->lock, flags);
 		bytes_written = token >> APM_WRITE_TOKEN_LEN_SHIFT;
 		prtd->copied_total += bytes_written;
 		snd_compr_fragment_elapsed(substream);
 
-		if (prtd->state != Q6APM_STREAM_RUNNING) {
-			spin_unlock_irqrestore(&prtd->lock, flags);
+		if (prtd->state != Q6APM_STREAM_RUNNING)
 			break;
-		}
 
 		avail = prtd->bytes_received - prtd->bytes_sent;
 
@@ -200,7 +195,6 @@ static void event_handler_compr(uint32_t opcode, uint32_t token,
 				audioreach_shared_memory_send_eos(prtd->graph);
 		}
 
-		spin_unlock_irqrestore(&prtd->lock, flags);
 		break;
 	default:
 		break;
@@ -581,14 +575,12 @@ static int q6apm_dai_compr_pointer(struct snd_soc_component *component,
 {
 	struct snd_compr_runtime *runtime = stream->runtime;
 	struct q6apm_dai_rtd *prtd = runtime->private_data;
-	unsigned long flags;
 	uint64_t temp_copied_total;
 
-	spin_lock_irqsave(&prtd->lock, flags);
+	guard(spinlock_irqsave)(&prtd->lock);
 	tstamp->copied_total = prtd->copied_total;
 	temp_copied_total = tstamp->copied_total;
 	tstamp->byte_offset = do_div(temp_copied_total, prtd->pcm_size);
-	spin_unlock_irqrestore(&prtd->lock, flags);
 
 	return 0;
 }
@@ -631,11 +623,9 @@ static int q6apm_dai_compr_ack(struct snd_soc_component *component, struct snd_c
 {
 	struct snd_compr_runtime *runtime = stream->runtime;
 	struct q6apm_dai_rtd *prtd = runtime->private_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&prtd->lock, flags);
+	guard(spinlock_irqsave)(&prtd->lock);
 	prtd->bytes_received += count;
-	spin_unlock_irqrestore(&prtd->lock, flags);
 
 	return count;
 }
@@ -760,7 +750,6 @@ static int q6apm_compr_copy(struct snd_soc_component *component,
 	struct snd_compr_runtime *runtime = stream->runtime;
 	struct q6apm_dai_rtd *prtd = runtime->private_data;
 	void *dstn;
-	unsigned long flags;
 	size_t copy;
 	u32 wflags = 0;
 	u32 app_pointer;
@@ -795,7 +784,7 @@ static int q6apm_compr_copy(struct snd_soc_component *component,
 			return -EFAULT;
 	}
 
-	spin_lock_irqsave(&prtd->lock, flags);
+	guard(spinlock_irqsave)(&prtd->lock);
 	bytes_in_flight = prtd->bytes_received - prtd->copied_total;
 
 	if (prtd->next_track) {
@@ -818,8 +807,6 @@ static int q6apm_compr_copy(struct snd_soc_component *component,
 		prtd->bytes_sent += bytes_to_write;
 	}
 
-	spin_unlock_irqrestore(&prtd->lock, flags);
-
 	return count;
 }
 
-- 
2.51.0


