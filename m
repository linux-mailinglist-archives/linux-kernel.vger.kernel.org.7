Return-Path: <linux-kernel+bounces-775368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 407B9B2BE62
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE7F188A197
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25C63203B1;
	Tue, 19 Aug 2025 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fCySFX0l"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B831CA74
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597726; cv=none; b=ZQNz54m3KHvs2GQWU9P9nZSwgMsGRAlPkpD6IOYTcjRE+xz9x6Z1vfG8ZK5ct7CrCKLgm7xhpHFBS7aN2+ZA4/Ytm26Jo3b756RvX3Ktu+aTMRf7SIq6YYb+vMyrrdrYidqX6BkwrRGUpLAVT0gTz/7kYKXGQOIJkcMMczUESfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597726; c=relaxed/simple;
	bh=qwuYqZpPtHuX/2WTSLKobMX+4muge/nS9jt2JifQjdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9O84aKv6eSSCfBNTB+t7FqnvcvzeGpfsXVCdR/1zb3qWSc7+7dEPKMMLQXcco4lQyQfbFg6TWjEM+m2qRuEDMWjCAOUY2eMRQn+EaqEZKsVmDB1rNSAobcNyC03c7IjuAApZevrcZVWD+j3NDZWNwPhHabh09HPMWAFMgGM8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fCySFX0l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90YrH000864
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JQBp3mqbspP
	8PIJt9/SllqFn7BROE0fyDwOwOB0VX5s=; b=fCySFX0lBg0IF8kYEhPZSBx1NXy
	UtuWMpj/JL1ANNPTGLiSk9ATBo1G4+2bmbER22ZIJKm2KaGlRo2EWMJzF0Phvcck
	bygvV8eRWqc+Wc96WGyG6f9SQngJ6IaQSnuTJ68oFmyJWMslGe/BMxZ75KMo6+e5
	AEoLzYZJrZ436itcTEzqeSOY4zpYbttZ9kymm2cISb/O2eF6IjdaHvs6oCuPSw6J
	ChPT41MJmp/xjU3jIMxTiekkfoLOF7JRJU0sML4WZE8UqllyNDkULgZFhnnazW7L
	IWtgHXLYSv0qMoYvYsy2lchjt8s4iC2U/4vvL/t8tP3xpewbWcxZ7DgOpKQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh0783nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:04 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f6346f8so109414316d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597723; x=1756202523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQBp3mqbspP8PIJt9/SllqFn7BROE0fyDwOwOB0VX5s=;
        b=rzmvMSZGbPoqRtv0+D3TmPNDVGokK5G5gtSpgp8dnnv8SU52VwXNQ/zIJP9TzCwG4H
         suVrneFt+kdBnzrICJdwV2Mv9AA7J9wM4OeFAeBX3AqebZimIxNw5PluAwSQwQ4DMPlr
         CImnR3UDC4sUUH6lM4VgKO8d8LETiA6X2jpKoRujnJEO4d/JfeqsWfnxzAmslMC+uDfI
         +a7SXkz907Gm47sl6ngXhWYULNsXhYoybshnUuMxSuJiWsXEM01H0TSq3YXgeOUdw0Ad
         3dgJqCDf5kcm006BEIA7s53yhgi78JCZO1zcLhDMGl8+vDo/lFYQ4tlc3rv+rJKJvHoz
         dJrA==
X-Forwarded-Encrypted: i=1; AJvYcCUso1noLhb4YRTXgvJodKAy0hTWinfl7oymhaiztH65wOMSW0NEMuDzL/b67V7lGbxRBiUdg33D1ijR9z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyNxScDsYbfPROQ7ZLpFoB31jN3zvLpM0lksTawDMzqvUvmC8+
	f9h1rltgahtW5uT1ImLg/DTRfaTaU4lX1fZHW3X71pNpso5xZnRrry5TEpcOm6VUPYBiCv/QVoq
	V8mddt2qNtmDD0NuT9Wy6KcLv9J13uwZZsVhLQrVEG962+M0fUmzPd5XjxqYm3pphMWY=
X-Gm-Gg: ASbGncvwWOaJLmN0JRO0tOuKfxUwMPB2M7PhcpRF/Sttdk6xBXuJQSoSN5VnrSDC6Y+
	FCKrpwCbL5bpto3wuaI+iezPQ9Gj+KPG4yaI3yK7tcPCfMtxM43BG4L9ROaWYCMK0ovpFqFtMip
	rVI2u5VG2mE5GcufwcZ12N5QNNH7rhphHGhtAici5CgGqHxuAn/CaEDLN1F1IyOIeuZOyO+fy9Z
	bux8vc40JsPKXIS/m2E27kMKxr3PEUeCvnQb+l8ClF/bih5Z8l1omNbteckmBwd+7ryJQS2pW3h
	kgKIed6eGma1Yaz/OqaCmpRviHEVr/4rCLalvyKPH+rgkHBrsW/USw==
X-Received: by 2002:a05:6214:4111:b0:707:6306:28bf with SMTP id 6a1803df08f44-70c35bec101mr20643586d6.36.1755597723217;
        Tue, 19 Aug 2025 03:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDnsU777ceQUX7Q+wc1HqFoZgcHCLcDM2iUFymWXoFmtr9FsHvy0tyalhDLoICjH/DbldWzA==
X-Received: by 2002:a05:6214:4111:b0:707:6306:28bf with SMTP id 6a1803df08f44-70c35bec101mr20642666d6.36.1755597722416;
        Tue, 19 Aug 2025 03:02:02 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78b410sm216169635e9.24.2025.08.19.03.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:02:01 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [RESEND PATCH v4 2/6] ASoC: qcom: audioreach: add documentation for i2s interface type
Date: Tue, 19 Aug 2025 11:01:47 +0100
Message-ID: <20250819100151.1294047-3-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: wapTMrRzsM75fZZOxhd5uGLULfReGc9e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX7aX7QrPO8pSP
 rkCkAypPyql6a6FDceahV2ZEC3/LN0OUkvnfXPJdbddmZPSC0IPtb2XG8sPs9MKJUfcLCZEBceH
 UQ/iL1Foo7M2AVBav0KQNXPcuyr3e/BqLpzn2lgPuUvCanNBOZyiFdjnQ8WGXapdrgvapmNHPto
 VudF7hRUkuXHMx4pwyJVHvGLeWu9qrJZuZKk7MvqTSCK3EWLbY0EDLbA4RWbtdG5bWmWn9Hib/P
 wA3xLBqFNxE4kQzIbJ9z+SaFoCTTuiJprx9be3siM+BA1cHH/TBxWf2EfbpbDDSAx3g6MajMzLq
 CUL+dAQEtyFeRhHbEPq+Jc/e8wi+Z3q1dF9ONGSylNiRQNR5C1Ip3wVA805igDL8Vj8Zy7FFrzQ
 I2ckt0jg
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a44b9c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=FY2npp4C09wRtmNKfY8A:9
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: wapTMrRzsM75fZZOxhd5uGLULfReGc9e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020

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


