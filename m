Return-Path: <linux-kernel+bounces-747014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AEEB12EA4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 10:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4EBB18935DF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 08:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9D11FC0ED;
	Sun, 27 Jul 2025 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HPefPEc/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764E1FC0E2
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753605123; cv=none; b=c+pUXRAiQqoimrZ4cnsH5OtWOLQQl+UQYHt4vL0igf8uKV4Tk6Lp6b4K8NXHlMVsOtSNKClEQLukLh2MBiTUaEB11ELcg6LVST+wh0pT0ghlc51sV4nXfhrMguIQZvSobiOyE/b+TA9+uddLKb+Cy7Gr9e60hDwGSKfltioYKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753605123; c=relaxed/simple;
	bh=+9bKbsOHOv6HUfFTojTu52PpIyeGZIM2BjFmGx8IJRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ti5SSnRWy2Q4CTB8m8efZbg/u2IglvvAVAfK8h8+1JYGn2BqyAKx/l4ft/srG+9FcPcd1isx8Yb/9euulwd9gzt696mv88o7vmZ/Nu2jSPDCAHaQoUEyLnUYyhbflLwFfcyaiEgk02RkdEUr1g6/yKmN/lJq8+1LH/sV8w82WMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HPefPEc/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56R5jiYU013201
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 08:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RZd0XO7FU/P
	/QgQIeS4PXIVz6WnhkQsNSg2RESxcNiY=; b=HPefPEc/95TVL6F6Rrg5jVJV650
	g1MwDGN3Sm/N+vLf0WpA4ttQrZfQ5trD8GZpqnLCsIqidja9jq/oB9bJ4K/SiD7x
	tCxeUwKep3XEZ/tkF9+Mm0tX/KULxpo6xWUkTE4OJucVhJh6HF54arRLkhVSE0V9
	O0fZfGOO4iYv8uTUMFUby1ImZ+XFXYAnSYbeTo1HQxOZN9G4P125guG7YLebzZCz
	0pi7JCfCilCXUI0rHbISq6Rq0A0+7d1iavroPvRYwhlNnNCqQf38roprCUTqdcQP
	4ElAr6B+6BttW2hhAe1OlgDjQ9cojkSiW4yyGetX9FiXVR5GNSq63vMyB4Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qsk1t1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 08:32:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b2c37558eccso2270891a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 01:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753605120; x=1754209920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZd0XO7FU/P/QgQIeS4PXIVz6WnhkQsNSg2RESxcNiY=;
        b=v7SB/B/ZVWm8bRbtmqIg92QbHjkWkLKmAUNLe+KypCLslGaGFk/c4aww63V1yXU7HG
         ct3xr6IzUZvu3ywcMNdi47xAxxBs68kIpl00OHRnZ+pfE4Em3hiW5tAnYSfv6+N28rDn
         sZXTj+vtXj+LrYiTE5f0CSTG8oORtQsueOK9fWSvffKmGPMdrAYeziW2apF0HfHaWYDi
         Of11LcdVihByx5R823DbaFS7TgEairwJUNHgtR1qZS6GOrGEp6Efij4xn6VlimDXuNEP
         t9J+4HUXPPsyn/GkHDdje1sQlKJk8LsfEjWNVljxDiGsCr3cr7qk060JJDFtPGauuB91
         Qimg==
X-Forwarded-Encrypted: i=1; AJvYcCVDNN7OL6hPUQ0FeY2mGlkyY42MArjvjhu7BMAfm8bgQYoZ5g0R8He1F/sR4XF7A5sG3f12UoUr74mclEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWkEHX0gDZVxwz6sjmglPO9F7CSx7t41MKTwoUpwADmcpbXPpy
	obNve4XYk0YmqwOjlm4fa9HGLYfxxGhKvC697u95ldyRnYyBZ+MdrvRFqN02Du61Hr+IeXAMcAa
	guHrdLoYS+njGceg1c+VMxkRswLKZhpj+lG7BnqdOvCkKR7/w0+hWMVlVeczUh3wIyhE=
X-Gm-Gg: ASbGncv0MrXkXAcsoJMdoDhQmtAz3HRaNQQcqhTQdSlqBzYYZyS1IhdseBoETRj+88t
	7dKcluTRAsbigKsTfobkJv4oq7t7K93cqsWypb1pBUlMvVs6umuqMaSlBf29UnBQfzoACjnFjSc
	gKQG1cDsm5ogWNp/i4M2TS74LNWjgtJ//Qm7hEuhyCZCOe4g4zFG2DRgQNQ7T4oRxPwX2cPUhDN
	v5V1EvieqSQYpGZwTloRQYVLMKH8HqBcr4CZUD7g1qcBJC3hXPOa6+m6Wx5K/B+HU7CzQdhOE+B
	EmUrk6bvV6CPxxQTlRfSawNv3iHUu8dovQrcbrzBpH+3zH1umx6cANxSqDNwXkh0gG7lHJyFtg/
	2
X-Received: by 2002:a17:902:fc8d:b0:23f:fa7c:7129 with SMTP id d9443c01a7336-23ffa7c7345mr26119135ad.25.1753605119921;
        Sun, 27 Jul 2025 01:31:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYL40jaLo95RgGHJ+Xssx0AAZaURi7P8YVF5vPE2C+sA20mi+8Arqz6EQswYNjlnFFzFdgKg==
X-Received: by 2002:a17:902:fc8d:b0:23f:fa7c:7129 with SMTP id d9443c01a7336-23ffa7c7345mr26118815ad.25.1753605119458;
        Sun, 27 Jul 2025 01:31:59 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401866c2c3sm2848645ad.30.2025.07.27.01.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 01:31:59 -0700 (PDT)
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
Subject: [PATCH v3 3/3] ASoC: codecs: wsa883x: Handle shared reset GPIO for WSA883x speakers
Date: Sun, 27 Jul 2025 14:01:17 +0530
Message-Id: <20250727083117.2415725-4-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250727083117.2415725-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250727083117.2415725-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KdDSsRYD c=1 sm=1 tr=0 ts=6885e400 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=pGReym1pqKqKmaA-xlUA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 2JdVz4M53MwcCN_qht2BTYR-wdjouY1E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDA3MyBTYWx0ZWRfXxXDSYzBDFwdQ
 uuF5M+UZC3lppC05/87n1DPjBoJGIjOaEL0NF6++VN7KqlcvLTBJuvrJpoUKbIzL/s4EoCLCPNu
 p6XlDSA3EBTM0CirO4kLphv0WI4rSBL+lyACgAdvqgmSNjORS3lIg7EWns8tQxSpP7a1BAe+nhC
 hbDVaCPWZdTT1A0+LXiRqmbXnlC78b2+9xo7+nmnHQAGSeekYuGnlDcdy1M9XvLmzMamYbwN3Nd
 8wCLnwCnnKsuL2bSSlvBC1M7hNswPielZzAXOtQCY+hPBKXsflIDKMKD6OYqG03wmo2Hj6zVlxD
 HkGQwslSlnIRbFgNqedu+KCdNAHidQAGX8zZl3K8+oQcbq0BV+740BkmdsSMTvwOt+qOQ0nsNtP
 q7lzn06G+dcNssWCHmVcn8G3VuRAFZ5TwtISsHJaRCGH8EqWuxt7BBoeVSIVQclpcSI6BWjT
X-Proofpoint-ORIG-GUID: 2JdVz4M53MwcCN_qht2BTYR-wdjouY1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507270073

On some Qualcomm platforms such as QCS6490-RB3Gen2, the multiple
WSA8830/WSA8835 speakers share a common reset (shutdown) GPIO.
To handle such cases, use the reset controller framework along
with the "reset-gpio" driver.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/codecs/wsa883x.c | 55 +++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index d5bc71b28a3a..0acf111f9583 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -469,6 +469,7 @@ struct wsa883x_priv {
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[WSA883X_MAX_SWR_PORTS];
 	struct gpio_desc *sd_n;
+	struct reset_control *sd_reset;
 	bool port_prepared[WSA883X_MAX_SWR_PORTS];
 	bool port_enable[WSA883X_MAX_SWR_PORTS];
 	int active_ports;
@@ -1547,6 +1548,24 @@ static const struct hwmon_chip_info wsa883x_hwmon_chip_info = {
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
 static void wsa883x_regulator_disable(void *data)
 {
 	struct wsa883x_priv *wsa883x = data;
@@ -1554,6 +1573,28 @@ static void wsa883x_regulator_disable(void *data)
 	regulator_disable(wsa883x->vdd);
 }
 
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
@@ -1583,11 +1624,9 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 	if (ret)
 		return ret;
 
-	wsa883x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
-						GPIOD_FLAGS_BIT_NONEXCLUSIVE | GPIOD_OUT_HIGH);
-	if (IS_ERR(wsa883x->sd_n))
-		return dev_err_probe(dev, PTR_ERR(wsa883x->sd_n),
-				     "Shutdown Control GPIO not found\n");
+	ret = wsa883x_get_reset(dev, wsa883x);
+	if (ret)
+		return ret;
 
 	dev_set_drvdata(dev, wsa883x);
 	wsa883x->slave = pdev;
@@ -1610,7 +1649,11 @@ static int wsa883x_probe(struct sdw_slave *pdev,
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
 	if (IS_ERR(wsa883x->regmap))
-- 
2.34.1


