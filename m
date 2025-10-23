Return-Path: <linux-kernel+bounces-866710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4334AC007B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3173A3A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5B530F94A;
	Thu, 23 Oct 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D7Y5dDo5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA52A30F533
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215181; cv=none; b=CkPHngatYRRh991o9LHEj75TvhzhixG5ERH7k49aRRrmtQW6ap+ITYPvgGr8Uw7rDJwSWBmZH1d9IiUZ1raWvEBjr8l6gTuETG1HDyrd3/cki6tcKUbA/EkR4ZRbL6vZf1TCUPEBYcTkTmy7xWjS07IOfkqfV79VBZ3SAccEZHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215181; c=relaxed/simple;
	bh=t04XyOJAlW4a/cW3iIAeR5OckKuonqZ/J6zYap6C1zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eerWthzUeYW5lefgaM5hl6YQHHTrZxEDhXHSYG+nTovSo2JajX4g57Ei1sPUhWdX906/ZeGjkDA4qKbQWSWb0++cLlS3WJ8oJq4fNjj9JNkg0lSM/2rdSxQ0ZwO6K4ofVeSSjuqwgiJqClMdG1UW4bOFxQQSxZLAyppQpQI5VDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D7Y5dDo5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6dfsI000663
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iDeZtnWh/qc
	Fvkr98+XBzVWqMHOVajWl1qfIqPp106w=; b=D7Y5dDo59fWFyB2WckwUeLAJIFI
	mxonuGuCSZS3RuXJNn+85mvVbCE6hyrHfvxcEK+ife1dQ9TpvaxJK3HTc70EVfgR
	bhq1pKBiorO0I6r5VDdzRwUY4ZMlo6fEBw9+T/v67mJICWAqQfpSeocv3Sz85so2
	7Cq7WZb1DtvuRgxuQi8OpPXywFYm0d1GTd9wKkaIYJNRelqlODtPPlrUABo7mxue
	u7TB1O3Td1TtkjqcDOj5tT8Se5nR2YNi9puIaZ35J4VWUckWnYZmAkERXxvnpEVg
	IvFU9m4nl0wQh0y2dGbFHhZlV5okZYjn0zSaMSEl0JDB21gid4kIUlfjdDw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08wdp25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8a4c63182so17546361cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215177; x=1761819977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDeZtnWh/qcFvkr98+XBzVWqMHOVajWl1qfIqPp106w=;
        b=Q41hmNbpjMQ0OFU7NSng2/n3wWOwbdsMnD2qkVSGBHMcawykLwjtPdtzcqEY1c4x09
         sWJAHUAvAiIGi0TSY5iOMgWFUCYKijfRlFdo4tTpeyJFSjZkbfPi1G6TIcd8/btEDSWx
         oZTHN0OWzGVYh8xdMJCp77+Om/49v0UsNccbOdO8xZoC95nNuO2eISAA9bYlxGnnvY8k
         VGCvx2dlDuU7jM0C0UDU+QfVmdPjYBdx1Pt5sSlTi72Xl0DxhTKTSHibC2v+7rC5NbPM
         cu9JI2absLM5kIV5NUaGYbIUiM9K+D2T8S1M0m7ZseT6px6nAi5qUSPZWxWcUNQDyhZV
         y5LA==
X-Forwarded-Encrypted: i=1; AJvYcCWSoqkaTZvQXUPghzUF4jZjJteQvf/2Tmz7QCLns7ysHTd6OxxxieWKaH8R3Nsm9kCqMNMfOvoJN7e2Im0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5BY7YA9rAXtNIiyg3gOuUzLSj58+gIITEJdOJImYJDMfZs93v
	hBWQ95hCHVdhHKxdXiVMvPyQWLrTw/5lVf96E19YW1DOCORDGFfjbC31GWdPRPRCYk97CErq3Ix
	5frK4+cWGJL3SLJeLPegVHyh8jlWfh2B5vM8MAu263xebdvp2MA5pxgPV/K5LbpINXEo=
X-Gm-Gg: ASbGncuT5wP7RtmDIJRdc17HdjE0fiMbPMq7jII1DdnQ/2BEK1+f68DQjHVixwM8V3Q
	IcLmqpNFi6bPVLYZ7NvnZYK5JUzqQ9BTguxwzcCPySgXWT4b04mwhUd6I9+rkJwmQXvGYtNE980
	jYitbUr8o4J+6K6JUwej0lYEbNOOh8+ho3eSRCX7HcXGcDNOKyO0knmCsntvfAC0HQb0LMbvcMr
	CLfGkgAsNMGfBHteUJiAZB6S+6uQlFWqkRqntQvNoldqA/QIDPhkMNKGZbPBPnWoRtN3x5TAOjR
	7WK/NQH7Bha3X//2LKS3uMgHR/7JwbQWUIOGKXbYbtHumGGR0rXYZ6BGfq2soHvQvtrZm33FGzb
	X1Quj0enHOdAT
X-Received: by 2002:a05:622a:1196:b0:4e8:a307:a428 with SMTP id d75a77b69052e-4eb8107e17amr21075761cf.28.1761215177502;
        Thu, 23 Oct 2025 03:26:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3rxCOTom7ofYplfN08by1bi87SvFeGoFIn0488gg2BDmU7tq8Qp6ELKT3VSIa5YBBU73qWQ==
X-Received: by 2002:a05:622a:1196:b0:4e8:a307:a428 with SMTP id d75a77b69052e-4eb8107e17amr21075581cf.28.1761215177083;
        Thu, 23 Oct 2025 03:26:17 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:26:16 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 18/20] ASoC: qcom: q6apm-dai: Use guard() for spin locks
Date: Thu, 23 Oct 2025 11:24:42 +0100
Message-ID: <20251023102444.88158-19-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Bwh3-ACZ5ZdRWPYoBth4PRhIkwEKk2Fm
X-Proofpoint-GUID: Bwh3-ACZ5ZdRWPYoBth4PRhIkwEKk2Fm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfXyDXC8OjHJNP1
 S0fG8GS4082Y0vW/KbtcVXywkOGIPHJSNv9YSixtDf8pULGxYVhS4fmg2Np03ILYNQGQF0YIaw6
 UePTLs8WE6g8a0RRBIMQG0i9KMAlNDiRFrtOB+UoylKXVeYWJgvZa5kOCwKM3M22iBivJNiFedT
 r+Oi/hGy3or4qXP4PdlW6p5crJT3SRVBHHVFP/NCL9Fgglq7uekHUfBLSKmIqfCOQ7ztJemdgHo
 wPCOQ9coQAVSIsMWF/7+mXPd0OsZ3WVdYADsf8m/2T4KMhM4pAgGK2YYzQIBPqteR+0UwsTxaql
 cWt0VpjpwAHf+sCcDuOeMAWi/mFFo3nNXSpwWffmG8Cqj2GQiT2DST6e6LnxiJc825RKJhZ+Aia
 ojmgLJ9+3q2ptF2nfsfR2uVdK8ehbQ==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68fa02ca cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=_oaKiOAelN1AsWPOrNEA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

Clean up the code using guard() for spin locks.
No functional changes, just cleanup.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 786ab3222515..aaeeadded7aa 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -151,33 +151,28 @@ static void event_handler_compr(uint32_t opcode, uint32_t token,
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
 
@@ -202,7 +197,6 @@ static void event_handler_compr(uint32_t opcode, uint32_t token,
 				audioreach_shared_memory_send_eos(prtd->graph);
 		}
 
-		spin_unlock_irqrestore(&prtd->lock, flags);
 		break;
 	default:
 		break;
@@ -583,14 +577,12 @@ static int q6apm_dai_compr_pointer(struct snd_soc_component *component,
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
@@ -633,11 +625,9 @@ static int q6apm_dai_compr_ack(struct snd_soc_component *component, struct snd_c
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
@@ -762,7 +752,6 @@ static int q6apm_compr_copy(struct snd_soc_component *component,
 	struct snd_compr_runtime *runtime = stream->runtime;
 	struct q6apm_dai_rtd *prtd = runtime->private_data;
 	void *dstn;
-	unsigned long flags;
 	size_t copy;
 	u32 wflags = 0;
 	u32 app_pointer;
@@ -797,7 +786,7 @@ static int q6apm_compr_copy(struct snd_soc_component *component,
 			return -EFAULT;
 	}
 
-	spin_lock_irqsave(&prtd->lock, flags);
+	guard(spinlock_irqsave)(&prtd->lock);
 	bytes_in_flight = prtd->bytes_received - prtd->copied_total;
 
 	if (prtd->next_track) {
@@ -820,8 +809,6 @@ static int q6apm_compr_copy(struct snd_soc_component *component,
 		prtd->bytes_sent += bytes_to_write;
 	}
 
-	spin_unlock_irqrestore(&prtd->lock, flags);
-
 	return count;
 }
 
-- 
2.51.0


