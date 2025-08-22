Return-Path: <linux-kernel+bounces-782504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337FAB32159
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C99642700
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7002327EFFF;
	Fri, 22 Aug 2025 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fp3eIFrK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BA026B771
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882919; cv=none; b=CreRRnRtG58SMFv6bRmh0NFAhvFF3f93l9wmdov5PjHNFKPCr8mN6WrGcJV9jzqZzrLHWmgA4Qz71aOlgjMTVaYrl5dvYKLibMZPpbrx6kmvlBzP78QYqKXR8kiwrKaaSifZ+8Eoa7uj65uccLW+Ouj85NsjhxM+cddAk4f+8QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882919; c=relaxed/simple;
	bh=NxFxH1PVJ8Nv0cTYQx5eobKGNaG3ah2F+6A//LoAzKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLGYqC6hZ7KwNLRtMAQP0bIZLa/EMkjYvk0vH5bkwXaUFzon/jkYNs9w4A5ZliSFG3TDj9C6EJnPsqZg+3zknMUJiljMoPGup/8yAu+9feggHJpLpYE6L2djK2PbZHzRauO093mHnmHPRTgU27sA5gW0bmbcR5ALAHM0EXeVraI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fp3eIFrK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MELWb7009724
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yYwBae6Xgid
	mPtjoDgfyrfegas7X3oCKUAh6mAOW99o=; b=Fp3eIFrKYMmEYLEzLt3RrtD9SuJ
	OYvD5kcLR3fLxIs/kCvsiC1bemUZexVLvW1/jwK8rku4TP7G8PKgY6YEMdpMtSod
	NBfbxawkS4NUjUviTZ6Zi6VL+Q3H9Nxb6cdyx3v8MYaEx/7DJDh1VVfZaesIyXYA
	BK9LsncwgMOftemUruKOOc+ArVNrReASlw4sLZQ548Id9nz1p/vA394NmGeG5SSi
	aODjBpXpE+Gc3CLY5Bn6oOCp1gsghhPRPGtHPKGxH5qhM9hNpfC3Qy9Vp/OH4o+N
	nME5JtgUQ392E6spotrDvwwHcTorKBWY8TJjje/IZtXP9EOKgIjfl4kOHKw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48pt7vggx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:15:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3251961140bso1103676a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755882905; x=1756487705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYwBae6XgidmPtjoDgfyrfegas7X3oCKUAh6mAOW99o=;
        b=k74pPnKcbs55c2EIeZ8d4fLZoaglPCx7b57Bg7VJ4oPNQeSEMvFtiKpAvv8uQgHRmf
         dimZS+ZZIOVjq5uzefkk5ApV/cqnVqndzB5i2utPd/gGzgkUMBGf3uQpqS0vk+TF7id7
         3EzQx5nFlEcpqCvSGASmkl01Gnsx/UsJqjuF9oXn0goCwLTvgu7vFxcovrttvGBE9573
         XDiIyaOP8fiffYthBcxtERkWmowePZzDiOGCLOE+2vhqIhWIlY3kJVPVWh9+ieHC3snM
         8iW1NVJobSYHmpvVEXT+CjwYMyv5QemzG7Y4c0z664PrrCR0QTEpCowpAg5kcNohfdEM
         scSw==
X-Forwarded-Encrypted: i=1; AJvYcCU0jf7ipzipz53oPWz5g6VTh12Hm6TlgSU1lCzo/twpox8+GgXX5hw0vu5pMKqTGzIC7NkJYw1plshBXGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM37mUwcr85C7qXWqIro5Igmj5l5n5R2qhmfKI08aEW/VJpSgz
	4679KnTanAICK1L4D0GmjqRTk8YCMtp0eeOtb5a8pNpyrmWruolqRuqjHrtObK2FkGkdYbyVopt
	0TOF/QuBrmpOzD4FOTpdIUXo8jPNyaRN755rWXAOPIKHNhdT9vBcPLLQaQ7XcYvuaxKc=
X-Gm-Gg: ASbGncsTEQeWODBKADHGS2ys41/mREQLUs77egUbgQl52X8XJexZ+HWd4krmAKliO7+
	mgFOdZpLnvyAAqOr3W2lyOBunTpYDYgqdjEtolqbtKVdzJW91C/enKYT046c3ZYAexovVSC2JPN
	ApS6KDdp1AMIlnr6jLuZbOryBC71HgKS4oHM6lWA+NLd58m6huZmbLmEfz4+QP9kCypLdVCDlQ9
	GkyH7/xff9z+YXzmkJssrQCto+zOtouZkS658VBEk9LfGQ+7znUihTEuvFEGEYUm44xwrI78n3z
	u7FERE0kmYDfLvR79XnzA1Zgr9UIKz37ae0egBgDW3gJpUK0UMhX01YSxJdR0ByhPlF0dHT/ZUl
	L
X-Received: by 2002:a17:90b:3bcd:b0:31e:ec02:2297 with SMTP id 98e67ed59e1d1-3251744bd07mr5539855a91.19.1755882905395;
        Fri, 22 Aug 2025 10:15:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3iOOqhGrWXgR2JO7VR3W11A0aVF7Bxe/6lQtQ8/h7CuPINehM98MxMjz1rao7k09JmOjHEA==
X-Received: by 2002:a17:90b:3bcd:b0:31e:ec02:2297 with SMTP id 98e67ed59e1d1-3251744bd07mr5539823a91.19.1755882904950;
        Fri, 22 Aug 2025 10:15:04 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afc56sm309995a12.15.2025.08.22.10.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:15:04 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
Subject: [PATCH v1 1/2] ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S interface
Date: Fri, 22 Aug 2025 22:44:39 +0530
Message-Id: <20250822171440.2040324-2-mohammad.rafi.shaik@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=ao/rySZV c=1 sm=1 tr=0 ts=68a8a5a4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KhSO6HZblKlzq0T7JtwA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: Blq9qs3UIwRQP-hgyWhoJUvLi4mqCs1T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDEyOCBTYWx0ZWRfXx2tphx8Z/EmZ
 w2m6/2/Bf6stGbNchQ7gY4IBYYRB9qtcAG7gPRHIicLLJuYIIzgJjgsWka6BfTliopfXpyQm9Hc
 wQ1ri4dbDqC5rycZ9giRgcFLmawtdpZSzgecUuZbs9BFimbX97U9nys/IXv9NKvp0YV/4dCQzOA
 6czf24lhmeW5aaAKKY0en4SENfrC2cJQQJvGqF985BocyVdjoUNITrlZUOSaK3MOManMNQe9KyV
 3JOaEUI1pl3H72qjQTT+bk6aOfKy9vRG70HUIxgO6xKDtThvQbpAeLX7xC8wAa3cdxZzhT6DlUH
 F0jl+d7I5TuZGIqiGoCUiOK9/aP5hd0fhBT2FhbWc50ZWZd/MFUAJi1QEnQ3NT238gFtOviym4w
 3Qv43OBs+aY+pIo8Jo9GlJAX6RvdLQ==
X-Proofpoint-GUID: Blq9qs3UIwRQP-hgyWhoJUvLi4mqCs1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508220128

Fix missing lpaif_type configuration for the I2S interface.
The proper lpaif interface type required to allow DSP to vote
appropriate clock setting for I2S interface.

Fixes: 25ab80db6b133 ("ASoC: qdsp6: audioreach: add module configuration command helpers")
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/audioreach.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index f4c53e84b4dc..6d7b1a4b0b2a 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -995,6 +995,7 @@ static int audioreach_i2s_set_media_format(struct q6apm_graph *graph,
 	param_data->param_id = PARAM_ID_I2S_INTF_CFG;
 	param_data->param_size = ic_sz - APM_MODULE_PARAM_DATA_SIZE;
 
+	intf_cfg->cfg.lpaif_type = module->hw_interface_type;
 	intf_cfg->cfg.intf_idx = module->hw_interface_idx;
 	intf_cfg->cfg.sd_line_idx = module->sd_line_idx;
 
-- 
2.34.1


