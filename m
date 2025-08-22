Return-Path: <linux-kernel+bounces-781715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D449FB315C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61471B60284
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1B32FABE5;
	Fri, 22 Aug 2025 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hO9XTDjW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07092FA0D3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859780; cv=none; b=e+9QqzsnpW3sIAOopSKMJWGYG6YlRv1HfJCYJbXx3ZrIc0yXKyAXUaqhrItJk7vxFGV1M0Mz3adn9TOICftD8R3FUiCsqcFe1+w7MKmJbXna3eoLPbkDClAN+RrcDUIzSRodL3ELWjJu87jNmhVu9UYLdlkj/vdRpQu2cWrV85k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859780; c=relaxed/simple;
	bh=asxvysqqAjgkKstONlIrpBzxu2GRO9SXusBJVqCmX5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxHZhSiMlS6jq8oIsSPbLmNYtaxG7IOxcM1aEOQDIbhy0e0Ke+TzVuROzJ6/L1MqIZ6V4bg5ghxy8G2gM8516uBzO+Q4L5I+fexWetfLqXl9u46QOr1MpKSlT7dyRA5E+NFsjYw7xT//fwktScp8gAAdQZPX+8PMClPwc5w+AQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hO9XTDjW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8Uh6Q006837
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WCblndB5WM/
	7lEa4Lxpv6vxarG8aRPyFWHgtcjT569A=; b=hO9XTDjW1Eq/ynBaonlnvuT/TGr
	Lo/up7YFycRVngRSwP5vC211CGfK5jE5zLxNggmmdfGN29m9NZmEcRASQcxyEt1J
	7G+seHnBPib6twNe16KSOePt7La0pNzw354AHv3oLGK5MCEPCq9DbWCsByZz4Fe5
	QVh4jmia8xUbeUZWfbuK5VNDQyYKpV9K6Liel6PTIDci9TT6vSWB0cdf8SiKt8/L
	CjWJ+X3JitWdmRoYQw5fmQUzQWb0cqfINxMwVqgW8lyv3xOHbX4VeFyhZCKtzTWu
	fGylvbqfjTdXz+fyQByTfoj3Hg+lNPF3FvD1voNY7HMNf/krumTZD6+s6mw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52dru52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:49:36 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a9f562165so63115886d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755859776; x=1756464576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCblndB5WM/7lEa4Lxpv6vxarG8aRPyFWHgtcjT569A=;
        b=B37qBesBj7JFE+gwMs48Iizr0l+UzbvE+M/gQATdJF5hZmsu2ehYo2mDyiDqBZKJS0
         tbuG1Hr1S4EebW/rCzPmg0AAFC6itx1xTp1V1vz5AWa2puSyIxU1r8y3QEQaO7dCXAMV
         lnXZKY29A2vfO+vFqQZW/Yor7ZKORQUk3y3LUGKiIpmVzrCY/Z1RHXKtEMyxm9+DiyjM
         NCAnyUu3ohzzBq1+viREMnNCTG5bdN2G2KBGr3X0RuZi3IXToUcQal1ZCvOOMEabJ4M1
         g8ks0d5Ho7lbJuJ3Y5OF9+j4fJ/B/aRd+N+Nd6LSoqMskhgt109sr5GRdiPF8063sFNs
         QbPA==
X-Forwarded-Encrypted: i=1; AJvYcCXI0ofc6shiOBGaH/UAU6lxLgneCrMvmW2ve5+xCHq5wj6ApY20vt6oMJCeSFFaZcCf1vNS1/8GaX0iSy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4NM4uMVkbxOUO77bMssRfPzDcjn7zJvgCGFpACytN765SR1DW
	NWqXRSMhnUBGDl2XFk+eYxtgBH8/Gpf0oxr7bfyCmj+vgXAfJ4P3aDklHFyBt97O4scAmOJ76sz
	DrRNT5SiXLazppx3bqrrfBTfzIMl5tnZQED0ksd+7IocxT8FUQHQQkJE8AytCP/ity+E=
X-Gm-Gg: ASbGnctlxawtqN2gooUjWxxZrpuO8S0qmkeUYt4Bn/qpDkCtNG0T5qcPzf//yEYFWQG
	yHAjvpn50CDYHK8gjMcBRSFJomn/46YyV6eHGL9O2Gj/bxDwlek4wYAEFh+uvUI6aCbdPtFAFD1
	k+U/SuzhZTkH74is5KA82w9TmMRiLEjbvdRTwxvudH9POcQ7REMPocrOnqZ9j9X/xuKiXt1Eglg
	Xy/WBtsyV0q4X/opHaIx7t9qzjXmwaxonRkw20BPhNxRffwXtUC6fvEQY9dCqML8/LfyYC3BPP3
	jhbL3dW6x9jCQeAm/LhFPu2i9DEJ/wh4BSh6apeg86BGkb9fJ6pK0g==
X-Received: by 2002:a05:6214:500d:b0:70d:6df4:1afb with SMTP id 6a1803df08f44-70d97259921mr28591376d6.57.1755859776104;
        Fri, 22 Aug 2025 03:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1sltVyJoaXvdkN/CS1sTPSfuTTarGRljY+oqL1ag+7erN2DvvnbX/OYAcjAovJ7/4cO1sLA==
X-Received: by 2002:a05:6214:500d:b0:70d:6df4:1afb with SMTP id 6a1803df08f44-70d97259921mr28591146d6.57.1755859775540;
        Fri, 22 Aug 2025 03:49:35 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50e4249bsm31367155e9.25.2025.08.22.03.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:49:34 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        neil.armstrong@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 5/8] ASoC: codecs: wcd939x: get regmap directly
Date: Fri, 22 Aug 2025 11:49:24 +0100
Message-ID: <20250822104927.2621866-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250822104927.2621866-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250822104927.2621866-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX6tNDO/tyFTg9
 ufz1itayerrRqocqrIvONRxA3Z0CnhNEorWtI06AtTdimvKdCPBF8qL8fxJ43agEt8lkx5l709U
 gSVDKEp/PpqBnM6TNmqsrRz68IwP2jNuX7izQXXNK5BXK9vHUSy1AA90l2lIA49VZ6ErCJIPUp3
 JjtowLyxiQVqOxG5CCFyK3/hqYTVi4ySkUA7g1Aj7+Zh3dYqzWYbIZN0ywJmK0C60P4fIwhn180
 ueWWNj6jF6IR6sU8mOuAa0oTcKGK80/Ee50N8rFD0n/IMikKW8G6tSwbLxDGtsKSGH+D7MNDtw9
 7T683wGTS3XmVz8Fd50iLXuQEnhNjz46JPKbuWurfFnFt18xCP/sZ5q1tVFloX0c5wzWMv1xMFt
 h+B4H+vFsr/iF2g8Oluqbq7VyuEtfA==
X-Proofpoint-ORIG-GUID: NzcmNHdGcUqIs5Kuu_SO8dgLEss4yqFY
X-Proofpoint-GUID: NzcmNHdGcUqIs5Kuu_SO8dgLEss4yqFY
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a84b40 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=lWraB9NP_8A8gAq8GzkA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

for some reason we ended up with a boiler plate for dev_get_regmap in
wcd939x codec and started exporting a symbol for this. Remove this
redundant wrapper and direclty get regmap.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/wcd939x-sdw.c | 9 ---------
 sound/soc/codecs/wcd939x.c     | 6 +++---
 sound/soc/codecs/wcd939x.h     | 6 ------
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wcd939x-sdw.c b/sound/soc/codecs/wcd939x-sdw.c
index df71d7777b71..2b0aa2108f33 100644
--- a/sound/soc/codecs/wcd939x-sdw.c
+++ b/sound/soc/codecs/wcd939x-sdw.c
@@ -186,15 +186,6 @@ int wcd939x_sdw_set_sdw_stream(struct wcd939x_sdw_priv *wcd,
 }
 EXPORT_SYMBOL_GPL(wcd939x_sdw_set_sdw_stream);
 
-struct regmap *wcd939x_swr_get_regmap(struct wcd939x_sdw_priv *wcd)
-{
-	if (wcd->regmap)
-		return wcd->regmap;
-
-	return ERR_PTR(-EINVAL);
-}
-EXPORT_SYMBOL_GPL(wcd939x_swr_get_regmap);
-
 static int wcd9390_update_status(struct sdw_slave *slave,
 				 enum sdw_slave_status status)
 {
diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
index 6bbdfa426365..ac45699ec067 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -3373,10 +3373,10 @@ static int wcd939x_bind(struct device *dev)
 	}
 
 	/* Get regmap from TX SoundWire device */
-	wcd939x->regmap = wcd939x_swr_get_regmap(wcd939x->sdw_priv[AIF1_CAP]);
-	if (IS_ERR(wcd939x->regmap)) {
+	wcd939x->regmap = wcd939x->sdw_priv[AIF1_CAP]->regmap;
+	if (!wcd939x->regmap) {
 		dev_err(dev, "could not get TX device regmap\n");
-		ret = PTR_ERR(wcd939x->regmap);
+		ret = -ENODEV;
 		goto err_remove_rx_link;
 	}
 
diff --git a/sound/soc/codecs/wcd939x.h b/sound/soc/codecs/wcd939x.h
index 0ee0fbb49ff9..eba8205cdd0d 100644
--- a/sound/soc/codecs/wcd939x.h
+++ b/sound/soc/codecs/wcd939x.h
@@ -919,8 +919,6 @@ int wcd939x_sdw_hw_params(struct wcd939x_sdw_priv *wcd,
 			  struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *params,
 			  struct snd_soc_dai *dai);
-
-struct regmap *wcd939x_swr_get_regmap(struct wcd939x_sdw_priv *wcd);
 #else
 
 static inline int wcd939x_sdw_free(struct wcd939x_sdw_priv *wcd,
@@ -945,10 +943,6 @@ static inline int wcd939x_sdw_hw_params(struct wcd939x_sdw_priv *wcd,
 	return -EOPNOTSUPP;
 }
 
-struct regmap *wcd939x_swr_get_regmap(struct wcd939x_sdw_priv *wcd)
-{
-	return PTR_ERR(-EINVAL);
-}
 #endif /* CONFIG_SND_SOC_WCD939X_SDW */
 
 #endif /* __WCD939X_H__ */
-- 
2.50.0


