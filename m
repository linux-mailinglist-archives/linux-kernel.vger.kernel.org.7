Return-Path: <linux-kernel+bounces-857634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA3DBE7505
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0DB188F815
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511C92BDC3B;
	Fri, 17 Oct 2025 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E2w0ov/O"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EDA2D3A94
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691390; cv=none; b=K9vtBf4RGXrbxBUmNTzRwtP7n/fLgm8BIvNmWm3Nmt7uOWwOqOKek/0wQa2cZNESy0ohGcDMvZOgGkX6MBqrUJMg2qRjcFbg0qLfU76VniX6RzPBr0jE+ng3TeXoFVNky7akR0QMhQlO/llYtc/VGPMbjBacbt0BtT4tb/qQDeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691390; c=relaxed/simple;
	bh=UOMDuytwV5b0FWFmJzLikQVcSaE25eP4RAV2dWnOfww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhDkvzYfGLEIWeOhs06tVvOlkM9MzgQlqRUGpqRufvj5f4pP5U55AVoLoT0oj2XNyXs+qKqInKYZUIvfnxRkzFeXqHRqGK0DF87/j6784PcIfRDj4/UfOlEf5owIR0/f8xX/g1EiHj2J31gnrtUTIU5HPnVtSkKJy6Hw7tJc0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E2w0ov/O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7sQOq028676
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IRPASGCwKLk
	EyaUY/ExfpyqCkRwquY7kf3u//UZGcCA=; b=E2w0ov/OpoeALdj9/AORL6KicqO
	Xjj0RR1g2dWTA09mXMW/5gypmUh6v7JSLfS2iP+w2bGqMWEiMxzbpXYVt8/idCk3
	SC7myjvPKN1pmijmccEhgUA3b6ffb5JW+Gv0G9lKR9JDpUYygcl4i/WnrHKbOynF
	QUJmOnKeaAitD6pC4ndtmCwX4WI15bIU4vVFkGaOw/bOc7T+LFGgNsZ6tQFgFTdS
	Qtke5N1iA73FS73nMeFkXYcMKqePqy2W+a5JAkORuR4fweloIuhLBpaR0JpKU+C5
	q4nAQmvu8s/M5Tz7iAGIdjDcAb0i3aDiPDQlHEHa52rg1vl4l8WAntSTCWQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49u1h0u71g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-86df46fa013so753275385a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691387; x=1761296187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRPASGCwKLkEyaUY/ExfpyqCkRwquY7kf3u//UZGcCA=;
        b=pc05tWH3hlC+w6efbDioNbv2ZxZ4yjmUSnEvHwBijos/720rw2T1pfkXqDxCBq4M3L
         jKtzmKR4UucvlMFhyDNLjnuBuR1oaccSkmLLrAJMQUGPJ3rmy+fhDF6Sy81hHJp1o3fv
         +e1pQQErdZlo64BR7MRn2zAz2In7kMN1l7MCbl6ikwXXaMDu4gWJMQFrtXXt4n/EAvKc
         Cf5OGQWVB8Q4TkFAOu7uYLAC7TP1VMlEh49CaxRJFtAo0yxz48h8pPeEsKkUMOLAauz4
         fzodLHu3rfBJYdn+5DrIlHhlNtpNPZZtc1pytoof+TgXgpdKMxGSf9KzzTh1chr85DQx
         qNJw==
X-Forwarded-Encrypted: i=1; AJvYcCWdlBGJK3PFo+3W5umxAt7eStz9R8qJmvJdnZ9aqpi7h8iW3e8P5TDtwzD5LQE2dto1HdMuuol+9A2an9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6jb0moMJxbVwt0sQerYd5TMYpmHM03QsKV/bcYXnQ6428fhe
	GKvaa5Xek74NeYrXWkyVhDQv90WODP/B1wc9Qq5DUml4zCLl4oC+nhFwllwzegeE8cdW6tqncsE
	K3BG2sH3QDvImPqi0sMtl/e2ovFifyVbse9/WOxTEfxWhm5QR3CY4+n0xmYxG+0c0/lE=
X-Gm-Gg: ASbGncvUYC9eOkwdEHpdrJcARP/ds/DTmpduRiV2BTGXGsLqRbmZCj/oMnviVwjCL0j
	gXPRr+rkOdROU15JVFplRRkV1VYYIdmmP0LZBUSFoRdBSZr3NSYITIVa7oL9QoSHxzciJFqX6/l
	bln1j5j9fryRSEiT6NJK3/aN4aNTqqpmPip4npU9DXk0jW0v3tm8rYovA1Tw9KdbsLizFzJHDqc
	q5TXFURJ0BWMjN2VKDbsuJtmJrUyU4C0LBiA1PFvV3zqrYLZ6UUsdKZ6alfjx9GE64bEObKnD8+
	HgQj3qmzYd0LdcWmPXYmPTP4E+Q8+lSPeiADLKqZwrxbs0PweqS6EuOFUVEIOx9PRqVT2AWecO4
	nC4TCzxU/4Zwp
X-Received: by 2002:ac8:6292:0:b0:4e8:a307:a42b with SMTP id d75a77b69052e-4e8a307aab3mr7543581cf.4.1760691386919;
        Fri, 17 Oct 2025 01:56:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt2aeEBG2tuomsaj8skDLmIMc21It7yI43sXPDyV3iT1PdQ3O8uYgGBS9IoNvVISB3p2rJGQ==
X-Received: by 2002:ac8:6292:0:b0:4e8:a307:a42b with SMTP id d75a77b69052e-4e8a307aab3mr7543391cf.4.1760691386395;
        Fri, 17 Oct 2025 01:56:26 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444d919sm70764985e9.14.2025.10.17.01.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:56:25 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 04/12] ASoc: qcom: q6adm: Use automatic cleanup of kfree()
Date: Fri, 17 Oct 2025 09:52:59 +0100
Message-ID: <20251017085307.4325-5-srinivas.kandagatla@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=esXSD4pX c=1 sm=1 tr=0 ts=68f204bc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=tHfk9jisluZWoJm7kAAA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: knQrltX-wDQ_D_f6zjV4lU8v4NgArLGW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA5OSBTYWx0ZWRfX16HqWAKdJ76J
 Tzk5MJQEh3OoFZ215AB4NHxw3c5C9jO13HQEw0y9tGHT//EhGsDaVR9A3O2kInqbTBP6Y8Yuc9x
 3gHF4eKOWo8vPiceQ6C7kKkRUlfOpeAAMlkp8sxhefrPTkQwvxtQcWlx/Ag40vdaHNdUlsgilVW
 DzhisFxp7gUXueBxZUDlXF4DE7pK+p2kOh6APFSBieBptcfMwDBjJqGai4+0SYUdoLQ/8FmJtxK
 9Fg3qe8hbPND2Dbu0b2scG8JBk+ae0O/cm84dWLncNxhiAZUXS/BeCUPWVxwaciRmZUv9C6pG7W
 spegHL8hcu+sCMzQnf2h2ta2i+4VwujjSMLXC7+Z0NJCspmdecOJ6RnvtRPKfmeafpR7t4f5leF
 3WMVDhOWJcuPhEUUrJaqYiCe3e2p8Q==
X-Proofpoint-ORIG-GUID: knQrltX-wDQ_D_f6zjV4lU8v4NgArLGW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510160099

Its common pattern in q6dsp code to allocate temporary buffer
to send gpr/apr packets and free at the function exit.
Now this can be simplified via __free(kfree) mechanism.

No functional changes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6adm.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 1530e98df165..6477c7875c12 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -325,11 +325,8 @@ static int q6adm_device_open(struct q6adm *adm, struct q6copp *copp,
 	struct q6adm_cmd_device_open_v5 *open;
 	int afe_port = q6afe_get_port_id(port_id);
 	struct apr_pkt *pkt;
-	void *p;
-	int ret, pkt_size;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*open);
-	p = kzalloc(pkt_size, GFP_KERNEL);
+	int ret, pkt_size = APR_HDR_SIZE + sizeof(*open);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -354,14 +351,9 @@ static int q6adm_device_open(struct q6adm *adm, struct q6copp *copp,
 	ret = q6dsp_map_channels(&open->dev_channel_mapping[0],
 				 channel_mode);
 	if (ret)
-		goto err;
-
-	ret = q6adm_apr_send_copp_pkt(adm, copp, pkt,
-				      ADM_CMDRSP_DEVICE_OPEN_V5);
+		return ret;
 
-err:
-	kfree(pkt);
-	return ret;
+	return q6adm_apr_send_copp_pkt(adm, copp, pkt, ADM_CMDRSP_DEVICE_OPEN_V5);
 }
 
 /**
@@ -464,15 +456,12 @@ int q6adm_matrix_map(struct device *dev, int path,
 	struct q6adm_session_map_node_v5 *node;
 	struct apr_pkt *pkt;
 	uint16_t *copps_list;
-	int pkt_size, ret, i, copp_idx;
-	void *matrix_map;
-	struct q6copp *copp;
-
+	int ret, i, copp_idx;
 	/* Assumes port_ids have already been validated during adm_open */
-	pkt_size = (APR_HDR_SIZE + sizeof(*route) +  sizeof(*node) +
+	struct q6copp *copp;
+	int pkt_size = (APR_HDR_SIZE + sizeof(*route) +  sizeof(*node) +
 		    (sizeof(uint32_t) * payload_map.num_copps));
-
-	matrix_map = kzalloc(pkt_size, GFP_KERNEL);
+	void *matrix_map __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!matrix_map)
 		return -ENOMEM;
 
@@ -510,16 +499,13 @@ int q6adm_matrix_map(struct device *dev, int path,
 		if (port_idx < 0) {
 			dev_err(dev, "Invalid port_id %d\n",
 				payload_map.port_id[i]);
-			kfree(pkt);
 			return -EINVAL;
 		}
 		copp_idx = payload_map.copp_idx[i];
 
 		copp = q6adm_find_copp(adm, port_idx, copp_idx);
-		if (!copp) {
-			kfree(pkt);
+		if (!copp)
 			return -EINVAL;
-		}
 
 		copps_list[i] = copp->id;
 		kref_put(&copp->refcount, q6adm_free_copp);
@@ -552,7 +538,6 @@ int q6adm_matrix_map(struct device *dev, int path,
 
 fail_cmd:
 	mutex_unlock(&adm->lock);
-	kfree(pkt);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(q6adm_matrix_map);
-- 
2.51.0


