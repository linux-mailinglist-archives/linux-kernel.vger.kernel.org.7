Return-Path: <linux-kernel+bounces-773541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A4BB2A19F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D57C189FC64
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D0E31CA55;
	Mon, 18 Aug 2025 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NQqU+qG5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC031CA4A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519776; cv=none; b=rIcWvfZTwtqMUVKOlWXs/eZqKVLUMF2/KW1k5fHaMvwtZxC0jER+OdKBqUdeGAZETsfUrfnPcYSjpnWAwgn4HRtZLj/5LfpQPKS3n06bpOXDjntSnvjTrRu0grzR7d9nGJQObuJwaB+stIXfQDckQGGlZfUYbArRw2mGfb/AijE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519776; c=relaxed/simple;
	bh=0r9Hyf0nVDtZIhGlg9pnxUosjJ8q4m1DneRXJydATCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VG9B/BuHYGqBTKxxoy4qQ6Sl/qpI3tGQOcHqAwQYy04Q3vij/9YoXhkxXxVzt7gaLvp34E1r2DCWqqBPz7UFWwbYIf0BzLWEHO71ljuhlTZ0BgDCSNcUGdGscUZOAThsj/ml4KIDi+SBVpK1yrqyO0MGN21vGyXTE7cmOoep/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NQqU+qG5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I82ib3029100
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cxCH5jc9rps
	/mrQJQ1gQYWQ3StnbOOQ8G8DFqXSrAMI=; b=NQqU+qG5FXHYClKSYO4okcgO1L+
	y41z3kZdy2irxE/veyMuqNixo2xoaKMG/u3UWlzINpOIJcePQ+DA7IQtPbqkS6Yw
	M/1yMnY/9ggBKmp9wLBdJrEmcQ/RXzEFcS/7DNt+vOtKBvJkxrE5bZwxybtCBEqz
	k+f2l4wjnHQ8ndeOMtP2IE4xS7QC3N9GHFlZwDGYgHB6pMTSH0okImCH/MDk34lZ
	k3zff6RBqSBuu7VR/fRRXpBWGq17TAQZ+sg8XzksNhfq7RacPTWGCHJELbJcoB7Y
	7ZYOq07DsZ8nsL1y0c7Zq8fvZAlifehu+ToAQKJv6Ivbd903dru999+5eEg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2ucpgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:54 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70ba7aa13dbso69583386d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519773; x=1756124573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxCH5jc9rps/mrQJQ1gQYWQ3StnbOOQ8G8DFqXSrAMI=;
        b=dbOSfDGeSQlX8i26ONzPB1AFCbrHV7cL5EW504EgBHCEl3nW2qtsEcHF8w/yAdHOGg
         VJQffjySaWbCrFoSoX/1wDzCtMkOjVgajr30vb4UN2B2y7Gulvd/Cf2w7vWhXNOkd0le
         5sa9BHGrMBuBe4/2YkERoldDBYaLc4cnfyTEndLY41/f2bDXf2x5MprE9IM013twH3/b
         uNZ855vC7+fMdnWQ+ukHB72u4pD+3zZzeLoudfquAtThEyZJlVNtw1+NSU0evCvPChL3
         MbINOstnObwjQkasSjOxxnliG1WylJ3m6MFO1iXI3kEdN+bEH5R7376Tp/5WBT9xvcbm
         cd7A==
X-Forwarded-Encrypted: i=1; AJvYcCWZO52a0iDlZWUG/UqVlJFGnHYExp5tuTPgetusnwxgj0kARTIGkDoVITFf/w0ZfySprLDFkV57FplxEXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0RmLUNb1WuUno3BwYjImULV8JI6e2SdML5VTs5cgo+ZcSsXTO
	F1ZGN3+f7x/bj+vYmHo9fZ/QX+y4gSAFM7eKr9LTR8tN91RGSjr8i3I2Cer8pbvvvvJ3ijIDhgg
	WaN56rBxytFgEn0d8FtstOqwUz33zODEMHvDNW9ktzfH4ddCNovX7A1IUAa/ukcPJz7g=
X-Gm-Gg: ASbGncu/OpuPkirKMI9Hk42wJTZ7cLcTZH0YnOrLXUnnhEkk0MxdtKoQmBg9h/rq7IU
	cBqutdro+7PL3Q2qedlu+n5GK9ALTsfOLVu83RfDYv/KlO6TiecuS0qe5xCjyANSx4I5N4Mjf3m
	YTpV+oW399cBd/9y0UChwfoOCHs1XS0UES17L2ltIRP0FXOKiT8mtJaPGi5c07iOxA9aJwOgCLs
	NGEpOTf2KBFZWuBb/fx5SG4LI7fs5st/YFUmPDNiZmIYI6Penf/f8YpEXCywf72YrHu0KSG7LRp
	t2V587rAJzLYxLFCpjFTxFwEfN1L3T23EwmFTO55iOiuJnctYbke2A==
X-Received: by 2002:ad4:5c43:0:b0:707:5319:d3f1 with SMTP id 6a1803df08f44-70ba7bcd758mr132199236d6.32.1755519772849;
        Mon, 18 Aug 2025 05:22:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhUYdasV96pnAGAVB482zMVwB+ztPSFkdJL7AZgDt1OaA3hCb8rRc++U4kwgJmxmJWnSwk2g==
X-Received: by 2002:ad4:5c43:0:b0:707:5319:d3f1 with SMTP id 6a1803df08f44-70ba7bcd758mr132198696d6.32.1755519772199;
        Mon, 18 Aug 2025 05:22:52 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb653f657fsm12601563f8f.29.2025.08.18.05.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:22:51 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 3/6] ASoC: qcom: audioreach: add support for static calibration
Date: Mon, 18 Aug 2025 13:22:37 +0100
Message-ID: <20250818122240.1223535-4-srinivas.kandagatla@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a31b1e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=FkCHEUkhfVKCBkrVOAQA:9
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: bt6XN4NwpQ2ZRwDIPr32-aBvkKtQkhNO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX07mnEl3K499n
 9wWOb0rJ/co/F01+30fnqMxiBdIFYixObw3dyfwWzX6kNVBwoIcXjT2qRVskrjmkM1xyKDmTZcy
 J5pXM/CuvQnQ/aQqfk9WDKgdn59WHr8wShHjouUnH6wO1hEJBZY9LkRbwIkYAz4hPLni1+Y9QRW
 wwn8y0BL+bOLjHtnZhU0VjDygqAEQbmym0uvELVZ9WY7UpViCtHiNeLIrPoQT86hBQtQUqPUdiR
 rZ6RUCpVjcEN/pBijm4dUN66/gK8ihtgqudh5eQpkyxVItaXJilZ/iQtjHxeexSe5QxdI1bEGQI
 gDsYIucvrRYwS25sdg+r1KhQjU1gmM9CIwOd0MNo1Z0vuQoxcI4vAoTUXbQ6K0p8SU732DWhxBE
 tI9/yynp
X-Proofpoint-GUID: bt6XN4NwpQ2ZRwDIPr32-aBvkKtQkhNO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

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
 include/uapi/sound/snd_ar_tokens.h | 12 ++++++++++--
 sound/soc/qcom/qdsp6/audioreach.h  |  2 ++
 sound/soc/qcom/qdsp6/topology.c    | 31 ++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/snd_ar_tokens.h b/include/uapi/sound/snd_ar_tokens.h
index 3aa5f4928a2b..3e18442d383a 100644
--- a/include/uapi/sound/snd_ar_tokens.h
+++ b/include/uapi/sound/snd_ar_tokens.h
@@ -120,8 +120,8 @@ enum ar_event_types {
  *						LPAIF_AXI = 4
  * Possible values for MI2S
  *						I2S_INTF_TYPE_PRIMARY = 0,
- *						I2S_INTF_TYPE_SECOINDARY = 1,
- *						I2S_INTF_TYPE_TERTINARY = 2,
+ *						I2S_INTF_TYPE_SECONDARY = 1,
+ *						I2S_INTF_TYPE_TERTIARY = 2,
  *						I2S_INTF_TYPE_QUATERNARY = 3,
  *						I2S_INTF_TYPE_QUINARY = 4,
  *
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


