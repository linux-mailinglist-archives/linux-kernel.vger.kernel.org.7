Return-Path: <linux-kernel+bounces-866709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06452C007B9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4464C19C593F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D37930EF80;
	Thu, 23 Oct 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jdlst7Q8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CF030AD00
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215181; cv=none; b=Vn9OCUb4eMgi64OYYi8GmqwRPf2wkVSziIcoxtB/VpSF7aAwSbSj+moQnc9LvHZgnEmi3i1cC1ZCwV+18VbIgl96fzaJ7Tp53Y+35WwiNsdl+baaIHPOyhaWIoB/gvWUTQYU6WkXdvAL9B9aHTP3YGQm3bEWJkSB2M23+JTv6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215181; c=relaxed/simple;
	bh=Pl+VRIM8jMYmrEk1r+d3bUb24PCwoL2Iz+GkWBsYZAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLW/QciQyuB0thbtrHVBCCkhavi+C/c78EIy7xC61e3fMe/LpeeDToFgeEzMr213sgFxbk5RmqKljWcF3BKJ1UqsimabzTnKb36NyFS4eQ7Z29RY9XCaeDgZBr1uH6aYk01Tmo6Y6EJKIqNhGug3J46t7OuSzj7T39E/+epLMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jdlst7Q8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N75t44026940
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=U5s7+tt/ePg
	j8UCqWNRYRAttxI1T69YcEon7Yn8Lo/Y=; b=jdlst7Q8YegplkFfVB6TNb5sUiI
	O1EKfZ4nIwLZteHgJnn7mQ4yo4rtDUIbfYWmz5ABBXjHs87oHmxtiwSlVlQf+l2U
	UEfo5Y7NTuPbWJ9Nynzl3zrJ92Imd6Q4Y8Di4i3cKox17q/1W+fpivH9BS97i8yM
	rZTL+u+fpioLzpi1sJU17g9ep3x3mNQLTCXQHJ+FnMmqYiNGKIGZMfo7aSl9CuSQ
	o5s1/5ddVZfVHE/IOWvJZoyX3OVM5uktAdbpKV2EE14qU4jq+xL107ul1ORXMmdP
	y3VDAKaChItnYfBytqa6f8zjaSb89L/gjQKJu+e5PnG98BYU+u03V/AMKuA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8j44d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e88a5e70a7so20397241cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215176; x=1761819976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5s7+tt/ePgj8UCqWNRYRAttxI1T69YcEon7Yn8Lo/Y=;
        b=l9ztyS1FisfMFbaKzGadkRHpUeQZqSQP+10W+BXxBL9xT72qT7fvvOONHOZ97yVdUR
         wzcEl3VcaRemk5tghb5p3odrR7BET8sa+8LclCygPcpmcyP1IMLP0eS6dz8UZZ8QMaiT
         NDImTYmzx1wejAY1FQ4hJPZiMOgq/tZWJ375k0fGBzCw2fUNHLqDfZ/eDC2FKolHApJF
         pWpFEw4dulzuW0QY80Dp3pUpf/r9u41Rk7rJytmeKa/FzLu4eLRBTuDkXrNtPHwusi+l
         Qy8Nl1eh+eBnnm4yhYnmgrtM6GaR0+etD04VM8G2fylmY+yn+mEE3dGYr4so39q9RPaW
         mYOg==
X-Forwarded-Encrypted: i=1; AJvYcCUv9ROj5E17nkHGHKr6btG2G5j/9eLlRzXy8Jv3e9OiqncAYLCTwJq189vEjOSEoZ3aC8Q9T65PqUzdtIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsGNWH6j/W8IU17u0UHAKmN991FlGCXxgVwTSbK/Na1PstSYJ8
	NcuTxIDif7yIDBUaOBARFYXUiiR/MoMzlp8GNeyORGeg2wTYItdKN351Qd91cxK766l12PGyb47
	IzvnK1xOtFICBrvH1iyPvP/ZvcscyC3CXc66W7ZNGJSfsA3/7Y9nuGsH/9LEVjSThBBE=
X-Gm-Gg: ASbGnctThist5MwO5AsODO2aqiz1BhQ8Gm/pZ3IcuDIYWP9KrBhxMZzFF4aPToCSN0H
	SoMoAHp0XbomnvsQXXz6BXIngRTW9rW3OV4ERlmTLftZlR/5Kz5gaDZt9t8y5jyQc6Gz3G19g4A
	cg6ro7DySMBqOdDHMcOa5fZwS1bQBrKtb9l7TNLq4IYqxp3OfNoKMO5kR3BYwBV3VdTlJrY06NE
	DAwru9+GzuguW7/OC8W1AXZDifBTQe0YxKvSlFRCYRIq11f4M2m4poyLD1qnOYViZHh4btbriNL
	ZHx7+Mn3pHqTbWkwNGsDgYfY9ly7x5juLhU0yjwlQRTkgu0Q5oSssvcdoxliTXRjvB5vQqXxoQD
	QxF5wZIE+z3hy
X-Received: by 2002:a05:622a:4:b0:4d5:eedd:688d with SMTP id d75a77b69052e-4eb7852d982mr57834461cf.30.1761215175505;
        Thu, 23 Oct 2025 03:26:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0U7ebBcvl1ESr1pmHAg9hUcnB8qHP6KbgqfaqSs9ZIXwm/ptBfCmEGtKtFSfmg7i4lk+RVQ==
X-Received: by 2002:a05:622a:4:b0:4d5:eedd:688d with SMTP id d75a77b69052e-4eb7852d982mr57834101cf.30.1761215174821;
        Thu, 23 Oct 2025 03:26:14 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:26:14 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 16/20] ASoc: qcom: q6asm: Use automatic cleanup of kfree()
Date: Thu, 23 Oct 2025 11:24:40 +0100
Message-ID: <20251023102444.88158-17-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: tZLId8lMYPUpzHfi7RQZ35YLA4DL0Vhz
X-Proofpoint-GUID: tZLId8lMYPUpzHfi7RQZ35YLA4DL0Vhz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfX0ZPXO73DQRXI
 IwVtqqDPogPfegXVsGI0YTvGEznrLDUegQMND40ePswskooI3n+IRkUe49C3C173nzUHaQtR5rf
 m5Kx/aqeXEKjGQfvOLeKQiL57A2Xcrrfu5dJB6eYzFd7Jd3cqO3Oet3ARDAKy+dMyMLLHu4/8K2
 rJP1rypDcYQf576IQyE3qgKnWpQRTsOb7wGHnDI4hWjNgS2A2v5vKkQ30ctcSJ1fkh29nNJvz6o
 NGdE+AaG8bw0ul11x08+VIz3QHF1jksha1nrqr0Zm7AMKAHijnq2q8MFrfC3gFgalUygODVeFPp
 zwSsSW6EGfwTZMDpe0awDzTbdigOnvmLo3AGvHksV+5yERmlsEwBXnBJDLmDfyDRRunHkEgJmyn
 fJUo9Ptbzwx4YgHFO+U8XfwvxDC6MQ==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68fa02c8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=asJyTNMcW66pmJShVVUA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164

Its common pattern in q6dsp code to allocate temporary buffer
to send gpr/apr packets and free at the function exit.
Now this can be simplified via __free(kfree) mechanism.

No functional changes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm.c | 166 +++++++++--------------------------
 1 file changed, 42 insertions(+), 124 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 1478948f9fe2..431a99776dcc 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -335,7 +335,7 @@ static int __q6asm_memory_unmap(struct audio_client *ac,
 	struct q6asm *a = dev_get_drvdata(ac->dev->parent);
 	struct apr_pkt *pkt;
 	int rc, pkt_size;
-	void *p;
+	void *p __free(kfree) = NULL;
 
 	if (ac->port[dir].mem_map_handle == 0) {
 		dev_err(ac->dev, "invalid mem handle\n");
@@ -360,14 +360,11 @@ static int __q6asm_memory_unmap(struct audio_client *ac,
 	mem_unmap->mem_map_handle = ac->port[dir].mem_map_handle;
 
 	rc = q6asm_apr_send_session_pkt(a, ac, pkt, 0);
-	if (rc < 0) {
-		kfree(pkt);
+	if (rc < 0)
 		return rc;
-	}
 
 	ac->port[dir].mem_map_handle = 0;
 
-	kfree(pkt);
 	return 0;
 }
 
@@ -431,10 +428,10 @@ static int __q6asm_memory_map_regions(struct audio_client *ac, int dir,
 	struct audio_port_data *port = NULL;
 	struct audio_buffer *ab = NULL;
 	struct apr_pkt *pkt;
-	void *p;
+	void *p __free(kfree) = NULL;
 	unsigned long flags;
 	uint32_t num_regions, buf_sz;
-	int rc, i, pkt_size;
+	int i, pkt_size;
 
 	if (is_contiguous) {
 		num_regions = 1;
@@ -481,12 +478,7 @@ static int __q6asm_memory_map_regions(struct audio_client *ac, int dir,
 	}
 	spin_unlock_irqrestore(&ac->lock, flags);
 
-	rc = q6asm_apr_send_session_pkt(a, ac, pkt,
-					ASM_CMDRSP_SHARED_MEM_MAP_REGIONS);
-
-	kfree(pkt);
-
-	return rc;
+	return q6asm_apr_send_session_pkt(a, ac, pkt, ASM_CMDRSP_SHARED_MEM_MAP_REGIONS);
 }
 
 /**
@@ -947,12 +939,8 @@ int q6asm_open_write(struct audio_client *ac, uint32_t stream_id,
 {
 	struct asm_stream_cmd_open_write_v3 *open;
 	struct apr_pkt *pkt;
-	void *p;
-	int rc, pkt_size;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*open);
-
-	p = kzalloc(pkt_size, GFP_KERNEL);
+	int rc, pkt_size = APR_HDR_SIZE + sizeof(*open);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -1018,7 +1006,6 @@ int q6asm_open_write(struct audio_client *ac, uint32_t stream_id,
 	ac->io_mode |= ASM_TUN_WRITE_IO_MODE;
 
 err:
-	kfree(pkt);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(q6asm_open_write);
@@ -1029,11 +1016,8 @@ static int __q6asm_run(struct audio_client *ac, uint32_t stream_id,
 {
 	struct asm_session_cmd_run_v2 *run;
 	struct apr_pkt *pkt;
-	int pkt_size, rc;
-	void *p;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*run);
-	p = kzalloc(pkt_size, GFP_ATOMIC);
+	int rc, pkt_size = APR_HDR_SIZE + sizeof(*run);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_ATOMIC);
 	if (!p)
 		return -ENOMEM;
 
@@ -1054,7 +1038,6 @@ static int __q6asm_run(struct audio_client *ac, uint32_t stream_id,
 			rc = 0;
 	}
 
-	kfree(pkt);
 	return rc;
 }
 
@@ -1115,11 +1098,8 @@ int q6asm_media_format_block_multi_ch_pcm(struct audio_client *ac,
 	struct asm_multi_channel_pcm_fmt_blk_v2 *fmt;
 	struct apr_pkt *pkt;
 	u8 *channel_mapping;
-	void *p;
-	int rc, pkt_size;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*fmt);
-	p = kzalloc(pkt_size, GFP_KERNEL);
+	int pkt_size = APR_HDR_SIZE + sizeof(*fmt);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -1142,16 +1122,11 @@ int q6asm_media_format_block_multi_ch_pcm(struct audio_client *ac,
 	} else {
 		if (q6dsp_map_channels(channel_mapping, channels)) {
 			dev_err(ac->dev, " map channels failed %d\n", channels);
-			rc = -EINVAL;
-			goto err;
+			return -EINVAL;
 		}
 	}
 
-	rc = q6asm_ac_send_cmd_sync(ac, pkt);
-
-err:
-	kfree(pkt);
-	return rc;
+	return q6asm_ac_send_cmd_sync(ac, pkt);
 }
 EXPORT_SYMBOL_GPL(q6asm_media_format_block_multi_ch_pcm);
 
@@ -1161,11 +1136,8 @@ int q6asm_stream_media_format_block_flac(struct audio_client *ac,
 {
 	struct asm_flac_fmt_blk_v2 *fmt;
 	struct apr_pkt *pkt;
-	void *p;
-	int rc, pkt_size;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*fmt);
-	p = kzalloc(pkt_size, GFP_KERNEL);
+	int pkt_size = APR_HDR_SIZE + sizeof(*fmt);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -1185,10 +1157,7 @@ int q6asm_stream_media_format_block_flac(struct audio_client *ac,
 	fmt->max_frame_size = cfg->max_frame_size;
 	fmt->sample_size = cfg->sample_size;
 
-	rc = q6asm_ac_send_cmd_sync(ac, pkt);
-	kfree(pkt);
-
-	return rc;
+	return q6asm_ac_send_cmd_sync(ac, pkt);
 }
 EXPORT_SYMBOL_GPL(q6asm_stream_media_format_block_flac);
 
@@ -1198,11 +1167,8 @@ int q6asm_stream_media_format_block_wma_v9(struct audio_client *ac,
 {
 	struct asm_wmastdv9_fmt_blk_v2 *fmt;
 	struct apr_pkt *pkt;
-	void *p;
-	int rc, pkt_size;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*fmt);
-	p = kzalloc(pkt_size, GFP_KERNEL);
+	int pkt_size = APR_HDR_SIZE + sizeof(*fmt);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -1223,10 +1189,7 @@ int q6asm_stream_media_format_block_wma_v9(struct audio_client *ac,
 	fmt->enc_options = cfg->enc_options;
 	fmt->reserved = 0;
 
-	rc = q6asm_ac_send_cmd_sync(ac, pkt);
-	kfree(pkt);
-
-	return rc;
+	return q6asm_ac_send_cmd_sync(ac, pkt);
 }
 EXPORT_SYMBOL_GPL(q6asm_stream_media_format_block_wma_v9);
 
@@ -1236,11 +1199,8 @@ int q6asm_stream_media_format_block_wma_v10(struct audio_client *ac,
 {
 	struct asm_wmaprov10_fmt_blk_v2 *fmt;
 	struct apr_pkt *pkt;
-	void *p;
-	int rc, pkt_size;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*fmt);
-	p = kzalloc(pkt_size, GFP_KERNEL);
+	int pkt_size = APR_HDR_SIZE + sizeof(*fmt);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -1262,10 +1222,7 @@ int q6asm_stream_media_format_block_wma_v10(struct audio_client *ac,
 	fmt->advanced_enc_options1 = cfg->adv_enc_options;
 	fmt->advanced_enc_options2 = cfg->adv_enc_options2;
 
-	rc = q6asm_ac_send_cmd_sync(ac, pkt);
-	kfree(pkt);
-
-	return rc;
+	return q6asm_ac_send_cmd_sync(ac, pkt);
 }
 EXPORT_SYMBOL_GPL(q6asm_stream_media_format_block_wma_v10);
 
@@ -1275,11 +1232,8 @@ int q6asm_stream_media_format_block_alac(struct audio_client *ac,
 {
 	struct asm_alac_fmt_blk_v2 *fmt;
 	struct apr_pkt *pkt;
-	void *p;
-	int rc, pkt_size;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*fmt);
-	p = kzalloc(pkt_size, GFP_KERNEL);
+	int pkt_size = APR_HDR_SIZE + sizeof(*fmt);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -1304,10 +1258,7 @@ int q6asm_stream_media_format_block_alac(struct audio_client *ac,
 	fmt->mb = cfg->mb;
 	fmt->kb = cfg->kb;
 
-	rc = q6asm_ac_send_cmd_sync(ac, pkt);
-	kfree(pkt);
-
-	return rc;
+	return q6asm_ac_send_cmd_sync(ac, pkt);
 }
 EXPORT_SYMBOL_GPL(q6asm_stream_media_format_block_alac);
 
@@ -1317,11 +1268,8 @@ int q6asm_stream_media_format_block_ape(struct audio_client *ac,
 {
 	struct asm_ape_fmt_blk_v2 *fmt;
 	struct apr_pkt *pkt;
-	void *p;
-	int rc, pkt_size;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*fmt);
-	p = kzalloc(pkt_size, GFP_KERNEL);
+	int pkt_size = APR_HDR_SIZE + sizeof(*fmt);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -1344,10 +1292,7 @@ int q6asm_stream_media_format_block_ape(struct audio_client *ac,
 	fmt->sample_rate = cfg->sample_rate;
 	fmt->seek_table_present = cfg->seek_table_present;
 
-	rc = q6asm_ac_send_cmd_sync(ac, pkt);
-	kfree(pkt);
-
-	return rc;
+	return q6asm_ac_send_cmd_sync(ac, pkt);
 }
 EXPORT_SYMBOL_GPL(q6asm_stream_media_format_block_ape);
 
@@ -1357,11 +1302,8 @@ static int q6asm_stream_remove_silence(struct audio_client *ac, uint32_t stream_
 {
 	uint32_t *samples;
 	struct apr_pkt *pkt;
-	void *p;
-	int rc, pkt_size;
-
-	pkt_size = APR_HDR_SIZE + sizeof(uint32_t);
-	p = kzalloc(pkt_size, GFP_ATOMIC);
+	int rc, pkt_size = APR_HDR_SIZE + sizeof(uint32_t);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_ATOMIC);
 	if (!p)
 		return -ENOMEM;
 
@@ -1376,8 +1318,6 @@ static int q6asm_stream_remove_silence(struct audio_client *ac, uint32_t stream_
 	if (rc == pkt_size)
 		rc = 0;
 
-	kfree(pkt);
-
 	return rc;
 }
 
@@ -1420,11 +1360,8 @@ int q6asm_enc_cfg_blk_pcm_format_support(struct audio_client *ac,
 	struct apr_pkt *pkt;
 	u8 *channel_mapping;
 	u32 frames_per_buf = 0;
-	int pkt_size, rc;
-	void *p;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*enc_cfg);
-	p = kzalloc(pkt_size, GFP_KERNEL);
+	int pkt_size = APR_HDR_SIZE + sizeof(*enc_cfg);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -1445,15 +1382,10 @@ int q6asm_enc_cfg_blk_pcm_format_support(struct audio_client *ac,
 	enc_cfg->is_signed = 1;
 	channel_mapping = enc_cfg->channel_mapping;
 
-	if (q6dsp_map_channels(channel_mapping, channels)) {
-		rc = -EINVAL;
-		goto err;
-	}
+	if (q6dsp_map_channels(channel_mapping, channels))
+		return -EINVAL;
 
-	rc = q6asm_ac_send_cmd_sync(ac, pkt);
-err:
-	kfree(pkt);
-	return rc;
+	return q6asm_ac_send_cmd_sync(ac, pkt);
 }
 EXPORT_SYMBOL_GPL(q6asm_enc_cfg_blk_pcm_format_support);
 
@@ -1473,12 +1405,9 @@ int q6asm_read(struct audio_client *ac, uint32_t stream_id)
 	struct audio_buffer *ab;
 	struct apr_pkt *pkt;
 	unsigned long flags;
-	int pkt_size;
+	int pkt_size = APR_HDR_SIZE + sizeof(*read);
 	int rc = 0;
-	void *p;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*read);
-	p = kzalloc(pkt_size, GFP_ATOMIC);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_ATOMIC);
 	if (!p)
 		return -ENOMEM;
 
@@ -1510,7 +1439,6 @@ int q6asm_read(struct audio_client *ac, uint32_t stream_id)
 	else
 		pr_err("read op[0x%x]rc[%d]\n", pkt->hdr.opcode, rc);
 
-	kfree(pkt);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(q6asm_read);
@@ -1520,11 +1448,8 @@ static int __q6asm_open_read(struct audio_client *ac, uint32_t stream_id,
 {
 	struct asm_stream_cmd_open_read_v3 *open;
 	struct apr_pkt *pkt;
-	int pkt_size, rc;
-	void *p;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*open);
-	p = kzalloc(pkt_size, GFP_KERNEL);
+	int pkt_size = APR_HDR_SIZE + sizeof(*open);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -1552,10 +1477,7 @@ static int __q6asm_open_read(struct audio_client *ac, uint32_t stream_id,
 		pr_err("Invalid format[%d]\n", format);
 	}
 
-	rc = q6asm_ac_send_cmd_sync(ac, pkt);
-
-	kfree(pkt);
-	return rc;
+	return q6asm_ac_send_cmd_sync(ac, pkt);
 }
 
 /**
@@ -1595,12 +1517,9 @@ int q6asm_write_async(struct audio_client *ac, uint32_t stream_id, uint32_t len,
 	struct audio_buffer *ab;
 	unsigned long flags;
 	struct apr_pkt *pkt;
-	int pkt_size;
+	int pkt_size = APR_HDR_SIZE + sizeof(*write);
 	int rc = 0;
-	void *p;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*write);
-	p = kzalloc(pkt_size, GFP_ATOMIC);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_ATOMIC);
 	if (!p)
 		return -ENOMEM;
 
@@ -1635,7 +1554,6 @@ int q6asm_write_async(struct audio_client *ac, uint32_t stream_id, uint32_t len,
 	if (rc == pkt_size)
 		rc = 0;
 
-	kfree(pkt);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(q6asm_write_async);
-- 
2.51.0


