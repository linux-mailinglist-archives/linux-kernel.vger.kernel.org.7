Return-Path: <linux-kernel+bounces-611176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E602A93E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 22:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B85467327
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21BE23F422;
	Fri, 18 Apr 2025 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r/Xi/TxD"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C9A21B9CA
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006393; cv=none; b=HxuPmXbZ+nXeFBwAEVFNcFKTB4xBedXteJ4apmov0yS4T/fX7Nnt5XqQVuEVTD5otO6X0AvIOYe9KwceJE9kNOzX9CD9IzdJQs+Pan6tkB0ipGawtFFiwhDGpdNlHReJxmW5dV0xNID5LxHv3CSOw0ifG2hmLjfQvTC7FexhvCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006393; c=relaxed/simple;
	bh=lGbQ3dZga8UFYhE2RmKRRSTA6YHIjjV8TI3JBRQo+eI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hO2i8BEQcVm4wHi44qPJl5C9qc66i65yAEuRKiVq7Ffds2wTkTy4wb6VSZKc+5Bm6T2mi2SkblznGRnyirlGbBnmT4BNbPf6RteCqj6MBdKhvlP0d97l02yhsXuWf/Ft3sh7dNaGstxrktxGPBANsjS1dlA3ODKeTSnwWcgqAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r/Xi/TxD; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2d4cefac09dso1128241fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745006389; x=1745611189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwf2pqYvTfZAKWRzV4AAx6ws0t+3hl5RqCYYJcwd3fg=;
        b=r/Xi/TxDZe1kDxXHfioivIkdDNQxdg8YPCbrONNu0OiHzE115MgSImVceZ1QDiLfoF
         9MpXhFc9WlAVi4mJSbwjmugNcnny0zIstmmJkeA/8oiDr5TD2eaNs8xmC+MK+Bch2cCI
         Fqe/99R74xPFyukgSiruicRdZG0ynwN/R6wKOHtAhhmBRrn9VzWk0Nz0jigj+8c4S2zS
         SxO9bNeA0t9RbuTyshJrrw+dKR0SSjSGOszRcd90uJiVkGw1jE1/5fwx08jONrL3310h
         t2gG7qXyfPeVr+mmRJiP48ihQveDaWhvsn98JUu+1NNlUTeF+Nj6fQCzECkCCyzCcMdp
         oudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745006389; x=1745611189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwf2pqYvTfZAKWRzV4AAx6ws0t+3hl5RqCYYJcwd3fg=;
        b=oo7gA3GP1PO+Y8jMDYxbDDhUlgclLnfiP3yu7ucxcQpvLwnPSHm785S6HWdvEUmmFY
         g7tDl5dTjYDORLtllOz00YQzZ89MIekNeXNVX9eS1bXXoBAaFJbtr5o30+mMeaMW863f
         dMB+6TKOdJgnje1fYshXqIZH/I5A7L187TXw+yvg9G3mVBc/W/idlUlBrryxsSxUbAZP
         X98mQGNlL8f7bX8h7LKL7fAamKzEIyWNrdtjtqz7h45SQMizVhu7sIv1BuDZpslr4oDV
         yPYf6ZLdGcaxxg5ApMi0L0MM5qr1ivUEZPwWKRhtOPd8jg29MWJQFKsLA130+5YNDVQX
         irUg==
X-Forwarded-Encrypted: i=1; AJvYcCXZDr+gwQ6qj62QJhKvJGsc7li96hfHncfcQuhSUQqBfRHIQPd+mWqqekOyrpgxWKV3k+3XEzUNQ4Dikmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyrzY0SZQIY33hMrR3gMDGXFlDSluivGmiSZFMTb3Ekp9e209l
	8Q3PQaG1yCd8CyPI9VPhkFRjEHU+PEJrPB4cC0cURbqg+NLdM3K1mT+easM4//s=
X-Gm-Gg: ASbGncuLOm33cRd2OXpwhredwhkVMt5az3Aa/hdV92SvFK9XTiTUz8kDZFJj+DRKZIF
	ymaQnS62sxgdOBoa3Dd86z+la8daT2o9IOFG5EIkhnbNFN9zX+0A+MuO6PtOqHf5z7o+zpa6bY9
	tT3x5Zxaj/oSkbowyzfvrl6H5OeYhX5iCNpuPSbU1bMOvmH1lKKaIAa11pfs3j7EJKkSH7Ih21e
	NHZ7vu+qrBtWzlJwrnLEst1vNl4oBSoqWAucG9Z5V6wKPvUNqO8Ipis8QRDg9po/ikq302+tkSi
	/uvO1ZASfLoqwbA2+TSewHhgXcFCOugeNJ5v/x7MNJ+MNjSLE/JYXfra7w==
X-Google-Smtp-Source: AGHT+IFwZ3EWj8a1332iU/6yoy+sVrn6yZp+kcyFC3R5X2BbUGWBQCdaSARBWT9nwdH3ywi0Y6UEcg==
X-Received: by 2002:a05:6870:1b11:b0:2d0:4a2c:7c22 with SMTP id 586e51a60fabf-2d526ae9243mr2222694fac.18.1745006389633;
        Fri, 18 Apr 2025 12:59:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5213f8e4asm606941fac.23.2025.04.18.12.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 12:59:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Apr 2025 14:58:22 -0500
Subject: [PATCH 03/10] iio: adc: hx711: use struct with aligned_s64
 timestamp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-iio-prefer-aligned_s64-timestamp-v1-3-4c6080710516@baylibre.com>
References: <20250418-iio-prefer-aligned_s64-timestamp-v1-0-4c6080710516@baylibre.com>
In-Reply-To: <20250418-iio-prefer-aligned_s64-timestamp-v1-0-4c6080710516@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andreas Klinger <ak@it-klinger.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=lGbQ3dZga8UFYhE2RmKRRSTA6YHIjjV8TI3JBRQo+eI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoAq736zDtgasDsEkD9rWkk6FaF1wjLFLYYEylg
 PumkP1NSyGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAKu9wAKCRDCzCAB/wGP
 wGuVCACVD/U6ho5K+XhYyv2ZNkNciwcFJPn/JPwQupiAbpUPj2JNFkyuR6gPyuLTUVWvVmzG4s9
 FeA62PoeKoiQkB2DMCf/dAnzaaifeKAjLoJ0IrqCYNoyxwMa5JNelAZOuNDyAilVXoH8vdGWVjy
 qpMHWiMGa8zdWFx5cTHLVkqj+fvO4I6AtQvTm4/k2nejdcLCE6Lm/6NF5HnwgrBgP9IZ2jOcMx4
 0RxycD8GgRzI6AiAJv+nN7K1NWEz8zjk/ja29Z347y8KgnYnl5dckBrqu858JTt1s8lEvLS1jml
 BgZmOJfTqI6VwbEvW3F38Hc51xsFx9QMlH2Dhe9oF5v8D+xK
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use a struct with aligned s64_timestamp instead of a padded array for
the buffer used for iio_push_to_buffers_with_ts(). This makes it easier
to see the correctness of the size and alignment of the buffer.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/hx711.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 8da0419ecfa3575aa54a93707c681ec8ced28be8..7235fa9e13d57c693751757c5d40e8a799622f17 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -87,7 +87,10 @@ struct hx711_data {
 	 * triggered buffer
 	 * 2x32-bit channel + 64-bit naturally aligned timestamp
 	 */
-	u32			buffer[4] __aligned(8);
+	struct {
+		u32 channel[2];
+		aligned_s64 timestamp;
+	} buffer;
 	/*
 	 * delay after a rising edge on SCK until the data is ready DOUT
 	 * this is dependent on the hx711 where the datasheet tells a
@@ -361,15 +364,15 @@ static irqreturn_t hx711_trigger(int irq, void *p)
 
 	mutex_lock(&hx711_data->lock);
 
-	memset(hx711_data->buffer, 0, sizeof(hx711_data->buffer));
+	memset(&hx711_data->buffer, 0, sizeof(hx711_data->buffer));
 
 	iio_for_each_active_channel(indio_dev, i) {
-		hx711_data->buffer[j] = hx711_reset_read(hx711_data,
+		hx711_data->buffer.channel[j] = hx711_reset_read(hx711_data,
 					indio_dev->channels[i].channel);
 		j++;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, hx711_data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &hx711_data->buffer,
 							pf->timestamp);
 
 	mutex_unlock(&hx711_data->lock);

-- 
2.43.0


