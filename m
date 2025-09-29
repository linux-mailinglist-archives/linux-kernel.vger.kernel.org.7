Return-Path: <linux-kernel+bounces-836475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36037BA9CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 882227A2D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F00330BBA7;
	Mon, 29 Sep 2025 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BHmZ0Xcg"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E752D3A94
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759159620; cv=none; b=LhIOnEpTWAYZ8iB8EAqgiuECnc3//p71YgJnJuQF407ykHcpuuySbjSlMYYTGo6hrn9EeEq0lnoq77+rACJ7pIQFhm76k3sMqhxiofWtP0aQqYsGTn7QDOqC2f3ndiziOn5Keh8bneJnawdSZ7+fq8mwf141A3MiwidMKHjPfaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759159620; c=relaxed/simple;
	bh=0VERunjZgrSaVxQvZYE9FtNitlxvBFrHYsth39nMrvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HY1aq9rwPqGrfSOrhfplqe8eO0bimI10mZ5uV41WP/9uP28uCO6dlKgHk8VLJ93xL48sjp4RzyXk3LZGpJOTGbuPypvJW0eSiE5nHqEo4UvPPTMBJUclQiErErjEpAbPxrfZQN5AAwhuNlmnktNDXyVmUsibckgcqv/crodyE0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BHmZ0Xcg; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-366ce79fbeeso43559601fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759159615; x=1759764415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lD/ZRIRPRoD4eeilEpQ/Ax8KbRLZBttE2gusXUBy/7U=;
        b=BHmZ0XcgOc/zM78FNki4dfgvA4saCKiexxHZqR0yZqfrczLkKG+0JMCPY7wqdUSBaX
         XLJAHE0+jrfh6+SG/hMvPdgx+rQ5APy6N6hICfu3d8Orc3e+W+S6tockt3Xd8CAqHVIl
         tGwaBAarErFRA/PBs0SjlGQNjl/lcuvwtAEjVfpX7lq6nZKzGI2HiqJEs8igV++cpwk+
         jrmWhIWGvcRf96iwoK0M+JzTsW2fPI0j7Gofc6MYq/V6vffg90z5RLzh1gNgIAJ6JDAg
         AsjtX50orArMXNFQeFivMUWvARYDXA1hh7swhRm9cVhnfpvIY1EOTKSEcnCgnDiCj2n/
         HFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759159615; x=1759764415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lD/ZRIRPRoD4eeilEpQ/Ax8KbRLZBttE2gusXUBy/7U=;
        b=wpFa1lJRQWYek+Q3xWvK5APiWwxv5zEEyV4exA9OEkuWhhV0Hf+L4AoKrBrbcPrCmQ
         bBplWfbdFhvkeB2HNK9aC7mXWCnPz3T7dACuY4dinrATCC167ZqlCrt2Cw3efjqHfcLn
         HdR4U3ImX1wX7+Wl2+kgbq+gUaH8NwXFIMCBH3aZ25lgM8QDa6Pgr7ChO1JfX0w+N4xg
         ZtHCt3Gi9IHmBDmvcD5fAbSUsE8slS3VO+KUrXdE1si60PF7vrxPa6AGCzoGzDGCuwnP
         NShfZE0B6R6hHcumcIQbvmsyT7B+k9RD/paFrEwKtf9sJ5sscUe4SDp4vkiT7tFsqim3
         Uh9A==
X-Forwarded-Encrypted: i=1; AJvYcCUy4UxqYVldFO2qXJGsAxArWyMjkD7rYf9sc6lqslyKcOWoUKPZq+z3wk6wBm1Ciapnk7cmLGihLt2vthM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC5S7olcpk+FtsD21x4LyTcfmmP2SVX7qgMYvFF3h32T6WK7mV
	m1aJ8HW5bDXnennGJXg2biRD1IA7jjwXS8QM6gpgPQQEziq8PaQ8IoFKpQKfv0W1Jf2ehfh7Yzs
	UdGbg4QEf/OLWnCcZNb+KusxpGQimDs8FLUcYEHuyLw==
X-Gm-Gg: ASbGnctuwrlMRPmHFgcfj8upyJY0m+Rvp0N9xTsUqM8aJuIo/6d+GTqlj+kFqhtmxMY
	oLiRVE+LpnClIfBWEn6HSKaBw0Q1e2lwMlJ6D8JrZ/oatkBfSqSBRGnNcU2va91FGwBsSJK1iJZ
	VNMtyoiXeOMWX40f2393o97i8Ny/3lkkQB+5oSWtY3KtOR6iEy+nYNNDy6QMVDVvdiwq0wwXZUi
	UdCa2weAr51vy+4Iw==
X-Google-Smtp-Source: AGHT+IEtN2lUKLnGoQ7WbW57ONBR/QKmzEKKycsDkK+DioqKXixXXuBeSvK0yyrJ+ATSRroRyWJm9ggSxHWFJcUI9/Y=
X-Received: by 2002:a05:651c:25d3:10b0:372:950f:2ae2 with SMTP id
 38308e7fff4ca-372950f3057mr14578111fa.5.1759159615153; Mon, 29 Sep 2025
 08:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929025358.2064-1-vulab@iscas.ac.cn>
In-Reply-To: <20250929025358.2064-1-vulab@iscas.ac.cn>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 29 Sep 2025 17:26:44 +0200
X-Gm-Features: AS18NWC2Vrzn89dFO6i3Pc5PcwsDZZtJqDcKNUIw8w9lRMGluo4z28T9Y4iCLNQ
Message-ID: <CAMknhBFm1HPKv6bPnYALc_=wGBHWB3SKnWmnBZ82Pan9z9TPVw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: mt6360: Handle error in cleanup path correctly
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It looks like you missed the IIO mailing list in the CC, so this might
not show up in Jonathan's queue.

On Mon, Sep 29, 2025 at 4:54=E2=80=AFAM Haotian Zhang <vulab@iscas.ac.cn> w=
rote:
>
> The return value of a regmap_raw_write() in the cleanup path was
> being ignored.
>
> Fix this by checking the return value and propagating the error.
>
> Fixes: 1f4877218f7e ("iio: adc: mt6360: Add ADC driver for MT6360")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/iio/adc/mt6360-adc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
> index 69b3569c90e5..97c4af8a93fc 100644
> --- a/drivers/iio/adc/mt6360-adc.c
> +++ b/drivers/iio/adc/mt6360-adc.c
> @@ -70,6 +70,7 @@ static int mt6360_adc_read_channel(struct mt6360_adc_da=
ta *mad, int channel, int
>         ktime_t predict_end_t, timeout;
>         unsigned int pre_wait_time;
>         int ret;
> +       int cleanup_ret;
>
>         mutex_lock(&mad->adc_lock);
>
> @@ -130,11 +131,15 @@ static int mt6360_adc_read_channel(struct mt6360_ad=
c_data *mad, int channel, int
>  out_adc_conv:
>         /* Only keep ADC enable */
>         adc_enable =3D cpu_to_be16(MT6360_ADCEN_MASK);
> -       regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, &adc_enable, =
sizeof(adc_enable));
> +       cleanup_ret =3D regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCF=
G,
> +                               &adc_enable, sizeof(adc_enable));
> +       if (ret >=3D 0)
> +               ret =3D cleanup_ret;

This overwrites the original return error, which is IIO_VAL_INT on
success or an error code. In either case, changing the return value
will break things.

In cleanup paths, there really isn't anything we can do with return
values other than ignore them like we were already doing or log an
error message.

>         mad->last_off_timestamps[channel] =3D ktime_get();
>         /* Config prefer channel to NO_PREFER */
>         regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PRE=
FERCH_MASK,

The return value here is also being ignored. If we decide that we
should add error messages, then we should add one here as well.

>                            MT6360_NO_PREFER << MT6360_PREFERCH_SHFT);
> +
>  out_adc_lock:
>         mutex_unlock(&mad->adc_lock);
>
> --
> 2.50.1.windows.1
>

