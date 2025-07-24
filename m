Return-Path: <linux-kernel+bounces-745073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B69B1147E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18321C25630
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68936246773;
	Thu, 24 Jul 2025 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ig0Obm3O"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DD5242D69
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753399566; cv=none; b=VWuEoGiQ91aJaShA1mP1T7+iWUyDXxv2Zk+mqRgS/1STkAS+K3lIP3MzeQdykFoQIE4Q5NVi2XFmxvxyZVbnNWY7Klk1T4w1sKqnvcyd1rc8AAQqjNOVUKo0frSPgmT/SSHWg30Wn4aryY4YQkD1vtQWuUNjEoxTj0gDZPbKSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753399566; c=relaxed/simple;
	bh=o/2bA0pR6AUw7lXgAjOEpMd1lrma/kJtl7JvrX3ogPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PxL5Bp5hzbfMTWb9Xlcc4VB6Uyq+SQPMfDVWC4lbh4bzXIr1IdApPqKB1z9ouvWxRRvTHwVEesCnDfqey6sPdNiCFUBSKQBwE8GUzuJ1ByGXJxbcaKjGJPWQlYKRc1angbxAdzT50eO9DI1sjfRu+sbwUqdkGXhC8oWL4mjt9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ig0Obm3O; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72c09f8369cso853125a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753399563; x=1754004363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfkMTGv2DjDQzlHRRIM99MWZaRgUgbrBbeXiEEEshC4=;
        b=Ig0Obm3O1hkL3TKpAlYq4lSiFaqLN0iLrhOQi2UlLxNlx++8460u1/EbkG/6psJjV5
         GYf7x0ghla2NoC5XZvRp4hPHAWM450OsOTO4WUJiWxhBAhSeRFRjiXIGKgR4XTUlHAfU
         tD+QBcYO1lxSfYSlievT034xkVnMWaUxxmotdOS9wtRoi2lcDal5DoaLdxR0yKlEgTnH
         Dxd3GFjSvyIY7SUWvfGt54vNXGx6cYYfPVgJvaiYU1nG+U58zEGWgStPaOd8LkCXAIAI
         73o+188U/0dx+UXkZ5kUYOnyp9qJ+0If4sY9O9PNT5kS9vlVzoee9sVCvlrsHr0CYsbu
         lFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753399563; x=1754004363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfkMTGv2DjDQzlHRRIM99MWZaRgUgbrBbeXiEEEshC4=;
        b=nLs/JYUteYaJFJAdivY68p0jNtzmNOdDI60QxqNgVWb9/mRQMYEOUPwYOWXV/1vrib
         H0bchvejZoWB9m8pSwpHI3fWAL2J/KJNn/z8KKAXz6BtSzkmLp0xSIGL0AfsYkON8EUS
         jhfSpfXUrYuvqv1WlhrCe55teqcC8x1k9hGYnxmSfH9b0Wgmwp0t5OvkC+nz7JVp7PnJ
         XvOMXxVOpdnWlLeub/yMTxdP5yA0RrYGz2XuVlsCflEx/DiHbK89OqqfKEg8DKpmIq53
         bPBv11U0d1llN4vS9eqqg3plSH6PYwB5wh/xzIlfUc8Nza9rFcxQgXL6/z733NGytE/0
         2u+A==
X-Forwarded-Encrypted: i=1; AJvYcCWCJOkedpL3+NNxVOfpR93tLXVHvETi/EN1lpdgqDaTqc4DEch6NayR4+gr61t83wNS14Stw/N/sM/N5tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjHydrV8lFuarNPQhDzyXdJ7QYAiJOXFTxZh69UJvVtXTw4lIH
	cJrOSqrfMJDnikNtmhJKxFlwpN2868hTFHJMQkKi1k084jJ/ub8ZBiMsrIi7jpT4Ab4=
X-Gm-Gg: ASbGnctERkxfatP9YGMEQiqJp5V43RtrDVip/ARfSp5RppJdYMLf3q2v6dr7+CGDAOH
	8fKn26fWicN0x+nL3eCvt/TvPhDNHZhjtNFiQl8cnjfHb21X9cjl+HiDOtFOj5a2fqYPCmJMiKd
	vBWvSaV1W+UQolBw09pROGjRylokyLfVHc98MFMPfva0nlSBKqIddNtC7qla+YPigOfgtV9ei0I
	+I8sflEtG53tFHBQlso63Dja12Lb330FTBImibXqfdLv7KiWRtgWfu1AwEOAuXo8Cds0zoD7uJQ
	6Rpx9xITMs84EuZueV3ic5cU54pO2Qgj57tm3DAwYb25YRfvbeWcxZneKXfTwwBsK9zT/FyGYVt
	3FFhJGu1nxnmjqEQ3180zgsJbVw==
X-Google-Smtp-Source: AGHT+IEk+oExELM+u1/tsclf9JZXs9QdRNY4IH2N6Oln8OdD08TP9D4SWyvAP2Qs4ISlV4fW2+egnA==
X-Received: by 2002:a05:6870:b12:b0:2e8:f5d4:6077 with SMTP id 586e51a60fabf-306c72fea4emr6063414fac.38.1753399562881;
        Thu, 24 Jul 2025 16:26:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:337f:e3bf:e9d2:b3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-306e3971332sm689626fac.0.2025.07.24.16.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 16:26:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Jul 2025 18:25:25 -0500
Subject: [PATCH 4/4] iio: adc: ad7124: add clock output support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-iio-adc-ad7124-proper-clock-support-v1-4-88f35db2fcaf@baylibre.com>
References: <20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com>
In-Reply-To: <20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2955; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=o/2bA0pR6AUw7lXgAjOEpMd1lrma/kJtl7JvrX3ogPY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBogsEA5jFqG17re15CK3Tg3w5rSfJlRDHB+luVe
 LSNkIdaGSmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaILBAAAKCRDCzCAB/wGP
 wEykB/49Gw3B+Sq8vaEMUQKX2HVbfGXwQftiXVBOMZCZKrJdxTIHfXyhhS7JerRmVnviDzXIrTz
 Zpdvfm8HjDKp4GiTEgxI9b6Wb82VSIZEsqkwqvegTBHDdaCoi9+9X3jiGD9oIoxS2F82M1ATBHq
 KjXCLSbLeL8XpsbhxOfbwzfURdp7Hm6FCYlpkAFRIEgDmif1bg08XtJkSRJNfI0fHACo/VLrJXg
 Lpacg9RCuW/VN2gp4xntaHt1AzIpEHS9LCDIc74/thsdER6pa2VWnKDjcpWO9r11oKuYAVJKWTA
 5O4xvz1VuTmyJombBrlAqswA33JBRd/BQKIaTwo3WiDvet/B
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for the AD7124's internal clock output. If the #clock-cells
property is present, turn on the internal clock output during probe.

If both the clocks and #clock-names properties are present (not allowed
by devicetree bindings), assume that an external clock is being used so
that we don't accidentally have two outputs fighting each other.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

We could make this fancier and only turn on the output on demand of a
clock consumer, but then we have to deal with locking of the SPI bus
to be able to write to the register. So I opted for the simpler
solution of always turning it on during probe. This would only be used
for synchronizing with other similar ADCs, so implementing the functions
for a more general-purpose clock seems a bit overkill.
---
 drivers/iio/adc/ad7124.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index b0b03f838eed730347a3afcd759be7c1a8ab201e..b18229ff037596c6e98e12dc22b1552bf13fdc4e 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -7,6 +7,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -125,10 +126,12 @@ static const unsigned int ad7124_reg_size[] = {
 	3, 3, 3, 3, 3
 };
 
+#define AD7124_INT_CLK_HZ 614400
+
 static const int ad7124_master_clk_freq_hz[3] = {
-	[AD7124_LOW_POWER] = 76800,
-	[AD7124_MID_POWER] = 153600,
-	[AD7124_FULL_POWER] = 614400,
+	[AD7124_LOW_POWER] = AD7124_INT_CLK_HZ / 8,
+	[AD7124_MID_POWER] = AD7124_INT_CLK_HZ / 4,
+	[AD7124_FULL_POWER] = AD7124_INT_CLK_HZ,
 };
 
 static const char * const ad7124_ref_names[] = {
@@ -1163,6 +1166,32 @@ static int ad7124_setup(struct ad7124_state *st)
 		}
 
 		clk_sel = AD7124_ADC_CONTROL_CLK_SEL_INT;
+	} else if (!device_property_present(dev, "clocks") &&
+		   device_property_present(dev, "clock-names")) {
+		struct clk_hw *clk_hw;
+		char *name;
+
+		name = devm_kasprintf(dev, GFP_KERNEL, "%s-clk",
+				      fwnode_get_name(dev_fwnode(dev)));
+		if (!name)
+			return -ENOMEM;
+
+		clk_hw = devm_clk_hw_register_fixed_rate(dev, name, NULL, 0,
+							 AD7124_INT_CLK_HZ);
+		if (IS_ERR(clk_hw))
+			return dev_err_probe(dev, PTR_ERR(clk_hw), "Failed to register clock provider\n");
+
+		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+						  clk_hw);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to add clock provider\n");
+
+		/*
+		 * Treat the clock as always on. This way we don't have to deal
+		 * with someone trying to enable/disable the clock while we are
+		 * reading samples.
+		 */
+		clk_sel = AD7124_ADC_CONTROL_CLK_SEL_INT_OUT;
 	} else {
 		struct clk *clk;
 

-- 
2.43.0


