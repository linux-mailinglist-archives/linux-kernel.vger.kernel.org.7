Return-Path: <linux-kernel+bounces-611179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359D4A93E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 22:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA2A4675F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 20:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A4E24EA8B;
	Fri, 18 Apr 2025 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DGvDRi8p"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6502475E8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006400; cv=none; b=idJ3n+tJSmfvSAQqp45bdpURfk8nYWz+6CHrUeUT6RIjbruwh55WB7Nz8kmrgmiRPdLqadLT844rAi48kg1DO7sN85jdsa6qj4ZEhzZq4Ti9wUTjt5OTVh9p4DCYueqtF5ASKnKUXJaQcOSl/w6o6RXoPOjYmIrguYd7/7ZwPz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006400; c=relaxed/simple;
	bh=k5yhrc00lCr8GGuZ0R5nv3Gzs90XuAA6/+QofhTasXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ah1kzqllaHBIeaW8oWse6gvh01CZAEutr3eKHDwmKo2sY5O5JEORoNPEEPBLbesF1RMnpk9L2yNvVdgXT+P6p+3uaBJRBnMwbiXTSoG4o1XdQrRdbfbRbHpP8YFDyt2G2pLUyCBi9zQa6d1DwhsS8dmUiqmORjbdiv832IJvX9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DGvDRi8p; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c76a1b574cso682122fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745006397; x=1745611197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MggEbc3/wN2+Q2lPVGSfBi5tCxmBAoGp/YWYe65Ys5s=;
        b=DGvDRi8pc5Xu+psYjVV351nnej+GsehTLQ2ZwVIPewRQeArNzjDXo00HPwUbn7GWvK
         MuPAKoeh8ryu57msChQxxUymPDC6mKyn/1GensYihkV6ezbnf+DO6XI03a4eP24/uoM4
         m6P4Ue+C9f842+5BYD960Qrefhw21TerTjiamag5EQx1D3SXgfuVw7DWjyNI8LFJ6X/a
         si/9iidS8LGLH+b94uGTl4qXDQxmwARXiJCP+dI88SEW0KN8BBUoRBPk+Y378xPurXdC
         eyiavSZfb4waEOZD03MvfGgYiyHvJPjVPUzfp44GnynMsEW2VIqkggwUpE2ARYkBhBpA
         3qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745006397; x=1745611197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MggEbc3/wN2+Q2lPVGSfBi5tCxmBAoGp/YWYe65Ys5s=;
        b=rt/JJ/Jof8HNs5rzNuYM69rgm0n/D7IamzMbq4R1VFeinHSnj9JZ2ZuEgwYo6dKYmL
         mPJ/Ln+I7XN3QsP7E/52eioZs+SZUB0n9cLKxzeBLXERWBU4DPuOgIhPLY7RDRjMPmdd
         7sZArUImOLVy2m52FNHLRZXc8n2CWWjf9P0vOw1X164Nzq+9KLxW9lgm/HujvG3kKQZM
         BNfLuoERbYLlMKQVWeio2O75Bjerrnl3FPdPAwX3a5XLIcWcq7ixSTjLDG1rbA7l2KEV
         G1Ki78LGcD8QjjXkFdWhDjx3XAQBsUQETpB8dqdMAPPh+oZtDXe7c9u0aykdskabtwhF
         gd/A==
X-Forwarded-Encrypted: i=1; AJvYcCXVMzw1xLtIOFmMdfQdAWxigWtyOIba3FnOobahDdDuRE882a0ZVHMSEuPomkSuhAyEt3dLWQ/2g7E/jWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl53uIV1OZBnCM+R30yIaKutz7zhvP9KBRXKRekoxJ1MLbD4QN
	0JIP8nv6I+0k8AQZdgTDXJRnT1cjxDew/RAyUgw0t+zC3ZPawsbNpSg3CtFx8hA=
X-Gm-Gg: ASbGncuA4kHyQBBg/CAW73UM3WiMxqTCA7glZbpQOVPdPGnXiQmoCvCuDg1MOQZHsBL
	SmWhw77cbHny/cARQNM3RlLp0KURmrE1z7cn9bweRc1+0uN2lQYGMbNyP+UKzl37TNtlCjkZD++
	moLkKoGsJubyKtl2pXP6BaUjnFnfGrgJQmMSTV1r9BYhT6ET46dSSXwKaJRPDlZkOQ9SdrqDAvv
	GaNff8irbS39uprTq2f57gVT47LyFVuoB0TqpIsbouh/znA08j6TwDZSFdvo8gT0f8ssQ/mbC2M
	7Y9ndcZcC14xGIISzUqSIAoKd1Pzs6j22AH5FJarXfDkGceAAyjWVMhFQg==
X-Google-Smtp-Source: AGHT+IG+gejGjhaQSsLs7N1sUMk8COxBQa4oufobNgGcbDF7GP8s42nvoeAVo7lIwRuf8OSEn7c6ww==
X-Received: by 2002:a05:6870:ae84:b0:29e:503a:7ea3 with SMTP id 586e51a60fabf-2d526f226b0mr2234380fac.36.1745006397466;
        Fri, 18 Apr 2025 12:59:57 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5213f8e4asm606941fac.23.2025.04.18.12.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 12:59:56 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Apr 2025 14:58:25 -0500
Subject: [PATCH 06/10] iio: adc: ti-adc0832: use struct with aligned_s64
 timestamp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-iio-prefer-aligned_s64-timestamp-v1-6-4c6080710516@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=k5yhrc00lCr8GGuZ0R5nv3Gzs90XuAA6/+QofhTasXU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoAq8L4xpevGeyh+Cbk2mjcqGgi7fDAYg/NhVII
 IL10PDy+pGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAKvCwAKCRDCzCAB/wGP
 wOHsB/4y5HpYvODEZLE67Y714oZoOOB72/gk72fvqGQ9uGCnlTWkSz7wnEGxYKbmMkLsb+moj/F
 NBujkX9MGrrHtpAp8TLZsFx98Hcb7jzknjKtpB2htjv9TdDIv9CqKX1yOBA8EVZXwi8XHCeYB93
 3BtqQ9OWhxpnqUwAM6qebZ+ptcjHPFtorYG4nsZpXR6JFv4oH39UENA2/CYzJ9EA1q31gj/VbIt
 LBL0I6QcLgYVzgzg8aDfKEbAB8tuNXT7KJdCRbPUBCzRQkNQITxQ7cbaRf6lJIfRc8O/Xp5MnxT
 rnK9CSmF3wjWUJALvkW2wA+G9QPBXPEI0MzWeOle7GfS6WLA
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use a struct with aligned s64_timestamp instead of a padded array for
the buffer used for iio_push_to_buffers_with_ts(). This makes it easier
to see the correctness of the size and alignment of the buffer.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-adc0832.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
index cfcdafbe284b103a069857028886411bc72dea4f..f508f7113faa2610a2889f3c36c5a679fa72264d 100644
--- a/drivers/iio/adc/ti-adc0832.c
+++ b/drivers/iio/adc/ti-adc0832.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 #include <linux/iio/iio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/iio/buffer.h>
@@ -29,12 +30,10 @@ struct adc0832 {
 	struct regulator *reg;
 	struct mutex lock;
 	u8 mux_bits;
-	/*
-	 * Max size needed: 16x 1 byte ADC data + 8 bytes timestamp
-	 * May be shorter if not all channels are enabled subject
-	 * to the timestamp remaining 8 byte aligned.
-	 */
-	u8 data[24] __aligned(8);
+	struct {
+		u8 data[16];
+		aligned_s64 timestamp;
+	} buffer;
 
 	u8 tx_buf[2] __aligned(IIO_DMA_MINALIGN);
 	u8 rx_buf[2];
@@ -222,10 +221,10 @@ static irqreturn_t adc0832_trigger_handler(int irq, void *p)
 			goto out;
 		}
 
-		adc->data[i] = ret;
+		adc->buffer.data[i] = ret;
 		i++;
 	}
-	iio_push_to_buffers_with_ts(indio_dev, adc->data, sizeof(adc->data),
+	iio_push_to_buffers_with_ts(indio_dev, &adc->buffer, sizeof(adc->buffer),
 				    iio_get_time_ns(indio_dev));
 out:
 	mutex_unlock(&adc->lock);

-- 
2.43.0


