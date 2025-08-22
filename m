Return-Path: <linux-kernel+bounces-782505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16FEB3215C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810006424B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1BF3375A7;
	Fri, 22 Aug 2025 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X0gbA+Sz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE33218C4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882922; cv=none; b=Ui35xGQFfLy7OK6T4NOnRSc8KsRw1jgcSKIxeZRYuq1CEDRVgGmrA8ZgAi7vJ+CjaKhVdkN8JrgCjLKMjrkECMq2xril0WvII0Hb7QziMCROKlMJYso23Y3Cl/KidoGw6juJgltQFhYFY43L3nV3sGYqtP4tKHvLQC0eo43HuCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882922; c=relaxed/simple;
	bh=xbJwyrD2C3iNWF1DUx952NDNhE0jLbF+XEtCs5+R0zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u1S6Yku59yrmIN/KZMJ2lgOqCWe2O62uDWf66uutgRMm14Q3PuzS3kFOcUsGoUlLGFCcUa1PDZRUK2uGShtfGOOVEIITtioyPPSxjo/qL855+GINrbmOSz4XqU+esAh6a4dgm7HOgSH+wKIskKketu/G3zN2GgNPjXby6tZeuZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X0gbA+Sz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MG9KeT011289
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+8pC070wu4J
	VmBSidlDuszZJEm3cZ5GlOhv5w5ch2vU=; b=X0gbA+Sze2lvQmaQRA1hSjvwDWX
	N0OkRJCkUdBRQS1ekOdununXI6BpbsnPmW9hlHEG3GuPMY6MD7QB5wtBagB83P2h
	oQebaZ50/vtR59DiW3/SFim3Irp7J0QORRVuGSt7pmeAh7h4Dh71RJIZK13AcFao
	+4EMnwYk1pPxkcEYZW+T3u/uCLGrEsOWcrqrYRilTqzhffYqDE9wK7RjVjMqS3M2
	F9L9bQZ/Mr7E8a0g6yEOKx71KrYBTboOdnsNWczgYs2lycrlRL1AInWKy+KcsLwl
	UA1dcAOniDYpz377zn23bOZlQ4OB7XJoOyUFtnlpftlXjcj8Qnm4Ztc7S/w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngt8ftmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:15:19 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b471737e673so3985579a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755882909; x=1756487709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8pC070wu4JVmBSidlDuszZJEm3cZ5GlOhv5w5ch2vU=;
        b=rsO13SzcDUzGA2j4kGy8FRwhHbXok8bStOxwORKocN4W4GGZh5NUZrNNayWPBEodkV
         93K2rlHgI6vvS/l+SrReYdjU+jMU0lIzKrMzWOvMJv7uu7af7f+4btDTelvQIvCkdv0t
         vgdrvbszg9OZYaPEpiXYSqeuFAZikNEHcwN/HY4zIzkEsHJir/oaVUuyBtLZhYmHQ0J7
         SfO7/juFo6ijohC+gmIWI6HGZBcrWpe8YiD0ZTWjQwVhlVJzSPayeHiMavW+kw2rcnhg
         4Xpof9RWzoeY29gXD/rdJE0/oM1mxQzvzo92x0Q+RKtIR9ndLfm8QgwwRoNIFoH1lKkY
         YlXw==
X-Forwarded-Encrypted: i=1; AJvYcCVvrjo32lKkIzdZ2bvSvBd0VCxD6ymba8+iS+/l1UkquG9W3CQaUA39vS0E7DLP4ok3FmpjwKYdgXXW0Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YznAC8XhgPOtH9RdIDo4/7LthRJ2+9adD32zf/sUysGD/QkJ0bE
	n8vl/GNdsT0d7SG0MrDDfHKThcLYezRzSbL0po/T7wbvhxbOXftb2V6DDYWUhxO2SfiFqP58ZKp
	YLkvSUn+KcGtD0ozoPc5vgrM1RHzuFGcWlcNo6KvKkLzkikbDhO61yMFHUVxK36YuIUg=
X-Gm-Gg: ASbGncsfzPWCHvZs2XRPqjnjM+5xrnFynEmo2faAK6cqko+AdWZnN6qvzPw8kPfHBBl
	EceTlSltRPvcYIoVLsy7cDW4f1LsaaSNc+KmH48/tkUyypwFbn+mypzCJsevP6UzWn4eMX5RSBJ
	PBIempRNxelOjK8kmPv7DocsLHJlkvKvTQAvjILSxJAtmwMkxSkN+fEyEcgZt49uY3eIc8zC3dj
	hAjyxk0zdaD97dS7cFWWryCYJEa8m9++4CN25Ou6yeoThjoC4hR6QrD7leOawuW4oc+XyUz4IIX
	iOMosnqgKJwdAopnn0LiDjfUMeMKpyZ5h22IzvW3d6IxMHyWdQELg8vCMAX2VxJJfo22OsQXyrE
	I
X-Received: by 2002:a05:6a20:3d85:b0:23d:4777:49bd with SMTP id adf61e73a8af0-24340ca7a9fmr5646989637.21.1755882908722;
        Fri, 22 Aug 2025 10:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6GuwX31R8qwOZw90/Fag7/snvKPwFqs6UB/eEJ4CBW4sM1BBnXp3rmNLCDtVvZV0OpWE4nQ==
X-Received: by 2002:a05:6a20:3d85:b0:23d:4777:49bd with SMTP id adf61e73a8af0-24340ca7a9fmr5646938637.21.1755882908264;
        Fri, 22 Aug 2025 10:15:08 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afc56sm309995a12.15.2025.08.22.10.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:15:08 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
Subject: [PATCH v1 2/2] ASoC: qcom: audioreach: Fix default WS source assignment for I2S interface
Date: Fri, 22 Aug 2025 22:44:40 +0530
Message-Id: <20250822171440.2040324-3-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822171440.2040324-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250822171440.2040324-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNCBTYWx0ZWRfX2TgFYfojcVTF
 0lzr5kwClnJqQPf1kjtexe0hy1Jz0Uas2WGjNYnQmLQtZflWiKXFBt7yxHZW7ooz8COLpan3/vw
 23V1h+Tf7l6KxGFFC5g5X/zLf4n1YP21Oi7/qYBlEAqEsGFkhw3rAsQUfQPyqlHvmVfHjf1yq/U
 VEZseSD91+JM+xgQLt/D4wlqXaj+MozbcSYS8LDCDYOhgY4aQsjNEhmNu3/Dl5ZsBkStiYwWOli
 +7StwnxekrLZ6aS9w3r1uRV/3QIN9Z5hsgfWHoge1KsJ7IIA3w6ARRwfRAsQiD994L1Z95y8wZF
 lybVZq43gfelqtwtSs0Oxtjik38cDilSpVWIz5i4m+07/AeqZ2jjLYYV20165ocO1caikc4TlPS
 wQ86sRnWA8vjiG53yMAZlBbzX+XG+Q==
X-Authority-Analysis: v=2.4 cv=c/fygR9l c=1 sm=1 tr=0 ts=68a8a5a7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=hSYZM-FDCW3FgKnTnV4A:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: jxampqBVWJv9NRqBOIjJ0yhpn-aDouR-
X-Proofpoint-ORIG-GUID: jxampqBVWJv9NRqBOIjJ0yhpn-aDouR-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200134

Resolve an issue where the I2S Word Select (WS) source could remain unset,
leading to misconfiguration of the I2S interface. A default WS source is
assigned when not explicitly configured by the AudioReach module.

For HS MI2S interface, the DSP need proper WS settings to set
appropriate endpoint configuration.

Fixes: 25ab80db6b133 ("ASoC: qdsp6: audioreach: add module configuration command helpers")
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/audioreach.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 6d7b1a4b0b2a..d4397f75e310 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -999,6 +999,12 @@ static int audioreach_i2s_set_media_format(struct q6apm_graph *graph,
 	intf_cfg->cfg.intf_idx = module->hw_interface_idx;
 	intf_cfg->cfg.sd_line_idx = module->sd_line_idx;
 
+	/* Set default WS source if not already configured */
+	if (!module->ws_src)
+		intf_cfg->cfg.ws_src = CONFIG_I2S_WS_SRC_INTERNAL;
+	else
+		intf_cfg->cfg.ws_src = module->ws_src;
+
 	switch (cfg->fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
 	case SND_SOC_DAIFMT_BP_FP:
 		intf_cfg->cfg.ws_src = CONFIG_I2S_WS_SRC_INTERNAL;
-- 
2.34.1


