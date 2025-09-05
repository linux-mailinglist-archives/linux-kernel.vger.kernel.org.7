Return-Path: <linux-kernel+bounces-803270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA67B45CE2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74617C6F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04503126CF;
	Fri,  5 Sep 2025 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SUwp4wVt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CD0309EE8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087086; cv=none; b=Vi95GvE46nBzCGtMP/v5mZO2lbrLYoL6KsXEySieAtvbBcZF518ArU6YVtQ7FQDTwMWlltKO24hEdVeLIJ7BlVhGJoLbNssUNYOEK6ehpDPjDWr0o314rwHvtBlfT+aHrc5bZiWO3DirXKXSc/q8wNs0+dVEevMp0tKQYSVyEtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087086; c=relaxed/simple;
	bh=4NDb3BHQkI2X3E5eiL6I24at9ebSdCFIXHWDhEFcgdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2NasRkCYDyYcP18+PltEQ2P37IDG3oYBohz7cu8v0ijOdZKUVyYb+VCSiv4K4D8qFOdTHPdZnGeYtOZ50iH1W9Fug1ag3Hdu+OdFvnao4aw46L+u8gtfdY0VnjenMXgAD7PaMYUt1k6HcedFnaJi1ahbX2D9sLmXEZuzn6aRg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SUwp4wVt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856j583008129
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 15:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=C34AfntxGUQ
	tcgOzSpdk0iKg2eP3zakUjCy6JAxDmas=; b=SUwp4wVt6ASuoS6rYrViinDZGie
	SaaQrW3UEBd5x3XBMZjjFNlExG7iHL5Cw0JePdgPjghpNzYwZh1pdlJp0TyWiaJV
	xEDVSIWcgUr/iwbffMUJJWxrZK8ddMz2o2sAYHC3u3ozePpd137T9XGgPvtObqeP
	HNc+uvNSoqI1irQog11R9ti9VzpkamQBFROMw2DsShxdgza/wYi/jF+UIW5iqhis
	2c449B48cUBkkwbYSyagOiAxEUYTMyRorOi011UfOPCQiKCesoZ0hVISP6urpD/s
	bNOxhD/YBjn+PAKEqpWYd6KX8e8Ip7OqvPpWvCQdqp1qKtoNEKG41yEbqUw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjujba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:44:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b3349c2c38so64909161cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087083; x=1757691883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C34AfntxGUQtcgOzSpdk0iKg2eP3zakUjCy6JAxDmas=;
        b=Diwp1qA3V7sfn88/75DsZiuRpFpscZlZ99MUt2X3zYaYfTQFFeYyI7k8Q5wm5+OX1U
         avzLbZ7kYco4dR/dZe2yofZPCx+GRL85Qdxdtw1C4UeyILLY5zR81cNtNmMEUnZMIUkD
         fy+06M1/o1jmsabPDm9K4Suza73g9nK8pVYiNU1VyXdAC9+2yoeOrXv0+Eyvi1muapqw
         nsOacElp6Aj22xzSZR2NNhJ0qALkNs7IRdh5zxHlblgETIytEl6clPqBpRng6KxdXWiS
         5f59XbjyJcT9HDMzr+4dp7kBTFgfcIH3+LwlWz7eurddvxDHZmL1Y80tXMkXERY99e0V
         6BTA==
X-Forwarded-Encrypted: i=1; AJvYcCWGFdr4j9zx67C/VdjgVWnIrlnA2lrgjq7h2ms2qqC8SVx0G7h/oWD6jyANfVq9iLEA95bYUVUCKiMXM0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3tV/jzmlyv/f2cDLQuUpAnKavuSzq7mDmZeF5lt6gEjE32MW
	1j66adQQTP+BoXYvJD4d7XMAT8hac68N7lTnkJXA0wTVOdYYq3PT294eUnp/KwCX+Fo5h+wEWLx
	/+p+HJKngQli8JJAPpOzuwI0fOfwXPpVsjRVkoMUzll1vwTAIv1h951uUAEedL/WAkrI=
X-Gm-Gg: ASbGnctCZuWvAJ6d4sPBZyLCpyF7ngnZGIUDh+xlZHGFx6L1fiI9yC/shryejucALRJ
	52ntJbrM/pdGqCehEXzylXR7/uvIDrfzrnWn5vYm+1rtTWe9sMDPEDUc6wD+MokHUXwSsdocyQj
	OwFqvAgn7YYWjAAhpjkHgBHXWD5pnn1sp2pCAuQhlrTXnXWxHnPrg+r7AcnHWB5VTZuQgvOH3K/
	16hXeKs8+rtYMQjq6FxrJCFnbKAtFjcCDJur0nvg9jFSpu2bRYyXVLb8GccmQxQiJws6fRjnYfl
	Dm5ILCDXN5KyGhxS5MpJQ01uBzUBdNk752GjMhicMwbj8MvGMhFjKg==
X-Received: by 2002:a05:622a:38c:b0:4b4:9273:9689 with SMTP id d75a77b69052e-4b4927397f8mr122516861cf.81.1757087082715;
        Fri, 05 Sep 2025 08:44:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTqgTAeXKIaPrM79+DCWFqyIZktp8nLWlrRyAjPgHUYjE2/tgNnLfxITtxh9nMlLdrVZT6lw==
X-Received: by 2002:a05:622a:38c:b0:4b4:9273:9689 with SMTP id d75a77b69052e-4b4927397f8mr122516131cf.81.1757087081455;
        Fri, 05 Sep 2025 08:44:41 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm165716585e9.6.2025.09.05.08.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:44:41 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org, srini@kernel.org,
        yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org, krzysztof.kozlowski@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, linux-sound@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 05/12] ASoC: codecs: wcdxxxx: use sdw_slave_get_current_bank helper
Date: Fri,  5 Sep 2025 16:44:23 +0100
Message-ID: <20250905154430.12268-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68bb056c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=WmG1VI7HpiTX60UEcG8A:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 6eJtZTt32f6GPoqI-zDwpB-hbwtXqJto
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX/k9aRFX7aSjM
 oRIrXhh3RLAqtxDYtddwTD2OPyKAj1tqyGooAr9ZVnALAKioHRjaCQ5tHRw/3Au12KQL2WsGPdq
 y1xs5gvmauK3XgfBbhiqFo7nknsh7zSoIAqwVS22Ex/daXul+Ue/yW6KItfkHZOBaqdO+DaOjLp
 N4CCJeyt6PALl+Zki7E7rWfKSkEkJgxJS61mjK/YvN2P3+/ckCPKRXrCFcQ4VVFiHv/i9IQeaQo
 KiTKYF2N27LxY0NFIessewLZwZf2iOB++2bE3kBoYQkqkrr6pO4bAiCOQY/TyxkhmjUo6oAi/f6
 f8kaDgLn8mUH6day66ao3iOrDwUaIiWVkfYFpZZfAad4vxuQ4sYLuZHuNNK5oLkTqZanc82iXvK
 9JVxx9aK
X-Proofpoint-ORIG-GUID: 6eJtZTt32f6GPoqI-zDwpB-hbwtXqJto
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

use sdw_slave_get_current_bank() helper function, rather than duplicating
this function in every codec driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/codecs/wcd938x-sdw.c | 10 ----------
 sound/soc/codecs/wcd938x.c     |  3 +--
 sound/soc/codecs/wcd938x.h     |  7 -------
 sound/soc/codecs/wcd939x-sdw.c |  7 -------
 sound/soc/codecs/wcd939x.c     |  2 +-
 sound/soc/codecs/wcd939x.h     |  7 -------
 6 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index a7514d716086..8bcd8396f375 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -82,16 +82,6 @@ static struct sdw_dpn_prop wcd938x_dpn_prop[WCD938X_MAX_SWR_PORTS] = {
 	}
 };
 
-int wcd938x_swr_get_current_bank(struct sdw_slave *sdev)
-{
-	int bank;
-
-	bank  = sdw_read(sdev, SDW_SCP_CTRL);
-
-	return ((bank & 0x40) ? 1 : 0);
-}
-EXPORT_SYMBOL_GPL(wcd938x_swr_get_current_bank);
-
 int wcd938x_sdw_hw_params(struct wcd938x_sdw_priv *wcd,
 			  struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *params,
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index e2cb0758bca7..f8d7bf27a6ed 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1094,8 +1094,7 @@ static int wcd938x_tx_swr_ctrl(struct snd_soc_dapm_widget *w,
 	int bank;
 	int rate;
 
-	bank = (wcd938x_swr_get_current_bank(wcd938x->sdw_priv[AIF1_CAP]->sdev)) ? 0 : 1;
-	bank = bank ? 0 : 1;
+	bank = sdw_slave_get_current_bank(wcd938x->sdw_priv[AIF1_CAP]->sdev);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
diff --git a/sound/soc/codecs/wcd938x.h b/sound/soc/codecs/wcd938x.h
index dbafcae247f4..54ee56b7fbd6 100644
--- a/sound/soc/codecs/wcd938x.h
+++ b/sound/soc/codecs/wcd938x.h
@@ -669,9 +669,6 @@ int wcd938x_sdw_hw_params(struct wcd938x_sdw_priv *wcd,
 			  struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *params,
 			  struct snd_soc_dai *dai);
-
-int wcd938x_swr_get_current_bank(struct sdw_slave *sdev);
-
 #else
 
 static inline int wcd938x_sdw_free(struct wcd938x_sdw_priv *wcd,
@@ -696,9 +693,5 @@ static inline int wcd938x_sdw_hw_params(struct wcd938x_sdw_priv *wcd,
 	return -EOPNOTSUPP;
 }
 
-static inline int wcd938x_swr_get_current_bank(struct sdw_slave *sdev)
-{
-	return 0;
-}
 #endif /* CONFIG_SND_SOC_WCD938X_SDW */
 #endif /* __WCD938X_H__ */
diff --git a/sound/soc/codecs/wcd939x-sdw.c b/sound/soc/codecs/wcd939x-sdw.c
index e487a1bb0194..477d6cf27d32 100644
--- a/sound/soc/codecs/wcd939x-sdw.c
+++ b/sound/soc/codecs/wcd939x-sdw.c
@@ -128,13 +128,6 @@ static struct sdw_dpn_prop wcd939x_tx_dpn_prop[WCD939X_MAX_TX_SWR_PORTS] = {
 	}
 };
 
-unsigned int wcd939x_swr_get_current_bank(struct sdw_slave *sdev)
-{
-	return FIELD_GET(SDW_SCP_STAT_CURR_BANK,
-			 sdw_read(sdev, SDW_SCP_CTRL));
-}
-EXPORT_SYMBOL_GPL(wcd939x_swr_get_current_bank);
-
 int wcd939x_sdw_hw_params(struct wcd939x_sdw_priv *wcd,
 			  struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *params,
diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
index 5a56c79a8922..85730ae40c2c 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -1017,7 +1017,7 @@ static int wcd939x_tx_swr_ctrl(struct snd_soc_dapm_widget *w,
 	int bank;
 	int rate;
 
-	bank = wcd939x_swr_get_current_bank(wcd939x->sdw_priv[AIF1_CAP]->sdev);
+	bank = sdw_slave_get_current_bank(wcd939x->sdw_priv[AIF1_CAP]->sdev);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
diff --git a/sound/soc/codecs/wcd939x.h b/sound/soc/codecs/wcd939x.h
index 3f189e5cafd5..e70445b1a4bc 100644
--- a/sound/soc/codecs/wcd939x.h
+++ b/sound/soc/codecs/wcd939x.h
@@ -930,8 +930,6 @@ int wcd939x_sdw_hw_params(struct wcd939x_sdw_priv *wcd,
 			  struct snd_pcm_hw_params *params,
 			  struct snd_soc_dai *dai);
 
-unsigned int wcd939x_swr_get_current_bank(struct sdw_slave *sdev);
-
 struct regmap *wcd939x_swr_get_regmap(struct wcd939x_sdw_priv *wcd);
 #else
 
@@ -957,11 +955,6 @@ static inline int wcd939x_sdw_hw_params(struct wcd939x_sdw_priv *wcd,
 	return -EOPNOTSUPP;
 }
 
-static inline unsigned int wcd939x_swr_get_current_bank(struct sdw_slave *sdev)
-{
-	return 0;
-}
-
 struct regmap *wcd939x_swr_get_regmap(struct wcd939x_sdw_priv *wcd)
 {
 	return PTR_ERR(-EINVAL);
-- 
2.50.0


