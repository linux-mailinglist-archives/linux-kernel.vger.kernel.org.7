Return-Path: <linux-kernel+bounces-805713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2176FB48C90
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEBA3B359E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9F62F7AA1;
	Mon,  8 Sep 2025 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="hNg8fCRu"
Received: from smtpcmd11116.aruba.it (smtpcmd11116.aruba.it [62.149.156.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A6E22D4F1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332274; cv=none; b=YZo5hOf/694Q2WNzeOniT4+v9Wi5nC9R6rDYeuFHrAFSowmvRrwrjezcMBAhOj4+V5710B4JejingYTCDZIw88TV+6oThAqk0Jyf20ec/RixyOae4zjTWdRfF6gEvUONvMxDsAIOWaxIjigIU71l8GWpiSzcsaGec7qcasq7Ir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332274; c=relaxed/simple;
	bh=SgYWapNgK/E3AHlk3nbGGB7gEQFS/7YxHGhn57ltUPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQoaeCIkKd0b+KNHgbB/0tIiekb/EsuwOVvwA953TZH67j5WKzP+qggSRE3Tm4S6bLP0QzP+SWloWbq6+/0X/03hqAxe/SK+1sbSguXbaq2ZNTN6ly0Alge0GEhbptrN1uKHCFjL0I+Djgj8MR2RP5jZlnyIlx2DkloWIX8veg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=hNg8fCRu; arc=none smtp.client-ip=62.149.156.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba SMTP with ESMTPSA
	id vaLnuOjEVtr9dvaLnuJB9O; Mon, 08 Sep 2025 13:48:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1757332081; bh=SgYWapNgK/E3AHlk3nbGGB7gEQFS/7YxHGhn57ltUPQ=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=hNg8fCRumEtA0UP4l2pBC5SlZq7VxmOkbu6uiUSIUZTYO0IUPQ6UuKKo5DYtiKATM
	 PtSJtxbaGeJix8nZxr3iamZLEZ8wZtTF8KmGtACeBjnNcgVNIrSR2QIb0+bTNzABwM
	 esm8x4iwrm5R/8XPFvVkBf9wimcMZ9OQitm9EvUm5iLyTE11thnEKygT/W/whK/cfA
	 AlThWBbkC0qJIs9vb5636QUt8Kw7dH7V99M3JFbAQBaifDTpsXNGUfFGV0FnGwH6TP
	 cUdrqC5DfygwYD/yKMooFgBNmLTPuj4nktVNk6pIjGTh8JjbVbQGz/C7lVONrOCFHS
	 rBgNRL6i4C5Jg==
Message-ID: <c4342478-f3f6-46d0-8c2f-502049e5994b@enneenne.com>
Date: Mon, 8 Sep 2025 13:47:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pps: fix warning in pps_register_cdev when register
 device fail
Content-Language: en-US
To: Calvin Owens <calvin@wbinvd.org>, Wang Liang <wangliang74@huawei.com>
Cc: gregkh@linuxfoundation.org, mschmidt@redhat.com, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, linux-kernel@vger.kernel.org
References: <20250830075023.3498174-1-wangliang74@huawei.com>
 <aLkQs8gNkK9NfiOh@mozart.vkv.me>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <aLkQs8gNkK9NfiOh@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBnjBn7n/MxicCAKC2FaJ68vfbw9hmymWfJWLKIdKnnTruZvHQ0EFx9g3RysCWUq0nKFbh08zdAcZKeVI8Hx4DEMUld/UbMSl2unE8Hrs0jaPOLIEy5B
 u313F33D3P0SJ01H7sVmIcEq0wqjO59nUM1wGAKrjVCYSbCBZSHYoESY+YHcPXUm5acZL/GNtZr7rFqv2nUB9EJHD33IQg410wh5K5+DiqCTsMYKVNf2CdqM
 gc4M+PeeHnDri3bIumxR2kVrCHpiSrx23ofiSSUEu1jBWTr3yGh5iatmU2djG0NrPq+NIrI7+6kicvAk5zPLSqQiTq2V0CpTLd9jDMxm02LZMyfvDN7kGGEh
 f/LNCSNwZ/Nwx/T2+vrj4syBprD4U8XYREcelhg5cpAcvBt6mOQ=

On 04/09/25 06:08, Calvin Owens wrote:
> On Saturday 08/30 at 15:50 +0800, Wang Liang wrote:
>> Similar to previous commit 2a934fdb01db ("media: v4l2-dev: fix error
>> handling in __video_register_device()"), the release hook should be set
>> before device_register(). Otherwise, when device_register() return error
>> and put_device() try to callback the release function, the below warning
>> may happen.
>>
>>    ------------[ cut here ]------------
>>    WARNING: CPU: 1 PID: 4760 at drivers/base/core.c:2567 device_release+0x1bd/0x240 drivers/base/core.c:2567
>>    Modules linked in:
>>    CPU: 1 UID: 0 PID: 4760 Comm: syz.4.914 Not tainted 6.17.0-rc3+ #1 NONE
>>    RIP: 0010:device_release+0x1bd/0x240 drivers/base/core.c:2567
>>    Call Trace:
>>     <TASK>
>>     kobject_cleanup+0x136/0x410 lib/kobject.c:689
>>     kobject_release lib/kobject.c:720 [inline]
>>     kref_put include/linux/kref.h:65 [inline]
>>     kobject_put+0xe9/0x130 lib/kobject.c:737
>>     put_device+0x24/0x30 drivers/base/core.c:3797
>>     pps_register_cdev+0x2da/0x370 drivers/pps/pps.c:402
>>     pps_register_source+0x2f6/0x480 drivers/pps/kapi.c:108
>>     pps_tty_open+0x190/0x310 drivers/pps/clients/pps-ldisc.c:57
>>     tty_ldisc_open+0xa7/0x120 drivers/tty/tty_ldisc.c:432
>>     tty_set_ldisc+0x333/0x780 drivers/tty/tty_ldisc.c:563
>>     tiocsetd drivers/tty/tty_io.c:2429 [inline]
>>     tty_ioctl+0x5d1/0x1700 drivers/tty/tty_io.c:2728
>>     vfs_ioctl fs/ioctl.c:51 [inline]
>>     __do_sys_ioctl fs/ioctl.c:598 [inline]
>>     __se_sys_ioctl fs/ioctl.c:584 [inline]
>>     __x64_sys_ioctl+0x194/0x210 fs/ioctl.c:584
>>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>     do_syscall_64+0x5f/0x2a0 arch/x86/entry/syscall_64.c:94
>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>     </TASK>
>>
>> Before commit c79a39dc8d06 ("pps: Fix a use-after-free"),
>> pps_register_cdev() call device_create() to create pps->dev, which will
>> init dev->release to device_create_release(). Now the comment is outdated,
>> just remove it.
>>
>> Thanks for the reminder from Calvin Owens, 'kfree_pps' should be removed
>> in pps_register_source() to avoid a double free in the failure case.
> 
> Looks good to me, thanks for cleaning this up :)
> 
> Reviewed-By: Calvin Owens <calvin@wbinvd.org>
> 
>> Link: https://lore.kernel.org/all/20250827065010.3208525-1-wangliang74@huawei.com/
>> Fixes: c79a39dc8d06 ("pps: Fix a use-after-free")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> ---
>> v2: remove kfree_pps in pps_register_source().
>> ---
>>   drivers/pps/kapi.c | 5 +----
>>   drivers/pps/pps.c  | 5 ++---
>>   2 files changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
>> index 92d1b62ea239..e9389876229e 100644
>> --- a/drivers/pps/kapi.c
>> +++ b/drivers/pps/kapi.c
>> @@ -109,16 +109,13 @@ struct pps_device *pps_register_source(struct pps_source_info *info,
>>   	if (err < 0) {
>>   		pr_err("%s: unable to create char device\n",
>>   					info->name);
>> -		goto kfree_pps;
>> +		goto pps_register_source_exit;
>>   	}
>>   
>>   	dev_dbg(&pps->dev, "new PPS source %s\n", info->name);
>>   
>>   	return pps;
>>   
>> -kfree_pps:
>> -	kfree(pps);
>> -
>>   pps_register_source_exit:
>>   	pr_err("%s: unable to register source\n", info->name);
>>   
>> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
>> index 9463232af8d2..c6b8b6478276 100644
>> --- a/drivers/pps/pps.c
>> +++ b/drivers/pps/pps.c
>> @@ -374,6 +374,7 @@ int pps_register_cdev(struct pps_device *pps)
>>   			       pps->info.name);
>>   			err = -EBUSY;
>>   		}
>> +		kfree(pps);
>>   		goto out_unlock;
>>   	}
>>   	pps->id = err;
>> @@ -383,13 +384,11 @@ int pps_register_cdev(struct pps_device *pps)
>>   	pps->dev.devt = MKDEV(pps_major, pps->id);
>>   	dev_set_drvdata(&pps->dev, pps);
>>   	dev_set_name(&pps->dev, "pps%d", pps->id);
>> +	pps->dev.release = pps_device_destruct;
>>   	err = device_register(&pps->dev);
>>   	if (err)
>>   		goto free_idr;
>>   
>> -	/* Override the release function with our own */
>> -	pps->dev.release = pps_device_destruct;
>> -
>>   	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name, pps_major,
>>   		 pps->id);
>>   
>> -- 
>> 2.33.0
>>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming

