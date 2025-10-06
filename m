Return-Path: <linux-kernel+bounces-842702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C21BBD53F
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF5FD349AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8D925C818;
	Mon,  6 Oct 2025 08:23:37 +0000 (UTC)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC62223DED
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759739017; cv=none; b=bsKoH6J2JIO3OvhJ8BWUCn0cHQZ+4o8sRwI4rhkhE56A9v3TrszQ0Rh/lbPIqAzyZLmeK8zNLwSRppXBCHReG/Ju8Doek/z+cpWPwW484JBdo0xxYCpff0zp4QQGKwXPJsElX2y5SpWxgkjz25t+q6OAK8fFTO5Vb5gWTecU8fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759739017; c=relaxed/simple;
	bh=yPJ4uhScVV52KX4qfADm9W+4Y+fnBc/G5x2E3kGOXeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wue8yHJNHQPtmmuebupGJnpWL4ydaAW52Lhq/WL5qmfRgUQWgUNYyQW9oEOxvVP/UdfcRQVF7muzmKraDxKCAE+RZ3ErEDFbRHnG6D55DsCkYik0oWAGpmaLVIXwUuz3MrmPFCb2a2Q4szR6cQfqwWV90GZ0Y4KzOhV0YN3PUhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5521c99636cso1605295e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759739014; x=1760343814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCOFbZedcMVlIFhZ5V9Jemyp+1b5l06JAScJmhtxVpA=;
        b=i61z4L459WRaAAuVruNyDvyMTVAwFB+GVA+r59o7hnVUzk4901dKB/cln8hHuXR7ZP
         KH5dJEVSgDjpxheDo926SoPsYzDLeuMfl06FAvQr7x9gEHJ+orFjsaceQWLZFnQ1FQAg
         hR2ItnROOr9lSHDy74b5idGQTI758OMX3B0CACr8jQRy3HbfzS5hYSxOyqcWMLGfnEYQ
         WLYqTNoqqCjQWHxdAUoK6og/8XtuJuLS0637u/7U17J4MDi4UaLM3Qy/q4vxTQ8JSC42
         X3SHgY8ZwpF8Iom+GZ1T3OLCIOku+GvEpAFWexpcr2bXGXVI1+O+qCXZeldmDLl8bDFa
         oy/A==
X-Forwarded-Encrypted: i=1; AJvYcCXXs4U8mPTGu5bJNcAqcmxQp6fpWD4iRV0HILK/ruio3QeHBlu0CtpAttEiaTwQpWXvMAy8cmAY496T3qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+g74iHhvxCBxud9yLyqBpogbicDYUP+X2JmKGJi8XvDc9+KRg
	MIOXhMirQQwDXyLHpTv8y70iz+WNrzDNAB38Eoc+zUmI0OY+i4ZyxJWTwKCWw2xP
X-Gm-Gg: ASbGnctHSIPdLR7B0n8GETkunitOXag/foifmgmIrqlBYhjUFB22X9QPbEnnuQ3at4C
	fqwETG+ffyzsnagFoa0rQLPkOFweEApUw+w+1H3R7DSjpwQoUX4TuGOFg3RJIUDlexWMxTEpyJB
	RZSHeQKiF6EnW5xw1ZC9BiadSV0vC2JQpOH8w9HiwEBGKif+FjucXY3+NWb9xY9PnI69qZjrsnI
	WHzWdmwAwwHYxC9wxOHop+4ErqqMN/0eiCNUxZ2H4FWQIr6oLUeGGQSTFJyavayWJ7A7Z7cETm5
	3rCDk8X+tU+oUjeHzKEXHIeU04RyD88CC/YS8IDVf0rlcc0J5U7kNZJuZI4f0aa1fXdg6wgUt3Q
	WP3PYK7urOJzvE0Dy23hNgOuCk6JAdtXCYh7zXUg8VlT4nAglxSZF7/zQD1kO4GNkXgauxwT3q7
	UkMAocbJ6mTvx743Xb12s=
X-Google-Smtp-Source: AGHT+IE8LVdAzCX0QproU2wtlaKKy4FXncXCYP2t4KqIL2D3a/wGEcSVqyQuNYCL3yQxznmzfmsHfg==
X-Received: by 2002:a05:6122:659f:b0:544:9a46:7c85 with SMTP id 71dfb90a1353d-5524e8884a7mr4112423e0c.4.1759739013579;
        Mon, 06 Oct 2025 01:23:33 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce202bbsm2882775e0c.4.2025.10.06.01.23.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 01:23:33 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-580a1f1f187so1925442137.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:23:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUa0eOLEXJcCl2rmh/O3yysrkfz0wbWVgu0HLc2rmJHbgunAmGsiskO7bMQblixjXIfIn32q60FBqUTAs=@vger.kernel.org
X-Received: by 2002:a05:6102:5548:b0:4de:d08f:6727 with SMTP id
 ada2fe7eead31-5d41d0015a6mr3619673137.13.1759739012879; Mon, 06 Oct 2025
 01:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729152804.2411621-1-arnd@kernel.org>
In-Reply-To: <20250729152804.2411621-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Oct 2025 10:23:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW6jCbB80JhUVjBPnMCAXn5Amdr6KM48jvnd+VnMR40gg@mail.gmail.com>
X-Gm-Features: AS18NWApwbBW2RVTzdSSIapTOtWIdeCfjdH3fDWaLQJJ19wwGQqxgXBBfp0nwbw
Message-ID: <CAMuHMdW6jCbB80JhUVjBPnMCAXn5Amdr6KM48jvnd+VnMR40gg@mail.gmail.com>
Subject: Re: [PATCH] hwrng: nomadik: add ARM_AMBA dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Cai Huoqing <cai.huoqing@linux.dev>, Arnd Bergmann <arnd@arndb.de>, Dragan Simic <dsimic@manjaro.org>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Daniel Golle <daniel@makrotopia.org>, 
	Christian Marangi <ansuelsmth@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, 
	Markus Mayer <mmayer@broadcom.com>, Lukas Bulwahn <lukas.bulwahn@redhat.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Tue, 29 Jul 2025 at 17:28, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Compile-testing this driver is only possible when the AMBA bus driver is
> available in the kernel:
>
> x86_64-linux-ld: drivers/char/hw_random/nomadik-rng.o: in function `nmk_rng_remove':
> nomadik-rng.c:(.text+0x67): undefined reference to `amba_release_regions'
> x86_64-linux-ld: drivers/char/hw_random/nomadik-rng.o: in function `nmk_rng_probe':
> nomadik-rng.c:(.text+0xee): undefined reference to `amba_request_regions'
> x86_64-linux-ld: nomadik-rng.c:(.text+0x18d): undefined reference to `amba_release_regions'
>
> The was previously implied by the 'depends on ARCH_NOMADIK', but needs to be
> specified for the COMPILE_TEST case.
>
> Fixes: d5e93b3374e4 ("hwrng: Kconfig - Add helper dependency on COMPILE_TEST")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch, which is now commit efaa2d815a0e4d1c ("hwrng:
nomadik - add ARM_AMBA dependency") upstream.

> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -312,6 +312,7 @@ config HW_RANDOM_INGENIC_TRNG
>  config HW_RANDOM_NOMADIK
>         tristate "ST-Ericsson Nomadik Random Number Generator support"
>         depends on ARCH_NOMADIK || COMPILE_TEST
> +       depends on ARM_AMBA
>         default HW_RANDOM
>         help
>           This driver provides kernel-side support for the Random Number

After seeing CONFIG_HW_RANDOM_NOMADIK disappear from m68k
all{mod,yes}config, I became intrigued, as it did build fine before?
If CONFIG_ARM_AMBA is not enabled, both __amba_driver_register() and
amba_driver_unregister() become static inline dummies, and the rest
of the code and data is not referenced, thus optimized away by the
compiler.  I verified this is the case on amd64 allmodconfig, too.
How come this failed for you?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

