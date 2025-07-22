Return-Path: <linux-kernel+bounces-741099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FD2B0E008
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931EBAA5A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F5228A73C;
	Tue, 22 Jul 2025 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hO5QgSQl"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576631EDA0F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196847; cv=none; b=C3zt2KBYtc/kAogDeiF0pX5UiGasx/iunEcptchimhxcL9lcpkWGgmor4IHm8Xtm20ABnxfGl8fcxV5JhdwYc1fnuhWxQciHIiYzqobfcbNQuvJIbmBKnMcgnes4BC/XYkpcGjw3OCFsbjGzabeXqh8Yc4TpVd0wFMjkK6pECRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196847; c=relaxed/simple;
	bh=j5SSV+1ISMEIUzJrR4iHLvQrB5Jw61jfhEox5TlUz/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLK+qX4Ret+mQVhTXxMFN77KIdlHE504BpUZ/zDj/oRJ1DcU/Z48hlLDUx0wME8W/tqzjnhaYq5rCnHCooyM0i+HClLx7uoDZtAwQCE647SX5H0xnfsASxO8te46ChL1+KJwgOJWivSoZ4dMxbUVCGd/EthHq/N4T85ZZhT9Zlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hO5QgSQl; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso5548973a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753196845; x=1753801645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFuXMFjo0h/UR0HAY+GfEgreh2ROPFxeYCspBFo4WEs=;
        b=hO5QgSQlfz1FBt1Z0ux+qRh7kXrYXcqhHX2D++Mac7P5XMQFHGvHVjn1x6VB5BYWcy
         xjNN9k2DNO6/T8jugoolbS5Qqhhd4Xo6hei5O1d7RrFdbBUwp+Ck7N399wNJz+JI9WAm
         0P7XAMj4K+kRLvaq1NcSMm6rnaBlcHNCvI0Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196845; x=1753801645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFuXMFjo0h/UR0HAY+GfEgreh2ROPFxeYCspBFo4WEs=;
        b=TohPaqCOhxZPQWEyaZG6JHSf7OSevoiHLqZW/H+lKC2nY0C+UZIh288veoYbXVjfRi
         DInis7/Kaewlw4LuHAqGu1hUFRy1RuNyCefXMwBOXFkyQ8THR+7qPf1+XwXxcBvhlxGM
         34UeK8RD3f2GxTt7OY6TbxJCI0qcoCCjdpIoANLLTCUlkRTmeWF4KANBBv+hbFIySWF1
         WzyPLbf9BCYVAagvUGSxfrW5020fk1cqCUaJdvf2+RZmsfB3/jEhvKdt880Nb+NXRbOR
         dLitk/kiWAlm53di7g+obwsVVUstgb/yN/z2uRxAmpwXROM41kBbzrHMolbPvA2E9YbY
         ExVA==
X-Forwarded-Encrypted: i=1; AJvYcCV2AhB+dpw8fH3vFZisgLdPltHm8oe6QAKN/ca4++CUgTSCtnSMDiEbKcZJy3vZXIael3UMVefQmW+2OEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymwUgbXKjhm7u+1OHVrAH7eYtgfk/hADWdURHml1yamZRQIPYb
	w/H94yx3zg5DYWJV36KpoBtWHylxqCsHsFUssBnwkaoG0gN4qpwi9hc/aCjlUli53nRifXico6c
	NpBbTETUMyhiARwF9xN+K60r8GJRPrvmJRtjrtmWh
X-Gm-Gg: ASbGncuCbd0LgFqxycTnPEGUzI8p0GPKLVebiCIb5zK1effhZK+bz0cMKOFiriulX/U
	wnDtGD2vCWjNE+dgevVyV60Zj9wQDMJ2+o+DZkRAqKvtIpL3uLYe8nuz0GTtUs81be/VMkPWXIH
	0SY8n9A8efVJn+uNcy4CbAATyEWk9YQJE5i1DaVAOjmM5c99JhzwwniACKTS0iS5dh92SLcNBfS
	BHaJIRmOXo5yvMdoQ13ow+Yn9Lywb04jA==
X-Google-Smtp-Source: AGHT+IGk1y8G6vC79Od6nJSs6BFL6N37A9eRdsBNjWz08vxroB/UI+dtxlpOZMSnUyUPvONRxKXIqDzWTZf0qhPv7Is=
X-Received: by 2002:a17:90b:5788:b0:31c:d2de:9dbe with SMTP id
 98e67ed59e1d1-31cd2ede5afmr22435266a91.4.1753196844424; Tue, 22 Jul 2025
 08:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630141239.3174390-1-akuchynski@chromium.org>
 <20250630141239.3174390-5-akuchynski@chromium.org> <2025070159-judgingly-baggage-042a@gregkh>
In-Reply-To: <2025070159-judgingly-baggage-042a@gregkh>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Tue, 22 Jul 2025 17:07:13 +0200
X-Gm-Features: Ac12FXw_VYcsq4dfyV_GLBPQkKDiKVtqlAukdd7Wf6z0LcTLpZMH55gDTdG9dpw
Message-ID: <CAMMMRMdSt1z63nDK6p_cPE4J1ypvwkkTTz_DPg5DayQ7Yr_O+g@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] usb: typec: Expose mode priorities via sysfs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, "Christian A. Ehrhardt" <lk@c--e.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 10:32=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 30, 2025 at 02:12:33PM +0000, Andrei Kuchynski wrote:
> > This sysfs attribute specifies the preferred order for enabling
> > DisplayPort, Thunderbolt alternate modes, and USB4 mode.
> >
> > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > ---
> >  Documentation/ABI/testing/sysfs-class-typec |  16 +++
> >  drivers/usb/typec/Makefile                  |   2 +-
> >  drivers/usb/typec/class.c                   |  28 ++++-
> >  drivers/usb/typec/class.h                   |   4 +
> >  drivers/usb/typec/mode_selection.c          | 116 ++++++++++++++++++++
> >  drivers/usb/typec/mode_selection.h          |  19 ++++
> >  include/linux/usb/typec_altmode.h           |   7 ++
> >  7 files changed, 190 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/usb/typec/mode_selection.c
> >  create mode 100644 drivers/usb/typec/mode_selection.h
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentatio=
n/ABI/testing/sysfs-class-typec
> > index 38e101c17a00..ff3296ee8e1c 100644
> > --- a/Documentation/ABI/testing/sysfs-class-typec
> > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > @@ -162,6 +162,22 @@ Description:     Lists the supported USB Modes. Th=
e default USB mode that is used
> >               - usb3 (USB 3.2)
> >               - usb4 (USB4)
> >
> > +What:                /sys/class/typec/<port>/mode_priorities
> > +Date:                June 2025
> > +Contact:     Andrei Kuchynski <akuchynski@chromium.org>
> > +Description: Lists the modes supported by the port, ordered by their
> > +             activation priority. It defines the preferred sequence fo=
r activating
> > +             modes such as Displayport alt-mode, Thunderbolt alt-mode =
and USB4 mode.
> > +             The default order can be modified by writing a new sequen=
ce to this
> > +             attribute. Any modes omitted from a user-provided list wi=
ll be
> > +             automatically placed at the end of the list.
> > +
> > +             Example values:
> > +             - "USB4 TBT DP": default priority order
> > +             - "USB4 DP TBT": modified priority order after writing "U=
SB4 DP TBT" or
> > +                     "USB4 DP"
> > +             - "DP": the port only supports Displayport alt-mode
>
> Multiple value sysfs files are generally frowned apon.  sysfs files that
> also have to be manually parsed in the kernel are also frowned apon.
> Are you _SURE_ there is no other way that you could possibly do this?
>

The string parser will be removed. See my comment below.

> > +
> >  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
> >
> >  What:                /sys/class/typec/<port>-partner/accessory_mode
> > diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> > index 7a368fea61bc..8a6a1c663eb6 100644
> > --- a/drivers/usb/typec/Makefile
> > +++ b/drivers/usb/typec/Makefile
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_TYPEC)          +=3D typec.o
> > -typec-y                              :=3D class.o mux.o bus.o pd.o ret=
imer.o
> > +typec-y                              :=3D class.o mux.o bus.o pd.o ret=
imer.o mode_selection.o
> >  typec-$(CONFIG_ACPI)         +=3D port-mapper.o
> >  obj-$(CONFIG_TYPEC)          +=3D altmodes/
> >  obj-$(CONFIG_TYPEC_TCPM)     +=3D tcpm/
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index a72325ff099a..93eadbcdd4c0 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -19,6 +19,7 @@
> >  #include "bus.h"
> >  #include "class.h"
> >  #include "pd.h"
> > +#include "mode_selection.h"
> >
> >  static DEFINE_IDA(typec_index_ida);
> >
> > @@ -540,7 +541,7 @@ static void typec_altmode_release(struct device *de=
v)
> >  }
> >
> >  const struct device_type typec_altmode_dev_type =3D {
> > -     .name =3D "typec_alternate_mode",
> > +     .name =3D ALTERNATE_MODE_DEVICE_TYPE_NAME,
> >       .groups =3D typec_altmode_groups,
> >       .release =3D typec_altmode_release,
> >  };
> > @@ -1942,6 +1943,25 @@ static ssize_t orientation_show(struct device *d=
ev,
> >  }
> >  static DEVICE_ATTR_RO(orientation);
> >
> > +static ssize_t mode_priorities_store(struct device *dev,
> > +                            struct device_attribute *attr,
> > +                            const char *buf, size_t size)
> > +{
> > +     struct typec_port *port =3D to_typec_port(dev);
> > +     int ret =3D typec_mode_priorities_set(port, buf);
>
> You don't pass in size here, what could go wrong...
>

Yes, the buffer size really needs to be checked. Thank you.

> > +
> > +     return ret ? : size;
>
> Please do not use ? : unless you have to.  Spell it out, it makes code
> easier to maintain.  Remember, we write code for people first, compilers
> second.
>

Ternary operators will be changed to if/else.

> > +}
> > +
> > +static ssize_t mode_priorities_show(struct device *dev,
> > +                           struct device_attribute *attr, char *buf)
> > +{
> > +     struct typec_port *port =3D to_typec_port(dev);
> > +
> > +     return typec_mode_priorities_get(port, buf);
> > +}
> > +static DEVICE_ATTR_RW(mode_priorities);
> > +
> >  static struct attribute *typec_attrs[] =3D {
> >       &dev_attr_data_role.attr,
> >       &dev_attr_power_operation_mode.attr,
> > @@ -1954,6 +1974,7 @@ static struct attribute *typec_attrs[] =3D {
> >       &dev_attr_port_type.attr,
> >       &dev_attr_orientation.attr,
> >       &dev_attr_usb_capability.attr,
> > +     &dev_attr_mode_priorities.attr,
> >       NULL,
> >  };
> >
> > @@ -1992,6 +2013,9 @@ static umode_t typec_attr_is_visible(struct kobje=
ct *kobj,
> >                       return 0;
> >               if (!port->ops || !port->ops->default_usb_mode_set)
> >                       return 0444;
> > +     } else if (attr =3D=3D &dev_attr_mode_priorities.attr) {
> > +             if (!port->alt_mode_override)
> > +                     return 0;
> >       }
> >
> >       return attr->mode;
> > @@ -2652,6 +2676,8 @@ struct typec_port *typec_register_port(struct dev=
ice *parent,
> >       else if (cap->usb_capability & USB_CAPABILITY_USB2)
> >               port->usb_mode =3D USB_MODE_USB2;
> >
> > +     typec_mode_priorities_set(port, "");
> > +
> >       device_initialize(&port->dev);
> >       port->dev.class =3D &typec_class;
> >       port->dev.parent =3D parent;
> > diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> > index f05d9201c233..28b3c19a0632 100644
> > --- a/drivers/usb/typec/class.h
> > +++ b/drivers/usb/typec/class.h
> > @@ -5,6 +5,7 @@
> >
> >  #include <linux/device.h>
> >  #include <linux/usb/typec.h>
> > +#include <linux/usb/typec_altmode.h>
> >
> >  struct typec_mux;
> >  struct typec_switch;
> > @@ -82,6 +83,7 @@ struct typec_port {
> >       struct device                   *usb3_dev;
> >
> >       bool                            alt_mode_override;
> > +     int                             mode_priority_list[TYPEC_MODE_MAX=
];
> >  };
> >
> >  #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, de=
v)
> > @@ -111,4 +113,6 @@ static inline int typec_link_ports(struct typec_por=
t *connector) { return 0; }
> >  static inline void typec_unlink_ports(struct typec_port *connector) { =
}
> >  #endif
> >
> > +#define ALTERNATE_MODE_DEVICE_TYPE_NAME "typec_alternate_mode"
> > +
> >  #endif /* __USB_TYPEC_CLASS__ */
> > diff --git a/drivers/usb/typec/mode_selection.c b/drivers/usb/typec/mod=
e_selection.c
> > new file mode 100644
> > index 000000000000..cb7ddf679037
> > --- /dev/null
> > +++ b/drivers/usb/typec/mode_selection.c
> > @@ -0,0 +1,116 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright 2025 Google LLC.
> > + */
> > +
> > +#include <linux/usb/typec_altmode.h>
> > +#include <linux/vmalloc.h>
> > +#include "mode_selection.h"
> > +#include "class.h"
> > +
> > +static const char * const mode_names[] =3D {
> > +     [TYPEC_DP_ALTMODE] =3D "DP",
> > +     [TYPEC_TBT_ALTMODE] =3D "TBT",
> > +     [TYPEC_USB4_MODE] =3D "USB4",
>
> No TYPEC_MODE_MAX entry?  Why not?  This is going to get out of sync,
> see below for my comment about that.
>

The mode_selection mechanism will strictly support and work only with
modes explicitly described in mode_names array. Elements in this array
will be checked for NULL. Thanks for raising it.

> > +};
> > +static const char * const default_priorities =3D "USB4 TBT DP";
>
> A comment here about what this is for?
>

Thanks, I=E2=80=99ll add it

> > +
> > +/* -------------------------------------------------------------------=
------- */
> > +/* port 'mode_priorities' attribute */
> > +static int typec_mode_parse_priority_string(const char *str, int *list=
)
> > +{
> > +     const bool user_settings =3D list[0] =3D=3D TYPEC_MODE_MAX;
> > +     char *buf, *ptr;
> > +     char *token;
> > +     int ret =3D 0;
> > +
> > +     buf =3D vmalloc(strlen(str) + 1);
>
> Why vmalloc for such a small chunk of memory?
>

Good point. kstrndup should be used here.

> > +     if (!buf)
> > +             return -ENOMEM;
> > +     for (int i =3D 0; i <=3D strlen(str); i++)
> > +             buf[i] =3D (str[i] =3D=3D '\n') ? '\0' : str[i];
>
> Please spell out if statements, especially ones that do assignements in
> them.  This is going to be a pain to maintain over time, right?  Make it
> obvious what is happening please.
>
>

Yes, I see it now. `strreplace` would be helpful here.

> > +     ptr =3D buf;
> > +
> > +     while ((token =3D strsep(&ptr, " ")) && !ret) {
> > +             if (strlen(token)) {
> > +                     int mode =3D 0;
> > +
> > +                     while ((mode < TYPEC_MODE_MAX) &&
> > +                             strcmp(token, mode_names[mode]))
> > +                             mode++;
> > +                     if (mode =3D=3D TYPEC_MODE_MAX) {
> > +                             ret =3D -EINVAL;
> > +                             continue;
> > +                     }
> > +
> > +                     for (int i =3D 0; i < TYPEC_MODE_MAX; i++) {
> > +                             if (list[i] =3D=3D TYPEC_MODE_MAX) {
> > +                                     list[i] =3D mode;
> > +                                     break;
> > +                             }
> > +                             if (list[i] =3D=3D mode) {
> > +                                     if (user_settings)
> > +                                             ret =3D -EINVAL;
> > +                                     break;
> > +                             }
> > +                     }
> > +             }
> > +     }
> > +     vfree(buf);
>
> Why not just use a free() type model and that way your error paths above
> are much simpler?
>
>

Acknowledged.

> > +
> > +     return ret;
> > +}
> > +
> > +int typec_mode_priorities_set(struct typec_port *port,
> > +             const char *user_priorities)
> > +{
> > +     int list[TYPEC_MODE_MAX];
> > +     int ret;
> > +
> > +     for (int i =3D 0; i < TYPEC_MODE_MAX; i++)
> > +             list[i] =3D TYPEC_MODE_MAX;
> > +
> > +     ret =3D typec_mode_parse_priority_string(user_priorities, list);
> > +     if (!ret)
> > +             ret =3D typec_mode_parse_priority_string(default_prioriti=
es, list);
> > +
> > +     if (!ret)
> > +             for (int i =3D 0; i < TYPEC_MODE_MAX; i++)
> > +                     port->mode_priority_list[i] =3D list[i];
> > +
> > +     return ret;
> > +}
> > +
> > +static int port_altmode_supported(struct device *dev, void *data)
> > +{
> > +     if (!strcmp(dev->type->name, ALTERNATE_MODE_DEVICE_TYPE_NAME)) {
> > +             struct typec_altmode *alt =3D to_typec_altmode(dev);
> > +
> > +             if (*(int *)data =3D=3D typec_svid_to_altmode(alt->svid))
> > +                     return 1;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static bool port_mode_supported(struct typec_port *port, int mode)
> > +{
> > +     if (mode >=3D TYPEC_MODE_MAX)
> > +             return false;
> > +     if (mode =3D=3D TYPEC_USB4_MODE)
> > +             return !!(port->cap->usb_capability & USB_CAPABILITY_USB4=
);
> > +     return device_for_each_child(&port->dev, &mode, port_altmode_supp=
orted);
> > +}
> > +
> > +int typec_mode_priorities_get(struct typec_port *port, char *buf)
> > +{
> > +     ssize_t count =3D 0;
> > +
> > +     for (int i =3D 0; i < TYPEC_MODE_MAX; i++) {
> > +             int mode =3D port->mode_priority_list[i];
> > +
> > +             if (port_mode_supported(port, mode))
> > +                     count +=3D sysfs_emit_at(buf, count, "%s ", mode_=
names[mode]);
> > +     }
> > +
> > +     return count + sysfs_emit_at(buf, count, "\n");
> > +}
> > diff --git a/drivers/usb/typec/mode_selection.h b/drivers/usb/typec/mod=
e_selection.h
> > new file mode 100644
> > index 000000000000..c595c84e26a4
> > --- /dev/null
> > +++ b/drivers/usb/typec/mode_selection.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#include <linux/usb/typec_dp.h>
> > +#include <linux/usb/typec_tbt.h>
> > +
> > +static inline int typec_svid_to_altmode(const u16 svid)
> > +{
> > +     switch (svid) {
> > +     case USB_TYPEC_DP_SID:
> > +             return TYPEC_DP_ALTMODE;
> > +     case USB_TYPEC_TBT_SID:
> > +             return TYPEC_TBT_ALTMODE;
> > +     }
> > +     return TYPEC_MODE_MAX;
> > +}
> > +
> > +int typec_mode_priorities_set(struct typec_port *port,
> > +             const char *user_priorities);
> > +int typec_mode_priorities_get(struct typec_port *port, char *buf);
> > diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/type=
c_altmode.h
> > index b3c0866ea70f..4f05c5f5c91d 100644
> > --- a/include/linux/usb/typec_altmode.h
> > +++ b/include/linux/usb/typec_altmode.h
> > @@ -145,6 +145,13 @@ enum {
> >
> >  #define TYPEC_MODAL_STATE(_state_)   ((_state_) + TYPEC_STATE_MODAL)
> >
> > +enum {
> > +     TYPEC_DP_ALTMODE =3D 0,
> > +     TYPEC_TBT_ALTMODE,
> > +     TYPEC_USB4_MODE,
> > +     TYPEC_MODE_MAX,
>
> This list is going to get out of order and sync with your string list
> elsewhere in the other .c file.  What is going to ensure that this does
> not happen?
>
> Again, I'm really not happy with this api, it feels fragile and tricky
> and will get out of sync very easily over time.  We need loads of
> justification for why this really is the only possible way this can be
> done, and some type of proof that this actually has been tested (and
> maybe fuzzed?)
>

The current mode priority string parser will be removed in the next
patch series. This will enable individual, per-mode priority
configuration. For the USB4 mode, priority will then be set via a
dedicated usb4_priority sysfs port attribute, or within a new
USB4-specific attribute group.
A read-only mode_priorities attribute will then be used to provide the
resulting, validated priority order to userspace.

Thank you,
Andrei

> thanks,
>
> greg k-h

