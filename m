Return-Path: <linux-kernel+bounces-773540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9EBB2A19D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1B317675D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47070320CB1;
	Mon, 18 Aug 2025 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kx1txnnE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006D31B119
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519775; cv=none; b=K8s2RRc0rFqvaEJCX463FizpjCTI7SOLnowscTAxaUmxKr+pWw4erjf1pEb2yOFzuC5ufqE96IUvG1p09BBeA9s69toGjI5nqRqv/8FgEbnNJ7rr5OOcbXpDox4XyUw94jcQq5zxpYT9Gjfzt3PZWasGV4YNfNFLDam/FLzEIC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519775; c=relaxed/simple;
	bh=lJiXI/C5Fuyf6B55gsngV/ulvqr7iM3XDCbQuIE36GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a91bOPuQPuOdgjdw7dYR5t4o35frnqYUa4gT4Gq1pvwN/erQwUDvoI4vegzaeii6cBMt8QPk+IDuXXnjoNOdebpZKR0lFpQYfE0ewgcqr5C7F0gjsezZVAozpk7SQy5yCfcoiQ61gH/KCanOk2fvuWLb5/HFNZ18RnbOO9CZCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kx1txnnE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7V3rc004103
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=18KqI4JQ1JW
	PbQpGA5es5HkuNAUrV8JMaK/zZS5RWVA=; b=kx1txnnE8UVg6qDf10/ScpJgfHm
	Sb6o5KrqK8vMq7JweYSeBujnqCgHTHuiGKOgVAxXqUC7YYm4bbP9bAAC8zV9DXQ1
	SnSXb41M8J2KL+6PjYQ1gbBB5ZkrdgOZejn+lJAWc+pum9CnpL75LWyQGPNUJtaZ
	SLmqfJkAREBkX2njPoJUkMp5C//F2awzvdwCsHmEcHr288ValDNbVXXhWyI//dGg
	oL3pjkVZgfOGjQxD82uerSS+2hb0+ey9xsEK+48PdGIMlNcpxIgiu+Fq9Hl/H7Bp
	5giq0soDgneomKdhz9vuYfyMQDq4Z1BU5K3XOXnWZce5YpC0W6eqJf6WnGA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyur8v75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:53 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a88d99c1cso95763066d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519772; x=1756124572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18KqI4JQ1JWPbQpGA5es5HkuNAUrV8JMaK/zZS5RWVA=;
        b=mljIgywte2d8u18WT0YYVJT5C44Hk7jOooijFlS4bpk2ABR0g1mJjg19n4wFRV8yb1
         qoWWa7Re5Gce/vLLOreLdOulWNMGcmRXaaz62eAKOAUjsPVZ8LwkK8EBCUG7344C0eWo
         ge1nfDGNBu8AoW4DDyJSuppc9+1ni/Dxq5C/KsOS09V789i7OBPXjN9zFxl68po1lJ9/
         6SC62cDw41d5ev2pxIMb8JcO2FzlZWzdmoABFnlvUfHuFpGhgP6ZU0z9QtUgiXOkK/pi
         rcjIn79PpLABD/iIiWGLpnPgG3chMZeLGSwZweeU5nnobiZuJse1DKrB636/tpO1mThq
         nG2w==
X-Forwarded-Encrypted: i=1; AJvYcCWV3Qai1tqVxtpvSoDr1rN0b582qfTAAaxdEuXnwjPsWMTa/U1W3I2bVzZ2MlbaGDCpMQVLm0/LmimwWyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjWatIdEP5EzH6eHQs7ehg53s52ofc98OAFpxUwZuwRyr5n4Gy
	xHHkGh3unmxldeS0Z2rRPAgOglU2d1aHMR/J/G8jycdaYll1tCAkTXWTKY+tcf3/HX+9Fqi4B0s
	ShVGcifI0vaqfCdnKK1NsUKQ3H0Yy4o0IGnyRQAcS1v8EZup00+BIKPdA0dgARETBD6o=
X-Gm-Gg: ASbGncvUhbH8/ZV8nSLLM7Cb5sHZHng6t2UmLgmgRrzknL6jvK/LPBERmtorj9B23oK
	5InmZUeCl/OvK6xOTwk/fgyjISix0C7IHRzqPb4aJMR5bzfZNean8IHcF4v0F3VKgykmeyoLSoj
	cWx5qYbh7G34rgfRUeRLo1OudaBCzM2+FM/kGEnlb9TLJlWhjY+F+Wxy6W4IyNHvQybGjVMZ9R4
	2f6Lv5UGTx7EcW/voEPqfVLuWgwBSCKXj50dI7HHjfQ1h0Pfn8GIE8oLJD29LKPqqEfXcypR1mG
	JCf1WAmDZ4QoEfEZEQvDU2qK+FPoRGLnxSVDg74VN/qe9Z6+ho7uHg==
X-Received: by 2002:a05:6214:c43:b0:709:e51b:2971 with SMTP id 6a1803df08f44-70ba7bfbca1mr127743466d6.26.1755519771581;
        Mon, 18 Aug 2025 05:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsRLUYmlEY9isyXBY9OO7FatP/twXOv1kdIQnNy6AnCeJmhofS9wF093UUPE6Fpivow8O03Q==
X-Received: by 2002:a05:6214:c43:b0:709:e51b:2971 with SMTP id 6a1803df08f44-70ba7bfbca1mr127743076d6.26.1755519771142;
        Mon, 18 Aug 2025 05:22:51 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb653f657fsm12601563f8f.29.2025.08.18.05.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:22:50 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 2/6] ASoC: qcom: audioreach: add documentation for i2s interface type
Date: Mon, 18 Aug 2025 13:22:36 +0100
Message-ID: <20250818122240.1223535-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250818122240.1223535-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250818122240.1223535-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA2OSBTYWx0ZWRfX4I6jRApYEPOt
 8MbYJhUjgDAxMXGxbeg/S093icEf0oN8wBWdsQYHU346F+1XKHqh15C8KWX5jJ/zSv3ZECb7jJU
 ZrDVfT5wvzNibCn2r8p3bRLpkjrPo5rNXKLsClMOdFiEX/5gjCz2HrIBWtQ8qGZ867ty6U7CmWj
 oIKuhgLDw1I/XS253NhUJtSAt1szPeHTkWHdq3JF3PFsMIdlXBuPi2k085aGnkaziPBstUILaJ9
 oIAWCwllhqsjrcaWxocnbBaIS3rk5IoCZRmAkMxsHY+FjvYteFWnsVRgLkGDzGfZH13pdVSDIG8
 KUg+9RCvkn1rpUy8I2BppDBMEZLVsiK07adi26aJPAQvMzzYCtNBhVrYn3v3hscDarWeoq/MAeD
 vOzdLbc0
X-Proofpoint-ORIG-GUID: V2lsyde4nUpH-2fEQve1TTGR55fEo1no
X-Proofpoint-GUID: V2lsyde4nUpH-2fEQve1TTGR55fEo1no
X-Authority-Analysis: v=2.4 cv=YtIPR5YX c=1 sm=1 tr=0 ts=68a31b1d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=FY2npp4C09wRtmNKfY8A:9
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180069

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Add documentation of possible values for I2S interface types,
currently this is only documented for DMA module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/uapi/sound/snd_ar_tokens.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/sound/snd_ar_tokens.h b/include/uapi/sound/snd_ar_tokens.h
index bc0b1bede00c..3aa5f4928a2b 100644
--- a/include/uapi/sound/snd_ar_tokens.h
+++ b/include/uapi/sound/snd_ar_tokens.h
@@ -118,6 +118,12 @@ enum ar_event_types {
  *						LPAIF_WSA = 2,
  *						LPAIF_VA = 3,
  *						LPAIF_AXI = 4
+ * Possible values for MI2S
+ *						I2S_INTF_TYPE_PRIMARY = 0,
+ *						I2S_INTF_TYPE_SECOINDARY = 1,
+ *						I2S_INTF_TYPE_TERTINARY = 2,
+ *						I2S_INTF_TYPE_QUATERNARY = 3,
+ *						I2S_INTF_TYPE_QUINARY = 4,
  *
  * %AR_TKN_U32_MODULE_FMT_INTERLEAVE:		PCM Interleaving
  *						PCM_INTERLEAVED = 1,
-- 
2.50.0


