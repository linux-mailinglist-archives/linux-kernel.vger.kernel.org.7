Return-Path: <linux-kernel+bounces-638752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 364AAAAED3D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 22:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9231B65896
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 20:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675382900AA;
	Wed,  7 May 2025 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yBmCPAW2"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0428FFF1
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650633; cv=none; b=cK8snCEV6WDu2TjhNVAaCdC3iQSk7Oh4Ov3z4mF1m+FZJ5Go7/x5/4K+VCPfbs8tA+n9uFP3ow5JzJw4nQCNdI9cC0NqTdlZCA9TOZzCVLzAr7E2kj2kPdOiUDF82IUYAIV5idvDv91RJJ08HAWONGyUATlg59/c4MATVqREwrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650633; c=relaxed/simple;
	bh=dvUFehPiHRrmTSC3dtvpsj/U2poRcpbR8vHtY4i3nHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UX4R/P+wko2ozWzguL1Pz2zGmUI9D3S82TyxuzRBzqAKVaEckj/Syze6kPXjHTgxsczjlbPUzWZkHbmE90iERsXl4i9ajQL8ydJky55WpowSd2OKeAfxzupo/XPnR7603E2eGlRterT2Xpa2/gWC7dUXLojdMdlbgzhRYouv7SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yBmCPAW2; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72c09f8369cso106346a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 May 2025 13:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746650631; x=1747255431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzPdaraet1qd/hRhYNfeQIRYquiVkvvOEQ3W8/ikI7E=;
        b=yBmCPAW2M/Qi81OLUmooCJzME1E8/SDFJhCaYD4BsZAMfIYePdj1SyIqSjc/4FxI8o
         gFDqyTOR7uCSlRrc2b2GosUetDFmX71HngCJYyXR5nxdCqw66seVrEI63ney4CjPAYwv
         USt3IfT6bOAiR1dH0fhpL5OiXfIaAm/3d+aS1OWhZ5dCMOAEFy7w0NQs8mCIWqOj3xfa
         87o/uCwrOLWGiGo4MDZ3e0GS4tnR0s7gR2kaNcRllEB9lJJnmCm0z42tvuDj7ewhn7GL
         2TQwab9etKiLAe09+/33JVmuTxEvuaVH+XFRGVlacEJEE0VoN5iHuALYpr5gymRCu4tz
         2ESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650631; x=1747255431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzPdaraet1qd/hRhYNfeQIRYquiVkvvOEQ3W8/ikI7E=;
        b=Ai0pkc9up303DqVLQxUbvzgR96LG9AQCE5rIbuArL/ZqKZqIHAjcjcwPcyXVkQDs/T
         wN71EDT7MkDDb5eWlUYr3lPsJnATl146zlWNMfF8eW7OaSXvvHqWXef0FHpYCpqCDdKk
         lRqVbM1eEE34ugVCf67kIIeDyr4EOdHnVt4W9iiMQPr7spXm/Ou9hBrJb+pCnib6aJ/+
         5jeBjnSGwMlQn/HzZ4y4zs/ok2i8TJTenciR+VVJZ+UJDJJ2gpd1UP8felo/BpUpfNP8
         oLs8ZuLGevj6/mgru3R57Lp1YIerFXfR44Jx7vT6Wag0o7o3lB+k/WbpxycOTirUgsbe
         5bNw==
X-Forwarded-Encrypted: i=1; AJvYcCXu/++5/RegmS6k3EmdohdfRq/5BW/QBQUMS84sqpcdyrvCYFs15B3pWlWF57U8q+SlU0r1X+zFJP9FZFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLDx6l0NfHFCfyNGT640xIifBOEi7BvOzyiCLAmhsoq9hpZPD
	A1PDKy3uN+blBpsOEt6jSq/QQUEz6rGJYwQFaTtb23u/zPJJxO1i9PE0CaIahz0=
X-Gm-Gg: ASbGncsxlPpAixPQJgYpwpoEVB/7aiNTYN1BWSt0bafTpG3zEkNbTAADJLg9z2+o6BK
	Zz3VKw2fsEtMC+YUTdMLoKc+UUORsVoVo0KzdIVRtCsmuyRC1dh8w+E6WYyvZ+NavWw6+zDRhBH
	Eapac28e0KfFNsdWf8etSXOx4xp+NX3B/wslh7WrlH8hxaDAgTZZHlys8KzSSWnwl5DmeQ+YGMW
	llhteRq/gfTldTnyKNTAAfr6HVpLSuOF/RjPcV2yzkz+bArz6y/07zimqTJoGiVb/N5/7es9jyw
	OtVUE1xVQXgl58XcGhq1vwX6xCkt9G+Q+0tVFTncTl0YOw==
X-Google-Smtp-Source: AGHT+IEpHAnG01Scl8J+PpIsjJyBK4Ozzp5Btge1E7DtlkBYgx1uC1tvjoReIGhc8pl1J4BDBekRyg==
X-Received: by 2002:a05:6870:4591:b0:2b7:d3f1:dc72 with SMTP id 586e51a60fabf-2db5c0689bbmr3206424fac.29.1746650631030;
        Wed, 07 May 2025 13:43:51 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3356:f6f6:bf76:a32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2db5cd716d3sm898642fac.21.2025.05.07.13.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:43:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 May 2025 15:42:45 -0500
Subject: [PATCH v6 6/7] iio: accel: sca3300: use IIO_DECLARE_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-6-4aee1b9f1b89@baylibre.com>
References: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-0-4aee1b9f1b89@baylibre.com>
In-Reply-To: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-0-4aee1b9f1b89@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3024; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=dvUFehPiHRrmTSC3dtvpsj/U2poRcpbR8vHtY4i3nHY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoG8XsfCtuj9afQdP+zJ6RY1Bvt2zemL+sDgCwQ
 kXeNrGbo4GJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBvF7AAKCRDCzCAB/wGP
 wGyqB/9o5h9iBDRuaIoFSHY1pBm5fkeyDKqnrw3bEgY8R0uUDWwzRNWAvrLeZFaFG0JPwu2sBNv
 +l0AZ6J9yMJ0J1nong62NfhEOxIpZg+qRE8RipH3LscKnXoOcMuu4ptiF8Vh9rOA2Fb3+j73SzJ
 z8SdMyDCVIML7mH9boq8DnliwmotlxdYo0Mho0+w+f3qZArRypNzHQbKKqgc6nZDXpTy3Djqeq/
 O76xOo9fkthmY+F5ZQda/ZaFtlQrGU5qn2/lyEPzmunUU8XlFG5FBCgybA44jKN+A+b/qoZ8ZVz
 fpAtYnb4YwBP9R+XYPexIC4pazTSS28lU2TQPYv4uxc7clFX
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_BUFFER_WITH_TS() to declare the buffer that gets used
with iio_push_to_buffers_with_ts(). This makes the code a bit easier to
read and understand.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is an alternative to [1]. Also, this serves as a test to see if we
can get a rule of thumb to decide how much is too much to put on the
stack vs. needing to put the buffer in a static struct. SCA3300_SCAN_MAX
is 7, so this add a bit over 64 bytes to the stack, make the stack now
roughly double what it was before.

[1]: https://lore.kernel.org/linux-iio/20250418-iio-prefer-aligned_s64-timestamp-v1-1-4c6080710516@baylibre.com/
---
 drivers/iio/accel/sca3300.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 1132bbaba75bcca525fac2f3e19f63546380fd4f..67416a406e2f43e4e417210410904d44c93111d2 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -58,15 +58,6 @@ enum sca3300_scan_indexes {
 	SCA3300_SCAN_MAX
 };
 
-/*
- * Buffer size max case:
- * Three accel channels, two bytes per channel.
- * Temperature channel, two bytes.
- * Three incli channels, two bytes per channel.
- * Timestamp channel, eight bytes.
- */
-#define SCA3300_MAX_BUFFER_SIZE (ALIGN(sizeof(s16) * SCA3300_SCAN_MAX, sizeof(s64)) + sizeof(s64))
-
 #define SCA3300_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
@@ -193,9 +184,6 @@ struct sca3300_chip_info {
  * @spi: SPI device structure
  * @lock: Data buffer lock
  * @chip: Sensor chip specific information
- * @buffer: Triggered buffer:
- *          -SCA3300: 4 channel 16-bit data + 64-bit timestamp
- *          -SCL3300: 7 channel 16-bit data + 64-bit timestamp
  * @txbuf: Transmit buffer
  * @rxbuf: Receive buffer
  */
@@ -203,7 +191,6 @@ struct sca3300_data {
 	struct spi_device *spi;
 	struct mutex lock;
 	const struct sca3300_chip_info *chip;
-	u8 buffer[SCA3300_MAX_BUFFER_SIZE] __aligned(sizeof(s64));
 	u8 txbuf[4] __aligned(IIO_DMA_MINALIGN);
 	u8 rxbuf[4];
 };
@@ -492,7 +479,7 @@ static irqreturn_t sca3300_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct sca3300_data *data = iio_priv(indio_dev);
 	int bit, ret, val, i = 0;
-	s16 *channels = (s16 *)data->buffer;
+	IIO_DECLARE_BUFFER_WITH_TS(s16, channels, SCA3300_SCAN_MAX);
 
 	iio_for_each_active_channel(indio_dev, bit) {
 		ret = sca3300_read_reg(data, indio_dev->channels[bit].address, &val);
@@ -505,8 +492,7 @@ static irqreturn_t sca3300_trigger_handler(int irq, void *p)
 		channels[i++] = val;
 	}
 
-	iio_push_to_buffers_with_ts(indio_dev, data->buffer,
-				    sizeof(data->buffer),
+	iio_push_to_buffers_with_ts(indio_dev, channels, sizeof(channels),
 				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);

-- 
2.43.0


