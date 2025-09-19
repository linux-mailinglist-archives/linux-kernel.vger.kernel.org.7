Return-Path: <linux-kernel+bounces-825159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BB1B8B232
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDAC5A6113
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C556D31355D;
	Fri, 19 Sep 2025 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gufAo4sB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120182BE7AD;
	Fri, 19 Sep 2025 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311637; cv=none; b=GF+ttscdUbYa9NNZq66PGH8tb7YYRtzC+jrs+7rXrUFAlnkGvEYxp1OTANSmQAKHR5g0gVcsJhDJuPdeq1SAhfz8hG6s7ebWZXNQwvOsh0F3C5l/X7SY+DwoU7xQZzwA0aKtl3+F0BVrhTNPW+lbKGH8VgNX/N8BcqihDSoFChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311637; c=relaxed/simple;
	bh=niMH7u1uPeLGPA53se0P99RL7MqLZq3V8qqVKowZ7ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSFhG6Op9yFyNAkaxzzzjdgotu/3+lhbzmL+7J0vNPkoQAIwIt3C3dYCbB4cUdchGrr4StJeFILOqemNHesymznilC4NSzkOXc8x3eKzJfeet2ALQ1flp0B2Cq9ZGG6jsQvqTPUoqNqv8BicPk0k5RFr8188BrgjFxlDx8d6BfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gufAo4sB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FBCC4CEF0;
	Fri, 19 Sep 2025 19:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758311636;
	bh=niMH7u1uPeLGPA53se0P99RL7MqLZq3V8qqVKowZ7ec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gufAo4sBAhU2wF8+WAM67BzhJnDkH04xpuPVMYCJG0MBNGf8OvYL9tLXjV8TdNb6+
	 YGsYaZncGo9imuK0XGuUC9gFxfErhM22JaavZFcqo92309EsOKiU8pGctv2DYOZuGu
	 Qi7AB3vqq/YyE0qPnQZH5O2pN4h9+IC70IHeZSdG3CPfyl02ihxdd5TFMZJ3Vj+8uR
	 jDDSwc7lISGYHwVSZkaKbVD5qos1asksw92g3JDow0/OrflAfz2OfIDCuVi7P7tSHl
	 c/5+4j8mluWcCunN1+0KaXQGDTynW9rh/+nUNgs5R1KuMpLtSwR/t9cKdaV+GrDkJA
	 cbLgIH4mUgsQA==
Message-ID: <bc463249-a159-466d-8804-399805b8fa3f@kernel.org>
Date: Fri, 19 Sep 2025 21:53:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] x86-android-tablets: convert to use GPIO
 references
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Arnd Bergmann <arnd@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250810-x86-andoroid-tablet-v2-0-9c7a1b3c32b2@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20250810-x86-andoroid-tablet-v2-0-9c7a1b3c32b2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11-Aug-25 4:22 AM, Dmitry Torokhov wrote:
> This series came about because now software nodes can be used to
> describe GPIOs (via PROPERTY_ENTRY_GPIO() macros) and I would like to
> eventually get rid of gpio_keys_platform_data structure.
> 
> So while I was doing the conversions from GPIO_LOOKUP() tables for
> gpio_keys devices I decided to convert the rest of them as well. Maybe
> some time in the future we can drop support for GPIO_LOOKUP() and rely
> on device properties exclusively.
> 
> This is completely untested.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thank you for this series. While reviewing this I've found
a couple of issues. I've fixed these in my own tree and
I'll send out a v3 with this fixed + some extra patches.

The issues which I've found and fixed are:

- lenovo_yoga_tab2_830_1050_init_codec() is missing a pinctrl_put()
  in error-exit paths after the pinctrl_get_select() succeeds

- Adding a swnode to the yt3 spi device changes the name of the SPI/codec
  device and the sound/soc/intel/boards/bytcr_wm5102.c machine driver looks
  up the code by name, update the machine driver to use the new name.

- In the "convert Yoga Tab2 fast charger to GPIO references" references
  the fwnode is added to the wrong device. The node should be added to
  the "serial0-0" device but that gets instantiated by
  drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
  I've made yoga-tab2-pro-1380-fastcharger.c propagate the fwnode set on
  the platform-device to the serdev it creates to fix this.

- Fix the commit message of "platform/x86: x86-android-tablets: convert
  gpio_keys devices to GPIO references" which contained a stray reference
  to wm5102.

I've also added some follow-up patches with some cleanups, see the v3
cover-letter for details.

I'll also add a rebased version of my patches to add support for
the Acer A1-840 tablet to v3, now using software-nodes for the GPIOs.

Regards,

Hans






> ---
> Changes in v2:
> - Reworked on top of the current linux-next
> - Link to v1: https://lore.kernel.org/r/20230512001815.591817-1-dmitry.torokhov@gmail.com
> 
> ---
> Dmitry Torokhov (11):
>       platform/x86: x86-android-tablets: convert Goodix devices to GPIO references
>       platform/x86: x86-android-tablets: convert Wacom devices to GPIO references
>       platform/x86: x86-android-tablets: convert HiDeep devices to GPIO references
>       platform/x86: x86-android-tablets: convert Novatek devices to GPIO references
>       platform/x86: x86-android-tablets: convert EDT devices to GPIO references
>       platform/x86: x86-android-tablets: convert int3496 devices to GPIO references
>       platform/x86: x86-android-tablets: convert wm1502 devices to GPIO references
>       platform/x86: x86-android-tablets: convert HID-I2C devices to GPIO references
>       platform/x86: x86-android-tablets: convert Yoga Tab2 fast charger to GPIO references
>       platform/x86: x86-android-tablets: remove support for GPIO lookup tables
>       platform/x86: x86-android-tablets: convert gpio_keys devices to GPIO references
> 
>  drivers/platform/x86/x86-android-tablets/asus.c    | 102 ++++----
>  drivers/platform/x86/x86-android-tablets/core.c    | 109 +++++---
>  drivers/platform/x86/x86-android-tablets/lenovo.c  | 279 +++++++++++---------
>  drivers/platform/x86/x86-android-tablets/other.c   | 289 ++++++++++-----------
>  .../x86/x86-android-tablets/shared-psy-info.c      |  20 --
>  .../x86/x86-android-tablets/shared-psy-info.h      |   5 -
>  .../x86/x86-android-tablets/x86-android-tablets.h  |  23 +-
>  7 files changed, 436 insertions(+), 391 deletions(-)
> ---
> base-commit: b1549501188cc9eba732c25b033df7a53ccc341f
> change-id: 20250810-x86-andoroid-tablet-df93908b426b
> 
> Best regards,
> --  
> Dmitry
> 


