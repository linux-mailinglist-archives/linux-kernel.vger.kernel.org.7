Return-Path: <linux-kernel+bounces-857635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE96BE7502
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04AA8501EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD9B2D5C76;
	Fri, 17 Oct 2025 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uww1N1ua"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8375A2D4B4B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691392; cv=none; b=DFH5dy0rrx6kv38J11nsUMqZMbVL7zTSger12p7xYWSuQUE5vZQaf3VJYBd7EOOKoa5NN4nUdVqOedNWI+zx3NJaaMdNtWSanJ04zOPLNXTd0Oz1j+GHdjszrmOKRJ7DnLkL/Um8iyERPzY70zOXQjd4I9ZU2uFq/1yJzic5woc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691392; c=relaxed/simple;
	bh=yBNFWfi7nb0NEEgHL4lbgPtCESQBjN8cUW0xWV+hUrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIA2dz37tZ9bEacdktaniDkMDPZ3O6LVvcbSlQmnSme8ZBhFxg48D5AHGtq6H8xRKiKLsq13AeDLprcNrBIIdWB/5aXnDKx0/EqEk3YJUkyA33o9peLKSurLQZzPGMWtHcb6QHZTaWt2TFXMz2XWgUiarVlz1i3GTPHdIPhOOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uww1N1ua; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H83NPg025387
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nDvlp40m+Ni
	viZ7Prwo/9bXT1BrtIsyNq1nV9QUwJU8=; b=Uww1N1uaGi2FFme7I1wBWjSasQC
	UC7KEVUT6M7RGACcM9I6LHdfcAbrDaWnrOCAWRez7gyz//R+I79xTnkjXv6vXJO6
	gISuVFCDPphBj/fD+W6iyRX4f14GizHC/4Pz2WSZNxjPuFWlB4x54tsurhdHneT2
	YBN+tVzXeTd1ysKe3XIuN/TeauwyRSDqejeA/kb5b4A8Q0MRpa6121qXwYvEDUWM
	AAhDAjlNQ9JGx99ooR67w+AZ3SepEJ/kNXNBYLIQ6yQ5AJWFTt5OmoK2Lcr45cGe
	c9peTsMf5rAThxJXa/xgYSnWia06cXffGzLHO2BtQrJFvhJTi+sMukDXc5w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdkkj5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-88f1dad9992so762228085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691388; x=1761296188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDvlp40m+NiviZ7Prwo/9bXT1BrtIsyNq1nV9QUwJU8=;
        b=djL81HDG5vYZQPbkjuae49lxucVFqr5zDTTwtyaGqbyClE6lkeSa0U/LPy2qfFs2dC
         BCmKLb+/+hV0Goy3RSQ3sgnjj94ptK6FR24S1iPYqtnVYLnokFSyHDLwPhlQpBIMGCUS
         MvKsSEqNaaNAAGNEAGBZYab/n3tC8A92Uqf5+rjSmRQdi3Df9OF72lq6ruXxsKT1NSHv
         CjI+kupS222ifzB03QDhWtNPMxZlDHg+54sZ8MuHuoF9JZuqfbYCBezTpv9EOSx3IIfW
         cwnqNEhfVM9V0A0cLguzPSyiqAfALr6Bn9RVURF7CI25tmwJT7LcQMmYBtzvGvTQVRbD
         NjjA==
X-Forwarded-Encrypted: i=1; AJvYcCUeGHZPIUJ/YA++hPCpVfrPj2YfcBZp/dM39+3lfsjrz4ef7DhLBbnfpLqVIYtJXSNKmeiUZKGqXukC+2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt4n1VqGiwtrlO+zHU5FSJKLbYPinin8a8LI2MzYmC2blQPlxM
	k3ZY1y0vAfaGPtXgX7Q/EZHwrmiHUrqKsYUUVJufKE2cQLSOxpvSRbsH2IwCX7dSCMe70yho4q5
	jIbuLXjBneGOKP4DC1GhVEgf6H+6gg5Q0o617TcEhXZ7nOTw2VQju2CV/595Fdok4/+s=
X-Gm-Gg: ASbGncsDQ6ttqiS2Hc3FfRZv83Zo2qERS430RVk80UdKsZ7kfhrwtQP9OLGKbN4sUoD
	LBNtNDsp6ZDELaY/YWTwNfijbtNCxZeUP2P4GfPahaDKIC58pW/yBrDMeOK/3jH21k49Slp26lu
	LMsAu8RZhybAawviUh5DAnh2nglTC47tDXTu7Cme0I0LXf+h+nqK00lV2aWk43U0j3Y25Hy/uec
	b3Xgh16hoXYIvfuii37xN5kH6nFdTxm35B1uxOUFtAaJ1CxDaqhmfuUyNFxCc3FsBp9L6tcdY53
	+A0hmiVsuUoDo6pdfwxvXE9JnuwBbKWCdsQtsEaDnr5nUUr8ASVCxdnO/ZSBYe9AhnqtoqZsJV3
	OlgBKkt3GUSZ2
X-Received: by 2002:a05:620a:d89:b0:84b:226b:bf4b with SMTP id af79cd13be357-8907011469dmr371062085a.44.1760691388340;
        Fri, 17 Oct 2025 01:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUPr93d8Ajmplggb+ldAlBxbQLvNV0HTydv4xrmLHHI5+c/49iamayVLMQxclCht+/wql+7w==
X-Received: by 2002:a05:620a:d89:b0:84b:226b:bf4b with SMTP id af79cd13be357-8907011469dmr371060085a.44.1760691387891;
        Fri, 17 Oct 2025 01:56:27 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444d919sm70764985e9.14.2025.10.17.01.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:56:27 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 05/12] ASoc: qcom: q6afe: Use automatic cleanup of kfree()
Date: Fri, 17 Oct 2025 09:53:00 +0100
Message-ID: <20251017085307.4325-6-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: oC_sf4mwkYCUti2Zg-TKvwJLfrEKx30m
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f204bd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=92AZDs2nESXm7HPk3LYA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: oC_sf4mwkYCUti2Zg-TKvwJLfrEKx30m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX7IZr7roli7nG
 zpQbgbV3ThZqscUMeWrp6PqJ9r3se/GnCL2ebsaIAT/OdpbBkWlNfocQbachGSqIUuimyU9xfUf
 yFkQWdHXkde8GB1iHefa0m2eYrMy6nS5MixYlkDrD4S7D6PT4wx4UwcwW1Z3Fwrrr1XsDazDbmU
 9SndiYhqzOEIhXl2lNyfxj+cx1fxJm3ecnNnIVxi8Yp4iJHI234EQpd/+sTf6LZterBZ0HGVW7h
 BhISAB5IWOvh6QkXtDEkRo7HrPbbI2g2T+Ii9Jy7bIZIfpEze6DcDN/NIM4dP583c5zTrRbgNoN
 qniNCvURJbiLgzWkeR0EBPRpiCCTmqXKlFKXoWYr0uJrTGdXMuRxee/RipH/DXEW4iP34g3DH8E
 uA/puRj98cTi0L88lzwbXtEclzKDjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Its common pattern in q6dsp code to allocate temporary buffer
to send gpr/apr packets and free at the function exit.
Now this can be simplified via __free(kfree) mechanism.

No functional changes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6afe.c | 41 +++++++++++-------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 7b59d514b432..56f85f1c2425 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -1077,11 +1077,9 @@ static int q6afe_set_param(struct q6afe *afe, struct q6afe_port *port,
 	struct afe_svc_cmd_set_param *param;
 	struct afe_port_param_data_v2 *pdata;
 	struct apr_pkt *pkt;
-	int ret, pkt_size;
-	void *p, *pl;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*param) + sizeof(*pdata) + psize;
-	p = kzalloc(pkt_size, GFP_KERNEL);
+	int ret, pkt_size = APR_HDR_SIZE + sizeof(*param) + sizeof(*pdata) + psize;
+	void *pl;
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -1112,7 +1110,6 @@ static int q6afe_set_param(struct q6afe *afe, struct q6afe_port *port,
 	if (ret)
 		dev_err(afe->dev, "AFE set params failed %d\n", ret);
 
-	kfree(pkt);
 	return ret;
 }
 
@@ -1131,11 +1128,9 @@ static int q6afe_port_set_param_v2(struct q6afe_port *port, void *data,
 	struct q6afe *afe = port->afe;
 	struct apr_pkt *pkt;
 	u16 port_id = port->id;
-	int ret, pkt_size;
-	void *p, *pl;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*param) + sizeof(*pdata) + psize;
-	p = kzalloc(pkt_size, GFP_KERNEL);
+	int ret, pkt_size = APR_HDR_SIZE + sizeof(*param) + sizeof(*pdata) + psize;
+	void *pl;
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -1168,7 +1163,6 @@ static int q6afe_port_set_param_v2(struct q6afe_port *port, void *data,
 		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
 		       port_id, ret);
 
-	kfree(pkt);
 	return ret;
 }
 
@@ -1285,7 +1279,7 @@ int q6afe_port_stop(struct q6afe_port *port)
 	int port_id = port->id;
 	int ret = 0;
 	int index, pkt_size;
-	void *p;
+	void *p __free(kfree) = NULL;
 
 	index = port->token;
 	if (index < 0 || index >= AFE_PORT_MAX) {
@@ -1316,7 +1310,6 @@ int q6afe_port_stop(struct q6afe_port *port)
 	if (ret)
 		dev_err(afe->dev, "AFE close failed %d\n", ret);
 
-	kfree(pkt);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(q6afe_port_stop);
@@ -1676,7 +1669,7 @@ int q6afe_port_start(struct q6afe_port *port)
 	int ret, param_id = port->cfg_type;
 	struct apr_pkt *pkt;
 	int pkt_size;
-	void *p;
+	void *p __free(kfree) = NULL;
 
 	ret  = q6afe_port_set_param_v2(port, &port->port_cfg, param_id,
 				       AFE_MODULE_AUDIO_DEV_INTERFACE,
@@ -1722,7 +1715,6 @@ int q6afe_port_start(struct q6afe_port *port)
 		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
 			port_id, ret);
 
-	kfree(pkt);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(q6afe_port_start);
@@ -1845,11 +1837,8 @@ int q6afe_unvote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
 	struct afe_cmd_remote_lpass_core_hw_devote_request *vote_cfg;
 	struct apr_pkt *pkt;
 	int ret = 0;
-	int pkt_size;
-	void *p;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*vote_cfg);
-	p = kzalloc(pkt_size, GFP_KERNEL);
+	int pkt_size = APR_HDR_SIZE + sizeof(*vote_cfg);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -1871,7 +1860,6 @@ int q6afe_unvote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
 	if (ret < 0)
 		dev_err(afe->dev, "AFE failed to unvote (%d)\n", hw_block_id);
 
-	kfree(pkt);
 	return ret;
 }
 EXPORT_SYMBOL(q6afe_unvote_lpass_core_hw);
@@ -1883,11 +1871,8 @@ int q6afe_vote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
 	struct afe_cmd_remote_lpass_core_hw_vote_request *vote_cfg;
 	struct apr_pkt *pkt;
 	int ret = 0;
-	int pkt_size;
-	void *p;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*vote_cfg);
-	p = kzalloc(pkt_size, GFP_KERNEL);
+	int pkt_size = APR_HDR_SIZE + sizeof(*vote_cfg);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -1911,8 +1896,6 @@ int q6afe_vote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
 	if (ret)
 		dev_err(afe->dev, "AFE failed to vote (%d)\n", hw_block_id);
 
-
-	kfree(pkt);
 	return ret;
 }
 EXPORT_SYMBOL(q6afe_vote_lpass_core_hw);
-- 
2.51.0


