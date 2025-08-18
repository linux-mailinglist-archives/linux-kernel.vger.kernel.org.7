Return-Path: <linux-kernel+bounces-773539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2026BB2A19B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B99F189A756
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5890131CA53;
	Mon, 18 Aug 2025 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PxNJpsbS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94F931AF2D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519774; cv=none; b=AwWF4vTgi+ZGdwFX8bWNXVxn6JNvE7miAe4E4tRmOfmSj8Psi01RlLDY5/EHQCd+D9pzqZKL7KjWf+hZJaNkCghBgPxkS+piElrhDstNWLB5lQMq7h5sjugxG2kbUGobOaCFTLmWl2UxzKsTboWoIeDYi9z2+XAwQ3Rv2PHperk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519774; c=relaxed/simple;
	bh=hpGzTc0IFp4kxDa7L0DoR4eGGYq0Ed7d5aUx9Md288w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1VebOushabQgZsSDTl+Umqknze0zOVAXqyx9Cqdi2tkkOiCKqnXWvWzRpnqW997LcBhe7twHlAMsKz7R5tiitljWcI8ORtn05/vIRVaqu8C3XRpz+KDN4Ep3bEnYJU8rOcydCSIAw6qcn9tk6XXp4o05Q9qE3MuYPFgmgWNKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PxNJpsbS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7qfdL011391
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wM721AZ4mzS
	KZrE5a5VcC0lVzer8Uu47S0uTwNMIfYE=; b=PxNJpsbSIsKu+TCC/hGGd1MwiaQ
	Ie/0O/X+P4g/vaG2hwzJN3w4LwhOoSZDjcW8T938XkePZl9y7vY6a1P3ec+ynfr4
	zKmj+W7XhyUnb+a1Rtwmwj71tI7sBi5RyG+oyCtq/hgnosh7vRUBnFaKBtl6wlJd
	pTvIQ/JH1L2t8idAtPP2FiDTwYjHH25V2nspNck+xfjEOVNS9kGU7SMq2DOIhuan
	IfWXjsWTKc4ugKN/0ZvEq7jDox/nj16tYoctIvmbqDZNqcDMj3DCXVYXB8uN0uBc
	wVkwPrR4aZpI+azESe8bmVkpW/5ti3dfzRdDkrWfOjtGOR9u66AEnwPUGlg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk5mchdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:52 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a92827a70so93718036d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519771; x=1756124571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wM721AZ4mzSKZrE5a5VcC0lVzer8Uu47S0uTwNMIfYE=;
        b=HCBFpiRbHiyPUOvb7pzW4OnmPsrrhB4v/k7/zfvugwN6aLfD9aOwpNigADfDZ9CQqL
         dHOGnJgYDdiozIpEU/4UTzmA+HEdOWrNmQm/GxdxAgtRErdPQDnJIowQypbg6Rq5sFU1
         CyG2gw63fMiOKAIdZfLt6ohRvid3WVR0tZ6c2BXtdYsp/c0PzqMU3yN4QdkKibiKzZii
         PiHap5Dqyv9uIMsE27IymQcOwch8lgw63sHz8R4e8dxJ+p4fzE7LP5sWHA6XEdAQUZgI
         HpRaVOA6YH49g/RAzbJIo+CiNSupP1cI5+e4qsYeYI65J+3s9OEjbWqjw2aASdHgr+dU
         bsRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZEzkxoBU9QJgEVp0vldXoodmY9dFwogfDe57bm4u9yc0ClicMLdWSU1wuXSKlklAbAeDyrz7QrRGSako=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqHedS+4Ay2ABJUz+zgn2mERcNiUkMJ0GQgTkJ49aful8VE/4K
	/cJiN3T47Uf3dH6Kpc4f3+XjKWILF+IlCp+L0c+dDQoBftZdL7ISRIoAAtE2Q2PTMjuIppB+VHh
	hOBj9aKdXtLDXq0g9lDXSDu/2dP+ZCM/Ot2NQ0ofxdn7gUE6mJC/JAoUyGrCzSrZiEf4=
X-Gm-Gg: ASbGncsFZ1eS41i0CExOUOUcw99GXu8vmDAVXCQK4tZnnwZ224E72BQ+irDlCG7R1dm
	MQXBWZbOabzTfFZ2663UbgxKl2I7rsKDfIpQW4HYllh+Gh8OPA0JBHzBt1CIZs4uCDrOTEYXpld
	jLarTnrwFpRR00Eau+d7yMrQ+VKZPDkZnvEt3c51pqxEv4QidDq1zgNLyebV0hkr9JUxRtO1EKL
	+yY66NkPYpX3l/LRxvhjbzHbAMsmb1SqkOYliIjwmRyICF0taDcZenNyJd535da+9tZSLSo80jE
	bZdP10pHycoBLCmGhPGJypPPF4glns55RSBTHD16kzxK1fXJK+eTuw==
X-Received: by 2002:a05:6214:2a4d:b0:709:e4a2:bf54 with SMTP id 6a1803df08f44-70bb060c3d9mr123257626d6.31.1755519770544;
        Mon, 18 Aug 2025 05:22:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUcr/GCgCbA9G2u/4IyMEwPyAw/NjsrcQ5eA7gUss8mTuZTnsQntVw6I/g6SciWoXqiNst9Q==
X-Received: by 2002:a05:6214:2a4d:b0:709:e4a2:bf54 with SMTP id 6a1803df08f44-70bb060c3d9mr123257256d6.31.1755519770108;
        Mon, 18 Aug 2025 05:22:50 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb653f657fsm12601563f8f.29.2025.08.18.05.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:22:49 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 1/6] ASoC: qcom: audioreach: deprecate AR_TKN_U32_MODULE_[IN/OUT]_PORTS
Date: Mon, 18 Aug 2025 13:22:35 +0100
Message-ID: <20250818122240.1223535-2-srinivas.kandagatla@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Sdn3duRu c=1 sm=1 tr=0 ts=68a31b1c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=zhxk0K_MHdi4n0KV9BwA:9
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: mF0BsNq_P4k8FrwYr7SKfC7xHlZZIfSC
X-Proofpoint-GUID: mF0BsNq_P4k8FrwYr7SKfC7xHlZZIfSC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0MiBTYWx0ZWRfX27gSEqBl8Y7n
 5iohoNDZyuow4ioeMrb9C1Mmt1j8v7tL+TxshqaeF4UmlWerCOnn9PZAjaWNiXj6WR85A26eSNm
 hUPphufWd5Sdt4BnOFzoZ02vDgsPD1S2iKSMSsUQd3yjJEOi6LlzkNpy3Y+AImo93G/UTaDZSBg
 lS2+7OW/f5qpcT/JhvfKhVKVJZLLr/tZ7l8FY81CAEcLYLUIO49CBGYlQga0bfFnNfkeTTQ/CWB
 F9IKvlQli2adSphHG6NRJSH+6zxtZpxZ4D/dmcW6je9ikYAgErLjQire8zZ6H6rBH6n0nJ5Zu4J
 +jSa+yEMy58uEn9tLkguuTN0h1EhG2Ra1yuJk2DuLZr2zrkXUiYU4U50dYtAH1+klGVbX7pFrIv
 /5/CxFQz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160042

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Deprecate usage of AR_TKN_U32_MODULE_IN_PORTS and
AR_TKN_U32_MODULE_OUT_PORTS as the connectivity of modules is taken care
by AR_TKN_U32_MODULE_SRC_OP_PORT_ID* and AR_TKN_U32_MODULE_DST_IN_PORT_ID*

Also this property is never used in the drivers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/uapi/sound/snd_ar_tokens.h |  4 ++--
 sound/soc/qcom/qdsp6/audioreach.h  |  3 ---
 sound/soc/qcom/qdsp6/topology.c    | 10 +---------
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/include/uapi/sound/snd_ar_tokens.h b/include/uapi/sound/snd_ar_tokens.h
index b9b9093b4396..bc0b1bede00c 100644
--- a/include/uapi/sound/snd_ar_tokens.h
+++ b/include/uapi/sound/snd_ar_tokens.h
@@ -184,8 +184,8 @@ enum ar_event_types {
 #define AR_TKN_U32_MODULE_INSTANCE_ID		201
 #define AR_TKN_U32_MODULE_MAX_IP_PORTS		202
 #define AR_TKN_U32_MODULE_MAX_OP_PORTS		203
-#define AR_TKN_U32_MODULE_IN_PORTS		204
-#define AR_TKN_U32_MODULE_OUT_PORTS		205
+#define AR_TKN_U32_MODULE_IN_PORTS		204 /* deprecated */
+#define AR_TKN_U32_MODULE_OUT_PORTS		205 /* deprecated */
 #define AR_TKN_U32_MODULE_SRC_OP_PORT_ID	206
 #define AR_TKN_U32_MODULE_DST_IN_PORT_ID	207
 #define AR_TKN_U32_MODULE_SRC_INSTANCE_ID	208
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 61a69df4f50f..9b30177463e6 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -707,9 +707,6 @@ struct audioreach_module {
 	uint32_t max_ip_port;
 	uint32_t max_op_port;
 
-	uint32_t in_port;
-	uint32_t out_port;
-
 	uint32_t num_connections;
 	/* Connections */
 	uint32_t src_mod_inst_id;
diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index 83319a928f29..a3b0f558260c 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -412,7 +412,7 @@ static struct audioreach_module *audioreach_parse_common_tokens(struct q6apm *ap
 							struct snd_soc_tplg_private *private,
 							struct snd_soc_dapm_widget *w)
 {
-	uint32_t max_ip_port = 0, max_op_port = 0, in_port = 0, out_port = 0;
+	uint32_t max_ip_port = 0, max_op_port = 0;
 	uint32_t src_mod_op_port_id[AR_MAX_MOD_LINKS] = { 0, };
 	uint32_t dst_mod_inst_id[AR_MAX_MOD_LINKS] = { 0, };
 	uint32_t dst_mod_ip_port_id[AR_MAX_MOD_LINKS] = { 0, };
@@ -455,12 +455,6 @@ static struct audioreach_module *audioreach_parse_common_tokens(struct q6apm *ap
 		case AR_TKN_U32_MODULE_MAX_OP_PORTS:
 			max_op_port = le32_to_cpu(mod_elem->value);
 			break;
-		case AR_TKN_U32_MODULE_IN_PORTS:
-			in_port = le32_to_cpu(mod_elem->value);
-			break;
-		case AR_TKN_U32_MODULE_OUT_PORTS:
-			out_port = le32_to_cpu(mod_elem->value);
-			break;
 		case AR_TKN_U32_MODULE_SRC_INSTANCE_ID:
 			src_mod_inst_id = le32_to_cpu(mod_elem->value);
 			break;
@@ -550,8 +544,6 @@ static struct audioreach_module *audioreach_parse_common_tokens(struct q6apm *ap
 		mod->module_id = module_id;
 		mod->max_ip_port = max_ip_port;
 		mod->max_op_port = max_op_port;
-		mod->in_port = in_port;
-		mod->out_port = out_port;
 		mod->src_mod_inst_id = src_mod_inst_id;
 		for (pn = 0; pn < mod->max_op_port; pn++) {
 			if (src_mod_op_port_id[pn] && dst_mod_inst_id[pn] &&
-- 
2.50.0


