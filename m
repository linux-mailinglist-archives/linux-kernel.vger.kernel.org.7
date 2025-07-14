Return-Path: <linux-kernel+bounces-730462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDE7B044E2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A883B5171
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F2A25D8E8;
	Mon, 14 Jul 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jyEWSbDh"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9067824DD17
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508783; cv=none; b=cRv5jb7J9KZ4HVQYJJYCqJPCwkuT6csT90kH6GY7279ysyJfqZ3rTIoPO8Db7Veh+y+Xf2QfnQZzXSGhpDpBioW6VfT3yDG6VR3XomrIUVRXV0qrzeqARG4fRqd5PBISslMPMh+FX/YLwXzCznCbl4H633No9lz0FnkzjgPJGlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508783; c=relaxed/simple;
	bh=jkfpbBDz6fsZzySxLlb7hy7jGu+rjZvw977kguTtv3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QI4Kr3O6IN7mNz1iCDShlsyAYjaS33XVH8UtyMzfFYeYTDgSKdZuHUEhodvvPwPqf6Rc3bPqr9XzxfPXcP85kH/cUPpsw9iMJ5iU/7XPJrBTxX3aapzBkFeiO/1L10eWFjUEWtWNCzqWmIUXtOOY6lLi6vxuU+kzdd2+ObA7Bro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jyEWSbDh; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-556373661aaso3718172e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752508779; x=1753113579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hof50iYCL5T7/Bkgw5ZGSrfNWjcSfleM91HbwvcCRsY=;
        b=jyEWSbDhvRtFHKdW/s+AFz0PQ/MUtKb/C/jArL8fKAL3zPXZ8SYM/wfb8jZ0f47Dy7
         LbI6H0Kp54UMDR5HBELnJEpYucSwOMwbxpksOZb+regmrnObzDBhSTWE5EdPYPEbdvlP
         WhaKP/F6QIp3OjuGeZLFC1J2Ah+GDGplYohtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752508779; x=1753113579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hof50iYCL5T7/Bkgw5ZGSrfNWjcSfleM91HbwvcCRsY=;
        b=j39D18EmRp1kI2CAfF6MMLlW6vrYy94kOeYd+94eVBGJI8C1KBkyTAynZ6FyV/M8ZJ
         at4pMfMA5RUOWHYEHfKv2783lEltLVbJmFKYhzelc62tMsNh8nNYwOCfh1JJ6kpUYdn9
         bv9wS4+/VbioJJXoglxr+VH6l+v18Z7/+2a/rz3b5+ux467z8JGVEG7uZSky96SJlMQ/
         pXuQbmmeyfXehLPEE/Jkhhq3uqOgCVQNcYPKUzm/rsV8LmLF05l7BvC7SPeV5dsTIfXi
         1MLqGbxheVV16AQpapzxGx1p1o4o3vHydw1x13Xl0XGBqrDmPCVgPZDAxzChznJ6EXSK
         MAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk5sA88//n97tG70ki7Ytx4cbfYIxBieU7XPAFJTV8SOYuz8wcqSyM4xjOzJA4ef2wfAsMfDsg9J1X660=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA64Pv+Yde/9ZpbrYtHTYUa2EKMQ23eBu7whjZ68aS0N0B/fUI
	3/VpmytbvNA2H279lPQHjelskMJunLRdeuz2QEM+AXtfK2e/8rS04euDL0T/CG1cHtzllbc4XwC
	BLSVEQw==
X-Gm-Gg: ASbGncvALcx0ZrbI/j0NaoisBCBi/RnuDXD/m36ldZoeTJhjQPx6LMHBh6gjslfJpfR
	HQnIwcmH4psFKQJq4jm8EFw9IZdCv98auH0a95ZClmeF++rI4PBo2rd8TyNIvfisu+YVdAayqhR
	2UNGpw8yNAijERyARki1mkZSSi6tAIqKjsNOv9qgHuFNxSTX0akP21kEPp+twi9Lw+gEsiHN9dG
	GuE+2bl/Hk/qa1B3nEOfjL/QJHGKk42JzKPyebOnO60fn5GLRCZ5njGJeMsF1IURW24nWNDE2/d
	+hune7iOkJ0+QZkBcGAdp2+2h/OZ4pVybJ2b908L+5dD/XqlPvDw9+lEiNovkHx2wlG6coVWAQN
	ldH7IwE7kP5OMgm/f5deM/9MlDwofnjy1DioAQ/1K8/6UV/MD9vdjLR7NJrhBvRoD
X-Google-Smtp-Source: AGHT+IEVL94R+hr0S6dg+412Nuqk7p8I4OonGlaucMSvAV+XSKigEn1R/8/Xtp3guXY4JODWUZAJEA==
X-Received: by 2002:a05:6512:12c3:b0:553:a339:2c34 with SMTP id 2adb3069b0e04-55a0464adf3mr4193914e87.44.1752508779369;
        Mon, 14 Jul 2025 08:59:39 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d2e52sm1991420e87.105.2025.07.14.08.59.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:59:38 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b3b250621so39032711fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:59:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVr/B6ijvgUYmjc0a3KtuShky33ab+WZ+k7Ey142sz1n9D3kvEcK7TJOj+zZ8KK/93oFe+eXQgrtCGwZqc=@vger.kernel.org
X-Received: by 2002:a2e:b5af:0:b0:32c:de97:6ff7 with SMTP id
 38308e7fff4ca-330535f6a83mr36141461fa.29.1752508778131; Mon, 14 Jul 2025
 08:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-11-5710f9d030aa@chromium.org>
 <20250629181440.GO24912@pendragon.ideasonboard.com> <CANiDSCvSP-NXpefOiKnGf53eUWKVf7iJqtXPEPN9e-Gaxt0k7A@mail.gmail.com>
 <20250714143120.GJ8243@pendragon.ideasonboard.com>
In-Reply-To: <20250714143120.GJ8243@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Jul 2025 17:59:24 +0200
X-Gmail-Original-Message-ID: <CANiDSCt6Xy_5bj6H7qFvG+g=FMfW7GWXvPGa5T+gdKPDqCa5BQ@mail.gmail.com>
X-Gm-Features: Ac12FXx_F9n-LUsxRwoh8ZmPOJZUgV6UwgyllEtyANUua67LvfGkioCuWb8sCms
Message-ID: <CANiDSCt6Xy_5bj6H7qFvG+g=FMfW7GWXvPGa5T+gdKPDqCa5BQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] media: uvcvideo: Add support for V4L2_CID_CAMERA_ROTATION
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 16:31, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Jul 01, 2025 at 01:26:51PM +0200, Ricardo Ribalda wrote:
> > On Sun, 29 Jun 2025 at 20:15, Laurent Pinchart wrote:
> > > On Thu, Jun 05, 2025 at 05:53:04PM +0000, Ricardo Ribalda wrote:
> > > > Fetch the rotation from the fwnode and map it into a control.
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_ctrl.c     | 22 +++++++++++++--
> > > >  drivers/media/usb/uvc/uvc_swentity.c | 55 ++++++++++++++++++++++++++++++++----
> > > >  drivers/media/usb/uvc/uvcvideo.h     |  5 ++++
> > > >  3 files changed, 74 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > index 59be62ae24a4219fa9d7aacf2ae7382c95362178..5788f0c0f6604da06a7bca1b9999d0957817e75e 100644
> > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > @@ -378,11 +378,18 @@ static const struct uvc_control_info uvc_ctrls[] = {
> > > >       },
> > > >       {
> > > >               .entity         = UVC_GUID_SWENTITY,
> > > > -             .selector       = 0,
> > > > -             .index          = 0,
> > > > +             .selector       = UVC_SWENTITY_ORIENTATION,
> > > > +             .index          = UVC_SWENTITY_ORIENTATION,
> > > >               .size           = 1,
> > > >               .flags          = UVC_CTRL_FLAG_GET_CUR,
> > > >       },
> > > > +     {
> > > > +             .entity         = UVC_GUID_SWENTITY,
> > > > +             .selector       = UVC_SWENTITY_ROTATION,
> > > > +             .index          = UVC_SWENTITY_ROTATION,
> > > > +             .size           = 2,
> > > > +             .flags          = UVC_CTRL_FLAG_GET_RANGE,
> > > > +     },
> > > >  };
> > > >
> > > >  static const u32 uvc_control_classes[] = {
> > > > @@ -1025,7 +1032,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
> > > >       {
> > > >               .id             = V4L2_CID_CAMERA_ORIENTATION,
> > > >               .entity         = UVC_GUID_SWENTITY,
> > > > -             .selector       = 0,
> > > > +             .selector       = UVC_SWENTITY_ORIENTATION,
> > > >               .size           = 8,
> > > >               .offset         = 0,
> > > >               .v4l2_type      = V4L2_CTRL_TYPE_MENU,
> > > > @@ -1033,6 +1040,15 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
> > > >               .menu_mask      = GENMASK(V4L2_CAMERA_ORIENTATION_EXTERNAL,
> > > >                                         V4L2_CAMERA_ORIENTATION_FRONT),
> > > >       },
> > > > +     {
> > > > +             .id             = V4L2_CID_CAMERA_SENSOR_ROTATION,
> > > > +             .entity         = UVC_GUID_SWENTITY,
> > > > +             .selector       = UVC_SWENTITY_ROTATION,
> > > > +             .size           = 16,
> > > > +             .offset         = 0,
> > > > +             .v4l2_type      = V4L2_CTRL_TYPE_INTEGER,
> > > > +             .data_type      = UVC_CTRL_DATA_TYPE_UNSIGNED,
> > > > +     },
> > > >  };
> > > >
> > > >  /* ------------------------------------------------------------------------
> > > > diff --git a/drivers/media/usb/uvc/uvc_swentity.c b/drivers/media/usb/uvc/uvc_swentity.c
> > > > index 702a2c26e029a0655dade177ed2a9b88d7a4136d..60f3166addbeb7d2e431d107b23034d2d11a1812 100644
> > > > --- a/drivers/media/usb/uvc/uvc_swentity.c
> > > > +++ b/drivers/media/usb/uvc/uvc_swentity.c
> > > > @@ -10,10 +10,11 @@
> > > >  #include <media/v4l2-fwnode.h>
> > > >  #include "uvcvideo.h"
> > > >
> > > > -static int uvc_swentity_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
> > > > -                             u8 cs, void *data, u16 size)
> > > > +static int uvc_swentity_get_orientation(struct uvc_device *dev,
> > > > +                                     struct uvc_entity *entity, u8 cs,
> > > > +                                     void *data, u16 size)
> > > >  {
> > > > -     if (size < 1)
> > > > +     if (cs != UVC_SWENTITY_ORIENTATION || size != 1)
> > > >               return -EINVAL;
> > > >
> > > >       switch (entity->swentity.props.orientation) {
> > > > @@ -30,6 +31,31 @@ static int uvc_swentity_get_cur(struct uvc_device *dev, struct uvc_entity *entit
> > > >       return 0;
> > > >  }
> > > >
> > > > +static int uvc_swentity_get_rotation(struct uvc_device *dev,
> > > > +                                  struct uvc_entity *entity, u8 cs, void *data,
> > > > +                                  u16 size)
> > > > +{
> > > > +     if (cs != UVC_SWENTITY_ROTATION || size != 2)
> > > > +             return -EINVAL;
> > > > +
> > > > +     ((u8 *)data)[0] = entity->swentity.props.rotation;
> > > > +     ((u8 *)data)[1] = entity->swentity.props.rotation >> 8;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int uvc_swentity_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
> > > > +                             u8 cs, void *data, u16 size)
> > > > +{
> > > > +     switch (cs) {
> > > > +     case UVC_SWENTITY_ORIENTATION:
> > > > +             return uvc_swentity_get_orientation(dev, entity, cs, data, size);
> > > > +     case UVC_SWENTITY_ROTATION:
> > > > +             return uvc_swentity_get_rotation(dev, entity, cs, data, size);
> > > > +     }
> > > > +     return -EINVAL;
> > > > +}
> > > > +
> > > >  static int uvc_swentity_get_info(struct uvc_device *dev,
> > > >                                struct uvc_entity *entity, u8 cs, u8 *caps)
> > > >  {
> > > > @@ -37,11 +63,22 @@ static int uvc_swentity_get_info(struct uvc_device *dev,
> > > >       return 0;
> > > >  }
> > > >
> > > > +static int uvc_swentity_get_res(struct uvc_device *dev, struct uvc_entity *entity,
> > > > +                             u8 cs, void *res, u16 size)
> > > > +{
> > > > +     if (size == 0)
> > > > +             return -EINVAL;
> > >
> > > The get_cur functions return an error if the size doesn't match the
> > > expected size. I think you can return -EINVAL if size != 1.
> > >
> > > > +     ((u8 *)res)[0] = 1;
> > > > +     memset(res + 1, 0, size - 1);
> > >
> > > And drop the memset.
> > >
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  int uvc_swentity_init(struct uvc_device *dev)
> > > >  {
> > > >       static const u8 uvc_swentity_guid[] = UVC_GUID_SWENTITY;
> > > >       struct v4l2_fwnode_device_properties props;
> > > >       struct uvc_entity *unit;
> > > > +     u8 controls = 0;
> > > >       int ret;
> > > >
> > > >       ret = v4l2_fwnode_device_parse(&dev->udev->dev, &props);
> > > > @@ -49,7 +86,11 @@ int uvc_swentity_init(struct uvc_device *dev)
> > > >               return dev_err_probe(&dev->intf->dev, ret,
> > > >                                    "Can't parse fwnode\n");
> > > >
> > > > -     if (props.orientation == V4L2_FWNODE_PROPERTY_UNSET)
> > > > +     if (props.orientation != V4L2_FWNODE_PROPERTY_UNSET)
> > > > +             controls |= BIT(UVC_SWENTITY_ORIENTATION);
> > > > +     if (props.rotation != V4L2_FWNODE_PROPERTY_UNSET)
> > > > +             controls |= BIT(UVC_SWENTITY_ROTATION);
> > > > +     if (!controls)
> > > >               return 0;
> > > >
> > > >       unit = uvc_alloc_entity(UVC_SWENTITY_UNIT, UVC_SWENTITY_UNIT_ID, 0, 1);
> > > > @@ -60,9 +101,13 @@ int uvc_swentity_init(struct uvc_device *dev)
> > > >       unit->swentity.props = props;
> > > >       unit->swentity.bControlSize = 1;
> > > >       unit->swentity.bmControls = (u8 *)unit + sizeof(*unit);
> > > > -     unit->swentity.bmControls[0] = 1;
> > > > +     unit->swentity.bmControls[0] = controls;
> > > >       unit->get_cur = uvc_swentity_get_cur;
> > > >       unit->get_info = uvc_swentity_get_info;
> > > > +     unit->get_res = uvc_swentity_get_res;
> > > > +     unit->get_def = uvc_swentity_get_rotation;
> > > > +     unit->get_min = uvc_swentity_get_rotation;
> > > > +     unit->get_max = uvc_swentity_get_rotation;
> > >
> > > Why do you support GET_DEF, GET_MIN and GET_MAX for rotation only ?
> >
> > Orientation has enum type. It does not require min or max.
> >
> > For get_def I could use get_cur, but 0 is as good as any other value
> > within range.
>
> Both the orientation and rotation are read-only, and should report min
> == max == def == cur. What am I missing ?

V4L2_CID_CAMERA_ORIENTATION has type V4L2_CTRL_TYPE_MENU
In _uvc_queryctrl_boundaries(), min and max are auto calculated, they
are not based on information from the device.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/usb/uvc/uvc_ctrl.c#n1504

I can change  unit->get_(def|min|max)=uvc_swentity_get_cur if you
think that it is cleaner...

Regards!

>
> > > >       strscpy(unit->name, "SWENTITY", sizeof(unit->name));
> > > >
> > > >       list_add_tail(&unit->list, &dev->entities);
> > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > index d6da8ed3ad4cf3377df49923e051fe04d83d2e38..7cca0dc75d11f6a13bc4f09676a5a00e80cb38f7 100644
> > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > @@ -45,6 +45,11 @@
> > > >  #define UVC_SWENTITY_UNIT            0x7ffd
> > > >  #define UVC_SWENTITY_UNIT_ID         0x101
> > > >
> > > > +enum {
> > > > +     UVC_SWENTITY_ORIENTATION,
> > > > +     UVC_SWENTITY_ROTATION
> > > > +};
> > > > +
> > > >  /* ------------------------------------------------------------------------
> > > >   * Driver specific constants.
> > > >   */
>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda

