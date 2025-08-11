Return-Path: <linux-kernel+bounces-762248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA606B203F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24A0188B19B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFD515990C;
	Mon, 11 Aug 2025 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEvpHrtt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B02248BE;
	Mon, 11 Aug 2025 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905309; cv=none; b=VrPlNl7m41fqw9K3SZy3/FCI1xNZ2i9kN1EnkWnQFwplsLrLcbIL1OcY3pPQfltSB04/0QEzcQvneQGNX0TAO8xMuzaie/xXNoW83ZuCV+K89k4DZIJxue+ZVesNcR0XpGpKj1hA0TomDBW/ed7TIpO3Zn72KjsdvjSBt7uhlEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905309; c=relaxed/simple;
	bh=y1AgwAWGVPsJLeXk56B7iUGUW7PB51HCZHLDJZWCzjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkKpX18p1ASmTEuhNut7nz13WN9wzMiJUqX4N5/rcnOFdF7f9zI9bwLhZtZ+lxCV8PxuX4HD/Zu0EanprfGeSRn+xIK3zd91NyE2TfdzlEJZ58i9RwIxYMLfJHL7PJmMFnnteyjrwnGzUM2wjI7/YROxj4JWucHj2tI6CU9DmOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEvpHrtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C7CC4CEED;
	Mon, 11 Aug 2025 09:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754905309;
	bh=y1AgwAWGVPsJLeXk56B7iUGUW7PB51HCZHLDJZWCzjo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dEvpHrttiS6IC7kvPMj4ctyETPuISfr9bRXzkrynEohG/0tzDEpoWmLz5Qm9TwcRj
	 NC7pQhkh/CGYECr96QA8R8/KF8lyXz7l0d8C7y6npAZ71uLktSLQriWjqc/58KOMeQ
	 HtwPiZNAqDNV/HAErs1xBCw6nyMprbB20WyUjIGodt6UYByftB6ajm5/Fo8yK5se5B
	 MOImLbLWmV6v1fZs5SqkIACTpzbj94cJ7EISJzrlFW49FmOyiqwbj3WXfGcdWXwlBT
	 lt0XEDiyGqR7b+pnzA+nGc8VPuAQGbJcSsmNvxh8t1j+JNlAdfiX8pWlS/ut8LcM+u
	 bVzr1mWRzPLag==
Message-ID: <bd6a10ba-d83b-4bb2-8e69-7d985eeb5162@kernel.org>
Date: Mon, 11 Aug 2025 11:41:46 +0200
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

Hi Dmitry,

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
> ---
> Changes in v2:
> - Reworked on top of the current linux-next
> - Link to v1: https://lore.kernel.org/r/20230512001815.591817-1-dmitry.torokhov@gmail.com

Thanks this is an interesting series. I don't know why I missed / dropped
the ball on v1.

It will be a while before I can get around to this due to travel, but
I'll take a look and either provide a Tested-by or fixup any issues
I encounter and then post a fixed v3 myself.

Regards,

Hans







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


