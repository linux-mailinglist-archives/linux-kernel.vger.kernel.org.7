Return-Path: <linux-kernel+bounces-758747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CDBB1D36A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBF21677A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2997523C4FD;
	Thu,  7 Aug 2025 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aF3RpP1g"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176451A8F97
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552134; cv=none; b=Dcne5TDt11I/VIjkUl6wuN3Ixw2vot88VWdFTL3gIq9kn+xG33X8iQOXNWDTyo009umgFv5yD9gg8u48dMfcQOPd4gURKLmGMCHPmfOtcxyg8A18+2jW0dnMc3bHXyrAXKtDM2Z/scKbEqOCSVYT63eKHSH3CWs00oJrq8n/9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552134; c=relaxed/simple;
	bh=FiZl7dBM01nTpHTio21jd/nJKd4QC3gAoTSrHH1QJgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doDYqFdxVX4GuhR9mhbVwBRyv87Hibf+UxveoK63XsQ0TA6+mgcGMJZEHpzmqV3a3Bku0zWOop0kijAHwZQHLH5nPKdKPGhHToWTXuCABplsZ4GsFPXl6uooYGR4I9OwVpLSG/OH6I/bmcB4pWXqhQwGMDZ8rMuGDKeh+J36q8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aF3RpP1g; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55b96b154bdso711252e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754552130; x=1755156930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vRngVDSFiad8P3vLgxpfrf7smMW2bm5yBF8353hqHug=;
        b=aF3RpP1g1MaD4sYbQdO0JRXJiD8HsnFu8L+dip3QYZx1AnrUkml2FHM+hSEOI+qGTl
         HQkSF7kFeH7ZMf2kwdxVvqDQNGPSYzfq8ZsJQEkM4vJ+0eiD3OFVBkqZI5QY+AQrqXAZ
         BMlJgDAkavoWeQazXpxHqCrIefQnKJR0CurtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754552130; x=1755156930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRngVDSFiad8P3vLgxpfrf7smMW2bm5yBF8353hqHug=;
        b=ZG6DDpww+C+Pj3icV+uRWFVpE2ZLosJVT/Oua6lh7bTYdir+ZwJsZftwb5yCndZYvm
         8CqL69Tjo0HuneDAG2mGlXBubRkZrnDAI0qvAZKwP5Km7btrZzzwAX2JkGmz6EZrW+dC
         wciN7MdCNbVPI0Q39Sq7n3p4gnXu2LK/6rgzCUeiY5ZpegNVJWOtO0vv4957JmatHy3g
         U4J/dCE6MTp2Jkqh75YR1SxTZiFY/z06+zfBpVH3KUQGCtQzumSa7OwtBCsG4MAPF9qv
         G3L3gm5RQTxfGmWjKemkcH2/KWC3BLBZjmuZllrMb7lqrVlH3YH6pKQOBmiWjNsR5k8X
         5KAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwkpstRyY1yW/LRFCT/t0zBCpGIk3/43XuGXZ+3dsrWJg5pNUqGcX8zbA0MCw4KFjvMdtgQMU8zAOu9bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdVqVcsS+ZY044p9x1ByQEnhJqN58pZMDmq4ntwLQ2uz4DTQdH
	nk/eBIeQQrPbt5PXu7sAh1/N/pw6PPlAthSFZrWl3nUvZcrOB8Ds7nlqArF+SavxCe4FaJCfHeI
	X68Q=
X-Gm-Gg: ASbGncs6qmKtoOEAYT7DKNg+tkOlAiwlsYDvw45124wclCDZN9+vtL/XFq8y0auQX8x
	VrUvj1+6tfaE9Av9II2hMFdjC5vr8bZWP5ADeqBhPDXRAwzxJDAvWAIkpb/A+h7Tv6jS3xKxEj8
	gnVKUpzSEEkLWB3sITXG4Z9d0IY0xmkQh14yuGnPRgNXREPX8XkoYq9Jdel7KbxlMAixzR4kh/t
	udoYY4Qa+TjttcLBRWLidKDdAXs3cnCW4gbW6n0lt9hyH5QJV6pkM/K0MUHE+UIVuePaAO27Dfm
	VesGS4HPNJCqbPMyY36t8GQ98QBuF9xmWcOwUGsF45odXSezxJ1HM9YgJd6mWIYSPXbrnJJjwCU
	bj8Sr93kOB9s/wWvtN/rgdPHluDMdZgnAOlXqas9l4+ebrZ3NtyJQRtGZ3CeJVw8F
X-Google-Smtp-Source: AGHT+IHzafbVylW+HIWwdEXEVD6a6TqsqWfRmCKs/g4RNbJeD+DMDZtAxFJ1GNNBjleid0PRn/MyHg==
X-Received: by 2002:ac2:4c4c:0:b0:553:35e6:393b with SMTP id 2adb3069b0e04-55caf3e11d5mr2047856e87.45.1754552129967;
        Thu, 07 Aug 2025 00:35:29 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c98ad9sm2540305e87.78.2025.08.07.00.35.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 00:35:28 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32ce1b2188dso6584391fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:35:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5EWifWughSLuvk5OGrWK3f8fDOsTyheh/06xRQMs6RrGqy9B+jjOZvjYqC2bXmV9CzcNs4KB7fO+QL6I=@vger.kernel.org
X-Received: by 2002:a2e:b54b:0:b0:332:2a32:2856 with SMTP id
 38308e7fff4ca-333813c4660mr13208821fa.29.1754552127402; Thu, 07 Aug 2025
 00:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-10-5710f9d030aa@chromium.org>
 <20250629181246.GE6260@pendragon.ideasonboard.com> <CANiDSCsu0RT4dcGyBJRutP=9HTe+niUoohxTZE=qJ8O_9ez=+A@mail.gmail.com>
 <20250714142926.GI8243@pendragon.ideasonboard.com> <CANiDSCvFe23xmrJ0-qbWWa6+vKGb+QdDFV8VSLkmWdAnfsFtzw@mail.gmail.com>
 <20250715193505.GB19299@pendragon.ideasonboard.com> <CANiDSCtvt6qnROQ0_-0iG5hqkU_uHZABujZPN7xuh7pUASSGyw@mail.gmail.com>
In-Reply-To: <CANiDSCtvt6qnROQ0_-0iG5hqkU_uHZABujZPN7xuh7pUASSGyw@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 7 Aug 2025 09:35:14 +0200
X-Gmail-Original-Message-ID: <CANiDSCsNjBEWR5HA9bhFNnXB7Cazj7o0wBnn53gzpoBBcYFkFw@mail.gmail.com>
X-Gm-Features: Ac12FXyjct6ihC0OshwY5F1qdouFOZPK3DFRcqPyUc52eVa5roZ1nWwW2xk9ZpI
Message-ID: <CANiDSCsNjBEWR5HA9bhFNnXB7Cazj7o0wBnn53gzpoBBcYFkFw@mail.gmail.com>
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

On Wed, 16 Jul 2025 at 12:32, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> On Tue, 15 Jul 2025 at 21:35, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > On Mon, Jul 14, 2025 at 05:46:40PM +0200, Ricardo Ribalda wrote:
> > > On Mon, 14 Jul 2025 at 16:30, Laurent Pinchart wrote:
> > > > On Tue, Jul 01, 2025 at 01:13:10PM +0200, Ricardo Ribalda wrote:
> > > > > On Sun, 29 Jun 2025 at 20:13, Laurent Pinchart wrote:
> > > > > > On Thu, Jun 05, 2025 at 05:53:03PM +0000, Ricardo Ribalda wrote:
> > > > > > > Virtual entities need to provide more values than get_cur and get_cur
> > > > > >
> > > > > > I think you meant "get_info and get_cur".
> > > > > >
> > > > > > > for their controls. Add support for get_def, get_min, get_max and
> > > > > > > get_res.
> > > > > >
> > > > > > Do they ? The UVC specification defines controls that don't list
> > > > > > GET_DEF, GET_MIN, GET_MAX and GET_RES as mandatory requests. Can't we do
> > > > > > the same for the software controls ? This patch is meant to support the
> > > > > > UVC_SWENTITY_ORIENTATION and UVC_SWENTITY_ROTATION control in the next
> > > > > > patch, and those are read-only controls. Aren't GET_INFO and GET_CUR
> > > > > > enough ?
> > > > >
> > > > > V4L2_CID_CAMERA_ROTATION has the type UVC_CTRL_DATA_TYPE_UNSIGNED,
> > > > > that time requires get_min and get_max.
> > > >
> > > > Where does that requirement come from ? Is it because how the
> > > > corresponding V4L2 type (V4L2_CTRL_TYPE_INTEGER) is handled in
> > > > uvc_ctrl_clamp() ? uvc_ctrl_clamp() is only called when setting a
> > > > control, from uvc_ctrl_set(), and V4L2_CID_CAMERA_ROTATION should be
> > > > read-only.
> > >
> > > It its for VIDIOC_QUERY_EXT_CTRL
> > >
> > > uvc_query_v4l2_ctrl -> __uvc_query_v4l2_ctrl -> __uvc_queryctrl_boundaries
> > >
> > > We need to list the min, max, def and step for every control. They are
> > > fetched with uvc_ctrl_populate_cache()
> >
> > Ah, I see, thanks.
> >
> > For GET_RES, I think we can leave it unimplemented.
> > __uvc_queryctrl_boundaries() will set v4l2_ctrl->step = 0 which seems to
> > be the right behaviour for a read-only control whose value never
> > changes.
>
> That will break v4l2-compatiblity. Step needs to be != 0
> https://git.linuxtv.org/v4l-utils.git/tree/utils/v4l2-compliance/v4l2-test-controls.cpp#n77
>
> Control ioctls (Input 0):
>                 fail: v4l2-test-controls.cpp(77): step == 0
>                 fail: v4l2-test-controls.cpp(201): invalid control 009a0923
>
> >
> > As for the minimum and maximum, they are currently set to 0 if the
> > corresponding operations are not supported. I wonder if we should set
> > them to the current value instead for read-only controls (as in controls
> > whose flags report support for GET_CUR only)..
>
> I am not sure that I like that approach IMO the code looks worse...
> but if you prefer that, we can go that way

I am almost ready to send a new version.

What approach do you prefer?

Regards!

>
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index ec472e111248..47224437018b 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -35,6 +35,8 @@
>  /* ------------------------------------------------------------------------
>   * Controls
>   */
> +static int __uvc_ctrl_load_cur(struct uvc_video_chain *chain,
> +                              struct uvc_control *ctrl);
>
>  static const struct uvc_control_info uvc_ctrls[] = {
>         {
> @@ -1272,6 +1274,13 @@ static int uvc_ctrl_populate_cache(struct
> uvc_video_chain *chain,
>                                         uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
>                 if (ret < 0)
>                         return ret;
> +       } else if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR)) {
> +               ret = __uvc_ctrl_load_cur(chain, ctrl);
> +               if (!ret) {
> +                       memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF),
> +                              uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
> +                              ctrl->info.size);
> +               }
>         }
>
>         if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN) {
> @@ -1279,14 +1288,31 @@ static int uvc_ctrl_populate_cache(struct
> uvc_video_chain *chain,
>                                         uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
>                 if (ret < 0)
>                         return ret;
> +       } else if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR)) {
> +               ret = __uvc_ctrl_load_cur(chain, ctrl);
> +               if (!ret) {
> +                       memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN),
> +                              uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
> +                              ctrl->info.size);
> +               }
>         }
> +
>         if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX) {
>                 ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_MAX,
>                                         uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
>                 if (ret < 0)
>                         return ret;
> +       } else if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR)) {
> +               ret = __uvc_ctrl_load_cur(chain, ctrl);
> +               if (!ret) {
> +                       memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX),
> +                              uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
> +                              ctrl->info.size);
> +               }
>         }
> +
>         if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES) {
> +               u8 *res;
>                 ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_RES,
>                                         uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
>                 if (ret < 0) {
> @@ -1304,7 +1330,13 @@ static int uvc_ctrl_populate_cache(struct
> uvc_video_chain *chain,
>                                       "an XU control. Enabling workaround.\n");
>                         memset(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES), 0,
>                                ctrl->info.size);
> +                       res = uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES);
> +                       *res = 1
>                 }
> +       } else {
> +               memset(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES), 0,
> ctrl->info.size);
> +               res = uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES);
> +               *res = 1;
>         }
>
>         ctrl->cached = 1;
> @@ -1541,11 +1573,8 @@ static int __uvc_queryctrl_boundaries(struct
> uvc_video_chain *chain,
>                         return ret;
>         }
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF)
>                 v4l2_ctrl->default_value = uvc_mapping_get_s32(mapping,
>                                 UVC_GET_DEF, uvc_ctrl_data(ctrl,
> UVC_CTRL_DATA_DEF));
> -       else
> -               v4l2_ctrl->default_value = 0;
>
>         switch (mapping->v4l2_type) {
>         case V4L2_CTRL_TYPE_MENU:
> @@ -1576,23 +1605,14 @@ static int __uvc_queryctrl_boundaries(struct
> uvc_video_chain *chain,
>                 break;
>         }
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)
> -               v4l2_ctrl->minimum = uvc_mapping_get_s32(mapping, UVC_GET_MIN,
> -                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
> -       else
> -               v4l2_ctrl->minimum = 0;
> +       v4l2_ctrl->minimum = uvc_mapping_get_s32(mapping, UVC_GET_MIN,
> +                                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
> -               v4l2_ctrl->maximum = uvc_mapping_get_s32(mapping, UVC_GET_MAX,
> -                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> -       else
> -               v4l2_ctrl->maximum = 0;
> +       v4l2_ctrl->maximum = uvc_mapping_get_s32(mapping, UVC_GET_MAX,
> +                                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
> -               v4l2_ctrl->step = uvc_mapping_get_s32(mapping, UVC_GET_RES,
> -                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
> -       else
> -               v4l2_ctrl->step = 0;
> +       v4l2_ctrl->step = uvc_mapping_get_s32(mapping, UVC_GET_RES,
> +                                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
>
>         return 0;
>  }
>
> >
> > > > > We can create a new type UVC_CTRL_DATA_TYPE_UNSIGNED_READ_ONLY that
> > > > > fakes min, max and res, but I think that it is cleaner this approach.
> > > > >
> > > > > > > This is a preparation patch.
> > > > > > >
> > > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > > ---
> > > > > > >  drivers/media/usb/uvc/uvc_ctrl.c | 12 ++++++++++++
> > > > > > >  drivers/media/usb/uvc/uvcvideo.h |  8 ++++++++
> > > > > > >  2 files changed, 20 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > > > > index 21ec7b978bc7aca21db7cb8fd5d135d876f3330c..59be62ae24a4219fa9d7aacf2ae7382c95362178 100644
> > > > > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > > > > @@ -596,6 +596,18 @@ static int uvc_ctrl_query_entity(struct uvc_device *dev,
> > > > > > >       if (query == UVC_GET_CUR && ctrl->entity->get_cur)
> > > > > > >               return ctrl->entity->get_cur(dev, ctrl->entity,
> > > > > > >                                            ctrl->info.selector, data, len);
> > > > > > > +     if (query == UVC_GET_DEF && ctrl->entity->get_def)
> > > > > > > +             return ctrl->entity->get_def(dev, ctrl->entity,
> > > > > > > +                                          ctrl->info.selector, data, len);
> > > > > > > +     if (query == UVC_GET_MIN && ctrl->entity->get_min)
> > > > > > > +             return ctrl->entity->get_min(dev, ctrl->entity,
> > > > > > > +                                          ctrl->info.selector, data, len);
> > > > > > > +     if (query == UVC_GET_MAX && ctrl->entity->get_max)
> > > > > > > +             return ctrl->entity->get_max(dev, ctrl->entity,
> > > > > > > +                                          ctrl->info.selector, data, len);
> > > > > > > +     if (query == UVC_GET_RES && ctrl->entity->get_res)
> > > > > > > +             return ctrl->entity->get_res(dev, ctrl->entity,
> > > > > > > +                                          ctrl->info.selector, data, len);
> > > > > > >       if (query == UVC_GET_INFO && ctrl->entity->get_info)
> > > > > > >               return ctrl->entity->get_info(dev, ctrl->entity,
> > > > > > >                                             ctrl->info.selector, data);
> > > > > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > > > > index a931750bdea25b9062dcc7644bf5f2ed89c1cb4c..d6da8ed3ad4cf3377df49923e051fe04d83d2e38 100644
> > > > > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > > > > @@ -261,6 +261,14 @@ struct uvc_entity {
> > > > > > >                       u8 cs, u8 *caps);
> > > > > > >       int (*get_cur)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > >                      u8 cs, void *data, u16 size);
> > > > > > > +     int (*get_def)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > > +                    u8 cs, void *data, u16 size);
> > > > > > > +     int (*get_min)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > > +                    u8 cs, void *data, u16 size);
> > > > > > > +     int (*get_max)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > > +                    u8 cs, void *data, u16 size);
> > > > > > > +     int (*get_res)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > > +                    u8 cs, void *data, u16 size);
> > > > > > >
> > > > > > >       unsigned int ncontrols;
> > > > > > >       struct uvc_control *controls;
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
>
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda

