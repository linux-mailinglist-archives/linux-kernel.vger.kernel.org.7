Return-Path: <linux-kernel+bounces-828083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F690B93E71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF8618A423E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCEC26E6E8;
	Tue, 23 Sep 2025 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="MjfxaMhN"
Received: from mail-m19731110.qiye.163.com (mail-m19731110.qiye.163.com [220.197.31.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AD425A334;
	Tue, 23 Sep 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592206; cv=none; b=ms/ce6H9Fy//HlEPLhikuNXw0aLaQRgAOdLIM5jJg4DLird+Dc95tw+e/O2y0bfdp+s5It1XoOLLZj0rZwxJtAaML0DZx3nGVI1+5Bg2nnJGSQBLLCjDkYvS4fjhmDBj0Bj9FyjRhze3R0rltt2l3w+3AzTTZbjdKXkEQHDiZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592206; c=relaxed/simple;
	bh=+M6D1z1aSu5o71ItJC/qvn3A2Mpi3sy7HQ0uwlukb+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7azHP/QOr647VwKCplSCnbXRDK/e3ArlLkni9RaLXktO0KO3e/hd2kBCD23ndWYTk1hpIK1bkx4ayug2TpEkyWjQQflW6xKZe1uvn8PP5xd/9fd/OWftFpkeTmXgidnSzss8nIp/wIA6/Xafwxj1JpO0vIW1cM0MYMdCqGk1cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=MjfxaMhN; arc=none smtp.client-ip=220.197.31.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 23b40ab11;
	Tue, 23 Sep 2025 09:34:40 +0800 (GMT+08:00)
Message-ID: <e9cf0aa8-ed32-4ffb-a755-150742455808@rock-chips.com>
Date: Tue, 23 Sep 2025 09:34:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] usb: typec: Add default HPD device when register
 DisplayPort altmode
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20250922012039.323-1-kernel@airkyi.com>
 <20250922012039.323-2-kernel@airkyi.com>
 <mygbqhiom6pkwsadzz2bqf5bth3ogsbd6iku5a7r5swxrakein@fjhz7udnkcks>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <mygbqhiom6pkwsadzz2bqf5bth3ogsbd6iku5a7r5swxrakein@fjhz7udnkcks>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a997435663e03abkunm07394047b1283
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh4YGFYaGEpNHhgfTEMfTEhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=MjfxaMhNkqVIf6KIftsHcjWQjPy60e0dSApxnsFiS9Qu1sfUfcvJyU5z6a33gqxVLbb31H5++TZnQmck5JY8z57VOUa8oO42/qIsf6slYgGkDj/cgC6R8JawKVaFE3otXI8iphPEHWrsMK8FR4fierrjGEFZ3csE3Er9o1IYxn0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=nqVqLM0pFpqbw/sVgseWDxAxw4GetnCa6cznE3P0mpg=;
	h=date:mime-version:subject:message-id:from;

On 9/23/2025 9:10 AM, Dmitry Baryshkov wrote:

> On Mon, Sep 22, 2025 at 09:20:33AM +0800, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> Add default DRM AUX HPD bridge device when register DisplayPort
>> altmode. That makes it redundant for each Type-C driver to implement
>> a similar registration process in embedded scenarios.
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> ---
>>   drivers/usb/typec/altmodes/displayport.c | 27 ++++++++++++++++++++++++
>>   drivers/usb/typec/altmodes/displayport.h |  2 ++
>>   drivers/usb/typec/class.c                |  8 +++++++
>>   include/linux/usb/typec_altmode.h        |  2 ++
>>   4 files changed, 39 insertions(+)
>>
>> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
>> index 1dcb77faf85d..e026dc6e5430 100644
>> --- a/drivers/usb/typec/altmodes/displayport.c
>> +++ b/drivers/usb/typec/altmodes/displayport.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/property.h>
>>   #include <linux/usb/pd_vdo.h>
>>   #include <linux/usb/typec_dp.h>
>> +#include <drm/bridge/aux-bridge.h>
>>   #include <drm/drm_connector.h>
>>   #include "displayport.h"
>>   
>> @@ -182,6 +183,10 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
>>   				dp->pending_irq_hpd = true;
>>   		}
>>   	} else {
>> +		if (dp->port->hpd_dev)
>> +			drm_aux_hpd_bridge_notify(dp->port->hpd_dev,
>> +						  hpd ? connector_status_connected :
>> +							connector_status_disconnected);
> There should be no need for these calls. Once the HPD bridge is added to
> a correct fwnode, the drm_connector_oob_hotplug_event() calls should
> deliver the signal as expected.

It seems that only drm_bridge_connector can do this. I'm not sure if I remember correctly. I'll give it a try.


>
>>   		drm_connector_oob_hotplug_event(dp->connector_fwnode,
>>   						hpd ? connector_status_connected :
>>   						      connector_status_disconnected);
>> @@ -206,6 +211,9 @@ static int dp_altmode_configured(struct dp_altmode *dp)
>>   	 * configuration is complete to signal HPD.
>>   	 */
>>   	if (dp->pending_hpd) {
>> +		if (dp->port->hpd_dev)
>> +			drm_aux_hpd_bridge_notify(dp->port->hpd_dev,
>> +						  connector_status_connected);
>>   		drm_connector_oob_hotplug_event(dp->connector_fwnode,
>>   						connector_status_connected);
>>   		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
>> @@ -391,6 +399,9 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
>>   			dp->data.status = 0;
>>   			dp->data.conf = 0;
>>   			if (dp->hpd) {
>> +				if (dp->port->hpd_dev)
>> +					drm_aux_hpd_bridge_notify(dp->port->hpd_dev,
>> +								  connector_status_disconnected);
>>   				drm_connector_oob_hotplug_event(dp->connector_fwnode,
>>   								connector_status_disconnected);
>>   				dp->hpd = false;
>> @@ -751,6 +762,18 @@ static const struct attribute_group *displayport_groups[] = {
>>   	NULL,
>>   };
>>   
>> +void dp_altmode_hpd_device_register(struct typec_altmode *alt)
>> +{
>> +	if (alt->svid != USB_TYPEC_DP_SID)
>> +		return;
>> +
>> +	alt->hpd_dev = drm_dp_hpd_bridge_register(alt->dev.parent->parent,
>> +						  dev_of_node(alt->dev.parent->parent));
> This needs at least a comment, what is dev.parent->parent. Also, the
> of_node is not correct here. It should be a node of the connector,
> rather than the device itself. Consider USB-C controllers which handle
> several USB-C connectors (e.g. UCSI). The DRM core won't be able to
> identify the correct bridge.

I think  alt.dev->parent->parent is the connector device. Am I missing something?



>
>> +	if (IS_ERR(alt->hpd_dev))
>> +		alt->hpd_dev = NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(dp_altmode_hpd_device_register);
> Having the function here will bring a typec -> displayport dependency
> between drivers (which you didn't document). It means it won't be
> possible to build typec core into the kernel, having the DP AltMode
> driver in the module (which also doesn't sound like a good idea).

It make sense. Perhaps moving it into class.c would be a good idea.


>
>> +
>>   int dp_altmode_probe(struct typec_altmode *alt)
>>   {
>>   	const struct typec_altmode *port = typec_altmode_get_partner(alt);

-- 
Best,
Chaoyi


