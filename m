Return-Path: <linux-kernel+bounces-727843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB8AB0207F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310C47B6655
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010BF2ED154;
	Fri, 11 Jul 2025 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iYJTytre"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07782E2EE7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248050; cv=none; b=Xy3v2HDRHym3YcSZBTCthL+pnvsINuUjGWwf64WbHUSV3y8pVt/gPzJzd1R5A4WxOQkr9QF+Sy5O8E8+Qiv/EpViNlabJsItdCiqB4/tPYQ4zufUMyy9HNKX8s7LsJ13pqqFsGvsn6gtmygBc4maxQEXDqanOx2KU9/IQRFiHZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248050; c=relaxed/simple;
	bh=ebT2s7nXALqt6/yObzMeAm/ZCc1oP9CJhn5ID/ByeoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RK4L/j0tsVGIooBtRoukhEHKCFJQl9CAXmQs82RbYxVFYDuDCEoZzMAF4t7txzV9hPpwjzrclxIMaJLKdd1EWVIcyQty8zDFAmSPAy71cCWZxVsexmRM+Cq7lWz1r8inSs0nP9SUrjY3HW38pYkjYaHGZna1EvBDCMzf4wBEARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iYJTytre; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2ff1ed124deso665562fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752248046; x=1752852846; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hi2TXY2tfoPRf/N/ueDW56lwyKoXrTU9bENTT3dZYo=;
        b=iYJTytreA0rCoV8SP3UalOtwOjJxzlXcTqUxoyGGIVZV0zJHXj5lshblYroLL7KcaN
         bNTCDRWoB7J1UQQX41s2FUOgpirpFFjM2Md344GfNRBgAFyHVy1VZeFymdl19XSj7edF
         MxUCf4MmJEu5gB4GkZIUoSNroKRhLWX+vjp68856i7K3CJx7pG477tfOZ582qZx5Hjfr
         uG/xBjJbCcs/U/9tnZsYN6GUV2wL2DZYB/CbIJ6HwJQSPfv57/ueP2OZmcoBWnMceeRz
         kdiwmHYzsT8H2k9XGwqK0qtEh9PXxX52RwhWUWRd/WyRmBVpb6oAjaPITgff1cIAIleD
         GgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248046; x=1752852846;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hi2TXY2tfoPRf/N/ueDW56lwyKoXrTU9bENTT3dZYo=;
        b=N0A4o7ceyR6h1Yx9IdW9kukIWJntiEzNQXBLKNqxZnSt24vuTSij44hGdig6x5ESF1
         gS+lbw5gcL7J3LFIyCAZLNDsKV2v9fuZwcwFv/3k+cRRL3LXoPjoi3xkQGYcPJQPRVIe
         ZL+Nq5DoWcQJCqLviTsFm/Hz9ZskwjyZCjSz/gJRJv8nddCAd8aixa3oFHSyKtHbN3AA
         WD/b0rKHze07E6/I03sAp2FPYhKBE/C/19jjUfDLGTb+e9sc5a1t1mwMXWMJt4VNs2bA
         +L4ztvj1qUVDYPCbVFRsvvst1588wk+Y0MRiux2DHCvlt6RfrcRG3g966QS0UDm4Dp4i
         DSXg==
X-Forwarded-Encrypted: i=1; AJvYcCXie06CadpN3+EJvUwn3Au2iEVNq3mGxBMK7TViU2YAcc/Iw85cnx17dEp389iBtyFlQWsAMswH0CsMAZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoC8NOCJvZ0kLw5GnJGRjhIDOmJjiYpO4leb/BYPzvTHCZChgN
	GaK+lmBas8paORp/KV10I4Bw7r4bLpK4JFEtM8EOHFMycgg8KNmwhrihqVvJ7u1tJwc=
X-Gm-Gg: ASbGncsSCgY8ebmdQNQxCSPglOeuqoOfxEoF2boyxtbnA5LmK6sWdPDkwUkxWgBFzc1
	IE46xs1Gnk5/sEAXUusmhGyhN9kYRwqTCXOzDBsO3VDBHpo+BhIYNtmZJYJQp6PPXJ7TeyWRpfB
	dR9/94XkKDpkneb6B3mQSOH/7OCz4SuaQrk1ahiTYBI8jy5r/CWYzx03d4XOVgb7b+91cA6OGTK
	vG191LQmBYvrFzU887ZB5l4Le0S98GCp3sWRdewVxdQ8hu1sTkfPe0IG/PrK0cwA2Eurz3VnsN4
	kQjlDGDo/BzJ+mn736SNEvOFILmo5fJLEi/V0dZVKSdsVYc2T7xitJP/L3id0WBmOdQsLTdNQ62
	TzxuZUgxgDB8GzOP+JNHMuB6gR25/
X-Google-Smtp-Source: AGHT+IGXbaybHyhrMurjq2yGraWSmf6jCZve3G5yKDCAGdsvXXoxzSSFfEyknCjd809K9bkPjCWepA==
X-Received: by 2002:a05:6870:3e09:b0:2e9:8ed9:16fc with SMTP id 586e51a60fabf-2ff26eac21emr2616277fac.11.1752248046558;
        Fri, 11 Jul 2025 08:34:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff111c36a0sm762348fac.2.2025.07.11.08.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:34:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 11 Jul 2025 10:33:55 -0500
Subject: [PATCH] iio: temperature: maxim_thermocouple: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOIucWgC/x3N0QrCMAxA0V8ZeTawdriJvyJSujR1AV0l2VQY+
 3erj+fl3g2MVdjg3Gyg/BKTMle4QwM0xfnGKKkafOuP7eAcihRcjfFRlH8IiekelcO45swa3rJ
 MYTHs0BN1pyH2/ZgIau+pnOXzf12u+/4FEksheHsAAAA=
X-Change-ID: 20250711-iio-use-more-iio_declare_buffer_with_ts-3-2cc387a66bdc
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1723; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ebT2s7nXALqt6/yObzMeAm/ZCc1oP9CJhn5ID/ByeoY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocS7msivCC30zn1X+Gu/q9gRTPYZ7F35T4whGE
 IXSZg011mmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHEu5gAKCRDCzCAB/wGP
 wEktB/49NdsstQvtK9AX+6VglLicdjumTe23CFtB7TSZO/kAQ5HQv0wtejfGPga0imk9oydYhKl
 IEh7HTAXtU2IkhV+Diu4D4whrsnHfrz+cdx2q1NRsKwa7nPiv4zZ++IUWLeo7AoV+gzLJdPRZRt
 bzIGL9CJ0oimZ6kH4lfCEUHAcv5d754CkK5oaJHldDxmE18yUkApEYKioU2/s6wlmSDJ75V0wbu
 lj/CfzjQ2V4Or2GAW76KauC0wumD54BEFrdciW/AhLINtjzyyLrdc/9arZ3+Uq8YiEugCkZNSH2
 na/Zx2CCmu67rxDeJFejDoSVZA9dtFuKb8+6W/ApZseI5XcM
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_DMA_BUFFER_WITH_TS() to declare the buffer used for
scan data. There was not any documentation explaining the buffer layout
previously, and this makes it self-documenting. The element type is
also changed to __be16 to match the format of the data read from the
device. This way, the count argument to IIO_DECLARE_DMA_BUFFER_WITH_TS()
is just the number of channels rather than needing to calculate the
number of bytes required.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index cae8e84821d7fd521d59432580d51def939fa4d1..60eaa8140d3e98e10c073c8d18cf01524b1c1816 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -18,6 +18,8 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
+#include <asm/byteorder.h>
+
 #define MAXIM_THERMOCOUPLE_DRV_NAME	"maxim_thermocouple"
 
 enum {
@@ -121,8 +123,8 @@ struct maxim_thermocouple_data {
 	struct spi_device *spi;
 	const struct maxim_thermocouple_chip *chip;
 	char tc_type;
-
-	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
+	/* Buffer for reading up to 2 hardware channels. */
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, buffer, 2);
 };
 
 static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,

---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-3-2cc387a66bdc

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


