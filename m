Return-Path: <linux-kernel+bounces-730451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C23B044B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A2C77A8898
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B39D25C82E;
	Mon, 14 Jul 2025 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H6UkCAIX"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7CE19F43A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508285; cv=none; b=ScqDGJblS++QWLyIdiNZo4DsgdreM2ROG/BTbksdzUdM9lriWgQ3RudMi51NF3RKgGNJ92JeX6DNZyUyS7zSAdksoQ9NlCUx+gFJWsCz/OcEl/IPxep1g9zJTjFEctMN6P4RADd5fnXrH5gk+e/PsRW0P62ZP8GT5Z67gs7sdNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508285; c=relaxed/simple;
	bh=BUEqJYqut2iTVt5+5KMeLcGgtNQULwQgbWxEHQyKu2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h//QA96zPzg7V3pyKizTL+3RSEaP6OSRCqHcOgrmP0dv4x5VRWq4mXAd6qDagMf2XajSZfeXWXMZ3+wpKx5os3l2ODE3wORZDCkp28gb9lmLCShRNv3oz1fRgab1JBXdrp/nRNlfWv21qj7qDLySm3G6JC3f4YaFNxq3DQn6Jh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H6UkCAIX; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b78b5aa39so39120401fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752508282; x=1753113082; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JOUTiRTHZw62UnMALOtaZI8EYRouFJiKeX0szARAd/k=;
        b=H6UkCAIXSiJsS9GmmzC5D8lHSKne++9vb90OG5/s44ImLwOZtetCDfkJGy6dbheKuc
         yI5X4far3Yj25koh0ur89EPYnWVJAp/21MIr1E8FT+kafjugL+p7pHKSjBomAJzQNjRt
         nP7j71g9UO4JBSB4f61FFnXp/bzAm+tDw5uu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752508282; x=1753113082;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOUTiRTHZw62UnMALOtaZI8EYRouFJiKeX0szARAd/k=;
        b=P0Hkko7V5T/qPFx6ZZAB56EaekWJZFmYnaic4Vbwo6T62h3HrcorDq/lkxibc5avJE
         u8gKXWM87BbuTzdGkZhRz5eQt8Q5c1x6HmpWmFf+Q1iBKs4ZvJMTbmWZThRmCu94medk
         NcM8xSViSVds88WJlr1hlSPFabY0tBCyMzfxMzwPufqF6s4NatEdSkZ7+QeI15sl9B5/
         gkP/5JY8OJkGiHnspF7z0LObcPtVZgp0cL2wGjwU+yU3AXA9P4yK8AYAbt6pMJJqmyzm
         Xe3L2l+T2ppRPNdNLIfqP5i6irPQokHGA+Nqntt7P86FW0E9+ipq7KyTXpYbBhg36KG6
         krEg==
X-Forwarded-Encrypted: i=1; AJvYcCXX4d3W/ul7gbKRMbXdvpqKXXdiLjLETxG3uyHkqEhf1Bwvz+871ZsGhOLMS/rXuAAb13gSi54FSX+AAR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytqa4P9U83yoT7nYqTfmgo3uBCffrMPmq12b0tcPkdfO79xRqI
	HXk/ZakVaPwGFgubrfSWHgObE8NhrvRdtALPqF6lyj/HpGwvXQwIBpp+ej9CUf5dBGBQgZVwYRY
	1/xUR4A==
X-Gm-Gg: ASbGncu2r+sYj5RPR3fbvCt+tLvVa0JJADPHfDfQbt+WA47uSu5DrWhMW8EThzyD8ts
	q4JVGAO7bx6ic7ZnlK3ljHEJ6OxL2YZQpEOLqwvzwsOpsLys7Om+qgCfPxwYJisZw9Ao3XoffNS
	vGg3LdQ/Hz4kA7S3872HBhQbadG5rKGnIIBxpz9gjP4TmRm9L57dAVqGhqyEWuDRyBZaJI71FgL
	kPAuxFi1BtvZ5+pdpIk336io2dhekiveQ6PliR+/7WJ+ssPa2NT8P1xr6umYx0a9GLeM4dCALYx
	t47Wh3nflpJ7zlQD1ES1csEUbSIFQNN5r6rOGWwLMVhz9DBoboJc91XMq1SPO37fywornG2RRpG
	G1g7uBNcPkw+VPtBzRk1Ca78B/0wXf0fQM6sYe1IN9OFMLR4GC5mte04nD77If7ck
X-Google-Smtp-Source: AGHT+IFA6WWauE2WtiOZB2M9l5C8acy+0c/MmVBIv8UEUkq8EearyUpSzh9i4qvQaTKE2TzChWXqew==
X-Received: by 2002:a2e:a7ca:0:b0:32c:a097:4198 with SMTP id 38308e7fff4ca-330532989d3mr43514341fa.1.1752508281584;
        Mon, 14 Jul 2025 08:51:21 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29482f5sm16035581fa.42.2025.07.14.08.51.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:51:20 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b2f5d91c8so33942071fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:51:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUK16Vm5Qsndhgso/nXS0cuskPfprhYW50P2Vj/wfmlScZGQ4VcdciKw8u/t+Q9VvUuOfpHjIk6upPunJs=@vger.kernel.org
X-Received: by 2002:a05:651c:214c:b0:32a:8035:3f65 with SMTP id
 38308e7fff4ca-3305348a560mr20431831fa.36.1752508279445; Mon, 14 Jul 2025
 08:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-9-5710f9d030aa@chromium.org> <e573334d-da02-4d67-95ad-d372aa7f4a67@kernel.org>
In-Reply-To: <e573334d-da02-4d67-95ad-d372aa7f4a67@kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Jul 2025 17:51:06 +0200
X-Gmail-Original-Message-ID: <CANiDSCu0uHa9EAwyr-4AMdU_UL0k1YxPdT+YKX6yS22nyWw_DA@mail.gmail.com>
X-Gm-Features: Ac12FXwXunI1HhkoiTEAA1El4jNCwDB1UDYcjdPHccPPCbsUo8Spnc2mel0__-w
Message-ID: <CANiDSCu0uHa9EAwyr-4AMdU_UL0k1YxPdT+YKX6yS22nyWw_DA@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] media: uvcvideo: Add uvc_ctrl_query_entity helper
To: Hans de Goede <hansg@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 16:24, Hans de Goede <hansg@kernel.org> wrote:
>
> Hi Ricardo,
>
> On 5-Jun-25 19:53, Ricardo Ribalda wrote:
> > Create a helper function to query a control. The new function reduces
> > the number of arguments, calculates the length of the operation and
> > redirects the operation to the hardware or to the entity private
> > functions.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Thanks, this looks like a nice cleanup.
>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 81 ++++++++++++++++++++--------------------
> >  1 file changed, 41 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index b2768080c08aafa85acb9b7f318672c043d84e55..21ec7b978bc7aca21db7cb8fd5d135d876f3330c 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -576,6 +576,34 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc15 = {
> >                                 V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
> >  };
> >
> > +static int uvc_ctrl_query_entity(struct uvc_device *dev,
> > +                              const struct uvc_control *ctrl, u8 query,
> > +                              void *data)
> > +{
> > +     u16 len;
> > +
> > +     switch (query) {
> > +     case UVC_GET_INFO:
> > +             len = 1;
> > +             break;
> > +     case UVC_GET_LEN:
> > +             len = 2;
> > +             break;
> > +     default:
> > +             len = ctrl->info.size;
> > +     }
> > +
> > +     if (query == UVC_GET_CUR && ctrl->entity->get_cur)
> > +             return ctrl->entity->get_cur(dev, ctrl->entity,
> > +                                          ctrl->info.selector, data, len);
> > +     if (query == UVC_GET_INFO && ctrl->entity->get_info)
> > +             return ctrl->entity->get_info(dev, ctrl->entity,
> > +                                           ctrl->info.selector, data);
> > +
> > +     return uvc_query_ctrl(dev, query, ctrl->entity->id, dev->intfnum,
> > +                           ctrl->info.selector, data, len);
>
> Maybe:
>
>         if (query == UVC_GET_CUR && ctrl->entity->get_cur)
>                 return ctrl->entity->get_cur(dev, ctrl->entity,
>                                              ctrl->info.selector, data, len);
>         else if (query == UVC_GET_INFO && ctrl->entity->get_info)
>                 return ctrl->entity->get_info(dev, ctrl->entity,
>                                               ctrl->info.selector, data);
>         else
>                 return uvc_query_ctrl(dev, query, ctrl->entity->id, dev->intfnum,
>                                       ctrl->info.selector, data, len);
>
> ?
>
> That + Laurent's well observed remark about info->selector vs
> ctrl->info.selector which I would probably have missed...
>
> About Laurent's remark about one case of this pre-existing,
> please fix this in a separate patch (I guess you would have done so
> anyways, but just to be sure).

I have changed the code a bit so we can always rely on
ctrl->info.selector. I have made a small "preparation patch" getting
ready for it. Keep an eye on the next version ;)

There is no need to send a new patch fixing the current code because
the only controls that could have invalid ctrl->info.selector are xu
and software entities are not xu.

Regards!
>
> Regards,
>
> Hans
>
>
>
>
>
> > +}
> > +
> >  static const struct uvc_control_mapping *uvc_ctrl_filter_plf_mapping(
> >       struct uvc_video_chain *chain, struct uvc_control *ctrl)
> >  {
> > @@ -1222,35 +1250,27 @@ static int uvc_ctrl_populate_cache(struct uvc_video_chain *chain,
> >       int ret;
> >
> >       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF) {
> > -             ret = uvc_query_ctrl(chain->dev, UVC_GET_DEF, ctrl->entity->id,
> > -                                  chain->dev->intfnum, ctrl->info.selector,
> > -                                  uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF),
> > -                                  ctrl->info.size);
> > +             ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_DEF,
> > +                                     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
> >               if (ret < 0)
> >                       return ret;
> >       }
> >
> >       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN) {
> > -             ret = uvc_query_ctrl(chain->dev, UVC_GET_MIN, ctrl->entity->id,
> > -                                  chain->dev->intfnum, ctrl->info.selector,
> > -                                  uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN),
> > -                                  ctrl->info.size);
> > +             ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_MIN,
> > +                                     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
> >               if (ret < 0)
> >                       return ret;
> >       }
> >       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX) {
> > -             ret = uvc_query_ctrl(chain->dev, UVC_GET_MAX, ctrl->entity->id,
> > -                                  chain->dev->intfnum, ctrl->info.selector,
> > -                                  uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX),
> > -                                  ctrl->info.size);
> > +             ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_MAX,
> > +                                     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> >               if (ret < 0)
> >                       return ret;
> >       }
> >       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES) {
> > -             ret = uvc_query_ctrl(chain->dev, UVC_GET_RES, ctrl->entity->id,
> > -                                  chain->dev->intfnum, ctrl->info.selector,
> > -                                  uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES),
> > -                                  ctrl->info.size);
> > +             ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_RES,
> > +                                     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
> >               if (ret < 0) {
> >                       if (UVC_ENTITY_TYPE(ctrl->entity) !=
> >                           UVC_VC_EXTENSION_UNIT)
> > @@ -1291,16 +1311,7 @@ static int __uvc_ctrl_load_cur(struct uvc_video_chain *chain,
> >               return 0;
> >       }
> >
> > -     if (ctrl->entity->get_cur)
> > -             ret = ctrl->entity->get_cur(chain->dev, ctrl->entity,
> > -                                         ctrl->info.selector, data,
> > -                                         ctrl->info.size);
> > -     else
> > -             ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR,
> > -                                  ctrl->entity->id, chain->dev->intfnum,
> > -                                  ctrl->info.selector, data,
> > -                                  ctrl->info.size);
> > -
> > +     ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_CUR, data);
> >       if (ret < 0)
> >               return ret;
> >
> > @@ -2164,11 +2175,8 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
> >                       continue;
> >
> >               if (!rollback)
> > -                     ret = uvc_query_ctrl(dev, UVC_SET_CUR, ctrl->entity->id,
> > -                             dev->intfnum, ctrl->info.selector,
> > -                             uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
> > -                             ctrl->info.size);
> > -
> > +                     ret = uvc_ctrl_query_entity(dev, ctrl, UVC_SET_CUR,
> > +                             uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
> >               if (!ret)
> >                       processed_ctrls++;
> >
> > @@ -2570,13 +2578,7 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
> >       if (data == NULL)
> >               return -ENOMEM;
> >
> > -     if (ctrl->entity->get_info)
> > -             ret = ctrl->entity->get_info(dev, ctrl->entity,
> > -                                          ctrl->info.selector, data);
> > -     else
> > -             ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id,
> > -                                  dev->intfnum, info->selector, data, 1);
> > -
> > +     ret = uvc_ctrl_query_entity(dev, ctrl, UVC_GET_INFO, data);
> >       if (!ret) {
> >               info->flags &= ~(UVC_CTRL_FLAG_GET_CUR |
> >                                UVC_CTRL_FLAG_SET_CUR |
> > @@ -2654,8 +2656,7 @@ static int uvc_ctrl_fill_xu_info(struct uvc_device *dev,
> >       info->selector = ctrl->index + 1;
> >
> >       /* Query and verify the control length (GET_LEN) */
> > -     ret = uvc_query_ctrl(dev, UVC_GET_LEN, ctrl->entity->id, dev->intfnum,
> > -                          info->selector, data, 2);
> > +     ret = uvc_ctrl_query_entity(dev, ctrl, UVC_GET_LEN, data);
> >       if (ret < 0) {
> >               uvc_dbg(dev, CONTROL,
> >                       "GET_LEN failed on control %pUl/%u (%d)\n",
> >
>


-- 
Ricardo Ribalda

