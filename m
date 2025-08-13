Return-Path: <linux-kernel+bounces-767059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C36B24E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6989217A324
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A832820CB;
	Wed, 13 Aug 2025 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xe78x9+P"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B8281509
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100347; cv=none; b=SovSysZkC40JRJ0bgUg4cEUoyr0kW6lE9vFRlgzqd0Hw1rNPcgTQhAEIuMNQbTYqoGD45hy6+TFDRbxOU4aRjoZbO1mGv6oofo8DqEtZehDX3OkvdZ9i981SZBdNl+actMnnEXmD/nd6eVWo7Wby3Jyy3naPFH5z6Peu3Y734uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100347; c=relaxed/simple;
	bh=0lDPXnA29LfD994qiv4o/Yvav1c0prmIJcn30O4AZaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUBeOuFYTL35hMHNddHMwddYCG8MQtF77eZqP8DTEct9sxKWhey0kB0E7rpZ2XRCtfqjo/T6LFUWk/4N71dzq4wyIkVMnHH4oeawQHNTPrlQiLkkpdj4UNAWyPFpr50O3tomHNLMzbqhS9F4FqYAONZMUczUV1FohaneGj4FRJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xe78x9+P; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b109a95dddso298851cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755100344; x=1755705144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdEc+IFHh0oMz2sSa9Ktoes106zQC0q/gblI8k1FPsE=;
        b=xe78x9+PdLZ8zEOITYa+NfBgF5n6/RItmF6LfbHKzm6FDB0f98PZttTe9eQILZZy5b
         Y/VpAGCGEHRvtSRg+Y49rmnsXzyAG5WIQyQzO0oyiQDhZyEgo2OVWISCaDWsBKBlqhBn
         TsOWGv3ehzUtP4tsY05kCq7owWInc6MZCaf6swGx2Y8LBJrnlTlv61F9pK89X7vMbs3o
         67jG8XuVS2TiWh3QCuTM0t4n3vIJ5e8gp3DH88hH98iYSoyleZZwT9t9t8coBmCW/k2j
         AwV+FJ6K3kysot2o/oUD/QjPBU2nOT+ma2+6ItYQzuAA+r5UOOoWy/Fhv4W8IFYYimiE
         m1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100344; x=1755705144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdEc+IFHh0oMz2sSa9Ktoes106zQC0q/gblI8k1FPsE=;
        b=kRIUi0T6K7Q/FUtkYVQubIv8757MLVZtqyLSqUSo1+RoYVGEapfEVbqsaxBSHHbjh6
         +bYlZgZ8ZSS+EDwIatRQ9Zx1K6CHNdlcItBMUo+8YWLuoV23HEJBzd/hR1rtXSOgVKwd
         4uda9hBG7B90q8ZXXavw4sdRUO3uiH3UVMgWlRlGXUbK90i1pEU3nUGhJt5rBhIA4qA1
         YWQIifoQi1oD4nRDZl5HM5uT0rptyhfvSCTblfEF7kEOsR66fGNqu9T65G3BStQsMR88
         //WCf1cLF7exlFreTHEpbPMuFDJojrBmbAgFE/EGP2Ud3C6pXLdDU2RN/ylFm2w8eyvq
         +rnw==
X-Forwarded-Encrypted: i=1; AJvYcCWW3zQOOaubwAATQlScAj60Sg+IVmF2qh/dsjn1R0d2ia9krsgZ/A0Yj96BfK0pAPzPQG5eX/G+4hsQeR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrvvArGdD+MDLwiKQ1z1yBUmRSI7NIVl43ytyGfM1Cp9J2ilWg
	k5bib1OM3PWJeHE0pNy/vqpbmVeWlLQsgoAX/cRu5W6nzMAuoxPqh+VWg7JFoznv3MXaqJXTrZy
	Dj2eEzgCvMhj5SJisZjgw5a8cKNarSQEQ9YCV3wIN
X-Gm-Gg: ASbGncsDvpsi6SXLVVoPyJY7xIsYeeZVrTsMtZV9ZDQ9/lSf60t8ChyM2DfuFdP/Y28
	iBVxJ6zhMdC9D/ujgnC3okmcK/Vwlig8vcl1sje8Y1eAZjGZjdF31Ck11GJx0CxYPEgBuzzgm7P
	FozYlWQcThnljRtVTg5P5CWJh4RZqlEq19nDuxIgFGcT0tJHApGMOgg7jjHtX3zL26QU1G9oRDb
	joRxdOI9P1cVyJLFkCUj+yc2PmDz1Z1LWsom7ThZlZEF86npGc=
X-Google-Smtp-Source: AGHT+IHoK16+w0OxmN4RReeqz1kk/bu/LJMfIvfPBSuCM9CzqWwdBv8GNO1Fa4fdnqc7aE4WK58+gkev9zsJ0zynwX4=
X-Received: by 2002:a05:622a:4e9b:b0:4af:f25d:e2b0 with SMTP id
 d75a77b69052e-4b0fc6f77edmr47910241cf.8.1755100343958; Wed, 13 Aug 2025
 08:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804-support-forcepads-v2-0-138ca980261d@google.com>
 <20250804-support-forcepads-v2-11-138ca980261d@google.com> <kmjgxgsdh26okjvhbezl7uskedv3ybio2v6qk3zynlswkxaw4e@dhb43oyrxp44>
In-Reply-To: <kmjgxgsdh26okjvhbezl7uskedv3ybio2v6qk3zynlswkxaw4e@dhb43oyrxp44>
From: Jonathan Denose <jdenose@google.com>
Date: Wed, 13 Aug 2025 10:52:13 -0500
X-Gm-Features: Ac12FXzlUg9FNy0jJVvJjA0JYvVZ7y-xCQKbrZkvoVpVIGKcATYdWgs8Ot5ccuc
Message-ID: <CAMCVhVOh595PThqfd=AnSDGJhsMUzCLsLxTUPKBR3mOUrq2LnA@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] HID: multitouch: add haptic multitouch support
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Angela Czubak <aczubak@google.com>, "Sean O'Brien" <seobrien@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 4:22=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> On Aug 04 2025, Jonathan Denose wrote:
> > From: Angela Czubak <aczubak@google.com>
> >
> > Add new option (MULTITOUCH_HAPTIC) to mark whether hid-multitouch
> > should try and configure simple haptic device.
> > Once this option is configured, and the device is recognized to have si=
mple
> > haptic capabilities, check input frames for pressure and handle it usin=
g
> > hid_haptic_* API.
>
> Why creating a new option? It seems it'll add unwanted work from
> distributions when we should have something that "just works" no?
>
> It makes sense to depend on FF, but adding a new option is probably
> useless IMO.
>
> >
> > Signed-off-by: Angela Czubak <aczubak@google.com>
> > Co-developed-by: Jonathan Denose <jdenose@google.com>
> > Signed-off-by: Jonathan Denose <jdenose@google.com>
> > ---
> >  drivers/hid/Kconfig          |  11 ++++
> >  drivers/hid/Makefile         |   2 +-
> >  drivers/hid/hid-haptic.h     |  52 +++++++++++++++++
> >  drivers/hid/hid-multitouch.c | 136 +++++++++++++++++++++++++++++++++++=
+++++++-
> >  4 files changed, 199 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index ad6bcc4248cc111705d7cfde2b1481b46353e2d7..b7452f11a4f914f92af582e=
d054d42ecbcd6cb9e 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -817,6 +817,17 @@ config HID_MULTITOUCH
> >         To compile this driver as a module, choose M here: the
> >         module will be called hid-multitouch.
> >
> > +config MULTITOUCH_HAPTIC
> > +     bool "Simple haptic multitouch support"
> > +     depends on HID_MULTITOUCH
> > +     select HID_HAPTIC
> > +     default n
> > +     help
> > +     Support for simple multitouch haptic devices.
> > +     Adds extra parsing and FF device for the hid multitouch driver.
> > +     It can be used for Elan 2703 haptic touchpad.
> > +     To enable, say Y.
> > +
> >  config HID_NINTENDO
> >       tristate "Nintendo Joy-Con, NSO, and Pro Controller support"
> >       depends on NEW_LEDS
> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > index 361a7daedeb85454114def8afb5f58caeab58a00..be09b4f13b2058a0a1d7eab=
79f35def758120fc4 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -4,7 +4,7 @@
> >  #
> >  hid-y                        :=3D hid-core.o hid-input.o hid-quirks.o
> >  hid-$(CONFIG_DEBUG_FS)               +=3D hid-debug.o
> > -hid-$(CONFIG_HID_HAPTIC)     +=3D hid-haptic.o
> > +hid-$(CONFIG_MULTITOUCH_HAPTIC)      +=3D hid-haptic.o
> >
> >  obj-$(CONFIG_HID_BPF)                +=3D bpf/
> >
> > diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
> > index 0a34b0c6d706a985630962acc41f7a8eb73cd343..808cec0b4e51eba1f58b839=
f3e552493655b7899 100644
> > --- a/drivers/hid/hid-haptic.h
> > +++ b/drivers/hid/hid-haptic.h
> > @@ -58,6 +58,7 @@ struct hid_haptic_device {
> >       struct hid_haptic_effect stop_effect;
> >  };
> >
> > +#ifdef CONFIG_MULTITOUCH_HAPTIC
>
> There is something wrong with your ifdef usages:
> - here, you define the functions below conditionally to
>         CONFIG_MULTITOUCH_HAPTIC, which is fine
> - but in hid-multitouch, you also check for CONFIG_MULTITOUCH_HAPTIC
>         before calling the same set of functions.
>
> Either only define the haptic functions when CONFIG_MULTITOUCH_HAPTIC is
> set, and in multitouch check for that define, or define it conditionally
> and remove the checks in hid-multitouch (but probably add a comment).
> >  void hid_haptic_feature_mapping(struct hid_device *hdev,
> >                               struct hid_haptic_device *haptic,
> >                               struct hid_field *field, struct hid_usage
> > @@ -77,3 +78,54 @@ void hid_haptic_handle_press_release(struct hid_hapt=
ic_device *haptic);
> >  void hid_haptic_pressure_reset(struct hid_haptic_device *haptic);
> >  void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
> >                                 __s32 pressure);
> > +#else
> > +static inline
> > +void hid_haptic_feature_mapping(struct hid_device *hdev,
> > +                             struct hid_haptic_device *haptic,
> > +                             struct hid_field *field, struct hid_usage
> > +                             *usage)
> > +{}
> > +static inline
> > +bool hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
> > +                                 struct hid_input *hi, struct hid_fiel=
d *field)
> > +{
> > +     return false;
> > +}
> > +static inline
> > +int hid_haptic_input_mapping(struct hid_device *hdev,
> > +                          struct hid_haptic_device *haptic,
> > +                          struct hid_input *hi,
> > +                          struct hid_field *field, struct hid_usage *u=
sage,
> > +                          unsigned long **bit, int *max)
> > +{
> > +     return 0;
> > +}
> > +static inline
> > +int hid_haptic_input_configured(struct hid_device *hdev,
> > +                             struct hid_haptic_device *haptic,
> > +                             struct hid_input *hi)
> > +{
> > +     return 0;
> > +}
> > +static inline
> > +void hid_haptic_reset(struct hid_device *hdev, struct hid_haptic_devic=
e *haptic)
> > +{}
> > +static inline
> > +int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device =
**haptic_ptr)
> > +{
> > +     return 0;
> > +}
> > +static inline
> > +void hid_haptic_handle_press_release(struct hid_haptic_device *haptic)=
 {}
> > +static inline
> > +bool hid_haptic_handle_input(struct hid_haptic_device *haptic)
> > +{
> > +     return false;
> > +}
> > +static inline
> > +void hid_haptic_pressure_reset(struct hid_haptic_device *haptic) {}
> > +static inline
> > +void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
> > +                               __s32 pressure)
> > +{}
> > +#endif
> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
> > index b41001e02da7e02d492bd85743b359ed7ec16e7f..4ff9ac5022b13a0739dbc7a=
e5f6ebd84f0114a73 100644
> > --- a/drivers/hid/hid-multitouch.c
> > +++ b/drivers/hid/hid-multitouch.c
> > @@ -49,6 +49,8 @@ MODULE_LICENSE("GPL");
> >
> >  #include "hid-ids.h"
> >
> > +#include "hid-haptic.h"
> > +
> >  /* quirks to control the device */
> >  #define MT_QUIRK_NOT_SEEN_MEANS_UP   BIT(0)
> >  #define MT_QUIRK_SLOT_IS_CONTACTID   BIT(1)
> > @@ -167,11 +169,13 @@ struct mt_report_data {
> >  struct mt_device {
> >       struct mt_class mtclass;        /* our mt device class */
> >       struct timer_list release_timer;        /* to release sticky fing=
ers */
> > +     struct hid_haptic_device *haptic;       /* haptic related configu=
ration */
> >       struct hid_device *hdev;        /* hid_device we're attached to *=
/
> >       unsigned long mt_io_flags;      /* mt flags (MT_IO_FLAGS_*) */
> >       __u8 inputmode_value;   /* InputMode HID feature value */
> >       __u8 maxcontacts;
> >       bool is_buttonpad;      /* is this device a button pad? */
> > +     bool is_haptic_touchpad;        /* is this device a haptic touchp=
ad? */
> >       bool serial_maybe;      /* need to check for serial protocol */
> >
> >       struct list_head applications;
> > @@ -490,6 +494,95 @@ static void mt_get_feature(struct hid_device *hdev=
, struct hid_report *report)
> >       kfree(buf);
> >  }
> >
> > +#if defined(CONFIG_MULTITOUCH_HAPTIC)
> > +static int mt_haptic_init(struct hid_device *hdev,
> > +                             struct hid_haptic_device **haptic_ptr)
> > +{
> > +     return hid_haptic_init(hdev, haptic_ptr);
> > +}
> > +
> > +static void mt_haptic_feature_mapping(struct hid_device *hdev,
> > +                             struct hid_haptic_device *haptic,
> > +                             struct hid_field *field, struct hid_usage=
 *usage)
> > +{
> > +     return hid_haptic_feature_mapping(hdev, haptic, field, usage);
> > +}
> > +
> > +static bool mt_haptic_check_pressure_unit(struct hid_haptic_device *ha=
ptic,
> > +                                 struct hid_input *hi, struct hid_fiel=
d *field)
> > +{
> > +     return hid_haptic_check_pressure_unit(haptic, hi, field);
> > +}
> > +
> > +static void mt_haptic_pressure_reset(struct hid_haptic_device *haptic)
> > +{
> > +     return hid_haptic_pressure_reset(haptic);
> > +}
> > +
> > +static void mt_haptic_pressure_increase(struct hid_haptic_device *hapt=
ic,
> > +                              __s32 pressure)
> > +{
> > +     return hid_haptic_pressure_increase(haptic, pressure);
> > +}
> > +
> > +static int mt_haptic_input_mapping(struct hid_device *hdev,
> > +                          struct hid_haptic_device *haptic,
> > +                          struct hid_input *hi,
> > +                          struct hid_field *field, struct hid_usage *u=
sage,
> > +                          unsigned long **bit, int *max)
> > +{
> > +     return hid_haptic_input_mapping(hdev, haptic, hi, field, usage, b=
it, max);
> > +}
> > +
> > +static int mt_haptic_input_configured(struct hid_device *hdev,
> > +                             struct hid_haptic_device *haptic,
> > +                             struct hid_input *hi)
> > +{
> > +     return hid_haptic_input_configured(hdev, haptic, hi);
> > +}
> > +#else
> > +static int mt_haptic_init(struct hid_device *hdev,
> > +                             struct hid_haptic_device **haptic_ptr)
> > +{
> > +     return 0;
> > +}
> > +
> > +static void mt_haptic_feature_mapping(struct hid_device *hdev,
> > +                             struct hid_haptic_device *haptic,
> > +                             struct hid_field *field, struct hid_usage=
 *usage)
> > +{}
> > +
> > +static bool mt_haptic_check_pressure_unit(struct hid_haptic_device *ha=
ptic,
> > +                                 struct hid_input *hi, struct hid_fiel=
d *field)
> > +{
> > +     return 0;
> > +}
> > +
> > +static void mt_haptic_pressure_reset(struct hid_haptic_device *haptic)
> > +{}
> > +
> > +static void mt_haptic_pressure_increase(struct hid_haptic_device *hapt=
ic,
> > +                              __s32 pressure)
> > +{}
> > +
> > +static int mt_haptic_input_mapping(struct hid_device *hdev,
> > +                          struct hid_haptic_device *haptic,
> > +                          struct hid_input *hi,
> > +                          struct hid_field *field, struct hid_usage *u=
sage,
> > +                          unsigned long **bit, int *max)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int mt_haptic_input_configured(struct hid_device *hdev,
> > +                             struct hid_haptic_device *haptic,
> > +                             struct hid_input *hi)
> > +{
> > +     return 0;
> > +}
> > +#endif
> > +
> > +
> >  static void mt_feature_mapping(struct hid_device *hdev,
> >               struct hid_field *field, struct hid_usage *usage)
> >  {
> > @@ -525,6 +618,8 @@ static void mt_feature_mapping(struct hid_device *h=
dev,
> >                       mt_get_feature(hdev, field->report);
> >               break;
> >       }
> > +
> > +     mt_haptic_feature_mapping(hdev, td->haptic, field, usage);
> >  }
> >
> >  static void set_abs(struct input_dev *input, unsigned int code,
> > @@ -856,6 +951,9 @@ static int mt_touch_input_mapping(struct hid_device=
 *hdev, struct hid_input *hi,
> >               case HID_DG_TIPPRESSURE:
> >                       set_abs(hi->input, ABS_MT_PRESSURE, field,
> >                               cls->sn_pressure);
> > +                     td->is_haptic_touchpad =3D
> > +                             mt_haptic_check_pressure_unit(td->haptic,
> > +                                                            hi, field)=
;
> >                       MT_STORE_FIELD(p);
> >                       return 1;
> >               case HID_DG_SCANTIME:
> > @@ -980,6 +1078,8 @@ static void mt_sync_frame(struct mt_device *td, st=
ruct mt_application *app,
> >
> >       app->num_received =3D 0;
> >       app->left_button_state =3D 0;
> > +     if (td->is_haptic_touchpad)
> > +             mt_haptic_pressure_reset(td->haptic);
> >
> >       if (test_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags))
> >               set_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
> > @@ -1137,6 +1237,9 @@ static int mt_process_slot(struct mt_device *td, =
struct input_dev *input,
> >                       minor =3D minor >> 1;
> >               }
> >
> > +             if (td->is_haptic_touchpad)
> > +                     mt_haptic_pressure_increase(td->haptic, *slot->p)=
;
> > +
> >               x =3D hdev->quirks & HID_QUIRK_X_INVERT ?
> >                       input_abs_get_max(input, ABS_MT_POSITION_X) - *sl=
ot->x :
> >                       *slot->x;
> > @@ -1324,6 +1427,9 @@ static int mt_touch_input_configured(struct hid_d=
evice *hdev,
> >       if (cls->is_indirect)
> >               app->mt_flags |=3D INPUT_MT_POINTER;
> >
> > +     if (td->is_haptic_touchpad)
> > +             app->mt_flags |=3D INPUT_MT_TOTAL_FORCE;
> > +
> >       if (app->quirks & MT_QUIRK_NOT_SEEN_MEANS_UP)
> >               app->mt_flags |=3D INPUT_MT_DROP_UNUSED;
> >
> > @@ -1359,6 +1465,7 @@ static int mt_input_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
> >       struct mt_device *td =3D hid_get_drvdata(hdev);
> >       struct mt_application *application;
> >       struct mt_report_data *rdata;
> > +     int ret;
> >
> >       rdata =3D mt_find_report_data(td, field->report);
> >       if (!rdata) {
> > @@ -1421,6 +1528,11 @@ static int mt_input_mapping(struct hid_device *h=
dev, struct hid_input *hi,
> >       if (field->physical =3D=3D HID_DG_STYLUS)
> >               hi->application =3D HID_DG_STYLUS;
> >
> > +     ret =3D mt_haptic_input_mapping(hdev, td->haptic, hi, field, usag=
e, bit,
> > +                                    max);
> > +     if (ret !=3D 0)
> > +             return ret;
> > +
> >       /* let hid-core decide for the others */
> >       return 0;
> >  }
> > @@ -1635,6 +1747,14 @@ static int mt_input_configured(struct hid_device=
 *hdev, struct hid_input *hi)
> >       struct hid_report *report;
> >       int ret;
> >
> > +     if (td->is_haptic_touchpad && (td->mtclass.name =3D=3D MT_CLS_WIN=
_8 ||
> > +         td->mtclass.name =3D=3D MT_CLS_WIN_8_FORCE_MULTI_INPUT)) {
> > +             if (mt_haptic_input_configured(hdev, td->haptic, hi) =3D=
=3D 0)
> > +                     td->is_haptic_touchpad =3D false;
> > +     } else {
> > +             td->is_haptic_touchpad =3D false;
> > +     }
> > +
> >       list_for_each_entry(report, &hi->reports, hidinput_list) {
> >               rdata =3D mt_find_report_data(td, report);
> >               if (!rdata) {
> > @@ -1764,7 +1884,6 @@ static int mt_probe(struct hid_device *hdev, cons=
t struct hid_device_id *id)
> >       int ret, i;
> >       struct mt_device *td;
> >       const struct mt_class *mtclass =3D mt_classes; /* MT_CLS_DEFAULT =
*/
> > -
>
> unrelated change (line removed).
>
> >       for (i =3D 0; mt_classes[i].name ; i++) {
> >               if (id->driver_data =3D=3D mt_classes[i].name) {
> >                       mtclass =3D &(mt_classes[i]);
> > @@ -1777,6 +1896,10 @@ static int mt_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
> >               dev_err(&hdev->dev, "cannot allocate multitouch data\n");
> >               return -ENOMEM;
> >       }
> > +     td->haptic =3D kzalloc(sizeof(*(td->haptic)), GFP_KERNEL);
>
> Please make use of the devm api, you are leaking the allocated memory in
> the regular case (AFAICT).
>
> > +     if (!td->haptic)
> > +             return -ENOMEM;
>
> One extra blank line wouldn't hurt here :)
>
> > +     td->haptic->hdev =3D hdev;
> >       td->hdev =3D hdev;
> >       td->mtclass =3D *mtclass;
> >       td->inputmode_value =3D MT_INPUTMODE_TOUCHSCREEN;
> > @@ -1840,6 +1963,17 @@ static int mt_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
> >
> >       mt_set_modes(hdev, HID_LATENCY_NORMAL, TOUCHPAD_REPORT_ALL);
> >
> > +     if (td->is_haptic_touchpad) {
> > +             if (mt_haptic_init(hdev, &td->haptic)) {
> > +                     dev_warn(&hdev->dev, "Cannot allocate haptic for =
%s\n",
> > +                              hdev->name);
> > +                     td->is_haptic_touchpad =3D false;
> > +                     kfree(td->haptic);
> > +             }
> > +     } else {
> > +             kfree(td->haptic);
> > +     }
> > +
> >       return 0;
> >  }
> >
> >
> > --
> > 2.50.1.565.gc32cd1483b-goog
> >
>
> Cheers,
> Benjamin
I'll make the changes and send out a new version.

Thanks for your review!
--=20
Jonathan

