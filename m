Return-Path: <linux-kernel+bounces-845999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9639DBC6B08
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 851804E51FD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A082C0F7D;
	Wed,  8 Oct 2025 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoWzoiGV"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CA0247280
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958921; cv=none; b=ChtMcbXk4pDMQJrpB3lpDbHsJ0s7T2+QU8Mb5Kzzc3a83gSA9ugbe+NLXGbGRy9I/oLBS/tHhQ/9g6KtQ0L8Cn+jqACkcad/017O7cxRkBIoxqkjxkOAHRdBqIKDZF71w8FBktTx7NmbKnRg4imVvS1aLz3nwH15w+HfK9Wgbl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958921; c=relaxed/simple;
	bh=gGodYYFxH+jsG0qCHPc7o14Eo5hulEOlNs8Wy5REovw=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPCguG5Prtkm5Aq1FT/d5Zr3cyAVBjdCDAIXObx9/hXlMw6lQtPzWxp7odKgjEU9/0lWl0WtGjD0PoTbZqWMb+gzGGZEaxiYR4rHZeWh4LG6xn+Qlr7bHXQ+MvZd2cq7dwCJYIACQ2b5ZY1keG8x00kWqcujenHhdp6o2lh+Yz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoWzoiGV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b07d4d24d09so47544866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759958918; x=1760563718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:cc:to:subject:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyfpjLrqJ6QlUqbfp6rN6SLKr9bkjhkOub121iG/VYQ=;
        b=AoWzoiGVVJArE8tafnylllnbZMD0dw+/QYBPZt1oXvZG7scAcVETRf7WdIw75p/i61
         qkjFjK+XvnDR3+CdD2B//oSKShDVFCdC55KbHxgHaNkGBX9yMOwODj3INAt3NL6gJpn6
         j/f4wKDgwt5lPHV5Z7XtqOjRRbJAR48ohmH3TczezWF5GIRmUQ0BeuwKrNV8nv+4FSHw
         P9cqA0onpvz3Zf5q6uur5ScfBDh5EHwYbySS8ELAu1SniKEDV67bv2iJ+EeDC/Xip3IY
         o0+oV+rLXgii75ErqCgzGeIJ8gW+8/sfxVlCfVV29fqNmVFd2njrajR9JzaPPQAEt+pG
         gwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759958918; x=1760563718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:cc:to:subject:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyfpjLrqJ6QlUqbfp6rN6SLKr9bkjhkOub121iG/VYQ=;
        b=I1+OmeHSElotv4RxvtjfB+tyEOUFd7OvTWA2SAUfffsl/7g9bqgOicr8wQ8ewtAzok
         oAeMg+Jjcpx8bUDAnMpPusa9SU9IhoILIqF3mSGYLP2kBotu3zfHeR5tcemp6s8eouzV
         2dtKjycx1WI0k5iV/VKWeumyAAsJS+gsnra0Ljw8XxOtlMhFVa6d/J4ZS08dT7UJROiz
         OFD9icqIBFlS+eTcQXgb7MjusfVU7bmmhfn9QjdYhrfdz1ZJhimDFV74rbhU/m6SQ68q
         52JJ++++vAJPJ03U1KbcqedR92zS+rEbSQoPMR7dywHkfNO2TIDK4HGSis053MHMvaB2
         cteQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi1RuwAz9abG4M4BU0rEu2UqeXxG61ET1gNstEBsluhxeRj7XfxoHpnM0wc8KFYMDA/uBWQEhITHdmuAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHMSheP7ahuMAR/KPH7tWJzvWgNpOjlSRsU5uN2Woc9fOk8Ns7
	oPRjcPJ6h5m5iz4bul5flTXSJG3529HMXVHmQasQm9akTzbqop5RYrzaejER2w==
X-Gm-Gg: ASbGncsCwgE75CBq5sCOjyVDZALVqGb+UnJ7PtgIgnEiQzQ6D7em2lRIvtUjUZSNPHO
	gvLuucZlxmej2Gck307vIAcH6NLmy3AZIrDl/cYyiY8gYapyQoVf5L18BTTcc2cPqc/esgQRd26
	kkZunFT7VJ3OD8I09DmwYVVaKOeMq+ZmnHS1UTSxpPDU69iAxbYsPtTVZR1olQL7/iY95nHrDWE
	+4Qnqh96wM5RkQaD0XNkDSDOvLqgkz1V6h5k97Fym+bwbHY4yzCwSllQ0Gc/p/q4ItIcT3heaDJ
	uKLsVqB/66YT0WFkHVxWlLnZ402Hc2hYvrimloG822OwTy4BC7LcAs/LqD7aSRcReY7ez2pSjTo
	kZA7P6U5c/9vY/7k5JtwcF5WZ3jX/oyGj+7/DIfVYhZ9RbMrFsdMi7MA+yfQPdT1FT0nPaBuk43
	qwMiOFeTP65EANb+c=
X-Google-Smtp-Source: AGHT+IGIeYcw6vOkpm/HcxGOq7wg2RMmJZSrQWTRzVpWF5ez02FhM8tPERcmmJnce5WqEl3AqtrZdg==
X-Received: by 2002:a17:907:3f1c:b0:b3d:4ab4:ea2f with SMTP id a640c23a62f3a-b50aaa96b1amr639860166b.19.1759958918110;
        Wed, 08 Oct 2025 14:28:38 -0700 (PDT)
Received: from [192.168.1.186] (2-229-167-183.ip197.fastwebnet.it. [2.229.167.183])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm450116666b.48.2025.10.08.14.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:28:37 -0700 (PDT)
Date: Wed, 08 Oct 2025 23:28:31 +0200
From: Stefano Manni <stefano.manni@gmail.com>
Subject: Re: [PATCH v2] gpio: pisosr: read ngpios as U32
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-Id: <JZ0U3T.53FSIQ97H39F1@gmail.com>
In-Reply-To: <CAMRc=MdfjuSSsD=LWDpUroyf+fxC7jQrJDtZJtmj_YiQYQjAuw@mail.gmail.com>
References: <20250806091531.109861-1-stefano.manni@gmail.com>
	<CAMRc=MdfjuSSsD=LWDpUroyf+fxC7jQrJDtZJtmj_YiQYQjAuw@mail.gmail.com>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On lun, ago 11 2025 at 09:56:51 +02:00:00, Bartosz Golaszewski=20
<brgl@bgdev.pl> wrote:
> On Wed, Aug 6, 2025 at 9:17=E2=80=AFAM Stefano Manni=20
> <stefano.manni@gmail.com> wrote:
>>=20
>>  If of_property_read_u16() is used instead the value read
>>  is always zero.
>>=20
>=20
> Please state more clearly what the problem is. This sentence is quite=20
> garbled,


the value returned by of_property_read_u16() is always zero, if=20
of_property_read_u32()
is used instead , then the returned value is the right one contained in=20
the dts.


>=20
>>  Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
>>  ---
>>   drivers/gpio/gpio-pisosr.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>=20
>>  diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
>>  index a69b74866a13..2dc1b1e021d2 100644
>>  --- a/drivers/gpio/gpio-pisosr.c
>>  +++ b/drivers/gpio/gpio-pisosr.c
>>  @@ -117,6 +117,7 @@ static int pisosr_gpio_probe(struct spi_device=20
>> *spi)
>>   {
>>          struct device *dev =3D &spi->dev;
>>          struct pisosr_gpio *gpio;
>>  +       unsigned int ngpio;
>>          int ret;
>>=20
>>          gpio =3D devm_kzalloc(dev, sizeof(*gpio), GFP_KERNEL);
>>  @@ -125,8 +126,11 @@ static int pisosr_gpio_probe(struct spi_device=20
>> *spi)
>>=20
>>          gpio->chip =3D template_chip;
>>          gpio->chip.parent =3D dev;
>>  -       of_property_read_u16(dev->of_node, "ngpios",=20
>> &gpio->chip.ngpio);
>>=20
>>  +       if (of_property_read_u32(dev->of_node, "ngpios", &ngpio))
>>  +               ngpio =3D DEFAULT_NGPIO;
>>  +
>=20
> If you're touching this, can you switch to using generic device
> properties instead?
>=20

what do you mean with "generic device properties"?

Best,
Stefano
>>=20



