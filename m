Return-Path: <linux-kernel+bounces-773610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116D5B2A22B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F556208B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C5331E113;
	Mon, 18 Aug 2025 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R4T0PKC9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9399B31E0FB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521464; cv=none; b=L+6nr5pS4PDjffLc4tmTiWvJ+rrtdjjA0YeMgoZfXYKvzrAjU21uUQ1tHGf4Hhe2G5XNMAldPGwePpAD7MBOoj/GdAeftKydkfPeIYG6ukFVAS/SVaxSXurpLCaSXQPmWMV/DiQVYFxvWO/gBO1lgasBzQt3EJFkM6Hi/9sHPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521464; c=relaxed/simple;
	bh=qwuYqZpPtHuX/2WTSLKobMX+4muge/nS9jt2JifQjdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dH9gRgYUVVnfqS9TDwl3xUPfAOg1Uzsjo56hf8zvutOnVA//6i28CTXWfMHHyoEvOqpNfEEHtRF1sGoxL2rOj8rZ/Gh6Y0a6IyyPMeZVbMsllbM+LMAMCgwv+fXLiMKzi/J543EbOHBkOqw/WXyY3H3dfBkl3jKkJ48yR+tOxbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R4T0PKC9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8OlEH012131
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JQBp3mqbspP
	8PIJt9/SllqFn7BROE0fyDwOwOB0VX5s=; b=R4T0PKC97PH4iOPI0xf+XVLddqa
	zLoniuKFqhpwXRh6KGGbcqnoJ2U0GwlJa6A2353sNALQlUho8GF3nwtPqCNuN1TF
	8lZg2Fblzjj73177wGECTsX/sgFmUFmS8hapTtaTD9UCUPrGxscD9MNit3jb9xUT
	SzXjCZKRBgC3v8+Yzi5BmU/aQZdgq7333PiI6F9+jsMDEkfeTDWhX1ZffitjR1Fa
	h3crg5JsiKTCx8rKLbdvFBkfkVZSKHtD6LPp8PEisXimYUk2PRbEyzrZq3gCbBI2
	qtBtA7L34gIyWvwhjiffuMhGrHvAZRmQLk5ilBt/Xu5XTxlcWtaM/EqcpiA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjc7vr6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:01 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a927f4090so97577946d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755521461; x=1756126261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQBp3mqbspP8PIJt9/SllqFn7BROE0fyDwOwOB0VX5s=;
        b=TfF1uNTgfXEI/dSO4LwT4Yq1KT4Vlhq+uTvaakAebDvnJQt4MJeFuo3kY5doTqkOe8
         r53L1s27qx25xB4Wqh3HsIR1tkrv26EP1juEu8Sf4h7H8Ki8DzWo4Y4GSDN4wJtakNxx
         sa+/9vYdzps+OuoODBAiaGz1xGOvMFsx3D0vMl8bkacbvk4isxM0m3r97CLQhZ7ezx29
         JDIYisABmNbPnJHKy4oakFGvc7Sp4G7r3v2akhBg2j3JZIZkpS4zj9M9OULwuDY7XPRI
         tG0wsc/1SowgimGNywm4xf2DTxECpuPy831nMfvuPi0FT9kxzjI+p3a8gOndS1SM85nF
         XD8g==
X-Forwarded-Encrypted: i=1; AJvYcCXbn1GAJBylwYXVagmP1SQM5LOJ0+snGdVafBn34/NJOP2JtML/aH28LZtD99iAx6IHl2axUF8WGDQMTAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpVcPeYbVrTEI4gZqMK6xrb6TaRNDynxQNCjbJxbOjG/H797F
	TSHo+B/KtWlqUtEm7ph12G1Zoye9QTcLQIZah/GwMNJQci4YOFJ9yx9jlXOMQkECnLJ5Ra9tjdD
	6TvvBtxLFE3dEovLC+YfNrgFL5V4fcxurc7HetI4hZ3H/iH+0Vy78FlJGW5yWx0Gsb2c=
X-Gm-Gg: ASbGncvt6WjM/J+AESKxy7Up1lvXJJXKEIVPLm+ZqpXMxTPVt7TIoTq80vOy7UlNwRL
	nEDC4sM1EkgmD2sGpA2xfwXfS25TznZhIbmnL295sj2Tto9zUcrflAFX82oyH702DggDspJ1oeY
	ygS7VslK9SDr2SLHMJ/VZNOg/UMAEhBpZ5uwPdq3XKxLtWorGEHqlbeD2HKwJ9PNTeZGVqVW/eF
	WzGMLcpDxbozyGPjsNp4iYEhudhK2HZMMEHRTr/bQbc47xCRVSG+ZLPn8hiCeHMRYN2sAbIw8El
	t1rgHS3YB7MmchXEdF2/ss5Bdm0lxxTBWy3a6QWWrHDIyJbG7Ak73w==
X-Received: by 2002:a05:6214:21e2:b0:707:5f39:7808 with SMTP id 6a1803df08f44-70ba7c72965mr160275756d6.36.1755521460451;
        Mon, 18 Aug 2025 05:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmINqOZa9cT2dkO8FkYzE5SIW/vFiqJlspoaNnd9of4SYsEEeDeM5pV9K6+JyP6AydBc8euA==
X-Received: by 2002:a05:6214:21e2:b0:707:5f39:7808 with SMTP id 6a1803df08f44-70ba7c72965mr160274886d6.36.1755521459128;
        Mon, 18 Aug 2025 05:50:59 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9b27sm12537347f8f.44.2025.08.18.05.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:50:58 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 2/6] ASoC: qcom: audioreach: add documentation for i2s interface type
Date: Mon, 18 Aug 2025 13:50:51 +0100
Message-ID: <20250818125055.1226708-3-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX4RlR0rcOkqKg
 BBLlp9D5sX1R1F/hcq9rZnVsk2W2RJ0XF9/FtS/qsY+Ds7GgeOcmgcRUYuk1uafheTSqzpSdmfd
 w/nvMJu29Z4ipDblqd9yAqiNL0NbRbrURH/SUFkcEgPa05AdLrbor9SItWYLlZcel5Y7v8Kf/Ff
 wZu4P908sD1J6rid4Z7uyaa2HWUou5zefcUeHV6hBywUbjMKPxQnvT5D2zTxSb0bCNY3sE+kX+t
 m26uwki7Fyp1NFhJzt9CRDNd62i1pOnvTz3xQ7EHRl1w1V4EZZE4wV1EPjcE5eZdDsAV1paOfnX
 sPEJsUFc+26peeX/stwPExUsAmUkZtDXPOColVhVMa6h9wH1PMKC6qaplfj+xNut5WdlIKjl5f0
 7t8mpGiT
X-Authority-Analysis: v=2.4 cv=c4mrQQ9l c=1 sm=1 tr=0 ts=68a321b5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=FY2npp4C09wRtmNKfY8A:9
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: quAr50Sefm9OtQbxkWWP4CYRm3wcxpzS
X-Proofpoint-ORIG-GUID: quAr50Sefm9OtQbxkWWP4CYRm3wcxpzS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160033

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Add documentation of possible values for I2S interface types,
currently this is only documented for DMA module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/uapi/sound/snd_ar_tokens.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/sound/snd_ar_tokens.h b/include/uapi/sound/snd_ar_tokens.h
index bc0b1bede00c..92cf72a6fdd4 100644
--- a/include/uapi/sound/snd_ar_tokens.h
+++ b/include/uapi/sound/snd_ar_tokens.h
@@ -118,6 +118,12 @@ enum ar_event_types {
  *						LPAIF_WSA = 2,
  *						LPAIF_VA = 3,
  *						LPAIF_AXI = 4
+ * Possible values for MI2S
+ *						I2S_INTF_TYPE_PRIMARY = 0,
+ *						I2S_INTF_TYPE_SECONDARY = 1,
+ *						I2S_INTF_TYPE_TERTIARY = 2,
+ *						I2S_INTF_TYPE_QUATERNARY = 3,
+ *						I2S_INTF_TYPE_QUINARY = 4,
  *
  * %AR_TKN_U32_MODULE_FMT_INTERLEAVE:		PCM Interleaving
  *						PCM_INTERLEAVED = 1,
-- 
2.50.0


