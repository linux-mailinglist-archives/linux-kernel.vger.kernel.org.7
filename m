Return-Path: <linux-kernel+bounces-857641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A602EBE7529
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F9F62595E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52462D77F5;
	Fri, 17 Oct 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y+5pZSdK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8912D837B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691400; cv=none; b=D2TqTOwjrElpGwy99lvOaabBywjIqkTVcF+UnEHNK/6/0sB1rHCh/okVdDKw4Lo9vmCzKJqjNJQamOuLrouZulaA17zk7ClEUXRIoDkY2Xr5tXUOcYbA1sC6+YQFrqBqacGFQeydxnGbn5JLsvYZOeU6XTmYR1mgrY/aoWDyuRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691400; c=relaxed/simple;
	bh=xJ9ewBKmUOcp7y1OOXagWe0RLhZPnHfQRgccA5gcwCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G34H1VFd2vsXTdn9GJUPtW+Voz13RQeivR1VEwXIXH50Fz7YQ+SRbqtGS+SCqZb+k0QO20cQeYsxXrifPUtP/gOmtNRZqXsnCga1b7msFGFoEwnwmFxEJD0A5LsXRSyyDLk6NB+IjjVlFrBRsvQCVfD2A5147mEICitsqFww5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y+5pZSdK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8mImP008877
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HLTr0qwAyjy
	py8cQSzVdRdWFvvEMv8L8lE7ajdfrlhc=; b=Y+5pZSdKuMh+SRNrogEKtF6KYjd
	TozBO2qtdkfBE7Ztr9MWJ+4AwjifZWT1w2hmBY92nBjEaukcGdWWgiZQiC+PaSum
	pqYIjsMZePaPWRdUf8PMghtFxrw2Rq1mSiVCRktkXKFn7w15EZwnhnpOVKvyQ3RP
	/O4gHwPlSl7iwnZ0RTJFrCO2of/5ASDyP92Tp3NSkcMlkqjPGFyqY8uK+fcvl4XM
	2SPIee9X6fu4ewNDouDsm3BZWExg6nlAtyWVdmVpGKUCFMQq3Lm2ybiefeDxP7qy
	Yh0ytmOc/QaNXSSuUTChmI1Om0PjwElxQmTp/53+CndtQ6LtAz5XXSp4mrA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1aqrvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:38 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-79a3c16b276so51882296d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691397; x=1761296197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLTr0qwAyjypy8cQSzVdRdWFvvEMv8L8lE7ajdfrlhc=;
        b=xT+iBYlot8V+wK6s96FZiWw6QlfnhcW3ziWJXj75GuDXbJJQe103kY5IEriEQnUqKH
         CCAF5h4bWBXjHcqp0+nQHBRFaISFRpIuA4zmUYUZjEnP5wPv1kv9nFFNzjPN48vMsM03
         Dp9chJOgiZW5b5kuIZWHsA7erHjmsa5+l2GNNfz9I+CS+9v4t6qW882XbfCMoDV9XhhD
         wNlYHKEjYMj/Na5A9ugcFeqVSLfoWsyE7bRHkLb3+qAWTEUEk5sUAFaTuc/ApQlq6cgA
         9ScZMijgqXXmRNP8l/yRYSZiL+C8k+BEIevMnIouCepx4wuN2Zso9ibX/hoJM7tGgAL5
         J+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl5V8Jo32vxYZSk7CHE2OT+ev2SotHv0iXR8DcdHaKk9B4jd7JVLAiEtCNbuOGEmA+GE1sqwT5xJB3x6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaP692RpqFZJhatLRNXc/Ixp2aL3hspBoqTYmHalfJo0bPOtOs
	suFjrhaEEJYNukPeL0lmJh/ilaAZ8azFo1U+AlJGVLoec6s2HZ6mkR/saVksEo57z4MiZPujmjP
	vxHiPll8jdu0w42gPtz31AWbrWX5El1h38/y1idiWH6WZJ6U1CfFPFZJ3xQ+8NtyU8dw=
X-Gm-Gg: ASbGncsiTZeSFAeH9qCcvFDxo1VKg9rmlh9l/G2Jz2KZm9kgUvNjq3GtW2vqzp+R+O+
	uad4ZOF+jfd7412xZsre1atJaGnbRwBs3b+c2C6I95Df1sgCfoeWito8UUqAUK1YpfaFtzSf6V2
	3480UBw2uUI/3qghtHoxrqvs/Ov5nzh4tMw3pIySi3nH1FGRHdnrSsEu/y2ImYc83A/zFIx4t0X
	BrHfrSdqWaPp6CCDicDktYYMU9c2fiO6yqcJUthFEVl1J09NjvT9pEJFcuRwUSp2mqhgeSl9Nz2
	hHlKMdIvmhtv2uPMYKU6diLbvdMnWt7Dvbt1+JGKrNnr0WER/r6qAHyyJzHZHPHgVaqn+pNh4Yd
	CXtbZC260UioJ
X-Received: by 2002:ac8:7c54:0:b0:4da:3218:e8da with SMTP id d75a77b69052e-4e89d263059mr42429421cf.17.1760691396916;
        Fri, 17 Oct 2025 01:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGiJl3aHFmjmNgCLDQr4OtAu7l19M62+p30JfjEUZEfWKYdayPHQpd/eRhXsqwlIUUFFwADg==
X-Received: by 2002:ac8:7c54:0:b0:4da:3218:e8da with SMTP id d75a77b69052e-4e89d263059mr42429211cf.17.1760691396380;
        Fri, 17 Oct 2025 01:56:36 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444d919sm70764985e9.14.2025.10.17.01.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:56:35 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 11/12] ASoC: qcom: q6asm-dai: Use guard() for spin locks
Date: Fri, 17 Oct 2025 09:53:06 +0100
Message-ID: <20251017085307.4325-12-srinivas.kandagatla@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68f204c6 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=xYGVKCReuHkqpmdgNokA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: rFMm7HPfkh5ue0pxcIuxPxtjJpbv7Kmn
X-Proofpoint-ORIG-GUID: rFMm7HPfkh5ue0pxcIuxPxtjJpbv7Kmn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfXy6SCcKKrveZ9
 Ry0nnigqtMFCOhcGOUf2hH83Q2PcJqU4oeOGrEHK1Er6uh/qvDZMDIPTcrLwYEgR9LSAU144lV3
 dOE/szfXtBhbto9VgFxcaE4cn1jJ6Mgif62x/VmNOAaEIRMYZPg9NP1uqP5lnNPf/E7Nib1LoJg
 zUOxJXwFgx87URmWNGwzESSvhMBhyekq3IkT294tpRRkFSoeLbb+Tu+b23TZyb/2RTqPJQ8hd0U
 /ft5k2wEj2MqgFUsAwLksckg8wFWFvHLj12/SSWQNf3WQVrgs6s4t7tgHzLEShQtkuc0mxorDW4
 h2emH8ok2d60s+X+1OeeILTibWvvX5ISgabgZatnzUpzit61S3Owne2HW5OPHenvmtdSqpToMUG
 Wxl+CsSSc55y2Lunb+FrWDlQOGC9MQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

Clean up the code using guard() for spin locks.
No functional changes, just cleanup.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index b616ce316d2f..665a5d1ec4cf 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -493,15 +493,15 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 {
 	struct q6asm_dai_rtd *prtd = priv;
 	struct snd_compr_stream *substream = prtd->cstream;
-	unsigned long flags;
 	u32 wflags = 0;
 	uint64_t avail;
 	uint32_t bytes_written, bytes_to_write;
 	bool is_last_buffer = false;
 
+	guard(spinlock_irqsave)(&prtd->lock);
+
 	switch (opcode) {
 	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
-		spin_lock_irqsave(&prtd->lock, flags);
 		if (!prtd->bytes_sent) {
 			q6asm_stream_remove_initial_silence(prtd->audio_client,
 						    prtd->stream_id,
@@ -512,11 +512,9 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 			prtd->bytes_sent += prtd->pcm_count;
 		}
 
-		spin_unlock_irqrestore(&prtd->lock, flags);
 		break;
 
 	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
-		spin_lock_irqsave(&prtd->lock, flags);
 		if (prtd->notify_on_drain) {
 			if (substream->partial_drain) {
 				/*
@@ -539,20 +537,16 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 		} else {
 			prtd->state = Q6ASM_STREAM_STOPPED;
 		}
-		spin_unlock_irqrestore(&prtd->lock, flags);
 		break;
 
 	case ASM_CLIENT_EVENT_DATA_WRITE_DONE:
-		spin_lock_irqsave(&prtd->lock, flags);
 
 		bytes_written = token >> ASM_WRITE_TOKEN_LEN_SHIFT;
 		prtd->copied_total += bytes_written;
 		snd_compr_fragment_elapsed(substream);
 
-		if (prtd->state != Q6ASM_STREAM_RUNNING) {
-			spin_unlock_irqrestore(&prtd->lock, flags);
+		if (prtd->state != Q6ASM_STREAM_RUNNING)
 			break;
-		}
 
 		avail = prtd->bytes_received - prtd->bytes_sent;
 		if (avail > prtd->pcm_count) {
@@ -581,7 +575,6 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 			q6asm_cmd_nowait(prtd->audio_client,
 					 prtd->stream_id, CMD_EOS);
 
-		spin_unlock_irqrestore(&prtd->lock, flags);
 		break;
 
 	default:
@@ -1031,17 +1024,14 @@ static int q6asm_dai_compr_pointer(struct snd_soc_component *component,
 {
 	struct snd_compr_runtime *runtime = stream->runtime;
 	struct q6asm_dai_rtd *prtd = runtime->private_data;
-	unsigned long flags;
 	uint64_t temp_copied_total;
 
-	spin_lock_irqsave(&prtd->lock, flags);
+	guard(spinlock_irqsave)(&prtd->lock);
 
 	tstamp->copied_total = prtd->copied_total;
 	temp_copied_total = tstamp->copied_total;
 	tstamp->byte_offset = do_div(temp_copied_total, prtd->pcm_size);
 
-	spin_unlock_irqrestore(&prtd->lock, flags);
-
 	return 0;
 }
 
@@ -1051,7 +1041,6 @@ static int q6asm_compr_copy(struct snd_soc_component *component,
 {
 	struct snd_compr_runtime *runtime = stream->runtime;
 	struct q6asm_dai_rtd *prtd = runtime->private_data;
-	unsigned long flags;
 	u32 wflags = 0;
 	uint64_t avail, bytes_in_flight = 0;
 	void *dstn;
@@ -1087,7 +1076,7 @@ static int q6asm_compr_copy(struct snd_soc_component *component,
 			return -EFAULT;
 	}
 
-	spin_lock_irqsave(&prtd->lock, flags);
+	guard(spinlock_irqsave)(&prtd->lock);
 
 	bytes_in_flight = prtd->bytes_received - prtd->copied_total;
 
@@ -1113,8 +1102,6 @@ static int q6asm_compr_copy(struct snd_soc_component *component,
 		prtd->bytes_sent += bytes_to_write;
 	}
 
-	spin_unlock_irqrestore(&prtd->lock, flags);
-
 	return count;
 }
 
-- 
2.51.0


