Return-Path: <linux-kernel+bounces-851418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F3BD666B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D2B64F4AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048A41E8836;
	Mon, 13 Oct 2025 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="d5YUgP6N"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D210D34BA41
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391935; cv=none; b=ZLffI8K4+A3SQA1/fIBzqdxfaSE0GHVGCkmEc8udQ5cUdm18/Jgo9YbNrC+WBgOL1qlEplAncoOrRnjpfB6V96B8wVHkw2ZlVmupEw5tKUuvBq2vbtkDf5ByUiuEBR4gDdZJ/OlXi2TVPgv+zaqcv3DHsJRSuYW0QwEDZrWiJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391935; c=relaxed/simple;
	bh=cclDK2BAFQm6kJ00RJaS+GKYvmxKaZnwXbxZkXQE/Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xvvhtyddk6as6YE0PycQWNJuQehNUQhEB0zUsnde+LRA9k6PS8XYbICmQYEROj2WV6l/4EHmjxl5LmyE+U3njxm7b3EJ83KVADf4xLJFdhDoOLBhhGxaQ71o077OLeaT1qF2MKuNPytoolOxuRhTpK1j6cP7Cj5rkPTSUKAb7GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=d5YUgP6N; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id BBF723EC32
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:45:30 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 9CCBE3EBC3
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:45:29 +0300 (EEST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id E4AFD1FDBC5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:45:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1760391929;
	bh=6geIx3tS0bxCUQr0vUyvQOM4/WMUsfqmxa8Je5kWtvc=;
	h=Received:From:Subject:To;
	b=d5YUgP6NtZ1qoxNSmjDTIScYyaCbmdal48RBJ4E6f41waTURCWfRZ0WJIcMgePUkA
	 cTsxfvxbdiU2APNTQ1C4LOnZvkDfn9+azBteAZRB0dLedBqourjHl+MWmnOumq+pps
	 DHpPm1p0J0XDKNgiY8de6Xl2cUrf92MsnCL+8d42a9I13VyLnKUtXRReeNSqE/i8/U
	 bDqGJJhaQ9veJlDy2+JYDmPCN6d4WNmDje+GUGBxszeRzEulAM8BoML++zCsvpSfgV
	 WlvjVRHys3WiImbFohX0j51QyBWYe07Gt9vnzDayI4CtmlmnPh1e9H0AMALoHWZET2
	 x69otSdQ15Iuw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.170) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f170.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-371e4858f74so55506201fa.1
        for <linux-kernel@vger.kernel.org>;
 Mon, 13 Oct 2025 14:45:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCX/Shz2LHLdMloZJ9x7I3rYqm3QYEI1SVzDTgITxSE0I2P1qMUEqLYYgrfC0J3JXe2p0BhDwkcAGSsHR68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVjDO7rOS06w4cg4rqZeTprN6/GLQ3xRDqzYWVi/JEUC/XQsjx
	YlipOvy4wyQtX3xV7Y0nJZHD+8+srj515QMi8uLHfVC2B9lIEqA6syCXl9AXFuKzvpQw2iqeFRZ
	SQ2L1AagJOCuB63wQI/hnt4fiok32cU4=
X-Google-Smtp-Source: 
 AGHT+IFa3im/Zow8xfyqxFPDndTPvq75BoRPjejtBlBvKBGXD3okSS686GRvidI8awt5OyKgEsvqGvX2PBPI4zHj3kM=
X-Received: by 2002:a05:651c:990:b0:335:352a:3c3 with SMTP id
 38308e7fff4ca-3760a2fa6bbmr61446731fa.8.1760391928347; Mon, 13 Oct 2025
 14:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013201535.6737-1-lkml@antheas.dev>
 <f936d9c0-ab58-4205-afd2-2d6b857cad57@gmail.com>
In-Reply-To: <f936d9c0-ab58-4205-afd2-2d6b857cad57@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 13 Oct 2025 23:45:17 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHy0EPjrLmfbD1k1xRFTBDTs+1HYCShePhi_w+Qjbt1Tw@mail.gmail.com>
X-Gm-Features: AS18NWBlKIpoGNDWUBb0dE2AEv22P2FnUHA6qRK68vYsQmAcSfIcH9gQWmnHaa4
Message-ID: 
 <CAGwozwHy0EPjrLmfbD1k1xRFTBDTs+1HYCShePhi_w+Qjbt1Tw@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] HID: asus: Fix ASUS ROG Laptop's Keyboard
 backlight handling
To: Denis Benato <benato.denis96@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176039192912.3674884.12146546158749902657@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 13 Oct 2025 at 23:36, Denis Benato <benato.denis96@gmail.com> wrote:
>
>
> On 10/13/25 22:15, Antheas Kapenekakis wrote:
> > This is a two part series which does the following:
> >   - Clean-up init sequence
> >   - Unify backlight handling to happen under asus-wmi so that all Aura
> >     devices have synced brightness controls and the backlight button works
> >     properly when it is on a USB laptop keyboard instead of one w/ WMI.
> >
> > For more context, see cover letter of V1. Since V5, I removed some patches
> > to make this easier to merge.
> >
> > All comments with these patches had been addressed since V4.
> >
> > ---
> > V5: https://lore.kernel.org/all/20250325184601.10990-1-lkml@antheas.dev/
> > V4: https://lore.kernel.org/lkml/20250324210151.6042-1-lkml@antheas.dev/
> > V3: https://lore.kernel.org/lkml/20250322102804.418000-1-lkml@antheas.dev/
> > V2: https://lore.kernel.org/all/20250320220924.5023-1-lkml@antheas.dev/
> > V1: https://lore.kernel.org/all/20250319191320.10092-1-lkml@antheas.dev/
> >
> > Changes since V5:
> >   - It's been a long time
> >   - Remove addition of RGB as that had some comments I need to work on
> Hello and thanks for this,
>
> I would like to see a set of objectives that this series is trying to reach clearly spelled out:
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
> section 2, basically.
>
> I can deduct you are trying to fix certain keyboards having keys not properly changing
> the backlight, but is that all there is to it?

First two patches cleanup the init sequence.

Next three patches centralize the keyboard brightness handler into
asus-wmi, by having hid-asus register a listener for brightness events
to it.

This allows Asus laptops that have both WMI and Aura devices to still
work without a rerouting quirk, the Z13 to work while having both a
lightbar and a keyboard (2 Aura devices), and specifically for devices
with removable keyboards such as the Z13, the ability to maintain the
same brightness file descriptor, so that handlers like upower do not
stop working after detaching the keyboard.

Finally, the last two patches send the brightness events to asus-wmi
to process them internally. This allows for 0-33%-66%-100% brightness,
instead of 100%/0% toggle. This mirrors how the thinkpad devices work
internally. Brightness events are broadcast, so KDE reports the
brightness changing correctly.

> These commits sure touches a lot of code to fix an (unspecified? Unclear to me at least) number of bugs.
>
> Given the fact I expect regressions (nothing personal: ASUS has a very large pool of models,
> many requiring specialized quirks as can be seen in the diff)
> wouldn't it be wise to take the chance and expose the "static" lighting mode,
> including colors handling, for every asus rog, tuf, tx and proart laptop
> in existence in a way that most already-existing programs (including the KDE widget) can handle?
> At least there would be a big incentive behind all these changes.

The patches for RGB have been removed from this series.

Thanks,
Antheas

> [^ the above paragraph is valid if the number of fixed bugs is small and there is at least another way to fix it/them].
>
> Surely data needed to check what model support
> what lighting mode is known at this point, would probably be wise
> to put such data in the kernel and make good use of it.
>
> Thanks,
> Denis
>
> >   - Remove folio patch (already merged)
> >   - Remove legacy fix patch 11 from V4. There is a small chance that
> >     without this patch, some old NKEY keyboards might not respond to
> >     RGB commands according to Luke, but the kernel driver does not do
> >     RGB currently. The 0x5d init is done by Armoury crate software in
> >     Windows. If an issue is found, we can re-add it or just remove patches
> >     1/2 before merging. However, init could use the cleanup.
> >
> > Changes since V4:
> >   - Fix KConfig (reported by kernel robot)
> >   - Fix Ilpo's nits, if I missed anything lmk
> >
> > Changes since V3:
> >   - Add initializer for 0x5d for old NKEY keyboards until it is verified
> >     that it is not needed for their media keys to function.
> >   - Cover init in asus-wmi with spinlock as per Hans
> >   - If asus-wmi registers WMI handler with brightness, init the brightness
> >     in USB Asus keyboards, per Hans.
> >   - Change hid handler name to asus-UNIQ:rgb:peripheral to match led class
> >   - Fix oops when unregistering asus-wmi by moving unregister outside of
> >     the spin lock (but after the asus reference is set to null)
> >
> > Changes since V2:
> >   - Check lazy init succeds in asus-wmi before setting register variable
> >   - make explicit check in asus_hid_register_listener for listener existing
> >     to avoid re-init
> >   - rename asus_brt to asus_hid in most places and harmonize everything
> >   - switch to a spinlock instead of a mutex to avoid kernel ooops
> >   - fixup hid device quirks to avoid multiple RGB devices while still exposing
> >     all input vendor devices. This includes moving rgb init to probe
> >     instead of the input_configured callbacks.
> >   - Remove fan key (during retest it appears to be 0xae that is already
> >     supported by hid-asus)
> >   - Never unregister asus::kbd_backlight while asus-wmi is active, as that
> >   - removes fds from userspace and breaks backlight functionality. All
> >   - current mainline drivers do not support backlight hotplugging, so most
> >     userspace software (e.g., KDE, UPower) is built with that assumption.
> >     For the Ally, since it disconnects its controller during sleep, this
> >     caused the backlight slider to not work in KDE.
> >
> > Changes since V1:
> >   - Add basic RGB support on hid-asus, (Z13/Ally) tested in KDE/Z13
> >   - Fix ifdef else having an invalid signature (reported by kernel robot)
> >   - Restore input arguments to init and keyboard function so they can
> >     be re-used for RGB controls.
> >   - Remove Z13 delay (it did not work to fix the touchpad) and replace it
> >     with a HID_GROUP_GENERIC quirk to allow hid-multitouch to load. Squash
> >     keyboard rename into it.
> >   - Unregister brightness listener before removing work queue to avoid
> >     a race condition causing corruption
> >   - Remove spurious mutex unlock in asus_brt_event
> >   - Place mutex lock in kbd_led_set after LED_UNREGISTERING check to avoid
> >     relocking the mutex and causing a deadlock when unregistering leds
> >   - Add extra check during unregistering to avoid calling unregister when
> >     no led device is registered.
> >   - Temporarily HID_QUIRK_INPUT_PER_APP from the ROG endpoint as it causes
> >     the driver to create 4 RGB handlers per device. I also suspect some
> >     extra events sneak through (KDE had the @@@@@@).
> >
> > Antheas Kapenekakis (7):
> >   HID: asus: refactor init sequence per spec
> >   HID: asus: prevent binding to all HID devices on ROG
> >   platform/x86: asus-wmi: Add support for multiple kbd RGB handlers
> >   HID: asus: listen to the asus-wmi brightness device instead of
> >     creating one
> >   platform/x86: asus-wmi: remove unused keyboard backlight quirk
> >   platform/x86: asus-wmi: add keyboard brightness event handler
> >   HID: asus: add support for the asus-wmi brightness handler
> >
> >  drivers/hid/hid-asus.c                     | 235 +++++++++++----------
> >  drivers/platform/x86/asus-wmi.c            | 157 ++++++++++++--
> >  include/linux/platform_data/x86/asus-wmi.h |  69 +++---
> >  3 files changed, 291 insertions(+), 170 deletions(-)
> >
> >
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
>


