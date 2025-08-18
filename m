Return-Path: <linux-kernel+bounces-773544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 188D4B2A17C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BD55E77ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FF0322766;
	Mon, 18 Aug 2025 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FFClrAg9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00099320CDB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519779; cv=none; b=uj3/xt5wQ2hBciAI2cBJHvRyeM7lkBGfU8CzTklL8PupnmOHTJSBrl2ldBEMdWzgfQqyhjgKLy29YHtx1fUoYix+ROqszct82FMV9itA03nZeRmjvtabV3N7lYUrFowulA+z+BFcEqBKzIsQbn/xdy9el1NibIQzJV0rM0Dwamk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519779; c=relaxed/simple;
	bh=H6GmVGgK5ll2SdWjCCALFf5iXA1TVZUoNq4CRHuxHNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hX/i1gpZXeb5arStlvIODfDa1E3t+QMwmd/22It0DUsmGZqcQwf3T7xZHl0cDHcCFNS8XK9IDIh5CSFXUB8tQqA7MIvzoujx9oT+tUNb8+XgAjs7dZocpaaY8n92WIXbU4ygh3lFK2QnsxFcdTIrAYByzEXqKf9YA90v4IAl3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FFClrAg9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I80Lvq030728
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZxJHrPhW4rJ
	jRlDgxhmie2TsrJx2Ufa63zRckQyMYdg=; b=FFClrAg91Sx5LTeXFhkO6gjnpU/
	P68ISsd4Wh8TOLrL662kM05eiL3SozsQdbehyOcFZSg31OjykYsn2ScF0xFO933S
	nD5GghX6+vtW81qlP7JMx61zmNxliPyNim4Q7G0pBcFY6IQ8nFUqP+WOh0teCVkD
	4yzIHS74eKnR6Kv715Xx7kMD7G0QcaHqucEY5STeImj/0qiEfF7ANkOQ0pqm/U0B
	Asnedfx7oID/2/kzFDp2TE7zqvXkoCXofv0Jn6QwKBiXguOyNhq5MOvJPMZFBeq9
	HGfc5+JU6fld26/2DwvysaPidLqq1ENDxAIQv6EVQ4yBMLzDNBDr+p2XrtA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2ucpgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:56 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a88dd1408so93053316d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519776; x=1756124576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxJHrPhW4rJjRlDgxhmie2TsrJx2Ufa63zRckQyMYdg=;
        b=ACZEGAG6eBzJ/tBnlbV6mFbqVQnFtnrRd7WY/TQgDTeWfFyCVuTuwD69vw4cmdVYR7
         I3DN0AdnDGhsNxmmWFse1OPfIkevLygq/da+2/thuwvQRJUmrg7YnyKZ6CDuKOFwFtmm
         XXsuBwdheC8pSPUm0kHbXreNyoQN8EIxdt9P2Y5evPZejpH7FWtC9A74oDV8vHvGr++5
         VF1INv6XXzUCbt1y2CpqMl56if5O3KEuXYKK/S0TvEiHICgdATsr/MxkLtTIXVB8+axI
         NCByHwNfTuzE7kg96yisDy1Y0CFsXHKgrqh2HsoqSb0A3QuizzpO6tChALhUllquk1Af
         e7PA==
X-Forwarded-Encrypted: i=1; AJvYcCUs2YpdDA/xoGzjSmTG3xN+3ZlQLO9U2sV3Wrfp+Jxdh41f3e1a/6ageHQLmCnHqDSfTmcLsxTAP1agxS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOGdf6y30pFpA3UvbQjSsewRp3xVRUHxTGeLugt9CkdDv2Knhu
	qXt9pZevORvWh54CbTGNfau0XERyu2W3q8NGq8h3AhJPfYzsp3q/cRakZN1S87QQajnUMpjSNza
	iYnZp0VJLDlFbhKSh68IXxmRxLHQTr5yx389XVZ8+3okIpJWUHNfHukPxOWm6pO5HnDiBEhFvnq
	g=
X-Gm-Gg: ASbGncsE6HrgXpj8NNJZGa9B91bcTG1DQNxgWx/1djOOglgbIoLeVhyPcn4MWDClkNq
	6a+BRXxd47J85PkiSr4qGCdgTKEI1vNjADlX8cpPo50fL+25pjxAFPrIaCSeHV2ruhRGbGlMJUM
	rV7F3ERI4rtym78FqF20Uj/cjU5eCY8zAyG8UrHpIXSy+LaICkE/gH7RSYV7fK0fGbjFCzWrzWL
	tpmFi1ItLbjzqydm8BrD5Nm9EnCpWnh8syaE5oGJ7661jSQGlXnDemxi3e4Oa6EUrKTH1flw2lp
	6Al7ZBeTbDL3IfWNjZjEo3l/mGUFFiVTGHgctP+r2Wj/54F2Lxb5Fw==
X-Received: by 2002:a05:6214:1c46:b0:70b:9a89:c2d with SMTP id 6a1803df08f44-70ba7a9a7d1mr128986356d6.11.1755519775978;
        Mon, 18 Aug 2025 05:22:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzUJ6w0ICilwEQ42QLrmeuUoDXTHduQ9jES10B49TbGEQsDe6EUQYGwGMQAw+sADlCHw2VKg==
X-Received: by 2002:a05:6214:1c46:b0:70b:9a89:c2d with SMTP id 6a1803df08f44-70ba7a9a7d1mr128985986d6.11.1755519775271;
        Mon, 18 Aug 2025 05:22:55 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb653f657fsm12601563f8f.29.2025.08.18.05.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:22:54 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 6/6] ASoC: qcom: audioreach: add support for SMECNS module
Date: Mon, 18 Aug 2025 13:22:40 +0100
Message-ID: <20250818122240.1223535-7-srinivas.kandagatla@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a31b20 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=oi9uD5rjtjE88QS_ecgA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: CZXvlRa_-6Irn-M1guwZRMc9uwOuwT3d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX4Jbdxo74qbWd
 Lb1q3xC73+Y5u9GmPxNzeg+Zux4TIC5rsTJLmwDlH4YFyyU3lF2uleBJzMPbEZAJbB/Q3IDB3MF
 9ptI5yNnDCHN7Py5zTPrWi8V687yEt6oaB13fZrijwyIL9rfLXM6/mvMeBrewMbJY1k+hJyDgFK
 hL434ULoCS13YNbPDF9FxudIvqaQE19+8gDZiSOrMIX2Vh/v2tmLSWVPD03c68YR1eNzBu6Z72T
 9mtG6Mj6x4WNO/L+nAzMHu+x3ecTm+D1eDybDP606H4t9BW8xQmitQOeE2EvX9LBj4jDrvXdVZT
 MoyYWBwSxzG7NgCTUB3UZoXRGcGwFf7PTcRbFKPvHUwLCdpzXfjij4aKtdMow0Aw7Dm9Y2b4jHZ
 zeIzJ54Q
X-Proofpoint-GUID: CZXvlRa_-6Irn-M1guwZRMc9uwOuwT3d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

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
index 790fba96e34d..cc45c94f023f 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -31,6 +31,7 @@ struct q6apm_graph;
 #define MODULE_ID_MP3_DECODE		0x0700103B
 #define MODULE_ID_GAPLESS		0x0700104D
 #define MODULE_ID_DISPLAY_PORT_SINK	0x07001069
+#define MODULE_ID_SMECNS_V2		0x07001031
 
 #define APM_CMD_GET_SPF_STATE		0x01001021
 #define APM_CMD_RSP_GET_SPF_STATE	0x02001007
-- 
2.50.0


