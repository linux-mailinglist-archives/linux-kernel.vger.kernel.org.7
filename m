Return-Path: <linux-kernel+bounces-773612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD6DB2A29B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A90169C05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D2B320CC3;
	Mon, 18 Aug 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="My1q/iSZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9AB1E51FE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521467; cv=none; b=ivpiLgRkuOUCpxhdH4fhQxvFTfle58pNnMX1FJWo1EnUXWuU2BR/KD8soX1kfbECiAT638jPRZjLasDk5hMvMDV7PNvhyv0i94p8Zo4r7PTj8DksYjAGC+LwnGZyhvXq15s3Z69jz4sv84UZCqz90ZWXf/ULalLiVbQTi65TZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521467; c=relaxed/simple;
	bh=06kAT+9DrliAjxRD7QFhFtzFqp9qtzZsrREwZHXF9Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3Uy8Oey0Rb0kf+Byvv+pgqo8XAg/Lkvt8icBl0cvOh76tbF5kZbmQNKLRK6b7Igdkm/LBb9qsIF8UqJmf7DNSLgd9UM+/Hzc1eXiylVWb0nTe58LfGAk6UgXPNCSG1+L4OSyq5PxCrhQ8Sv23iLE3a/ZTBI2LUXVMmRBc0WLVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=My1q/iSZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8tIlY023680
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PlcrtGDGu73
	MEF4667+AotAmjGL1GbqsP/mPC9bHYeU=; b=My1q/iSZ0h7R1V3/B1w25B0bTwH
	bE/QQmbScQxfXO41caU6nU63cgk1aGK4M9p+8/wWNh7UZ1XDSjNIdjmO17yLP6z1
	YHFNC3tZVKJw+iXz9TWEaVCNEACSOaVvVl+0+RIkYJOUu0IcKrcA6FfwuPcwlX4x
	COMOM5jMq19yg4OqSibBbZEo7IDjtolLPSdGAYwE9xOOwYryQ3u7fIhZjlqYJUeW
	q51VG71Cv1AFDcCIL343sausMyjAycSmQL5/E4FiL0w3UFM4N6m36yP9Ql1QPAP7
	Za5pWyDP4+R6ZVeQFCFpAQ8ynP7ObKGqUqjrDirXFfOasLTFurNKnf/HdSw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk99mkya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:05 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a88dae248so89583226d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755521464; x=1756126264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlcrtGDGu73MEF4667+AotAmjGL1GbqsP/mPC9bHYeU=;
        b=rKmfIAwWPD8L8BYcJ+1JM6rT8iKiWwL/gz2eT5GFToRnaM1y2b1PlbR78DkseZKtmk
         29UrsJQkmTrkVKVvAq0ffynGS88ewQ9e4L8DYegGvEpD7Ew9j/shLIwzrRxNUSR3bnlt
         pVi6WRsQn3tNTxrjVAN+9qDgMoi7xeJGvUhy8UmYuLYcI9+HvQMYUIFZQCh5COsj3b1I
         SCUAqRkuye3GPxNlbi//DPKreSgLaJJrsIaNqQWmgS0s6mG8wb9RB9W4ZvroiGTBkNw6
         7YoGjH+HmfsMZ411M3QFkZoRoXJB4KJOyF2oIj4m7xk4S/Awq41egdGk2L1BKPOXtA0N
         dr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSiWL3AYbqtpRuXcK2sMYwByQkjLzSfSRKKEdAi6dXjRszJcDupxvQGniZn5dJYKvAVHLKl1fmeJR0/V0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6RPpIHiEpnOvhC0nnRb4lngJvlzQGo+jvbPyUvSIxreRW15M
	NvwEhF9VJ0ZnXzelpqH12mpT0IeAOnw/ynuKTyfsAreMrYGE2Q04DWiBx23hIW+B0n9l8Mb3HhI
	GP8FTMg4Rav4zhcKCseLFrBavM7/vYMOcjL8NCn+Tgjb2eQ9KCtlW2dXAvM/k+TIRcQA=
X-Gm-Gg: ASbGncvSF8OPkaAnW3J+AYBXLiDKw5ktlacBfWv0AnG+zbzBNTdL9M8G4/lZYYRgvoC
	yfmT8HJ5Liey03BWS6PbXP6UCeNHxRg7g6YExGKeWt3/shkUF5oySzQQrYVNyyH4EBblZXn7Bx5
	F8IUeDfWCaSKNQHiB30ZuIq9nkOXhFsFgkb7THk70pOAGc3zOjhAIgHNwrYH3BknyCQah22T8Nh
	ne4h4zz7+qq38mI7d8ZQsqD/mHJb32GuGIEDSWnnIZFk34Yu51YLCIOAFpMk8RQtqb8WBokgwTm
	4TbksOqhGmAfoSoVkmYX4b1p67houhM9PIupHAVEd+agYid/l2qjEQ==
X-Received: by 2002:a05:6214:76c:b0:6fa:a5c9:2ee7 with SMTP id 6a1803df08f44-70b97d50e1cmr200097326d6.8.1755521463582;
        Mon, 18 Aug 2025 05:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRYOz34pRV/ltjYsz0g4ZxkrzJ3SwXSzKHny2OsO5Kv+nDB7W2cT9y7QPPd0Q6h+ip7T7tdQ==
X-Received: by 2002:a05:6214:76c:b0:6fa:a5c9:2ee7 with SMTP id 6a1803df08f44-70b97d50e1cmr200097056d6.8.1755521463076;
        Mon, 18 Aug 2025 05:51:03 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9b27sm12537347f8f.44.2025.08.18.05.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:51:02 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 6/6] ASoC: qcom: audioreach: add support for SMECNS module
Date: Mon, 18 Aug 2025 13:50:55 +0100
Message-ID: <20250818125055.1226708-7-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: vV4vgrnCAqNm8Lf-ClWbiEIHMN4-Mcsd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0NSBTYWx0ZWRfX2kfVqsTRyDEe
 BW3WF0EsTAK+MLRQcqp6/mPvKGM9JtVGg4WKSvY6jpvvSXKOx7fdk4Qw7LgZ/1pWVkSGc/dt/kL
 qH7tC9R8EMPZv2RBfISbhBSGtfzEH2uY8XDJQsbhSeOZZ1nQRxzi1/H1cRypBryTAzSrTvlJuTp
 boNVhwKu/x7vi86PoNxm3sfDz8FofFO01RQ1LkOGrbED8XCeZv5OS+IWYRpxPbyyxzwF6s8wzVi
 O6mEHp6IICmEr6fDFEr45UjvzCow3KldvAywNjGwaoa3SyCDC/CfsxjAwAX9NxICmObqbVuVwzv
 t3NrzSFhVuNw9X3Wru+8u/oFz42e3Dcvu/YuhDtu7n/c+HX7fdd5irYAmx3ESqx7c6yPP6oPim8
 kTsDL9WV
X-Authority-Analysis: v=2.4 cv=IIMCChvG c=1 sm=1 tr=0 ts=68a321b9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=oi9uD5rjtjE88QS_ecgA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: vV4vgrnCAqNm8Lf-ClWbiEIHMN4-Mcsd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160045

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


