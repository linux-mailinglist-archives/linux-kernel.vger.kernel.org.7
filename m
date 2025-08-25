Return-Path: <linux-kernel+bounces-785667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E13D3B34F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64201893C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCAC2D061E;
	Mon, 25 Aug 2025 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n1WyOluA"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E34D2C1584
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162546; cv=none; b=Az6+vN2Bu1JO/sPc7v4bIu/IYHYwvVY2v9lPkSit5A63CDHahS2PSA46EcfXH+jRgOUMTrzHs2O3vdSwgLw8kQ5h4/qytOrWdnai+GY1LD4mHKo8oxmG/hEitXsISpXr5CC8CppfxdkE/aCjuLafq7DPv8pWQPA5jdieJ7SuZSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162546; c=relaxed/simple;
	bh=xFruIh1dJkHwC4/899ebphgTT8LU3IBSfD9CxxH6rBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cPq6gztLMnWeW101C5ia3XTN1h2mxHTjJZcynfzewwAaomKoNfnJfYZMIAdpfz7avPZ7MH3p9HvH8tS9Ievyezacnyog1zEQ03GBjcXpTGvSUH54ws+H2flMvQY1DMajAe5bvm97dNiJEkXwE90eicBrSIgs2ohIPBXh2HPUYgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n1WyOluA; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-744fa68531dso1349012a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756162543; x=1756767343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cSpwhr4OHdGE4D7f/XRjFwNJZRCfq1FRXvwP6Ffuu8=;
        b=n1WyOluApMuUl5jFE3BftQuH7pdkcH5qrm7CxTzACv9zDaQcsgnRet2wdy44KvS5Qp
         OE70lBQZtLltpUoJw41vRYkcpFjZHE6IobWpiS/YhBFAO9z/5pKtpEadJqv+46nKp808
         3xsIcznk1dGdLXX4IxPvzeLXRwKEuBq45zR0eDKEy73lgAiRnF45L2GcMDBY27GyNDIQ
         oQnqwddQ2la8U8skkcOZm+HNp82NdF4aGkh9GK091W6lQkjaJWeYPpqy1HWzPIjDbA18
         eftnsehQSFGXGCgw/4RTZallAsh30/fZ7eMDlKB1/trJDbeo51IGVLzXnTZUEnQPqiHr
         kP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756162543; x=1756767343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cSpwhr4OHdGE4D7f/XRjFwNJZRCfq1FRXvwP6Ffuu8=;
        b=h0kGDTfN0xzb+rBJCc+TecpYHx0wured2fiZdRIDQSCEmM+8S2Z+WosWx/WlfKWVBd
         mF/W0zv/CU69FNua7gjBV+m2r/zVG0hHQeOmtTaJBsTfVwfvacmA1saQ0xHETMwXb7Ro
         aHiExSzL/CwfSS87mhCQZwHXHudXM/MeTN8H7ERJhcdankJvy+KjxoQ+6L2wPJwWe3o+
         rVYzYi+0yjgyh+SIAI/CKx1HraDBUHjpy7le5WgUogiEtO589Yw93YaDLqRC5mkjptrL
         89jOqIZecFxcrKDdzLD7THGHlBR/LPvnqrvET9IOOYeVtnIswA/r3za8H8xj/xw0D9at
         UlQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU65eW9jECdpn2YlQbMdVnv8wHNY2hOLQMsZafDcE0KJjspvQxQMXw3cY7DjJjTQnfEN0zQsU8Z+PAsKxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZHuq5WgV50Ba9Q4Cu6H+uFhR+aUKujmdBYyEYqR1Bev4updlc
	vEY2n+/27ilMbhCwjKvll/Sj3v48qC3IDmMvngKXSS1GyBWCi7/cOUGTQPguhisABIUb1DLWr/i
	xG2cs
X-Gm-Gg: ASbGncvZjQMjX5lDbS/rIhmykhiFjp3oNDo29jQ0VXks0Eov3s43wQoiDKgbTp0hSQI
	hjdluieHj5bjCtguWO48peV3fVfHzoVFduL3WTQwAt5pClKBIZfWky3+BC8CIONfemED3KKN2WM
	YaJ0c1mIKjysOLuKJ+82wYabYxFIjbjcel6+a7eJfLDU60bfUa0+HNnU5/0Nv14O0d5IPdL5veG
	3Nl4zQRUrZNaPZUUikr/D6OtfDi2RwGPrB3L8a5baT0TjTr6CaMCJQ2/AFBlk9NZ1D3JUIgyRe6
	43F8N9gSTyLqTyJONQtcw1TkxcIQ9+zib19Rhrol0scJvjUSJfiYW11ZmGCNMZJ56CAP72EEUBI
	O5O4NGBGaQxr19288dghcJ2eiZKS1
X-Google-Smtp-Source: AGHT+IFa2v3+6INnkH7Pb5/iizOJp22ndKBOs+CMIlrim3qXEPy+qesWesPnrUp++GZY9Sn9kwfd7A==
X-Received: by 2002:a05:6830:3709:b0:743:bc1:e85e with SMTP id 46e09a7af769-74500909d36mr8870111a34.4.1756162543309;
        Mon, 25 Aug 2025 15:55:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:5075:40f3:ff25:c24c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e49d36esm1991747a34.40.2025.08.25.15.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 15:55:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 25 Aug 2025 17:55:02 -0500
Subject: [PATCH v2 3/4] iio: adc: ad7124: add external clock support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-iio-adc-ad7124-proper-clock-support-v2-3-4dcff9db6b35@baylibre.com>
References: <20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com>
In-Reply-To: <20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3361; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=xFruIh1dJkHwC4/899ebphgTT8LU3IBSfD9CxxH6rBU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBorOnd4kGuMzUs+5R/ZjrILO91LzOXg1ah8NaTn
 rXbP1qwduOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaKzp3QAKCRDCzCAB/wGP
 wBG/B/kBCLUzo5Ug4ObjK+ki9kZv+caTdb2FSLirv+ysmkoM4afa9xyubai6R2+I+n4hcJL1LCk
 IwHZkITi0GnQgL1SGTITs5U7uh86pTEOEwxuujoHDRhRQuSZY/DnlIBZ1AuyLNO/6ZpRZtjRaFx
 RVi35UiU7rvKwYtQy3BteTLxAVtHD4m1dmrtXQ892/S1RJ23ajFeMiINkwLjOKJLDU58ezbjaYZ
 bq6k/DqvD9+ig/6gBS4JBpGR+XX9+QYyCH12oLc9qLtOKjBx9sZK8iCvJo4o/gHNxLkGsNjX88Y
 qS2R2zcf00OYP+T0UigsXoIe+GWqV9iiV1PzQGZ4R2Duhoq9
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for an external clock source to the AD7124 ADC driver.

Previously, the driver only supported using the internal clock and had
bad devicetree bindings that used a fake clock to essentially select
the power mode. This is preserved for backwards compatibility.

If the clock is not named "mclk", then we know that the devicetree is
using the correct bindings and we can configure the chip to use an
external clock source rather than internal.

Also drop a redundant comment when configuring the register fields
instead of adding more.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 49003c8436463f49a47564644fd8e405579df829..4112c484c2371cfa6f26acb0d7c5b2a308a5fb35 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -18,6 +18,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/adc/ad_sigma_delta.h>
@@ -44,6 +45,11 @@
 #define AD7124_STATUS_POR_FLAG			BIT(4)
 
 /* AD7124_ADC_CONTROL */
+#define AD7124_ADC_CONTROL_CLK_SEL		GENMASK(1, 0)
+#define AD7124_ADC_CONTROL_CLK_SEL_INT			0
+#define AD7124_ADC_CONTROL_CLK_SEL_INT_OUT		1
+#define AD7124_ADC_CONTROL_CLK_SEL_EXT			2
+#define AD7124_ADC_CONTROL_CLK_SEL_EXT_DIV4		3
 #define AD7124_ADC_CONTROL_MODE			GENMASK(5, 2)
 #define AD7124_ADC_CONTROL_MODE_CONTINUOUS		0
 #define AD7124_ADC_CONTROL_MODE_SINGLE			1
@@ -1112,7 +1118,7 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 static int ad7124_setup(struct ad7124_state *st)
 {
 	struct device *dev = &st->sd.spi->dev;
-	unsigned int power_mode;
+	unsigned int power_mode, clk_sel;
 	struct clk *mclk;
 	int i, ret;
 
@@ -1156,9 +1162,43 @@ static int ad7124_setup(struct ad7124_state *st)
 				return dev_err_probe(dev, ret,
 						     "Failed to set mclk rate\n");
 		}
+
+		clk_sel = AD7124_ADC_CONTROL_CLK_SEL_INT;
+	} else {
+		struct clk *clk;
+
+		clk = devm_clk_get_optional_enabled(dev, NULL);
+		if (IS_ERR(clk))
+			return dev_err_probe(dev, PTR_ERR(clk),
+					     "Failed to get external clock\n");
+
+		if (clk) {
+			unsigned long clk_hz;
+
+			clk_hz = clk_get_rate(clk);
+			if (!clk_hz)
+				return dev_err_probe(dev, -EINVAL,
+					"Failed to get external clock rate\n");
+
+			/*
+			 * The external clock may be 4x the nominal clock rate,
+			 * in which case the ADC needs to be configured to
+			 * divide it by 4. Using MEGA is a bit arbitrary, but
+			 * the expected clock rates are either 614.4 kHz or
+			 * 2.4576 MHz, so this should work.
+			 */
+			if (clk_hz > MEGA)
+				clk_sel = AD7124_ADC_CONTROL_CLK_SEL_EXT_DIV4;
+			else
+				clk_sel = AD7124_ADC_CONTROL_CLK_SEL_EXT;
+		} else {
+			clk_sel = AD7124_ADC_CONTROL_CLK_SEL_INT;
+		}
 	}
 
-	/* Set the power mode */
+	st->adc_control &= ~AD7124_ADC_CONTROL_CLK_SEL;
+	st->adc_control |= FIELD_PREP(AD7124_ADC_CONTROL_CLK_SEL, clk_sel);
+
 	st->adc_control &= ~AD7124_ADC_CONTROL_POWER_MODE;
 	st->adc_control |= FIELD_PREP(AD7124_ADC_CONTROL_POWER_MODE, power_mode);
 

-- 
2.43.0


