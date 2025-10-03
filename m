Return-Path: <linux-kernel+bounces-841102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A354BB644E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 10:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855DA19E80C7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6E72765E3;
	Fri,  3 Oct 2025 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="m8AHGWe8"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F731804A
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759481506; cv=none; b=SBGqgAbDNmokT9DON4v/HRflCUYpgE8F/287omoSFHWS5Zf/I3hnPrjZZ5E2F3QeFI0wFZaSH9ycW/jQ/dMeQ1pNqs9XhqoAn2ZvQ9FjF3aoJqPjkEB4zpYRSmYJlpngNTiIG8u1pLBa3X56gZnQhfR9NZrIK9C7EbUf0Fp2Cvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759481506; c=relaxed/simple;
	bh=x2XT9zcVh7kzpD0X4tRTqt0/foxsWPu3XNzZKS/xTCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGUCsXeHORWH0qq1ldxY4ArW5jGdAMrpwFvkYw8vEBCjqq/4UX5UlGlIaXRrLPr/hu9Bn/QBP86Tm2HdqnHOzfE9fMjSYeceyHH7NgUkim99gguJjYRKg3ChVo4P5qxXbAjjyy/rQiD6V6eA+MvQS/0zv5QbpD7tqnr1uC2szVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=m8AHGWe8; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-367874aeeacso20643991fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759481503; x=1760086303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmsmH87Q3nsWkYHojOW1pGLDSq47SZ4os0x3/+bAd08=;
        b=m8AHGWe8HvKSi7+9lYUVf2aMm16iHSkGGiFtwoQNHZgfx+2da1ua5h4lsvrCEf3kgT
         8aO9ZQO+vP/KFj1w5aOcM10ArD2WvZX57bmNXwMYsd4keYfskgHkwNlGPRVW69h6jZ4e
         ddWQFbDOkoTUggQpqzHA436NhCQtWOtsbb6uYYqIP7gOij2WqKzM+NiCav1naoZQyYsk
         QK1J4iKhXr/o9ClW4mdqRfuzhpIWaaLqpaMhXTDoAd+ZZ//dpSj70i5qxPzn2oDwZG9N
         CIXyAMx8DeOJBEU1Mfs+FTo744x58MqMlX620xpIEyKPJwJY7YqCGxFkA8/IOyt7bOSi
         oHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759481503; x=1760086303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmsmH87Q3nsWkYHojOW1pGLDSq47SZ4os0x3/+bAd08=;
        b=QhS2Q1Pl7q3Vm9fIqf0YoHWgS0FfAV2IcfoJBP8xf5yB+oGG4WjDrKJIpJit6b42hg
         nv7eIgsFeM7wtYN/Klmlf7QeIJnGeoibJBkSTo4+0+3ptB3kLnBN+K8HEseOgFHOie4z
         85tQ2x0T8x2kKkeDylrZxZwIBp1DXV7NPdvWuqklQ9qSsZfFRzsb8lmuBZWMS30Rl3TZ
         SMtje0TTvr848Kh8wOHbf+oCG/44RwfbCF0LIp3WEXRyVLTlYd8dyDwRi0q35ryVAbY0
         ffozqu7B3PK9kd/52yKjgnzXfcLpRjODya6hJSOMeJWbzUmlU7MYUmY/cnsTFW/lhcK+
         RMew==
X-Forwarded-Encrypted: i=1; AJvYcCWGRfa66w+9PQwa6L6lgrnsOd4x+e0O7bKMOTcieizFXHURr+rSWYopd802I5VsAxJSNODMZ3u4HOhbmH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAsp7bpBTXLrn+dHz3T2KX7t+KsLDNBHgIIy2GvkcMDOUIBSXh
	tM3GKfqHYat7dYY2AZrL5q6TFXtAIp6Hph0F1H59AY3kmBp40LXOFIDQEBEZEuHXfdLT/XSO0Dt
	mb/TZKfkrLlUfPejY9QQzQoRYS2S+WnoIBia5Qi4eDg==
X-Gm-Gg: ASbGncvSuMfkhqigBKabw3RFUFW2TK7vbIeXoTi+iISElBPeVSgOi+YgWKM5/oVlYxF
	o4Wlm/EWaULO8ldnjKvN5/x24W5Yfbl3+OLkGnPYFVTrrAMVMx3D4fMZEdl+mZ/u+mwCNsW5Dqe
	CrDsDwQP+/SGZ/yfKcbk0OQOeQXbBFyDdoyXh+xib3cxDDgnTQKSLzVr3OUAJ27Hp47hwGX0Gz7
	1a1jMY8vANsTEPdGHOkACUgfOacjvYBIqHg1UMHulyCU1rVUrju+JJZ9mvqwA==
X-Google-Smtp-Source: AGHT+IGpVFhYHvvmq0k22AePxJXM3wxZnhvCRYnHq9Pngg2NH46casC/4XWUD4nLAbqyQDtuHaatgzMh2vzh8d67flE=
X-Received: by 2002:a05:651c:12c1:b0:332:3562:9734 with SMTP id
 38308e7fff4ca-374c36c07f2mr6231941fa.8.1759481503006; Fri, 03 Oct 2025
 01:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002215759.1836706-1-markus.probst@posteo.de>
 <CAMRc=Me3VLbmRksbrHmOdw8NxN7sxXjeuNFb9=6DzE=uLn0oAA@mail.gmail.com> <7f4057f25594ac3b50993a739af76b7b1430ee6a.camel@posteo.de>
In-Reply-To: <7f4057f25594ac3b50993a739af76b7b1430ee6a.camel@posteo.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 3 Oct 2025 10:51:31 +0200
X-Gm-Features: AS18NWCIhQoF-dv9QcLF1nIcoukTH-eCETtxxDfQif9_jQZhzC3c7G8RkGTaXOE
Message-ID: <CAMRc=McioBjF3WCBu0ezzuL+JJTiEpF2fz1YpbToRpijpHfAEg@mail.gmail.com>
Subject: Re: [PATCH] gpio: of: make it possible to reference gpios probed in
 acpi in device tree
To: Markus Probst <markus.probst@posteo.de>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 10:40=E2=80=AFAM Markus Probst <markus.probst@posteo=
.de> wrote:
>
> On Fri, 2025-10-03 at 10:03 +0200, Bartosz Golaszewski wrote:
> > On Thu, Oct 2, 2025 at 11:58=E2=80=AFPM Markus Probst
> > <markus.probst@posteo.de> wrote:
> > >
> > > sometimes it is necessary to use both acpi and device tree to
> > > declare
> >
> > This is a rather controversial change so "sometimes" is not
> > convincing
> > me. I would like to see a user of this added in upstream to consider
> > it.
> >
> > > devices. Not every gpio device driver which has an acpi_match_table
> > > has
> > > an of_match table (e.g. amd-pinctrl). Furthermore gpio is an device
> > > which
> >
> > What is the use-case here because I'm unable to wrap my head around
> > it? Referencing devices described in ACPI from DT? How would the
> > associated DT source look like?
> In my specific usecase for the Synology DS923+, there are gpios for
> powering the usb vbus on (powered down by default), also for powering
> on sata disks. An example for a regulator defined in DT using a gpio in
> ACPI (in this case controlling the power of on of the usb ports):
>
>         gpio: gpio-controller@fed81500 {
>                 acpi-path =3D "\\_SB_.GPIO";
>                 #gpio-cells =3D <2>;
>         };
>
>         vbus1_regulator: fixedregulator@0 {
>                 compatible =3D "regulator-fixed";
>                 regulator-name =3D "vbus1_regulator";
>                 regulator-min-microvolt =3D <5000000>;
>                 regulator-max-microvolt =3D <5000000>;
>                 gpio =3D <&gpio 0x2a 0x01>;
>         };
>
> - Markus Probst
> >

Krzysztof: Could you please look at this and chime in? Does this make any s=
ense?

> > Bart
> >
> > > can't be easily disabled in acpi and then redeclared in device
> > > tree, as
> > > it often gets used by other devices declared in acpi (e.g. via
> > > GpioInt or
> > > GpioIo). Thus a disable of acpi and migration to device tree is not
> > > always
> > > possible or very time consuming, while acpi by itself is very
> > > limited and
> > > not always sufficient. This won't affect most configurations, as
> > > most of
> > > the time either CONFIG_ACPI or CONFIG_OF gets enabled, not both.
> > >
> > > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > > ---
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > >

[snip]

What happened here with your mailer?

Bart

