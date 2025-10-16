Return-Path: <linux-kernel+bounces-856214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25835BE37F7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C62CE358C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCC53314B9;
	Thu, 16 Oct 2025 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="pH3O69UP"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF025A357
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619121; cv=none; b=J3nBhZCYTITMBqlo20160tMaYX9Lf4oMhLSymgOD1lGk8VMu7s0RxYGedUHyVqj0b6HK5wi6GukQWgZ14saEs7oNHX+AFzNaXsF0cHwPMbytzouXYHbNu3y846dmWXyh1RwHVQioPMLtHxENcCJJOo4hFmyDmWXyH/Ms9tzcS6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619121; c=relaxed/simple;
	bh=VoR66ikCYvkn1D1ErKICNOKHGY4siJaBIv5gUcYwR7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Py0yTKswCtrSYnccQGfLC4b49BR0Ond0lMIjfkhesWtqOzBSuJEHRInQkz8ibcsOcK72OPfeWDd+arlSbWN/ykg0rpp77D6vEvUrXt7/3FbtBpgOxgCXuE98liEsV9Uu7lvf2UPgfo1pANguH6a73p4lk1cvu6OXeLK7nivi0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=pH3O69UP; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 2F682BDC66
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:51:56 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id F0255BDA94
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:51:54 +0300 (EEST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 70DFC1FF277
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:51:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1760619114;
	bh=LDx5qF+YqGiZKOhDdt5T41oaqAkwphR1G3xCFVs8KJU=;
	h=Received:From:Subject:To;
	b=pH3O69UPoLYYTEOKxQSB3yqeIhJv0sUI3JVfGycv6kSd32PeeqWmpC+XLFjTIzlzL
	 rty8ZL9F0XsOmzverdPhHDOhc7u18xlbPUGBaMgvFsWEkvdL5uUzawT0tvLdFogeaq
	 Fpqih+6FlFObf0BJRfplUwdewQzn/SrmTCToGA6VFLPGFCqgFiYIyJSFSUDdNUNnPk
	 Hk42lS9ziT1NRqH1ygdVHji/DiiCqR7O9PUy2jSbfZPN4bBhuY8yXidRoFvU1TN6Gl
	 XlGUcsjwQ0MTZh15Bf/p8GZ8ojEsNbWGFViYDLmn4T38uqS5QxH5EKAOduYfEZ1g0u
	 lbHh/mrBH+MVA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.167.48) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f48.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-57a292a3a4bso844675e87.3
        for <linux-kernel@vger.kernel.org>;
 Thu, 16 Oct 2025 05:51:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWNDBf4CmJ1QXi9xLqjAooJdzoM6wDJ++a4HuqAfpSF6Mss+6mIbV7bp+IxTvioh2okzV1U4WnkPkbU23Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27OTaCTBJMIA8p/qXpcBYizcKwzpKxJuR50bXmM7ZQnJ/j8KL
	FU4STTaa5nzDoawuXXIUa1ZLtVsWNwgBDDUq02FjKvU50wHxIptFhUzuXVxaarktBbocNjAbNEX
	Vd5whBrMocTknxrt7gtEh8axHyJkl6c4=
X-Google-Smtp-Source: 
 AGHT+IEd5g9sc4RW5vGdMhiQnvCSmU/eK8ToWXr1HZ2CsCQgREqhQ0Pnn9q0DZ2fNhQLjMm351dtRXa5h/t+Aeoaqkk=
X-Received: by 2002:a05:651c:150c:b0:36f:4c94:b585 with SMTP id
 38308e7fff4ca-377978b3ddcmr375881fa.17.1760619113931; Thu, 16 Oct 2025
 05:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013201535.6737-1-lkml@antheas.dev>
 <160c3adf-9333-4486-ba4c-d3359ea73337@gmail.com>
 <CAGwozwGzOQ-LCk6B202-CuKq=gepn6Mt4LitJJZ7dfMLaDVs7Q@mail.gmail.com>
 <ce8cc332-54ec-4e12-aa7c-a6d5e2b4fa9d@gmail.com>
 <CAGwozwHrWxxE_vyswe39W=ui8N6ej4ZPFvuKVueyw4xLL8C4ZQ@mail.gmail.com>
 <13c53469-58fd-462a-a462-626975d6055f@gmail.com>
In-Reply-To: <13c53469-58fd-462a-a462-626975d6055f@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 16 Oct 2025 14:51:42 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHmTUb3Bcbn9Zc44sqe7DHtnnk0chvhjN7jJNrmePr8fw@mail.gmail.com>
X-Gm-Features: AS18NWDNCyu2QkWrrXm3Ri95RKDH2Hl2WWG9JpkgQDQtwFEc1k4A-1hU3TRX6b4
Message-ID: 
 <CAGwozwHmTUb3Bcbn9Zc44sqe7DHtnnk0chvhjN7jJNrmePr8fw@mail.gmail.com>
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
 <176061911465.3305188.16775460427767221681@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 16 Oct 2025 at 14:46, Denis Benato <benato.denis96@gmail.com> wrote:
>
>
> On 10/16/25 14:28, Antheas Kapenekakis wrote:
> > On Thu, 16 Oct 2025 at 14:19, Denis Benato <benato.denis96@gmail.com> wrote:
> >>
> >> On 10/16/25 14:14, Antheas Kapenekakis wrote:
> >>> On Thu, 16 Oct 2025 at 13:57, Denis Benato <benato.denis96@gmail.com> wrote:
> >>>> On 10/13/25 22:15, Antheas Kapenekakis wrote:
> >>>>> This is a two part series which does the following:
> >>>>>   - Clean-up init sequence
> >>>>>   - Unify backlight handling to happen under asus-wmi so that all Aura
> >>>>>     devices have synced brightness controls and the backlight button works
> >>>>>     properly when it is on a USB laptop keyboard instead of one w/ WMI.
> >>>>>
> >>>>> For more context, see cover letter of V1. Since V5, I removed some patches
> >>>>> to make this easier to merge.
> >>>>>
> >>>>> All comments with these patches had been addressed since V4.
> >>>> I have loaded this patchset for users of asus-linux project to try out.
> >>>>
> >>>> One of them opened a bug report about a kernel bug that happens
> >>>> consistently when closing the lid of his laptop [1].
> >>>>
> >>>> He also sent another piece of kernel log, but didn't specify anything more
> >>>> about this [2].
> >>>>
> >>>> [1] https://pastebin.com/akZx1w10
> >>>> [2] https://pastebin.com/sKdczPgf
> >>> Can you provide a link to the bug report? [2] seems unrelated.
> >> The log in [2] was posted without additional context in the same
> >> discord message as [1].
> > Link me the kernel sources. Is it linux-g14 in the AUR?
> Someone has replicated it on the AUR but it's just an out-of-sync replica.
>
> The true source code is here:
> https://gitlab.com/asus-linux/linux-g14 branch 6.17

Ok, lets wait for the user to replicate on a stock kernel

> >> I think I will tell the user to open a proper bug report because
> >> I do agree on the fact that it's looking unrelated.
> >>> As for [1], it looks like a trace that stems from a sysfs write to
> >>> brightness stemming from userspace that follows the same chain it
> >>> would on a stock kernel and times out. Is it present on a stock
> >>> kernel?
> >> I have asked more details to the user. The user is not online ATM
> >> so I will get to you with more details when I can.
> >>> Ilpo should know more about this, could the spinlock be interfering?
> >>> My testing on devices that have WMI led controls is a bit limited
> >>> unfortunately. However, most of our asus users have been happy with
> >>> this series for around half a year now.
> >> Unless they have looked to kernel logs they won't be able to tell
> >> since apparently there are no visible consequences.
> >>> Antheas
> >>>
> >>>>> ---
> >>>>> V5: https://lore.kernel.org/all/20250325184601.10990-1-lkml@antheas.dev/
> >>>>> V4: https://lore.kernel.org/lkml/20250324210151.6042-1-lkml@antheas.dev/
> >>>>> V3: https://lore.kernel.org/lkml/20250322102804.418000-1-lkml@antheas.dev/
> >>>>> V2: https://lore.kernel.org/all/20250320220924.5023-1-lkml@antheas.dev/
> >>>>> V1: https://lore.kernel.org/all/20250319191320.10092-1-lkml@antheas.dev/
> >>>>>
> >>>>> Changes since V5:
> >>>>>   - It's been a long time
> >>>>>   - Remove addition of RGB as that had some comments I need to work on
> >>>>>   - Remove folio patch (already merged)
> >>>>>   - Remove legacy fix patch 11 from V4. There is a small chance that
> >>>>>     without this patch, some old NKEY keyboards might not respond to
> >>>>>     RGB commands according to Luke, but the kernel driver does not do
> >>>>>     RGB currently. The 0x5d init is done by Armoury crate software in
> >>>>>     Windows. If an issue is found, we can re-add it or just remove patches
> >>>>>     1/2 before merging. However, init could use the cleanup.
> >>>>>
> >>>>> Changes since V4:
> >>>>>   - Fix KConfig (reported by kernel robot)
> >>>>>   - Fix Ilpo's nits, if I missed anything lmk
> >>>>>
> >>>>> Changes since V3:
> >>>>>   - Add initializer for 0x5d for old NKEY keyboards until it is verified
> >>>>>     that it is not needed for their media keys to function.
> >>>>>   - Cover init in asus-wmi with spinlock as per Hans
> >>>>>   - If asus-wmi registers WMI handler with brightness, init the brightness
> >>>>>     in USB Asus keyboards, per Hans.
> >>>>>   - Change hid handler name to asus-UNIQ:rgb:peripheral to match led class
> >>>>>   - Fix oops when unregistering asus-wmi by moving unregister outside of
> >>>>>     the spin lock (but after the asus reference is set to null)
> >>>>>
> >>>>> Changes since V2:
> >>>>>   - Check lazy init succeds in asus-wmi before setting register variable
> >>>>>   - make explicit check in asus_hid_register_listener for listener existing
> >>>>>     to avoid re-init
> >>>>>   - rename asus_brt to asus_hid in most places and harmonize everything
> >>>>>   - switch to a spinlock instead of a mutex to avoid kernel ooops
> >>>>>   - fixup hid device quirks to avoid multiple RGB devices while still exposing
> >>>>>     all input vendor devices. This includes moving rgb init to probe
> >>>>>     instead of the input_configured callbacks.
> >>>>>   - Remove fan key (during retest it appears to be 0xae that is already
> >>>>>     supported by hid-asus)
> >>>>>   - Never unregister asus::kbd_backlight while asus-wmi is active, as that
> >>>>>   - removes fds from userspace and breaks backlight functionality. All
> >>>>>   - current mainline drivers do not support backlight hotplugging, so most
> >>>>>     userspace software (e.g., KDE, UPower) is built with that assumption.
> >>>>>     For the Ally, since it disconnects its controller during sleep, this
> >>>>>     caused the backlight slider to not work in KDE.
> >>>>>
> >>>>> Changes since V1:
> >>>>>   - Add basic RGB support on hid-asus, (Z13/Ally) tested in KDE/Z13
> >>>>>   - Fix ifdef else having an invalid signature (reported by kernel robot)
> >>>>>   - Restore input arguments to init and keyboard function so they can
> >>>>>     be re-used for RGB controls.
> >>>>>   - Remove Z13 delay (it did not work to fix the touchpad) and replace it
> >>>>>     with a HID_GROUP_GENERIC quirk to allow hid-multitouch to load. Squash
> >>>>>     keyboard rename into it.
> >>>>>   - Unregister brightness listener before removing work queue to avoid
> >>>>>     a race condition causing corruption
> >>>>>   - Remove spurious mutex unlock in asus_brt_event
> >>>>>   - Place mutex lock in kbd_led_set after LED_UNREGISTERING check to avoid
> >>>>>     relocking the mutex and causing a deadlock when unregistering leds
> >>>>>   - Add extra check during unregistering to avoid calling unregister when
> >>>>>     no led device is registered.
> >>>>>   - Temporarily HID_QUIRK_INPUT_PER_APP from the ROG endpoint as it causes
> >>>>>     the driver to create 4 RGB handlers per device. I also suspect some
> >>>>>     extra events sneak through (KDE had the @@@@@@).
> >>>>>
> >>>>> Antheas Kapenekakis (7):
> >>>>>   HID: asus: refactor init sequence per spec
> >>>>>   HID: asus: prevent binding to all HID devices on ROG
> >>>>>   platform/x86: asus-wmi: Add support for multiple kbd RGB handlers
> >>>>>   HID: asus: listen to the asus-wmi brightness device instead of
> >>>>>     creating one
> >>>>>   platform/x86: asus-wmi: remove unused keyboard backlight quirk
> >>>>>   platform/x86: asus-wmi: add keyboard brightness event handler
> >>>>>   HID: asus: add support for the asus-wmi brightness handler
> >>>>>
> >>>>>  drivers/hid/hid-asus.c                     | 235 +++++++++++----------
> >>>>>  drivers/platform/x86/asus-wmi.c            | 157 ++++++++++++--
> >>>>>  include/linux/platform_data/x86/asus-wmi.h |  69 +++---
> >>>>>  3 files changed, 291 insertions(+), 170 deletions(-)
> >>>>>
> >>>>>
> >>>>> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
>


