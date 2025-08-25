Return-Path: <linux-kernel+bounces-784470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF7AB33C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0743AC86B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375492DC327;
	Mon, 25 Aug 2025 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HX0CBdcN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258AB2D9EC5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116782; cv=none; b=hX7glWYU/xAak1TibcuCrb6rwjF471zTzUrhF1McgCujsH3+VE9Rf0iBDDgadRg2ZLgtPkRtPuV6O5OheOgBY+lIWYJWT1DetjiA1BGbtS5ZUiQRNIITBmS/YzqHuJQHAmZQQpI6zT4JN4BcAZ6I56XO5jnaITBTOjVZPiEtIGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116782; c=relaxed/simple;
	bh=qETacxdD+xOMesgXMU0txWNaZ5hKWFtVQbpaLYum4Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDAlj/K/OXK20c5CrCjdTiyy8P2f1pGZA9EyGhrY1gMKmiU4ks1FT8RZnqcjvnpK+9BZbOT+/s737EPr5gEnjxafamvJBZIyEPAsqndDd6QBZbFB37hKyar2CCPoJGLiWrvRZQNM8iU8pBk4PFeOJrh4Lkn3GYX7hrRyL4Im7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HX0CBdcN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8MFWd004082
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=M94yiXXN3v2
	OeJTyDLo3KsFMQqNubljS5iZCkUwPSZ8=; b=HX0CBdcNMAbP5YdkvBxw06GNjHs
	dXwFKQKsnZrIvxTZbcsiK1KYW90sEKivlKgJFD+6g+kydNSH/pv1RvvPiu5lwB/X
	ug9ZFCKox4qmhIk7HytzYQncH0GmsuIe7Fg+w0NXw8UWKIcp5V0N/A05Fxz9bTP5
	C1WgmsLC6wIa9EAFyaz4t8sIGIUSbeYF99s5/Wvg0co5WOXC1Tiln9vrArZpojqv
	SJohIZ3/ppYgqky5n0jZgvqLMLnKKw9MSaeYau+zvhcmfWhb9XQSm9rnrnrFs/tG
	RUcuoAsX0+LAX/iv4TfsVtrsKQWXg61JF6S3lQwrMo2urbSluQdvCf8CrmQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpmsmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:13:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b10ab0062aso102922331cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756116779; x=1756721579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M94yiXXN3v2OeJTyDLo3KsFMQqNubljS5iZCkUwPSZ8=;
        b=hKT4c7o6T3xxcCSeIh6lmoZ8d0LI9/kOyK5Y8bAql09hU0L3WPD1/StZYRvT6WWSV1
         RiL4F1rdASpkAjVWLKhvNH3vJNJr9Ef1s2nVMU0JpOObD+DC/y7BC/Y9NZWro6Xpr6JP
         v4z4KPw0/rodSydQOEiX4PU4gXO4ofVTQYXm6Y9tq0J/kPgAix/whmUYbBc7crUs/6gU
         WvvoqO6ILUFMUjhn1wRpWfGp9/FeWM8phrf/HBPUqGuHmqiTDtlStv9nNTVqFBd47xKu
         cYwEOTTtRsgsykwnDf/5XK3sY9EEUqOT/nV3EnoxMG4JrCxZ7IXtzeu2Sl3gK5ws1Q03
         MiHg==
X-Forwarded-Encrypted: i=1; AJvYcCUXLvWI1RQPtnn4B06Xz8Yvo8+ajzv61qK61d8rf3p+HVw3I6ZsetrjAOCjqpiNJjnr4ud0ZFROZGDdpmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt3fe1VcKLYk0AiNSNDJtdGmuyNqsP7z1pTtoDsP/x1QoZQi1c
	PLjOWf959e63Drqb2etD4nqBl4uPbFG7IWhtp5aZcPKMz5z75W1pxJ7Nqn+gRrFIrOF/Ii9PibM
	Vn9grr4cpRMGLnenhkUOj1eY98q6eIMFr1iBRFeKZ8QBAxOHYouCpHGjZWKxOrkbLIgE=
X-Gm-Gg: ASbGncsEmSBcCHOpB6CWANADsKSmQhIHulIImrMRdtGH6TZRtWroYE5MsvRsdG032ST
	lWzEtjSNHnSijNp4cH5w0K6vhAzhXrw3uYrMBxB3eV7T9JvHwMd1MoOu/odF/7OnOz4JiX04xc1
	4r5F0aSp4JopQ4KpS/gCJSqIli7mMhfCkI3/pTQ0wmNZ0q/NnHmdeyj69SgvUk/Vx9Lc7i66rTH
	Af7zq7y79LrloMuJxBxUNAMwzw1hEDaOd5OQlqHl/JT67I4gmq5nnTt9dCkhui2ehw3/XqwvLbQ
	tc6LrKr3jMi9X1IkCFr0+Sv9TSOtDm+tZ6To+8i+Oygi1oxguNVwQg==
X-Received: by 2002:a05:622a:4188:b0:4b2:d25d:2f15 with SMTP id d75a77b69052e-4b2d25d317amr35725611cf.20.1756116778665;
        Mon, 25 Aug 2025 03:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2cGVPeIFuXbrWm4z0GxzF/KpOCtFW5IwJGn5xkGyqjVJJolW8huuGhTudz9wm/LFSsEywjw==
X-Received: by 2002:a05:622a:4188:b0:4b2:d25d:2f15 with SMTP id d75a77b69052e-4b2d25d317amr35725231cf.20.1756116778089;
        Mon, 25 Aug 2025 03:12:58 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6359b8d6sm5798645e9.4.2025.08.25.03.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 03:12:57 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>, Stable@vger.kernel.org
Subject: [PATCH 1/3] ASoC: qcom: audioreach: fix potential null pointer dereference
Date: Mon, 25 Aug 2025 11:12:45 +0100
Message-ID: <20250825101247.152619-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250825101247.152619-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250825101247.152619-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68ac372c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=6m3MDpN89X3R0uDixRgA:9 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 797VoJz_uCIYAHxrw_I4j9rylc8eXXpj
X-Proofpoint-ORIG-GUID: 797VoJz_uCIYAHxrw_I4j9rylc8eXXpj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXz9YJuMcRWVLr
 MX6x68zJRRpiNZXjFV5CkF48CDczZ/lcQNyJ9yG4vbJ8oi9ZSdKO1lo+LuEnKDVrsgrKL6HkidT
 qSGfp8+RbjUxerFP2c+ItqKl7gcwQSFPTQDpZMbEDnMJ/2CVKzHCfQO9ncnw8vldsnYT5WWOY2c
 oDbDpJPjo7eR3XwIuUN07sh/GppXodtOS6EvMPactVZRm+l8omHn+xM3CExswNeFoZ88oxn0TM6
 ayxdXTqsgvAUh2DdZKyYe7PDszj6lY05Z8A//H+yw62BWa7wENqHuHIGwMJyKC5squMbKnMtUQz
 27WU8imEeiuFoSD5CsLmmU/jtMRRRBCwvCY4U/Pqh2X8npD8rxdRR8GXqfGrY167ISDNl69szs+
 B02LUyab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

It is possible that the topology parsing function
audioreach_widget_load_module_common() could return NULL or an error
pointer. Add missing NULL check so that we do not dereference it.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: <Stable@vger.kernel.org>
Fixes: 36ad9bf1d93d ("ASoC: qdsp6: audioreach: add topology support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index ec51fabd98cb..c2226ed5164f 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -607,8 +607,8 @@ static int audioreach_widget_load_module_common(struct snd_soc_component *compon
 		return PTR_ERR(cont);
 
 	mod = audioreach_parse_common_tokens(apm, cont, &tplg_w->priv, w);
-	if (IS_ERR(mod))
-		return PTR_ERR(mod);
+	if (IS_ERR_OR_NULL(mod))
+		return mod ? PTR_ERR(mod) : -ENODEV;
 
 	mod->data = audioreach_get_module_priv_data(&tplg_w->priv);
 
-- 
2.50.0


