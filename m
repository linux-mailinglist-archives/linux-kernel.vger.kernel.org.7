Return-Path: <linux-kernel+bounces-898311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA3BC54D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 470CA3487E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EE8299957;
	Wed, 12 Nov 2025 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NsMj293J"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10494265298
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762991409; cv=none; b=ioFeRXKFIC/gvV4eJzsknL5w7Q8vk6/zBvCsC9ZAelFcBNGZUR738cpU9ZOwIgUgLhDOdi02TGvt2pOyb3W49hyGqEjy89gZ7NLzuYladyK/N9+Fn8K9Qrszqok7qLMTPOvt1rT7uZjUT/0MOoRo+lhGsOstVK3dDbS4/owWtc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762991409; c=relaxed/simple;
	bh=/1xuZ19N9D21dJMmxPDAgahjfiz1uG/kX3l0Q8uy9NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8bv+RzmIJuW+GHaOcmRITBiARw97ar3oo8XznHLUL3CzLY3gMxNdUcDyRVF9vynsR9U8t0k0p72aDsU/dkG5+IZnGN1We8DLm1ZeCBT/azzFOVuxiaWsyvotSEw+KDmaglvwcySPrS4QOCxh3xO396/49FkOcgd2hG59k6AAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NsMj293J; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-880499b2bc7so1933306d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762991407; x=1763596207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR3KNcGL1WKYaIA0MeDAd56bxcOpI3C9w3m5B5bYUmg=;
        b=NsMj293JU1v7yNGWw5fWQZKAHBUYmE9ZlBLc8bxtF0H6/1HDDqML2RzPKvWsXXNo7f
         k5tRg9qjqLK1zKG80qymCu1mSMtY+lrczzWV2tnUXu652rNUHGkNT0jMBaDkSXh52EIk
         qSWUKqeWJtUL6YcPC2fitp7r+02lnkcn/KCkuPoGeXCxSX0HHaX8E4CRx6wUAsMxBIyx
         cqV1/Z8MAGF1XPJga9vDHHQG4SVGpukG8a0aTzrwbNW6V99O+PVixABJyAb3pbbLtd0+
         Uv7vR6pmgRA2KrazuUpNlKKI8nRBkEK95r+jRG4yHT1+XqNOBY5veW7t5yo376TWkjyY
         dq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762991407; x=1763596207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bR3KNcGL1WKYaIA0MeDAd56bxcOpI3C9w3m5B5bYUmg=;
        b=hNTjXhJiSHVYeKF+wIm8JjTP+PhyxSElwQ6DAXgv1xDlGbH8Vsyuxay+zXUA8At8M4
         vIRGY6hIdxa8A1+1BwVqVJ9ajA0594i6R9bR0rCF3NZAiQjM13n9AteHJK+HUPgngv/I
         SBMtc5EWqdswKYfxQBer9P7zRTJu+gIeUjfHRsFbm9udyLQNgJ5N4DPYS92EkuszInAL
         lQyxnQ2CvIryvu1MGiUPBEjUB8FakjQ/aXIPb/R5gV6ZONRIfNzSMScAX8albVqD7kD8
         Qojc3fdi+apeFlSp8QZr+msMY/fimWMpNgeQwYU7ZJKc0YQPlc+QK7BieNRdWhQT9ixB
         0Pog==
X-Forwarded-Encrypted: i=1; AJvYcCV37uDxlnDJSG2j0kF4WdU/XBRyBTAeiufgMckY/wFALOOfGSqyJEZiWq4tg1w8bcXlvKTe9rLfkXuq2MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhihl0Nhkh5q8xAI6yPT398Cp5nuXgyEUHJ3BcKl4tKyOtHgV
	uAeFplgYzXtfrgUp8UtNrh4ygeof9PPoivDYC+UBt1V8GRJGogIPP3YiiMEwBT5ftfue8aWwfRd
	gmchbm5kGwcpkdH6WzrVSwjpmBKl8Kuo8jByp3+uB
X-Gm-Gg: ASbGncsE9yhnRN7Bgvqk0lhtBoHCAc6lXRj6FRsZ/uCzovOw/gLbAuD9z0pzjBlTWB3
	5RjLbNRUaJQEKwH5xGkNrQfYPNivGhlkZqwTxYUaqnSj7ZUWmC+xtxE1FX0ip7avgD5nNJEsgx6
	a2UKvaXgmBpbrG1jnKro9PriyUtd5XBMqUR3gZT0KshZbPUn5yMbuPVLn5D0kOUni5rvn9nNG08
	056vrkvC8tVgY1iuMjcyK5YkUbna3oglC709jEWKYetLG5nmHx47c9PwSuhE6Y8t44Fq8auY+10
	uLvqDOr8G+53Z0xIRk+Y10n/3WcfOJJ+/Qm4rr0=
X-Google-Smtp-Source: AGHT+IGjxH+nH9D9BN5Xbegmeehkb+D9wVijiInU13yeFxIU69OGkMqQu9VMoeEWBT5CH73UarXvTNb92zlBRFLl7lE=
X-Received: by 2002:ad4:5ca6:0:b0:880:4366:cf95 with SMTP id
 6a1803df08f44-882718cf8c8mr62674186d6.6.1762991406658; Wed, 12 Nov 2025
 15:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111-lid-switch-notifier-v2-0-789723d78d89@google.com>
 <20251111-lid-switch-notifier-v2-2-789723d78d89@google.com> <iazucnirwewmavtsxudcynuoy2afzxhzr7nre2wke4d7glypcu@jtotz5oivpsu>
In-Reply-To: <iazucnirwewmavtsxudcynuoy2afzxhzr7nre2wke4d7glypcu@jtotz5oivpsu>
From: Jonathan Denose <jdenose@google.com>
Date: Wed, 12 Nov 2025 17:49:53 -0600
X-Gm-Features: AWmQ_blmCSjfJm5kWTz-kCSBVIeMXy-6smTOG3RLV9orFvKSezNo0gUDNUrU7MA
Message-ID: <CAMCVhVMPuoaEzTthmaOBR+YbT3AN2YPKRv3XAw_r4owUvSRCKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] HID: multitouch: Toggle touch surface on Elan
 touchpad on lid event
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Thanks for your review.

On Tue, Nov 11, 2025 at 4:37=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Jonathan,
>
> On Tue, Nov 11, 2025 at 09:34:07PM +0000, Jonathan Denose wrote:
> > Many touchpad modules have a pin which is expected to be connected to t=
he
> > lid angle sensor in laptops. The pin sends a signal to the touchpad mod=
ule
> > about the lid state and each touchpad vendor handles this notification =
in
> > their firmware.
> >
> > The Elan touchpad with VID 323b does not always have this aforementione=
d
> > pin, which then causes interference between the lid and the touchpad wh=
en
> > the lid is closed. This interference causes a few seconds delay before =
the
> > touchpad works again, or it causes it to be come completely unresponsiv=
e.
> > To circumvent this hardware issue in software, implement a device quirk
> > which will allow the hid-multitouch driver to register a notifier_block
> > to listen for lid switch events. When the lid switch closes, the
> > touchpad surface will be turned off and when the lid switch opens, the
> > touchpad surgace will be turned on. This triggers recalibration which
> > resolves interference issues when the lid is closed.
> >
> > Signed-off-by: Jonathan Denose <jdenose@google.com>
> > ---
> >  drivers/hid/hid-multitouch.c | 32 +++++++++++++++++++++++++++++++-
> >  1 file changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
> > index 2879e65cf303b1456311ac06115adda5a78a2600..9a89913c193bc110a0a821a=
901aebd97892c66bd 100644
> > --- a/drivers/hid/hid-multitouch.c
> > +++ b/drivers/hid/hid-multitouch.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/device.h>
> >  #include <linux/hid.h>
> >  #include <linux/module.h>
> > +#include <linux/notifier.h>
> >  #include <linux/slab.h>
> >  #include <linux/input/mt.h>
> >  #include <linux/jiffies.h>
> > @@ -76,6 +77,7 @@ MODULE_LICENSE("GPL");
> >  #define MT_QUIRK_DISABLE_WAKEUP              BIT(21)
> >  #define MT_QUIRK_ORIENTATION_INVERT  BIT(22)
> >  #define MT_QUIRK_APPLE_TOUCHBAR              BIT(23)
> > +#define MT_QUIRK_REGISTER_LID_NOTIFIER BIT(24)
> >
> >  #define MT_INPUTMODE_TOUCHSCREEN     0x02
> >  #define MT_INPUTMODE_TOUCHPAD                0x03
> > @@ -183,6 +185,8 @@ struct mt_device {
> >       struct list_head reports;
> >  };
> >
> > +static struct hid_device *lid_notify_hdev;
>
> This should really be per-device.

Just to be sure I'm following correctly, the initialization of
lid_notify_hdev should be per-device?

> > +
> >  static void mt_post_parse_default_settings(struct mt_device *td,
> >                                          struct mt_application *app);
> >  static void mt_post_parse(struct mt_device *td, struct mt_application =
*app);
> > @@ -227,6 +231,7 @@ static void mt_post_parse(struct mt_device *td, str=
uct mt_application *app);
> >  #define MT_CLS_SMART_TECH                    0x0113
> >  #define MT_CLS_APPLE_TOUCHBAR                        0x0114
> >  #define MT_CLS_SIS                           0x0457
> > +#define MT_CLS_REGISTER_LID_NOTIFIER 0x0115
> >
> >  #define MT_DEFAULT_MAXCONTACT        10
> >  #define MT_MAX_MAXCONTACT    250
> > @@ -327,7 +332,9 @@ static const struct mt_class mt_classes[] =3D {
> >                       MT_QUIRK_CONTACT_CNT_ACCURATE |
> >                       MT_QUIRK_WIN8_PTP_BUTTONS,
> >               .export_all_inputs =3D true },
> > -
> > +     { .name =3D MT_CLS_REGISTER_LID_NOTIFIER,
> > +             .quirks =3D MT_QUIRK_REGISTER_LID_NOTIFIER,
> > +             .export_all_inputs =3D true },
> >       /*
> >        * vendor specific classes
> >        */
> > @@ -1840,6 +1847,20 @@ static void mt_expired_timeout(struct timer_list=
 *t)
> >       clear_bit_unlock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
> >  }
> >
> > +static int mt_input_notifier(struct notifier_block *nb, unsigned long =
action, void *dev)
> > +{
> > +     if (action)
> > +             mt_set_modes(lid_notify_hdev, HID_LATENCY_NORMAL, TOUCHPA=
D_REPORT_NONE);
> > +     else if (!action)
> > +             mt_set_modes(lid_notify_hdev, HID_LATENCY_NORMAL, TOUCHPA=
D_REPORT_ALL);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct notifier_block mt_lid_notifier_block =3D {
> > +     .notifier_call =3D mt_input_notifier
> > +};
> > +
> >  static int mt_probe(struct hid_device *hdev, const struct hid_device_i=
d *id)
> >  {
> >       int ret, i;
> > @@ -1920,6 +1941,11 @@ static int mt_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
> >       if (hdev->vendor =3D=3D USB_VENDOR_ID_SIS_TOUCH)
> >               hdev->quirks |=3D HID_QUIRK_NOGET;
> >
> > +     if (mtclass->quirks & MT_CLS_REGISTER_LID_NOTIFIER) {
> > +             lid_notify_hdev =3D hdev;
> > +             register_lid_notifier(&mt_lid_notifier_block);
> > +     }
> > +
> >       ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> >       if (ret)
> >               return ret;
> > @@ -2150,6 +2176,10 @@ static const struct hid_device_id mt_devices[] =
=3D {
> >               HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
> >                       USB_VENDOR_ID_ELAN, 0x32ae) },
> >
> > +     { .driver_data =3D MT_CLS_REGISTER_LID_NOTIFIER,
> > +             HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
> > +                     USB_VENDOR_ID_ELAN, 0x323b) },
>
> The need to have special handling of LID events is a quirk of board
> design, not quire of a controller. So I think it needs to be triggered
> by DMI quirk.
> > +
> >       /* Elitegroup panel */
> >       { .driver_data =3D MT_CLS_SERIAL,
> >               MT_USB_DEVICE(USB_VENDOR_ID_ELITEGROUP,
> >
>
> Thanks.
>
> --
> Dmitry
--=20
Jonathan

