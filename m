Return-Path: <linux-kernel+bounces-866704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ED0C007AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C871B4FC990
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760D830E859;
	Thu, 23 Oct 2025 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDO9t2yh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC5A30DED8
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215176; cv=none; b=H7okuJ864lnDpX+9rMyJZnaL3/CeNarIFKvnHbOI8aFcQt+7mOWa127Iy+7/7F3gBlI2duysOYDVTPdZ2dBowlAvvxMkvhEa/O7RvQQ4MTgDVvkV3eMfDPFFT83hrZ39Qx9iJYLYSJ/8Vpn1nBn9Qw5cA/luzodEiEtEhfaghXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215176; c=relaxed/simple;
	bh=yBNFWfi7nb0NEEgHL4lbgPtCESQBjN8cUW0xWV+hUrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqcKKBDtY97ZoN+DpfCtrj9NQSBzeUzlDziyiiqq6xfZHmIlkC8W2V7f88b3+QEZKEA/h1GTvuyrhTyXZnYVetg/13Iv8ZBCx8ZjbfF5OrU71xdtF5ighwS+VP/bSNADWYp2WK8x/ueiUB6YciUoQpKyClfvhyXORxEuGs+J+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dDO9t2yh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N71SZu018600
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nDvlp40m+Ni
	viZ7Prwo/9bXT1BrtIsyNq1nV9QUwJU8=; b=dDO9t2yhoTDMVFCW+mn8OSfyqXp
	xIdNp9640vYTcXOYyx6ab9I/NSNxUQP8hUsaOQBSQGOn1rz9tXoQB2Z+0L4olJez
	yTZmCn9cJkbBn5zS+wWOUHlInJ4erMbnP5R1Gf5rZ/70FT83UuSageEkyT7rXgj5
	yfZm2GB4P8HpmAMAm5mXB2exFnPaH/eUxeTuQquyBJcil3KwBOz8c8fRT/IBeksG
	CRK6j/wK+XkZzDNoKBcjgZHVWSz7n8xCT9fYPH73kyBD7pDUmnjEfNESlNDpgNVt
	9F2eEczoYsrZjrDap/oHK1yWlYaeH3gTs6LuACxIu5GDRvCq8oQTxOvvfqg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pr8km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8916e8d4aso31565361cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215172; x=1761819972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDvlp40m+NiviZ7Prwo/9bXT1BrtIsyNq1nV9QUwJU8=;
        b=I7n9giHdTg9G1SpRWc6rQp+Ko84sYH1EgRzjkX9E1+7o8RvL2eMqoEmx9snsj7DwDf
         dLUmnQXz1cvEXX1W6yhnbpO4y0UGlvuInr8SVVeZY554XctfgevhpZ9oFGOcXVwDlfVI
         GWLIRFYXJBHWqfhEEpPzIVSSyITSowCc3F+U5zxDSKi0NbWiRk85WiQeXuP/O28smdNC
         zd5c29urTYQnEscub/VC2C+jIbdgw06IiirwN1v5kC4hZEe2yIBYxW2sw3r4506jxOQF
         /Jn6KOAqdS+SrTUtIKgF04x8piPFeEcZC0tjO8Z04id97oC9u7IMH0p6MDFvszgYidrq
         BDaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk3Zcjr9SQBgYuKuH8cUfr9LOOIl2ifsD2JuZj/C3y7ulpj1mr+aVdF+BqhuZXIZhsZhHeXQBJbSp4SQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgkVuexcgG+Z3VrQDnaJFK73Fjpegw+G3qAWGOmuBMB5mrcr4Q
	hAIOLtRm+ycJGBJ5My+3WOghSDF27baTCPnpVJjXB/E1zGN24QAQ0WOTyboY7wHdUF4bOcakETr
	AQJ4U3h5Ky/w1wpPUnIDtZi7kJvqLG6UJavE1JZLYCi7eQFdO0clTM9S4HOBh7ns/lIc=
X-Gm-Gg: ASbGncslMbECB0q99MDcrid8/hTWy6QfuOK0J3lUVsS6YgBZo2ddtX8CD5UJCOrh95x
	H7VTdwVSs9Ol60oUWEkRdgySlo/d2t6Df65dY52FZepJR7qDiCvWu3wyFu8Xx0u0KBFdxGQUE/3
	2RjET7PxGaqcI9fV2PNSUnBpTbec85VBogcr7cK/yrX+4WjGD3iwuxkxjCKSVzD+8Q+grqtIEJy
	a2K7ntknM1DeSz6+mqOXTV8z59OpgQpQxxLkJhTjTls0bzSgRUUOK7mr0u0BpJpSP5jtTPJ3z23
	WcbzQUg2UzhABsfl8buHLJ51Z5hgwf5NpvSDJWyIw1oQFG5ZUueuoLyS1b0+bB75I7qqyD8FLO2
	Bq/Rj+1gmbjNv
X-Received: by 2002:a05:622a:138b:b0:4e6:f8b8:50f7 with SMTP id d75a77b69052e-4e89d33642bmr329289561cf.44.1761215171854;
        Thu, 23 Oct 2025 03:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO3GrQVUuEv9NnqplDFxqKgL+KC3Vx8puoDERmcPhpNTD+7RpwHEoz9azTtHB75fZgXP5pTQ==
X-Received: by 2002:a05:622a:138b:b0:4e6:f8b8:50f7 with SMTP id d75a77b69052e-4e89d33642bmr329289291cf.44.1761215171349;
        Thu, 23 Oct 2025 03:26:11 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:26:10 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 13/20] ASoc: qcom: q6afe: Use automatic cleanup of kfree()
Date: Thu, 23 Oct 2025 11:24:37 +0100
Message-ID: <20251023102444.88158-14-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfXznFfrwHWfv/L
 /vX6F7JIM4wa3ry4aGhym+epz8jD+JPPIzjwX2PShZG2U0Zhbd67lPUX/gwo0UqsuwQCLzD3lTo
 Z92ClRAMPiC2VVAocNXfzF5q0I75LG1WTXbEB2knlXwKAufB+dmS02GmUP9DCYcYFLVtwjibEjJ
 2juUvv8g6pW6CtpMBnSUT8KXq18/wWmEC8fWNprhz45Yr079+JYGoGzQKxrts9JyiG6qWOEeIsH
 00LElm6QmxobbYeTqcbLWcV8FbGgFakZadxEZdqACXX442x3yR/c+OMqultsBkkm5v0Zr/FCd2a
 S7TK5Ag2GPF5gykYrqD4jdExquIuoToXmVw05i534jDcPX0zRc7FAGW4rjzucN3hNl2jc+filRB
 8/E0ek09EX69l65i2P/aOnhy4euIeA==
X-Proofpoint-GUID: CCntX1xfaP2NVvZWhD2KW-tCBaJqLXPk
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68fa02c4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=92AZDs2nESXm7HPk3LYA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: CCntX1xfaP2NVvZWhD2KW-tCBaJqLXPk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

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


