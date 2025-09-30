Return-Path: <linux-kernel+bounces-837665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBB4BACDE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5372A3A7ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BE02FB625;
	Tue, 30 Sep 2025 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIuJDBGy"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABB934BA41
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235844; cv=none; b=CBzlymBNTTg2vCQ6JESMcfIIUw2HfJ/XOaHwNOPkxbNNuIMC4eO5eDO+CpnWRvJHUfTsscC+vJxLUxVcTZJVp+JcISOoItlNAJe05uZYDvHOgfQ+UG+aZnBPTBvSPSFpsSrFBdE4aPn6sAr7n2BoHBT0P5OTrNSyoPPbDkOF/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235844; c=relaxed/simple;
	bh=hU/KzLVkEmlUuRTcag5YTyK28/UdejOheaoxAd30pqg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nt1LLHnN8Lf49zRIGHCX/8yA2wq3pwOvGajcVXwrT90V0Epzt+LgpD9BctWhIfQ2iRJVrfn8Olm048A9UYzFoIhXfXlpB85nfWduxbBbyrVeQLgc/3P9stmH5cT8lG5KeSZp95R2aGF0G8X3P1MRdKIjs5WzpphdqDWPDhFYz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIuJDBGy; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7960d69f14bso31779356d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759235842; x=1759840642; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sqpa9GlvBUx0ux5OfJqrlwK23CiJE3UVGxxZzcBLZIk=;
        b=LIuJDBGyysP96YjMyImAD40n0QC6nnNPTwueJjydjP3hSraXg7U7kZg40OBicjitCa
         w2fOKKh90VpgTZhIrYAqwfb15F+2owhfi8nHKP6K+dTcV7VTtbTIheP8YDqsw8SIAQLT
         UZYEER+e7GcKFqUEcDHYU91167pXRcu5nBlkqTFbZlhvBOLiWeUMxTfWcL/lIQgw14xu
         3zO40majQ7yMO4jCoLZLp4scsSSTybX6sKu39Sm6LpJmtWlS9t8/I4gHHkBba7CwjJyr
         kTk1R/8RhyiYNlZUaWb+mkXajWHS2U1JsJAHpvpj45ll7U4VOILdxZ4pJ/rP3iVhvY4I
         HY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235842; x=1759840642;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sqpa9GlvBUx0ux5OfJqrlwK23CiJE3UVGxxZzcBLZIk=;
        b=Gc9E3eI/cFNGRQYFNqwWSN2K+Ux5xOw5n7JLNOUSUMyNhZZbUrQXSu09NcXBUyBnWO
         uyXjDKP6pwq7m6QI8n9hQSKR9+duYN2x+bTna14aJc6nJs+Gxzk1sWTKHCJta7W05TyG
         N7Fog3zr17K8YmhFifIa6Mte16qx7r27tPdq7INQwpYJ+2XATaIm4vljE1W+n71oyp33
         smbkCBnFbRF9MPeNINI9aipeuifGuMzQd2LR6oMoxahXgBn6yNviQmKxLhxrBqj2bSy1
         7qqimx7nEZzuDFIbaBLgfila+J/b7GWU179nAMWMagnitlSHInyzhJXtq4UnhdJ1mJs+
         wC8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5cdDGyntyNlxuSVEdHcyZp6wF2Dp/eUGd31sfH7Cac6nzy4Y0fOPadovc9AsQI707c3sjyJsa20k7yds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8DKpnwB/INmO/diqk4bl+ZSgXXwsuNh+v9+wjibLZaf6/xXJP
	1tar8zQ5+bSVbX28x9cUtz4f5yf7z9DtYdsii0PP1DL5wfYyfVALyqe7
X-Gm-Gg: ASbGncvbpJP8QXC8Z/8vLAl4+POmTxHRF/xtpTxqr5gxAxyn8shdLZmNMLqKj6uhZmp
	CC04LcF/x8mX0653+y49JFKsrwrwQgdKtHrMCmItIGOle4e4RXE50mGQKWMJFD9k0MIkEzGwEjR
	9IMAOidK+kGELSMISoOy2BaoW7nurkfcnHH3gKj/Xj5ZGHnZglw/XCKx6pLtM5llusXu8x5DjrD
	9vNM3G9hQWwXFl0jahjZc4S6ft6+BomqkZdjOvt0Rz8Q8mqUnbpijDi1bEkGyC2BGpIPbPBxkBr
	y3RSSZKtCfQkfI/0+vARClEfyg8MRbOENli4ttGEGwvaGCVdWu1LDgxlmzxJvL6mivCIPZwSP8J
	CCp/P6P/tDtGyNN5gQsmYEJapEdpxInupAdODG5MpJwzPIC09oZjg1Ce0NDP0s/K0fQ==
X-Google-Smtp-Source: AGHT+IFf8Ujmddz9wnW3knoT77L/BwOAbC4cJJ4thEw7Ws2bZ/MuIegRBffbh8umm4/lPsVvwVM8Dw==
X-Received: by 2002:a05:6214:2aaa:b0:784:4f84:22f8 with SMTP id 6a1803df08f44-7fc2d330151mr308896346d6.21.1759235842055;
        Tue, 30 Sep 2025 05:37:22 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80136c84338sm93345146d6.10.2025.09.30.05.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:37:21 -0700 (PDT)
Message-ID: <22eb04cd1337f155c8c373db81d4e1a03380f395.camel@gmail.com>
Subject: Re: [PATCH v2 4/6] iio: adc: ad4080: add support for AD4084
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 30 Sep 2025 13:37:48 +0100
In-Reply-To: <20250930103229.28696-4-antoniu.miclaus@analog.com>
References: <20250930103229.28696-1-antoniu.miclaus@analog.com>
	 <20250930103229.28696-4-antoniu.miclaus@analog.com>
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
> Add support for AD4084 16-bit SAR ADC. The AD4084 differs from
> AD4080 in resolution (16-bit vs 20-bit) and LVDS CNV clock count
> maximum (2 vs 7).
>=20
> Changes:
> - Add AD4084_CHIP_ID definition (0x0054)
> - Create ad4084_channel with 16-bit resolution and storage
> - Add ad4084_chip_info with appropriate configuration
> - Register AD4084 in device ID and OF match tables
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> no changes in v2.
> =C2=A0drivers/iio/adc/ad4080.c | 15 +++++++++++++++
> =C2=A01 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index fa15b8f63b8a..a68d7fa9f977 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -126,6 +126,7 @@
> =C2=A0/* Miscellaneous Definitions */
> =C2=A0#define
> AD4080_SPI_READ						BIT(7)
> =C2=A0#define AD4080_CHIP_ID						0x0050
> +#define AD4084_CHIP_ID						0x0054
> =C2=A0
> =C2=A0#define AD4080_LVDS_CNV_CLK_CNT_MAX				7
> =C2=A0
> @@ -435,6 +436,8 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[=
] =3D {
> =C2=A0
> =C2=A0static const struct iio_chan_spec ad4080_channel =3D AD4080_CHANNEL=
_DEFINE(20,
> 32);
> =C2=A0
> +static const struct iio_chan_spec ad4084_channel =3D AD4080_CHANNEL_DEFI=
NE(16,
> 16);
> +
> =C2=A0static const struct ad4080_chip_info ad4080_chip_info =3D {
> =C2=A0	.name =3D "ad4080",
> =C2=A0	.product_id =3D AD4080_CHIP_ID,
> @@ -445,6 +448,16 @@ static const struct ad4080_chip_info ad4080_chip_inf=
o =3D {
> =C2=A0	.lvds_cnv_clk_cnt_max =3D AD4080_LVDS_CNV_CLK_CNT_MAX,
> =C2=A0};
> =C2=A0
> +static const struct ad4080_chip_info ad4084_chip_info =3D {
> +	.name =3D "ad4084",
> +	.product_id =3D AD4084_CHIP_ID,
> +	.scale_table =3D ad4080_scale_table,
> +	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),
> +	.num_channels =3D 1,
> +	.channels =3D &ad4084_channel,
> +	.lvds_cnv_clk_cnt_max =3D 2,
> +};
> +
> =C2=A0static int ad4080_setup(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0	struct ad4080_state *st =3D iio_priv(indio_dev);
> @@ -598,12 +611,14 @@ static int ad4080_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0static const struct spi_device_id ad4080_id[] =3D {
> =C2=A0	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
> +	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
> =C2=A0	{ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(spi, ad4080_id);
> =C2=A0
> =C2=A0static const struct of_device_id ad4080_of_match[] =3D {
> =C2=A0	{ .compatible =3D "adi,ad4080", &ad4080_chip_info },
> +	{ .compatible =3D "adi,ad4084", &ad4084_chip_info },
> =C2=A0	{ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, ad4080_of_match);

