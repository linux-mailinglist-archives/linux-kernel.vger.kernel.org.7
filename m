Return-Path: <linux-kernel+bounces-836295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884A7BA93A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9422E189D990
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C074270ED9;
	Mon, 29 Sep 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PSfoqwfx"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8934BA40
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759149951; cv=none; b=reMY6BGttNrS7RJjcZOAjlaZR+j39JnTaG0UNwmAJT517+2uL7yjbdvWdTvIlUTD6Io0vQGPFHOjOcSjbyyfJq/lNo8gudjN5I30a2MSJtm6sVU6Lmmw0Bz8bOL0drKBv/nJ5rmwrKy/wBYf0AfvyiNcC2oJ2ssaniWFTEq5H8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759149951; c=relaxed/simple;
	bh=yIr8HBJeaWG4z2Zp1AsruyR6vvbi+g8yEhktUcR1Rzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dczQytZod3F6SGNxIBYOuVTIywgaUcYF8d1b6w9CSm2jenGmQmOQIhK0MzfOck7kR6eFI+Ivlp7/suyLLRh7cNQExbYJv8dhmWqfNBQ1PU5CGb7+q3FPeZzLTbgjC7CAH0+r/EAh+y9TqWVGhYRtYxQxujpI3SpV4lmceTv7XzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PSfoqwfx; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57933d3e498so5487550e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759149948; x=1759754748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7b2Xmk823kj47j/pJ6Gz4Gn2hyrizZmbnqLdt2BBnE=;
        b=PSfoqwfx1QwyutUOjXQ97dXB6oCgp8jzyzqpIuMiYEkjHRNZHK1SNH1UggEZwycPlT
         GVLryFfnigR5JICBGrsgXO0wE8kSAtg42700OY81f2D0DMdsSNMVE6bet4ohzCpq0UdQ
         9MfmIpN1nLprflLUvNEELbsynnzl5QL9iY9kQTunBRwb+NxdvqB7WkdyJ0kBC3Mto1AJ
         43xieS2obCrxKnwcP+2E9CEWp0XuRqG3R+iZ6Y3jwXPqjFMOQwFN7R4Q0msrxSGhxCgL
         PioptaxKTDuZDD4JibleKSG0yAX4EC7KGd3Yf4hE/uBh9evtUY2w93i560F8hldhrF2w
         0ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759149948; x=1759754748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7b2Xmk823kj47j/pJ6Gz4Gn2hyrizZmbnqLdt2BBnE=;
        b=Xw3Z4pG9NBLmzWcfdyEqgElRJjA4+d7hkbUyiHT4hW3NzAIpzV6Qu5Pzwjb7Q5/Nb9
         bMYHK2GbGQ3Yqp+t4QDsawD2WSQfRdjgfR+mIqVi57nn+UAuCB7jCTFH3VnS6eYXUilb
         Y2VuopAnj6qVnaaAtF8rHN/l26zb3RGhubH9W5njOASoDfbhc2HqiPDd9bcupUP8neAp
         OOzAAt1FLBlg5UfA7jaSl3jLBK1KIp77oNuVVL0SrUMnK96XJjo4l6slHbl9PzdIyt3E
         FzaqNplbic0bs1n7HEeUhhJphOWLjAhM6o/bu5wIWzNxoTDmXXB/3RWFDAxN8oOBeOhz
         H7tg==
X-Forwarded-Encrypted: i=1; AJvYcCW7feYBA8TzSu1VsonS+Yavtqg4vOP/8X+vDjarJkTsruZ8Nl8AE1EkBBeOrdV3aBhvdiDQ7NhDP0MFPBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu3q5g0ErZGczWQHhSosP5tMWT4SdJhcGOqpp0asxqWP5jszd3
	G3KscLCJB7KC3W/l23YLCZ6LivkCQGS8ZCP5IGAb5lua5YQJfcT47z5Jin5fPTXAE8DWfDKnu72
	ETN4UkX6iHSEQy1G/dtXxPW8vyBffw5nWA5rQFxIbbQ==
X-Gm-Gg: ASbGncsMjCZXCAE249jR3buKVnt90YNaxrgtpb/waGOExqDiGfpQ5CrAdlyBIbD+Wwj
	o/4+jNXaKjngOUWW+AE4IZcmsNW5eAwx/wB3lL5/dw7kQ70r/YoRzRp9n5kR9vpEgkJCOXBPs/+
	lRAca3MIjCunqszrSGw/nwSwOye/4u1A3KFynjXhr1G6ZKBapkArB/481l271b3Zc2tidgf+ftf
	1nXKTocbb0OTCBL+5avKXYjTy6TwzdIveFczURYDUXrZjYsfQ==
X-Google-Smtp-Source: AGHT+IF1U+ntE2SSzPWkrg1omim0UZUn9M1eJMqtMt19isbv6716FR3UDWvVglHEDHl19ADE6NeWUXyFaPZ4zdOBX88=
X-Received: by 2002:a05:6512:3b20:b0:57a:8738:4d80 with SMTP id
 2adb3069b0e04-582d0c2a62fmr4431350e87.21.1759149947738; Mon, 29 Sep 2025
 05:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929-gpio-aggregator-fix-set-config-callback-v1-1-39046e1da609@bootlin.com>
In-Reply-To: <20250929-gpio-aggregator-fix-set-config-callback-v1-1-39046e1da609@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 29 Sep 2025 14:45:35 +0200
X-Gm-Features: AS18NWDnh-XcXJZXhEqxC9wSMjePYeDhH2_VEtoj8YXr05ZwZa-yz1re_gq_0-0
Message-ID: <CAMRc=MfG8-c_+_R3meR_DgK3OMM3JEMSWu3SjfdMz-aW8c5wew@mail.gmail.com>
Subject: Re: [PATCH] gpio: aggregator: restore the set_config operation
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 12:03=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:
>
> Restore the set_config operation, as it was lost during the refactoring o=
f
> the gpio-aggregator driver while creating the gpio forwarder library.
>
> Fixes: b31c68fd851e7 ("gpio: aggregator: handle runtime registration of g=
pio_desc in gpiochip_fwd")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202509281206.a7334ae8-lkp@intel.co=
m
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  drivers/gpio/gpio-aggregator.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregato=
r.c
> index 37600faf4a4b728ceb1937538b3f6b78ab3e90fa..416f265d09d070ee33e30bf67=
73e9d8fffc242bd 100644
> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -723,6 +723,7 @@ struct gpiochip_fwd *devm_gpiochip_fwd_alloc(struct d=
evice *dev,
>         chip->get_multiple =3D gpio_fwd_get_multiple_locked;
>         chip->set =3D gpio_fwd_set;
>         chip->set_multiple =3D gpio_fwd_set_multiple_locked;
> +       chip->set_config =3D gpio_fwd_set_config;
>         chip->to_irq =3D gpio_fwd_to_irq;
>         chip->base =3D -1;
>         chip->ngpio =3D ngpios;
>
> ---

Thanks for fixing it. I saw the report but I had already prepared my
big PR for Linus. This will still make v6.18-rc1, I will send it later
into the merge window. Please address Geert's review.

Bartosz

