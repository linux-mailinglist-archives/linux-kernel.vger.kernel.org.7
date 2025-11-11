Return-Path: <linux-kernel+bounces-895181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9081C4D23C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D813618864E5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7A12FB0AE;
	Tue, 11 Nov 2025 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZfXwY8j"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7EF2FB629
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857873; cv=none; b=e3fd46RxzbhSXQ2YecC3LJHlgqcRvAfv1v0VEUBT8jL5+ikQA35PbrFAegCgPifjS+wdZBNxvHMzc1me+hWXyDp/1jXntOfHzIAljUMM4npfl8Bi3W+zFVJHhGlH+a5LDvJo2iqMzbLTc6eRwdWjBpY9NCLVIb/LIZo4D0PYXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857873; c=relaxed/simple;
	bh=9cdWyWvVx1HiMmqJtLkBOepfaD6aK6+e9z5z1DN0zTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGvshZXoR6ytN30jb4z+Cc36F1gE/CPuPDReOJxDTcOGwS03CdMsVyqFeBc1CdNt4/G1yaoxuKf+2ZbCzdympJCxEwVpxXlX1a4lh/2UKrbmighf91VSsvMbFTeeF2EDqUFZ9iPmUh0lTMRpSKSLqyVXUHitiaIOZwp8AXR6fWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kZfXwY8j; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-787da30c50fso26803767b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762857870; x=1763462670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cdWyWvVx1HiMmqJtLkBOepfaD6aK6+e9z5z1DN0zTM=;
        b=kZfXwY8jA2RfIv/beanYlCuNRNHEDnYc6FC7/viUrwd3DhBhSMKXVNQ+LBx54BwxQb
         6bRRD7eO7duzXc/3Vk/cdQsVQ3Je9WCIBmTCXNLDXuCe58WxeNkjWVmYseOlz4Iyvcpy
         2CxO2Tdzj6VYV3p3Zo7KPqusjhQWgDJ7TK4NN8KORD4ZzyMagDHoqPnUWP12U7HEliik
         95BYqbIytmiLh93FTrSVi2AYEMFG76DXmIHRS15zq0lq1ySaJQoNNf7ti93YIdZMKyIZ
         jttvw8xqbhoNduIsu2RPnUnh5Z3ZGTRyXcb+M7uxQZZOpTvbE0H35OiLvsfmz46LUpl8
         yfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857870; x=1763462670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9cdWyWvVx1HiMmqJtLkBOepfaD6aK6+e9z5z1DN0zTM=;
        b=DcYky0Oi5Hz0qSIIA92l1atv7sPgSegkGpWEzlkkNDDKL/0loSImcYTB7J02x2jREI
         PqF0TayWteH1Jyq4SyLljFmAb7xLxCXnVHPEvTSi5hkIt3xdJXSqPv+Gp6gVHEN3kVP3
         ikYK+hMag0NDsKra7KaT+I8jniFCB0x9FrEf0RKn8uka1pJ5mnf5ZsnWBOwLdyqVjszv
         /svwv+ZN5wJxRcT/vvGbqZrw5LqomjAnhmxKa6Z18hlODWXWxfmUvM/IzSPknUukTlbB
         3RYyY8ETkxDyOaK4zQ0FDjJVhucYr/4eNhjxY6WxBTZnI5usWfKCnyQZjATY6zw0Zite
         2dsw==
X-Forwarded-Encrypted: i=1; AJvYcCWFIRUvVOdZGJ2z16xsf7MToH5Teg/ktmqrJXW67laX7WRgUW6LBihVZBZ+cCWqn68xlAhCUXi9cO0asF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvvRKHegGo8iFC7bIwA0yWvPZ/CASUQIffRBAZOA85e0RBCqSt
	HdQYB2sa51K9RmRF6xd2waX9OOg29kwiQ2gWGP/GJkCWGQxI6MrCQLrUUGcXoFu/DBQ/qpNKDz+
	ERtL3gfjm+2V7RBk+TYrePw2pMarDH7nYlReO0bQg9A==
X-Gm-Gg: ASbGncvr5Y99VYG3iIrcgL8eLbddg+rV+IhSW09XPNLUV8qI51+X+QObulKbqh8h0F2
	KPFY0d7dYX5YQpAnaAQE/2CBT7reJZei+QUU1zph78GKXBBRp8mvH3KkuIbeAAThKSLhigRoRP1
	y7orIa5rusu3ylB6l/StlWLlwsBIsA42+of3+CD1v+IZf4sL6bP5pxgBBjeKRSTt6tM9KDxHja6
	4cWooME1X73Nn4rkdCTgp2VJpciPtSYahBbOSt1j2SiR2EfMPy93dEVdkyr
X-Google-Smtp-Source: AGHT+IGM3E/e9Scx4gWocd3epZsySeg+GiSnUa6Lqk3ZWYP/cx+DuGwZohc+rkcKQ1+QYm8c7Jg9lh/z3+tSIbO/Q/8=
X-Received: by 2002:a05:690c:a719:b0:781:32c:b359 with SMTP id
 00721157ae682-787d541c211mr161593377b3.36.1762857869718; Tue, 11 Nov 2025
 02:44:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org> <20251022-gpio-shared-v2-6-d34aa1fbdf06@linaro.org>
In-Reply-To: <20251022-gpio-shared-v2-6-d34aa1fbdf06@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 11:44:06 +0100
X-Gm-Features: AWmQ_bkCgjjs_tm6yJMft7dkXQVENEnuhOT2qvpn5ldswgUFUo9RrRQtDQDlZKU
Message-ID: <CACRpkdbqLyeaZx37yrKjDFWb=C5c=vK6aPgnW8cMQvwi_6Jiug@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] gpio: provide gpiod_is_shared()
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

On Wed, Oct 22, 2025 at 3:11=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Provide an interface allowing consumers to check if a GPIO descriptor
> represents a GPIO that can potentially be shared by multiple consumers
> at the same time. This is exposed to allow subsystems that already
> work around the limitations of the current non-exclusive GPIO handling
> in some ways, to gradually convert to relying on the new shared GPIO
> feature of GPIOLIB.
>
> Extend the gpiolib-shared module to mark the GPIO shared proxy
> descriptors with a flag checked by the new interface.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

