Return-Path: <linux-kernel+bounces-865068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D2419BFC12E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F348D357B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EE4346E7C;
	Wed, 22 Oct 2025 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HXsXbQ89"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057126ED4D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138866; cv=none; b=P40BOIZFs2ZsKnaHWsVrdswd0RTC6e3tK25DXzI0LYr1SIQidUaQip3NPPRNtXmbY0vYWNPNWpsW7TGKJFkQdq8tj0yAgLnK0RV9zqlUe0x8mXtV8smQZ4aUersM1l5t1MPj1lJ82AHVBlvvKFHWHbzEI3zUXMvK7pptDduaTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138866; c=relaxed/simple;
	bh=/hSb/+UzJgAiZsGscem0MjyIrSdJXmjn5q6fndiputU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzzUwXewgxTbpAzEukrgFlEStJx1wQpBokzpqZRPYIcl0kMYGbh8Wh5VxW/QBGIlCKKB9bB0/xJFUnN17y3cR/8TVtkvXI0Kdsz209Ck3gVGMWo1D1KJGJux7cPiMg26snhy3HLosQ6OBlXuQAxqAuWRmgYWMtzFywa2QqYqGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HXsXbQ89; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57e36125e8aso6499654e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761138863; x=1761743663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oJMkbkm0Thyr9SlTkJ+h78WVMFb+GiJwDkxV8fN6at8=;
        b=HXsXbQ89Os6f/7fPHMrRfqLWejNTdwCbx7RCDeFAFaHQBoh6zQYnYbnA8JcNt+zmXf
         LA/xa5k4rOJZlLkqdReBZGp8hZzDFOM7BkZPO2xNKVDvcs0XCuPz7GhjxJf5rHxJ5zVN
         xtETmBhcY5Qa7fe3xFdT0D+T2Vd0PYcN5eVqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138863; x=1761743663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJMkbkm0Thyr9SlTkJ+h78WVMFb+GiJwDkxV8fN6at8=;
        b=rhi3hltc5hXwYitTpuhl+YiyUIrWJbKUiG2+Ay42YcgEg0Bw1SQZMniAJ7A2WBe7N2
         eJGZb+CmDq2MVS42yFusuwTppmwxK77KeE6thcwCEit/rsq76/vPP+DJXKT8hEATTRux
         edp9OsaDgKt3CWfzw6gv2lclk9YgOhSwGnPmAjFuYKTOAmL6tYmf6mC3hOto50izrAFh
         QkyBhTR63l6ZQzSEpucCBt8g6B4sYh1WgxN5AQMkrohSB0QAFFYYQfcByVKJIz8cFLM5
         NDIS3RrfMS7FGwnq6EDZn7S276PUqVJlnHq7TrzNsQ8D28CB2jdIRAvCKcIvdUSpCDP2
         Vo5w==
X-Forwarded-Encrypted: i=1; AJvYcCXW0OmYr7+dutPrWpZqbA2HKFrRgmadju9FrDY4S+S9BdKCnxKSOscC9/HvjpMaSg/o2ZgdzX9hvjEjpzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+1t4s56yyfP5hagjpOz1ccdZzMyFb85tPc0SfON/ebumexO25
	tbVjnnUSA1laXYajg9oSJ5HvpqCl6anhuG2bultRVoMnL93yst61bPSQo6mv09t/4roJNQQvoOp
	43AGqwA==
X-Gm-Gg: ASbGncuyDwjjrgd2MwbDC9wFCNVe2hjViLkzvJ0DfWwdGttqAESqrnz2btX2QfipCKf
	vz2ACnJeog4l/GLTrYUXTW/LSIeLYQj0mKTrhYePNpZavxpieUT1LrJ4Yq92wKaEtYVkM/lVmD7
	Lke3leVh4zBP931YlHBUj3EzQ+0FJfyYor6/7lCR6u807Gaax/Pj2WANe0q/GyQVFlyy2pyrPVl
	lM/wUe3ARAbQ3K+/Xh4f3ni/FbLPICzKAuUdNNDJWppFK+T08gwG/Qtm6LSSc4xsb18nKotbIyB
	+2T8mIBAs6IuZq8REc03Zbjy/m4hCgglhHADV3TPBPqXhBvPTL+GuZ+nfJIJIHeeSoYUm4+l/Fi
	4Tlh/t+zrdDvmiZUw1HaGsaZPiSfCD7ZIrz/yv2LCLEcQ9DZ/M1s/9U3Q/S1vK+b7ae2pYZps1O
	End9J4gTbClUm2irHmuNjZJFLb+RykucVQoLm9yMVDzGTAU4S3
X-Google-Smtp-Source: AGHT+IHTbtWzmpMhBz3/tbLcN2OWfrQi+5yh46q4oQ3R9/uwqcTD9sbibVCcZ8V/C15/BOziTIOiQg==
X-Received: by 2002:a05:6512:ba1:b0:57c:2474:3733 with SMTP id 2adb3069b0e04-591d85982ebmr6906309e87.42.1761138862722;
        Wed, 22 Oct 2025 06:14:22 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def1b2e9sm4698789e87.86.2025.10.22.06.14.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 06:14:22 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-591ebf841ddso2320242e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:14:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZteeO2OuxdiApm9N9h6LiD42kS+Ca9vAN/yNElH7GHkZSymG6Uq0HVoGb4i06xpasUM0CRIDIzpOafJU=@vger.kernel.org
X-Received: by 2002:a05:6512:3e18:b0:592:f315:843 with SMTP id
 2adb3069b0e04-592f3150ac3mr255982e87.50.1761138861516; Wed, 22 Oct 2025
 06:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-uvc-grandstream-laurent-v1-1-0925738a3484@chromium.org>
 <20251022120849.GD727@pendragon.ideasonboard.com> <CANiDSCvtqe8MKpb=O-=Mv28dK+g=REi7kpdr-eyAD-mLLpzQJw@mail.gmail.com>
 <20251022124937.GE727@pendragon.ideasonboard.com> <CANiDSCscZgwUM0VCpdMvNKq0U2a6kOPbJmd4G8iY3EpsPQvZNw@mail.gmail.com>
 <20251022131236.GG19043@pendragon.ideasonboard.com>
In-Reply-To: <20251022131236.GG19043@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 Oct 2025 15:14:09 +0200
X-Gmail-Original-Message-ID: <CANiDSCsVOsCDjg_KU8Y82h9Ujfro4nQ=f4B1BezAkQtJUKFczg@mail.gmail.com>
X-Gm-Features: AS18NWAjg-Z1iViRllwLp5LrHwuLv-qEBFfsH4gAfXQVTtO8MadVnVb6LIhi__0
Message-ID: <CANiDSCsVOsCDjg_KU8Y82h9Ujfro4nQ=f4B1BezAkQtJUKFczg@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Create a specific id namespace for
 output entities
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 15:12, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Oct 22, 2025 at 03:08:58PM +0200, Ricardo Ribalda wrote:
> > On Wed, 22 Oct 2025 at 14:49, Laurent Pinchart wrote:
> > > On Wed, Oct 22, 2025 at 02:29:15PM +0200, Ricardo Ribalda wrote:
> > > > On Wed, 22 Oct 2025 at 14:09, Laurent Pinchart wrote:
> > > > > On Wed, Oct 22, 2025 at 11:55:16AM +0000, Ricardo Ribalda wrote:
> > > > > > Nothing can be connected from an output entity. Which means that no
> > > > >
> > > > > s/output entity/output terminal. Same below.
> > > > >
> > > > > Did you mean s/from an/to an/ ?
> > > > >
> > > > > > other entity can reference an output entity as baSourceId.
> > > > > >
> > > > >
> > > > > Some output terminals have controls, so we need to preserve their ID.
> > > > > That's why my proposal only set the UVC_TERM_OUTPUT bit for the
> > > > > *streaming* output terminals, not for all output terminals.
> > > > >
> > > > > > Use this fact to move all the output entities to a different namespace
> > > > > > id.
> > > > > >
> > > > > > The output entities are usually named after the dev_name() of the usb
> > > > > > device, so there should not be any uAPI change from this change.
> > > > > >
> > > > > > Although with this change we can handle some id collisions
> > > > > > automagically, change the logic of uvc_alloc_new_entity() to keep
> > > > > > showing a warning when a camera has invalid descriptors. Hopefully this
> > > > > > message will help vendors fix their invalid descriptors.
> > > > > >
> > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > ---
> > > > > > Hi, this patch fixes support for some devices with invalid USB
> > > > > > descriptor.
> > > > > >
> > > > > > It is orthogonal to:
> > > > > > https://lore.kernel.org/linux-media/20251021184213.GC19043@pendragon.ideasonboard.com/T/#t
> > > > > >
> > > > > > Some devices will be fixed by the other patch, other devices will be
> > > > > > fixed by this. In my opinion is worth to land both patches.
> > > > > >
> > > > > > Tested with GRANDSTREAM GUV3100 in a 6.6 kernel.
> > > > > > ---
> > > > > >  drivers/media/usb/uvc/uvc_driver.c | 23 +++++++++++++++++++----
> > > > > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > index fb6afb8e84f00961f86fd8f840fba48d706d7a9a..40f8ae0df89e104992f5d55af3d3539dea3d146e 100644
> > > > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > @@ -165,10 +165,14 @@ static struct uvc_entity *uvc_entity_by_reference(struct uvc_device *dev,
> > > > > >       return NULL;
> > > > > >  }
> > > > > >
> > > > > > +#define ENTITY_HARDWARE_ID(id) ((id) & ~UVC_TERM_OUTPUT)
> > > > >
> > > > > This needs a UVC_ prefix, and should probably go to uvcvideo.h. You can
> > > > > also & 0xff, as the UVC descriptors store IDs in 8-bit fields.
> > > > >
> > > > > > +
> > > > > >  static struct uvc_streaming *uvc_stream_by_id(struct uvc_device *dev, int id)
> > > > > >  {
> > > > > >       struct uvc_streaming *stream;
> > > > > >
> > > > > > +     id = ENTITY_HARDWARE_ID(id);
> > > > > > +
> > >
> > > Another comment, I would have done this in the (single) caller, to keep
> > > operating on real ids in this function. Or we could pass a struct
> > > uvc_entity instead of an int id and rename the function to
> > > uvc_stream_for_terminal(), which could better encapsulate the purpose.
> >
> > Like the second option better.
>
> I think I do too.
>
> > > > > >       list_for_each_entry(stream, &dev->streams, list) {
> > > > > >               if (stream->header.bTerminalLink == id)
> > > > > >                       return stream;
> > > > > > @@ -810,10 +814,12 @@ static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
> > > > > >       }
> > > > > >
> > > > > >       /* Per UVC 1.1+ spec 3.7.2, the ID is unique. */
> > > > > > -     if (uvc_entity_by_id(dev, id)) {
> > > > > > -             dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n", id);
> > > > > > +     if (uvc_entity_by_id(dev, ENTITY_HARDWARE_ID(id)))
> > > > > > +             dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n",
> > > > > > +                     ENTITY_HARDWARE_ID(id));
> > > > >
> > > > > It's not an error anymore if there's no collision of the full 16-bit ID,
> > > > > right ? Should it be demoted to a dev_warn() ?
> > > >
> > > > if it is OK with you I'd rather keep the dev_err(). If an ISP
> > > > manufacturer tests their camera in Linux I want them to really notice
> > > > that there is an error.
> > >
> > > Yes I'm OK with that. It shouldn't happen. We want a dev_err_and_blame()
> > > that prints a message to the kernel log and posts messages on social
> > > networks to blame the hardware manufacturer.
> > >
> > > > Besides that, I have implemented all your proposed changes.
> > > >
> > > > I cannot test it until tomorrow in real hardware. But the changes are
> > > > trivial, let me know if I shall send the v2 right now or wait til it
> > > > is tested.
> > >
> > > Up to you, I don't mind either way.
> > >
> > > If we merge "[PATCH v2] media: uvcvideo: Use heuristic to find stream
> > > entity" first, do you plan to revert it to get this patch merged ?
> >
> > I think they solve two different issues:
> >
> > - Output terminal id collides with another entity id.
> > - Incorrect bTerminalLink
>
> Do we know of any device affected by that issue ?

I bet you there is one :)

>
> >  We can have the two patches in.  If there is any conflict because we
> > land one and then the other I can send a v3 fixing the conflict. Or a
> > maintainer can do that, they should be trivial conflicts.
> >
> > > > > > +
> > > > > > +     if (uvc_entity_by_id(dev, id))
> > > > > >               id = UVC_INVALID_ENTITY_ID;
> > > > > > -     }
> > > > > >
> > > > > >       extra_size = roundup(extra_size, sizeof(*entity->pads));
> > > > > >       if (num_pads)
> > > > > > @@ -969,6 +975,7 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
> > > > > >       struct usb_host_interface *alts = dev->intf->cur_altsetting;
> > > > > >       unsigned int i, n, p, len;
> > > > > >       const char *type_name;
> > > > > > +     unsigned int id;
> > > > > >       u16 type;
> > > > > >
> > > > > >       switch (buffer[2]) {
> > > > > > @@ -1107,8 +1114,16 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
> > > > > >                       return 0;
> > > > > >               }
> > > > > >
> > > > > > +             /*
> > > > > > +              * Nothing can be connected from an output terminal. To avoid
> > > > > > +              * entity-id's collisions in devices with invalid USB
> > > > > > +              * descriptors, move the output terminal id to its own
> > > > > > +              * namespace.
> > > > > > +              */
> > > > > > +             id = buffer[3] | UVC_TERM_OUTPUT;
> > > > > > +
> > > > > >               term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,
> > > > > > -                                         buffer[3], 1, 0);
> > > > > > +                                         id, 1, 0);
> > > > > >               if (IS_ERR(term))
> > > > > >                       return PTR_ERR(term);
> > > > > >
> > > > > >
> > > > > > ---
> > > > > > base-commit: ea299a2164262ff787c9d33f46049acccd120672
> > > > > > change-id: 20251022-uvc-grandstream-laurent-3f9abb8a0d5b
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

