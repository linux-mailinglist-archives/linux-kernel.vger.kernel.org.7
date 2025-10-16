Return-Path: <linux-kernel+bounces-856176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 35937BE3508
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7E8A3471C7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4540326D50;
	Thu, 16 Oct 2025 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYFf4kev"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0862E36F2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617159; cv=none; b=aoXQIMv2cwK22A1QCGnP1FR/67yWA7mNCBNPTYdvK67ilKnUFeBxFXW/JmW0DuCG5gW9cdFkg88usIeVm7rUVvTQUal3SOwdYQClpo0QT006N18fc4gFJPt84oAC/+x61rN+y6am7JUHABpGAwV0T0HJaBz+gSPX6hlkpLI3XYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617159; c=relaxed/simple;
	bh=ERazTbvd1p5z4jUhhtD5MW9L9tTN1PZnkhOHBIhG8OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cz5vB6qO69kNJbi9XgDJJGgEkEQg1vgxtcW+Qy5CWSj4cVfcERYSLz0Rc6LGWZQuYHIV1uhZH5eAPHrrbYO7Y+/WeJ6olBfJ8qu/1D/XHOqa+f6fOXXPihsXMGtrKYRo18hVCUb+GcwUrD1rU17uHGr5g9FuV8RBvJ9HOo7Kimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYFf4kev; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so6129385e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760617155; x=1761221955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1lRzBg6Y0DrujbaeCJgr3EEbAFrys3lR1v5Iou63/c=;
        b=MYFf4kevaweWweTBDipBhMpWBG/4MWy2hxjMbw63VzC0HeoqF6p2bXbOiEI2RVdvEJ
         F8pf/c2VlNeLYKo/ETItq//g71b3tLPhOkW4xt+RD7tWi3BKhqG/vi0yMnxu1o/naT/y
         8MNJbhIowdDaz/Ww0taD9Ai0Ht9R/Ym8Va1bHX+DmLwcnT/kNDUWsTVRIUtAs6uyhAa3
         e52jsNNwe/uIcKLXiee6adzn78fOTboxJq9cNKWl2kKhTLonCwBOO6lxD8KeVyTMJX4h
         WhXMv8mvv9Atoz9ZF3NVJSLNeuSSs1N5pav27vCZdHv+RyxJOK1yp7FZ9TF+EXtseGc8
         NKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760617155; x=1761221955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1lRzBg6Y0DrujbaeCJgr3EEbAFrys3lR1v5Iou63/c=;
        b=dwpK8NhrQgVU2+oMy/aws6joS3C6DjRqvujEZet+SbGjLTf09ACe0JeAu8gNR2JY/W
         4f/kHxKvMyBI/rs02K+hHdGtS28/yuOH1vWRW76mQxa0+4gO3TCDzjqUAXoKUtK78NB8
         Z/DkGtNJK0vXfUh/rfFWI5vOwvveRJEa+d4E7Sia9mxSFZCgXk6pm3Y/SZ7MzEADqlnR
         v1+UjJalU9YLD/TsFt7mdW9A8GRO5XsnnwGU9xpU3ClAHoWwrjgcwKCtUiymlzMHJmnT
         ozM/LNMeybsLMouZnLzBVqFX/wLZv1RIKpGhXanWC7MqHFVOLnVMr2aiqZD/BkHFrIVP
         HFFA==
X-Forwarded-Encrypted: i=1; AJvYcCXq7nz0TqxxlsRTlcEQib0EB0JVDhosE93ZPv9XHEr7GM4SBGwCyRm+CS6/r603jASEQjrTfp+ZqE86Yj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/BDGb6SHgIM5kVxkWI+az/TJJd6xMSs3OqzpseFQ2nKbNkQw
	8CXDCInfomf8zY2rhE6rK7g5ckAVLd4fNPYo6lJSfSOCDlawpnzluegP
X-Gm-Gg: ASbGncvBiXR99Ojv/Id+ez9LrxV8u0w3gYJkcF2NyUMitLDL5ilgo09a40jd0M7KJnv
	C7HgP7Lj3P4lCD3mVxgm04ummcE2q0NSS+urrr3bKp2q2jTwmElAZvmqL3qFSkqcYIXI5xvg+ff
	2qxRPQC4WFmnxan8nxwQkRBgyhkvl4G9XWRmGSN8vyDlJxBGSDiSD8beG1TvjZgQ+JqidFaw/1A
	j5ZZQ5M2e2McUbTSmroBANpJy7nXK+OpedwsErE+h7qh+C/3WbnMmQCQswKb0J0I7yv4Sub7cvu
	rMvlUvrt8c/3vlOEmRERG957Eoh7ocaFspeRWeOjljLfzkhZp9BK83hsa8/81hM72s9oq1MIme2
	wZzcpPFtIcDRE6YJcIuGmSW3kVAkoyCBhr2z25i8QcJxcXfuC+WzYxW1ARZmWOb5XwmqxDD1dN4
	ryqN0CJWLxdXH6sZrrCgcXPfHLQiSNACg+MlU=
X-Google-Smtp-Source: AGHT+IE1N+/r0ZCrtxFyqBMS0KrH997fqnbg6jqIzxCgghAv0m+zk6mpZ6vW5N5cOzmVRywi6bH1Cw==
X-Received: by 2002:a05:600c:c116:b0:46e:3709:d88a with SMTP id 5b1f17b1804b1-46fa9b17e16mr187399425e9.33.1760617155130;
        Thu, 16 Oct 2025 05:19:15 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582abcsm34383986f8f.17.2025.10.16.05.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 05:19:14 -0700 (PDT)
Message-ID: <ce8cc332-54ec-4e12-aa7c-a6d5e2b4fa9d@gmail.com>
Date: Thu, 16 Oct 2025 14:19:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] HID: asus: Fix ASUS ROG Laptop's Keyboard
 backlight handling
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20251013201535.6737-1-lkml@antheas.dev>
 <160c3adf-9333-4486-ba4c-d3359ea73337@gmail.com>
 <CAGwozwGzOQ-LCk6B202-CuKq=gepn6Mt4LitJJZ7dfMLaDVs7Q@mail.gmail.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <CAGwozwGzOQ-LCk6B202-CuKq=gepn6Mt4LitJJZ7dfMLaDVs7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/16/25 14:14, Antheas Kapenekakis wrote:
> On Thu, 16 Oct 2025 at 13:57, Denis Benato <benato.denis96@gmail.com> wrote:
>>
>> On 10/13/25 22:15, Antheas Kapenekakis wrote:
>>> This is a two part series which does the following:
>>>   - Clean-up init sequence
>>>   - Unify backlight handling to happen under asus-wmi so that all Aura
>>>     devices have synced brightness controls and the backlight button works
>>>     properly when it is on a USB laptop keyboard instead of one w/ WMI.
>>>
>>> For more context, see cover letter of V1. Since V5, I removed some patches
>>> to make this easier to merge.
>>>
>>> All comments with these patches had been addressed since V4.
>> I have loaded this patchset for users of asus-linux project to try out.
>>
>> One of them opened a bug report about a kernel bug that happens
>> consistently when closing the lid of his laptop [1].
>>
>> He also sent another piece of kernel log, but didn't specify anything more
>> about this [2].
>>
>> [1] https://pastebin.com/akZx1w10
>> [2] https://pastebin.com/sKdczPgf
> Can you provide a link to the bug report? [2] seems unrelated.
The log in [2] was posted without additional context in the same
discord message as [1].

I think I will tell the user to open a proper bug report because
I do agree on the fact that it's looking unrelated.
> As for [1], it looks like a trace that stems from a sysfs write to
> brightness stemming from userspace that follows the same chain it
> would on a stock kernel and times out. Is it present on a stock
> kernel?
I have asked more details to the user. The user is not online ATM
so I will get to you with more details when I can.
> Ilpo should know more about this, could the spinlock be interfering?
> My testing on devices that have WMI led controls is a bit limited
> unfortunately. However, most of our asus users have been happy with
> this series for around half a year now.
Unless they have looked to kernel logs they won't be able to tell
since apparently there are no visible consequences.
> Antheas
>
>>> ---
>>> V5: https://lore.kernel.org/all/20250325184601.10990-1-lkml@antheas.dev/
>>> V4: https://lore.kernel.org/lkml/20250324210151.6042-1-lkml@antheas.dev/
>>> V3: https://lore.kernel.org/lkml/20250322102804.418000-1-lkml@antheas.dev/
>>> V2: https://lore.kernel.org/all/20250320220924.5023-1-lkml@antheas.dev/
>>> V1: https://lore.kernel.org/all/20250319191320.10092-1-lkml@antheas.dev/
>>>
>>> Changes since V5:
>>>   - It's been a long time
>>>   - Remove addition of RGB as that had some comments I need to work on
>>>   - Remove folio patch (already merged)
>>>   - Remove legacy fix patch 11 from V4. There is a small chance that
>>>     without this patch, some old NKEY keyboards might not respond to
>>>     RGB commands according to Luke, but the kernel driver does not do
>>>     RGB currently. The 0x5d init is done by Armoury crate software in
>>>     Windows. If an issue is found, we can re-add it or just remove patches
>>>     1/2 before merging. However, init could use the cleanup.
>>>
>>> Changes since V4:
>>>   - Fix KConfig (reported by kernel robot)
>>>   - Fix Ilpo's nits, if I missed anything lmk
>>>
>>> Changes since V3:
>>>   - Add initializer for 0x5d for old NKEY keyboards until it is verified
>>>     that it is not needed for their media keys to function.
>>>   - Cover init in asus-wmi with spinlock as per Hans
>>>   - If asus-wmi registers WMI handler with brightness, init the brightness
>>>     in USB Asus keyboards, per Hans.
>>>   - Change hid handler name to asus-UNIQ:rgb:peripheral to match led class
>>>   - Fix oops when unregistering asus-wmi by moving unregister outside of
>>>     the spin lock (but after the asus reference is set to null)
>>>
>>> Changes since V2:
>>>   - Check lazy init succeds in asus-wmi before setting register variable
>>>   - make explicit check in asus_hid_register_listener for listener existing
>>>     to avoid re-init
>>>   - rename asus_brt to asus_hid in most places and harmonize everything
>>>   - switch to a spinlock instead of a mutex to avoid kernel ooops
>>>   - fixup hid device quirks to avoid multiple RGB devices while still exposing
>>>     all input vendor devices. This includes moving rgb init to probe
>>>     instead of the input_configured callbacks.
>>>   - Remove fan key (during retest it appears to be 0xae that is already
>>>     supported by hid-asus)
>>>   - Never unregister asus::kbd_backlight while asus-wmi is active, as that
>>>   - removes fds from userspace and breaks backlight functionality. All
>>>   - current mainline drivers do not support backlight hotplugging, so most
>>>     userspace software (e.g., KDE, UPower) is built with that assumption.
>>>     For the Ally, since it disconnects its controller during sleep, this
>>>     caused the backlight slider to not work in KDE.
>>>
>>> Changes since V1:
>>>   - Add basic RGB support on hid-asus, (Z13/Ally) tested in KDE/Z13
>>>   - Fix ifdef else having an invalid signature (reported by kernel robot)
>>>   - Restore input arguments to init and keyboard function so they can
>>>     be re-used for RGB controls.
>>>   - Remove Z13 delay (it did not work to fix the touchpad) and replace it
>>>     with a HID_GROUP_GENERIC quirk to allow hid-multitouch to load. Squash
>>>     keyboard rename into it.
>>>   - Unregister brightness listener before removing work queue to avoid
>>>     a race condition causing corruption
>>>   - Remove spurious mutex unlock in asus_brt_event
>>>   - Place mutex lock in kbd_led_set after LED_UNREGISTERING check to avoid
>>>     relocking the mutex and causing a deadlock when unregistering leds
>>>   - Add extra check during unregistering to avoid calling unregister when
>>>     no led device is registered.
>>>   - Temporarily HID_QUIRK_INPUT_PER_APP from the ROG endpoint as it causes
>>>     the driver to create 4 RGB handlers per device. I also suspect some
>>>     extra events sneak through (KDE had the @@@@@@).
>>>
>>> Antheas Kapenekakis (7):
>>>   HID: asus: refactor init sequence per spec
>>>   HID: asus: prevent binding to all HID devices on ROG
>>>   platform/x86: asus-wmi: Add support for multiple kbd RGB handlers
>>>   HID: asus: listen to the asus-wmi brightness device instead of
>>>     creating one
>>>   platform/x86: asus-wmi: remove unused keyboard backlight quirk
>>>   platform/x86: asus-wmi: add keyboard brightness event handler
>>>   HID: asus: add support for the asus-wmi brightness handler
>>>
>>>  drivers/hid/hid-asus.c                     | 235 +++++++++++----------
>>>  drivers/platform/x86/asus-wmi.c            | 157 ++++++++++++--
>>>  include/linux/platform_data/x86/asus-wmi.h |  69 +++---
>>>  3 files changed, 291 insertions(+), 170 deletions(-)
>>>
>>>
>>> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787

