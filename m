Return-Path: <linux-kernel+bounces-775372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48910B2BE5F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A245B7B0A31
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0FC3218A7;
	Tue, 19 Aug 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nES4S8Yd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ACD32144E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597731; cv=none; b=rGrI7Fd5ZLIghVzFjvmMcqoLgpGVPlFp1zKKM9Nwn8MS82NoKYTe1biOhqq56CwoxmowNW6u7E19gMHb0nft8bIWU/kNteRzFlVteZdW/6ZPieMyrqm8cILZOD46kTGJCJcEXF+FIxp5X7cbZxy9dm0hYR0N9FCdu63oi4jGclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597731; c=relaxed/simple;
	bh=ZMDj79JNuxpPNuBtieYFiO7WSUV+XTuIRsLUot9Amxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGiYJT5kvTZ7ByLwzRRNr2JmsJFmQkCEZLUH63l7662U+oMjzzFun0ePx3I/ZfZeNimhPkM4Mvh2N9/94rjQ6a6eLD2rxYgl3/TL1inzUBVm3D6uxlcmajVLTq3HTsImFTTnnzXIQvwHhK6IW7IZhsqF7t3WYEMZ2qyAfsI/b5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nES4S8Yd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90ZxJ001506
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7/8Lx/VqzWp
	eiHTffLhRucXrEdQ6j6on3fcQCwM7QKw=; b=nES4S8Ydz8XSEzazIWEdvJ9j75c
	JH5sCNrxH3NhpsNFIL2RNH8dNXaJUjusDsjIUf8XT3NMOxIYMj2IoPM3ztLbiOc0
	0Q7RHSKz4Nd9CQQioLPWgo6iBztBO2ARbuhcbcbxXvzINXxQeZ4ziinMegGJ7DJo
	z9gV1isaJGBgsP/1R8C8v0nHEKlIp6afwmxiRvp793TnmZ5utFzVZtPONwecjwIk
	tI+euaGa9iB4SVxQ4UVYK/w9J9FW1XppOTCUGAXUQAT7leUBrxyuP+x/e39d08G6
	v3rU2zW+tl3G1jgOnjVl8yBOrZ8xjGulexL1q6n5g0jQU0wL17rTvRC2Lvw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh0783nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:08 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f57ef93so108306496d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597727; x=1756202527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/8Lx/VqzWpeiHTffLhRucXrEdQ6j6on3fcQCwM7QKw=;
        b=P2v3Hgkfuk9utqL5T+vpeYFKvaASRARo9FafrAre6ccN2LpbndZw7oE/gBM3urRkIh
         3CvDJZd1RZ18QK8S+5sh6oIBmEYhnQ6+xP7PxXr00eQiM/aj0QHx+bNAzKNT38TqzzQG
         /rXlbnEWDQzL+BfXRzz+K6pGJ1MekoAW+EtM3Rmtldw+Bs4T3FjXHXoWvb5y2+2QSVMQ
         7nYwoox40d2dnr3z1K3Z11+E7kZqquS/86FThkE/5ZelFDrns3LWMkPhK8QD2CXVGu/B
         PahgPF2hn7iPZaXKC2fprvsPbmKrdHQQjE+/MOGU548tMbGF5F3vHeXOY2l9grMppWv6
         JXwA==
X-Forwarded-Encrypted: i=1; AJvYcCUjB/bqcFbNp2cFLNwnvmCknE+fiWOrSd4tAEeY/n27VqwldKO2L++4meLJa8L9g4xtLIXGvXCk665wPxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ZMe4/gYSVL9E2uFQ/cP+azma9rkTo/AzsmsyIzUlWWZo+aKQ
	9/FbTvgmjzbvMw6s81tOOotvmj1oCHRJKBv9bp1bTCyAyabTQVoTkv5h7xU6uhyky6pDP1B01np
	wjGfsV3IgZcxqC9Qzr9zGFat7Cmy3huEoUKrpb3ElDzO6CFb3WUxdFifDyjy4mT5vIxI=
X-Gm-Gg: ASbGncssEFyfpDKjmEmt39CUWdQ3X6d4DskAOoY+oylJ4BvKc53AGla1QTBMRMs2+0x
	PGRiVqpa4v9hEggTkISuhc2wnmt6Hyt6HwxTtxfbH8/hd0TWbQejSn7Ps8UdBa+yfyYT4eRtaLv
	gw4hLp8b5Ir2UmIb3qBUEx/1UB/QL99fnbLCsgG0jYVGrvW8uDFITm8WlilztS/IkBaXv/VfnyQ
	3WYR2DAsHWxKFXx6qOUrYmNGyEQoRBfooJNa5h8OsnzHngKwSbPiToU0DQdCeWqo2fWEHnLRCiy
	NnCN8fBw5TzRRHSkxZ6KSw6vGb5YQ3DJfB1Bg5wLblhOGkObCsWuZg==
X-Received: by 2002:a05:6214:5194:b0:70d:6df3:9a7d with SMTP id 6a1803df08f44-70d6df39d8cmr4692306d6.61.1755597727366;
        Tue, 19 Aug 2025 03:02:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWh5qhTWgsqfNEZP+cI13i59i9FkibSaIL6ON7kG82mV1vAsa6wXLKX/gdx47IIO4me3XByw==
X-Received: by 2002:a05:6214:5194:b0:70d:6df3:9a7d with SMTP id 6a1803df08f44-70d6df39d8cmr4691766d6.61.1755597726583;
        Tue, 19 Aug 2025 03:02:06 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78b410sm216169635e9.24.2025.08.19.03.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:02:06 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [RESEND PATCH v4 6/6] ASoC: qcom: audioreach: add support for SMECNS module
Date: Tue, 19 Aug 2025 11:01:51 +0100
Message-ID: <20250819100151.1294047-7-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: mbTdMbFrJRVygSqt2B5_TnSIUD9KEzXg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX6Fikx398Mzde
 kCaZgK0KZJVNW/f2iavKK+hWfFIJ7bIlQaxOsQTWV7y8ZGKqqlIX+43WKPxwdz54jMjmVrfy6JQ
 GGhjO31yvDiBpQsTFpgYv2dY0f3Ex1vzt+Xw2HqzE9Tnp+skgPRqscLKQ6HNWwM1z1LbD4iIaE3
 GL6MOdd5FYgjyk1nMq7U9sbhR7YB+Nf4BHsyNiYCiEtPsOJZ0I98Lq0vXaX9T0vmowCE8+K4ONw
 C/hOaDaaM7Ue4Ui27jEKxU9zCCcL68J2MBOobCWt7RviluNOyWfd3MmriUyUeP5ajF1qiT4iEfS
 7PmFeHJ/wNXUnBZGo15pSopjVxAu9p+U63ykotIYWB00B3fyBMM4o3eZmB08zB8sYH4ucxgrEIp
 lk2U7Dqm
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a44ba0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=oi9uD5rjtjE88QS_ecgA:9
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mbTdMbFrJRVygSqt2B5_TnSIUD9KEzXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

This patch adds support for Single Mic ECNS module, used for echo
cancellation. It also makes use of audioreach_set_module_config to load
the calibration data for this module from ASoC tplg file.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
index e4babf9a44ff..790fba96e34d 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -27,6 +27,7 @@ struct q6apm_graph;
 #define MODULE_ID_CODEC_DMA_SINK	0x07001023
 #define MODULE_ID_CODEC_DMA_SOURCE	0x07001024
 #define MODULE_ID_FLAC_DEC		0x0700102F
+#define MODULE_ID_SMECNS_V2		0x07001031
 #define MODULE_ID_MP3_DECODE		0x0700103B
 #define MODULE_ID_GAPLESS		0x0700104D
 #define MODULE_ID_DISPLAY_PORT_SINK	0x07001069
-- 
2.50.0


