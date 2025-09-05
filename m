Return-Path: <linux-kernel+bounces-803274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D905AB45CE3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7EA07B24D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DDC35E4F0;
	Fri,  5 Sep 2025 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hfH3DnsX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5A731328E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087092; cv=none; b=sH7ic+HKtbK/EF93Ym4MnRuwYuqlq60jAkKV7wdOQxH1xOhtaELuUq2MdgGX7CbApO54rYMOf06tvLj9yCmhn/34+D3DZMbkUiUFtJ1zXFrp9Df8krV8khPBgewgtpae4BBgunjS4yqunTKP3NnWscVDmnzPjVmcdQEmvOMti9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087092; c=relaxed/simple;
	bh=akR3Yzvusad4i+UCHWyqsSQvBIYsdFkmvXNaMfYcDRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9/F2+8PgW/ihWHiOGyIzFrHaqNc+f0XhYtdNjE5vb1/nkpjQ0cR1n81+Gik1Tg2XF5THrLTwy9a+hgRdcjzyfitkXnFbzC/VA+w8OyXpcor9BFK3PKz0KUekB0Bl3YSDmiKN2AP/UGWOM4xiwWl/g5eQPht/JSavAHIjtRieKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hfH3DnsX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585D8H5j018660
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 15:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lZRvyA2vNm6
	fxL6Jok3NTa76zr2CFM+a5QQAwIqtQn0=; b=hfH3DnsXfaYQYAQaxk3qaca9ABp
	YyqyLU2Bx6rQwCqlMYz2UejRjwX7TKcKbnDBdVZZg01VhbLY/UOVcQKZxZIcBqUs
	6BXzvgQjLKRl09J2pw7wifQBYRTqWdX8as1bh01AL12BZWLrOO5hBhfKQSc9nZA+
	hFPgoSXeP4X9zVJSUgFz8/63pq9z//buhoLTnHT88FJ86AFJ4k1KTVU/fB+A7vZJ
	oZo79sU9b1PD4FEw7cEfpWs79jmAcRqwaQHOlLTpraWeXWdWCPj0kor7MMzKvN8B
	iz7xRbOb+tbV7SEKkvRgIrAjwYRYGrcyMPiAntGXQPzb+8aPQAqZfa4y4bA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebuufnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:44:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5e91fb101so33984751cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087089; x=1757691889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZRvyA2vNm6fxL6Jok3NTa76zr2CFM+a5QQAwIqtQn0=;
        b=aHTnL6+0UvcPEZ7eF+ZpVFT1yB8DXptyY/UlEiVCB+62RRuRsHcNuOMHhYMWCTqKYl
         9sFTIjfoT2OC7EoL5PODkOiHWyxVXutSLUG/fpgMNY8QOMDOaEqnVhv7vIJgMLurfXQQ
         I/FteHcsYD78zsDClUZ/vctmIPPJLi/1eMD6AZrZ42Z6D1Vj5bQLOwLgyDg0qyxH7Pp1
         jE2dObydIvFqSYySmiuRPJFU+DP/kd6DJqqoM10haOO7u198Q/gJDuasJIx6i/dipWN+
         2ODodtIhzbneGBzusezIvYbbJYCrJS5zRMagC+BPoISJsoADvnh707UTL4rkKHV4ufWf
         IC5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtYzeczxPywiwd0ZeKi/85eNDmWz4E7Kr2HQ5xHc8QZ+6fvwuSezXNxlmvr8KvIMueO3JqxT5GUlB8qko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9VXoQPXARLZZyvGOXqGParhbUlEJW7RR1LL6RdPNM6og1SBV8
	fCLX0DhCcFcjA6tm7fXm3QjwW/4RlvPtnkY93ScOAFKrBT7E3ERElSZuOTu1/oCngcksMnQfqAC
	e+jBgpATR6GJDn0icWeBnWP3farABUZgMWaY7nomu5Q8pJiH+r8pT1BTuJWh4/s1q24E=
X-Gm-Gg: ASbGncvJS5x6nue1ROPDBXs+x5DXMTXUYwQRB+dtq05V1Zen81ltcY71Ed8NuidVAeI
	ypSJZ0Qwhh8iYyM2qenn+8vNu37ILYmGZpIDJiy9IBUD+gpDfdXuCd6FL3TeEvzsF5CuNqhKIOs
	hg5umPgONkzJ6NNUBJoH6+BLjiZxHefzDDhFiP3722nl8YuVAFaX6bLmEAGEch75jEzu9RUr5Q7
	9KpUhWRN5MGw879MxgSy7yBj8oqkN+QHorsVO9QM+8lqTClrS4u5gf34X+EBupXvF9ESZIM7ZwP
	dqYOkplQ2bab59W+nGFnkwF+Ks/71kh0aqdcE/f/NPVwYEruldDU9g==
X-Received: by 2002:a05:622a:a953:10b0:4b4:91f8:3b13 with SMTP id d75a77b69052e-4b491f83e49mr109615631cf.63.1757087088726;
        Fri, 05 Sep 2025 08:44:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSG0XGNMp/AQ4ikUx9DdF4h05Yh44/Dzm6gF3o/VyuLO/Ifik/KWlx9cIobfmm9FA2GXcPwQ==
X-Received: by 2002:a05:622a:a953:10b0:4b4:91f8:3b13 with SMTP id d75a77b69052e-4b491f83e49mr109615291cf.63.1757087088181;
        Fri, 05 Sep 2025 08:44:48 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm165716585e9.6.2025.09.05.08.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:44:45 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org, srini@kernel.org,
        yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org, krzysztof.kozlowski@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, linux-sound@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 09/12] ASoC: codecs: wcd939x: get regmap directly
Date: Fri,  5 Sep 2025 16:44:27 +0100
Message-ID: <20250905154430.12268-10-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-GUID: Fc99BvvlXXs_4cVuwIhNBu874WF9U3jL
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68bb0571 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=jWMDT5uzmWzhJut3sAYA:9
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfX188n1WShW1LO
 Y9qebZivPbxYSTGul6yX7jbUd1MldPSQCL1fKiVJ08iwNvicTr/nCk0YJ/jgyBgb8Ln63d2/Hph
 CxOrXlOjwfiMyXfKGb78w+0DfOZSvPMCOl9fKlNi1kPYY/+w58LZZWHKzNnDlBOgN5UwgwDlRyp
 afSxYudMn8IaYoDFdDtEzGKTwqq9qbApoN5o9r/Xmeb4SCWOfuZNXJAgKWlzH+/073K6nKfraDP
 c2UjEIM58POqgR+o4fXW0t/I54IPL9VlnStuqZuLqV1Y4pHtmKyoFMZusLnkEOaChkJziWaWlIG
 Gm2MnLJqHWQofFvrFKflqbOu1WmALbK1eTtaq8dCyqpgACHf1mMYkVGlUxf59ShoICq8GPnSvhz
 gXjXhO3A
X-Proofpoint-ORIG-GUID: Fc99BvvlXXs_4cVuwIhNBu874WF9U3jL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163

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
index 6aecad2a28aa..38da706d80be 100644
--- a/sound/soc/codecs/wcd939x-sdw.c
+++ b/sound/soc/codecs/wcd939x-sdw.c
@@ -187,15 +187,6 @@ int wcd939x_sdw_set_sdw_stream(struct wcd939x_sdw_priv *wcd,
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
index a414cd99b946..e74e6f013131 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -3374,10 +3374,10 @@ static int wcd939x_bind(struct device *dev)
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
index ca6353222ea0..6bd2366587a8 100644
--- a/sound/soc/codecs/wcd939x.h
+++ b/sound/soc/codecs/wcd939x.h
@@ -918,8 +918,6 @@ int wcd939x_sdw_hw_params(struct wcd939x_sdw_priv *wcd,
 			  struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *params,
 			  struct snd_soc_dai *dai);
-
-struct regmap *wcd939x_swr_get_regmap(struct wcd939x_sdw_priv *wcd);
 #else
 
 static inline int wcd939x_sdw_free(struct wcd939x_sdw_priv *wcd,
@@ -944,10 +942,6 @@ static inline int wcd939x_sdw_hw_params(struct wcd939x_sdw_priv *wcd,
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


