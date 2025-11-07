Return-Path: <linux-kernel+bounces-891031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1F5C41A85
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C4E424985
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316CE33B6DA;
	Fri,  7 Nov 2025 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vWJgL5pK"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9255B320CA6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548829; cv=none; b=Kvpl61DOEdgsQ9pBBIJShlrnoXrRo1/yxFAHRnG9JoE9Ipx/vNTifb5f0bdpeCFczVexiWDlvzSW+xol/ta5Zpb/VneddeMVixkAleXCqDqgi78r6FwVXX9TIz8uiB2xMlaQ0+h5y6nkMZVkIJAYYrXZXt7Mme86I77PsGbgDjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548829; c=relaxed/simple;
	bh=uBZhRBQvKxN5Rbc+PdSnTkkrZAa+WeV1PheO2s8Yfj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QkbLPlrXHx9kQbjOsPWoAFIp1YmeGtrG8cA3cUWLx1IuJnk+zsXfRS8sqxtUSnzyeod9uYPcUZmN+DW1vkY4imvJ6KT3xTYPJP1vKQxxEfHQR22S/1d8uuqP3FC9Gt3tKZdX/zOF9v6uXrce2IEtu6Mckbqkrq4HHihQTxfoA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vWJgL5pK; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4501d38bb41so407167b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 12:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762548827; x=1763153627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/rvhBJ+T6XZ73EAxGhr0kOh+HMxO6YR7XKNjge0UoKs=;
        b=vWJgL5pKyHRHWD+m8sSU71U/WljRfVTYhpRmQ5qnjd+XbaUHQCt7uYSA+ZCnOGeeEA
         48lfAWda6LIJ49NVlgyylqqlIYZeDAIIr4NHwp+ysEAA5zY8w8HTqhSJZ7x33DxLqct5
         n/roD+ztLL/Kke2JhKHoAs+SMZW6prsnJGC8oXFjnlt2OUonBVbtbAPp/0nFgOCHut5z
         8TZfkm8/19vtICNbFDJcw7MHT9XgIl0aIZZiZTKxx55o4VEETge2NyCpy+LQuUrtuyKk
         IDSvqjB70ni79Pf0Kq4kO8gO1a0ZLFeREDb7dEtOx6DzieWwDk716dAmHI29OYw5Uirh
         Cq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548827; x=1763153627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/rvhBJ+T6XZ73EAxGhr0kOh+HMxO6YR7XKNjge0UoKs=;
        b=fsyZzcXm/k0D/2Vrc9YDopHPCWf8FCUYeJTCN63fv98bLO51zwg6nqgW8vMyD+eKeu
         5b9jjBJKxjocn/DLvmW1muNihUzBseIAY7fVDNbNIkYnQxbJ/soZ+jPaZs5hZsqvdAki
         q+9qed95i3Dxm4pX7sCs1EIvGXqa8oBBpE0RVYKjMENZy8LaDuBcPQ2iNNtL5sYnzCbA
         kQW8cWvQOJ5tQk8XPnm2ChjvU5Q0xiTw3+qMkBTSNM+nA6e5RUuvAvE7W5IVVZEERDyG
         B7uiQZsxbryXDnVDiAfGfgrhnAuisuybWv5wcHm/wPGh9akSY8yTgbjwRiUsicPZ5aHm
         LNEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmErkFkXxrjna8Im9CQ3F9zy2Wzxlhr4fsxCLHS6Plfx2bQHVKydXV8mJ+YAOpB7vT39mxJ4ULDrEPkv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ow6/aorXH56oNKeVzuzEv5p20QTpz+0HpxANgiX8JomY+Lov
	UuRXuAAnefdk87rRNZZWC07zTfnIaHL0kEEnfeaG7psoCEHeGViHLSbNm6xRNZFrRcw=
X-Gm-Gg: ASbGncuQIJ9aG6H9uxWRl/oXD8P3wV3s9CYo0mnZlaDbVe1ATasKgzbPqU4lAx+9O1h
	y+aPa+MZHY4+mwxc+QOJR49Kuz0EsNSt0jTgmI0TPV/4QJ1wAK8w67IXelOMALYy2eX8LTEWCg6
	cBGtZrKWkDflgMhUrQ6aepoV553bbqhKuzR9CNepNssqVz2qoNTU1627uShlXw0DRQXR9R2aO0G
	5xmISDTdkCyVFDWxfnuZUgEgIBXmb3nku+gU0fD/iRtdJzHFUyCyRdQYtr9SEl9WetYgQUfff4K
	el/m+XCTwqz6m7rw9XqbfbQHQwZeWsXJ5L6v6OYlC4+owx2lw30eWxtP7v5PDPFp5IQz4JQAYdj
	AjTuYjLo58GQGVF4wrNjSmBNp5WsWa6Z36hm36+MSztfk+swSixkLGpFdS2gnobpwutt/jqabYb
	XHTxE9Hxe7NsSxTH0=
X-Google-Smtp-Source: AGHT+IEHuss/Yrh1cFcIOW73t6Nlukd7ORXBjsm4AOvCFUlFSow7BBb0+QgzjM0tTWDidJyPyKavcw==
X-Received: by 2002:a05:6808:1523:b0:43f:63cc:aefa with SMTP id 5614622812f47-4502a4d4915mr342618b6e.48.1762548826608;
        Fri, 07 Nov 2025 12:53:46 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57eae5esm2915601eaf.16.2025.11.07.12.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:53:46 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Nov 2025 14:52:49 -0600
Subject: [PATCH v2 3/6] spi: add multi_bus_mode field to struct
 spi_transfer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251107-spi-add-multi-bus-support-v2-3-8a92693314d9@baylibre.com>
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
In-Reply-To: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3841; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=uBZhRBQvKxN5Rbc+PdSnTkkrZAa+WeV1PheO2s8Yfj0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpDlw6WL09bq9iy+/GN33p/vb2QS8/tlJSTsR8H
 F4YmjIugkKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaQ5cOgAKCRDCzCAB/wGP
 wC8VB/4wshs9FzXaveEoEjEhM+PG0nDRH0fQV4ZScm5cEAV+PAJPkqnMUu+GvtyQo1Qe5OLjZcR
 rjJfhnozvGJ7I91mbnuVX6fXsJ8EbX+faFEJbSjEyLGtzsolg5Zhwbws8KKRDqEAC4Z4fIO8l/7
 bwTVB4QbJqfYpYoAXGRS/HZ+KjFd3k5qBmC+B2G4h5Z4i1ux+qMF0otPmcksaPQMsHmZDRNFeWY
 TghgoBn+sobC+tXMSawtC4sKeBHToHRJwExDy/Y/0+araYcGqzQeynLrv/4d0NcEliRIS1CpP+T
 XDZxb1cv9dEKZok/p9EyooZrSDMqnK0atHgj4p5IUI+m8T48
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a new multi_bus_mode field to struct spi_transfer to allow
peripherals that support multiple SPI buses to be used with a single
SPI controller.

This requires both the peripheral and the controller to have multiple
serializers connected to separate data buses. It could also be used with
a single controller and multiple peripherals that are functioning as a
single logical device (similar to parallel memories).

The possible values for this field have the following semantics:

- SPI_MULTI_BUS_MODE_SINGLE: Only use the first bus. This means that it
    it is operating just like a conventional SPI bus. It is the default
    value so that existing drivers do not need to be modified.

    Example:
        tx_buf[0] = 0x88;

        struct spi_transfer xfer = {
            .tx_buf = tx_buf,
            .len = 1,
        };

        spi_sync_transfer(spi, &xfer, 1);

        controller    > data bits >     peripheral
        ----------   ----------------   ----------
            SDO 0    0-0-0-1-0-0-0-1    SDI 0

- SPI_MULTI_BUS_MODE_MIRROR: Send a single data word over all of the
    buses at the same time. This only makes sense for writes and not
    for reads.

    Example:
        tx_buf[0] = 0x88;

        struct spi_transfer xfer = {
            .tx_buf = tx_buf,
            .len = 1,
            .multi_bus_mode = SPI_MULTI_BUS_MODE_MIRROR,
        };

        spi_sync_transfer(spi, &xfer, 1);

        controller    > data bits >     peripheral
        ----------   ----------------   ----------
            SDO 0    0-0-0-1-0-0-0-1    SDI 0
            SDO 1    0-0-0-1-0-0-0-1    SDI 1

- SPI_MULTI_BUS_MODE_STRIPE: Send or receive two different data words at
    the same time, one on each bus.

    Example:
        struct spi_transfer xfer = {
            .rx_buf = rx_buf,
            .len = 2, /* must be multiple of number of buses */
            .multi_bus_mode = SPI_MULTI_BUS_MODE_STRIPE,
        };

        spi_sync_transfer(spi, &xfer, 1);

        controller    < data bits <     peripheral
        ----------   ----------------   ----------
            SDI 0    0-0-0-1-0-0-0-1    SDO 0
            SDI 1    1-0-0-0-1-0-0-0    SDO 1

        After the transfer, rx_buf[0] == 0x11 (word from SDO 0) and
        rx_buf[1] == 0x88 (word from SDO 1). If the transfer was longer,
        the data would continue in an alternating fashion.

Acked-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/spi/spi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c314194d4e7e2b396795ece10e142118ca05f4eb..7d22ef5077d1229cac2574831f80092c591b972f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -976,6 +976,8 @@ struct spi_res {
  *      (SPI_NBITS_SINGLE) is used.
  * @rx_nbits: number of bits used for reading. If 0 the default
  *      (SPI_NBITS_SINGLE) is used.
+ * @multi_bus_mode: How to serialize data on multiple buses. One of the
+ *      SPI_MULTI_BUS_MODE_* values.
  * @len: size of rx and tx buffers (in bytes)
  * @speed_hz: Select a speed other than the device default for this
  *      transfer. If 0 the default (from @spi_device) is used.
@@ -1112,6 +1114,10 @@ struct spi_transfer {
 	unsigned	cs_change:1;
 	unsigned	tx_nbits:4;
 	unsigned	rx_nbits:4;
+	unsigned	multi_bus_mode: 2;
+#define SPI_MULTI_BUS_MODE_SINGLE	0 /* only use single bus */
+#define SPI_MULTI_BUS_MODE_STRIPE	1 /* one data word per bus */
+#define SPI_MULTI_BUS_MODE_MIRROR	2 /* same word sent on all buses */
 	unsigned	timestamped:1;
 	bool		dtr_mode;
 #define	SPI_NBITS_SINGLE	0x01 /* 1-bit transfer */

-- 
2.43.0


