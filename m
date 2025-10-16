Return-Path: <linux-kernel+bounces-856138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B312CBE333B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35F5A357F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB87731D371;
	Thu, 16 Oct 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfcK2pKv"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492FE2D320B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615845; cv=none; b=WmSmsVBtp5TkiE075w5tgGsAo6vXV3x+w7ooWbhtK6rZFYYnpRBfCX2x56y2DxTWLX7mTO0O5WCpWBgoQJX4/0NFMXSX9uEJ7uPMWxiNffAIWz3OVnvhwGbRmJv2L6FitKzAI6PoF9lDjcUkGeoBWwLgKlmVRaRmy7nR1XzaDUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615845; c=relaxed/simple;
	bh=sRF5+eiyyvDy6P35qPDSbZ1Op+KomFN+cO3tpPaTpzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KObjYOqmaWcyCCPzAbpdRymZg4sXtMIe8RL17+uDtbHFH0N9PNODn6z7MllfnHn1CIrw//XlUS3UHtrJwJsyuFKRAZMn3ZCb22DKkvPClr7DbkleJ/xVJelXgg87rqvaz4NDDHqYIS+hl+G5IzSBGQVQF0aDhsXLQhC71flRZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfcK2pKv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e504975dbso5229555e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760615840; x=1761220640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ArYuqC9d/+uAAMAhpyNsnKi2KHyS/I3ASJZL/VZkmq8=;
        b=dfcK2pKvABcBngobcpn9bxLPHj1BNp3/TEONd6n5S/U8Pc9aN2y6sEeLI0TmxwZxDn
         SekQ+9e7MuFKQ0aW5e/rhwiwoJ+IOt2lnH7tA1ytzBIWvTePmjqgvk2YKJ/OYbncewvm
         oMqOBOCIpUarE98Iin0xaYTPJPvsLcF2x64W+BitdIhBpocgOBNT8Zo9693wz9E5mNK9
         8nndjyyWuyyk+Amii3eCr9YWYlf9+Xc2WZ97DdiHfsPqd9MOZMKajPqWVH7kKc358FS1
         mAgvh01vAUPbA2R6Jm3iIRUZcwkM1iKVc99prQWDe9YmTkVazwoiu8DkWhj9/OVC+gZ+
         JnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615840; x=1761220640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArYuqC9d/+uAAMAhpyNsnKi2KHyS/I3ASJZL/VZkmq8=;
        b=sjY/OkVrG0iE/tpIylSqJp8UuShfzuaS6RSzEXs/r+qH71RAKydolM111giD7jr3On
         TDY9or/yWQtqmEY4p3Fxu2L4E9tlLbJIsY4k1ofTpGjX+0sRpvZxJn0PvnazAFlmgAXf
         3Z9iCVoulI9Vd6no6T/NXTC3LmcyAdFdY4/MZ43Mbh62L9VFtVei2M+QKZuC67CtpNNa
         2ZZlCrTXjtYVh5HjIRqvZ7RTk2UfJgEQOccZ0vZuAJDMbH5BFbLF5daEVd10FT7D7VNV
         pHzgPhSyMHkXPFtfYeCYbk/EmGp8JrGWXkj8bB9WmlX75oG1JVzVtYwSYs0m7czgU7eS
         /Jvg==
X-Gm-Message-State: AOJu0YzVOfNmvlQUUJla/S5tiAzFO7U73xwiLXH3nhwOBxHm8yEz5aM1
	J1BCt60QHXF4KiprmbPe+/qtY+kIEj6cZe2O6PTyG1hZ2M11tgFQOcWr
X-Gm-Gg: ASbGncsNN4c2yppbQWEakPc5Ptz2ea+QWYjK0ja0FbXKRnwLe/xYHKAXdmETqLm+kx4
	Z6M+QB1K+qr80hWnfzjtF0TMkx9E3CO0nkN+FfaoD1E6r48XZrikUpnWmVZsOi0UR3UQYjvtt1I
	7U4Jo63NmYaRboQ/O2yofGygYBroTm2L2O4tRahM9URBZEPNgWIJGCDbN/JmnMlTUqMdNMIFf68
	duXUt9tTGdaSqZzRx1E2YovIXUknq7537QTvg0Rp7cOhl2LmxePG5Aeu1iXBCBh64WNHpuXgCYB
	uynHDjq9IDhBSkq2icMaOchnxBOdnvZQOMx3GF5m3BJMdYAneueBiIXvVZyR2xoKyELoZP9WPwO
	4+eCfqKYP4Ww4VDVsIjdAonBXrdkFxO0J3FRRHn0+RkhY3BbTLrL+XoGGGmT6VQp3X8+2AFjJyp
	0S2sGJyPwZPkuNPl+KFIJgjOt5
X-Google-Smtp-Source: AGHT+IELWh2FOBUasPrU4o/JTA9HAOtjaMyk6lZtLqKGYpqZSBBmNutJ4eN0jpuLE9Huxd8ZS6tGJA==
X-Received: by 2002:a05:600c:c0d6:b0:471:c04:a352 with SMTP id 5b1f17b1804b1-4710c04a443mr17476155e9.4.1760615840293;
        Thu, 16 Oct 2025 04:57:20 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114444b06sm22459765e9.12.2025.10.16.04.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 04:57:19 -0700 (PDT)
Message-ID: <160c3adf-9333-4486-ba4c-d3359ea73337@gmail.com>
Date: Thu, 16 Oct 2025 13:57:19 +0200
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
I have loaded this patchset for users of asus-linux project to try out.

One of them opened a bug report about a kernel bug that happens
consistently when closing the lid of his laptop [1].

He also sent another piece of kernel log, but didn't specify anything more
about this [2].

[1] https://pastebin.com/akZx1w10
[2] https://pastebin.com/sKdczPgf

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

