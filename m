Return-Path: <linux-kernel+bounces-775273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBC7B2BD5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9593AD3B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3116631B135;
	Tue, 19 Aug 2025 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZQren/OC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82614B06C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595620; cv=none; b=mm7z6ZiK9jogTVCRWY8ggYN/NxAqjakcBJxPsLRBPoZpjFuSlL5lc9Zi731LC/LYIa3IBGhNc+dloGrYfJFzfLXidT5dfnLSAyWVK0kG7jlLZjyS50deNZBjc+Tx53/WE9swzh9MAmC4HJ+wtRcAo22O9CcYX4WxI3JvBsc9Vhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595620; c=relaxed/simple;
	bh=hpGzTc0IFp4kxDa7L0DoR4eGGYq0Ed7d5aUx9Md288w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dde5SAVr1IAjsbWzR81DB8/D5QeLIb4oZU/6Pgj/wCvWoyGZVH6EmaWCTZHmvkIynsOjxK9O6ykEJoc96LZEm6tqVPP1WV/hLBh4ZEFQqS/Xp/ZUhpnQVyvLwE7EaG26duOPTh5u+iyVYkrJXOFCDatdYfnRJTO2VFYnW3pPK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZQren/OC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90WM7027823
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wM721AZ4mzS
	KZrE5a5VcC0lVzer8Uu47S0uTwNMIfYE=; b=ZQren/OCPoXWEW3XoIRoD0JJKE6
	xTCXK6cpHoeOQkqcUEWySwmVHS1UenWZ/LaxAa4f0pcW4aCy+mIG0Zrw6jg/fk8x
	Wr5U1FU67N9iy0w4Lkrk0U4qaq0ULkU2aqsH5kfupw2ECDtbWnKavZlu1lblsqkF
	sj9DS5OJktita3NSgWtsRIsR7ke7OzSsRHKuqv62hXieyaL89xfOmD5FjXZy17cv
	RS8WbLtdPrd5mK051RrnhkBj2AO2YBKC7rLkZ7BzfjQT1Nyst1X0UqVquoLLqXgz
	DkqHj+54fXzWsr3T0yy27uBEGxrks595wx3K/NQxhyEF7fBoPo8U5jrwzDw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jgxtg6dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:26:58 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-709e7485b3eso119894066d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755595617; x=1756200417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wM721AZ4mzSKZrE5a5VcC0lVzer8Uu47S0uTwNMIfYE=;
        b=A0TeddGdSlL828AJJcueyf2h1WbsBjiqllidYnpWOo9HS30keIvs0NCg/WSnpNFhOL
         bOHFDexOZWDiwp7gxXifMZRti0/CPBDcQ7jNUUzasuhLqLR8M1LV24bjvnvjPSY7z+oN
         qY4XKiU+xPfTiefbRH44/GUA8rRZ4JOG26nAx3zO9v2wE/wQw247RqtUdjT0AyykFUXD
         AsKKveBuutd5rq1EwB1P8kz8+o3S9k3+Yqv8njBUchYwo0th2S3IP01SzVfZwGRwUUF+
         yI+Ll/SVU/80+nP0DPp9Hy3kdu7OJGsirphtdpXpb1A2xZhC0PsAFg0OEdkRS0S7APzI
         lT+w==
X-Forwarded-Encrypted: i=1; AJvYcCXrydFuZhBwK/BU3oSqzS4KkWiXB1b6FjeQ8RAxRTCjYKcE/JSh2xSSFySJ1lfzsJBIiwVLk4kDxRp3BKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQnLa2jl6yQFt+cnKbvVg2d9cA5lsUgk0eg7lsLQwtLkryNV9x
	cFRkuS8MCnHHhbA7D1C2V+Jadai8wtVmLv/umQNMFiwpUTqJPBEjglTMgyrcMd3OA2CQR2WOFjC
	UBEIqoDyGkxp3fHNt9EYHe+eXV3+XWpDw5b0IYRCnsrn99yTNlHdeTKHKxEpu50O56nw=
X-Gm-Gg: ASbGncs+0ypt09/lI4IDI6aIeB3EDEcCmFUDa54lip2GKWwBTMpHuJYyNLBi3Zrra3b
	nPlbUutyRWPpc3kkGk3krCIOmWBP0tlwqpFgMDB5kjYWtt5XGL3pBtdhzTu2+tC8dvWx0I9oVRi
	Gco8ZCL+UTIcyZ/zA7jk4cTMvYME7nm4Pv5BuJVa3JgmYOIkuokqUU0I/MBYnrYxHVpIObII/nS
	N77k4EBdG6YwfqBmrB84pzvI+/ekP8Mx+UAGGDNcvrrU5PfWw09tHMwg4rxqK3tKkJpKutfFoFh
	QYa2MSKjQ5rSBi/0EEktr4pgdWHQw9LvmcoJUJUPWtQRJ0ckD1sL3Q==
X-Received: by 2002:a05:6214:1242:b0:709:e01d:95e7 with SMTP id 6a1803df08f44-70c67848befmr19306466d6.16.1755595616678;
        Tue, 19 Aug 2025 02:26:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9GqDmEUOZr1/l47uzimaFTEtTx/+XaK+m2zAjBVg0cMA8rGGZ5FkfoP2eu0JKiyv62TuSMA==
X-Received: by 2002:a05:6214:1242:b0:709:e01d:95e7 with SMTP id 6a1803df08f44-70c67848befmr19306306d6.16.1755595616236;
        Tue, 19 Aug 2025 02:26:56 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077788df7sm2942284f8f.48.2025.08.19.02.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:26:55 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v4 1/6] ASoC: qcom: audioreach: deprecate AR_TKN_U32_MODULE_[IN/OUT]_PORTS
Date: Tue, 19 Aug 2025 10:26:47 +0100
Message-ID: <20250819092652.1291164-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250819092652.1291164-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250819092652.1291164-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RK1pCwgEaZxt6DafYbr4Wk2bIu9Lx5IK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfXyggG+AMyKM/Q
 WPOgmkmimDFFRJ4Hxz355vzsoAgv7Z6XBkJqi7F7N0PO63RG/pPUIZhET/bAJxQtpvQFL6/+2O4
 dMCIkbjtBGQJE+E3Zz6f6jvi0+RQ0H1vA1UrB2hAfeOdsU61rBsydnb9iA6+yC7PQOLxTfTg6iw
 06bYsUulpWHxqyB1FkGyqw9tGRvAigsvBzASALFT2sGIlNuNKBep5fBEBGNspcMfS029MBbc77p
 zwkbcaC45QaxbfMolaFB+RxRQxL7+v3t6ykK7D8rAPFGPygSDtI7BTo6KZ+rF7ognDAWv/XgqGb
 RLXktH4ZuX5CrQR7PDyhwRdnkZ4AKH8Qgu7yfd4NJvY7WZqbMiBNMl7RViqnA4HV1RYYQayXGcM
 x46jb3D0
X-Proofpoint-GUID: RK1pCwgEaZxt6DafYbr4Wk2bIu9Lx5IK
X-Authority-Analysis: v=2.4 cv=V7B90fni c=1 sm=1 tr=0 ts=68a44362 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=zhxk0K_MHdi4n0KV9BwA:9
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160020

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


