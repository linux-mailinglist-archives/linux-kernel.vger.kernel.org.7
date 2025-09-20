Return-Path: <linux-kernel+bounces-825691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C220B8C886
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 14:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 708607B1484
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 12:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980361F9F7A;
	Sat, 20 Sep 2025 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE38RpO/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA3C1DED77;
	Sat, 20 Sep 2025 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758372808; cv=none; b=k0qAKIfvJSZUJ+ppXxP+H432R3hpkWp42vaWELw0a7b0Jn6bsqeNWnfySLxSizTF8u32BdsovcoVA5NcrKkIQzIO4VCpTl2AQNfNJFjYsJ4xr+EjUHFLfuCpxy0EJcjMzBMXQ3e6vXFnRrnNjbaazfOQQgtVzCSW/8w52CPLej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758372808; c=relaxed/simple;
	bh=AjolLnj9vYvyau+Qw1nPzhy9BvsSmW3m/2cqU9XAPao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jH9JKF5acRWGiXYK6Sx6yWxw8Pj6hPxqtGbgC2vEXWCq5VmNjMcIWUnRzu2iTUxj1eYC5nlg5Zcq9QzCRCf9EIE7XwMZJG+eGoVZ63/hmvKDVrv+THg7UapVNBiTvsOLEvJcL5OIby9G0pgYT9Ta+1B2bJGP9VoNyW3phNcz6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE38RpO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFC5C4CEEB;
	Sat, 20 Sep 2025 12:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758372806;
	bh=AjolLnj9vYvyau+Qw1nPzhy9BvsSmW3m/2cqU9XAPao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oE38RpO/I8pKgAHj5xiMF0FsfNYrHNNAMCuM78kngaJdDK2tz8S1en4V4gi4D366Y
	 DWt1779SayRUOHWDZPYqpYUlYwPGpezh+EF3ZxMNCG5xGofMRC7YjqGYf1MhEQ/mF0
	 JkqHtiPpAJZpcw7gkjHhb6zrrWCj9G0m9y7YvS+xuRpOagr0ZsCG1fhOCbO+zO/pJH
	 0RTUYOFlqrhC9MfevL6DIn31oqbYVT6FF0wpxiDQrTfU/PyVO0O8MHrolO/fQrN4lt
	 olCdR12EwPhWXQnmXqM3DLxKNjGYAg5oc8y5/+eD3f/QJs9O5sOlK6+rmG49gCru8v
	 TCAtF7WMXp78g==
Message-ID: <e6b39e68-d950-40fe-a807-37b5d9e9204e@kernel.org>
Date: Sat, 20 Sep 2025 14:53:23 +0200
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
 <bc463249-a159-466d-8804-399805b8fa3f@kernel.org>
 <ley47cmpwn5lhacf7ddfufeaqhe7rqemmkp2sjrhxitdv3l6cm@ktafyk6eeeft>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <ley47cmpwn5lhacf7ddfufeaqhe7rqemmkp2sjrhxitdv3l6cm@ktafyk6eeeft>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 19-Sep-25 11:21 PM, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Fri, Sep 19, 2025 at 09:53:53PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 11-Aug-25 4:22 AM, Dmitry Torokhov wrote:
>>> This series came about because now software nodes can be used to
>>> describe GPIOs (via PROPERTY_ENTRY_GPIO() macros) and I would like to
>>> eventually get rid of gpio_keys_platform_data structure.
>>>
>>> So while I was doing the conversions from GPIO_LOOKUP() tables for
>>> gpio_keys devices I decided to convert the rest of them as well. Maybe
>>> some time in the future we can drop support for GPIO_LOOKUP() and rely
>>> on device properties exclusively.
>>>
>>> This is completely untested.
>>>
>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> Thank you for this series. While reviewing this I've found
>> a couple of issues. I've fixed these in my own tree and
>> I'll send out a v3 with this fixed + some extra patches.
>>
>> The issues which I've found and fixed are:
>>
>> - lenovo_yoga_tab2_830_1050_init_codec() is missing a pinctrl_put()
>>   in error-exit paths after the pinctrl_get_select() succeeds
>>
>> - Adding a swnode to the yt3 spi device changes the name of the SPI/codec
>>   device and the sound/soc/intel/boards/bytcr_wm5102.c machine driver looks
>>   up the code by name, update the machine driver to use the new name.
>>
>> - In the "convert Yoga Tab2 fast charger to GPIO references" references
>>   the fwnode is added to the wrong device. The node should be added to
>>   the "serial0-0" device but that gets instantiated by
>>   drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
>>   I've made yoga-tab2-pro-1380-fastcharger.c propagate the fwnode set on
>>   the platform-device to the serdev it creates to fix this.
>>
>> - Fix the commit message of "platform/x86: x86-android-tablets: convert
>>   gpio_keys devices to GPIO references" which contained a stray reference
>>   to wm5102.
> 
> Thank you Hans for looking over the series and fixing up all the issues
> that I introduced.

You're welcome and thank you for the reviews on the new patches.

Regards,

Hans



