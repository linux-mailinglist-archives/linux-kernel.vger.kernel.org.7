Return-Path: <linux-kernel+bounces-756314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F88B1B28E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7A0180151
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA8026CE30;
	Tue,  5 Aug 2025 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoE5ughg"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F77244671;
	Tue,  5 Aug 2025 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754392734; cv=none; b=IGkNC5bvjE1pSm3SBCpTsVYPgHud2ifNcIONkyrOsKWQ3b278iP37Z7g4UEtsEIB3GDmerc0hVcdFb9yvvKGqJfsU2NARhQOOKDBjrYgDJn0h4pgMxczUD7QVsahavHmgnnb2o+RwbR0lTuKnfrFtZJp5m33hADStsNGgs/od18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754392734; c=relaxed/simple;
	bh=jGSh/LkL0X52CDO3zdkc5x7ncFnzPCmvG4RFuADPvdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDvsNnBmHyWyfv+A6JDOs9958nPVjgva3V3mldUOcB+uEdJTKYoAicASC6D1fFScZkYDUxy84TOThIDuDL3bkmP9WUFHo5foIbfpOXgrBezn//PwFwkv/kC5E61A57BDeP9ZNwSQhxe3tXrLoyXOkdCS9p62IuHcw6vYIm4saoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoE5ughg; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3323afe4804so37198621fa.0;
        Tue, 05 Aug 2025 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754392730; x=1754997530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yCdqk783l2O4FNUDcUuzsOge6j9py4J7WwVbdxRdP8=;
        b=FoE5ughgi9v6V5Mhp5+oCEOzA07uK+pWYSvb+1RatGuAPFumuMmlRP9zR189qeO20a
         GAUKqAohy6sNhefZSzSNllom1pZ9GMISNy9fQsu2HBsHdaOXmIav51vPhPUXMYNVl8lg
         s4kSo0I52PNNJj2ADZEVhWrRc448jiEcYELVTahlihebYFT40OLy6UyPYNF5yFsLYCiU
         f33hlxiQbktwX660HYJ8jvHWFuBgKow/HCFQQXqqD+MyOxaio42Uscx9cQzfOA8sMwVP
         xD08uETxmYzY4qtnuOA2GfyHVsQB/yj3k5mFplU84GJvY2ldEkyWkWeEZ1IUsT7zokzK
         rFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754392730; x=1754997530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yCdqk783l2O4FNUDcUuzsOge6j9py4J7WwVbdxRdP8=;
        b=cp83LY0fhYqJwn4SKIASQpfb+k5XUMqrpOcHbRqwgcBG3TGTwPNYmnPkp2uKlEf1tl
         4bUr4ScvLC5EU4hRboEmPkZ6u/qKJ9wapiqPVH1awhB/H835tYHrYenfvj3Sw/Kk/LxZ
         OZzkH8D7qCa9kU2kZrkaRjMS4W06ghWx3NYCmYp4CG91Z05727LWU49IgHzUOzD9ogiR
         9/zJRAB0esX2oX029aGRcVXjeVI9WyNDq7qMdR55POKa41Mjrl1+nq3BsFytdDGhX5uP
         2UsWshNaqelCpTO+cszouL1sSSgl9Ol0aW2wmCzuwrC73PBCMkp0g1Tt+aKU2WfGzjwo
         vIeg==
X-Gm-Message-State: AOJu0YyFlDo1E7szh0HyocnJlJmPqScGNf71LnqBd/sQQG9EtaDbqUTe
	jZHUSamSOEDuscaKrgAuxK4pE6+BdJFmIQDxZl6M1ljBIAfKTLg2ZZfePHsIFYSIW4GmtA==
X-Gm-Gg: ASbGnctyE+pJwi9knlzgstTRcC+v84NmrxKb3rRCHcPv2CTGPUvw1aXTWEmzXzz7WBb
	vYMJAgbClH+RTLJoL/kmx3x2dcWPSy+2KMSywFkJbgIDPx8eOh11xh4K0vvVAGzfv1CB0m1n2Ci
	oMQgoIy5LeQGsOCbKgu3UYnvwyZGfebaXF/44vdOi+9z6qhR/NYWLXjxZjgg/SrVHHhfqo+e9NM
	EF8GR3fy5F2/GpvzFB/fgpxwhf5ElSvcLqLi/mVz29/OafA/FT7vb//ky25u4MKWQbuB18UBdON
	vriE4hcpGnvYzjouFCbCg5aWTRXzHyZejXuQ745Ue9Vcu2KQs/6sIAKgvi72jtVDQ37JFzyEUOB
	eSoDntS3Cu8X34URJ9pT4T64T
X-Google-Smtp-Source: AGHT+IEpp1BefhuhwHK1MIo7yV8oheN+yGj7341Ufa/EQ+BfNJT1WPhhIIywRubZ1rjsUROQ6rVqtg==
X-Received: by 2002:a05:651c:2108:b0:332:362c:c775 with SMTP id 38308e7fff4ca-3325632d466mr31689691fa.0.1754392729954;
        Tue, 05 Aug 2025 04:18:49 -0700 (PDT)
Received: from artem-pc.. ([88.201.168.202])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382a9054sm19367161fa.28.2025.08.05.04.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 04:18:49 -0700 (PDT)
From: Artyom Shimko <artyom.shimko@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	jdelvare@suse.com,
	guenter.roeck@linux.com,
	Artem Shimko <artyom.shimko@gmail.com>
Subject: [PATCH v1 3/4] hwmon: scmi: Enhance error reporting with dev_err_probe
Date: Tue,  5 Aug 2025 14:18:40 +0300
Message-ID: <20250805111840.6472-4-artyom.shimko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805111840.6472-1-artyom.shimko@gmail.com>
References: <20250805111840.6472-1-artyom.shimko@gmail.com>
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


