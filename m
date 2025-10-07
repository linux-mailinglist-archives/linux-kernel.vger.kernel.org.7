Return-Path: <linux-kernel+bounces-844243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ED3BC15D6
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A2EE4EE92F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D5D227599;
	Tue,  7 Oct 2025 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LdleBcLE"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1462DC330
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840157; cv=none; b=WuD/VRmn/Ex011QYbxZAENvx/4tDaumadyOGuPqzSRnQrJC5lrFi2efzu6Yovi2d8rXwx/0uMk+pvJaz7zOsH8mnOz8vuYYjq672ab9EU46wAE5o6KnrTaRCxIpbtzWNkjfGtwDRmXU6iuwpp7PiUE6wJupN4JC8idBKDbAd7Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840157; c=relaxed/simple;
	bh=EnIFXZqKjMmu46oO94pEByawVJ8hwocGBr4EM7AEbYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDbt3zYIp+92SvBwwfM7ShFavsBS1FJ2WiugFPYKsW53pIvxU/YFz6jWGI4X3mx5ieYKjfHpg1x/GlhB7r2yZYgVXmRHYhqmZe8Jmgyx4E1FkMgBVit3nGnptDHqziYyCmSj/ZbRuvS9DM5zaZWr/SvlSCrVTk0HTzmGkNGMmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LdleBcLE; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57933d3e498so8494843e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759840154; x=1760444954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnIFXZqKjMmu46oO94pEByawVJ8hwocGBr4EM7AEbYM=;
        b=LdleBcLEXMPxkGZZ4IH7OHM1RCEfGKmTVWJ7BemZ0ohKWk3OZepLgJvzL2xrSFg4iW
         CH9OqqPR5znp1hzBs1NwrthbL8u9+PG0T5BZ3zcpfTsOtAYzDaU7qkEbOC1HKo1NPJ7d
         BuUkAPFGSIqB66oOCyrgods7ODqHz2NvVn2LTnCJU6Y+sdpB740semCvRU3NHwZcPnOM
         J7LqBsetSjjrQJB/xYTgdog+u9uwGlaEy3wS+YasHk3chLzB0brWBFz6xB4bgPMQiu50
         QGjKVnRLaFQIWA2hfnFCQ89dwUAJL41fACPNVmbBoEbTPq9oDn2VIh+wl/x1aGZWmHwk
         GwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759840154; x=1760444954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnIFXZqKjMmu46oO94pEByawVJ8hwocGBr4EM7AEbYM=;
        b=qi1YQWXstjxTHDPlZy5U/CYtTb7jZ6RMHibwtPytCQGpyp+GaKzHwVryGtYPRkJtCA
         gAGV5RU/ffT8jXaqwXyCV8FuKG2ylucSxaQSt2UyWMj40zfOqwY8SH5R3qB+CppUZs8l
         w0My2f/AyW6VzLVPVAwGiVjtOuAmWGeU0OcNy+QfHi/QOsutFUJBf1fMvN2WGCLf5pvP
         iPtH3rbi2fykEM+/as7tEDtflrd7X8glM6pqAEWXFr1WluokeHuT/YorE+j0pvAhYA3P
         OL2UJ7fA5WL2NvMSHOpKEHbWJdsGNOYjl8+SZJ6EhoANLNf9bjUPsycELVhCBBlD5Q1+
         FJvA==
X-Forwarded-Encrypted: i=1; AJvYcCUd48xert17ouLSksy8Wg0pNA7N0NfD28wsstCtQlSZtV+bdKsKh7uK3RNhlh4h6+wxO5GmIUR0ChNrxC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRLYXD3MDS6dINEYZxNqOsbp3NfaT6km88ZOSOSGICWV3OOf2C
	YroXmID/3ff+MNOgCIZE+uiOvFDzV1UH8wNI+GRtuE6sVJa0wAm6+3Nx/Kgt/oDJcntbLXb5UrT
	F5qd6BHpHa1n1Gs9RBTOVQXfMHCi4XSLBprLvzPyvbg==
X-Gm-Gg: ASbGncsqBSeRJ3e69E2S1UjYyrkhVVjI5w50/W6MST5REOfDr1J/IMC5NxDZHx7AWWs
	IpXfgEHe62h7/v5l7g5mHDVhXUEtYUsjdHu7F8SsNAZcTyOJzSyItlVF0jIg6sqC1QnYqlU8pzC
	vqbhhNlDihlntw8IwYwnHArjd6JaibaMIznGKAYG8n3792N8mHvdtrGmI1kMTVMq6W+7RAg2HSt
	WsPTV/OxmwM7aK6GksliZtJD1NPNeBkJjKQaLuWW3aRc9OTBlCNtBVybAbEhSg=
X-Google-Smtp-Source: AGHT+IFvEXq4IGvOkBEwLnkFzMNYQoqXWta+MRuNZ6zy5QIvEZlr/9df2gaJ9h0Z2yhh4+vKPvuKBvTOlCdfwhpYHf8=
X-Received: by 2002:a05:6512:3e2a:b0:55f:6fb4:e084 with SMTP id
 2adb3069b0e04-58cbc776474mr4804386e87.50.1759840153971; Tue, 07 Oct 2025
 05:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
 <hyzzrjn7jzo3tt3oyg7azijouawe3zopfjzq6zfhoo6e6z2m4t@ssl5vl4g557e>
 <zk4ea5cibrkp4vttuy4evrqybf76b3nop5lnyck4ws4nyf2yc4@ghj2eyswsoow>
 <CAMRc=MdWmO4wvX6zpzN0-LZF1pF5Y2=sS8fBwr=CKMGWHg+shA@mail.gmail.com> <rfr5cou6jr7wmtxixfgjxhnda6yywlsxsei7md7ne3qge7r3gk@xv6n5pvcjzrm>
In-Reply-To: <rfr5cou6jr7wmtxixfgjxhnda6yywlsxsei7md7ne3qge7r3gk@xv6n5pvcjzrm>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 7 Oct 2025 14:29:01 +0200
X-Gm-Features: AS18NWAtiT9xc4AHDK2XxNjFXsHbeG0TTtUUuLHamMaXYLyXs_iBH5F444RGyw8
Message-ID: <CAMRc=Me9Td5G9qZV8A98XkGROKw1D2UeQHpFzt8uApF8995MZw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] gpio: improve support for shared GPIOs
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
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

On Tue, Oct 7, 2025 at 12:09=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> > >
> > > Not always... For something like shared reset line, consumers request=
 the line
> > > as GPIO and expect gpiolib to do resource manangement.
> > >
> >
> > They could use the reset API and it would implicitly create a virtual
> > device that requests the reset GPIO and controls its enable count.
> > Except that some devices also do a specific reset sequence with delays
> > etc. That would require some additional logic in reset-gpio.
> >
>
> I was referring to the PCIe PERST# line, for which the 'reset-gpios' prop=
erty
> already exist in the schema. Now, you want me to model this simple GPIO a=
s a
> fake reset controller and use it the PCIe Bridge nodes through 'resets'
> property?
>

No, not at all. It's just that a shared `reset-gpios` property is
pretty common and Krzysztof implemented the reset-gpio driver[1] to
address it. Drivers that request a reset control via the OF interface
will notice that there's no `resets` property but if there's a
`reset-gpios`, the reset core will create a virtual device binding to
the reset-gpio driver which requests the GPIO in question (once!) and
registers with the reset subsystem providing shared reset control to
users. Basically the abstraction Srini mentioned minus any reset
sequence.

That only happens if the driver uses the reset API. If you go with the
GPIOLIB then none of this matters. I definitely don't want to change
the existing DT sources either but I want to find out if the code in
this series is suitable (with some modifications) for supporting the
PERST# line or if the logic behind it is more complex and possibly
requires separate, more fine-grained handling.

Bartosz

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/reset/reset-gpio.c

