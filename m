Return-Path: <linux-kernel+bounces-849921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2F1BD155D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A493B9E77
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A2327A93C;
	Mon, 13 Oct 2025 03:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BtDpGjCh"
Received: from mail-m1973177.qiye.163.com (mail-m1973177.qiye.163.com [220.197.31.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A713B797;
	Mon, 13 Oct 2025 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760327631; cv=none; b=cCWDQgiiVr2KpAq5xxR2P8FMnkiaHXj3bPU1mHmkB03NvvnbY626inNVg12QtAPXNPKdkb9HW5W/0iqmTnjl94SFRXZPR3n1tWtuJpzWlbQsWX3MCvVJmGSBBsjmGL7/ibNZwNkyGHfMZJYj0DbS5Ipq5jVXWD37OPjK28xiZWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760327631; c=relaxed/simple;
	bh=PbAzsDLcpCjjU+ySuiE6iEnMNY0RjBPQ3C98WW1Xuig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fE1T9u3P0fhw+PYKh+pIhDnXlSQvvgQzFXkREq3KWOPCH6+sW6av74VrHOB46qSLjysi7m59wsEBwB63m+KnjL6ng5lwLrZYbXQtSbgwBlToa4+fVl5qRn0nl9N+qpZ8oKyyZfwOL3ggbz5kHrbMdBGYebRs69UaQbrP+3N8sro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BtDpGjCh; arc=none smtp.client-ip=220.197.31.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [127.0.0.1] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 25a425d33;
	Mon, 13 Oct 2025 09:31:09 +0800 (GMT+08:00)
Message-ID: <b0a41372-f28a-4e2f-9590-94fe2a86f7d8@rock-chips.com>
Date: Mon, 13 Oct 2025 09:31:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] usb: typec: Add default HPD device when register
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
References: <20251011033233.97-1-kernel@airkyi.com>
 <20251011033233.97-2-kernel@airkyi.com>
 <4eizpzejw43gqt5jauvkeij65rracols2voa2osflwyjrwbvun@sovgqfuhg6mc>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <4eizpzejw43gqt5jauvkeij65rracols2voa2osflwyjrwbvun@sovgqfuhg6mc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a99db315d3303abkunmf2c18e8ff96737
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkgYS1ZIQh9LSU1ITEJJH0lWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BtDpGjChpSP48XE1NKo9jcl4Ni8DKvg9gZwmx1ejEbB52Pfa+kRYrhK7oEn5aQ5AakDYb/7RggtO5dn567l+twFPbz45HrVLLzoOI81hMA76pKtG8j7aBsmYKJIDji/YO4B/Lud3EvzLmEHni0K6Bgrj0VWBL7P9W8ve4ol9ntw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=FbJ61tTmug1JcWEYVwCZO9erg1Aurz+LDUFUiiNDiT4=;
	h=date:mime-version:subject:message-id:from;

On 10/12/2025 12:51 AM, Dmitry Baryshkov wrote:

> On Sat, Oct 11, 2025 at 11:32:26AM +0800, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> Add default DRM AUX HPD bridge device when register DisplayPort
>> altmode. That makes it redundant for each Type-C driver to implement
>> a similar registration process in embedded scenarios.
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> ---
>>
>> Changes in v5:
>> - Remove the calls related to `drm_aux_hpd_bridge_notify()`.
>> - Place the helper functions in the same compilation unit.
>> - Add more comments about parent device.
>>
>>   drivers/usb/typec/class.c         | 26 ++++++++++++++++++++++++++
>>   include/linux/usb/typec_altmode.h |  2 ++
>>   2 files changed, 28 insertions(+)
>>
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
> You can not do this, unless you make TYPEC core:
>
> depends on DRM || DRM=n
> select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF

You are right, Kconfig should be configured by the actual caller. Will fix in v6.


>
>> +	if (IS_ERR(alt->hpd_dev))
>> +		alt->hpd_dev = NULL;
>> +}
>> +
>>   static struct typec_altmode *
>>   typec_register_altmode(struct device *parent,
>>   		       const struct typec_altmode_desc *desc)

-- 
Best,
Chaoyi


