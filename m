Return-Path: <linux-kernel+bounces-898225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9410CC54A20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC9184E1E13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D0D2E1726;
	Wed, 12 Nov 2025 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjiN4n1w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V20FzSVl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1130D2DC338
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983430; cv=none; b=e9N1Q8WUvnE2HlphDxkleq5fDl9atoosVOjCfAUACLfisDMcJTWAhAFeBHqp5dluE5oVgspDZ8WHzrrTD7WQej1HGe7nkVhtvtBNAxUYr/w/IITfzR4zxXnSx3CD7vrmw2iwmpyv6A7a693ZnDTJW+GkyaWCmiWH4AwO+iJJ0/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983430; c=relaxed/simple;
	bh=dKhBf552At/bF2QNHyOl05JIDSW6vZQi2tUcI5W2ts0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhWDVxeuXuOh9p4/Qta6e5baU102wGBUh83tno/YJ58AxdzIHksfUXT9K2SRTM2yCbwUG4Y7KqFneHFaPoIzP7G6OukyusMhwHEX+7iW9tf6wvjLIGYIhfC+MfMzKh4aRzXlTU68ieHI+qEVevQAHX81vLcaHV2WlPbeTqiIVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjiN4n1w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V20FzSVl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762983426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tYciv5xTheTRzllZ894SH6EgI4YNILIAz81lyocP4jQ=;
	b=UjiN4n1wx3q8J/ACJkUN3GVxDb4gsdWOz3TMlb7YKAbJtk85JOpiQbN5B14Y+Frqsdz2Cx
	+qW+dWJ6OVnrXPWMr026Tlkdzp/EChu39NqwQIyS48Dxv0WFj4R1lgPRMZf3BCZYGP9Tf8
	8V8c8B89OHjX/1lK8onLo1f4UyWlDQY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-d_oa3DJjPhSL29AviDFfAQ-1; Wed, 12 Nov 2025 16:37:04 -0500
X-MC-Unique: d_oa3DJjPhSL29AviDFfAQ-1
X-Mimecast-MFC-AGG-ID: d_oa3DJjPhSL29AviDFfAQ_1762983423
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4776079ada3so1115175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762983423; x=1763588223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYciv5xTheTRzllZ894SH6EgI4YNILIAz81lyocP4jQ=;
        b=V20FzSVloHuN8qGlsN5pn5GgmQlc//qEZqAtdpdc3PoWtnm2O85cbNfsds5AbVZgDI
         0FJdGS1oe7gt/2OgpQrKPy/CQVKKX4u8tKULaGHk3MyzG1UYEzvBrqGXTMu3mlM1HN2v
         MIKVfwUroMC5DnGzcqyaC2mtYY5csm5RO4yoXoY6ejV05aPpSrCK53Iqn7oVcx3z/neZ
         9aepb2DQRj7QOd3BRNcj6jGm/iiXxrEb2ANrZsmKMfCScyQkS4u+AVviFdJ58adBCO9c
         2VHGW9pWUxvAF8KQXG5Lbm5L4CUsPOHHWTe7CTQE1ESSk33xXXAPVEx/IiwNFu69Wg4c
         dV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762983423; x=1763588223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tYciv5xTheTRzllZ894SH6EgI4YNILIAz81lyocP4jQ=;
        b=OI+0zb4AtTFnMJbjteCLbGy/bJhzfSrnA4RUr6pF7xjKs4NTA9kkgCGDXXY0FCWgnh
         NpEtHfa9wc8mM+pHiAjfU7vHb+8xT2Ur+2MYl40kyLjuxBm0Wtu3dRPB/+TtZxGqgZzu
         1Nf0NxCKm+a9PGiIVZChl371J56EKGTSiimGL3lcujX6u+NLa3d2CFy9xSyqMXfFbnZr
         2EM47tkXF8axOFfS4StJcBiJ6nHLnZ42JwqLFFdYX8PbO7k+mxtes7UnBv47wOmuLLkN
         AAgwVyKsYT3ywV5GwRRb8d1M1Drsi8r87Men1ZNs2xPLAHLcPzfOW7HyNE4nUXfPW+er
         siig==
X-Forwarded-Encrypted: i=1; AJvYcCXW6FqUG8NimEso6JudwRQ5os/rV0Z64vl3M5iMqMTd0AXKuJd0CU/DzH7t0Ncka56vvgh3rr25IMMgWSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+FmJ9uDeq7rk9zhoFRTBp4McbQ1d55lF+wFroqNf1ot+1sP22
	EdmzNVcqYYRtS15MjtIov2b4NZgjedaJyUIBoLxfpzZYTTIZc6rgt+Lf8N4JTg2pRcVEh9naLci
	pqAC5pi7xr37EtPsldyNz2RI2XQIG1+O1zyRKOzv6RHzJvHk/80QFheLTldKewZChZIIjxP6lAQ
	Yg0jE9cZuBIKhO9OhdK5ctbdRjA99Zp2+PFS3HzwjKf+MQNUGH/84=
X-Gm-Gg: ASbGncuG1sb3gZzj/p1U+24odbOUElV8YInzJkyGrxZoXj8yVuRdgZhy82LR9CpCWFD
	2bvGwsIyEVvlY+fJ9v1fT40sM67OEpNRR4fC7Dkff/bDjlR3cVJg/fhIbdJjA74cZXTTzwerHIf
	njAXA1aUCDhCzmDH8gmo18wJzl8wmr8vyk7M1Qa+Ywu23DZUAHVaKKbAOPLEGrHDz1f5nTqEtmY
	5WaIXU2W7zdxfGjiQ==
X-Received: by 2002:a05:600c:1c8e:b0:477:6e02:54a5 with SMTP id 5b1f17b1804b1-47787086f75mr39343805e9.18.1762983422758;
        Wed, 12 Nov 2025 13:37:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHj0h0LWmUgvvEg+u9hyLIcRNCuaz2YMcpA+S1tevmdEIAm7MRyqt5sPcYjJwAvASPVz7118eNGcgVCLPDAtac=
X-Received: by 2002:a05:600c:1c8e:b0:477:6e02:54a5 with SMTP id
 5b1f17b1804b1-47787086f75mr39343595e9.18.1762983422243; Wed, 12 Nov 2025
 13:37:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111105634.1684751-1-lzampier@redhat.com> <20251111105634.1684751-2-lzampier@redhat.com>
 <82ec5223f83eaa89278997fe95ee9ea83236a4a1.camel@hadess.net>
In-Reply-To: <82ec5223f83eaa89278997fe95ee9ea83236a4a1.camel@hadess.net>
From: Lucas Zampieri <lzampier@redhat.com>
Date: Wed, 12 Nov 2025 21:36:51 +0000
X-Gm-Features: AWmQ_bn01Psq5ifqjk_KX3K_rkAwkdFEyTAkgg0BJTsvidHSbXouhyKQCPUdKaw
Message-ID: <CAOOg__Ds=0EU=pS3ZxYONSqr1rncmz89pn1RpRbgTqvtTdRXgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] HID: input: Add support for multiple batteries
 per device
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Bastien,

On Wed, Nov 12, 2025 at 2:46=E2=80=AFPM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> Hey Lucas,
>
> (Follow-up to a chat we had about this patch privately)
>
> On Tue, 2025-11-11 at 10:56 +0000, Lucas Zampieri wrote:
> > Add support for multiple batteries per HID device by introducing
> > struct hid_battery to encapsulate individual battery state and using
> > a list to track multiple batteries identified by report ID. The
> > legacy
> > dev->battery field is maintained for backwards compatibility.
>
> The cover letter mentions specific hardware, you probably want to
> mention this in the commit message itself, as the cover letter will be
> disconnected from this commit once this gets merged. Don't hesitate to
> link to product pages directly if you want to show specific products as
> potential users of that capability.
>
Got it, I'll update the commits in the v2 with that in mind.

> You mentioned that you tested this patchset with a custom firmware for
> a split keyboard. It would be great if the firmware could be made
> available to show how this was tested and mention that in the commit
> message.
>
I've pushed my custom firmware to
https://github.com/zampierilucas/zmk/tree/feat/individual-hid-battery-repor=
ting,
if this series gets merged, I'll also propose that change to upstream
zmk project.
I'll also add links to in the v2 of the cover-letter

> bentiss will also likely want a hid-recorder output for the device that
> shows the batteries being instantiated. This would also likely be used
> to test whether upower continues working as expected.
>
Ack, I'll get the hid-recorder output and add to the testing section
of my cover letter.

> Talking of upower, I think we'll need an systemd/hwdb + upower changes
> to differentiate batteries within a single device, as I don't think we
> can have enough metadata in the HID report to differentiate them.
>
> Last comment about the patch itself, do you think it would be feasible
> to split this in 2 or 3? One to introduce the hid_battery struct,
> another to use it to replace direct power_supply access, and finally
> one to allow a list of hid_batteries?
>
> Don't hesitate to CC: on future versions.
>
For sure, thanks for the feedback

> Cheers
>
> >
> > Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> > ---
> >  drivers/hid/hid-core.c  |   4 +
> >  drivers/hid/hid-input.c | 193 +++++++++++++++++++++++++++-----------
> > --
> >  include/linux/hid.h     |  42 ++++++++-
> >  3 files changed, 176 insertions(+), 63 deletions(-)
> >
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index a5b3a8ca2fcb..76d628547e9a 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2990,6 +2990,10 @@ struct hid_device *hid_allocate_device(void)
> >       mutex_init(&hdev->ll_open_lock);
> >       kref_init(&hdev->ref);
> >
> > +#ifdef CONFIG_HID_BATTERY_STRENGTH
> > +     INIT_LIST_HEAD(&hdev->batteries);
> > +#endif
> > +
> >       ret =3D hid_bpf_device_init(hdev);
> >       if (ret)
> >               goto out_err;
> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > index e56e7de53279..071df319775b 100644
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -454,7 +454,8 @@ static int hidinput_get_battery_property(struct
> > power_supply *psy,
> >                                        enum power_supply_property
> > prop,
> >                                        union power_supply_propval
> > *val)
> >  {
> > -     struct hid_device *dev =3D power_supply_get_drvdata(psy);
> > +     struct hid_battery *bat =3D power_supply_get_drvdata(psy);
> > +     struct hid_device *dev =3D bat->dev;
> >       int value;
> >       int ret =3D 0;
> >
> > @@ -465,13 +466,13 @@ static int hidinput_get_battery_property(struct
> > power_supply *psy,
> >               break;
> >
> >       case POWER_SUPPLY_PROP_CAPACITY:
> > -             if (dev->battery_status !=3D HID_BATTERY_REPORTED &&
> > -                 !dev->battery_avoid_query) {
> > +             if (bat->status !=3D HID_BATTERY_REPORTED &&
> > +                 !bat->avoid_query) {
> >                       value =3D
> > hidinput_query_battery_capacity(dev);
> >                       if (value < 0)
> >                               return value;
> >               } else  {
> > -                     value =3D dev->battery_capacity;
> > +                     value =3D bat->capacity;
> >               }
> >
> >               val->intval =3D value;
> > @@ -482,20 +483,20 @@ static int hidinput_get_battery_property(struct
> > power_supply *psy,
> >               break;
> >
> >       case POWER_SUPPLY_PROP_STATUS:
> > -             if (dev->battery_status !=3D HID_BATTERY_REPORTED &&
> > -                 !dev->battery_avoid_query) {
> > +             if (bat->status !=3D HID_BATTERY_REPORTED &&
> > +                 !bat->avoid_query) {
> >                       value =3D
> > hidinput_query_battery_capacity(dev);
> >                       if (value < 0)
> >                               return value;
> >
> > -                     dev->battery_capacity =3D value;
> > -                     dev->battery_status =3D HID_BATTERY_QUERIED;
> > +                     bat->capacity =3D value;
> > +                     bat->status =3D HID_BATTERY_QUERIED;
> >               }
> >
> > -             if (dev->battery_status =3D=3D HID_BATTERY_UNKNOWN)
> > +             if (bat->status =3D=3D HID_BATTERY_UNKNOWN)
> >                       val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> >               else
> > -                     val->intval =3D dev->battery_charge_status;
> > +                     val->intval =3D bat->charge_status;
> >               break;
> >
> >       case POWER_SUPPLY_PROP_SCOPE:
> > @@ -513,33 +514,53 @@ static int hidinput_get_battery_property(struct
> > power_supply *psy,
> >  static int hidinput_setup_battery(struct hid_device *dev, unsigned
> > report_type,
> >                                 struct hid_field *field, bool
> > is_percentage)
> >  {
> > +     struct hid_battery *bat;
> >       struct power_supply_desc *psy_desc;
> > -     struct power_supply_config psy_cfg =3D { .drv_data =3D dev, };
> > +     struct power_supply_config psy_cfg;
> >       unsigned quirks;
> >       s32 min, max;
> >       int error;
> > +     int battery_num =3D 0;
> >
> > -     if (dev->battery)
> > -             return 0;       /* already initialized? */
> > +     list_for_each_entry(bat, &dev->batteries, list) {
> > +             if (bat->report_id =3D=3D field->report->id)
> > +                     return 0;       /* already initialized */
> > +             battery_num++;
> > +     }
> >
> >       quirks =3D find_battery_quirk(dev);
> >
> > -     hid_dbg(dev, "device %x:%x:%x %d quirks %d\n",
> > -             dev->bus, dev->vendor, dev->product, dev->version,
> > quirks);
> > +     hid_dbg(dev, "device %x:%x:%x %d quirks %d report_id %d\n",
> > +             dev->bus, dev->vendor, dev->product, dev->version,
> > quirks,
> > +             field->report->id);
> >
> >       if (quirks & HID_BATTERY_QUIRK_IGNORE)
> >               return 0;
> >
> > -     psy_desc =3D kzalloc(sizeof(*psy_desc), GFP_KERNEL);
> > -     if (!psy_desc)
> > +     bat =3D kzalloc(sizeof(*bat), GFP_KERNEL);
> > +     if (!bat)
> >               return -ENOMEM;
> >
> > -     psy_desc->name =3D kasprintf(GFP_KERNEL, "hid-%s-battery",
> > -                                strlen(dev->uniq) ?
> > -                                     dev->uniq : dev_name(&dev-
> > >dev));
> > +     psy_desc =3D kzalloc(sizeof(*psy_desc), GFP_KERNEL);
> > +     if (!psy_desc) {
> > +             error =3D -ENOMEM;
> > +             goto err_free_bat;
> > +     }
> > +
> > +     /* Create unique name for each battery based on report ID */
> > +     if (battery_num =3D=3D 0) {
> > +             psy_desc->name =3D kasprintf(GFP_KERNEL, "hid-%s-
> > battery",
> > +                                        strlen(dev->uniq) ?
> > +                                             dev->uniq :
> > dev_name(&dev->dev));
> > +     } else {
> > +             psy_desc->name =3D kasprintf(GFP_KERNEL, "hid-%s-
> > battery-%d",
> > +                                        strlen(dev->uniq) ?
> > +                                             dev->uniq :
> > dev_name(&dev->dev),
> > +                                        battery_num);
> > +     }
> >       if (!psy_desc->name) {
> >               error =3D -ENOMEM;
> > -             goto err_free_mem;
> > +             goto err_free_desc;
> >       }
> >
> >       psy_desc->type =3D POWER_SUPPLY_TYPE_BATTERY;
> > @@ -559,98 +580,148 @@ static int hidinput_setup_battery(struct
> > hid_device *dev, unsigned report_type,
> >       if (quirks & HID_BATTERY_QUIRK_FEATURE)
> >               report_type =3D HID_FEATURE_REPORT;
> >
> > -     dev->battery_min =3D min;
> > -     dev->battery_max =3D max;
> > -     dev->battery_report_type =3D report_type;
> > -     dev->battery_report_id =3D field->report->id;
> > -     dev->battery_charge_status =3D
> > POWER_SUPPLY_STATUS_DISCHARGING;
> > +     /* Initialize battery structure */
> > +     bat->dev =3D dev;
> > +     bat->min =3D min;
> > +     bat->max =3D max;
> > +     bat->report_type =3D report_type;
> > +     bat->report_id =3D field->report->id;
> > +     bat->charge_status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > +     bat->status =3D HID_BATTERY_UNKNOWN;
> >
> >       /*
> >        * Stylus is normally not connected to the device and thus
> > we
> >        * can't query the device and get meaningful battery
> > strength.
> >        * We have to wait for the device to report it on its own.
> >        */
> > -     dev->battery_avoid_query =3D report_type =3D=3D HID_INPUT_REPORT
> > &&
> > -                                field->physical =3D=3D HID_DG_STYLUS;
> > +     bat->avoid_query =3D report_type =3D=3D HID_INPUT_REPORT &&
> > +                        field->physical =3D=3D HID_DG_STYLUS;
> >
> >       if (quirks & HID_BATTERY_QUIRK_AVOID_QUERY)
> > -             dev->battery_avoid_query =3D true;
> > +             bat->avoid_query =3D true;
> >
> > -     dev->battery =3D power_supply_register(&dev->dev, psy_desc,
> > &psy_cfg);
> > -     if (IS_ERR(dev->battery)) {
> > -             error =3D PTR_ERR(dev->battery);
> > +     psy_cfg.drv_data =3D bat;
> > +     bat->ps =3D power_supply_register(&dev->dev, psy_desc,
> > &psy_cfg);
> > +     if (IS_ERR(bat->ps)) {
> > +             error =3D PTR_ERR(bat->ps);
> >               hid_warn(dev, "can't register power supply: %d\n",
> > error);
> >               goto err_free_name;
> >       }
> >
> > -     power_supply_powers(dev->battery, &dev->dev);
> > +     power_supply_powers(bat->ps, &dev->dev);
> > +
> > +     list_add_tail(&bat->list, &dev->batteries);
> > +
> > +     /*
> > +      * The legacy single battery API is preserved by exposing
> > the first
> > +      * discovered battery. Systems relying on a single battery
> > view maintain
> > +      * unchanged behavior.
> > +      */
> > +     if (battery_num =3D=3D 0) {
> > +             dev->battery =3D bat->ps;
> > +             dev->battery_min =3D bat->min;
> > +             dev->battery_max =3D bat->max;
> > +             dev->battery_report_type =3D bat->report_type;
> > +             dev->battery_report_id =3D bat->report_id;
> > +             dev->battery_charge_status =3D bat->charge_status;
> > +             dev->battery_status =3D bat->status;
> > +             dev->battery_avoid_query =3D bat->avoid_query;
> > +     }
> > +
> >       return 0;
> >
> >  err_free_name:
> >       kfree(psy_desc->name);
> > -err_free_mem:
> > +err_free_desc:
> >       kfree(psy_desc);
> > -     dev->battery =3D NULL;
> > +err_free_bat:
> > +     kfree(bat);
> >       return error;
> >  }
> >
> >  static void hidinput_cleanup_battery(struct hid_device *dev)
> >  {
> > +     struct hid_battery *bat, *next;
> >       const struct power_supply_desc *psy_desc;
> >
> > -     if (!dev->battery)
> > -             return;
> > +     list_for_each_entry_safe(bat, next, &dev->batteries, list) {
> > +             psy_desc =3D bat->ps->desc;
> > +             power_supply_unregister(bat->ps);
> > +             kfree(psy_desc->name);
> > +             kfree(psy_desc);
> > +             list_del(&bat->list);
> > +             kfree(bat);
> > +     }
> >
> > -     psy_desc =3D dev->battery->desc;
> > -     power_supply_unregister(dev->battery);
> > -     kfree(psy_desc->name);
> > -     kfree(psy_desc);
> >       dev->battery =3D NULL;
> >  }
> >
> > -static bool hidinput_update_battery_charge_status(struct hid_device
> > *dev,
> > +static struct hid_battery *hidinput_find_battery(struct hid_device
> > *dev,
> > +                                              int report_id)
> > +{
> > +     struct hid_battery *bat;
> > +
> > +     list_for_each_entry(bat, &dev->batteries, list) {
> > +             if (bat->report_id =3D=3D report_id)
> > +                     return bat;
> > +     }Tested with Dactyl 5x6 split keyboard usin
> > +     return NULL;
> > +}
> > +
> > +static bool hidinput_update_battery_charge_status(struct hid_battery
> > *bat,
> >                                                 unsigned int
> > usage, int value)
> >  {
> >       switch (usage) {
> >       case HID_BAT_CHARGING:
> > -             dev->battery_charge_status =3D value ?
> > -
> > POWER_SUPPLY_STATUS_CHARGING :
> > -
> > POWER_SUPPLY_STATUS_DISCHARGING;
> > +             bat->charge_status =3D value ?
> > +                                  POWER_SUPPLY_STATUS_CHARGING :
> > +
> > POWER_SUPPLY_STATUS_DISCHARGING;
> > +             if (bat->dev->battery =3D=3D bat->ps)
> > +                     bat->dev->battery_charge_status =3D bat-
> > >charge_status;
> >               return true;
> >       }
> >
> >       return false;
> >  }
> >
> > -static void hidinput_update_battery(struct hid_device *dev, unsigned
> > int usage,
> > -                                 int value)
> > +static void hidinput_update_battery(struct hid_device *dev, int
> > report_id,
> > +                                 unsigned int usage, int value)
> >  {
> > +     struct hid_battery *bat;
> >       int capacity;
> >
> > -     if (!dev->battery)
> > +     bat =3D hidinput_find_battery(dev, report_id);
> > +     if (!bat)
> >               return;
> >
> > -     if (hidinput_update_battery_charge_status(dev, usage,
> > value)) {
> > -             power_supply_changed(dev->battery);
> > +     if (hidinput_update_battery_charge_status(bat, usage,
> > value)) {
> > +             power_supply_changed(bat->ps);
> >               return;
> >       }
> >
> >       if ((usage & HID_USAGE_PAGE) =3D=3D HID_UP_DIGITIZER && value =3D=
=3D
> > 0)
> >               return;
> >
> > -     if (value < dev->battery_min || value > dev->battery_max)
> > +     if (value < bat->min || value > bat->max)
> >               return;
> >
> >       capacity =3D hidinput_scale_battery_capacity(dev, value);
> >
> > -     if (dev->battery_status !=3D HID_BATTERY_REPORTED ||
> > -         capacity !=3D dev->battery_capacity ||
> > -         ktime_after(ktime_get_coarse(), dev-
> > >battery_ratelimit_time)) {
> > -             dev->battery_capacity =3D capacity;
> > -             dev->battery_status =3D HID_BATTERY_REPORTED;
> > -             dev->battery_ratelimit_time =3D
> > +     if (bat->status !=3D HID_BATTERY_REPORTED ||
> > +         capacity !=3D bat->capacity ||
> > +         ktime_after(ktime_get_coarse(), bat->ratelimit_time)) {
> > +             bat->capacity =3D capacity;
> > +             bat->status =3D HID_BATTERY_REPORTED;
> > +             bat->ratelimit_time =3D
> >                       ktime_add_ms(ktime_get_coarse(), 30 * 1000);
> > -             power_supply_changed(dev->battery);
> > +
> > +             if (dev->battery =3D=3D bat->ps) {
> > +                     dev->battery_capacity =3D bat->capacity;
> > +                     dev->battery_status =3D bat->status;
> > +                     dev->battery_ratelimit_time =3D bat-
> > >ratelimit_time;
> > +             }
> > +
> > +             power_supply_changed(bat->ps);
> >       }
> >  }
> >  #else  /* !CONFIG_HID_BATTERY_STRENGTH */
> > @@ -664,8 +735,8 @@ static void hidinput_cleanup_battery(struct
> > hid_device *dev)
> >  {
> >  }
> >
> > -static void hidinput_update_battery(struct hid_device *dev, unsigned
> > int usage,
> > -                                 int value)
> > +static void hidinput_update_battery(struct hid_device *dev, int
> > report_id,
> > +                                 unsigned int usage, int value)
> >  {
> >  }
> >  #endif       /* CONFIG_HID_BATTERY_STRENGTH */
> > @@ -1533,7 +1604,7 @@ void hidinput_hid_event(struct hid_device *hid,
> > struct hid_field *field, struct
> >               return;
> >
> >       if (usage->type =3D=3D EV_PWR) {
> > -             hidinput_update_battery(hid, usage->hid, value);
> > +             hidinput_update_battery(hid, report->id, usage->hid,
> > value);
> >               return;
> >       }
> >
> > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > index a4ddb94e3ee5..a6e36835fb3c 100644
> > --- a/include/linux/hid.h
> > +++ b/include/linux/hid.h
> > @@ -634,6 +634,36 @@ enum hid_battery_status {
> >       HID_BATTERY_REPORTED,           /* Device sent unsolicited
> > battery strength report */
> >  };
> >
> > +/**
> > + * struct hid_battery - represents a single battery power supply
> > + * @list: list node for linking into hid_device's battery list
> > + * @dev: pointer to the parent hid_device
> > + * @ps: the power supply device
> > + * @capacity: current battery capacity
> > + * @min: minimum battery value
> > + * @max: maximum battery value
> > + * @report_type: type of report (HID_INPUT_REPORT,
> > HID_FEATURE_REPORT)
> > + * @report_id: report ID for this battery
> > + * @charge_status: current charge status
> > + * @status: battery status (unknown, queried, reported)
> > + * @avoid_query: if true, don't query battery (wait for device
> > reports)
> > + * @ratelimit_time: time for rate limiting battery updates
> > + */
> > +struct hid_battery {
> > +     struct list_head list;
> > +     struct hid_device *dev;
> > +     struct power_supply *ps;
> > +     __s32 capacity;
> > +     __s32 min;
> > +     __s32 max;
> > +     __s32 report_type;
> > +     __s32 report_id;
> > +     __s32 charge_status;
> > +     enum hid_battery_status status;
> > +     bool avoid_query;
> > +     ktime_t ratelimit_time;
> > +};
> > +
> >  struct hid_driver;
> >  struct hid_ll_driver;
> >
> > @@ -670,8 +700,16 @@ struct hid_device {
> >  #ifdef CONFIG_HID_BATTERY_STRENGTH
> >       /*
> >        * Power supply information for HID devices which report
> > -      * battery strength. power_supply was successfully
> > registered if
> > -      * battery is non-NULL.
> > +      * battery strength. Each battery is tracked separately in
> > the
> > +      * batteries list.
> > +      */
> > +     struct list_head batteries;             /* List of
> > hid_battery structures */
> > +
> > +     /*
> > +      * Legacy single battery support - kept for backwards
> > compatibility.
> > +      * Points to the first battery in the list if any exists.
> > +      * power_supply was successfully registered if battery is
> > non-NULL.
> > +      * DEPRECATED: New code should iterate through batteries
> > list instead.
> >        */
> >       struct power_supply *battery;
> >       __s32 battery_capacity;
>
Best,


