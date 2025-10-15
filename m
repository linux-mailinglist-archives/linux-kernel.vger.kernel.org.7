Return-Path: <linux-kernel+bounces-854299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F95BDE08A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2681927016
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF030BB9A;
	Wed, 15 Oct 2025 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZifL0Bsf"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF92494ED
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524551; cv=none; b=JdCqn+gEF+1U6nLXiNw/1Od7zjcMGmHQs6IIWtGLqm1tkZjcGWBuIc6tx7ihAsQoU+o+TDvPmRQSYDM/A7wM8DvN2oKX/o/I1+zNzixzWOpxIThSEbSX9dNbaWK8wR+5GxFvsEHuuo+uXDxb2KidNMj/mw4HqWMRF7wvkmVmIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524551; c=relaxed/simple;
	bh=L4wLsqvaNKifFb9kXN1voIWzjV4ev9i8DnZdeTEPjgA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IqvXyQ0wKz2bKs8dWMHLVP1nLxx0bsI5YgOm4yQODJKjPMpCPA76IHxvv8TCUmlNx/GOrwol/qcE8YKRotcNM0Qtu6E3NBJcUQ03LlJsRVzNetxIPJMDoD6rcc2F9Zvk8oteCm+Cb5VHI4S+bUSq7FA98XrhvHL8u3R+5qqgt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZifL0Bsf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710683a644so3203545e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760524548; x=1761129348; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7QNXCpktIYAb1DPjGOe7dO+9+h/oG2Y1WU2nDERyLWo=;
        b=ZifL0BsfiFIMHz/ld2J9irwBtjZlex3rBImlrXEtgVACHZK1as8pZARWpbGup2LRcD
         i4d9iTXIuH+GtiJhJ/rFfzttMHa5+WUYTCBOMU+5eoIE+NcnGhc24FtQz2WbZ8LbrkZc
         CL6gJIKGcgUevB+D1wKpUESM4qfDvT2yTA6MtZblelCLB657hgGtDPH7RkCbvnductmp
         hBSeUBYblMWbpZJagvD/38jmCF7JoCB2I523YLYF0VZfeUvMRYvT1K03Jwbd9fsaYXUK
         /bhGEfcbRpel98FB9LNOfJLH8lMRyadhTT24XnycfIA3AL9Xyy/OLf2LzCtFdUcc1w53
         tuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524548; x=1761129348;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QNXCpktIYAb1DPjGOe7dO+9+h/oG2Y1WU2nDERyLWo=;
        b=qrS9X1K0xJLpZWfvkVw4lYiHUpqLeABWXeCNQYsR2iL2IGpIDOeHxF1N2YxlLMl/5a
         CpQCHG7X/70FY1fQ4+VRt2njRpdcVSa29xnWu4O+cdis05OPOcwCYoKhqLj/vOCmfzeJ
         yAWR4bzoaZ+CYiYUlaPhwYIuEbdsaB7h+C0cLeSap6SV85aRYq5/B7OOeU+b5WRstUU1
         Bh4tZ7wYkAmlXKfH+7375eVJT/OiARJN4bYS+TtU8eSqijg/PkpejEEEAP8JxYE+lPKY
         qTFCJHg3kqhboxCakLQSYZfCFNx5AeLRfWRkrdVsiYYsUPCsRKiJGAbZn+tonMJlQyvw
         +sow==
X-Forwarded-Encrypted: i=1; AJvYcCV5azr90Hljqwt27tXgJx2fBkLgml1BCJwKV08YFjWfTpGJI7OYizRYo5uwB3G5Li0bN6zcK9cZhQpv8Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1P7RVOTRop+EL6h+KxIwxtv++ltFuaHyjKhK+HSN63TySFwD
	VxSgNTdaU0Iw8peFOgryZqyA3JTgatw98m5Al1L3HBqBzhDn56GyjKIe
X-Gm-Gg: ASbGncvfCNVk8h7ReiJQ7xSX17vZ1fRwx1UpaBOV/G/BnPvGT4JwA6aGPdhodR27P+H
	wuIAn+RbdypoWoJrArh0EJbnVIC4Y9xy7/JdXbarng1qBBlOMohQPz72HD/+C0MKhE4FOgTGwCy
	slngc194g2nHtSm4vjTwzy6ET2Ofa7dFE/jY4hnKeosaq/3P1HsB/G6kzD2HtP2zkAsr2Rj7acE
	x2xAmOcKyt6FYKmnsA4S7r0EOxqCYdFTGegXy1GZIqQ8ZapMaGqh/prEO6hndznyk8ywMaCuHD/
	ZrHE7KcaXHexDZinzBH86kOiI5gm7fVlGA+LOF78U6WX2xVvUO5I6d5nO436NTrG3klfgdVAl0H
	fbXYGWOAoRcaPsQ63CBpHebVl6FhgCFBqLffyyHRA0JFHXcwxcVKnB27NNixn
X-Google-Smtp-Source: AGHT+IERvd+DCsAGw5wufhvSoXWWpJyqmq8RwH0h8dyTRRhpT1w1j/81EeNMDn3zr7X5Guqk61mo0A==
X-Received: by 2002:a05:600c:450e:b0:46e:1a60:c995 with SMTP id 5b1f17b1804b1-46fa9e8dcc7mr223056895e9.2.1760524548098;
        Wed, 15 Oct 2025 03:35:48 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101c23a52sm19972125e9.12.2025.10.15.03.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:35:47 -0700 (PDT)
Message-ID: <ef452c01679bee2c8bdbefe1df4775c432f8b345.camel@gmail.com>
Subject: Re: [PATCH 6/6] iio: adc: ad7380: Add support for multiple SPI buses
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko	
 <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Wed, 15 Oct 2025 11:36:20 +0100
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-6-2098c12d6f5f@baylibre.com>
References: 
	<20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
	 <20251014-spi-add-multi-bus-support-v1-6-2098c12d6f5f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:
> Add support for multiple SPI buses to increase throughput. The AD7380
> family of ADCs have multiple SDO lines on the chip that can be used to
> read each channel on a separate SPI bus. If wired up to a SPI controller
> that supports it, the driver will now take advantage of this feature.
> This allows reaching the maximum sample rate advertised in the datasheet
> when combined with SPI offloading.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

One minor thing. With it,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7380.c | 41 ++++++++++++++++++++++++++++---------=
----
> =C2=A01 file changed, 28 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index
> bfd908deefc0f40b42bd8a44bfce7a2510b2fdf1..36abe95852006a81f7e31f8034699e5=
9292a
> f79e 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -77,8 +77,7 @@
> =C2=A0#define AD7380_CONFIG1_REFSEL		BIT(1)
> =C2=A0#define AD7380_CONFIG1_PMODE		BIT(0)
> =C2=A0
> -#define AD7380_CONFIG2_SDO2		GENMASK(9, 8)
> -#define AD7380_CONFIG2_SDO		BIT(8)
> +#define AD7380_CONFIG2_SDO		GENMASK(9, 8)
> =C2=A0#define AD7380_CONFIG2_RESET		GENMASK(7, 0)
> =C2=A0
> =C2=A0#define AD7380_CONFIG2_RESET_SOFT	0x3C
> @@ -92,11 +91,6 @@
> =C2=A0#define T_CONVERT_X_NS 500		/* xth conversion start time
> (oversampling) */
> =C2=A0#define T_POWERUP_US 5000		/* Power up */
> =C2=A0
> -/*
> - * AD738x support several SDO lines to increase throughput, but driver
> currently
> - * supports only 1 SDO line (standard SPI transaction)
> - */
> -#define AD7380_NUM_SDO_LINES		1
> =C2=A0#define AD7380_DEFAULT_GAIN_MILLI	1000
> =C2=A0
> =C2=A0/*
> @@ -1084,7 +1078,7 @@ static int ad7380_set_ch(struct ad7380_state *st,
> unsigned int ch)
> =C2=A0	if (oversampling_ratio > 1)
> =C2=A0		xfer.delay.value =3D T_CONVERT_0_NS +
> =C2=A0			T_CONVERT_X_NS * (oversampling_ratio - 1) *
> -			st->chip_info->num_simult_channels /
> AD7380_NUM_SDO_LINES;
> +			st->chip_info->num_simult_channels / st->spi-
> >num_data_bus;
> =C2=A0
> =C2=A0	return spi_sync_transfer(st->spi, &xfer, 1);
> =C2=A0}
> @@ -1113,7 +1107,7 @@ static int ad7380_update_xfers(struct ad7380_state =
*st,
> =C2=A0	if (oversampling_ratio > 1)
> =C2=A0		t_convert =3D T_CONVERT_0_NS + T_CONVERT_X_NS *
> =C2=A0			(oversampling_ratio - 1) *
> -			st->chip_info->num_simult_channels /
> AD7380_NUM_SDO_LINES;
> +			st->chip_info->num_simult_channels / st->spi-
> >num_data_bus;
> =C2=A0
> =C2=A0	if (st->seq) {
> =C2=A0		xfer[0].delay.value =3D xfer[1].delay.value =3D t_convert;
> @@ -1124,6 +1118,7 @@ static int ad7380_update_xfers(struct ad7380_state =
*st,
> =C2=A0			AD7380_SPI_BYTES(scan_type) *
> =C2=A0			st->chip_info->num_simult_channels;
> =C2=A0		xfer[3].rx_buf =3D xfer[2].rx_buf + xfer[2].len;
> +		xfer[3].multi_bus_mode =3D xfer[2].multi_bus_mode;

Why not doing the above once during probe?

- Nuno S=C3=A1


