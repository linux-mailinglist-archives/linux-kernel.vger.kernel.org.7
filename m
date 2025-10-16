Return-Path: <linux-kernel+bounces-856577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC6ABE4846
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D450E544B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DA332AAC7;
	Thu, 16 Oct 2025 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="gkmtMb75"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6627C76026
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631413; cv=none; b=Hicd9jLl/Ra8uKe4PbtTRNXXZIh6a1aBFx3D4u+yg85sK95qxhKwb1lDgtnI3G/oCZ3+lCEtMDth5nehSoo/Hc8BaaE+8FMw6m1SvFPQKYIv/MdCWGHQG+SU2beahErm7p46iuYElnoYis8Ilgjxy3MpaWzxhHER+oEaubP0FXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631413; c=relaxed/simple;
	bh=I8TPStSOWTc1ywCC/PFYsGxmS4XKEK7rlkVnKhY9nKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtmJRurlCOJtojWC4HBP2WSbM8OW8L29v3ELooYM5jEQalq3xdKCSYXfW6MEE6bM87OJiWOK4v5K0gFJGu46WZ/qvNpmDArsi7sNL8DMIeCx1Z4fEV2EMfh+l0ySDdmH9l0VJYj0i6vWUYYoGesy0wEh5o5OkNs08TnyPPTaoNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=gkmtMb75; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 695F142735
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:16:48 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 00CDA4763B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:16:46 +0300 (EEST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id CC4721FEB7A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:16:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1760631405;
	bh=7fFB9OKT/v7gkno3hKDfnyn/d5f3CWo3hujRgju3zec=;
	h=Received:From:Subject:To;
	b=gkmtMb75etVoOhgJ7///fq+eY+tEdOeCFc4YPOxzQw2ydJG2Bb3VnjF2xggWz8X7g
	 m+JK6Q/vwIq8MEcJ7oIwkzhI0OH3UlKij9nOvxInUG3HDJx3HzmbXw2GLa6pLGDmow
	 e8NwiSop/rc+Yuxt+zyGiBevnBXgrHCL2NT6FDw5ZqlODML+9vT7OniSItOviB8GK8
	 dNrbQ6aqjaJVvmxypipRGpqs8itgV/bgw8+hp3zg/X8NuMSX9msulFn3hODFRi0nS/
	 5F+cJ7Dkh3PNmrB3rjhESl3dAYEgDGhYcJL6N7WAlLo+ieuA48RcwDGpzd1iNDBnxT
	 IOvVbugmD5hOg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.182) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f182.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-3778144a440so11964141fa.0
        for <linux-kernel@vger.kernel.org>;
 Thu, 16 Oct 2025 09:16:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVPL1FngCUTMKzl0pz/PEldc2CmL136jORPXjz7+mlrKoBgT3DyrIQQvaIJ580NVV33npXBZyGnID7jv1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkUgG3EFgQQiDbDZIKdJHI+khqsy/wXE4/zzXfp1ee97D8QVlq
	lmHTQJeFMM44MWBE70ELT2cssqQAQtPk8tLfD4bsyLXfE2//FHWoY08vaDYajBvfurlSvFK51TW
	6NjOpbJ+fHTVWCp9JN0E6+YyemJCq0rc=
X-Google-Smtp-Source: 
 AGHT+IGDrt0y04ePLzv00Qz0jsm7XROK4pcLgD8IQDSIIDwazQymSP/lwa0lll09PqyJz0OT8PedXflmgENKBmK/k2E=
X-Received: by 2002:a05:651c:19a2:b0:372:89df:9673 with SMTP id
 38308e7fff4ca-377821db658mr13438111fa.13.1760631403893; Thu, 16 Oct 2025
 09:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013201535.6737-1-lkml@antheas.dev>
 <160c3adf-9333-4486-ba4c-d3359ea73337@gmail.com>
 <CAGwozwGzOQ-LCk6B202-CuKq=gepn6Mt4LitJJZ7dfMLaDVs7Q@mail.gmail.com>
 <c075a9f4-8103-dbcc-a1e7-4eaec5e90597@linux.intel.com>
In-Reply-To: <c075a9f4-8103-dbcc-a1e7-4eaec5e90597@linux.intel.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 16 Oct 2025 18:16:31 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwH3VnTsx8p5N6S1yp4Z9mFfPUdZ4frrnPAveLH2a00K6g@mail.gmail.com>
X-Gm-Features: AS18NWC9e6fbOnX-fx6764d0xMH_ti5HrtfbeZYPLSaYGIp5ibvgq-WQC4yYhXo
Message-ID: 
 <CAGwozwH3VnTsx8p5N6S1yp4Z9mFfPUdZ4frrnPAveLH2a00K6g@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] HID: asus: Fix ASUS ROG Laptop's Keyboard
 backlight handling
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Denis Benato <benato.denis96@gmail.com>,
 platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Corentin Chary <corentin.chary@gmail.com>,
 "Luke D . Jones" <luke@ljones.dev>,
	Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <176063140541.4064666.11348617816794351250@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 16 Oct 2025 at 17:09, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 16 Oct 2025, Antheas Kapenekakis wrote:
> > On Thu, 16 Oct 2025 at 13:57, Denis Benato <benato.denis96@gmail.com> w=
rote:
> > > On 10/13/25 22:15, Antheas Kapenekakis wrote:
> > > > This is a two part series which does the following:
> > > >   - Clean-up init sequence
> > > >   - Unify backlight handling to happen under asus-wmi so that all A=
ura
> > > >     devices have synced brightness controls and the backlight butto=
n works
> > > >     properly when it is on a USB laptop keyboard instead of one w/ =
WMI.
> > > >
> > > > For more context, see cover letter of V1. Since V5, I removed some =
patches
> > > > to make this easier to merge.
> > > >
> > > > All comments with these patches had been addressed since V4.
> > > I have loaded this patchset for users of asus-linux project to try ou=
t.
> > >
> > > One of them opened a bug report about a kernel bug that happens
> > > consistently when closing the lid of his laptop [1].
> > >
> > > He also sent another piece of kernel log, but didn't specify anything=
 more
> > > about this [2].
> > >
> > > [1] https://pastebin.com/akZx1w10
> > > [2] https://pastebin.com/sKdczPgf
> >
> > Can you provide a link to the bug report? [2] seems unrelated.
> >
> > As for [1], it looks like a trace that stems from a sysfs write to
> > brightness stemming from userspace that follows the same chain it
> > would on a stock kernel and times out. Is it present on a stock
> > kernel?
> >
> > Ilpo should know more about this, could the spinlock be interfering?
>
> [1] certainly seems to do schedule() from do_kbd_led_set() so it's not
> possible to use spinlock there.
>
> So we're back to what requires the spinlock? And what the spinlock
> protects?

For that invocation, since it is coming from the cdev device owned by
asus_wmi, it protects asus_ref.listeners under do_kbd_led_set.
asus_wmi is protected by the fact it is owned by that device. Spinlock
is not required in this invocation due to not being an IRQ.

Under asus_hid_event (second to last patch), which is called from an
IRQ, a spinlock is required for protecting both listeners and the
asus_ref.asus, and I suspect that scheduling from an IRQ is not
allowed either. Is that correct?

Antheas
>
> Not related to this particular email in this thread, if the users are
> testing something with different kernels, it's also important to make sur=
e
> that the lockdep configs are enabled in both. As it could be that in one
> kernel lockdep is not enabled and thus it won't do the splat.
>
> --
>  i.
>
>
> > My testing on devices that have WMI led controls is a bit limited
> > unfortunately. However, most of our asus users have been happy with
> > this series for around half a year now.
> >
> > > > ---
> > > > V5: https://lore.kernel.org/all/20250325184601.10990-1-lkml@antheas=
.dev/
> > > > V4: https://lore.kernel.org/lkml/20250324210151.6042-1-lkml@antheas=
.dev/
> > > > V3: https://lore.kernel.org/lkml/20250322102804.418000-1-lkml@anthe=
as.dev/
> > > > V2: https://lore.kernel.org/all/20250320220924.5023-1-lkml@antheas.=
dev/
> > > > V1: https://lore.kernel.org/all/20250319191320.10092-1-lkml@antheas=
.dev/
> > > >
> > > > Changes since V5:
> > > >   - It's been a long time
> > > >   - Remove addition of RGB as that had some comments I need to work=
 on
> > > >   - Remove folio patch (already merged)
> > > >   - Remove legacy fix patch 11 from V4. There is a small chance tha=
t
> > > >     without this patch, some old NKEY keyboards might not respond t=
o
> > > >     RGB commands according to Luke, but the kernel driver does not =
do
> > > >     RGB currently. The 0x5d init is done by Armoury crate software =
in
> > > >     Windows. If an issue is found, we can re-add it or just remove =
patches
> > > >     1/2 before merging. However, init could use the cleanup.
> > > >
> > > > Changes since V4:
> > > >   - Fix KConfig (reported by kernel robot)
> > > >   - Fix Ilpo's nits, if I missed anything lmk
> > > >
> > > > Changes since V3:
> > > >   - Add initializer for 0x5d for old NKEY keyboards until it is ver=
ified
> > > >     that it is not needed for their media keys to function.
> > > >   - Cover init in asus-wmi with spinlock as per Hans
> > > >   - If asus-wmi registers WMI handler with brightness, init the bri=
ghtness
> > > >     in USB Asus keyboards, per Hans.
> > > >   - Change hid handler name to asus-UNIQ:rgb:peripheral to match le=
d class
> > > >   - Fix oops when unregistering asus-wmi by moving unregister outsi=
de of
> > > >     the spin lock (but after the asus reference is set to null)
> > > >
> > > > Changes since V2:
> > > >   - Check lazy init succeds in asus-wmi before setting register var=
iable
> > > >   - make explicit check in asus_hid_register_listener for listener =
existing
> > > >     to avoid re-init
> > > >   - rename asus_brt to asus_hid in most places and harmonize everyt=
hing
> > > >   - switch to a spinlock instead of a mutex to avoid kernel ooops
> > > >   - fixup hid device quirks to avoid multiple RGB devices while sti=
ll exposing
> > > >     all input vendor devices. This includes moving rgb init to prob=
e
> > > >     instead of the input_configured callbacks.
> > > >   - Remove fan key (during retest it appears to be 0xae that is alr=
eady
> > > >     supported by hid-asus)
> > > >   - Never unregister asus::kbd_backlight while asus-wmi is active, =
as that
> > > >   - removes fds from userspace and breaks backlight functionality. =
All
> > > >   - current mainline drivers do not support backlight hotplugging, =
so most
> > > >     userspace software (e.g., KDE, UPower) is built with that assum=
ption.
> > > >     For the Ally, since it disconnects its controller during sleep,=
 this
> > > >     caused the backlight slider to not work in KDE.
> > > >
> > > > Changes since V1:
> > > >   - Add basic RGB support on hid-asus, (Z13/Ally) tested in KDE/Z13
> > > >   - Fix ifdef else having an invalid signature (reported by kernel =
robot)
> > > >   - Restore input arguments to init and keyboard function so they c=
an
> > > >     be re-used for RGB controls.
> > > >   - Remove Z13 delay (it did not work to fix the touchpad) and repl=
ace it
> > > >     with a HID_GROUP_GENERIC quirk to allow hid-multitouch to load.=
 Squash
> > > >     keyboard rename into it.
> > > >   - Unregister brightness listener before removing work queue to av=
oid
> > > >     a race condition causing corruption
> > > >   - Remove spurious mutex unlock in asus_brt_event
> > > >   - Place mutex lock in kbd_led_set after LED_UNREGISTERING check t=
o avoid
> > > >     relocking the mutex and causing a deadlock when unregistering l=
eds
> > > >   - Add extra check during unregistering to avoid calling unregiste=
r when
> > > >     no led device is registered.
> > > >   - Temporarily HID_QUIRK_INPUT_PER_APP from the ROG endpoint as it=
 causes
> > > >     the driver to create 4 RGB handlers per device. I also suspect =
some
> > > >     extra events sneak through (KDE had the @@@@@@).
> > > >
> > > > Antheas Kapenekakis (7):
> > > >   HID: asus: refactor init sequence per spec
> > > >   HID: asus: prevent binding to all HID devices on ROG
> > > >   platform/x86: asus-wmi: Add support for multiple kbd RGB handlers
> > > >   HID: asus: listen to the asus-wmi brightness device instead of
> > > >     creating one
> > > >   platform/x86: asus-wmi: remove unused keyboard backlight quirk
> > > >   platform/x86: asus-wmi: add keyboard brightness event handler
> > > >   HID: asus: add support for the asus-wmi brightness handler
> > > >
> > > >  drivers/hid/hid-asus.c                     | 235 +++++++++++------=
----
> > > >  drivers/platform/x86/asus-wmi.c            | 157 ++++++++++++--
> > > >  include/linux/platform_data/x86/asus-wmi.h |  69 +++---
> > > >  3 files changed, 291 insertions(+), 170 deletions(-)
> > > >
> > > >
> > > > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > >
> >
>
>


