Return-Path: <linux-kernel+bounces-758163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D8AB1CBD7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06C8E7AC004
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE522BD025;
	Wed,  6 Aug 2025 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ShfscUVo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA229E103
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754504344; cv=none; b=hotFXrMQIENHj7HByv0mgOQTzHs5yaAO3elA6U1YrnZmv3RYm1Q+vgryCif9xmWwhAB5WzWKDlaR2QaVDFACJ0SuhWQN8X0zq/ny+mo8eq+UpRimb68U8MyiRcAb1wc5P6EC4TqmdJSbM1odajnQMUL5d9MHFl60z8RcjWymt68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754504344; c=relaxed/simple;
	bh=NsvMJSp8F5T2ZEdBlHZhi4JPlQy4BlRF5C9s/0knJGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4qYiLc76wclBzLJ9M9eFfKVNyyQ0xTk2JohgXd9PyyWJaxiJ5iuS1cGvs49QYPZ6qXlyToTGkMAkfXGr8LIE9qTgt2AIKinYDNCkEUwwf5pHd766ZRi3tLopppvTQ7LGDGnAXsAC60SnH6z/ZIdI+uTBdzAJfFHHVR5EIxShV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ShfscUVo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576E9Jj8021958
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 18:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jrrvZt2wZRn
	DC6jHgt1LgU2Lm7JEFL30ZgbLxvffx8o=; b=ShfscUVov9wf+7wlxYdlbzSlowg
	H3fBf1R5NydgNYt5LqK+QJDqzYUZXchM7v4WZHnN7HszTDSA+AJzMt50bhfvbC9F
	E8wL4s/DmwzDB1dsSsaJuxu/Nru3kOOU/Idg7Z17h2K0GbQVxZPGsWQayd6ZQhyv
	VvXZMWUcaEUO26QoSTeYeQ4x2m9i9C0OjR06vLtjUrvJk8M5PWDPuailDH0GFyDl
	smY+1IuV6L62klgJbKYT0AzDGf/oTACZfeMuTWPDJSPTp03oaetL4jf/JkMAx1XC
	GCLNDz29gtwBLk4EvizxDcrJ/5hZfhbozEo62FmDmhEdFR453zC/N4S5eMw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy8bn9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 18:19:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-315af08594fso246389a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 11:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754504342; x=1755109142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrrvZt2wZRnDC6jHgt1LgU2Lm7JEFL30ZgbLxvffx8o=;
        b=QRyENiKhsM/eL5OSwjWT8DhIE1Q88y0hD3ViYTRma6SzcMT7jF9b8wPUHMlvduaof/
         GTjfzgTtfUAHMGMOBxjNxrvu46TxHNRoLYhcIP6BvqX/vh6NdGkx+/wUZw1vUkPpyh4a
         2klFIfBkDWRuV5ghtudr5IgEL0TJhF5AgRRrDgVCJusg54KWJ4zgjrgW1ddWimWCmqJ3
         twFl8KmD8f/Ua8/OHZyQpVPxwivbfN4nw80u6ab/fk2rE0TpmRSaMR4UdEmU9BN6tTTO
         YmP1ERXQBxov73lEmeFs9OcDY1/A6uS0iC8zTEh9a4sOHohT2QYCtgXR3R69vONan2S9
         +LIg==
X-Forwarded-Encrypted: i=1; AJvYcCVIEMd9bTT0pkOmP/YVU7bZIdxykf0HkZNI4wcsx5wgTjJ28gQsWryCOD8GTb/69Yk6AnmCDGOKgh3wdDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynX6d4kjSqXQGq3guap9jOisiUrC9qXMlljW3mhNB3Z+oOx3b2
	/OzzYNEbqAX7ghZkOkMJKM37A4hGW+Iw85jN/OahhXGawDIyfdmQSPDn+0St6JMUX2wG/P2vVme
	/vmlYJczmibtZAl/F0EbV8/pxInBdm8eB71RI1kr+iRfC+0Tr/96K6oGhsHjetfVlL+M=
X-Gm-Gg: ASbGncuAGvNoL6IuB1paoSWU4yxIu8dHhhQ4GMA0a+hsF4YV7JbWxwlQPOPDfUlYkSQ
	gn0vZMwFwwWDXHtZrgZbGi7oU9itrMyJAcY798vmUnT3k++RAaxOFiBM9QwHQt6kCcP3KT9gEU5
	tWfze789j1p+IV8fROdWuCz4YHuKSh6MA1j1fsp0JVugXHf5X5puk8oo3hMaZ1dkhkvKmb12gJj
	COqRvCD3kqpMYdfyylhktPQYtGsd3Z239QIOfIQQlYLIzGnwUw9nbfZtxhlRSJeEoVJRKj9IeJy
	EGGlYRK6jac7NNWQbInY7yCdMcVJijKBXnrrPrbzRwEDlSrWOO26idBOmZahNtdfNCQewyA4N2A
	4
X-Received: by 2002:a17:90b:1c89:b0:312:f650:c795 with SMTP id 98e67ed59e1d1-32167523459mr5187014a91.21.1754504341051;
        Wed, 06 Aug 2025 11:19:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGan0qt9cUm989lWBnGWFvNSan7KWo8h3FvpalPwExqSjk6AiaaNPuBVIOk7I3o8zf4jJtT8g==
X-Received: by 2002:a17:90b:1c89:b0:312:f650:c795 with SMTP id 98e67ed59e1d1-32167523459mr5186970a91.21.1754504340518;
        Wed, 06 Aug 2025 11:19:00 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f36311sm20235186a91.34.2025.08.06.11.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 11:19:00 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, quic_pkumpatl@quicinc.com,
        kernel@oss.qualcomm.com, Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v4 2/2] ASoC: codecs: wsa883x: Handle shared reset GPIO for WSA883x speakers
Date: Wed,  6 Aug 2025 23:48:18 +0530
Message-Id: <20250806181818.2817356-3-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806181818.2817356-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250806181818.2817356-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Fuo4HaMHUuDQmxBAbURu8fMf-3K3TDl9
X-Proofpoint-ORIG-GUID: Fuo4HaMHUuDQmxBAbURu8fMf-3K3TDl9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXz7LgPJ68OtwA
 fF2qc79GITNZ6v5pyl+r0aLl+xoReRoPiCrneNmqBKqy1m4WVQ5fvTHYvR+ngCdel14ckrcw3yX
 Zq8tG9bqTOQyKqmCKvOME1279IVJSB2LZhvjbscO4YJNRnYD2N/k9WjmboNRSvrMs94EWDyNGOT
 haGP7zJSyBnz1qMUKns68O8JQDbIjmcA0JX8xIG9XFjFlju/2LEgKXZ4AZHIBgZ4ietJ+cLXQio
 LMuxvZGCoapli9JfssQr6nBeO1ymcKRuJq4LF7xCYeF3gnwtZsJZdnsoUOZeSYug0LlQDKqopoc
 k4W38Ou/Or2rVcid3ZkWqmFBSVM3MvAYR9zRDYnSvckT2MhaKwjV4B+z+Yv7oM3TJhb+2nblZ5G
 v/8rzBX1
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=68939c96 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=DNsnnwWP5_ky-Fbzbr0A:9
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>

On some Qualcomm platforms such as QCS6490-RB3Gen2, the multiple
WSA8830/WSA8835 speaker amplifiers share a common reset (shutdown) GPIO.

To handle such scenario, use the reset controller framework and its
"reset-gpio" driver to handle such case. This allows proper handling
of all WSA883x speaker amplifiers on QCS6490-RB3Gen2 board.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 sound/soc/codecs/wsa883x.c | 57 +++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 188363b03b93..ec7a55d88576 100644
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
@@ -1546,6 +1548,46 @@ static const struct hwmon_chip_info wsa883x_hwmon_chip_info = {
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
@@ -1566,11 +1608,9 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to enable vdd regulator\n");
 
-	wsa883x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
-						GPIOD_FLAGS_BIT_NONEXCLUSIVE | GPIOD_OUT_HIGH);
-	if (IS_ERR(wsa883x->sd_n)) {
-		ret = dev_err_probe(dev, PTR_ERR(wsa883x->sd_n),
-				    "Shutdown Control GPIO not found\n");
+	ret = wsa883x_get_reset(dev, wsa883x);
+	if (ret) {
+		dev_dbg(dev, "Failed to get reset powerdown GPIO: %d\n", ret);
 		goto err;
 	}
 
@@ -1595,11 +1635,14 @@ static int wsa883x_probe(struct sdw_slave *pdev,
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
 	if (IS_ERR(wsa883x->regmap)) {
-		gpiod_direction_output(wsa883x->sd_n, 1);
 		ret = dev_err_probe(dev, PTR_ERR(wsa883x->regmap),
 				    "regmap_init failed\n");
 		goto err;
-- 
2.34.1


