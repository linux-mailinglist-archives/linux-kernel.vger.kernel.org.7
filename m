Return-Path: <linux-kernel+bounces-780316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C63B30058
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E070605813
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B51D2E0418;
	Thu, 21 Aug 2025 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SfZORVhp"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1EB2DFA29
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794419; cv=none; b=ZL/Ub+ZBwZCmodlE33L9lSwhvNy2mS3Z+ePfPLmSE7/WYPz+eoMLojdZ1iChbkrugH2gARu/gWU+NXpQJbpKF70kzDZb+DvKVX56HUPifa5aTXrJujxa1FA4BL/f1o8nKPr02rjaxv8b6Ue3a4K521/rYlw2Q5JcZqQIT94jKk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794419; c=relaxed/simple;
	bh=bWToChmulvqXhXQ3tZmq2PQ/BsSS4AKAT1CG+kjy9kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V99bQTLU5/2bs2WrMa9zcozc4zO57wqMwD2IwTdHzodkuKS4HA9XFu0E0iO+bt7NCf43l+fqt/3V9qZOIL9xmtV/4DmmOEVW9qOWB5+9eCKeW9GbAEiEioFiMKeqrMCvblzm9nITzlaYW82QQlEuy+ciPxL4JaXNcRj3Zc0sXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SfZORVhp; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-333f917a67aso10144481fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755794415; x=1756399215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx1YB+H5vIBLE5Fa31BDROcSz+EhcXywiHr57dkWwUg=;
        b=SfZORVhpkjTW4oS8FKOVi2MZKA350JKg/njDau6dy7FMm+HXGas+4T6SSK42j3Dn/S
         DtJSmsB1TotEuJep4BE73zcvcAiW1uWb+CE9uOO9Nl3mOChDam0m8NsXSsdZUAKAwRP2
         yFto/p7JMNpBfAqa09uGAKKt15c2mgD6APHTsQbVYHkdTh+OT9CdETf7sKyWYbWGtjD6
         MLpzzSlB3zXQzwgcoWvB69AOgdAhSZxUHeV6Q8Gbp2OgKOiN8nhOrTA2jU07YVk/ppOm
         URBMpAQkizCEk63kY0b/ajbx0DzTmysLzxYMQZhwB7GzuZxikijOsgx61uqzmTWiOrT4
         zNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794415; x=1756399215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yx1YB+H5vIBLE5Fa31BDROcSz+EhcXywiHr57dkWwUg=;
        b=KB9g23Y1ZNtYaYXBxnEtcZatdKenKSYf/c+qP5NRJKuaJtuLid0lEIBQyfFB9XtUXa
         HkpXDbH5jB9YFjdeT9jGHTorSZS/LEUksv8GI212F76cPBmivW4uzrWse2fB9b025KfW
         Ij5ODu4gWDRjwOlO2bqRClyR8mXaV+M4aFi/0RRQG0pcuJZhEahPggpZFit4Cmnj8yeW
         K6Hgb0MeeLuma38/xh8adlsGZZ+c1E3gvVE6SakF/j82D4kJnarCzHIWqpWubvH5YeDd
         GQQQvBcmlsCKSbIwej0ZXWiiUj/eFA1umtDdsuCjhVWFQDeGij3MoATRFmpIusCMk5a3
         x5GQ==
X-Gm-Message-State: AOJu0YzpfFjv3j8Qq786eVYI0dKgGEYWRHMCUfgLO1Pj/bxr2zoHhYct
	5UXEh5UPg5eAf4g31ok22+U1h3jpi6f1K3vl/Px+CHAyRMOCoiKBh52rqTFuvBnbCoG0E7PHQff
	tLxLo7cYpnyYiO8JpxH7dJcl9fBX7tfjZAAdj5XzxO/2+2DiVgB9f54U=
X-Gm-Gg: ASbGnctF5jwaQ1/4QvjRG9B0QIwIR8+/rvD7yuHF4QTJdKuMt4bg7h5LTG2LVGxRV3O
	TQiTllUAVUsEZ89aEF+lAtA0tlJqgXAKOqO9jvQ8aChzdvLXfRXXN6/8k68pw6wAWstX5yN92Da
	CBP7V3yr1RvbQzI0Rs1Yq/L0qPBDvNLeekuUYrfHnkr8i1h2Kcf1uMFnBg6hEYuOnN7e9W7UPL5
	p1hcJ4=
X-Google-Smtp-Source: AGHT+IGaa75dN6Rx278wUEX3vwaOHBSmC/o+BxgTE6DohI8t+fuAqLankM4CZ/lh4NJ65YBKsYCdp0dxIlotQyWrgII=
X-Received: by 2002:a05:651c:410a:b0:332:3691:a50b with SMTP id
 38308e7fff4ca-33549fadb22mr8983421fa.33.1755794415305; Thu, 21 Aug 2025
 09:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821101902.626329-1-marcos@orca.pet> <20250821101902.626329-2-marcos@orca.pet>
In-Reply-To: <20250821101902.626329-2-marcos@orca.pet>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Aug 2025 18:40:03 +0200
X-Gm-Features: Ac12FXyyFo6xbQBksJuTPyJgFgZWaXcr1Hbr8p5teIetyrGwo-JJG1vB3Q4YNjc
Message-ID: <CACRpkdb7PZTx8WPQP8Jrj_sR8X2ejK3OgA+9v2PUaOcTM4NnrQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] gpio: gpio-regmap: add flags to control some behaviour
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Michael Walle <mwalle@kernel.org>, Lee Jones <lee@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 12:19=E2=80=AFPM Marcos Del Sol Vives <marcos@orca.=
pet> wrote:

>  static int gpio_regmap_direction_output(struct gpio_chip *chip,
>                                         unsigned int offset, int value)
>  {
> -       gpio_regmap_set(chip, offset, value);
> +       struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
> +       int ret;
> +
> +       if (gpio->flags & GPIO_REGMAP_DIR_BEFORE_SET) {
> +               ret =3D gpio_regmap_set_direction(chip, offset, true);
> +               if (ret)
> +                       return ret;
> +
> +               return gpio_regmap_set(chip, offset, value);
> +       }
> +
> +       ret =3D gpio_regmap_set(chip, offset, value);
> +       if (ret)
> +               return ret;
>
>         return gpio_regmap_set_direction(chip, offset, true);

I guess this looks like this because it is just copied from
gpio-mmio.c:

static int bgpio_simple_dir_out(struct gpio_chip *gc, unsigned int gpio,
                                int val)
{
        gc->set(gc, gpio, val);

        return bgpio_dir_return(gc, gpio, true);
}

It's hard to know which semantic to employ here, it's one
way or the other.

I like the new flag.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

You can merge this with the rest of the series.

Yours,
Linus Walleij

