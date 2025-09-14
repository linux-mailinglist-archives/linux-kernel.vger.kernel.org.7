Return-Path: <linux-kernel+bounces-815567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2838B56843
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7F3178B4F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7261F8728;
	Sun, 14 Sep 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvARUJB+"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4237E487BE
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851509; cv=none; b=al3tDzh8HigUI+X69lbGR6SIcciIbrxVMD1JPYaTvckDn20WhizW/z+Od5sU/AiGYVmMonq0hxJ+sptoIs9NL5ke9/fxOklxQINfBuhYjmvamirWzOMh1786A87tK/OcoIph3pfZ+BtAKrwan762erl628NcGEBxMAyxkvrCMw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851509; c=relaxed/simple;
	bh=2XEUW3sv2PyTMtUGHSUVu8YoqpR7RWEQF674FEhLsR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7/3ci+DbkBKxNTMe2446O8TOCeq/vLMsvY5wo8iixl95RbwfvPBVsG3yK4NbrcOk3gsu+RIQhTEPROQjMKSXsylHED393XiglC1RoxcTxyYhdZ8V3IO/Wg0SpEFEATtSLldCEDkPwAItM2EM/8ZPl92g7lcV99b0ZRxSUPGfiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvARUJB+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b042cc3954fso599687466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757851507; x=1758456307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fY6DSEo3jc/AJz5h4ijfNxRlC4eYjZTzab4rWN3vGwY=;
        b=IvARUJB+3LjKzMNjVqb5Qa205KJ5gvr6ef7dG7G3E0shxZKsFaeWmxGOuNyxjN8xF6
         ieFK4u2iFFWvkGgka4wwLlpp4VeD9wdyPWYyowIRAkKuZnCKL6r5o4fvMfsFfHq5xu3e
         9cQT9eJQygNT+OTQ1jPzZ3NdIfNTiQGMvSZ8tDGC8nlB3SfRPJ/INE/A9S2Zf5UgiN3Z
         UxxU+0N5AYjCEXWWkhJKQyVkeSq1Hsf4ZCSoZryl/zARi1XFYJtGwWppKt1ftjFG1AQl
         d9Z0DOYzG5cem9DAdwxCmYTitAjKiR+z5oYzvJVPwTikLh+SSrn9lUm5f0aBVzmSLQQ8
         MEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757851507; x=1758456307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fY6DSEo3jc/AJz5h4ijfNxRlC4eYjZTzab4rWN3vGwY=;
        b=tPx1U+VljmIN7HDnJPc4Hs5LHYUiPctIdflksg9dmlPHzDbk6e69HpbAhzB0K+GtPE
         Njy+LUWxIVHTgtd1ndQJrjj32hrqFVAvw+dgyl2ut8hkyTyphE0pW0MjO5OILfldY0Bg
         ey+2n8huleLs+fIYLejsWZC39J5ik31Rqm0yzq/aFNYETGimQsd34cC4tTLtAYEb4SiJ
         /aUEOeIQCgqwp7Piyltq75AuVDS7kuXWIOVPQ3YzHBYSHF9d8NsbXSmDx2+jwt5mey7k
         VZNmJ934Dl/aIfiZyBf1VZuYmEw2AAj/tV0KerD3wR+3a8CVrp0iq9KJGZRyHoA46KEf
         qNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJNEbwkeXaoh+Ft5p2AVUAGxYhMJQdj6Pj7c37AAF7UfjdKMPROPWoQnJaQQV4wD8XUbmf69V10AtEZcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy995vHM/7ezGktLNCZFe8RRL/d9lhbME3dv3TD3RLNV7x9sZUj
	euXZVgsSr01LN3jYPkFc+KU3jkwDCLD+7R/VAH6J1HgC3sqqEIYtbYXIFBtRCsbFr/o7IMsgbbc
	aBw0CkhAeaRe4aRrx1csxUpx8jv/ufeE=
X-Gm-Gg: ASbGncvQqGF0z9EHd6D4Gort8cKKySaOA9Ur9NHzNLCHoP0xAdabSbyJmB+ZKDuLkWM
	BiHV1/uTDlmg8VrLgtnw+IJZ+38HfFF5Co+PMPf1ET3O8Ns7ihYWW4d9shWm/nou7uaTo0Ly8we
	k7wWlSBHbeJc6TY3mgVbVhNQBzDizSHSdZJJUlAEmox3scB03U2HkhpGyWG69hY0NaXKKUTxGDo
	N3Fsfc=
X-Google-Smtp-Source: AGHT+IHsndcZySXaL6I1jcRzVrpRT63KT1X95uqVC06SA7Ggplz0Yps+bfOG8puX6cEkwkqk4cjU2eV9ySlSoHck3Gk=
X-Received: by 2002:a17:907:6e9e:b0:b04:aa9d:2240 with SMTP id
 a640c23a62f3a-b07c37dbd64mr909536866b.39.1757851506307; Sun, 14 Sep 2025
 05:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-6-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-6-0b97279b4e45@subdimension.ro>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 15:04:29 +0300
X-Gm-Features: Ac12FXwYsc-BkMVQQt5TjOs94PVItMr4VpPlJOUdr5AMKIOfTub8Tv9c2hIE7dI
Message-ID: <CAHp75VcQW2LLjDSL+6z-RLjoniqNL-eqLz82eBozJuG49r4kgA@mail.gmail.com>
Subject: Re: [PATCH v3 06/18] iio: accel: bma220: turn power supplies on
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 6:40=E2=80=AFPM Petre Rodan <petre.rodan@subdimensi=
on.ro> wrote:
>
> Add devm_regulator_bulk_get_enable() to device probe().

...

>  {
>         int ret;
> +       static const char * const regulator_names[] =3D { "vddd", "vddio"=
, "vdda" };
> +
> +       ret =3D devm_regulator_bulk_get_enable(&spi->dev,
> +                                            ARRAY_SIZE(regulator_names),

Adding

  struct device *dev =3D &spi->dev;

will make this line and others shorter.

> +                                            regulator_names);
> +       if (ret)
> +               return dev_err_probe(&spi->dev, ret, "Failed to get regul=
ators\n");

...

It's possible to do in a separate patch for all of the cases, though.


--=20
With Best Regards,
Andy Shevchenko

