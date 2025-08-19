Return-Path: <linux-kernel+bounces-775367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF1FB2BE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3989C3BC720
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DD431E11B;
	Tue, 19 Aug 2025 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hjYcx/TU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50BF31B123
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597725; cv=none; b=DjbeNc7asWtRO51BmPPXRNhwHD2QBYnc5707bDQRY9C1H1c3XJIa4IBRU/kg8tWHso7X6JXET3pXZRT4e57o8rU6MoZDXCLk1txSN0Xt1k358hwwD8Xk//Wmn7pImK/2NbXtWMhUaukxT/1mfsQkFmIBzbNZJPMb6ulJ5rLA5Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597725; c=relaxed/simple;
	bh=hpGzTc0IFp4kxDa7L0DoR4eGGYq0Ed7d5aUx9Md288w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njnIN5+EIYhI7fynHOQJvdlC8sD+z9imiV2HhK1+OVvB37/EBEHHc9p+D08onIKKZQ66yLmTHhETnyMrxxBGWS7yzCfye8rYAuRDoiNCIqU2AFRKCbCY+NjfUG5K+kntRtN95WhckQ36m/zGo1ldQt9tIeXVfyBUaRcM8W/JVgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hjYcx/TU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90gHx030574
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wM721AZ4mzS
	KZrE5a5VcC0lVzer8Uu47S0uTwNMIfYE=; b=hjYcx/TUMXvNSqDtniaz/Kx7eHk
	JkSc9zrai0/p3Nz2VFPzF+rgRWwFEbcuRddDLRVmdnlqhdM1RKh5APHTGG7RK/O3
	8TvfXHpMppRzkYkazUyWIppFwYodUt4EaLhR+VnA9cHKtBKG0OJeuTDm4FG1Fnol
	B3QJWLYkihQVEFoiQ+dJly7aDeGZs6CTalI+9gthFM8Dho5Lbu39U9REcncZuo3X
	4u0eMuqdBXpc1KKGORdfeGMTt2gyZtqTcrZY5AfP8snkLKtp+2eBarxM/gh0tBJ1
	/dY5piKu3+4SRAAd2UY7f7xMhA2oV5asxtr90sgoXRCijJlWQZRpcmXJNiQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyunvaux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:02 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f636685so172689966d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597722; x=1756202522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wM721AZ4mzSKZrE5a5VcC0lVzer8Uu47S0uTwNMIfYE=;
        b=m5RGdhIbfeU1tIcVzTw3DfXii1ULhxyWd+yHHHVVbBBBxnDkI15JuBSDete2Ddr053
         F/57uJOpu4KaUfNsPYK8SsuVeq9MunzUhvDOGEn5TpFPnqoaZpJsGsZ1PWgDkvl3OqLc
         JBzg7XHs5nxpMPwIdayh/WX5tQJLmKHk/CZBz78IEo6/F+xrVSJD4hbRypsbWCzi80nx
         e/FcSe+eLZXJbuyFd9zKlMwXM8CKgPFZAnGBJhjlxv3kqwVmGqUZlZ8CGPtPzhWbsVjy
         eAZI0YNMMiqE6mneFoblwxhPhUbrawWYjrTjEw8+Q2TlGOVGoNRc2OjovO8cTumXOMLG
         T0aA==
X-Forwarded-Encrypted: i=1; AJvYcCWHBKSfTVzA3xlIQwCR4tHlwpv8xk5Txukh4qgt8mzJwmd9fhhuf3DJNlhs97dPX1PkpKLtMJOvGFvuxds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXzDLoMEkyW4r6HuNCwH3VqYhG+eQi2IwfCV6MjV9FxAFxHEIo
	Fu+1aNrK9vNEDuuAKPpsClGxNnOq8hgmt5Lk7ABvnMwjyYUjVMgY+FN/uXDqXSTYWfpaV3Ljrrp
	7IG8VeqBfViV4KzKc0Xa0j43MmU770UhbIyKoOgQO6cI3FNpleKBEBR9bAI1ppf8Wcas=
X-Gm-Gg: ASbGncsxvvQXCUHWfQfrvorpa9f0o3bNVH+ta9idTBXRsmDazbGvgHOba9tYnEq5gdN
	7WDzb7klij6Bk5Xw0cUqnPdG6//Bxm67iir+UZsSwFHvsjfNVd+yWXemvXavVwnzCMTp9x7tdqB
	9Hl8ezVhpESgXq9sVUtEWhH58+dbKGHlkTO94wVj3Fh1JdwnlW5rXXQ2Rp+BobicjUeg6D99Z+Z
	HTHvVhG0dqWJGs3dD7UOtvrv5F93AH6vU56BmsMUbSAwWYys7Bm5N1i8v0CeTdVlDBPmyjk8eE+
	S0VXmjZ3r2iC8PDdgjIHteAaxRbDKIFbyRoAecLis5n3Vmv6jcfjGQ==
X-Received: by 2002:a05:6214:401a:b0:70b:7058:4746 with SMTP id 6a1803df08f44-70c35b97b10mr17744346d6.37.1755597721919;
        Tue, 19 Aug 2025 03:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNFvk99moeiVgwrJWZ2vKTW8+g3BP4ueZLIORhlPbQjQBhgufuANqDaWSbk/5MT7fJn2X//Q==
X-Received: by 2002:a05:6214:401a:b0:70b:7058:4746 with SMTP id 6a1803df08f44-70c35b97b10mr17743836d6.37.1755597721420;
        Tue, 19 Aug 2025 03:02:01 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78b410sm216169635e9.24.2025.08.19.03.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:02:01 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [RESEND PATCH v4 1/6] ASoC: qcom: audioreach: deprecate AR_TKN_U32_MODULE_[IN/OUT]_PORTS
Date: Tue, 19 Aug 2025 11:01:46 +0100
Message-ID: <20250819100151.1294047-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250819100151.1294047-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250819100151.1294047-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Zab7O1EBDAdmccd1oUqDeeaVnYKFgoGB
X-Authority-Analysis: v=2.4 cv=N6UpF39B c=1 sm=1 tr=0 ts=68a44b9a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=zhxk0K_MHdi4n0KV9BwA:9
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA3MSBTYWx0ZWRfX1Jg0PpiZKlsV
 D+I86NDYaIEZ+T8akMtxFeObhxt5IYdO9xCxQI0ZFkKgwEfJpXOG3iK/NamYsozfZKgHpFWcuaW
 125xolVTUb8V0Owi4KMVLgOuxpo5kWJT4bcvsarYOmVcfraLU1J7BoajCbzEwyFyVqLXx5mLoJA
 CmMcN9VIkzEs8YsRTUGoj8k5ykfdsFq6O8kSGE8zUUuBNoBK/C+CXwf5cxmoO61fICf+BkhMkOY
 U5DpVZGqNKPvFK00g9aahLJD98kFGhHIJxrenL/gSl8PftkmduiNS0Fukf3IWhjAhbh4Aw1XGPS
 OzMZE4gzLX3TfqMhQhKC42oykcn34E7KETrHswEcA7i/WUbLUG9BfZMvcygAsJj3/Oplmavp+jh
 yVxqbeSF
X-Proofpoint-ORIG-GUID: Zab7O1EBDAdmccd1oUqDeeaVnYKFgoGB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180071

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


