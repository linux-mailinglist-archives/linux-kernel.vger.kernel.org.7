Return-Path: <linux-kernel+bounces-860706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D13BF0BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90096189F7CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9C72F9D8C;
	Mon, 20 Oct 2025 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="dXqj5NkZ"
Received: from mail-m21467.qiye.163.com (mail-m21467.qiye.163.com [117.135.214.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4853424676B;
	Mon, 20 Oct 2025 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958477; cv=none; b=oFa3zmzpxxj9lxNJwLHMOw8SEh/V330ZdyyEzamYZaaEmjI5KCkUTBsdwq33S1U77NbQ6jf20ZViaWEkEivoFbJnBRZAyOe9TTWQ04+tQFVsZZQrLCERQeJzim3I8YtlMdLmVjLTWUvfVbv+9owFZIxJEvgg9PXo+w7Y8qdl/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958477; c=relaxed/simple;
	bh=XR2VwGVUBY0oNp+PAoWlyn373NkPJfO6YjBid3cI/xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaWlY5DJZ0hK93VgLKvxNj+9mznSfz9h1QJfiILy+xvvYslUDrNH0GWggGesZqa1h0ldxN7xzJaUKNy0wV7b8b8qENyYIobBidHZS9PrVGGMeRbFo0HV1HV2q2cZbFb6/AvO9dvgImQ3C4Wyhk62mSU0DKshLVMiN1vt84AvSu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=dXqj5NkZ; arc=none smtp.client-ip=117.135.214.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.149] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 268423cdc;
	Mon, 20 Oct 2025 19:07:48 +0800 (GMT+08:00)
Message-ID: <954a67d1-1759-4e18-8eef-3fa14fb3cef5@rock-chips.com>
Date: Mon, 20 Oct 2025 19:07:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] usb: typec: Add default HPD device when register
 DisplayPort altmode
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Chaoyi Chen <kernel@airkyi.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20251016022741.91-1-kernel@airkyi.com>
 <20251016022741.91-2-kernel@airkyi.com> <aPYImGmesrZWwyqh@kuha.fi.intel.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <aPYImGmesrZWwyqh@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a014dd00203abkunm40e5dafaa0fcfb
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlKGVZPGB1KQx1CSU5CSUJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	9VSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dXqj5NkZfi6RdQnKgqMUg8BCh/n152sPRHim3KgJLTuoqkgUqNXBIJ1AlymydVKUpz8pF6HwyNm2AetRmBbh9s5l+IGGlsVFCOmPNAyFWUBGqpTYSkwmiZ3vxoKGCHQdHSj3aXmc2X4h5qhyffGPX+Ek0rtr7mj99qONbKoltJ8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=PW2Gb3KgS1lxfff0TLl++nMBLOL4Uug61XDZnqG+onc=;
	h=date:mime-version:subject:message-id:from;

Hi Heikki,

On 10/20/2025 6:02 PM, Heikki Krogerus wrote:
> On Thu, Oct 16, 2025 at 10:27:34AM +0800, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> Add default DRM AUX HPD bridge device when register DisplayPort
>> altmode. That makes it redundant for each Type-C driver to implement
>> a similar registration process in embedded scenarios.
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> ---
>>
>> Changes in v6:
>> - Fix depend in Kconfig.
>>
>> Changes in v5:
>> - Remove the calls related to `drm_aux_hpd_bridge_notify()`.
>> - Place the helper functions in the same compilation unit.
>> - Add more comments about parent device.
>>
>>   drivers/usb/typec/Kconfig         |  2 ++
>>   drivers/usb/typec/class.c         | 26 ++++++++++++++++++++++++++
>>   include/linux/usb/typec_altmode.h |  2 ++
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
>> index 2f80c2792dbd..a6730fbb576b 100644
>> --- a/drivers/usb/typec/Kconfig
>> +++ b/drivers/usb/typec/Kconfig
>> @@ -2,6 +2,8 @@
>>   
>>   menuconfig TYPEC
>>   	tristate "USB Type-C Support"
>> +	depends on DRM || DRM=n
>> +	select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
> This is wrong. DRM should not dictate how this entire subsystem core
> is configured. The dependency needs to be on the DRM bridge side.
>
> You can for example use the bus notification there to see when a new
> alternate mode is being registered, or use some other notification
> mechanism.

Is it a good idea to implement notification functions like drivers/usb/core/notify.c in TCPM, and then let other subsystems (such as DRM) listen to these notifications?


>
> thanks,
>
>>   	help
>>   	  USB Type-C Specification defines a cable and connector for USB where
>>   	  only one type of plug is supported on both ends, i.e. there will not
>> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
>> index 67a533e35150..e9d7772d1a8f 100644
>> --- a/drivers/usb/typec/class.c
>> +++ b/drivers/usb/typec/class.c
>> @@ -8,14 +8,18 @@
>>   
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>> +#include <linux/of.h>
>>   #include <linux/property.h>
>>   #include <linux/slab.h>
>>   #include <linux/string_choices.h>
>>   #include <linux/usb/pd_vdo.h>
>> +#include <linux/usb/typec_dp.h>
>>   #include <linux/usb/typec_mux.h>
>>   #include <linux/usb/typec_retimer.h>
>>   #include <linux/usb.h>
>>   
>> +#include <drm/bridge/aux-bridge.h>
>> +
>>   #include "bus.h"
>>   #include "class.h"
>>   #include "pd.h"
>> @@ -538,6 +542,21 @@ const struct device_type typec_altmode_dev_type = {
>>   	.release = typec_altmode_release,
>>   };
>>   
>> +static void dp_altmode_hpd_device_register(struct typec_altmode *alt)
>> +{
>> +	if (alt->svid != USB_TYPEC_DP_SID)
>> +		return;
>> +
>> +	/*
>> +	 * alt->dev.parent->parent : USB-C controller device
>> +	 * alt->dev.parent         : USB-C connector device
>> +	 */
>> +	alt->hpd_dev = drm_dp_hpd_bridge_register(alt->dev.parent->parent,
>> +						  to_of_node(alt->dev.parent->fwnode));
>> +	if (IS_ERR(alt->hpd_dev))
>> +		alt->hpd_dev = NULL;
>> +}
>> +
>>   static struct typec_altmode *
>>   typec_register_altmode(struct device *parent,
>>   		       const struct typec_altmode_desc *desc)
>> @@ -600,6 +619,13 @@ typec_register_altmode(struct device *parent,
>>   		return ERR_PTR(ret);
>>   	}
>>   
>> +	/*
>> +	 * It is too late to register the HPD device when the DisplayPort
>> +	 * altmode device becomes ready. If the current altmode is DP,
>> +	 * register a static HPD device.
>> +	 */
>> +	dp_altmode_hpd_device_register(&alt->adev);
>> +
>>   	return &alt->adev;
>>   }
>>   
>> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
>> index b3c0866ea70f..acb0af1b9d5d 100644
>> --- a/include/linux/usb/typec_altmode.h
>> +++ b/include/linux/usb/typec_altmode.h
>> @@ -21,6 +21,7 @@ struct typec_altmode_ops;
>>    * @desc: Optional human readable description of the mode
>>    * @ops: Operations vector from the driver
>>    * @cable_ops: Cable operations vector from the driver.
>> + * @hpd_dev: HPD device for DisplayPort
>>    */
>>   struct typec_altmode {
>>   	struct device			dev;
>> @@ -32,6 +33,7 @@ struct typec_altmode {
>>   	char				*desc;
>>   	const struct typec_altmode_ops	*ops;
>>   	const struct typec_cable_ops	*cable_ops;
>> +	struct device			*hpd_dev;
>>   };
>>   
>>   #define to_typec_altmode(d) container_of(d, struct typec_altmode, dev)
>> -- 
>> 2.49.0

-- 
Best,
Chaoyi


