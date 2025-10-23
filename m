Return-Path: <linux-kernel+bounces-866696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B339CC0075C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE0E450027E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDD530C352;
	Thu, 23 Oct 2025 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ofp7nl/H"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8330130BB82
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215164; cv=none; b=RnBOYBAZUMvFqOtb3ZpRxyDEGFuBXfTiU07cTv9x5PaQVVLH4fxi9UNneungDgoYqGa5KHVLyLfAVBClvWlr7T1L1kqqjTovRahBCaQdqzGHTpugUsoCBA9lClNG7nMqGWNMTz7GNvk8pNToVaJZsnov+yiCPzNpVkY9lL0uVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215164; c=relaxed/simple;
	bh=n/QDHw1ITWRby7vrBcC4hapXZgt2KFZCOKf4tNRyaaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBgXe5v+XlTje+FMpBTnjZo9I/mwsFe8zC5sqrEEkJOP7MvDAgBxpFh/XlPJlXcC1Bz+/uiuP/ugjx3/QxvituExlLnK1LB2Ad8VpesRqr0koXxS6QSYkjtHk0TqRgCFUZhR4InujsKFxUPXGFoHxMB9w6rQQlnMVQ5iTNQ2PrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ofp7nl/H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7fQOT026317
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jdyJtjan7SM
	H7wF51lvA8fxlxpPM+Q5el4ttALOfDg8=; b=ofp7nl/HBaXVLLvPU82S4U87eL6
	Gy9EvPxlr17buAKxBAYQcnWxylx1Kg++K7y8RtBRTKCk3MLstr16HdN1ARN6pVcd
	6RVXfXm0xPTCQGj/nALSmHn8Vhp9cjATvCuE6O0M0LXy+3TANJXVZWyvk18fC5yu
	DhnYPYKaIAXV4/YnAwL8b6PB0V4AKOQ8yxiNIrZbx1H4i4d1x4bL6mJYAmwgQa1A
	AfRV9HT8L7HoB1n3vE8Xr9iyfd+zhOYMtpboYGP+zNQ5WbHanUx0Qz8MYHuqnRCS
	+PnTudC3dlP+T7wAtvywk02KPHYcSn0Nvbasoqgqc+MFqSidEGwvkV9z9jA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8j42p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8984d8833so30651191cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215160; x=1761819960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdyJtjan7SMH7wF51lvA8fxlxpPM+Q5el4ttALOfDg8=;
        b=gPBC38SoiqSRObTD/8L9Id5gZxdKameQ8ULQkVEEWnqWDZ6uvkgHcM4ul+pMX3oMqh
         zHHNnzCl7I1jRtS4rQMeqcQTFi/5qtsi7e4Mpnb/ML87XfJDFTadco6U8P+S8iNbQgmd
         SsUQBtnaZBrgqxBX2nKi6PfWMWFjoKKq29SEzEzFtTSZ+yP2gPgpFnKOjUHR5b1kIyMK
         nC6HbAKO6J50vg3rXUxDbLLEGZBJUCwjVzK7MBSFKSLdrRtHwD+i9KJAGAJVkEtqKDih
         XrwjwCUEFOQD+ucTQXsL7qDl7C0Ex57F/RUJd9uIsvby5GaQfsxG3mzAaLL3adsRTS+F
         P1LA==
X-Forwarded-Encrypted: i=1; AJvYcCUUWgH5oTHh/JuBCTK0+jIjHgWlezDDKrmY2HDAGFr/FHkuk3XGgftahyouKNUEdr/+/VrRGudq7xd8GlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8c09PjCLjCWnYteIucXxcQIVioUCWVQK9nLPHqh7zz0O7fkd5
	W7JVwksA01CpxxE+a5JRwYXq5M3NeZfndjBJP7L0Z6yMJXUganKj+LFyY97NRTCHaSxe406vUb1
	Y1D5bgPyDv2BeaDf66hfctWWaUTyq95ZG7OOIHgMdZrd8bScmxS4xo+hIYpYHq/QHZpY=
X-Gm-Gg: ASbGncu9J+gvpIXriOnCekJW27UzbAKzjVDmy/exFpsx3NuFhZxlKwXuwDCHmteGNS9
	KBb1l/tim64HzIenPA5ORClMLCcNPqFzLongRZsXWAmkVSp4Z5mNW5rN0NhyuJucsMn3ELnQOpp
	3mBE5j503Y7ADNJmU3vD89g/2x41KeuHOLUK3GhzzIsStl/gXq9hP9mvLkvWlOc/VE8SRbMO/Kr
	JipwU16gi1hcqbxNDtkZSvEmXQYDTJLL8yc01S/+tfBDI0qE/rvtHyiQwmUB2HSB1GH/tQwXfp0
	7DcoV76M3hHBO7U1MOzrFpdcIcJiZY1NsYGgWbgu7uYZU7yUdbEXOE5Nst1VUWhxkvpAe8P+/Z/
	pX6s1qb72W7eV
X-Received: by 2002:a05:622a:1827:b0:4e8:b8f7:299d with SMTP id d75a77b69052e-4e8b8f72eaamr207458361cf.68.1761215160561;
        Thu, 23 Oct 2025 03:26:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD7wLSA44400aNfpBlMqCLaACZqamHhHypYbkYfQM4rxcD3dsHflxyufF1YmFN6YdHQzG4bA==
X-Received: by 2002:a05:622a:1827:b0:4e8:b8f7:299d with SMTP id d75a77b69052e-4e8b8f72eaamr207458091cf.68.1761215160076;
        Thu, 23 Oct 2025 03:26:00 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:25:59 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org, Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 04/20] ASoC: qcom: q6asm-dai: perform correct state check before closing
Date: Thu, 23 Oct 2025 11:24:28 +0100
Message-ID: <20251023102444.88158-5-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: SlCiL75sphUgaZdtxCBXmGeC9KWRMRBm
X-Proofpoint-GUID: SlCiL75sphUgaZdtxCBXmGeC9KWRMRBm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfX+WHDKRdkQ7wk
 ya2mZkiUV+wi1/v4L4HofgmcDuSxA6rhm6S2FcnD35DvVXRtYdcCHnH1/bygSEuAeZoZ2E0J8CM
 F1fFtLVqBSRxp6zLt51M8V7H6gFLfQlrYvYj2Wc0XhgQe6wjw6v0bmq4da8UkrtBVRhD87knirG
 PxnAv6G3dPfZf0Z5HSCEk899BMM/1sRrAztp2GPEU5VhPVU2D5Umda8edITm6J3osC1QWGbqDuS
 cfAVgv0b37Ki0S3Ti1BvooD2/jBO6x30HPBI5GSEzK1yxYSzThnDzu0YR3L3QwGUXzVAuxu30kw
 MirFGTJNhDDoMOA6WP5sphEbl8QLm/hPlyVoAlHm+IPHTHymYr35jf4mNgJcmfDbzrpD4H9osEX
 baXDzSnzTN/aMnEWSSJzqPCy9hiNyQ==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68fa02b9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=MOmvoJmQv4oe-d1MVI8A:9 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164

Do not stop a q6asm stream if its not started, this can result in
unnecessary dsp command which will timeout anyway something like below:

q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: CMD 10bcd timeout

Fix this by correctly checking the state.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # RB5, RB3
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


