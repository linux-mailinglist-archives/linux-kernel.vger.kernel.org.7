Return-Path: <linux-kernel+bounces-866707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC82C0079E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD7F3A1E93
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D0730F7F3;
	Thu, 23 Oct 2025 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D2dLk21D"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7875930B512
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215179; cv=none; b=B3w+5DRNcSM0gkVUJRi/r+T78Ni9pb1arqEilBrmcrmc4JHtOVnXgFomqlKSTLn1HTG22vsf/HZviJVaIwpNPIbC4XITIUJ5s2I8SQxR8oSPvqtMsiLZyfXMy/o6A0ZiBJfWeTpWwNI7WdLHHDHPXG/4R/N6E4LYSVTDmczk3W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215179; c=relaxed/simple;
	bh=SejOUWbTAy/5ROULM2ELVlqM+FZ6nMOhFi6ugNEQavQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUze3jLJGfiKdvARx5LOdWCslSCDXCRtUN/woA/ugk/9ni3/4LAJy1an0J0dcFMpUM+eOtx1o4hpeMQZO0SCN7vl9e0KhhtFL3XTj5ChWyGVpH1dW9GaOAzWHR+NMoHVsaUR5ZLLkfVZMSb33g96y4yI8tgio+t+ThSyPOv/Td0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D2dLk21D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7Ec7q015926
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FajSm68u81z
	o6yJDj0yJMvUAWFriu/OwYH2XhH8JyXE=; b=D2dLk21D+aPzeguIg6XY3m9IK+x
	vNKSrzGTtSzyNDixO9MQPNzn9eQr4EOPkOMJTYKcSVHBzyYi/Mw1QlOprTyAYB4L
	EAoZVidPNo8NvmCdAyu81ha9+g1GCd80AiTCJg2P4PhEiDvAHWkxZOUikzaS6cxt
	cdoi9GDSlDrQTT60zYx9g9DfHuEpc4hazA5wFhhHoT6O3IDyuZj2D1NdUwXNFVos
	n8Vc546wV4VhKUm5h87Xgu96Gq8wTmTwbRD6QI2ISEaJ6oVV7vNPle1PiSUYzswU
	CJ1xTP+K85TjZQnwIk3g1IOfdkClPCzu827lapjBlCf1XICqIxQO8IVuFDg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsdmvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-89087f3817cso64821085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215174; x=1761819974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FajSm68u81zo6yJDj0yJMvUAWFriu/OwYH2XhH8JyXE=;
        b=Wvzve7QKwzH+jtIwz1/QsV2jAyXNIhz4WInevgJhUw9ZmoqK+IYqxiWbaN/u3w0Kur
         IEDLGZOq+fjpAtWkUa8zgpOjw38sTI05VKGy0jWF0rBnU4oGb7wv8geQEtp01priiKt/
         zZRt4+B9kdZPCBSHe5A6cy5doTMzD8onFglP50gwyH7uXPKdhO4n9uohSIIptKdykPPQ
         C+VRFixpOOiIH3BhbFfJEKtvacEUleZg2eFtihhrSY4RUrYjLBTd9/WJwgXbP+ACZX6D
         rYfmsmW1k8a9PKBezI3HLcMwdIRYYzvwjmRVST6cYE0dr3Y60cSZHMsnPzTmAQMV4r00
         dJbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg3rgWUybWSaEq/LijMjGTNippBDakn1Y8yNQrXCXqhz35lW+S8g1alazuj2/gkNhJqguGenRu5BxFQX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkDMbq997jwVOTIHlXtSKKyGmMUvLnYUKq1sbMhFxywDHWHijt
	PSGAC3XaeRxR9Od0vCkcXH4MoSg/P26IuIPBouu4KeUoQzvQ117k7sW5Q00tYuQqu4TXXq9B35J
	4KeYTqeufRd1oxtbvJg6/nyT8DtVAq9hRJ5JlAdbTDWD66y5k/0hK2GYdT0w/zRjmB5M=
X-Gm-Gg: ASbGncs2DIlh2qUBAMGjdnNFEChXBf3wh9kwEv7tC93sW2bd+U8So03dFthM+ocgaRM
	qqQTXbLKoHFB7oZxSeCeEf06qJ7oznbnxLuu9vZ+zcABvX9NmeBCg3uiy84NCXdPcBG79CHxXct
	1Pm1+Jq6o9fePhr8dbQst0mmr9HfuxYgUrPZ6d5izfLSutBNbhaCJNVKlWujSU1hKu8RvkjS6Tc
	R9/6kY9JXgl3jjIPyPN+7kFdxCFkhGDmj1KOKGJwKFd8sG9uqPuSQ5I5diwjLcG6iOH1Nz5nK4m
	3dDyAgrYroasiocQoyCleKmw4wJ842nyyKr77IJ+QjZgJDHuHWuN0p/DIgYk9A4T6c9iva6rMbk
	xVHVAGS0BlKVM
X-Received: by 2002:a05:622a:1114:b0:4e8:aa11:586a with SMTP id d75a77b69052e-4e8aa115bbfmr248237581cf.53.1761215174253;
        Thu, 23 Oct 2025 03:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLF+Hw8CW8MbahSfA8tACDLOuC6rzyi9L5cROc7gcuF/UeO13IMGr98DKx00AXgM1vVR7AVA==
X-Received: by 2002:a05:622a:1114:b0:4e8:aa11:586a with SMTP id d75a77b69052e-4e8aa115bbfmr248237361cf.53.1761215173810;
        Thu, 23 Oct 2025 03:26:13 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:26:13 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 15/20] ASoc: qcom: q6prm: Use automatic cleanup of kfree()
Date: Thu, 23 Oct 2025 11:24:39 +0100
Message-ID: <20251023102444.88158-16-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX4Pc0xwLLpGBT
 EES1+bfNllVXZjO6zxgZNs51CnH6x4ZCAlZstc8XccccpVG75GNHdPJConhz/0oRUbmXiUlBLdx
 aVnBE1HRt0Op8vwz8HoPhR2+zx+e0ks4+EdZfb+YG+IWLsFHIKsoH6hg0oDg8AUT4l45PfrUe6F
 kb7RLsmGhCf1nikY5DhSsc+sZhQbEUAEILv2LHwMCB9ovNJ/VugqJnCVcK/c8+vAALsavRWKNlX
 TtBXuxejMtOQMrKwWvPP5YaCROPE0aN7Hv01GixLyoLfQ0NoGq+XCGRsiP9laOk54Kbl1A7H2g/
 9xV/2YRsKjtlQ/HFRBF6DTrmcbn1uYTIp6FoDKteGJfN40gwdQQ2B7rrAArzwomq+cJ7oS7dzP9
 F9/S1wdgSN3ArB4gX6M/Tetmctu+Vw==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68fa02c7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=XDFA_cjcnCjOe_gdXw4A:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: N6SlgK0Wv5CHlztyFncHuoGWoSzs2g9K
X-Proofpoint-ORIG-GUID: N6SlgK0Wv5CHlztyFncHuoGWoSzs2g9K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

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


