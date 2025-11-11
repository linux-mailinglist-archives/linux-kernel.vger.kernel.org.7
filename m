Return-Path: <linux-kernel+bounces-894740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE43C4BBA8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CDC74E28E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BCB341AD6;
	Tue, 11 Nov 2025 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L24wN6So"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6422D8DD6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843702; cv=none; b=JLt/Xz9EmyCy2X6O6bxnmhqA/A5LXzrU0K12lGrWVap3Qa9mP6vu+hmgGp2/SzWsPeuxiowF28kxPI7Q16bJ/07E6RRuMJAXk01HIHVjAAa0AW6GbsJj9hcBWUazlDCFxswS4E8TeoR188KK6FrQvaATwcVkjLNqc7MDzoQ5ZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843702; c=relaxed/simple;
	bh=EusY1YtHYQQoikr/c/SlwC/Rh4MX3FMNKsBXoat7rAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEW4s+ZhLktH8q1csxbnCYvueV1S3dB1hs9lAE29jGP5b8NsN4mPx8sgNKbssLwNyT1mVSY3OHnnPijdr8B7pdh21THfmnY0XNVJEop/+00BfYqH9YxwauwXYVl/Gitl7eq+OPX+omi6Xie6mRWsfIZO6py3M8jaJ19k4kPlb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L24wN6So; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5599e0ab1e8so1329781e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762843700; x=1763448500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gP5GzDPunPhccnuJOs7BSz9jnRuXsEyAOZ/rFAQkjAU=;
        b=L24wN6SoR6HNFQeTDjyb8JN77ELLfJBPw5jOnH+Zvg5Q0SukzGaJCwCqkWePRvbwcL
         Jj6sLqPqYyd4zwPutgPdWyjVk2hUhNiWb+uALe1u0I5DgUmrSXNkxkeBndl60EsFsoo2
         o1mcU3JGcQB66I1Z2/9pbwRWgM2ZNa4/5Q+wlXdzsqtC7E2HfLalhlA5j5qTLHqC7mo/
         p59or+YbeEGjPb9GPLnX+uB64s9i4kdEAu0nY2Z8jL9kFficEXxmx0vNN+S0X6XQGaL9
         hMKGbxJfQPCFKKO4gTCYnP9tRq9AEXWcPo0cHTn0lfGDyeyDhpqo3UGbJduzpleEQ+NL
         ITBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762843700; x=1763448500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gP5GzDPunPhccnuJOs7BSz9jnRuXsEyAOZ/rFAQkjAU=;
        b=KwGisxlbRVcQ1N1/vOpxIAFKFMCMbOR1dKXgWaxPYQrFnLqL5nOCiSnXHBpNOT6hwG
         yA6vqKwQZixKP33L4rXxBHUhdPVTcemx0bksKH00Qe5NZoh4vbWrAl+JnL30yrjW1N2D
         QEDeENU4+tMyvPntya/B7zFDQt9vdn1ANhd/rWGKzqRMh5SaWgJEHl3I8V/INrsuhX1Y
         W8MBb25r8XDPoIYSqdDVjm+5fgKWwX2gQgB3jM1ED2Z24HaFt8OzUtOsd+8BO49FtQLr
         1ccIMleljCmiI4VciZJZELMGd8voy81jBWQeH1h1fhQMKUq8ZCYEm/zE4lG7/SK9+GeV
         IY9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7ZM3yhxklao39ids6v4edOh8DDVcOAJixCl0yMhwxC8qgZFN2bC1bmCz09eCKdxxVz3Xi4a76ebMIfp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQi3oIQhpc9W8hVC8Fqx/Zgy09vXqtFSICbzXy+DDscq0ymuNT
	K9PPf91v3hl7AMhVUzUqL5bi0x1cYuYJgxnDbw2OkUqCcmoQjVApBC+JmYmatd/Z/6Feg2mJZtg
	VKuuIAiGfq6N1QVcnuOEAgP2bQ6q7NQk=
X-Gm-Gg: ASbGnctOBJm2g2Klizeso8gjrNiY7PbwnODhATndL4hIqouCmABVonCFLxn5d4B6jot
	XoQCLFCno7YoWWFe9IyvdwkrFVnOi1iHnQLzf8KBJWpFsS4D3tgJFIK2NVVKFy8uO/ip5ooEZME
	5lOFju9uD1/MawsXuHnbS04s7nrRqGC7shfIuhfNBXoEh28aR6i/HGAqw13M0Np4DYtjQzaEuux
	Kh7M6lN76jFpOdNJOTZp3O0D3k7mUyj43kW/oPbr9ROMojVh7IvXuPTBoh2eA==
X-Google-Smtp-Source: AGHT+IHs/HnaXf74BFA+VnF8+OeIWKAvXMura36UhoIxjctf7EXn9XmD5A/bc3vkBxXa3XQ8XxEPTVZlMcq4CJKQuEY=
X-Received: by 2002:a05:6122:220f:b0:544:c8bf:6509 with SMTP id
 71dfb90a1353d-559b31f635emr4247968e0c.4.1762843699910; Mon, 10 Nov 2025
 22:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108232923.2067131-1-alex.t.tran@gmail.com> <aRGe1NkDHYtDOfnw@kekkonen.localdomain>
In-Reply-To: <aRGe1NkDHYtDOfnw@kekkonen.localdomain>
From: Alex Tran <alex.t.tran@gmail.com>
Date: Mon, 10 Nov 2025 22:48:09 -0800
X-Gm-Features: AWmQ_bnpahixUtFQ_QuDroeqIUMnaRfNGFfJK_LBi2sbT7-kLMKFAycskIl2JVM
Message-ID: <CA+hkOd5oxHMaoXMLVFiH=ySiT6f2y+F463KO9xV3o4P7ZKghTw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] media: i2c: et8ek8: et8ek8_driver: add support for
 crc configuration via device tree
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Pavel Machek <pavel@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 12:14=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Alex,
>
> Thanks for the patch.
>
> On Sat, Nov 08, 2025 at 03:29:23PM -0800, Alex Tran wrote:
> > Retrieve the configuration for CRC from the device tree instead
> > using the hard coded USE_CRC directive. If there is an issue
> > retrieving the endpoint node or the CRC property then the default
> > of 1 is used and the driver does not fail to maintain backward
> > compatibility.
>
> Is there a need for making this configurable? I have to say I can't recal=
l
> the specifics of CCP2 but presumably the receiver side would need to be
> aligned with this as well, requiring such configuration on both sides.
>
> If you want to pursue this further, please also cc me to the DT binding
> patch.
>
> >
> > Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> > ---
> >  drivers/media/i2c/et8ek8/et8ek8_driver.c | 49 +++++++++++++++++++-----
> >  1 file changed, 39 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/media/i2c/et8ek8/et8ek8_driver.c b/drivers/media/i=
2c/et8ek8/et8ek8_driver.c
> > index 2cb7b7187..4ef92359c 100644
> > --- a/drivers/media/i2c/et8ek8/et8ek8_driver.c
> > +++ b/drivers/media/i2c/et8ek8/et8ek8_driver.c
> > @@ -29,6 +29,7 @@
> >  #include <media/media-entity.h>
> >  #include <media/v4l2-ctrls.h>
> >  #include <media/v4l2-device.h>
> > +#include <media/v4l2-fwnode.h>
> >  #include <media/v4l2-subdev.h>
> >
> >  #include "et8ek8_reg.h"
> > @@ -45,6 +46,7 @@ struct et8ek8_sensor {
> >       struct regulator *vana;
> >       struct clk *ext_clk;
> >       u32 xclk_freq;
> > +     u32 use_crc;
> >
> >       u16 version;
> >
> > @@ -130,8 +132,6 @@ static struct et8ek8_gain {
> >
> >  #define ET8EK8_I2C_DELAY     3       /* msec delay b/w accesses */
> >
> > -#define USE_CRC                      1
> > -
> >  /*
> >   * Register access helpers
> >   *
> > @@ -844,20 +844,16 @@ static int et8ek8_power_on(struct et8ek8_sensor *=
sensor)
> >       if (rval)
> >               goto out;
> >
> > -#ifdef USE_CRC
> >       rval =3D et8ek8_i2c_read_reg(client, ET8EK8_REG_8BIT, 0x1263, &va=
l);
> >       if (rval)
> >               goto out;
> > -#if USE_CRC /* TODO get crc setting from DT */
> > -     val |=3D BIT(4);
> > -#else
> > -     val &=3D ~BIT(4);
> > -#endif
> > +     if (sensor->use_crc)
> > +             val |=3D BIT(4);
> > +     else
> > +             val &=3D ~BIT(4);
> >       rval =3D et8ek8_i2c_write_reg(client, ET8EK8_REG_8BIT, 0x1263, va=
l);
> >       if (rval)
> >               goto out;
> > -#endif
> > -
> >  out:
> >       if (rval)
> >               et8ek8_power_off(sensor);
> > @@ -1396,6 +1392,34 @@ static int __maybe_unused et8ek8_resume(struct d=
evice *dev)
> >       return __et8ek8_set_power(sensor, true);
> >  }
> >
> > +static int et8ek8_parse_fwnode(struct device *dev, struct et8ek8_senso=
r *sensor)
> > +{
> > +     struct v4l2_fwnode_endpoint bus_cfg =3D {
> > +             .bus_type =3D V4L2_MBUS_CCP2,
> > +     };
> > +     struct fwnode_handle *ep;
> > +     int ret;
> > +
> > +     ep =3D fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
> > +                                          FWNODE_GRAPH_ENDPOINT_NEXT);
> > +     if (!ep) {
> > +             dev_warn(dev, "could not get endpoint node\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret =3D v4l2_fwnode_endpoint_alloc_parse(ep, &bus_cfg);
> > +     if (ret) {
> > +             dev_warn(dev, "parsing endpoint node failed\n");
> > +             goto done;
> > +     }
> > +
> > +     fwnode_property_read_u32(ep, "crc", &sensor->use_crc);
> > +done:
> > +     v4l2_fwnode_endpoint_free(&bus_cfg);
> > +     fwnode_handle_put(ep);
> > +     return ret;
> > +}
> > +
> >  static int et8ek8_probe(struct i2c_client *client)
> >  {
> >       struct et8ek8_sensor *sensor;
> > @@ -1406,6 +1430,11 @@ static int et8ek8_probe(struct i2c_client *clien=
t)
> >       if (!sensor)
> >               return -ENOMEM;
> >
> > +     sensor->use_crc =3D 1;
> > +     ret =3D et8ek8_parse_fwnode(dev, sensor);
> > +     if (ret)
> > +             dev_warn(dev, "parsing endpoint failed\n");
> > +
> >       sensor->reset =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> >       if (IS_ERR(sensor->reset)) {
> >               dev_dbg(&client->dev, "could not request reset gpio\n");
>
> --
> Kind regards,
>
> Sakari Ailus

Thanks for the review. It seems like I missed adjusting the change on
the receiver side in omap3isp: isp.c
since the crc is still being defaulted to 1. I'll go ahead and add the
corresponding device tree parsing for the
crc property on the receiver side as well, so both the sensor and ISP
endpoints can be configured consistently.

The threading for this patch series was broken. I'll send in v2 as a 3
patch series with them
properly linked.

Best,
--
Alex Tran

