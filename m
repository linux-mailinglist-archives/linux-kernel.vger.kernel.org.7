Return-Path: <linux-kernel+bounces-876639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF70C1C238
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997BF5830AC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B075354AF1;
	Wed, 29 Oct 2025 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NOOEL8vj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XVIgmx7k"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91085354ADD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753679; cv=none; b=hxOoE8EUYZgPsPFc5N4symkIIgsWU0TBtgKu0isrVtnjI5xtpaUo5YSqW6pAgoOcTrC+hwAuK0iDxg0fycRpVSvD09OOeWaNgh2L2WjsoPyMt4YFw7k+YMYpP6ir5IpZAvpbF9a3SjO6NP/GtmBwWlAh0aL0fBuTsaordWSVgpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753679; c=relaxed/simple;
	bh=iZXJ+wvYSZ5S6EtMrmxWZW14bw4Q9snvePaLf0HVOQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mbqp1CuxPoUs7Id7mY80ri+crvIspbu2TaySzMQCCDHyZoMvTy3zs3+0fkE+BSAwUvOSPJN4rWFTExzNsafnaRJKoGhE9/wM8VlFqzPPUQTznQCdDl6rouFe+MbUho+dj23i2fDxDGG9p8lh0ONJNcuXxmrMvMQ2GePValeAEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NOOEL8vj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XVIgmx7k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TCMBQm3692119
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xd6tUxrDmZV
	yYkpH6AHK/2JkgivGrY63G9FW6CayDw0=; b=NOOEL8vj2NWA1GTOrvp+0hoMfod
	hfSfTlX58IIOqKdai/Pwy8kBLc3i5BtaKYAuSDXg2NLnUiaGPp5PrXmCxs62xOQZ
	TOSbY5brM2mR8uyXCdJdZEgn02oZ/C8mWyAQre9lj+MuMPOyH372zNfjRjHjJOAa
	gy9A5fNxX6GGpSXXyzk7F/XeDQVSf2itzs7KB8gPSJcKnju40EFnpyzUCVNdwkYz
	507M30s9UaqLo62GPbz7YUblmSBh9ZWqHAevCS6DRo9iQfAsurWtpUgqh0rljSfn
	irlnE/VJcBukpfrNvTj4GcwXRhnbFVIQRHPitgpXxEjSfjPi1uR7eLvmJYA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a2k6p2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:01:16 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9310391b032so8195241.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761753675; x=1762358475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xd6tUxrDmZVyYkpH6AHK/2JkgivGrY63G9FW6CayDw0=;
        b=XVIgmx7k6tOB1g0Es+2T207bOfDMISnUl+TOP74/nwgLCLxvvU5StQ2lqtd/+QXONM
         8JW0EA22dX29lpBBxsH+MWwZZw0+/BW43+GhZh9/CmQ1yZHnflfZvIcr3tV62IefKgNR
         q1sJvyH1DAcct0U1KHv0IgJzK+luXJaHSfVXfiWxp+oP/MG5n70ckiHQBByMv5gibqXK
         IZukCfqdPfMpsdki+lFn7H1ET74jivQiJ36GeMSOutUClmnCG72e68w07LLKWpNkJS3Q
         c0hTPeaT71BKVXS5mTiaCIoNm3ZvB63sHwK81E1QRz/nxcU/jw9r3DdCgpp6caf91WSo
         OODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753675; x=1762358475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xd6tUxrDmZVyYkpH6AHK/2JkgivGrY63G9FW6CayDw0=;
        b=abX5SeCzXfP7CBo/asw4+ELUyxu/HZnTD67o/Nda131IN5mEumHFPe/LOXked+mHVS
         2+QOIqrLPg2z6XMas3jFJCuEov49v1XUF07WG7TuwO9PmV6Nvcjfp2BExlgBrtxWC2GZ
         UYwTDFgD3WcmyDNvcPKW3xyOQx6Re11/qc1OtQgDJdvMTogn6u2pZq3QAjuJt18wWs8Q
         FVIqpY86gUfRtiue1M+UnlyPC5T3ShqcBW/yOJUeiexqhB3bVvraqCshKWDlJMiuWOMc
         iTtUaeecEmyvl0KPSAp8jZn42kbUjz10YtsDHgipkgMY8L9jd2vhEJ6QJ0sWDfZXWYtt
         SHOA==
X-Forwarded-Encrypted: i=1; AJvYcCUIu9L4svIXhCcFRKYygjmKj6zpi9mmgVaZTkkWT2DJse1idA2Ep1eSjXxgxFbj1Bpon42bl4doG3n+Kyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6z0yuBIVNvMQOuUWJQElY4j818jMLKstJm2eSHDurvUHofOC+
	ukCpU3ABziC585G68eHdvXLqQNMunmLC+jmJzc6fPGrldCCnuJk8nBPyXlyMy3CwRarDyLKWNon
	RbYaoyOhyS04oRni8PoCXe5iWwrfif0uRhevRnzYL28grdJGY8nvoWV2gmtUJB20FNgyYh1nHqV
	0=
X-Gm-Gg: ASbGncvt2ka2BN5nCYe2vevYfoDrfyjSz7XkR856Eq+5r+FWWs95crICiH1U06OTQq/
	DUgMkkgkkh9qLSB/CXZBreB8lgCRfmmjPHgaE6ko+jhxyPoGKlCgNdAcIP53ahXMZ5I8gRogvF5
	6+/mTI+yAwmBwvRF7mJKAXwxsMjPcWvNfbLCAptUMQguPPQaYAAEJSwjnpiRQBMJuF74pJnNLwK
	m2sDrCv1HrAk5e62vTYnQ1ld28BHVjBmiZNVNS31zSbeDBe+mN3PLx982ujKQkR2Jr0nCpEfJMO
	veLkopvghDW0ZUqUdjwe+/yklKdVcY5YeXvf6UDlLiVHiuwEUAhyAJaN9IvCXZ1wuBsnhL81TsB
	k50+d958LqXYy
X-Received: by 2002:a05:6122:1d9f:b0:556:4f4e:812a with SMTP id 71dfb90a1353d-55814105b1cmr1156456e0c.7.1761753674909;
        Wed, 29 Oct 2025 09:01:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmMyq2OMke7b4038qoWowzNVA9IP6dPgXk9UEoB7Iao+WLyIdArUF4UBE7roEcnbRQ9jmahA==
X-Received: by 2002:a05:6122:1d9f:b0:556:4f4e:812a with SMTP id 71dfb90a1353d-55814105b1cmr1155604e0c.7.1761753668177;
        Wed, 29 Oct 2025 09:01:08 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e27f7b8sm57154535e9.0.2025.10.29.09.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:01:07 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH 1/4] ASoC: codecs: lpass-tx-macro: fix SM6115 support
Date: Wed, 29 Oct 2025 16:00:58 +0000
Message-ID: <20251029160101.423209-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029160101.423209-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251029160101.423209-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yTGlRRp-aF3QPRSunCco1y3p9BrUWXQK
X-Proofpoint-ORIG-GUID: yTGlRRp-aF3QPRSunCco1y3p9BrUWXQK
X-Authority-Analysis: v=2.4 cv=PcvyRyhd c=1 sm=1 tr=0 ts=69023a4c cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WUhUZdYVz38ogwO1su8A:9
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDEyNSBTYWx0ZWRfX83y1G5aNDGb3
 TNRsZUq5l5fvKvNxNttiPtDwiCCJg00lKbX/8pTzkMtHmN8tPDJh90W0JqC5SpgbP6T3u+d8jrF
 G3vRMnZiYIN9cVO+QSFP5/JN4PcFFvX/4dizktA1/GJ8EQAH97ratI7Uu0U4JoSmxo0ScUuanFF
 1/+JqY18REf5KdKvBopA3H6S7naBKPh0KPNpozOrSU0jSgHTEFny29i3vKVDXQ1zMcNryxsCeAE
 0GL0TkwsM99axpqs+XHx0NahnpChGnfvbeRF+Yt9WT7c3ku49hqAnP7qxqIvE3d0xlbPJ+Ec5hR
 jqZGI7nht74RT0vERyiL1pc29ObrSEQRx6VFws/y62E44Nwn1A6trSolgwGn3hcYiSWsOIeWT7E
 rZr9CFh9bCGwzq689yQ3zDcKfOVV4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290125

SM6115 is compatible with SM8450 and SM6115 does have soundwire
controller in tx. For some reason we ended up with this incorrect patch.

Fix this by removing it from the codec compatible list and let dt use
sm8450 as compatible codec for sm6115 SoC.

Fixes: 510c46884299 ("ASoC: codecs: lpass-tx-macro: Add SM6115 support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/lpass-tx-macro.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 1aefd3bde818..1f8fe87b310a 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -2472,15 +2472,6 @@ static const struct tx_macro_data lpass_ver_9_2 = {
 	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9_2),
 };
 
-static const struct tx_macro_data lpass_ver_10_sm6115 = {
-	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
-	.ver			= LPASS_VER_10_0_0,
-	.extra_widgets		= tx_macro_dapm_widgets_v9_2,
-	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9_2),
-	.extra_routes		= tx_audio_map_v9_2,
-	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9_2),
-};
-
 static const struct tx_macro_data lpass_ver_11 = {
 	.flags			= LPASS_MACRO_FLAG_RESET_SWR,
 	.ver			= LPASS_VER_11_0_0,
@@ -2500,9 +2491,6 @@ static const struct of_device_id tx_macro_dt_match[] = {
 		 */
 		.compatible = "qcom,sc7280-lpass-tx-macro",
 		.data = &lpass_ver_9,
-	}, {
-		.compatible = "qcom,sm6115-lpass-tx-macro",
-		.data = &lpass_ver_10_sm6115,
 	}, {
 		.compatible = "qcom,sm8250-lpass-tx-macro",
 		.data = &lpass_ver_9,
-- 
2.51.0


