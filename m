Return-Path: <linux-kernel+bounces-865087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCA3BFC38D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA92624A50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A9B347BD4;
	Wed, 22 Oct 2025 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDVnjz5j"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5367F347BB8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140050; cv=none; b=QtZBZBoRMJNAaGwyvbEAIn+Gcdrf0BOYcEbQ0wbX2RMn8vGpn0jMiNUfwmqmbeq9ECcyfRMQzbtAPvr90TiY5Z6dQwqQruxE7DHoUfD+U6kt9p2xk5a8AQkb6ZLvjc6CUjRIZCiT6+qiG6KCtKLme6CjAwrD4RomZSt67C5rOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140050; c=relaxed/simple;
	bh=gWtnyZCMZ79lGvtHTyeCn/sxtckldijN3FKie7XpzK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2OVBBSVFL8l0/TU81QqxeOKODjEYrt4I5zDKYr2AsdSvOpo3k9JzRlLLzUVqL5Om4yXmC1RQTVAhWQI7Kpzexpd4IvxARksNG54BAWGetDU1wJU0RqPlawCYc6P319KFeZ808yJbMT86AhHzzAwEiZnF8Q/2HBjGaDAZboUxD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDVnjz5j; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c3d7e2217so9837766a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761140046; x=1761744846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnDab3MvBR9d06ZmEVci9R2LEo8WZZltTef4oKgMrxE=;
        b=CDVnjz5jqOsaNOGf/xUBqTdky530gFLOTueh497tFpB3jkwYJP28o/3s45BjwsT3qr
         lxtZZfaUu9NuRQXrZQus0kZ+fVkvLKEZlTTPAjnn8L1AK83eyuMn7Wafr0Zx2aPo2m7B
         fOksJ515XZEh3M9ikP0Zi6ABQa5qKlirVffuN9zigqowVSbr8nMHixoqdkvTuY6pM1iV
         fQGnCgY4EBxF4s+0B7aI6fKEQq3+tw0kG1+xMoUyanJoZ+Fu6ARAN4wIWfTxh39VwOFr
         Wx5ZbOHMR6GU5w6ATE1Pq8Wi+CVOQETUwWCPGLKBJ6FEJg3fmGgB3Tv6eWF5BzUXgSL9
         dcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140046; x=1761744846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnDab3MvBR9d06ZmEVci9R2LEo8WZZltTef4oKgMrxE=;
        b=s/eJLpU7K5EUnFZpEJbVC0yYbik6MaZjBtJAAvLvF5ji2T0QLRkQnDEsAdFbINr0b2
         Hu2oaSgLov+EYaOnHRh7bPL0eLOdhFInDoLA8vURDgG7GIkXC0GsRAylmWVaG2JxW3d7
         N5jx+8M5AP2FaO9GICL3iTjgwNU+xJtrgFhExyoEhQL6LHcbyAaP9OvA4guUvjeATrWv
         I9ABdmRXfuNayHRZXOCoZwNPOe//Fn7yiU7F6JmdaT1ez0LqN+YT3AjkUrB++Ab8xKiN
         KAuATy+KeR/ZmgYWKUrDhp8RL3lvq4kIyTZJExAyYO8fZfBRIYWCQIf0X1EOCEqRVSeF
         Y1fA==
X-Forwarded-Encrypted: i=1; AJvYcCW7MAcWk7fI0cBf2pt7L//nL/Wm9xWLC714CChN6zfgs1eGouwoLYGcU2SGVGWtXV6ASzknmB3MD2iMpAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+7Hf7E/PoG1k9SQfCneq+DAdECtarO9iTJrtYrgt8Yt8MlOSL
	v6gOktK6Cbq2mrnbjvNWJPEKwB/5BuVmMGryIQPUvIQqXs5EozBbmOvvnjRLSl0Hm09CnXY45uO
	usF9gDxWewQjzZVtc2hHi6Sqszz1iE+I=
X-Gm-Gg: ASbGncudjkHsQI/08fg8AAIND2xPM553MY2yCJAYIZqeElbsZ012q06zoWZyt2CeDr+
	+zZz4vZlIUNWM5Ngm6KOPbXKf3kIzBATzDwmc312pVfYR8gXQEqvBzNaq3MmTMYVKe2NrG80QQR
	FIeULKZexiIdjiUR6VhFRNBRsg52GClpkA21WRasWHnM1CJ+Kv/UowrYUUjFYBVf5oTu7+aoFgt
	9iQSMcBq1YskWq0n1ULlPxyBv6CS0MkFEgmKhS/FG2RGcHJfS9tS78/fnX5IzCC6H+0FjKH
X-Google-Smtp-Source: AGHT+IF+bGnEQc856DkdZpIAOaRV7nKVJQZfv8gn2VCNIJnjHmyCsahfWQqIidtzCF/ZoRQsNWSOtm7llM7J7h8TBP8=
X-Received: by 2002:a17:906:7314:b0:b45:420c:81c0 with SMTP id
 a640c23a62f3a-b6474b36a46mr2340985466b.36.1761140045360; Wed, 22 Oct 2025
 06:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org> <20251022-gpio-shared-v2-1-d34aa1fbdf06@linaro.org>
In-Reply-To: <20251022-gpio-shared-v2-1-d34aa1fbdf06@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 22 Oct 2025 16:33:29 +0300
X-Gm-Features: AS18NWD8eeQXjXIPK4eXDVlSVPojwJxWfrcwXD-jC0yt5VNiNWjvrq9EAmjuWt4
Message-ID: <CAHp75Vewc2OoD7=eoFtrkPrGRuB9ZGT2vu4Z_wdHZUDZ8igUtw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] string: provide strends()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
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

On Wed, Oct 22, 2025 at 4:11=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> Implement a function for checking if a string ends with a different
> string and add its kunit test cases.

...

> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -562,4 +562,6 @@ static inline bool strstarts(const char *str, const c=
har *prefix)
>         return strncmp(str, prefix, strlen(prefix)) =3D=3D 0;
>  }
>
> +bool strends(const char *str, const char *suffix);

Why not static inline as strstarts()?

--=20
With Best Regards,
Andy Shevchenko

