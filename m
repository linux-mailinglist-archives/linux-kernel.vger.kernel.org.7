Return-Path: <linux-kernel+bounces-742517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8C8B0F2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED4F5477A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575E72E62B2;
	Wed, 23 Jul 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="nj6KV9qr"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A190D2FF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275636; cv=none; b=f/WJ3Tl6UZ+rICANJ8qcupA8yApuHHBYktASpw3ItB3clROEfB7GdJ8iu+jVBUNqvPczS4y0sZqtNLxiQ2aBFkzoqj3qLexXnFLDwHJi8xC9z1vi1YTVlPIiYz3GDHA9jT+0ScsqpMHw4Kjvq/qxt8BSr+wblUzfRDH6OcjIE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275636; c=relaxed/simple;
	bh=Ri7s8hJvITaMzi7gaN9M+9ZBqdCoGeDFZCaNr/uGK04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFSaL/yFBg1VRgQAgFtroCRGKYRDYoYnWhDlD6KitssRX25FZLrX/Dx8mPYg/GpD0k98yVE+KTxXCmf1/fqKLCywkL0K+i+IUH4lCith3sFIpvgTlvaqadQnCu3PIqLWO4Ug0r5BJyMCmBQpj40f/Ty0KdEt8P5Xr2cjfTH30no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=nj6KV9qr; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-718409593b9so68338957b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1753275633; x=1753880433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uGfivhZ1DUsKXGRytAhJid6o6kAJDjw6rZUNtK4FfG0=;
        b=nj6KV9qroK1MbO6AkXgI6anNGTsxiNj9a02T4YJLIYAPYDCNwMEoTuPYlU73oSL0tT
         1J/CBalH2G9Roip+0dJr1YL9zuR2X1XCyi0AMbgS7fQq0d2a+t5PNMWSGBniRDey1a3i
         /OgK1T43EeoI9PAPx7lsdyzFrMnylKMoA+pVX9xasVw/lIj4cGWD53D0Klzf1ECc11n7
         gLLoGCheHO4BCeqk5ffiHQHH31oCzEojGEPKXK5dle+JG9IjXB1/t14rSK2JFBzIWqDD
         4xiY6FxgcxYoRB60cXLLS6xjIjsqTJhpWmonBKZ+LnyFOVqeeAXSV22VUTFdGlNr34Kb
         meRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753275633; x=1753880433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGfivhZ1DUsKXGRytAhJid6o6kAJDjw6rZUNtK4FfG0=;
        b=GHCvrtWqB2F8VLtnodYxdvksdLrkZONngEl8ICMxEgdA4Nu03R0YbkpmzYe5pUcFWn
         8KAU8qcX8CrOFvvX2/jSdM2qansdc9JMRNqIqKtMH2Hr7I2RpTjtM8NwRzjNtjCz2BW3
         oWcLlRcBLABOPCYoNydsvH4bwLGeXhwpKU1HWLkhddlAqtEyQKHUKv0vxxoaNoPH9rhu
         ZfUx/TcFLxoD1veAyp+hJVH+Rkz66/2zhQ3f2rdskI3rIbtgXAfQUwdF6rCJhHNJX9mY
         9c89qsiE1JXa0zyRB6GVYo2O9kcXw28SazqRL8xwPljEpdK7kmdipr6uRZ71+LhUnMU2
         4EiA==
X-Forwarded-Encrypted: i=1; AJvYcCULrliPDiy2+ynLKCsma+RyYn+mRGHR2DBzkDZJbucnc4NUEkaWHJlE/PECgazvDs4h4j0ZB094koDS6j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAo2TXf7RdYJRDi8hG+EsFJQhf04io3xOPuDyn513M0E0OOD0x
	yqh9u7ybtVmN1Ca6b2jkNSaf7eaqBH30AMASFJnESZJCGP4zuEAhGSNHwPScyxPDdAJuz2FYzyj
	KMv2T1PAEgGPDIslHyzHXYDUWLLmdcTox6VO0QUDljQ==
X-Gm-Gg: ASbGncsUXp9uPXtDbDc8Bey1LqLr+mDoCdreDMwxcqe1BO51r06GVxajr7uLrQmuDOG
	omhlKHJVEJN0SVHMwYEUAx7yxkUQ/HzkckrUexMkobP+f+O6irPPYIwGm3XmAqRlcPshS7/0wS0
	t44GKOXVldncc6BC6xE9mLgXD87rOmid1FlzQbe6FW+x8VuLQukVNsQ5CPJnED20ZPQteMf6EZz
	0NBoDdbJeINJwO2KhNEJYoW+svWZVEbX3VuEz8=
X-Google-Smtp-Source: AGHT+IGNIePst0Sukci1x4zgyK0txApzP/1uRGdwSr8aXGYzOqv05HMAbl7VRONKmg1O1Aa+xnW+8zo5H/IPc8lzg4M=
X-Received: by 2002:a05:690c:4493:b0:714:3e9:dd3 with SMTP id
 00721157ae682-719b4208b0bmr39866417b3.6.1753275633204; Wed, 23 Jul 2025
 06:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718-fpf-media-dt-flip-v1-0-75b3a938b4be@pengutronix.de>
 <ryuew3kxnocj6uqq4nadp3kyaxg27rxlrgnaieyy2hlpz5jkd3@iyetnsbfanee>
 <35debf21-bca7-480f-a61e-7b0494f10ca5@pengutronix.de> <mljx67lkcw4kh3cs344iprik244cm7hqfckmg4bj5j5atuyt62@lh2ht4mrtkjq>
 <3ac271c7-a67a-4f6f-935d-256937516068@pengutronix.de> <ffzxxsplmivvj7pib7n7lkutbyohl5npofdaxdxtoffo43yatw@gqm64zdgb4iy>
In-Reply-To: <ffzxxsplmivvj7pib7n7lkutbyohl5npofdaxdxtoffo43yatw@gqm64zdgb4iy>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 23 Jul 2025 14:00:15 +0100
X-Gm-Features: Ac12FXzhwhTRnfeouU7SY55TBB_W9w-c59XLWjDatEdh6WBJv4bfct3s5BZJejE
Message-ID: <CAPY8ntDLPDmgmE8+VQ4jchfNKLLEK5bZ10ftham9bK-x_HL8Xw@mail.gmail.com>
Subject: Re: [PATCH 0/2] parse horizontal/vertical flip properties
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Fabian Pfitzner <f.pfitzner@pengutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jacopo Mondi <jacopo@jmondi.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, entwicklung@pengutronix.de
Content-Type: text/plain; charset="UTF-8"

Hi Jacopo and Fabian

On Wed, 23 Jul 2025 at 13:21, Jacopo Mondi
<jacopo.mondi@ideasonboard.com> wrote:
>
> Hi Fabian
>
> On Wed, Jul 23, 2025 at 12:09:58PM +0200, Fabian Pfitzner wrote:
> > On 7/23/25 11:44, Jacopo Mondi wrote:
> > > On Wed, Jul 23, 2025 at 11:29:27AM +0200, Fabian Pfitzner wrote:
> > > > On 7/23/25 11:17, Jacopo Mondi wrote:
> > > > > Hi Fabian
> > > > >
> > > > > On Wed, Jul 23, 2025 at 10:58:28AM +0200, Fabian Pfitzner wrote:
> > > > > > There are cameras containing a mirror on their optical path e. g. when
> > > > > > mounted upside down.
> > > > > How is this different from 'rotation = 180' ?
> > > > If you simply want to flip the output (e. g. horizontally), you cannot do
> > > > this with a rotation.
> > > > The camera I'm referring to is not only upside down, but also flipped
> > > > horizontally.
> > > 180 degress rotation = HFLIP + VFLIP
> > I do not want to do both. Only one of them.
> > >
> > > Yes, you can't express 'mirror' in DTS, because DTS are about the
> > > physical mounting rotation of the camera. Sensor drivers shall not
> > > apply any flip control automatically, it's userspace that by parsing
> > > the rotation property through the associated v4l2 controls should decide
> > > if it has to apply flips or not to correct the images.
> > >
> > > What is the use case you had in mind ? Tell the driver through a DTS
> > > property it has to apply flips to auto-compensate ? Because I think we
> > > shouldn't and if I'm not mistaken we also document it:
> > > https://www.kernel.org/doc/html/latest/userspace-api/media/drivers/camera-sensor.html#rotation-orientation-and-flipping
> > I have a camera that does a horizontal flip in its hardware, so the output
>
> Sorry, I don't want to be annoying, but what does it mean "does a
> horizontal flip in the hardware" ?
>
> In my understanding either "in hardware" means you can't control it
> from software (and so there's no point in telling drivers what to do)
> or you can control it from software and it's a regular HFLIP.

Can you say what this sensor/module is?

To change flips due to physical sensor orientation is a very unusual
one. That would imply some weird mechanics in the sensor to add the
mirror and some form of orientation sensor being built in.

The closest instance I can think of would be ov5647 where the sense of
the H & V flip register bits are in opposition, but that doesn't
change based on how the sensor is mounted.
In that case the driver just needs to account for it when programming
those registers [1]. And I now note that I haven't upstreamed the
patch adding flip controls - another one for the to-do list. The
hardcoded register set in the mainline driver sets HFLIP (0x3821 bit
2) but not VFLIP (0x3820 bit 2) [2].

  Dave

[1] https://github.com/raspberrypi/linux/commit/9e5d3fd3f47e91806a5c26f96732284f39098a58
[2] https://elixir.bootlin.com/linux/v6.15.7/source/drivers/media/i2c/ov5647.c#L153

> > is not what I want. My example above was misleading. The rotation fixes the
> > "upside down" problem, but does not fix the flip.
> >
> > Doing that in userspace might be a solution, but in my opinion it is a bit
> > ugly to write a script that always sets the flip property from userspace
> > when the device was started.
> > A much cleaner way would be to simply set this property in the device tree
> > such that the driver can be initially configured with the proper values.
>
> Sorry, don't agree here. What if a sensor is mounted 90/270 degrees
> rotated (typical for mobile devices in example) ? You can't compensate
> it completely with flips, would you 270+HFLIP=90 ? would you leave it
> unmodified ? Userspace has to know and act accordingly, doing things
> in driver (will all drivers behave the same ? Will some compensate or
> other won't ?) is a recipe for more complex behaviours to handle.
>
> >
> > PS: I have to send this email twice. The first one contained HTML parts that
> > were rejected by some receivers...
> >
> > >
> > > TL;DR drivers shall not flip, userspace should. Mirroring is an effect
> > > of drivers applying an HFLIP, because unless I'm missing something
> > > obvious, 'mirror' is not a physical mounting configuration of the camera
> > > sensor.
> > >
> > > FIY we're talking about something similar in libcamera
> > > https://lists.libcamera.org/pipermail/libcamera-devel/2025-July/051533.html
> > >
> > > > > > Introduce two options to change the device's flip property via device tree.
> > > > > >
> > > > > > As there is already support for the panel-common driver [1], add it for cameras in the same way.
> > > > > >
> > > > > > [1] commit 3c0ecd83eee9 ("dt-bindings: display: panel: Move flip properties to panel-common")
> > > > > >
> > > > > > Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> > > > > > ---
> > > > > > Fabian Pfitzner (2):
> > > > > >         media: dt-bindings: add flip properties
> > > > > >         media: v4l: fwnode: parse horizontal/vertical flip properties
> > > > > >
> > > > > >    .../devicetree/bindings/media/video-interface-devices.yaml        | 8 ++++++++
> > > > > >    drivers/media/v4l2-core/v4l2-fwnode.c                             | 3 +++
> > > > > >    include/media/v4l2-fwnode.h                                       | 4 ++++
> > > > > >    3 files changed, 15 insertions(+)
> > > > > > ---
> > > > > > base-commit: 6832a9317eee280117cd695fa885b2b7a7a38daf
> > > > > > change-id: 20250718-fpf-media-dt-flip-7fcad30bcfb7
> > > > > >
> > > > > > Best regards,
> > > > > > --
> > > > > > Fabian Pfitzner <f.pfitzner@pengutronix.de>
> > > > > >
> > > > --
> > > > Pengutronix e.K.                           | Fabian Pfitzner             |
> > > > Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
> > > > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
> > > >
> > --
> > Pengutronix e.K.                           | Fabian Pfitzner             |
> > Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
> > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
> >
>

