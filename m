Return-Path: <linux-kernel+bounces-864916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81853BFBD8D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DAAB0356720
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C45344029;
	Wed, 22 Oct 2025 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b+KXZw+o"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616C3343D6E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136173; cv=none; b=E/O4MWIO8hjtEDdQE1bU0hycEevV6/rnGdSrdB2jVIJ/tKJiXZEdRRc6B/OB4p0Xl92ZywBQlzSO8HqCVAkdupbqi5aJA99/DDx29N40RbyQ35ryIeRteTtx/RKlsYNIeQMj43s3rnf4f15K+bI72fshbMh2+xdS7t1Bop6gmEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136173; c=relaxed/simple;
	bh=EN74wRmhRMfF20ZojltjPHZiNIUseVkOwqwVbG+3HwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ao+qwmpF2AvKEo4rteE0MkJw5gHuG+OlZVaJ0paNonMwIK6KSJuvuIWHFEkQznkL7rKKsBhyWKKgN2AKztqyOd6+Y9tLVGey61IP7VWSxZlZIm0KlxFSR1fF/O78JPg2R+UtTfJKe7NUfpbsecXXNy5aGu+3WrNinzOoOMLEV4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b+KXZw+o; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so6520892e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761136169; x=1761740969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SK/895TH4727JPcOv1LzX820iwrH4WkE7bHuzdndNvE=;
        b=b+KXZw+oBpvUdypvTHO0itUKv6KxQlyHcQNY6C3V3TleTGf8ukBB/CdVZN1vd02IcW
         GtCcb9hhhzERYyWPqAghqQgpzKcRPdo+CzTkanFwQI9Dz34Hyv6217CSRHLRAyr4aHBV
         +k4xwmdb/P25OAvvFq2+G7QCH4m40KN5OjwoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761136169; x=1761740969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SK/895TH4727JPcOv1LzX820iwrH4WkE7bHuzdndNvE=;
        b=byMMVv+105Yzhu5tEKrl+EUyc4A7TUCGXdTPVSxuETUhZ14DQURaFS0/i21Z3hklLg
         3A0K5nbE22h+rvMOQJnQpwyyWxvR7jeXfuuNzzCCiKibiigI+U5Njq2LWnFTXA0fkpRT
         gmCuE08GDZ9GLT3SsQWkGzkeiPzzVcPTn80GQvnbmojw9hk53h0anVaWuqJ1nvl8FFEu
         h+L38yPYqUlMtN49a1F/bFgH2R7+SNoCugGpEPh6HkwuxOsjOuf2ShkygPJmwW0egY6U
         Qa7ZBGV2wLwQEIIfvdi19iYJzpgnrpTkxZabntrNUmpa78zy7xAes+uB1tuc2mVC8XuV
         wTdw==
X-Forwarded-Encrypted: i=1; AJvYcCWI1qDSKQfF0BV0S3T6rJqa68QiNKempk00QMYgh8434whh0oj1RfpIh27tTgEyqRZPR+Whla/Mk2VtD4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFOZ/MftZUcrIpafggpV2mmW9EXUnfREY+2Tj6p3vH+vcvmfZ
	ItQ0E0vvo719zAFI+u4JGBjJ5p+Ns7pSpmfLIAcLcgAS2hhI9V3meMoEgMB3sSVn3ds6GWCsBjn
	7A8iWyA==
X-Gm-Gg: ASbGncu9Sa+thUYDT3jMKpo6ndPeIFSZ2hkcCrSDKLWAk4CQ/xgOFsanPCOAZsry302
	CNMgE9uHuGkwTPkqpwTMulPMS/jh9bw1X7N8/SB8l1/D9mPCm4GPtVuBhsENJyoGHW2i4BrsIp1
	Q/4fluUNvauWBPKmRjgKoX1eOkD0tMhM5C5hg0fsFS4+Xs9dQRuV+plsSqNwWf+2Uqh4qQZcOdy
	u85whxqV4zU9CX/pfDiZFPVT9qolhS2a20yrviPh00YFkvddlzJ9u59DAHCADPLemAIvVO8wI2E
	DdD9cbce9cn3EVkqE6BwtDkC9/6R9/JbVH5Kha3GyMy0Gg6O23FjA075GhG2KiusN7uj8lEQ6m/
	dMGUqu2Hc+IKP3GcI6lHpqT+CIox2bFPrBP6I9LGml3NxrsO/ndqDDr44OVG5rQMEmwKY9yFWSj
	DPynZ8blf1ysRDyhaCqokIQSqgKH/pYNpJFOHPPA==
X-Google-Smtp-Source: AGHT+IFz5mBHSgMbLV9afpKPJxzeBdzwKORRsq9IWwbYlnmVjkbgXdH6hpUbNmptTuJVco8HrJilfA==
X-Received: by 2002:a05:6512:239d:b0:586:9b16:6d1f with SMTP id 2adb3069b0e04-591d84ef1aamr6497924e87.15.1761136169249;
        Wed, 22 Oct 2025 05:29:29 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def160cfsm4638234e87.76.2025.10.22.05.29.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 05:29:28 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-592f22b1e49so298103e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:29:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgKJaZUQsyomS7Isnvx8lu3zMSmQvnchvKj8zrn1qslly6vNX6XOtyYGmavasBiehRW72aCZj8T68qdlY=@vger.kernel.org
X-Received: by 2002:a05:6512:3a88:b0:578:6ccf:d031 with SMTP id
 2adb3069b0e04-591d8534106mr6173368e87.35.1761136167907; Wed, 22 Oct 2025
 05:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-uvc-grandstream-laurent-v1-1-0925738a3484@chromium.org> <20251022120849.GD727@pendragon.ideasonboard.com>
In-Reply-To: <20251022120849.GD727@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 Oct 2025 14:29:15 +0200
X-Gmail-Original-Message-ID: <CANiDSCvtqe8MKpb=O-=Mv28dK+g=REi7kpdr-eyAD-mLLpzQJw@mail.gmail.com>
X-Gm-Features: AS18NWBM5UwpZqxEvO3DsR977BkO4xv27-2tIdMI9svnnbokKy7BTnfKbh2UjOs
Message-ID: <CANiDSCvtqe8MKpb=O-=Mv28dK+g=REi7kpdr-eyAD-mLLpzQJw@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Create a specific id namespace for
 output entities
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 14:09, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Oct 22, 2025 at 11:55:16AM +0000, Ricardo Ribalda wrote:
> > Nothing can be connected from an output entity. Which means that no
>
> s/output entity/output terminal. Same below.
>
> Did you mean s/from an/to an/ ?
>
> > other entity can reference an output entity as baSourceId.
> >
>
> Some output terminals have controls, so we need to preserve their ID.
> That's why my proposal only set the UVC_TERM_OUTPUT bit for the
> *streaming* output terminals, not for all output terminals.
>
> > Use this fact to move all the output entities to a different namespace
> > id.
> >
> > The output entities are usually named after the dev_name() of the usb
> > device, so there should not be any uAPI change from this change.
> >
> > Although with this change we can handle some id collisions
> > automagically, change the logic of uvc_alloc_new_entity() to keep
> > showing a warning when a camera has invalid descriptors. Hopefully this
> > message will help vendors fix their invalid descriptors.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > Hi, this patch fixes support for some devices with invalid USB
> > descriptor.
> >
> > It is orthogonal to:
> > https://lore.kernel.org/linux-media/20251021184213.GC19043@pendragon.ideasonboard.com/T/#t
> >
> > Some devices will be fixed by the other patch, other devices will be
> > fixed by this. In my opinion is worth to land both patches.
> >
> > Tested with GRANDSTREAM GUV3100 in a 6.6 kernel.
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index fb6afb8e84f00961f86fd8f840fba48d706d7a9a..40f8ae0df89e104992f5d55af3d3539dea3d146e 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -165,10 +165,14 @@ static struct uvc_entity *uvc_entity_by_reference(struct uvc_device *dev,
> >       return NULL;
> >  }
> >
> > +#define ENTITY_HARDWARE_ID(id) ((id) & ~UVC_TERM_OUTPUT)
>
> This needs a UVC_ prefix, and should probably go to uvcvideo.h. You can
> also & 0xff, as the UVC descriptors store IDs in 8-bit fields.
>
> > +
> >  static struct uvc_streaming *uvc_stream_by_id(struct uvc_device *dev, int id)
> >  {
> >       struct uvc_streaming *stream;
> >
> > +     id = ENTITY_HARDWARE_ID(id);
> > +
> >       list_for_each_entry(stream, &dev->streams, list) {
> >               if (stream->header.bTerminalLink == id)
> >                       return stream;
> > @@ -810,10 +814,12 @@ static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
> >       }
> >
> >       /* Per UVC 1.1+ spec 3.7.2, the ID is unique. */
> > -     if (uvc_entity_by_id(dev, id)) {
> > -             dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n", id);
> > +     if (uvc_entity_by_id(dev, ENTITY_HARDWARE_ID(id)))
> > +             dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n",
> > +                     ENTITY_HARDWARE_ID(id));
>
> It's not an error anymore if there's no collision of the full 16-bit ID,
> right ? Should it be demoted to a dev_warn() ?

if it is OK with you I'd rather keep the dev_err(). If an ISP
manufacturer tests their camera in Linux I want them to really notice
that there is an error.
Besides that, I have implemented all your proposed changes.

I cannot test it until tomorrow in real hardware. But the changes are
trivial, let me know if I shall send the v2 right now or wait til it
is tested.

Regards

>
> > +
> > +     if (uvc_entity_by_id(dev, id))
> >               id = UVC_INVALID_ENTITY_ID;
> > -     }
> >
> >       extra_size = roundup(extra_size, sizeof(*entity->pads));
> >       if (num_pads)
> > @@ -969,6 +975,7 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
> >       struct usb_host_interface *alts = dev->intf->cur_altsetting;
> >       unsigned int i, n, p, len;
> >       const char *type_name;
> > +     unsigned int id;
> >       u16 type;
> >
> >       switch (buffer[2]) {
> > @@ -1107,8 +1114,16 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
> >                       return 0;
> >               }
> >
> > +             /*
> > +              * Nothing can be connected from an output terminal. To avoid
> > +              * entity-id's collisions in devices with invalid USB
> > +              * descriptors, move the output terminal id to its own
> > +              * namespace.
> > +              */
> > +             id = buffer[3] | UVC_TERM_OUTPUT;
> > +
> >               term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,
> > -                                         buffer[3], 1, 0);
> > +                                         id, 1, 0);
> >               if (IS_ERR(term))
> >                       return PTR_ERR(term);
> >
> >
> > ---
> > base-commit: ea299a2164262ff787c9d33f46049acccd120672
> > change-id: 20251022-uvc-grandstream-laurent-3f9abb8a0d5b
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

