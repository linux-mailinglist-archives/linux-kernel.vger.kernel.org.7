Return-Path: <linux-kernel+bounces-837667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB31BACDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE9017B03D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661062DFA38;
	Tue, 30 Sep 2025 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQtAKHSU"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5A34BA41
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235873; cv=none; b=TQtOES/Ni7GIQnqxsMt2Xs+bpm4qNEyfAQJ0NvisEzA9AVxLrAqR1jBvRglO5vtBU0uPxySjW12Yottt+nd0PKHOamZCUUEwiAxfPF3OSvoOn2WvqgBk2tslMbD9MI2nO2q29zG1zzNAzGWXItqvkntjtiWou2g02Jpe5ojPClc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235873; c=relaxed/simple;
	bh=uURFXlGNdUF+Jg1TXYTFrqJ+6twXM+PGQp5QmOEoIKk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZ39EqmCMLXtM/XN6dE7rpsIb6frJJ5wWdZs4vftY8MK2bAfTRGgEn7PG9GV1kEksAtJhSSQrVr3C8jdOn5DKd3XBVlx9WBf967UI1jRPdW3frLY4YYy4B24ZXKPDQKn4497a97ecS7ZoAYkCXLw6SYcBm303UaG6q9elV+6nu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQtAKHSU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so22917285e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759235869; x=1759840669; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLjriQ23LoYJBTD+XC8CsUOd9ht1tU8OnhQ3XQhiqo4=;
        b=EQtAKHSU83Tpa4t/QoGuC/4RvX4LFsXFTfVU1gmm7h87Nn5pURf+DhwMs6ITfvN9TH
         wkYM845aM8nJHD8srMu0EbffXkMlLXm943mXv3b3S15AR9re8DTIDhbtYCLIOXEQNpyp
         nHrDoocd2sTH5Rkk3dmZsdqtgMxS1eOcwYqRYog7wXMNYHM4i3/yS7j0qu2JHqIOVepI
         JliBgHK/3zmopGrHxxvYz+9NI2Vv4393wDhHL09EUKtHDfRV6qiKhS1TjmTbEDR8bwAg
         yo3VRxo6nVOPmCSRdTCNW3oTVqA9UwWmTfjPt/fd+vSwXVLtZABVFJHaXdUYra6mbhCB
         bNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235869; x=1759840669;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iLjriQ23LoYJBTD+XC8CsUOd9ht1tU8OnhQ3XQhiqo4=;
        b=kCfMyEHljpIMym6c/U9cumgLDpSkbhOhWc+i2C/agTCk1fsWVF21JF8G7bxGktlEdy
         2q8qiaQpCxzwr0zWZi56ZK2YpelceweaBKxikvpvdPWsANqopWz/mlrgJlhoEKzYSNKe
         hCJi3jRUbAigmh5ESKSvfYT1uhjRlmceRWZ6TfST0en/V1irCB17LHWdxMEpobWKoXGM
         ChCmeIcilXpDFQSvxJGGMYZuZcqVnunUBXG2AaLKCWErop1Ol7CscR0lWlkqJYkf9GA1
         kR0zXXp6qkBqR52TGuVvZJALX3Otc24OvqHPAkonbE1o83VPiqZTTmALjqxqDasQOKw6
         1E9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuyReURHvUoLeLlWDKvcYtyVDXgZ3vmOws6wbQOYiNV5B20Zr+ybNrv5/DfTWnBi2lpEMhRU6e8mdPWVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz70pecDvW3L19Q47AuJH+g5AXbM3ijsyfiKZTHr9N1lY7uDC3z
	WmCwRmWuIj00vbE43vqkK1iwxQmfEYfgMgdZF+5s2KmOdbFygzo5za+8
X-Gm-Gg: ASbGncvXwJiplhTMi/iyOQjSpBe+WYCRVDWp8DwuFrCvEQchD53v+9iy8/waW4pyFSY
	IJ46yklv26Mku4W1A049wtZHcIjQDnISkvshJjwDkHwaLS+/aWad3YQ3FDWj+NcFdVQCKMgCwbO
	+4xAHc93TPUUuFGJ7W79hk+wnNToskN+KqZkNEUL5xEwhuXo3hEHHhKQtmfRjshS3ARhNU8+SUV
	1IkJDpFoDFmCsE+iV+wLZ9jKTjp9o6shqB9U7pgiDbpzRogdeDt/2f5u5310dWJtlRfFFOuiPkr
	s9CJ6b642ue2E/tivU3t8Q4kKBsrfpfdz2+5bVCABEXdygXZioPBxo40xuDML4dvul031DiLREh
	ozgP8OutVMrhRr7coaNlo16tHYLK/4EJN9Jh4c3tdOdOkfum4/G5VCwLfbYgvdHYNCA==
X-Google-Smtp-Source: AGHT+IECObCjBC1Gx71Ul7SlexRt8RMp9HMCWyDMZeAgaOWRLxuItpHqqG0Vs1EwsrRrQaMmFsEAvg==
X-Received: by 2002:a05:600c:1c93:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-46e329bd24amr173160135e9.13.1759235868804;
        Tue, 30 Sep 2025 05:37:48 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb8811946sm22459235f8f.18.2025.09.30.05.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:37:48 -0700 (PDT)
Message-ID: <325bcbb1f36ffa68c48423a623ca2815ad0ab3d3.camel@gmail.com>
Subject: Re: [PATCH v2 6/6] iio: adc: ad4080: add support for AD4081
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 30 Sep 2025 13:38:17 +0100
In-Reply-To: <20250930103229.28696-6-antoniu.miclaus@analog.com>
References: <20250930103229.28696-1-antoniu.miclaus@analog.com>
	 <20250930103229.28696-6-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 10:32 +0000, Antoniu Miclaus wrote:
> Add support for AD4081 20-bit SAR ADC. The AD4081 has the same
> resolution as AD4080 (20-bit) but differs in LVDS CNV clock count
> maximum (2 vs 7).
>=20
> Changes:
> - Add AD4081_CHIP_ID definition (0x0051)
> - Create ad4081_channel with 20-bit resolution and 32-bit storage
> - Add ad4081_chip_info with lvds_cnv_clk_cnt_max =3D 2
> - Register AD4081 in device ID and OF match tables
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> no changes in v2.
> =C2=A0drivers/iio/adc/ad4080.c | 15 +++++++++++++++
> =C2=A01 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index a68d7fa9f977..0dcbf175523c 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -126,6 +126,7 @@
> =C2=A0/* Miscellaneous Definitions */
> =C2=A0#define
> AD4080_SPI_READ						BIT(7)
> =C2=A0#define AD4080_CHIP_ID						0x0050
> +#define AD4081_CHIP_ID						0x0051
> =C2=A0#define AD4084_CHIP_ID						0x0054
> =C2=A0
> =C2=A0#define AD4080_LVDS_CNV_CLK_CNT_MAX				7
> @@ -436,6 +437,8 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[=
] =3D {
> =C2=A0
> =C2=A0static const struct iio_chan_spec ad4080_channel =3D AD4080_CHANNEL=
_DEFINE(20,
> 32);
> =C2=A0
> +static const struct iio_chan_spec ad4081_channel =3D AD4080_CHANNEL_DEFI=
NE(20,
> 32);
> +
> =C2=A0static const struct iio_chan_spec ad4084_channel =3D AD4080_CHANNEL=
_DEFINE(16,
> 16);
> =C2=A0
> =C2=A0static const struct ad4080_chip_info ad4080_chip_info =3D {
> @@ -448,6 +451,16 @@ static const struct ad4080_chip_info ad4080_chip_inf=
o =3D {
> =C2=A0	.lvds_cnv_clk_cnt_max =3D AD4080_LVDS_CNV_CLK_CNT_MAX,
> =C2=A0};
> =C2=A0
> +static const struct ad4080_chip_info ad4081_chip_info =3D {
> +	.name =3D "ad4081",
> +	.product_id =3D AD4081_CHIP_ID,
> +	.scale_table =3D ad4080_scale_table,
> +	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),
> +	.num_channels =3D 1,
> +	.channels =3D &ad4081_channel,
> +	.lvds_cnv_clk_cnt_max =3D 2,
> +};
> +
> =C2=A0static const struct ad4080_chip_info ad4084_chip_info =3D {
> =C2=A0	.name =3D "ad4084",
> =C2=A0	.product_id =3D AD4084_CHIP_ID,
> @@ -611,6 +624,7 @@ static int ad4080_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0static const struct spi_device_id ad4080_id[] =3D {
> =C2=A0	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
> +	{ "ad4081", (kernel_ulong_t)&ad4081_chip_info },
> =C2=A0	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
> =C2=A0	{ }
> =C2=A0};
> @@ -618,6 +632,7 @@ MODULE_DEVICE_TABLE(spi, ad4080_id);
> =C2=A0
> =C2=A0static const struct of_device_id ad4080_of_match[] =3D {
> =C2=A0	{ .compatible =3D "adi,ad4080", &ad4080_chip_info },
> +	{ .compatible =3D "adi,ad4081", &ad4081_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad4084", &ad4084_chip_info },
> =C2=A0	{ }
> =C2=A0};

