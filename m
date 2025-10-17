Return-Path: <linux-kernel+bounces-857632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2531BBE74F6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59526189D4AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7FF2D249B;
	Fri, 17 Oct 2025 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mcFTw8Sg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342F2BDC3B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691386; cv=none; b=HdgXCNfGS1KGbG07GzLstfoBtvyq6/u9czN7gv+QCmelI/zCgfr2aOj1yxGRueU/HyfYepy6iPd05qGEj4316cyxTRg9tJTJMWO+kaiyY15ormm7GYIIMVzbYszIwiRPkgBSFv3EO0KuPowKnm9aSBlf6ddGZ98E0kbiistzMLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691386; c=relaxed/simple;
	bh=a6vR3cZrsa8eEPprG6ADmXlyyk7ZVWqf4VY8FOiCsl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VM07NDlPh5hEtjmbqYWHh+C4s90gdv9x+AvF0vsiUCaKQnebnu8+PEfuMSOkP3W7OoOml1RLbPs6OGJVdO2hHa/iwUlc3PCPYApeIvSUotXOP1HisXmWUQysjWsxW1HkJffn8gJz6mj1jYB0XlcfogLjMhixKOc2q/kthEmh3Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mcFTw8Sg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7ctS1006536
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uJLxaLL+Ort
	xu6N92+2HUswlxaL+eZtDPgykkLQ+IQI=; b=mcFTw8SgbydUEAP+OHcucuJo7S8
	gfzn+ouQ2X9GjeKbGSbsZ0Xalt1lrEhKkLbqxYcfu8IXkRKeycXKdLdcnHB0MhIv
	4WGCZbgdoCokMuOx4Xzyycu3Qh9wb82XFe8PvDWoIuGFO/9yk38KyTpj9EqmN5yM
	4P90jlY+XLwQOMhW7d6+1ADr2R/7Gp7dlvO4wsUmsQoUI8zYE4QsEtbyphs+vpwR
	mjTsuKhBO4jnecvMDjWj4zCDNSoarpYRtttLcRp+Gi5o/9LGGO3dGdYMwL2SYbk/
	NKUX069vyZu4ZFTeGyaduldMBQwPgjeXbDvmQTot0sW6HfL2jbwSnqOqDXQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff13h34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:24 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8741223accfso64022546d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691384; x=1761296184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJLxaLL+Ortxu6N92+2HUswlxaL+eZtDPgykkLQ+IQI=;
        b=hI11r2b/0bJ+xdoJM7HFGsQrPy2Pizd2JR2/NjEMm5F1hxw6l4KKU/NPvZOghk8nk4
         YEsNwbdgunMwLG6aYNW1fNYK7PW28XXT6gVATpFmkG+Ix154p8fPY16NULo0dbny0ZYT
         TTLreK9xWubwLo/QKBgwvX9fdkEi98FP9r9JP0V+aW2WhZe2AVPn5J2udjxzRTgN7c0G
         iACFKON39tNnyvPyXzyzr5GMCS3NckQbZ4+FP+M5L9ny33mnPCPGao+3o+ZC5y4+r9qR
         ZyEHWRFbIlMchYVhNxXpRnN1zvFCIUmN4BIB+33NKmQaXSGSn55pCQZUDbcl28S4r5hP
         fuug==
X-Forwarded-Encrypted: i=1; AJvYcCWhWydcdkG4uXz30n8ukcvTZ3TsTvlE6rotx2mQdyvBsNebbK9dbRgKEC+/KNNMKFov4Ap/ZvRtwvydSok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLaMEqRr5qYuSTgG5gCZplqrn2t6qId4xIzugYcVKgMOHmfVSn
	uhoEy5VnHOSGWpgp+k/JAUhGKEhTXMq+Kx5hsU1uZGxVvU2AMXGHa2iBrHPDBWAwzYv8gPEXCmm
	gPphLIg7IQbEgW7TjPJChMrk6NTFE7FlzM9j8d7Kw2rxt4q/tsF1pvylSwFOghclQeMM=
X-Gm-Gg: ASbGnct6JY+vueCSjRExaPQ6Vv6kiM7a9rO0fMC9aPnWhpjWI933pvtbhZswmQsWr+r
	LSTHpKxBYcZ/XA24UZqQtE1wLVBNGPhdqsi9Jd1NbbmhhNez79KD5adBDrfo/ZSbS5iQ7iD5JSz
	NbcSMIgHYBuCrdd70k74QKdM36JiP7qWFgLbgiffjrxTN4jZIyAepUT1QoSkB5JSXXH4uklq2fY
	BntyUSu2NqiY+0ruSKP+dUsTQyXb9FyEnz4gWF/M6utu38/KB8CBzVwyT7LUrQ9pnAA2+YqQSNQ
	ARVBAgGWqJxXXPT04x593YWsXTFpsFOqInof5n64GEpbgEne0ANidoMmD5QAawS0IQ2fMvQ5+0u
	y+R6H6VW4TiFz
X-Received: by 2002:a05:622a:244:b0:4e8:846d:a980 with SMTP id d75a77b69052e-4e89d2a387cmr37124571cf.33.1760691383667;
        Fri, 17 Oct 2025 01:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3eUE2elVtUpnZhtWXHz+4MlB+o7mcQ28YYahGYwUYCKw2V2KCoMwky9rkXFdFcShMWPjcVQ==
X-Received: by 2002:a05:622a:244:b0:4e8:846d:a980 with SMTP id d75a77b69052e-4e89d2a387cmr37124471cf.33.1760691383258;
        Fri, 17 Oct 2025 01:56:23 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444d919sm70764985e9.14.2025.10.17.01.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:56:22 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 02/12] ASoc: qcom: audioreach: remove unused variables
Date: Fri, 17 Oct 2025 09:52:57 +0100
Message-ID: <20251017085307.4325-3-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXwi/DXGnAroX3
 jZl2EAIZVQZWgEPkNGQ5iyqfFxiGz1lMlQIU99qrPP9vNNJFD4vw5Cf0MR9OaO0s3Htc0okgf6J
 kXBdQ65DaG3TEJHR+3Wxedyyx7mUCfPvyNGj6u2czT8vnb2eMPlfeSRShwaffJp8kVaN/4OB2E4
 dId1AuXVYLKz8MVQeJM+0PgUZzdeZ1dTNGbCkuXV9iv4n0No8a4cY+rT+gAzLyaNFv0lw7I1sjE
 zCQ6YYTeg6LaZWcvLiYxlh4+GQp2VY40TI+1fnDD4+29BTB93a9aSivO4jnQzz9iiTg8oOtg+pZ
 Dp6bKG2KKLE4EgjoN3/2mKLxO/2Twc6gTDs6oevDg==
X-Proofpoint-GUID: efEyAt_ID5YzJC3qPYolcv4pheky5gfz
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68f204b9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=s8dh861zfECFqLDNse4A:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: efEyAt_ID5YzJC3qPYolcv4pheky5gfz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

remove unused variables in some of the audioreach functions.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/audioreach.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 2365424a9b42..0456d4689034 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -612,7 +612,7 @@ static int audioreach_display_port_set_media_format(struct q6apm_graph *graph,
 	struct apm_module_frame_size_factor_cfg *fs_cfg;
 	struct apm_module_param_data *param_data;
 	struct apm_module_hw_ep_mf_cfg *hw_cfg;
-	int ic_sz, ep_sz, fs_sz, dl_sz;
+	int ic_sz, ep_sz, fs_sz;
 	int rc, payload_size;
 	struct gpr_pkt *pkt;
 	void *p;
@@ -620,9 +620,8 @@ static int audioreach_display_port_set_media_format(struct q6apm_graph *graph,
 	ic_sz = APM_DP_INTF_CFG_PSIZE;
 	ep_sz = APM_HW_EP_CFG_PSIZE;
 	fs_sz = APM_FS_CFG_PSIZE;
-	dl_sz = 0;
 
-	payload_size = ic_sz + ep_sz + fs_sz + dl_sz;
+	payload_size = ic_sz + ep_sz + fs_sz;
 
 	pkt = audioreach_alloc_apm_cmd_pkt(payload_size, APM_CMD_SET_CFG, 0);
 	if (IS_ERR(pkt))
@@ -680,7 +679,7 @@ static int audioreach_codec_dma_set_media_format(struct q6apm_graph *graph,
 	struct apm_module_hw_ep_power_mode_cfg *pm_cfg;
 	struct apm_module_param_data *param_data;
 	struct apm_module_hw_ep_mf_cfg *hw_cfg;
-	int ic_sz, ep_sz, fs_sz, pm_sz, dl_sz;
+	int ic_sz, ep_sz, fs_sz, pm_sz;
 	int rc, payload_size;
 	struct gpr_pkt *pkt;
 	void *p;
@@ -689,9 +688,8 @@ static int audioreach_codec_dma_set_media_format(struct q6apm_graph *graph,
 	ep_sz = APM_HW_EP_CFG_PSIZE;
 	fs_sz = APM_FS_CFG_PSIZE;
 	pm_sz = APM_HW_EP_PMODE_CFG_PSIZE;
-	dl_sz = 0;
 
-	payload_size = ic_sz + ep_sz + fs_sz + pm_sz + dl_sz;
+	payload_size = ic_sz + ep_sz + fs_sz + pm_sz;
 
 	pkt = audioreach_alloc_apm_cmd_pkt(payload_size, APM_CMD_SET_CFG, 0);
 	if (IS_ERR(pkt))
-- 
2.51.0


