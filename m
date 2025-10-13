Return-Path: <linux-kernel+bounces-851411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 814C5BD6617
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 084E3350E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D1C2EDD76;
	Mon, 13 Oct 2025 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STVdBJ5n"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862B2DE1F0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391407; cv=none; b=fiocy3MPz7ibI4FihfD/sf2SLFQY+62t//EjBJzY80v8BY1TD34tMvlGCR8XKqrkFeFhgRcDW3Z7mCd0RKUCmyAEl9yXzdB4Zc2rsAnXX1Rs+AGHXB3N77aDxnydSVLnlxsNajrwG8vA05nfSjIYmfShZ+noDpMmxiPfFs1b3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391407; c=relaxed/simple;
	bh=s6j0ZYCaL08K3BVXigJwH67BJEXmUSYpWj75Dcit+PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ugxm3xFcfPit+5ME3GKvvCMH9476PDrojmDD+YF4zlKlcHIIKxRw9U/Tf0e73o+FheHyicNV6ziFUTouVtuh5LYJCDAwreSiYlMql4svPiFKpmXjutMwyihAiafqzkLiw8N06JuvPaPaEuay4Ur2MiVM94CaJDKkl38b6SyHGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STVdBJ5n; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so33575965e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760391404; x=1760996204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nu5z4mg3xCRHNl5zheHeBL5r5Nli+aiOa9GaVNwhvDE=;
        b=STVdBJ5nI0CNyxGtQuTrHlVCmGTAo6uSwt5oo4VO8pBVoR9H5p3YvSe9zajRpiXXpJ
         fB8d39PByBtLfuU9FDvDwk2SEHkDgbXAFsCpXBbH0E8h1ap8vt/rA8lwzL8rC817/UAW
         Cyj9cJTHAgkVZCGyeM4yKwbEqGLr6yshaXmN4cYVuLIkrvscDVe9Vc4cmPeXGFqlfG6+
         I3aDsekAOOIH9D9lEi3Y+5u6/oBntxaPEy1ZVk6QBIAzcpCYcl7sCwviOZham8q80KHA
         1A29Q+1ByLSGQLeSExTRDFYiVnnuU+XlYAJz+p+QA1xiX+1Kij+sq5EU/Qrv31qSAarh
         sC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760391404; x=1760996204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nu5z4mg3xCRHNl5zheHeBL5r5Nli+aiOa9GaVNwhvDE=;
        b=gpwMHf7n9hFaoO1hIQiwGvJKrlZyAMZ59Mmyo6q08EheA9TAzGv1g9dX+bKVSOJL5P
         goAqPeFCn8fcGqkd0OboGksEEiP9z8muICcMHE80ueAzawaBN/4tcjVOkGte/AEgbPL2
         cYw8BFU0gKsSo5tTXIR2MxFG9E5zZMGY+hY+Q24086Cxp81lls5AyaSwful0THmKC7xx
         HlaPhxgs5zCTtZpfaP6dPI+tPvKnX8hOaGknW4jPVhe2cKJEdo5s6fCizuludGAy6ngb
         mnRonssKrBQVNXlKYtQ8J/N7ruvndr7tXADVL82PYc2YMwMJMUS5+andDm1sR2xafooa
         EBqw==
X-Gm-Message-State: AOJu0Yw2i9ZtRsLrCP8mUo/2IL24LurIS+SoGMvLAOOMbzc/85lZUizb
	SyFoPv05wyb1yKF8ej0xw0DHhwo+U5zNVEPc03yqeBYef29lOf3oFCcGWR9cPUu6
X-Gm-Gg: ASbGnctJ/UYByozaKLqV1oa7Ki99v70oOqZF3FYhstVb7RJQ7uObuRHRUCq1n64qGfJ
	3+zFif/bCXEDZFVyEKAbHJTssxwOGvf4+LlO2/cxE+jWyBkzJdpXZlKR4DXIpWaSMjhJj//i8c+
	ALC83fJfALW2b7n5BHPlnJRrO2VmHivZttUmfB+yaVAxQ3/GG0gqIQbOiBqVHiLSpyhVwS5RIPr
	K2UHBXfwJq09uJq+w9WUmzDoPEiJOISGxNLlo8T+/7Rx5/OqUrI20CMrRLstGouBZg43MRphCSe
	lZAFblQBTEk4jfIm7XugSfUw4QU9Bdux0ktPLiBlHl3vZ6emaaJku4oX4SxtFcRLrqlGFhozJSF
	4nHSn4fF1ra1/jMkm94lrdN9Viy3nevAHU6XUetmZwTRanbE/mV4bby9nIg+PBNJS/g==
X-Google-Smtp-Source: AGHT+IGMncAm63bsnpKtZ420DMDx3/1flo/2Ky3sEH0+wJMnWCS0rjcq+tvSA75zUV+PLkJe9itCag==
X-Received: by 2002:a5d:5d85:0:b0:3eb:5245:7c1f with SMTP id ffacd0b85a97d-42666ac46ffmr12236133f8f.2.1760391404109;
        Mon, 13 Oct 2025 14:36:44 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d4bbsm20448482f8f.2.2025.10.13.14.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 14:36:43 -0700 (PDT)
Message-ID: <f936d9c0-ab58-4205-afd2-2d6b857cad57@gmail.com>
Date: Mon, 13 Oct 2025 23:36:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] HID: asus: Fix ASUS ROG Laptop's Keyboard
 backlight handling
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20251013201535.6737-1-lkml@antheas.dev>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <20251013201535.6737-1-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/13/25 22:15, Antheas Kapenekakis wrote:
> This is a two part series which does the following:
>   - Clean-up init sequence
>   - Unify backlight handling to happen under asus-wmi so that all Aura
>     devices have synced brightness controls and the backlight button works
>     properly when it is on a USB laptop keyboard instead of one w/ WMI.
>
> For more context, see cover letter of V1. Since V5, I removed some patches
> to make this easier to merge.
>
> All comments with these patches had been addressed since V4.
>
> ---
> V5: https://lore.kernel.org/all/20250325184601.10990-1-lkml@antheas.dev/
> V4: https://lore.kernel.org/lkml/20250324210151.6042-1-lkml@antheas.dev/
> V3: https://lore.kernel.org/lkml/20250322102804.418000-1-lkml@antheas.dev/
> V2: https://lore.kernel.org/all/20250320220924.5023-1-lkml@antheas.dev/
> V1: https://lore.kernel.org/all/20250319191320.10092-1-lkml@antheas.dev/
>
> Changes since V5:
>   - It's been a long time
>   - Remove addition of RGB as that had some comments I need to work on
Hello and thanks for this,

I would like to see a set of objectives that this series is trying to reach clearly spelled out:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
section 2, basically.

I can deduct you are trying to fix certain keyboards having keys not properly changing
the backlight, but is that all there is to it?

These commits sure touches a lot of code to fix an (unspecified? Unclear to me at least) number of bugs.

Given the fact I expect regressions (nothing personal: ASUS has a very large pool of models,
many requiring specialized quirks as can be seen in the diff)
wouldn't it be wise to take the chance and expose the "static" lighting mode,
including colors handling, for every asus rog, tuf, tx and proart laptop
in existence in a way that most already-existing programs (including the KDE widget) can handle?
At least there would be a big incentive behind all these changes.

[^ the above paragraph is valid if the number of fixed bugs is small and there is at least another way to fix it/them].

Surely data needed to check what model support
what lighting mode is known at this point, would probably be wise
to put such data in the kernel and make good use of it.

Thanks,
Denis

>   - Remove folio patch (already merged)
>   - Remove legacy fix patch 11 from V4. There is a small chance that
>     without this patch, some old NKEY keyboards might not respond to
>     RGB commands according to Luke, but the kernel driver does not do
>     RGB currently. The 0x5d init is done by Armoury crate software in
>     Windows. If an issue is found, we can re-add it or just remove patches
>     1/2 before merging. However, init could use the cleanup.
>
> Changes since V4:
>   - Fix KConfig (reported by kernel robot)
>   - Fix Ilpo's nits, if I missed anything lmk
>
> Changes since V3:
>   - Add initializer for 0x5d for old NKEY keyboards until it is verified
>     that it is not needed for their media keys to function.
>   - Cover init in asus-wmi with spinlock as per Hans
>   - If asus-wmi registers WMI handler with brightness, init the brightness
>     in USB Asus keyboards, per Hans.
>   - Change hid handler name to asus-UNIQ:rgb:peripheral to match led class
>   - Fix oops when unregistering asus-wmi by moving unregister outside of
>     the spin lock (but after the asus reference is set to null)
>
> Changes since V2:
>   - Check lazy init succeds in asus-wmi before setting register variable
>   - make explicit check in asus_hid_register_listener for listener existing
>     to avoid re-init
>   - rename asus_brt to asus_hid in most places and harmonize everything
>   - switch to a spinlock instead of a mutex to avoid kernel ooops
>   - fixup hid device quirks to avoid multiple RGB devices while still exposing
>     all input vendor devices. This includes moving rgb init to probe
>     instead of the input_configured callbacks.
>   - Remove fan key (during retest it appears to be 0xae that is already
>     supported by hid-asus)
>   - Never unregister asus::kbd_backlight while asus-wmi is active, as that
>   - removes fds from userspace and breaks backlight functionality. All
>   - current mainline drivers do not support backlight hotplugging, so most
>     userspace software (e.g., KDE, UPower) is built with that assumption.
>     For the Ally, since it disconnects its controller during sleep, this
>     caused the backlight slider to not work in KDE.
>
> Changes since V1:
>   - Add basic RGB support on hid-asus, (Z13/Ally) tested in KDE/Z13
>   - Fix ifdef else having an invalid signature (reported by kernel robot)
>   - Restore input arguments to init and keyboard function so they can
>     be re-used for RGB controls.
>   - Remove Z13 delay (it did not work to fix the touchpad) and replace it
>     with a HID_GROUP_GENERIC quirk to allow hid-multitouch to load. Squash
>     keyboard rename into it.
>   - Unregister brightness listener before removing work queue to avoid
>     a race condition causing corruption
>   - Remove spurious mutex unlock in asus_brt_event
>   - Place mutex lock in kbd_led_set after LED_UNREGISTERING check to avoid
>     relocking the mutex and causing a deadlock when unregistering leds
>   - Add extra check during unregistering to avoid calling unregister when
>     no led device is registered.
>   - Temporarily HID_QUIRK_INPUT_PER_APP from the ROG endpoint as it causes
>     the driver to create 4 RGB handlers per device. I also suspect some
>     extra events sneak through (KDE had the @@@@@@).
>
> Antheas Kapenekakis (7):
>   HID: asus: refactor init sequence per spec
>   HID: asus: prevent binding to all HID devices on ROG
>   platform/x86: asus-wmi: Add support for multiple kbd RGB handlers
>   HID: asus: listen to the asus-wmi brightness device instead of
>     creating one
>   platform/x86: asus-wmi: remove unused keyboard backlight quirk
>   platform/x86: asus-wmi: add keyboard brightness event handler
>   HID: asus: add support for the asus-wmi brightness handler
>
>  drivers/hid/hid-asus.c                     | 235 +++++++++++----------
>  drivers/platform/x86/asus-wmi.c            | 157 ++++++++++++--
>  include/linux/platform_data/x86/asus-wmi.h |  69 +++---
>  3 files changed, 291 insertions(+), 170 deletions(-)
>
>
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787

