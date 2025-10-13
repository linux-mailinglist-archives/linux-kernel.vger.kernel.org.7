Return-Path: <linux-kernel+bounces-851458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA48BD68B9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD6F4266F3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927272FB08F;
	Mon, 13 Oct 2025 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="B+a24GxR"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B590312815
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392656; cv=none; b=Q7jMXMkeO4xk5JdVHL5J8KFXDL7a75J6xpExP0tEajFAgduwTr6t4gjeD+PF+rm3s/Ul13+ideO9R5wG0rzU8DBQMwZ2Tph9kKMUSR/Z41QYt21Ay9GN6wY6CcaZ9LyHDFpn0gleZtgnCBzm5FjUoHn/Onf6QQfClOCAbupcASU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392656; c=relaxed/simple;
	bh=4Cz/5Tg01mEm7HOWBRI+QY3KIF06zD3aR2vbmZtrLUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bftgKKGNm2iCEoJSXzWK5+AK84BJ+OUsNjX2qaGLPVAFFZfOnwZdolYv4Gb+K6vZeoW4UYGsjVjiGKL+t7wbVt7kTLOHEyuPFO89ynwQwNNBogcQaMwJo6KkuItDFveIlJFSpirW9X/LtEU81bdlHb9nmWTkv61J4aoaxR1wdLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=B+a24GxR; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id E0D993ED07
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:57:32 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 0FD403ED00
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:57:32 +0300 (EEST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 5BB981FDE2D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:57:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1760392651;
	bh=El5iz56Qd+ib5idmhjwDcMQU0F22cZFo7/Zrr1+8mgw=;
	h=Received:From:Subject:To;
	b=B+a24GxR/vCSP4+ewgZ56QqQmJOKmEHCJm3OqstmeG0mEoWZOSpmyX98YjALbPc2H
	 vBteUNWYG1OyQ4iZpAL6GP4T9t/PoUbf6gcU2lN4Dt40UqnMpiNpF4OP7AaIwAdZnc
	 K6/tj34BaTYs/+Iee35/Rpht/qvZhzUzN2BuQ4ulKyarTwPDWM0b5sFSo8m5oMyIGR
	 OGNgRGsAaMVnPzfVoy9HiJ7l7oXZkbaHIuW6F9HRkM1DH2EnUevNq7oXUmWcBmCVWo
	 Y3r0M7xf0DoUeLLzSpOB1oAxciKFYlzCm4zPtQxG8Q8T5+BDNGcNY/Epdpkp+X3+xU
	 mN4qa8hi1wGOw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f176.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-368348d30e0so40039571fa.1
        for <linux-kernel@vger.kernel.org>;
 Mon, 13 Oct 2025 14:57:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW/xxSbxJjwlP4KTzAFyiQ0PT+iT7j7mM7KbnL9Qh1Jl38FQMhXklL1UmKu5bsKbB3G9dqq60rZi3fq3Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWUFwILjuPeW5aGS1xffRXtOZvbv+ybsAKggESLXdrmsINrgqf
	5Ff4AOUT+eJuAPP6xL02hWiY3F2p+D7WrtOHB6F1Ni9U6EKhOh/8WihRIqFnxRfhhzprbFC7Zuf
	YWLlvvbjUEdd2ZkMIEV3SdanPFdCDGZ4=
X-Google-Smtp-Source: 
 AGHT+IFv9tAH/E/ajmrfCGsXqap0lzkbXiPlZM96aHjzYrArckY+BrPccTbGdYZHSc4ACjoVQWi+ugOoMrKAiVipz94=
X-Received: by 2002:a05:651c:144a:b0:336:9427:3527 with SMTP id
 38308e7fff4ca-37609e55b64mr53271531fa.21.1760392650751; Mon, 13 Oct 2025
 14:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013201535.6737-1-lkml@antheas.dev>
 <20251013201535.6737-5-lkml@antheas.dev>
 <e1e6ee09-ea29-4328-9eae-f2a4a23b3edc@gmail.com>
In-Reply-To: <e1e6ee09-ea29-4328-9eae-f2a4a23b3edc@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 13 Oct 2025 23:57:19 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHP6ukxBRpOFU+XQL5gyNKu5f-HUJio-=F6rAGUmcm2tw@mail.gmail.com>
X-Gm-Features: AS18NWAuJ3FJduwaF_6Bo-8GDPx0UFFCTA2170ZRQeDNWVr9iXBapON5KVo5mYo
Message-ID: 
 <CAGwozwHP6ukxBRpOFU+XQL5gyNKu5f-HUJio-=F6rAGUmcm2tw@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] HID: asus: listen to the asus-wmi brightness
 device instead of creating one
To: Denis Benato <benato.denis96@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176039265155.3717381.8975482118122008434@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 13 Oct 2025 at 23:44, Denis Benato <benato.denis96@gmail.com> wrote:
>
>
> On 10/13/25 22:15, Antheas Kapenekakis wrote:
> > Some ROG laptops expose multiple interfaces for controlling the
> > keyboard/RGB brightness. This creates a name conflict under
> > asus::kbd_brightness, where the second device ends up being
> > named asus::kbd_brightness_1 and they are both broken.
> Can you please reference a bug report and/or an analysis of why they ends
> up being broken?

You can reference the V1 description [1]

[1] https://lore.kernel.org/all/20250319191320.10092-1-lkml@antheas.dev/

> >
> > Therefore, register a listener to the asus-wmi brightness device
> > instead of creating a new one.
> >
> > Reviewed-by: Luke D. Jones <luke@ljones.dev>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/hid/hid-asus.c | 64 +++++++-----------------------------------
> >  1 file changed, 10 insertions(+), 54 deletions(-)
> >
> > diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> > index a62559e3e064..0af19c8ef035 100644
> > --- a/drivers/hid/hid-asus.c
> > +++ b/drivers/hid/hid-asus.c
> > @@ -102,7 +102,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
> >  #define TRKID_SGN       ((TRKID_MAX + 1) >> 1)
> >
> >  struct asus_kbd_leds {
> > -     struct led_classdev cdev;
> > +     struct asus_hid_listener listener;
> It is my understanding from "register a listener .... instead of creating a new one"
> that you are attempting to use the same listener among many devices... so why isn't
> this a pointer? And more importantly: why do we have bool available, bool registered
> instead of either one or the other being replaced by this field being possibly NULL?

A listener is the handle that is passed to asus-wmi so that it can
communicate with hid-asus. Since the flow of communication flows from
asus-wmi -> hid-asus, the pointer is placed on asus-wmi.

The boolean kbd_led_avail is used to signify whether the BIOS supports
RGB commands. If not, we still want the common handler to be there to
link multiple hid-asus devices together. At the same time, we need to
skip calling the bios commands for brightness, and hold a value for
the previous brightness outside the bios.

The kbd_led_registered fixes the race condition that happens between
hid-asus and asus-wmi. Specifically, it ensures that the rgb listener
is only setup once, either once asus-wmi loads (if it supports RGB) or
when the first hid device loads.

Best,
Antheas

> >       struct hid_device *hdev;
> >       struct work_struct work;
> >       unsigned int brightness;
> > @@ -495,11 +495,11 @@ static void asus_schedule_work(struct asus_kbd_leds *led)
> >       spin_unlock_irqrestore(&led->lock, flags);
> >  }
> >
> > -static void asus_kbd_backlight_set(struct led_classdev *led_cdev,
> > -                                enum led_brightness brightness)
> > +static void asus_kbd_backlight_set(struct asus_hid_listener *listener,
> > +                                int brightness)
> >  {
> > -     struct asus_kbd_leds *led = container_of(led_cdev, struct asus_kbd_leds,
> > -                                              cdev);
> > +     struct asus_kbd_leds *led = container_of(listener, struct asus_kbd_leds,
> > +                                              listener);
> >       unsigned long flags;
> >
> >       spin_lock_irqsave(&led->lock, flags);
> > @@ -509,20 +509,6 @@ static void asus_kbd_backlight_set(struct led_classdev *led_cdev,
> >       asus_schedule_work(led);
> >  }
> >
> > -static enum led_brightness asus_kbd_backlight_get(struct led_classdev *led_cdev)
> > -{
> > -     struct asus_kbd_leds *led = container_of(led_cdev, struct asus_kbd_leds,
> > -                                              cdev);
> > -     enum led_brightness brightness;
> > -     unsigned long flags;
> > -
> > -     spin_lock_irqsave(&led->lock, flags);
> > -     brightness = led->brightness;
> > -     spin_unlock_irqrestore(&led->lock, flags);
> > -
> > -     return brightness;
> > -}
> > -
> >  static void asus_kbd_backlight_work(struct work_struct *work)
> >  {
> >       struct asus_kbd_leds *led = container_of(work, struct asus_kbd_leds, work);
> > @@ -539,34 +525,6 @@ static void asus_kbd_backlight_work(struct work_struct *work)
> >               hid_err(led->hdev, "Asus failed to set keyboard backlight: %d\n", ret);
> >  }
> >
> > -/* WMI-based keyboard backlight LED control (via asus-wmi driver) takes
> > - * precedence. We only activate HID-based backlight control when the
> > - * WMI control is not available.
> > - */
> > -static bool asus_kbd_wmi_led_control_present(struct hid_device *hdev)
> > -{
> > -     struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> > -     u32 value;
> > -     int ret;
> > -
> > -     if (!IS_ENABLED(CONFIG_ASUS_WMI))
> > -             return false;
> > -
> > -     if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD &&
> > -                     dmi_check_system(asus_use_hid_led_dmi_ids)) {
> > -             hid_info(hdev, "using HID for asus::kbd_backlight\n");
> > -             return false;
> > -     }
> > -
> > -     ret = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS,
> > -                                    ASUS_WMI_DEVID_KBD_BACKLIGHT, 0, &value);
> > -     hid_dbg(hdev, "WMI backlight check: rc %d value %x", ret, value);
> > -     if (ret)
> > -             return false;
> > -
> > -     return !!(value & ASUS_WMI_DSTS_PRESENCE_BIT);
> > -}
> > -
> >  /*
> >   * We don't care about any other part of the string except the version section.
> >   * Example strings: FGA80100.RC72LA.312_T01, FGA80100.RC71LS.318_T01
> > @@ -701,14 +659,11 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
> >       drvdata->kbd_backlight->removed = false;
> >       drvdata->kbd_backlight->brightness = 0;
> >       drvdata->kbd_backlight->hdev = hdev;
> > -     drvdata->kbd_backlight->cdev.name = "asus::kbd_backlight";
> > -     drvdata->kbd_backlight->cdev.max_brightness = 3;
> > -     drvdata->kbd_backlight->cdev.brightness_set = asus_kbd_backlight_set;
> > -     drvdata->kbd_backlight->cdev.brightness_get = asus_kbd_backlight_get;
> > +     drvdata->kbd_backlight->listener.brightness_set = asus_kbd_backlight_set;
> >       INIT_WORK(&drvdata->kbd_backlight->work, asus_kbd_backlight_work);
> >       spin_lock_init(&drvdata->kbd_backlight->lock);
> >
> > -     ret = devm_led_classdev_register(&hdev->dev, &drvdata->kbd_backlight->cdev);
> > +     ret = asus_hid_register_listener(&drvdata->kbd_backlight->listener);
> >       if (ret < 0) {
> >               /* No need to have this still around */
> >               devm_kfree(&hdev->dev, drvdata->kbd_backlight);
> > @@ -1105,7 +1060,7 @@ static int __maybe_unused asus_resume(struct hid_device *hdev) {
> >
> >       if (drvdata->kbd_backlight) {
> >               const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4,
> > -                             drvdata->kbd_backlight->cdev.brightness };
> > +                             drvdata->kbd_backlight->brightness };
> >               ret = asus_kbd_set_report(hdev, buf, sizeof(buf));
> >               if (ret < 0) {
> >                       hid_err(hdev, "Asus failed to set keyboard backlight: %d\n", ret);
> > @@ -1241,7 +1196,6 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >       }
> >
> >       if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
> > -         !asus_kbd_wmi_led_control_present(hdev) &&
> >           asus_kbd_register_leds(hdev))
> >               hid_warn(hdev, "Failed to initialize backlight.\n");
> >
> > @@ -1282,6 +1236,8 @@ static void asus_remove(struct hid_device *hdev)
> >       unsigned long flags;
> >
> >       if (drvdata->kbd_backlight) {
> > +             asus_hid_unregister_listener(&drvdata->kbd_backlight->listener);
> > +
> >               spin_lock_irqsave(&drvdata->kbd_backlight->lock, flags);
> >               drvdata->kbd_backlight->removed = true;
> >               spin_unlock_irqrestore(&drvdata->kbd_backlight->lock, flags);
>


