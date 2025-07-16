Return-Path: <linux-kernel+bounces-733518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829DEB075B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77904A203B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB492F532B;
	Wed, 16 Jul 2025 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="go8gXOA8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5AD2F50B1
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669217; cv=none; b=uUy1JLH2bhjLm9/yBl6YWYLL4Eu3+HAPdLZHLRZgb4ynXwtW6sSMnRkmero8FaurvYAaWjCo3E29iCaM6IyivkF1KML+RG5HueLd3LXhkLMb4Zbv7Ha36MtJaMz9xaYIo7I4MxLxkGEIvkde15GpTwgh3gsxbOetg8hY+tgcYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669217; c=relaxed/simple;
	bh=zjhVvqySrSwwnLW11WVGyKNG12Gd3+0QhOKhI4XLesk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dL4zExKDQUoWisBzpucD6kamDt7uiolREZH37oVcc1knVgzKMy9u3zn/Vi++gTfqRVhX1q+rZ58g8UZTrvue+NbX42hlrhk1P+EtAgVClgtmu20jiqcQGZPlaA0OS6T7uEtRJrboMe2yvFcth27V3Kca7rP5ZeO3V8qD8si2otQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=go8gXOA8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G5gu09017640
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=R54aSxowHXp
	RiRjvZplb9BA0g0wx/yEa6TgqmAyLwd4=; b=go8gXOA8B82eFopyyptiL8OFTq4
	94Rxse6jI0Rew729F1XpyMsf4d4ExC+v/QZgLi9KEbumF+AzsnYq5iZqiLohNIlH
	RGilJMJ7chQs+dAW1MYr3jS92e657cqL9wWSn54uqF2zK4KmxdP+OVUNopqkoodQ
	lDRvy9TtPj2MhXzCgi/UjTryhFn6Easg4qsCGvKzSZoTWglNF9YySs4awYXlwogA
	bMxn9gDWciX4Cj5VEEf3P3/X5PwohuLf9HrggFBv173anFwf0xy3qaj8iKIew5mQ
	88dQVHl3Jus3WufKMbu9XBAxg0n3TqLZjpAdiSJoXXsbQ6wCGYxJRDoKatQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu8bqxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e32b9398e4so367771685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669212; x=1753274012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R54aSxowHXpRiRjvZplb9BA0g0wx/yEa6TgqmAyLwd4=;
        b=ADrNCMC3LCo0jaSCFeN2IDTr8eu0654CURXCNKhI4uDEAn6Ya3tG8//MA2b0PeHT26
         au5AU+alkX4U7mqPz/Ksg4FqG5MjjO7A7peRWabKbdDmWqkHaKfHD92V/4Q18amvqI8R
         FvuTqKi1rZrhKGm0K6o6/SGbPN6W5Pe611BcmV7a/HfdxwNwuu+YCi8cSTuuWG++RrVv
         EN3CTTDa1YXy9Ctg7DdRrq8KrBKChPyuXfXkMzLCsAVrm6YKn/hjcrg+EVJqK01PN3Z6
         ovjNX2G32pLDm8WnaJSE3Euvg3E6JaKXqbuTcZkVwdbTtQzC+kPv2qr/Q+aTik5OA8Ky
         JejQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu2RESbnn6WOrI6nOcDwM5NRO79kXMDJ1PyaDTOZ3ooMD0Nk4ZjkJWVtobRJSiwdwTvqixEs0/xxmem0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMKtTAnnctWLxl2Q1NjS9jXQmGhQXP5J6KSCB4I02X1W8flVnK
	JFuhbKiwcWadLymEUj+TweZM+8zPpxekHYcJDIGZFuKOTfWAMiO+5H6x23eMG9Rk6tM3tTTdEQ/
	enwBWr+Bi2fHLKEZllffEOiOuljKLPauiSKfgkxGHuLD0/2Rx+jyaRtCuBPgb4N0c9xw=
X-Gm-Gg: ASbGnctrMfcUgDZF6LSiYFfhXdIHlI4FONSCCvpCcYbRZzVE2723wdo2HTcPfVf7u7A
	Gl77ss6oYSV0jm0C1ABgPehrTlR0v1duJnPt9hdP1+al511z+DWBx5/G3m+vVQe7qAl+X9OUKtk
	jmQurlL9Cb89+YOrpxG2YOau1shEvwuJAMGm5YF36A4t22bFqIaN0jykNW6IPB4ZycBkui0mYsa
	wgUeNVm2/BP5op9PDsvuUHjIduXxzLj7heY5LHRgrMzpkCGr8G4VUAmLYxsguJ9cWq8JpK7WqwL
	AFaYmKYenZUlNOFym0ZhBSHmw8Dsd37aET+UHaEaAfb7dOoDzpkkNw==
X-Received: by 2002:a05:620a:44c5:b0:7e3:49b5:d53f with SMTP id af79cd13be357-7e349b5d6b4mr66929785a.34.1752669211906;
        Wed, 16 Jul 2025 05:33:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsvE+VqtNvxlt0dhL+n9oaGEyO6NZwYTFbdXlPWS1CeSWMSp3UiwpgsU6Vom+DApz6OG/vjQ==
X-Received: by 2002:a05:620a:44c5:b0:7e3:49b5:d53f with SMTP id af79cd13be357-7e349b5d6b4mr66925085a.34.1752669211381;
        Wed, 16 Jul 2025 05:33:31 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c739sm19453335e9.32.2025.07.16.05.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:33:30 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 3/5] ASoC: codecs: wcd-common: move component ops to common
Date: Wed, 16 Jul 2025 13:33:21 +0100
Message-ID: <20250716123323.5831-4-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDExMiBTYWx0ZWRfX822LMbqPBnhu
 3aauTkdiGt6wfcpdtvDh4npLpFXjVeQcVH7t+kW0XpgBn8HMc3hz/AkYt1N/+g7vq+9d5lkJiXX
 0AhDaCh3dPTyzesKwQuk94U1D0SmwelGvqPqQ1rAjB81ONgk7DZOdo4vzycQ0vVmxKDK4yAUnDd
 IGbjsngYpDPU144SsA8wD2H7cRjT4wGtbB5YvJIBTuweU9Kn4TKp7ZAh/OSTYAD6BeGqIFETr2f
 sIgSC2hTM3qFh3G1hYD5SjXv+Qsj1h/G9bjqdsCkSI04wtW/OUHhlkP+5sNqjRDUhg75V+Ng9Si
 Gv1CamyiIN3um7bFNKmnDyeL00nGe3R5UT/rciQTKhew44Jut1hXXuGEgJPQLA8fQGPICMgKT3U
 yPM/iedYV4MR+t1yxDre4xXusHEcQxqpKvsPhv1MdUNuXLAYlYJIceo6Ixka9gkeOXOOUXRx
X-Proofpoint-ORIG-GUID: ua9-To6eqX6oRy80Lk67ork8B92EwLpe
X-Proofpoint-GUID: ua9-To6eqX6oRy80Lk67ork8B92EwLpe
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=68779c1e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=eQjB__F64b99YC4tFhYA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160112

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

component_ops for wcd97x, wcd938x, wcd939x soundwire codecs are exactly
identlical, move them to common driver to remove this duplicate code.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/wcd-common.c  | 27 +++++++++++++++++++++++++++
 sound/soc/codecs/wcd-common.h  |  1 +
 sound/soc/codecs/wcd937x-sdw.c | 29 ++---------------------------
 sound/soc/codecs/wcd938x-sdw.c | 20 ++------------------
 sound/soc/codecs/wcd939x-sdw.c | 29 ++---------------------------
 5 files changed, 34 insertions(+), 72 deletions(-)

diff --git a/sound/soc/codecs/wcd-common.c b/sound/soc/codecs/wcd-common.c
index dffb0431a48c..0c1ffa015403 100644
--- a/sound/soc/codecs/wcd-common.c
+++ b/sound/soc/codecs/wcd-common.c
@@ -7,6 +7,8 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/printk.h>
+#include <linux/component.h>
+#include <linux/pm_runtime.h>
 
 #include "wcd-common.h"
 
@@ -62,5 +64,30 @@ int wcd_dt_parse_micbias_info(struct wcd_common *common)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wcd_dt_parse_micbias_info);
+
+static int wcd_sdw_component_bind(struct device *dev, struct device *master, void *data)
+{
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
+static void wcd_sdw_component_unbind(struct device *dev, struct device *master, void *data)
+{
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+}
+
+const struct component_ops wcd_sdw_component_ops = {
+	.bind = wcd_sdw_component_bind,
+	.unbind = wcd_sdw_component_unbind,
+};
+EXPORT_SYMBOL_GPL(wcd_sdw_component_ops);
+
 MODULE_DESCRIPTION("Common Qualcomm WCD Codec helpers driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wcd-common.h b/sound/soc/codecs/wcd-common.h
index ee101f8547d5..deb78241236b 100644
--- a/sound/soc/codecs/wcd-common.h
+++ b/sound/soc/codecs/wcd-common.h
@@ -29,6 +29,7 @@ struct wcd_common {
 	u32 micb_vout[WCD_MAX_MICBIAS];
 };
 
+extern const struct component_ops wcd_sdw_component_ops;
 int wcd_get_micb_vout_ctl_val(struct device *dev, u32 micb_mv);
 int wcd_dt_parse_micbias_info(struct wcd_common *common);
 
diff --git a/sound/soc/codecs/wcd937x-sdw.c b/sound/soc/codecs/wcd937x-sdw.c
index 8f2819163527..59c353cafd31 100644
--- a/sound/soc/codecs/wcd937x-sdw.c
+++ b/sound/soc/codecs/wcd937x-sdw.c
@@ -983,31 +983,6 @@ static const struct sdw_slave_ops wcd9370_slave_ops = {
 	.interrupt_callback = wcd9370_interrupt_callback,
 };
 
-static int wcd937x_sdw_component_bind(struct device *dev,
-				      struct device *master, void *data)
-{
-	pm_runtime_set_autosuspend_delay(dev, 3000);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
-	return 0;
-}
-
-static void wcd937x_sdw_component_unbind(struct device *dev,
-					 struct device *master, void *data)
-{
-	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
-	pm_runtime_dont_use_autosuspend(dev);
-}
-
-static const struct component_ops wcd937x_sdw_component_ops = {
-	.bind = wcd937x_sdw_component_bind,
-	.unbind = wcd937x_sdw_component_unbind,
-};
-
 static int wcd9370_probe(struct sdw_slave *pdev,
 			 const struct sdw_device_id *id)
 {
@@ -1093,7 +1068,7 @@ static int wcd9370_probe(struct sdw_slave *pdev,
 	}
 
 
-	ret = component_add(dev, &wcd937x_sdw_component_ops);
+	ret = component_add(dev, &wcd_sdw_component_ops);
 	if (ret)
 		return ret;
 
@@ -1107,7 +1082,7 @@ static int wcd9370_remove(struct sdw_slave *pdev)
 {
 	struct device *dev = &pdev->dev;
 
-	component_del(dev, &wcd937x_sdw_component_ops);
+	component_del(dev, &wcd_sdw_component_ops);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 40c6896eb781..e43d6ac1c913 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -1181,22 +1181,6 @@ static const struct sdw_slave_ops wcd9380_slave_ops = {
 	.bus_config = wcd9380_bus_config,
 };
 
-static int wcd938x_sdw_component_bind(struct device *dev,
-				      struct device *master, void *data)
-{
-	return 0;
-}
-
-static void wcd938x_sdw_component_unbind(struct device *dev,
-					 struct device *master, void *data)
-{
-}
-
-static const struct component_ops wcd938x_sdw_component_ops = {
-	.bind   = wcd938x_sdw_component_bind,
-	.unbind = wcd938x_sdw_component_unbind,
-};
-
 static int wcd9380_probe(struct sdw_slave *pdev,
 			 const struct sdw_device_id *id)
 {
@@ -1261,7 +1245,7 @@ static int wcd9380_probe(struct sdw_slave *pdev,
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	ret = component_add(dev, &wcd938x_sdw_component_ops);
+	ret = component_add(dev, &wcd_sdw_component_ops);
 	if (ret)
 		goto err_disable_rpm;
 
@@ -1279,7 +1263,7 @@ static int wcd9380_remove(struct sdw_slave *pdev)
 {
 	struct device *dev = &pdev->dev;
 
-	component_del(dev, &wcd938x_sdw_component_ops);
+	component_del(dev, &wcd_sdw_component_ops);
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
diff --git a/sound/soc/codecs/wcd939x-sdw.c b/sound/soc/codecs/wcd939x-sdw.c
index b5a35c3b22e1..df71d7777b71 100644
--- a/sound/soc/codecs/wcd939x-sdw.c
+++ b/sound/soc/codecs/wcd939x-sdw.c
@@ -1377,31 +1377,6 @@ static const struct sdw_slave_ops wcd9390_slave_ops = {
 	.bus_config = wcd9390_bus_config,
 };
 
-static int wcd939x_sdw_component_bind(struct device *dev, struct device *master,
-				      void *data)
-{
-	pm_runtime_set_autosuspend_delay(dev, 3000);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
-	return 0;
-}
-
-static void wcd939x_sdw_component_unbind(struct device *dev,
-					 struct device *master, void *data)
-{
-	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
-	pm_runtime_dont_use_autosuspend(dev);
-}
-
-static const struct component_ops wcd939x_sdw_component_ops = {
-	.bind = wcd939x_sdw_component_bind,
-	.unbind = wcd939x_sdw_component_unbind,
-};
-
 static int wcd9390_probe(struct sdw_slave *pdev, const struct sdw_device_id *id)
 {
 	struct device *dev = &pdev->dev;
@@ -1465,7 +1440,7 @@ static int wcd9390_probe(struct sdw_slave *pdev, const struct sdw_device_id *id)
 		regcache_cache_only(wcd->regmap, true);
 	}
 
-	ret = component_add(dev, &wcd939x_sdw_component_ops);
+	ret = component_add(dev, &wcd_sdw_component_ops);
 	if (ret)
 		return ret;
 
@@ -1480,7 +1455,7 @@ static int wcd9390_remove(struct sdw_slave *pdev)
 	struct device *dev = &pdev->dev;
 	struct wcd939x_sdw_priv *wcd = dev_get_drvdata(dev);
 
-	component_del(dev, &wcd939x_sdw_component_ops);
+	component_del(dev, &wcd_sdw_component_ops);
 
 	if (wcd->regmap)
 		regmap_exit(wcd->regmap);
-- 
2.50.0


