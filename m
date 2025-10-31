Return-Path: <linux-kernel+bounces-879770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924F1C23FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C563BE162
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9A032D438;
	Fri, 31 Oct 2025 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="loCW9yb4"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657632C305
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901266; cv=none; b=kIeYOzJwA9S+XZ9u2PNQ+UfS3pQrgevpKTh8Zg4XxP+ea8S43jTDCHDLlVHcTk/zNvaV0ycFvznnana/YmYEDfM6rH2Q+qgMnIvNfWmGK9XjuxHtDv7fQoCI0wdMJwRAIvvYXeI5vCdjYFcUZYNkAyspoikbcYHYXRrioHMy1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901266; c=relaxed/simple;
	bh=kfJpm0mLG9RdVDLearjYwAtnnJ9GdvDB4BJl81FcoME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NB2DTYqLK0nGtlat+SPknXI9vRbyt3Ly9SniO6sakf66FbKZXMzYVfl4cfaxLO93ZPuNdM58daILUTqLAw66dBhCKWGry6F3kfXHr6NSPK9ExMNHX7I8J02gGvk6h4/3B0MqUpEFg+/x6XSZQdyLMYBWTT8qV5IKAVRjBnArcHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=loCW9yb4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-591c74fd958so2211173e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761901262; x=1762506062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2zWXQAb4J66gJtbZXDf79DLTVt9tmjwLAqTV9wFU9Q=;
        b=loCW9yb48Ax3J5ZW4b3UlLYQBoK3qE6SPslSpIH94lJGfJ6xybBDgNQJCJnuIt+YV2
         DaX8hLxBsazM0nbViqlSQEK9yx+vRX/CAgtXmuz5QehQctVS6Zb27xB9e+r3rBFKs3wu
         OVqHBROSuBFAy4dwL7iPMHmH8u0/I+USgRz96ag5v+N5qPGBtg8D1i+B5IcXIZFWbW7k
         CEMqQNzQGj8RWyJW9bKISGl68guZ8no7XknSG2g0A20OsJb2zOfYTJ439dGTD4qKs0jo
         2oeZsd4/2TZS8HUBR2ATS0NY5nQncBWRGzgWK5CurPZrI9pMxSTC01ZGsLmAcQdA/7Ff
         KtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901262; x=1762506062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2zWXQAb4J66gJtbZXDf79DLTVt9tmjwLAqTV9wFU9Q=;
        b=Qo4YYogi5HssXCcPHzkPSHZw5p75HgB54ix7s+xACmpa7eYkRbARJ/20w+4kR7iSVH
         /tVsmXPGUbeyRnm/rjdVKqlSNpD7HfduhT1xiLOkmnGUDukj1ymCoS7xP/txq4bg7nN2
         BteLMJodK3M6JDZNsg9uTZYTFA1EHgZSCoWZYvOQc0vCpj12XDBqK7oouqjPK73armpu
         A45DAVYd0yzc3bwSXAiXyzdaOYxOXjRr7j0yuN97siWfPLO6nDF9U4WiUcJpnKwEFE84
         X7w+uxfM2qIcrMbqn1wnVyT0R5OlfDH1AnBseX3arEFASjtAOoWUA8z7yu9WO/VW3qOj
         2sDw==
X-Forwarded-Encrypted: i=1; AJvYcCXUcsFUVg7pcEGADd2K6QeHzSr6s89MM9PJmM7WZ4ta7ZGS5RrhTgQAgseV3KtlmRkNYq9AP6jKz0e8CPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRAoxj/pxjlkjlLK4Isst7f0cCEZgpjjz7ySqtLDmAThIdBgD/
	29NE3DLq3jhridSdqucW/Sg/fqnwndxyuNMxmGK94fYuE7OUsGdzFl4WbOvu9S2IHEmcVbTMWPR
	m37uenkwOSZ7g9TcGywMF/cBjM0FTMnZNqr7LQ2GJlA==
X-Gm-Gg: ASbGncsZHXrnrYzFN/AjEsgV47tC7V1k3ioYKkPqnYSmmIwZGLeCsSkGbHlm0LwkqUL
	wkiJgQ+LZ1UEAmAzA+SKJiV7nc7gG4z2BhOL3oISPEN4sJp0s1NEMQr76ECXaI9kp4Y0RM+Ft01
	uyM9NzXLEvpv+2C5VrUx+PYCq4POUjHkWbYqr5teJcfEP0mh8/36tbHHUsSqCDFB04qcSDiYLZz
	MsgpT8akOzHXK3z94gz6/KK2xunsEyJ7kPkoFUJEXCTMDT97WHX0XMzk941h2rbPos0fzPmbb2B
	Wa1z0jD3tRl9p4dF
X-Google-Smtp-Source: AGHT+IH9CdyA/9CpR4yuZJkUQBQIcmzJf4sYm4WcPQACoUSrA5BoL7natdG3cIpjNxAp+exZosbxpHf54nNaLort178=
X-Received: by 2002:a05:6512:3e0d:b0:592:f9c6:9736 with SMTP id
 2adb3069b0e04-5941d563fdfmr953358e87.56.1761901249206; Fri, 31 Oct 2025
 02:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-3-638a4cb33201@linaro.org>
 <aQMy00pxp7lrIrvh@smile.fi.intel.com> <CAMRc=MdP58d=o7ZL4bAdsaYwzrs6nJo3bhS7Jf1UkDNwPOnAsg@mail.gmail.com>
 <aQRyFSHWzccTPa3M@smile.fi.intel.com>
In-Reply-To: <aQRyFSHWzccTPa3M@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 31 Oct 2025 10:00:37 +0100
X-Gm-Features: AWmQ_bknobk-QJWbVtapIqlH_lufop-oiWv3enLciZJOoLidz7raNrtQVaowNic
Message-ID: <CAMRc=McT+Q8ZVk9_HTyWd6uS0OoP92E_phwef7CDyDVeNbJCqA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] software node: allow referencing firmware nodes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 9:24=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 30, 2025 at 04:17:48AM -0700, Bartosz Golaszewski wrote:
> > On Thu, 30 Oct 2025 10:41:39 +0100, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> said:
> > > On Wed, Oct 29, 2025 at 01:28:37PM +0100, Bartosz Golaszewski wrote:
> > >>
> > >> At the moment software nodes can only reference other software nodes=
.
> > >> This is a limitation for devices created, for instance, on the auxil=
iary
> > >> bus with a dynamic software node attached which cannot reference dev=
ices
> > >> the firmware node of which is "real" (as an OF node or otherwise).
> > >>
> > >> Make it possible for a software node to reference all firmware nodes=
 in
> > >> addition to static software nodes. To that end: add a second pointer=
 to
> > >> struct software_node_ref_args of type struct fwnode_handle. The core
> > >> swnode code will first check the swnode pointer and if it's NULL, it
> > >> will assume the fwnode pointer should be set. Rework the helper macr=
os
> > >> and deprecate the existing ones whose names don't indicate the refer=
ence
> > >> type.
> > >>
> > >> Software node graphs remain the same, as in: the remote endpoints st=
ill
> > >> have to be software nodes.
> > >
> > > ...
> > >
> > >> -#define SOFTWARE_NODE_REFERENCE(_ref_, ...)                       \
> > >> +#define __SOFTWARE_NODE_REF(_ref, _node, ...)                     \
> > >>  (const struct software_node_ref_args) {                           \
> > >> -  .node =3D _ref_,                                          \
> > >> +  ._node =3D _ref,                                          \
> > >>    .nargs =3D COUNT_ARGS(__VA_ARGS__),                       \
> > >>    .args =3D { __VA_ARGS__ },                                \
> > >>  }
> > >
> > > Okay, looking at this again I think we don't need a new parameter.
> > > We may check the type of _ref_
> > > (actually why are the macro parameters got renamed here and elsewhere=
?)
> > > and assign the correct one accordingly. I think this is what _Generic=
()
> > > is good for.
> > >
> >
> > Oh, that's neat, I would love to use _Generic() here but I honest to go=
d have
> > no idea how to make it work. I tried something like:
> >
> > #define __SOFTWARE_NODE_REF(_ref, ...)                          \
> > _Generic(_ref,                                                  \
> >         const struct software_node *:                           \
> >                 (const struct software_node_ref_args) {         \
> >                         .swnode =3D _ref,                         \
> >                         .nargs =3D COUNT_ARGS(__VA_ARGS__),       \
> >                         .args =3D { __VA_ARGS__ },                \
> >                 },                                              \
> >         struct fwnode_handle *:                                 \
> >                 (const struct software_node_ref_args) {         \
> >                         .fwnode =3D _ref,                         \
> >                         .nargs =3D COUNT_ARGS(__VA_ARGS__),       \
> >                         .args =3D { __VA_ARGS__ },                \
> >                 }                                               \
> >         )
> >
> >
> > But this fails like this:
> >
> > In file included from ./include/linux/acpi.h:16,
> >                  from drivers/reset/core.c:8:
> > drivers/reset/core.c: In function =E2=80=98__reset_add_reset_gpio_devic=
e=E2=80=99:
> > drivers/reset/core.c:958:52: error: initialization of =E2=80=98const st=
ruct
> > software_node *=E2=80=99 from incompatible pointer type =E2=80=98struct=
 fwnode_handle
> > *=E2=80=99 [-Wincompatible-pointer-types]
> >   958 |                                                    parent->fwno=
de,
> >       |                                                    ^~~~~~
> > ./include/linux/property.h:374:35: note: in definition of macro
> > =E2=80=98__SOFTWARE_NODE_REF=E2=80=99
> >   374 |                         .swnode =3D _ref,                      =
   \
> >
> > So the right branch is not selected. How exactly would you use it here?
>
> I believe this is an easy task.
>
> But first of all, your series doesn't compile AFAICS:
>
> drivers/reset/core.c:981:6: error: variable 'ret' is used uninitialized w=
henever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>   981 |         if (IS_ERR(rgpio_dev->swnode))
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/reset/core.c:1001:9: note: uninitialized use occurs here
>        1001 |         return ret;
>             |                ^~~
> drivers/reset/core.c:981:2: note: remove the 'if' if its condition is alw=
ays false
>   981 |         if (IS_ERR(rgpio_dev->swnode))
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   982 |                 goto err_put_of_node;
>       |                 ~~~~~~~~~~~~~~~~~~~~
> drivers/reset/core.c:905:13: note: initialize the variable 'ret' to silen=
ce this warning
>   905 |         int id, ret, lflags;
>       |                    ^
>       |                     =3D 0
> 1 error generated.
>

You're not wrong but for the record: it builds fine for me with
aarch64-linux-gnu-gcc 14.2 for some reason so I didn't notice it. I'll
fix it.

> So, but to the topic
>
> I have applied this and get the only error as per above
>
>  (const struct software_node_ref_args) {                                \
>  -       ._node =3D _ref,                                          \
>  +       .swnode =3D _Generic(_ref, const struct software_node *: _ref, d=
efault: NULL), \
>  +       .fwnode =3D _Generic(_ref, struct fwnode_handle *: _ref, default=
: NULL), \
>

That works, thanks for the idea.

Bartosz

