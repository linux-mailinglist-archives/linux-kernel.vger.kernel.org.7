Return-Path: <linux-kernel+bounces-826330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04559B8E34E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C2D189C263
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD2A137C52;
	Sun, 21 Sep 2025 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ywnrhy8X"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B96DF9E8
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758479622; cv=none; b=XVSpNBqEDZHYYf2m3O9u/9ZdIIaqwRL+KVaddTkOJFzUUL2fYqxXRk3lbUeyvOkM+5GKLUcoFOpxCaL+mod2tLAiEnPWxTKrqC4HVtHge7pyUEYDeUyOknl/2UW+hRPj1RpK45QDTc7XCTuXujduYhGFpuORa7J65CmfBw9CRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758479622; c=relaxed/simple;
	bh=aoI5EA1Q9ddis6FAdUjfMMEy+ju0QkwuO+9f1M9RxRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDizju7BzvRdi7wRKTfER62AHZW0PdB9VpYW+x9UVydVH9/BKMtQJairDWsXmhWmDsvcBw9YdsYMfOs3+nkn53Yq2alyvTcGAEnazTPUioSJwfS3dJzJibQuHi5s0IZykahxHsJdX/DUvf4Pvz/mOTv/0ppGR6/Ukv3cg6RFx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ywnrhy8X; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b00a9989633so278120566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758479619; x=1759084419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTXsn+dbl5OayTNA74PTyK9yM2TR4se1zzy0Wcj19vI=;
        b=Ywnrhy8XL7TfNWVPCwmJ4+ofBamX8jXQ/2/ypSRZzbszIVca2qG3OFr/OVz4GR1bga
         rnzAfgugcetbXTD9h+e4eoovsd+s50k3NLRJ//ci1ZlIoMZBT+ApQIg0j0KT/fnq38N8
         mb4jIrF23Sju80FVsOvcmPLnIUJQMPBHPbF4WRPDU5mEwMDnGvhoPVT9YYcjmNMnAc7A
         NKEuIVGDphs04Sf7TZ5N9VE8FewxcHDolHkx2yIv2GIwCbZFF8PWpThMuxiMd3fJmRuO
         FUECqMjYufSQ1mr6riJwetukhVyk/6Nes9e4SHLgm2bbLwpjualr7WMFrsCKIdAaXvKJ
         vFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758479619; x=1759084419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTXsn+dbl5OayTNA74PTyK9yM2TR4se1zzy0Wcj19vI=;
        b=Nw5gMVVOwGkVGv7dpjJETzNPc9dN4C/5FY8hP+uU2rVJL3injDUblUiONB+qRoGU93
         SjD4ts/6EPMBp+ZtyhXx6E9JNJcBaOYSkVrbPtaRNqjXwiTGOOgdCnJxbndZJy38KMah
         pAsUIAW3WOe214u1GkaIBsJC2Vi1EjALN4zxOm4usk8hZkQBhIn0QbIpH0iBEE1ZZXh6
         1MI6SmGrTDUTZ1Y+PSStLO0AiT2MaWavppzXBdoB68kOS8nDpcLdup7Xe4R2vkiuj7Rt
         u+h37JKjdiCeTBcLoJ8BH04hOhpa29/7O0x7sAoYk5ByHOZIJu2JxPbcTQjZq6HVgPBj
         GOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP6K+8/2f8LUQQpam51th6KHOwSu3nbUEnzqSoGf1xUaKxcHQ5pV2uzrcu94nR49m4QlJdZ7MAxfNtSI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx901Alio2prCo/wcY/ueIiCoO1H8A3rfOvVSA7+3c3OxVpjBYZ
	+7Z/SMAGcO0sHkLuIKuU6qd4WzAQGPKCE5013PhKiufYVf0soc62SMlOg3QxYUYcSxDTjvpDyFN
	qK2keGmB0tvPUlB6DcgMcqS8FUuDmm/4=
X-Gm-Gg: ASbGnct6pJxQiP0ovh5DQLpSSvkfYaoudAOf1891NW5aVazn4GC1h5ncTzJizHeiPfW
	jkOt6JmCXnUXCc62f1wmD0R2EHz7ZR0YrHr07r8B+O2MFnHHAdgFRZ+OxnNN3z7g8aC35tT9Abe
	Ar1frqNj9+wiYjZopRpCoEHdDKc0e8G1eRsHMxJGPQJ1len3WZnY/xcEsjpx6nAFkwR0dykk3mP
	fu0I0s=
X-Google-Smtp-Source: AGHT+IHE6kkj6zEHA6FRknwexuoQviCdjwYfQ9bu0E/tNgpyN9MvqSrFBdZVovWMAQkYLx9OU2nIIZ1G+MuXi7CYLZc=
X-Received: by 2002:a17:906:2b47:b0:b2a:6316:72e9 with SMTP id
 a640c23a62f3a-b2a631678bfmr282997566b.20.1758479618607; Sun, 21 Sep 2025
 11:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920-iio-indio_dev-name-wrong-v1-1-d376436abbb6@baylibre.com>
In-Reply-To: <20250920-iio-indio_dev-name-wrong-v1-1-d376436abbb6@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 21 Sep 2025 21:33:02 +0300
X-Gm-Features: AS18NWBhQDyGph8zvUHZo91vKcQr6gv4tJP-utxiru0pemI4UO9AvveoZgh7nFw
Message-ID: <CAHp75VfkS_geLqSjMz95yb8smNqKTQTfyCA3KeeUGMSg1=EfOw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: explain why indio_dev->name =
 dev_name() is wrong
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 7:44=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Add an explanatory comment on why indio_dev->name =3D dev_name(dev) is
> wrong, and that we can't fix it without breaking userspace.
>
> The idea is to prevent future drivers from making the same mistake by
> copying this code. And if this driver is ever modified again, we can
> at least make sure any new compatible IDs use the correct name.

...

> +       /*
> +        * The device name is supposed to be the "part number", not the k=
object
> +        * name. Do not copy this code for new drivers. We can't "fix" th=
is
> +        * without breaking userspace, so we have to live with it. Howeve=
r, if
> +        * any new compatible IDs are added, please do something similar =
to
> +        * adc/ltc2497-core.c so that at least the new part numbers are c=
orrect.

Please, use the full path from the root of the source tree, i.e.
drivers/iio/adc/ltc2497-core.c. IIRC the Sphynx might even render the
links properly (if it ever goes to this deep comment, which is not
marked as kernel-doc).

> +        */
>         indio_dev->name =3D dev_name(&pdev->dev);

--=20
With Best Regards,
Andy Shevchenko

