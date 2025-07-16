Return-Path: <linux-kernel+bounces-733519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9DBB075BE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CAC1AA00CA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7302F546C;
	Wed, 16 Jul 2025 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LBCud2yJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BD62F5318
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669219; cv=none; b=sCxgO6IaAY+nsbG/uibjVHDna8DFBcLAAzr9GlSNR832O7z981WbqFF5wIVIfvBhXJHhCor2EWpHNU2grsazwCKYT9Wl5EcJOrZC7cOP+MVB4l+Cn4+oIZ3tyj32Jkj/hW+LN01vWO1YigSCnW5XbfNe1JLNHlIAhOVDEFBcbwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669219; c=relaxed/simple;
	bh=yibIyJ86F2/IfQa5SjS5WXhbpmt6CUibLHc0JVss7P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0/HrJDrkdi4STx58Q0Xacd8SP46PaFxxmUSJ99qAuPED/R59x6rNLOsepkVlhK/oA5MuYKvIM0CI7c9v3M009lEcZ+EJaH83ub0Sq9ydy1uaGKTLN1bfild6cEEvhe7J9RwZdv3CKdag8KdCMcK7D5XpwY9mZ3e9SRA0Xm8Fms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LBCud2yJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCLg1D022755
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jlH8rAJGwAT
	ewu+6bBhjIOTX5MRWqExEs1wQ0VHGYQg=; b=LBCud2yJs6PttBRPX/0Z/vKFZmh
	pIPsaxpF4ZeDmtn8Nuc1Ith5r92KW4n55TnXrSV3R2Ed+OxOydupPuNz8blfYdGi
	BXqFxYNC/epuhRq8nvBqfNRQWfOBB00th5fagKj7DRn/paeK1yJj9s6Kov56MgYr
	zRZLE7Ktb9Irrk/fy4EwGBp5pSHcDcnWH7GWmRougNOnNAXhFLw7+95xqIbD6xQ7
	vLi6LwmhLaA6HOpTchCNBmokFDCAWkHZmab1ROWhX65Ft969VUCult9veAD1UvX1
	w5gUwX28TV97mVJXToCH6t+4jTmAToCcbqYcrEyfvtv4rKu+8UzANHbKAeQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wkrumk6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e269587d8eso573477985a.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669214; x=1753274014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlH8rAJGwATewu+6bBhjIOTX5MRWqExEs1wQ0VHGYQg=;
        b=AH5XN4NKjM/wGhIyNJ5DaHhSfxYiTTCcNu0mF6NXz2K1+f+Ep9ZR39+JKIBUy08Z+k
         YZomckQ52ow4Y0prBGVMCMTtI7qEztw14Gvp73VHhcvGQGlVEct9auevEfS7chNqJMzI
         lwWel1nPJuwfIA4A4gjjt8aeJhppvU5NZyUBz2/cWho4f2NIEpJ/P+00igpQX8CWqbV6
         ilzzTB7fQlkjBjlh8qHAwpJrPjZOqvOj47byek1P6rjy+49i+1E1eG0bdPavSVdjQFD4
         XNifC3a50NWcdaoHzclOJBFPuH6nQpCvsKwIZI45Z8D1FlU7rvFPgFgUTFUHiDmD9Bjd
         famQ==
X-Forwarded-Encrypted: i=1; AJvYcCW648twCUdgjwc5nJkxpNlkwFG7tQlVlGABc/YYUk+6k75OnBhK4ZQ6cd/CXGLv7PGJf0n944IZJ3i7GMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpGy7EkeAxEH00Jh+Mrfsr98JauzEid4k6wQaGcdgE39eCGiUK
	yrWRj5D6SPvPRAWu/h0QFFrxGJvw6DNx1chsPZB1uTNFl6UGeozRRUmmF5hgjaDMs6rc8GzuCqf
	dvqP+fsweLNyXr48c2A8rNNJm9dyWtnipDXwk6Jh9D1xYtXLNpE5CQkUSmOrheNUPQWs=
X-Gm-Gg: ASbGnctCW4b7N3XRaAonCUPJxYz70qocG0ccPYosenlf/2c7RJz+nSpOpPw1nKmgtmg
	uPY/qTqO+8wxXbaC0hYgH79VawVPLoaXUPTSMalmIRNDAVkEPh9pcvQKqhWfZ7nzr/kwVVhdCcx
	TIc3J8MDUPsKovR1SJfa/sJIr0w+gAxZgHtTAmd0pfpzwUt9wPrHSVDECGWiSHX+lKTuWmmVWJb
	JfBYrnQElINJJIXrQNu4eaO6N9cRenheVIMsFdrsGTOctePTtg7Q8LUUR3ZPYr6K22qLhvg3Mef
	hkn0doRBSJYLMklywStwj4rhnbIbas02M9cBE9GP/wQ/hIjySeG6pg==
X-Received: by 2002:a05:620a:a20c:b0:7e3:44e1:be4b with SMTP id af79cd13be357-7e344e1c048mr266093985a.31.1752669214499;
        Wed, 16 Jul 2025 05:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQGAK+k/pm+VAAiYbieT5s9SCZyiLFMahx58ymhGKiZvECv6WJDXL9w1xmtshVD5BdvFTvNg==
X-Received: by 2002:a05:620a:a20c:b0:7e3:44e1:be4b with SMTP id af79cd13be357-7e344e1c048mr266090085a.31.1752669213998;
        Wed, 16 Jul 2025 05:33:33 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c739sm19453335e9.32.2025.07.16.05.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:33:31 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 4/5] ASoC: codecs: wcd939x: move to using dev_get_regmap
Date: Wed, 16 Jul 2025 13:33:22 +0100
Message-ID: <20250716123323.5831-5-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716123323.5831-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250716123323.5831-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wTH8ci5f0zoVZ6bcK3-R1tdeKI7l-km2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDExMiBTYWx0ZWRfXwD2T+6yGOk6p
 LJ6J3FGZ7NoQXSZxeIGL/Hy3PL7c7ttrYRGLdx3YeF/zcwQfX99AZbHte+Ndd6+a2edDZIJx84k
 EfKVC5MDZdyCrJWvOKNEo8ZralW8xDbonZ3WH6czrzCUzqEGfCR8QVK4uuZI8rzuYlfuUzZH49w
 5D7VqITTmrJE8SVGBu6i6HH170cetns6FLSYQdXjPs8euoRnX4tQjeYboPIdaVvzbYMxAPmV1S6
 lqLri+JtdKB0h5tcvrLn5NZE1UvkOni4LYH5AHKPqHXDCdyUgC0vKcw9WI3Ymb2wWT/EPkJ3Y2o
 /XP5mmTER9p7BdnZiaa5QVGSy1lZBeXk4FU6Tw7Yrso3RwGEI4UeM3CwHiZvjH1M231049ocOF3
 FTw0eX3EspoS+gnG5VG8WMfk0kXPqkQHns/VvbViFbf2BxXkaaJesk5vvlYvxSO3G8DJ1ku/
X-Authority-Analysis: v=2.4 cv=WqUrMcfv c=1 sm=1 tr=0 ts=68779c1f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ZenZftWH51yG1dFpGBgA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: wTH8ci5f0zoVZ6bcK3-R1tdeKI7l-km2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=734 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160112

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Ffor some reason we ended up with a boiler plate for dev_get_regmap in
wcd939x codec and started exporting a symbol for this. Remove this
redundant wrapper and direclty use dev_get_regmap from device pointer..

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
index 6bbdfa426365..18ccdba18291 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -3373,10 +3373,10 @@ static int wcd939x_bind(struct device *dev)
 	}
 
 	/* Get regmap from TX SoundWire device */
-	wcd939x->regmap = wcd939x_swr_get_regmap(wcd939x->sdw_priv[AIF1_CAP]);
-	if (IS_ERR(wcd939x->regmap)) {
+	wcd939x->regmap = dev_get_regmap(wcd939x->txdev, NULL);
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


