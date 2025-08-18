Return-Path: <linux-kernel+bounces-773460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0040CB2A06F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7F4621656
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A00831AF27;
	Mon, 18 Aug 2025 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dF6Ojwep"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6F431A053
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516509; cv=none; b=jRUe3N7LLbTxByZvf+p+HxhqsNcICahZeiYbanoyB3yn8tbNC/4mdx7QAnK7ruCpWGu2arBlb4bvuQH5X8/EHDdn8aMSxBjJZxv08UcEAE7jwj0CwtBnjr/42/sMSXyAb0Y1yGCEkhb4FCZv95ORskf4qAJNNIG2e2qpSG3W6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516509; c=relaxed/simple;
	bh=7YHepwuhOJY63DTXiXG877/iFdeDIgw0g0diALJOzrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCtdvuqqEEVI4hl7D91xpWWT/0pskhl1PlBocXR1A5sPzW6MnfeWuoJUI186EdKnehaSFiKOOPLeLvNnGDXqZzjV0PBq0NcLjqVBbO/rNcPHqyaFnORtGi+er2MeeElfLU5TatB2qndjUpc9VSfSovcdY6IglhKlaVBsP2JTZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dF6Ojwep; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8LTG4022741
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4+wFXC1bMsd
	mzWY8JLHSnVTpvfhHOd2YnF+XgmDrNUE=; b=dF6OjwepdyGx1dXEVufFycOnKb/
	ItyIxgcs1w7GpEbg7vF5ezZdLy19lZbOwoZoYaWaWcie3h4P4Zy/YTsC6nh8xmjv
	H8YqoUa7CPUWm7ljtjFVU2qFCnAXgVWh7vsGn8kK0YV45FRAGBriknmIhap1k7V2
	odFIu0W6YMaEfphTLlKI5kvCzOMdL/oozLKIE29Ic3LJJpXyDH9uObOVvgZVStcS
	bOISN+m+9wzZBqa29Nn9cqeYOwRgJyqNl9RvXtocptUex7TGavfAFA4+so3FTQIk
	hNeATWqXiftr8LFV3BgE4sDMACaE8TmtgdzKX8Y4mkMGg2wFuDzUcMGP1Hg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jgxtckj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:28:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a9289baafso86631276d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755516506; x=1756121306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+wFXC1bMsdmzWY8JLHSnVTpvfhHOd2YnF+XgmDrNUE=;
        b=ZB1I/yT77yeJfLwMIa99SZ7Ze8VHgHJKImEPuB44oHdbj0QqppJEDeTK84xs03IOts
         jAFMXXDuuRyGD6/x7QV5WpHnGDpo1tfWNZebP9y20I4W/EsnO4sEfgzCpPQTi6iAvAPc
         fWH60pRvdxz7P48N9FhpziS7DVBB4mac1egUBYGF8rrCXsp6Uy0+q7pJi5uqpWCHHMsw
         0ZFIUqO5UY/4ML3zMNliV2b5QeR8PFN66+/TNiZjH4z7VP5jfb+0UEJljQxqo0uq9yoU
         OOkZDrIHWhApqiEtkYP37+Mh2f0H5tbqD0WX3KsE+tiGFFZ9X5SzlZDQdQKXpSPJGOcf
         BlRw==
X-Forwarded-Encrypted: i=1; AJvYcCXur0vJ3uO2j0mJRmQPR00nGrJ4cQIs0CGtt42resdh1sEPqnRnSC90SiDzjN0fDa+cTiKNjJwFPd+VPh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRV7x2Gqygf71oFx3OikrAesAwldB2/zM28MRUzrBBSNfCmCHR
	qG34iPGvZSyO0EiBqtupn2XQrnUZ5sWO/3x/VdLIbhpAoDekq3yVDatjPlTYqfS/8kSl2nVMfY+
	Xc/kKM7AhSF07C9PQEDNgBc5NQT485LJss2aqOmIKJC2Vw0laZcW9gBrujQPKpVdQmhE=
X-Gm-Gg: ASbGncspovlzAe+YzbUdBqXGCcI6RU2Z6o0JpGhyEZzN6mlcdsnCrRRthttRJ6kwvxL
	5J3jn5wLLCYNAXieZFSnZWQnj1UE6T75fKxdoA0s9My90/TUMhtFa8lD5X7pNS8lEsqGsGQRFjk
	/BQAtSeDRN//SsGNOpcN7HSyG1AqFMg+mNi4pANRA/Mdxc0VpOZMQ3QDm276C6wdptWZ5eZN1c1
	VrHE4fpjPOqUhcXUKMNMJBYZKlQqR1rCSfPD9RQ00HdSXN/HlmaH6y2EbYvMBBBLXxer/0wXGBS
	qx/OE7wXBe7pfZ2eKjvyX4rije9g5rGubJ/n5XEhyCd1Ck03hr9wrg==
X-Received: by 2002:a05:6214:1c0c:b0:6fd:3963:7a7b with SMTP id 6a1803df08f44-70b97d16604mr204923676d6.1.1755516505542;
        Mon, 18 Aug 2025 04:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP+KiptgfDG6xcoSSl5xxCTWMuHxndUXFTpZBE9EQe2O3f18HVCgRA/uELxALMM5far3YWvA==
X-Received: by 2002:a05:6214:1c0c:b0:6fd:3963:7a7b with SMTP id 6a1803df08f44-70b97d16604mr204923406d6.1.1755516505120;
        Mon, 18 Aug 2025 04:28:25 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22321985sm127555275e9.17.2025.08.18.04.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 04:28:24 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 4/4] ASoC: qcom: audioreach: add support for SMECNS module
Date: Mon, 18 Aug 2025 12:28:10 +0100
Message-ID: <20250818112810.1207033-5-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250818112810.1207033-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250818112810.1207033-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wLmWsobRtkc1YUZdU16eZXT1v7zipmgV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX0Rw82hZPApmT
 EvyKJ/9cP5Or1IMmC425X1GaC1yK70NhpB80BPSJybEPBOirW9oN/LZm3D16+6nErkEClUIsXPL
 AdxmjtJuyhqh/aHaViAxhi036mJlTdMFTO9hXsJlQAAt7FIum4tQG6Wx3nAN4NB9j+YJWddF8jz
 FSGxJdAkC9swAoMKw9o3LhGRGpEpKgDvNoS35Ec4E0H6EZDJzOuXvWKYmyO2CLuc9BLnAKu/nhI
 iqNOYhmW/DfVZrKV7g5lIRn63d1+UvoW4QheDpUtNFgCUohRua1krQ6qacM8rrNRxJ2RcoErkn9
 marctKLs+n8QH+rnjfGGCj/LXhhSO9LKN9dblE38HEuiJshzBH14607mU3zIx97ZdpqxFJhpuE2
 ylWZpcLi
X-Proofpoint-GUID: wLmWsobRtkc1YUZdU16eZXT1v7zipmgV
X-Authority-Analysis: v=2.4 cv=V7B90fni c=1 sm=1 tr=0 ts=68a30e5b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=oi9uD5rjtjE88QS_ecgA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160020

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

This patch adds support for Single Mic ECNS module, used for echo
cancellation. It also makes use of audioreach_set_module_config to load
the calibration data for this module from ASoC tplg file.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/audioreach.c | 27 +++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/audioreach.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 4ebaaf736fb9..f4c53e84b4dc 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -811,6 +811,30 @@ static int audioreach_gapless_set_media_format(struct q6apm_graph *graph,
 					 EARLY_EOS_DELAY_MS);
 }
 
+static int audioreach_set_module_config(struct q6apm_graph *graph,
+					struct audioreach_module *module,
+					struct audioreach_module_config *cfg)
+{
+	int payload_size = module->data->size;
+	struct gpr_pkt *pkt;
+	int rc;
+	void *p;
+
+	pkt = audioreach_alloc_apm_cmd_pkt(payload_size, APM_CMD_SET_CFG, 0);
+	if (IS_ERR(pkt))
+		return PTR_ERR(pkt);
+
+	p = (void *)pkt + GPR_HDR_SIZE + APM_CMD_HDR_SIZE;
+
+	memcpy(p, module->data->data, payload_size);
+
+	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
+
+	kfree(pkt);
+
+	return rc;
+}
+
 static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
 					   struct audioreach_module *module,
 					   struct audioreach_module_config *cfg)
@@ -1247,6 +1271,9 @@ int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_mod
 	case MODULE_ID_DISPLAY_PORT_SINK:
 		rc = audioreach_display_port_set_media_format(graph, module, cfg);
 		break;
+	case  MODULE_ID_SMECNS_V2:
+		rc = audioreach_set_module_config(graph, module, cfg);
+		break;
 	case MODULE_ID_I2S_SOURCE:
 	case MODULE_ID_I2S_SINK:
 		rc = audioreach_i2s_set_media_format(graph, module, cfg);
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 617bda051cf8..2ae6420f4b6a 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -30,6 +30,7 @@ struct q6apm_graph;
 #define MODULE_ID_MP3_DECODE		0x0700103B
 #define MODULE_ID_GAPLESS		0x0700104D
 #define MODULE_ID_DISPLAY_PORT_SINK	0x07001069
+#define MODULE_ID_SMECNS_V2		0x07001031
 
 #define APM_CMD_GET_SPF_STATE		0x01001021
 #define APM_CMD_RSP_GET_SPF_STATE	0x02001007
-- 
2.50.0


