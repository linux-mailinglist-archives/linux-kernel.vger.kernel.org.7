Return-Path: <linux-kernel+bounces-867552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDADC02EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7A5E4FCFEB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E408034679E;
	Thu, 23 Oct 2025 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="STR6h+9K"
Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3E62C0287
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244071; cv=none; b=SZjSbyaaG5l2J2iLRc/Kh4gbkFe6RS+d4tYMBfJwpdyMPT1/xvQT1jkNuFhI+lljc1C6Q/cvfyLynZOxddODWy29L830uuPsR1M9s888rycr1W7gHSSItDKja4aQTqbT/E3wOTNBcHlEjjBh2xkWCbKbQHOOKrNnwzs6PgnQc+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244071; c=relaxed/simple;
	bh=Dqmhx2T8Z4PUBHkc0XnnJwfmL/y9EVJ2+HpMIXQjexM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEeESvEnxAMHoaf/ZZy8noI7oLlW+vm/WFTgqBZepI6HMZHu/41E9Xa7Froszy+uFEOSQAcVqYi8Q8+E0dp/wbPwLX8Kx0enhyJyQ9tMWmhWAumj75xlx/Ri5WfoDU13HmD9/aUgmy/LVDrpubw5j2r9p0lo3T/DFNIt85L3lH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=STR6h+9K; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id 932495E58B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:27:47 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 1C9785E69E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:27:46 +0300 (EEST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id ADB021FF4AB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:27:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761244065;
	bh=YS/72VHhH/g/YFNa4ff51+NZvroLJ77Vov5cSnMbTD4=;
	h=Received:From:Subject:To;
	b=STR6h+9KU33zjx6WcsZxbS8t20kUKaRCrgMth2qoyeW/q3VGgzPK+mzGr5256gFuP
	 CjNpebttAm896jRpPbbdJ/BQl+ZuhccMqo1wCZqlEeqLg4EBCDvN+9cbF7qILw1RHW
	 UftKx6YBEgtV+KiXcGKcBStFPjtK1h2D07k5p9hW+UlJDS+Zd1JuzONJHcqOFnOPFp
	 9CmecZ7o4XwbAJg/eNIbYrKUw+V/GeN7URBXTFNP8R0F04NA8ONdkxN6mearoSVJbN
	 4HkG7e4eEraRDJkcBsFaWTFIWI1LvZn6DWjZCWIAQyMuhhceUpMqnS2+9bPol1Fahs
	 7kbZLg7GNeSdw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-378d61ce75aso10498421fa.1
        for <linux-kernel@vger.kernel.org>;
 Thu, 23 Oct 2025 11:27:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXtLD3zq5KcOSncSyUfzzsglkIm1lobXoNh0GCc8SrkdGFr06pnqyxKyoyybz/JALT06DIHWEbc+BqTpOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Xx4SEWS3AxTsydN6PwQL/6xr3utD2CsdQODYHV1wvt1gJL6O
	ZExO0HY+fjiE5QEF2b1Ec/15YyFnNQji8Ijg4yvkUff2Km8IwPQUewNXKSVvOst63L4xsdC4u4H
	F4Xh8Mv4AH9cEIizLMnhlxge1FX+Ix0k=
X-Google-Smtp-Source: 
 AGHT+IHilJ4ewlHSY4xggMhYaacCiDaa1aE1mkJY+Ltinfbu2Uaioj7vl798C2CEKwXIMBC7drdEmuXC3d2pPsrSukk=
X-Received: by 2002:a05:651c:3136:b0:376:3792:1a9b with SMTP id
 38308e7fff4ca-378cf944538mr19889991fa.21.1761244064142; Thu, 23 Oct 2025
 11:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018101759.4089-1-lkml@antheas.dev>
 <20251018101759.4089-5-lkml@antheas.dev>
 <f1d2dece-6e51-4092-9f2e-58dc93508a25@gmail.com>
In-Reply-To: <f1d2dece-6e51-4092-9f2e-58dc93508a25@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 23 Oct 2025 20:27:32 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGzN9Z5iQAVeYbmmAAf9jxhTw5Yy8f36BfwYdgN45kqNA@mail.gmail.com>
X-Gm-Features: AWmQ_bms1zXHxIp5gYKbu1d_fiWt-GifAEGH7Jd-F-Qmm03vnpBn86iRp-VuEP8
Message-ID: 
 <CAGwozwGzN9Z5iQAVeYbmmAAf9jxhTw5Yy8f36BfwYdgN45kqNA@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] HID: asus: prevent binding to all HID devices on
 ROG
To: Denis Benato <benato.denis96@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176124406495.1372877.8375875577423272325@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 23 Oct 2025 at 20:23, Denis Benato <benato.denis96@gmail.com> wrote:
>
>
> On 10/18/25 12:17, Antheas Kapenekakis wrote:
> > Currently, when hid-asus is not loaded, NKEY keyboards load as ~6
> > event devices with a pretty ASUSTEK name. When it loads, it concatenates
> > all applications per HID endpoint, renames them, and prints errors
> > when some of them do not have an input device.
> >
> > Therefore, change probe so that this is no longer the case. Stop
> > renaming the devices, omit the check for .input which causes errors on
> the devices -> devices
> > e.g., the Z13 for some hiddev only devices, and add
> > HID_QUIRK_INPUT_PER_APP so that each application gets its own event.
>
> event -> event device (or evdev?)
>
> It is not clear from the message what HID_QUIRK_INPUT_PER_APP has to do with
> renaming the devices/having one evdev vs multiple: please make
> it explicit in the commit message (and perhaps make explicit if (and how),
> in case it could make any difference, how programs might change
> theirs behavior as a consequence).
>
> I like the fact that userspace only sees one keyboard for what is,
> effectively, one keyboard device.
>
> The code looks good to me: make the commit message more
> explanatory and I'll include my reviewed-by.

If I respin the series to a v8 I will reword this patch subject.

Antheas

> Thanks,
> Denis
>
> > When this is done, the probes are called multiple times. Due to this,
> > the rgb check needs to be moved into probe, and the report fixup should
> > be skipped for non-vendor endpoints (prevents multiple prints).
> >
> > Reviewed-by: Luke D. Jones <luke@ljones.dev>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/hid/hid-asus.c | 59 +++++++++++++++++++++++++++---------------
> >  1 file changed, 38 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> > index 03f0d86936fc..bbbac98f76c6 100644
> > --- a/drivers/hid/hid-asus.c
> > +++ b/drivers/hid/hid-asus.c
> > @@ -47,6 +47,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
> >  #define T100CHI_MOUSE_REPORT_ID 0x06
> >  #define FEATURE_REPORT_ID 0x0d
> >  #define INPUT_REPORT_ID 0x5d
> > +#define HID_USAGE_PAGE_VENDOR 0xff310000
> >  #define FEATURE_KBD_REPORT_ID 0x5a
> >  #define FEATURE_KBD_REPORT_SIZE 64
> >  #define FEATURE_KBD_LED_REPORT_ID1 0x5d
> > @@ -89,6 +90,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
> >  #define QUIRK_ROG_NKEY_KEYBOARD              BIT(11)
> >  #define QUIRK_ROG_CLAYMORE_II_KEYBOARD BIT(12)
> >  #define QUIRK_ROG_ALLY_XPAD          BIT(13)
> > +#define QUIRK_SKIP_REPORT_FIXUP              BIT(14)
> >
> >  #define I2C_KEYBOARD_QUIRKS                  (QUIRK_FIX_NOTEBOOK_REPORT | \
> >                                                QUIRK_NO_INIT_REPORTS | \
> > @@ -125,7 +127,6 @@ struct asus_drvdata {
> >       struct input_dev *tp_kbd_input;
> >       struct asus_kbd_leds *kbd_backlight;
> >       const struct asus_touchpad_info *tp;
> > -     bool enable_backlight;
> >       struct power_supply *battery;
> >       struct power_supply_desc battery_desc;
> >       int battery_capacity;
> > @@ -316,7 +317,7 @@ static int asus_e1239t_event(struct asus_drvdata *drvdat, u8 *data, int size)
> >  static int asus_event(struct hid_device *hdev, struct hid_field *field,
> >                     struct hid_usage *usage, __s32 value)
> >  {
> > -     if ((usage->hid & HID_USAGE_PAGE) == 0xff310000 &&
> > +     if ((usage->hid & HID_USAGE_PAGE) == HID_USAGE_PAGE_VENDOR &&
> >           (usage->hid & HID_USAGE) != 0x00 &&
> >           (usage->hid & HID_USAGE) != 0xff && !usage->type) {
> >               hid_warn(hdev, "Unmapped Asus vendor usagepage code 0x%02x\n",
> > @@ -931,11 +932,6 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
> >
> >       drvdata->input = input;
> >
> > -     if (drvdata->enable_backlight &&
> > -         !asus_kbd_wmi_led_control_present(hdev) &&
> > -         asus_kbd_register_leds(hdev))
> > -             hid_warn(hdev, "Failed to initialize backlight.\n");
> > -
> >       return 0;
> >  }
> >
> > @@ -1008,15 +1004,6 @@ static int asus_input_mapping(struct hid_device *hdev,
> >                       return -1;
> >               }
> >
> > -             /*
> > -              * Check and enable backlight only on devices with UsagePage ==
> > -              * 0xff31 to avoid initializing the keyboard firmware multiple
> > -              * times on devices with multiple HID descriptors but same
> > -              * PID/VID.
> > -              */
> > -             if (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT)
> > -                     drvdata->enable_backlight = true;
> > -
> >               set_bit(EV_REP, hi->input->evbit);
> >               return 1;
> >       }
> > @@ -1133,8 +1120,10 @@ static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
> >
> >  static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  {
> > -     int ret;
> > +     struct hid_report_enum *rep_enum;
> >       struct asus_drvdata *drvdata;
> > +     struct hid_report *rep;
> > +     int ret, is_vendor = 0;
> >
> >       drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
> >       if (drvdata == NULL) {
> > @@ -1218,18 +1207,42 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >               return ret;
> >       }
> >
> > +     /* Check for vendor for RGB init and handle generic devices properly. */
> > +     rep_enum = &hdev->report_enum[HID_INPUT_REPORT];
> > +     list_for_each_entry(rep, &rep_enum->report_list, list) {
> > +             if ((rep->application & HID_USAGE_PAGE) == HID_USAGE_PAGE_VENDOR)
> > +                     is_vendor = true;
> > +     }
> > +
> > +     /*
> > +      * For ROG keyboards, make them HID/hiddev compliant by creating one
> > +      * input per application. For interfaces other than the vendor one,
> > +      * disable report fixups.
> > +      */
> > +     if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
> > +             if (!is_vendor)
> > +                     drvdata->quirks |= QUIRK_SKIP_REPORT_FIXUP;
> > +             hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
> > +     }
> > +
> >       ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> >       if (ret) {
> >               hid_err(hdev, "Asus hw start failed: %d\n", ret);
> >               return ret;
> >       }
> >
> > +     if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
> > +         !asus_kbd_wmi_led_control_present(hdev) &&
> > +         asus_kbd_register_leds(hdev))
> > +             hid_warn(hdev, "Failed to initialize backlight.\n");
> > +
> >       /*
> > -      * Check that input registration succeeded. Checking that
> > -      * HID_CLAIMED_INPUT is set prevents a UAF when all input devices
> > -      * were freed during registration due to no usages being mapped,
> > -      * leaving drvdata->input pointing to freed memory.
> > +      * For ROG keyboards, skip rename for consistency and ->input check as
> > +      * some devices do not have inputs.
> >        */
> > +     if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD)
> > +             return 0;
> > +
> >       if (!drvdata->input || !(hdev->claimed & HID_CLAIMED_INPUT)) {
> >               hid_err(hdev, "Asus input not registered\n");
> >               ret = -ENOMEM;
> > @@ -1352,6 +1365,10 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> >               rdesc = new_rdesc;
> >       }
> >
> > +     /* Vendor fixups should only apply to NKEY vendor devices. */
> > +     if (drvdata->quirks & QUIRK_SKIP_REPORT_FIXUP)
> > +             return rdesc;
> > +
> >       if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD &&
> >                       *rsize == 331 && rdesc[190] == 0x85 && rdesc[191] == 0x5a &&
> >                       rdesc[204] == 0x95 && rdesc[205] == 0x05) {
>


