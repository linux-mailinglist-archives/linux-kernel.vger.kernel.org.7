Return-Path: <linux-kernel+bounces-763339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F0B21398
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E719D3E3801
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991E41A9FAA;
	Mon, 11 Aug 2025 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi/29GmZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBCCB640;
	Mon, 11 Aug 2025 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934328; cv=none; b=KRWowBBYqfDGinvv0cAy5hmqY27mpQsElyDAVqLXb4Ue2e3G258o68vHtHaYZudbps9X+tQQINiL2MaG8PSJfyIdIVoMd/nshf/zCDRx9CuNag4TPb1pjrOyn/vxvLJg73WXcnVe1ulmx8Aw1Ihf08zzh17opVJWlSXPg9Gvq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934328; c=relaxed/simple;
	bh=cbNvYyTng8khy6ZQsS8BDQ2O5TXa1kf9EEo6gDZxZ7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpWViJKpACb3brLHpf8/QFrWVUDhfQZ7DbpJ1XFmF7zRz4PIInMPuM0s3n7pXao7ZS52fvk9TEno8ihA+YNjxz3aKVHb0ZlRXco4YOjx0v6JPO7PVQxYyrtRi129s7eD7+UWOOKLWl2I5Tj8L5KT9vLic9+8LFjldnh2Wh84GXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi/29GmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B535C4CEED;
	Mon, 11 Aug 2025 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754934327;
	bh=cbNvYyTng8khy6ZQsS8BDQ2O5TXa1kf9EEo6gDZxZ7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vi/29GmZSO+MDoWxHiTP9d414l4wwQcPomhdW/Iekw5Fvewy8ZQjj/wgf52jQdXSj
	 s7r5izAGutpQwX8wQN2F78hBxVxWiAxTD19ozOFlYcCRUR6jZkfPHguCb4QreIKOMU
	 FPOkeAH5BY1ajDYXXGTSRadC3s4tIBEIkYpXWzvhe5FX50vdvRUr/FPpQfM87g+2jO
	 DB6jFtvSC50fJpzigx6FKOhEDNhzUr5t+C1OLqmCqHDfCoCSkVPcv+H2vLdrZ9WNxL
	 GwwQKatvggWGRdSTfovlhN+U1I3/y6VcODS6eXYqOVq2WjxWHuNHfCMXyKCuIvnEIo
	 sfsKk/ES4iUiA==
Message-ID: <8d754f56-0df3-4d7a-94ce-96d28f4f8003@kernel.org>
Date: Mon, 11 Aug 2025 19:45:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] platform/x86: x86-android-tablets: convert
 Goodix devices to GPIO references
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Arnd Bergmann <arnd@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250810-x86-andoroid-tablet-v2-0-9c7a1b3c32b2@gmail.com>
 <20250810-x86-andoroid-tablet-v2-1-9c7a1b3c32b2@gmail.com>
 <961582ff-938b-487c-9b86-d2afbfc45304@kernel.org>
 <3ru23uz7mxrjlo77zgkbzdpfzkafzwxt5tvxrbeo3j3h7o2rjx@2ob5m3imsamh>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <3ru23uz7mxrjlo77zgkbzdpfzkafzwxt5tvxrbeo3j3h7o2rjx@2ob5m3imsamh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11-Aug-25 6:01 PM, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Mon, Aug 11, 2025 at 12:09:18PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 11-Aug-25 4:22 AM, Dmitry Torokhov wrote:
>>> Now that gpiolib supports software nodes to describe GPIOs, switch the
>>> driver away from using GPIO lookup tables for Goodix touchscreens to
>>> using PROPERTY_ENTRY_GPIO() to keep all touchscreen properties together.
>>>
>>> Since the tablets are using either Baytrail or Cherryview GPIO
>>> controllers x86_dev_info structure has been extended to carry gpiochip
>>> type information so that the code can instantiate correct set of
>>> software nodes representing the GPIO chip.
>>>
>>> Because this adds a new point of failure in x86_android_tablet_probe(),
>>> x86_android_tablet_remove() is rearranged to handle cases where battery
>>> swnode has not been registered yet, and registering of GPIO lookup
>>> tables is moved earlier as it can not fail.
>>>
>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> Thanks.
>>
>> So I was curious and took a quick peek at the code, mainly at
>> the core changes.
>>
>> ...
>>
>>> diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
>>> index 2a9c47178505..b0d63d3c05cd 100644
>>> --- a/drivers/platform/x86/x86-android-tablets/core.c
>>> +++ b/drivers/platform/x86/x86-android-tablets/core.c
>>> @@ -155,6 +155,7 @@ static struct serdev_device **serdevs;
>>>  static struct gpio_keys_button *buttons;
>>>  static struct gpiod_lookup_table * const *gpiod_lookup_tables;
>>>  static const struct software_node *bat_swnode;
>>> +static const struct software_node **gpiochip_node_group;
>>>  static void (*exit_handler)(void);
>>>  
>>>  static __init struct i2c_adapter *
>>> @@ -331,6 +332,34 @@ static __init int x86_instantiate_serdev(const struct x86_dev_info *dev_info, in
>>>  	return ret;
>>>  }
>>>  
>>> +const struct software_node baytrail_gpiochip_nodes[] = {
>>> +	{ .name = "INT33FC:00" },
>>> +	{ .name = "INT33FC:01" },
>>> +	{ .name = "INT33FC:02" },
>>> +};
>>
>> I'm afraid that just setting the names here, and then
>> registering the node group below is not enough, see
>> the comment below.
> 
> Please see explanation below why it actually is enough.
> 
>>
>>
>>> +
>>> +static const struct software_node *baytrail_gpiochip_node_group[] = {
>>> +	&baytrail_gpiochip_nodes[0],
>>> +	&baytrail_gpiochip_nodes[1],
>>> +	&baytrail_gpiochip_nodes[2],
>>> +	NULL
>>> +};
>>
>> ...
>>
>>> @@ -361,10 +390,14 @@ static void x86_android_tablet_remove(struct platform_device *pdev)
>>>  	if (exit_handler)
>>>  		exit_handler();
>>>  
>>> +	if (bat_swnode)
>>> +		software_node_unregister(bat_swnode);
>>> +
>>> +	if (gpiochip_node_group)
>>> +		software_node_unregister_node_group(gpiochip_node_group);
>>> +
>>>  	for (i = 0; gpiod_lookup_tables && gpiod_lookup_tables[i]; i++)
>>>  		gpiod_remove_lookup_table(gpiod_lookup_tables[i]);
>>> -
>>> -	software_node_unregister(bat_swnode);
>>>  }
>>>  
>>>  static __init int x86_android_tablet_probe(struct platform_device *pdev)
>>> @@ -388,16 +421,36 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
>>>  	for (i = 0; dev_info->modules && dev_info->modules[i]; i++)
>>>  		request_module(dev_info->modules[i]);
>>>  
>>> -	bat_swnode = dev_info->bat_swnode;
>>> -	if (bat_swnode) {
>>> -		ret = software_node_register(bat_swnode);
>>> +	gpiod_lookup_tables = dev_info->gpiod_lookup_tables;
>>> +	for (i = 0; gpiod_lookup_tables && gpiod_lookup_tables[i]; i++)
>>> +		gpiod_add_lookup_table(gpiod_lookup_tables[i]);
>>> +
>>> +	switch (dev_info->gpiochip_type) {
>>> +	case X86_GPIOCHIP_BAYTRAIL:
>>> +		gpiochip_node_group = baytrail_gpiochip_node_group;
>>> +		break;
>>> +	case X86_GPIOCHIP_CHERRYVIEW:
>>> +		gpiochip_node_group = cherryview_gpiochip_node_group;
>>> +		break;
>>> +	case X86_GPIOCHIP_UNSPECIFIED:
>>> +		gpiochip_node_group = NULL;
>>> +		break;
>>> +	}
>>> +
>>> +	if (gpiochip_node_group) {
>>> +		ret = software_node_register_node_group(gpiochip_node_group);
>>>  		if (ret)
>>>  			return ret;
>>>  	}
>>
>> As mentioned above just registering the node group here is not enough,
>> the nodes need to actually be assigned to the platform-devices which
>> are the parents of the GPIO controller, something like this from
>> a recent patch of mine which is not upstream yet:
> 
> No, I'm afraid you misunderstand how software nodes for GPIOs work.

<snip>

Ack. I've already replied to the same remark in the
"[PATCH] platform/x86: barco-p50-gpio: use software nodes for gpio-leds/keys"
thread.

Lets continue discussing this there.

Regards,

Hans



