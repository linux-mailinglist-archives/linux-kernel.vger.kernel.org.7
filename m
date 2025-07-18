Return-Path: <linux-kernel+bounces-736728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC981B0A0FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E54A1C485DC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188722C1597;
	Fri, 18 Jul 2025 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cCYYvp6R"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C11F2C08BB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835624; cv=none; b=GSHtnqjRoxP0rlT2lWuarzrlsrRxeM/uXk8d1mL7CfVAh24fSMEBfY0PrX8wgqjhKxz17+dvP+UqZloAFWwUs2EI8OijJ9VSFIisnb5l4zFi1Ts290IHNEogLjY6VDDcEx60/7FpPfl9Mlv4fYfEHRvpXL0lw8YglIffpQOFeG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835624; c=relaxed/simple;
	bh=07xKJikXxGu1w2IBiBwoPMNnpKvLi5WoDtQv5e+L78c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DeJv6OEaMfLZEvm65ssHJS3efXRnaRemcySb3PR96mzil8s05fJ8lydo2ygWJkSY8M0QP+ge+P0iAmTD+tdgrHyj7nG8mVRiaUO19zqe4egXI7cKS26BGE0CJpYhfje/+K6inWXoh0r6GOEsUfCMARJDgIhB9a2hiYmInS5iD+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cCYYvp6R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I7L2xL008701
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9mQquBEnOIM
	1hitS0Sq3r6vjyWp9aN4ghWgwERH+4ko=; b=cCYYvp6RajTA8TLsMx0HU96crzf
	YnFxfkM72TcuQJcFOTmBVzxe72WoldYHDS1O1q3PoBJ91dJz5JCtwPu2hjXq24wz
	NXP/kf7H4hOW4+BAF9P0vUOb/z0JjCoU7s2JWEqlq/8LsPdy6J3V489H8m5qc8KU
	rZUo1yIAHZbPrq0imyNXcVKWa+LM2YbYG+3lvRXS+A6UrYt9/59vnVwuWXXx4+g8
	CY2PIcR4FLp3BDil7WP3aH0vSQW05MeK9ZA9VcZrwBoSnSwD79uno5aMR0v3thIW
	5m8JmXK9LL5Mdo3dUsjwXJx82UOK9DjOdJSLW3EQxK+N/bLiIpcat2rLxtA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxbb6q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:47:01 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso3032266b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752835620; x=1753440420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mQquBEnOIM1hitS0Sq3r6vjyWp9aN4ghWgwERH+4ko=;
        b=tp8wLGzVyr/P+KxYpARqizm9JGiRKPBNd5L1y/c0Z+HdAyY/70WiXbjHSwADl/cF+m
         ok6n1YuPAVcZBq1pJkRYoHyUc5QiZXL8lq63SUHt5rPzqEvoGo3x0NSO3Pq1Dfd84hcK
         hOY2QggAbqrN+rtAIKQ28IUA/fwEa18ubbwv5dwT2QVW1x5uni7TNesmHohzD7nHPz/e
         FfO177Aox7MvYIcPLaUfknQcx6Un4DCp36Ehe5myVdYJ2M9mgaarbtOPxJfDTbtSYYww
         p0Mhh02WvTg0woOP6v3lrgi/zSPNK52bRzvLmvsqmcC2Zpxgv3lKZcGZ6bhb8Kv0AsP1
         O3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ExA1dsh6/AYaAiReo/CFTNM35rX78GblugOqpwBQz/O+CzLcDIhJP5ac9JOFYYwwoBJFncBI4MSzYmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCt6BpmQhBlhNnvpJ/9jKCUBVIYTAxlchN6CYyN3xT7f1Ya+p2
	HJw9Qe9RkSv2bojnbF+0pyvemabslM44p9WGR2OgR6EFMd8Tb3SNh6rbh60VJsTgmbrqY6rawcu
	w+HBFup6GdByY2U1lMgS2vUmWP5S/FofpCyzBv6Pwzei3N2Uc1VP6mXKxqv1iFYt3g9s=
X-Gm-Gg: ASbGncvt7cPxz/l0Uj+kva/A/tK5JHjGQPMiVMDFdY4aDvZax/TjX3OW4TMCQV3kiDo
	a3xFGCf8a1TSMKBPECufvljYHBjBOVGFEz9nYWZ+YBiUaT+Kqzr+FYGhWL8Qguw7kZPuazLvzKe
	78DMfPw14ZhM0C2lya14hdzreX34CZf7M52Hqn5YBxZGS0X10b5ZfKqqn+RZbjz4vmtFLr4nyRI
	lwsWccJkdevMJAq1SrKhM04f4b0k50PJVN4dMiIkVIJcKbGlPbKetWe/Ifbnh0HSDcQSR0kaGsg
	K7EN/8fupqfzk2ZQqWmX2e7ri3jIW/53ueHJlnFHP+0PS9S1H63R1S5FOXP6AFdUNLiSThwuQUx
	t
X-Received: by 2002:a05:6a00:3c8e:b0:742:b3a6:db16 with SMTP id d2e1a72fcca58-7572568553fmr14265464b3a.20.1752835619921;
        Fri, 18 Jul 2025 03:46:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCP8U1oTauA1NU8UmQ02YT/Qr/1dew6KPieiLsIUCV2VzGU/buEHCG47Bit1Kl9IaTNIxOzw==
X-Received: by 2002:a05:6a00:3c8e:b0:742:b3a6:db16 with SMTP id d2e1a72fcca58-7572568553fmr14265410b3a.20.1752835619420;
        Fri, 18 Jul 2025 03:46:59 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb678cdbsm1028989b3a.108.2025.07.18.03.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 03:46:59 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, quic_pkumpatl@quicinc.com,
        kernel@oss.qualcomm.com
Subject: [PATCH v2 2/2] ASoC: codecs: wsa883x: Handle shared reset GPIO for WSA883x speakers
Date: Fri, 18 Jul 2025 16:16:28 +0530
Message-Id: <20250718104628.3732645-3-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718104628.3732645-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250718104628.3732645-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OQaNJeROpTvZfkmNMrg5ixPj-OuZV4ki
X-Proofpoint-ORIG-GUID: OQaNJeROpTvZfkmNMrg5ixPj-OuZV4ki
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA4NCBTYWx0ZWRfXxVIl/dYaKL8i
 e/ATymOnQf19AW83DPOBkjuDqifMEF8chEFb8pNM0HdawixBCjICwVehX3tUY/0lxoBoLSynTE+
 zQnLTUsRLcMTN7St5AAd1LUDajFYU/HMq2j+WFgK95dJz4h5kgNe73Jbsy/vMFRZtYfchyJ+xX4
 hZmjl1OYnuixCRsdh4SozBKoXtGoFNY0oNZkF/r6QtQJsx3NTEKc/t/nACQo0dvdJzTzfBr/Tre
 SvR6vC4UZX3f1HzFz8ZVJv/vrXGpXCkF/CJuFzpV5GaKfu9OGwp5JAbatoe03TOun+QU+yOrOlj
 pZ2NYPESuSyv0Y9Zy6w6ER+UGhK6N2S8ios9dnkLtmK8uD4YptLOxnmTQSrrlzXWAwq53mjOXKU
 wJZ0+rwzmIWiq5T5jkh754C+6Fq6H+ueNbmGWLQQyJ7lcn36SqutKJRdscx3/1DsuCiiOeKE
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=687a2625 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=JpXIU2bkfXmfP1Z-X1EA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180084

On some Qualcomm platforms such as QCS6490-RB3Gen2, the multiple
WSA8830/WSA8835 speakers share a common reset (shutdown) GPIO.
To handle such cases, use the reset controller framework along
with the "reset-gpio" driver.

Register devm action to safely disable the regulator on device removal
to prevents a potential release warning from _regulator_put().

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/codecs/wsa883x.c | 93 +++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 188363b03b93..eea160a08183 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -14,6 +14,7 @@
 #include <linux/printk.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
@@ -468,6 +469,7 @@ struct wsa883x_priv {
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[WSA883X_MAX_SWR_PORTS];
 	struct gpio_desc *sd_n;
+	struct reset_control *sd_reset;
 	bool port_prepared[WSA883X_MAX_SWR_PORTS];
 	bool port_enable[WSA883X_MAX_SWR_PORTS];
 	int active_ports;
@@ -1546,6 +1548,53 @@ static const struct hwmon_chip_info wsa883x_hwmon_chip_info = {
 	.info	= wsa883x_hwmon_info,
 };
 
+static void wsa883x_reset_assert(void *data)
+{
+	struct wsa883x_priv *wsa883x = data;
+
+	if (wsa883x->sd_reset)
+		reset_control_assert(wsa883x->sd_reset);
+	else
+		gpiod_direction_output(wsa883x->sd_n, 1);
+}
+
+static void wsa883x_reset_deassert(struct wsa883x_priv *wsa883x)
+{
+	if (wsa883x->sd_reset)
+		reset_control_deassert(wsa883x->sd_reset);
+	else
+		gpiod_direction_output(wsa883x->sd_n, 0);
+}
+
+static void wsa883x_regulator_disable(void *data)
+{
+	struct wsa883x_priv *wsa883x = data;
+
+	regulator_disable(wsa883x->vdd);
+}
+
+static int wsa883x_get_reset(struct device *dev, struct wsa883x_priv *wsa883x)
+{
+	wsa883x->sd_reset = devm_reset_control_get_optional_shared_deasserted(dev, NULL);
+	if (IS_ERR(wsa883x->sd_reset))
+		return dev_err_probe(dev, PTR_ERR(wsa883x->sd_reset),
+				     "Failed to get reset\n");
+	/*
+	 * if sd_reset: NULL, so use the backwards compatible way for powerdown-gpios,
+	 * which does not handle sharing GPIO properly.
+	 */
+	if (!wsa883x->sd_reset) {
+		wsa883x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
+							GPIOD_FLAGS_BIT_NONEXCLUSIVE |
+							GPIOD_OUT_HIGH);
+		if (IS_ERR(wsa883x->sd_n))
+			return dev_err_probe(dev, PTR_ERR(wsa883x->sd_n),
+					     "Shutdown Control GPIO not found\n");
+	}
+
+	return 0;
+}
+
 static int wsa883x_probe(struct sdw_slave *pdev,
 			 const struct sdw_device_id *id)
 {
@@ -1566,13 +1615,18 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to enable vdd regulator\n");
 
-	wsa883x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
-						GPIOD_FLAGS_BIT_NONEXCLUSIVE | GPIOD_OUT_HIGH);
-	if (IS_ERR(wsa883x->sd_n)) {
-		ret = dev_err_probe(dev, PTR_ERR(wsa883x->sd_n),
-				    "Shutdown Control GPIO not found\n");
-		goto err;
-	}
+	ret = wsa883x_get_reset(dev, wsa883x);
+	if (ret)
+		return ret;
+
+	/*
+	 * Register devm action to safely disable the regulator on device removal.
+	 * This prevents a potential release warning from _regulator_put().
+	 */
+	ret = devm_add_action_or_reset(dev, wsa883x_regulator_disable,
+				       wsa883x);
+	if (ret)
+		return ret;
 
 	dev_set_drvdata(dev, wsa883x);
 	wsa883x->slave = pdev;
@@ -1595,15 +1649,16 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 	pdev->prop.simple_clk_stop_capable = true;
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
-	gpiod_direction_output(wsa883x->sd_n, 0);
+
+	wsa883x_reset_deassert(wsa883x);
+	ret = devm_add_action_or_reset(dev, wsa883x_reset_assert, wsa883x);
+	if (ret)
+		return ret;
 
 	wsa883x->regmap = devm_regmap_init_sdw(pdev, &wsa883x_regmap_config);
-	if (IS_ERR(wsa883x->regmap)) {
-		gpiod_direction_output(wsa883x->sd_n, 1);
-		ret = dev_err_probe(dev, PTR_ERR(wsa883x->regmap),
-				    "regmap_init failed\n");
-		goto err;
-	}
+	if (IS_ERR(wsa883x->regmap))
+		return dev_err_probe(dev, PTR_ERR(wsa883x->regmap),
+				     "regmap_init failed\n");
 
 	if (IS_REACHABLE(CONFIG_HWMON)) {
 		struct device *hwmon;
@@ -1623,16 +1678,10 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	ret = devm_snd_soc_register_component(dev,
-					      &wsa883x_component_drv,
+	return devm_snd_soc_register_component(dev,
+					       &wsa883x_component_drv,
 					       wsa883x_dais,
 					       ARRAY_SIZE(wsa883x_dais));
-err:
-	if (ret)
-		regulator_disable(wsa883x->vdd);
-
-	return ret;
-
 }
 
 static int wsa883x_runtime_suspend(struct device *dev)
-- 
2.34.1


