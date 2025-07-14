Return-Path: <linux-kernel+bounces-729548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED43BB03843
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4413216EED9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC172367DE;
	Mon, 14 Jul 2025 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GZqEoW9p"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039711DBB0C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479223; cv=none; b=tFMG2MI8IiwIPx1cUVvNiE5A+po90uPMAuK5Sc+WrjR4IfpuHwtrmydJTw3Vew8VoTf2vE3ybB3pFvEksLkGyThfPlpe+VC84FgsLgZcoB//fWS3fHEC4A1depBlLJvVjQ/gwRNcZkiA3bJczCwDNaRLLsViw8F2aKgXw8igfMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479223; c=relaxed/simple;
	bh=7elxMeEXvp1wM2XutufFBptshq5583mChiL6IFD3cdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWZvpYw/5vJ2h9fFDvcaD0DnmsCb4zQqxyQGDlXrLapr9wwl1wI26P6ZBG8qwxgu25dVwz6uU3oL0T8CcHbDflj8/elTrkZ2fwJq4R3RO7a8iTPjzvW45vzibmQLDXS4Q0S4wx/626KjRJzna2Ww4LYWdI++YHz/OIFea4peuCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GZqEoW9p; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5561c20e2d5so4942830e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752479220; x=1753084020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pSf9aMoYQyLirUqC8HpaRTr+wUf/smTXCC/AwdguD5c=;
        b=GZqEoW9pPQVIWcfCHUMvqwnOxQDTdtyfnjJEE1FwzOkRMg8SyUKYAlIUi9HvVcK7fA
         7OYblJaDU3SikbvF67JtOWQv9BQ8ffiir2yaZ1bCDKb2R3FWj74EDhO6dK4q9jMUkyRW
         fyoIGzvY5Co/170C3OCpG+zsDaddsRpOREZ+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752479220; x=1753084020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSf9aMoYQyLirUqC8HpaRTr+wUf/smTXCC/AwdguD5c=;
        b=kwFoT6WPbqrRGPoq2N/NxhRhqC72clpXEQm2cbm9T6Z1/IZhRoQ/UZOmP8OLSNVA8D
         FFXuK8alW/o4ZIKZgaRoWjK5zWf3VRIdCagv/M4XrjbLWG4nir09/bqILRbuECmktY+6
         hRkJHaSigfouVzCfW6h4ToIB0R/YOVXi3dkB1A1/X0rj6X8Wdn0sNBkjr7jahLXtTv4D
         7KT/irI7jSSMPFEG2xV7ixb4I4Evv5n7woxlUmxYRJIdFQeS5yBPj1Ztc42csY0bhyJI
         PWBHze6ftLGqH2ihTRpA7wzWag5/Ijiyr8YCDvCp3RIx2CcRF4YpoKqGGDYUbijdBPzC
         inCA==
X-Forwarded-Encrypted: i=1; AJvYcCXZjWrGgplKQ+YZBMAJ35oOukbvrHd+VlFqkLhaWW/ldCMAwpT/F1HfzgLb6sEOnVBbfr6WMsnMvCHymWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FROE94trhG/YHEM4tKPQgBZ+zdOYKYweMDdSRfarn3+0ICQA
	CiEc4CK9jL1y8Ylt316CUvHoGtZVf5RyphywaZzzliUx4JW4ZvylZZil6x861IKhtw+O7iwvTNk
	MibI=
X-Gm-Gg: ASbGncs82tdgIxtZH6H9+Ws6oX5adRCWnrizJktkFPJPDCWNs/OAd7CFWXp+L1CK5Vz
	R+y+UW+FRvP21LgWaTrsu3zOIjknOqarNIsKxQhdmwxyVI6n3qZJKarm0YnZiPkAxV3a3UfSzWh
	G410tk9XeVuzZV4btXHZ4EwC1X3xkcoePnwc4vYJQjufzMCW5vrGEuW2rL3G1Qhv/LL6BW42dm+
	qMYDHRkjisWSoylZxqlvKRpAk3mudMPZVwRy6FBimZeNEdLxM+IcFxWChgXJ/ESSZ9VKbNOF1qa
	/ENA9LYD2hC90NPSL2TWpi5wSjn4uTEFmIe6wCqxWRF6uT2wg8Y3JYaIgf2gcntVtGOlk7nh1st
	/p0V5F3jgaVdQMKxc2bvbt7w2fro4wGDqOPBuCbb4TKQzALIiV2MGfMzJavdq
X-Google-Smtp-Source: AGHT+IEkn6IqAHG1F0mV1jZh5KQmoWQ5q8G+eAVOBVD3auE93pVN6QEjXjDaEYb8mYkuzM1NNnMJVQ==
X-Received: by 2002:a05:6512:118e:b0:553:2868:6364 with SMTP id 2adb3069b0e04-55a0463bb7emr3147833e87.33.1752479219880;
        Mon, 14 Jul 2025 00:46:59 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7ed00asm1872847e87.77.2025.07.14.00.46.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 00:46:58 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5561c20e2d5so4942768e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:46:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUw0wQe75eW36Rz1F+Xu5AmT3BUVg15Z99KySHaNvtRaS2pJklg2ylHjFkOBnSSK+3SxHj0gU3f3hDYq0=@vger.kernel.org
X-Received: by 2002:a05:6512:3094:b0:553:6570:1999 with SMTP id
 2adb3069b0e04-55a044e372bmr2619792e87.13.1752479218064; Mon, 14 Jul 2025
 00:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-uvc-meta-v8-0-ed17f8b1218b@chromium.org>
 <20250707-uvc-meta-v8-5-ed17f8b1218b@chromium.org> <20250711195815.GH27674@pendragon.ideasonboard.com>
In-Reply-To: <20250711195815.GH27674@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Jul 2025 09:46:45 +0200
X-Gmail-Original-Message-ID: <CANiDSCsWE-5smL-H7CD_mi6AhJL2LAwf07bFpxJyN+0CnsLPfQ@mail.gmail.com>
X-Gm-Features: Ac12FXwqC1VN5_k1_HzlZaqYI-D_PHxB5Qi8X976aLSdl3Pe4ujQoB6CY0yAqTo
Message-ID: <CANiDSCsWE-5smL-H7CD_mi6AhJL2LAwf07bFpxJyN+0CnsLPfQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] media: uvcvideo: Auto-set UVC_QUIRK_MSXU_META
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hansg@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Fri, 11 Jul 2025 at 21:58, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Jul 07, 2025 at 06:34:05PM +0000, Ricardo Ribalda wrote:
> > If the camera supports the MSXU_CONTROL_METADATA control, auto set the
> > MSXU_META quirk.
> >
> > Reviewed-by: Hans de Goede <hansg@kernel.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c   |  7 +++-
> >  drivers/media/usb/uvc/uvc_metadata.c | 75 +++++++++++++++++++++++++++++++++++-
> >  drivers/media/usb/uvc/uvcvideo.h     |  2 +-
> >  include/linux/usb/uvc.h              |  3 ++
> >  4 files changed, 84 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 56ea20eeb7b9d5d92f3d837c15bdf11d536e9f2d..9de5abb43e19d9e876cddc5d7124592953db89ac 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2315,7 +2315,12 @@ static int uvc_probe(struct usb_interface *intf,
> >               goto error;
> >       }
> >
> > -     uvc_meta_init(dev);
> > +     ret = uvc_meta_init(dev);
> > +     if (ret < 0) {
> > +             dev_err(&dev->udev->dev,
> > +                     "Error initializing the metadata formats (%d)\n", ret);
> > +             goto error;
> > +     }
> >
> >       if (dev->quirks & UVC_QUIRK_NO_RESET_RESUME)
> >               udev->quirks &= ~USB_QUIRK_RESET_RESUME;
> > diff --git a/drivers/media/usb/uvc/uvc_metadata.c b/drivers/media/usb/uvc/uvc_metadata.c
> > index 77e03273d3cf6b00cac6ebb9b29b941f1cbfd9f7..59bb133baf9a73ef6a30fa8ead85aa90653d60f4 100644
> > --- a/drivers/media/usb/uvc/uvc_metadata.c
> > +++ b/drivers/media/usb/uvc/uvc_metadata.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/list.h>
> >  #include <linux/module.h>
> >  #include <linux/usb.h>
> > +#include <linux/usb/uvc.h>
> >  #include <linux/videodev2.h>
> >
> >  #include <media/v4l2-ioctl.h>
> > @@ -166,6 +167,71 @@ static const struct v4l2_file_operations uvc_meta_fops = {
> >       .mmap = vb2_fop_mmap,
> >  };
> >
> > +static struct uvc_entity *uvc_meta_find_msxu(struct uvc_device *dev)
> > +{
> > +     static const u8 uvc_msxu_guid[16] = UVC_GUID_MSXU_1_5;
> > +     struct uvc_entity *entity;
> > +
> > +     list_for_each_entry(entity, &dev->entities, list) {
> > +             if (!memcmp(entity->guid, uvc_msxu_guid, sizeof(entity->guid)))
> > +                     return entity;
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +#define MSXU_CONTROL_METADATA 0x9
> > +static int uvc_meta_detect_msxu(struct uvc_device *dev)
> > +{
> > +     u32 *data __free(kfree) = NULL;
> > +     struct uvc_entity *entity;
> > +     int ret;
> > +
> > +     entity = uvc_meta_find_msxu(dev);
> > +     if (!entity)
> > +             return 0;
> > +
> > +     /*
> > +      * USB requires buffers aligned in a special way, simplest way is to
> > +      * make sure that query_ctrl will work is to kmalloc() them.
> > +      */
> > +     data = kmalloc(sizeof(*data), GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     /* Check if the metadata is already enabled. */
> > +     ret = uvc_query_ctrl(dev, UVC_GET_CUR, entity->id, dev->intfnum,
> > +                          MSXU_CONTROL_METADATA, data, sizeof(*data));
> > +     if (ret)
> > +             return 0;
> > +
> > +     if (*data) {
> > +             dev->quirks |= UVC_QUIRK_MSXU_META;
> > +             return 0;
> > +     }
> > +
> > +     /*
> > +      * We have seen devices that require 1 to enable the metadata, others
> > +      * requiring a value != 1 and others requiring a value >1. Luckily for
>
> I'm confused here. If those are three different behaviours, then value
> != 1 would be value == 0 (as the third behaviour is value > 1). You test
> for !*data below, so 0 is not accepted as a valid value for this
> purpose. What am I missing ?

There is a typo in the comment.

Some devices require 1, some devices any value !=0, and other value=MAX.
I will fix it in a follow-up patch.


>
> > +      * us, the value from GET_MAX seems to work all the time.
> > +      */
> > +     ret = uvc_query_ctrl(dev, UVC_GET_MAX, entity->id, dev->intfnum,
> > +                          MSXU_CONTROL_METADATA, data, sizeof(*data));
> > +     if (ret || !*data)
> > +             return 0;
> > +
> > +     /*
> > +      * If we can set MSXU_CONTROL_METADATA, the device will report
> > +      * metadata.
> > +      */
> > +     ret = uvc_query_ctrl(dev, UVC_SET_CUR, entity->id, dev->intfnum,
> > +                          MSXU_CONTROL_METADATA, data, sizeof(*data));
> > +     if (!ret)
> > +             dev->quirks |= UVC_QUIRK_MSXU_META;
> > +
> > +     return 0;
> > +}
> > +
> >  int uvc_meta_register(struct uvc_streaming *stream)
> >  {
> >       struct uvc_device *dev = stream->dev;
> > @@ -185,9 +251,14 @@ int uvc_meta_register(struct uvc_streaming *stream)
> >                                        &uvc_meta_fops, &uvc_meta_ioctl_ops);
> >  }
> >
> > -void uvc_meta_init(struct uvc_device *dev)
> > +int uvc_meta_init(struct uvc_device *dev)
> >  {
> >       unsigned int i = 0;
> > +     int ret;
> > +
> > +     ret = uvc_meta_detect_msxu(dev);
> > +     if (ret)
> > +             return ret;
> >
> >       dev->meta_formats[i++] = V4L2_META_FMT_UVC;
> >
> > @@ -201,4 +272,6 @@ void uvc_meta_init(struct uvc_device *dev)
> >
> >        /* IMPORTANT: for new meta-formats update UVC_MAX_META_DATA_FORMATS. */
> >       dev->meta_formats[i++] = 0;
> > +
> > +     return 0;
> >  }
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index 616adc417c62a58686beccbc440a5dfac0a2d588..a4c064c5e046f2a4adba742c8777a10619569606 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -757,7 +757,7 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> >  void uvc_video_clock_update(struct uvc_streaming *stream,
> >                           struct vb2_v4l2_buffer *vbuf,
> >                           struct uvc_buffer *buf);
> > -void uvc_meta_init(struct uvc_device *dev);
> > +int uvc_meta_init(struct uvc_device *dev);
> >  int uvc_meta_register(struct uvc_streaming *stream);
> >
> >  int uvc_register_video_device(struct uvc_device *dev,
> > diff --git a/include/linux/usb/uvc.h b/include/linux/usb/uvc.h
> > index bce95153e5a65613a710d7316fc17cf5462b5bce..ee19e9f915b8370c333c426dc1ee4202c7b75c5b 100644
> > --- a/include/linux/usb/uvc.h
> > +++ b/include/linux/usb/uvc.h
> > @@ -29,6 +29,9 @@
> >  #define UVC_GUID_EXT_GPIO_CONTROLLER \
> >       {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
> >        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03}
> > +#define UVC_GUID_MSXU_1_5 \
> > +     {0xdc, 0x95, 0x3f, 0x0f, 0x32, 0x26, 0x4e, 0x4c, \
> > +      0x92, 0xc9, 0xa0, 0x47, 0x82, 0xf4, 0x3b, 0xc8}
> >
> >  #define UVC_GUID_FORMAT_MJPEG \
> >       { 'M',  'J',  'P',  'G', 0x00, 0x00, 0x10, 0x00, \
> >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

