Return-Path: <linux-kernel+bounces-756424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDB6B1B3CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B956231A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A089C27467D;
	Tue,  5 Aug 2025 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0EDpt81"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3650527381C;
	Tue,  5 Aug 2025 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398220; cv=none; b=BubTIqm/+ml+4HClA6Z+bNwtEWcMdSIAm9utFNjTfjqC75lL79eWWVWj8iArZITNWslh9m+GnbylNInuRESraAwZFTYOD35Wb23L95HMs9RyniK4QI9M6XQmmcEwEGYCckyEpcKl5HwalmuxI6tv5n2+jOiEQeoYT91bE273nrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398220; c=relaxed/simple;
	bh=jGSh/LkL0X52CDO3zdkc5x7ncFnzPCmvG4RFuADPvdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHgKRX+dDP3u8W0QD4+0y5EtHUMF8lcPDmjl0e4NO+xOf5R4W3quAwZDSgLkNZ9Hnz4qpQzZnWbO+Eod6v6FGhe9UtI+tfxzOMMULThAiYo7b9mXnnrfy7Tw/g+NWZi9/oe8qdZKJx9DFFLuuZcecxS39+jHTw5+k60Mng+Ta/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0EDpt81; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6155e75a9acso8101446a12.0;
        Tue, 05 Aug 2025 05:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754398217; x=1755003017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yCdqk783l2O4FNUDcUuzsOge6j9py4J7WwVbdxRdP8=;
        b=G0EDpt81e3ui4hADtRA+AxAlTPaVonzPKKnDiMWQHvGuO51iPY2EFyxM/z5k05IpGc
         fUln7roDRLTXEPkQs5v27OPnVcnzfD5snG2jX1d7Bb19Xwq3HOnqQ2npqVszzGIroIlA
         zx7u9uJ7SfMWz6q0kiotFjeker5iEN9XIjptfPkEnWjWh3tO99QzivLF9lgwvQrXdJkY
         MoluITrofmn6nhRhLE2xaDiwAvl2NmR1tCmOrdTtnVHBgNEPBEAQafEgCZHa7HrLfMp8
         4RtjC+/Ks2FDC3SZHQJbS3KpkZ+95FonGAD9OIXZfGEXP//zS9vvr/OaV6AQJ5B5f2ph
         tT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754398217; x=1755003017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yCdqk783l2O4FNUDcUuzsOge6j9py4J7WwVbdxRdP8=;
        b=UYAGV37kXoEnDdvI7ZhA1ezWt70DzkgCJSdV9Rl+WxRIDEu3FFdRP1UhdWCVHzef94
         UTMD+Vy4U27gL0a+8JNq3O3YVQp5yZTT6fsPAJVkVKLLEdnMNc9nR8PHyyvUfwZErqgN
         fARy7C00YtRgfjgfbHTzOQOpAj9plQWJiLuSdz1JL+8QQmWVGAmhxn1qPNh4Dup0nnUg
         /uQDAw9pAu2UC2dkhcpinrvmYA5puAl9fVY3WkDXnuDZwFh3wY9jTN6F/t9Bn4Jva8S8
         EUF9/bJB4lRvHSheLl1Eb44rdjQGjXyRUL+TZebV2S7xRwzxabZc5UsO5b7uIJVrAIJZ
         izVA==
X-Forwarded-Encrypted: i=1; AJvYcCVex0BfCyvVFR21bQjXcA67QBE9Iz0D2REgKCG4tYs5PclBkIVTVzdu4fOV084aiV+gf1Sjfwp6rQKT2kI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw31mRxmxhlvmNvjr1puADgGg0HWhWhQKH/2+GXiCjDb1/UXtc
	rRe1YgSjP2JtfntHliV9YwaWNt1O9B8CEWDmP3QQdDmiMPLqOLkiDVAhqYT3fUpnI6fDLw==
X-Gm-Gg: ASbGncu1eMup7+eh8KbRxqhc3ja70ItmM3dmjzc10E74E8hgmBEqWzOdzyT/IWBRaC4
	KQBp7mdXZrtFzYqRxK1X+aSHGlp9vLlxvM7KpVuilCZ6dqgjS1USJJ2PK8FYIW/35g5pGeK3rIk
	QMnH0lpxm0ICBZ+xejcQe8fHvrbe8t8buYazIzqEAl7mU2hWDFJOOtciuvkZvgw9uCBdKUANizC
	+uXwhl1KjYeBwQloy9hxeqUksjiqypePgvHEf7MIAJwjC780hCmKFP/H3lcCj3zZItYrLd1M3Ca
	OYOM3z/xuXgM6q8z/RtqoFG8gpkm1mFgBTK48V318K+GGOAQrCrGCLWDNtdp1ODpdThFJxIa5fZ
	uspyJyvMDpnIIODu2DDwQ0rIL
X-Google-Smtp-Source: AGHT+IGgVVg8/lqy8zr7O3W94feKtEZYw9quK1epE4thGB2ryISlPd8xGSLMn3qy9LQ2M8exu/AGoQ==
X-Received: by 2002:a05:6402:270a:b0:615:cc03:e6ae with SMTP id 4fb4d7f45d1cf-615e6eb6a33mr11559383a12.6.1754398217189;
        Tue, 05 Aug 2025 05:50:17 -0700 (PDT)
Received: from artem-pc.. ([88.201.168.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615cc38aeccsm6811176a12.2.2025.08.05.05.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 05:50:16 -0700 (PDT)
From: "a.shimko" <artyom.shimko@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: "a.shimko" <artyom.shimko@gmail.com>,
	linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	jdelvare@suse.com,
	guenter.roeck@linux.com
Subject: [PATCH 3/3] hwmon: scmi: Enhance error reporting with dev_err_probe
Date: Tue,  5 Aug 2025 15:43:59 +0300
Message-ID: <20250805125003.12573-4-artyom.shimko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805125003.12573-1-artyom.shimko@gmail.com>
References: <20250805125003.12573-1-artyom.shimko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Shimko <artyom.shimko@gmail.com>

Replace error returns with dev_err_probe() throughout driver:
- Add descriptive error messages for all failure cases
- Include relevant context (sensor IDs, types etc)
- Standardize error reporting format

Improved messages include:
- "No valid sensor info for index %d"
- "Failed to allocate channel info array"
- "SCMI protocol ops not initialized"

Signed-off-by: Artem Shimko <artyom.shimko@gmail.com>
---
 drivers/hwmon/scmi-hwmon.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index d03174922e65..081502418dfa 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -240,26 +240,36 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 	struct scmi_protocol_handle *ph;
 
 	if (!handle)
-		return -ENODEV;
+		return dev_err_probe(dev, -ENODEV, "SCMI device handle is NULL\n");
 
 	sensor_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_SENSOR, &ph);
-	if (IS_ERR(sensor_ops))
-		return PTR_ERR(sensor_ops);
+	if (IS_ERR_OR_NULL(sensor_ops)) {
+		if (IS_ERR(sensor_ops))
+			return dev_err_probe(dev, PTR_ERR(sensor_ops),
+					     "SCMI sensor protocol acquisition failed\n");
+		return dev_err_probe(dev, -EPROTO,
+				     "SCMI sensor protocol ops structure unexpectedly NULL\n");
+	}
+
+	if (!sensor_ops->info_get || !sensor_ops->count_get)
+		return dev_err_probe(dev, -ENOENT,
+				     "SCMI sensor protocol operations are not initialized\n");
 
 	nr_sensors = sensor_ops->count_get(ph);
 	if (!nr_sensors)
-		return -EIO;
+		return dev_err_probe(dev, -EIO, "No sensors found\n");
 
 	scmi_sensors = devm_kzalloc(dev, sizeof(*scmi_sensors), GFP_KERNEL);
 	if (!scmi_sensors)
-		return -ENOMEM;
+		return dev_err_probe(dev, -ENOMEM, "Failed to allocate scmi_sensors structure\n");
 
 	scmi_sensors->ph = ph;
 
 	for (i = 0; i < nr_sensors; i++) {
 		sensor = sensor_ops->info_get(ph, i);
 		if (!sensor)
-			return -EINVAL;
+			return dev_err_probe(dev, -EINVAL,
+					     "Failed to get sensor info for sensor %d\n", i);
 
 		switch (sensor->type) {
 		case TEMPERATURE_C:
@@ -285,12 +295,12 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 	scmi_hwmon_chan = devm_kcalloc(dev, nr_types, sizeof(*scmi_hwmon_chan),
 				       GFP_KERNEL);
 	if (!scmi_hwmon_chan)
-		return -ENOMEM;
+		return dev_err_probe(dev, -ENOMEM, "Failed to allocate channel info array\n");
 
 	ptr_scmi_ci = devm_kcalloc(dev, nr_types + 1, sizeof(*ptr_scmi_ci),
 				   GFP_KERNEL);
 	if (!ptr_scmi_ci)
-		return -ENOMEM;
+		return dev_err_probe(dev, -ENOMEM, "Failed to allocate channel info pointers\n");
 
 	scmi_chip_info.info = ptr_scmi_ci;
 	chip_info = &scmi_chip_info;
@@ -307,7 +317,8 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 			devm_kcalloc(dev, nr_count[type],
 				     sizeof(*scmi_sensors->info), GFP_KERNEL);
 		if (!scmi_sensors->info[type])
-			return -ENOMEM;
+			return dev_err_probe(dev, -ENOMEM,
+					     "Failed to allocate sensor info for type %d\n", type);
 	}
 
 	for (i = nr_sensors - 1; i >= 0 ; i--) {
@@ -336,7 +347,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 						     scmi_sensors, chip_info,
 						     NULL);
 	if (IS_ERR(hwdev))
-		return PTR_ERR(hwdev);
+		return dev_err_probe(dev, PTR_ERR(hwdev), "Failed to register hwmon device\n");
 
 	for (i = 0; i < nr_count_temp; i++) {
 		int ret;
@@ -352,7 +363,9 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 		ret = scmi_thermal_sensor_register(dev, ph, sensor);
 		if (ret) {
 			if (ret == -ENOMEM)
-				return ret;
+				return dev_err_probe(dev, ret,
+						     "Failed to allocate memory for thermal zone\n");
+
 			dev_warn(dev,
 				 "Thermal zone misconfigured for %s. err=%d\n",
 				 sensor->name, ret);
-- 
2.43.0


