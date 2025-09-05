Return-Path: <linux-kernel+bounces-803275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FC2B45CEA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A6D1C84E56
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247463728BD;
	Fri,  5 Sep 2025 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="npD7r6xD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AD1313293
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087094; cv=none; b=f4FEbPq7SkRpvP/rHGmum7eY+MSj9ko9u6l2+8P7WKgQ03UNCbPAaCDtZ4Md5eM2d1GIUNkU+9kcM+Qy57G8oNnuTyNbDxqI/aLVu6IHjzBBERLluUL+fPylUjWiVwFKTYdxHiE4eQwLGnAl/NpV1O9l4Nj/NsZrt7qGdib7pRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087094; c=relaxed/simple;
	bh=PPCnT4+/UjE7beMeYgyhQF55hZMGq11H4hwr+tBfo2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXLy8zpEM3rQYGvz8uzCKUb/g7jrPUA7J2nYsF/dmeoGX9ep/Dz66CQgwdpijCeLdv9o/1Xm8LPokCXBWZLPIVlmTNri1D0KpmxX6cHsGchVOP0pjKPtRUQ+xowwG8ch/iyzcZvf8CfkTLEmuRFQYJ/+KM2CVo5veBtQBAeprOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=npD7r6xD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857SsHQ031977
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 15:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=H0joPrmWAzQ
	FyLXYkYTfG1C6Z6lxgTGnKdLzru7jbe8=; b=npD7r6xDXX6/p7sIQxVeiGJosN8
	r3LLvyAZq/Pr1wLS8OCrs8w/WZa6cSl1O54OvOGICD12S5LGXTz3g19pq8XONW3o
	Ya8RqykH6Y4lc6YrzA81LlJmFvs25QLkaK2pd02hYd+1TKpgRKWrY0fMgw3IzN/0
	6G9X/4A0ZOmROeegn0XGvyzv2nthseTd00Lr9Jtk5nPOlgnW/CcJRIsEfTPnDgXp
	qqX95IBegf+ldOFZ/kpd44O1zGRCqLugOHVq3ZbBjTWKTGnAnpU4wSecL/0WgwSM
	EiLhuJylbMo4NHFVZgSPM4zBMTGFi2zmdsUTUOTD7S4PA/EuX07koAfJubQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw0bnx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:44:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5f112dafeso12542901cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087091; x=1757691891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0joPrmWAzQFyLXYkYTfG1C6Z6lxgTGnKdLzru7jbe8=;
        b=SAk9/JojWNAEz/pNP8TlGVYApCgwT+dC4H1HywMsmRzYxepAy34XwwqH6YCZPvdeD6
         UmNeiCwYT40oQ4mtruB5kZCyRswvLatLdzoRNt7U7JB+7tMYYS0J6EQZ6AjeWBGjhaUi
         sZYGSLmCVoeMKxKksL1TI9n+zUu7YQUnQIvnSyAM7Z/qVLeBCC+nZlwkhPli2InYmlmD
         fUF/HIvX8ldjWvNlBitFQo+Y10ngKFYWdo4OH1D/xr7aei5D63cnGoBRcD4TPcSSnS4u
         qIZ3U3LUGLYBXPbOalA474NO22JRumVIbNud00JtvCB8jrGHUOW1C2soRkZ1yipsnPNW
         MxJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEPGkvZeAymOX8v/eGo8T9srmGW3ErhrnBUIouI3yWcFwliB17qE1hN8WSZgg4Sck3mBTtiZRGieXwO98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2hcvsfvtzKdHPHNin9dpFNmDk3A0zMS9WjE6c8jw4sP/DkGG
	sXrD6VQdyPulwUesB5HzQFa+nPOOnoRYwvqnbaSJGVhdJ1VSQzTMbFxPnEM0Bk8WLOeF3Qv5ixN
	sQCWVIRNa6lueGscOd20crhU9EaVJtsCxObUSGjcZtYP4B/PaOikVW2KNFoG9dyILvYk=
X-Gm-Gg: ASbGnctbR215BoUwrA5IPxhDtMBcq45m53x4OD9ZcYduQbpX374sXJHMyZqVV4BjZS2
	djr4g+FHqYUBXou52TI6hiEfh8we8fA3/8FbcTlf0NscPdAs2NDA9u552Qg+sFQm0ugMkI06/c1
	uY6lUaE3czzyh83ej34RCbK7OK3hjqWFEWYwj4IevB10fJzRHVbN24B/c13Z9hnVAncK5dR41ZL
	W84dBirXRA9PFZrf0TRxXQwzZiBzcMJyThIx2Z8NPem1YusWmViLFk0w33wkjZgk7Mmbj5emetM
	X1Vd5rsueHU0o1H9U7k9/AprcZvZrsMwTwg9+EFAdSe/0zxVk0lxgg==
X-Received: by 2002:a05:622a:a13:b0:4b5:de12:4c34 with SMTP id d75a77b69052e-4b5de1250c6mr59824011cf.75.1757087090532;
        Fri, 05 Sep 2025 08:44:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgmamiKdfpxGgwl8PZbDfmu8tMOYi1WuWxDIqz7Xspu99/7mmyGnLvR1GMvKJQF2Us5kfOeA==
X-Received: by 2002:a05:622a:a13:b0:4b5:de12:4c34 with SMTP id d75a77b69052e-4b5de1250c6mr59823671cf.75.1757087089976;
        Fri, 05 Sep 2025 08:44:49 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm165716585e9.6.2025.09.05.08.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:44:48 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org, srini@kernel.org,
        yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org, krzysztof.kozlowski@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, linux-sound@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 10/12] ASoC: codecs: wcd-common: move status_update callback to common
Date: Fri,  5 Sep 2025 16:44:28 +0100
Message-ID: <20250905154430.12268-11-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-GUID: WAirvWHBDS4msIj0QxcxwCJw2VTvajU8
X-Proofpoint-ORIG-GUID: WAirvWHBDS4msIj0QxcxwCJw2VTvajU8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX3/b0vzMQpKfJ
 RJJAfYIc+YKsz6xCvcl31TX3gdfv1AlW6jyvXP0Vs33YBnCwLRAGrb/tSfxdBNz1qzbxhMkSkIz
 R++cN/lGnjouLlVAxHiGWcpla3UcbzPCelBvDiDafJcyoiHPVv20WNZFEaKhVBAGIfbAh7gkoho
 NiJYEviJeLuKB3KCYH1WnmnJAPeDKXNLI5gc4TQEj6WrN01OjHV8k8uAqf3yhSXa+R/cgJjl+3f
 cg0o9tsVHloUD6kYroMoCMv1z3t08EMk4NLjMe9v0Wvu/6o1IqZWtWcnZUZtzPyHJbh1cXkwqV0
 QktxTAaXBQUGZVpbKcg/2HMcoS1/lHH6FxPDnuKyjdN1FQckYVtLByDryPwpNLc6IJ8C2DejBit
 e6clGpNK
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68bb0573 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=sWKEhP36mHoA:10 a=EUspDBNiAAAA:8 a=lLZ5r3BOYuU-AXZT-04A:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

Soundwire update_status, bus_config and interrupt callbacks for wcd937x,
wcd938x, wcd939x soundwire codecs are exactly identlical, move them to
common driver to remove this duplicate code.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/wcd-common.c  | 46 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wcd-common.h  |  5 ++++
 sound/soc/codecs/wcd937x-sdw.c | 28 +++------------------
 sound/soc/codecs/wcd938x-sdw.c | 41 +++---------------------------
 sound/soc/codecs/wcd939x-sdw.c | 42 +++----------------------------
 5 files changed, 62 insertions(+), 100 deletions(-)

diff --git a/sound/soc/codecs/wcd-common.c b/sound/soc/codecs/wcd-common.c
index 585d3e036900..6aaa6e2c955a 100644
--- a/sound/soc/codecs/wcd-common.c
+++ b/sound/soc/codecs/wcd-common.c
@@ -9,6 +9,9 @@
 #include <linux/printk.h>
 #include <linux/component.h>
 #include <linux/pm_runtime.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_type.h>
+#include <linux/regmap.h>
 
 #include "wcd-common.h"
 
@@ -16,6 +19,8 @@
 #define WCD_DEF_MICBIAS_MV	1800
 #define WCD_MAX_MICBIAS_MV	2850
 
+#define SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(m) (0xE0 + 0x10 * (m))
+
 int wcd_get_micb_vout_ctl_val(struct device *dev, u32 micb_mv)
 {
 	/* min micbias voltage is 1V and maximum is 2.85V */
@@ -93,5 +98,46 @@ const struct component_ops wcd_sdw_component_ops = {
 };
 EXPORT_SYMBOL_GPL(wcd_sdw_component_ops);
 
+int wcd_update_status(struct sdw_slave *slave, enum sdw_slave_status status)
+{
+	struct regmap *regmap = dev_get_regmap(&slave->dev, NULL);
+
+	if (regmap && status == SDW_SLAVE_ATTACHED) {
+		/* Write out any cached changes that happened between probe and attach */
+		regcache_cache_only(regmap, false);
+		return regcache_sync(regmap);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wcd_update_status);
+
+int wcd_bus_config(struct sdw_slave *slave, struct sdw_bus_params *params)
+{
+	sdw_write(slave, SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(params->next_bank), 0x01);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wcd_bus_config);
+
+int wcd_interrupt_callback(struct sdw_slave *slave, struct irq_domain *slave_irq,
+		unsigned int wcd_intr_status0, unsigned int wcd_intr_status1,
+		unsigned int wcd_intr_status2)
+{
+	struct regmap *regmap = dev_get_regmap(&slave->dev, NULL);
+	u32 sts1, sts2, sts3;
+
+	do {
+		handle_nested_irq(irq_find_mapping(slave_irq, 0));
+		regmap_read(regmap, wcd_intr_status0, &sts1);
+		regmap_read(regmap, wcd_intr_status1, &sts2);
+		regmap_read(regmap, wcd_intr_status2, &sts3);
+
+	} while (sts1 || sts2 || sts3);
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_GPL(wcd_interrupt_callback);
+
 MODULE_DESCRIPTION("Common Qualcomm WCD Codec helpers driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wcd-common.h b/sound/soc/codecs/wcd-common.h
index 85e5818b9b0c..a844908de433 100644
--- a/sound/soc/codecs/wcd-common.h
+++ b/sound/soc/codecs/wcd-common.h
@@ -35,5 +35,10 @@ struct wcd_common {
 extern const struct component_ops wcd_sdw_component_ops;
 int wcd_get_micb_vout_ctl_val(struct device *dev, u32 micb_mv);
 int wcd_dt_parse_micbias_info(struct wcd_common *common);
+int wcd_update_status(struct sdw_slave *slave, enum sdw_slave_status status);
+int wcd_bus_config(struct sdw_slave *slave, struct sdw_bus_params *params);
+int wcd_interrupt_callback(struct sdw_slave *slave, struct irq_domain *slave_irq,
+		unsigned int wcd_intr_status0, unsigned int wcd_intr_status1,
+		unsigned int wcd_intr_status2);
 
 #endif /* __WCD_COMMON_H___  */
diff --git a/sound/soc/codecs/wcd937x-sdw.c b/sound/soc/codecs/wcd937x-sdw.c
index 59c353cafd31..1878d67e3fa1 100644
--- a/sound/soc/codecs/wcd937x-sdw.c
+++ b/sound/soc/codecs/wcd937x-sdw.c
@@ -112,19 +112,6 @@ int wcd937x_sdw_hw_params(struct wcd937x_sdw_priv *wcd,
 }
 EXPORT_SYMBOL_GPL(wcd937x_sdw_hw_params);
 
-static int wcd9370_update_status(struct sdw_slave *slave, enum sdw_slave_status status)
-{
-	struct wcd937x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
-
-	if (wcd->regmap && status == SDW_SLAVE_ATTACHED) {
-		/* Write out any cached changes that happened between probe and attach */
-		regcache_cache_only(wcd->regmap, false);
-		return regcache_sync(wcd->regmap);
-	}
-
-	return 0;
-}
-
 /*
  * Handle Soundwire out-of-band interrupt event by triggering
  * the first irq of the slave_irq irq domain, which then will
@@ -135,18 +122,9 @@ static int wcd9370_interrupt_callback(struct sdw_slave *slave,
 				      struct sdw_slave_intr_status *status)
 {
 	struct wcd937x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
-	struct irq_domain *slave_irq = wcd->slave_irq;
-	u32 sts1, sts2, sts3;
-
-	do {
-		handle_nested_irq(irq_find_mapping(slave_irq, 0));
-		regmap_read(wcd->regmap, WCD937X_DIGITAL_INTR_STATUS_0, &sts1);
-		regmap_read(wcd->regmap, WCD937X_DIGITAL_INTR_STATUS_1, &sts2);
-		regmap_read(wcd->regmap, WCD937X_DIGITAL_INTR_STATUS_2, &sts3);
-
-	} while (sts1 || sts2 || sts3);
 
-	return IRQ_HANDLED;
+	return wcd_interrupt_callback(slave, wcd->slave_irq, WCD937X_DIGITAL_INTR_STATUS_0,
+				WCD937X_DIGITAL_INTR_STATUS_1, WCD937X_DIGITAL_INTR_STATUS_2);
 }
 
 static const struct reg_default wcd937x_defaults[] = {
@@ -979,7 +957,7 @@ static const struct regmap_config wcd937x_regmap_config = {
 };
 
 static const struct sdw_slave_ops wcd9370_slave_ops = {
-	.update_status = wcd9370_update_status,
+	.update_status = wcd_update_status,
 	.interrupt_callback = wcd9370_interrupt_callback,
 };
 
diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 92714aef09d5..add907cb2706 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -20,8 +20,6 @@
 #include "wcd938x.h"
 #include "wcd-common.h"
 
-#define SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(m) (0xE0 + 0x10 * (m))
-
 static const struct wcd_sdw_ch_info wcd938x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD938X_HPH_L, WCD938X_HPH_PORT, BIT(0)),
 	WCD_SDW_CH(WCD938X_HPH_R, WCD938X_HPH_PORT, BIT(1)),
@@ -142,44 +140,13 @@ int wcd938x_sdw_set_sdw_stream(struct wcd938x_sdw_priv *wcd,
 }
 EXPORT_SYMBOL_GPL(wcd938x_sdw_set_sdw_stream);
 
-static int wcd9380_update_status(struct sdw_slave *slave,
-				 enum sdw_slave_status status)
-{
-	struct wcd938x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
-
-	if (wcd->regmap && (status == SDW_SLAVE_ATTACHED)) {
-		/* Write out any cached changes that happened between probe and attach */
-		regcache_cache_only(wcd->regmap, false);
-		return regcache_sync(wcd->regmap);
-	}
-
-	return 0;
-}
-
-static int wcd9380_bus_config(struct sdw_slave *slave,
-			      struct sdw_bus_params *params)
-{
-	sdw_write(slave, SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(params->next_bank),  0x01);
-
-	return 0;
-}
-
 static int wcd9380_interrupt_callback(struct sdw_slave *slave,
 				      struct sdw_slave_intr_status *status)
 {
 	struct wcd938x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
-	struct irq_domain *slave_irq = wcd->slave_irq;
-	u32 sts1, sts2, sts3;
-
-	do {
-		handle_nested_irq(irq_find_mapping(slave_irq, 0));
-		regmap_read(wcd->regmap, WCD938X_DIGITAL_INTR_STATUS_0, &sts1);
-		regmap_read(wcd->regmap, WCD938X_DIGITAL_INTR_STATUS_1, &sts2);
-		regmap_read(wcd->regmap, WCD938X_DIGITAL_INTR_STATUS_2, &sts3);
-
-	} while (sts1 || sts2 || sts3);
 
-	return IRQ_HANDLED;
+	return wcd_interrupt_callback(slave, wcd->slave_irq, WCD938X_DIGITAL_INTR_STATUS_0,
+				WCD938X_DIGITAL_INTR_STATUS_1, WCD938X_DIGITAL_INTR_STATUS_2);
 }
 
 static const struct reg_default wcd938x_defaults[] = {
@@ -1177,9 +1144,9 @@ static const struct regmap_config wcd938x_regmap_config = {
 };
 
 static const struct sdw_slave_ops wcd9380_slave_ops = {
-	.update_status = wcd9380_update_status,
+	.update_status = wcd_update_status,
 	.interrupt_callback = wcd9380_interrupt_callback,
-	.bus_config = wcd9380_bus_config,
+	.bus_config = wcd_bus_config,
 };
 
 static int wcd9380_probe(struct sdw_slave *pdev,
diff --git a/sound/soc/codecs/wcd939x-sdw.c b/sound/soc/codecs/wcd939x-sdw.c
index 38da706d80be..d369100a2457 100644
--- a/sound/soc/codecs/wcd939x-sdw.c
+++ b/sound/soc/codecs/wcd939x-sdw.c
@@ -22,8 +22,6 @@
 #include "wcd939x.h"
 #include "wcd-common.h"
 
-#define SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(m) (0xE0 + 0x10 * (m))
-
 static const struct wcd_sdw_ch_info wcd939x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD939X_HPH_L, WCD939X_HPH_PORT, BIT(0)),
 	WCD_SDW_CH(WCD939X_HPH_R, WCD939X_HPH_PORT, BIT(1)),
@@ -187,29 +185,6 @@ int wcd939x_sdw_set_sdw_stream(struct wcd939x_sdw_priv *wcd,
 }
 EXPORT_SYMBOL_GPL(wcd939x_sdw_set_sdw_stream);
 
-static int wcd9390_update_status(struct sdw_slave *slave,
-				 enum sdw_slave_status status)
-{
-	struct wcd939x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
-
-	if (wcd->regmap && status == SDW_SLAVE_ATTACHED) {
-		/* Write out any cached changes that happened between probe and attach */
-		regcache_cache_only(wcd->regmap, false);
-		return regcache_sync(wcd->regmap);
-	}
-
-	return 0;
-}
-
-static int wcd9390_bus_config(struct sdw_slave *slave,
-			      struct sdw_bus_params *params)
-{
-	sdw_write(slave, SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(params->next_bank),
-		  0x01);
-
-	return 0;
-}
-
 /*
  * Handle Soundwire out-of-band interrupt event by triggering
  * the first irq of the slave_irq irq domain, which then will
@@ -220,18 +195,9 @@ static int wcd9390_interrupt_callback(struct sdw_slave *slave,
 				      struct sdw_slave_intr_status *status)
 {
 	struct wcd939x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
-	struct irq_domain *slave_irq = wcd->slave_irq;
-	u32 sts1, sts2, sts3;
-
-	do {
-		handle_nested_irq(irq_find_mapping(slave_irq, 0));
-		regmap_read(wcd->regmap, WCD939X_DIGITAL_INTR_STATUS_0, &sts1);
-		regmap_read(wcd->regmap, WCD939X_DIGITAL_INTR_STATUS_1, &sts2);
-		regmap_read(wcd->regmap, WCD939X_DIGITAL_INTR_STATUS_2, &sts3);
-
-	} while (sts1 || sts2 || sts3);
 
-	return IRQ_HANDLED;
+	return wcd_interrupt_callback(slave, wcd->slave_irq, WCD939X_DIGITAL_INTR_STATUS_0,
+			WCD939X_DIGITAL_INTR_STATUS_1, WCD939X_DIGITAL_INTR_STATUS_2);
 }
 
 static const struct reg_default wcd939x_defaults[] = {
@@ -1364,9 +1330,9 @@ static const struct regmap_config wcd939x_regmap_config = {
 };
 
 static const struct sdw_slave_ops wcd9390_slave_ops = {
-	.update_status = wcd9390_update_status,
+	.update_status = wcd_update_status,
 	.interrupt_callback = wcd9390_interrupt_callback,
-	.bus_config = wcd9390_bus_config,
+	.bus_config = wcd_bus_config,
 };
 
 static int wcd9390_probe(struct sdw_slave *pdev, const struct sdw_device_id *id)
-- 
2.50.0


