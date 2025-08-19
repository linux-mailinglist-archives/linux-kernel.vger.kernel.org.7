Return-Path: <linux-kernel+bounces-775369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7186BB2BE72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165043A7494
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD1A321425;
	Tue, 19 Aug 2025 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KzqGeKWD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3631E10D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597728; cv=none; b=rnm3xkAcQozWK3QyYXDT+oYbE3+T66uEDF8y0P9TpNxUfdb7/rcI2Wy9Nvf5pKtWImwI/GIjbXC9C4q1eiSTEFfy2SCjRzWKkmM6ZJ4myTFb8BHSCSmC9NfBbNcNCZ/+YZ8awgEEK3eqQO/SmG17jSCy3LXfZf9SmFGMgmwluOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597728; c=relaxed/simple;
	bh=XBbKaJVEpJ0GLksbf9mqJRlB8lYIex/t0O9ath5WT6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDLZW94XetEuS0lXQC12vXrTkTu+XFLEoe4+22kELVEWX6zxqh3vah9JlXB+CfJonei4lERT79h48C++k9TNSiZ7UTviqCqQB3i5EL1PEDFeffxvbHGNQ071dL+OXECHV9jibalt45YlIfafS7Mz66PtCj95qPIkkYvWAMPqUgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KzqGeKWD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90Wwa023322
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tRc0HsrjFgZ
	QuPsk7St9wVUwcmnzl+/hXr2r0k0gJLw=; b=KzqGeKWDErGGwJXWX2LBRu9+zfV
	CYovi++bV9jq363PPvcQz0x9AWQpFprn70b/OWUi5RVV80EZkJ+eMQy28a6qmiba
	86zrwp3URJB9Aw7KqSvHb+p4l5jrAqqTx4Kz6+4eAtj2eWC5Rclo7Y+ja8pqQL2Y
	GzByr/AJHAA9rtke1vXunR/N0yC32GyiPlITFNGj1g7qXo8ySbCBkNLI2+aaaD3q
	E2XoP7T9GY+V5PurzGuKH8vhQmjG8qnoNCLCJGqWVt/JXhZ0oxFreCSlxAcus+4o
	6W5gHZt9aPp79q/UOBCxUmn070e3PV0XWjRCC8ltO4egwtEdn8EeRu2iD5Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m62vk1yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:05 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a88dd0193so116425596d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597724; x=1756202524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRc0HsrjFgZQuPsk7St9wVUwcmnzl+/hXr2r0k0gJLw=;
        b=Gxxzsnlwgj3YkzexjbwOYh2wMkH4Wxul5bF6UhU8tnEav3YUEgyOXRZpcI/BrsQgfT
         2hAXEXvZYuLsi+T1VG4KsNDmG/qmXXSG7aQyEk541WQxV0RwY/cjzQCU+0NCz/b2/gpo
         xJIoEgX1ClwjeSTDlhJQnsv016VagkyyrkELsNmSKz7NdKe69F0F2EeimPdchAPDvv0S
         F1+mD/wXx7a7iZT+2jniZc1OhJCQvW6iSdH/h5CJHhPMct7ttKJBJjU2JwhcsM1UDnJk
         4AQVu/XR2z7ExSm4e4woNs4Y4NXrN6smeItrptHDrw0rcRZ1iEQ2/4yFZgkyv1NYE9fW
         pciA==
X-Forwarded-Encrypted: i=1; AJvYcCWEypRdg+ZDH5/2yIQfYj+JgDBx8DPAjJIg2+kvEjfOgdqFsKHnNfSf61MArvwf545+LehbdEkSrufhIb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01VbdtGCSJw3/aFJa91czHxg1HPnmbzqQsIQ4Z5oxV92/ognN
	GqP0IplrxDjp6BhgrGYFIPvzQdbzTzIoJgvYCa6Zr8SeBHh97FEPLJnqQ0YxYpiTAzg6bAOcgbA
	uFYU2zXI7lCRWvnCmJLXhiLAgWeG0i7zac/0pn8JcgVJsAToPb4tT1D0mXUCn5MX0HdQ=
X-Gm-Gg: ASbGncvaLJapIMI4FzHA9Fx20yCoQki25uFQMckAJiy+5iW+GIduPcpOJHR/hWeUyey
	cVozB0PVZ+jPut1MHpns+Hj1pZzqSzXmQ+ELi8aC0Wij95ufyrO25Q9dfuYkzlOos3oIRncxmFn
	u/sB4Or5haGWxWMyZzQxnkPnV3FfQjvGuDVeE97IN8CFMqxEUoa7SV//eygnWadR6SYcJbcQNOJ
	oLVUA5cEsWIYwp3ECJVY4Dj/k0Zeuat+NXzEQxLcrVtpWpx9dD8jDKmbRMmALwECRoed2QfwkPy
	WncWM+vkyld1CUngRZuurOam2ncTwiTzCaTfMjKFafCOX3AXybHx3g==
X-Received: by 2002:a05:6214:c82:b0:709:8665:f839 with SMTP id 6a1803df08f44-70c35c1934dmr18056586d6.43.1755597724179;
        Tue, 19 Aug 2025 03:02:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUWHhvsKgyA2SxkteDFqxqRKkA3blu3hRYStMz+IEvN92IgnTOzLaLYoD7it9D9J7VRufiIA==
X-Received: by 2002:a05:6214:c82:b0:709:8665:f839 with SMTP id 6a1803df08f44-70c35c1934dmr18055956d6.43.1755597723482;
        Tue, 19 Aug 2025 03:02:03 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78b410sm216169635e9.24.2025.08.19.03.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:02:03 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [RESEND PATCH v4 3/6] ASoC: qcom: audioreach: add support for static calibration
Date: Tue, 19 Aug 2025 11:01:48 +0100
Message-ID: <20250819100151.1294047-4-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEzOSBTYWx0ZWRfX/Ux2px/KPNHu
 Ddvxrk9LWQtJ60rXb9GWWHEO3U2ZIVd8VFZXVW49pHQhYLvgrxLmgrZEDaqtH4qSh+He5bThzWb
 cKIMEoQTNTR22aUgIFmIraBW55eLD418hjIJrJwsSJ3+4biwbsa+mLwtvBgEIs5sWYi3uLc4Dq2
 P8PGUkDdvEqzqDLnj4pF4OmImjlJUP1eJBSuvQEhDelA8dXtc3sseLX9yRSZwjqCiShXO+nc7Um
 eEL5+zK0k7fSWW8x2r1wYM0dyMyhrorY5RMMcYD3SaCeqpiwEK9zrrTEmL+Yg37dTcpq82wC8aZ
 K/1g/sBU2Sy+r4529k9SC0M0A6myqNn3S8CXPjjiWMELcl9Ypp11u403xaR/YdwbFSSGoUbdWJ2
 RLmc6Brs
X-Proofpoint-GUID: YHdX8qZlWTWeQjkMmzRtWwHraGQa_7qb
X-Authority-Analysis: v=2.4 cv=A4tsP7WG c=1 sm=1 tr=0 ts=68a44b9d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=FkCHEUkhfVKCBkrVOAQA:9
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: YHdX8qZlWTWeQjkMmzRtWwHraGQa_7qb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180139

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
 include/uapi/sound/snd_ar_tokens.h | 10 ++++++++++
 sound/soc/qcom/qdsp6/audioreach.h  |  2 ++
 sound/soc/qcom/qdsp6/topology.c    | 31 ++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/include/uapi/sound/snd_ar_tokens.h b/include/uapi/sound/snd_ar_tokens.h
index 92cf72a6fdd4..6b8102eaa121 100644
--- a/include/uapi/sound/snd_ar_tokens.h
+++ b/include/uapi/sound/snd_ar_tokens.h
@@ -3,6 +3,8 @@
 #ifndef __SND_AR_TOKENS_H__
 #define __SND_AR_TOKENS_H__
 
+#include <linux/types.h>
+
 #define APM_SUB_GRAPH_PERF_MODE_LOW_POWER	0x1
 #define APM_SUB_GRAPH_PERF_MODE_LOW_LATENCY	0x2
 
@@ -238,4 +240,12 @@ enum ar_event_types {
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


