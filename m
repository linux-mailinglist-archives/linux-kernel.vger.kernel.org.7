Return-Path: <linux-kernel+bounces-813185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DB7B541BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249341B273E5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D35119D8A3;
	Fri, 12 Sep 2025 04:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X92hgrNR"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3441146588
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757652380; cv=none; b=QhoOQa9DvFLCSuLSxjnM523EeJziix8++1shCSHypD/Gk9qXCV9ev05/wvkqVq2Bl51VPpqjUh5eFC0nXJ3lCMZOwXxMxdNvc750tL1hAsOGeZWnOLt6mzF58y2dDvCpolBeNVGQ3r1idQFUZpk1/4v8kUxqQQU64JL0ZEIUQUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757652380; c=relaxed/simple;
	bh=TpUNMHEqmkCZSGnRTVB1Ed/+IAY3EQrOacZve65hZyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqgjUKbqNTLSvtAPE7cwkTIbPRCErsBHmYJTLhkYo/iFeg1IcTtDOM75VhCjmk756y+KtZPBMeVoiPLXzjUxs1115aqSxhewnV7u0pT5PrKU+mOrKyv8mW2XnnkSbbQXGFxhPOWCbQZ3NDGzl1TrdD3+48f0wlQ/1oGNCoKWzWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X92hgrNR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b02c719a117so253438766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757652377; x=1758257177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPyIFFvWJ2Fqxf0usnACNYTRuGONj4aV/5x3K8yq/0Y=;
        b=X92hgrNRbUMCE4ViUGEmvMyOEWyXx+uX6KZwziGn/b39YdgGHZj/unIyPnBOJV7RuJ
         8bzv/4AIdWDymcqMcXqbGeudzOWET75GGmBjFeGpxovodWy6ngpWWdiWkGFYKxx5j5H4
         iUjYV3E5fkJaefDFF0JXnp38Cv1z1FmqeRp8qmlRKczdh6Za2WFBS+8m71WgHCJGYA7j
         xzGZvsATllar07JVbPTFubG71oVPSmHM8VvOVxM5EFeJBYGOBe7j+JcunL4zQmSgj9Fw
         eaR8jKowCyNFR+duJ7WfSPeVKaBvsJLCeNWsyxkgGM+4V8KOhhyYpQvudRtwvsEiKW6R
         qSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757652377; x=1758257177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPyIFFvWJ2Fqxf0usnACNYTRuGONj4aV/5x3K8yq/0Y=;
        b=I2j0hcu1WFgMh1UUIo84pDNfLqFH1gZDjJgWSEm6jnJxe2yl4z33aM36StLUdocYom
         r4W+SHjO2yHNr87OB2fFDflkJO47SgqWzPnAT0xYwQ+3bWt5vKGSiEV7FR+0AdSwwquC
         7MzJKy3Ra8nLAxYl2qDAGgxxVI/WhaYOmbXtbUB53h6lJd6oJk8AGJQUNBNSHxM1RvBM
         9xqgl1eJ2SyRyiu8hKlWCq1F35AlaWg77+9MA1qjVSjxM7KhHlRDxQeY/7cduiuclVOO
         cq2j/4rttNXVCReVXPP5B59LUUXuR4tcSjjZXsdYnvKrfnRX0IhSQnhXeqKIAtt3+xMp
         zY+w==
X-Forwarded-Encrypted: i=1; AJvYcCWkM7k+z9xd52xLe/9P2KmYkeQnAUObGD23nIgsrGuQ6IKvOXogy7vMR49i71pdM8n+JsrJa7ZRK30HnAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrIBsURu5e2zsaIHduLQwitQdfZLG5bBdgIzWpH/d+zvGOiGJy
	yVE6gwY0ggu+pQODxn4v5qqylmIk40kMzgJYQpAP6YZOD6Kcl0tK7n7KNioPEJieHfC61r3NbPr
	PoGCcWh4RYwanwtFiyhgAsX4z3393T6M=
X-Gm-Gg: ASbGncsU6M/+JSYgcWaNqB3g1Xdto45gC5dF/vji3WimjRI44dN6Da4IVWBS9V3q+GD
	zMHYA5p8B36KQFhAzr95c1QzaEkbCTW1SjBXrN7YoKW8JLJW6AQ9EpZYYlzIl6RKcdzWlGElbIn
	7vqhxGLVoSHVgYByoTDXbOBuf4VOqijVoEUWAA7lvU1IGipjO1LTBqGApZiExxtZD0vbHjVb4Cr
	i9tzgX/1cvYTAVZFg==
X-Google-Smtp-Source: AGHT+IGrjZ4Yal+gsevWhgCEpcnrtzJz9j54FSUPVtZ49Qh1nxgsRYE/+aTevgym4aFnuwf0J3Dt95GMvslt3Ecgfos=
X-Received: by 2002:a17:907:7faa:b0:b04:74d1:a57c with SMTP id
 a640c23a62f3a-b07c3a76750mr146310366b.58.1757652376991; Thu, 11 Sep 2025
 21:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
 <20250911-iio-adc-ad7124-add-filter-support-v2-4-b09f492416c7@baylibre.com>
In-Reply-To: <20250911-iio-adc-ad7124-add-filter-support-v2-4-b09f492416c7@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 12 Sep 2025 07:45:40 +0300
X-Gm-Features: Ac12FXzDMR8_bGyEoyQ1qf9m-hGEeoE7KKekcW58wgWXbu-hWTBEx_d3jGIfl9o
Message-ID: <CAHp75VdMSr400YokZfv8SAkt-M8kuw7gt4+eCBb68xt7ipKJbQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] iio: adc: ad7124: support fractional sampling_frequency
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:42=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Modify the attribute read/write functions for sampling_frequency and
> filter_low_pass_3db_frequency to return fractional values.
>
> These ADCs support output data rates in the single digits, so being
> able to specify fractional values is necessary to use all possible
> sampling frequencies.

...

>         factor =3D 32 * 4; /* N =3D 4 for default sinc4 filter. */
> -       odr_sel_bits =3D clamp(DIV_ROUND_CLOSEST(fclk, odr * factor), 1, =
2047);
> +       odr_sel_bits =3D DIV_ROUND_CLOSEST(fclk, odr * factor +
> +                                              odr_micro * factor / MICRO=
);

> +       odr_sel_bits =3D clamp(odr_sel_bits, 1, 2047);

I would rather see this clamp() call to be the part of
cfg.odr_sel_bits() assignment, otherwise the above line and this
operate on the semantically (slightly) different data. So, the first
line should use different variable name, or the second, like
odr_sel_bits_clamped.

>         if (odr_sel_bits !=3D st->channels[channel].cfg.odr_sel_bits)
>                 st->channels[channel].cfg.live =3D false;
>
> -       /* fADC =3D fCLK / (FS[10:0] x 32) */
> -       st->channels[channel].cfg.odr =3D DIV_ROUND_CLOSEST(fclk, odr_sel=
_bits *
> -                                                               factor);
>         st->channels[channel].cfg.odr_sel_bits =3D odr_sel_bits;


--=20
With Best Regards,
Andy Shevchenko

