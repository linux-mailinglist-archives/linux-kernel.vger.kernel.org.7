Return-Path: <linux-kernel+bounces-762003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C41B200F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3AD189CB3D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2156C2DA743;
	Mon, 11 Aug 2025 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YZ55BwUH"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE2E2D9EFA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899025; cv=none; b=nPWDUuuR4uvKi8i+E6GrbfmqkQrMM+xjn8IxLspFZUSMLnEWyOn6rlLKR1F2K+mX5kWrThZbFT0k6URxtqDkT6RZUugWz7mOjUxZQmu6IYpvF97QVQsoZTzwUG0axCyMEtLyX8usodzgwvDDi/azsuy9zEpimMv1Awg1HqQbfLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899025; c=relaxed/simple;
	bh=CJFtm8aT05kS0Usnv5/NsR4DQOUjZUTFcSM8jpLribs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIeIiIn3swS3jZPV4hGcpyB6GAE5hklS4w+cqXEmi8j/X5ABfHclp/wzGL05WLxF5tOZC+dDgOVmzpU8MavcHO4AGV/zn9gYUt1K9TCcFOxrrlSu1NOIvQC+LhP4ZQA14eiiEJcJo+n3kCWCWO9hHf9iaVwRJNlrV9Gk7mSbJjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YZ55BwUH; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55b7454c6b0so4440838e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754899022; x=1755503822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjTF7RqO10ef3txtnjHxWOV2j8hirOXEUm2/myrJmDs=;
        b=YZ55BwUH0Cqn/mp0E7yMgcQluURItIs3lId/s7O4dFI75EvDfH+6HS/PNA6PPasxYC
         eXBZ33Bzcz08b3SZgFXXMa0sjTCDo6TIKDe+QHK6uXCVXB/4+dPN5vFiZZJb9BhTn+GQ
         cWCcGohjzgS+wp8VNtu+M8dZtplIgbVqkz8MK+iq1HIZMn1SqK/zJbCRUdghecKwcxjx
         pG8by+bvHkWqN32R1WHMoJ5TIdbVKVZYbPHm9z0TOH+0/13G7Ik1gf4+VqDAXTLGnWtC
         EPSMv31OLp6g+WH5eT49haL56SRPJWh0cV9ywMutp1WMG1n+EJry9vFUEoWkfy+hSZV3
         DP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754899022; x=1755503822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjTF7RqO10ef3txtnjHxWOV2j8hirOXEUm2/myrJmDs=;
        b=ctyY92zzP3B5pNtBdnso9B30xbkOL6k/KzM/mZroAIeS9L00RFubnU52loCfXcdcAN
         iif+OiyTPbh/ItZFkKXibEwI4dTN7KwI4wqj/wB3W1WXGfuE9MsIWELVslGPxuHg0cOX
         L7ZxQ7ThHPRlpMYARZOcK0ptnCj/+FFrFDge5nyULIpfYz3UCbf7HwXsRCQYr3lbZ57T
         ZdW20ImK5mvuXq6/RdU4VTv/iOc/uYQhgFDT2LwhZAZQ9p1pSQAzpmFLKX9nMY7/POgX
         x3PM3j3YQaVGpqDvRVfodXa7kZUs5rEx2iVnxkKeh50i5b7Cip+byXOOf69sRQynGzLI
         lBvw==
X-Forwarded-Encrypted: i=1; AJvYcCVTzDto7IdoJbbpq8yHbzzNvhiiYpPRBg1dOy+04CnzPXUQXhizSJS2o7PEYqa3U/T8oeKg65W3Bi3e/Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgeTxcvFhCaK1Y+xwShoriNTrrdSkFBzDbryVkqLot0TJf+zP+
	o4mrUA3zOFViAZQDyYNqJRSj6dRpOht4wOyG5LkxqUpRkF6BCD3AmiChxfO/oJgsVfHUilO8Wix
	c6aPBYBuTDC8ohemPwiXL/dtOSyAfgmlD7+helssVJ+DZbAHwz7PU
X-Gm-Gg: ASbGncsdlaTaTonjPRwD/NUDgB/RinBIvpyQoPt/IS5pD/OFpDqhxlKnppbS4hu4qPt
	3F02H5g8Dr/OUpN0rnKLnQ3j659qaHAAw9O1I0umEdBRHWLeydgKnAeyLbfJkyShRHd31VsqWnI
	9LkTqIJpHfftZh6w4qdTWLZVcnXg/KK+HqGhY4ws8tHr3fbBkXo2Wvx5IOgbPDxxsDBdOpH7p58
	ipV+27gEy66TEj6rQ==
X-Google-Smtp-Source: AGHT+IGQH2i8Y/9oCUDP0jds1CiD8zyBoHENbFwp82iz6bSSxifol1LS2z2CYkeffycyRoSzVvzsx1jWGXTt8a00rMA=
X-Received: by 2002:a05:6512:3b8b:b0:55a:4e55:cb94 with SMTP id
 2adb3069b0e04-55cc008396fmr2749117e87.8.1754899022032; Mon, 11 Aug 2025
 00:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806091531.109861-1-stefano.manni@gmail.com>
In-Reply-To: <20250806091531.109861-1-stefano.manni@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 11 Aug 2025 09:56:51 +0200
X-Gm-Features: Ac12FXz3kEkcMo77ykPrhjTh-nDYN-A0dNNICBO0nUM7JygFn2C7N1TD3Y2NU9k
Message-ID: <CAMRc=MdfjuSSsD=LWDpUroyf+fxC7jQrJDtZJtmj_YiQYQjAuw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: pisosr: read ngpios as U32
To: Stefano Manni <stefano.manni@gmail.com>
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 9:17=E2=80=AFAM Stefano Manni <stefano.manni@gmail.c=
om> wrote:
>
> If of_property_read_u16() is used instead the value read
> is always zero.
>

Please state more clearly what the problem is. This sentence is quite garbl=
ed,

> Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
> ---
>  drivers/gpio/gpio-pisosr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
> index a69b74866a13..2dc1b1e021d2 100644
> --- a/drivers/gpio/gpio-pisosr.c
> +++ b/drivers/gpio/gpio-pisosr.c
> @@ -117,6 +117,7 @@ static int pisosr_gpio_probe(struct spi_device *spi)
>  {
>         struct device *dev =3D &spi->dev;
>         struct pisosr_gpio *gpio;
> +       unsigned int ngpio;
>         int ret;
>
>         gpio =3D devm_kzalloc(dev, sizeof(*gpio), GFP_KERNEL);
> @@ -125,8 +126,11 @@ static int pisosr_gpio_probe(struct spi_device *spi)
>
>         gpio->chip =3D template_chip;
>         gpio->chip.parent =3D dev;
> -       of_property_read_u16(dev->of_node, "ngpios", &gpio->chip.ngpio);
>
> +       if (of_property_read_u32(dev->of_node, "ngpios", &ngpio))
> +               ngpio =3D DEFAULT_NGPIO;
> +

If you're touching this, can you switch to using generic device
properties instead?

Bart

> +       gpio->chip.ngpio =3D ngpio;
>         gpio->spi =3D spi;
>
>         gpio->buffer_size =3D DIV_ROUND_UP(gpio->chip.ngpio, 8);
> --
> 2.48.1
>

