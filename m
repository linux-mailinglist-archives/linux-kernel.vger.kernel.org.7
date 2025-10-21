Return-Path: <linux-kernel+bounces-863348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBC9BF79CD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3841502B14
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3EA345724;
	Tue, 21 Oct 2025 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AXFwxZ1T"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D69343D8F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063375; cv=none; b=TKmuUjyQKg6Q0RFssHFqone0pv4mwDLUhIlyIdWlcO9SYbBkZMDeAxeAdfVDOShfg/yo6ngN3ENhgC3ATquqFYeuO++o95xSIL7fRQDYfuCpOKL+1Dhm0KcORgLM1BA7DzKCW5+NnYw8HYvWqSyv2SvUJJIRCPdD8Y/BA4yuxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063375; c=relaxed/simple;
	bh=Zq8iZc6Eo3c5hTIu5jsoB64J7Z71E2l4DV/FakgrlbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Urf55WXFoaXR6jSOv+E36bk/p/8XYyvlOvc2GImLzZVgXXT5X3ZltGcik5bOELt0bwmiF+3sAru9HMsSWcubC4kQAddMyZq6ZOTAiw2DrW1rRE1BHpP84aKioHr0DK5255hFGlO0QfJn6bBoXr3gpIXSDFzTSqu5gkI0+Js+cjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AXFwxZ1T; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6a7ed1ff9eso3028810a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761063373; x=1761668173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SXEEfWLImx3JUqZZ/tH4v4lMv+RtTDD2xX9HGJ/Xm8k=;
        b=AXFwxZ1TrGMjsryZWYjSpab/jdhKGJxmVfLysIZOaWiMgJWpeXDVycMFW9AOFwMfAB
         Bkf5DQtL8wNRUIBxoZZP8g7FhkGcxsyI/aIUxHbiMGp/Ks7FKOmTE75IW2OU32RgF5Ta
         PC+6vtJWbM/iyU2nLCb3o/yx+MPY3dXWI6K8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761063373; x=1761668173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXEEfWLImx3JUqZZ/tH4v4lMv+RtTDD2xX9HGJ/Xm8k=;
        b=Xceqf4xYMnpQXsQ+lDjsFPdO7Bgi3jJQ3hrkyjbQIiAA37aQ0I4xBGi2l1ivx62N5E
         pqUleJPUvmXbs04tjxQXF4hDiZz7uQvFCXUXNmxGYjyvduVskcGHVnxgijMHMR1g6Nfa
         xbMt6Tzq2m6keTj2bM2pWZfgvB7U4UzlrFdXchmx0C+k2IItHZn24/Qhw3L/YA3fpHCI
         IXTeHJdWwtMSuwRqrDnPPAcKIzNYm7l429n7OB/T7LKWzgiBUrHtypXVOUjyRR5qhotl
         TstW2TDDqCfybIjaJmu5lbEuQVXBVCqM13XisKOiI3E056gA84nnTCnvTFcX7Ai8xhHx
         lL/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9+YwgkN5wirr6Fla9cogPNxeOpLVWSxAkJuuOD6raoPUeeSmKtczD6wIMv9HEFP23HyaEA3DwK6m8i/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwInULWxYefei4VXKDS+KtCU9bDEkWPbZW49/WS+2tmzQFNWW3N
	759eS2geCRiYybNJJS5gJetbLiw8d5bl4XrElg6bYH4e6PnZquD/R0muKv9BeDz6RMOeqOegerU
	hzbk7Vg==
X-Gm-Gg: ASbGnctJiL18ezM6pLlyep1BBWJ6Ejw8R9RnEGqwc6RIZPxpp45kcvty8sBTnvrvd+2
	OrFmuXyJuVmghoO0OdN6RBV5qSrXuDbltPG/p9ZD1K0OybaC+kvGKhvBtsUHaQjZd73imnbaetw
	jynGrNqsLTBo+CPFcl4sS3oRs6HMiXRK1Y3RdZ6qwz/dqH57BGIieiVYcPDS63wveCdDF4W5Jg+
	RMqABPJvNv51IvLTXRpAyriEp0t7jVM2llpCzHhGgpwXydKzha3ZwDQsfo4Ys7UDRD2rjvWwcxa
	Q1HjZHhYoBSXxbzngyKm6r+/9Sbp8GHXSc2ZO2Y9Vx+3BfkKHMTEZ1Dflp0CJM/T8J2uP90O3/Y
	PnhrPLtZIn9kGMfithfaGYsndWcUwi/z+eApyF4NYkreqVJH/A4JSF5mf0AScR+l5RS3De+0sBA
	Ttb5ia0d4mzmIYTYOzte/HE2PWmKjzBUBel6lG3vP05RmEOPeNR38D
X-Google-Smtp-Source: AGHT+IFSfdVNtzoougEJr3w8BlwdvcQ67h+xVLt9g1pHB77l5leAOpJcf4340yyipJKm47FvxaWFsQ==
X-Received: by 2002:a17:903:234a:b0:261:cb35:5a08 with SMTP id d9443c01a7336-290cb947720mr225737485ad.38.1761063372407;
        Tue, 21 Oct 2025 09:16:12 -0700 (PDT)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com. [209.85.214.180])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b68a4dsm10574504a12.34.2025.10.21.09.16.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 09:16:11 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27ee41e0798so92022585ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:16:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX65nt1qJJMlvHcxbJtXoVZ0zChhnAlECyCklg194R0vKmvQkkFbuNN4pAJSrV7GyOuHPSl+sjDj8PqLu4=@vger.kernel.org
X-Received: by 2002:a17:903:98f:b0:277:3488:787e with SMTP id
 d9443c01a7336-290c9cf8e7fmr223158245ad.12.1761063369954; Tue, 21 Oct 2025
 09:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-uvc-grandstream-v2-1-6a74a44f4419@chromium.org> <b282f6ef-fd91-44ea-bf51-187cf2c56fc6@kernel.org>
In-Reply-To: <b282f6ef-fd91-44ea-bf51-187cf2c56fc6@kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 21 Oct 2025 18:15:54 +0200
X-Gmail-Original-Message-ID: <CANiDSCvr-BR7wZVK2gW0wYEQjyFHTpZv7nnR4JVi6bMUyGNCoQ@mail.gmail.com>
X-Gm-Features: AS18NWDmZAnceyCVjQ_kSBGA-M4GHuvSkJw28yjWvXcX-dRpnIvp7ZCUnBJsf9k
Message-ID: <CANiDSCvr-BR7wZVK2gW0wYEQjyFHTpZv7nnR4JVi6bMUyGNCoQ@mail.gmail.com>
Subject: Re: [PATCH v2] media: uvcvideo: Use heuristic to find stream entity
To: Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, Angel4005 <ooara1337@gmail.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hans(es)

On Tue, 21 Oct 2025 at 18:07, Hans de Goede <hansg@kernel.org> wrote:
>
> Hi,
>
> On 21-Oct-25 12:36, Ricardo Ribalda wrote:
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
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hansg@kernel.org>

Thanks for the prompt reply.

@Hverkil I think you are planning to push to /fixes soon. I believe
this patch should also land there.

>
> Regards,
>
> Hans
>
>
>
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
> > +
> >       return NULL;
> >  }
> >
> >
> > ---
> > base-commit: ea299a2164262ff787c9d33f46049acccd120672
> > change-id: 20251021-uvc-grandstream-05ecf0288f62
> >
> > Best regards,
>


-- 
Ricardo Ribalda

