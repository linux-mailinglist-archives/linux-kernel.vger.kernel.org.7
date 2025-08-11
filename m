Return-Path: <linux-kernel+bounces-763334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E8CB2137A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583FF626D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE15B2D47F7;
	Mon, 11 Aug 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICIcPitU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8B21771B;
	Mon, 11 Aug 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934031; cv=none; b=oGpfrzxYs85d2GJkdOAr0XEedk1awuYNDvrO5W7MTF8NckWllGJesJHlv24o86v0IqMbjYGSXHb3NMjieCaIZN2vRBmjz2Vtr5mDFIofJW1t5YxuvaDQUkjMR2VnVbL9EiZP52OqQohypuq0lIbStTnQIUWbeHuQZT+HtCyqO4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934031; c=relaxed/simple;
	bh=DR4nzsj2RSJeo1Dqf7XMP3J098TXOv60AI7D/vJomI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMfOVe/7Os7UgBpP5BrF3h5h3mNkwdfMBQYv9kpJZwMAVBH6yZ48l1t6rhyYH+SYRXGIT2BaI05DABxqRChTMwYElqr1sPpnONHjOigyU9+L30Jyj2/A5hlJn/t1eMOn7cXzBee/VoGD20mQ8JQJ62D4Tua7tt6UeWTSv6DHC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICIcPitU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4B9C4CEED;
	Mon, 11 Aug 2025 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754934031;
	bh=DR4nzsj2RSJeo1Dqf7XMP3J098TXOv60AI7D/vJomI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ICIcPitUvvE+Smdr08VW/T0wbBwaCCrgWxjRnugeYNKEXuLNeR+JSbYkG4VsQ5DRe
	 7yIzBomnbXC3CvW+XcvnjkzDoJTYh0JkarCgDW5P9hTcl2WMyDkKWhz4l9bKVPUJ0a
	 cuDQl/tmHI1YqCGjcNI6funcs1bfaaU0McQ44XoA5y/OmuBFAYz/IIsZQ/KTBWuwYd
	 6nS1ft+xWXfENLaDtvzQ9o8B661nt71bebSGTqybfAb7HTcDYC/5Tbq1lmvvq8vHEy
	 ecLfCuiRrG2hsS2iuTkCTvWSKGLA58N9EWVw5jiKXStJLG3ZJuuj42zE0Jo/Ix9fxk
	 qiliFgEoTsuEg==
Message-ID: <c60ccef1-7213-4dd7-8c10-e8ef03675bd8@kernel.org>
Date: Mon, 11 Aug 2025 19:40:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: use software nodes for
 gpio-leds/keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Santosh Kumar Yadav <santoshkumar.yadav@barco.com>,
 Peter Korsgaard <peter.korsgaard@barco.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr>
 <aJnlnx2qF6P61jJN@smile.fi.intel.com>
 <7c2d08e3-d1e2-433e-b726-307246ab17e9@kernel.org>
 <aJoQE2CQv3nzaSqc@smile.fi.intel.com>
 <uakyig6sp2sfuwtt2aq7ds5dcbsjrgcijenunefqzc46inpees@xc6bfr4mjnan>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <uakyig6sp2sfuwtt2aq7ds5dcbsjrgcijenunefqzc46inpees@xc6bfr4mjnan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11-Aug-25 5:49 PM, Dmitry Torokhov wrote:
> On Mon, Aug 11, 2025 at 06:45:23PM +0300, Andy Shevchenko wrote:
>> On Mon, Aug 11, 2025 at 04:20:33PM +0200, Hans de Goede wrote:
>>> On 11-Aug-25 2:44 PM, Andy Shevchenko wrote:
>>>> On Sun, Aug 10, 2025 at 09:31:37PM -0700, Dmitry Torokhov wrote:
>>
>> ...
>>
>>>> Otherwise LGTM as here it looks like we establish platform device ourselves and
>>>> hence no need some additional magic Hans mentioned in the other series.
>>>
>>> Not entirely like with the x86-android-tablets patches this
>>> declares a software-node for the gpiochip:
>>>
>>> static const struct software_node gpiochip_node = {
>>> 	.name = DRIVER_NAME,
>>> };
>>>
>>> and registers that node, but nowhere does it actually
>>> get assigned to the gpiochip.
>>>
>>> This is going to need a line like this added to probe():
>>>
>>> 	p50->gc.fwnode = software_node_fwnode(&gpiochip_node);
>>>
>>> note the software_node_fwnode() call MUST be made after
>>> registering the software-nodes (group).
>>>
>>> Other then needing this single line things are indeed
>>> much easier when the code containing the software
>>> properties / nodes is the same code as which is
>>> registering the gpiochip.
>>
>> Ah, good point!
> 
> This is wrong though, the software node need not be attached to the
> gpiochip (and I wonder if it is even safe to do so). It simply provides
> a name by which gpiochip is looked up in swnode_get_gpio_device().

Ah interesting. This is very different from how fwnodes generally
work though. Generally speaking when a PROPERTY_ENTRY_REF() is used
like PROPERTY_ENTRY_GPIO() does then the lookup is done by matching
the reference to the fwnode of the type of device to which the
reference points.

IOW the standard way how this works for most other subsystems
is that gpiolib-swnode.c: swnode_get_gpio_device() would call
gpio_device_find() with a compare function which uses
device_match_fwnode().

I see that instead it uses the swnode name and passes that to
gpio_device_find_by_label().

I must say that AFAIK this is not how swnodes are supposed to
be used the swnode name field is supposed to only be there
for debugging use and may normally be left empty all together.

I guess using the swnode-name + gpio_device_find_by_label()
works but it goes against the design of how fw-nodes
and especially fwnode-references are supposed to be used...

Having a fwnode reference pointing to what is in essence
a dangling (not attached to any device) fwnode is weird.

Are there already any users of PROPERTY_ENTRY_GPIO() in
the kernel? If not then I think that we should fix things
up to actually do a reference match and not a name based
lookup.

Andy IIRC you've done quite a bit of work on software-nodes,
what is your take on this ?

Note this is likely my last email in this thread for
a while since I will be traveling without email access.

Regards,

Hans



