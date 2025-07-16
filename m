Return-Path: <linux-kernel+bounces-733353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6DCB0737F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C9D58306F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D066194A60;
	Wed, 16 Jul 2025 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ohTjKJBW"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C52E6D11
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661952; cv=none; b=jj+fEjNAWeTDqdfBZXEfiobUo/yhKOZfpteTIP4j4YMhGINsUPgMPAiBEH2zABYmA9QQWTYQqLJQbVtUFR5bQfQa+/v7p0Qo+XdlVdIypcy+0PlS95K9fsm66n2Oqy8k5BjWm6fmKtqzu4CHuLxFs0sjlZROMiEoTfrzi7RnI4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661952; c=relaxed/simple;
	bh=lQBsia0sYbc3ZhTi0JAkaaWjrbsoT4HfjHir1/c3JVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEwl4GivF/HlcOQjiK6OvYGuL+SlwGWdS15nx1yup5K867Gmw4Sm8YjNBiZrT5z360aDgzenqQAbnkpbV2/y3I6JVqypCRNdi/D0m6mFNDATOitEUmHenGFmSWdXQ8L0xRsHcnCHLQ7s2YVWEw9qjsZrOXowErLBrCjTZ6nzT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ohTjKJBW; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55a25635385so378542e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752661948; x=1753266748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XO0Fx40qXcc6y2Q85UzZUUK6JgaXB0+V8kATrQASoZ0=;
        b=ohTjKJBW3AltsPPHsAeRt3wYfQ0SvmYSH9B9KObdZuLXdnMD0Q0GzOfR2qWVzRfiiN
         JXTmDBu28J78MwoGrlPM4LuII0r/gkW/Q9yPu9a6Z9VwjoPV2kxNTrgF2fEPHUtwnnYj
         mpbBDfhxxoSabA9HQI6bc5xeglXFjBFTOZnBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752661948; x=1753266748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XO0Fx40qXcc6y2Q85UzZUUK6JgaXB0+V8kATrQASoZ0=;
        b=EUtfnndyx/GaBnzT3iNXz+h7DMHUgSPh+eyJmEXmIMXB6Lw1gLxoToFk7jhaiqmrp5
         BZFm4Yu/IE8ts3M0/SmEAMq/Iy8ucYzhsbKaSpxnwzyBa91yLLleETIRkREBD5sETN9F
         GIAAhzPmQEBee+2eh7QW9RftBvClt/mjKpm8+h6bML9zP5UXGdsxbUhN8Q6VvXtXOh59
         s3wQWW4Z3x/8NhgSkUspkmM33llPmBuChHtzleWgbiPDXJYhHDVUMkjZvJ7z+F6+LdfY
         V7tYYSNAQ+YPU056zNSV0iQcKyBYOeUVzdBMPd8GHY9WJMVKyEhpS/H/7CfyKUGL7GWj
         2kWA==
X-Forwarded-Encrypted: i=1; AJvYcCWgzaOxY5GJ+mV57elYMjru3K/CLhOdfgfnwYf/hzbKxO3me+bBY6yb5bjTRc5RV8FvFWTDLJdk0vNDvOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMGxCWNgYKXMqh7TDqQqifO3YV40+qphSFmjiyNMK0i3GqqE/x
	EfB0eSnOCakGnxrA/kVrWR09GC+i3n7Vyh2+9SwIVJq5g0HNqSq150hU+dmEcYAsUHvq28hfqtH
	mfkY=
X-Gm-Gg: ASbGncvKAKP6P7nWJvrQ0st/LrctWLqjDIJuhN7RhQ6lqNi/27AOl0qX/CNFdgvZ3ba
	pLOqA7C2vikKxErOnMy8QHVdriI/rNP8DoJI6UiN5mF3/ZqPlDYx6CIC0gc3mPajzE6wbQfQiG9
	BdL1GbULVBOXMqDGhdzG2ef8XXwWmtLLyQJeNw2qArxsYijU+QR0lNQNnBI+fnMbPNh0qAevqZ5
	MOXmkeva8qxVnmNpa3bTS4zOs+VR9u9zE2Yyc77+gHbgHLZlPRuU2S2flPalNCOOO5evmwGZlgk
	Mx5uaV48rhLzo+Gd0NW2UszpCgk+gQhHnKl87T9IB1Pd25lpcbD6Km97uaswY5n9OZkgdxcJOt+
	qwthF6eCAMjfAPZ090FFAWwmsTwkcNIpVQWGfaXO7Aa3Ov+Ax2dp/H33l73Ho
X-Google-Smtp-Source: AGHT+IHIE/twS9K4IkWOEV3M8fbkwKrec5y4ECNZrVXYkAuzaUBffX+l+f8JnDfwmhNj8vddocYuYQ==
X-Received: by 2002:a05:6512:1190:b0:553:24b7:2f61 with SMTP id 2adb3069b0e04-55a233f81bfmr887990e87.57.1752661947768;
        Wed, 16 Jul 2025 03:32:27 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab917602sm19280391fa.104.2025.07.16.03.32.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:32:26 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5551a770828so6573181e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:32:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkR8NbiZpJMjs11/IQHLayT3HuUKjnUqZ+IMUOEvYXvR8oxTC8fXj4OU8SmT/IFGaAxBy5mcr7wjwK55w=@vger.kernel.org
X-Received: by 2002:a05:651c:20cc:20b0:32b:7123:ec4c with SMTP id
 38308e7fff4ca-3308e534766mr5343651fa.38.1752661944634; Wed, 16 Jul 2025
 03:32:24 -0700 (PDT)
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
 <20250715193505.GB19299@pendragon.ideasonboard.com>
In-Reply-To: <20250715193505.GB19299@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 16 Jul 2025 12:32:12 +0200
X-Gmail-Original-Message-ID: <CANiDSCtvt6qnROQ0_-0iG5hqkU_uHZABujZPN7xuh7pUASSGyw@mail.gmail.com>
X-Gm-Features: Ac12FXxTxa1OMnAHd5xkxGC40dZgahlVF2ufC7vQULE72HOrmtGjhNO81HxFS-Q
Message-ID: <CANiDSCtvt6qnROQ0_-0iG5hqkU_uHZABujZPN7xuh7pUASSGyw@mail.gmail.com>
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

On Tue, 15 Jul 2025 at 21:35, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Jul 14, 2025 at 05:46:40PM +0200, Ricardo Ribalda wrote:
> > On Mon, 14 Jul 2025 at 16:30, Laurent Pinchart wrote:
> > > On Tue, Jul 01, 2025 at 01:13:10PM +0200, Ricardo Ribalda wrote:
> > > > On Sun, 29 Jun 2025 at 20:13, Laurent Pinchart wrote:
> > > > > On Thu, Jun 05, 2025 at 05:53:03PM +0000, Ricardo Ribalda wrote:
> > > > > > Virtual entities need to provide more values than get_cur and get_cur
> > > > >
> > > > > I think you meant "get_info and get_cur".
> > > > >
> > > > > > for their controls. Add support for get_def, get_min, get_max and
> > > > > > get_res.
> > > > >
> > > > > Do they ? The UVC specification defines controls that don't list
> > > > > GET_DEF, GET_MIN, GET_MAX and GET_RES as mandatory requests. Can't we do
> > > > > the same for the software controls ? This patch is meant to support the
> > > > > UVC_SWENTITY_ORIENTATION and UVC_SWENTITY_ROTATION control in the next
> > > > > patch, and those are read-only controls. Aren't GET_INFO and GET_CUR
> > > > > enough ?
> > > >
> > > > V4L2_CID_CAMERA_ROTATION has the type UVC_CTRL_DATA_TYPE_UNSIGNED,
> > > > that time requires get_min and get_max.
> > >
> > > Where does that requirement come from ? Is it because how the
> > > corresponding V4L2 type (V4L2_CTRL_TYPE_INTEGER) is handled in
> > > uvc_ctrl_clamp() ? uvc_ctrl_clamp() is only called when setting a
> > > control, from uvc_ctrl_set(), and V4L2_CID_CAMERA_ROTATION should be
> > > read-only.
> >
> > It its for VIDIOC_QUERY_EXT_CTRL
> >
> > uvc_query_v4l2_ctrl -> __uvc_query_v4l2_ctrl -> __uvc_queryctrl_boundaries
> >
> > We need to list the min, max, def and step for every control. They are
> > fetched with uvc_ctrl_populate_cache()
>
> Ah, I see, thanks.
>
> For GET_RES, I think we can leave it unimplemented.
> __uvc_queryctrl_boundaries() will set v4l2_ctrl->step = 0 which seems to
> be the right behaviour for a read-only control whose value never
> changes.

That will break v4l2-compatiblity. Step needs to be != 0
https://git.linuxtv.org/v4l-utils.git/tree/utils/v4l2-compliance/v4l2-test-controls.cpp#n77

Control ioctls (Input 0):
                fail: v4l2-test-controls.cpp(77): step == 0
                fail: v4l2-test-controls.cpp(201): invalid control 009a0923

>
> As for the minimum and maximum, they are currently set to 0 if the
> corresponding operations are not supported. I wonder if we should set
> them to the current value instead for read-only controls (as in controls
> whose flags report support for GET_CUR only)..

I am not sure that I like that approach IMO the code looks worse...
but if you prefer that, we can go that way


diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index ec472e111248..47224437018b 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -35,6 +35,8 @@
 /* ------------------------------------------------------------------------
  * Controls
  */
+static int __uvc_ctrl_load_cur(struct uvc_video_chain *chain,
+                              struct uvc_control *ctrl);

 static const struct uvc_control_info uvc_ctrls[] = {
        {
@@ -1272,6 +1274,13 @@ static int uvc_ctrl_populate_cache(struct
uvc_video_chain *chain,
                                        uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
                if (ret < 0)
                        return ret;
+       } else if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR)) {
+               ret = __uvc_ctrl_load_cur(chain, ctrl);
+               if (!ret) {
+                       memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF),
+                              uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
+                              ctrl->info.size);
+               }
        }

        if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN) {
@@ -1279,14 +1288,31 @@ static int uvc_ctrl_populate_cache(struct
uvc_video_chain *chain,
                                        uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
                if (ret < 0)
                        return ret;
+       } else if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR)) {
+               ret = __uvc_ctrl_load_cur(chain, ctrl);
+               if (!ret) {
+                       memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN),
+                              uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
+                              ctrl->info.size);
+               }
        }
+
        if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX) {
                ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_MAX,
                                        uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
                if (ret < 0)
                        return ret;
+       } else if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR)) {
+               ret = __uvc_ctrl_load_cur(chain, ctrl);
+               if (!ret) {
+                       memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX),
+                              uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
+                              ctrl->info.size);
+               }
        }
+
        if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES) {
+               u8 *res;
                ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_RES,
                                        uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
                if (ret < 0) {
@@ -1304,7 +1330,13 @@ static int uvc_ctrl_populate_cache(struct
uvc_video_chain *chain,
                                      "an XU control. Enabling workaround.\n");
                        memset(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES), 0,
                               ctrl->info.size);
+                       res = uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES);
+                       *res = 1
                }
+       } else {
+               memset(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES), 0,
ctrl->info.size);
+               res = uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES);
+               *res = 1;
        }

        ctrl->cached = 1;
@@ -1541,11 +1573,8 @@ static int __uvc_queryctrl_boundaries(struct
uvc_video_chain *chain,
                        return ret;
        }

-       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF)
                v4l2_ctrl->default_value = uvc_mapping_get_s32(mapping,
                                UVC_GET_DEF, uvc_ctrl_data(ctrl,
UVC_CTRL_DATA_DEF));
-       else
-               v4l2_ctrl->default_value = 0;

        switch (mapping->v4l2_type) {
        case V4L2_CTRL_TYPE_MENU:
@@ -1576,23 +1605,14 @@ static int __uvc_queryctrl_boundaries(struct
uvc_video_chain *chain,
                break;
        }

-       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)
-               v4l2_ctrl->minimum = uvc_mapping_get_s32(mapping, UVC_GET_MIN,
-                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
-       else
-               v4l2_ctrl->minimum = 0;
+       v4l2_ctrl->minimum = uvc_mapping_get_s32(mapping, UVC_GET_MIN,
+                                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));

-       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
-               v4l2_ctrl->maximum = uvc_mapping_get_s32(mapping, UVC_GET_MAX,
-                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
-       else
-               v4l2_ctrl->maximum = 0;
+       v4l2_ctrl->maximum = uvc_mapping_get_s32(mapping, UVC_GET_MAX,
+                                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));

-       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
-               v4l2_ctrl->step = uvc_mapping_get_s32(mapping, UVC_GET_RES,
-                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
-       else
-               v4l2_ctrl->step = 0;
+       v4l2_ctrl->step = uvc_mapping_get_s32(mapping, UVC_GET_RES,
+                                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));

        return 0;
 }

>
> > > > We can create a new type UVC_CTRL_DATA_TYPE_UNSIGNED_READ_ONLY that
> > > > fakes min, max and res, but I think that it is cleaner this approach.
> > > >
> > > > > > This is a preparation patch.
> > > > > >
> > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > ---
> > > > > >  drivers/media/usb/uvc/uvc_ctrl.c | 12 ++++++++++++
> > > > > >  drivers/media/usb/uvc/uvcvideo.h |  8 ++++++++
> > > > > >  2 files changed, 20 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > > > index 21ec7b978bc7aca21db7cb8fd5d135d876f3330c..59be62ae24a4219fa9d7aacf2ae7382c95362178 100644
> > > > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > > > @@ -596,6 +596,18 @@ static int uvc_ctrl_query_entity(struct uvc_device *dev,
> > > > > >       if (query == UVC_GET_CUR && ctrl->entity->get_cur)
> > > > > >               return ctrl->entity->get_cur(dev, ctrl->entity,
> > > > > >                                            ctrl->info.selector, data, len);
> > > > > > +     if (query == UVC_GET_DEF && ctrl->entity->get_def)
> > > > > > +             return ctrl->entity->get_def(dev, ctrl->entity,
> > > > > > +                                          ctrl->info.selector, data, len);
> > > > > > +     if (query == UVC_GET_MIN && ctrl->entity->get_min)
> > > > > > +             return ctrl->entity->get_min(dev, ctrl->entity,
> > > > > > +                                          ctrl->info.selector, data, len);
> > > > > > +     if (query == UVC_GET_MAX && ctrl->entity->get_max)
> > > > > > +             return ctrl->entity->get_max(dev, ctrl->entity,
> > > > > > +                                          ctrl->info.selector, data, len);
> > > > > > +     if (query == UVC_GET_RES && ctrl->entity->get_res)
> > > > > > +             return ctrl->entity->get_res(dev, ctrl->entity,
> > > > > > +                                          ctrl->info.selector, data, len);
> > > > > >       if (query == UVC_GET_INFO && ctrl->entity->get_info)
> > > > > >               return ctrl->entity->get_info(dev, ctrl->entity,
> > > > > >                                             ctrl->info.selector, data);
> > > > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > > > index a931750bdea25b9062dcc7644bf5f2ed89c1cb4c..d6da8ed3ad4cf3377df49923e051fe04d83d2e38 100644
> > > > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > > > @@ -261,6 +261,14 @@ struct uvc_entity {
> > > > > >                       u8 cs, u8 *caps);
> > > > > >       int (*get_cur)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > >                      u8 cs, void *data, u16 size);
> > > > > > +     int (*get_def)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > +                    u8 cs, void *data, u16 size);
> > > > > > +     int (*get_min)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > +                    u8 cs, void *data, u16 size);
> > > > > > +     int (*get_max)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > +                    u8 cs, void *data, u16 size);
> > > > > > +     int (*get_res)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > +                    u8 cs, void *data, u16 size);
> > > > > >
> > > > > >       unsigned int ncontrols;
> > > > > >       struct uvc_control *controls;
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

