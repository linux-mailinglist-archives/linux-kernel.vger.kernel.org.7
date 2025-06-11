Return-Path: <linux-kernel+bounces-680584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8481AD472E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 02:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87396189CB8F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 00:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB58B2576;
	Wed, 11 Jun 2025 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b="D1P+ya6w"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D886288CC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749600372; cv=none; b=jh3WenL2tpU5PFfC6DL7wdmhTUvJrGZ9JTJVdLGJlgDi3+INlWvYniy8uOcXdQZTiCHoTTFh4xePAmwE/U7p/JOTYg3PkCEXGYlkx/JjNqrLxP9Wl2v7wHODo1OoNHOey4IEdo7x9Fs9hlIgY1Uol4+SPyKJLthhjhADNEOktkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749600372; c=relaxed/simple;
	bh=0L0QrdrbF3eIPEJwxeoIpihmmZc23N/FFGqyE7epieQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=crgdVrePut/y6O03qyQ+nyVJOimx7uqEOXT5SqhsYkg0b9w87h/OMSnKRJt2V4mf0T+Cyzt4iccXovRwNugj5DGXXQprM7RVBhT+ZhAueKnu62ioJenmguZVSaqpi2MJxkoC/+GdIU3TY+3wjpW814GTTLwBimmLCGPsg3uCkFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer; spf=none smtp.mailfrom=libretech.co; dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b=D1P+ya6w; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=libretech.co
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a58f79d6e9so66537911cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 17:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1749600369; x=1750205169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/S+u5mk3bLFvYAEjEuTrh1x6JcZ8zFH062YgbiH+X0s=;
        b=D1P+ya6wsD5CeOoLO5gAeHDdgoD+y8seQ3NjaO6pJ/KicYeuK0txsP1EZNbgUNTigU
         MjdFbJ7GtNTlhrbSPUFTdJw8CyNjAFDASk+83i2oaVtrccm0TpeoLCOfiq2Mqo67auso
         ONOvsFK44zPaXk3Z4XBszl96xRGqwZlmaZz6ecl9I7wAozeowiND8haRkBCaiLmSyMPg
         b3TXBiEufu02Eg4X8AGHR1tPpn1ohT0Mp12Xr54qgh3LYY0D6w8sxi4TLG1g9A7qNtVb
         FsQqmJy6jUkqf97vHbERRwYLD4ILFvKgGUXd4y7yUfO5pc6Zue64aK+/A/FWsZ3k+Z+I
         yXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749600369; x=1750205169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/S+u5mk3bLFvYAEjEuTrh1x6JcZ8zFH062YgbiH+X0s=;
        b=YmUX/pDiI2Ch/vQz0AR1fYLlZjjoO9otA6zELNTZI0kXlTucn3+lep2oAvYiknOYu9
         XUjobCgVdQZqeGLz51mxM4nTkvIGlMD+8mnKMf+FHwE2CrE1sZsnClNKueQqX8wBocHG
         sOqsMTOHAr7u9zAK7GPVttiJRnTK6m/pEmXAtCydDmN1ABz3KGvdJR2C/S5/7dNYEd8k
         q5PPBvcNxtmB65JmMX4NZ/MIw24WuiXg+M2KjoUxtBZXH6aIoMAGlz0Iwz9Gn5Xq5oWk
         6DwQChbyrc6k91VgS7HZpSqlapOnZy5gQMl5g2RCgHv3xOjFD2BfIA9loue1wU0WasP4
         1c7A==
X-Forwarded-Encrypted: i=1; AJvYcCUv6XJMBJzL8/cjnyOUwx/NsYXyck1O2RSYMvxvEDQHz05gYkFZEjOlEG95mmugjBY5bQpQ826ZOKw9Y4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdBvy+yGm2c+5pTbEkLxF29dT4gESd96YHnWsVEUe/P13jPoUv
	X+SC9vmcU++bGHQOtP28p4xgU/E2q2LA3hXgW6MWXxHUXcK6xPJ2Q5An55+F/HFuwA==
X-Gm-Gg: ASbGnct8uE+Fr0ZXjXvR7U1FC11vvRTzf69UuuNy4QbvevJNWd5RUHDdzM+qYkjHtq8
	cs9auz+TMTrblghDtqQWcydZkJ+hJb/cRY27Rd4/iiDgE/oldWVQ3qZz7Pzp44yYuRwfbS5aUYU
	jaLaDF2bOVaQw0vnR+Ac/7sZb4TzFnSA5E2gMTgH5pnXXHJcDbUx/Pn3CURFI9rXB3uPAKoTEB2
	MQ4IawGPZe3SDg4pb/qhWFZLwwTRGL3YSHA6F0G8rho+UuzBc3vLvpEh2Q3QB+c+w4ZHo7u5HNI
	fE5O4DRConZds9hKXNn+5kvBN1se8L9UOFDAvjm6X5CVD+2Ej7o2NBPuIw==
X-Google-Smtp-Source: AGHT+IEwSwD1OTQv/cY8Rdnwddhjk6tvIVxJAG/PkD4t1En++yl7NMDCXVoGb+ITA72UocpaA9kshw==
X-Received: by 2002:a05:6214:2263:b0:6fa:f94e:6e82 with SMTP id 6a1803df08f44-6fb2c31b3a3mr26501776d6.7.1749600369307;
        Tue, 10 Jun 2025 17:06:09 -0700 (PDT)
Received: from localhost ([2607:fb91:eb2:c0a0:10e4:4464:87db:3a66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d38de859casm501567085a.38.2025.06.10.17.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 17:06:08 -0700 (PDT)
From: Da Xue <da@libre.computer>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Da Xue <da@libre.computer>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Subject: [RFC] spi: expand bits_per_word_mask to 64 bits
Date: Tue, 10 Jun 2025 20:05:15 -0400
Message-Id: <20250611000516.1383268-1-da@libre.computer>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most current controller IP support 64-bit words.
Update the mask to u64 from u32.

Signed-off-by: Da Xue <da@libre.computer>
---
 drivers/iio/adc/ad7949.c         | 2 +-
 drivers/spi/spi-dln2.c           | 2 +-
 drivers/spi/spi-ingenic.c        | 2 +-
 drivers/spi/spi-sh-msiof.c       | 2 +-
 drivers/spi/spi.c                | 4 ++--
 drivers/staging/greybus/spilib.c | 2 +-
 include/linux/spi/altera.h       | 2 +-
 include/linux/spi/spi.h          | 6 +++---
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index edd0c3a35ab7..469789ffa4a3 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -308,7 +308,7 @@ static void ad7949_disable_reg(void *reg)
 
 static int ad7949_spi_probe(struct spi_device *spi)
 {
-	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
+	u64 spi_ctrl_mask = spi->controller->bits_per_word_mask;
 	struct device *dev = &spi->dev;
 	const struct ad7949_adc_spec *spec;
 	struct ad7949_adc_chip *ad7949_adc;
diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index 2013bc56ded8..cccbb00ad5ce 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -315,7 +315,7 @@ static int dln2_spi_set_bpw(struct dln2_spi *dln2, u8 bpw)
 }
 
 static int dln2_spi_get_supported_frame_sizes(struct dln2_spi *dln2,
-					      u32 *bpw_mask)
+					      u64 *bpw_mask)
 {
 	int ret;
 	struct {
diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
index 318b0768701e..21d453d6e46e 100644
--- a/drivers/spi/spi-ingenic.c
+++ b/drivers/spi/spi-ingenic.c
@@ -51,7 +51,7 @@
 #define SPI_INGENIC_FIFO_SIZE		128u
 
 struct jz_soc_info {
-	u32 bits_per_word_mask;
+	u64 bits_per_word_mask;
 	struct reg_field flen_field;
 	bool has_trendian;
 
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 94a867967e02..97f5a6192279 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -33,7 +33,7 @@
 #define SH_MSIOF_FLAG_FIXED_DTDL_200	BIT(0)
 
 struct sh_msiof_chipdata {
-	u32 bits_per_word_mask;
+	u64 bits_per_word_mask;
 	u16 tx_fifo_size;
 	u16 rx_fifo_size;
 	u16 ctlr_flags;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1bc0fdbb1bd7..4f47201f2462 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3824,8 +3824,8 @@ static int __spi_validate_bits_per_word(struct spi_controller *ctlr,
 					u8 bits_per_word)
 {
 	if (ctlr->bits_per_word_mask) {
-		/* Only 32 bits fit in the mask */
-		if (bits_per_word > 32)
+		/* Only 64 bits fit in the mask */
+		if (bits_per_word > 64)
 			return -EINVAL;
 		if (!(ctlr->bits_per_word_mask & SPI_BPW_MASK(bits_per_word)))
 			return -EINVAL;
diff --git a/drivers/staging/greybus/spilib.c b/drivers/staging/greybus/spilib.c
index 24e9c909fa02..087eed1879b1 100644
--- a/drivers/staging/greybus/spilib.c
+++ b/drivers/staging/greybus/spilib.c
@@ -27,7 +27,7 @@ struct gb_spilib {
 	unsigned int		op_timeout;
 	u16			mode;
 	u16			flags;
-	u32			bits_per_word_mask;
+	u64			bits_per_word_mask;
 	u8			num_chipselect;
 	u32			min_speed_hz;
 	u32			max_speed_hz;
diff --git a/include/linux/spi/altera.h b/include/linux/spi/altera.h
index 3b74c3750caf..d6e036ed00e2 100644
--- a/include/linux/spi/altera.h
+++ b/include/linux/spi/altera.h
@@ -24,7 +24,7 @@
 struct altera_spi_platform_data {
 	u16				mode_bits;
 	u16				num_chipselect;
-	u32				bits_per_word_mask;
+	u64				bits_per_word_mask;
 	u16				num_devices;
 	struct spi_board_info		*devices;
 };
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4789f91dae94..f44120d5a63c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -586,7 +586,7 @@ struct spi_controller {
 	u32			buswidth_override_bits;
 
 	/* Bitmask of supported bits_per_word for transfers */
-	u32			bits_per_word_mask;
+	u64			bits_per_word_mask;
 #define SPI_BPW_MASK(bits) BIT((bits) - 1)
 #define SPI_BPW_RANGE_MASK(min, max) GENMASK((max) - 1, (min) - 1)
 
@@ -1329,9 +1329,9 @@ spi_max_transfer_size(struct spi_device *spi)
  */
 static inline bool spi_is_bpw_supported(struct spi_device *spi, u32 bpw)
 {
-	u32 bpw_mask = spi->controller->bits_per_word_mask;
+	u64 bpw_mask = spi->controller->bits_per_word_mask;
 
-	if (bpw == 8 || (bpw <= 32 && bpw_mask & SPI_BPW_MASK(bpw)))
+	if (bpw == 8 || (bpw <= 64 && bpw_mask & SPI_BPW_MASK(bpw)))
 		return true;
 
 	return false;
-- 
2.39.5


