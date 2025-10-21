Return-Path: <linux-kernel+bounces-862549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C704BF593D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A32DC4FFA95
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCE632BF3A;
	Tue, 21 Oct 2025 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="g6OhVZ/y"
Received: from mail-m19731102.qiye.163.com (mail-m19731102.qiye.163.com [220.197.31.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AEB32B9B8;
	Tue, 21 Oct 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039862; cv=none; b=TFd3rLQPo83dpJKDpQi3wkYjrlhinP9qySJKv2s+pWz8Bawbv/TaLaPQT5tQpndjQlK05TKYI4TvBs2HREklIS+VG+TqivKe9FcKOtwLqT3vjdTEOvZbi3DxHknVofC6IEqgWRzbGEo/5J4p8nMbXCZhAuwqe2xB/1/LfpSncbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039862; c=relaxed/simple;
	bh=QzGk1F4Oghc7q1SK/0Q0gWE+qslFRrGUIMBxavAMLZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLOyvcUVNxkToYeW73jvZnW48+M2hERoGAhORNNQyS7wNl/WdEvp4zDmshAF+ZeeTStQSuAiwZeopKMLu47aKS6KsbXHtZOGFX+el+a/3gCZMuJ4+1Nm8REhK8fmsHdThEOl7wmFJL56EFVBBax5TKoCOYb31C7KfAMlUs/oeqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=g6OhVZ/y; arc=none smtp.client-ip=220.197.31.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.149] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26a698a5f;
	Tue, 21 Oct 2025 17:44:12 +0800 (GMT+08:00)
Message-ID: <1221dd6c-2035-4e5d-8052-341da279fe81@rock-chips.com>
Date: Tue, 21 Oct 2025 17:44:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] usb: typec: Add default HPD device when register
 DisplayPort altmode
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Chaoyi Chen <kernel@airkyi.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
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
 <954a67d1-1759-4e18-8eef-3fa14fb3cef5@rock-chips.com>
 <aPdI7Vb_djrfCfbT@kuha.fi.intel.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <aPdI7Vb_djrfCfbT@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a0627a3a903abkunm5cd7977fb8e2b1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUpDS1YaGRpIHUpDTBlKGU1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	9VSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=g6OhVZ/yiqpa03UuI1XX7K9vWZ8zWP3G2Gzz5rhk0AcJK/U+UJws7ashU78Y+//2Cp1XYy8iR5A+1sB1SdjmB78dMX58786reFgEn7dhTHoMucj84RbJ6zYHbg7CDu7vWXLe8oopZFd6uuDFaXjD2L3+MUHefnrApM/1yNbvoa0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=qUewYvs5quWL8CZ5KUc8yRAa2rvIV3/2PN0yp7OZqoo=;
	h=date:mime-version:subject:message-id:from;

On 10/21/2025 4:48 PM, Heikki Krogerus wrote:

> Hi,
>
> On Mon, Oct 20, 2025 at 07:07:46PM +0800, Chaoyi Chen wrote:
>> Hi Heikki,
>>
>> On 10/20/2025 6:02 PM, Heikki Krogerus wrote:
>>> On Thu, Oct 16, 2025 at 10:27:34AM +0800, Chaoyi Chen wrote:
>>>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>>
>>>> Add default DRM AUX HPD bridge device when register DisplayPort
>>>> altmode. That makes it redundant for each Type-C driver to implement
>>>> a similar registration process in embedded scenarios.
>>>>
>>>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>> ---
>>>>
>>>> Changes in v6:
>>>> - Fix depend in Kconfig.
>>>>
>>>> Changes in v5:
>>>> - Remove the calls related to `drm_aux_hpd_bridge_notify()`.
>>>> - Place the helper functions in the same compilation unit.
>>>> - Add more comments about parent device.
>>>>
>>>>    drivers/usb/typec/Kconfig         |  2 ++
>>>>    drivers/usb/typec/class.c         | 26 ++++++++++++++++++++++++++
>>>>    include/linux/usb/typec_altmode.h |  2 ++
>>>>    3 files changed, 30 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
>>>> index 2f80c2792dbd..a6730fbb576b 100644
>>>> --- a/drivers/usb/typec/Kconfig
>>>> +++ b/drivers/usb/typec/Kconfig
>>>> @@ -2,6 +2,8 @@
>>>>    menuconfig TYPEC
>>>>    	tristate "USB Type-C Support"
>>>> +	depends on DRM || DRM=n
>>>> +	select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
>>> This is wrong. DRM should not dictate how this entire subsystem core
>>> is configured. The dependency needs to be on the DRM bridge side.
>>>
>>> You can for example use the bus notification there to see when a new
>>> alternate mode is being registered, or use some other notification
>>> mechanism.
>> Is it a good idea to implement notification functions like
>> drivers/usb/core/notify.c in TCPM, and then let other subsystems (such as DRM)
>> listen to these notifications?
> Don't limit this to tcpm only. I would suggest something similar what
> we have for usb bus: drivers/usb/core/notify.c
>
> So that, but for the typec bus. Then in DRM bridge code you just use
> typec_register/unregister_notify().

I will try to add drivers/usb/typec/notify.c in v7 to implement this. Thank you.


>
> thanks,
>
-- 
Best,
Chaoyi


