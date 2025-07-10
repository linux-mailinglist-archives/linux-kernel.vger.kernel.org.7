Return-Path: <linux-kernel+bounces-726469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ACFB00D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE5A5C4DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECA92F0031;
	Thu, 10 Jul 2025 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p8/VNO9l"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DCB21421A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180239; cv=none; b=OG4iWPTjQKJ/6EgMfdq4uLQ1j/Vi55rsKRBdQTzjufH2W4xGx9yNBvMNSoLzcd950b0/IDfplEzgIlJJTt+2WjeX3QW0bQZvSUIEe6mCk14nDr/agdNuYGOaoiKh3WKdpyxhtyAP0ERYGqWj02Votmh/BqHsZ8/O5at5NhxOlbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180239; c=relaxed/simple;
	bh=Tq+kcG3CNqTc+WAbHQcKCfcmOeCI9+WqNhfqW8zWLwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b/8ZNVCkr9bHz2KsVZ/GVMEuHHiBtkg4hXnw35FmjAt9dXJVWL9HPEmp0oKoZ5+wjZJjTBqXo1Vv/HMq2bsSyVR/pJVon40EwoAaSczIjw/n9lX6+VW639i5o3O2aVInMT1wB6wbDFaKmQLTQ+T9iGZ4gtHk75821VB9/oFcYyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p8/VNO9l; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73cdff9a27aso338906a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752180234; x=1752785034; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CiqjwpdSWDMo+9ZdKh3Q4FHq3twDU9X6sP5x0odekqc=;
        b=p8/VNO9lfKU6gWMyt9+t1BuVoV8UtwQkThdQFC7ZJSoaeB9/oH2WdOOfM7D1eIkvy2
         dOYVMCuEDfabwhZgj9dDYHiSwOvtn1sRmS3OuaFbIOSZo0quYR5x1XBKB+E6HFna63W0
         tvAjSoBrWBQG277fB2kvdL8vGcNp2qH1axhZUF0p3froBSNnwZ+JVjYojeMgT+Tk5PlE
         DyGQRXlDiB7OneY14MmMUyXXLtFcoDT6NfO/JRn9rB9XHBVM+PtiCgIqgInAKOUfUBSm
         yBkDbD/Q7umSxzURD5QjBSr/6z7dlfvzmsHH8tBP9VFuGBYRwp3l7cEFPi13c0LJakcP
         lzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752180234; x=1752785034;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiqjwpdSWDMo+9ZdKh3Q4FHq3twDU9X6sP5x0odekqc=;
        b=kaa3ZO23qhQ05zAJnwcyYn5Y1SYva4xFz6gHdzBM/6IYxInQLMU/uDuP8Zp2Tf9IPj
         z6fOQPtLMRTNs6vB+LcvjZfzM2jNFW/h1OwhnuXAEtcwBNbj9pTlwYlw2pJ4j6pa+k9a
         n7ZvercFaUERYPovdwo5r7yaCF36Xrmb74UQjr5orzLup1QwdQ1Db50FoM/vEbMjjf07
         +fPvPSIOd/Zt5cwNYaF424W5rjiRqZgAd068ngUnV2/UjhbtA/CzevCZb0vez8MWpYWd
         yK4d02AUDNZOrrm7qLZKJ/SY/ipAy4Vwqyu0EhDNuwKK2gWh2tSI4Idy2uzOr2vTJ02G
         xxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJN7EBbwPsC1V32rusti3TlocTLnDOlECqw+KAZIlhg7lTPqLBz0dwHh44vzGptBJZrotFj9lPVMeaSpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe48PqsyTFIpzcejaVhZYLTL5llLHcI8L+hTnI+Eg75pTtKtrj
	p2tA1oPAYJ2of8Ed73OvnzPluzwmPi1TnYaoFn3UWDVgKzELuZEraRyvep1HLdc68go=
X-Gm-Gg: ASbGncv0/iMQBZ1rTkeqPkez/uQN00vaW7CFO1k9HqE4uuDWR7tBejMXItpzm3Dfp1L
	PPwMkXW/qvhdPsXUW8ewVI2CfiK+2k7gxTHcuU6MMJUNw0lwM7efNfrhe4FC3drfHL701kXMcRq
	9kfowCFa1UeJrnZWTqtGqm6XPk2osRBXoab9TFFulcDINzK7SdLIUd0428KasitFK1YAi96t4gk
	J04qDsBddox8hpsy9BhNRrkGTR7afauNPmwJd121Mq1kd92ZVOa7jQasQ0S4WUTxv2se+UBz8eJ
	r8s2ysieoyvh01IC/hxDPan4jpl24aIAbTIkaTSKulPik39bs+4p5jwkiTZeOUGjeK+DHZS4kx8
	EBTHMtnKm8FRE/+IbRvddtJpMCI9gFdbFmupwYzE=
X-Google-Smtp-Source: AGHT+IGQJp1xboJLdGXJ3rpaFaP2GJKciMhVlj61Om3Xpq0zgJ8UNj3FzEnCk3b5u1o9qWthNIXjwA==
X-Received: by 2002:a05:6870:639e:b0:2c1:bc87:9bd7 with SMTP id 586e51a60fabf-2ff269cde53mr631163fac.35.1752180234503;
        Thu, 10 Jul 2025 13:43:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:6f38:cf8f:abb1:34f7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf12b7448sm328272a34.66.2025.07.10.13.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:43:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 10 Jul 2025 15:43:40 -0500
Subject: [PATCH] iio: adc: ad7173: fix setting ODR in probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-iio-adc-ad7173-fix-setting-odr-in-probe-v1-1-78a100fec998@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPslcGgC/x2NQQqDQAxFryJZN5AZkVSvUroYndRmMyMZKYJ4d
 0MXb/Hg8f8JTUylwdSdYPLTprW4hEcHyzeVVVCzO0SKA3EgVK2Y8uJw4B4/emCTfdeyYs2GWnC
 zOguOYRg5EpM8E/jaZuLt/+n1vq4bOztx63kAAAA=
X-Change-ID: 20250710-iio-adc-ad7173-fix-setting-odr-in-probe-915972070e8a
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Tq+kcG3CNqTc+WAbHQcKCfcmOeCI9+WqNhfqW8zWLwQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocCYCOhvHguJVU39EN9vGeVxFtXH+FcyPx1r4j
 1P4d90+houJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHAmAgAKCRDCzCAB/wGP
 wFS/B/0c0a7na+PHJf3QSL13YCocFbIlonhFD9t01Nkns+x0zZtNSmsgxI6T3lRW76elHjkJESr
 iIU+yW1c1AjKmUuZv133Xhgjolj0x5KL1ksXPJnJE+7YeumCxdi2qPKMjWgc/25wRKGYBe0FhFg
 8643hd9lvMvjvZc8Tnk0qdHZVkftI4qKdYDmw3+qL4+b6riZ6FQq6ylo8Nu8IBVOiEMEEZPJ17z
 dsSmauccAXK98/qr91lidx0JQGBQ32RJAXuXV5bZDHDw3PcdiJ4ETfaBQZjYzkY/RxwED+8tLw7
 bPgrkC8we4/58uUCwlaLUoIbF4mrvAyIaZykaxITW/k4amhz
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix the setting of the ODR register value in the probe function for
AD7177. The AD7177 chip has a different ODR value after reset than the
other chips (0x7 vs. 0x0) and 0 is a reserved value on that chip.

The driver already has this information available in odr_start_value
and uses it when checking valid values when writing to the
sampling_frequency attribute, but failed to set the correct initial
value in the probe function.

Fixes: 37ae8381ccda ("iio: adc: ad7173: add support for additional models")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index dd9fa35555c79ead5a1b88d1dc6cc3db122502be..ef074b41332ed912fb281c0903f6cc52077accb4 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1574,6 +1574,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan_st_priv->cfg.bipolar = false;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
+		chan_st_priv->cfg.odr = st->info->odr_start_value;
 		chan_st_priv->cfg.openwire_comp_chan = -1;
 		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
 		if (st->info->data_reg_only_16bit)
@@ -1640,7 +1641,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan->scan_index = chan_index;
 		chan->channel = ain[0];
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
-		chan_st_priv->cfg.odr = 0;
+		chan_st_priv->cfg.odr = st->info->odr_start_value;
 		chan_st_priv->cfg.openwire_comp_chan = -1;
 
 		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");

---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250710-iio-adc-ad7173-fix-setting-odr-in-probe-915972070e8a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


