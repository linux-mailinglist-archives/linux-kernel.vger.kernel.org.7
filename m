Return-Path: <linux-kernel+bounces-868726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1F4C05FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA233BB14A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC140319614;
	Fri, 24 Oct 2025 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hhY0rXAA"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690CA274FC1
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303672; cv=none; b=Wm6bRoEOR7fStjEZaE8FobTqlj2b7QdXqOB5wN4Jt/F/YFHFSaDZ4foWCn/eKND+aOKqSSGd5vONhdCt5oUZ3Smk9RpV2l2OKIQWHC/SfxHRp3QaS5eGPaaDxfl8gKPVJwd0r29Jp56eUTI4v2ylmDTLjPKIRcyfGPrwFWTIZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303672; c=relaxed/simple;
	bh=S5sYSyf+Zlamnyf5bP2W7Lhiz91LIVXyH8JCfOOM+28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJXG41ncDdoCJYcAg81WjEDbKXaNabD35OI+oxN7hgKvt4kM0Ft/yw0cSF+iR20JOxD1zHuUhEGGPGQMSOxDVU5tu3axiuQJ6Yly7dLyH32NZnp+BjYVmRWHPh9S4ykc9HGMmfsQP0rGVx/AloJwC3pbXsu8BE9S6vLSrtpkEfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hhY0rXAA; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso4587145e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761303668; x=1761908468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LA5HyXM+hX2bjP2Gn29we5vfghMgg9wNb+qfs6Jdw60=;
        b=hhY0rXAAZ2gTfowGA4IlBWwwoetckl83kWmZ4pXiO4l9rZREgavWvFbQE+4hQp9Ogf
         BadGCS3MqaefgMUTBaIAxIXi53wlsDw4rDBqbv5WqYtloah9/a0YjQ6SbdBydmOYFKvG
         ZA++qKSgoIJNpUznFTV3d959Ux/l5emHuLPNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761303668; x=1761908468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LA5HyXM+hX2bjP2Gn29we5vfghMgg9wNb+qfs6Jdw60=;
        b=LFowvlOJD1oyqRsdrU+6Qk1D61n9ZHWH38LIOl/V0wfHAe2hY1BnYJc/SO8c17H6bZ
         vlYbOEOqVbQKFa64E43fPNDFN7a8OP4UH3q3s6EdD9hHHhNA/EYWop3pseorWoB1/WWW
         2sQBaSl2Oz8+wxMvG6qiKG0g1GciiEdjy+16v2v2UshmVfqIR17u9ipLMzHnKZqDlL8Q
         4SQf7h7EHo3OHSJLf+ydusSUvbDoWOAjMwy/d9CSwHaYGV14uApV4JfYYZ6xArI8cfZn
         vc7PDREt7F67mvIEKhUsJRYY+Vkl0zhgYA66oUbRa+LhvUD8kcL4kxu1oFDlZhQI3TLH
         g9ow==
X-Forwarded-Encrypted: i=1; AJvYcCWcwZpeoqE/9rEpiBSXASgiUXBNIwefjuDxtcpWAr4vI4fpZqHWxWtB/V3CMgWbTSUl5lfCDd2O9msuOvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5XAP5RitFgTON5B4GemvX7F4Efg7R/iqiCfR2NzsMilpKwyUp
	RBFMEJp1RpdCwjJGhNTJhKzd0zaLTuXoeOcAhS+FEaI77u+QKcvRUoLdAYgLRU6RiY5cydf6NiK
	fkpE=
X-Gm-Gg: ASbGncsez7KhwTOMPTT+DpNz2eCIaFtbsAMBjmymuQb2T/8p/JSeBRor/lV8cnVnoR6
	w+WYMFvMJlv/FSU3gHo5YqgQtqBzK5P+/c8alJQG++DCh9IFNGahsvMCnhITjNvgSntgVfMy/K9
	k/lDBeQu2yseWM30X4tSY/FIAaKCk+fhmQP0dHe+atnzq4Ocxj6BanYmeyTfWLWWjxQ9jsfOSp9
	3C5/rXpMpUhU63I71/KE/5wxKAv5yZm9UPDufCuV+hkCAbucEww46Nw0OI7Qj20zzdLJ5dMxGAc
	zX/OPQVtw6uRtCoyRaJUdrNScXsmdT5Efz/7z7AAYU2fK1M06d5KeltdMiTE6hE6bfQFVb+Sp9g
	xz8EcvJXCCFVduk3/SDSqabrtVm3IZWch2+wDvR+rVzK1tT9tMDDlNa6RFKSAI20GUMDRNoEwjt
	jYrLjI3TU8mTPorrE7UPDYd+AqOHUYIaMpzuscgA==
X-Google-Smtp-Source: AGHT+IF6juxA33iQq4KY05PfLu7DmdKzKVEF9oUn2C0lISOpqjhu9CL9Q8/6T4OtD7yhErwsfwHcuw==
X-Received: by 2002:a05:6512:239d:b0:591:ec58:ec7c with SMTP id 2adb3069b0e04-592fc13871amr853243e87.25.1761303668130;
        Fri, 24 Oct 2025 04:01:08 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4cd12f4sm1557877e87.26.2025.10.24.04.01.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 04:01:07 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-592f1988a2dso2698130e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:01:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIScAJ4rm19Yrcx76Uh3ODnxM9s4tPmDLnAodO6+/ZH3tkUSwK8HnMmwHk7eFqGUZoFkCK+j1HP8/n9w8=@vger.kernel.org
X-Received: by 2002:a05:6512:1103:b0:57d:cdb4:5b94 with SMTP id
 2adb3069b0e04-592fc0d3fa1mr766057e87.11.1761303667037; Fri, 24 Oct 2025
 04:01:07 -0700 (PDT)
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
 <20251023112459.GJ19043@pendragon.ideasonboard.com> <CANiDSCuex8w8GvMuKMyZw5sBCeW0wLteRJy97LG5Z_TDbWZ71w@mail.gmail.com>
 <20251024105441.GB13023@pendragon.ideasonboard.com>
In-Reply-To: <20251024105441.GB13023@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 24 Oct 2025 13:00:53 +0200
X-Gmail-Original-Message-ID: <CANiDSCuFP=HRu1JUnyomFOYUt-8=SA679dLy+eC8c8Yk0PNxLw@mail.gmail.com>
X-Gm-Features: AS18NWBtUyzObSBXid2bztomITLUzgiu_hpU7gWN2-F0ZiOfMxf_Uliz2d3NqPg
Message-ID: <CANiDSCuFP=HRu1JUnyomFOYUt-8=SA679dLy+eC8c8Yk0PNxLw@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Create a specific id namespace for
 output entities
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Fri, 24 Oct 2025 at 12:54, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Thu, Oct 23, 2025 at 01:47:39PM +0200, Ricardo Ribalda wrote:
> > On Thu, 23 Oct 2025 at 13:25, Laurent Pinchart wrote:
> > > On Wed, Oct 22, 2025 at 03:14:09PM +0200, Ricardo Ribalda wrote:
> > > > On Wed, 22 Oct 2025 at 15:12, Laurent Pinchart wrote:
> > > > > On Wed, Oct 22, 2025 at 03:08:58PM +0200, Ricardo Ribalda wrote:
> > > > > > On Wed, 22 Oct 2025 at 14:49, Laurent Pinchart wrote:
> > > > > > > On Wed, Oct 22, 2025 at 02:29:15PM +0200, Ricardo Ribalda wrote:
> > > > > > > > On Wed, 22 Oct 2025 at 14:09, Laurent Pinchart wrote:
> > > > > > > > > On Wed, Oct 22, 2025 at 11:55:16AM +0000, Ricardo Ribalda wrote:
> > > > > > > > > > Nothing can be connected from an output entity. Which means that no
> > > > > > > > >
> > > > > > > > > s/output entity/output terminal. Same below.
> > > > > > > > >
> > > > > > > > > Did you mean s/from an/to an/ ?
> > > > > > > > >
> > > > > > > > > > other entity can reference an output entity as baSourceId.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Some output terminals have controls, so we need to preserve their ID.
> > > > > > > > > That's why my proposal only set the UVC_TERM_OUTPUT bit for the
> > > > > > > > > *streaming* output terminals, not for all output terminals.
> > > > > > > > >
> > > > > > > > > > Use this fact to move all the output entities to a different namespace
> > > > > > > > > > id.
> > > > > > > > > >
> > > > > > > > > > The output entities are usually named after the dev_name() of the usb
> > > > > > > > > > device, so there should not be any uAPI change from this change.
> > > > > > > > > >
> > > > > > > > > > Although with this change we can handle some id collisions
> > > > > > > > > > automagically, change the logic of uvc_alloc_new_entity() to keep
> > > > > > > > > > showing a warning when a camera has invalid descriptors. Hopefully this
> > > > > > > > > > message will help vendors fix their invalid descriptors.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > > Hi, this patch fixes support for some devices with invalid USB
> > > > > > > > > > descriptor.
> > > > > > > > > >
> > > > > > > > > > It is orthogonal to:
> > > > > > > > > > https://lore.kernel.org/linux-media/20251021184213.GC19043@pendragon.ideasonboard.com/T/#t
> > > > > > > > > >
> > > > > > > > > > Some devices will be fixed by the other patch, other devices will be
> > > > > > > > > > fixed by this. In my opinion is worth to land both patches.
> > > > > > > > > >
> > > > > > > > > > Tested with GRANDSTREAM GUV3100 in a 6.6 kernel.
> > > > > > > > > > ---
> > > > > > > > > >  drivers/media/usb/uvc/uvc_driver.c | 23 +++++++++++++++++++----
> > > > > > > > > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > > > > index fb6afb8e84f00961f86fd8f840fba48d706d7a9a..40f8ae0df89e104992f5d55af3d3539dea3d146e 100644
> > > > > > > > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > > > > @@ -165,10 +165,14 @@ static struct uvc_entity *uvc_entity_by_reference(struct uvc_device *dev,
> > > > > > > > > >       return NULL;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +#define ENTITY_HARDWARE_ID(id) ((id) & ~UVC_TERM_OUTPUT)
> > > > > > > > >
> > > > > > > > > This needs a UVC_ prefix, and should probably go to uvcvideo.h. You can
> > > > > > > > > also & 0xff, as the UVC descriptors store IDs in 8-bit fields.
> > > > > > > > >
> > > > > > > > > > +
> > > > > > > > > >  static struct uvc_streaming *uvc_stream_by_id(struct uvc_device *dev, int id)
> > > > > > > > > >  {
> > > > > > > > > >       struct uvc_streaming *stream;
> > > > > > > > > >
> > > > > > > > > > +     id = ENTITY_HARDWARE_ID(id);
> > > > > > > > > > +
> > > > > > >
> > > > > > > Another comment, I would have done this in the (single) caller, to keep
> > > > > > > operating on real ids in this function. Or we could pass a struct
> > > > > > > uvc_entity instead of an int id and rename the function to
> > > > > > > uvc_stream_for_terminal(), which could better encapsulate the purpose.
> > > > > >
> > > > > > Like the second option better.
> > > > >
> > > > > I think I do too.
> > > > >
> > > > > > > > > >       list_for_each_entry(stream, &dev->streams, list) {
> > > > > > > > > >               if (stream->header.bTerminalLink == id)
> > > > > > > > > >                       return stream;
> > > > > > > > > > @@ -810,10 +814,12 @@ static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
> > > > > > > > > >       }
> > > > > > > > > >
> > > > > > > > > >       /* Per UVC 1.1+ spec 3.7.2, the ID is unique. */
> > > > > > > > > > -     if (uvc_entity_by_id(dev, id)) {
> > > > > > > > > > -             dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n", id);
> > > > > > > > > > +     if (uvc_entity_by_id(dev, ENTITY_HARDWARE_ID(id)))
> > > > > > > > > > +             dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n",
> > > > > > > > > > +                     ENTITY_HARDWARE_ID(id));
> > > > > > > > >
> > > > > > > > > It's not an error anymore if there's no collision of the full 16-bit ID,
> > > > > > > > > right ? Should it be demoted to a dev_warn() ?
> > > > > > > >
> > > > > > > > if it is OK with you I'd rather keep the dev_err(). If an ISP
> > > > > > > > manufacturer tests their camera in Linux I want them to really notice
> > > > > > > > that there is an error.
> > > > > > >
> > > > > > > Yes I'm OK with that. It shouldn't happen. We want a dev_err_and_blame()
> > > > > > > that prints a message to the kernel log and posts messages on social
> > > > > > > networks to blame the hardware manufacturer.
> > > > > > >
> > > > > > > > Besides that, I have implemented all your proposed changes.
> > > > > > > >
> > > > > > > > I cannot test it until tomorrow in real hardware. But the changes are
> > > > > > > > trivial, let me know if I shall send the v2 right now or wait til it
> > > > > > > > is tested.
> > > > > > >
> > > > > > > Up to you, I don't mind either way.
> > > > > > >
> > > > > > > If we merge "[PATCH v2] media: uvcvideo: Use heuristic to find stream
> > > > > > > entity" first, do you plan to revert it to get this patch merged ?
> > > > > >
> > > > > > I think they solve two different issues:
> > > > > >
> > > > > > - Output terminal id collides with another entity id.
> > > > > > - Incorrect bTerminalLink
> > > > >
> > > > > Do we know of any device affected by that issue ?
> > > >
> > > > I bet you there is one :)
> > >
> > > I'd rather be cautious and address that if the issue arises. Enabling
> > > non-compliant behaviour has the drawback of making issues less visible
> > > to vendors, so I would prefer not working around problems unless we know
> > > they exist.
> >
> > My main goal right now is to solve the regression.
> >
> > If you think that this approach is best, please add your review-by and
> > the following tags to the patch. And let's start landing into upstream
> > asap.
>
> I've done so in v2. Could you check if you're OK with the proposed
> changes for the commit message and comment ? I'll then send a v3 with
> all the tags (or you can do so yourself to ack the proposed changes),
> and Hans or Mauro can pick the patch up as a fix.

I am fine with you sending the v3.

HansV has already landed the other patch in /fixes

So I think the best approach here is:

1) Wait until the fix is in media-commiters/next (*)
2) Add a revert in uvc/next
3) Add this patch in uvc/next


(*) If after 1 you have not posted v3 I will do it with your changes and tags.

Regards!

>
> Thanks for testing the proposed change, I appreciate it.
>
> > We can discuss later if we want an extra patch or if we want to wait
> > for another report.
> >
> > Reported-by: Angel4005 <ooara1337@gmail.com>
> > Closes: https://lore.kernel.org/linux-media/CAOzBiVuS7ygUjjhCbyWg-KiNx+HFTYnqH5+GJhd6cYsNLT=DaA@mail.gmail.com/
> > Fixes: 0e2ee70291e6 ("media: uvcvideo: Mark invalid entities with id
> > UVC_INVALID_ENTITY_ID")
> >
> > > > > >  We can have the two patches in.  If there is any conflict because we
> > > > > > land one and then the other I can send a v3 fixing the conflict. Or a
> > > > > > maintainer can do that, they should be trivial conflicts.
> > > > > >
> > > > > > > > > > +
> > > > > > > > > > +     if (uvc_entity_by_id(dev, id))
> > > > > > > > > >               id = UVC_INVALID_ENTITY_ID;
> > > > > > > > > > -     }
> > > > > > > > > >
> > > > > > > > > >       extra_size = roundup(extra_size, sizeof(*entity->pads));
> > > > > > > > > >       if (num_pads)
> > > > > > > > > > @@ -969,6 +975,7 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
> > > > > > > > > >       struct usb_host_interface *alts = dev->intf->cur_altsetting;
> > > > > > > > > >       unsigned int i, n, p, len;
> > > > > > > > > >       const char *type_name;
> > > > > > > > > > +     unsigned int id;
> > > > > > > > > >       u16 type;
> > > > > > > > > >
> > > > > > > > > >       switch (buffer[2]) {
> > > > > > > > > > @@ -1107,8 +1114,16 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
> > > > > > > > > >                       return 0;
> > > > > > > > > >               }
> > > > > > > > > >
> > > > > > > > > > +             /*
> > > > > > > > > > +              * Nothing can be connected from an output terminal. To avoid
> > > > > > > > > > +              * entity-id's collisions in devices with invalid USB
> > > > > > > > > > +              * descriptors, move the output terminal id to its own
> > > > > > > > > > +              * namespace.
> > > > > > > > > > +              */
> > > > > > > > > > +             id = buffer[3] | UVC_TERM_OUTPUT;
> > > > > > > > > > +
> > > > > > > > > >               term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,
> > > > > > > > > > -                                         buffer[3], 1, 0);
> > > > > > > > > > +                                         id, 1, 0);
> > > > > > > > > >               if (IS_ERR(term))
> > > > > > > > > >                       return PTR_ERR(term);
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > > base-commit: ea299a2164262ff787c9d33f46049acccd120672
> > > > > > > > > > change-id: 20251022-uvc-grandstream-laurent-3f9abb8a0d5b
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

