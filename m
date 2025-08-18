Return-Path: <linux-kernel+bounces-773613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA9B2A233
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BF93AA44B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A2D320CD1;
	Mon, 18 Aug 2025 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eySm4jvd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7F31B129
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521468; cv=none; b=t7ux1YLgBILIDK1Pyq8K0XiO1T58cYttubGFBcx2GT91Xgvl8ava6pFVQ9hOrbV4dWurF8hn7HvQ4AHKcdUP/20U0PA8EAsHn2jeSQlM5IhFyNAMkULCqXEIxxfGKtmHdEu4cXszlhWf3DZeTXwTnbP3FN1LkBwY+BMKHbZ10mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521468; c=relaxed/simple;
	bh=hpGzTc0IFp4kxDa7L0DoR4eGGYq0Ed7d5aUx9Md288w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qbnuf9jslbSbNVHbm+OBCaZpCsB3ZKtS9L1LyBCgoQMXuDf0BEJQJbZ5Jx5DvW1L8nDQsjMDfi71iFH4X8y+TL2ONLXPmorSxm+soviFzr/r/AYLW7lLchbHk7TOAXxZ29/sqsYPf9gDrr6FwNpkeO/meJ/TvXU7HK4Wr4APC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eySm4jvd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8F2VV007294
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wM721AZ4mzS
	KZrE5a5VcC0lVzer8Uu47S0uTwNMIfYE=; b=eySm4jvdMvCNiwdvWVrd4dof1wN
	qBADJaaN7nwfOl5MPIMlb/w3m0nsUHlj6IHxuIouvJBoFo0Q/bEfjmWVvz0rNuSK
	VyxhdoFLrbMr9dWZkL0mhRLLBbFCUhAR5MUA62Ncln+Lw+qvxGhbl5lXxsRje+o6
	2XpAzOyiQJiiSbhJFYBlJx87AQTtTxpzqSHXqkvQ7VU/TRP2DKVu9AGy522TTmnL
	UirdXHtp5qG3l6MB3xQQ78x6WGt/dV+MoSgUl20qH09N9lQNRpDYxc44DzwCH2LZ
	vqrJz+H8FTFU/vHSsz0hzHnwZrlmIDsaX94f7KUYhdHoIHFs4KwRNUw7knw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk99mky0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:00 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a9384d33aso36617376d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755521459; x=1756126259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wM721AZ4mzSKZrE5a5VcC0lVzer8Uu47S0uTwNMIfYE=;
        b=aMi8I33Ifltrhr92RRLA+sxk+an0eLJB/laduadQA5epKltcBItsWfW6KMEaREo9TU
         +hj7wemKXFJr0ccYn7sCmtGmW7c+/SXC4Mjes+dgkBlosscoJYZIL6+KLr6yTGn10nJK
         lS092QTPSmbAcqjPD/9V6shSiQAVN0tBtIFy7VKxtagGOzd4EZuQzOT9Hf0aDP6i1Sm3
         n5jARNiUjWaKRS7ARQ7qimUUTnt9LgHDX//YoH3YynFLtjB+h5xg/y3NbeCYJBxX6zaz
         tCrRBfmE9NiZNZJOxeuwWQzlgiRumFlGLgxB2I7VQpTcl7L3j18aDErTVFmbeecp7aA/
         ySFw==
X-Forwarded-Encrypted: i=1; AJvYcCVA2sGpOry1vgZvO63eiTx+LYSwUhyZ1TpI12YXCUC3vlCfyjia3+9GN0MU9PEN5dtwm+CY+31qUsz5J08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc2cBSJgH2QJqIc5BNRDEtWBswcg3kL8Vfycfbb5oDy+gAZHe6
	BJ/KGdX5rno/2zP+W956/3O7FWG9+PP+2fTs3QlN9VdE6/816U/1p+qteAp+PSGWiErBxPPeSvj
	u9b8LsvF+iSaiUJs/AwA7hBzAQyqHISf9IKUg2DwyZo8UYcXAJZYllqAAzD0rOH9I2+Q=
X-Gm-Gg: ASbGncsa67zqDxbnaUComhtKcBB35TVCQVvLYhoPvSxNeNCHsyTp5USUz+UFJo+Tm2Y
	izG70571+No1D4yONtkUbeso0y1H7SPzgfbJiRIPzaoSUFnvbYL8vKlhdBEe11dax4mbueHwcAw
	6a62MeJaO4Oy/SW1q4NderULEVxO4+Jd83/l7i/C+7uBmG2ppIsRcMHhfo/WP5yDHYAJ0BTGYMT
	/yfgsfHLIVvJz1OPkmUTzYkNIVkg7q0HgVZvuLo2JOjvmewjQbUXbLxjJF3hLBxXAwLuCa5+fbn
	3O24x25fm+c5sN40RpbrMBQa5GFx0gUNfrFYOa6V8VH/BHZVqIe/Ig==
X-Received: by 2002:ad4:5ecc:0:b0:709:65ec:834d with SMTP id 6a1803df08f44-70ba7c074c3mr137812886d6.30.1755521458808;
        Mon, 18 Aug 2025 05:50:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeBiZiWiyk62FtVrWZh4y+IKlDpVh+YIf7vQWzRL0BaK1P6yLQnxcA/7BsloB89i068HuBDw==
X-Received: by 2002:ad4:5ecc:0:b0:709:65ec:834d with SMTP id 6a1803df08f44-70ba7c074c3mr137812446d6.30.1755521458103;
        Mon, 18 Aug 2025 05:50:58 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9b27sm12537347f8f.44.2025.08.18.05.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:50:57 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 1/6] ASoC: qcom: audioreach: deprecate AR_TKN_U32_MODULE_[IN/OUT]_PORTS
Date: Mon, 18 Aug 2025 13:50:50 +0100
Message-ID: <20250818125055.1226708-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250818125055.1226708-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250818125055.1226708-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gSh4wCX3XJQea7idNyCV2MQPc_nn6lPs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0NSBTYWx0ZWRfXzSzMfOLKI56H
 Yy/sYOa050/M/E8S6kBfhW0nPCqm1tX3tWbgvrP3k96/SOBiH2ulrX7+RMXc2Nzt+VE0Hvp7rk0
 6jp4zTxotSglhfc3zefgAHMOjN4++KyZgWAf+eUILVgn1hAiNe7ccasyroE5txSt1paWpA+HRHU
 ZD7qfVEtBD5GNcTBy3JWHRvbgJ4aNJcgidzIb3LmcIUc+Vi6IwmjVVkxCNNZrrs3Mgmbfkm7xBE
 0lmHxvEaUU1S+x5IFcTRUjjrke5oZzdwpWQB+RndrgZavM2AXD9ouz3PUgc7XPRFAhPHzTz/Fqa
 5b1eoaAJbMKESHSosYXLxvYWODvGCGjzzkD18yedAUB/RXH3q5YYocHeWYxM4G7pkgcvbTktrhs
 Db5Sf8eA
X-Authority-Analysis: v=2.4 cv=IIMCChvG c=1 sm=1 tr=0 ts=68a321b4 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=zhxk0K_MHdi4n0KV9BwA:9
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gSh4wCX3XJQea7idNyCV2MQPc_nn6lPs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160045

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


