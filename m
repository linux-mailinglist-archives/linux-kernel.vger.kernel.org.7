Return-Path: <linux-kernel+bounces-864879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7B3BFBC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09B4D353817
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B7E342CBC;
	Wed, 22 Oct 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="v4tTF88F"
Received: from smtp101.iad3a.emailsrvr.com (smtp101.iad3a.emailsrvr.com [173.203.187.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CAA32E12F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134509; cv=none; b=GYjo/2Y26ZL1zC2dFJj/JO7uDAmyAtuHSM/DnIR9dCFwMir2GJ2eyW8RSFaGuv5UQHZPF/mO1+c7ycB8Fcj/7U23zZUfb4FTJxYjvgIpCQ4INX196KvSjh0SNHFBzoOASksrsied5ZkGLZWSxG+YftA+nZA9DX5PTvSQoW55s/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134509; c=relaxed/simple;
	bh=NEueq3Avk4gQfB2zNcLsQ9mHX3JZQHi8T4qdGRMkVLY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HgHGG222+YHY/c24/kNFFT52azvxzTf0K/rOi27TBaBgto5vYb9EWewfI3yvAYUm06NH3JDFa4DhXZ2/gS6qEiC/RzGksXnpipQ5Nt67vqK2GiUDCXrVK7RaPh9cwTd+LYjOlzM/piCrEiX4qTRqDEhgriSFSB5Qnp9o927472w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=v4tTF88F; arc=none smtp.client-ip=173.203.187.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761133917;
	bh=NEueq3Avk4gQfB2zNcLsQ9mHX3JZQHi8T4qdGRMkVLY=;
	h=Date:Subject:From:To:From;
	b=v4tTF88F1oR4EObnvmC+9AW2nwwNPSKqOsbuVxGk/vJXaqpDaMGwWYDh4OPdM+8ox
	 equKVGxb3qS4RzN7fePry+ixlR4WIHqSyqs9aoh5dWYCcvOaOF0+I6wV541nndvMt0
	 zquuoxE86jn4XvDItI47g7dvE4vgBjwLMD11gjxY=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp29.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id B21182503B;
	Wed, 22 Oct 2025 07:51:56 -0400 (EDT)
Message-ID: <df307a5e-811b-479d-a287-7a670a337bb2@mev.co.uk>
Date: Wed, 22 Oct 2025 12:51:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: drivers: do not detach device if driv->attach()
 fails
From: Ian Abbott <abbotti@mev.co.uk>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
 syzbot+6616bba359cec7a1def1@syzkaller.appspotmail.com,
 lvc-project@linuxtesting.org
References: <20251021131656.164783-1-n.zhandarovich@fintech.ru>
 <fb39d407-622b-4480-a146-2e754f74bcbf@mev.co.uk>
Content-Language: en-GB
Organization: MEV Ltd.
In-Reply-To: <fb39d407-622b-4480-a146-2e754f74bcbf@mev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Classification-ID: 77642887-f119-49c0-ae98-3730c4c71774-1-1

On 22/10/2025 11:45, Ian Abbott wrote:
> On 21/10/2025 14:16, Nikita Zhandarovich wrote:
>> Syzbot identified an issue [1] in comedi_device_attach() that occurs
>> when kernel attempts to detach a comedi device via
>> comedi_device_detach() even if a driver-specific attach() method
>> already failed. Attempts to follow through with detaching the
>> device and unregistering the driver trigger a warning.
>>
>> Fix this by rearranging cleanup calls so that comedi_device_detach()
>> runs only if the device in question has been successfully attached.
>>
>> Original idea for this patch belongs to Hillf Danton
>> <hdanton@sina.com>.
>>
>> [1] Syzbot crash:
>> Unexpected driver unregister!
>> WARNING: CPU: 0 PID: 5970 at drivers/base/driver.c:273 
>> driver_unregister drivers/base/driver.c:273 [inline]
>> WARNING: CPU: 0 PID: 5970 at drivers/base/driver.c:273 
>> driver_unregister+0x90/0xb0 drivers/base/driver.c:270
>> ...
>> Call Trace:
>>   <TASK>
>>   comedi_device_detach_locked+0x12f/0xa50 drivers/comedi/drivers.c:207
>>   comedi_device_detach+0x67/0xb0 drivers/comedi/drivers.c:215
>>   comedi_device_attach+0x43d/0x900 drivers/comedi/drivers.c:1011
>>   do_devconfig_ioctl+0x1b1/0x710 drivers/comedi/comedi_fops.c:872
>>   comedi_unlocked_ioctl+0x165d/0x2f00 drivers/comedi/comedi_fops.c:2178
>>   vfs_ioctl fs/ioctl.c:51 [inline]
>>   __do_sys_ioctl fs/ioctl.c:597 [inline]
>> ...
>>
>> Reported-by: syzbot+6616bba359cec7a1def1@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=6616bba359cec7a1def1
>> Suggested-by: Hillf Danton <hdanton@sina.com>
>> Fixes: 74ece108f9e5 ("staging: comedi: move detach out of post-config")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>> ---
>>   drivers/comedi/drivers.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
>> index c9ebaadc5e82..001083f96138 100644
>> --- a/drivers/comedi/drivers.c
>> +++ b/drivers/comedi/drivers.c
>> @@ -1005,10 +1005,13 @@ int comedi_device_attach(struct comedi_device 
>> *dev, struct comedi_devconfig *it)
>>       dev->board_name = dev->board_ptr ? *(const char **)dev->board_ptr
>>                        : dev->driver->driver_name;
>>       ret = driv->attach(dev, it);
>> -    if (ret >= 0)
>> +    if (ret >= 0) {
>>           ret = comedi_device_postconfig(dev);
>> -    if (ret < 0) {
>> -        comedi_device_detach(dev);
>> +        if (ret < 0) {
>> +            comedi_device_detach(dev);
>> +            module_put(driv->module);
>> +        }
>> +    } else {
>>           module_put(driv->module);
>>       }
>>       /* On success, the driver module count has been incremented. */
> 
> Unfortunately, the low-level drivers expect the `->detach()` handler to 
> be called to clean up even if the `->attach()` handler returns an error. 
>   So this won't work.
> 

The problem seems to be the "c6xdigio" driver 
("drivers/comedi/drivers/c6digio.c"). Its comedi `->attach()` handler 
`c6digio_attach()` can return an error before the call to 
`pnp_register_driver()`.  Also, it does not check the return value from 
`pnp_register_driver()`.  On error, comedi will call the `->detach()` 
handler `c6xdigio_detach()` which calls `pnp_unregister_driver()` 
unconditionally, leading to the warning reported by Syzbot.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

