Return-Path: <linux-kernel+bounces-796805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25444B4076E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21108563687
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8052731A041;
	Tue,  2 Sep 2025 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R0icCBMT"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B33126A0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824138; cv=none; b=W69r7rWYh03oK80BaQnn7oDEKVF3q4Z7OIAaAQEFAS4GJP9zm1M51P+yZTfXYuispdap/jhDQk97TlV9Egjn08lRgIyhvt6wO2RUrZWxaJjldFzOqj3MrPCJKqqSUvPWYrxNvXQyuMTl3fnNHMCxGWai9+ojdWEpdUYt+Yty84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824138; c=relaxed/simple;
	bh=yV2Z/zkG+BjUpAySXYJlMu/Cx84YnHXdRI+Xpo1xOvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6IuY/WTvBpk81iegPHjyi+hfPx0jx+NrvA+VaAM0hWpJXb/FCh7diay70O6uAmrnQTWSOAdDZH+KxNFcv5U8zohRI4U8S8ihw+U6QGCAHgyY23P7FlgFidORFMD5b1O+Xvg0XaBBFxoEeldxMxqVhqwrI/4P6SC23ch3vDtAyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R0icCBMT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 590494E40BFB;
	Tue,  2 Sep 2025 14:42:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 308A360695;
	Tue,  2 Sep 2025 14:42:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B29A21C22D920;
	Tue,  2 Sep 2025 16:42:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756824132; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=XrIeNTm43O3tz5vDufxbmHSySD74Kdj4OftGw+6TpU0=;
	b=R0icCBMTg6KflDGsdT33H5aNsz8Vj8lyqCC6HAGF9cCvMqxBs5I0slpCgTm2xsxoeXeDBW
	aKBAkSgJ4z7ftlqi1Kq13q1pLafV0K/LV7meffNgkbWV6omD2+h9qWonINUd5B2VrPRzwt
	I4u+elLb3+64qG9GoHMdqxt8t6j3hhyCSXvTWKfMGGuFqOVZUpgcC7opStMkBEGirrohZo
	3bV0ZDIisf82/n7bRV25fvuQjWQXKXpLf1603JpZdWQGenJchAb62CkX4PWWyRKqZTEgJS
	MTunD+T3TggeUA35NfMEOr1WPn0pJ1mW8vxMLf96bIcGdyiaiMs360yAHTw05A==
Message-ID: <0d9145ee-7f25-429c-934e-7dd9bde31bd5@bootlin.com>
Date: Tue, 2 Sep 2025 16:42:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: core: Increment of_node's refcount before linking it
 to the platform device
To: Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <linchengming884@gmail.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-kernel@vger.kernel.org
References: <20250820-mfd-refcount-v1-1-6dcb5eb41756@bootlin.com>
 <20250902132900.GN2163762@google.com>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250902132900.GN2163762@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/2/25 3:29 PM, Lee Jones wrote:
> On Wed, 20 Aug 2025, Bastien Curutchet wrote:
> 
>> When an MFD device is added, a platform_device is allocated. If this
>> device is linked to a DT description, the corresponding OF node is linked
>> to the new platform device but the OF node's refcount isn't incremented.
>> As of_node_put() is called during the platform device release, it leads
>> to a refcount underflow.
>>
>> Call of_node_get() to increment the OF node's refcount when the node is
>> linked to the newly created platform device.
>>
>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>> ---
>> Hi all,
>>
>> I'm currently working on a new MFD driver and I encountered some
>> underflow errors with the of_node refcount. As you can see in the logs
>> below, I reproduced the issue on a mainline driver (atmel-hlcdc):
>>
>>> # modprobe atmel-hlcdc
>>> # modprobe -r atmel-hlcdc
>>> # modprobe atmel-hlcdc
>>> # modprobe -r atmel-hlcdc
>>> [   22.932128] OF: ERROR: of_node_release() detected bad of_node_put() on /amba_pl/atmel_sama5@43a00000/dc
>>> [   22.941586] CPU: 1 UID: 0 PID: 103 Comm: modprobe Not tainted 6.17.0-rc2-00053-gb19a97d57c15-dirty #81 NONE
>>> [   22.941608] Hardware name: Xilinx Zynq Platform
>>> [   22.941615] Call trace:
>>> [   22.941626]  unwind_backtrace from show_stack+0x10/0x14
>>> [   22.941660]  show_stack from dump_stack_lvl+0x54/0x68
>>> [   22.941680]  dump_stack_lvl from of_node_release+0x140/0x16c
>>> [   22.941707]  of_node_release from kobject_put+0x110/0x130
>>> [   22.941745]  kobject_put from platform_device_release+0x10/0x3c
>>> [   22.941782]  platform_device_release from device_release+0x30/0xa0
>>> [   22.941814]  device_release from kobject_put+0x88/0x130
>>> [   22.941845]  kobject_put from klist_prev+0xd4/0x16c
>>> [   22.941879]  klist_prev from device_for_each_child_reverse+0x88/0xc8
>>> [   22.941911]  device_for_each_child_reverse from devm_mfd_dev_release+0x30/0x54
>>> [   22.941941]  devm_mfd_dev_release from devres_release_all+0xb0/0x114
>>> [   22.941974]  devres_release_all from device_unbind_cleanup+0xc/0x58
>>> [   22.942003]  device_unbind_cleanup from device_release_driver_internal+0x190/0x1c4
>>> [   22.942025]  device_release_driver_internal from driver_detach+0x54/0xa0
>>> [   22.942046]  driver_detach from bus_remove_driver+0x58/0xa4
>>> [   22.942066]  bus_remove_driver from sys_delete_module+0x178/0x25c
>>> [   22.942094]  sys_delete_module from ret_fast_syscall+0x0/0x54
>>> [   22.942116] Exception stack(0xf0a1dfa8 to 0xf0a1dff0)
>>> [   22.942130] dfa0:                   004ec438 005a0870 005a0d40 00000080 00000000 005a0d18
>>> [   22.942144] dfc0: 004ec438 005a0870 005a0190 00000081 005a0d60 005a0870 00000001 0059f6bc
>>> [   22.942155] dfe0: beccdb20 beccdb10 004ed1f4 b6e9eb40
>>> [   22.942163] OF: ERROR: next of_node_put() on this node will result in a kobject warning 'refcount_t: underflow; use-after-free.'
>>> [   23.098617] OF: ERROR: of_node_release() detected bad of_node_put() on /amba_pl/atmel_sama5@43a00000/pwm
>>> [   23.108137] CPU: 1 UID: 0 PID: 103 Comm: modprobe Not tainted 6.17.0-rc2-00053-gb19a97d57c15-dirty #81 NONE
>>> [   23.108159] Hardware name: Xilinx Zynq Platform
>>> [   23.108166] Call trace:
>>> [   23.108173]  unwind_backtrace from show_stack+0x10/0x14
>>> [   23.108206]  show_stack from dump_stack_lvl+0x54/0x68
>>> [   23.108227]  dump_stack_lvl from of_node_release+0x140/0x16c
>>> [   23.108252]  of_node_release from kobject_put+0x110/0x130
>>> [   23.108288]  kobject_put from platform_device_release+0x10/0x3c
>>> [   23.108324]  platform_device_release from device_release+0x30/0xa0
>>> [   23.108354]  device_release from kobject_put+0x88/0x130
>>> [   23.108384]  kobject_put from klist_prev+0xd4/0x16c
>>> [   23.108418]  klist_prev from device_for_each_child_reverse+0x88/0xc8
>>> [   23.108450]  device_for_each_child_reverse from devm_mfd_dev_release+0x30/0x54
>>> [   23.108479]  devm_mfd_dev_release from devres_release_all+0xb0/0x114
>>> [   23.108513]  devres_release_all from device_unbind_cleanup+0xc/0x58
>>> [   23.108541]  device_unbind_cleanup from device_release_driver_internal+0x190/0x1c4
>>> [   23.108563]  device_release_driver_internal from driver_detach+0x54/0xa0
>>> [   23.108585]  driver_detach from bus_remove_driver+0x58/0xa4
>>> [   23.108605]  bus_remove_driver from sys_delete_module+0x178/0x25c
>>> [   23.108631]  sys_delete_module from ret_fast_syscall+0x0/0x54
>>> [   23.108653] Exception stack(0xf0a1dfa8 to 0xf0a1dff0)
>>> [   23.108667] dfa0:                   004ec438 005a0870 005a0d40 00000080 00000000 005a0d18
>>> [   23.108681] dfc0: 004ec438 005a0870 005a0190 00000081 005a0d60 005a0870 00000001 0059f6bc
>>> [   23.108691] dfe0: beccdb20 beccdb10 004ed1f4 b6e9eb40
>>> [   23.108698] OF: ERROR: next of_node_put() on this node will result in a kobject warning 'refcount_t: underflow; use-after-free.'
>> ---
>>   drivers/mfd/mfd-core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
>> index 76bd316a50afc5c07ff2a3303c4363b16d0bc023..7d14a1e7631ee8d5e91b228a07b2d05695e41b6e 100644
>> --- a/drivers/mfd/mfd-core.c
>> +++ b/drivers/mfd/mfd-core.c
>> @@ -131,6 +131,7 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
>>   	of_entry->np = np;
>>   	list_add_tail(&of_entry->list, &mfd_of_node_list);
>>   
>> +	of_node_get(np);
> 
> Looks okay at first blush.
> 
> My question would be, why isn't this required for all calls to device_set_node()?
> 

Tough question, I've found drivers that do call of_node_get() before 
device_set_node() and others that don't. I guess it depends on what 
happens during release, but it's not always trivial to follow all the 
redirections that occur at that stage ..


Best regards,
-- 
Bastien Curutchet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


