Return-Path: <linux-kernel+bounces-838606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62720BAFBAA
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2253F4A5A9F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8FC27F16A;
	Wed,  1 Oct 2025 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zkfrDGu+"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9E419DF5F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759308564; cv=none; b=XRvhivuAc0TwQKV4qYYICJf3md64fgWswUHp4qLbI/GWh9OtT9efDjfofh4yMuNmt96J2AL7vB41CoAKIO5hwvnIOm2DJBN50MZlecO114v+WTWxhrUFwZSk3AA5X9YUa7tpyYyJ+7a5FNNhkfnTPWaDv5Z/Tgmhibv1DWDw9nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759308564; c=relaxed/simple;
	bh=8rIcT1Pqs3Ea0y+ldBE56b1g4vr0kel/gXDqeQVGlIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8p4TQ+IG6CATh3YDEPPeYgDak1jJM3+V/hsMrtG7PEgw8+YMlGVBKobiEkVvvx6u+K9X52WJamsu/mtc3ONZ53hRMVcpqE9bFs2CQJipjf6ajA26IPGDpCtuoiAVniGroB5XN2tS0F8YziV6b7XQdZa6R9Hfkj7XWLdvlYM2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zkfrDGu+; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-367874aeeacso50523111fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759308561; x=1759913361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0MU6aIf0UKaVQXy6RXiIl/s8w4p6CMU+2iv6BbdgNc=;
        b=zkfrDGu+OWGi3FG8ITAaOuQBN1lu+3NuDJaQ2yrnNFnH/u4ixV3mjNpWXUlAp6+tpa
         EX6re+C2MTBLzc8+tP2BGCqAmohTb6v4M7n01C4APyZ6weYstslPeSeKGecOJzJZWXBO
         dHUTGYoXnL/KSJbvNr8GWGvwo/Fb45TO1CzVJ4i3gOzmtLQgGyieA4xc3OaVmeumXkwn
         8lhRf7ibgDZsV1U/4E/J13OYbqg6YgoBJ3XS37jH3D74Vl/Hal+T6qhgJXZCzPRyBX5N
         mVMJbwIiMb3Qhyuq6WZKybFR1gzRX5URh/ZKdRBuwn2ltYr++hyKpz0xopO4lH4DySv9
         qXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759308561; x=1759913361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0MU6aIf0UKaVQXy6RXiIl/s8w4p6CMU+2iv6BbdgNc=;
        b=Vaehppig9uD3cjBeGyeKg+zose3eVEdOjs1SXiL9kjinhVQhSJWORnYr2ZfmPehGWs
         XJUJVNJPOw6MAVu7OeFWDqDtKLh6y+lKL8WmWwxbGpsuo4fiv1IL6lDdW+uTEBrZzEhR
         gcjCXoC6W2eKp3Hjgb4Newpouo6bOUBSNSL7c3InDI3qQ7Q7M5HKc2LC8gVhD3+KeHGN
         jLNYGLyucbhOsMowpTmTejEogPdoj6rDf2e/I6/9gmNIOaMYbYFzz0XxxqWkO0P5R4qj
         Ew2EbJNKaViMU0VbZdzO2Dsxt7jvBN5tqzgWha6OkTLRXiSF4E8kSjoiw3+nn6ZHHGCk
         lN+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFWCqBLLK7fvGHZtE0bS4UKR+do3sBIXqecjN5QX+IaT+xTngA4ZqElwtjrQ5EvHA/aqxISjuP0JRJge4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkJbAw6ingWbsGRPMK3sDY80wAVyI1MNOCMB82od1QivrMwMjg
	aKbRkGb0TPoI9p0ctrldbODFs2hFjy+lM+lAEVdJaj2ZiHxVUn1cK/dpoYp7lyTKFS5NZqsyLpK
	dWlgd5No5NNXqiojhu8HkeaNNARFgqg7WdT6lez8WSQ==
X-Gm-Gg: ASbGncvYdOCkliMrft7M6MpbKsbthfyr/3zkYB8OShguEgoKsq9dfFgrqYup3tJZI7Q
	gPeoQWej6ZOUft22KNREL278GKeax6gBZ2KJhDBc6bRtGqWDNMDBAebb/zp4+tlExW+N3rjMzeM
	Xlzj3+jSrbnvuP2zNeYuPrNbroRp6teMUHGNU/lT3KUyQHTR5RxlxgPkAmxMEvpZyu8dBRAwDeR
	MFHbIsy4vEn6ob53tCXeliL4KDI7Lo=
X-Google-Smtp-Source: AGHT+IE/zKf4qFF1V06mzijknnV4vH7ubPftpR9/pcWP4CKpLmmmcoKCGAvUGlvDb6zfdbCLMmIHYOCJfvmvwXDpg0U=
X-Received: by 2002:a05:651c:1592:b0:372:9468:8f99 with SMTP id
 38308e7fff4ca-373a752cee4mr8095951fa.35.1759308560647; Wed, 01 Oct 2025
 01:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
In-Reply-To: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 10:49:09 +0200
X-Gm-Features: AS18NWD8uQhySPgdZVvT54DJFS2VbD05G4rr5WTDsYs0mXBgIhMrAJorsb0mOuY
Message-ID: <CACRpkdYcVtJjRHRJ8GgeU7rZDuyaJKu0vgcknb7DsHPjZGKGuA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] gpio: improve support for shared GPIOs
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

I see the big picture of this plan!

One quick comment:

On Wed, Sep 24, 2025 at 4:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> I'm Cc'ing some people that may help with reviewing/be interested in
> this: OF maintainers (because the main target are OF systems initially),
> Mark Brown because most users of GPIOD_FLAGS_BIT_NONEXCLUSIVE live
> in audio or regulator drivers and one of the goals of this series is
> dropping the hand-crafted GPIO enable counting via struct
> regulator_enable_gpio in regulator core),

...and that is what I thought as well, so:

>       arm64: select HAVE_SHARED_GPIOS for ARCH_QCOM

why would we be selecting this per-subarch?

What will happen is that CONFIG_REGULATOR will select
it and since everyone and their dog is using regulator, what
will happen is that every system will have this enabled,
and every GPIO access on every system will be proxied
and then this better be fast.

Two things come to mind, and I bet you have thought of
them already:

1. Footprint: all systems using regulators will now have
   to compile in all this code as well.

2. Performance, I didn't quite get it if every GPIO on the
  system will be proxied through a layer of indirection
  if you select HAVE_SHARED_GPIOS
  but that would not be good, since some users are in
  fastpath such as IRQ handlers, and the old way of
  sharing GPIOs would just affect pins that are actually
  shared.

I don't know of a good generic solution for (2) to be honest,
last resort would be something like runtime patching of
calls when a GPIO becomes shared and that is really
advanced but maybe necessary to get a performant and
generic solution.

Yours,
Linus Walleij

