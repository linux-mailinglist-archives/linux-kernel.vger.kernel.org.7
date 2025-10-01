Return-Path: <linux-kernel+bounces-838823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F3BB038D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B028F4C14B1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAC52D9EFC;
	Wed,  1 Oct 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGBIcqZ+"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D0A2DE6F4
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318894; cv=none; b=UJPthhvy/PyoXjtMvauUBsBud2mk8EEM6AAoLqa4sbXKDWu75Pc2APdM9WbgpZA1CbJpFNVqRMx3apvdh2VSU9ln5rpuw1w3p/6F4u/ZjhzGvDuZrHbFrZybk50sE5/9RTltGtIPlUPE2GEfETGNWyXaq1cmy7SkuD+hAA0xFTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318894; c=relaxed/simple;
	bh=XNoirN2YmXOb9e+cUQx56jMaIQh+gAJtYRQuQbyuBGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdIkzzFHVxb4YuGJkcBDtjNgLUUMm7zyayITI9WzenNjNOlKQVJIEYPImHFNCsisfF8zIZCocLIkh8iXFPGnGi/zbNgpHViV0aOdhgDAToIeemfHEmpCUgXjROSMXBAzCN6GvKsM+MuwezCPiQY/nCql5rb/99o266trVYT8P78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iGBIcqZ+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57da66e0dc9so7337056e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759318888; x=1759923688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qctZSXMhs2xeiqfjqCMk0nsDO98tXumKc7sHsixp5Vw=;
        b=iGBIcqZ+9TycTKvNSiWZkouV7Wmik5N8GdkyJAC5jTLxIaSIKYFTZi6hylI1+nEutf
         Le2gXxMVkShPUGDqrR62j3Wf4YYeLomcJHuBTiM+BOcj6v8iXlsWcIZNjXJ5iq1SdoSi
         Fx/lrm3zTbQh9wWIhEi/en0CvPk1lLCebQV/b12O8mF/7tuvRxt+undkh6RCOlOJvnMz
         jBxu2ImwUKRwNGIbGFNAPr+HFkesPrzEHSlMXmPil/JiySkXwh3vc4dgktqfuuwhnZga
         Nvt0WkU9UpLB7pyoLRHtvi1Ie1Rnzx/ofigjjRUsgSm02AZwHd9Wd3DlfGkS8au0LNek
         sEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759318888; x=1759923688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qctZSXMhs2xeiqfjqCMk0nsDO98tXumKc7sHsixp5Vw=;
        b=Ugg+Zo6KJv5Y0lLxdSQ2dkpAw8GNLwUB27EOTTGRe2X7PgwCh9S3I58rpcXDHrcRsl
         chLeIlk+kvr7+tkyl0oE6xZuz2niFQWkmWQpqjYFr28uGxytUyx1jhWHZjzYeDhpBqtg
         IOXSVBExFx71/TQkFf8XaPsbw3pDiTaDqILyRF/L1D/gk6xx+OiAu4k7IV4V9r3Er4oX
         HMUtbsxkyWrZRgOOXr2SQ2yYbut1BhCXLafzwAhBaeEuIoBWRbRjeHAMzyvxRIKr4ftH
         r5x5VQ8rANv/g62zGMVrK7fzrUTSCm7GOaKiJhCbU723aFJVtmvJU/CnvmNk+ksrnRKa
         kioA==
X-Forwarded-Encrypted: i=1; AJvYcCWjV1b+VY0jKeo5VcySRIgSiLKoWTJXbjXNvxm5uAeoU5Sqfy7wY0kBFDwCD/q9ROFmZ0Pqnwm+DKe+j7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRDC9z5U9ZGxdGlH61e/TgqigeBu6xEj+Ew6+GvU14NbDgBox2
	CNjpM7Ng1toVrJQZXyQATvD9to/hVgXkEOntW+/M8ToEFFgkT1Lqelcu1tYkHE5mblHf8LeHerg
	ktMrfAwZpR/Cm1xlG91DpJ/m5uLSTgUSDmT7BmAk0WA==
X-Gm-Gg: ASbGnctO5kYRzIWX+sPdZpYWcvEZ69m1J78Vror26iN+YyQhgRY/4bsJ6LOhx68Hi0Q
	ArdyUBbOgkf6b7G8sjGm/iu2k/LCNhe8FjTfvX8s78Lg8VEaPvtYCakAlmxrSScaouVyjWhIH4Y
	KntdbmDtdyPFWcgjw5hpCgTZohNadVeIomwc1s9Zqcewg5NpUMAwjYygzdd6CfaPrSilMQpsLxa
	6TXIV+AFrdcgtxut7ZLM1ZF9KakEE4=
X-Google-Smtp-Source: AGHT+IGh0WRelayFPhpsyMTnu/QogCxki2FOJNlaiws2mA6RsyILjodYZSp8V+kDGxU8+sBc5yZrKN2O5uWz8LJyuPc=
X-Received: by 2002:a05:6512:b12:b0:581:75eb:cb0b with SMTP id
 2adb3069b0e04-58af9f4df8fmr956846e87.48.1759318888565; Wed, 01 Oct 2025
 04:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927-rda8810pl-gpio-fix-v3-0-3641cdcf6c1e@mainlining.org> <20250927-rda8810pl-gpio-fix-v3-1-3641cdcf6c1e@mainlining.org>
In-Reply-To: <20250927-rda8810pl-gpio-fix-v3-1-3641cdcf6c1e@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 13:41:17 +0200
X-Gm-Features: AS18NWBXAbHjbTdnQXpt6IR8KxMLhgGpEzULsJ3KqRHyjfQNnQcsJ6eT4En0sws
Message-ID: <CACRpkdZD+QFsFSTL0c6HbPp_4op2axjpZRL=y-KEMw_rNpxgqA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: gpio: rda: Make interrupts optional
To: Dang Huynh <dang.huynh@mainlining.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dang,

thanks for your patch!

On Sat, Sep 27, 2025 at 7:02=E2=80=AFAM Dang Huynh <dang.huynh@mainlining.o=
rg> wrote:

> The GPIO controller from the modem does not have an interrupt.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>

If the GPIO controllers are so different, should they not have different
compatible strings?

Maybe add rda,8810pl-modem-gpio compatible for the modem
GPIO then?

 +++ b/Documentation/devicetree/bindings/gpio/gpio-rda.yaml
> @@ -41,9 +41,6 @@ required:
>    - gpio-controller
>    - "#gpio-cells"
>    - ngpios
> -  - interrupt-controller
> -  - "#interrupt-cells"
> -  - interrupts

Then this can be conditional using an if:-statement such that
it is only mandatory for rda,8810pl-gpio and not for
rda,8810pl-modem-gpio.

Yours,
Linus Walleij

