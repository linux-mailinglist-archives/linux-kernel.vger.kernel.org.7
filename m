Return-Path: <linux-kernel+bounces-857637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ED2BE750E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AB0F35AC32
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA882D73B2;
	Fri, 17 Oct 2025 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pnZsnm0+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8B2D6621
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691395; cv=none; b=NUTYL7Opqn8c+Eiv1/bNk0tr+fiUBA1J9upYnr9nDxVQuYuvVJ706wHAE6X8rFr0hqkzIHZbnuBl2Ejh48jQNI0g15OVvjfow821zg8SM6K2za+PKylckl4N2XKBeBlUnJlIkn+jOLANbx0DrbLGD1NtizyKQXicMHlCGaVY7Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691395; c=relaxed/simple;
	bh=SejOUWbTAy/5ROULM2ELVlqM+FZ6nMOhFi6ugNEQavQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ig9wAxLPRnOvwCRlDrCOdgC0s8gKSY0kRoSn6DXJhjiMPhR02lvNHnB1TDDQ0bcvR1KSXQwUxzvvcLQO7E8IMJ5D+sIZEPHasdx3Nkf9dOYsSvmxKJCuJmSV/HI9P/hHaP20itoOmTWQNWBNa4EfaWfm9AdqfOCfKU9pVRRQ0uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pnZsnm0+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H86Z4K020220
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FajSm68u81z
	o6yJDj0yJMvUAWFriu/OwYH2XhH8JyXE=; b=pnZsnm0+Hb9oR1wbNi8+epvF73q
	OKaznn8WpO/oRbhykSLFLstqhHiO3x2ZwjOa7ZdSIlIygv8mXovtCDE/ziu1uF9R
	rTzteedER6JV0Pbc3uFee0uvk8SDWaKhxtmQn+BGM1nvBSoKsPMDyM6o9DwaPdqr
	ggWcZzojk5J65TQccRFEKQbAMHA/JeZfNoOQ/wTP2g7Nph/J+7B8V5LveME1vXdc
	db/8dKg6VDn6JzfhdV5W1i47GpUffrB5yTCz1UjonGjlnVAA7lxkaX2yap7IokGT
	S4ZW74LFaMR/s3oMrVA0q4q+3keU2KujX5kyG1uq+fCneU7pQzt5fmSC72A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49tqvpmyg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-84a3a7ac082so552293785a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691392; x=1761296192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FajSm68u81zo6yJDj0yJMvUAWFriu/OwYH2XhH8JyXE=;
        b=i9+OebDX2brzejiplyzg82sJ4U+8liMSAIp16crBLqCqnMtkS/8sOEYUboB5NevJPX
         +dBdHBy5KjFfvE8ikhtMqSOT5joOLmyNVQQCHNFKWkdv1QqpVYWqZtpFWdjxKbJZ4aMW
         NNuyznoWmmSE8w2fWcmqbSFwgn1oEouRDrKmSN9iE7nUwgnmOOUfJCJXefcN3jQBLhGB
         ltdTfsuI0lJc1U+6UiBdGgom3VGY1j8HN5wfWsPSEXyagJzbwZRFg4n+ANh9C+Chp8Ku
         gmNXu+Ov0LgaTY/7oRib65By1mD7BnMMdS90Bg/d/QzYwd20VcKTIZjT3YtzzZQlDfcV
         4gow==
X-Forwarded-Encrypted: i=1; AJvYcCV41SrlDOfNCpS+ftrAcHsm3auUoC1niJAr2fNQC7FxmEgdDS+GanGrzccFVX0E8+DB3W44pmJ8jW+3Tow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy197n7KrnTBTyCz43T2MKurFrGQgHGMDh4BMlzpCd8U1qviOE6
	XUUTVQ+C9Ga6J88Wj2RBzCOqtAQUjJxeJwSpF71Fe2/uP3e7RTFNOYAclTvZb9ZIC18ZUIz3QB7
	o8ch8KAQzVi23r2/4bK4jfS84HER6IW+6khWky1qG8P/0zPAX3NBBMguJFUUz9WexKN0=
X-Gm-Gg: ASbGncvHq5apM8I6FKIykC1pxCSFinTT2cMJGQ5YJgDyaS7tVHPgbn6+iSWJmwmRLKC
	VD7UPHGfkyndw9/MFP7P7wIIACpsVUlhS/KVNBxABq2At+w6bmGcuvmkH73szTffqPJnzy8GBO4
	35PjUJoW2uhA4x3t8tdsazMVY2i6cKfYaxYdjnHLR7I5M56zK3vCtVZJe0Sv9Gwv4+AxkP+xXqS
	vVK8rLMFXColuNEclrHWCGMpv8A8TfY06/TOP2eH/r85iTiRYYAYgpgWeY7f8t71tj06xM3QlSS
	sI4qXfxGJJbyG0FS/ppVM9JKC4BmolS9xEyXmTNuX9a+P7odOu8iTSTfda6OpbbwtkYpNaaiMGF
	as9rMJcEKBti1
X-Received: by 2002:a05:622a:587:b0:4e6:ed89:c014 with SMTP id d75a77b69052e-4e89d3a24c9mr33928011cf.55.1760691392407;
        Fri, 17 Oct 2025 01:56:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpa5jj8b7IDxg5bOjcWoHZU0OyEot5cPPW8i+SaTkYNxJ8GuekLCvVvjpxwIH4XJzYIX1FWA==
X-Received: by 2002:a05:622a:587:b0:4e6:ed89:c014 with SMTP id d75a77b69052e-4e89d3a24c9mr33927861cf.55.1760691391958;
        Fri, 17 Oct 2025 01:56:31 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444d919sm70764985e9.14.2025.10.17.01.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:56:31 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 07/12] ASoc: qcom: q6prm: Use automatic cleanup of kfree()
Date: Fri, 17 Oct 2025 09:53:02 +0100
Message-ID: <20251017085307.4325-8-srinivas.kandagatla@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=aPD9aL9m c=1 sm=1 tr=0 ts=68f204c1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=XDFA_cjcnCjOe_gdXw4A:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAxNyBTYWx0ZWRfXzoyezrXaJf7D
 uvgQFXJobeBdj9oxHrXC6E24TsARqcWu6FMRZ45UamFbUOuKy4SuDBQIqkfU5ZP0kezV92EnR1T
 U8ah2mtOSk1smEryOkClA5mdYpGOFw3etgWUpcK6V4fx/aA0mDAzvKoXFXNOCmwvhyki3GCmVzr
 mimGUulgGkTpf/4SD+UsnRtacDAcp+cJCdw9tS4crYZdC4eg75V0qarzNhiDb8omGWUvPxy9f4Y
 uMccADoKXMaKHL6xZ4lQpjgJGsfkxH3xRCB/wuMOO15QijiTPxUNQOIro7aNzkzww+xle8+Ud+W
 +ba90w3JKsmCwAQlZzOSObfXCFY2UPSct60/P3Giv+R3lCN9c8WTFZQA9jCVUZ4vRGwDL1TVIs4
 h3gSlyLGj00NanlVKk22MpCMR8GXSQ==
X-Proofpoint-ORIG-GUID: siAftytBCXLIvShpR5cY5S3hblfgBxmp
X-Proofpoint-GUID: siAftytBCXLIvShpR5cY5S3hblfgBxmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160017

Its common pattern in q6dsp code to allocate temporary buffer
to send gpr/apr packets and free at the function exit.
Now this can be simplified via __free(kfree) mechanism.

No functional changes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6prm.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6prm.c b/sound/soc/qcom/qdsp6/q6prm.c
index 81554d202658..0b8fad0bc832 100644
--- a/sound/soc/qcom/qdsp6/q6prm.c
+++ b/sound/soc/qcom/qdsp6/q6prm.c
@@ -62,8 +62,7 @@ static int q6prm_set_hw_core_req(struct device *dev, uint32_t hw_block_id, bool
 	struct prm_cmd_request_hw_core *req;
 	gpr_device_t *gdev = prm->gdev;
 	uint32_t opcode, rsp_opcode;
-	struct gpr_pkt *pkt;
-	int rc;
+	struct gpr_pkt *pkt __free(kfree) = NULL;
 
 	if (enable) {
 		opcode = PRM_CMD_REQUEST_HW_RSC;
@@ -88,11 +87,7 @@ static int q6prm_set_hw_core_req(struct device *dev, uint32_t hw_block_id, bool
 
 	req->hw_clk_id = hw_block_id;
 
-	rc = q6prm_send_cmd_sync(prm, pkt, rsp_opcode);
-
-	kfree(pkt);
-
-	return rc;
+	return q6prm_send_cmd_sync(prm, pkt, rsp_opcode);
 }
 
 int q6prm_vote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
@@ -116,8 +111,7 @@ static int q6prm_request_lpass_clock(struct device *dev, int clk_id, int clk_att
 	struct apm_module_param_data *param_data;
 	struct prm_cmd_request_rsc *req;
 	gpr_device_t *gdev = prm->gdev;
-	struct gpr_pkt *pkt;
-	int rc;
+	struct gpr_pkt *pkt __free(kfree) = NULL;
 
 	pkt = audioreach_alloc_cmd_pkt(sizeof(*req), PRM_CMD_REQUEST_HW_RSC, 0, gdev->svc.id,
 				       GPR_PRM_MODULE_IID);
@@ -139,11 +133,7 @@ static int q6prm_request_lpass_clock(struct device *dev, int clk_id, int clk_att
 	req->clock_id.clock_attri = clk_attr;
 	req->clock_id.clock_root = clk_root;
 
-	rc = q6prm_send_cmd_sync(prm, pkt, PRM_CMD_RSP_REQUEST_HW_RSC);
-
-	kfree(pkt);
-
-	return rc;
+	return q6prm_send_cmd_sync(prm, pkt, PRM_CMD_RSP_REQUEST_HW_RSC);
 }
 
 static int q6prm_release_lpass_clock(struct device *dev, int clk_id, int clk_attr, int clk_root,
@@ -153,8 +143,7 @@ static int q6prm_release_lpass_clock(struct device *dev, int clk_id, int clk_att
 	struct apm_module_param_data *param_data;
 	struct prm_cmd_release_rsc *rel;
 	gpr_device_t *gdev = prm->gdev;
-	struct gpr_pkt *pkt;
-	int rc;
+	struct gpr_pkt *pkt __free(kfree) = NULL;
 
 	pkt = audioreach_alloc_cmd_pkt(sizeof(*rel), PRM_CMD_RELEASE_HW_RSC, 0, gdev->svc.id,
 				       GPR_PRM_MODULE_IID);
@@ -173,11 +162,7 @@ static int q6prm_release_lpass_clock(struct device *dev, int clk_id, int clk_att
 	rel->num_clk_id = 1;
 	rel->clock_id.clock_id = clk_id;
 
-	rc = q6prm_send_cmd_sync(prm, pkt, PRM_CMD_RSP_RELEASE_HW_RSC);
-
-	kfree(pkt);
-
-	return rc;
+	return q6prm_send_cmd_sync(prm, pkt, PRM_CMD_RSP_RELEASE_HW_RSC);
 }
 
 int q6prm_set_lpass_clock(struct device *dev, int clk_id, int clk_attr, int clk_root,
-- 
2.51.0


