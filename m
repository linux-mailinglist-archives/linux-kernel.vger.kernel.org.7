Return-Path: <linux-kernel+bounces-857642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D7FBE752F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DB0627033
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6542DA753;
	Fri, 17 Oct 2025 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="abupiNi+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49A2D7DFF
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691402; cv=none; b=D4IktntKsW7G730l4vuCgelO6/uR5HYSn4ofpF0hzzuHiNVGljAJ7ytdd7w3hDdbX1uDQAy4AVO4fBbtiDUzUJeYB+HiaLbUhvBT5kTHPIKwXzAoxHw4kPy2Afqc/nPJEfuonrylgolu6sO4YFjp1icGsuPFyfzk7FPL7yVGe0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691402; c=relaxed/simple;
	bh=P19330s2rEI12H+hFUT0x7xmbf//n4xsYyxteQ0dyh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFpG8dBS0JFDVTGi5g698E0XFS7Ik9T6u0y4XicnTOs9gLQHzxrzijBlUc2b70kDZU/8cHBs+1BUQ+8h2Yg7aCmPP9SaBI5rrdtOuIklln6+TOGmL63xEBV1NxUlT3jOfSmibFrm7NyfKVe6k1JQjB28e3HrWXGy63M9JO6IzEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=abupiNi+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8SNQc006081
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Vp8Tre/TUw7
	lskgMkX0Rr2AnYlSGvl2YlZcKg+3d5Ok=; b=abupiNi+KfcKfFL9GAyfvYz7rfd
	uaS2UxF9ngg9P/2nIS/qYCvoG5pFP9quKmtM37Xk4E4FLdcbOwJJ5cSs5bWTY/An
	MuX02IcpO/NHQ4LIpw19KGbwIh6PN+YFZ4JzYSpOVrNRk+GSKXHfU+mw7goD6fjR
	2lVVeBu4Rs6tKMAc6JgWsYNEoPalaqzp4y58NMHk8wlbjxm8Dg9gmIcpCpqJZnCA
	LobEtxDeW5rloLsO0p9FSfkCYxmHUnTQoxNqBeB0RfrxyxIJvCxsLipS1RkoUuC2
	RSwYaEI7kqk4WKzTm/GNSxjiSHG0bTail0Kdn/w2yD+FoPHgCQL54z22viQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwwvp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:39 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-818bf399f8aso79571806d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691398; x=1761296198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vp8Tre/TUw7lskgMkX0Rr2AnYlSGvl2YlZcKg+3d5Ok=;
        b=kPaXg5AxB2qI5jr0gVAZ9rFuOh73T9X8oxNG/IfVE/xKwp4cn9jCjmPF9VLMB54L8D
         vUoFsuDORGFikmBnv3PEhH/yllXUA2M+gbAa1U0OdfReGNXd3eWCa0pYd3oC9xVUGIg7
         Q0yaVM1fpE2ptlJChsABz3KDhGqzziZ9Ojul+CDUQUQrLVMuOgcpoI56tPs9r0THUOos
         ZAElTZODCOdvn+pWgbhVbPNDS1nWLPvLYtsO3B5KCSWNWBr1l588+23t3+EbQtaVeKhJ
         NqHvIEf8TjgB7fxBYTNoJ+p47JKIT8tvnBdV4sgVJOOTLyLnJ2zjh9SNySEHjSbGFE5o
         dheA==
X-Forwarded-Encrypted: i=1; AJvYcCWTOVi4pn2nuPGg6+KaeopEm1UnOG89kr+cOf5nG5XocGb8xFsHqbVSBO0nOkC0oFOR2ajfMXcmQUR8RLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoZUHULLmx7JkqViIi+z91lAPKWai/w82Phx8KhBmYDyJj9Ldc
	rG2SuBqTnYi1IloILKabxGGbYC7M35xghfphfg+7/ScEYOa4+TUc9F+bJtjcZ5iOx5vwluqKCk9
	BlLjXhQV/qWtHBsM+w72Dq+VhoKUX4pFIh2H1ZmH04YeDokrMuYV6huYZqYwQB8Tl4Yw=
X-Gm-Gg: ASbGncszTaqhaUjppAnZRM5MQcuqVnIz4Zu7IWwqO+z5dlqE/6fHtop2m7mTDHp+ncn
	Pyi8KoE9rhoA1doSjDFCQVBzvCRJeZRA78shSWCMQKgxw/avXP40lkABmf8anatzSqBOW2ojHmf
	WXn49Sw55OwCBkj+wnDsuViiyOEBEBlx1A3xnEpLLbPT2mqVVXrJ5UNRR4jgS8atNrhbLQA4Utt
	zunU1hg3Kpp6eOxJSpeRK9/e+AqHWy2lE9rHjukFNo+3kiT74nD/ljAWhetMoP6uLQEiv3SuqpR
	JKajtPMke9G7baUP+1Rgq1tQE24Go0mRZMS+JfTvHKp/JPsUDRSENI2X3TSqVuMnLzreEtsMtIq
	X9ixEVfTajdsG
X-Received: by 2002:a05:622a:14f:b0:4e8:91df:63bd with SMTP id d75a77b69052e-4e89d076cddmr41100561cf.0.1760691398294;
        Fri, 17 Oct 2025 01:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6gPcL0Z+5GM2WlrbbQ7u4fSCPPFGZINJjyo6aTt08/qvGlm1JGSXEJpXOHTxKsT9HVs4i3g==
X-Received: by 2002:a05:622a:14f:b0:4e8:91df:63bd with SMTP id d75a77b69052e-4e89d076cddmr41100391cf.0.1760691397817;
        Fri, 17 Oct 2025 01:56:37 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444d919sm70764985e9.14.2025.10.17.01.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:56:37 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 12/12] ASoC: qcom: q6asm: Use guard() for spin locks
Date: Fri, 17 Oct 2025 09:53:07 +0100
Message-ID: <20251017085307.4325-13-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfXwgLGKLOurQLt
 lPDjolvCuy7rgS5uSssQG03ij3a7BGee91SnykHvVLxA9px4AzxhXWzwKXn5okrfNfhwO8RTMuN
 3c+1ZBTpiSw+DqaJ9dvO7XWUoBjpT9Jv+ji044ItLgpYYia732qpixA1+DDjtItkGOHC0J+ub4a
 vy5Kfbz9ferSFZYpU8yPd+yuBjU/BHQWAEYTnInZE+oxnRLYY9qf1SQr5lT/FfIdg8VqWKgJ89U
 YtynAhqEsr5921zUhILuYTyZQUdeuR21cEw3FDLrVDqNV5PHormkaUoFjG1O56fdz5s0ZhOSEvo
 VnVcTQ/HG8/k52UtvovzuE0pYKc2MHZWBGGkw7R6NylApWHxZnNNdt1mN9EDdE81x5v0KK7K5lN
 ZfX8TSvdfRbMBpOpgV94r3bZBcRPxg==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68f204c7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=C-aEvXguSqPNF6A64mIA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: or2IToP6aKVcpg-f2Bs_Rr1ppxVXr8y3
X-Proofpoint-ORIG-GUID: or2IToP6aKVcpg-f2Bs_Rr1ppxVXr8y3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

Clean up the code using guard() for spin locks.

No functional changes, just cleanup.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 366fe8a8387f..7c9d1494e8b9 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -569,9 +569,8 @@ static struct audio_client *q6asm_get_audio_client(struct q6asm *a,
 						   int session_id)
 {
 	struct audio_client *ac = NULL;
-	unsigned long flags;
 
-	spin_lock_irqsave(&a->slock, flags);
+	guard(spinlock_irqsave)(&a->slock);
 	if ((session_id <= 0) || (session_id > MAX_SESSIONS)) {
 		dev_err(a->dev, "invalid session: %d\n", session_id);
 		goto err;
@@ -586,7 +585,6 @@ static struct audio_client *q6asm_get_audio_client(struct q6asm *a,
 	ac = a->session[session_id];
 	kref_get(&ac->refcount);
 err:
-	spin_unlock_irqrestore(&a->slock, flags);
 	return ac;
 }
 
@@ -666,15 +664,13 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 		client_event = ASM_CLIENT_EVENT_DATA_WRITE_DONE;
 		if (ac->io_mode & ASM_SYNC_IO_MODE) {
 			phys_addr_t phys;
-			unsigned long flags;
 			int token = hdr->token & ASM_WRITE_TOKEN_MASK;
 
-			spin_lock_irqsave(&ac->lock, flags);
+			guard(spinlock_irqsave)(&ac->lock);
 
 			port =  &ac->port[SNDRV_PCM_STREAM_PLAYBACK];
 
 			if (!port->buf) {
-				spin_unlock_irqrestore(&ac->lock, flags);
 				ret = 0;
 				goto done;
 			}
@@ -685,24 +681,21 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 			    upper_32_bits(phys) != result->status) {
 				dev_err(ac->dev, "Expected addr %pa\n",
 					&port->buf[token].phys);
-				spin_unlock_irqrestore(&ac->lock, flags);
 				ret = -EINVAL;
 				goto done;
 			}
-			spin_unlock_irqrestore(&ac->lock, flags);
+			atomic_set(&port->hw_ptr, token + 1);
 		}
 		break;
 	case ASM_DATA_EVENT_READ_DONE_V2:
 		client_event = ASM_CLIENT_EVENT_DATA_READ_DONE;
 		if (ac->io_mode & ASM_SYNC_IO_MODE) {
 			struct asm_data_cmd_read_v2_done *done = data->payload;
-			unsigned long flags;
 			phys_addr_t phys;
 
-			spin_lock_irqsave(&ac->lock, flags);
+			guard(spinlock_irqsave)(&ac->lock);
 			port =  &ac->port[SNDRV_PCM_STREAM_CAPTURE];
 			if (!port->buf) {
-				spin_unlock_irqrestore(&ac->lock, flags);
 				ret = 0;
 				goto done;
 			}
@@ -715,11 +708,9 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 					&port->buf[hdr->token].phys,
 					done->buf_addr_lsw,
 					done->buf_addr_msw);
-				spin_unlock_irqrestore(&ac->lock, flags);
 				ret = -EINVAL;
 				goto done;
 			}
-			spin_unlock_irqrestore(&ac->lock, flags);
 		}
 
 		break;
@@ -1544,14 +1535,12 @@ EXPORT_SYMBOL_GPL(q6asm_write_async);
 static void q6asm_reset_buf_state(struct audio_client *ac)
 {
 	struct audio_port_data *port;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ac->lock, flags);
+	guard(spinlock_irqsave)(&ac->lock);
 	port = &ac->port[SNDRV_PCM_STREAM_PLAYBACK];
 	port->dsp_buf = 0;
 	port = &ac->port[SNDRV_PCM_STREAM_CAPTURE];
 	port->dsp_buf = 0;
-	spin_unlock_irqrestore(&ac->lock, flags);
 }
 
 static int __q6asm_cmd(struct audio_client *ac, uint32_t stream_id, int cmd,
-- 
2.51.0


