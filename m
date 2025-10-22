Return-Path: <linux-kernel+bounces-865375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A84BFCEBB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BDC74F268A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD5434C9B1;
	Wed, 22 Oct 2025 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="L12t+1rE"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866327281D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147412; cv=none; b=RFy91q0lWVqtgJmkFoOTUxRSn9qk8CJPYHxcHv5frT6Vc5JLWmCnK7hiU2HCpmAjQH6FMmwqVmFI9BzDz8PlWpzyr7CDFfraGi2fgr4+kiHEbtmxYm0sDwXwe4N0eC4hBeIyw20cO+m/Yd5sv3zKZkssON4PUsMvkV7HLfduP40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147412; c=relaxed/simple;
	bh=voJSs7Hw3Wl/EZaQou3RkTgu4VdQyS/EVwb9Mp9QVNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfTnHeAdCV9nnYtFCJWJ1wlljknDXaoYGKxruZXYkksM7TjbcgNOQSgDGl50E1xIwpNuAHuYUDeeauCMSUz7WE0q/rE/ciWnRhdc93I/iJ7WrZp63++ynMQxRqbThkA54VUnd7fF+JIlrTdj2JHCS5cgZZR1hW75vZinaAzmGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=L12t+1rE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso6561753e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761147406; x=1761752206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRzlJtgmeKcllMySQlFgaimNGUEcv2R+GqjiMHEJzN4=;
        b=L12t+1rE+8f9f2Pii8C/PIdRs9UoviXh9nOuNQfciu+K6ySdJHYZaubI8Ar0qund4h
         87cLYIm2isV0LihywDTjrUE33d2U+F+uSNel4OMVteAUWqf0NhsWuZGk//KVBBzthMBJ
         W4fB8wRsqMKZBHbuNv4Rq3PwYFsdylxTWDHSw9FcnkCog+tqej7kEXIUGk9df1LSVmCO
         srJ/y9tNCneiHfOQ4AUrXz6ZT4gF/cjiyLsErvxX4C2dZlZ/o3e9gTtiaz2Nyi7iuszQ
         VuSLCt8QoP762tAXBhLqvElEO/Tszi67Dds/nmxWBVMdZeiozzYZ7buez5BkpisZTuFA
         9tgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147406; x=1761752206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRzlJtgmeKcllMySQlFgaimNGUEcv2R+GqjiMHEJzN4=;
        b=VuR8nRiUd+d+PaL9dOosvv7aYoRNeooZjsCU4Dwlx9TVtZ56ww9KzGQOaHit40ZpI3
         PMVear7SXYXtUXJjV8hCHAxDiX3NF+aM8tR12xVSPoxYmZquVW6EwxPZ6mpavGbrkkML
         PzT82a5gUoC/gcZ/VZjr67irNHJlp/UVBupOvlfchn1q5hdT0D7vM1VjhiEjSPWG7vbS
         BykW1p5jF8rn0WOgVAASRuwiBCU7ehS+aK+m5zKhhazUX/Kq64kCqeUnwbr+ILxMSRea
         hE9EPu9xCyTe9u9g7LfoF4CExsA46f7RtZe3fjWPf0I6aLxn4DqgmLkwgb8a/xd7q/nq
         NhCA==
X-Forwarded-Encrypted: i=1; AJvYcCWkyC6CVwd+PQgJMYX252CAZD6z888MTC3o7GEKX6A2WUHUEcrTtEtsjeLfSeC9aBkeEnwkO5wk5fhR8g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwybtDOw4AzskjxqKcXpaWCJVRI4+QXjQzc3g5S69kFyRivapdz
	V3PiHUAn6Us1YcUtrNpw/arvmKD82l3Q14PeabxhKUIEevDb7GDr+yu1P7AUKu9/I9+peCCyn21
	raUKeInXe0ycOfemT2kOxB8OA30A06wmH0c0cevEx0A==
X-Gm-Gg: ASbGncuBt7Z4a6nIY0AApvildLSqxsqFeSQlIu5edUm9mkW8Cdc0dQdp9aJiE9t9vb2
	EsB2ohhNUtt2KsD+W7ZCWHulodtGG0+wrWwYa2+1RUlibxyZ9uaRzVEZ4cbErgHLc0XR8Lmt+B6
	YQ7SzMPy+SEh5idNDvhrtXKkecUGYPWWbB6vu8dplxWbb64IVvHxVH+oEtkLWKXZdZakfmlpfbn
	2jaPPWiRx91UpA8yM2F5/VvY11SZlqJ2WypJZP2p2k2Jo4C3PfV9JTHbsWpeIrzwTXsIzGWjrnG
	RyoG5U61DHOxvWVDDkglPfDzGZM=
X-Google-Smtp-Source: AGHT+IEi/irswdy4VVxLlO1hAN0Zsc9fjvuDKRe+i2ePli5jYREx+Bc29gt/0YVceCmzNFvpblDZjtrVlJp1Cz69730=
X-Received: by 2002:a05:6512:33d5:b0:58b:151:bc12 with SMTP id
 2adb3069b0e04-591d85a4b54mr8169026e87.51.1761147405947; Wed, 22 Oct 2025
 08:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
 <20251022-gpio-shared-v2-1-d34aa1fbdf06@linaro.org> <aPj3fCYj-NQdDSQT@smile.fi.intel.com>
In-Reply-To: <aPj3fCYj-NQdDSQT@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 17:36:33 +0200
X-Gm-Features: AS18NWDr85-ZpXwSC6o2WrSo4j9nQyRJc99PDFWHduyckze-ToGPJ6wk6IRJ840
Message-ID: <CAMRc=MeSFKRo1rHq5ENzKqws+gOAX=-nCsGtw5MXvsOwJr=XpQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] string: provide strends()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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

On Wed, Oct 22, 2025 at 5:25=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Oct 22, 2025 at 03:10:40PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Implement a function for checking if a string ends with a different
> > string and add its kunit test cases.
>
> ...
>
> > +static void string_test_strends(struct kunit *test)
> > +{
> > +     KUNIT_EXPECT_TRUE(test, strends("foo-bar", "bar"));
> > +     KUNIT_EXPECT_TRUE(test, strends("foo-bar", "-bar"));
> > +     KUNIT_EXPECT_TRUE(test, strends("foobar", "foobar"));
> > +     KUNIT_EXPECT_TRUE(test, strends("foobar", ""));
> > +     KUNIT_EXPECT_FALSE(test, strends("bar", "foobar"));
> > +     KUNIT_EXPECT_FALSE(test, strends("", "foo"));
> > +     KUNIT_EXPECT_FALSE(test, strends("foobar", "ba"));
> > +     KUNIT_EXPECT_TRUE(test, strends("", ""));
> > +}
>
> Have you checked the binary file? If you want this to be properly impleme=
nted,
> generate the suffix. (Actually making the function static inline makes my=
 point
> really visible)
>

Andy, this is bikeshedding. This is literally the least important
piece of this series. It doesn't matter for the big picture whether
this is inlined or not.

Bartosz

