Return-Path: <linux-kernel+bounces-803195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2910AB45BED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5CEA68460
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935C331B832;
	Fri,  5 Sep 2025 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mkhgop2S"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE631B81F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084739; cv=none; b=JDIpp+Wheao2GApplRm5rCCKlv/hFdiymCzov5m9pjLpfR7m7JOV8cm3tt+LLN35IbmwEDAr+QVA0Wm+5bEkWU3Isy1opE2h3Ss7hl2kH1Tws7Ti8gFxRBeRiF3JU4Cko5sr3rPfpt9tlA+iBZoiN/kX2y0UXg2l+y9Ad5Uy9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084739; c=relaxed/simple;
	bh=MoCMuDXvh+Nu9b2vpvZYjT7oWfQjMy2t9SXDsBDVWPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BFviU3+oAUAsWILC14UdjwhzNcmO1h5zbCexSTJzK8HDvGvE7pf+siiaMnfBOlNUgnvleBMs8WP4ylHo43kopH6p1BPMpI5N6/+i6IgrASSquG3shmr6JsUQSSbBH55IhXTjifIOsikP0KVWEYVVxflucmLpk9m+GzBx0V+H+jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mkhgop2S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857DO9f002342
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 15:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ja7IG9owaxs
	h1UgdgM/0Skauh8Aewx5qIfunpWQiINo=; b=mkhgop2SOMwXZsAhrA4ValusQS3
	b069AqqecinOTRO/4cniy0P6p0Klumic0LwYbF138VNr/g5OWfpMdz0cWVsXTK8x
	oFm+U7k4DUDbhxjk3Z/hp9uUgeyk4/gwVdDbWhmqTxOV36ngbiav62MOMGPbCp+S
	p3GpfuU06W0CBBmipQukZwvUI6YB1aDeQIcCCyET2J1ze24G8aQx8C3sxV5MesvI
	btc+kx6+VvuI85tgGLtE22oW9Ky4eWk5ozTqSQEnXaEvqGJ6DbImr/6XD9ia+b2U
	y4Xljfh+Mb6BPSeFaDpUZey9tWBcw84yj4p7x+QAvL366SIhislhk5uXFOg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush3bcp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:05:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3280d0d4d11so3285126a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084737; x=1757689537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ja7IG9owaxsh1UgdgM/0Skauh8Aewx5qIfunpWQiINo=;
        b=U4lCX3gXXhpHXynu9fgNFMnFO0Cs3OO0K5VaYivSGrj9garD60iDoWSWglSNMe7n3A
         VVMUi250iSsTyTzkiahqxdd2g2faFLcciT7V8GdMEbzUlQUExiR+nXrl6WHQjS6jRWL4
         zVeb9rA0NwIUXrrQOBYHaP43PQe2V9X5ldO+3EQuUNgGMFL+ML+JDbKbHtcWH+hWDglX
         wgRGJJ5YczQLPr+aubJX0rCbHhkNckHrujYl8lw+eq+9mjZNhCL+xrqXvMZOq5YGIldf
         xQ59Z9W8d4z/HXpppkN2BmroqLNLwVXQm7u6/oBO/QKmJhfH9ydoWIB2YyCWFHByMh5+
         9OLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPo1JdUEotOX1DbrgyAy5jpdJaXlQi30ozhfLSiu7CB0XpCfsNM0ExpAbEku6KSNM1uTWfWCvurGydFQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0fLMskn5bTQVdTZWJadhtgwvQjlseFdVEQVgEredpIz4VfcYo
	bu2DHB0TbZDM0/4txtP6JPasT5/tibVdw1mV9Erk5jqOgnOcf96WgLNSI3JIAafgF2nc9EO9ceR
	R0pasz3umLzG+B/3bqXbItCyMOQVwRrQ/r7/1FshAp+LJVPlbvye2T1Jp3TkeZJmQuxM=
X-Gm-Gg: ASbGncs9W18SRXFgqqz0wHzjkqKZ1jh18+e1rA4j2kRGef8jBKgmDDUe7LbJJZaWx5P
	Vedy/RXdFVbiah22/juzBqG+ZwOsQDkJozOkrPOodTq9QQz8DsnJE+Q+JbJAHQdWiIOMw2ZiP6R
	k9TajpHm1n3bM04SkfsnfmVNkbVoW1bSfwkj3oBtQsNYTkx2kirohaXcUG72Ola6nvvOWX5QAE/
	TPEXfNN9ueSAVAP1ArRK1ZqxmbmAV3f7i2ZpLQTO8UZmh2kd8Li4d5FIMNJQAe1TU90vUhovFD8
	1gK5mWp3tNy3dCAHQEkWiZG/kHinMZh/ild2sQMBt4+PyGulBAcLFKqMQ/ltrsFPdXDP2SC/r7E
	/
X-Received: by 2002:a17:90b:4d92:b0:327:e018:204a with SMTP id 98e67ed59e1d1-3281531d3e3mr30603489a91.0.1757084736551;
        Fri, 05 Sep 2025 08:05:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqIiEJYnj8QbW+Wv6u6rEqkieOl2LWNIL2cqibUoeZ/H246F4m2n7ChcRg2w3QOWU4GeqyAA==
X-Received: by 2002:a17:90b:4d92:b0:327:e018:204a with SMTP id 98e67ed59e1d1-3281531d3e3mr30603424a91.0.1757084735781;
        Fri, 05 Sep 2025 08:05:35 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcf04b8sm28882840a91.26.2025.09.05.08.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:05:35 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 2/3] ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S
Date: Fri,  5 Sep 2025 20:34:44 +0530
Message-Id: <20250905150445.2596140-3-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX2QmPqQWHyC/r
 qcP0j7OGC3eMY4TWcmcI7fZzi/gUTVJb732o1s+7H6sJD55tRkFIUszL+k8uSBQttVkW7VNZEsp
 Hbia8xeiqWivgCQAklCKNTjEkmEP4D4mK/wKHesKD3Byafga6/6lyPPO2sJqEqrIhZ3Jt4WL8R6
 W5Z3gBurcAb1ogcdNhDO58CwBCzNYD3meKhbWP3XuZxT9Dxhr4BXX5LxlworXUxJaV0HJWDKWUd
 PkvB9o/ExLeWB2k8StqKJLgn2KaFUzLwOuFA6GUTxQzj9H/kpmquKHwnp5ZfPz4Fo3dK5oi2NW2
 63hJA+9iayY91m80dwLuNxBsclcuq5R6RvLMCcxa+fGkD6KQvSrQcAaWdAjQAih1X92N2i0v1ea
 6mxY1+j1
X-Proofpoint-ORIG-GUID: 3JSmbc_XTQ-L4Li3mUf0xG1akryxrenx
X-Proofpoint-GUID: 3JSmbc_XTQ-L4Li3mUf0xG1akryxrenx
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68bafc41 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VUbThP3hI7wIHPtXhhgA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

The q6i2s_set_fmt() function was defined but never linked into the
I2S DAI operations, resulting DAI format settings is being ignored
during stream setup. This change fixes the issue by properly linking
the .set_fmt handler within the DAI ops.

Fixes: 30ad723b93ade ("ASoC: qdsp6: audioreach: add q6apm lpass dai support")
Cc: <stable@vger.kernel.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 20974f10406b..528756f1332b 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -262,6 +262,7 @@ static const struct snd_soc_dai_ops q6i2s_ops = {
 	.shutdown	= q6apm_lpass_dai_shutdown,
 	.set_channel_map  = q6dma_set_channel_map,
 	.hw_params        = q6dma_hw_params,
+	.set_fmt	= q6i2s_set_fmt,
 };
 
 static const struct snd_soc_dai_ops q6hdmi_ops = {
-- 
2.34.1


