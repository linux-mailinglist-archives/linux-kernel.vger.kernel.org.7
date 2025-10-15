Return-Path: <linux-kernel+bounces-854216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE72BDDD77
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E395189947D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78823195E1;
	Wed, 15 Oct 2025 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK5BYRWq"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE89280331
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521572; cv=none; b=MED6MuZ5jWC4ewX4hZtxdqn9yppZz0Zdhv1Fcq3dJWadZzwdKCFPAigOiQHpDg8Q6lWfdRblpxSUja4+so+NDuMrzkrkTnlyBr13RmmPfLllzo0t2DJZrGwBnVB1HitacKSq1rrTuALh861Pvm6071YreQO4MumwAoY5xm4swWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521572; c=relaxed/simple;
	bh=FJ9b6EPmGD3cOsuVIr/WCne1YCspRvoK6wQb8QulFgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1OlOxP1Qlkbo8BihzvBxj496L4ZH8D+6HUkOOqUPjWtV7yx49YH6ZOnXQkL1gLwy8IAxBI7JUXySf9MUmY/D15E6Dcwp3DJVhoFbjiZj8coW5ImWoa/JwaYRAPAGNJwOlpRcQZ+pzFJBg/2gD7D9N5m2EkAhOK93T6bM0C37ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK5BYRWq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3b27b50090so1172064966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760521568; x=1761126368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfFEPTq2Vdeuv7Ta08hrglqY+S6ExVm1EPz0GEFlrjI=;
        b=kK5BYRWqW7zUtpPjSxxdxUD4r1WFYhxrehFYuVtSgFwdnO112tiwOIiDnz0cSgJI1Z
         91uPN9rTuH1NQYwpP7kus48LAqfwh7JG/DMWTYfb0x8aa1anysQDmiGee8duWBLwYLaF
         A9+KhtIIFlPhXDPc9qFeJmCo7Z+ySlUL/TRCbfAjib8HbcGK2EG5WzzHWLvaoU2cDcmH
         HApC1NvDSWm1nCTlpnW+eXV7DBO+wB8irRPw5U9Pxi/VpH8UOBx4zuJqxiDZv4AXNcun
         kDJCAhz3s15ONGquzbS5R2wTR3Zboka2zRehViW6r5KbD9fp98MHLtx85EpEPgzOs+gX
         j0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760521568; x=1761126368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfFEPTq2Vdeuv7Ta08hrglqY+S6ExVm1EPz0GEFlrjI=;
        b=CN7lKSpm0G/8ZQO4uG5+0Aufr7yE+xxrBHCKR7JWzRXeUC8oSqyPTtsqFxPsVYAg8h
         K/oWiPUDrIoej4Y6kOE3zvgYu1ry02H0m3g6BB920dXv4jxZ/4pw8k0DA9B1mslqm1nd
         JYgBoIQS87ZjolAW/OM0/KJtEFAVrLWZuIQMK6yxDSinlmJrH2bQW+VrDYraxCK2Ue62
         Wmr/74/E7rd1cFjsSjTTSB4jYsvswXsGsYmnW/3x0NzSUTwSDzLMUzUXNMRhtcm3VOtV
         REu0CdPUxUZJgI4dP8x3cVPvWVoRgzXnopnUyGcxEnQSB1lATIcDtatvAC2nSxKM+m68
         9XXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4f68EcI51CJUez2AXuLtilnAOEOWlDNIIBCt04w3FJZR7MvgWywB+yw5NSXuH+Fg7k/1YfWZPnpP4v2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KJY0GcRoyA+iYoqRASD6/O4jjm+ou46NV2U0EcTsUlReKv5+
	fyhwq4kh/UH+LFnKjKx0rK+bkrkLtX88UqvVD7pf31xqtJPb2+m5BnpI4iNKyT1U1tJsUIeleZ4
	9q2K4LXuTRUPyrgq0IXsUPFyCLSAz+9g=
X-Gm-Gg: ASbGncttSyRp5yoFiGbwSnXF/MT4u6nIgQl71+zpa5pUJ5d++T3VEYIQOaOnHyIzZtH
	Ihj+6P1eqfG0X40KMtm2ctKxLik6GUrPAgxT+zrjzKvOgdrL9moAq3+CvlDC7gfPmjtwXQDqP2G
	7NpxoZ74A8zR9iI9jJ2m2yHrI8CgCeyeyy3qWTst9l9VVTSKVRrwcki4iYWEDysoSMvr8wp1VZ0
	HGetrRUXaCOWSVn0O3Y6rhAe7g=
X-Google-Smtp-Source: AGHT+IEw4syRa7FfRkrqQf0uXseSwjNsjR/QJa3wjJevfESUoOmATV6wp3HQfHlHdESQNLGWxsQOlsKdYrPFGrsO4ws=
X-Received: by 2002:a17:907:3d89:b0:b3e:f89e:9840 with SMTP id
 a640c23a62f3a-b50aa9a1e57mr2981809066b.20.1760521568270; Wed, 15 Oct 2025
 02:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-hdc3020-units-fix-v3-0-b21fab32b882@liebherr.com> <20251013-hdc3020-units-fix-v3-2-b21fab32b882@liebherr.com>
In-Reply-To: <20251013-hdc3020-units-fix-v3-2-b21fab32b882@liebherr.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 15 Oct 2025 12:45:31 +0300
X-Gm-Features: AS18NWD8gTpf8qpn8f36NT70XyYbafSfwoUfsKLJpd0uQv-ZRKyeCqUmBO8GLHc
Message-ID: <CAHp75Vd6g_Nw0U_4NXEQZvLBCP49mXDrmxFj8yYqR7kW7festw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: humditiy: hdc3020: fix units for thresholds
 and hysteresis
To: dimitri.fedrau@liebherr.com
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Li peiyu <579lpy@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chris Lesiak <chris.lesiak@licorbio.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 11:12=E2=80=AFAM Dimitri Fedrau via B4 Relay
<devnull+dimitri.fedrau.liebherr.com@kernel.org> wrote:
>
> According to the ABI the units after application of scale and offset are
> milli degree celsius for temperature thresholds and milli percent for
> relative humidity thresholds. Currently the resulting units are degree
> celsius for temperature thresholds and hysteresis and percent for relativ=
e
> humidity thresholds and hysteresis. Change scale factor to fix this issue=
.

...


> -       return -2949075 + (175 * temp);
> +       return -589815 + (35 * temp);

I was under the impression that we agreed on the explicit division by 5.

  return -2949075 / 5 + (175 / 5 * temp);

...

> -       return hum * 100;
> +       return hum * 20;

And in a similar way here.


>                         s_clr =3D max(s_clr, HDC3020_MIN_TEMP_MICRO);
>                         s_clr =3D min(s_clr, HDC3020_MAX_TEMP_MICRO);
> @@ -565,7 +574,8 @@ static int hdc3020_write_thresh(struct iio_dev *indio=
_dev,
>                         /* Calculate old hysteresis */
>                         s_thresh =3D (s64)hdc3020_thresh_get_hum(thresh) =
* 1000000;
>                         s_clr =3D (s64)hdc3020_thresh_get_hum(clr) * 1000=
000;
> -                       s_hyst =3D div_s64(abs(s_thresh - s_clr), 65535);
> +                       s_hyst =3D div_s64(abs(s_thresh - s_clr),
> +                                        HDC3020_THRESH_FRACTION);
>                         /* Set new threshold */
>                         thresh =3D reg_val;
>                         /* Try to set old hysteresis */
> @@ -574,15 +584,16 @@ static int hdc3020_write_thresh(struct iio_dev *ind=
io_dev,
>                 case IIO_EV_INFO_HYSTERESIS:
>                         /*
>                          * Function hdc3020_thresh_get_hum returns relati=
ve
> -                        * humidity in percent scaled by 65535. Scale by =
1000000
> -                        * to be able to subtract scaled hysteresis value=
.
> +                        * humidity in percent scaled by HDC3020_THRESH_F=
RACTION.
> +                        * Scale by 1000000 to be able to subtract scaled
> +                        * hysteresis value.
>                          */
>                         s_thresh =3D (s64)hdc3020_thresh_get_hum(thresh) =
* 1000000;
>                         /*
> -                        * Units of s_val are in micro percent, scale by =
65535
> -                        * to get same units as s_thresh.
> +                        * Units of s_val are in micro percent, scale by
> +                        * HDC3020_THRESH_FRACTION to get same units as s=
_thresh.
>                          */
> -                       s_hyst =3D (s64)s_val * 65535;
> +                       s_hyst =3D (s64)s_val * HDC3020_THRESH_FRACTION;
>                         s_clr =3D hdc3020_thresh_clr(s_thresh, s_hyst, di=
r);
>                         s_clr =3D max(s_clr, 0);
>                         s_clr =3D min(s_clr, HDC3020_MAX_HUM_MICRO);
> @@ -630,7 +641,7 @@ static int hdc3020_read_thresh(struct iio_dev *indio_=
dev,
>                 thresh =3D hdc3020_thresh_get_temp(ret);
>                 switch (info) {
>                 case IIO_EV_INFO_VALUE:
> -                       *val =3D thresh;
> +                       *val =3D thresh * MILLI;
>                         break;
>                 case IIO_EV_INFO_HYSTERESIS:
>                         ret =3D hdc3020_read_be16(data, reg_clr);
> @@ -638,18 +649,18 @@ static int hdc3020_read_thresh(struct iio_dev *indi=
o_dev,
>                                 return ret;
>
>                         clr =3D hdc3020_thresh_get_temp(ret);
> -                       *val =3D abs(thresh - clr);
> +                       *val =3D abs(thresh - clr) * MILLI;
>                         break;
>                 default:
>                         return -EOPNOTSUPP;
>                 }
> -               *val2 =3D 65535;
> +               *val2 =3D HDC3020_THRESH_FRACTION;
>                 return IIO_VAL_FRACTIONAL;
>         case IIO_HUMIDITYRELATIVE:
>                 thresh =3D hdc3020_thresh_get_hum(ret);
>                 switch (info) {
>                 case IIO_EV_INFO_VALUE:
> -                       *val =3D thresh;
> +                       *val =3D thresh * MILLI;
>                         break;
>                 case IIO_EV_INFO_HYSTERESIS:
>                         ret =3D hdc3020_read_be16(data, reg_clr);
> @@ -657,12 +668,12 @@ static int hdc3020_read_thresh(struct iio_dev *indi=
o_dev,
>                                 return ret;
>
>                         clr =3D hdc3020_thresh_get_hum(ret);
> -                       *val =3D abs(thresh - clr);
> +                       *val =3D abs(thresh - clr) * MILLI;
>                         break;
>                 default:
>                         return -EOPNOTSUPP;
>                 }
> -               *val2 =3D 65535;
> +               *val2 =3D HDC3020_THRESH_FRACTION;
>                 return IIO_VAL_FRACTIONAL;
>         default:
>                 return -EOPNOTSUPP;
>
> --
> 2.39.5
>
>


--
With Best Regards,
Andy Shevchenko

