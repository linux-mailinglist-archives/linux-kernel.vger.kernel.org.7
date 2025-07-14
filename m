Return-Path: <linux-kernel+bounces-730459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8EAB044D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523537ADD0D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59F825EF97;
	Mon, 14 Jul 2025 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IcWRSa1Z"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2487125BF1B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508494; cv=none; b=lNnTfHB+iIw0IDG5MWZFy2ZA5hCwXJZGV6PxAYv9UGOeUMYRRC8vvxinigRUCAOfeBAqT6oSyQK5TObIRrWrMKokqVcLnmXqvFR/jwOadCPh3ywnC8+Jb9OtU9TFDYZbZ+I+r39Va+d/n5ktPpfMrB2+gW/I4+5kS1atHan1Hjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508494; c=relaxed/simple;
	bh=5LlMEN4J3o3aD6YDXjwZ5zCkBWXWLqScnxci+wtPW0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pf+u4WQFcz/bQAdRph3bltXXeXo1ZeDaezd5GWogVnCmrbrahzjkjLc4Y/JUNxVJ7jf6xeHpvkiwxKkHs+e983RW8LqreIpEAiJYoyckHdkY7FiBSpn80+zxD8PsiYUKTmkofaDMf27dwxEsZcxrB2EoyhO7PpW75gt6XzW701g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IcWRSa1Z; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae36e88a5daso897969366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752508491; x=1753113291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9h6RiMEbdSPWHXVsj9OLxwFBmTJFmqoquTZg92Kpnmk=;
        b=IcWRSa1ZJ0lxbrbqEkWQJ956iUSO8Sw5FFvp/6eSfoQ1a/HSuupelG75ueybDrz14z
         r7xHuWxsCWu3ht1FJfZJilz5PUkxL019+2WkamzipPcLjB1Dh8Knq/PiorkZtRUoo5f3
         QI/X9YaJm3+er2Fx1ffgt9Aa5IQeUnfXimCcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752508491; x=1753113291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9h6RiMEbdSPWHXVsj9OLxwFBmTJFmqoquTZg92Kpnmk=;
        b=igwY2UsWo6/E8KGJxRaPe4nfGxBgdxLi72Vn7n1gy9OqEU9/WHGGf0rNBv7q7jF7AH
         YxlqsfvJ6HH1zzHexlgi5lgckc3Vr/Ei5MEqvYLMwln2K5R5TForB2HCbomhsdaXrhfs
         rFOVSPzDZlJZUFQOi8pyz2MkWuEZBb6mcMxlnPR00LAJ1bSiZzmZ10D994pU+tiWbV+7
         SGokoKhiRj17JNtQY/z34Yy9WyCHl57jSBp0HJiVwqmSRGBcwxFMi+rFe32JeD4/xAPQ
         7vdUawp+OkvzmE1WZ8AFZxybWDVfuyP8w0WO8KEA9DbZUW87PllRAwclRFu1P5/q3xB8
         lvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv+IN0t+pz8f1vocCTchgZo0MfN9uu9kFQJkVSLtRZANKrkTKqPY6El7cQDPSMnv9/cN6ni9tcIyVW9SU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+NtYMVa0AndeHFW340DMobZj6DukmCa0gbMg8tj6GwRmMT9Wj
	FQU571NxLgsmXlUa+hwwQMO3T2D9wXOsbqy1K6MUKan/Dn/yCcla24eEWG7/+KzDOzdmp2GZr0/
	pOjDxHg==
X-Gm-Gg: ASbGncunEVh9+didAkRM2Q44h33qT8kamSGtjXkWUDoOyKk/VYut9HlR6dx8tf4hDqp
	Vfk/D9/Rz0u1WJtv+AUkHC5CsoMXd2umYw91T8PKOnEDIN/Fj3WljoKX3JZXCldau3LIyM7jlxx
	zMLXlSeF6VBkT8R8MnrE9rP53nlH71c7Y9sD0A1zNhuv1UdNS0Y77AClF2nw65Jwr4m5op1fAkw
	z/ZnaDk/HbM6FXlcBE5/48W2+f1//s3CqeCK/+EXTz36bbBenlOcqFr6KVsSvryk1w0AxQUokFL
	ideHko6o6YZhq0g6snBq7OfUb6g5dUPEHQ35gx1bauAC/KUKtQesFcDAX7SAD9FaI1FLIrXNAOO
	bEPI93kiOI/T8Yawyg1XiXB3GzppUtoYSW4jEuWeNHjWwHNCmUAqX2OptB7Ex
X-Google-Smtp-Source: AGHT+IFcORXQnRlyAQl1BWIkNKBcRWIRUrC5YBpxoOBv4Wb3iX34/fPFZjmwfnOilEdKaHia8kiIfA==
X-Received: by 2002:a17:907:3c85:b0:ae3:f296:84cf with SMTP id a640c23a62f3a-ae6fc1204f3mr1387359066b.30.1752508491254;
        Mon, 14 Jul 2025 08:54:51 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82ded59sm830302566b.169.2025.07.14.08.54.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:54:51 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso7093068a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:54:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTr9itchJDQyJky3ubwmJg64DtoizDJZEveXPZbrOVzUA6AjcvgfbxSpK2vfErnpQI2waQmALxozUvBMU=@vger.kernel.org
X-Received: by 2002:a05:6512:b10:b0:553:3492:b708 with SMTP id
 2adb3069b0e04-55a046250abmr3344250e87.49.1752508013248; Mon, 14 Jul 2025
 08:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-10-5710f9d030aa@chromium.org>
 <20250629181246.GE6260@pendragon.ideasonboard.com> <CANiDSCsu0RT4dcGyBJRutP=9HTe+niUoohxTZE=qJ8O_9ez=+A@mail.gmail.com>
 <20250714142926.GI8243@pendragon.ideasonboard.com>
In-Reply-To: <20250714142926.GI8243@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Jul 2025 17:46:40 +0200
X-Gmail-Original-Message-ID: <CANiDSCvFe23xmrJ0-qbWWa6+vKGb+QdDFV8VSLkmWdAnfsFtzw@mail.gmail.com>
X-Gm-Features: Ac12FXzUtyaVLj7tKhzc2QjlgMNdUTCkm86hTg8iZ2lfMiulh_fOCFYDlXtaIQQ
Message-ID: <CANiDSCvFe23xmrJ0-qbWWa6+vKGb+QdDFV8VSLkmWdAnfsFtzw@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] media: uvcvideo: Add get_* functions to uvc_entity
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

Hi Laurent

On Mon, 14 Jul 2025 at 16:30, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Tue, Jul 01, 2025 at 01:13:10PM +0200, Ricardo Ribalda wrote:
> > On Sun, 29 Jun 2025 at 20:13, Laurent Pinchart wrote:
> > > On Thu, Jun 05, 2025 at 05:53:03PM +0000, Ricardo Ribalda wrote:
> > > > Virtual entities need to provide more values than get_cur and get_cur
> > >
> > > I think you meant "get_info and get_cur".
> > >
> > > > for their controls. Add support for get_def, get_min, get_max and
> > > > get_res.
> > >
> > > Do they ? The UVC specification defines controls that don't list
> > > GET_DEF, GET_MIN, GET_MAX and GET_RES as mandatory requests. Can't we do
> > > the same for the software controls ? This patch is meant to support the
> > > UVC_SWENTITY_ORIENTATION and UVC_SWENTITY_ROTATION control in the next
> > > patch, and those are read-only controls. Aren't GET_INFO and GET_CUR
> > > enough ?
> >
> > V4L2_CID_CAMERA_ROTATION has the type UVC_CTRL_DATA_TYPE_UNSIGNED,
> > that time requires get_min and get_max.
>
> Where does that requirement come from ? Is it because how the
> corresponding V4L2 type (V4L2_CTRL_TYPE_INTEGER) is handled in
> uvc_ctrl_clamp() ? uvc_ctrl_clamp() is only called when setting a
> control, from uvc_ctrl_set(), and V4L2_CID_CAMERA_ROTATION should be
> read-only.

It its for VIDIOC_QUERY_EXT_CTRL

uvc_query_v4l2_ctrl -> __uvc_query_v4l2_ctrl -> __uvc_queryctrl_boundaries

We need to list the min, max, def and step for every control. They are
fetched with uvc_ctrl_populate_cache()



>
> > We can create a new type UVC_CTRL_DATA_TYPE_UNSIGNED_READ_ONLY that
> > fakes min, max and res, but I think that it is cleaner this approach.
> >
> > > > This is a preparation patch.
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_ctrl.c | 12 ++++++++++++
> > > >  drivers/media/usb/uvc/uvcvideo.h |  8 ++++++++
> > > >  2 files changed, 20 insertions(+)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > index 21ec7b978bc7aca21db7cb8fd5d135d876f3330c..59be62ae24a4219fa9d7aacf2ae7382c95362178 100644
> > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > @@ -596,6 +596,18 @@ static int uvc_ctrl_query_entity(struct uvc_device *dev,
> > > >       if (query == UVC_GET_CUR && ctrl->entity->get_cur)
> > > >               return ctrl->entity->get_cur(dev, ctrl->entity,
> > > >                                            ctrl->info.selector, data, len);
> > > > +     if (query == UVC_GET_DEF && ctrl->entity->get_def)
> > > > +             return ctrl->entity->get_def(dev, ctrl->entity,
> > > > +                                          ctrl->info.selector, data, len);
> > > > +     if (query == UVC_GET_MIN && ctrl->entity->get_min)
> > > > +             return ctrl->entity->get_min(dev, ctrl->entity,
> > > > +                                          ctrl->info.selector, data, len);
> > > > +     if (query == UVC_GET_MAX && ctrl->entity->get_max)
> > > > +             return ctrl->entity->get_max(dev, ctrl->entity,
> > > > +                                          ctrl->info.selector, data, len);
> > > > +     if (query == UVC_GET_RES && ctrl->entity->get_res)
> > > > +             return ctrl->entity->get_res(dev, ctrl->entity,
> > > > +                                          ctrl->info.selector, data, len);
> > > >       if (query == UVC_GET_INFO && ctrl->entity->get_info)
> > > >               return ctrl->entity->get_info(dev, ctrl->entity,
> > > >                                             ctrl->info.selector, data);
> > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > index a931750bdea25b9062dcc7644bf5f2ed89c1cb4c..d6da8ed3ad4cf3377df49923e051fe04d83d2e38 100644
> > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > @@ -261,6 +261,14 @@ struct uvc_entity {
> > > >                       u8 cs, u8 *caps);
> > > >       int (*get_cur)(struct uvc_device *dev, struct uvc_entity *entity,
> > > >                      u8 cs, void *data, u16 size);
> > > > +     int (*get_def)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > +                    u8 cs, void *data, u16 size);
> > > > +     int (*get_min)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > +                    u8 cs, void *data, u16 size);
> > > > +     int (*get_max)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > +                    u8 cs, void *data, u16 size);
> > > > +     int (*get_res)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > +                    u8 cs, void *data, u16 size);
> > > >
> > > >       unsigned int ncontrols;
> > > >       struct uvc_control *controls;
>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda

