Return-Path: <linux-kernel+bounces-867815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A626CC038D6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6150A3A283B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DA337160;
	Thu, 23 Oct 2025 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="KE8IHrgT"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803C21D011
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761255026; cv=none; b=e+yQEfwp5t6Ue2Pn9AuJcS8eguZqgZ+6kAX89NCkNtWIWTL1lW8uJ0X8oi2blDTAZs3GFEbcXmUs16L6BJGCfG4018QufE4PzXzPGu75r/q3B/xTOdub6FxNuHnRnhJwu1GDjSfQQSq5cR86rwtklRIdjr62EAYM+yS/oTn36q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761255026; c=relaxed/simple;
	bh=otaGLYxNIOW4UI+hYlX2ogLjbY1sgr0kMmk4C+qJ2eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxhZG770PM3aWRWOKI0vwjQV6kpOfpBEDMGoqwnRUAChtpThT41/JCMkUShZDDv3/Y2WQLbUoD5ew9ez6AN8m9TX59roMjcjHHrgNXuuroq5ISn5Cy9Up8G/LS8hP8f0BobqtxvA8c3S2rFln2Vmk2gSYoL6yOeUHqWpycq7zyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=KE8IHrgT; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id B78B03EBF7
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:30:21 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 9D4333EC09
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:30:20 +0300 (EEST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id E4AF8201B60
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:30:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761255020;
	bh=7Ss2IUJ/KvoT3sNotJmDkTC+OgO33dxxsl3Y76pbwYI=;
	h=Received:From:Subject:To;
	b=KE8IHrgT5w1a9Y/NwY0Ds/Sh8TeL98OJzhv3lcMTT42TbFd/jkCT6v1br7loMPVeh
	 nxzOSGHJVt8NtTMtHPoNdW2qdZN5KKrKzJOwfZQDHFaaB2/SOPghx7vIQYp/TMAQwI
	 W66JZ9KCHI4FMBL5QbgabQGYuqxiV63GA1Dz6GlXzi/9jXhiFGqA/E8QZqkCNt0ik6
	 ZYurgJFsyR1NCPSb1ylRDy70qtAZzcH8oGw8ZfcC6CL5Vfmk2UYSyEahl4d2/VrT20
	 FLMfJ0NQshEe47meJrPYh2iauTs/B/+6uKSAmGHHROdrihDJnUKP800fdzbdSBew+2
	 9AHrIkkn8yFpw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.180) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f180.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-378cffe5e1aso14947911fa.2
        for <linux-kernel@vger.kernel.org>;
 Thu, 23 Oct 2025 14:30:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXRdv7j9F2oD/zFEjvTCn6gRw7Se5cp+2bAUzzehAFHOdE2WMg0Nz7jgFLNWVVUdrmRrIRpqxgI7UmX9Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt8g0jlh9jP/1qEtRnnkYxzAFWBg79b9JoguOYbqtzxgpQGP1O
	kiQKIvYz1Oj+P2sxD/b/3POsyg1ziPzXSCLZIdgRnEITtMef5Ub7Xc6Mv/hQIefzXjn3PyxGLI/
	/BBR9GL0EyWM5SMNhIFqDenO/nT4ja8w=
X-Google-Smtp-Source: 
 AGHT+IE5aIMiJih4YDtM1AUn2jQDnOpKB7I3D528ChPEqlwmc+xZiVggYOVyOOuUgHeQC8/+4NZLnfEPDM8vkBApCi8=
X-Received: by 2002:a05:651c:1442:b0:378:dd0a:4233 with SMTP id
 38308e7fff4ca-378e444fb8fmr348541fa.17.1761255019345; Thu, 23 Oct 2025
 14:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018101759.4089-1-lkml@antheas.dev>
 <20251018101759.4089-2-lkml@antheas.dev>
 <e6328da3-8099-4540-9cb0-4fc28b359ee7@gmail.com>
 <CAGwozwG+gf09PQf9o9YkKFYVgVn-1w5CDVrpOe4uFavVYCNijQ@mail.gmail.com>
 <3947f772-691b-46a2-af68-15825e7f4939@gmail.com>
In-Reply-To: <3947f772-691b-46a2-af68-15825e7f4939@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 23 Oct 2025 23:30:08 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFbQWyuQB6EwLMLon5muff2WudR+oVL62DqP_MXGW+p-Q@mail.gmail.com>
X-Gm-Features: AWmQ_bmwHOSe4Z-uuTqe5zkcZxvmek2SNkxJSOIpSb-zQ-vzFGrV0K38CbvpgbI
Message-ID: 
 <CAGwozwFbQWyuQB6EwLMLon5muff2WudR+oVL62DqP_MXGW+p-Q@mail.gmail.com>
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
 <176125502016.2060288.9665927885135186880@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 23 Oct 2025 at 22:05, Denis Benato <benato.denis96@gmail.com> wrote:
>
>
> On 10/23/25 20:06, Antheas Kapenekakis wrote:
> > On Thu, 23 Oct 2025 at 19:38, Denis Benato <benato.denis96@gmail.com> wrote:
> >>
> >> On 10/18/25 12:17, Antheas Kapenekakis wrote:
> >>> Currently, RGB initialization forks depending on whether a device is
> >>> NKEY. Then, NKEY devices are initialized using 0x5a, 0x5d, 0x5e
> >>> endpoints, and non-NKEY devices with 0x5a and then a
> >>> backlight check, which is omitted for NKEY devices.
> >>>
> >>> Remove the fork, using a common initialization sequence for both,
> >>> where they are both only initialized with 0x5a, then checked for
> >>> backlight support. This patch should not affect existing functionality.
> >>>
> >>> 0x5d and 0x5e endpoint initializations are performed by Windows
> >>> userspace programs associated with different usages that reside under
> >>> the vendor HID. Specifically, 0x5d is used by Armoury Crate, which
> >>> controls RGB and 0x5e by an animation program for certain Asus laptops.
> >>> Neither is used currently in the driver.
> >> What benefits do we get from removing the unused initialization?
> >>
> >> If this has never caused any troubles I don't see the reason for removing
> >> them. Moreover the lighting protocol is known and I might as well add
> >> support for it in the near future,
> > I already have a patch that adds RGB and delay inits that endpoint. It
> > got removed to make this easier to merge. See [1].
> >
> > [1] https://lore.kernel.org/lkml/20250324210151.6042-10-lkml@antheas.dev/
> I have to main concerns about this:
>
> 1. taking away initialization commands in one patchset to make it
> easier to merge another unrelated patch doesn't seem the right thing
> to do if the other patch it's not in the same series.
>
> I can see [1] has been removed from the set for a later moment in time,
> it's fine if it needs more work, just send something that function in the
> same way and do not remove initialization commands when unnecessary,
> especially since there will be for sure future development.

The initialization was removed as part of general cleanup. Not to make
it easier to merge the RGB patch. In addition, the RGB patch only runs
the init in a lazy fashion, so if nobody uses the RGB sysfs the init
does not run and the behavior is the same.

> 2. Your patchset resolves around keyboard backlight control and how
> the keyboard device is exposed to userspace: it's fine but I do not see
> the point in removing initialization commands that has nothing to do
> with the issue we are trying to solve here.
>
> Please leave 0x5E and 0x5D initialization commands where they are now.

I mean the second part of the patchset does that. The first part is a
cleanup. What would be the reason for keeping 0x5E and 0x5D? They are
only used when initializing those endpoints to write further commands
to them and for identification. The current driver does not write
commands to those endpoints and identifies itself over 0x5A.

I do get that it is a bit risky as some laptops might be hardcoded to
wait for 0x5D to turn on RGB. Which is why we had the last patch until
V4. But we have yet to find a laptop that has this problem, so I find
it difficult to justify keeping the init.

Do note that you might need to add the 0x5D init to your userspace
program for certain laptops if you haven't already. But that is ok,
since in doing so you are also validating you are speaking to an Asus
device, which is important.

Antheas

> >>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>> ---
> >>>  drivers/hid/hid-asus.c | 56 ++++++++++++++----------------------------
> >>>  1 file changed, 19 insertions(+), 37 deletions(-)
> >>>
> >>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> >>> index a444d41e53b6..7ea1037c3979 100644
> >>> --- a/drivers/hid/hid-asus.c
> >>> +++ b/drivers/hid/hid-asus.c
> >>> @@ -638,50 +638,32 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
> >>>       unsigned char kbd_func;
> >>>       int ret;
> >>>
> >>> -     if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
> >>> -             /* Initialize keyboard */
> >>> -             ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
> >>> -             if (ret < 0)
> >>> -                     return ret;
> >>> -
> >>> -             /* The LED endpoint is initialised in two HID */
> >>> -             ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID1);
> >>> -             if (ret < 0)
> >>> -                     return ret;
> >>> -
> >>> -             ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID2);
> >>> -             if (ret < 0)
> >>> -                     return ret;
> >>> -
> >>> -             if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
> >>> -                     ret = asus_kbd_disable_oobe(hdev);
> >>> -                     if (ret < 0)
> >>> -                             return ret;
> >>> -             }
> >>> -
> >>> -             if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> >>> -                     intf = to_usb_interface(hdev->dev.parent);
> >>> -                     udev = interface_to_usbdev(intf);
> >>> -                     validate_mcu_fw_version(hdev,
> >>> -                             le16_to_cpu(udev->descriptor.idProduct));
> >>> -             }
> >>> +     ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
> >>> +     if (ret < 0)
> >>> +             return ret;
> >>>
> >>> -     } else {
> >>> -             /* Initialize keyboard */
> >>> -             ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
> >>> -             if (ret < 0)
> >>> -                     return ret;
> >>> +     /* Get keyboard functions */
> >>> +     ret = asus_kbd_get_functions(hdev, &kbd_func, FEATURE_KBD_REPORT_ID);
> >>> +     if (ret < 0)
> >>> +             return ret;
> >>>
> >>> -             /* Get keyboard functions */
> >>> -             ret = asus_kbd_get_functions(hdev, &kbd_func, FEATURE_KBD_REPORT_ID);
> >>> +     if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
> >>> +             ret = asus_kbd_disable_oobe(hdev);
> >>>               if (ret < 0)
> >>>                       return ret;
> >>> +     }
> >>>
> >>> -             /* Check for backlight support */
> >>> -             if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
> >>> -                     return -ENODEV;
> >>> +     if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> >>> +             intf = to_usb_interface(hdev->dev.parent);
> >>> +             udev = interface_to_usbdev(intf);
> >>> +             validate_mcu_fw_version(
> >>> +                     hdev, le16_to_cpu(udev->descriptor.idProduct));
> >>>       }
> >>>
> >>> +     /* Check for backlight support */
> >>> +     if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
> >>> +             return -ENODEV;
> >>> +
> >>>       drvdata->kbd_backlight = devm_kzalloc(&hdev->dev,
> >>>                                             sizeof(struct asus_kbd_leds),
> >>>                                             GFP_KERNEL);
>


