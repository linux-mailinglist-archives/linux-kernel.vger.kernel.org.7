Return-Path: <linux-kernel+bounces-866871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EA6C00DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45F2E4F98DF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2853D30E835;
	Thu, 23 Oct 2025 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iyWYQihf"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECEE2D2481
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220079; cv=none; b=oT4FkNEgmZyfkxK8nYvi4PUuc3pb0LwmTGg+hwVzjU3z+oaNHEjijjsPMPVKiwpT57Sag8hS8aamIk3za7heiH7yBPpHFFH1S5OGjQ0MQBDGDkAiX/4Hyy+tUR7BpGz1rbqAo8sH6fQQZcxPRBMKrPi8y+7xphaGbsMfRwNzpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220079; c=relaxed/simple;
	bh=2UP5+TpIIwsaMxmuIF3VfGdTMIyzpI9UdkWp4UaifCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kk+LxshIu3GGsbWyNMcH6sR5H5eB1uhDGYw1pgw2SVLaFZ/Wq0G0jco9jG2fkSvi57AYGBiuTYVGDfsAA4LehzJq4UrNPxH/rs6/GG4+XUxqw65HNDngcsn16Q1dk9LX7V0yM8XoK78N4hASMmYahQfmqEH9TF7SAkHx5m23X+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iyWYQihf; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so794191e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761220075; x=1761824875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fGZy7UhXL07Yk+nTSbfLuUtLjU6n/6JfdEPHyt8vOhk=;
        b=iyWYQihfs9VQnqZaCeYus/fQ2HistTOEL90h4bZN2+lM7SmNtYo0/lwHAUxiXUBnyh
         n3VmAvX3g0EtnaIYcOrqLK6ydUwhfLTB8gbCThuUNrryPD6kjreYPEQsKgYgElviEqNT
         1TPCGCxIR+L3QtpYP3Mnf7TZgs4t0ie2C9GnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220075; x=1761824875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGZy7UhXL07Yk+nTSbfLuUtLjU6n/6JfdEPHyt8vOhk=;
        b=j9luWNSn3Jlgf3XY9FoM4cBaqXXd++Gs57FOzLU3ZFWxM2M4b4HThl426FPWbjxjul
         vjnTqvPJXCVvb+5SC9A+3kHI06O2ScrmlWwb6U2j2jtpgKEfx5Id+imEGlhqVDz1daPj
         y+1XWhf5NeYA9YiLKotiPIouPSvSNqhuQWfGqD3qoze4wAbqrrMstEsoxsentyC3N+WV
         srhCCbAON1uq/6BGALytQmQ4a8yPt+1/xHK6rsrnnmDttSJyRCIDfg6/vQLmmQQQbl0B
         PCnkTPVYEMcc0aIH8I9yKKcviVMKLWd4UQU5Tb5H6Mkf2wBNIV2LXovURbD4hm/lO0v0
         aa+w==
X-Forwarded-Encrypted: i=1; AJvYcCUor9Z77Tn5W7vre7HhI4hqHKmbFVLJhQ1zOefok3SWBTRNVqDo5H0+PAIrGtRReEK6q5E9Gi+yeaE6WVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweJwX5V7wEqrxdhJ/3ZPFd0i8kb4a2rRAxbzkvO4y0McFydDP6
	tjSQBZomvOQe9Ftfn2CTzvusaNcfbBfQ2xJAO8KqWPimYEW1XP3x6nW/dpNRK49BicFzS2ooXEX
	kD7k=
X-Gm-Gg: ASbGnctCytqkZ3oJkBabq2ovDfrlxZLSH8AAnntkQXxGxtOUeh05gcPz/BxgSXAEWUQ
	Ak0RGOKTn4p3JXjNkwCbXXj4oUPbAwpsXMA7rFwerZkX68L/P83mN/Ip3m8z7shdZr3lViMzUNW
	0MGcJig9e3i60lbZn4Vell7nlDbVPRRcgOULPvB/ukFBkco6u/v6nWXX7IsMlf671T8t2qDn5JG
	WPglEF7q13bH7nC/sNmPMdZ+0zWpvj7owlVyyDUZ0O5DOwhqES/rKYTGjPZ/86MrV9W26sk7LgR
	c6NQ/hJ/s6KLbB89TZYk38DMrJHxGB8aiUcbSK1KEfLAyKU+GPKE8vEZYKocM5e7EiWJQw64vxm
	ChxIJu9RFJ8jTBTkJYh97OuHDGZCE+nXn+QPzSJJTu4Jh5ZkI5pXD8vyjgCvnyHQBa33w1FDcS9
	pDmGCQ8rxRGrUW92TtAZYkNqjQ6dMJ622vtcEjVan7/0j+r3UP
X-Google-Smtp-Source: AGHT+IHbQDlJTSRlsk+llx69FVfs24MMiK7OwSGgldAn2h2w55/1mv6jbZyj0o0UhWB728+RMH8GlQ==
X-Received: by 2002:a05:6512:130c:b0:586:83e2:2295 with SMTP id 2adb3069b0e04-591d85525f5mr8126478e87.45.1761220074936;
        Thu, 23 Oct 2025 04:47:54 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d38709sm660774e87.106.2025.10.23.04.47.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:47:54 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-592f7733dd6so581413e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:47:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbPSdl1S9pwjHxIPKRPrbTHwY7yq3Zt4iu+fx8WXWoJOYS4hGIbVsfKQiwcWGV1lx/lCxe4/ovfQKsYLI=@vger.kernel.org
X-Received: by 2002:a05:6512:31c2:b0:57b:8675:e430 with SMTP id
 2adb3069b0e04-591d84e73damr8218591e87.13.1761220073779; Thu, 23 Oct 2025
 04:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-uvc-grandstream-laurent-v1-1-0925738a3484@chromium.org>
 <20251022120849.GD727@pendragon.ideasonboard.com> <CANiDSCvtqe8MKpb=O-=Mv28dK+g=REi7kpdr-eyAD-mLLpzQJw@mail.gmail.com>
 <20251022124937.GE727@pendragon.ideasonboard.com> <CANiDSCscZgwUM0VCpdMvNKq0U2a6kOPbJmd4G8iY3EpsPQvZNw@mail.gmail.com>
 <20251022131236.GG19043@pendragon.ideasonboard.com> <CANiDSCsVOsCDjg_KU8Y82h9Ujfro4nQ=f4B1BezAkQtJUKFczg@mail.gmail.com>
 <20251023112459.GJ19043@pendragon.ideasonboard.com>
In-Reply-To: <20251023112459.GJ19043@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 23 Oct 2025 13:47:39 +0200
X-Gmail-Original-Message-ID: <CANiDSCuex8w8GvMuKMyZw5sBCeW0wLteRJy97LG5Z_TDbWZ71w@mail.gmail.com>
X-Gm-Features: AS18NWDvdforVS-BLaFC8rCUkYDwOEMGrcUKGumoD2gxt_kTgWGVeSMAqavOLow
Message-ID: <CANiDSCuex8w8GvMuKMyZw5sBCeW0wLteRJy97LG5Z_TDbWZ71w@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Create a specific id namespace for
 output entities
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 13:25, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Oct 22, 2025 at 03:14:09PM +0200, Ricardo Ribalda wrote:
> > On Wed, 22 Oct 2025 at 15:12, Laurent Pinchart wrote:
> > > On Wed, Oct 22, 2025 at 03:08:58PM +0200, Ricardo Ribalda wrote:
> > > > On Wed, 22 Oct 2025 at 14:49, Laurent Pinchart wrote:
> > > > > On Wed, Oct 22, 2025 at 02:29:15PM +0200, Ricardo Ribalda wrote:
> > > > > > On Wed, 22 Oct 2025 at 14:09, Laurent Pinchart wrote:
> > > > > > > On Wed, Oct 22, 2025 at 11:55:16AM +0000, Ricardo Ribalda wrote:
> > > > > > > > Nothing can be connected from an output entity. Which means that no
> > > > > > >
> > > > > > > s/output entity/output terminal. Same below.
> > > > > > >
> > > > > > > Did you mean s/from an/to an/ ?
> > > > > > >
> > > > > > > > other entity can reference an output entity as baSourceId.
> > > > > > > >
> > > > > > >
> > > > > > > Some output terminals have controls, so we need to preserve their ID.
> > > > > > > That's why my proposal only set the UVC_TERM_OUTPUT bit for the
> > > > > > > *streaming* output terminals, not for all output terminals.
> > > > > > >
> > > > > > > > Use this fact to move all the output entities to a different namespace
> > > > > > > > id.
> > > > > > > >
> > > > > > > > The output entities are usually named after the dev_name() of the usb
> > > > > > > > device, so there should not be any uAPI change from this change.
> > > > > > > >
> > > > > > > > Although with this change we can handle some id collisions
> > > > > > > > automagically, change the logic of uvc_alloc_new_entity() to keep
> > > > > > > > showing a warning when a camera has invalid descriptors. Hopefully this
> > > > > > > > message will help vendors fix their invalid descriptors.
> > > > > > > >
> > > > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > > > ---
> > > > > > > > Hi, this patch fixes support for some devices with invalid USB
> > > > > > > > descriptor.
> > > > > > > >
> > > > > > > > It is orthogonal to:
> > > > > > > > https://lore.kernel.org/linux-media/20251021184213.GC19043@pendragon.ideasonboard.com/T/#t
> > > > > > > >
> > > > > > > > Some devices will be fixed by the other patch, other devices will be
> > > > > > > > fixed by this. In my opinion is worth to land both patches.
> > > > > > > >
> > > > > > > > Tested with GRANDSTREAM GUV3100 in a 6.6 kernel.
> > > > > > > > ---
> > > > > > > >  drivers/media/usb/uvc/uvc_driver.c | 23 +++++++++++++++++++----
> > > > > > > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > > index fb6afb8e84f00961f86fd8f840fba48d706d7a9a..40f8ae0df89e104992f5d55af3d3539dea3d146e 100644
> > > > > > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > > @@ -165,10 +165,14 @@ static struct uvc_entity *uvc_entity_by_reference(struct uvc_device *dev,
> > > > > > > >       return NULL;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +#define ENTITY_HARDWARE_ID(id) ((id) & ~UVC_TERM_OUTPUT)
> > > > > > >
> > > > > > > This needs a UVC_ prefix, and should probably go to uvcvideo.h. You can
> > > > > > > also & 0xff, as the UVC descriptors store IDs in 8-bit fields.
> > > > > > >
> > > > > > > > +
> > > > > > > >  static struct uvc_streaming *uvc_stream_by_id(struct uvc_device *dev, int id)
> > > > > > > >  {
> > > > > > > >       struct uvc_streaming *stream;
> > > > > > > >
> > > > > > > > +     id = ENTITY_HARDWARE_ID(id);
> > > > > > > > +
> > > > >
> > > > > Another comment, I would have done this in the (single) caller, to keep
> > > > > operating on real ids in this function. Or we could pass a struct
> > > > > uvc_entity instead of an int id and rename the function to
> > > > > uvc_stream_for_terminal(), which could better encapsulate the purpose.
> > > >
> > > > Like the second option better.
> > >
> > > I think I do too.
> > >
> > > > > > > >       list_for_each_entry(stream, &dev->streams, list) {
> > > > > > > >               if (stream->header.bTerminalLink == id)
> > > > > > > >                       return stream;
> > > > > > > > @@ -810,10 +814,12 @@ static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
> > > > > > > >       }
> > > > > > > >
> > > > > > > >       /* Per UVC 1.1+ spec 3.7.2, the ID is unique. */
> > > > > > > > -     if (uvc_entity_by_id(dev, id)) {
> > > > > > > > -             dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n", id);
> > > > > > > > +     if (uvc_entity_by_id(dev, ENTITY_HARDWARE_ID(id)))
> > > > > > > > +             dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n",
> > > > > > > > +                     ENTITY_HARDWARE_ID(id));
> > > > > > >
> > > > > > > It's not an error anymore if there's no collision of the full 16-bit ID,
> > > > > > > right ? Should it be demoted to a dev_warn() ?
> > > > > >
> > > > > > if it is OK with you I'd rather keep the dev_err(). If an ISP
> > > > > > manufacturer tests their camera in Linux I want them to really notice
> > > > > > that there is an error.
> > > > >
> > > > > Yes I'm OK with that. It shouldn't happen. We want a dev_err_and_blame()
> > > > > that prints a message to the kernel log and posts messages on social
> > > > > networks to blame the hardware manufacturer.
> > > > >
> > > > > > Besides that, I have implemented all your proposed changes.
> > > > > >
> > > > > > I cannot test it until tomorrow in real hardware. But the changes are
> > > > > > trivial, let me know if I shall send the v2 right now or wait til it
> > > > > > is tested.
> > > > >
> > > > > Up to you, I don't mind either way.
> > > > >
> > > > > If we merge "[PATCH v2] media: uvcvideo: Use heuristic to find stream
> > > > > entity" first, do you plan to revert it to get this patch merged ?
> > > >
> > > > I think they solve two different issues:
> > > >
> > > > - Output terminal id collides with another entity id.
> > > > - Incorrect bTerminalLink
> > >
> > > Do we know of any device affected by that issue ?
> >
> > I bet you there is one :)
>
> I'd rather be cautious and address that if the issue arises. Enabling
> non-compliant behaviour has the drawback of making issues less visible
> to vendors, so I would prefer not working around problems unless we know
> they exist.

My main goal right now is to solve the regression.

If you think that this approach is best, please add your review-by and
the following tags to the patch. And let's start landing into upstream
asap.

We can discuss later if we want an extra patch or if we want to wait
for another report.


Reported-by: Angel4005 <ooara1337@gmail.com>
Closes: https://lore.kernel.org/linux-media/CAOzBiVuS7ygUjjhCbyWg-KiNx+HFTYnqH5+GJhd6cYsNLT=DaA@mail.gmail.com/
Fixes: 0e2ee70291e6 ("media: uvcvideo: Mark invalid entities with id
UVC_INVALID_ENTITY_ID")

Regards!



>
> > > >  We can have the two patches in.  If there is any conflict because we
> > > > land one and then the other I can send a v3 fixing the conflict. Or a
> > > > maintainer can do that, they should be trivial conflicts.
> > > >
> > > > > > > > +
> > > > > > > > +     if (uvc_entity_by_id(dev, id))
> > > > > > > >               id = UVC_INVALID_ENTITY_ID;
> > > > > > > > -     }
> > > > > > > >
> > > > > > > >       extra_size = roundup(extra_size, sizeof(*entity->pads));
> > > > > > > >       if (num_pads)
> > > > > > > > @@ -969,6 +975,7 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
> > > > > > > >       struct usb_host_interface *alts = dev->intf->cur_altsetting;
> > > > > > > >       unsigned int i, n, p, len;
> > > > > > > >       const char *type_name;
> > > > > > > > +     unsigned int id;
> > > > > > > >       u16 type;
> > > > > > > >
> > > > > > > >       switch (buffer[2]) {
> > > > > > > > @@ -1107,8 +1114,16 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
> > > > > > > >                       return 0;
> > > > > > > >               }
> > > > > > > >
> > > > > > > > +             /*
> > > > > > > > +              * Nothing can be connected from an output terminal. To avoid
> > > > > > > > +              * entity-id's collisions in devices with invalid USB
> > > > > > > > +              * descriptors, move the output terminal id to its own
> > > > > > > > +              * namespace.
> > > > > > > > +              */
> > > > > > > > +             id = buffer[3] | UVC_TERM_OUTPUT;
> > > > > > > > +
> > > > > > > >               term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,
> > > > > > > > -                                         buffer[3], 1, 0);
> > > > > > > > +                                         id, 1, 0);
> > > > > > > >               if (IS_ERR(term))
> > > > > > > >                       return PTR_ERR(term);
> > > > > > > >
> > > > > > > >
> > > > > > > > ---
> > > > > > > > base-commit: ea299a2164262ff787c9d33f46049acccd120672
> > > > > > > > change-id: 20251022-uvc-grandstream-laurent-3f9abb8a0d5b
>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda

