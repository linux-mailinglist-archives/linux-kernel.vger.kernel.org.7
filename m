Return-Path: <linux-kernel+bounces-867533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FA2C02D90
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E831AA2187
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE0C34B403;
	Thu, 23 Oct 2025 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Y2pFT+ub"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE52D9EEC
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242815; cv=none; b=YPMop9HMy8Y7ssJlqj/UAMxFet4r5td8UzJ+e+MLu2RklcKfwMWJyslJNAL0G/OEs9c+RwG/VK5ogXU+qDlpHw5cyv76oLt88ISo6tKAFXX2J31WJGewjT9hd0A9Rfkevxy6fWmLx4uGf0oVZQpdO/eVM39nyALcyADKsuOR+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242815; c=relaxed/simple;
	bh=ppj0zcw0nPTgt5YFcPTF4lftuYec/xhtUP33N63ySMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4yFfYI/8SYPwrQWzhm+5UiNBhpmS9OXd4gGgccJU5AvnuU+pkUvJAEY8X8fW5XINV9OnKP/fwCm5YPlsu8VJjbVotbuS/7YvureWN2g3sd3swf/pIbgOz2EYVl7yfScdgY+rET3VNKk7H6NfgdW+8HY0+cmw192guKa02IiQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Y2pFT+ub; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 9BACBC4E35
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:06:48 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id D9372C4E2D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:06:47 +0300 (EEST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id B749E1FF4AB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:06:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761242807;
	bh=m14a92JklS8k80iJ56VPWp9IsKb1nU+gd3TmcV65a5U=;
	h=Received:From:Subject:To;
	b=Y2pFT+ub8hOVs0QVwg5lBSgcxQJePPmg4irIbehvyNtKl75rHeTMu8g8x0/BLCu/P
	 s0y4Ud/tQuNj9favA+7rncFuI+cJEZM52lggvzE//lnbap3vzYBqGI2zE58QttWrTz
	 fGvF0U+vDb6a7/YnOH6MWNexA36OECzo/Lyq/aCcNPNSwTHZfViggSBqtd8nPTuZbi
	 wqVN5359UcYAwDyeUvPYvT55DnunkzXH4fIcMEl28sZKnMqWxDUG2dYTAEGCa7Ve3x
	 U72HnR29SmTNRr/aAkXOcYNHfTB7OpIpranZ5oDkxnIM3vvYDpty+irvluW5m7osL0
	 8cPXElKYkVhnA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.181) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f181.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-3737d0920e6so17545191fa.1
        for <linux-kernel@vger.kernel.org>;
 Thu, 23 Oct 2025 11:06:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVnWBJCV78DCw10SHUD7DzZLMoeGTDTIfRM1OcUNw4ge1erSIPLp7ZgRYOC964VXgBbJFWoZNojb08s+3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzINj6V8M9X/T+4l5rmi6RxC6B6yBURk3WuexqTLz5NTHWfNAiY
	eHQlKYIv7KXBzY+ojQSzzeyPzlVKMR+6qT2oZzV6UjrW1q1+9chEOuT7f5UCXa63MwGzz25iAxU
	9jgMadz3FfUu72h+Fqq+YuvIP+rBqxbs=
X-Google-Smtp-Source: 
 AGHT+IFcUgsgSdTJiZj1AqDBjAMYFbKScOYBIhn/+8PQKtOpHY4PRYrVoOocH9TesdLvOUYCW49wRox7xM007Wsi58E=
X-Received: by 2002:a2e:a98c:0:b0:378:dd0a:4233 with SMTP id
 38308e7fff4ca-378dd0a455cmr9957901fa.17.1761242806227; Thu, 23 Oct 2025
 11:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018101759.4089-1-lkml@antheas.dev>
 <20251018101759.4089-2-lkml@antheas.dev>
 <e6328da3-8099-4540-9cb0-4fc28b359ee7@gmail.com>
In-Reply-To: <e6328da3-8099-4540-9cb0-4fc28b359ee7@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 23 Oct 2025 20:06:34 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwG+gf09PQf9o9YkKFYVgVn-1w5CDVrpOe4uFavVYCNijQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmsy9CCcsdB92GuTUjf8GbwA3AnnHeLMMwi-B00I8zG6wET36zOcRfpf80
Message-ID: 
 <CAGwozwG+gf09PQf9o9YkKFYVgVn-1w5CDVrpOe4uFavVYCNijQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] HID: asus: simplify RGB init sequence
To: Denis Benato <benato.denis96@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176124280754.1275269.7789453292332633323@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 23 Oct 2025 at 19:38, Denis Benato <benato.denis96@gmail.com> wrote:
>
>
> On 10/18/25 12:17, Antheas Kapenekakis wrote:
> > Currently, RGB initialization forks depending on whether a device is
> > NKEY. Then, NKEY devices are initialized using 0x5a, 0x5d, 0x5e
> > endpoints, and non-NKEY devices with 0x5a and then a
> > backlight check, which is omitted for NKEY devices.
> >
> > Remove the fork, using a common initialization sequence for both,
> > where they are both only initialized with 0x5a, then checked for
> > backlight support. This patch should not affect existing functionality.
> >
> > 0x5d and 0x5e endpoint initializations are performed by Windows
> > userspace programs associated with different usages that reside under
> > the vendor HID. Specifically, 0x5d is used by Armoury Crate, which
> > controls RGB and 0x5e by an animation program for certain Asus laptops.
> > Neither is used currently in the driver.
> What benefits do we get from removing the unused initialization?
>
> If this has never caused any troubles I don't see the reason for removing
> them. Moreover the lighting protocol is known and I might as well add
> support for it in the near future,

I already have a patch that adds RGB and delay inits that endpoint. It
got removed to make this easier to merge. See [1].

[1] https://lore.kernel.org/lkml/20250324210151.6042-10-lkml@antheas.dev/

> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/hid/hid-asus.c | 56 ++++++++++++++----------------------------
> >  1 file changed, 19 insertions(+), 37 deletions(-)
> >
> > diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> > index a444d41e53b6..7ea1037c3979 100644
> > --- a/drivers/hid/hid-asus.c
> > +++ b/drivers/hid/hid-asus.c
> > @@ -638,50 +638,32 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
> >       unsigned char kbd_func;
> >       int ret;
> >
> > -     if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
> > -             /* Initialize keyboard */
> > -             ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
> > -             if (ret < 0)
> > -                     return ret;
> > -
> > -             /* The LED endpoint is initialised in two HID */
> > -             ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID1);
> > -             if (ret < 0)
> > -                     return ret;
> > -
> > -             ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID2);
> > -             if (ret < 0)
> > -                     return ret;
> > -
> > -             if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
> > -                     ret = asus_kbd_disable_oobe(hdev);
> > -                     if (ret < 0)
> > -                             return ret;
> > -             }
> > -
> > -             if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> > -                     intf = to_usb_interface(hdev->dev.parent);
> > -                     udev = interface_to_usbdev(intf);
> > -                     validate_mcu_fw_version(hdev,
> > -                             le16_to_cpu(udev->descriptor.idProduct));
> > -             }
> > +     ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
> > +     if (ret < 0)
> > +             return ret;
> >
> > -     } else {
> > -             /* Initialize keyboard */
> > -             ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
> > -             if (ret < 0)
> > -                     return ret;
> > +     /* Get keyboard functions */
> > +     ret = asus_kbd_get_functions(hdev, &kbd_func, FEATURE_KBD_REPORT_ID);
> > +     if (ret < 0)
> > +             return ret;
> >
> > -             /* Get keyboard functions */
> > -             ret = asus_kbd_get_functions(hdev, &kbd_func, FEATURE_KBD_REPORT_ID);
> > +     if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
> > +             ret = asus_kbd_disable_oobe(hdev);
> >               if (ret < 0)
> >                       return ret;
> > +     }
> >
> > -             /* Check for backlight support */
> > -             if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
> > -                     return -ENODEV;
> > +     if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> > +             intf = to_usb_interface(hdev->dev.parent);
> > +             udev = interface_to_usbdev(intf);
> > +             validate_mcu_fw_version(
> > +                     hdev, le16_to_cpu(udev->descriptor.idProduct));
> >       }
> >
> > +     /* Check for backlight support */
> > +     if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
> > +             return -ENODEV;
> > +
> >       drvdata->kbd_backlight = devm_kzalloc(&hdev->dev,
> >                                             sizeof(struct asus_kbd_leds),
> >                                             GFP_KERNEL);
>


