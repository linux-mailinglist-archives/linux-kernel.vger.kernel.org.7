Return-Path: <linux-kernel+bounces-745466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB894B11A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58815A0D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E3124886A;
	Fri, 25 Jul 2025 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rs8Z3b35"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43B623AB94
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433959; cv=none; b=SGTF59cmpoZ+PzLaNua0Uj5jSN0ojL4BLn3Q4oidUhItfFiUfxxE8yaUG1U0aWQG3/Jgrq6vOrtuliMKPXbrAlNuVsnlHYXih/boKcLz53whrn/+7Y5PVD5+dhORRd26rLb8Qq26KHK1TjaZBhtQyUYF8lB7xoM/YkcVbLs/N0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433959; c=relaxed/simple;
	bh=Epvz5xYDEH6GKKNdQXbFMYOls6Bpp+GEsfDk9aT0VMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=he0tm2glIwJVpycX+4cLlIsy+vpPOv5fDU3oFpHtdNG+61uN6agRv1iOZLgVv+9a1wEtiuuK99+Q8HD3YpuSq8mluW4oAm5vjBalJ1ZR+0JCSyqdH3t6LvaOs2/eDKKNJkkYBRYYTaqD15LUiPAJhtBzNGpJ0rAfyh5okYIPP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rs8Z3b35; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553b3316160so1963319e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753433956; x=1754038756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4AOzOJElgwV0qIorBKZrScQx66fbUFWWoBvz5q4bGY=;
        b=Rs8Z3b35G9lDFbxqagHt6+uUgLTxBMDLgoKZi+zVrBxR4c4PSIiYuCnvJdgDyFyMWJ
         lrlNS9D0GmWtckEIZqHnZYNMv3twGnfN0JhGVFujJBpv5TRj3fydPHQWWKDLu6+aZwgq
         darmExu9em5K0xQDdSZCrEdYHbKjfTCfSJAmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753433956; x=1754038756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4AOzOJElgwV0qIorBKZrScQx66fbUFWWoBvz5q4bGY=;
        b=opxxjP4rceUSfUBSy7VqfZIewsQe+5E+xB7484QEOT2QLor6hOO9j4TnkKuxdf8ZVx
         mir8+WGCkBD0SJLPkpsVNa1kPQdqHHnnio1B02/XFIrkV17RV+kbdnLWDVWombBvqysj
         Jdo77bI3I9qhm5W6QmyW0EvF+vb47bWHctjS6VhSFw+nNIxYPjIDeczQ45vgbxA1EtBX
         vxPE0/aNx8GnxVgpknPtpgE0l5SOJZSN/eQCtDelj8hv1bloeZbXN8YRH7kDakTZ4oCO
         Y51xQFI8Hx3wQuU+pHFZfKXVDNjbFPEE6/mvbc8YHIw3CKqHKOD7MSc8++SbtGxkstyF
         uTVg==
X-Forwarded-Encrypted: i=1; AJvYcCWzDopmpgHn2aCPzBroWk0iUWZSRmxS/Owfs3Oqqb+oq0oIt8DrXCSy4afpwhz56DH1Yirnqf9zQCLBtIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfaIMAgeALuCs9REm76MRLhR0Y+HW12AFFu6qFIDAs+JV1ZTOw
	eVZ4T+TibUtem1o8cuYtOT5dtUvPzCBHbo9s2zFqwmcL7/Jb6kgpGrMcHIM0XnmDrK92tu1Bvn6
	iSWA=
X-Gm-Gg: ASbGncthPF0AtEheQthwywIlhLO0qDa37enU+Y3KBvzjIWERBaiaEV+nyMVOaka/fek
	wgz5+Wv+qRQlNQhvNBTI55K/E5cnLr6J0u9H1N9wVwQbYAk/XONCpzDV9pdBNW3xZlqZ2HOYtdl
	gSp15yqgYcDyP2xxulsyIsJM6N7zoSbOk2+vHxIRJ2lJ7+kDi0EHvVPLE/bUiBvrGG0WFQrssk0
	XDGKpae4O2mcDeDLSHRiQj7wW/7SzzMwXF7PaMZqKhN62+1QK7pBIMmPbUICE6VR7b4M76Ty9wN
	ZiPXS4P+VjfkslGIihihOC3XxYmFPh5dARaXTCkHmnWqAH36ezLSSXanFEhelA6vMYAwTPCmvdw
	7lej4suqQLN53WAHNT+EN2IAc939FDYfJ0GNldP4VKg9eZ1WJOxmLZb054Aliw+26
X-Google-Smtp-Source: AGHT+IHzkY0Ccx0FrONiVVk8xAzTo+kX2LMmx8L0lqgrxh0XdCxnl94Tfo9kYTiX4WrPa2gX4QWnJw==
X-Received: by 2002:a05:6512:3f12:b0:553:cfa8:dd25 with SMTP id 2adb3069b0e04-55b5f3cf92bmr335524e87.3.1753433955452;
        Fri, 25 Jul 2025 01:59:15 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53b21f16sm820488e87.26.2025.07.25.01.59.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 01:59:14 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b7113ed6bso20117541fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:59:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCpnfETCt4RtOoTzflwOnhIt9lpGPgNc95EWNDWIfRdVLb2d7c7NFyZ0aLFnKnWvtJTc82AahvFx4Q2lE=@vger.kernel.org
X-Received: by 2002:a2e:b8ce:0:b0:32b:4773:7aaf with SMTP id
 38308e7fff4ca-331ee83c6c1mr3694771fa.35.1753433953931; Fri, 25 Jul 2025
 01:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717-uvc-onelocksless-v1-1-91a1b834186a@chromium.org>
 <20250724120840.GL11202@pendragon.ideasonboard.com> <CANiDSCvvAX27u4_qnKxbSqWVWybsZFV-367eSv8ig85-cCeDTw@mail.gmail.com>
 <20250724155101.GA17890@pendragon.ideasonboard.com> <CANiDSCsojmQdCQqYXBFStPwGJ3n+-04_+dqTx+tsUrT+dRSC2Q@mail.gmail.com>
 <20250724200014.GT11202@pendragon.ideasonboard.com>
In-Reply-To: <20250724200014.GT11202@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 25 Jul 2025 10:59:01 +0200
X-Gmail-Original-Message-ID: <CANiDSCvfD_j3KhrEU9ajRxC5Wgdp=Anq_PTZkUg7G8-Nof3O4w@mail.gmail.com>
X-Gm-Features: Ac12FXyUZoN8IWCHRFEqo-qPEo_qvsB-UP_v6qbQ-rSDUJObnSDxRVqW8O02WBk
Message-ID: <CANiDSCvfD_j3KhrEU9ajRxC5Wgdp=Anq_PTZkUg7G8-Nof3O4w@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Drop stream->mutex
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hans Verkuil <hans@jjverkuil.nl>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Jul 2025 at 22:00, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Thu, Jul 24, 2025 at 08:15:48PM +0200, Ricardo Ribalda wrote:
> > On Thu, 24 Jul 2025 at 17:51, Laurent Pinchart wrote:
> > >
> > > (CC'ing Hans Verkuil)
> > >
> > > On Thu, Jul 24, 2025 at 05:41:06PM +0200, Ricardo Ribalda wrote:
> > > > On Thu, 24 Jul 2025 at 14:08, Laurent Pinchart wrote:
> > > > > On Thu, Jul 17, 2025 at 07:56:45AM +0000, Ricardo Ribalda wrote:
> > > > > > Since commit c93d73c9c2cf ("media: uvcvideo: Use vb2 ioctl and fop
> > > > > > helpers"), the IOCTLs are serialized. Due to this there is no more need
> > > > > > to protect ctrl, cur_format or cur_frame from concurrent access.
> > > > > >
> > > > > > Drop stream->mutex after thanking it for years of good service.
> > > > > >
> > > > > > Use this opportunity to do fix some CodeStyle.
> > > > >
> > > > > Is that about the following change only:
> > > > >
> > > > > -       if (format == NULL || frame == NULL) {
> > > > > +       if (!format || !frame)
> > > > >
> > > > > or is there something else I missed ?
> > > >
> > > > I believe that's it.
> > > >
> > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > ---
> > > > > >  drivers/media/usb/uvc/uvc_driver.c   |  4 ----
> > > > > >  drivers/media/usb/uvc/uvc_metadata.c |  8 ++------
> > > > > >  drivers/media/usb/uvc/uvc_v4l2.c     | 39 ++++++++----------------------------
> > > > > >  drivers/media/usb/uvc/uvcvideo.h     |  6 ------
> > > > > >  4 files changed, 10 insertions(+), 47 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > index 775bede0d93d9b3e5391914aa395326d3de6a3b1..3039e6a533b82dd917050d416c9ced8756d69170 100644
> > > > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > @@ -183,8 +183,6 @@ static void uvc_stream_delete(struct uvc_streaming *stream)
> > > > > >       if (stream->async_wq)
> > > > > >               destroy_workqueue(stream->async_wq);
> > > > > >
> > > > > > -     mutex_destroy(&stream->mutex);
> > > > > > -
> > > > > >       usb_put_intf(stream->intf);
> > > > > >
> > > > > >       kfree(stream->formats);
> > > > > > @@ -201,8 +199,6 @@ static struct uvc_streaming *uvc_stream_new(struct uvc_device *dev,
> > > > > >       if (stream == NULL)
> > > > > >               return NULL;
> > > > > >
> > > > > > -     mutex_init(&stream->mutex);
> > > > > > -
> > > > > >       stream->dev = dev;
> > > > > >       stream->intf = usb_get_intf(intf);
> > > > > >       stream->intfnum = intf->cur_altsetting->desc.bInterfaceNumber;
> > > > > > diff --git a/drivers/media/usb/uvc/uvc_metadata.c b/drivers/media/usb/uvc/uvc_metadata.c
> > > > > > index 229e08ff323eed9129d835b24ea2e8085bb713b8..d1d4fade634bd3f8b12bbaa75388db42aecc25ea 100644
> > > > > > --- a/drivers/media/usb/uvc/uvc_metadata.c
> > > > > > +++ b/drivers/media/usb/uvc/uvc_metadata.c
> > > > > > @@ -100,14 +100,10 @@ static int uvc_meta_v4l2_set_format(struct file *file, void *fh,
> > > > > >        * Metadata buffers would still be perfectly parseable, but it's more
> > > > > >        * consistent and cleaner to disallow that.
> > > > > >        */
> > > > > > -     mutex_lock(&stream->mutex);
> > > > > > -
> > > > > >       if (vb2_is_busy(&stream->meta.queue.queue))
> > > > > > -             ret = -EBUSY;
> > > > > > -     else
> > > > > > -             stream->meta.format = fmt->dataformat;
> > > > > > +             return -EBUSY;
> > > > > >
> > > > > > -     mutex_unlock(&stream->mutex);
> > > > > > +     stream->meta.format = fmt->dataformat;
> > > > > >
> > > > > >       return ret;
> > > > >
> > > > >         return 0;
> > > > >
> > > > > >  }
> > > > > > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > > > > > index 160f9cf6e6dbdbf39e3eff56a5d5ea1d977fbe22..d7be4d59f0c73b983aa01321f4acc8f8bf6e83ef 100644
> > > > > > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > > > > > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > > > > > @@ -329,14 +329,12 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
> > > > > >        * developers test their webcams with the Linux driver as well as with
> > > > > >        * the Windows driver).
> > > > > >        */
> > > > > > -     mutex_lock(&stream->mutex);
> > > > > >       if (stream->dev->quirks & UVC_QUIRK_PROBE_EXTRAFIELDS)
> > > > > >               probe->dwMaxVideoFrameSize =
> > > > > >                       stream->ctrl.dwMaxVideoFrameSize;
> > > > > >
> > > > > >       /* Probe the device. */
> > > > > >       ret = uvc_probe_video(stream, probe);
> > > > > > -     mutex_unlock(&stream->mutex);
> > > > > >       if (ret < 0)
> > > > > >               return ret;
> > > > > >
> > > > > > @@ -395,19 +393,15 @@ static int uvc_ioctl_g_fmt(struct file *file, void *fh,
> > > > > >       struct uvc_streaming *stream = handle->stream;
> > > > > >       const struct uvc_format *format;
> > > > > >       const struct uvc_frame *frame;
> > > > > > -     int ret = 0;
> > > > > >
> > > > > >       if (fmt->type != stream->type)
> > > > > >               return -EINVAL;
> > > > > >
> > > > > > -     mutex_lock(&stream->mutex);
> > > > > >       format = stream->cur_format;
> > > > > >       frame = stream->cur_frame;
> > > > > >
> > > > > > -     if (format == NULL || frame == NULL) {
> > > > > > -             ret = -EINVAL;
> > > > > > -             goto done;
> > > > > > -     }
> > > > > > +     if (!format || !frame)
> > > > > > +             return -EINVAL;
> > > > > >
> > > > > >       fmt->fmt.pix.pixelformat = format->fcc;
> > > > > >       fmt->fmt.pix.width = frame->wWidth;
> > > > > > @@ -419,9 +413,7 @@ static int uvc_ioctl_g_fmt(struct file *file, void *fh,
> > > > > >       fmt->fmt.pix.xfer_func = format->xfer_func;
> > > > > >       fmt->fmt.pix.ycbcr_enc = format->ycbcr_enc;
> > > > > >
> > > > > > -done:
> > > > > > -     mutex_unlock(&stream->mutex);
> > > > > > -     return ret;
> > > > > > +     return 0;
> > > > > >  }
> > > > > >
> > > > > >  static int uvc_ioctl_s_fmt(struct file *file, void *fh,
> > > > > > @@ -441,19 +433,14 @@ static int uvc_ioctl_s_fmt(struct file *file, void *fh,
> > > > > >       if (ret < 0)
> > > > > >               return ret;
> > > > > >
> > > > > > -     mutex_lock(&stream->mutex);
> > > > > > -     if (vb2_is_busy(&stream->queue.queue)) {
> > > > > > -             ret = -EBUSY;
> > > > > > -             goto done;
> > > > > > -     }
> > > > > > +     if (vb2_is_busy(&stream->queue.queue))
> > > > > > +             return -EBUSY;
> > > > > >
> > > > > >       stream->ctrl = probe;
> > > > > >       stream->cur_format = format;
> > > > > >       stream->cur_frame = frame;
> > > > > >
> > > > > > -done:
> > > > > > -     mutex_unlock(&stream->mutex);
> > > > > > -     return ret;
> > > > > > +     return 0;
> > > > > >  }
> > > > > >
> > > > > >  static int uvc_ioctl_g_parm(struct file *file, void *fh,
> > > > > > @@ -466,9 +453,7 @@ static int uvc_ioctl_g_parm(struct file *file, void *fh,
> > > > > >       if (parm->type != stream->type)
> > > > > >               return -EINVAL;
> > > > > >
> > > > > > -     mutex_lock(&stream->mutex);
> > > > > >       numerator = stream->ctrl.dwFrameInterval;
> > > > > > -     mutex_unlock(&stream->mutex);
> > > > > >
> > > > >
> > > > > You can drop the blank line here.
> > > > >
> > > > > >       denominator = 10000000;
> > > > > >       v4l2_simplify_fraction(&numerator, &denominator, 8, 333);
> > > > > > @@ -519,12 +504,9 @@ static int uvc_ioctl_s_parm(struct file *file, void *fh,
> > > > > >       uvc_dbg(stream->dev, FORMAT, "Setting frame interval to %u/%u (%u)\n",
> > > > > >               timeperframe.numerator, timeperframe.denominator, interval);
> > > > > >
> > > > > > -     mutex_lock(&stream->mutex);
> > > > > >
> > > > >
> > > > > Double blank line.
> > > > >
> > > > > > -     if (uvc_queue_streaming(&stream->queue)) {
> > > > > > -             mutex_unlock(&stream->mutex);
> > > > > > +     if (uvc_queue_streaming(&stream->queue))
> > > > > >               return -EBUSY;
> > > > > > -     }
> > > > > >
> > > > > >       format = stream->cur_format;
> > > > > >       frame = stream->cur_frame;
> > > > > > @@ -556,14 +538,11 @@ static int uvc_ioctl_s_parm(struct file *file, void *fh,
> > > > > >
> > > > > >       /* Probe the device with the new settings. */
> > > > > >       ret = uvc_probe_video(stream, &probe);
> > > > > > -     if (ret < 0) {
> > > > > > -             mutex_unlock(&stream->mutex);
> > > > > > +     if (ret < 0)
> > > > > >               return ret;
> > > > > > -     }
> > > > > >
> > > > > >       stream->ctrl = probe;
> > > > > >       stream->cur_frame = frame;
> > > > > > -     mutex_unlock(&stream->mutex);
> > > > > >
> > > > > >       /* Return the actual frame period. */
> > > > > >       timeperframe.numerator = probe.dwFrameInterval;
> > > > > > @@ -941,10 +920,8 @@ static int uvc_ioctl_g_selection(struct file *file, void *fh,
> > > > > >
> > > > > >       sel->r.left = 0;
> > > > > >       sel->r.top = 0;
> > > > > > -     mutex_lock(&stream->mutex);
> > > > > >       sel->r.width = stream->cur_frame->wWidth;
> > > > > >       sel->r.height = stream->cur_frame->wHeight;
> > > > > > -     mutex_unlock(&stream->mutex);
> > > > > >
> > > > > >       return 0;
> > > > > >  }
> > > > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > > > index 757254fc4fe930ae61c9d0425f04d4cd074a617e..86765b9d7935f0888476249c3fb826cd7f36b35c 100644
> > > > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > > > @@ -469,12 +469,6 @@ struct uvc_streaming {
> > > > > >       const struct uvc_format *cur_format;
> > > > > >       const struct uvc_frame *cur_frame;
> > > > > >
> > > > > > -     /*
> > > > > > -      * Protect access to ctrl, cur_format, cur_frame and hardware video
> > > > > > -      * probe control.
> > > > > > -      */
> > > > > > -     struct mutex mutex;
> > > > > > -
> > > > >
> > > > > Could you please instead keep this mutex and drop uvc_video_queue.mutex
> > > > > ? The rationale is that the same lock is now used to protect the queue
> > > > > operations and to serialize the ioctls. It's therefore a higher-level
> > > > > lock, which should be stored in the higher-level object, not in the
> > > > > queue.
> > > > >
> > > > > You can then also drop the lock assignment in uvc_queue.c that reads
> > > > >
> > > > >         queue->queue.lock = &queue->mutex;
> > > > >
> > > > > as videobuf2 and the V4L2 core will use the video device lock when no
> > > > > queue lock is set. The comment at the top of uvc_queue.c may need to be
> > > > > updated.
> > > >
> > > > Are we sure that it is exactly the same?
> > > >
> > > > There are places in videobuf2-core.c where we do not use video device lock.
> > > >
> > > > Eg:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/common/videobuf2/videobuf2-core.c#n2056
> > > >
> > > > I'd rather keep the assignment to be in the safe side.
> > >
> > > There are lots of places where the vdev lock is used is the queue has no
> > > lock. Hans, was is an oversight not to do it in __vb2_wait_for_done_vb()
> > > ? If we don't want to support not setting the queue lock that's OK, but
> > > we should then drop code that uses vdev->lock instead.
> > >
> > > We can keep the assignment for the time being to be safe until that
> > > issue gets resolved, but I'd still like to use the stream mutex instead
> > > of the queue mutex.
> >
> > The problem with using the stream mutex is that the meta device and
> > the capture device have the same uvc_streaming, but they need a
> > different mutex.
> >
> > So if you do something like this:
> >
> > console0 # yavta -c /dev/video1 &
> >
> > console1# yavta -c /dev/video0 &
> >
> > You end in a deadlock. Where the DQBUF of video1 do not let you use video0
>
> Aarrghhh :-(
>
> I wouldn't expect a deadlock as DQBUF should release the lock when
> waiting, but still, aarrrrgghhhhh :-(
>
> > We can add a second mutex to uvc_streaming.... but I think this is a
> > bit overkill.
> >
> > Any ideas?
>
> I'm thinking it could make sense to move the video_device members of
> uvc_streaming to uvc_video_queue and rename uvc_video_queue to
> uvc_video_device. That's a change that should probably be done on top of
> this patch, as it won't change the location of the mutex.

I have moved the video_device members.

But after playing a bit with renaming uvc_video_queue.... It does not
look like a good idea. To do it properly we also need to rename
variables and functions and the change will be pretty massive. Any
future backport to stable is going to be hell....

>
> > > > > >       /* Buffers queue. */
> > > > > >       unsigned int frozen : 1;
> > > > > >       struct uvc_video_queue queue;
> > > > > >
> > > > > > ---
> > > > > > base-commit: d968e50b5c26642754492dea23cbd3592bde62d8
> > > > > > change-id: 20250716-uvc-onelocksless-b66658e01f89
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

