Return-Path: <linux-kernel+bounces-844281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B3BC1727
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCEF18965EB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407DA2E0910;
	Tue,  7 Oct 2025 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OpkeMj9c"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7172DFF19
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842825; cv=none; b=ik1NE87SbbueV8lOp//9QCvcE5NGRHH0PQ6tkfsCeIRNvGtyEyD5MVzlzpfckaJw12bc4mtP6SBNXQooc621ddQTbnlroip10lLNiBlzPNxr7WaqVEw3EQmRy210ykgWJPdvozSKtSjzHxi4r2gmIk//3eH5IFiegkPdyPhJRgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842825; c=relaxed/simple;
	bh=t0N+x/VGNAQttY2sxorx9dZNMTxHZKG1OWxQ7z8PFso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edu08al1YjEULR/HreqRDyd99b/5pCxf0Anc/7pW+4d0/1zlzYH+MSEGXwzGJH15epM9+SvSxUhXVIiUWZWbTRuEofDwExlNZswY/TeDtaPdv46kYQcqe+nWY4vY/3peaBCQot6oa8geHZf2932NCUJNqR3PF498HJtWpCTeFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OpkeMj9c; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-36ba647ac9fso50165761fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759842822; x=1760447622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0N+x/VGNAQttY2sxorx9dZNMTxHZKG1OWxQ7z8PFso=;
        b=OpkeMj9cbEuqd2iTllQwOT9yVdO2fmEEfS/m+hUM0tUHgN48mBoIkT9BLHmLCL7Wlb
         1I4Wl4IqdVR7OrwMlzUdgd2raaJAlK+p0VBkNvpOODbVkbOslgiYx7G5jMQzGM9jdWKF
         FiVgfSs/g3PoEGlT4PO2KF5C0QOpj3sXe4xDurS7S/SlJpbZ9vXXC5lihfFxMDyriyy1
         ooeiOGOPQDcAchF5JGqJzFx0H/4WFsylmkV0hcQnJCR5bOxvJcFA1UxD7SrZ0u+87u90
         ODudjpiY1i3XQEsYtgz7Hog3C8bUp0VzKEpfQJUtinC2s6OpzK6JOSILBD8EsvgMkr74
         dTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759842822; x=1760447622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0N+x/VGNAQttY2sxorx9dZNMTxHZKG1OWxQ7z8PFso=;
        b=pcLjVMhheQLhtp6HrywjLcGpaygyDbiEyherALktkr1prb950hu758KxTMDd9Y8M7O
         NnnBv+LC5h5Z3vWpS/QWzFA4ue69c1qQ8RiEh3Vp77TiLH28vLPbQ6QJoVZFgOQzjCp6
         igTpW5jy/ufbDwxRTUSjnmqiBaTAAB7iiJkJG1EbPYvS44LdIoylO6Zj0/NzIk0wB0i8
         4uozhiSB5Mxqwyl4+IcogRvAK6pJ4zxfBMFazfrFQtfa+ztcptrohbQpFeMk5zQkkc0U
         DoKZcS1Qv0tzhQs7vTmE4MO8Qm1DQWXSRptnPHbWlG9RGEUlEw3+V4F3jAG7QTexiDHR
         6spQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGt1wrtRxxakzu8k/wDR69it82MqnwQ3W4mEIrGSn2zGmpOf+9QsfYgNPBtHIXzpnHH89cgjB3m5M1oNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbv6EL/Roltc9f/53BCnPVAQQbiqmiGXO8WA5LZ7zQSRK2GAn4
	WKHgKqkAqRSwl8nPo1DD0G3q5mq+AuRmb5PdNdjfyP5xiVqkAh9FzYIXzRYL7LuVJbCtXNplO9n
	nQHWjgz4EC0331ziB9f/VOgzhZBefQr2E+EDaDs0ojg==
X-Gm-Gg: ASbGnctWKyksExhsKFAQW7tAylBYlLNr3bKha8GeJm0uvw456ijGakTFOs+bynqcR2+
	N7T0GPoj+iMalTzu1zkU6o+wsMLiUijLGW5W0IdGr8e+UyZjnyh/2/b6tj39oDi2gJO4EIKFljZ
	HulGtCEa031lruEdLIf8j3p6bInpfaTqpBot/5aSSa09qUCFFVZ8cbFEaqK8LUDGqgXzcoJ6cJa
	jY1EI1K/Klv+pDYjmO3BFV4OlULwVhG934VU90FNnMQKNKIHX3ii3BKUlIAozQ=
X-Google-Smtp-Source: AGHT+IG7P5Lsywws5bBPOT8E7JIpupmd0eu9fkYQI1gC/FvLSNAcnVdx2QxXsM+KX1p4mn8AU407934CqwjnV4QazxU=
X-Received: by 2002:a2e:9a14:0:b0:36e:21a0:f212 with SMTP id
 38308e7fff4ca-374c38477a4mr56218171fa.29.1759842821852; Tue, 07 Oct 2025
 06:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
 <0b402bba-0399-4f93-873e-890a78570ff7@kernel.org> <CAMRc=MfwEHGV-HZQURR3JNg1HatAeWO17qbRmkWUXTSBWj5jSg@mail.gmail.com>
 <80347dcf-419b-489e-9b0e-d901fbacc71a@kernel.org>
In-Reply-To: <80347dcf-419b-489e-9b0e-d901fbacc71a@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 7 Oct 2025 15:13:29 +0200
X-Gm-Features: AS18NWAq4ASQRRUa58ojinY89n-hm2wwAP_Re2fgpRgz7dBtx-tBmKEba_o3nR0
Message-ID: <CAMRc=McaZV=tUkzDGMYxXqkuEYw_KasKcv8QGdjw709UYZuGhg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] gpio: improve support for shared GPIOs
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 11:55=E2=80=AFPM Srinivas Kandagatla <srini@kernel.o=
rg> wrote:
>
> >
> > If they were called "reset-gpios" then we could (and should) use
> > Krzysztof's reset-gpio driver here, but we have many cases where
> > that's not the case and the names (and implied functions) are
>
> Yes, these codec drivers are due to be moved to use reset-gpios.
>

You will still need to keep support for the current "powerdown-gpios"
property in existing device tree sources so that doesn't change
anything. And what about shared pins other than reset? 'dc-gpios' for
display, other 'powerdown' instances, 'enable-gpios', all kinds of
uncommon names like: `dlg,cs`, `wlf,ldo2ena`, `speaker-enable`,
`maxim,enable`? It's not likely we will create a separate abstraction
for each of them. What I'm proposing is a sane, catch-all mechanism
for shared GPIOs that right now use a rather wonky hack. Also: the
drivers have no business knowing that they request GPIOs that can be
shared. This is why I want to hide it inside GPIOLIB.

Bartosz

