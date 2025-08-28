Return-Path: <linux-kernel+bounces-790797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E457B3AD18
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17D43BF0B4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9662DE71B;
	Thu, 28 Aug 2025 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eqseKukw"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BE72C2377
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418137; cv=none; b=jtrD3sZZCIUoOlBckJ47EBWN9VEZ8xRUJLhF18US+3gdHPk6UQJnOK7K0JjBlIR0ZeoUoi6RtmO8htIDhXLsLSGFd4se+ulFh2ro/KFV+vRJ00xWz4NW8cCDZihitWOzxWc8+e49CMimgZkUMDpL6KUfsQ4zAE29OEin3TDt0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418137; c=relaxed/simple;
	bh=ypSAtKV8rM9Cgp4IRVqP8ksAKS9fyVlwRssePLuFiuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NNhxiOQvduFGThvDTH+3ChXQg+9O6grli3diZvejAd3e+baesO/ppCClR7lvsXVhEOEPvHAA7XvT4jVSFBpePuXIkX2Yw0rwG65U3gLKFAWbRdTGEJ84gEw6PPqEvcAYHnC9tt7wHTmPqvQKDvT9yBhli+aHL4UPzgnm4guZLC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eqseKukw; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-74381e2079fso1246827a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756418134; x=1757022934; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALFPEtMAJeKYFLBKD9MPVcG/WffhumAdGSk3f0EFW8M=;
        b=eqseKukw93jX5JMf74T1XAM1fdywpe9LYZE7g7pBfaNTMzsYUzo2rRBv1rwrRrVOMJ
         uokSLmvb/m8ny3a/whM3VWWKY1gHjHspw7x/ZkljcfZ1nYjL712FdHirusiiBN85faKk
         ADoLiCOzOV9snIX6tXTtefDMZxwfcOBlP/yT1QIg1Jv5L5Q8LDfqA+iE6eX2M8NksAav
         FZwLebjkA2U15i+5qkHhpQr7gls4TkeSEZWsyKxt6Ta6EoGdefO3BsbYJIeDLGchWAHu
         xt1KUGvF/bSEyUnle4dG4TcXalAehiK6WNmfoA1Wr5mfTUJII2RUqfHeJOyw01j5+w9Y
         nGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756418134; x=1757022934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALFPEtMAJeKYFLBKD9MPVcG/WffhumAdGSk3f0EFW8M=;
        b=Wr48Xo85ORydqDGRsXMWkoAx41zsM9RbEfVJNyrqN2FqQMLxr0CQ/oE87Fpb1SmOgb
         JciGv2bua7DOz4hvBHxIkYqTlBj2EZEPxJ7X5qC6Fw/boY8fUZnK1xovYLLO3XW+2fBY
         SlA8+mKfzZSX+kmjR4+zaNG34+YP0tFsmaGwsX9DIJNgTvlTkBDL2qKxxxU70QmS511o
         tSi6VgKg3FJb31pyWejIXt6DYvj71TrXR9uY5dIlxRd3PYwvMXzmHhZwmlhpBmZISMlG
         sjs+26uUMmtExARiQJ5DqS0Am+wNQytv8L1MYXolqQnON26+tlFffvSuVhJI0bo0YuYU
         tCEA==
X-Forwarded-Encrypted: i=1; AJvYcCULYUUAPBxbSZw2xLcXiV5reaqvw/o/JISB7nP6Hi/YBZQVEuvgQRPP1vMA9YmH/2G+teNDY5sdw1pGmcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv0ttQFunh4/ZpMtiKz2GQYXv0x+dtYZn/BcNyLi96b7vP6NsY
	iMqofiNZxAoUmJZwOcWYiVjTrx4ztDNApZs9HTVKQi00qJxaTRuRR8IBzznvh8ZlBGM=
X-Gm-Gg: ASbGncsu1UlwEakn0GYy2zJKFyMDtlKHVvX5j1ByvwykU4RyGWlZYJT6xaipNGTbUOp
	i5HXl4z3GN4ivIABPsxY3VfKBGDpRhBPzcp/3TovOXfBxGjtaR70mMo3dTtnTZwArW1Hkqrry89
	AeO0RVj2kedfiIwSimoVYwUfgTRpm3jhMTBXYuI/2qYIJNyUgdonWkRT5p1HSiVDwo+6t+l9fCf
	ajsrHf0jGJFEi+wSnLVTL5zCQlmMw9D2PEyQv+RGy+iBhimJ8c2ErBS0eoXVucRyPdSWU/x2W0J
	2Vrcs0gr1MEjrLOhQ/E/0YfL+0AgFnLiEq5+ZmMbcAiKG1oTU/JkpcyW1QOOxZVZ1XSFfr2ixR+
	VMqgGBsF56QtOjvGar4XWwEHQ52B8whW61V+z8H55Py2L4T071g==
X-Google-Smtp-Source: AGHT+IEerR9EhOsZ/nfsPh+VS33L7lGiKKEvCMApUXquz35i7TkTs8zD0fbwnznTFBNwuAeCgSgmbA==
X-Received: by 2002:a05:6830:3386:b0:745:2619:1568 with SMTP id 46e09a7af769-7452619299dmr5592805a34.24.1756418134167;
        Thu, 28 Aug 2025 14:55:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:aa84:2d2c:f28c:4102])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7455853804asm136084a34.33.2025.08.28.14.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 14:55:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 28 Aug 2025 16:54:55 -0500
Subject: [PATCH v3 4/4] iio: adc: ad7124: add clock output support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-iio-adc-ad7124-proper-clock-support-v3-4-0b317b4605e5@baylibre.com>
References: <20250828-iio-adc-ad7124-proper-clock-support-v3-0-0b317b4605e5@baylibre.com>
In-Reply-To: <20250828-iio-adc-ad7124-proper-clock-support-v3-0-0b317b4605e5@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2397; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ypSAtKV8rM9Cgp4IRVqP8ksAKS9fyVlwRssePLuFiuY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBosNBJnjkH7Cj1FiY0jOZ9/OYsW5E7zIqS85Eng
 xLD9BzGnYiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLDQSQAKCRDCzCAB/wGP
 wPx4CACG2q/BQCZrc789f5epr403XeHkahxdEIn10kRE8Qfj7jzrLq+0NXnNujYurZtetg75T/n
 uSwE59XQ7ucZLBmQ5ZrqtLkmKoksvFiSGFqJ5CX6YL/cKFF+KoaNqCwiPq4K6L7S5kvOpiB8QaY
 eaw/bLAW49c04iF6wAdA3Jg3f9M5H96Oi3l/zfkZuciyvdhO4fRD5BMlZnqAe5M8dKJiHmVOGSj
 YQ3aBifCSOy29ufVwg0pbCa12m/TKxhGio0BZPswaFhe92ZmvyH2XaEwRBNqO1RIgoUN/f121Da
 JuDXBnbASKtT1l/wzf4mh5qKZM/U2xexmaPX65QBVbyt0jaQ
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for the AD7124's internal clock output. If the #clock-cells
property is present, turn on the internal clock output during probe.

If both the clocks and #clock-names properties are present (not allowed
by devicetree bindings), assume that an external clock is being used so
that we don't accidentally have two outputs fighting each other.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index eb5b2028dfad0f62145edff13a24e824b05e0c13..9b410571413429a99ea3303f49377f8a7e0ceba6 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -6,7 +6,9 @@
  */
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -18,6 +20,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/sprintf.h>
 #include <linux/units.h>
 
 #include <linux/iio/iio.h>
@@ -1189,6 +1192,36 @@ static int ad7124_setup(struct ad7124_state *st)
 
 		clk_sel = AD7124_ADC_CONTROL_CLK_SEL_INT;
 		st->clk_hz = AD7124_INT_CLK_HZ;
+	} else if (!device_property_present(dev, "clocks") &&
+		   device_property_present(dev, "#clock-cells")) {
+#ifdef CONFIG_COMMON_CLK
+		struct clk_hw *clk_hw;
+
+		const char *name __free(kfree) = kasprintf(GFP_KERNEL, "%pfwP-clk",
+							   dev_fwnode(dev));
+		if (!name)
+			return -ENOMEM;
+
+		clk_hw = devm_clk_hw_register_fixed_rate(dev, name, NULL, 0,
+							 AD7124_INT_CLK_HZ);
+		if (IS_ERR(clk_hw))
+			return dev_err_probe(dev, PTR_ERR(clk_hw),
+					     "Failed to register clock provider\n");
+
+		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+						  clk_hw);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to add clock provider\n");
+#endif
+
+		/*
+		 * Treat the clock as always on. This way we don't have to deal
+		 * with someone trying to enable/disable the clock while we are
+		 * reading samples.
+		 */
+		clk_sel = AD7124_ADC_CONTROL_CLK_SEL_INT_OUT;
+		st->clk_hz = AD7124_INT_CLK_HZ;
 	} else {
 		struct clk *clk;
 

-- 
2.43.0


