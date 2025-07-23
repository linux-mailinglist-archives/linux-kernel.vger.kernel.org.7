Return-Path: <linux-kernel+bounces-742689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE8B0F566
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1316BAC341B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18912E9EB0;
	Wed, 23 Jul 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="maIwifSS"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F7E2E763B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281249; cv=none; b=StT+WXHETu6UwUyP2f0sKdF5HR05T16Ys70ORuI9pRylVd/WXCoutnruICPmFJ7Due6DX0VQtBuFv/EeBeXxspWGwKrVJVE3FM0JHiLostjHmV5mKmY1Oo/2quJ8GEf9bA/EKBP6BoHyDhv+tI30tXIxACPdljsp+8Wo5RJd45k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281249; c=relaxed/simple;
	bh=s2U6DW6ywBldcB4970d407QnV5OdXYvMoGTWnX4OGNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pW+cTA5uNXIUif1E/eRLIEptL7wPH06EoQzJQ8z0QANyXr2wIdDxRDoPMudQoekpG4J2ZP3lum/0lAQc2CQMp+jfM4/APDiW63X8C/Mgf0JdESiMP3gQlC/A6qZdyuRhTICfUW+Xyl4bqsQGj8k0FGJOalocJkJkLrz7N/qTBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=maIwifSS; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7184015180fso77130667b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1753281247; x=1753886047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i7J8HjQSm2OQjkU72pczPzlrbrT1qcIJ7YC84xB7FCM=;
        b=maIwifSS2svN5/4n//AWmKgskRsN9Xj5I3PLLDuDz/B5UuBRnXccL2CtHOT64B0sHI
         DLqBebCNeH32ENcyCDv7AHE4nYkNkUWuHU/MszBMKRE7PKgbjEAElJfdyQKfY7EruJ4P
         Bv3UcCgMUJYRJ5jqUUyn9owj3xu+yiKW79GVn/J9sQij6tXD4hAUkXx7/cq4U9fEaJEu
         QPmMWX25yLVl1ivueCIFkPvhp9MjsAqT6DWDn1LWxng3vV+YCI3hCMbf8GpHviWRcXu8
         igM2cxyeuxA3If9rsLEj4qTTmTM9HNvfIWxfkpwy90pJJTxkUL/F03HiUYCJtUWQfoJ/
         B7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753281247; x=1753886047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7J8HjQSm2OQjkU72pczPzlrbrT1qcIJ7YC84xB7FCM=;
        b=Y7VzS0+G2KlCVtLWe1yMZ9OKJ3/mWNto00qJp7jBpUFiddIrrb+PpYWGkwodfyGoSh
         8qW1VNi+DwfxK8LfmD25y4+rCL2c6gRssZNJ9xP+38B2WDnT0umoL5CYQZXn2Z+Tyk7Y
         5CsO6c/zxjHaokKWV9k8LYr1/6v7rXBrd3aqsFsF9YclIridp8MCUfNM7R8OUd0V9VVa
         Phx69pEQEcd4wB+qtI0qMElCMJSs4dujpUJjUR0N5eleqvhjycVa3GV1Wa/aY37rH932
         jsvTTuXWr8XdjXQFxu7N8f/0PWl3p0ECXO+RtR7DS6uVs36GyVzVTFGXuHSlmKEE8Pp1
         RbpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZxyEOjukJL0GTq+rX0dsmvnmfdkpS09ZXuPO/dh4Ziin5SPWoRfnGfUbL6aeTtejs1M4WPuCvVmzAebs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe9GE/7uGXOGtdJxmpAe05lJZMFsOPR/baEE2oJgCBkvO/yEDV
	oqNwWFHfakWSX/ma0Ge+AqQO3UKYaTkPIC6Ait2rpwe7CIPImGlJLSWXITfR/0nD2y57B4pgSNe
	/oBD8l2R286JNr2MQh1Vey+fDlG3fn8awC+7qxzVztw==
X-Gm-Gg: ASbGncsTlg+5Ocp6aTQMe2CVYiCOocz+Pi57UvGvcadD2h9hH3IpoEw+6HXjsSEwe2s
	jBV5S/6M0LF4fJZ9lhGrAThgKIEZYfrB8tPNE4fyF24ioy4Cathku4zqzf+6qVAdEPlmO5ceRW4
	NdeeE3sSHo3REzWIOUw4B1tlKKki/gSN7xsXZpMUbtINDbkUUlEQd6EajYuHdJckMANCUx/oCvU
	Ks74u4REMG/Js6XNSmPg3DSAoBMet6ry64bIWM=
X-Google-Smtp-Source: AGHT+IFdM0YGkTA31TcTNyjAMSUBkzoHDq8wTZY+3lQzK3Gvy55vMXJ7rJnbZqh2eAD8y0Yep59W+Ns3oYwHbz72V+E=
X-Received: by 2002:a05:690c:4c06:b0:70f:8884:a5fc with SMTP id
 00721157ae682-719b4129516mr39550997b3.4.1753281246521; Wed, 23 Jul 2025
 07:34:06 -0700 (PDT)
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
 <CAPY8ntDLPDmgmE8+VQ4jchfNKLLEK5bZ10ftham9bK-x_HL8Xw@mail.gmail.com> <a89dbe5d-a30b-455d-adaf-31eadf2b3751@pengutronix.de>
In-Reply-To: <a89dbe5d-a30b-455d-adaf-31eadf2b3751@pengutronix.de>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 23 Jul 2025 15:33:48 +0100
X-Gm-Features: Ac12FXxCqzvs8tOlogOsNm4KLi0oz7j1OkzF1OLW8n-rahTjlq-sI0gx-wT9C3E
Message-ID: <CAPY8ntC+t9miX2396=PuhF2LX-wwoyg4zhXsj4yKAbsCt7+muA@mail.gmail.com>
Subject: Re: [PATCH 0/2] parse horizontal/vertical flip properties
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Jacopo Mondi <jacopo@jmondi.org>, linux-kernel@vger.kernel.org, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, entwicklung@pengutronix.de, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Jul 2025 at 14:48, Fabian Pfitzner <f.pfitzner@pengutronix.de> wrote:
>
> On 7/23/25 15:00, Dave Stevenson wrote:
> > Hi Jacopo and Fabian
> >
> > On Wed, 23 Jul 2025 at 13:21, Jacopo Mondi
> > <jacopo.mondi@ideasonboard.com> wrote:
> >> Hi Fabian
> >>
> >> On Wed, Jul 23, 2025 at 12:09:58PM +0200, Fabian Pfitzner wrote:
> >>> On 7/23/25 11:44, Jacopo Mondi wrote:
> >>>> On Wed, Jul 23, 2025 at 11:29:27AM +0200, Fabian Pfitzner wrote:
> >>>>> On 7/23/25 11:17, Jacopo Mondi wrote:
> >>>>>> Hi Fabian
> >>>>>>
> >>>>>> On Wed, Jul 23, 2025 at 10:58:28AM +0200, Fabian Pfitzner wrote:
> >>>>>>> There are cameras containing a mirror on their optical path e. g. when
> >>>>>>> mounted upside down.
> >>>>>> How is this different from 'rotation = 180' ?
> >>>>> If you simply want to flip the output (e. g. horizontally), you cannot do
> >>>>> this with a rotation.
> >>>>> The camera I'm referring to is not only upside down, but also flipped
> >>>>> horizontally.
> >>>> 180 degress rotation = HFLIP + VFLIP
> >>> I do not want to do both. Only one of them.
> >>>> Yes, you can't express 'mirror' in DTS, because DTS are about the
> >>>> physical mounting rotation of the camera. Sensor drivers shall not
> >>>> apply any flip control automatically, it's userspace that by parsing
> >>>> the rotation property through the associated v4l2 controls should decide
> >>>> if it has to apply flips or not to correct the images.
> >>>>
> >>>> What is the use case you had in mind ? Tell the driver through a DTS
> >>>> property it has to apply flips to auto-compensate ? Because I think we
> >>>> shouldn't and if I'm not mistaken we also document it:
> >>>> https://www.kernel.org/doc/html/latest/userspace-api/media/drivers/camera-sensor.html#rotation-orientation-and-flipping
> >>> I have a camera that does a horizontal flip in its hardware, so the output
> >> Sorry, I don't want to be annoying, but what does it mean "does a
> >> horizontal flip in the hardware" ?
> >>
> >> In my understanding either "in hardware" means you can't control it
> >> from software (and so there's no point in telling drivers what to do)
> >> or you can control it from software and it's a regular HFLIP.
> > Can you say what this sensor/module is?
> ClairPixel 8320
> >
> > To change flips due to physical sensor orientation is a very unusual
> > one. That would imply some weird mechanics in the sensor to add the
> > mirror and some form of orientation sensor being built in.
> Really? Imagine a door bell where an arbitrary camera is mounted such
> that it faces upwards (e. g. due to space limitations).
> Then you need a mirror in order to point into the "correct" direction.

That's not a function of the sensor then. I'd interpreted what you'd
written as the sensor itself magically changed the readout order to
add flips based on how it was mounted.

I'll agree with Jacopo that it is up to userspace to set the required
flips based on information provided by the driver. Userspace could
choose to flip the displayed image when rendering instead, which may
be necessary if the sensor driver doesn't support flip controls.

Your second patch parses these new properties into struct
v4l2_fwnode_device_properties, but then does nothing further with
them. I would have expected similar handling to V4L2_CID_ORIENTATION
and V4L2_CID_ROTATION in v4l2_ctrl_new_fwnode_properties to convert
them into V4L2 controls. Trying to change the behaviour in the driver
would again require changes for each and every sensor driver.
It does run the risk of conflicting with rotation though, so needs
some careful thought and specification with regard operation order
(rot 90 + HFLIP != HFLIP + rot 90).

  Dave

> Fixing the driver for an arbitrary camera driver does not seem to be a
> good solution.
> >
> > The closest instance I can think of would be ov5647 where the sense of
> > the H & V flip register bits are in opposition, but that doesn't
> > change based on how the sensor is mounted.
> > In that case the driver just needs to account for it when programming
> > those registers [1]. And I now note that I haven't upstreamed the
> > patch adding flip controls - another one for the to-do list. The
> > hardcoded register set in the mainline driver sets HFLIP (0x3821 bit
> > 2) but not VFLIP (0x3820 bit 2) [2].
> >
> >    Dave
> >
> > [1] https://github.com/raspberrypi/linux/commit/9e5d3fd3f47e91806a5c26f96732284f39098a58
> > [2] https://elixir.bootlin.com/linux/v6.15.7/source/drivers/media/i2c/ov5647.c#L153
> >
> >>> is not what I want. My example above was misleading. The rotation fixes the
> >>> "upside down" problem, but does not fix the flip.
> >>>
> >>> Doing that in userspace might be a solution, but in my opinion it is a bit
> >>> ugly to write a script that always sets the flip property from userspace
> >>> when the device was started.
> >>> A much cleaner way would be to simply set this property in the device tree
> >>> such that the driver can be initially configured with the proper values.
> >> Sorry, don't agree here. What if a sensor is mounted 90/270 degrees
> >> rotated (typical for mobile devices in example) ? You can't compensate
> >> it completely with flips, would you 270+HFLIP=90 ? would you leave it
> >> unmodified ? Userspace has to know and act accordingly, doing things
> >> in driver (will all drivers behave the same ? Will some compensate or
> >> other won't ?) is a recipe for more complex behaviours to handle.
> >>
> >>> PS: I have to send this email twice. The first one contained HTML parts that
> >>> were rejected by some receivers...
> >>>
> >>>> TL;DR drivers shall not flip, userspace should. Mirroring is an effect
> >>>> of drivers applying an HFLIP, because unless I'm missing something
> >>>> obvious, 'mirror' is not a physical mounting configuration of the camera
> >>>> sensor.
> >>>>
> >>>> FIY we're talking about something similar in libcamera
> >>>> https://lists.libcamera.org/pipermail/libcamera-devel/2025-July/051533.html
> >>>>
> >>>>>>> Introduce two options to change the device's flip property via device tree.
> >>>>>>>
> >>>>>>> As there is already support for the panel-common driver [1], add it for cameras in the same way.
> >>>>>>>
> >>>>>>> [1] commit 3c0ecd83eee9 ("dt-bindings: display: panel: Move flip properties to panel-common")
> >>>>>>>
> >>>>>>> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> >>>>>>> ---
> >>>>>>> Fabian Pfitzner (2):
> >>>>>>>          media: dt-bindings: add flip properties
> >>>>>>>          media: v4l: fwnode: parse horizontal/vertical flip properties
> >>>>>>>
> >>>>>>>     .../devicetree/bindings/media/video-interface-devices.yaml        | 8 ++++++++
> >>>>>>>     drivers/media/v4l2-core/v4l2-fwnode.c                             | 3 +++
> >>>>>>>     include/media/v4l2-fwnode.h                                       | 4 ++++
> >>>>>>>     3 files changed, 15 insertions(+)
> >>>>>>> ---
> >>>>>>> base-commit: 6832a9317eee280117cd695fa885b2b7a7a38daf
> >>>>>>> change-id: 20250718-fpf-media-dt-flip-7fcad30bcfb7
> >>>>>>>
> >>>>>>> Best regards,
> >>>>>>> --
> >>>>>>> Fabian Pfitzner <f.pfitzner@pengutronix.de>
> >>>>>>>
> >>>>> --
> >>>>> Pengutronix e.K.                           | Fabian Pfitzner             |
> >>>>> Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
> >>>>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> >>>>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
> >>>>>
> >>> --
> >>> Pengutronix e.K.                           | Fabian Pfitzner             |
> >>> Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
> >>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> >>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
> >>>
> >
> --
> Pengutronix e.K.                           | Fabian Pfitzner             |
> Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
>

