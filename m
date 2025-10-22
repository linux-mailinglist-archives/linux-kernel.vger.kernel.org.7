Return-Path: <linux-kernel+bounces-865050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7C1BFC1A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61ED76260FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCF6345CBA;
	Wed, 22 Oct 2025 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WjV/dKDw"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502E26ED5E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138557; cv=none; b=dUw3yELljeAZRA7qalpL1ouFsNijJ+ldma/1VQ89VMnJSjuw2ImNdQGbLi8gQnL2aFQNhKU1Pb+buqerZihdPTVKRlK7t+n9XSwsHHpUmrjRCNWtf1x7icbb5NQGqhjvfj1f4xeA5nWeMoYsPi8dkw3Q0q/cSFZFaQ4dfZNXaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138557; c=relaxed/simple;
	bh=RBXxDCERFUy+wUBxB01HnpU+uq73YtGp47zZ13gfmvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/Ehg6g9QZ4ss3fi/tlkDAQBWNLZqariTDNcdfmn7d2wgPBOfWXmcXGuQ3Ef5zP/4vVmMh0kKUxoPt7bmvU/e16t21NJ26vGaFeyPMQJjRkY+JJTTnZQiGfqOMPDEqzN1FRNGUprjQZN0sApkpmnzWF7/Q/OOxwwKlBDOKnHkYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WjV/dKDw; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-378cfbf83f2so5334701fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761138553; x=1761743353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AXGvv+Y1jV7JovByIaEcMd+FcuJA2nc0qLNBaH9UXNY=;
        b=WjV/dKDwky15unZEbVhXkkEOmvR2QuiuRTg8R8wMK/EnXhiQK9RtkOGOYHVjvJxJA4
         Bu2T+NswZCVZq6eHJ6KDAOCzXx/l4S4BmZvGAm9VQ0mg3DzSPpFvZ2Jzr5dHuOA3mYtF
         wRok36C0KlCMz/bQO5dYPMA8zU/sbvAWIWfeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138553; x=1761743353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXGvv+Y1jV7JovByIaEcMd+FcuJA2nc0qLNBaH9UXNY=;
        b=vPpe4s4HAM+cgJ94tgKFiM1PmBzhuvpWT/Chy2dlVmxaoPtAlEaw08JT7w0YsSP+9U
         eDZOaGDm9GYL+EIQIgtZJsZg7a04c4qrgYlwa9WVIYyOgj4X7jq2+8Q/TxAQwsrHUjnQ
         idbDcAsgmCqTcTrhQy3WyGtwaAC2nTyby/8YinYRrMx3v8T5GDEmIVVOgacOqckXfgao
         zCq3Dn1GOfhv9/Iyhkr2wXHQYOtwD4aDHPKDelq5WQjk2z3rqwzJPeIbbVy9846Nq3qF
         I+EC3H3HUpZKV2P0kHvgYes81/hOrG/t1S29zT5dFkZ0tFwbdqWbf36wFwfm8ZRyp4vs
         9zwA==
X-Forwarded-Encrypted: i=1; AJvYcCVhyiECv/PuuByT5p3qG1SHvJYaiPX4dEu28JLv8zazz/Kq+/2ivp3fD4Ilg56e9uduHFsyWVllv1Tdclo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOOb7hmU6TzAklLn9GLZ+XikGrzksSe1AFWSllRm7ZlMT30Di3
	orXU270+7GRUN1rUD+6pSuj+UmGQj8iBPxFtMuLE18m8hfUs1N5jkUHZyoIbGUVwjUlNVypVnDX
	mggEVbw==
X-Gm-Gg: ASbGncuHDlLadkyvbt72n1z3OLPkjpNhMxTrQuTwLyksF7By364hKbjRHBj3VGyd/WD
	3x12yl7M8gSQuEn4RKBF80byky4S+2guvMAtaDN6uTwRept/IvUWFowFwl5HhUCo1cJT6W3ZEQt
	wMi+dTshQL8dr06SP9vWF5HyxKPFUojduqKJKmigWsu2uAN/dj2u3fBjDbEfuwooc/EG2dJ3/xs
	nBbb34OewHspac+bxmoCcg6n47TJOHbvxMHJDSCYKDlCY/i8180buL0QUKboAoy5tRM5TnLyqdk
	v9KwZ0C6Mxslp2MpChuHqlUHvU8N5SgU/uonaWmY+ehH/objFIHRhK843HP4ea9fgUPnkx2H61R
	sSMWemoS11RuO8frM9s9VjZd6QuwhQJbJpN1WRG2FgXd22yQh1+Iq6oLgofGWRm0TSg18hvtONA
	7FkjVX+a4agNT+teaC+yz2YUVV4UYqsHxzH9TfZimGiM80NyL4i0duLrJbajo=
X-Google-Smtp-Source: AGHT+IEoQNxeC/RjSCoxtr0hO3n2kvNPOjrDiTZj1nWOckTa8hbyWpWw1x7VwrASZ+M4NxCjx+bNMw==
X-Received: by 2002:a2e:be0a:0:b0:34c:e79:7827 with SMTP id 38308e7fff4ca-3779793763amr63016411fa.21.1761138552516;
        Wed, 22 Oct 2025 06:09:12 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592ddc3662fsm961190e87.84.2025.10.22.06.09.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 06:09:11 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso7980068e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:09:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFRneXhUIFcIuIDmp7icUXpbLNqItwpY4MNI80QcO03NlhlaQnWI+EcN0XyjurKMLsVglL/cUHqRkLtP4=@vger.kernel.org
X-Received: by 2002:a05:6512:b11:b0:572:f47:d10e with SMTP id
 2adb3069b0e04-591d84eb2e6mr7236014e87.3.1761138551207; Wed, 22 Oct 2025
 06:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-uvc-grandstream-laurent-v1-1-0925738a3484@chromium.org>
 <20251022120849.GD727@pendragon.ideasonboard.com> <CANiDSCvtqe8MKpb=O-=Mv28dK+g=REi7kpdr-eyAD-mLLpzQJw@mail.gmail.com>
 <20251022124937.GE727@pendragon.ideasonboard.com>
In-Reply-To: <20251022124937.GE727@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 Oct 2025 15:08:58 +0200
X-Gmail-Original-Message-ID: <CANiDSCscZgwUM0VCpdMvNKq0U2a6kOPbJmd4G8iY3EpsPQvZNw@mail.gmail.com>
X-Gm-Features: AS18NWClkgpLnT5WZ_y5AoAe9CpdDHLhPPjp8XnQAQ6S3MH9wfvYuNoNQIyQn6o
Message-ID: <CANiDSCscZgwUM0VCpdMvNKq0U2a6kOPbJmd4G8iY3EpsPQvZNw@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Create a specific id namespace for
 output entities
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Wed, 22 Oct 2025 at 14:49, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Oct 22, 2025 at 02:29:15PM +0200, Ricardo Ribalda wrote:
> > On Wed, 22 Oct 2025 at 14:09, Laurent Pinchart wrote:
> > > On Wed, Oct 22, 2025 at 11:55:16AM +0000, Ricardo Ribalda wrote:
> > > > Nothing can be connected from an output entity. Which means that no
> > >
> > > s/output entity/output terminal. Same below.
> > >
> > > Did you mean s/from an/to an/ ?
> > >
> > > > other entity can reference an output entity as baSourceId.
> > > >
> > >
> > > Some output terminals have controls, so we need to preserve their ID.
> > > That's why my proposal only set the UVC_TERM_OUTPUT bit for the
> > > *streaming* output terminals, not for all output terminals.
> > >
> > > > Use this fact to move all the output entities to a different namespace
> > > > id.
> > > >
> > > > The output entities are usually named after the dev_name() of the usb
> > > > device, so there should not be any uAPI change from this change.
> > > >
> > > > Although with this change we can handle some id collisions
> > > > automagically, change the logic of uvc_alloc_new_entity() to keep
> > > > showing a warning when a camera has invalid descriptors. Hopefully this
> > > > message will help vendors fix their invalid descriptors.
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > > Hi, this patch fixes support for some devices with invalid USB
> > > > descriptor.
> > > >
> > > > It is orthogonal to:
> > > > https://lore.kernel.org/linux-media/20251021184213.GC19043@pendragon.ideasonboard.com/T/#t
> > > >
> > > > Some devices will be fixed by the other patch, other devices will be
> > > > fixed by this. In my opinion is worth to land both patches.
> > > >
> > > > Tested with GRANDSTREAM GUV3100 in a 6.6 kernel.
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_driver.c | 23 +++++++++++++++++++----
> > > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > index fb6afb8e84f00961f86fd8f840fba48d706d7a9a..40f8ae0df89e104992f5d55af3d3539dea3d146e 100644
> > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > @@ -165,10 +165,14 @@ static struct uvc_entity *uvc_entity_by_reference(struct uvc_device *dev,
> > > >       return NULL;
> > > >  }
> > > >
> > > > +#define ENTITY_HARDWARE_ID(id) ((id) & ~UVC_TERM_OUTPUT)
> > >
> > > This needs a UVC_ prefix, and should probably go to uvcvideo.h. You can
> > > also & 0xff, as the UVC descriptors store IDs in 8-bit fields.
> > >
> > > > +
> > > >  static struct uvc_streaming *uvc_stream_by_id(struct uvc_device *dev, int id)
> > > >  {
> > > >       struct uvc_streaming *stream;
> > > >
> > > > +     id = ENTITY_HARDWARE_ID(id);
> > > > +
>
> Another comment, I would have done this in the (single) caller, to keep
> operating on real ids in this function. Or we could pass a struct
> uvc_entity instead of an int id and rename the function to
> uvc_stream_for_terminal(), which could better encapsulate the purpose.

Like the second option better.

>
> > > >       list_for_each_entry(stream, &dev->streams, list) {
> > > >               if (stream->header.bTerminalLink == id)
> > > >                       return stream;
> > > > @@ -810,10 +814,12 @@ static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
> > > >       }
> > > >
> > > >       /* Per UVC 1.1+ spec 3.7.2, the ID is unique. */
> > > > -     if (uvc_entity_by_id(dev, id)) {
> > > > -             dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n", id);
> > > > +     if (uvc_entity_by_id(dev, ENTITY_HARDWARE_ID(id)))
> > > > +             dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n",
> > > > +                     ENTITY_HARDWARE_ID(id));
> > >
> > > It's not an error anymore if there's no collision of the full 16-bit ID,
> > > right ? Should it be demoted to a dev_warn() ?
> >
> > if it is OK with you I'd rather keep the dev_err(). If an ISP
> > manufacturer tests their camera in Linux I want them to really notice
> > that there is an error.
>
> Yes I'm OK with that. It shouldn't happen. We want a dev_err_and_blame()
> that prints a message to the kernel log and posts messages on social
> networks to blame the hardware manufacturer.
>
> > Besides that, I have implemented all your proposed changes.
> >
> > I cannot test it until tomorrow in real hardware. But the changes are
> > trivial, let me know if I shall send the v2 right now or wait til it
> > is tested.
>
> Up to you, I don't mind either way.
>
> If we merge "[PATCH v2] media: uvcvideo: Use heuristic to find stream
> entity" first, do you plan to revert it to get this patch merged ?

I think they solve two different issues:

- Output terminal id collides with another entity id.
- Incorrect bTerminalLink


 We can have the two patches in.  If there is any conflict because we
land one and then the other I can send a v3 fixing the conflict. Or a
maintainer can do that, they should be trivial conflicts.

Regards



>
> > > > +
> > > > +     if (uvc_entity_by_id(dev, id))
> > > >               id = UVC_INVALID_ENTITY_ID;
> > > > -     }
> > > >
> > > >       extra_size = roundup(extra_size, sizeof(*entity->pads));
> > > >       if (num_pads)
> > > > @@ -969,6 +975,7 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
> > > >       struct usb_host_interface *alts = dev->intf->cur_altsetting;
> > > >       unsigned int i, n, p, len;
> > > >       const char *type_name;
> > > > +     unsigned int id;
> > > >       u16 type;
> > > >
> > > >       switch (buffer[2]) {
> > > > @@ -1107,8 +1114,16 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
> > > >                       return 0;
> > > >               }
> > > >
> > > > +             /*
> > > > +              * Nothing can be connected from an output terminal. To avoid
> > > > +              * entity-id's collisions in devices with invalid USB
> > > > +              * descriptors, move the output terminal id to its own
> > > > +              * namespace.
> > > > +              */
> > > > +             id = buffer[3] | UVC_TERM_OUTPUT;
> > > > +
> > > >               term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,
> > > > -                                         buffer[3], 1, 0);
> > > > +                                         id, 1, 0);
> > > >               if (IS_ERR(term))
> > > >                       return PTR_ERR(term);
> > > >
> > > >
> > > > ---
> > > > base-commit: ea299a2164262ff787c9d33f46049acccd120672
> > > > change-id: 20251022-uvc-grandstream-laurent-3f9abb8a0d5b
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

