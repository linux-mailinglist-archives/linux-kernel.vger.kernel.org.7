Return-Path: <linux-kernel+bounces-729626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC030B03953
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEAC17C5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E528223BCE4;
	Mon, 14 Jul 2025 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GonXFGq4"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791DC23E350
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481302; cv=none; b=L0j7gCp40SQFJIBnz33llVatgp8cXRTe9f5A56vBLgZqrk7jfWNrzw3TatwS+BqcvMVVOMtiTF4c6UfXM17lwPg7i5sG1qF0VbOTA3LC63y+PRfHz+YGsgBdoXZWdXQvTB4df+NbD+0L8D6Qc/2+YbXbvaRcxOZy8D4IF8x+aIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481302; c=relaxed/simple;
	bh=arVcmvMi7wv9dMtrbTzsYunSGTpRra0ZVUpLvZuaUuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s01e2R+Y4/XsyCFFKBgDjCAgvKZ97auYJBHrf51fr/269g4jnNW8ch9qppQrd0z+Ju7wbbM1890FJ3wJ495t3hbC8imuc53AVnF7z3IiVNTYHawH8rtC6dINPKLzeK7Gqy+C3Hw/SyDw4YhJldgclXIT/FVPQOPoJ7Y/DmdRoHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GonXFGq4; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-555024588a8so3594712e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 01:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752481297; x=1753086097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3QXzSslzxPfJBBocBjcOMU9pFCY2a4+fYCQYUTldnc8=;
        b=GonXFGq4QPafl67e4pLty42kcEYn1K/OBXuWK9EIO0LYjQKlFQCaD2+x3JjeoFQFwA
         ASMO6Sz8JGSv78VXRSgOzaYae0xdg97NQvp27e0rFQaSVYBjdX1eVn8Aqvm0uXotkC6Q
         wGzvAFBM6H6YRq22wtPr7+HjKX7q1fEPY97EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752481297; x=1753086097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QXzSslzxPfJBBocBjcOMU9pFCY2a4+fYCQYUTldnc8=;
        b=kBdlpU3V+GopqhacMs+AVii9o4IxePwslit09v8mUer/zQfxI/zAMib5nTzckSGkdE
         WmWxc4CuJ8N5Z64HnricKX0IfGFl38TGwK7tuNxVN6JuQMYGboN3JbV2WOpMApkwlU3q
         oh17F7JF4NOY4fXNzxcPAMnhHOtLv5/r5rotbjh03mZFkJN+B5ytHmv5O/qHDARuAQBv
         0kM9/gxewNq89UNR8W+yNZhRuaRDo8N0u4bbWCUpGYPx5U043E4tvkrMR2jlfzzyaGMA
         e/xbg4VIJWr/MewPP3QmRGSAMPd5dBCstbHtYBK5ML8D0Q6jfncNG2gSujEJ9hOYAls5
         JBtg==
X-Forwarded-Encrypted: i=1; AJvYcCW7u4JwLsV7D5vYbGgi0i4V9wPYhzPswgWs+HRsxzg8aejW532Q+v7xGwDx6rvPYG82c+wqcSLenAviVxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMN9SNOsDpYiE8ohEepYc6MtfbIVoRGg4MWIu7uKA0thlhg72I
	1uEYtfVET0By+MBnrdXGsfhqLLYr24BB8NAuKpypjMr4h9sP8ZSU5TsEmoUp73G2OIVIlhIJQS7
	CHXE=
X-Gm-Gg: ASbGncs7mwd1Y40Xnd4qCmXgo9VagEvWqgecZ8sS+PuHbecqt6BQtjBoO9UJPMa1pvL
	3kapkicoxuAtxs3FwGo7q+p1bmX5ILxh1GMjcUcWrwwKtaiTPSuT4OISrCgwspXSH9bXv5NYG2W
	8Co4rcWQxzBJYBlj5U4Gg9tymhN2CwXZrs6oEFl/PZXNXZZ5CqkMIRjNNo3g7MhBMRALyHUpiJo
	9ZwHWZQ9MMKGt6Gbg31djFsJ6L1oVPBoOwZj2Y3B/GD1uPUrUAIXBC0xwbvH64n9bw29xNnuTNc
	XGQpftogzH2k3G0Ah6+7jIqeVpRWnCt98E1X8T6O9VK9/bwl0smYJbCqj2CGA97aN79fp2PAHSj
	8h0vyv6rW/b+853LVuqlhOoUnnOC6uf4/8t+eIe3mdv7jtwAJhaYW6Q6vzvaw
X-Google-Smtp-Source: AGHT+IEvvvLXpI70sajOcxO61UVcXcidUI6Kp1+FlNvT577z6xiiA3ECWvH42nqtbsEBW4lRLNt26w==
X-Received: by 2002:a05:6512:3096:b0:553:3892:5ead with SMTP id 2adb3069b0e04-55a044adb03mr3022243e87.2.1752481297413;
        Mon, 14 Jul 2025 01:21:37 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7e947fsm1848855e87.63.2025.07.14.01.21.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 01:21:37 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553c31542b1so3761039e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 01:21:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUipcKr88JYAlMpbeXH49t90/ImeUBYTBFKbYA+TRcuFQkZLR5bv7bgfEE5pxnViFyInJ2QC/+jOF3UI7Q=@vger.kernel.org
X-Received: by 2002:a05:6512:3096:b0:553:3892:5ead with SMTP id
 2adb3069b0e04-55a044adb03mr3022181e87.2.1752481294990; Mon, 14 Jul 2025
 01:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-uvc-meta-v8-0-ed17f8b1218b@chromium.org>
 <20250707-uvc-meta-v8-5-ed17f8b1218b@chromium.org> <20250711195815.GH27674@pendragon.ideasonboard.com>
 <CANiDSCsWE-5smL-H7CD_mi6AhJL2LAwf07bFpxJyN+0CnsLPfQ@mail.gmail.com> <20250714080608.GB10401@pendragon.ideasonboard.com>
In-Reply-To: <20250714080608.GB10401@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Jul 2025 10:21:20 +0200
X-Gmail-Original-Message-ID: <CANiDSCvkTQeTsFwRiJF=9s8jHsRtWjb46=JcwLWPPK0VLqkbEA@mail.gmail.com>
X-Gm-Features: Ac12FXxusuV_-IRh_oeOSKzUpooIdoCQ91c10vGt0gZ29pEOz092uostatKw6ck
Message-ID: <CANiDSCvkTQeTsFwRiJF=9s8jHsRtWjb46=JcwLWPPK0VLqkbEA@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] media: uvcvideo: Auto-set UVC_QUIRK_MSXU_META
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hansg@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 10:06, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Jul 14, 2025 at 09:46:45AM +0200, Ricardo Ribalda wrote:
> > On Fri, 11 Jul 2025 at 21:58, Laurent Pinchart wrote:
> > > On Mon, Jul 07, 2025 at 06:34:05PM +0000, Ricardo Ribalda wrote:
> > > > If the camera supports the MSXU_CONTROL_METADATA control, auto set the
> > > > MSXU_META quirk.
> > > >
> > > > Reviewed-by: Hans de Goede <hansg@kernel.org>
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_driver.c   |  7 +++-
> > > >  drivers/media/usb/uvc/uvc_metadata.c | 75 +++++++++++++++++++++++++++++++++++-
> > > >  drivers/media/usb/uvc/uvcvideo.h     |  2 +-
> > > >  include/linux/usb/uvc.h              |  3 ++
> > > >  4 files changed, 84 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > index 56ea20eeb7b9d5d92f3d837c15bdf11d536e9f2d..9de5abb43e19d9e876cddc5d7124592953db89ac 100644
> > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > @@ -2315,7 +2315,12 @@ static int uvc_probe(struct usb_interface *intf,
> > > >               goto error;
> > > >       }
> > > >
> > > > -     uvc_meta_init(dev);
> > > > +     ret = uvc_meta_init(dev);
> > > > +     if (ret < 0) {
> > > > +             dev_err(&dev->udev->dev,
> > > > +                     "Error initializing the metadata formats (%d)\n", ret);
> > > > +             goto error;
> > > > +     }
> > > >
> > > >       if (dev->quirks & UVC_QUIRK_NO_RESET_RESUME)
> > > >               udev->quirks &= ~USB_QUIRK_RESET_RESUME;
> > > > diff --git a/drivers/media/usb/uvc/uvc_metadata.c b/drivers/media/usb/uvc/uvc_metadata.c
> > > > index 77e03273d3cf6b00cac6ebb9b29b941f1cbfd9f7..59bb133baf9a73ef6a30fa8ead85aa90653d60f4 100644
> > > > --- a/drivers/media/usb/uvc/uvc_metadata.c
> > > > +++ b/drivers/media/usb/uvc/uvc_metadata.c
> > > > @@ -10,6 +10,7 @@
> > > >  #include <linux/list.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/usb.h>
> > > > +#include <linux/usb/uvc.h>
> > > >  #include <linux/videodev2.h>
> > > >
> > > >  #include <media/v4l2-ioctl.h>
> > > > @@ -166,6 +167,71 @@ static const struct v4l2_file_operations uvc_meta_fops = {
> > > >       .mmap = vb2_fop_mmap,
> > > >  };
> > > >
> > > > +static struct uvc_entity *uvc_meta_find_msxu(struct uvc_device *dev)
> > > > +{
> > > > +     static const u8 uvc_msxu_guid[16] = UVC_GUID_MSXU_1_5;
> > > > +     struct uvc_entity *entity;
> > > > +
> > > > +     list_for_each_entry(entity, &dev->entities, list) {
> > > > +             if (!memcmp(entity->guid, uvc_msxu_guid, sizeof(entity->guid)))
> > > > +                     return entity;
> > > > +     }
> > > > +
> > > > +     return NULL;
> > > > +}
> > > > +
> > > > +#define MSXU_CONTROL_METADATA 0x9
> > > > +static int uvc_meta_detect_msxu(struct uvc_device *dev)
> > > > +{
> > > > +     u32 *data __free(kfree) = NULL;
> > > > +     struct uvc_entity *entity;
> > > > +     int ret;
> > > > +
> > > > +     entity = uvc_meta_find_msxu(dev);
> > > > +     if (!entity)
> > > > +             return 0;
> > > > +
> > > > +     /*
> > > > +      * USB requires buffers aligned in a special way, simplest way is to
> > > > +      * make sure that query_ctrl will work is to kmalloc() them.
> > > > +      */
> > > > +     data = kmalloc(sizeof(*data), GFP_KERNEL);
> > > > +     if (!data)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     /* Check if the metadata is already enabled. */
> > > > +     ret = uvc_query_ctrl(dev, UVC_GET_CUR, entity->id, dev->intfnum,
> > > > +                          MSXU_CONTROL_METADATA, data, sizeof(*data));
> > > > +     if (ret)
> > > > +             return 0;
> > > > +
> > > > +     if (*data) {
> > > > +             dev->quirks |= UVC_QUIRK_MSXU_META;
> > > > +             return 0;
> > > > +     }
> > > > +
> > > > +     /*
> > > > +      * We have seen devices that require 1 to enable the metadata, others
> > > > +      * requiring a value != 1 and others requiring a value >1. Luckily for
> > >
> > > I'm confused here. If those are three different behaviours, then value
> > > != 1 would be value == 0 (as the third behaviour is value > 1). You test
> > > for !*data below, so 0 is not accepted as a valid value for this
> > > purpose. What am I missing ?
> >
> > There is a typo in the comment.
> >
> > Some devices require 1, some devices any value !=0, and other value=MAX.
> > I will fix it in a follow-up patch.
>
> The documentation of the control states that MSXU_CONTROL_METADATA
> reports the maximum size of the MS metadata generated by the device in
> kB, and the control should be set to the value reported by GET_MAX to
> enable metadata generation. That's what you're doing in this patch, so
> you can update the comment to document there.

Some vendors assumed the kB was a typo in MS spec and used bytes instead :)
In this favor I must say that kB here sounds like a mistake, I haven't
seen more than 300 bytes of metadata.

Will send a patch with the updated documentation.


>
> Some devices also don't support SET_CUR, in which case they should
> report GET_MIN == GET_DEF == GET_MAX. I assume GET_CUR should then also
> report the same value. Please also update the previous comment to
> explain this, the GET_CUR value check above is more about handling
> devices that always produce metadata than devices for which a driver has
> enabled metadata production.
>
> This leads to another question: should we enable metadata generation
> only when the metadata capture device is streaming ?

This will lead to a lot of issues with very little benefit.

We have no control over the order that the user will enable streamon
in the metadata and "normal" video devices. And the device will not
like that MSXU_CONTROL_METADATA changes during streamon.

I have not seen any performance penalty by the 300 new bytes
transferred when the metadata is on.


>
> > > > +      * us, the value from GET_MAX seems to work all the time.
> > > > +      */
> > > > +     ret = uvc_query_ctrl(dev, UVC_GET_MAX, entity->id, dev->intfnum,
> > > > +                          MSXU_CONTROL_METADATA, data, sizeof(*data));
> > > > +     if (ret || !*data)
> > > > +             return 0;
> > > > +
> > > > +     /*
> > > > +      * If we can set MSXU_CONTROL_METADATA, the device will report
> > > > +      * metadata.
> > > > +      */
> > > > +     ret = uvc_query_ctrl(dev, UVC_SET_CUR, entity->id, dev->intfnum,
> > > > +                          MSXU_CONTROL_METADATA, data, sizeof(*data));
> > > > +     if (!ret)
> > > > +             dev->quirks |= UVC_QUIRK_MSXU_META;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  int uvc_meta_register(struct uvc_streaming *stream)
> > > >  {
> > > >       struct uvc_device *dev = stream->dev;
> > > > @@ -185,9 +251,14 @@ int uvc_meta_register(struct uvc_streaming *stream)
> > > >                                        &uvc_meta_fops, &uvc_meta_ioctl_ops);
> > > >  }
> > > >
> > > > -void uvc_meta_init(struct uvc_device *dev)
> > > > +int uvc_meta_init(struct uvc_device *dev)
> > > >  {
> > > >       unsigned int i = 0;
> > > > +     int ret;
> > > > +
> > > > +     ret = uvc_meta_detect_msxu(dev);
> > > > +     if (ret)
> > > > +             return ret;
> > > >
> > > >       dev->meta_formats[i++] = V4L2_META_FMT_UVC;
> > > >
> > > > @@ -201,4 +272,6 @@ void uvc_meta_init(struct uvc_device *dev)
> > > >
> > > >        /* IMPORTANT: for new meta-formats update UVC_MAX_META_DATA_FORMATS. */
> > > >       dev->meta_formats[i++] = 0;
> > > > +
> > > > +     return 0;
> > > >  }
> > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > index 616adc417c62a58686beccbc440a5dfac0a2d588..a4c064c5e046f2a4adba742c8777a10619569606 100644
> > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > @@ -757,7 +757,7 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> > > >  void uvc_video_clock_update(struct uvc_streaming *stream,
> > > >                           struct vb2_v4l2_buffer *vbuf,
> > > >                           struct uvc_buffer *buf);
> > > > -void uvc_meta_init(struct uvc_device *dev);
> > > > +int uvc_meta_init(struct uvc_device *dev);
> > > >  int uvc_meta_register(struct uvc_streaming *stream);
> > > >
> > > >  int uvc_register_video_device(struct uvc_device *dev,
> > > > diff --git a/include/linux/usb/uvc.h b/include/linux/usb/uvc.h
> > > > index bce95153e5a65613a710d7316fc17cf5462b5bce..ee19e9f915b8370c333c426dc1ee4202c7b75c5b 100644
> > > > --- a/include/linux/usb/uvc.h
> > > > +++ b/include/linux/usb/uvc.h
> > > > @@ -29,6 +29,9 @@
> > > >  #define UVC_GUID_EXT_GPIO_CONTROLLER \
> > > >       {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
> > > >        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03}
> > > > +#define UVC_GUID_MSXU_1_5 \
> > > > +     {0xdc, 0x95, 0x3f, 0x0f, 0x32, 0x26, 0x4e, 0x4c, \
> > > > +      0x92, 0xc9, 0xa0, 0x47, 0x82, 0xf4, 0x3b, 0xc8}
> > > >
> > > >  #define UVC_GUID_FORMAT_MJPEG \
> > > >       { 'M',  'J',  'P',  'G', 0x00, 0x00, 0x10, 0x00, \
> > > >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

