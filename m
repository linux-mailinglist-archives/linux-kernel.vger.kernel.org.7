Return-Path: <linux-kernel+bounces-856788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C270CBE5156
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C216583FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD88A239570;
	Thu, 16 Oct 2025 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb4DVjr4"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE3E262A6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640039; cv=none; b=nnDMbuT9//wV+Txn/rSh85Ea5ZMc6hBxKtl1/PP+VKWLTJHFP87P+/twXAKjI8rfFxFr+Z4Agyeh0BqF7kVLicIwHTw2TQdi1AP7vafSOOL7BY2oix0J9YsKJH0kG9oVKp8LYck47JeRpaeMdD5gk3O9Wrll2iNPpjnWngEhXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640039; c=relaxed/simple;
	bh=5QysmaokXLn3WO6Gp92GJ+wwsN+FNCg2fB1fyWLq7Tg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YP3k6Z6RtBowRKvDM4+d3yhPZocs2UZBHWv/ekG0HxayA0nfPq0NxhttUncn3McKj8SYCif8DIFX3SoRMityI9do7kRXB1UDLrFVHwX1Xy3JArjAOSSZ8lZGbXFeOQzjzsAS6ILGUz6oJHng7H0RF0CV8sZjWlagrsQcbgE9kKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb4DVjr4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-427060bc0f5so31596f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760640035; x=1761244835; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gVrVN0cURT8XxOWEND/toDNC6BEXYqhiqrr2ZmhC6Wg=;
        b=Kb4DVjr4P8bzQkdC6frJlmNGatQhd6iQxGC7D7VWMo1gddZHd8qoiB5WW9eAzT1A4N
         KjDaMdaWQt2diQJURY3BrxTJSVrIoG0lrlFu0Lg4/nfuIny800GFeOWoe6/0Ys/KxNRW
         RJTSKJwXMkmTOXBYqnn5BzLWomDqmOPdrwHUQoVS3n1FsScRSHRlxsrgCKjp/NARDV/P
         ozot9zUmZMMU7SwN5sQdej3O1YkcIKM9XAlC5mOs+22Rb8RZJDQd8NMC1hRxY6eqVsvC
         jwrwWRRMt1OgJoaHxvFN7sdL7pGPMfJCSwqcpdlAQyRQ6i9mG3ojDllxSUsEaUMJJY1R
         8MUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640035; x=1761244835;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVrVN0cURT8XxOWEND/toDNC6BEXYqhiqrr2ZmhC6Wg=;
        b=WvCdxiM5bxU08rslADcnhV78esVai2Fuvj/lQU6OYH2iE4pUJzpArDsymctoUeZPdJ
         0RH438QTAKxF/hzjwzoKyJXCp15Ps7ZaBIC85fxTrbBb+KCttbRc3vPPA+zL8W2TNTS8
         6xyZqfoidhVLpDYtjS6WOUaC4Fyl2RUKlRpr6V2FDX7m8wky6Yiu/2ICpGujdc/UKyW0
         1/IPK0ZXL9otWWW4k0A0/7oG1WvaC4Uqo8X5dYJBzmD4fDv7kA9R5zXyUPq3JPpuo6Ff
         mHmEGorSoqimXVvi8AArrM2Ww1UJH8Amjom2bggFxMhP06SJJN1PU7nhfPTcn/3wnDYY
         VR1A==
X-Forwarded-Encrypted: i=1; AJvYcCWFgMXl/IvgA7waaB0B7Z93WR/m3ySx1v8htptbdeBB4ty6cmo8KNarHpeR/k00sXpyuQRxabDwgKbNXOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6WSWrxXS3VH7eMZU/04ayLqUAEcOO/VvxHCOzX1XJ8lGRLzhn
	OaxfblK7kWkH9Ra361srKC86AHfNqoPZLC3ItQM4EzqkjwgD7WnsW3i6
X-Gm-Gg: ASbGncsfl2O0cHS6oO+YdOWqZ1rPIPqAQwiVqUkjBy4E4U8MnOoh9JIX0zxiBs2uaYL
	UFdEeUaYLnbEe3Ac+k25YWcbECUyvV8gsZN3MP8LyngnC76vSjJqDNGPnO+ZqOU7rwVEMxgJX3X
	fEvbz8uX6fBoiTuvlVuuSvcLdPOXmBNf7o0LoqNe9nibZJ44xAFaLLSclOlvGGcJgYZUY0xWjU8
	KQvlHOIRh2pUtUCe09nAZSecEKYz59NaKXhEwPBMC3doj5FA5Db23BTeus+TxLua+opef9e3y9X
	YuwCjVTj5YdU4mVzHMhQJCX+KAsoa0eMw1pFZTk5foGiN+KCDwjWqVcwHFJRQAuLAG9vGxspGfr
	gDiqbG6wIAgunOnagHJ3Cqine390OeX7QGYXFweUrUI8EyeldhzbKhLk43HjOgNEs7irL5HrHjc
	//1j+VhHaGgnL5kET1kKT2B1/1s3m4a7Cz5MIhPldlvuHq4FCsxVIJEk9c
X-Google-Smtp-Source: AGHT+IFtecOfZqgKKUQdQobTvSoWGjsWAXnz5FwPdqEhfoodXPkAZsFTaly51YsTEiMSfFcc5ooSyw==
X-Received: by 2002:a05:6000:4301:b0:3e5:47a9:1c7f with SMTP id ffacd0b85a97d-42704e043c1mr799792f8f.47.1760640035343;
        Thu, 16 Oct 2025 11:40:35 -0700 (PDT)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm35643266f8f.40.2025.10.16.11.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 11:40:34 -0700 (PDT)
Message-ID: <60fbaaef249e6f5af602fe4087eab31cd70905de.camel@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: cs4271: Fix cs4271 I2C and SPI drivers
 automatic module loading
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, David Rhodes	
 <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela	 <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Nikita Shubin	 <nikita.shubin@maquefel.me>,
 Axel Lin <axel.lin@ingics.com>, Brian Austin	 <brian.austin@cirrus.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni
	 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Date: Thu, 16 Oct 2025 20:40:34 +0200
In-Reply-To: <20251016130340.1442090-2-herve.codina@bootlin.com>
References: <20251016130340.1442090-1-herve.codina@bootlin.com>
	 <20251016130340.1442090-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Herve,

On Thu, 2025-10-16 at 15:03 +0200, Herve Codina wrote:
> In commit c973b8a7dc50 ("ASoC: cs4271: Split SPI and I2C code into
> different modules") the driver was slit into a core, an SPI and an I2C
> part.
>=20
> However, the MODULE_DEVICE_TABLE(of, cs4271_dt_ids) was in the core part
> and so, module loading based on module.alias (based on DT compatible
> string matching) loads the core part but not the SPI or I2C parts.
>=20
> In order to have the I2C or the SPI module loaded automatically, move
> the MODULE_DEVICE_TABLE(of, ...) the core to I2C and SPI parts.
> Also move cs4271_dt_ids itself from the core part to I2C and SPI parts
> as both the call to MODULE_DEVICE_TABLE(of, ...) and the cs4271_dt_ids
> table itself need to be in the same file.

I'm a bit confused by this change.
What do you have in SYSFS "uevent" entry for the real device?

If you consider spi_uevent() and i2c_device_uevent(), "MODALIAS=3D" in the
"uevent" should be prefixed with either "spi:" or "i2c:".
And this isn't what you adress in your patch.

You provide [identical] "of:" prefixed modalias to two different modules
(not sure, how this should work), but cs4271 is not an MMIO device,
so it should not generate an "of:" prefixed uevent.

Could you please show the relevant DT snippet for the affected HW?

> Fixes: c973b8a7dc50 ("ASoC: cs4271: Split SPI and I2C code into different=
 modules")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> =C2=A0sound/soc/codecs/cs4271-i2c.c | 6 ++++++
> =C2=A0sound/soc/codecs/cs4271-spi.c | 6 ++++++
> =C2=A0sound/soc/codecs/cs4271.c=C2=A0=C2=A0=C2=A0=C2=A0 | 9 ---------
> =C2=A0sound/soc/codecs/cs4271.h=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
> =C2=A04 files changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/sound/soc/codecs/cs4271-i2c.c b/sound/soc/codecs/cs4271-i2c.=
c
> index 1d210b969173..cefb8733fc61 100644
> --- a/sound/soc/codecs/cs4271-i2c.c
> +++ b/sound/soc/codecs/cs4271-i2c.c
> @@ -28,6 +28,12 @@ static const struct i2c_device_id cs4271_i2c_id[] =3D =
{
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(i2c, cs4271_i2c_id);
> =C2=A0
> +static const struct of_device_id cs4271_dt_ids[] =3D {
> +	{ .compatible =3D "cirrus,cs4271", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, cs4271_dt_ids);
> +
> =C2=A0static struct i2c_driver cs4271_i2c_driver =3D {
> =C2=A0	.driver =3D {
> =C2=A0		.name =3D "cs4271",
> diff --git a/sound/soc/codecs/cs4271-spi.c b/sound/soc/codecs/cs4271-spi.=
c
> index 4feb80436bd9..82abc654293c 100644
> --- a/sound/soc/codecs/cs4271-spi.c
> +++ b/sound/soc/codecs/cs4271-spi.c
> @@ -23,6 +23,12 @@ static int cs4271_spi_probe(struct spi_device *spi)
> =C2=A0	return cs4271_probe(&spi->dev, devm_regmap_init_spi(spi, &config))=
;
> =C2=A0}
> =C2=A0
> +static const struct of_device_id cs4271_dt_ids[] =3D {
> +	{ .compatible =3D "cirrus,cs4271", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, cs4271_dt_ids);
> +
> =C2=A0static struct spi_driver cs4271_spi_driver =3D {
> =C2=A0	.driver =3D {
> =C2=A0		.name	=3D "cs4271",
> diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
> index 6a3cca3d26c7..ff9c6628224c 100644
> --- a/sound/soc/codecs/cs4271.c
> +++ b/sound/soc/codecs/cs4271.c
> @@ -543,15 +543,6 @@ static int cs4271_soc_resume(struct snd_soc_componen=
t *component)
> =C2=A0#define cs4271_soc_resume	NULL
> =C2=A0#endif /* CONFIG_PM */
> =C2=A0
> -#ifdef CONFIG_OF
> -const struct of_device_id cs4271_dt_ids[] =3D {
> -	{ .compatible =3D "cirrus,cs4271", },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, cs4271_dt_ids);
> -EXPORT_SYMBOL_GPL(cs4271_dt_ids);
> -#endif
> -
> =C2=A0static int cs4271_component_probe(struct snd_soc_component *compone=
nt)
> =C2=A0{
> =C2=A0	struct cs4271_private *cs4271 =3D snd_soc_component_get_drvdata(co=
mponent);
> diff --git a/sound/soc/codecs/cs4271.h b/sound/soc/codecs/cs4271.h
> index 290283a9149e..4965ce085875 100644
> --- a/sound/soc/codecs/cs4271.h
> +++ b/sound/soc/codecs/cs4271.h
> @@ -4,7 +4,6 @@
> =C2=A0
> =C2=A0#include <linux/regmap.h>
> =C2=A0
> -extern const struct of_device_id cs4271_dt_ids[];
> =C2=A0extern const struct regmap_config cs4271_regmap_config;
> =C2=A0
> =C2=A0int cs4271_probe(struct device *dev, struct regmap *regmap);

--=20
Alexander Sverdlin.

