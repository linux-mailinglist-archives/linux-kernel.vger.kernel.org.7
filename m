Return-Path: <linux-kernel+bounces-763175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 645F9B2113B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0805F188D39A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CAA29BD81;
	Mon, 11 Aug 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACG0UALx"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242C6F06B;
	Mon, 11 Aug 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928123; cv=none; b=qGDsQnMY28z6fneFlP7LvqyWsgS7HJ0tXIuivO9tRe2+843wkdO02xFjKoqtnKqAeMsR3+ibjiLSVZnnKTjK353S1yWrhKUeXfH0sUJ0AfCFLqPElOXT8XRv0moV5JQZqWJJ7/2mljCkwAFv/+7NFJzbLuseeOlHc7AGAfks7cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928123; c=relaxed/simple;
	bh=/eBUVsIBK/xWxKGZCkMqFNojPAESEO7+XGxmxoyNAHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmrR/mwcUqeLiaIvYR4LRXgj5nFAggc5ByWq2Cvk1AUeyiwekmHMirzpEQOCsfGSv2dWF4yzTzChtZy//gSkQtErmTWyZdle75digVqpg6gTV7K7mjqxKQEwFRh/WGYBRRUR1lWy3Ug9c3pWKAYZUOrFeMBxaNBfo697waveKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACG0UALx; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bd202ef81so5851712b3a.3;
        Mon, 11 Aug 2025 09:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754928121; x=1755532921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n6NG/u4rLkxmkgpK/ejZN7eGGzWbDlAerh5EVuem2VI=;
        b=ACG0UALxDUgv3lmdUySBTn+71b2dS9I0aBYJkkgs5a6d0gE2cvTUHuDoMS9yefSA15
         P52BmTkjIEll4QMyC0/EyHAk83MuoY5laKFbE8cIqh50cbxTwgPGweE9VBRTdc79O48A
         V6lG55DKdfWALBwm+K3MDbZkTtNlgyBQAfbj/gBI6vllZLlRQTZbz3fAtdbsnuZh2EsV
         /5fduq6uq//ktKq9Lr+3x4QjLzgwDCb22V0YYS50uvWXQrVkc2PgPQGkCKsr89akK6nG
         HMlqoZ4rDmiWj+bzYUVjJ5go2isxWT/7Toz/pDp+qj4rVjaG3cmaiccqv5QZKA4hQfPl
         5uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754928121; x=1755532921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6NG/u4rLkxmkgpK/ejZN7eGGzWbDlAerh5EVuem2VI=;
        b=ZjsoFQL4NUE/6llenw2wKnWwPCxHR8CrV5xBBhwvcNs8slH88tO2EOTpHuJ47WiDJj
         //vTQ7NtKLCcSSm9VHBlx1M6M8Wgx78fk0kHAHt8NrQgo8zcCDxA6bPLuXTs5xN1Nfa8
         cKT8N9cOGjKJBARw2rByPQIeZ3Lf3DL1pOIGYIpk/U19UHqgO16vmg9QfDnlgRobKX8i
         kK4DnYXMz7zvfpc2pfsXxp/eeKAfmXz6ZsiEcoXQiyX9TM6uGioXvqUV95/XUCYBlbvR
         sYP/t2HziScUCRiDh2dNcmZEMr2EgJ1JVuvQlxcUH7G8T/IleC/VoDNT84G/YtBBUy3P
         0sCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWutWcxE0QoWdvMEzODYSa0/iHRUPzqbgImGlKUkSdhAJkqkVHpX+fvvsDbt8Lt2PgYINJymw6j7bhQ9QLdWudvziWZwQ==@vger.kernel.org, AJvYcCX/M44pZCTVqoYC3nRRlR6WoSu1COmmpY7N4prRJpp7vFOo0aQ84sBsemFTCA9xYdBqWjqZAKcKvY7uvdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV7vcZoKmipAUTFiadTz9bSNs3A1Txkp4aQFl5X66YAyRUtUFC
	KQjrZxd9MHBXq9TZnUGS033ZvUFQH9Nws9JhsqSouaTK4DO0Pt16sySv
X-Gm-Gg: ASbGncuWyzJU8/Mz7dsok5VyrEx2n1c4xtPYkXWGa51CyiLy2IoUuuVbGiLqOKHGDxH
	FJpICzIc621KHaEmJM0LbbL6t7uO7xSS1W3kWRmIrNqSHv7ld178aZBEQjv41jmA0JsCQd6a6U6
	f++LmMwo8PxVePSrFBSbDLV9g/TXsDbX4Sr/3wZOTuicfDR8/Jpkqi6R0+kqUvG/eAbsVKacepZ
	8e4+oov6/i/qWwxMIzORG8jZrZY7+8Y39XNnvJhnXppeMxBrBp+y8W+5vWfRqphOBSuRqvroHb3
	leyzTHcprS2enSLaxNIyFUr5wRJufEV/pSCZvEXSO2xpwavbrIOnA7+gjwO+yN9lhpaKrBd+pDo
	6MfxFD831gNuNxB9jrsTLuhVOMhB71KAFgw==
X-Google-Smtp-Source: AGHT+IH5+Tp+GVfCz5bY+1qak517FkAY6ZYwEAlhdjGGz9bXGXFx/dyhqfEC3u9L5FQYXapCggnlmg==
X-Received: by 2002:a05:6a00:4fcf:b0:740:67aa:94ab with SMTP id d2e1a72fcca58-76e0dc8423bmr239854b3a.0.1754928120809;
        Mon, 11 Aug 2025 09:02:00 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f6fesm27079154b3a.26.2025.08.11.09.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:02:00 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:01:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Arnd Bergmann <arnd@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] platform/x86: x86-android-tablets: convert
 Goodix devices to GPIO references
Message-ID: <3ru23uz7mxrjlo77zgkbzdpfzkafzwxt5tvxrbeo3j3h7o2rjx@2ob5m3imsamh>
References: <20250810-x86-andoroid-tablet-v2-0-9c7a1b3c32b2@gmail.com>
 <20250810-x86-andoroid-tablet-v2-1-9c7a1b3c32b2@gmail.com>
 <961582ff-938b-487c-9b86-d2afbfc45304@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <961582ff-938b-487c-9b86-d2afbfc45304@kernel.org>

Hi Hans,

On Mon, Aug 11, 2025 at 12:09:18PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 11-Aug-25 4:22 AM, Dmitry Torokhov wrote:
> > Now that gpiolib supports software nodes to describe GPIOs, switch the
> > driver away from using GPIO lookup tables for Goodix touchscreens to
> > using PROPERTY_ENTRY_GPIO() to keep all touchscreen properties together.
> > 
> > Since the tablets are using either Baytrail or Cherryview GPIO
> > controllers x86_dev_info structure has been extended to carry gpiochip
> > type information so that the code can instantiate correct set of
> > software nodes representing the GPIO chip.
> > 
> > Because this adds a new point of failure in x86_android_tablet_probe(),
> > x86_android_tablet_remove() is rearranged to handle cases where battery
> > swnode has not been registered yet, and registering of GPIO lookup
> > tables is moved earlier as it can not fail.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Thanks.
> 
> So I was curious and took a quick peek at the code, mainly at
> the core changes.
> 
> ...
> 
> > diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
> > index 2a9c47178505..b0d63d3c05cd 100644
> > --- a/drivers/platform/x86/x86-android-tablets/core.c
> > +++ b/drivers/platform/x86/x86-android-tablets/core.c
> > @@ -155,6 +155,7 @@ static struct serdev_device **serdevs;
> >  static struct gpio_keys_button *buttons;
> >  static struct gpiod_lookup_table * const *gpiod_lookup_tables;
> >  static const struct software_node *bat_swnode;
> > +static const struct software_node **gpiochip_node_group;
> >  static void (*exit_handler)(void);
> >  
> >  static __init struct i2c_adapter *
> > @@ -331,6 +332,34 @@ static __init int x86_instantiate_serdev(const struct x86_dev_info *dev_info, in
> >  	return ret;
> >  }
> >  
> > +const struct software_node baytrail_gpiochip_nodes[] = {
> > +	{ .name = "INT33FC:00" },
> > +	{ .name = "INT33FC:01" },
> > +	{ .name = "INT33FC:02" },
> > +};
> 
> I'm afraid that just setting the names here, and then
> registering the node group below is not enough, see
> the comment below.

Please see explanation below why it actually is enough.

> 
> 
> > +
> > +static const struct software_node *baytrail_gpiochip_node_group[] = {
> > +	&baytrail_gpiochip_nodes[0],
> > +	&baytrail_gpiochip_nodes[1],
> > +	&baytrail_gpiochip_nodes[2],
> > +	NULL
> > +};
> 
> ...
> 
> > @@ -361,10 +390,14 @@ static void x86_android_tablet_remove(struct platform_device *pdev)
> >  	if (exit_handler)
> >  		exit_handler();
> >  
> > +	if (bat_swnode)
> > +		software_node_unregister(bat_swnode);
> > +
> > +	if (gpiochip_node_group)
> > +		software_node_unregister_node_group(gpiochip_node_group);
> > +
> >  	for (i = 0; gpiod_lookup_tables && gpiod_lookup_tables[i]; i++)
> >  		gpiod_remove_lookup_table(gpiod_lookup_tables[i]);
> > -
> > -	software_node_unregister(bat_swnode);
> >  }
> >  
> >  static __init int x86_android_tablet_probe(struct platform_device *pdev)
> > @@ -388,16 +421,36 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
> >  	for (i = 0; dev_info->modules && dev_info->modules[i]; i++)
> >  		request_module(dev_info->modules[i]);
> >  
> > -	bat_swnode = dev_info->bat_swnode;
> > -	if (bat_swnode) {
> > -		ret = software_node_register(bat_swnode);
> > +	gpiod_lookup_tables = dev_info->gpiod_lookup_tables;
> > +	for (i = 0; gpiod_lookup_tables && gpiod_lookup_tables[i]; i++)
> > +		gpiod_add_lookup_table(gpiod_lookup_tables[i]);
> > +
> > +	switch (dev_info->gpiochip_type) {
> > +	case X86_GPIOCHIP_BAYTRAIL:
> > +		gpiochip_node_group = baytrail_gpiochip_node_group;
> > +		break;
> > +	case X86_GPIOCHIP_CHERRYVIEW:
> > +		gpiochip_node_group = cherryview_gpiochip_node_group;
> > +		break;
> > +	case X86_GPIOCHIP_UNSPECIFIED:
> > +		gpiochip_node_group = NULL;
> > +		break;
> > +	}
> > +
> > +	if (gpiochip_node_group) {
> > +		ret = software_node_register_node_group(gpiochip_node_group);
> >  		if (ret)
> >  			return ret;
> >  	}
> 
> As mentioned above just registering the node group here is not enough,
> the nodes need to actually be assigned to the platform-devices which
> are the parents of the GPIO controller, something like this from
> a recent patch of mine which is not upstream yet:

No, I'm afraid you misunderstand how software nodes for GPIOs work.

If you look into drivers/gpio/gpiolib-swnode.c, in particular at 
swnode_get_gpio_device(), is uses the name from the software node to
match with the name of registered gpiochip to locate it. The node itself
does not need to be attached to the gpiochip or it's parent device, it
is simply there to establish a link between GPIO reference
(SOFTWARE_NODE_REFEREMCE) and gpiochip structure.

So PROPERTY_ENTRY_GPIO is pretty much PROPERTY_ENTRY_REF which is:

#define PROPERTY_ENTRY_REF(_name_, _ref_, ...)				\
(struct property_entry) {						\
	.name = _name_,							\
	.length = sizeof(struct software_node_ref_args),		\
	.type = DEV_PROP_REF,						\
	{ .pointer = &SOFTWARE_NODE_REFERENCE(_ref_, ##__VA_ARGS__), },	\
}

and SOFTWARE_NODE_REFERENCE is

#define SOFTWARE_NODE_REFERENCE(_ref_, ...)			\
(const struct software_node_ref_args) {				\
	.node = _ref_,						\
	.nargs = COUNT_ARGS(__VA_ARGS__),			\
	.args = { __VA_ARGS__ },				\
}

swnode_find_gpio() scans these entries looking for the matching name,
and then resolves the references by taking the _ref_ software node,
using its name and doing:

	gdev = gpio_device_find_by_label(gdev_node->name);

Where gdev_node is that potentially unattached software node and name is
"INT33FC:00" or whatever.


> 
> static int __init acer_a1_840_init(struct device *dev)
> {
>         int ret;
> 
>         acer_a1_840_fg_dev = bus_find_device_by_name(&platform_bus_type, NULL, "chtdc_ti_batterry");
>         if (!acer_a1_840_fg_dev)
>                 return dev_err_probe(dev, -EPROBE_DEFER, "getting chtdc_ti_battery dev\n");
> 
>         acer_a1_840_fg_node = fwnode_create_software_node(acer_a1_840_fg_props, NULL);
>         if (IS_ERR(acer_a1_840_fg_node)) {
>                 ret = PTR_ERR(acer_a1_840_fg_node);
>                 goto err_put;
>         }
> 
>         ret = device_add_software_node(acer_a1_840_fg_dev,
>                                        to_software_node(acer_a1_840_fg_node));
>         if (ret)
>                 goto err_put;
> 
> Except that this will only work if the GPIO controller gets probed()
> after assigning the swnodes. Otherwise the GPIO controller itself will
> not have the fwnode_handle inside struct gpio_chip set ...
> 
> Oh wait, that fwnode will already be set, it will point to the ACPI
> fwnode. So setting the swnode on the platform device will likely work,
> because that will be assigned to fwnode_handle->secondary and
> the fwnode_handle pointer is shared between the platform-device
> and the gpiochip, so adding the software_node to the platform-device
> will also set fwnode_handle->secondary for the gpiochio (as it is
> the same fwnode_handle).
> 
> So thinking more about it calling device_add_software_node() on
> the GPIO controller parent platform-device doing something like\
> the above should work ...
> 
> But only calling software_node_register_node_group() definitely
> is not enough.

Yes, it actually is.

Thanks.

-- 
Dmitry

