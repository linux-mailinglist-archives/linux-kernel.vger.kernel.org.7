Return-Path: <linux-kernel+bounces-856441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9ACBE42C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD2D2508D49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607633469F5;
	Thu, 16 Oct 2025 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLlhVTgx"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632583451CC
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627798; cv=none; b=oBJyJ69mOhVdhbJfyxxtxGhahICYJDSvT0lSZQkUKD21ldl7Y9fYJKx89NPyRfOxnI7DpWlKsR4BkTBd9T6p1q478XQD78dy68iSPBRGVVGG5+piqxjF8f66UMdQJoiInhuaQXrc60An3enQS7MISmXBiWVwQMMscHHlOU6Foxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627798; c=relaxed/simple;
	bh=oa7K0JZTewj+HSuTTd/Uvc+SWhVmeZPCcOMWUVCfbyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9dn8KptDwwRAtNUyXLDU42yNoRNe9T9Cea7GBdbhd7T1a3B05KNTj7RPNQNLQkth++EPHUDhHY8gZ7ZgMrQqLv1DNM1uCba4JPhKDT9XLGcyoPu4tHwSafkkIq3MsluBo2UUgwUKhBKq+XNTIVo0Oy9jvJ9sDapG+0q9+uVsfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLlhVTgx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-427015003eeso499817f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760627794; x=1761232594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZNj5a9vYHSqnXPzE3bW6USYGveDnBdGISqnkFGhWQt4=;
        b=kLlhVTgxFOkajDAdntMEh84Z1xkVoctECcxbl2La9rRn2MFmin4isjoFRbIrzL+SYk
         wRXOqf1GIt1T56FMepwLgr8VKkyNSPbX8lPdFpW5UVRzCQTTPpUqDh73k6gwb7U8ffuw
         6o3i1cVxwVDGR3FFPT6dSa4Pv0d4uPF1bIxuERSQt3XAu90hL8V+1cLQwyqxPK7/J6QO
         G5OIU0Svkt1DBOlPlQhfLiJ/J+XA9mDc2EOp2elBe4VwQrVdrTu2ikGDdr3GmPcHpcNa
         zDqZKkCUNflpUaeDskc4f2TwqXK+Vj/f68XxxpljvIVUfKDNX91rxSZpfDSmswFuBcvo
         T41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627794; x=1761232594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNj5a9vYHSqnXPzE3bW6USYGveDnBdGISqnkFGhWQt4=;
        b=XFxdDRY5a1DWLk05tXJVCojYlz1g5YfyumiSrRgNOSWolVwh42Lt4uLvcEefhcr0K9
         Ys3Z0R7/Av8Tux8p4c/Aq4ZOwrDA8y9Vc49GCUfmYR0w0rrviDjn95Z/iQ6FeoEMhOmm
         PQVLGKouo66Xbdddm1ZyrQOS4p9LJ/b93GJQOf/bclMSD5q9EHlkNXFTLOm2XT78SF9V
         6kjIefFd5rMfjEQszA9Dwl2t+A8MebqwcHV5KF7WZjI2m8qD48P05MTVskuvrCW2oM2p
         fzFbjfE85edSXFY98xqkUfeGYoBNGlJHL/LgeXQ2G3X5HcCvsAMpG0t3UUGIVFiKsdsQ
         AnTA==
X-Forwarded-Encrypted: i=1; AJvYcCVG1XMtZY+LhLAEh5bpcYmJycQyDUw4SL/OOfrw25kRGUwOVOuemEjB1OQ/aDmvuInQSUqnd/jLWl1RJ6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA8L4LwfKtmg4rXcPAcY0Sv2Qu9pcN5lbE2wBW9wgM2BzdX8xe
	+hMxLrr/FY7vn2+1UXv9jvWgmXFbj2I+WR7z82kjQrOPOxoBlXexaOo/
X-Gm-Gg: ASbGncuyN1t36+hHeweqO7KDK9dtk6BFQuoZqSdTEaJJkNvecijCGrHMPJLeMgGj/hs
	Iu3ZBznD85WGD6EMZhzbFcoHhUw48b+zNO8OEBUICEX/relo66LUws1jMxXubXEW6l4d9XoajEI
	6RXhUAPyylIrlEMCi2VQAGPUSyJ8aE1G27t3tYtKt6MNPyXxHLgYys6OzaVYWsJvzMyisSEnGFS
	uZR9dEyUd8vN5/r4rf443jsO4JxvP4Gu3YPx3uEbyL1MDNtI9OyTLq7V9uLjAaJDCoJ/utnXqIo
	G+DhaTCfYIc7SfZZoWt4jc6yTGzoGaE0pPzfvYuqJPIUAwk1biC8qBLHwAsxI2LxP8QV26ugUql
	SRZPmc3tdlGsC9ND5sHuIcCj007mRUtzG8zHp9n8V5laaMmoSUX/zeH/vLjSnCfufo/VrdRVgOB
	GWJzumdReVcuP29jRDfCuDMIlqnvwMv53kjRU=
X-Google-Smtp-Source: AGHT+IGtwe+2MYniCJX8mJ89r3l4ed7+hu/JJ/nkz0HhOJVzWSHynZlE5+GXyj4xNSbiMDajzHmpgA==
X-Received: by 2002:a05:6000:4381:b0:426:f10e:718e with SMTP id ffacd0b85a97d-42704db9ec2mr384173f8f.46.1760627794261;
        Thu, 16 Oct 2025 08:16:34 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42704a929acsm938510f8f.18.2025.10.16.08.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 08:16:33 -0700 (PDT)
Message-ID: <fbf2fd7a-de03-448f-a6e4-890ecf8a4b3c@gmail.com>
Date: Thu, 16 Oct 2025 17:16:33 +0200
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
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 fooqux@proton.me
References: <20251013201535.6737-1-lkml@antheas.dev>
 <160c3adf-9333-4486-ba4c-d3359ea73337@gmail.com>
 <CAGwozwGzOQ-LCk6B202-CuKq=gepn6Mt4LitJJZ7dfMLaDVs7Q@mail.gmail.com>
 <ce8cc332-54ec-4e12-aa7c-a6d5e2b4fa9d@gmail.com>
 <CAGwozwHrWxxE_vyswe39W=ui8N6ej4ZPFvuKVueyw4xLL8C4ZQ@mail.gmail.com>
 <13c53469-58fd-462a-a462-626975d6055f@gmail.com>
 <CAGwozwHmTUb3Bcbn9Zc44sqe7DHtnnk0chvhjN7jJNrmePr8fw@mail.gmail.com>
 <f43f4f0e-9b98-4629-872e-b623bfc9b6b1@gmail.com>
 <CAGwozwECtoh-7uK9RuB+WSbognjwHiBx7iXi6OJwyasoAfHemw@mail.gmail.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <CAGwozwECtoh-7uK9RuB+WSbognjwHiBx7iXi6OJwyasoAfHemw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/16/25 16:44, Antheas Kapenekakis wrote:
> On Thu, 16 Oct 2025 at 16:32, Denis Benato <benato.denis96@gmail.com> wrote:
>>
>> On 10/16/25 14:51, Antheas Kapenekakis wrote:
>>> On Thu, 16 Oct 2025 at 14:46, Denis Benato <benato.denis96@gmail.com> wrote:
>>>> On 10/16/25 14:28, Antheas Kapenekakis wrote:
>>>>> On Thu, 16 Oct 2025 at 14:19, Denis Benato <benato.denis96@gmail.com> wrote:
>>>>>> On 10/16/25 14:14, Antheas Kapenekakis wrote:
>>>>>>> On Thu, 16 Oct 2025 at 13:57, Denis Benato <benato.denis96@gmail.com> wrote:
>>>>>>>> On 10/13/25 22:15, Antheas Kapenekakis wrote:
>>>>>>>>> This is a two part series which does the following:
>>>>>>>>>   - Clean-up init sequence
>>>>>>>>>   - Unify backlight handling to happen under asus-wmi so that all Aura
>>>>>>>>>     devices have synced brightness controls and the backlight button works
>>>>>>>>>     properly when it is on a USB laptop keyboard instead of one w/ WMI.
>>>>>>>>>
>>>>>>>>> For more context, see cover letter of V1. Since V5, I removed some patches
>>>>>>>>> to make this easier to merge.
>>>>>>>>>
>>>>>>>>> All comments with these patches had been addressed since V4.
>>>>>>>> I have loaded this patchset for users of asus-linux project to try out.
>>>>>>>>
>>>>>>>> One of them opened a bug report about a kernel bug that happens
>>>>>>>> consistently when closing the lid of his laptop [1].
>>>>>>>>
>>>>>>>> He also sent another piece of kernel log, but didn't specify anything more
>>>>>>>> about this [2].
>>>>>>>>
>>>>>>>> [1] https://pastebin.com/akZx1w10
>>>>>>>> [2] https://pastebin.com/sKdczPgf
>>>>>>> Can you provide a link to the bug report? [2] seems unrelated.
>>>>>> The log in [2] was posted without additional context in the same
>>>>>> discord message as [1].
>>>>> Link me the kernel sources. Is it linux-g14 in the AUR?
>>>> Someone has replicated it on the AUR but it's just an out-of-sync replica.
>>>>
>>>> The true source code is here:
>>>> https://gitlab.com/asus-linux/linux-g14 branch 6.17
>>> Ok, lets wait for the user to replicate on a stock kernel
>>>
>> User said "yes I just confirmed it: it is only on the asus kernel, mainline doesn't have this issue".
>>
>> With "asus kernel" he is referring to -g14.
>>
>> I added him in CC.
> If possible, try the bazzite kernel, its linux-bazzite-bin. It has
> this series + another older armoury series. If it still happens with
> that, we can cut a release with just this series to begin isolating
> this issue

If deemed necessary I will provide the user a kernel matching exactly
what doesn't give him the error and add to it this patch series.

However the problem does appear to be tied to the use of spinlock,
so perhaps it's better to try a version with some other type of locking.

> Antheas
>
>>>>>> I think I will tell the user to open a proper bug report because
>>>>>> I do agree on the fact that it's looking unrelated.
>>>>>>> As for [1], it looks like a trace that stems from a sysfs write to
>>>>>>> brightness stemming from userspace that follows the same chain it
>>>>>>> would on a stock kernel and times out. Is it present on a stock
>>>>>>> kernel?
>>>>>> I have asked more details to the user. The user is not online ATM
>>>>>> so I will get to you with more details when I can.
>>>>>>> Ilpo should know more about this, could the spinlock be interfering?
>>>>>>> My testing on devices that have WMI led controls is a bit limited
>>>>>>> unfortunately. However, most of our asus users have been happy with
>>>>>>> this series for around half a year now.
>>>>>> Unless they have looked to kernel logs they won't be able to tell
>>>>>> since apparently there are no visible consequences.
>>>>>>> Antheas
>>>>>>>
>>>>>>>>> ---
>>>>>>>>> V5: https://lore.kernel.org/all/20250325184601.10990-1-lkml@antheas.dev/
>>>>>>>>> V4: https://lore.kernel.org/lkml/20250324210151.6042-1-lkml@antheas.dev/
>>>>>>>>> V3: https://lore.kernel.org/lkml/20250322102804.418000-1-lkml@antheas.dev/
>>>>>>>>> V2: https://lore.kernel.org/all/20250320220924.5023-1-lkml@antheas.dev/
>>>>>>>>> V1: https://lore.kernel.org/all/20250319191320.10092-1-lkml@antheas.dev/
>>>>>>>>>
>>>>>>>>> Changes since V5:
>>>>>>>>>   - It's been a long time
>>>>>>>>>   - Remove addition of RGB as that had some comments I need to work on
>>>>>>>>>   - Remove folio patch (already merged)
>>>>>>>>>   - Remove legacy fix patch 11 from V4. There is a small chance that
>>>>>>>>>     without this patch, some old NKEY keyboards might not respond to
>>>>>>>>>     RGB commands according to Luke, but the kernel driver does not do
>>>>>>>>>     RGB currently. The 0x5d init is done by Armoury crate software in
>>>>>>>>>     Windows. If an issue is found, we can re-add it or just remove patches
>>>>>>>>>     1/2 before merging. However, init could use the cleanup.
>>>>>>>>>
>>>>>>>>> Changes since V4:
>>>>>>>>>   - Fix KConfig (reported by kernel robot)
>>>>>>>>>   - Fix Ilpo's nits, if I missed anything lmk
>>>>>>>>>
>>>>>>>>> Changes since V3:
>>>>>>>>>   - Add initializer for 0x5d for old NKEY keyboards until it is verified
>>>>>>>>>     that it is not needed for their media keys to function.
>>>>>>>>>   - Cover init in asus-wmi with spinlock as per Hans
>>>>>>>>>   - If asus-wmi registers WMI handler with brightness, init the brightness
>>>>>>>>>     in USB Asus keyboards, per Hans.
>>>>>>>>>   - Change hid handler name to asus-UNIQ:rgb:peripheral to match led class
>>>>>>>>>   - Fix oops when unregistering asus-wmi by moving unregister outside of
>>>>>>>>>     the spin lock (but after the asus reference is set to null)
>>>>>>>>>
>>>>>>>>> Changes since V2:
>>>>>>>>>   - Check lazy init succeds in asus-wmi before setting register variable
>>>>>>>>>   - make explicit check in asus_hid_register_listener for listener existing
>>>>>>>>>     to avoid re-init
>>>>>>>>>   - rename asus_brt to asus_hid in most places and harmonize everything
>>>>>>>>>   - switch to a spinlock instead of a mutex to avoid kernel ooops
>>>>>>>>>   - fixup hid device quirks to avoid multiple RGB devices while still exposing
>>>>>>>>>     all input vendor devices. This includes moving rgb init to probe
>>>>>>>>>     instead of the input_configured callbacks.
>>>>>>>>>   - Remove fan key (during retest it appears to be 0xae that is already
>>>>>>>>>     supported by hid-asus)
>>>>>>>>>   - Never unregister asus::kbd_backlight while asus-wmi is active, as that
>>>>>>>>>   - removes fds from userspace and breaks backlight functionality. All
>>>>>>>>>   - current mainline drivers do not support backlight hotplugging, so most
>>>>>>>>>     userspace software (e.g., KDE, UPower) is built with that assumption.
>>>>>>>>>     For the Ally, since it disconnects its controller during sleep, this
>>>>>>>>>     caused the backlight slider to not work in KDE.
>>>>>>>>>
>>>>>>>>> Changes since V1:
>>>>>>>>>   - Add basic RGB support on hid-asus, (Z13/Ally) tested in KDE/Z13
>>>>>>>>>   - Fix ifdef else having an invalid signature (reported by kernel robot)
>>>>>>>>>   - Restore input arguments to init and keyboard function so they can
>>>>>>>>>     be re-used for RGB controls.
>>>>>>>>>   - Remove Z13 delay (it did not work to fix the touchpad) and replace it
>>>>>>>>>     with a HID_GROUP_GENERIC quirk to allow hid-multitouch to load. Squash
>>>>>>>>>     keyboard rename into it.
>>>>>>>>>   - Unregister brightness listener before removing work queue to avoid
>>>>>>>>>     a race condition causing corruption
>>>>>>>>>   - Remove spurious mutex unlock in asus_brt_event
>>>>>>>>>   - Place mutex lock in kbd_led_set after LED_UNREGISTERING check to avoid
>>>>>>>>>     relocking the mutex and causing a deadlock when unregistering leds
>>>>>>>>>   - Add extra check during unregistering to avoid calling unregister when
>>>>>>>>>     no led device is registered.
>>>>>>>>>   - Temporarily HID_QUIRK_INPUT_PER_APP from the ROG endpoint as it causes
>>>>>>>>>     the driver to create 4 RGB handlers per device. I also suspect some
>>>>>>>>>     extra events sneak through (KDE had the @@@@@@).
>>>>>>>>>
>>>>>>>>> Antheas Kapenekakis (7):
>>>>>>>>>   HID: asus: refactor init sequence per spec
>>>>>>>>>   HID: asus: prevent binding to all HID devices on ROG
>>>>>>>>>   platform/x86: asus-wmi: Add support for multiple kbd RGB handlers
>>>>>>>>>   HID: asus: listen to the asus-wmi brightness device instead of
>>>>>>>>>     creating one
>>>>>>>>>   platform/x86: asus-wmi: remove unused keyboard backlight quirk
>>>>>>>>>   platform/x86: asus-wmi: add keyboard brightness event handler
>>>>>>>>>   HID: asus: add support for the asus-wmi brightness handler
>>>>>>>>>
>>>>>>>>>  drivers/hid/hid-asus.c                     | 235 +++++++++++----------
>>>>>>>>>  drivers/platform/x86/asus-wmi.c            | 157 ++++++++++++--
>>>>>>>>>  include/linux/platform_data/x86/asus-wmi.h |  69 +++---
>>>>>>>>>  3 files changed, 291 insertions(+), 170 deletions(-)
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787

