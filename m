Return-Path: <linux-kernel+bounces-730188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8A3B0412F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0F5189A8F4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E00255F56;
	Mon, 14 Jul 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U6bU3OcR"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075725525F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502472; cv=none; b=JD5iJc0V9V0sNYgejxDayystgGmsrbPOgCQLJBxyqYxYh6EWWBNyOEElEQK4gwhVNXJ7ABaJq79P4m8Tf6FgGdys8pM2c26q7hmjVBhEabx8ebtNiLIwEZUVp7zvoq3bHZcz/zD8FyAzNxt1j5CLvYL87Lx8QrFJeUvOOdSpNlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502472; c=relaxed/simple;
	bh=83AgYV4x+hwPaNGzWopzeXSbiWGOVcEuU5XbcQfD8es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5LhnpVx5/0oCjWYGNjRkQhT1BXcsYF5Ckqmv6frg5jfHWDBABOhOLcYF6PCLIxFumnRRN9De9izcGM0LFCxWOdz+e4rjnYQm7vNXc4zSKdT4mfO0jjvADrxi4nIqboJjLtnPI9waG2ub5+vKxT0pJbtiHuWqj4k95uqlFy8Av4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U6bU3OcR; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b4876dfecso54069821fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752502469; x=1753107269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aPBTalpHMZbUCps9VnvQc6q/AJch4FZWjrxFyUqpLTw=;
        b=U6bU3OcR9CxT7D5fNr4b8g6YBdbaq/Rs0bevrAvyiaGP2ez3I2i7sSUrrMcbtlQb74
         KnDy0S7Z3A4f34I4S4Jjp7ABtOei2AODpvDr2xLONNHPzmIjF/i+d1IkWozMhmDchR5Q
         c3vO3aFHddX8lRgUGaYod3V5RZxkdq3mdOTLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752502469; x=1753107269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPBTalpHMZbUCps9VnvQc6q/AJch4FZWjrxFyUqpLTw=;
        b=D/sOVmWtZD/c4WW31VcDlY8zt/G3Nlrqg7AlWdvaRQK+K1/HG5ln0fABAMEsBbooPI
         DjBjWa93dd81cRuY47QMdKmZqYGynB9yvbanePzuQCCDcE2V/o0aMyPH1P2Yy7M7CxL6
         xcD+S9DWde4vlC/9z8ey2dDZh1qWScjb8MwojeMp2Gmw1o+fVY5E39WV+qsPJX3LwgCm
         fojnRPTtNhlW3HspSrVdLVzOhFhnUOFXctaAvlbTQGD/A/j8cvLv3XFLC0Amb+RqBpKF
         5amj1itN5YvSriLF4g7qq/c8YeVsLAym5Yc54SFIuIRX9/N2WI8bACEbM04+Z34rGEsb
         hbtw==
X-Forwarded-Encrypted: i=1; AJvYcCWXqLVUrrzLAYgE2vu8iq6/RDkfF2HnB+IH2+zHVsGyWFxIzbXDc3BAC0ZEcOnkZSkOZ6Q0xgQn9Bci/2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YycO03uS+pygwGEOqYF7OqOiolepBijLAAJgzWYhNvhOLCE8NNa
	CdVwbUzmlJWmZwPJdg0VAzzOFw6cW8LP64T3bVUHQfz0Niln5dqL5m/gLGAWbChrdsiRjgWWdVE
	b5yU=
X-Gm-Gg: ASbGncsjzjtEbtMO6jdhzfr7jFdb9eybvfouAB6D99OhfpzNE1/aEGzWn/U6PNxZ0RQ
	COK6HmkPlZk+cRmzgOwtrg81jhEJHMQrlDV8TrbXKM3A9ckChO9NI7gK+tRLImkkmAvbvxtsHs+
	NDXZYnHNPGsVH6JukkwqELWv88jQODLwZPcaDtycMCKSPXei9O7C34CSy3HsgSVkNhFCQ7wFEUG
	gaNXJbc8G/n2rfbsoJBW2goGD1Q2w3e9cuFJPYubr23f4qoALofJmGqrsRGvkgsgRQWooAzMOdg
	y0zYA/rsyx4fUMJ7RJR5sQHRNQTPtv3Yv8W6UJI1uBZpvo8MzxHDXWDbPgzUyNbP4PNjT+hMtF+
	JUp0uVN7k5Qp50+GkSMzUEL7OkDqTe92Mz4Jn7q8CklEzhnMUTiqT0Cpt1rZfdJHZ
X-Google-Smtp-Source: AGHT+IHzMilRZGRgp8QWmCSGgPRHNMwRphZhziP7jddaTv6IlEkgqtVjBAmx1IxZ35mbBsLcCCXJmQ==
X-Received: by 2002:a05:651c:b08:b0:329:2657:c98 with SMTP id 38308e7fff4ca-32f51202133mr55161561fa.15.1752502468808;
        Mon, 14 Jul 2025 07:14:28 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab916bebsm15684061fa.105.2025.07.14.07.14.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:14:28 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32f144d0db8so29128451fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:14:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDcP0L4Kgnr958pYsvQjWy+LWjNwj1XRDeSYJQt6+I4B/xKCmtxB2JFfoT47vlecd5BDq3YKRFa7CevwE=@vger.kernel.org
X-Received: by 2002:a05:651c:2002:b0:32b:59d1:7ef2 with SMTP id
 38308e7fff4ca-32f50c780f8mr41327731fa.9.1752502467634; Mon, 14 Jul 2025
 07:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-2-5710f9d030aa@chromium.org> <a02801c8-4be0-4a53-a037-e38bf0f05db1@redhat.com>
In-Reply-To: <a02801c8-4be0-4a53-a037-e38bf0f05db1@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Jul 2025 16:14:14 +0200
X-Gmail-Original-Message-ID: <CANiDSCsq4_R5R6+W3qxN6tpDJxqSkZ8E20Hza=Ye-HpqfCza1w@mail.gmail.com>
X-Gm-Features: Ac12FXyYIipkCH4Sx5CVKejVWW7_NLIKMhi6EeKATJWIjzTAUBbADXkCmkZ4IHg
Message-ID: <CANiDSCsq4_R5R6+W3qxN6tpDJxqSkZ8E20Hza=Ye-HpqfCza1w@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] media: v4l: fwnode: Support ACPI's _PLD for v4l2_fwnode_device_parse
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
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

On Mon, 14 Jul 2025 at 15:03, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 5-Jun-25 19:52, Ricardo Ribalda wrote:
> > Currently v4l2_fwnode_device_parse() obtains the orientation and
> > rotation via fwnode properties.
> >
> > Extend the function to support as well ACPI devices with _PLD info.
> >
> > We give a higher priority to fwnode, because it might contain quirks
> > injected via swnodes.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/v4l2-core/v4l2-fwnode.c | 85 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 79 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> > index cb153ce42c45d69600a3ec4e59a5584d7e791a2a..379290ab3cfde74c8f663d61837a9a95011b5ae0 100644
> > --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> > +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> > @@ -15,6 +15,7 @@
> >   * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> >   */
> >  #include <linux/acpi.h>
> > +#include <acpi/acpi_bus.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mm.h>
> >  #include <linux/module.h>
> > @@ -807,16 +808,65 @@ int v4l2_fwnode_connector_add_link(struct fwnode_handle *fwnode,
> >  }
> >  EXPORT_SYMBOL_GPL(v4l2_fwnode_connector_add_link);
> >
> > -int v4l2_fwnode_device_parse(struct device *dev,
> > -                          struct v4l2_fwnode_device_properties *props)
> > +static int v4l2_fwnode_device_parse_acpi(struct device *dev,
> > +                                      struct v4l2_fwnode_device_properties *props)
> > +{
> > +     struct acpi_pld_info *pld;
> > +     int ret = 0;
> > +
> > +     if (!is_acpi_device_node(dev_fwnode(dev)))
> > +             return 0;
> > +
> > +     if (!acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld)) {
> > +             dev_dbg(dev, "acpi _PLD call failed\n");
> > +             return 0;
> > +     }
> > +
> > +     if (props->orientation != V4L2_FWNODE_PROPERTY_UNSET) {
>
> "!=" should be "==" here. So that we set it when not set already,
> rather then leaving it unset when not set already.
>
> > +             switch (pld->panel) {
> > +             case ACPI_PLD_PANEL_FRONT:
> > +                     props->orientation = V4L2_FWNODE_ORIENTATION_FRONT;
> > +                     break;
> > +             case ACPI_PLD_PANEL_BACK:
> > +                     props->orientation = V4L2_FWNODE_ORIENTATION_BACK;
> > +                     break;
> > +             case ACPI_PLD_PANEL_TOP:
> > +             case ACPI_PLD_PANEL_LEFT:
> > +             case ACPI_PLD_PANEL_RIGHT:
> > +             case ACPI_PLD_PANEL_UNKNOWN:
> > +                     props->orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
> > +                     break;
> > +             default:
> > +                     dev_dbg(dev, "Unknown _PLD panel val %d\n", pld->panel);
> > +                     ret = -EINVAL;
> > +                     goto done;
> > +             }
> > +     }
> > +
> > +     if (props->rotation != V4L2_FWNODE_PROPERTY_UNSET) {
>
> Same here.
>
>
> > +             switch (pld->rotation) {
> > +             case 0 ... 7:
> > +                     props->rotation = pld->rotation * 45;
> > +                     break;
> > +             default:
> > +                     dev_dbg(dev, "Unknown _PLD rotation val %d\n", pld->panel);
> > +                     ret = -EINVAL;
> > +                     goto done;
> > +             }
> > +     }
> > +
> > +done:
> > +     ACPI_FREE(pld);
> > +     return ret;
> > +}
> > +
> > +static int v4l2_fwnode_device_parse_dt(struct device *dev,
> > +                                    struct v4l2_fwnode_device_properties *props)
> >  {
> >       struct fwnode_handle *fwnode = dev_fwnode(dev);
> >       u32 val;
> >       int ret;
> >
> > -     memset(props, 0, sizeof(*props));
> > -
> > -     props->orientation = V4L2_FWNODE_PROPERTY_UNSET;
> >       ret = fwnode_property_read_u32(fwnode, "orientation", &val);
> >       if (!ret) {
> >               switch (val) {
> > @@ -833,7 +883,6 @@ int v4l2_fwnode_device_parse(struct device *dev,
> >               dev_dbg(dev, "device orientation: %u\n", val);
> >       }
> >
> > -     props->rotation = V4L2_FWNODE_PROPERTY_UNSET;
> >       ret = fwnode_property_read_u32(fwnode, "rotation", &val);
> >       if (!ret) {
> >               if (val >= 360) {
> > @@ -847,6 +896,30 @@ int v4l2_fwnode_device_parse(struct device *dev,
> >
> >       return 0;
> >  }
> > +
> > +int v4l2_fwnode_device_parse(struct device *dev,
> > +                          struct v4l2_fwnode_device_properties *props)
> > +{
> > +     int ret;
> > +
> > +     memset(props, 0, sizeof(*props));
> > +
> > +     props->orientation = V4L2_FWNODE_PROPERTY_UNSET;
> > +     props->rotation = V4L2_FWNODE_PROPERTY_UNSET;
> > +
> > +     /* Start by looking into swnodes and dt. */
> > +     ret =  v4l2_fwnode_device_parse_dt(dev, props);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Orientation and rotation found!, we are ready. */
> > +     if (props->orientation != V4L2_FWNODE_PROPERTY_UNSET &&
> > +         props->rotation != V4L2_FWNODE_PROPERTY_UNSET)
> > +             return 0;
>
> As Sakari set, this can be dropped, with the 2 checks above
> fixed to be == v4l2_fwnode_device_parse_acpi() will become
> a no-op in this case.

I wanted to avoid calling he _PLD method if it was not necessary.

But if both Sakari and you dislike the optimization then let's get rid of it :)

Thanks


>
> With these things fixed:
>
> Reviewed-by: Hans de Goede <hansg@kernel.org>
>
> Regards,
>
> Hans
>
>
> > +
> > +     /* Let's check the acpi table. */
> > +     return v4l2_fwnode_device_parse_acpi(dev, props);
> > +}
> >  EXPORT_SYMBOL_GPL(v4l2_fwnode_device_parse);
> >
> >  /*
> >
>


--
Ricardo Ribalda

