Return-Path: <linux-kernel+bounces-864328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEAEBFA870
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0121B4F509B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492332F83DC;
	Wed, 22 Oct 2025 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="atcQMrZ6"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B170B2F7453
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117832; cv=none; b=iFW9w7GWnoAc0oXlROZ/jQtIjjIvZUcWMSl3AG3bnI1KYwDd11erkB5O6yBvhLxVT2kdu4tT6aIiM8t5dOQblVyh/sbO58b5WI1qrJtTwa7+PvLa0WFYZgBZpvjI+AiHAA5pcERGrUSX02dfr4KAH6snxd2JEP+KzPjGo86D/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117832; c=relaxed/simple;
	bh=KAzF1t+jG/TWqXNpynShq2i67Mb+W9sWwRnWCZGDy80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQvFCFOPpuU7Ec+UWD2fPSnTjC7KkDgZI89CdSCg27aNuLOTuCEThuJ2ZZDIviSpcKvjvXh/GJOWg3C79hu4VjSlO8MMVF0jTGi7FguILEgSe9/czkxsfmlWuPMv4+6jNakXQTkK/L7xD34upPCxH+yww0wP04Gk/HJik0yGuZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=atcQMrZ6; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-591eb980286so2092967e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761117829; x=1761722629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5A1id1SGRYPwkfypYJ6qRn/5uL2uarF90qzz71rp2EQ=;
        b=atcQMrZ6deXkIw+U1xSYPmcqhQJcgzReuep7WDdtIBDMczeRThGqf3MyYh3Xw+90Gz
         +Xo4db7nB3OYKQtrMXqaJHFtzBS1kPTbjlt8sty3AZ0Ld0WNZU2OC3wue+ybpblXHpEu
         d3PUnSkkwVY9/Jsc88Sf6buE3+Bz2s/hMpky5sdKvL/35UOAKeoY9keGpDc3GWkFDuxd
         otQlTUW1h2iQLDLQMM9AtHydgzVdREv30R8TlK5Mc+OlwKqXj9Z0BGkqVn2/uZQF5KKH
         haQrag1IQ5Qhx2W4S2FmvPUqAcrW3g1E4DtOJHvzqodB3l+nMImTvNp9OlUNXFdRJelE
         FDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761117829; x=1761722629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5A1id1SGRYPwkfypYJ6qRn/5uL2uarF90qzz71rp2EQ=;
        b=nkUgvE1aKzyo4fE3BqMQSHHWDv4+q6lELj5NrdJrgFmO5mRZH+7nsuLJun0wg2QdZu
         LfuBssS0+5RRyK8A7JOpFcMkAymIkTJaeh/WN3n/b8C7qu6zczuj1AepCHlWJyXberSo
         xshcqarwNmjEamTE3qRz7vvhlilkanDydic/a5U4TOZiKvxzAFSjDHu0sINvCU7d5ZsC
         66whVIBcg0MV6nklZR072ABrwlKlPRyqMVv/OIr1KP3Ggf6N/Dtjesly99Xl8v5HwMu3
         zaxyhhCIeFcgZjTuEhQ6xg5qefI6rSA5gF5Gj0IAJ8au/WAHTpEQvUCtatLcMDOQtiss
         qd7A==
X-Forwarded-Encrypted: i=1; AJvYcCWkI8k2hXOiO94CD61pKZaRcGjdYUoSlgENils8znNwpS+P8kq/Z5xWN29jLWDYUJ03XyCqa4gIFg46S00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztp2LEdgv0FcJ9pPa8nZO9DF5QAVYQ8FyMuteZKAR6YmY+LyU7
	ZcXLpBmOM9FbL6pep/5EAuTa+4sOcgYmLZEo+BBs0RJU0RxhQjWdqvbvutBdmW4/ocDv6i3u3KO
	+bbzIWA4t2jx3c/FYqF8vCDcUIIZMGIcIiIcMnFhYRQ==
X-Gm-Gg: ASbGncvmwdysF9rsdyNW1l4zlnJ69eDZKpWSCWd7GhX6pzMLPdlDaDGgSaKlD8ucZEw
	fwQtQVBHbO3abGc9PjjAHwcuJZXpaBd3N/PamooJLTdDxqW3oY027lk8a2DJYJBqxg5a69j4o3O
	z/UlyvqVobB00k65v3OyghHK8rsBLo2EFoYBMzEqtpCy3OcP4Z9Co6tt0OwGkkUOP7qVIytTsSp
	3/w5CEFlg8IpWfWNeU2+d6kcGd3Wa2bQ54Z5iI/J/sR242GUv4Qk+XnX/8aQEHJgLWD0SJSopQz
	P57Vtc/f6O1DAPCW
X-Google-Smtp-Source: AGHT+IGeyQXjZLLCFK5JPYKsrKRqqZiejy+zuOYqH5QxSDczg7GGQ5xLajlHxEL5O+oHFuqe15LrIT93CQawnFHffbo=
X-Received: by 2002:a05:6512:10d5:b0:591:c5bb:ce44 with SMTP id
 2adb3069b0e04-591d8565542mr6721828e87.43.1761117828734; Wed, 22 Oct 2025
 00:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021181631.25442-1-alitariq45892@gmail.com>
In-Reply-To: <20251021181631.25442-1-alitariq45892@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 09:23:37 +0200
X-Gm-Features: AS18NWCsM_dUl8fxQ2wYJOUQ3nXW_TsGWO5r7_7o5MFypE6AK4VLb7fy2KZDeW4
Message-ID: <CAMRc=Mc9e4P9vCt79yR1Jt5_2wxUngqAR_m1AxG=nbz=Cr3BjQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: starfive: use dynamic GPIO base allocation
To: Ali Tariq <alitariq45892@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:17=E2=80=AFPM Ali Tariq <alitariq45892@gmail.com>=
 wrote:
>
> The JH7110 pinctrl driver currently sets a static GPIO base number from
> platform data:
>
>   sfp->gc.base =3D info->gc_base;
>
> Static base assignment is deprecated and results in the following warning=
:
>
>   gpio gpiochip0: Static allocation of GPIO base is deprecated,
>   use dynamic allocation.
>
> Set `sfp->gc.base =3D -1` to let the GPIO core dynamically allocate
> the base number. This removes the warning and aligns the driver
> with current GPIO guidelines.
>
> Tested on VisionFive 2 (JH7110 SoC).
>
> Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
> ---
>  drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers=
/pinctrl/starfive/pinctrl-starfive-jh7110.c
> index 05e3af75b09f..eb5cf8c067d1 100644
> --- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
> @@ -938,7 +938,7 @@ int jh7110_pinctrl_probe(struct platform_device *pdev=
)
>         sfp->gc.set =3D jh7110_gpio_set;
>         sfp->gc.set_config =3D jh7110_gpio_set_config;
>         sfp->gc.add_pin_ranges =3D jh7110_gpio_add_pin_ranges;
> -       sfp->gc.base =3D info->gc_base;
> +       sfp->gc.base =3D -1;
>         sfp->gc.ngpio =3D info->ngpios;
>
>         jh7110_irq_chip.name =3D sfp->gc.label;
> --
> 2.43.0
>
>

That's a NACK until you also remove JH7110_AON_GC_BASE and
JH7110_SYS_GC_BASE assignments after explaining why they are no longer
needed.

Bartosz

