Return-Path: <linux-kernel+bounces-863406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDFDBF7CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07814545BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E480E346D88;
	Tue, 21 Oct 2025 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ggsg678Z"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA10346E79
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065844; cv=none; b=LLzKE6+0yAFvso4V2iAA2wJeIWhK5w1VntEYxPx6GU+YazXiGRChB5TMoHFSNPaxlJ9lFGyMJkFG1JPGi/eI9SMUcRFRsyXyRXe62y4Hnhoo8cGEiY5aj505eKpdYF5jHmedniU3UYXIt/BAmFJQNf1eolHLAN17dDvMEs4Tc4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065844; c=relaxed/simple;
	bh=G6YohIT+fs9B/+IJtYe9Q8CE/mpoodxFwGuynaMq7AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBMJUpNAoDd5OraWyBSy1bzMcJG680zfsf19M0tD7DBimPilXkOIjZYbYiw1VNv4nXfByCxzEEIPBuJIjvIbT6TESGq7Krhiyfx5RjSHCshGuZSEMvvSzebzzIfHTekUpstSesCoy/8VP+VYPQm7SMs70Y8ZdlBPeOSLpqyk6fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ggsg678Z; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-78125ed4052so7192697b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761065840; x=1761670640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jAGSW6q4wKZt8ryYTbIpdoRikyV0yafrAaOHao5ZM9A=;
        b=Ggsg678ZCpXZbUXm8ryv5YTg/qC+zWpw2zKqUhFGXFN7LgisGE7c8YSBJDSmrReobF
         HFcsE8Jgib7jd5i0/JZS2rMqqK+rNNRpkXIBn6iU5X1+AgE8U0BDp0Lyo2qEvAeBbew6
         Rd2Q+G1ElKUjGE3G4BU6zGHy2kZT3C4JR8O+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065840; x=1761670640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAGSW6q4wKZt8ryYTbIpdoRikyV0yafrAaOHao5ZM9A=;
        b=bZo87gkXozjO9z8WDaZ2jCr//Ixhe9ehjap/Dy35nLaTPMvjiHHGBCUo6i+TzIM4Lo
         9vL9gzOs15nMKhEbRKcRRk+nUon3TAjWeeIfR9YnwCMpCt5LxrJwKPXoPstViw8HmXWs
         XGriM0UURV0a2zpcj+Msd7ai+55Rs37SWCwSZ9E3i4+/cwuoOgLCs/yQshS0/GSjhBQA
         ezbdj99O2PaprNmTyMfhtHQ0PVNV/hFxP4E7IS5wZfErfoYaocGNwwciXUaWYSljAxRN
         NtRBWeBuqUvkTQnh5j1q/L2pH728erAfu3b28Zw2FAvqIeIzMUDPdbGekRboaAP3GRWX
         p/EA==
X-Forwarded-Encrypted: i=1; AJvYcCVE2h/CaYBfpXLdvJwMEPQ0f5SahOgXGKbbAv3M/sP5gZV+tVHpV8uxqPD2m4YQyfH8P973tEaLH/6JLes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQLqobiYioVU0eGtlVB8R8gmPa64gNS5WTFm9iu6KIFsoFVyY
	IabVal0kUf18ebg+wDcjfl9xlPGAspRknYGHs2RM4qvYVyzUEF2LndR2EIxUFiJkJ8LYx0ic6rh
	O/htUuQ==
X-Gm-Gg: ASbGncsfd88GPdzpEDWtHdQpwQEk5znISdZGSxG2ByRBqRAwjAKy6h2o9wPMDEKDORD
	yUU/rZLRACC2mXNCuKpaAEJRc/eYnhVVq6Z+WDzTEClcdlTWrzP3HQ41DbYWzzF8mldm3MiEcal
	YBot910c/Hz1gALZ6l5qDMwRR0jje1CcimVmgSsbZfKbbCFq5jsCBE6NHSD0MewYuLr/IjwGVqu
	Q6wtMHZFV2ehQ2aRkPb02Tpx1kviTINv1siDaly7nrx2oiHsxOrLj/M5kLY2ewtOMwANXFk22OR
	2hCVMzhWPXnqsFdXSDqjzci4oMlFSi8eKUZfuTPY/LR62kioD/vJL7WqiiJbNxe1rJp85JHWbix
	IP+qMQ94kmofpCKaZV0plyogklLa7TSn/IJQj9qM2dGRyMjmfK6VZQp+Oqhpo11IT66hYxFq65l
	qHhgVhEXgvI2WxCn/PI9GVYJNtpCHew0HDwsm/CHvWmHiSsI/cHGiJ
X-Google-Smtp-Source: AGHT+IFu/VUXWx55ZqouNeWMV2I9OVvJ3UypCnTcvlFPQzOMeZqGXEYxZi1t+p35gaxbuBY1ye38fA==
X-Received: by 2002:a05:6a21:999e:b0:30a:c54d:92cb with SMTP id adf61e73a8af0-334a863acf3mr21251464637.48.1761065840387;
        Tue, 21 Oct 2025 09:57:20 -0700 (PDT)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com. [209.85.214.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f3c38sm11852848b3a.37.2025.10.21.09.57.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 09:57:19 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29292eca5dbso31483965ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:57:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWG23RJaQzNvS0JGx+4v7JHzTon7VrFvhm8UFWTAc/VdQYzBGRRUUfJ7V4EFg1SbjwuxNG+k7BwQPt7/QY=@vger.kernel.org
X-Received: by 2002:a17:902:f605:b0:26a:8171:dafa with SMTP id
 d9443c01a7336-290c9cbb0damr224548565ad.21.1761065838849; Tue, 21 Oct 2025
 09:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-uvc-grandstream-v2-1-6a74a44f4419@chromium.org> <20251021164443.GA727@pendragon.ideasonboard.com>
In-Reply-To: <20251021164443.GA727@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 21 Oct 2025 18:57:00 +0200
X-Gmail-Original-Message-ID: <CANiDSCsC6SgYJ-jSswPaeAw8RkxjZN4n23X35XbntNGcUsuRJQ@mail.gmail.com>
X-Gm-Features: AS18NWBUR2nh2BzwxnfnsMF19OfNSg3PVqZY-4xsxgcHOprFv4QmBZeGn7uF0gM
Message-ID: <CANiDSCsC6SgYJ-jSswPaeAw8RkxjZN4n23X35XbntNGcUsuRJQ@mail.gmail.com>
Subject: Re: [PATCH v2] media: uvcvideo: Use heuristic to find stream entity
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, Angel4005 <ooara1337@gmail.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Tue, 21 Oct 2025 at 18:44, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Tue, Oct 21, 2025 at 10:36:17AM +0000, Ricardo Ribalda wrote:
> > Some devices, like the Grandstream GUV3100 webcam, have an invalid UVC
> > descriptor where multiple entities share the same ID, this is invalid
> > and makes it impossible to make a proper entity tree without heuristics.
> >
> > We have recently introduced a change in the way that we handle invalid
> > entities that has caused a regression on broken devices.
> >
> > Implement a new heuristic to handle these devices properly.
> >
> > Reported-by: Angel4005 <ooara1337@gmail.com>
> > Closes: https://lore.kernel.org/linux-media/CAOzBiVuS7ygUjjhCbyWg-KiNx+HFTYnqH5+GJhd6cYsNLT=DaA@mail.gmail.com/
> > Fixes: 0e2ee70291e6 ("media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > I have managed to get my hands into a Grandstream GUV3100 and
> > implemented a new heuristics. (Thanks Yunke and Hidenori!).
> >
> > With this heuristics we can use this camera again (see the /dev/video0
> > in the topology).
> >
> > I have tested this change in a 6.6 kernel. Because the notebook that I
> > used for testing has some issues running master. But for the purpose of
> > this change this test should work.
> >
> > ~ # media-ctl --print-topology
> > Media controller API version 6.6.99
> >
> > Media device information
> > ------------------------
> > driver          uvcvideo
> > model           GRANDSTREAM GUV3100: GRANDSTREA
> > serial
> > bus info        usb-0000:00:14.0-9
> > hw revision     0x409
> > driver version  6.6.99
> >
> > Device topology
> > - entity 1: GRANDSTREAM GUV3100: GRANDSTREA (1 pad, 1 link)
> >             type Node subtype V4L flags 1
> >             device node name /dev/video0
> >         pad0: SINK
> >                 <- "Extension 3":1 [ENABLED,IMMUTABLE]
> >
> > - entity 4: GRANDSTREAM GUV3100: GRANDSTREA (0 pad, 0 link)
> >             type Node subtype V4L flags 0
> >             device node name /dev/video1
> >
> > - entity 8: Extension 3 (2 pads, 2 links, 0 routes)
> >             type V4L2 subdev subtype Unknown flags 0
> >         pad0: SINK
> >                 <- "Processing 2":1 [ENABLED,IMMUTABLE]
> >         pad1: SOURCE
> >                 -> "GRANDSTREAM GUV3100: GRANDSTREA":0 [ENABLED,IMMUTABLE]
> >
> > - entity 11: Processing 2 (2 pads, 3 links, 0 routes)
> >              type V4L2 subdev subtype Unknown flags 0
> >         pad0: SINK
> >                 <- "Camera 1":0 [ENABLED,IMMUTABLE]
> >         pad1: SOURCE
> >                 -> "Extension 3":0 [ENABLED,IMMUTABLE]
> >                 -> "Extension 4":0 [ENABLED,IMMUTABLE]
> >
> > - entity 14: Extension 4 (2 pads, 1 link, 0 routes)
> >              type V4L2 subdev subtype Unknown flags 0
> >         pad0: SINK
> >                 <- "Processing 2":1 [ENABLED,IMMUTABLE]
> >         pad1: SOURCE
> >
> > - entity 17: Camera 1 (1 pad, 1 link, 0 routes)
> >              type V4L2 subdev subtype Sensor flags 0
> >         pad0: SOURCE
> >                 -> "Processing 2":0 [ENABLED,IMMUTABLE]
> > ---
> > Changes in v2:
> > - Fix : invalid reference to the index variable of the iterator.
> > - Link to v1: https://lore.kernel.org/r/20251021-uvc-grandstream-v1-1-801e3d08b271@chromium.org
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index fb6afb8e84f00961f86fd8f840fba48d706d7a9a..ee4f54d6834962414979a046afc59c5036455124 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -167,13 +167,26 @@ static struct uvc_entity *uvc_entity_by_reference(struct uvc_device *dev,
> >
> >  static struct uvc_streaming *uvc_stream_by_id(struct uvc_device *dev, int id)
> >  {
> > -     struct uvc_streaming *stream;
> > +     struct uvc_streaming *stream, *last_stream;
> > +     unsigned int count = 0;
> >
> >       list_for_each_entry(stream, &dev->streams, list) {
> > +             count += 1;
> > +             last_stream = stream;
> >               if (stream->header.bTerminalLink == id)
> >                       return stream;
> >       }
> >
> > +     /*
> > +      * If the streaming entity is referenced by an invalid ID, notify the
> > +      * user and use heuristics to guess the correct entity.
> > +      */
> > +     if (count == 1 && id == UVC_INVALID_ENTITY_ID) {
> > +             dev_warn(&dev->intf->dev,
> > +                      "UVC non compliance: Invalid USB header. The streaming entity has an invalid ID, guessing the correct one.");
> > +             return last_stream;
> > +     }
>
> As far as I understand, the reason why we can't find the streaming
> interface here is because we have set the streaming output terminal ID
> to UVC_INVALID_ENTITY_ID, due to the extension unit being previously
> registered with the same ID. We're therefore adding a workaround on top
> of another workaround.
>
> Looking at the UVC descriptors for this camera, ID 4 is shared between
> an extension unit with GUID ffe52d21-8030-4e2c-82d9-f587d00540bd and the
> streaming output terminal. That GUID is apparently a Logitech GUID
> (according to https://github.com/soyersoyer/cameractrls/blob/c920e/cameractrls.py).
> I don't know if the XU actually works in that camera, but it could be
> useful to keep it functional.
>
> I think we could make the handling of non-unique IDs more clever. If an
> output streaming terminal and a unit share the same ID, we could
> allocate an unused ID for the output streaming terminal, and patch the
> bTerminalLink of the stream headers accordingly. The ID remapping should
> not cause other issues, as
>
> - streaming output terminals have no controls, so the ID isn't used to
>   reference controls
>
> - the units graph is build from sink to source, with UVC descriptors
>   containing the IDs of source units, so streaming output terminals are
>   never referenced by ID from descriptors except for the bTerminalLink.
>
> This would produce a valid graph without duplicated IDs in this case.

I will try to work on a solution like you propose in this kernel
cycle, but I do not feel very confident about landing that big change
in "fixes" without being in linux-next for a couple of weeks. I'd
rather go for a simple solution that fixes the regression.

With this fix, the media controller topology looks identical as before
we introduce the bug, so we do not lose any functionality.

So if you agree I think the safest path is to land this fix in fixes
now. And try to get a better logic landed in next in this kernel
cycle.

What do you think?

Regards!


>
> > +
> >       return NULL;
> >  }
> >
> >
> > ---
> > base-commit: ea299a2164262ff787c9d33f46049acccd120672
> > change-id: 20251021-uvc-grandstream-05ecf0288f62
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

