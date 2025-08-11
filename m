Return-Path: <linux-kernel+bounces-762876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC4CB20BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1757916B918
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396FA228CA3;
	Mon, 11 Aug 2025 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPWL+PfR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB5223719;
	Mon, 11 Aug 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922037; cv=none; b=jY2ydcUFnOncH5h15q+92UXImIjiDgLuJPkQKD6JdKZ221Nz40ZwG1DUK/CV5pBC/bWyFZALRb5aAbSZLspxsvr3B531ssZJNQjt+Y+VlcaNQC4pvp1VPw4F12bAX1TKmW4/ORphlze21sRmmteEZw+Q9FOsKCcLmKXDIPlNFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922037; c=relaxed/simple;
	bh=j5Shuqz1CXocCoQQ86N71cQzgEh1FsxiQiDq4Y4M5lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZp73YnBM9CC9tL48CemiQ/QQQZebETzDUV50/j0SUvMhj7y4waLqCiD1cb4kQF8w0RN1urjDS9uhEZyrRiXyIv9+6UU9zDcIrQWuO5YDiURDf0xJSDbN/QOiJySToBPuGnVtIrEC6iwlQ/tHil8FoiTnFHjLYmmQ4xzmodeQ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPWL+PfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CECC4CEF7;
	Mon, 11 Aug 2025 14:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754922037;
	bh=j5Shuqz1CXocCoQQ86N71cQzgEh1FsxiQiDq4Y4M5lk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bPWL+PfRUU39NxkClfe1O3CVx6RW/INaEdm9V2Tsy5d1LMOskQAfnfx5Rwfet9Vlg
	 BXhoJXJx7OgZWHqDjSh8V+18ot2/Wqlsa3qVAjLm1qEopXUH/J5LbGwJYtDhFrulXC
	 lGrH9KApNrhjzr7k+F2V731pWOsjI5HcIlIroloA2EJkJrPKhcdYCoo9NjFoT+1LGW
	 r8zHBYuF4jz0Apawo3ECnf1yi3TxYl6rhCAWGOW+Ppz4BpK/PPU67Ot97VE3PSGlLc
	 W5K7amTd384TFBNfvZNBGThZ6C3SdO4JedXpir7YcUuJvm3McBzaf3YBcX3teFiXFQ
	 s7mwxQLDu89Gw==
Message-ID: <7c2d08e3-d1e2-433e-b726-307246ab17e9@kernel.org>
Date: Mon, 11 Aug 2025 16:20:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: use software nodes for
 gpio-leds/keys
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Santosh Kumar Yadav <santoshkumar.yadav@barco.com>,
 Peter Korsgaard <peter.korsgaard@barco.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr>
 <aJnlnx2qF6P61jJN@smile.fi.intel.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <aJnlnx2qF6P61jJN@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy, Dmitry,

On 11-Aug-25 2:44 PM, Andy Shevchenko wrote:
> On Sun, Aug 10, 2025 at 09:31:37PM -0700, Dmitry Torokhov wrote:
>> In preparation of dropping support for legacy GPIO API from gpio-keys
>> switch the driver to use software nodes/properties to describe
>> GPIO-connected LED and button.
> 
> ...
> 
>>  #include <linux/delay.h>
>> +#include <linux/dev_printk.h>
>>  #include <linux/dmi.h>
>>  #include <linux/err.h>
>>  #include <linux/io.h>
> 
>>  #include <linux/leds.h>
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>> -#include <linux/gpio_keys.h>
>>  #include <linux/gpio/driver.h>
>>  #include <linux/gpio/machine.h>
>> -#include <linux/input.h>
> 
>> +#include <linux/gpio/property.h>
>> +#include <linux/input-event-codes.h>
>> +#include <linux/property.h>
> 
> The idea of sorting here is to have more generic first and then more specific
> (per subsystem in use) groups of headers. So with your change it should look
> like
> 
> #include <linux/delay.h>
> #include <linux/dev_printk.h>
> #include <linux/dmi.h>
> #include <linux/err.h>
> #include <linux/io.h>
> ...
> #include <linux/leds.h>
> #include <linux/module.h>
> #include <linux/platform_device.h>
> #include <linux/property.h>
> 
> #include <linux/gpio/driver.h>
> #include <linux/gpio/machine.h>
> #include <linux/gpio/property.h>
> 
> #include <linux/input-event-codes.h>
> 
> (I also added blank lines to make it more explicit)
> 
> ...
> 
> Otherwise LGTM as here it looks like we establish platform device ourselves and
> hence no need some additional magic Hans mentioned in the other series.

Not entirely like with the x86-android-tablets patches this
declares a software-node for the gpiochip:

static const struct software_node gpiochip_node = {
	.name = DRIVER_NAME,
};

and registers that node, but nowhere does it actually
get assigned to the gpiochip.

This is going to need a line like this added to probe():

	p50->gc.fwnode = software_node_fwnode(&gpiochip_node);

note the software_node_fwnode() call MUST be made after
registering the software-nodes (group).

Other then needing this single line things are indeed
much easier when the code containing the software
properties / nodes is the same code as which is
registering the gpiochip.

Regards,

Hans



