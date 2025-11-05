Return-Path: <linux-kernel+bounces-886763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0918FC3674D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEB5189BAED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE353218B8;
	Wed,  5 Nov 2025 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SfrmACU/"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509FF25F994
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357044; cv=none; b=iq+pCem/6xsVE5WZGKqn295mm8iTgur5YYWp17HetMkRJjnvtKuYbDu9meHPSlckO59i4ILCUB5BeH5p/4wuYUzhEKlz/RrHGThJXfqHPpU07w31VF1XJLBfry2KXv/nwVf4g12E/vqikIXBr8E7uqPd8RWKwcqtVri8e8gt0qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357044; c=relaxed/simple;
	bh=tsjWVsRRSjnvoclSRHwK3diHpWnX1Sxoum+6RmQp7f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irWiGytDXOWqRQ2GscZhlbyfbMkURmtMjUxDTrYzjpqywYm2Se51qZIZm6Y2k3k1LD3cY+7bcc76DNoLxbF66pxXil1ZxuyYE1E654sJDNk5C2jlbLbbKVbsDWaDBP8fsMrAoQl0KWRHw0oGuZKZSm+9xDc+8LrQ99e4rCe0D5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SfrmACU/; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-378d50e1c77so54559861fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762357040; x=1762961840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQVK9c2pVcdVjyDwid4GqvWLwTZQh0fbwLctVK8OiSw=;
        b=SfrmACU/IaruvTLTM/8Y5f58WVjlsUz3ZQgyna9ZhhrN9Ep2dui8B2FZ+RyWkk4534
         xeO9xYWeF9VW3kGPjgYBfkwbACDJsFm1lCwoKdanOMXQs5ZVhvPW+NBEjwAbxT+iO7EV
         CrwDDGhFyVYUKPc2haSUD4utdCPJWiWvc0WpNaL9dXl1IUkpVi1iydp/Eb/trQY/3Jug
         izYn1EY3zvDPy3R8G3sBxQoG4GZ1rsdM1GXfNpz7JSwDopVniUprTcolFZDq6na2KboL
         RBlpO2YCopdLkL7N5kx57yTRmaV6w/dG2CWOgsUe4x8tl/+JOTHdUcguPtGx+cNwZEdi
         4dNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357040; x=1762961840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQVK9c2pVcdVjyDwid4GqvWLwTZQh0fbwLctVK8OiSw=;
        b=bkIo4tStrAjhwbPq9PPHFKlNPqBdix8nEewrN42ydQz1RHPVwtpNMwLyaP3I1NMrh1
         UGUySxt+tOIZg6aqnyy1t/P19eexDeJar04gPxIufMt3lfNed8R56aHl1Dk2UF6HQ2CB
         2SFBXat5dvWE00vR28IxFHgJe8Rui588SQFXglLvnL7YmcUuvqGDMS/dfTFb2qQWvZRJ
         ceTGysepVMiSUdW07Ggbn8gMIv1yrPBJeop96sxnba1XTrNUH55rEe5nRBA2VVAGo1qF
         pBTp8onBIuxnl6pdpWOPbuFSG3kInQiLlJL5jriwIIVrFTCNfbw2+6xGerawBePobZpK
         uq7g==
X-Forwarded-Encrypted: i=1; AJvYcCVvIxJMy4Mnae+ZVE+h99o1oDSw7OUniPM4+jS8+olSytM+2Thjmo1KMrJyp8yO+KAToP7Tg+j2rX8/lgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmVmzaC0trYVCl96TMsOPr5d0N6V/gT1/UVh1vZEgBWUoZHvNE
	NJFi+8PwkKwUneT6uMP/cLGx6IBeNmWoZnxa69Qvw2ttkpMXCtj5uZDBMUitN1aHAKyAVHLe+4o
	8mUsDibpOD+L/YVT1WywWj8EBwz6PJkr6jn8pHNNSUw==
X-Gm-Gg: ASbGncurI5UEBWUVPidUHabWvuJYY9PaIt5lfF0qIdtQ3+b5djOOBjRlYJdLExHQtUw
	h7K8nNZ9HNR6PpjmgcaZiZs/8EmvSQU2Q7HPTcwnVYEt/boiDyu1NK7hOyYxqQjNQQFgj7Ssm3N
	yaqMFHmN4ALjUS8uoVP1UhoqnwhAWKV5IezU2yhcy6g9H/F+8CXKkozyEndOvCb3BU/WvboCFf6
	Za/K4knGLOfev0uEGtGykINtPC1JNtCg2TuuzvzUuFHjC2DSRCkZrXzaeB4MmiknaqmwCTI3IUo
	AVkjuCZ0Hnbf93Ky
X-Google-Smtp-Source: AGHT+IGZLSyHZwdSHoXOFtP2iNbjQMFV/+/RajiafeSS7vcfUC9MhdnV6BD4cJxWmnaWMlh79AK6+5Ypz4lKmcTRIqk=
X-Received: by 2002:a2e:b88a:0:b0:37a:3412:1415 with SMTP id
 38308e7fff4ca-37a513d8404mr11832991fa.8.1762357040210; Wed, 05 Nov 2025
 07:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105103607.393353-1-jelonek.jonas@gmail.com>
 <20251105103607.393353-3-jelonek.jonas@gmail.com> <CAMRc=MdQLN5s+MpkLUF2Ggc4vYo30zOXrA=8qkGmXvu7N3JjeA@mail.gmail.com>
 <12efb5b2-058e-4a9c-a45d-4b1b0ee350e7@gmail.com> <CAMRc=MehBmd+-z5PRQ04UTWVFYzn7U4=32kyvDCf4ZQ4iTqXhw@mail.gmail.com>
 <74603667-c77a-e791-d692-34d0201e5968@axentia.se>
In-Reply-To: <74603667-c77a-e791-d692-34d0201e5968@axentia.se>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 5 Nov 2025 16:37:08 +0100
X-Gm-Features: AWmQ_bmO335tsrm3LPxOxIYQ6LeZj7W7E6BVgAdcHPrSnLlU0JTYxziQYjrCYrc
Message-ID: <CAMRc=MdkkRnwxx3vcMB3duOteQNdC9eb+A1P4GActou=xY9yJQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpio: add gpio-line-mux driver
To: Peter Rosin <peda@axentia.se>
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Richard <thomas.richard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 3:19=E2=80=AFPM Peter Rosin <peda@axentia.se> wrote:
>
> Hi!
>
> 2025-11-05 at 14:24, Bartosz Golaszewski wrote:
> > On Wed, Nov 5, 2025 at 2:23=E2=80=AFPM Jonas Jelonek <jelonek.jonas@gma=
il.com> wrote:
> >>
> >> Hi Bartosz,
> >>
> >> On 05.11.25 14:15, Bartosz Golaszewski wrote:
> >>> Hi Jonas!
> >>>
> >>> This looks good, I'm ready to queue it but I'm afraid the consumer
> >>> label "shared" will logically conflict with the work I'm doing on the
> >>> shared GPIO support[1] as the shared GPIOs will appear as proxy
> >>> devices containing the name "shared". Do you see any problem with
> >>> changing the label to "gpio-mux"? I can even change it myself when
> >>> applying.
> >>
> >> Another name is fine for me if it conflicts with your work, as long as=
 the name is obvious
> >> enough. Not sure about "gpio-mux" though. Maybe "muxed-gpio"?. Just le=
t me know
> >> what you think and if I should adjust it or you do.
> >
> > Yes, "muxed-gpio" is good. I can change it myself when applying.
> >
> > Bartosz
>
> Isn't that the name in the device tree?
>
> Is
>
>         muxed-gpio-gpios =3D <&gpio0 2 GPIO_ACTIVE_HIGH>;
>
> really satisfactory? Can you really make that change as you apply
> w/o a re-review of the binding?
>

Ah, that's what you get for revieweing with a fever. :/

You're right of course.

And yes, we'd need to modify the bindings.

> Or, are we talking about
>
>         glm->shared_gpio =3D devm_gpiod_get(dev, "muxed", GPIOD_ASIS);
>
> and
>
>         muxed-gpios =3D <&gpio0 2 GPIO_ACTIVE_HIGH>;
>
> ?
>

I would make it: glm->muxed_gpio =3D devm_gpiod_get(dev, "muxed", GPIOD_ASI=
S);

Jonas, could you please send another version with that addressed both
here and in the bindings?

Bartosz

