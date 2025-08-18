Return-Path: <linux-kernel+bounces-773614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04C3B2A23A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD5E3B4118
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2025731CA57;
	Mon, 18 Aug 2025 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bbs2Z51K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87514320CBF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521470; cv=none; b=o73xjG8iQSrURmJqtmtL7GQOMCo+c3+Ri3pVZhi2jVTd0uPLf3haGdORvprL1mnG8raCAT9N0UuKrqWVKbtgr/XaKgKFwB5p+XlPBpOnkuISkvdd80VULC7ZbstNRJZFDynv4FGm5w3NqUcb3iEnM9b1Y0KugoRTqf2sQEMRcLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521470; c=relaxed/simple;
	bh=lMnHikDt2xPUwNu7ernNychdD+CBhIRxNA593e9iJMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbwhFyTODvoTSsRP2Glna+nfTQzWIPUOwbLYnglOxGV2xjFuOyX7wBg0IIeZZuLQ8MwkvCXoYs+nDKWsWfvNr7KdgX8XUi8kyLgA1+NZASx4UusD/XEPslejHExxIKVqVeg8n/ymqRTDX4iJeMRMJX/ZRcRKMN/TB3Qcl2+Qnio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bbs2Z51K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7V3WM004096
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=259VP3onLw5
	dwQjsAMaa1sY9Z4N6xhGpKI2zjU8vG8o=; b=bbs2Z51Ki6cnBHzBrBApv1BjN7+
	t57YfSEb4k+9vtsj+dPs5ZYO1/8BoT6xS8hXPva422+XL9zTndIF9KiU14Ni3Xzs
	/OvXUu4POFwaJbFL41tR22YNu/f/XiPjMGFdWI0QwiVtIlWwa+u+crZojJlNW4Mk
	EZx5CX2uVZ5PaqG9VMH5cnYVsjNTrhQxWNYDPmuYcmVxa6ZfJEdrw1PX3EE8T+87
	FN2a13CRh8Ix26Jflhn712bTsVqhvj6h1rljEcxxQoGrH7eNlnno+pQyBj9pAVW9
	RzV8m/h0AbnGT8ffxTVFUAUHWB9XJDRyXMSo1MH9K4rQLgKp6tskjETatMg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyur8xp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:02 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a88dd0193so97552086d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755521461; x=1756126261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=259VP3onLw5dwQjsAMaa1sY9Z4N6xhGpKI2zjU8vG8o=;
        b=TtHsPVQmN1z+PnhN19ZyaaeyAXN3/wVYOQslA2YjkTo3cu8zzTcc951Tpjw+UOLQTN
         gGGqdthBRhFoyAbV9LfOmEUpgeyysG8XC9+GQOeWnYRUru3pDcvaUFjfpwS25kw8oL3A
         RZ3qDJbX3ushdkR9wv8Si4yU2o46CCiRxoL80H/gjV7A+H0ccAFPEdrgQ6f0GoxRiU2V
         BZmgoXvFYBUIMIFE4UJOR3QPVURgDo+LKIknlSvtQQWKhxd0/5X3e3zYoWee+9yGoP4H
         YwnUAbtJ/NhTaGXUiE+StBMe0fRimvaYF5zHTugyQpsBOr1EA8DU1ZLOADkPq66rBtee
         662A==
X-Forwarded-Encrypted: i=1; AJvYcCUjDb5YzS4PBuNDjxM7MEYRxtiMpiyaxzVu32ABFizEje38/ZtTiGrqreAPinyVv5paXx1WL2TQmGc1tX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXIgJr4/kOU7CExdo521NLNEKhcPDE1mYIMKAxUD7A16zEnm9w
	asKxAm3YQ3gsh4RQ9V9MQ6Iz5Mo6CNeKoM2N77s2Ldz1/w3Rcz9Nm4qpMuQKVn7grrRqugnPklW
	MZz18MlTlIt4Vfr7Qvx7YTMHiljzBI1pxqwAZUlo8UJiuBaPMa3SEvr17b6OcJbbJ0qU=
X-Gm-Gg: ASbGncvzd6YPVStYyxi9D+HHvtjYcrhnC7CK00i659VnPHZBVsbFS8ofsIHa0tMMyPN
	xksKR2iVF4nzZ0uzf8fUa0FaQYmsDIpHgYRL6Sv20zBWw2TGPx8QKVqNr9TQP7fEJYJ5a13kjJJ
	+heYUg0yje/t/pMsi6LHmwDwI2WPNoy3y1gAbgmAmOdvz/i+Qn+uh4xs/SV1vOM0LxNUq5Cpc/e
	8iIDDJhwrma3rmxCUOCcZd8EnK2IjFciPHWZEuQT2SCqqdb7sx51t0jqizglvq0vlCNmhKai5u1
	3Yjha/T7EqQRhIn+O2UaY12KxVRPepUY6BqhXmzxnt29WS+HI/v9gA==
X-Received: by 2002:a0c:f7d1:0:b0:70b:ab0e:6b79 with SMTP id 6a1803df08f44-70bab0f3e7bmr99081506d6.6.1755521460687;
        Mon, 18 Aug 2025 05:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH59B7x0owy07zcuXrgr5JzJamOIuQA4OFL9/s6uhV0smmoMmgRhuJx6ZF4VakVhtzC0Vb2xA==
X-Received: by 2002:a0c:f7d1:0:b0:70b:ab0e:6b79 with SMTP id 6a1803df08f44-70bab0f3e7bmr99081276d6.6.1755521460250;
        Mon, 18 Aug 2025 05:51:00 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9b27sm12537347f8f.44.2025.08.18.05.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:50:59 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 3/6] ASoC: qcom: audioreach: add support for static calibration
Date: Mon, 18 Aug 2025 13:50:52 +0100
Message-ID: <20250818125055.1226708-4-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA2OSBTYWx0ZWRfXzXtjGkIyfv+6
 /c4pTZvuEdftIv7xg8T8vDdFAbLIWNGQnH33AEdEBCwJIF4+9c+f1WYS+ZlU4AgfIjmCrCr1gVF
 aNbpsuzJMv7BmwDXP8jRlGrw74x0oPXC4WwmpPnLhfvqIz66iqVZW63tLTN/mtkWY6vlOM+nyb2
 A9HRmeFt7NBkEBt4ggs24JHLev27nR29FsEOc2aWh4pGSwsKAqb6/xN7dfw6cf0BvQGeFRreTyp
 OWlh/aqboRzx/imN8sE/rYIHKVhIYJnsp53yXFSTZ7Lo8PbGI0g2JquhccLSOvh3zDOwa6Yujn4
 olp4YAxXXpBySgVbHM5Zo0eqOhEj+B5G63FTrdRn/NvCcXrCuueK3K4DU5MhpgFvpHuRY2OH/45
 EogNVOsm
X-Proofpoint-ORIG-GUID: tffkrJ4kDej9VceUeMHJgV6W-Cfijn7g
X-Proofpoint-GUID: tffkrJ4kDej9VceUeMHJgV6W-Cfijn7g
X-Authority-Analysis: v=2.4 cv=YtIPR5YX c=1 sm=1 tr=0 ts=68a321b6 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=FkCHEUkhfVKCBkrVOAQA:9
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

This change adds support for static calibration data via ASoC topology
file. This static calibration data could include binary blob of data
that is required by specific module and is not part of topology tokens.

Reason for adding this support is to allow loading module specific data
that can not be part of the tplg tokens, example, Echo and Noise cancelling
module needs a blob of calibration data to function correctly.

This support is also one of the building block for adding speaker
protection support.

Tested this with Single Mic ECNS(Echo and Noise Cancellation).

tplg can now contain this calibration data like:

SectionWidget."stream2.SMECNS_V224" {
	...
	data [
		...
		"stream2.SMECNS_V224_cfg_data"
	]
}

SectionData."stream2.SMECNS_V224_cfg_data" {
	words "0x00000330, 0x01001006,0x00000000,0x00000000,
		0x00004145,0x08001026,0x00000004,0x00000000,
		..."
	}
}

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/uapi/sound/snd_ar_tokens.h |  8 ++++++++
 sound/soc/qcom/qdsp6/audioreach.h  |  2 ++
 sound/soc/qcom/qdsp6/topology.c    | 31 ++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/uapi/sound/snd_ar_tokens.h b/include/uapi/sound/snd_ar_tokens.h
index 92cf72a6fdd4..3e18442d383a 100644
--- a/include/uapi/sound/snd_ar_tokens.h
+++ b/include/uapi/sound/snd_ar_tokens.h
@@ -238,4 +238,12 @@ enum ar_event_types {
 #define AR_TKN_U32_MODULE_LOG_TAP_POINT_ID	260
 #define AR_TKN_U32_MODULE_LOG_MODE		261
 
+#define SND_SOC_AR_TPLG_MODULE_CFG_TYPE 0x01001006
+struct audioreach_module_priv_data {
+	__le32 size;	/* size in bytes of the array, including all elements */
+	__le32 type;	/* SND_SOC_AR_TPLG_MODULE_CFG_TYPE */
+	__le32 priv[2];	/* Private data for future expansion */
+	__le32 data[0];	/* config data */
+};
+
 #endif /* __SND_AR_TOKENS_H__ */
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 9b30177463e6..617bda051cf8 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -4,6 +4,7 @@
 #define __AUDIOREACH_H__
 #include <linux/types.h>
 #include <linux/soc/qcom/apr.h>
+#include <uapi/sound/snd_ar_tokens.h>
 #include <sound/soc.h>
 struct q6apm;
 struct q6apm_graph;
@@ -742,6 +743,7 @@ struct audioreach_module {
 	struct list_head node;
 	struct audioreach_container *container;
 	struct snd_soc_dapm_widget *widget;
+	struct audioreach_module_priv_data *data;
 };
 
 struct audioreach_module_config {
diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index a3b0f558260c..ec51fabd98cb 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -305,6 +305,34 @@ static struct snd_soc_tplg_vendor_array *audioreach_get_module_array(
 	return NULL;
 }
 
+static struct audioreach_module_priv_data *audioreach_get_module_priv_data(
+		struct snd_soc_tplg_private *private)
+{
+	int sz;
+
+	for (sz = 0; sz < le32_to_cpu(private->size); ) {
+		struct snd_soc_tplg_vendor_array *mod_array;
+
+		mod_array = (struct snd_soc_tplg_vendor_array *)((u8 *)private->array + sz);
+		if (mod_array->type == SND_SOC_AR_TPLG_MODULE_CFG_TYPE) {
+			struct audioreach_module_priv_data *pdata;
+
+			pdata = kzalloc(struct_size(pdata, data, le32_to_cpu(mod_array->size)),
+				       GFP_KERNEL);
+			if (!pdata)
+				return ERR_PTR(-ENOMEM);
+
+			memcpy(pdata, ((u8 *)private->data + sz), struct_size(pdata, data,
+						le32_to_cpu(mod_array->size)));
+			return pdata;
+		}
+
+		sz = sz + le32_to_cpu(mod_array->size);
+	}
+
+	return NULL;
+}
+
 static struct audioreach_sub_graph *audioreach_parse_sg_tokens(struct q6apm *apm,
 						       struct snd_soc_tplg_private *private)
 {
@@ -582,6 +610,8 @@ static int audioreach_widget_load_module_common(struct snd_soc_component *compon
 	if (IS_ERR(mod))
 		return PTR_ERR(mod);
 
+	mod->data = audioreach_get_module_priv_data(&tplg_w->priv);
+
 	dobj = &w->dobj;
 	dobj->private = mod;
 
@@ -939,6 +969,7 @@ static int audioreach_widget_unload(struct snd_soc_component *scomp,
 	cont->num_modules--;
 
 	list_del(&mod->node);
+	kfree(mod->data);
 	kfree(mod);
 	/* Graph Info has N sub-graphs, sub-graph has N containers, Container has N Modules */
 	if (list_empty(&cont->modules_list)) { /* if no modules in the container then remove it */
-- 
2.50.0


