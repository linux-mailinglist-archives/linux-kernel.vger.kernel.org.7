Return-Path: <linux-kernel+bounces-854563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F1CBDEB66
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1EB6353165
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500142309B2;
	Wed, 15 Oct 2025 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TfVNaGvx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C720766E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534296; cv=none; b=dPeu1Tspjy1lNhscCU9xiVJCW10fEkgRo1eA1qyCkhe3x269cajTk74HwUIYxSmkQxu+lSTqIFKrPoPwte4w6w4kH/hpeZ2IW4WNTxoWVEYuOIB96pEhpnxIXWVEfCUQ8H3/km8Q/l7hCam22irTDAed3q3QCB8HRkZHka/aV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534296; c=relaxed/simple;
	bh=FciMJV9TB+OlUWS0wBBXljHH3OORGyEACeJ2UfDr5yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=db//EZvrULSdQHdoh1uZp0ctBRhkhixMuZeSwR+7BFQWi35FqhCHNnh9EbTfSCPBxpf4O1W2P/O1YhHHarMfZLwYJO1tdXRT3qiEN6Kt3RUOGrFeFeV9gvhmsKnVPUmUSKvpJXP7y8Q5TZio9no61F+3XeZHnLKOBXk/m1lCIdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TfVNaGvx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAwR74009231
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qHkE+bKT/J8
	nbQ5S5gGHutvtvukdRZt0lHpKcZkg+54=; b=TfVNaGvxxRSKVcbpPC/Wp1JJJec
	YlsdhhhsEh5aeuH/7/kzZN0kVr9ULIK3W0b3ZuqtLUY+wazTc3YN6YtUTFITAP55
	c5Bl9XBUJ3Mb2xX+E0tj2YKVMAypXQ6+6J6Gaj0Hnzy3I2sFRDJns1D+nWa/h7XQ
	qRUKvF8YMkI3j/eKwidoNIc2ZkhCDdBvuCREBIzUxR3wLafIMmCyuOEOGQEhP/bt
	F+4uxX/hpKRld93fh4EfiNd8coNXHUZci/HtUzLhrGKip02u16sJqrkP5o/yOAxT
	1AN2wy1nfOCFLR6avE8THRn23OvklOjPMwq4T77rzG0Xr1DqTNirboY/2MQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c4ebp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-85dd8633b1bso359615885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534291; x=1761139091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHkE+bKT/J8nbQ5S5gGHutvtvukdRZt0lHpKcZkg+54=;
        b=wb9WZoWJDL7eEOk4xVWsl2d2PbrseLTSKa3ynBkrum3Qd8Cr9/4XQvrvh2oMbOKDah
         ysFeiZXxnDAogiCOI/Z8MnbFTHlT7TWTLBPB3vKBa9OsoB2LOmMIeb8Mz8stOc9h53Qe
         3s4VLlnvJgL/vOaLQjWA/zfkwvD5VRvKBVYob0ZPozOgP3PLHk1tDcxgVhQBOF1iwH2a
         Ib2qoAkkcABNBpWyIlB/z+Rp1Rt8RpnHmyFpH9r5lPzCa4/DZCfk20UnYtwofz1K/nCY
         tXQAItaenJjzeKOmeQtdzCW3Mz2PpRV5XBuV7zywsOZn/uRgBDmGvGMbhsP2K7qjAjkx
         EhoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVU58RhaTLre0rKX47sTg+M4xxavVh5REGttcFKBEQVJTrVcvuYGQ6vIMXaAZC72VPDayE4S1bWKcdP48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfnM7jzg170J84ZvgqXPElmbUJlsGzxUi5ASmAFF/Ja3iWmcIZ
	Tkz+OYB8kL26vkAmXIiaPNBNIXSCrovO9oSCiV5l4s/xHuKXNwe0/uEyWNi3tf4adFOR4aeZABV
	xoqH0EM00UvPQiT/acT5xrGzPRvWBS8puRKbDGyx+2JUifljpa3jyfkP3pZSwjik1FuQ=
X-Gm-Gg: ASbGnctXQ97Qx2Q6WdWYiiJk/frsxD+XDtoBoKHd+FDI1rtGg0EjGTOksfcihdKFiSL
	7aKLVy7GwfcWzBnnJbMZ5krRoL4/Q1P1m7XSZMhBhAbbxPAYQ/R6FeepNW5i0yUhb9Vf0mMD9Bc
	/1vo00rjkQcrTyGxY5Iwgq5JksNgtUzwAzZ6avmKxJ4YTSV5i9aP990MB0K6eivsYB7cNdMdTVK
	5roIF1m0SebdNX+mWLh528FIY72JZ0Gm7NTkHVmOLVJ2N+fQPeifxofkJqn2yX94Z53FNEsqXyO
	HueNobxBOhBE9iJ6Ol05/dyp6bFd6KrTglMpKN5qcYiQKDJBD8ZCpg==
X-Received: by 2002:ac8:5a45:0:b0:4e6:eaa9:8a2a with SMTP id d75a77b69052e-4e890defe64mr794861cf.15.1760534291269;
        Wed, 15 Oct 2025 06:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYMWisWH0+ZGB14jA4jsreCXonf5bTEm2tvxmjYdPJwPg9hoSqnxhGbMTLY6h3qG2Avbm8MQ==
X-Received: by 2002:ac8:5a45:0:b0:4e6:eaa9:8a2a with SMTP id d75a77b69052e-4e890defe64mr794491cf.15.1760534290799;
        Wed, 15 Oct 2025 06:18:10 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc155143fsm262081245e9.11.2025.10.15.06.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:18:10 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH 4/9] ASoC: qcom: q6asm-dai: perform correct state check before closing
Date: Wed, 15 Oct 2025 14:17:34 +0100
Message-ID: <20251015131740.340258-5-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-GUID: PGdcu2AiBm8zpVQwp0-ww8koVcMhxq0D
X-Proofpoint-ORIG-GUID: PGdcu2AiBm8zpVQwp0-ww8koVcMhxq0D
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ef9f14 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=MOmvoJmQv4oe-d1MVI8A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX90/2Hamhvukr
 9kXKuONBjfphIV3pLINlS6n7931hfr1I0LsTv8+hEDhUOuFQF2KfriWpDwXE+N8UL4FmSzzNX7m
 AMA/oNnpZQQPPiMh3nTvLJviAL68FaDPMMZCXurRbklxwxVZxYJgFAagzthrNWtALM+IQCI/7xd
 6Mrf3RqIfMSDvkJX3DqcVyA8uAMeBGNl65bae/D8Wd/ZB0576MJhcvO6YEnyno/mM1jt7luW5Hn
 PfAwt/DKQA1xlpYBWMqJHi34bI2tdqBk8eVfhY4Yk0zRJbsT51j+v88JfOYqheTDsFK/Qjyqq7L
 nUT0tvdcsHSvy/ehJWVxhFiK5YWd9SYtnk6O+sANUEmRCa4Fm++u6x+iTZsnSwMuspjr6xgSRVu
 60A/urW8Mnr49DnR3PPqkEvjnbeX/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

Do not stop a q6asm stream if its not started, this can result in
unnecessary dsp command which will timeout anyway something like below:

q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: CMD 10bcd timeout

Fix this by correctly checking the state.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index e8129510a734..0eae8c6e42b8 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -233,13 +233,14 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	prtd->pcm_count = snd_pcm_lib_period_bytes(substream);
 	prtd->pcm_irq_pos = 0;
 	/* rate and channels are sent to audio driver */
-	if (prtd->state) {
+	if (prtd->state == Q6ASM_STREAM_RUNNING) {
 		/* clear the previous setup if any  */
 		q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
 		q6asm_unmap_memory_regions(substream->stream,
 					   prtd->audio_client);
 		q6routing_stream_close(soc_prtd->dai_link->id,
 					 substream->stream);
+		prtd->state = Q6ASM_STREAM_STOPPED;
 	}
 
 	ret = q6asm_map_memory_regions(substream->stream, prtd->audio_client,
-- 
2.51.0


