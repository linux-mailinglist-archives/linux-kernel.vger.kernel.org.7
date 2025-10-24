Return-Path: <linux-kernel+bounces-868027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E282C042E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA01E354ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDF326B2D2;
	Fri, 24 Oct 2025 02:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gmcha7yu"
Received: from mail-m19731118.qiye.163.com (mail-m19731118.qiye.163.com [220.197.31.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF9D14386D;
	Fri, 24 Oct 2025 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274513; cv=none; b=dOzO2xVgDhiJ4D/cnEDaH9ae4xhXwf/NJrwFSKCD1/WIKqmGQxK6RZovkGbqV4G1V3LKDv4FcTyERa2ARP+tmqfN8KlNkwcuiR17sayoJCC6jQMSJMFoyQ3U3frDGHls5MJqfAWzoaFlKcLwmfz0v3MlB3r/sh4tVUbqfAO4dfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274513; c=relaxed/simple;
	bh=7Qj/NAfS3cLyaDSJR4xvC/LqFNp7atNcNr1bPRQSWUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2JvVhlfhl4ehlLu+Gkm0Lm+QexwtJwy75YYYVjGI0mLnC0iNbWOLVYzbnp/+6OQwD3QL3MDBIOXmY3h27hmSXg3iiveIAkVPlht6360Wy087Jfeso1kU3fPciUhnO3GfNgH9fxenYa2RpMmNJC0DHzk7iHPek/SYc1LX6pXU3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gmcha7yu; arc=none smtp.client-ip=220.197.31.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.149] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 270392de1;
	Fri, 24 Oct 2025 10:54:54 +0800 (GMT+08:00)
Message-ID: <3a24bd7f-c247-4541-8cf5-c1e66e2af5a0@rock-chips.com>
Date: Fri, 24 Oct 2025 10:54:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/9] usb: typec: Add notifier functions
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Chaoyi Chen <kernel@airkyi.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>, Dragan Simic <dsimic@manjaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20251023033009.90-1-kernel@airkyi.com>
 <20251023033009.90-2-kernel@airkyi.com> <aPni4AeDaem_rfZH@kuha.fi.intel.com>
 <aPnvoSRJefwDlpNO@kuha.fi.intel.com> <aPn4-S7upPOOtenr@kuha.fi.intel.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <aPn4-S7upPOOtenr@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a1423fc4303abkunm4d0d6ba0277ced
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMaHVYZGU1PQ0lLSksaSk5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gmcha7yuuy2CrfoJTdnhI28g8WBtmL6HRH9Mdyp3PkXa22Ic+yNinMzirWLDo1sTbwJVUhRbRenlG1jXmIyMJdhn2Is0wH2sqNKx0KDDv2BfwRPbBJ0P629GC7/OLFQ5/1dtLeizfRYMEGojJWZS/eHoEMLejymKWKBGpFP+TiQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=N/ZJiet+D4kgJuaGh5t2VPX+e1fCgDJpBS23oXLL2Nk=;
	h=date:mime-version:subject:message-id:from;

Hi Heikki,

On 10/23/2025 5:44 PM, Heikki Krogerus wrote:
> On Thu, Oct 23, 2025 at 12:04:44PM +0300, Heikki Krogerus wrote:
>> On Thu, Oct 23, 2025 at 11:10:20AM +0300, Heikki Krogerus wrote:
>>> Hi,
>>>
>>>> diff --git a/include/linux/usb/typec_notify.h b/include/linux/usb/typec_notify.h
>>>> new file mode 100644
>>>> index 000000000000..a3f1f3b3ae47
>>>> --- /dev/null
>>>> +++ b/include/linux/usb/typec_notify.h
>>>> @@ -0,0 +1,17 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +
>>>> +#ifndef __USB_TYPEC_NOTIFY
>>>> +#define __USB_TYPEC_NOTIFY
>>>> +
>>>> +#include <linux/notifier.h>
>>>> +
>>>> +enum usb_typec_event {
>>>> +	TYPEC_ALTMODE_REGISTERED
>>>> +};
>>> Don't you need to know when the altmode is removed?
>> I noticed that you don't because drm_dp_hpd_bridge_register() is
>> always resource managed. But I think you could still send an event
>> also when the altmode is removed already now. That way it does not
>> need to be separately added if and when it is needed.
> Hold on! Every bus has already a notifier chain. That's the one that
> we should also use. Sorry for not noticing that earlier.
>
> So let's just export the bus type in this patch - you can then use
> bus_register_notifier() in your driver:
>
> diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> index a884cec9ab7e..65ded9e3cdaa 100644
> --- a/drivers/usb/typec/bus.c
> +++ b/drivers/usb/typec/bus.c
> @@ -547,3 +547,4 @@ const struct bus_type typec_bus = {
>          .probe = typec_probe,
>          .remove = typec_remove,
>   };
> +EXPORT_SYMBOL_GPL(typec_bus);
> diff --git a/drivers/usb/typec/bus.h b/drivers/usb/typec/bus.h
> index 643b8c81786d..af9edb3db9d0 100644
> --- a/drivers/usb/typec/bus.h
> +++ b/drivers/usb/typec/bus.h
> @@ -5,7 +5,6 @@
>   
>   #include <linux/usb/typec_altmode.h>
>   
> -struct bus_type;
>   struct typec_mux;
>   struct typec_retimer;
>   
> @@ -28,7 +27,6 @@ struct altmode {
>   
>   #define to_altmode(d) container_of(d, struct altmode, adev)
>   
> -extern const struct bus_type typec_bus;
>   extern const struct device_type typec_altmode_dev_type;
>   
>   #define is_typec_altmode(_dev_) (_dev_->type == &typec_altmode_dev_type)
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 309251572e2e..c6fd46902fce 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -20,12 +20,15 @@ struct typec_port;
>   struct typec_altmode_ops;
>   struct typec_cable_ops;
>   
> +struct bus_type;
>   struct fwnode_handle;
>   struct device;
>   
>   struct usb_power_delivery;
>   struct usb_power_delivery_desc;
>   
> +extern const struct bus_type typec_bus;
> +
>   enum typec_port_type {
>          TYPEC_PORT_SRC,
>          TYPEC_PORT_SNK,
>
> thanks,

I noticed the following statement in typec_register_altmode():

```

     /* The partners are bind to drivers */
     if (is_typec_partner(parent))
         alt->adev.dev.bus = &typec_bus;

```

If the condition is not met, the bus will not be set, which means bus_notify() won't be able to take effect. Did I miss something?


-- 
Best,
Chaoyi


