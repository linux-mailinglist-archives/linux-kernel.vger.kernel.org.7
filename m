Return-Path: <linux-kernel+bounces-882674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4888C2B1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A45254F0FFD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E98C2FE571;
	Mon,  3 Nov 2025 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iv5OUXrD"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29AB2F39BC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166214; cv=none; b=uEvbcY2uKuMOJKmB1tGCzVNWDKkdKq/lCXsQz1qxFwl/QUs+RyYOMB2GTPH7XT/qgwb3tHOpwyzfWl62upKlZdEo5rv7DckmHAFcqLhUB5W7aoqmc5h+3AghA34ZK3E+DdpQ31sRQ/ihjOddjbX4TCKDZfcjBU2hI2xIoPIGpJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166214; c=relaxed/simple;
	bh=+MmxogPhCLs9ZpI9QmsWexfExGRNeJu+3ZnjBRPUXe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ys9Uu/4JX28fqkytBkLOLx5QgoFdcQRaIN2dgGalJ4810OJYlRHe/sJLx3wufR79CjQnEihtff6hI2DBjsyar3jOrMFIlTRvrxyhS/CbbDmanXen1RYz38W9Tmg9vCIpSEUfpGK/q1AUyyXq2GODkl7gr4vnKz2W1ozPqEy5810=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iv5OUXrD; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-378d50e1c82so40437431fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762166210; x=1762771010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjLBSonYsqmv8UYBTszg3fkXjFKAEIXlmbkscAA6YbA=;
        b=iv5OUXrDCZogogcKkaAr2xU9qPJ09nejdz8PXi5j3gPIVivtB1RBQgE/F3QQ1nGwJy
         GM9OxBnVhI69OguE+YQ7/B/GI52YjpVurtceaK4SWItb4Ti4zaspM7rSK1pjYPgrf+Mr
         A1gvN1fUAPQGqfCrRl7KInQJhbEXUifSN+iXHGctNMfg1p8gdekdjQKk6gv4Jrsmv634
         YBcUTXIAutvtHOfq+12fr44JLfo+3VEqlNnL6rW457Y8XcOpWL0t/zWO1O6idx/UMzUX
         Dm7X27jtovNir7m0HYSf8kz6CqTWalrqRMx+znF2vcqmeFUXZuqRVoEqVlC/emLTmyhs
         FqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166210; x=1762771010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjLBSonYsqmv8UYBTszg3fkXjFKAEIXlmbkscAA6YbA=;
        b=AH6i951lIcgLZlNYEB4e1cS+aOb9CPTl+pR9sJEhxyPuLHYZyWRnwMqAsm5eR5ISXh
         Bl0PlggRCmlqV8K/g6+LFedn/iplCFK8vv2cBztPU0Mwh6lQjYeW5kkyX3OoLNXFbp2y
         xVI9hd/LJwVf8eP9sIEjsVyxMzo2S7b/xoGP8kF+1dwClSIbFqXzeg7WMjsY6qhxkhEd
         5ghVhzkjo1xitAHb+CGZZwHSEZorwEFtZj6uQ7VHbP9GKnUNzLA0UlbdFP6m+BTenxeI
         OwCTFYVeT3UIhI6h/GB9MgKDtTLtDJ8J9OnYgkMlqy2Tm/Ebm/2iuP76AbWDFu9LdN2I
         +ISw==
X-Forwarded-Encrypted: i=1; AJvYcCX9K6I2wqPMdzKB+OwdKYfZ7XHxkDw8vhkDVkrQSf9cDfbB8KeS7BnJNG+JmkdRT5YHucMzv1j5zq6cZZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywubjl/U339SiP8C1XDTA1lPI59z146LlYMtqwMuApEgZ8ID/hy
	YqlJhtEVzl0bk9OWFB9bAb/jmXMOr3KKk/sXYMMXLk4JYHkEOVk39kZqBLSRWjoN1TgKCBJbRj8
	Yq9mTl4ZWvrj6PN1j+KkyC/04pCZNBju+sM5DBqep2Q==
X-Gm-Gg: ASbGncvEv4pC6SeuzRBVS7HExDHs1curn2MMTDa5+iAkpx4ox/DgHo9+/Js4HK29Ued
	gOBECEA4rss9Hlw9s4pesSvYPG5djms0OJGqAFVhNWN5nXNqtBF5A60HhUn5zAQbFrBdyZAO9Lo
	QW1k0X6yDeKftHIGY6jVMBQ7P9lk5uAfUwQJGmmDnInbcPN84sXap6lFB0BqcZfIXWyfZbPLQ+t
	Yzk0mJgQeJy0mFDn7Z/06qr5PrsRFFv139J/Of8849N2lubRYjT8IR7anRxMfHoBWyGEmEItRxu
	Y5AVar1lQ7FOJFLWrXsiNIacOYc=
X-Google-Smtp-Source: AGHT+IE87NQ2wrN4nbBrNGJFPIv5zQc1LIytN9zHMv4eWDwdCr6Is7aAXMrMg0as6kgGpZ9GoAeO7eWblG8JuiJzHas=
X-Received: by 2002:a2e:be27:0:b0:37a:2b3d:12cc with SMTP id
 38308e7fff4ca-37a2b3d178fmr22342871fa.44.1762166210020; Mon, 03 Nov 2025
 02:36:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-3-6461800b6775@linaro.org> <aQh6n2XuI0oayg2g@smile.fi.intel.com>
In-Reply-To: <aQh6n2XuI0oayg2g@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 3 Nov 2025 11:36:36 +0100
X-Gm-Features: AWmQ_bkxzE88tRObcETZ4rhIp4MxY1YrBBIl6dy0Tsm5UlD4jZWeoUiNmbbz8tk
Message-ID: <CAMRc=Md=r7GaO3A_7de+EqzboyA2cqNSTZx7+64VSMvRBb9gpw@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] software node: allow referencing firmware nodes
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

On Mon, Nov 3, 2025 at 10:49=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 03, 2025 at 10:35:23AM +0100, Bartosz Golaszewski wrote:
> >
> > At the moment software nodes can only reference other software nodes.
> > This is a limitation for devices created, for instance, on the auxiliar=
y
> > bus with a dynamic software node attached which cannot reference device=
s
> > the firmware node of which is "real" (as an OF node or otherwise).
> >
> > Make it possible for a software node to reference all firmware nodes in
> > addition to static software nodes. To that end: add a second pointer to
> > struct software_node_ref_args of type struct fwnode_handle. The core
> > swnode code will first check the swnode pointer and if it's NULL, it
> > will assume the fwnode pointer should be set. Rework the helper macros
> > and deprecate the existing ones whose names don't indicate the referenc=
e
> > type.
> >
> > Software node graphs remain the same, as in: the remote endpoints still
> > have to be software nodes.
>
> ...
>
> > +     /*
> > +      * A software node can reference other software nodes or firmware
> > +      * nodes (which are the abstraction layer sitting on top of them)=
.
> > +      * This is done to ensure we can create references to static soft=
ware
> > +      * nodes before they're registered with the firmware node framewo=
rk.
> > +      * At the time the reference is being resolved, we expect the swn=
odes
> > +      * in question to already have been registered and to be backed b=
y
> > +      * a firmware node. This is why we use the fwnode API below to re=
ad the
>
> A nit-pick (since anyway it requires a new version): move 'the' to the ne=
xt
> line to make them more equal in the length.
>
> > +      * relevant properties and bump the reference count.
> > +      */
>
> ...
>
> > -#define SOFTWARE_NODE_REFERENCE(_ref_, ...)                  \
> > +#define __SOFTWARE_NODE_REF(_ref, ...)                               \
>
> No, NAK. The renaming of the parameters is not related to this change _at=
 all_.
> Why do you change established style here? Did I miss your answer to my qu=
estion
> in the previous rounds?
>

Ah, my brain just filtered out the trailing '_'.

> >  (const struct software_node_ref_args) {                              \
> > -     .node =3D _ref_,                                          \
> > +     .swnode =3D _Generic(_ref,                                \
> > +                        const struct software_node *: _ref,  \
> > +                        default: NULL),                      \
> > +     .fwnode =3D _Generic(_ref,                                \
> > +                        struct fwnode_handle *: _ref,        \
> > +                        default: NULL),                      \
> >       .nargs =3D COUNT_ARGS(__VA_ARGS__),                       \
> >       .args =3D { __VA_ARGS__ },                                \
> >  }
>
> ...
>
> > +#define SOFTWARE_NODE_REF_SWNODE(_ref, ...)                  \
> > +     __SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
> > +
> > +#define SOFTWARE_NODE_REF_FWNODE(_ref, ...)                  \
> > +     __SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
> > +
> > +/* DEPRECATED, use SOFTWARE_NODE_REF_SWNODE() instead. */
> > +#define SOFTWARE_NODE_REFERENCE(_ref, ...)                   \
> > +     SOFTWARE_NODE_REF_SWNODE(_ref, __VA_ARGS__)
>
> Now, useless.
>

No, why? With these changes, SOFTWARE_NODE_REFERENCE()'s name is a bit
misleading or incomplete, so I'm proposing to start replacing it with
SOFTWARE_NODE_REF_SWNODE() which is compatible with the former but has
a better name.

> ...
>
>
> > -#define PROPERTY_ENTRY_REF(_name_, _ref_, ...)                        =
       \
> > +#define __PROPERTY_ENTRY_REF(_type, _name, _ref, ...)                 =
       \
> >  (struct property_entry) {                                            \
> > -     .name =3D _name_,                                                =
 \
> > +     .name =3D _name,                                                 =
 \
> >       .length =3D sizeof(struct software_node_ref_args),               =
 \
> >       .type =3D DEV_PROP_REF,                                          =
 \
> > -     { .pointer =3D &SOFTWARE_NODE_REFERENCE(_ref_, ##__VA_ARGS__), },=
 \
> > +     { .pointer =3D &_type(_ref, ##__VA_ARGS__), },                   =
 \
> >  }
>
> Do we need this now? I assume that _Generic() takes case of this.
>

Ah, right, it should be done here as well.

> ...
>
> > +#define PROPERTY_ENTRY_REF_SWNODE(_name, _ref, ...)                  \
> > +     __PROPERTY_ENTRY_REF(SOFTWARE_NODE_REF_SWNODE,                  \
> > +                          _name, _ref, __VA_ARGS__)
> > +
> > +#define PROPERTY_ENTRY_REF_FWNODE(_name, _ref, ...)                  \
> > +     __PROPERTY_ENTRY_REF(SOFTWARE_NODE_REF_FWNODE,                  \
> > +                         _name, _ref, __VA_ARGS__)
> > +
> > +/* DEPRECATED, use PROPERTY_ENTRY_REF_SWNODE() instead. */
> > +#define PROPERTY_ENTRY_REF(_name, _ref, ...)                         \
> > +     PROPERTY_ENTRY_REF_SWNODE(_name, _ref, __VA_ARGS__)
>
> Seems like useless churn.
>

This is the same argument as with SOFTWARE_NODE_REF_SWNODE(). It's not
clear from the name what PROPERTY_ENTRY_REF() is really referencing.

Bart

