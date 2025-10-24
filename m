Return-Path: <linux-kernel+bounces-869203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0DDC07487
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78C285623FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812E927CB02;
	Fri, 24 Oct 2025 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ezL+BSo0"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D51219A79
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322833; cv=none; b=Smg75IrRKkLIQlnFooB4lj26b6XUoA7sZ0QdILv3e8PWp5kIotBLW1HOWcBqTIGKAbjqPrKhrZ0BND9fbU0qbyCpBs4RDuRRWFsNXKHyKA6M1yTAOTQI8K6V7aDTRyKEOmDJHCR7LdgJ4w9O0cNQi8ATA6gJlmisTCqkgW4NVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322833; c=relaxed/simple;
	bh=Uz61FD/DKMX/OkatTg2k7SbA1EKWO/0kfbVwwjsgNBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDZQ7b9Y7AhGPVOm6E1y2D9PyylYLZOgVMhYOANUfm/RCwgWiThP9P88Na1cRt6pDVXwcip+teXslcKv1Pw45Bf3RL4nDi98dNdgGuf2aNqHixA+SPhSpO8/xfP3QAT+TNV5ySegXFCNU+jV3AYTHqFuIYsEmqjuDs3iBDGvvk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ezL+BSo0; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 194DDC5B64
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:20:28 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 0BB1EC53D6
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:20:27 +0300 (EEST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 7EA971FF3B7
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:20:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761322826;
	bh=zXBoRPa7llDLOBOBmhwdAtXRgCm90e/W0j9vQSGI+10=;
	h=Received:From:Subject:To;
	b=ezL+BSo0EqTlRwdKz8BXfnIxvMEFPnsoD0JMzYSxfx6IARYAQvbXvn8M/I9nDZzQ0
	 OGLLROh3uaNRnb9jvBphme5g+2X5Ef44v4tWgplJNmIKlRQyICWfq1NyixA3Y4sISS
	 WXUM/K/O6Nu5sZj57+xCE7CnSKeSX93xcX2hjPVbMI81XyF03TGypDNXhpkTL+rC4o
	 AJXi3Atr/T5OjrTj0axlFRjPzyr2nNQpMsSS4arXM9OvqSELSwJIhdW5MRe0MlvZ8V
	 GQMRXWyjy1tTNabA3a2rBMW8tEyWm1H51T/cpHcjqu7HwiuRXO9aUC5EqNoxAwmAOh
	 DKxrcrli4D5KA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f176.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-378cfd75fb0so23023001fa.1
        for <linux-kernel@vger.kernel.org>;
 Fri, 24 Oct 2025 09:20:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUvDirJ83lIUzxm69RGc2cU6A5cYMff7qq+3r5XCBqB2lkF1+DDpNRu2ScMkfF3DZ90co8eG5HJC2o2pzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZp5Z/WCI8/ZvJzpTBG7UKzZzl9p3kG80h824xpG61t/XjGAsN
	DCAOWDTFbD2etSuMLkgAGtPtDzYE8WcVOex3BjPnq7Ry3Feh3Y5uqsFLQricGI/128/B4g7G2QR
	PYDgtBdop1F7FCv3dpipjrtJv/ERNKkQ=
X-Google-Smtp-Source: 
 AGHT+IEQzAWb4Yb3tHKwSmhSGDhJwsNtHZb5B8TJ1yCHCfA7ki1ikULJDDSb8mLZL+TbWRz6Uc+bg57LbSfPnVJhEXg=
X-Received: by 2002:a2e:a984:0:b0:378:e30b:d1e1 with SMTP id
 38308e7fff4ca-378e30beee3mr11329641fa.40.1761322825940; Fri, 24 Oct 2025
 09:20:25 -0700 (PDT)
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
 <CAGwozwFbQWyuQB6EwLMLon5muff2WudR+oVL62DqP_MXGW+p-Q@mail.gmail.com>
 <b91de7c7-74b8-4cf5-82a4-f3d4eaf418d4@gmail.com>
 <CAGwozwGj-yXHXBan38_NV7G5T66bnjm7om2bz_Bha35AHhtCJQ@mail.gmail.com>
In-Reply-To: 
 <CAGwozwGj-yXHXBan38_NV7G5T66bnjm7om2bz_Bha35AHhtCJQ@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 24 Oct 2025 18:20:13 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEh32XMcGJPKMRBWd63ybYOxW1Wx4QjU-QErjQgLHwX2g@mail.gmail.com>
X-Gm-Features: AWmQ_bm7gzn18HWBJWKWicaU2Mf9cOLIcXHnKxvTqgAOu5hFzzHrG57eskCdmpQ
Message-ID: 
 <CAGwozwEh32XMcGJPKMRBWd63ybYOxW1Wx4QjU-QErjQgLHwX2g@mail.gmail.com>
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
 <176132282670.2564802.6078046734731565840@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 24 Oct 2025 at 01:25, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> On Fri, 24 Oct 2025 at 00:53, Denis Benato <benato.denis96@gmail.com> wrote:
> >
> >
> > On 10/23/25 23:30, Antheas Kapenekakis wrote:
> > > On Thu, 23 Oct 2025 at 22:05, Denis Benato <benato.denis96@gmail.com> wrote:
> > >>
> > >> On 10/23/25 20:06, Antheas Kapenekakis wrote:
> > >>> On Thu, 23 Oct 2025 at 19:38, Denis Benato <benato.denis96@gmail.com> wrote:
> > >>>> On 10/18/25 12:17, Antheas Kapenekakis wrote:
> > >>>>> Currently, RGB initialization forks depending on whether a device is
> > >>>>> NKEY. Then, NKEY devices are initialized using 0x5a, 0x5d, 0x5e
> > >>>>> endpoints, and non-NKEY devices with 0x5a and then a
> > >>>>> backlight check, which is omitted for NKEY devices.
> > >>>>>
> > >>>>> Remove the fork, using a common initialization sequence for both,
> > >>>>> where they are both only initialized with 0x5a, then checked for
> > >>>>> backlight support. This patch should not affect existing functionality.
> > >>>>>
> > >>>>> 0x5d and 0x5e endpoint initializations are performed by Windows
> > >>>>> userspace programs associated with different usages that reside under
> > >>>>> the vendor HID. Specifically, 0x5d is used by Armoury Crate, which
> > >>>>> controls RGB and 0x5e by an animation program for certain Asus laptops.
> > >>>>> Neither is used currently in the driver.
> > >>>> What benefits do we get from removing the unused initialization?
> > >>>>
> > >>>> If this has never caused any troubles I don't see the reason for removing
> > >>>> them. Moreover the lighting protocol is known and I might as well add
> > >>>> support for it in the near future,
> > >>> I already have a patch that adds RGB and delay inits that endpoint. It
> > >>> got removed to make this easier to merge. See [1].
> > >>>
> > >>> [1] https://lore.kernel.org/lkml/20250324210151.6042-10-lkml@antheas.dev/
> > >> I have to main concerns about this:
> > >>
> > >> 1. taking away initialization commands in one patchset to make it
> > >> easier to merge another unrelated patch doesn't seem the right thing
> > >> to do if the other patch it's not in the same series.
> > >>
> > >> I can see [1] has been removed from the set for a later moment in time,
> > >> it's fine if it needs more work, just send something that function in the
> > >> same way and do not remove initialization commands when unnecessary,
> > >> especially since there will be for sure future development.
> > > The initialization was removed as part of general cleanup. Not to make
> > > it easier to merge the RGB patch. In addition, the RGB patch only runs
> > > the init in a lazy fashion, so if nobody uses the RGB sysfs the init
> > > does not run and the behavior is the same.
> > There are a few problems here:
> > 1. sope creep: either do a cleanup or solve bugs. The fact that your flow z13
> > doesn't load hid-asus correctly has nothing to do with the initialization of anime.
> > The fact that hid-asus is driving leds instead of asus-wmi has nothing to do with
> > anime matrix initialization either.
> > 2. not sending the initialization can get hardware misbehave because it
> > is left in an uninitialized state.
> > 3. there are absolutely zero reasons to do that. There are even less reasons
> > as to do it as part of this patchset.
> >
> > >> 2. Your patchset resolves around keyboard backlight control and how
> > >> the keyboard device is exposed to userspace: it's fine but I do not see
> > >> the point in removing initialization commands that has nothing to do
> > >> with the issue we are trying to solve here.
> > >>
> > >> Please leave 0x5E and 0x5D initialization commands where they are now.
> > > I mean the second part of the patchset does that. The first part is a
> > > cleanup. What would be the reason for keeping 0x5E and 0x5D? They are
> > > only used when initializing those endpoints to write further commands
> > > to them and for identification. The current driver does not write
> > > commands to those endpoints and identifies itself over 0x5A.
> > There are no bugs opened that ties initialization of devices to bugs.
> > Quite the opposite: I can guarantee you that removing part of the
> > init will introduce regressions.
> >
> > The onus is on you to provide strong evidence that the removal is
> > a necessary act.
> >
> > Regardless it is not in the scope of this patchset: remove it.
> > > I do get that it is a bit risky as some laptops might be hardcoded to
> > > wait for 0x5D to turn on RGB. Which is why we had the last patch until
> > > V4. But we have yet to find a laptop that has this problem, so I find
> > > it difficult to justify keeping the init.
> > Yes it's risky to remove initialization sequences for a device that is
> > in every modern ASUS laptop and is tied to the EC.
> > > Do note that you might need to add the 0x5D init to your userspace
> > > program for certain laptops if you haven't already. But that is ok,
> > > since in doing so you are also validating you are speaking to an Asus
> > > device, which is important.
> > This doesn't make much sense: why would anyone remove
> > a command from the kernel, that can be very well essential to some models
> > (sleep can break, for example) just to add it back in a userspace program?
> >
> > What does it mean I have to validate I am speaking to an asus device?
> > Software selects devices by known attribute, one of them is the vid:pid....
> > Beside what does this have to do with the removal of initialization commands
> > from the kernel?
> >
> > Even late initializing devices can lead to problems. Windows doesn't do that:
> > as soon as asus drivers are loaded all relevant initialization sequences are
> > sent; Windows is the only officially supported OS: do not introduce commands
> > flow divergence without strong reasons backing it up.
>
> If you think keeping 0x5D init is that important, I can spin patch [1]
> into this series. But then this quirk will stay in the kernel forever.
> I can even add 0x5E since that does not affect newer devices, which I
> care for simplifying the sequence.
>
> Luke said these two pairs are the important ones to keep.
>
> I'm not sure what to do.

I was asked by a 2025 Asus Zenbook Duo user to add his IDs in [1]. In
doing so, I updated the rgb and legacy init patches for the new series
and added a quirk for early init of the duo keyboards.

The series is 14 patches long, I don't think my email can take it :(

Should we merge the first part of this series with the legacy init,
then do the backlight refactor, and finally the new Duo stuff + rgb?

Antheas

> Antheas
>
> [1] https://lore.kernel.org/all/20250325184601.10990-12-lkml@antheas.dev/
>
> > > Antheas
> > >
> > Denis
> > >>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > >>>>> ---
> > >>>>>  drivers/hid/hid-asus.c | 56 ++++++++++++++----------------------------
> > >>>>>  1 file changed, 19 insertions(+), 37 deletions(-)
> > >>>>>
> > >>>>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> > >>>>> index a444d41e53b6..7ea1037c3979 100644
> > >>>>> --- a/drivers/hid/hid-asus.c
> > >>>>> +++ b/drivers/hid/hid-asus.c
> > >>>>> @@ -638,50 +638,32 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
> > >>>>>       unsigned char kbd_func;
> > >>>>>       int ret;
> > >>>>>
> > >>>>> -     if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
> > >>>>> -             /* Initialize keyboard */
> > >>>>> -             ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
> > >>>>> -             if (ret < 0)
> > >>>>> -                     return ret;
> > >>>>> -
> > >>>>> -             /* The LED endpoint is initialised in two HID */
> > >>>>> -             ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID1);
> > >>>>> -             if (ret < 0)
> > >>>>> -                     return ret;
> > >>>>> -
> > >>>>> -             ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID2);
> > >>>>> -             if (ret < 0)
> > >>>>> -                     return ret;
> > >>>>> -
> > >>>>> -             if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
> > >>>>> -                     ret = asus_kbd_disable_oobe(hdev);
> > >>>>> -                     if (ret < 0)
> > >>>>> -                             return ret;
> > >>>>> -             }
> > >>>>> -
> > >>>>> -             if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> > >>>>> -                     intf = to_usb_interface(hdev->dev.parent);
> > >>>>> -                     udev = interface_to_usbdev(intf);
> > >>>>> -                     validate_mcu_fw_version(hdev,
> > >>>>> -                             le16_to_cpu(udev->descriptor.idProduct));
> > >>>>> -             }
> > >>>>> +     ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
> > >>>>> +     if (ret < 0)
> > >>>>> +             return ret;
> > >>>>>
> > >>>>> -     } else {
> > >>>>> -             /* Initialize keyboard */
> > >>>>> -             ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
> > >>>>> -             if (ret < 0)
> > >>>>> -                     return ret;
> > >>>>> +     /* Get keyboard functions */
> > >>>>> +     ret = asus_kbd_get_functions(hdev, &kbd_func, FEATURE_KBD_REPORT_ID);
> > >>>>> +     if (ret < 0)
> > >>>>> +             return ret;
> > >>>>>
> > >>>>> -             /* Get keyboard functions */
> > >>>>> -             ret = asus_kbd_get_functions(hdev, &kbd_func, FEATURE_KBD_REPORT_ID);
> > >>>>> +     if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
> > >>>>> +             ret = asus_kbd_disable_oobe(hdev);
> > >>>>>               if (ret < 0)
> > >>>>>                       return ret;
> > >>>>> +     }
> > >>>>>
> > >>>>> -             /* Check for backlight support */
> > >>>>> -             if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
> > >>>>> -                     return -ENODEV;
> > >>>>> +     if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> > >>>>> +             intf = to_usb_interface(hdev->dev.parent);
> > >>>>> +             udev = interface_to_usbdev(intf);
> > >>>>> +             validate_mcu_fw_version(
> > >>>>> +                     hdev, le16_to_cpu(udev->descriptor.idProduct));
> > >>>>>       }
> > >>>>>
> > >>>>> +     /* Check for backlight support */
> > >>>>> +     if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
> > >>>>> +             return -ENODEV;
> > >>>>> +
> > >>>>>       drvdata->kbd_backlight = devm_kzalloc(&hdev->dev,
> > >>>>>                                             sizeof(struct asus_kbd_leds),
> > >>>>>                                             GFP_KERNEL);
> >


