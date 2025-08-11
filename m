Return-Path: <linux-kernel+bounces-762322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED94CB204E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF21A7A636C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5068722332E;
	Mon, 11 Aug 2025 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeE+LK0J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99510221F2F;
	Mon, 11 Aug 2025 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906962; cv=none; b=kP/S8596uDvF1osaOZYXOhjZliAper5dMXyygvfaEmA0ncveW4hBBaMCq1XKUukdWFC21bBPCwGUjZoU1m0Z+tOYpA0JN7X5C0LR2n8Pf0fJR0TwxZg/wT6/qciw5jNcD8RtOmqj6aVyWR5+ch1Hlu/KOY1HFNqAbx7VOEbJRHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906962; c=relaxed/simple;
	bh=wBjNtP38gVpbJeRu32ZPajKEAVmZSzpTnFlf8icUfMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RENS8K5bhzBkP9qPMJgbRhmt6cLDZn1y9W5DWYIv4ZSQxNBDpw8//YJ8Xa3XAvkdfEvIkPEoRxElDi6HMS2/FPnZSD+jZWfjcSSASf2CdNocik8arYLI4iJVONhrGWC6k4sKzjj+/bBy0bsZqdtgLMUvP6bmEyKR7Fx/Ja4arVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeE+LK0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7147C4CEED;
	Mon, 11 Aug 2025 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754906961;
	bh=wBjNtP38gVpbJeRu32ZPajKEAVmZSzpTnFlf8icUfMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qeE+LK0JRZu/jha4eL8BrcFrDmm4VySFkCvbiH4Zlt9r05nvGx4aiiuSAP/ufDw+R
	 wjNkv3OF8awGba3kStTRON0M+GD4jbVdN/3OFEOHb/F9IdoozamOeRcP6K6eA3tpIT
	 Ll24wg7A0KnA+krCYvbmrpZLlw62ycDpleZCqS7Xa2bcKdgs3eFbPP7EVKDLaVK2+A
	 ofF7Ho/5i3Yy4T7R4BdK5+1f5KTUgCvokO+FPXqIOVs+k97zew5sUhVQA0UW7Lh7nO
	 YRmEgdIPsTPu5fKIgFeyxZ/K1RJSiTVMzs0Yja0fYsUentCH7EsjDp30Kk/c4ddt3H
	 QDsKYhDI5dNZw==
Message-ID: <961582ff-938b-487c-9b86-d2afbfc45304@kernel.org>
Date: Mon, 11 Aug 2025 12:09:18 +0200
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
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20250810-x86-andoroid-tablet-v2-1-9c7a1b3c32b2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11-Aug-25 4:22 AM, Dmitry Torokhov wrote:
> Now that gpiolib supports software nodes to describe GPIOs, switch the
> driver away from using GPIO lookup tables for Goodix touchscreens to
> using PROPERTY_ENTRY_GPIO() to keep all touchscreen properties together.
> 
> Since the tablets are using either Baytrail or Cherryview GPIO
> controllers x86_dev_info structure has been extended to carry gpiochip
> type information so that the code can instantiate correct set of
> software nodes representing the GPIO chip.
> 
> Because this adds a new point of failure in x86_android_tablet_probe(),
> x86_android_tablet_remove() is rearranged to handle cases where battery
> swnode has not been registered yet, and registering of GPIO lookup
> tables is moved earlier as it can not fail.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

So I was curious and took a quick peek at the code, mainly at
the core changes.

...

> diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
> index 2a9c47178505..b0d63d3c05cd 100644
> --- a/drivers/platform/x86/x86-android-tablets/core.c
> +++ b/drivers/platform/x86/x86-android-tablets/core.c
> @@ -155,6 +155,7 @@ static struct serdev_device **serdevs;
>  static struct gpio_keys_button *buttons;
>  static struct gpiod_lookup_table * const *gpiod_lookup_tables;
>  static const struct software_node *bat_swnode;
> +static const struct software_node **gpiochip_node_group;
>  static void (*exit_handler)(void);
>  
>  static __init struct i2c_adapter *
> @@ -331,6 +332,34 @@ static __init int x86_instantiate_serdev(const struct x86_dev_info *dev_info, in
>  	return ret;
>  }
>  
> +const struct software_node baytrail_gpiochip_nodes[] = {
> +	{ .name = "INT33FC:00" },
> +	{ .name = "INT33FC:01" },
> +	{ .name = "INT33FC:02" },
> +};

I'm afraid that just setting the names here, and then
registering the node group below is not enough, see
the comment below.


> +
> +static const struct software_node *baytrail_gpiochip_node_group[] = {
> +	&baytrail_gpiochip_nodes[0],
> +	&baytrail_gpiochip_nodes[1],
> +	&baytrail_gpiochip_nodes[2],
> +	NULL
> +};

...

> @@ -361,10 +390,14 @@ static void x86_android_tablet_remove(struct platform_device *pdev)
>  	if (exit_handler)
>  		exit_handler();
>  
> +	if (bat_swnode)
> +		software_node_unregister(bat_swnode);
> +
> +	if (gpiochip_node_group)
> +		software_node_unregister_node_group(gpiochip_node_group);
> +
>  	for (i = 0; gpiod_lookup_tables && gpiod_lookup_tables[i]; i++)
>  		gpiod_remove_lookup_table(gpiod_lookup_tables[i]);
> -
> -	software_node_unregister(bat_swnode);
>  }
>  
>  static __init int x86_android_tablet_probe(struct platform_device *pdev)
> @@ -388,16 +421,36 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
>  	for (i = 0; dev_info->modules && dev_info->modules[i]; i++)
>  		request_module(dev_info->modules[i]);
>  
> -	bat_swnode = dev_info->bat_swnode;
> -	if (bat_swnode) {
> -		ret = software_node_register(bat_swnode);
> +	gpiod_lookup_tables = dev_info->gpiod_lookup_tables;
> +	for (i = 0; gpiod_lookup_tables && gpiod_lookup_tables[i]; i++)
> +		gpiod_add_lookup_table(gpiod_lookup_tables[i]);
> +
> +	switch (dev_info->gpiochip_type) {
> +	case X86_GPIOCHIP_BAYTRAIL:
> +		gpiochip_node_group = baytrail_gpiochip_node_group;
> +		break;
> +	case X86_GPIOCHIP_CHERRYVIEW:
> +		gpiochip_node_group = cherryview_gpiochip_node_group;
> +		break;
> +	case X86_GPIOCHIP_UNSPECIFIED:
> +		gpiochip_node_group = NULL;
> +		break;
> +	}
> +
> +	if (gpiochip_node_group) {
> +		ret = software_node_register_node_group(gpiochip_node_group);
>  		if (ret)
>  			return ret;
>  	}

As mentioned above just registering the node group here is not enough,
the nodes need to actually be assigned to the platform-devices which
are the parents of the GPIO controller, something like this from
a recent patch of mine which is not upstream yet:

static int __init acer_a1_840_init(struct device *dev)
{
        int ret;

        acer_a1_840_fg_dev = bus_find_device_by_name(&platform_bus_type, NULL, "chtdc_ti_batterry");
        if (!acer_a1_840_fg_dev)
                return dev_err_probe(dev, -EPROBE_DEFER, "getting chtdc_ti_battery dev\n");

        acer_a1_840_fg_node = fwnode_create_software_node(acer_a1_840_fg_props, NULL);
        if (IS_ERR(acer_a1_840_fg_node)) {
                ret = PTR_ERR(acer_a1_840_fg_node);
                goto err_put;
        }

        ret = device_add_software_node(acer_a1_840_fg_dev,
                                       to_software_node(acer_a1_840_fg_node));
        if (ret)
                goto err_put;

Except that this will only work if the GPIO controller gets probed()
after assigning the swnodes. Otherwise the GPIO controller itself will
not have the fwnode_handle inside struct gpio_chip set ...

Oh wait, that fwnode will already be set, it will point to the ACPI
fwnode. So setting the swnode on the platform device will likely work,
because that will be assigned to fwnode_handle->secondary and
the fwnode_handle pointer is shared between the platform-device
and the gpiochip, so adding the software_node to the platform-device
will also set fwnode_handle->secondary for the gpiochio (as it is
the same fwnode_handle).

So thinking more about it calling device_add_software_node() on
the GPIO controller parent platform-device doing something like\
the above should work ...

But only calling software_node_register_node_group() definitely
is not enough.

Regards,

Hans




