Return-Path: <linux-kernel+bounces-805070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1951BB483AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988FF3BA5AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E741D2367D3;
	Mon,  8 Sep 2025 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pT+UtsMG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F80224AEB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 05:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309848; cv=none; b=IHTnz4T+fKa6byAGZ67q6MjO2bYNGFz2p9e1vVilPRATYree9rI1g2VqLk9U9MoKEPfOWSRxO3mVCBAPMwrvUgJg9YlVCP4SdsVKfgr+ZWu+86+o376RtFbAJfoPnRO/QCRrarcF2hhx/JhSEcrqi8gvhHf8ARuaDiK9U0TwR4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309848; c=relaxed/simple;
	bh=RhOFMO390kD6vVPQk+wsaIHxpEh7Rl6s/uQ6K6nB+Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P43gqST5b3AtkxsFS4zAn6jkODsD1kTDRxWl4vUSYfQtz+TaudIpwifAsljluhDTM0B0TueviJItDRsREnJ6xKCpakZUabbIHaWf5yp4FTvnBgH4HD5SnYohKz95jbFY0rh5wsWVsQfo6+iQwBhHkE9Rj+pvv/9eRYgj7InbEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pT+UtsMG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5880MSqY024097
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 05:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HWX0jsMcz+X
	znw8DUFwCpjh9opKGeTSObz3aq0hQzb4=; b=pT+UtsMGperxMiWj/SHOY9fBAa0
	RPiePWRqn9AtH3Yg1EdsgYIKWfxAjyiUNfNhfX+H5K50spInLYiRZxdN0U7iCypf
	ltcs5u4bGQo/OB8R2rVGgKuikfA4g7sAl5NapYvuwEZTl0mCSpOPIFb9LFZvhMLU
	w21oZgBPIKet6dZAAkP8Xxdsj/lnCADpl0NnLsYTjlF/N4zewxzhmVwKUxjzjBIy
	J32/S5mv+ByR/4BVyvfMDaphxNBo9GQ+i5BukH7Pm4cU3sAG/sRG5dRGEh+1KWXx
	yb20xRQ7jw/xR0z9xfXS97LPfkemrpL23Ug7h8zPHWbBp3AZAxBCT6ffEcQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8a383s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:37:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4f86568434so3300071a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 22:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309845; x=1757914645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWX0jsMcz+Xznw8DUFwCpjh9opKGeTSObz3aq0hQzb4=;
        b=sEGMVgUAsH9qRlEiCJ6QaM+B1+fM/PCgw8IjGSYUArQPRLejrAlO/SWJM3bixf78Jk
         OeSno62F3okQYIrcRDVvOjnJDhlN4NPrkrtB3VkAAI/b/de95ENQy0jishbvpH6/QMij
         AawhXLe9jInT9x4TOTpUcAg3YZPNTbiYE5vLZByhm4loolPwxc51Hh9WCVq+oL2oeoZf
         tAfmSn+KnrphgPqF2WHF57sxOt7GKaE7rM3As3Ur2V0W37MrSgsZyM2zRLneIPZdNoRH
         M9aycJ9I7bo0cNFhIXPW39bp+RWTlByLAlihcqdpEKZfoYlWIVSHRrC1zzTDBmqYzwcE
         DYsA==
X-Forwarded-Encrypted: i=1; AJvYcCXYPjXW8p0p/E+qy7h+3jln8Z5WtH0NKCdIuQXxYold+L1FN/Ar+fQU4mc8ecWAf+YtNBQOvMcH2U7bCbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxua8XQrwe85tVG2ExzmksyaB9QK8+GIeQ6wG/x9Lcz06cbIBYj
	CbFM+VpleRuDAX1y0Ku3ZZ7BPoxKjK1/2iyIzONTMUciRC28D1T2NRNQqOcKeSZ8Fp8DyT8qdGR
	POr+jWzkYr9FkPtIHXxsw7nwtK2yHS+yxQgsKgmbH4Nn8HpnM97OvTCrNkM6+SPyukvA=
X-Gm-Gg: ASbGncu3srdc8+kBw0rhDeMj1ZATOwR0MX1rMTcnkYVl4ppaq37+asG+hrZo+px7nZ9
	siI5RG4BxDKRQrmMKhOPgeyZBi/XLkjge4o+Ci46U3aWDsFcfKybB8R0pcfW2Epyryrkn3MNH2+
	xheTVZVmm2DHD0kDnMPeEGFo2t8wMLP1GvDRC/Hk8VvRJN1kWUMV7X4drIaXRyrwn8G5sbby1AD
	UNCv2JRVw5OK55ZYRdDTA4ivNbvSa8zd5uinrOJHNVxjg6aNPBAUPEUhwp4zOKuh3umN4Jbaf0n
	YTTNzmSAgPTyCfL19uhPqCw5PqOLKqqgit4hs2VI6Xv9cRASzEhbLB4e5gpR2y36jC04pNoit1t
	y
X-Received: by 2002:a05:6a20:4322:b0:240:489:be9a with SMTP id adf61e73a8af0-2533fab5821mr9907422637.23.1757309845028;
        Sun, 07 Sep 2025 22:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiiCDYxE12pB+bzy1cltbrdX0bzzKGs/EE30YA0O6ftyQUyRTV93nZj0ULHEaojirXrT3w0A==
X-Received: by 2002:a05:6a20:4322:b0:240:489:be9a with SMTP id adf61e73a8af0-2533fab5821mr9907391637.23.1757309844546;
        Sun, 07 Sep 2025 22:37:24 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d4fsm28013488b3a.73.2025.09.07.22.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:37:24 -0700 (PDT)
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
Subject: [PATCH v4 2/3] ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S
Date: Mon,  8 Sep 2025 11:06:30 +0530
Message-Id: <20250908053631.70978-3-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908053631.70978-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250908053631.70978-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68be6b96 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VUbThP3hI7wIHPtXhhgA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 7mtBuCr95tBOdHsWQks_KSlsx-r72d5I
X-Proofpoint-ORIG-GUID: 7mtBuCr95tBOdHsWQks_KSlsx-r72d5I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfXzvQSbtU5uKKH
 WF6NX2hWKI6EUTCmzIq3VU6okPcDSJJRk0ML32ZcTCqYoKOuua9GZfaZXPce6oGSPYRFHpfmMUf
 m8ww21NLMuIyZIKnqQc8fTeNmlvF4OacHvDntFgKegXMud4TGzTx3njxDo8do3+mFKpGZNL363d
 pa5X90UhR5V3g+pgkDJcVRNbVJ2c1BlOVYzXhBaUPu2M/iUB/8Z8Bfp/7S8Re2Adygl1JAWomvD
 /3OBZNNKUF4zfwPZLRCgTIFL5J2kA8Gm1d02Pja4/3+WT0aag340nbMHlT0uP0LvhpXDMBjHXVX
 7IY03loVcF+C/af9Rdp9mi2vgYi7b9DQ9HkiEClkyY6dKadAyV/b07pAaRnm5TiJ7zOJgIbHYpF
 hq7uvpkM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

The q6i2s_set_fmt() function was defined but never linked into the
I2S DAI operations, resulting DAI format settings is being ignored
during stream setup. This change fixes the issue by properly linking
the .set_fmt handler within the DAI ops.

Fixes: 30ad723b93ade ("ASoC: qdsp6: audioreach: add q6apm lpass dai support")
Cc: stable@vger.kernel.org
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


