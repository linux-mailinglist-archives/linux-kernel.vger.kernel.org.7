Return-Path: <linux-kernel+bounces-739924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD1B0CD2D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7497916BA50
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FB3241665;
	Mon, 21 Jul 2025 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Aisdd/y3"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F823C4E7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753135981; cv=none; b=mUwFk4HlQMnWRSUdfqFEeMMyE8bJ8MY9uWl+ce6k5MnqOD44PgNiTHmIzLJn6COshD73diBPbLKQHHUCsy9xphRvh8F6gkwU7xXtSRaaPrQP/fU8Fp7XVL5Co8log+KeTgmgyFDlEpHraEWOzUQsAWT+81e8UzgJAp5jtc2EH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753135981; c=relaxed/simple;
	bh=FlH/ND2z8RUlY+3y2sTU47dSU+1M5otXT+HK7pDuHn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I/nor3LndHJTihtGq2j0vjMA582ndQky3Au2t7eD1IhmrJQEU5ouFBO/7HTpa/kjYuz1FgaomA57rW3md1TCFiTAaHrgtS8YCUeZJjmap/2P0/gUApW4k/2u5xLv+KudC0IygexlStYgievDFysiZLA7DVT8a1fd4XtDQLFA2FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Aisdd/y3; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-73e55e829fcso2720376a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753135977; x=1753740777; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4QUqhtmhxV/A0o/IDCP/S2tsnQrmpkfM9PaU4Oxm2c=;
        b=Aisdd/y3bghN/NV1cW426hY0DkDTaDORs7/O9jFwGYU/qg895FApdCiWyUtWaDlQjq
         KwQ8HmMqinMSw++q3+aW1LMSLiG/246QjgFPS1hCDMElmCwjMSV86IkXgHSwzMlcFeaS
         vgAsKCU66iN6lxx0Ts4I9UkPMxw27WeiUoUmfTsHv7vb+en4glqGoAkChv0PhZuF1gFD
         4F+fy6WFITgUofYUbep1f4vS6kBJOA5Avc93arRstzdV6B5EJ2xhTAYdofrfHnjYhDe4
         O8YcXdVCwafw2R9obGM/8L1lSkV32ATDwC9h0uO8vRvUKR2Bg7o7UeXyAt1KKRR2OAJ8
         7VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753135977; x=1753740777;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4QUqhtmhxV/A0o/IDCP/S2tsnQrmpkfM9PaU4Oxm2c=;
        b=CWjb2PuFg0BL1q5ZzhU6nFN/57XUk/AQqTtZdb5FQHW1yvRHXhCEDYonck/xKyJJM5
         facoH25M/VJJOQ4Ts5aV5DMUizF1Nxu3ViQCyzNdpqaD0i3p/tSSJPZKaGB2QGilklBx
         r3zm0Y0Kxq+m8zV7DGRI4oMO6RgL1DQIxYuO4lGwpGrhCVCkz6dtpCW53X1V54t7Uxn1
         6CowH90CnxxqLSd+dkA63kIadSRppcTY/3FhYt8zSc5kohJ+REukEIoVU9vrh3xWoD7U
         lLzsFuEEjcVSyEoIzyFg7US5Sd1ZLsHFwLzj/QNeR33cSQvOJ9Q73RNA9JzJ56wPRS1b
         YO/g==
X-Forwarded-Encrypted: i=1; AJvYcCVWCUK0NFni8Lx5lVxPTNwV/iEXBGy4Vanj3UiH1czn48WtUZ6zn1YDuKX9vfuxbb9vxKwwISCKmnUjEHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFHmdNw9cP4M0xfOmHC1GuRAUugiUmlhpqvYZxlev6gLkdcShJ
	BvYNtoplPUhoTr4HJ4BAOeZ/d43RbuqBizxxrxDaLxPPW/VHlsSTQIp3dcB4ML1JnhY=
X-Gm-Gg: ASbGncs4P+P4lIUgOYznr+/8+KWgk7V9/E+kmHfoXAgfdE0tMmA8Bw5vi1gmu6sb0Ye
	33SxXegSrvaQ0IkrwDRsi9ys/QyUH3Gm4l6ikMpkjj05x0U1e0wkA3nbxhnQnYI7MtIhh0KjQLk
	lFe8nQJYKMzkaXqy3OLudU20jaKF3BCN7dQbb2/nvjNniflBOrGGDzHzYxj92hmRDSfmiUC4YGk
	yXNKDC9mHyJ/KFnyuGr2QsLru9t/pPHhFOTHhQQIBmdFLN7S9Kuu58Dd+VYFDFzfxaIe0YPU1jP
	Fuya7FCirjawO7V9DMzghckZPSNu04U3oaguxDxmdy2+e6pS7GPpgcD7CI2tsN+eDJhvinfUt6H
	1MAwlQ8QZIpgfV4QrOX+gDCbBLYmS
X-Google-Smtp-Source: AGHT+IFthgWSVSfgVwt6XwHTFSI4mZWckkpu17WIbzx4acXXViP8dTaXTcaVrb+dPf4d/8DZcXkItA==
X-Received: by 2002:a05:6830:6c8d:b0:72c:320b:fc8c with SMTP id 46e09a7af769-73e64abb03dmr16573659a34.21.1753135977532;
        Mon, 21 Jul 2025 15:12:57 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2a79:4b55:6a01:85d7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e90ce0b42sm2518764a34.43.2025.07.21.15.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 15:12:57 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 21 Jul 2025 17:12:47 -0500
Subject: [PATCH v2] iio: adc: ti-adc081c: use individual model structures
 instead of array
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-iio-const-data-11-v2-1-c3fec12511ee@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAF67fmgC/32NQQrCMBBFr1Jm7Ugz2JK48h6lizQZ7YA2kpRgK
 bm7sQdw+R7893dIHIUTXJsdImdJEpYKdGrAzXZ5MIqvDNRS1/akUSSgC0ta0dvVolKoXD8ZJm0
 9e6i7d+S7fI7mMFaeJa0hbsdFVj/7r5ZrEKnXSptLZ5Sh22S3p0yRzy68YCylfAEkLvsBtQAAA
 A==
X-Change-ID: 20250628-iio-const-data-11-1c6b9e28aded
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3328; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=FlH/ND2z8RUlY+3y2sTU47dSU+1M5otXT+HK7pDuHn0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBofrtguNZPRR8KLpLKDaiAPcFIgaCGjY+rBqVUp
 DB9jY6qkqmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaH67YAAKCRDCzCAB/wGP
 wFcCB/4tjTVD04WHlbyez7ozsf0hv+2cO42jF1uFTOanXoY5wjqeL9QMbj2FGa+4L55Ew5VkXol
 1krlHy50hQRwo4IucSijziN64qr2Kduenm5NEFGLb4tMgCwTnjZp8uB9Hl8K3ZxKA65Auo/2eRv
 8++FCnqkNRxGEsXAHZIVJHQEnnkqEr97dOG4i3+tQo/Yca3Ge8hn+S4nL0B4X3NVReji2SzKTVL
 ShOhJAvBCJV0WlMrPUiETuJWbtC/YxY86nwrhnwb2/BCpfsTX2FnroxnYjUV05kupDxa27fZmp0
 EROgI14L1ENkt/hA67LJt9AF0SCFQMu1YGoKqcD8PYEfJkOK
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change the ti-adc081c driver to use individual model structures instead
of an array. This reduces the verbosity of the code. Also, the data is
now const as it should have been in the first place. The ADCxx1C_MODEL()
macro is dropped to be consistent with similar model definitions in
other drivers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Drop use of ADCxx1C_MODEL() macro.
- Link to v1: https://lore.kernel.org/r/20250628-iio-const-data-11-v1-1-268189459192@baylibre.com
---
 drivers/iio/adc/ti-adc081c.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 4f514db5c26ea803660087ae02b2cf8ec71911e4..8ef51c57912de62b1d6a6913372b2cc8c6d463ae 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -102,27 +102,23 @@ struct adcxx1c_model {
 	int bits;
 };
 
-#define ADCxx1C_MODEL(_name, _bits)					\
-	{								\
-		.channels = _name ## _channels,				\
-		.bits = (_bits),					\
-	}
-
 DEFINE_ADCxx1C_CHANNELS(adc081c,  8);
 DEFINE_ADCxx1C_CHANNELS(adc101c, 10);
 DEFINE_ADCxx1C_CHANNELS(adc121c, 12);
 
-/* Model ids are indexes in _models array */
-enum adcxx1c_model_id {
-	ADC081C = 0,
-	ADC101C = 1,
-	ADC121C = 2,
+static const struct adcxx1c_model adc081c_model = {
+	.channels = adc081c_channels,
+	.bits = 8,
+};
+
+static const struct adcxx1c_model adc101c_model = {
+	.channels = adc101c_channels,
+	.bits = 10,
 };
 
-static struct adcxx1c_model adcxx1c_models[] = {
-	ADCxx1C_MODEL(adc081c,  8),
-	ADCxx1C_MODEL(adc101c, 10),
-	ADCxx1C_MODEL(adc121c, 12),
+static const struct adcxx1c_model adc121c_model = {
+	.channels = adc121c_channels,
+	.bits = 12,
 };
 
 static const struct iio_info adc081c_info = {
@@ -203,24 +199,24 @@ static int adc081c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adc081c_id[] = {
-	{ "adc081c", (kernel_ulong_t)&adcxx1c_models[ADC081C] },
-	{ "adc101c", (kernel_ulong_t)&adcxx1c_models[ADC101C] },
-	{ "adc121c", (kernel_ulong_t)&adcxx1c_models[ADC121C] },
+	{ "adc081c", (kernel_ulong_t)&adc081c_model },
+	{ "adc101c", (kernel_ulong_t)&adc101c_model },
+	{ "adc121c", (kernel_ulong_t)&adc121c_model },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adc081c_id);
 
 static const struct acpi_device_id adc081c_acpi_match[] = {
 	/* Used on some AAEON boards */
-	{ "ADC081C", (kernel_ulong_t)&adcxx1c_models[ADC081C] },
+	{ "ADC081C", (kernel_ulong_t)&adc081c_model },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
 
 static const struct of_device_id adc081c_of_match[] = {
-	{ .compatible = "ti,adc081c", .data = &adcxx1c_models[ADC081C] },
-	{ .compatible = "ti,adc101c", .data = &adcxx1c_models[ADC101C] },
-	{ .compatible = "ti,adc121c", .data = &adcxx1c_models[ADC121C] },
+	{ .compatible = "ti,adc081c", .data = &adc081c_model },
+	{ .compatible = "ti,adc101c", .data = &adc101c_model },
+	{ .compatible = "ti,adc121c", .data = &adc121c_model },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc081c_of_match);

---
base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
change-id: 20250628-iio-const-data-11-1c6b9e28aded

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


